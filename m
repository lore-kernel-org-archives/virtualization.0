From: akong@redhat.com
Subject: [PATCH] virtio-spec: fix two typos
Date: Wed,  9 Jan 2013 15:55:23 +0800
Message-ID: <1357718123-9274-1-git-send-email-akong@redhat.com>
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
To: rusty@rustcorp.com.au, virtualization@lists.linux-foundation.org
Cc: kvm@vger.kernel.org
List-Id: virtualization@lists.linuxfoundation.org

From: Amos Kong <akong@redhat.com>

VIRTIO_NET_F_VTRL_VQ -> VIRTIO_NET_F_CTRL_VQ
VIRTIO_NET_CTRL_MQ is defined to 4 in kernel code

Signed-off-by: Amos Kong <akong@redhat.com>
---
 virtio-spec.lyx | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/virtio-spec.lyx b/virtio-spec.lyx
index 78ec5d0..1ba9992 100644
--- a/virtio-spec.lyx
+++ b/virtio-spec.lyx
@@ -5156,7 +5156,7 @@ Control Virtqueue
 \end_layout
 
 \begin_layout Standard
-The driver uses the control virtqueue (if VIRTIO_NET_F_VTRL_VQ is negotiated)
+The driver uses the control virtqueue (if VIRTIO_NET_F_CTRL_VQ is negotiated)
  to send commands to manipulate various features of the device which would
  not easily map into the configuration space.
 \end_layout
@@ -5501,7 +5501,7 @@ struct virtio_net_ctrl_mq {
 
 \change_inserted 1986246365 1353594263
 
-#define VIRTIO_NET_CTRL_MQ    1
+#define VIRTIO_NET_CTRL_MQ    4
 \end_layout
 
 \begin_layout Plain Layout
-- 
1.7.11.7
