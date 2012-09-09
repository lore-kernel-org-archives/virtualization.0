From: "Michael S. Tsirkin" <mst@redhat.com>
Subject: [PATCH] virtio-spec: serial: english tweak
Date: Sun, 9 Sep 2012 15:11:17 +0300
Message-ID: <20120909121116.GA2972@redhat.com>
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
To: virtualization@lists.linux-foundation.org, Amit Shah <amit.shah@redhat.com>
List-Id: virtualization@lists.linuxfoundation.org

"A number of virtqueues are created" seems clearer
than "the number of virtqueues": it's
virtqueues that are created not the number.

Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
---

I'm not a native english speaker but the below
seems correct to me. Rusty?

 virtio-spec.lyx | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/virtio-spec.lyx b/virtio-spec.lyx
index d9626a9..a29315c 100644
--- a/virtio-spec.lyx
+++ b/virtio-spec.lyx
@@ -6406,7 +6406,7 @@ If the VIRTIO_CONSOLE_F_MULTIPORT feature is negotiated, the driver can
  spawn multiple ports, not all of which may be attached to a console.
  Some could be generic ports.
  In this case, the control virtqueues are enabled and according to the max_nr_po
-rts configuration-space value, the appropriate number of virtqueues are
+rts configuration-space value, an appropriate number of virtqueues are
  created.
  A control message indicating the driver is ready is sent to the host.
  The host can then send control messages for adding new ports to the device.
-- 
MST
