Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=124.126.103.232
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794452972;
	b=n5jrqroYOL6mr5aDY5ttjs4o6nyg9IYCeNq8MzIk/hJoWr6ENC9NI81+/KuTsYUF/iCE
	 FwSKJEXSSaXOUSvmKHbJfU7d9X/+oyzJxtRreHOu44wd4oxVUXWaZQJX1hMMnz3BQp4Aa
	 qatKnoIA0Z2hjQWF3X6cfIL5LBSevaVMnPGTh3eLUMPxtdbEA0jINMUeX3LIC346/XdZM
	 DxJDtCSrjWV6Era2sfDfjTPEiDg0wmgoK/Ss/y3cxqNYAi+eXUutjfYPRYT8q3fWXZ2TR
	 PqmqTAjZEHg1HTsgUgbpajT7okaDCBCWqsZdKxQf+5UvNAlkdBQEZUrfdgFClwfPzyQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794452972;
	h=DMARC-Filter:X-UUID:X-CID-P-RULE:X-CID-O-INFO:X-CID-META:X-CID-BVR:
	 X-CID-BAS:X-CID-FACTOR:X-CID-RHF:X-UUID:X-User:Received:Message-ID:
	 Date:MIME-Version:User-Agent:Subject:To:Cc:References:
	 Content-Language:From:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding;
	bh=qkinF/q9GCb+35gkYPPlegUGJ9Dwb0hvfw7/Lf59FvY=;
	b=vySFngemtK2ln32Bo2G9EuOUWFBHtoqQ9czt0NvAwFQUU5xQaztlPhapEhDQi6K6xA8c
	 nDJAPlNJg3FJuIid1nGEjACIWuDGywaR4flbbIGm7x92e3rRzP4dEYuu0qVNHAvPOhT4o
	 uQ3TMghgekbcJrGI/uYS8LhpayDqNxFjopYe+hW0DxgIjwrV8Dm82M73/Ev95wDc09KNH
	 V44H916lWHhQA0ygCH+PGwYkbF+ahxQH+q7zqvJK19P83CVS73HTIQfbtbs9wr0DyO1JH
	 UMq0L8eSKDg3Bdtvn42p5ILtFeYU7AB/3jyjIswJXrgm1hX8P/LRM4TSZ6KR9IjSTgw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=none header.from=kylinos.cn;
	spf=pass smtp.mailfrom=kylinos.cn;
	arc=none smtp.remote-ip=124.126.103.232
Received: from mailgw.kylinos.cn (mailgw.kylinos.cn [124.126.103.232])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 22ADF606A327;
	Thu, 12 Nov 2026 03:09:30 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 22ADF606A327
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kylinos.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kylinos.cn
X-UUID: 75f5befede4611f19a56ed5b684f684d-20261112
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.3.19,REQID:037130f9-52f9-445f-b903-0fb7fdf7388f,IP:0,U
	RL:0,TC:0,Content:0,EDM:0,RT:0,SF:0,FILE:0,BULK:0,RULE:Release_Ham,ACTION:
	release,TS:0
X-CID-META: VersionHash:7db8b62,CLOUDID:9601ed369c3b6ffe06a276b458c22895,BulkI
	D:nil,BulkQuantity:0,SF:80|81|82|83|102|136|865|898,TC:nil,Content:0|15|50
	|99,EDM:-3|-100,IP:nil,URL:0,File:nil,RT:nil,Bulk:nil,QS:nil,BEC:nil,COL:0
	,OSI:0,OSA:0,AV:0,LES:1,SPR:NO,DKR:0,DKP:0,BRR:0,BRE:0,ARC:0
X-CID-BVR: 2,SSN|SDN
X-CID-BAS: 2,SSN|SDN,0,_
X-CID-FACTOR: TF_CID_SPAM_SNR
X-CID-RHF: D41D8CD98F00B204E9800998ECF8427E
X-UUID: 75f5befede4611f19a56ed5b684f684d-20261112
X-User: liwang@kylinos.cn
Received: from [10.42.16.85] [(10.44.16.150)] by mailgw.kylinos.cn
	(envelope-from <liwang@kylinos.cn>)
	(Generic MTA with TLSv1.3 TLS_AES_128_GCM_SHA256 128/128)
	with ESMTP id 475416175; Thu, 12 Nov 2026 11:09:23 +0800
Message-ID: <98d41456-a6c4-48c2-8207-0d3fe32f8860@kylinos.cn>
Date: Thu, 12 Nov 2026 11:09:20 +0800
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
Subject: Re: [PATCH v3] fuse: virtio-fs: stop new requests before draining
 queues
To: Qihang <q.h.hack.winter@gmail.com>, German Maglione
 <gmaglione@redhat.com>, Vivek Goyal <vgoyal@redhat.com>,
 Stefan Hajnoczi <stefanha@redhat.com>, Miklos Szeredi <miklos@szeredi.hu>
Cc: Eugenio Perez <eperezma@redhat.com>, virtualization@lists.linux.dev,
 linux-fsdevel@vger.kernel.org, fuse-devel@lists.linux.dev,
 linux-kernel@vger.kernel.org
References: <20261109023957.34500-1-q.h.hack.winter@gmail.com>
Content-Language: en-GB
From: Li Wang <liwang@kylinos.cn>
In-Reply-To: <20261109023957.34500-1-q.h.hack.winter@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

Hi Hang,

On 09/11/2026 10:39, Qihang wrote:
> virtio_fs_conn_destroy() drains the virtqueues and then calls
> fuse_conn_destroy(), which aborts the connection.  The abort ends every
> request the fuse device still owns, and each ended request is freed as
> soon as its waiter wakes up.
> 
> The drain only covers the requests that were already counted in
> fsvq->in_flight when it started.  A request submitted after it returns is
> not covered, but is still handed to the device before the abort runs:
> 
>   CPU 0 (umount)                     CPU 1
>   ---------------------------------  --------------------------------
>   virtio_fs_drain_all_queues()
>     /* in_flight drops to 0 and
>        the drain returns */
>                                      virtio_fs_enqueue_req()
>                                        virtqueue_add_sgs()
>                                        inc_in_flight_req() -> 1
>   fuse_conn_destroy()
>     fuse_send_destroy()
>     fuse_chan_abort()
>       /* ends and frees the
>          request above */
>     fuse_chan_wait_aborted()
>                                      /* the device still owns the
>                                         virtqueue descriptors and
>                                         DMA-writes into the freed
>                                         request and its argbuf */
> 
> Stop admitting requests on each queue before draining begins.  The flag
> is set per queue, but that is sufficient: request admission,
> virtqueue_add_sgs() and, on the submission path, the in_flight
> increment are serialized by the same fsvq->lock.  A request is
> therefore either rejected before the device can see it, or already
> counted in fsvq->in_flight and covered by the drain.  There is no
> window in between.
> 
> Rejected requests use the existing -ENOTCONN error path and are ended by
> virtio_fs_request_dispatch_work() through end_reqs, so no new request
> completion or ownership state is introduced.  Nothing has to be
> discarded in the completion path, and fsvq->in_flight remains the only
> per-queue accounting state.
> 
> The -ENOSPC path needs the same admission check.  virtio_fs_enqueue_req()
> drops fsvq->lock before returning -ENOSPC, and the caller queues the
> request in a second critical section; teardown can finish in between and
> leave the request stranded on queued_reqs, which nothing drains.
> Re-check connected/aborting before queueing, in both the submission path
> and the dispatch worker.  After aborting is set, no request can newly
> enter queued_reqs or the virtqueue, except the explicitly permitted
> FUSE_DESTROY path.
> 
> Rejected requests are ended by virtio_fs_request_dispatch_work().  If
> their end callback may block (a DAX release), ending them inline can
> deadlock: the callback may issue a synchronous request that needs the
> same worker.  Offload those endings to a separate work item, like the
> device completion path already does.
> 
> The new state is not folded into fsvq->connected because the request
> queues have to stay usable: fuse_conn_destroy() sends FUSE_DESTROY
> through them, with args.force set so that fuse_simple_request() waits
> for the reply.  Clearing fsvq->connected would make that request fail
> with -ENOTCONN and the server would never see the destroy.
> 
> FUSE_DESTROY is the sole exception while aborting is set.  It is sent
> only after the first drain, and its completion is waited for before
> fuse_chan_abort() can end requests, so the destroy is the only request
> the device sees after the drain.  virtio-fs exposes no userspace
> /dev/fuse fd (and no_control disables the fusectl interface), so
> userspace cannot inject another request.
> 
> virtio_fs_start_all_queues() clears the flag, so a mount that follows an
> unmount starts with admission enabled again.
> 
> Fixes: a62a8ef9d97d ("virtio-fs: add virtiofs filesystem")
> Cc: stable@vger.kernel.org
> Signed-off-by: Qihang <q.h.hack.winter@gmail.com>
> ---
> V2 -> V3:
> - re-check admission before queueing on -ENOSPC, in virtio_fs_send_req()
>   and in the dispatch worker, so teardown cannot strand a request on
>   queued_reqs
> - offload may_block request endings in the dispatch worker to avoid a
>   self-deadlock through fuse_simple_request()
> - add Fixes: and Cc: stable
> V1 -> V2:
> - prevent new requests from reaching the virtqueue at teardown time
>   instead of skipping completions of aborted requests
> - keep FUSE_DESTROY working: it is the teardown request and is waited
>   for before fuse_chan_abort()
> - drop the per-vq aborted flag and the completion-skip branch
>  fs/fuse/virtio_fs.c | 104 +++++++++++++++++++++++++++++++++++++++-----
>  1 file changed, 94 insertions(+), 10 deletions(-)
> 
> diff --git a/fs/fuse/virtio_fs.c b/fs/fuse/virtio_fs.c
> index ba8d79c4bcac6..a46536c9fdc8e 100644
> --- a/fs/fuse/virtio_fs.c
> +++ b/fs/fuse/virtio_fs.c
> @@ -55,6 +55,7 @@ struct virtio_fs_vq {
>  	struct work_struct dispatch_work;
>  	struct fuse_dev *fud;
>  	bool connected;
> +	bool aborting; /* reject new requests except FUSE_DESTROY */
>  	long in_flight;
>  	struct completion in_flight_zero; /* No inflight requests */
>  	struct kobject *kobj;
> @@ -97,6 +98,11 @@ struct virtio_fs_req_work {
>  	struct work_struct done_work;
>  };
>  
> +struct virtio_fs_end_work {
> +	struct work_struct work;
> +	struct fuse_req *req;
> +};

We can avoid introducing it and reuse virtio_fs_req_work instead.

Thanks,
Li Wang
