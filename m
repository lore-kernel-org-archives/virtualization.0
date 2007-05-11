From: Jeremy Fitzhardinge <jeremy@goop.org>
Subject: [patch 23/28]xen: rename xen netif_ structures to xen_netif_
Date: Thu, 10 May 2007 17:07:06 -0700
Message-ID: <20070511001207.097457000@goop.org>
References: <20070511000643.025196000@goop.org>
Return-path: <virtualization-bounces@lists.linux-foundation.org>
Content-Disposition: inline; filename=xen-netif-rename.patch
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/virtualization>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: Andi Kleen <ak@suse.de>
Cc: Chris Wright <chrisw@sous-sol.org>, virtualization@lists.osdl.org, Andrew Morton <akpm@linux-foundation.org>, Xen-devel <xen-devel@lists.xensource.com>, lkml <linux-kernel@vger.kernel.org>
List-Id: virtualization@lists.linuxfoundation.org

The "netif_" prefix is used in the Linux network stack, so rename the
Xen structures to xen_netif_ to avoid confusion (and potential
collision).

Signed-off-by: Jeremy Fitzhardinge <jeremy@xensource.com>
Signed-off-by: Chris Wright <chrisw@sous-sol.org>

---
 include/xen/interface/io/netif.h |   18 +++++++++++-------
 1 file changed, 11 insertions(+), 7 deletions(-)

===================================================================
--- a/include/xen/interface/io/netif.h
+++ b/include/xen/interface/io/netif.h
@@ -47,7 +47,7 @@
 #define _NETTXF_extra_info     (3)
 #define  NETTXF_extra_info     (1U<<_NETTXF_extra_info)
 
-struct netif_tx_request {
+struct xen_netif_tx_request {
     grant_ref_t gref;      /* Reference to buffer page */
     uint16_t offset;       /* Offset within buffer page */
     uint16_t flags;        /* NETTXF_* */
@@ -71,7 +71,7 @@ struct netif_tx_request {
  * This structure needs to fit within both netif_tx_request and
  * netif_rx_response for compatibility.
  */
-struct netif_extra_info {
+struct xen_netif_extra_info {
     uint8_t type;  /* XEN_NETIF_EXTRA_TYPE_* */
     uint8_t flags; /* XEN_NETIF_EXTRA_FLAG_* */
 
@@ -103,12 +103,12 @@ struct netif_extra_info {
     } u;
 };
 
-struct netif_tx_response {
+struct xen_netif_tx_response {
     uint16_t id;
     int16_t  status;       /* NETIF_RSP_* */
 };
 
-struct netif_rx_request {
+struct xen_netif_rx_request {
     uint16_t    id;        /* Echoed in response message.        */
     grant_ref_t gref;      /* Reference to incoming granted frame */
 };
@@ -129,7 +129,7 @@ struct netif_rx_request {
 #define _NETRXF_extra_info     (3)
 #define  NETRXF_extra_info     (1U<<_NETRXF_extra_info)
 
-struct netif_rx_response {
+struct xen_netif_rx_response {
     uint16_t id;
     uint16_t offset;       /* Offset in page of start of received packet  */
     uint16_t flags;        /* NETRXF_* */
@@ -140,8 +140,12 @@ struct netif_rx_response {
  * Generate netif ring structures and types.
  */
 
-DEFINE_RING_TYPES(netif_tx, struct netif_tx_request, struct netif_tx_response);
-DEFINE_RING_TYPES(netif_rx, struct netif_rx_request, struct netif_rx_response);
+DEFINE_RING_TYPES(xen_netif_tx,
+		  struct xen_netif_tx_request,
+		  struct xen_netif_tx_response);
+DEFINE_RING_TYPES(xen_netif_rx,
+		  struct xen_netif_rx_request,
+		  struct xen_netif_rx_response);
 
 #define NETIF_RSP_DROPPED         -2
 #define NETIF_RSP_ERROR           -1

-- 
