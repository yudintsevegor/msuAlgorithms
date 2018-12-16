#include <iostream>
#include <fstream>
#include <cstdlib>
#include <chrono>
#include <ctime>
#include <string>
#include <utility>


using namespace std;

template< class T>
class set {

	struct node
	{
		pair<T, int> info;
		node *l, *r;
		node() { l = nullptr; r = nullptr; }
	};

	node* root;
	long length = 0;
	long chet = 0;

public:
	void push(T a, node*& t)
	{
		if (t == nullptr)
		{
			length++;
			t = new node;
			t->info = make_pair(a, 1);
			return;
		}

		chet++;
		if (a == t->info.first) { t->info.second++; return; }
		if (a > t->info.first) push(a, t->r);
		else push(a, t->l);
	}

	void insert(T a) {
		if (length == 0) {
			root = new node;
			root->info = make_pair(a, 1);
			length++; chet = 0;
		}
		else {

			chet = 0;
			push(a, root);

		}
	}

	void show(node* temp)
	{
		if (temp != nullptr)
		{
			show(temp->l);
			cout << temp->info.first << ' ';
			show(temp->r);
		}
	}

	void show() { show(root); cout << endl; }

	bool empty() { return length == 0; }

	bool find_1(node*& t, T& el) {
		if (t == nullptr) return false;
		if (el == t->info.first) return true;
		if (el > t->info.first) return find_1(t->r, el);
		if (el < t->info.first) return find_1(t->l, el);
	}

	bool find(T el) {
		return find_1(root, el);
	}

	node*& find_2(node*& t, T& el) {
		if (t == nullptr) { node* temp = nullptr; return temp; }
		if (el == t->info.first) return t;
		if (el > t->info.first) return find_2(t->r, el);
		if (el < t->info.first) return find_2(t->l, el);
	}

	long size() { return length; }
	long counter() { return chet; }

	T* front() {
		node* temp = root;
		while (temp->l != nullptr) temp = temp->l;
		return &temp->info;
	}

	T* back() {
		node* temp = root;
		while (temp->r != nullptr) temp = temp->r;
		return &temp->info;
	}

	void erase(T el) {
		node*& t = find_2(root, el);
		if (t == nullptr) { cout << "error\n"; return; }
		if ((t->l == nullptr) && (t->r == nullptr)) { t = nullptr; return; }
		if ((t->l != nullptr) && (t->r == nullptr)) { t = t->l; return; }
		if ((t->l == nullptr) && (t->r != nullptr)) { t = t->r; return; }
		node* temp = t;
		temp = temp->r;
		while (temp->l != nullptr) { temp = temp->l; }
		erase(temp->info.first);
		t->info = temp->info;
		delete temp;

	}


};

int main()
{
	set<string> a;
	string word, word1;

	ifstream text("war-peace.txt");
	ofstream myfile;
	myfile.open("task_6_1.csv");

	text >> word1;
	text >> word1;

	while (text >> word)
	{

		if (word != word1) {

			a.insert(word);
			myfile << a.size() << ";";
			myfile << a.counter() << ";" << word << "\n";

		}
	}


	text.close();
	myfile.close();


	system("pause");
	return 0;
}
