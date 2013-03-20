From: Rusty Russell <rusty@rustcorp.com.au>
Subject: Re: [PATCH 20/22] 9p/trans_virtio.c: use virtio_add_sgs[]
Date: Wed, 20 Mar 2013 15:23:23 +1030
Message-ID: <87obeept8c.fsf@rustcorp.com.au>
References: <1363599293-23065-1-git-send-email-rusty@rustcorp.com.au>
	<1363599293-23065-21-git-send-email-rusty@rustcorp.com.au>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <1363599293-23065-21-git-send-email-rusty@rustcorp.com.au>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/virtualization/>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: virtualization@lists.linux-foundation.org
Cc: Eric Van Hensbergen <ericvh@gmail.com>
List-Id: virtualization@lists.linuxfoundation.org

Rusty Russell <rusty@rustcorp.com.au> writes:
> virtio_add_buf() is going away, replaced with virtio_add_sgs() which
> takes multiple terminated scatterlists.
>
> Cc: Eric Van Hensbergen <ericvh@gmail.com>
> Signed-off-by: Rusty Russell <rusty@rustcorp.com.au>

This one was buggy.  Testing and reading the patch do wonderful things.

Cheers,
Rusty.

9p/trans_virtio.c: use virtio_add_sgs[]

virtio_add_buf() is going away, replaced with virtio_add_sgs() which
takes multiple terminated scatterlists.

Cc: Eric Van Hensbergen <ericvh@gmail.com>
Signed-off-by: Rusty Russell <rusty@rustcorp.com.au>

diff --git a/net/9p/trans_virtio.c b/net/9p/trans_virtio.c
index de2e950..e29d72e 100644
--- a/net/9p/trans_virtio.c
+++ b/net/9p/trans_virtio.c
@@ -194,11 +194,14 @@ static int pack_sg_list(struct scatterlist *sg, int start,
 		if (s > count)
 			s = count;
 		BUG_ON(index > limit);
+		/* Make sure we don't terminate early. */
+		sg_unmark_end(&sg[index]);
 		sg_set_buf(&sg[index++], data, s);
 		count -= s;
 		data += s;
 	}
-
+	if (index-start)
+		sg_mark_end(&sg[index - 1]);
 	return index-start;
 }
 
@@ -236,12 +239,17 @@ pack_sg_list_p(struct scatterlist *sg, int start, int limit,
 		s = rest_of_page(data);
 		if (s > count)
 			s = count;
+		/* Make sure we don't terminate early. */
+		sg_unmark_end(&sg[index]);
 		sg_set_page(&sg[index++], pdata[i++], s, data_off);
 		data_off = 0;
 		data += s;
 		count -= s;
 		nr_pages--;
 	}
+
+	if (index-start)
+		sg_mark_end(&sg[index - 1]);
 	return index - start;
 }
 
@@ -256,9 +264,10 @@ static int
 p9_virtio_request(struct p9_client *client, struct p9_req_t *req)
 {
 	int err;
-	int in, out;
+	int in, out, out_sgs, in_sgs;
 	unsigned long flags;
 	struct virtio_chan *chan = client->trans;
+	struct scatterlist *sgs[2];
 
 	p9_debug(P9_DEBUG_TRANS, "9p debug: virtio request\n");
 
@@ -266,15 +275,20 @@ p9_virtio_request(struct p9_client *client, struct p9_req_t *req)
 req_retry:
 	spin_lock_irqsave(&chan->lock, flags);
 
+	out_sgs = in_sgs = 0;
 	/* Handle out VirtIO ring buffers */
 	out = pack_sg_list(chan->sg, 0,
 			   VIRTQUEUE_NUM, req->tc->sdata, req->tc->size);
+	if (out)
+		sgs[out_sgs++] = chan->sg;
 
 	in = pack_sg_list(chan->sg, out,
 			  VIRTQUEUE_NUM, req->rc->sdata, req->rc->capacity);
+	if (in)
+		sgs[out_sgs + in_sgs++] = chan->sg + out;
 
-	err = virtqueue_add_buf(chan->vq, chan->sg, out, in, req->tc,
+	err = virtqueue_add_sgs(chan->vq, sgs, out_sgs, in_sgs, req->tc,
 				GFP_ATOMIC);
 	if (err < 0) {
 		if (err == -ENOSPC) {
 			chan->ring_bufs_avail = 0;
@@ -289,7 +304,7 @@ req_retry:
 		} else {
 			spin_unlock_irqrestore(&chan->lock, flags);
 			p9_debug(P9_DEBUG_TRANS,
-				 "virtio rpc add_buf returned failure\n");
+				 "virtio rpc add_sgs returned failure\n");
 			return -EIO;
 		}
 	}
@@ -351,11 +366,12 @@ p9_virtio_zc_request(struct p9_client *client, struct p9_req_t *req,
 		     char *uidata, char *uodata, int inlen,
 		     int outlen, int in_hdr_len, int kern_buf)
 {
-	int in, out, err;
+	int in, out, err, out_sgs, in_sgs;
 	unsigned long flags;
 	int in_nr_pages = 0, out_nr_pages = 0;
 	struct page **in_pages = NULL, **out_pages = NULL;
 	struct virtio_chan *chan = client->trans;
+	struct scatterlist *sgs[4];
 
 	p9_debug(P9_DEBUG_TRANS, "virtio request\n");
 
@@ -396,13 +412,22 @@ p9_virtio_zc_request(struct p9_client *client, struct p9_req_t *req,
 	req->status = REQ_STATUS_SENT;
 req_retry_pinned:
 	spin_lock_irqsave(&chan->lock, flags);
+
+	out_sgs = in_sgs = 0;
+
 	/* out data */
 	out = pack_sg_list(chan->sg, 0,
 			   VIRTQUEUE_NUM, req->tc->sdata, req->tc->size);
 
-	if (out_pages)
+	if (out)
+		sgs[out_sgs++] = chan->sg;
+
+	if (out_pages) {
+		sgs[out_sgs++] = chan->sg + out;
 		out += pack_sg_list_p(chan->sg, out, VIRTQUEUE_NUM,
 				      out_pages, out_nr_pages, uodata, outlen);
+	}
+		
 	/*
 	 * Take care of in data
 	 * For example TREAD have 11.
@@ -412,11 +437,17 @@ req_retry_pinned:
 	 */
 	in = pack_sg_list(chan->sg, out,
 			  VIRTQUEUE_NUM, req->rc->sdata, in_hdr_len);
-	if (in_pages)
+	if (in)
+		sgs[out_sgs + in_sgs++] = chan->sg + out;
+
+	if (in_pages) {
+		sgs[out_sgs + in_sgs++] = chan->sg + out + in;
 		in += pack_sg_list_p(chan->sg, out + in, VIRTQUEUE_NUM,
 				     in_pages, in_nr_pages, uidata, inlen);
+	}
 
-	err = virtqueue_add_buf(chan->vq, chan->sg, out, in, req->tc,
+	BUG_ON(out_sgs + in_sgs > ARRAY_SIZE(sgs));
+	err = virtqueue_add_sgs(chan->vq, sgs, out_sgs, in_sgs, req->tc,
 				GFP_ATOMIC);
 	if (err < 0) {
 		if (err == -ENOSPC) {
@@ -432,7 +463,7 @@ req_retry_pinned:
 		} else {
 			spin_unlock_irqrestore(&chan->lock, flags);
 			p9_debug(P9_DEBUG_TRANS,
-				 "virtio rpc add_buf returned failure\n");
+				 "virtio rpc add_sgs returned failure\n");
 			err = -EIO;
 			goto err_out;
 		}
