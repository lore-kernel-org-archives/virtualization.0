From: Gerd Hoffmann <kraxel@redhat.com>
Subject: [PATCH v3] drm/bochs: downgrade pci_request_region failure from error to warning
Date: Fri, 13 Mar 2020 09:41:52 +0100
Message-ID: <20200313084152.2734-1-kraxel@redhat.com>
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
 drivers/gpu/drm/bochs/bochs_hw.c | 6 ++----
 1 file changed, 2 insertions(+), 4 deletions(-)

diff --git a/drivers/gpu/drm/bochs/bochs_hw.c b/drivers/gpu/drm/bochs/boc=
hs_hw.c
index 952199cc0462..dce4672e3fc8 100644
--- a/drivers/gpu/drm/bochs/bochs_hw.c
+++ b/drivers/gpu/drm/bochs/bochs_hw.c
@@ -157,10 +157,8 @@ int bochs_hw_init(struct drm_device *dev)
 		size =3D min(size, mem);
 	}
=20
-	if (pci_request_region(pdev, 0, "bochs-drm") !=3D 0) {
-		DRM_ERROR("Cannot request framebuffer\n");
-		return -EBUSY;
-	}
+	if (pci_request_region(pdev, 0, "bochs-drm") !=3D 0)
+		DRM_WARN("Cannot request framebuffer, boot fb still active?\n");
=20
 	bochs->fb_map =3D ioremap(addr, size);
 	if (bochs->fb_map =3D=3D NULL) {
--=20
2.18.2
