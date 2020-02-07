From: Thomas Zimmermann <tzimmermann@suse.de>
Subject: [PATCH 0/6] drm: Provide a simple encoder
Date: Fri,  7 Feb 2020 09:41:29 +0100
Message-ID: <20200207084135.4524-1-tzimmermann@suse.de>
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
Errors-To: virtualization-bounces@lists.linux-foundation.org
Sender: "Virtualization" <virtualization-bounces@lists.linux-foundation.org>
To: airlied@linux.ie, daniel@ffwll.ch, maarten.lankhorst@linux.intel.com, mripard@kernel.org, kraxel@redhat.com, noralf@tronnes.org, sam@ravnborg.org, alexander.deucher@amd.com, emil.velikov@collabora.com
Cc: spice-devel@lists.freedesktop.org, Thomas Zimmermann <tzimmermann@suse.de>, dri-devel@lists.freedesktop.org, virtualization@lists.linux-foundation.org
List-Id: virtualization@lists.linuxfoundation.org

Many DRM drivers implement an encoder with an empty implementation. This
patchset adds drm_simple_encoder_init() and drm_simple_encoder_create(),
which can be used by drivers instead. Except for the destroy callback, the
simple encoder's implementation is empty.

The patchset also converts 4 encoder instances to use the simple-encoder
helpers. But there are at least 11 other drivers which can use the helper
and I think I did not examine all drivers yet.

The patchset was smoke-tested on mgag200 by running the fbdev console
and Gnome on X11.

Thomas Zimmermann (6):
  drm: Move initialization of encoder into an internal function
  drm: Add drm_simple_encoder_{init,create}()
  drm/ast: Use simple encoder
  drm/mgag200: Use simple encoder
  drm/qxl: Use simple encoder
  drm/simple-pipe: Use simple encoder

 drivers/gpu/drm/ast/ast_drv.h           |   6 +-
 drivers/gpu/drm/ast/ast_mode.c          |  25 +---
 drivers/gpu/drm/drm_encoder.c           | 190 +++++++++++++++++++++---
 drivers/gpu/drm/drm_simple_kms_helper.c |   8 +-
 drivers/gpu/drm/mgag200/mgag200_drv.h   |   7 -
 drivers/gpu/drm/mgag200/mgag200_mode.c  |  60 +-------
 drivers/gpu/drm/qxl/qxl_display.c       |  17 +--
 include/drm/drm_encoder.h               |  10 ++
 8 files changed, 191 insertions(+), 132 deletions(-)

--
2.25.0
