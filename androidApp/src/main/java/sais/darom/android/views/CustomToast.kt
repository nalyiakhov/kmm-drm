package sais.darom.android.views

import android.view.LayoutInflater
import android.view.View
import androidx.coordinatorlayout.widget.CoordinatorLayout
import androidx.core.content.ContextCompat
import com.google.android.material.snackbar.Snackbar
import sais.darom.android.R
import sais.darom.android.databinding.LayoutToastViewBinding
import java.lang.ref.WeakReference

object CustomToast {
	private const val DEFAULT_DURATION = 3000

	var currentCoordinator: WeakReference<CoordinatorLayout>? = null

	private fun getCoordinator(): CoordinatorLayout? {
		val coordinator = currentCoordinator?.get()

		coordinator?.bringToFront()

		return coordinator
	}

	private fun create(coordinatorLayout: View?, label: String?, durationMs: Int = DEFAULT_DURATION): Snackbar? {
		if (coordinatorLayout == null)
			return null

		if (label.isNullOrBlank())
			return null

		val binding = LayoutToastViewBinding.inflate(LayoutInflater.from(coordinatorLayout.context))
		binding.label.text = label

		val snackbar = Snackbar.make(coordinatorLayout, "", durationMs)
		val snackbarLayout = snackbar.view as Snackbar.SnackbarLayout
		snackbarLayout.removeAllViews()
		snackbarLayout.setPadding(0, 0, 0, 0)
		snackbarLayout.elevation = 0f
		snackbarLayout.addView(binding.root)

		snackbar.setBackgroundTint(ContextCompat.getColor(coordinatorLayout.context, R.color.transparent))

		return snackbar
	}

	fun show(label: String?, durationMs: Int = DEFAULT_DURATION) {
		val toast = create(getCoordinator(), label, durationMs)
		toast?.show()
	}
}