package sais.darom.android

import android.content.Context
import android.os.Build
import androidx.appcompat.app.AppCompatActivity
import android.os.Bundle
import androidx.core.content.ContextCompat
import androidx.navigation.NavController
import androidx.navigation.fragment.NavHostFragment
import sais.darom.UserData
import sais.darom.android.databinding.ActivityMainBinding
import android.content.Intent
import android.net.Uri

class MainActivity : AppCompatActivity() {
    private lateinit var binding: ActivityMainBinding
    private lateinit var navHostFragment: NavHostFragment
    private lateinit var navController: NavController

    override fun onCreate(savedInstanceState: Bundle?) {
        super.onCreate(savedInstanceState)

        val context: Context = this@MainActivity
        UserData.webClient.context = context

        binding = ActivityMainBinding.inflate(layoutInflater)

        setContentView(binding.root)

        val window = this.window
        window.statusBarColor = ContextCompat.getColor(this, if (Build.VERSION.SDK_INT >= 23) { R.color.white } else { R.color.colorPrimary })

        navHostFragment = supportFragmentManager.findFragmentById(R.id.nav_host_fragment) as NavHostFragment
        navController = navHostFragment.navController
        //val navigationView: NavigationView = binding.navView
        //navigationView.setupWithNavController(navController)

        val appLinkIntent: Intent = intent
        val appLinkAction: String? = appLinkIntent.action
        val appLinkData: Uri? = appLinkIntent.data

        println(appLinkAction)
        println(appLinkData)
    }
}