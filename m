Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=124.126.103.232
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795787370;
	b=oEaM0GkqYRheIqDGGyxuf7VLVNzLb2do5ln53pCl26Z3wB1D2aZD4Cndodiy9oClLY34
	 shRwcKw6ik3/vhqfFqBeqYEXkpD74hHm0wbYrZ4wrds9JgWY0roWuMkT+9DVCHTG1DgWU
	 +xlIHd0ny7nwLgahhgKX4hIX8qi5RBmDM+nKhtS6pUBaCrZTueDyoMtPtWv9MAcEPF2Zd
	 6TL4ovSXl4olhNM+0TYd5FtKwC7Fgz+tJG3nUD91CjMVEVgWL8P7e0y+tuKqC8sDSNxBX
	 fdrna2r1vPA84fvlMJ09N48S6HexlLlW6UVSXBAzn5QuGnkA1fvPN6Wp/5elMmweTxA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795787370;
	h=DMARC-Filter:X-UUID:X-CID-P-RULE:X-CID-O-INFO:X-CID-META:X-CID-BVR:
	 X-CID-BAS:X-CID-FACTOR:X-CID-RHF:X-UUID:X-User:Received:Message-ID:
	 Date:MIME-Version:User-Agent:Subject:To:Cc:References:
	 Content-Language:From:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding;
	bh=xfnZkh4Tftrkfex6QN7GHjgYykVdubDMd2Z+ir6ooWE=;
	b=T+WGNPlIEQih34/fgvK3Z8J+GINC+vgNLvoTfF7+Z0Bzg+9LJZZzfNESrdNbVCAnqGhS
	 UPwFzopCLSveRYnoA2AKt+BKv0jjP3Ozk20uZA9C/RaCiiE//xkXUcHg/1MQx4qr+2pdi
	 5UiFYccoON7m2iMZWq9Oq5CAvAAjkYaVUb3tTO6s1qLuBH3r2uLVdcRwlagiEVWffiBFh
	 atIjCYupfjrDI2yMCiXzLgC5zN0/SjQ1YfQN4kdDC8Pd63oqt8E4BUZVLcqQNRu0bN/nI
	 NnSwLrVCyNwG8TbtRMKAG0TE1mSCSjxHFHpDIReZ3vxMyBSJUR+qfOKN2PZnvVc726Q==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=none header.from=kylinos.cn;
	spf=pass smtp.mailfrom=kylinos.cn;
	arc=none smtp.remote-ip=124.126.103.232
Received: from mailgw.kylinos.cn (mailgw.kylinos.cn [124.126.103.232])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 86700606A321;
	Fri, 27 Nov 2026 13:49:28 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 86700606A321
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kylinos.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kylinos.cn
X-UUID: 5a0e29f4ea6911f19a56ed5b684f684d-20261127
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.3.19,REQID:d01992c1-1c69-441d-8839-7a835b116ff9,IP:0,U
	RL:0,TC:0,Content:0,EDM:0,RT:0,SF:0,FILE:0,BULK:0,RULE:Release_Ham,ACTION:
	release,TS:0
X-CID-META: VersionHash:7db8b62,CLOUDID:2ca9e505b82f8630a66fd9ee6ca143ce,BulkI
	D:nil,BulkQuantity:0,SF:80|81|82|83|102|136|865|898,TC:nil,Content:0|15|50
	|99,EDM:-3|-100,IP:nil,URL:0,File:nil,RT:nil,Bulk:nil,QS:nil,BEC:nil,COL:0
	,OSI:0,OSA:0,AV:0,LES:1,SPR:NO,DKR:0,DKP:0,BRR:0,BRE:0,ARC:0
X-CID-BVR: 2,SSN|SDN
X-CID-BAS: 2,SSN|SDN,0,_
X-CID-FACTOR: TF_CID_SPAM_SNR
X-CID-RHF: D41D8CD98F00B204E9800998ECF8427E
X-UUID: 5a0e29f4ea6911f19a56ed5b684f684d-20261127
X-User: liwang@kylinos.cn
Received: from [10.42.16.85] [(10.44.16.150)] by mailgw.kylinos.cn
	(envelope-from <liwang@kylinos.cn>)
	(Generic MTA with TLSv1.3 TLS_AES_128_GCM_SHA256 128/128)
	with ESMTP id 166450250; Fri, 27 Nov 2026 21:49:22 +0800
Message-ID: <268ff952-bf02-45bd-b5ec-9eb107f78a50@kylinos.cn>
Date: Fri, 27 Nov 2026 21:49:20 +0800
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
Subject: Re: [PATCH 3/5] virtiofs: retry request submission from the worker on
 -ENOMEM
To: Miklos Szeredi <mszeredi@redhat.com>, fuse-devel@lists.linux.dev,
 virtualization@lists.linux.dev
Cc: German Maglione <gmaglione@redhat.com>,
 Stefan Hajnoczi <stefanha@redhat.com>
References: <20261126144719.232329-1-mszeredi@redhat.com>
 <20261126144719.232329-3-mszeredi@redhat.com>
Content-Language: en-GB
From: Li Wang <liwang@kylinos.cn>
In-Reply-To: <20261126144719.232329-3-mszeredi@redhat.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

Hi Miklos,

On 26/11/2026 22:47, Miklos Szeredi wrote:
> virtio_fs_send_req() enqueues with GFP_ATOMIC, because it may be called
> with fc->chan->bg_lock held.  copy_args_to_argbuf() allocates the bounce
> buffer with those flags, so under memory pressure a request can be
> failed with -ENOMEM even though nothing is wrong with it.  The buffer is
> as large as the request arguments, so this is not limited to tiny
> allocations: FUSE_REMOVEMAPPING, for example, can ask for just over
> 4 KiB, an order-1 allocation out of the atomic reserves with no reclaim.
> 
> A virtqueue that is merely full is already handled gracefully: -ENOSPC
> puts the request on fsvq->queued_reqs and virtio_fs_request_dispatch_work()
> retries it with GFP_KERNEL under memalloc_nofs_save().  A failed atomic
> allocation is just as transient, so treat it the same way instead of
> ending the request.  Unlike -ENOSPC there is no completion to kick the
> worker afterwards, so schedule it here.
> 
> virtio_fs_enqueue_req() queues on -ENOSPC only after checking
> fsvq->connected under fsvq->lock; do the same here and fail the request
> with -ENOTCONN if the queue is gone.  req->argbuf has already been freed
> and cleared on the error path, so the retry reallocates it.
> 
> Fixes: a62a8ef9d97d ("virtio-fs: add virtiofs filesystem")
> Signed-off-by: Miklos Szeredi <mszeredi@redhat.com>
> ---
>  fs/fuse/virtio_fs.c | 17 +++++++++++++++++
>  1 file changed, 17 insertions(+)
> 
> diff --git a/fs/fuse/virtio_fs.c b/fs/fuse/virtio_fs.c
> index 8bd63c6165d2..6ddb2f181a16 100644
> --- a/fs/fuse/virtio_fs.c
> +++ b/fs/fuse/virtio_fs.c
> @@ -1586,6 +1586,23 @@ static void virtio_fs_send_req(struct fuse_iqueue *fiq, struct fuse_req *req)
>  			 */
>  			return;
>  		}
> +		if (ret == -ENOMEM) {
> +			/*
> +			 * Only the GFP_ATOMIC allocation failed.  Hand the
> +			 * request to the dispatch worker, which retries with
> +			 * GFP_KERNEL, rather than failing it outright.
> +			 */
> +			spin_lock(&fsvq->lock);
> +			if (fsvq->connected) {
> +				list_add_tail(&req->list, &fsvq->queued_reqs);
> +				inc_in_flight_req(fsvq);
> +				schedule_work(&fsvq->dispatch_work);
> +				spin_unlock(&fsvq->lock);
> +				return;
> +			}
> +			spin_unlock(&fsvq->lock);
> +			ret = -ENOTCONN;
> +		}
>  		req->out.h.error = ret;
>  		pr_err("virtio-fs: virtio_fs_enqueue_req() failed %d\n", ret);
>  

Minor nit: in virtio_fs_enqueue_req(), besides allocating the bounce buffer
via copy_args_to_argbuf(), it also calls virtqueue_add_sgs() with GFP_ATOMIC
later, which can also return -ENOMEM on a DMA mapping error (note that failing 
to allocate the indirect descriptor table with GFP_ATOMIC does not return -ENOMEM). 
If -ENOMEM comes from virtqueue_add_sgs(), retrying once in 
virtio_fs_request_dispatch_work() is unlikely to succeed. However, distinguishing 
the two cases would require checking whether req->argbuf is NULL.

Alternatively, we could consider noting in the commit message that a failed
atomic allocation in copy_args_to_argbuf() is just as transient.

Reviewed-by: Li Wang <liwang@kylinos.cn>

Thanks,
Li Wang
