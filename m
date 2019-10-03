From: Alexey Dobriyan <adobriyan@gmail.com>
Subject: [PATCH net-next] net, uapi: fix -Wpointer-arith warnings
Date: Thu, 3 Oct 2019 23:29:24 +0300
Message-ID: <20191003202924.GA21016__41203.9387317904$1570134579$gmane$org@avx2>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
Content-Disposition: inline
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/virtualization/>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: davem@davemloft.net
Cc: jon.maloy@ericsson.com, mst@redhat.com, netdev@vger.kernel.org, fw@strlen.de, kadlec@netfilter.org, netfilter-devel@vger.kernel.org, ying.xue@windriver.com, virtualization@lists.linux-foundation.org, pablo@netfilter.org
List-Id: virtualization@lists.linuxfoundation.org

Add casts to fix these warnings:

./usr/include/linux/netfilter_arp/arp_tables.h:200:19: error: pointer of type 'void *' used in arithmetic [-Werror=pointer-arith]
./usr/include/linux/netfilter_bridge/ebtables.h:197:19: error: pointer of type 'void *' used in arithmetic [-Werror=pointer-arith]
./usr/include/linux/netfilter_ipv4/ip_tables.h:223:19: error: pointer of type 'void *' used in arithmetic [-Werror=pointer-arith]
./usr/include/linux/netfilter_ipv6/ip6_tables.h:263:19: error: pointer of type 'void *' used in arithmetic [-Werror=pointer-arith]
./usr/include/linux/tipc_config.h:310:28: error: pointer of type 'void *' used in arithmetic [-Werror=pointer-arith]
./usr/include/linux/tipc_config.h:410:24: error: pointer of type 'void *' used in arithmetic [-Werror=pointer-arith]
./usr/include/linux/virtio_ring.h:170:16: error: pointer of type 'void *' used in arithmetic [-Werror=pointer-arith]

Those are theoretical probably but kernel doesn't control compiler flags
in userspace.

Signed-off-by: Alexey Dobriyan <adobriyan@gmail.com>
---

 include/uapi/linux/netfilter_arp/arp_tables.h  |    2 +-
 include/uapi/linux/netfilter_bridge/ebtables.h |    2 +-
 include/uapi/linux/netfilter_ipv4/ip_tables.h  |    2 +-
 include/uapi/linux/netfilter_ipv6/ip6_tables.h |    2 +-
 include/uapi/linux/tipc_config.h               |    4 ++--
 include/uapi/linux/virtio_ring.h               |    2 +-
 6 files changed, 7 insertions(+), 7 deletions(-)

--- a/include/uapi/linux/netfilter_arp/arp_tables.h
+++ b/include/uapi/linux/netfilter_arp/arp_tables.h
@@ -199,7 +199,7 @@ struct arpt_get_entries {
 /* Helper functions */
 static __inline__ struct xt_entry_target *arpt_get_target(struct arpt_entry *e)
 {
-	return (void *)e + e->target_offset;
+	return (struct xt_entry_target *)((char *)e + e->target_offset);
 }
 
 /*
--- a/include/uapi/linux/netfilter_bridge/ebtables.h
+++ b/include/uapi/linux/netfilter_bridge/ebtables.h
@@ -194,7 +194,7 @@ struct ebt_entry {
 static __inline__ struct ebt_entry_target *
 ebt_get_target(struct ebt_entry *e)
 {
-	return (void *)e + e->target_offset;
+	return (struct ebt_entry_target *)((char *)e + e->target_offset);
 }
 
 /* {g,s}etsockopt numbers */
--- a/include/uapi/linux/netfilter_ipv4/ip_tables.h
+++ b/include/uapi/linux/netfilter_ipv4/ip_tables.h
@@ -222,7 +222,7 @@ struct ipt_get_entries {
 static __inline__ struct xt_entry_target *
 ipt_get_target(struct ipt_entry *e)
 {
-	return (void *)e + e->target_offset;
+	return (struct xt_entry_target *)((char *)e + e->target_offset);
 }
 
 /*
--- a/include/uapi/linux/netfilter_ipv6/ip6_tables.h
+++ b/include/uapi/linux/netfilter_ipv6/ip6_tables.h
@@ -262,7 +262,7 @@ struct ip6t_get_entries {
 static __inline__ struct xt_entry_target *
 ip6t_get_target(struct ip6t_entry *e)
 {
-	return (void *)e + e->target_offset;
+	return (struct xt_entry_target *)((char *)e + e->target_offset);
 }
 
 /*
--- a/include/uapi/linux/tipc_config.h
+++ b/include/uapi/linux/tipc_config.h
@@ -309,7 +309,7 @@ static inline int TLV_SET(void *tlv, __u16 type, void *data, __u16 len)
 	tlv_ptr->tlv_len  = htons(tlv_len);
 	if (len && data) {
 		memcpy(TLV_DATA(tlv_ptr), data, len);
-		memset(TLV_DATA(tlv_ptr) + len, 0, TLV_SPACE(len) - tlv_len);
+		memset((char *)TLV_DATA(tlv_ptr) + len, 0, TLV_SPACE(len) - tlv_len);
 	}
 	return TLV_SPACE(len);
 }
@@ -409,7 +409,7 @@ static inline int TCM_SET(void *msg, __u16 cmd, __u16 flags,
 	tcm_hdr->tcm_flags = htons(flags);
 	if (data_len && data) {
 		memcpy(TCM_DATA(msg), data, data_len);
-		memset(TCM_DATA(msg) + data_len, 0, TCM_SPACE(data_len) - msg_len);
+		memset((char *)TCM_DATA(msg) + data_len, 0, TCM_SPACE(data_len) - msg_len);
 	}
 	return TCM_SPACE(data_len);
 }
--- a/include/uapi/linux/virtio_ring.h
+++ b/include/uapi/linux/virtio_ring.h
@@ -169,7 +169,7 @@ static inline void vring_init(struct vring *vr, unsigned int num, void *p,
 {
 	vr->num = num;
 	vr->desc = p;
-	vr->avail = p + num*sizeof(struct vring_desc);
+	vr->avail = (struct vring_avail *)((char *)p + num * sizeof(struct vring_desc));
 	vr->used = (void *)(((uintptr_t)&vr->avail->ring[num] + sizeof(__virtio16)
 		+ align-1) & ~(align - 1));
 }
