From: Dan Carpenter <dan.carpenter@oracle.com>
Subject: [PATCH] vhost_vdpa: Fix potential underflow in vhost_vdpa_mmap()
Date: Wed, 10 Jun 2020 11:58:52 +0300
Message-ID: <20200610085852.GB5439@mwanda>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <kvm-owner@vger.kernel.org>
Content-Disposition: inline
Sender: kvm-owner@vger.kernel.org
To: "Michael S. Tsirkin" <mst@redhat.com>, Jason Wang <jasowang@redhat.com>
Cc: kvm@vger.kernel.org, virtualization@lists.linux-foundation.org, kernel-janitors@vger.kernel.org
List-Id: virtualization@lists.linuxfoundation.org

The "vma->vm_pgoff" variable is an unsigned long so if it's larger than
INT_MAX then "index" can be negative leading to an underflow.  Fix this
by changing the type of "index" to "unsigned long".

Fixes: ddd89d0a059d ("vhost_vdpa: support doorbell mapping via mmap")
Signed-off-by: Dan Carpenter <dan.carpenter@oracle.com>
---
 drivers/vhost/vdpa.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/vhost/vdpa.c b/drivers/vhost/vdpa.c
index 7580e34f76c10..a54b60d6623f0 100644
--- a/drivers/vhost/vdpa.c
+++ b/drivers/vhost/vdpa.c
@@ -818,7 +818,7 @@ static int vhost_vdpa_mmap(struct file *file, struct vm_area_struct *vma)
 	struct vdpa_device *vdpa = v->vdpa;
 	const struct vdpa_config_ops *ops = vdpa->config;
 	struct vdpa_notification_area notify;
-	int index = vma->vm_pgoff;
+	unsigned long index = vma->vm_pgoff;
 
 	if (vma->vm_end - vma->vm_start != PAGE_SIZE)
 		return -EINVAL;
-- 
2.26.2
