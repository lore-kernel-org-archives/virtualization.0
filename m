From: Alistair Francis <Alistair.Francis@wdc.com>
Subject: [PATCH] drm/bochs: Fix the ID mismatch error
Date: Thu, 21 Feb 2019 00:33:03 +0000
Message-ID: <20190221003231.31625-1-alistair.francis__34990.2087169298$1555717151$gmane$org@wdc.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
Content-Language: en-US
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/virtualization/>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: "kraxel@redhat.com" <kraxel@redhat.com>, "virtualization@lists.linux-foundation.org" <virtualization@lists.linux-foundation.org>
Cc: "david.abdurachmanov@gmail.com" <david.abdurachmanov@gmail.com>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "dri-devel@lists.freedesktop.org" <dri-devel@lists.freedesktop.org>, Alistair Francis <Alistair.Francis@wdc.com>, "alistair23@gmail.com" <alistair23@gmail.com>, "linux-riscv@lists.infradead.org" <linux-riscv@lists.infradead.org>
List-Id: virtualization@lists.linuxfoundation.org

When running RISC-V QEMU with the Bochs device attached via PCIe the
probe of the Bochs device fails with:
    [drm:bochs_hw_init] *ERROR* ID mismatch

This was introduced by this commit:
    7780eb9ce8 bochs: convert to drm_dev_register

To fix the error we ensure that pci_enable_device() is called before
bochs_load().

Signed-off-by: Alistair Francis <alistair.francis@wdc.com>
Reported-by: David Abdurachmanov <david.abdurachmanov@gmail.com>
---
 drivers/gpu/drm/bochs/bochs_drv.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/drivers/gpu/drm/bochs/bochs_drv.c b/drivers/gpu/drm/bochs/bochs_drv.c
index f3dd66ae990a..aa35007262cd 100644
--- a/drivers/gpu/drm/bochs/bochs_drv.c
+++ b/drivers/gpu/drm/bochs/bochs_drv.c
@@ -154,6 +154,10 @@ static int bochs_pci_probe(struct pci_dev *pdev,
 	if (IS_ERR(dev))
 		return PTR_ERR(dev);
 
+	ret = pci_enable_device(pdev);
+	if (ret)
+		goto err_free_dev;
+
 	dev->pdev = pdev;
 	pci_set_drvdata(pdev, dev);
 
-- 
2.20.1
