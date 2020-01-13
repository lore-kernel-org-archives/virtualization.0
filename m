From: Thomas Zimmermann <tzimmermann@suse.de>
Subject: [PATCH v2 0/4] Use no_vblank property for drivers without VBLANK
Date: Mon, 13 Jan 2020 11:38:18 +0100
Message-ID: <20200113103822.24473-1-tzimmermann@suse.de>
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
To: airlied@linux.ie, daniel@ffwll.ch, kraxel@redhat.com, maarten.lankhorst@linux.intel.com, mripard@kernel.org, hdegoede@redhat.com, david@lechnology.com, noralf@tronnes.org, sean@poorly.run, oleksandr_andrushchenko@epam.com, sam@ravnborg.org, laurent.pinchart@ideasonboard.com, emil.velikov@collabora.com
Cc: xen-devel@lists.xenproject.org, dri-devel@lists.freedesktop.or, Thomas Zimmermann <tzimmermann@suse.de>, virtualization@lists.linux-foundation.org
List-Id: virtualization@lists.linuxfoundation.org

Instead of faking VBLANK events by themselves, drivers without VBLANK
support can enable drm_crtc_vblank.no_vblank and let DRM do the rest.
The patchset makes this official and converts over several drivers.

Ast already uses the functionality and just needs a cleanup. Cirrus can
be converted easily by setting the field in the check() callback and
removing the existing VBLANK code. For most other simple-KMS drivers
without enable_vblank() and check(), simple-KMS helpers can enable the
faked VBLANK by default. The only exception is Xen, which comes with
its own VBLANK logic and should rather to disable no_vblank.

v2:
	* document functionality (Daniel)
	* cleanup ast (Daniel)
	* let simple-kms handle no_vblank where possible

Thomas Zimmermann (4):
  drm: Document struct drm_crtc_state.no_vblank for faking VBLANK events
  drm/ast: Set struct drm_crtc_state.no_vblank in atomic_check()
  drm/cirrus: Let DRM core send VBLANK events
  drm/simple-kms: Let DRM core send VBLANK events by default

 drivers/gpu/drm/ast/ast_mode.c          |  4 ++--
 drivers/gpu/drm/bochs/bochs_kms.c       |  9 ---------
 drivers/gpu/drm/cirrus/cirrus.c         | 10 ++--------
 drivers/gpu/drm/drm_atomic_helper.c     |  4 +++-
 drivers/gpu/drm/drm_mipi_dbi.c          |  9 ---------
 drivers/gpu/drm/drm_simple_kms_helper.c | 19 +++++++++++++++----
 drivers/gpu/drm/tiny/gm12u320.c         |  9 ---------
 drivers/gpu/drm/tiny/ili9225.c          |  9 ---------
 drivers/gpu/drm/tiny/repaper.c          |  9 ---------
 drivers/gpu/drm/tiny/st7586.c           |  9 ---------
 drivers/gpu/drm/udl/udl_modeset.c       | 11 -----------
 drivers/gpu/drm/xen/xen_drm_front_kms.c | 13 +++++++++++++
 include/drm/drm_crtc.h                  |  9 +++++++--
 include/drm/drm_simple_kms_helper.h     |  7 +++++--
 14 files changed, 47 insertions(+), 84 deletions(-)

--
2.24.1
