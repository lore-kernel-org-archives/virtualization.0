From: Rusty Russell <rusty@rustcorp.com.au>
Subject: [PATCH] virtio: pass baton to Michael Tsirkin
Date: Sat, 02 May 2015 08:42:38 +0930
Message-ID: <87h9rv3na1.fsf__37884.0678524741$1430522042$gmane$org@rustcorp.com.au>
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
To: "Michael S. Tsirkin" <mst@redhat.com>, Linus Torvalds <torvalds@linux-foundation.org>
Cc: LKML <linux-kernel@vger.kernel.org>, virtualization@lists.linux-foundation.org
List-Id: virtualization@lists.linuxfoundation.org

With my job change kernel work will be "own time"; I'm keeping lguest
and modules (and the virtio standards work), but virtio kernel has to
go.

This makes it clear that Michael is in charge.  He's good, but having
me watch over his shoulder won't help.

Good luck Michael!

Signed-off-by: Rusty Russell <rusty@rustcorp.com.au>

diff --git a/MAINTAINERS b/MAINTAINERS
index 2e5bbc0d68b2..16227759dfa8 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -10523,7 +10523,6 @@ F:	include/linux/virtio_console.h
 F:	include/uapi/linux/virtio_console.h
 
 VIRTIO CORE, NET AND BLOCK DRIVERS
-M:	Rusty Russell <rusty@rustcorp.com.au>
 M:	"Michael S. Tsirkin" <mst@redhat.com>
 L:	virtualization@lists.linux-foundation.org
 S:	Maintained
