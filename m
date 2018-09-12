From: Gerd Hoffmann <kraxel@redhat.com>
Subject: Re: [PATCH] qxl: refactor to use drm_fb_helper_fbdev_setup
Date: Wed, 12 Sep 2018 09:03:12 +0200
Message-ID: <20180912070312.kop4e2s3v5xeriwu@sirius.home.kraxel.org>
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
Cc: Dave Airlie <airlied@redhat.com>, linux-kernel@vger.kernel.org, dri-devel@lists.freedesktop.org, virtualization@lists.linux-foundation.org
List-Id: virtualization@lists.linuxfoundation.org

On Mon, Sep 10, 2018 at 03:21:56PM +0200, Peter Wu wrote:
> Lots of code can be removed by relying on fb-helper:
> - "struct drm_framebuffer" moves to fb_helper.fb.
> - "struct drm_gem_object" moves to fb_helper.obj[0].
> - "struct qxl_device" can be inferred as drm_fb_helper is embedded.
> - qxl_user_framebuffer_create -> drm_gem_fb_create.
> - qxl_user_framebuffer_destroy -> drm_gem_fb_destroy.
> - qxl_fbdev_destroy -> drm_fb_helper_fbdev_teardown + vfree(shadow).
> 
> Remove unused code:
> - qxl_fbdev_qobj_is_fb, qxl_fbdev_set_suspend.
> - Unused fields of qxl_fbdev: delayed_ops, delayed_ops_lock, size.
> 
> Misc notes:
> - The dirty callback is preserved as it is necessary to trigger update
>   commands in the hw (the screen stays black otherwise).
> - No idea when .create_handle in drm_framebuffer_funcs is used, but use
>   the same drm_gem_fb_create_handle to match drm_gem_fb_funcs.
> - I don't know why qxl_fb_find_or_create_single used to check for an
>   existing framebuffer and removed that check to match other drivers.
> - Use of drm_fb_helper_fbdev_teardown also requires "info->fbdefio" to
>   be dynamically allocated. Replace the existing defio config by
>   drm_fb_helper_defio_init to accomodate this.
> 
> Testing results: startx with fbdev, modesetting and qxl all seems to
> work. Tested also with CONFIG_DRM_FBDEV_EMULATION=n, fbdev obviously
> fails but others are fine. QEMU -spice and QEMU -spice with vdagent and
> multiple (resized) displays (via remote-viewer) also works.
> unbind vtconsole and rmmod has *not* regressed (i.e. it still trips on a
> use-after-free in qxl_check_idle via qxl_ttm_fini).
> 
> Ideally setup/teardown is replaced by drm_fbdev_generic_setup as that
> would result in further code reduction, improve error handling (like not
> leaking shadow memory), but unfortunately QXL has no implementation for
> qxl_gem_prime_vmap.

Pushed to drm-misc-next.

thanks,
  Gerd
