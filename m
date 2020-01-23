From: Thomas Zimmermann <tzimmermann@suse.de>
Subject: [PATCH v4 00/15] Use no_vblank property for drivers without VBLANK
Date: Thu, 23 Jan 2020 10:21:08 +0100
Message-ID: <20200123092123.28368-1-tzimmermann@suse.de>
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
Cc: xen-devel@lists.xenproject.org, Thomas Zimmermann <tzimmermann@suse.de>, dri-devel@lists.freedesktop.org, virtualization@lists.linux-foundation.org
List-Id: virtualization@lists.linuxfoundation.org

Instead of faking VBLANK events by themselves, drivers without VBLANK
support can enable drm_crtc_vblank.no_vblank and let DRM do the rest.
The patchset makes this official and converts over drivers.

The current implementation looks at state of a device wrt vblanking. If
vblanking has been initialized for the device, the driver is responsible
for sending out VBLANK events. Otherwise, DRM will send out the event.
The behaviour is selected by initializing no_vblank as part of
drm_atomic_helper_check_modeset().

I went through all drivers, looking for those that call send out VBLANK
events but do not call drm_vblank_init(). These are converted to the new
semantics. This affects tiny drivers; drivers for virtual hardware; and
a few others, which do not support interrupts. Xen comes with its
own VBLANK logic and now disables no_vblank explictly.

v4:
	* replaced drm_crtc_has_vblank() with drm_dev_has_vblank() (Daniel)
	* squashed patches 1 and 2
	* moved driver updates into separate patches
v3:
	* reorder and squash patches
	* set no_vblank in drm_atomic_helper_check_modeset() for *all*
			  drivers (Daniel)
	* convert all drivers to new semnatics as necessary
v2:
	* document functionality (Daniel)
	* cleanup ast (Daniel)
	* let simple-kms handle no_vblank where possible

Thomas Zimmermann (15):
  drm: Initialize struct drm_crtc_state.no_vblank from device settings
  drm/arc: Remove sending of vblank event
  drm/ast: Don't set struct drm_crtc_state.no_vblank explictly
  drm/bochs: Remove sending of vblank event
  drm/cirrus: Remove sending of vblank event
  drm/gm12u320: Remove sending of vblank event
  drm/ili9225: Remove sending of vblank event
  drm/mipi-dbi: Remove sending of vblank event
  drm/qxl: Remove sending of vblank event
  drm/repaper: Remove sending of vblank event
  drm/st7586: Remove sending of vblank event
  drm/udl: Don't set struct drm_crtc_state.no_vblank explictly
  drm/vboxvideo: Remove sending of vblank event
  drm/virtio: Remove sending of vblank event
  drm/xen: Explicitly disable automatic sending of vblank event

 drivers/gpu/drm/arc/arcpgu_crtc.c        | 16 --------------
 drivers/gpu/drm/ast/ast_mode.c           |  2 --
 drivers/gpu/drm/bochs/bochs_kms.c        |  9 --------
 drivers/gpu/drm/cirrus/cirrus.c          |  8 -------
 drivers/gpu/drm/drm_atomic_helper.c      | 10 ++++++++-
 drivers/gpu/drm/drm_mipi_dbi.c           |  9 --------
 drivers/gpu/drm/drm_vblank.c             | 28 ++++++++++++++++++++++++
 drivers/gpu/drm/qxl/qxl_display.c        | 14 ------------
 drivers/gpu/drm/tiny/gm12u320.c          |  9 --------
 drivers/gpu/drm/tiny/ili9225.c           |  9 --------
 drivers/gpu/drm/tiny/repaper.c           |  9 --------
 drivers/gpu/drm/tiny/st7586.c            |  9 --------
 drivers/gpu/drm/udl/udl_modeset.c        | 11 ----------
 drivers/gpu/drm/vboxvideo/vbox_mode.c    | 12 ----------
 drivers/gpu/drm/virtio/virtgpu_display.c |  8 -------
 drivers/gpu/drm/xen/xen_drm_front_kms.c  | 13 +++++++++++
 include/drm/drm_crtc.h                   | 27 +++++++++++++++++------
 include/drm/drm_simple_kms_helper.h      |  7 ++++--
 include/drm/drm_vblank.h                 |  1 +
 19 files changed, 76 insertions(+), 135 deletions(-)

--
2.24.1
