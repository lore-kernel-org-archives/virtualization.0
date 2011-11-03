From: Sasha Levin <levinsasha928@gmail.com>
Subject: [PATCH] virtio-balloon: Trivial cleanups
Date: Thu,  3 Nov 2011 10:20:04 +0200
Message-ID: <1320308404-28859-1-git-send-email-levinsasha928@gmail.com>
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
To: linux-kernel@vger.kernel.org
Cc: virtualization@lists.linux-foundation.org, Sasha Levin <levinsasha928@gmail.com>, "Michael S. Tsirkin" <mst@redhat.com>
List-Id: virtualization@lists.linuxfoundation.org

Trivial changes to remove forgotten junk, format comments, and correct names.

Cc: Rusty Russell <rusty@rustcorp.com.au>
Cc: "Michael S. Tsirkin" <mst@redhat.com>
Cc: virtualization@lists.linux-foundation.org
Signed-off-by: Sasha Levin <levinsasha928@gmail.com>
---
 drivers/virtio/virtio_balloon.c |    6 +++---
 1 files changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/virtio/virtio_balloon.c b/drivers/virtio/virtio_balloon.c
index e058ace..289e998 100644
--- a/drivers/virtio/virtio_balloon.c
+++ b/drivers/virtio/virtio_balloon.c
@@ -1,4 +1,5 @@
-/* Virtio balloon implementation, inspired by Dor Loar and Marcelo
+/*
+ * Virtio balloon implementation, inspired by Dor Laor and Marcelo
  * Tosatti's implementations.
  *
  *  Copyright 2008 Rusty Russell IBM Corporation
@@ -17,7 +18,7 @@
  *  along with this program; if not, write to the Free Software
  *  Foundation, Inc., 51 Franklin St, Fifth Floor, Boston, MA  02110-1301  USA
  */
-//#define DEBUG
+
 #include <linux/virtio.h>
 #include <linux/virtio_balloon.h>
 #include <linux/swap.h>
@@ -148,7 +149,6 @@ static void leak_balloon(struct virtio_balloon *vb, size_t num)
 		vb->num_pages--;
 	}
 
-
 	/*
 	 * Note that if
 	 * virtio_has_feature(vdev, VIRTIO_BALLOON_F_MUST_TELL_HOST);
-- 
1.7.7.1
