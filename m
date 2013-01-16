From: akong@redhat.com
Subject: [PATCH] virtio-spec: set mac address by a new vq command
Date: Wed, 16 Jan 2013 15:33:24 +0800
Message-ID: <1358321604-11712-1-git-send-email-akong@redhat.com>
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
To: virtualization@lists.linux-foundation.org, rusty@rustcorp.com.au
Cc: kvm@vger.kernel.org, mst@redhat.com
List-Id: virtualization@lists.linuxfoundation.org

From: Amos Kong <akong@redhat.com>

Virtio-net driver currently programs MAC address byte by byte,
this means that we have an intermediate step where mac is wrong.
This patch introduced a new control command to set MAC address
in one time, and added a new feature flag VIRTIO_NET_F_MAC_ADDR
for this feature.

Signed-off-by: Amos Kong <akong@redhat.com>
---
 virtio-spec.lyx | 45 ++++++++++++++++++++++++++++++++++++++++++++-
 1 file changed, 44 insertions(+), 1 deletion(-)

diff --git a/virtio-spec.lyx b/virtio-spec.lyx
index 1ba9992..03f5a49 100644
--- a/virtio-spec.lyx
+++ b/virtio-spec.lyx
@@ -56,6 +56,7 @@
 \html_math_output 0
 \html_css_as_file 0
 \html_be_strict false
+\author -1930653948 "Amos Kong" akong@redhat.com
 \author -608949062 "Rusty Russell,,," 
 \author -385801441 "Cornelia Huck" cornelia.huck@de.ibm.com
 \author 1112500848 "Rusty Russell" rusty@rustcorp.com.au
@@ -4391,6 +4392,14 @@ VIRTIO_NET_F_GUEST_ANNOUNCE(21) Guest can send gratuitous packets.
 
 \change_inserted 1986246365 1352742808
 VIRTIO_NET_F_MQ(22) Device supports multiqueue with automatic receive steering.
+\change_inserted -1930653948 1358319033
+
+\end_layout
+
+\begin_layout Description
+
+\change_inserted -1930653948 1358319080
+VIRTIO_NET_F_CTRL_MAC_ADDR(23) Set MAC address.
 \change_unchanged
 
 \end_layout
@@ -5284,7 +5293,11 @@ The class VIRTIO_NET_CTRL_RX has two commands: VIRTIO_NET_CTRL_RX_PROMISC
 \end_layout
 
 \begin_layout Subsubsection*
-Setting MAC Address Filtering
+Setting MAC Address
+\change_deleted -1930653948 1358318470
+ Filtering
+\change_unchanged
+
 \end_layout
 
 \begin_layout Standard
@@ -5324,6 +5337,17 @@ struct virtio_net_ctrl_mac {
 \begin_layout Plain Layout
 
  #define VIRTIO_NET_CTRL_MAC_TABLE_SET        0 
+\change_inserted -1930653948 1358318313
+
+\end_layout
+
+\begin_layout Plain Layout
+
+\change_inserted -1930653948 1358318331
+
+ #define VIRTIO_NET_CTRL_MAC_ADDR_SET         1
+\change_unchanged
+
 \end_layout
 
 \end_inset
@@ -5349,6 +5373,25 @@ T_CTRL_MAC_TABLE_SET.
  The command-specific-data is two variable length tables of 6-byte MAC addresses.
  The first table contains unicast addresses, and the second contains multicast
  addresses.
+\change_inserted -1930653948 1358318545
+
+\end_layout
+
+\begin_layout Standard
+
+\change_inserted -1930653948 1358320004
+The command VIRTIO_NET_CTRL_MAC_ADDR_SET is used to set 
+\begin_inset Quotes eld
+\end_inset
+
+physical
+\begin_inset Quotes erd
+\end_inset
+
+ address of the network card.
+ The command-specific-data is a 6-byte MAC address.
+\change_unchanged
+
 \end_layout
 
 \begin_layout Subsection*
-- 
1.7.11.7
