From: kbuild test robot <lkp@intel.com>
Subject: Re: [PATCH] drm/simple-kms: Standardize arguments for callbacks
Date: Wed, 23 Oct 2019 13:55:38 +0800
Message-ID: <201910231343.cn5i5UQp%lkp__31008.1819466845$1571810285$gmane$org@intel.com>
References: <20191022155536.27939-1-daniel.vetter@ffwll.ch>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
Content-Disposition: inline
In-Reply-To: <20191022155536.27939-1-daniel.vetter@ffwll.ch>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/virtualization/>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
Cc: kbuild-all@lists.01.org, Daniel Vetter <daniel.vetter@ffwll.ch>, DRI Development <dri-devel@lists.freedesktop.org>, virtualization@lists.linux-foundation.org, Thomas Zimmermann <tzimmermann@suse.de>, Daniel Vetter <daniel.vetter@intel.com>, Emil Velikov <emil.velikov@collabora.com>
List-Id: virtualization@lists.linuxfoundation.org

Hi Daniel,

I love your patch! Perhaps something to improve:

[auto build test WARNING on linus/master]
[cannot apply to v5.4-rc4 next-20191022]
[if your patch is applied to the wrong git tree, please drop us a note to help
improve the system. BTW, we also suggest to use '--base' option to specify the
base tree in git format-patch, please see https://stackoverflow.com/a/37406982]

url:    https://github.com/0day-ci/linux/commits/Daniel-Vetter/drm-simple-kms-Standardize-arguments-for-callbacks/20191023-073731
base:   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git 3b7c59a1950c75f2c0152e5a9cd77675b09233d6
reproduce:
        # apt-get install sparse
        # sparse version: v0.6.1-dirty
        make ARCH=x86_64 allmodconfig
        make C=1 CF='-fdiagnostic-prefix -D__CHECK_ENDIAN__'

If you fix the issue, kindly add following tag
Reported-by: kbuild test robot <lkp@intel.com>


sparse warnings: (new ones prefixed by >>)

>> drivers/gpu/drm/xen/xen_drm_front_kms.c:289:23: sparse: sparse: incorrect type in initializer (incompatible argument 1 (different base types)) @@    expected int enum drm_mode_status ( *mode_valid )( ... ) @@    got int enum drm_mode_status ( *mode_valid )( ... ) @@
>> drivers/gpu/drm/xen/xen_drm_front_kms.c:289:23: sparse:    expected int enum drm_mode_status ( *mode_valid )( ... )
>> drivers/gpu/drm/xen/xen_drm_front_kms.c:289:23: sparse:    got int enum drm_mode_status ( * )( ... )

vim +289 drivers/gpu/drm/xen/xen_drm_front_kms.c

c575b7eeb89f94 Oleksandr Andrushchenko 2018-04-03  287  
c575b7eeb89f94 Oleksandr Andrushchenko 2018-04-03  288  static const struct drm_simple_display_pipe_funcs display_funcs = {
c575b7eeb89f94 Oleksandr Andrushchenko 2018-04-03 @289  	.mode_valid = display_mode_valid,
c575b7eeb89f94 Oleksandr Andrushchenko 2018-04-03  290  	.enable = display_enable,
c575b7eeb89f94 Oleksandr Andrushchenko 2018-04-03  291  	.disable = display_disable,
dd388ee1ecbb8c Daniel Vetter           2018-04-09  292  	.prepare_fb = drm_gem_fb_simple_display_pipe_prepare_fb,
c575b7eeb89f94 Oleksandr Andrushchenko 2018-04-03  293  	.update = display_update,
c575b7eeb89f94 Oleksandr Andrushchenko 2018-04-03  294  };
c575b7eeb89f94 Oleksandr Andrushchenko 2018-04-03  295  

:::::: The code at line 289 was first introduced by commit
:::::: c575b7eeb89f94356997abd62d6d5a0590e259b7 drm/xen-front: Add support for Xen PV display frontend

:::::: TO: Oleksandr Andrushchenko <oleksandr_andrushchenko@epam.com>
:::::: CC: Oleksandr Andrushchenko <oleksandr_andrushchenko@epam.com>

---
0-DAY kernel test infrastructure                Open Source Technology Center
https://lists.01.org/pipermail/kbuild-all                   Intel Corporation
