From: Wei Wang <wei.w.wang@intel.com>
Subject: [PATCH v10 5/6] mm: export symbol of next_zone and first_online_pgdat
Date: Thu,  4 May 2017 16:50:14 +0800
Message-ID: <1493887815-6070-6-git-send-email-wei.w.wang__33239.5983198241$1493888224$gmane$org@intel.com>
References: <1493887815-6070-1-git-send-email-wei.w.wang@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <1493887815-6070-1-git-send-email-wei.w.wang@intel.com>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/virtualization/>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: virtio-dev@lists.oasis-open.org, linux-kernel@vger.kernel.org, qemu-devel@nongnu.org, virtualization@lists.linux-foundation.org, kvm@vger.kernel.org, linux-mm@kvack.org, mst@redhat.com, david@redhat.com, dave.hansen@intel.com, cornelia.huck@de.ibm.com, akpm@linux-foundation.org, mgorman@techsingularity.net, aarcange@redhat.com, amit.shah@redhat.com, pbonzini@redhat.com, wei.w.wang@intel.com, liliang.opensource@gmail.com
List-Id: virtualization@lists.linuxfoundation.org

This patch enables for_each_zone()/for_each_populated_zone() to be
invoked by a kernel module.

Signed-off-by: Wei Wang <wei.w.wang@intel.com>
---
 mm/mmzone.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/mm/mmzone.c b/mm/mmzone.c
index a51c0a6..08a2a3a 100644
--- a/mm/mmzone.c
+++ b/mm/mmzone.c
@@ -13,6 +13,7 @@ struct pglist_data *first_online_pgdat(void)
 {
 	return NODE_DATA(first_online_node);
 }
+EXPORT_SYMBOL_GPL(first_online_pgdat);
 
 struct pglist_data *next_online_pgdat(struct pglist_data *pgdat)
 {
@@ -41,6 +42,7 @@ struct zone *next_zone(struct zone *zone)
 	}
 	return zone;
 }
+EXPORT_SYMBOL_GPL(next_zone);
 
 static inline int zref_in_nodemask(struct zoneref *zref, nodemask_t *nodes)
 {
-- 
2.7.4
