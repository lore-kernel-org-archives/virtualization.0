From: kbuild test robot <lkp@intel.com>
Subject: Re: [PATCH] qxl: refactor to use drm_fb_helper_fbdev_setup
Date: Tue, 11 Sep 2018 10:22:02 +0800
Message-ID: <201809111052.rIhvlMzJ%fengguang.wu__23541.9047683992$1536632478$gmane$org@intel.com>
References: <20180910132156.23201-1-peter@lekensteyn.nl>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
Content-Disposition: inline
In-Reply-To: <20180910132156.23201-1-peter@lekensteyn.nl>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/virtualization/>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: Peter Wu <peter@lekensteyn.nl>
Cc: linux-kernel@vger.kernel.org, dri-devel@lists.freedesktop.org, virtualization@lists.linux-foundation.org, kbuild-all@01.org, Dave Airlie <airlied@redhat.com>
List-Id: virtualization@lists.linuxfoundation.org

Hi Peter,

Thank you for the patch! Perhaps something to improve:

[auto build test WARNING on linus/master]
[also build test WARNING on v4.19-rc3 next-20180910]
[if your patch is applied to the wrong git tree, please drop us a note to help improve the system]

url:    https://github.com/0day-ci/linux/commits/Peter-Wu/qxl-refactor-to-use-drm_fb_helper_fbdev_setup/20180911-071413
reproduce:
        # apt-get install sparse
        make ARCH=x86_64 allmodconfig
        make C=1 CF=-D__CHECK_ENDIAN__


sparse warnings: (new ones prefixed by >>)

   drivers/gpu/drm/qxl/qxl_drv.c:144:9: sparse: undefined identifier 'qxl_fbdev_set_suspend'
   drivers/gpu/drm/qxl/qxl_drv.c:181:9: sparse: undefined identifier 'qxl_fbdev_set_suspend'
>> drivers/gpu/drm/qxl/qxl_drv.c:144:30: sparse: call with no type!
   drivers/gpu/drm/qxl/qxl_drv.c:181:30: sparse: call with no type!
   drivers/gpu/drm/qxl/qxl_drv.c: In function 'qxl_drm_freeze':
   drivers/gpu/drm/qxl/qxl_drv.c:144:2: error: implicit declaration of function 'qxl_fbdev_set_suspend'; did you mean 'fb_set_suspend'? [-Werror=implicit-function-declaration]
     qxl_fbdev_set_suspend(qdev, 1);
     ^~~~~~~~~~~~~~~~~~~~~
     fb_set_suspend
   cc1: some warnings being treated as errors
--
>> drivers/gpu/drm/qxl/qxl_fb.c:166:21: sparse: incorrect type in assignment (different address spaces) @@    expected char const *data @@    got char [noderchar const *data @@
   drivers/gpu/drm/qxl/qxl_fb.c:166:21:    expected char const *data
   drivers/gpu/drm/qxl/qxl_fb.c:166:21:    got char [noderef] <asn:2>*
   include/linux/overflow.h:251:13: sparse: undefined identifier '__builtin_mul_overflow'
   include/linux/overflow.h:251:13: sparse: incorrect type in conditional
   include/linux/overflow.h:251:13:    got void
   include/linux/overflow.h:251:13: sparse: call with no type!

vim +166 drivers/gpu/drm/qxl/qxl_fb.c

   130	
   131	/*
   132	 * FIXME
   133	 * It should not be necessary to have a special dirty() callback for fbdev.
   134	 */
   135	static int qxlfb_framebuffer_dirty(struct drm_framebuffer *fb,
   136					   struct drm_file *file_priv,
   137					   unsigned flags, unsigned color,
   138					   struct drm_clip_rect *clips,
   139					   unsigned num_clips)
   140	{
   141		struct qxl_device *qdev = fb->dev->dev_private;
   142		struct fb_info *info = qdev->fb_helper.fbdev;
   143		struct qxl_fb_image qxl_fb_image;
   144		struct fb_image *image = &qxl_fb_image.fb_image;
   145	
   146		/* TODO: hard coding 32 bpp */
   147		int stride = fb->pitches[0];
   148	
   149		/*
   150		 * we are using a shadow draw buffer, at qdev->surface0_shadow
   151		 */
   152		image->dx = clips->x1;
   153		image->dy = clips->y1;
   154		image->width = clips->x2 - clips->x1;
   155		image->height = clips->y2 - clips->y1;
   156		image->fg_color = 0xffffffff; /* unused, just to avoid uninitialized
   157						 warnings */
   158		image->bg_color = 0;
   159		image->depth = 32;	     /* TODO: take from somewhere? */
   160		image->cmap.start = 0;
   161		image->cmap.len = 0;
   162		image->cmap.red = NULL;
   163		image->cmap.green = NULL;
   164		image->cmap.blue = NULL;
   165		image->cmap.transp = NULL;
 > 166		image->data = info->screen_base + (clips->x1 * 4) + (stride * clips->y1);
   167	
   168		qxl_fb_image_init(&qxl_fb_image, qdev, info, NULL);
   169		qxl_draw_opaque_fb(&qxl_fb_image, stride);
   170	
   171		return 0;
   172	}
   173	

---
0-DAY kernel test infrastructure                Open Source Technology Center
https://lists.01.org/pipermail/kbuild-all                   Intel Corporation
