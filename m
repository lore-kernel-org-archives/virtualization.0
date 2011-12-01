From: "K. Y. Srinivasan" <kys@microsoft.com>
Subject: =?UTF-8?q?=5BPATCH=201/1=5D=20hv=3A=20Update=20MAINTAINERS?=
Date: Thu,  1 Dec 2011 14:31:30 -0800
Message-ID: <1322778690-17381-1-git-send-email-kys@microsoft.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: gregkh@suse.de, linux-kernel@vger.kernel.org, devel@linuxdriverproject.org, virtualization@lists.osdl.org, ohering@suse.com, joe@perches.com, dmitry.torokhov@gmail.com, jkosina@suse.cz
Cc: "K. Y. Srinivasan" <kys@microsoft.com>, Haiyang Zhang <haiyangz@microsoft.com>
List-Id: virtualization@lists.linuxfoundation.org

Update the MAINTAINERS file to reflect the current state
of the Hyper-V drivers.

Signed-off-by: K. Y. Srinivasan <kys@microsoft.com>
Signed-off-by: Haiyang Zhang <haiyangz@microsoft.com>
---
 MAINTAINERS |   16 ++++++++++------
 1 files changed, 10 insertions(+), 6 deletions(-)

diff --git a/MAINTAINERS b/MAINTAINERS
index 3523ab0..809cad8 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -3197,6 +3197,16 @@ M:	William Irwin <wli@holomorphy.com>
 S:	Maintained
 F:	fs/hugetlbfs/
=20
+Hyper-V CORE AND DRIVERS
+M:	K. Y. Srinivasan <kys@microsoft.com>
+M:	Haiyang Zhang <haiyangz@microsoft.com>
+L:	devel@linuxdriverproject.org
+S:	Maintained
+F:	drivers/hv/
+F:	drivers/hid/hid-hyperv.c
+F:	drivers/net/hyperv/
+F:	drivers/staging/hv/
+
 I2C/SMBUS STUB DRIVER
 M:	"Mark M. Hoffman" <mhoffman@lightlink.com>
 L:	linux-i2c@vger.kernel.org
@@ -6322,12 +6332,6 @@ M:	David T=C3=A4ht <d@teklibre.com>
 S:	Odd Fixes
 F:	drivers/staging/frontier/
=20
-STAGING - HYPER-V (MICROSOFT)
-M:	Hank Janssen <hjanssen@microsoft.com>
-M:	Haiyang Zhang <haiyangz@microsoft.com>
-S:	Odd Fixes
-F:	drivers/staging/hv/
-
 STAGING - INDUSTRIAL IO
 M:	Jonathan Cameron <jic23@cam.ac.uk>
 L:	linux-iio@vger.kernel.org
--=20
1.7.4.1
