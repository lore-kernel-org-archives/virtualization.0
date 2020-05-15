From: David Hildenbrand <david@redhat.com>
Subject: [PATCH v4 16/15] virtio-mem: Don't rely on implicit compiler padding for requests
Date: Fri, 15 May 2020 12:14:02 +0200
Message-ID: <20200515101402.16597-1-david@redhat.com>
References: <20200507140139.17083-1-david@redhat.com>
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20200507140139.17083-1-david@redhat.com>
Sender: linux-kernel-owner@vger.kernel.org
To: linux-kernel@vger.kernel.org
Cc: linux-mm@kvack.org, virtio-dev@lists.oasis-open.org, virtualization@lists.linux-foundation.org, kvm@vger.kernel.org, Michal Hocko <mhocko@kernel.org>, Andrew Morton <akpm@linux-foundation.org>, "Michael S . Tsirkin" <mst@redhat.com>, David Hildenbrand <david@redhat.com>, Pankaj Gupta <pankaj.gupta.linux@gmail.com>, teawater <teawaterz@linux.alibaba.com>
List-Id: virtualization@lists.linuxfoundation.org

The compiler will add padding after the last member, make that explicit.
The size of a request is always 24 bytes. The size of a response always
10 bytes. Add compile-time checks.

Cc: "Michael S. Tsirkin" <mst@redhat.com>
Cc: Pankaj Gupta <pankaj.gupta.linux@gmail.com>
Cc: teawater <teawaterz@linux.alibaba.com>
Signed-off-by: David Hildenbrand <david@redhat.com>
---

Something I noticed while working on the spec (which proves that writing a
virtio-spec makes sense :) ).

---
 drivers/virtio/virtio_mem.c     | 3 +++
 include/uapi/linux/virtio_mem.h | 3 +++
 2 files changed, 6 insertions(+)

diff --git a/drivers/virtio/virtio_mem.c b/drivers/virtio/virtio_mem.c
index 9e523db3bee1..f658fe9149be 100644
--- a/drivers/virtio/virtio_mem.c
+++ b/drivers/virtio/virtio_mem.c
@@ -1770,6 +1770,9 @@ static int virtio_mem_probe(struct virtio_device *vdev)
 	struct virtio_mem *vm;
 	int rc = -EINVAL;
 
+	BUILD_BUG_ON(sizeof(struct virtio_mem_req) != 24);
+	BUILD_BUG_ON(sizeof(struct virtio_mem_resp) != 10);
+
 	vdev->priv = vm = kzalloc(sizeof(*vm), GFP_KERNEL);
 	if (!vm)
 		return -ENOMEM;
diff --git a/include/uapi/linux/virtio_mem.h b/include/uapi/linux/virtio_mem.h
index e0a9dc7397c3..a455c488a995 100644
--- a/include/uapi/linux/virtio_mem.h
+++ b/include/uapi/linux/virtio_mem.h
@@ -103,16 +103,19 @@
 struct virtio_mem_req_plug {
 	__virtio64 addr;
 	__virtio16 nb_blocks;
+	__virtio16 padding[3];
 };
 
 struct virtio_mem_req_unplug {
 	__virtio64 addr;
 	__virtio16 nb_blocks;
+	__virtio16 padding[3];
 };
 
 struct virtio_mem_req_state {
 	__virtio64 addr;
 	__virtio16 nb_blocks;
+	__virtio16 padding[3];
 };
 
 struct virtio_mem_req {
-- 
2.25.4
