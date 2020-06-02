From: "Michael S. Tsirkin" <mst@redhat.com>
Subject: [PATCH RFC 04/13] vhost: cleanup fetch_buf return code handling
Date: Tue, 2 Jun 2020 09:06:03 -0400
Message-ID: <20200602130543.578420-5-mst@redhat.com>
References: <20200602130543.578420-1-mst@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <20200602130543.578420-1-mst@redhat.com>
Content-Disposition: inline
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/virtualization>,
 <mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/virtualization/>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/virtualization>,
 <mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Errors-To: virtualization-bounces@lists.linux-foundation.org
Sender: "Virtualization" <virtualization-bounces@lists.linux-foundation.org>
To: linux-kernel@vger.kernel.org
Cc: Eugenio =?utf-8?B?UMOpcmV6?= <eperezma@redhat.com>, netdev@vger.kernel.org, kvm@vger.kernel.org, virtualization@lists.linux-foundation.org
List-Id: virtualization@lists.linuxfoundation.org

Return code of fetch_buf is confusing, so callers resort to
tricks to get to sane values. Let's switch to something standard:
0 empty, >0 non-empty, <0 error.

Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
---
 drivers/vhost/vhost.c | 24 ++++++++++++++++--------
 1 file changed, 16 insertions(+), 8 deletions(-)

diff --git a/drivers/vhost/vhost.c b/drivers/vhost/vhost.c
index aca2a5b0d078..bd52b44b0d23 100644
--- a/drivers/vhost/vhost.c
+++ b/drivers/vhost/vhost.c
@@ -2146,6 +2146,8 @@ static int fetch_indirect_descs(struct vhost_virtqueue *vq,
 	return 0;
 }
 
+/* This function returns a value > 0 if a descriptor was found, or 0 if none were found.
+ * A negative code is returned on error. */
 static int fetch_buf(struct vhost_virtqueue *vq)
 {
 	unsigned int i, head, found = 0;
@@ -2162,7 +2164,7 @@ static int fetch_buf(struct vhost_virtqueue *vq)
 	if (unlikely(vq->avail_idx == vq->last_avail_idx)) {
 		/* If we already have work to do, don't bother re-checking. */
 		if (likely(vq->ndescs))
-			return vq->num;
+			return 0;
 
 		if (unlikely(vhost_get_avail_idx(vq, &avail_idx))) {
 			vq_err(vq, "Failed to access avail idx at %p\n",
@@ -2181,7 +2183,7 @@ static int fetch_buf(struct vhost_virtqueue *vq)
 		 * invalid.
 		 */
 		if (vq->avail_idx == last_avail_idx)
-			return vq->num;
+			return 0;
 
 		/* Only get avail ring entries after they have been
 		 * exposed by guest.
@@ -2251,12 +2253,14 @@ static int fetch_buf(struct vhost_virtqueue *vq)
 	/* On success, increment avail index. */
 	vq->last_avail_idx++;
 
-	return 0;
+	return 1;
 }
 
+/* This function returns a value > 0 if a descriptor was found, or 0 if none were found.
+ * A negative code is returned on error. */
 static int fetch_descs(struct vhost_virtqueue *vq)
 {
-	int ret = 0;
+	int ret;
 
 	if (unlikely(vq->first_desc >= vq->ndescs)) {
 		vq->first_desc = 0;
@@ -2266,10 +2270,14 @@ static int fetch_descs(struct vhost_virtqueue *vq)
 	if (vq->ndescs)
 		return 0;
 
-	while (!ret && vq->ndescs <= vhost_vq_num_batch_descs(vq))
-		ret = fetch_buf(vq);
+	for (ret = 1;
+	     ret > 0 && vq->ndescs <= vhost_vq_num_batch_descs(vq);
+	     ret = fetch_buf(vq))
+		;
 
-	return vq->ndescs ? 0 : ret;
+	/* On success we expect some descs */
+	BUG_ON(ret > 0 && !vq->ndescs);
+	return ret;
 }
 
 /* This looks in the virtqueue and for the first available buffer, and converts
@@ -2288,7 +2296,7 @@ int vhost_get_vq_desc(struct vhost_virtqueue *vq,
 	int ret = fetch_descs(vq);
 	int i;
 
-	if (ret)
+	if (ret <= 0)
 		return ret;
 
 	/* Now convert to IOV */
-- 
MST
