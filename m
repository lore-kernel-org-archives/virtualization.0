From: Takuma Umeya <tumeya@redhat.com>
Subject: [PATCH] virtio_blk: decrement index when blockdevice is removed
Date: Tue, 5 Apr 2011 00:49:41 -0400 (EDT)
Message-ID: <1969774563.659835.1301978981017.JavaMail.root__37502.0178304569$1301979453$gmane$org@zmail07.collab.prod.int.phx2.redhat.com>
References: <1099995365.641718.1301903899721.JavaMail.root@zmail07.collab.prod.int.phx2.redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <1099995365.641718.1301903899721.JavaMail.root@zmail07.collab.prod.int.phx2.redhat.com>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/virtualization>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: virtualization@lists.linux-foundation.org
Cc: john cooper <john.cooper@redhat.com>, Jens Axboe <jaxboe@fusionio.com>, linux-kernel@vger.kernel.org, Tejun Heo <tj@kernel.org>, Christoph Hellwig <hch@lst.de>
List-Id: virtualization@lists.linuxfoundation.org

When virtio block device is removed, index does not get decremented. When 
another virtio disk is attached it uses the next device letter to the 
one that is suppose to be available. 

Signed-off-by: Takuma Umeya <tumeya@redhat.com>

diff --git a/drivers/block/virtio_blk.c b/drivers/block/virtio_blk.c
index 6ecf89c..730e7af 100644
--- a/drivers/block/virtio_blk.c
+++ b/drivers/block/virtio_blk.c
@@ -489,6 +489,7 @@ static void __devexit virtblk_remove(struct virtio_device *vdev)
        mempool_destroy(vblk->pool);
        vdev->config->del_vqs(vdev);
        kfree(vblk);
+       index--;
 }
 
 static const struct virtio_device_id id_table[] = {

-- 
Umeya, Takuma
Technical Account Manager
Red Hat GSS APAC
+81.3.5798.8584 (direct)
tumeya@redhat.com
