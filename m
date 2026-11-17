Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=124.126.103.232
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794917961;
	b=QbOy5mEpu0OrdQOIATX+zYMZZZbp8Q3o0XM30G9VL0nQT3X9pomkgrYoBYIbgydv/W3d
	 2BXD6F7Ple9cSH0v/eTV8AZQp/m4PhDT0SPOC+uXLOglFbMgaXYd6ecPuLLEU7nJJjWQq
	 gEBp/wgeAXIS0bsG9eI/Ne0nm6m6cJn/OtXQNP738d24TZfHyq3+civb+zesocqn+3/CG
	 C5H643AeHnNd6xxoOJ1tDpPxaKi2qpNdr8YuOtV5FSYX0ATUQibzbPWT4W/p6FP5JHTNJ
	 UQNGl1WTGJlrJq7O6euiVUkIN3bJxTsALG9OyglOg+5N4ss7kFP43TFM7/w60dcW8Ew==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794917961;
	h=DMARC-Filter:X-UUID:X-CID-P-RULE:X-CID-O-INFO:X-CID-META:X-CID-BVR:
	 X-CID-BAS:X-CID-FACTOR:X-CID-RHF:X-UUID:X-User:Received:Message-ID:
	 Date:MIME-Version:User-Agent:Subject:To:Cc:References:
	 Content-Language:From:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding;
	bh=9Qo5HED32HMIac07kWLfa/dQnNfHE6QDn+AhMsssE8w=;
	b=ZbaEuc9+2xR/7QEVloB4kDtgiOXTcL+SpnrQs3tSoDbcB4sfOX7Cl/u5REYz9oSe7Ita
	 tXgvP4H5X1jQTrH1x/IZQckmFYCa29o7qQSeBRGFdvdT7HNjUSgf7oLFBLY7JgLO80SUl
	 6DOV3pOudUpEAua57mggilfdyUOqgRhdHuApET2+NhhpLX5+D6LKeJdX1hxdpUWn8qBLM
	 ObvYcrC0+bHd+YgpZVgXxCrU+lgY4a6HOinU4GWHa5/Q8P14re9Kal/A8Mty2CeMRjUTL
	 c/oi08ZD4BEeE+6R/6Bw4vHsEapbFHOIYalhjVwm+epuIg6OZIsacDE4F3hQaJNs0aA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=none header.from=kylinos.cn;
	spf=pass smtp.mailfrom=kylinos.cn;
	arc=none smtp.remote-ip=124.126.103.232
Received: from mailgw.kylinos.cn (mailgw.kylinos.cn [124.126.103.232])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 48C97606A31C;
	Tue, 17 Nov 2026 12:19:18 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 48C97606A31C
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kylinos.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kylinos.cn
X-UUID: 17d328e0e28111f19a56ed5b684f684d-20261117
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.3.19,REQID:c2d38929-4bc9-4092-a310-5fe27e8b968a,IP:0,U
	RL:0,TC:0,Content:0,EDM:0,RT:0,SF:0,FILE:0,BULK:0,RULE:Release_Ham,ACTION:
	release,TS:0
X-CID-META: VersionHash:7db8b62,CLOUDID:c748a0bded8e2b883384503dc73395a3,BulkI
	D:nil,BulkQuantity:0,SF:80|81|82|83|102|136|865|898,TC:nil,Content:0|15|50
	|99,EDM:-3|-100,IP:nil,URL:99|1,File:nil,RT:nil,Bulk:nil,QS:nil,BEC:nil,CO
	L:0,OSI:0,OSA:0,AV:0,LES:1,SPR:NO,DKR:0,DKP:0,BRR:0,BRE:0,ARC:0
X-CID-BVR: 2,SSN|SDN
X-CID-BAS: 2,SSN|SDN,0,_
X-CID-FACTOR: TF_CID_SPAM_SNR,TF_CID_SPAM_ULS
X-CID-RHF: D41D8CD98F00B204E9800998ECF8427E
X-UUID: 17d328e0e28111f19a56ed5b684f684d-20261117
X-User: liwang@kylinos.cn
Received: from [10.42.16.85] [(10.44.16.150)] by mailgw.kylinos.cn
	(envelope-from <liwang@kylinos.cn>)
	(Generic MTA with TLSv1.3 TLS_AES_128_GCM_SHA256 128/128)
	with ESMTP id 811876433; Tue, 17 Nov 2026 20:19:10 +0800
Message-ID: <6c6cea56-1af2-4a37-b081-83244d5e09cd@kylinos.cn>
Date: Tue, 17 Nov 2026 20:19:07 +0800
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Post: <mailto:virtualization@lists.linux.dev>
List-Help: <mailto:virtualization+help@lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
List-Owner: <mailto:virtualization+owner@lists.linux.dev>
Precedence: list
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4] fuse: virtio-fs: fix lost wakeup on a full virtqueue
To: Qihang <q.h.hack.winter@gmail.com>, German Maglione
 <gmaglione@redhat.com>, Vivek Goyal <vgoyal@redhat.com>,
 Stefan Hajnoczi <stefanha@redhat.com>, Miklos Szeredi <miklos@szeredi.hu>
Cc: Eugenio Perez <eperezma@redhat.com>, virtualization@lists.linux.dev,
 linux-fsdevel@vger.kernel.org, fuse-devel@lists.linux.dev,
 linux-kernel@vger.kernel.org
References: <20261113091758.77678-1-q.h.hack.winter@gmail.com>
Content-Language: en-GB
From: Li Wang <liwang@kylinos.cn>
In-Reply-To: <20261113091758.77678-1-q.h.hack.winter@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

Hi Hang,

On 13/11/2026 17:17, Qihang wrote:
> When virtio_fs_enqueue_req() returns -ENOSPC, completion processing
> can run before the caller adds the request to queued_reqs. If no
> further completions arrive, dispatch is never scheduled and the
> request remains counted in in_flight, hanging queue draining.
> 
> Track completion progress under fsvq->lock and sample it when
> submission fails with -ENOSPC. After queueing, schedule dispatch if
> the sequence changed; otherwise completion processing will see the
> queued request and schedule it. Each failed submission keeps its own
> snapshot, so concurrent submitters cannot consume each other's wakeup.
> 
> Fixes: 106e4df1206b ("virtio-fs: improved request latencies when Virtio queue is full")
> Cc: stable@vger.kernel.org # 6.11+
> Link: https://lore.kernel.org/all/sashiko-outbox-204365@kernel.org/
> Signed-off-by: Qihang <q.h.hack.winter@gmail.com>
> ---
> Changes since v3:
> 
> - Only the lost-wakeup fix is included here.  v3 also carried teardown
>   admission control; that is a separate change, not part of this patch,
>   and nothing here depends on it.
> - Add a completion sequence sampled per failed submission to close the
>   window between -ENOSPC and queue insertion.
> 
> Runtime tests used an arm64 kernel with the separate teardown
> admission change also applied.  The request scenarios ran before
> admission was stopped, with fsvq->aborting remaining false.  The
> standalone patch was not run on its own.
> 
> - Filled the request virtqueue and held the submitter between -ENOSPC and
>   queue insertion while real device completions ran.  The unpatched
>   kernel hung in virtio_fs_drain_queue(); this change finished the drain.
> - Held the dispatch worker in the same place.  The unpatched kernel
>   stranded the request; this change rescheduled dispatch once more and
>   every request finished.
> - Kept the queue full without completions: dispatch did not reschedule
>   itself in a loop.
> 
>  fs/fuse/virtio_fs.c | 29 ++++++++++++++++++++++++-----
>  1 file changed, 24 insertions(+), 5 deletions(-)
> 
> diff --git a/fs/fuse/virtio_fs.c b/fs/fuse/virtio_fs.c
> index e445398..68aeaa6 100644
> --- a/fs/fuse/virtio_fs.c
> +++ b/fs/fuse/virtio_fs.c
> @@ -55,6 +55,7 @@ struct virtio_fs_vq {
>  	struct work_struct dispatch_work;
>  	struct fuse_dev *fud;
>  	bool connected;
> +	u64 completion_seq; /* completion progress under lock */
>  	long in_flight;
>  	struct completion in_flight_zero; /* No inflight requests */
>  	struct kobject *kobj;
> @@ -99,7 +100,7 @@ struct virtio_fs_req_work {
>  
>  static int virtio_fs_enqueue_req(struct virtio_fs_vq *fsvq,
>  				 struct fuse_req *req, bool in_flight,
> -				 gfp_t gfp);
> +				 gfp_t gfp, u64 *completion_seq);
>  
>  static const struct constant_table dax_param_enums[] = {
>  	{"always",	FUSE_VDAX_ALWAYS },
> @@ -348,6 +349,7 @@ static void virtio_fs_start_all_queues(struct virtio_fs *fs)
>  		fsvq = &fs->vqs[i];
>  		spin_lock(&fsvq->lock);
>  		fsvq->connected = true;
> +		fsvq->completion_seq = 0;
>  		spin_unlock(&fsvq->lock);
>  	}
>  }
> @@ -576,6 +578,7 @@ static void virtio_fs_request_dispatch_work(struct work_struct *work)
>  	/* Dispatch pending requests */
>  	while (1) {
>  		unsigned int flags;
> +		u64 completion_seq;
>  
>  		spin_lock(&fsvq->lock);
>  		req = list_first_entry_or_null(&fsvq->queued_reqs,
> @@ -588,12 +591,15 @@ static void virtio_fs_request_dispatch_work(struct work_struct *work)
>  		spin_unlock(&fsvq->lock);
>  
>  		flags = memalloc_nofs_save();
> -		ret = virtio_fs_enqueue_req(fsvq, req, true, GFP_KERNEL);
> +		ret = virtio_fs_enqueue_req(fsvq, req, true, GFP_KERNEL,
> +					    &completion_seq);
>  		memalloc_nofs_restore(flags);
>  		if (ret < 0) {
>  			if (ret == -ENOSPC) {
>  				spin_lock(&fsvq->lock);
>  				list_add_tail(&req->list, &fsvq->queued_reqs);
> +				if (completion_seq != fsvq->completion_seq)
> +					schedule_work(&fsvq->dispatch_work);
>  				spin_unlock(&fsvq->lock);
>  				return;
>  			}
> @@ -902,6 +908,8 @@ static void virtio_fs_requests_done_work(struct work_struct *work)
>  
>  	/* Try to push previously queued requests, as the queue might no longer be full */
>  	spin_lock(&fsvq->lock);
> +	/* Record progress for submitters not yet on queued_reqs. */
> +	fsvq->completion_seq++;
>  	if (!list_empty(&fsvq->queued_reqs))
>  		schedule_work(&fsvq->dispatch_work);
>  	spin_unlock(&fsvq->lock);
> @@ -1418,10 +1426,15 @@ static unsigned int sg_init_fuse_args(struct scatterlist *sg,
>  	return total_sgs;
>  }
>  
> -/* Add a request to a virtqueue and kick the device */
> +/*
> + * Add a request to a virtqueue and kick the device.  On -ENOSPC, return the
> + * completion sequence under the same lock as the failed submission.  If it
> + * changes before the caller queues the request, the caller must schedule
> + * dispatch itself: done_work may have run before the request was queued.
> + */
>  static int virtio_fs_enqueue_req(struct virtio_fs_vq *fsvq,
>  				 struct fuse_req *req, bool in_flight,
> -				 gfp_t gfp)
> +				 gfp_t gfp, u64 *completion_seq)
>  {
>  	/* requests need at least 4 elements */
>  	struct scatterlist *stack_sgs[6];
> @@ -1488,6 +1501,8 @@ static int virtio_fs_enqueue_req(struct virtio_fs_vq *fsvq,
>  	vq = fsvq->vq;
>  	ret = virtqueue_add_sgs(vq, sgs, out_sgs, in_sgs, req, GFP_ATOMIC);
>  	if (ret < 0) {
> +		if (ret == -ENOSPC)
> +			*completion_seq = fsvq->completion_seq;
>  		spin_unlock(&fsvq->lock);
>  		goto out;
>  	}
> @@ -1529,6 +1544,7 @@ static void virtio_fs_send_req(struct fuse_iqueue *fiq, struct fuse_req *req)
>  	unsigned int queue_id;
>  	struct virtio_fs *fs;
>  	struct virtio_fs_vq *fsvq;
> +	u64 completion_seq;
>  	int ret;
>  
>  	fuse_request_assign_unique(fiq, req);
> @@ -1545,7 +1561,8 @@ static void virtio_fs_send_req(struct fuse_iqueue *fiq, struct fuse_req *req)
>  		 queue_id);
>  
>  	fsvq = &fs->vqs[queue_id];
> -	ret = virtio_fs_enqueue_req(fsvq, req, false, GFP_ATOMIC);
> +	ret = virtio_fs_enqueue_req(fsvq, req, false, GFP_ATOMIC,
> +				    &completion_seq);
>  	if (ret < 0) {
>  		if (ret == -ENOSPC) {
>  			/*
> @@ -1555,6 +1572,8 @@ static void virtio_fs_send_req(struct fuse_iqueue *fiq, struct fuse_req *req)
>  			spin_lock(&fsvq->lock);
>  			list_add_tail(&req->list, &fsvq->queued_reqs);
>  			inc_in_flight_req(fsvq);
> +			if (completion_seq != fsvq->completion_seq)
> +				schedule_work(&fsvq->dispatch_work);
>  			spin_unlock(&fsvq->lock);
>  			return;
>  		}

Regarding handling -ENOSPC, it looks like we can simplify things similar to 
how send_forget_request() does it:

If -ENOSPC is encountered while holding fsvq->lock, we can simply use 
list_add_tail() to queue it into queued_reqs. For newly submitted requests, 
we increment via inc_in_flight_req().

virtio_fs_send_req() and virtio_fs_request_dispatch_work() can just return 
immediately upon seeing -ENOSPC, avoiding a second lock acquisition and re-queuing.

With this approach, we won't need completion_seq, per-call sequence snapshots, 
or an extra scheduling step from the submitter side.

Thanks,
Li Wang

