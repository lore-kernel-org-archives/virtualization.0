From: Thomas Zimmermann <tzimmermann@suse.de>
Subject: [PATCH v3 0/4] drm: Provide a simple encoder
Date: Tue, 25 Feb 2020 14:10:51 +0100
Message-ID: <20200225131055.27550-1-tzimmermann@suse.de>
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
patchset adds drm_simple_encoder_init(), which can be used by drivers
instead. Except for the destroy callback, the simple encoder's implementation
is empty.

The patchset also converts 4 encoder instances to use the simple-encoder
helpers. But there are at least 11 other drivers which can use the helper
and I think I did not examine all drivers yet.

The patchset was smoke-tested on mgag200 by running the fbdev console
and Gnome on X11.

v3:
	* remove drm_simple_encoder_create() for lack of users (Sam, Daniel)
	* provide more precise documentation (Sam)
v2:
	* move simple encoder to KMS helpers (Daniel)
	* remove name argument; simplifies implementation (Gerd)
	* don't allocate with devm_ interfaces; unsafe with DRM (Noralf)

Thomas Zimmermann (4):
  drm/simple-kms: Add drm_simple_encoder_{init,create}()
  drm/ast: Use simple encoder
  drm/mgag200: Use simple encoder
  drm/qxl: Use simple encoder

 drivers/gpu/drm/ast/ast_drv.h           |  6 +-
 drivers/gpu/drm/ast/ast_mode.c          | 25 +++-----
 drivers/gpu/drm/drm_simple_kms_helper.c | 34 +++++++++-
 drivers/gpu/drm/mgag200/mgag200_drv.h   |  9 +--
 drivers/gpu/drm/mgag200/mgag200_mode.c  | 85 +++----------------------
 drivers/gpu/drm/qxl/qxl_display.c       | 18 +-----
 include/drm/drm_simple_kms_helper.h     |  4 ++
 7 files changed, 59 insertions(+), 122 deletions(-)

--
2.25.0
