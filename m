From: Jason Yan <yanaijie@huawei.com>
Subject: [PATCH] virtio-balloon: make virtballoon_free_page_report() static
Date: Thu, 9 Apr 2020 16:50:47 +0800
Message-ID: <20200409085047.45483-1-yanaijie@huawei.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: mst@redhat.com, jasowang@redhat.com, virtualization@lists.linux-foundation.org, linux-kernel@vger.kernel.org
Cc: Jason Yan <yanaijie@huawei.com>
List-Id: virtualization@lists.linuxfoundation.org

Fix the following sparse warning:

drivers/virtio/virtio_balloon.c:168:5: warning: symbol
'virtballoon_free_page_report' was not declared. Should it be static?

Reported-by: Hulk Robot <hulkci@huawei.com>
Signed-off-by: Jason Yan <yanaijie@huawei.com>
---
 drivers/virtio/virtio_balloon.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/virtio/virtio_balloon.c b/drivers/virtio/virtio_balloon.c
index 0ef16566c3f3..8c964b3eebdf 100644
--- a/drivers/virtio/virtio_balloon.c
+++ b/drivers/virtio/virtio_balloon.c
@@ -165,7 +165,7 @@ static void tell_host(struct virtio_balloon *vb, struct virtqueue *vq)
 
 }
 
-int virtballoon_free_page_report(struct page_reporting_dev_info *pr_dev_info,
+static int virtballoon_free_page_report(struct page_reporting_dev_info *pr_dev_info,
 				   struct scatterlist *sg, unsigned int nents)
 {
 	struct virtio_balloon *vb =
-- 
2.17.2
