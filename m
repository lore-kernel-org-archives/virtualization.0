From: "Michael S. Tsirkin" <mst@redhat.com>
Subject: [PATCH 3/3] mic/host: initial virtio 1.0 support
Date: Mon, 15 Dec 2014 23:14:08 +0200
Message-ID: <1418678019-31629-4-git-send-email-mst@redhat.com>
References: <1418678019-31629-1-git-send-email-mst@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
Content-Disposition: inline
In-Reply-To: <1418678019-31629-1-git-send-email-mst@redhat.com>
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
Cc: virtualization@lists.linux-foundation.org
List-Id: virtualization@lists.linuxfoundation.org

This just makes code sparse-clean.
The new feature bit is not yet negotiated.

Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
---
 drivers/misc/mic/host/mic_debugfs.c | 18 ++++++++++++------
 1 file changed, 12 insertions(+), 6 deletions(-)

diff --git a/drivers/misc/mic/host/mic_debugfs.c b/drivers/misc/mic/host/mic_debugfs.c
index 028ba5d6..687e9aa 100644
--- a/drivers/misc/mic/host/mic_debugfs.c
+++ b/drivers/misc/mic/host/mic_debugfs.c
@@ -326,21 +326,27 @@ static int mic_vdev_info_show(struct seq_file *s, void *unused)
 			}
 			avail = vrh->vring.avail;
 			seq_printf(s, "avail flags 0x%x idx %d\n",
-				   avail->flags, avail->idx & (num - 1));
+				   vringh16_to_cpu(vrh, avail->flags),
+				   vringh16_to_cpu(vrh, avail->idx) & (num - 1));
 			seq_printf(s, "avail flags 0x%x idx %d\n",
-				   avail->flags, avail->idx);
+				   vringh16_to_cpu(vrh, avail->flags),
+				   vringh16_to_cpu(vrh, avail->idx));
 			for (j = 0; j < num; j++)
 				seq_printf(s, "avail ring[%d] %d\n",
 					   j, avail->ring[j]);
 			used = vrh->vring.used;
 			seq_printf(s, "used flags 0x%x idx %d\n",
-				   used->flags, used->idx & (num - 1));
+				   vringh16_to_cpu(vrh, used->flags),
+				   vringh16_to_cpu(vrh, used->idx) & (num - 1));
 			seq_printf(s, "used flags 0x%x idx %d\n",
-				   used->flags, used->idx);
+				   vringh16_to_cpu(vrh, used->flags),
+				   vringh16_to_cpu(vrh, used->idx));
 			for (j = 0; j < num; j++)
 				seq_printf(s, "used ring[%d] id %d len %d\n",
-					   j, used->ring[j].id,
-					   used->ring[j].len);
+					   j, vringh32_to_cpu(vrh,
+							      used->ring[j].id),
+					   vringh32_to_cpu(vrh,
+							   used->ring[j].len));
 		}
 	}
 	mutex_unlock(&mdev->mic_mutex);
-- 
MST
