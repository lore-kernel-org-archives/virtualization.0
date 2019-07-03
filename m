From: Thomas Zimmermann <tzimmermann@suse.de>
Subject: [PATCH 0/5] Unmappable DRM client buffers for fbdev emulation
Date: Wed,  3 Jul 2019 10:32:57 +0200
Message-ID: <20190703083302.2609-1-tzimmermann@suse.de>
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
permanently mapped, such devices often won't have enougth space left to
display other content (e.g., X11).

This patch set introduces unmappable DRM client buffers for framebuffer
emulation with shadow buffers. While the shadow buffer remains in system
memory permanently, the respective buffer object will only be mapped briefly
during updates from the shadow buffer. Hence, the driver can relocate he
buffer object among memory regions as needed.

The default behoviour for DRM client buffers is still to be permanently
mapped.

The patch set converts ast and mgag200 to generic framebuffer emulation
and removes a large amount of framebuffer code from these drivers. For
bochs, a problem was reported where the driver could not display the console
because it was pinned in system memory. [1] The patch set fixes this bug
by converting bochs to use the shadow fb.

The patch set has been tested on ast and mga200 HW.

[1] https://lists.freedesktop.org/archives/dri-devel/2019-June/224423.html

Thomas Zimmermann (5):
  drm/client: Support unmapping of DRM client buffers
  drm/fb-helper: Unmap BO for shadow-buffered framebuffer console
  drm/ast: Replace struct ast_fbdev with generic framebuffer emulation
  drm/bochs: Use shadow buffer for bochs framebuffer console
  drm/mgag200: Replace struct mga_fbdev with generic framebuffer
    emulation

 drivers/gpu/drm/ast/Makefile           |   2 +-
 drivers/gpu/drm/ast/ast_drv.c          |  22 +-
 drivers/gpu/drm/ast/ast_drv.h          |  17 --
 drivers/gpu/drm/ast/ast_fb.c           | 341 -------------------------
 drivers/gpu/drm/ast/ast_main.c         |  30 ++-
 drivers/gpu/drm/ast/ast_mode.c         |  21 --
 drivers/gpu/drm/bochs/bochs_kms.c      |   2 +-
 drivers/gpu/drm/drm_client.c           |  71 ++++-
 drivers/gpu/drm/drm_fb_helper.c        |  14 +-
 drivers/gpu/drm/mgag200/Makefile       |   2 +-
 drivers/gpu/drm/mgag200/mgag200_drv.h  |  19 --
 drivers/gpu/drm/mgag200/mgag200_fb.c   | 309 ----------------------
 drivers/gpu/drm/mgag200/mgag200_main.c |  61 +++--
 drivers/gpu/drm/mgag200/mgag200_mode.c |  27 --
 include/drm/drm_client.h               |   3 +
 15 files changed, 154 insertions(+), 787 deletions(-)
 delete mode 100644 drivers/gpu/drm/ast/ast_fb.c
 delete mode 100644 drivers/gpu/drm/mgag200/mgag200_fb.c

--
2.21.0
