From: Jason Wang <jasowang@redhat.com>
Subject: [PATCH net] vhost: flush dcache page when logging dirty pages
Date: Tue,  9 Apr 2019 12:16:47 +0800
Message-ID: <20190409041647.21269-1-jasowang__24001.6514713474$1554783426$gmane$org@redhat.com>
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
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: mst@redhat.com, jasowang@redhat.com, kvm@vger.kernel.org, virtualization@lists.linux-foundation.org, netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Cc: Christoph Hellwig <hch@infradead.org>, James Bottomley <James.Bottomley@HansenPartnership.com>, Andrea Arcangeli <aarcange@redhat.com>
List-Id: virtualization@lists.linuxfoundation.org

We set dirty bit through setting up kmaps and access them through
kernel virtual address, this may result alias in virtually tagged
caches that require a dcache flush afterwards.

Cc: Christoph Hellwig <hch@infradead.org>
Cc: James Bottomley <James.Bottomley@HansenPartnership.com>
Cc: Andrea Arcangeli <aarcange@redhat.com>
Fixes: 3a4d5c94e9593 ("vhost_net: a kernel-level virtio server")
Signed-off-by: Jason Wang <jasowang@redhat.com>
---
 drivers/vhost/vhost.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/vhost/vhost.c b/drivers/vhost/vhost.c
index 351af88231ad..34a1cedbc5ba 100644
--- a/drivers/vhost/vhost.c
+++ b/drivers/vhost/vhost.c
@@ -1711,6 +1711,7 @@ static int set_bit_to_user(int nr, void __user *addr)
 	base = kmap_atomic(page);
 	set_bit(bit, base);
 	kunmap_atomic(base);
+	flush_dcache_page(page);
 	set_page_dirty_lock(page);
 	put_page(page);
 	return 0;
-- 
2.19.1
