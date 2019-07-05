From: Thomas Zimmermann <tzimmermann@suse.de>
Subject: [PATCH v2 0/6] Unmappable DRM client buffers for fbdev emulation
Date: Fri,  5 Jul 2019 11:26:07 +0200
Message-ID: <20190705092613.7621-1-tzimmermann@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/virtualization/>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: airlied@redhat.com, daniel@ffwll.ch, kraxel@redhat.com, maarten.lankhorst@linux.intel.com, maxime.ripard@bootlin.com, sean@poorly.run, noralf@tronnes.org, sam@ravnborg.org, yc_chen@aspeedtech.com
Cc: Thomas Zimmermann <tzimmermann@suse.de>, dri-devel@lists.freedesktop.org, virtualization@lists.linux-foundation.org
List-Id: virtualization@lists.linuxfoundation.org

DRM client buffers are permanently mapped throughout their lifetime. This
prevents us from using generic framebuffer emulation for devices with
small dedicated video memory, such as ast or mgag200. With fb buffers
permanently mapped, such devices often won't have enough space left to
display other content (e.g., X11).

This patch set introduces unmappable DRM client buffers for framebuffer
emulation with shadow buffers. While the shadow buffer remains in system
memory permanently, the respective buffer object will only be mapped briefly
during updates from the shadow buffer. Hence, the driver can relocate he
buffer object among memory regions as needed.

HW-based framebuffer consoles will still map the buffer permanently. This
is a special case required by the fbdev interface, which allows for mmaping
video memory to userspace. Some userspace clients rely on this
functionality. Hence, the patch set also changes DRM clients to not map the
buffer by default. Future DRM clients are expected to map buffers as needed.

The patch set converts ast and mgag200 to generic framebuffer emulation
and removes a large amount of framebuffer code from these drivers. For
bochs, a problem was reported where the driver could not display the console
because it was pinned in system memory. [1] The patch set fixes this bug
by converting bochs to use the shadow fb.

The patch set has been tested on ast and mga200 HW.

[1] https://lists.freedesktop.org/archives/dri-devel/2019-June/224423.html

Thomas Zimmermann (6):
  drm/client: Support unmapping of DRM client buffers
  drm/fb-helper: Map DRM client buffer only when required
  drm/fb-helper: Instanciate shadow FB if configured in device's
    mode_config
  drm/ast: Replace struct ast_fbdev with generic framebuffer emulation
  drm/bochs: Use shadow buffer for bochs framebuffer console
  drm/mgag200: Replace struct mga_fbdev with generic framebuffer
    emulation

 drivers/gpu/drm/ast/Makefile           |   2 +-
 drivers/gpu/drm/ast/ast_drv.c          |  13 +-
 drivers/gpu/drm/ast/ast_drv.h          |  17 --
 drivers/gpu/drm/ast/ast_fb.c           | 341 -------------------------
 drivers/gpu/drm/ast/ast_main.c         |   3 +-
 drivers/gpu/drm/ast/ast_mode.c         |  21 --
 drivers/gpu/drm/bochs/bochs_kms.c      |   1 +
 drivers/gpu/drm/drm_client.c           |  61 ++++-
 drivers/gpu/drm/drm_fb_helper.c        |  52 +++-
 drivers/gpu/drm/mgag200/Makefile       |   2 +-
 drivers/gpu/drm/mgag200/mgag200_drv.h  |  19 --
 drivers/gpu/drm/mgag200/mgag200_fb.c   | 309 ----------------------
 drivers/gpu/drm/mgag200/mgag200_main.c |  31 +--
 drivers/gpu/drm/mgag200/mgag200_mode.c |  27 --
 include/drm/drm_client.h               |   3 +
 include/drm/drm_mode_config.h          |   5 +
 16 files changed, 109 insertions(+), 798 deletions(-)
 delete mode 100644 drivers/gpu/drm/ast/ast_fb.c
 delete mode 100644 drivers/gpu/drm/mgag200/mgag200_fb.c

--
2.21.0
