package sais.darom.android.data

import android.content.Context
import android.view.LayoutInflater
import android.view.View
import android.view.ViewGroup
import android.widget.BaseAdapter
import sais.darom.android.views.ItemView
import sais.darom.models.Item

class ItemAdapter(applicationContext: Context, items: ArrayList<Item>): BaseAdapter() {
	private var context: Context
	private var items: ArrayList<Item>
	private var inflter: LayoutInflater

	override fun getCount(): Int {
		return items.size
	}

	override fun getItem(i: Int): Any {
		return items.get(i)
	}

	override fun getItemId(i: Int): Long {
		return 0
	}

	override fun getView(i: Int, view: View?, viewGroup: ViewGroup?): View {
		val itemView = (view as? ItemView) ?: ItemView(context)
		itemView.setup(items.get(i))
		return itemView
	}

	init {
		context = applicationContext
		this.items = items
		inflter = LayoutInflater.from(applicationContext)
	}
}