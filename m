From: Andy Lutomirski <luto@kernel.org>
Subject: [PATCH v5 10/10] vring: Add a module parameter to force-enable the
	DMA API
Date: Thu, 28 Jan 2016 18:31:23 -0800
Message-ID: <76b6105e15c27c669cffc665e3a074c5cb3d5e16.1454034075.git.luto__4728.20945219627$1454034811$gmane$org@kernel.org>
References: <cover.1454034075.git.luto@kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <cover.1454034075.git.luto@kernel.org>
In-Reply-To: <cover.1454034075.git.luto@kernel.org>
References: <cover.1454034075.git.luto@kernel.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/virtualization/>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: "Michael S. Tsirkin" <mst@redhat.com>
Cc: Joerg Roedel <jroedel@suse.de>, KVM <kvm@vger.kernel.org>, linux-s390 <linux-s390@vger.kernel.org>, Benjamin Herrenschmidt <benh@kernel.crashing.org>, Stefano Stabellini <stefano.stabellini@eu.citrix.com>, Sebastian Ott <sebott@linux.vnet.ibm.com>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, Christoph Hellwig <hch@lst.de>, Christian Borntraeger <borntraeger@de.ibm.com>, David Vrabel <david.vrabel@citrix.com>, Andy Lutomirski <luto@kernel.org>, xen-devel@lists.xenproject.org, sparclinux@vger.kernel.org, Paolo Bonzini <pbonzini@redhat.com>, Linux Virtualization <virtualization@lists.linux-foundation.org>, David Woodhouse <dwmw2@infradead.org>, "David S. Miller" <davem@davemloft.net>, Martin Schwidefsky <schwidefsky@de.ibm.com>
List-Id: virtualization@lists.linuxfoundation.org

This will be useful for testing.

Signed-off-by: Andy Lutomirski <luto@kernel.org>
---
 drivers/virtio/virtio_ring.c | 6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

diff --git a/drivers/virtio/virtio_ring.c b/drivers/virtio/virtio_ring.c
index 305c05cc249a..46fb77d824e9 100644
--- a/drivers/virtio/virtio_ring.c
+++ b/drivers/virtio/virtio_ring.c
@@ -45,6 +45,10 @@
  * API.
  */
 
+static bool force_dma_api = false;
+module_param(force_dma_api, bool, 0644);
+MODULE_PARM_DESC(force_dma_api, "force-enable the DMA API");
+
 static bool vring_use_dma_api(void)
 {
 #if defined(CONFIG_X86) && defined(CONFIG_XEN)
@@ -59,7 +63,7 @@ static bool vring_use_dma_api(void)
 	return static_cpu_has(X86_FEATURE_XENPV);
 #endif
 
-	return false;
+	return force_dma_api;
 }
 
 #ifdef DEBUG
-- 
2.5.0
