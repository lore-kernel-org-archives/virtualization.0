From: Jason Wang <jasowang@redhat.com>
Subject: [PATCH] virtio-spec: fix typo
Date: Thu, 22 Mar 2012 17:46:47 +0800
Message-ID: <20120322094647.26280.72051.stgit@jason-ThinkPad-T400>
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
To: rusty@rustcorp.com.au, virtualization@lists.linux-foundation.org, linux-kernel@vger.kernel.org, mst@redhat.com
List-Id: virtualization@lists.linuxfoundation.org

Signed-off-by: Jason Wang <jasowang@redhat.com>
---
 virtio-0.9.4.lyx |   12 +++++++++---
 1 files changed, 9 insertions(+), 3 deletions(-)

diff --git a/virtio-0.9.4.lyx b/virtio-0.9.4.lyx
index 6c7bab1..9d30977 100644
--- a/virtio-0.9.4.lyx
+++ b/virtio-0.9.4.lyx
@@ -58,6 +58,7 @@
 \html_be_strict false
 \author -608949062 "Rusty Russell,,," 
 \author 1531152142 "pbonzini" 
+\author 2090695081 "Jason" 
 \end_header
 
 \begin_body
@@ -4657,9 +4658,14 @@ Control Virtqueue
 \end_layout
 
 \begin_layout Standard
-The driver uses the control virtqueue (if VIRTIO_NET_F_VTRL_VQ is negotiated)
- to send commands to manipulate various features of the device which would
- not easily map into the configuration space.
+The driver uses the control virtqueue (if VIRTIO_NET_F_
+\change_inserted 2090695081 1332409259
+C
+\change_deleted 2090695081 1332409259
+V
+\change_unchanged
+TRL_VQ is negotiated) to send commands to manipulate various features of
+ the device which would not easily map into the configuration space.
 \end_layout
 
 \begin_layout Standard
