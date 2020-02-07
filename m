From: Gerd Hoffmann <kraxel@redhat.com>
Subject: [PATCH v2] drm/bochs: downgrade pci_request_region failure from error to warning
Date: Fri,  7 Feb 2020 12:57:44 +0100
Message-ID: <20200207115744.4559-1-kraxel@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: dri-devel@lists.freedesktop.org
Cc: marmarek@invisiblethingslab.com, Gerd Hoffmann <kraxel@redhat.com>, David Airlie <airlied@linux.ie>, Daniel Vetter <daniel@ffwll.ch>, "open list:DRM DRIVER FOR
        BOCHS VIRTUAL GPU" <virtualization@lists.linux-foundation.org>, open list <linux-kernel@vger.kernel.org>
List-Id: virtualization@lists.linuxfoundation.org

Shutdown of firmware framebuffer has a bunch of problems.  Because
of this the framebuffer region might still be reserved even after
drm_fb_helper_remove_conflicting_pci_framebuffers() returned.

Don't consider pci_request_region() failure for the framebuffer
region as fatal error to workaround this issue.

Reported-by: Marek Marczykowski-G=C3=B3recki <marmarek@invisiblethingslab=
.com>
Signed-off-by: Gerd Hoffmann <kraxel@redhat.com>
---
 drivers/gpu/drm/bochs/bochs_hw.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/bochs/bochs_hw.c b/drivers/gpu/drm/bochs/boc=
hs_hw.c
index b615b7dfdd9d..a387efa9e559 100644
--- a/drivers/gpu/drm/bochs/bochs_hw.c
+++ b/drivers/gpu/drm/bochs/bochs_hw.c
@@ -157,8 +157,7 @@ int bochs_hw_init(struct drm_device *dev)
 	}
=20
 	if (pci_request_region(pdev, 0, "bochs-drm") !=3D 0) {
-		DRM_ERROR("Cannot request framebuffer\n");
-		return -EBUSY;
+		DRM_WARN("Cannot request framebuffer, boot framebuffer still active?\n=
");
 	}
=20
 	bochs->fb_map =3D ioremap(addr, size);
--=20
2.18.1
