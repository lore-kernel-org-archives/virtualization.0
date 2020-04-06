From: "Michael S. Tsirkin" <mst@redhat.com>
Subject: [PATCH v2 1/2] vdpa-sim: depend on HAS_DMA
Date: Mon, 6 Apr 2020 08:12:42 -0400
Message-ID: <20200406121233.109889-2-mst@redhat.com>
References: <20200406121233.109889-1-mst@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20200406121233.109889-1-mst@redhat.com>
Sender: linux-kernel-owner@vger.kernel.org
To: linux-kernel@vger.kernel.org
Cc: Ard Biesheuvel <ardb@kernel.org>, "richard.henderson@linaro.org" <richard.henderson@linaro.org>, "christophe.lyon@st.com" <christophe.lyon@st.com>, kbuild test robot <lkp@intel.com>, "daniel.santos@pobox.com" <daniel.santos@pobox.com>, Jason Wang <jasowang@redhat.com>, "kbuild-all@lists.01.org" <kbuild-all@lists.01.org>, Russell King <rmk+kernel@armlinux.org.uk>, Linux ARM <linux-arm-kernel@lists.infradead.org>, virtualization@lists.linux-foundation.org
List-Id: virtualization@lists.linuxfoundation.org

set_dma_ops isn't available on all architectures:

        make ARCH=um
...

   drivers/vdpa/vdpa_sim/vdpa_sim.c: In function 'vdpasim_create':
>> drivers/vdpa/vdpa_sim/vdpa_sim.c:324:2: error: implicit declaration of function 'set_dma_ops'; did you mean 'set_groups'?
+[-Werror=implicit-function-declaration]
     set_dma_ops(dev, &vdpasim_dma_ops);
     ^~~~~~~~~~~
     set_groups

Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
---
 drivers/vdpa/Kconfig | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/vdpa/Kconfig b/drivers/vdpa/Kconfig
index 08b615f2da39..d0cb0e583a5d 100644
--- a/drivers/vdpa/Kconfig
+++ b/drivers/vdpa/Kconfig
@@ -14,7 +14,7 @@ if VDPA_MENU
 
 config VDPA_SIM
 	tristate "vDPA device simulator"
-	depends on RUNTIME_TESTING_MENU
+	depends on RUNTIME_TESTING_MENU && HAS_DMA
 	select VDPA
 	select VHOST_RING
 	select VHOST_IOTLB
-- 
MST
