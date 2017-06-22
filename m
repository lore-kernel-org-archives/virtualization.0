From: Daniel Vetter <daniel@ffwll.ch>
Subject: Re: [PATCH 11/11] drm: remove unused and redundant callbacks
Date: Thu, 22 Jun 2017 08:37:55 +0200
Message-ID: <20170622063755.3bfwybkotacyn4p7__25496.6092682027$1498113487$gmane$org@phenom.ffwll.local>
References: <1497986735-14418-12-git-send-email-peda@axentia.se>
	<201706220036.6WxRju5X%fengguang.wu@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
Content-Disposition: inline
In-Reply-To: <201706220036.6WxRju5X%fengguang.wu@intel.com>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/virtualization/>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: kbuild test robot <lkp@intel.com>
Cc: Boris Brezillon <boris.brezillon@free-electrons.com>, kbuild-all@01.org, Philippe Cornu <philippe.cornu@st.com>, nouveau@lists.freedesktop.org, intel-gfx@lists.freedesktop.org, linux-kernel@vger.kernel.org, amd-gfx@lists.freedesktop.org, virtualization@lists.linux-foundation.org, Yannick Fertre <yannick.fertre@st.com>, dri-devel@lists.freedesktop.org, Dave Airlie <airlied@redhat.com>, Alex Deucher <alexander.deucher@amd.com>, Daniel Vetter <daniel.vetter@intel.com>, Christian =?iso-8859-1?Q?K=F6nig?= <christian.koenig@amd.com>, Vincent Abriou <vincent.abriou@st.com>, Peter Rosin <peda@axentia.se>, Ben Skeggs <bskeggs@redhat.com>
List-Id: virtualization@lists.linuxfoundation.org

On Thu, Jun 22, 2017 at 12:34:36AM +0800, kbuild test robot wrote:
> Hi Peter,
> 
> [auto build test ERROR on drm/drm-next]
> [also build test ERROR on next-20170621]
> [cannot apply to v4.12-rc6]
> [if your patch is applied to the wrong git tree, please drop us a note to help improve the system]
> 
> url:    https://github.com/0day-ci/linux/commits/Peter-Rosin/improve-the-fb_setcmap-helper/20170621-205441
> base:   git://people.freedesktop.org/~airlied/linux.git drm-next
> config: arm-allmodconfig (attached as .config)
> compiler: arm-linux-gnueabi-gcc (Debian 6.1.1-9) 6.1.1 20160705
> reproduce:
>         wget https://raw.githubusercontent.com/01org/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
>         chmod +x ~/bin/make.cross
>         # save the attached .config to linux build tree
>         make.cross ARCH=arm 
> 
> All errors (new ones prefixed by >>):
> 
> >> drivers/gpu//drm/armada/armada_fbdev.c:121:2: error: unknown field 'gamma_set' specified in initializer
>      .gamma_set = armada_drm_crtc_gamma_set,

Looks like you've missed at least the armada driver in your conversion?
-Daniel

>      ^
> >> drivers/gpu//drm/armada/armada_fbdev.c:121:15: error: initialization from incompatible pointer type [-Werror=incompatible-pointer-types]
>      .gamma_set = armada_drm_crtc_gamma_set,
>                   ^~~~~~~~~~~~~~~~~~~~~~~~~
>    drivers/gpu//drm/armada/armada_fbdev.c:121:15: note: (near initialization for 'armada_fb_helper_funcs.fb_probe')
> >> drivers/gpu//drm/armada/armada_fbdev.c:122:2: error: unknown field 'gamma_get' specified in initializer
>      .gamma_get = armada_drm_crtc_gamma_get,
>      ^
>    drivers/gpu//drm/armada/armada_fbdev.c:122:15: error: initialization from incompatible pointer type [-Werror=incompatible-pointer-types]
>      .gamma_get = armada_drm_crtc_gamma_get,
>                   ^~~~~~~~~~~~~~~~~~~~~~~~~
>    drivers/gpu//drm/armada/armada_fbdev.c:122:15: note: (near initialization for 'armada_fb_helper_funcs.initial_config')
>    cc1: some warnings being treated as errors
> 
> vim +/gamma_set +121 drivers/gpu//drm/armada/armada_fbdev.c
> 
> 96f60e37 Russell King   2012-08-15  115  			ret = 1;
> 96f60e37 Russell King   2012-08-15  116  	}
> 96f60e37 Russell King   2012-08-15  117  	return ret;
> 96f60e37 Russell King   2012-08-15  118  }
> 96f60e37 Russell King   2012-08-15  119  
> 3a493879 Thierry Reding 2014-06-27  120  static const struct drm_fb_helper_funcs armada_fb_helper_funcs = {
> 96f60e37 Russell King   2012-08-15 @121  	.gamma_set	= armada_drm_crtc_gamma_set,
> 96f60e37 Russell King   2012-08-15 @122  	.gamma_get	= armada_drm_crtc_gamma_get,
> 96f60e37 Russell King   2012-08-15  123  	.fb_probe	= armada_fb_probe,
> 96f60e37 Russell King   2012-08-15  124  };
> 96f60e37 Russell King   2012-08-15  125  
> 
> :::::: The code at line 121 was first introduced by commit
> :::::: 96f60e37dc66091bde8d5de136ff6fda09f2d799 DRM: Armada: Add Armada DRM driver
> 
> :::::: TO: Russell King <rmk+kernel@arm.linux.org.uk>
> :::::: CC: Russell King <rmk+kernel@arm.linux.org.uk>
> 
> ---
> 0-DAY kernel test infrastructure                Open Source Technology Center
> https://lists.01.org/pipermail/kbuild-all                   Intel Corporation


> _______________________________________________
> dri-devel mailing list
> dri-devel@lists.freedesktop.org
> https://lists.freedesktop.org/mailman/listinfo/dri-devel


-- 
Daniel Vetter
Software Engineer, Intel Corporation
http://blog.ffwll.ch
