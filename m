Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DC135C77B73
	for <virtualization@archiver.kernel.org>; Mon,  5 Jun 2023 20:34:16 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 79A686073E;
	Mon,  5 Jun 2023 20:34:16 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 79A686073E
Authentication-Results: smtp3.osuosl.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=ibKhaRQZ
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
	by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id o0BN1veoGldy; Mon,  5 Jun 2023 20:34:15 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp3.osuosl.org (Postfix) with ESMTPS id D4A57605DB;
	Mon,  5 Jun 2023 20:34:14 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org D4A57605DB
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id A7273C0037;
	Mon,  5 Jun 2023 20:34:14 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 026FBC0029
 for <virtualization@lists.linux-foundation.org>;
 Mon,  5 Jun 2023 20:34:14 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id DE15E814BB
 for <virtualization@lists.linux-foundation.org>;
 Mon,  5 Jun 2023 20:34:13 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org DE15E814BB
Authentication-Results: smtp1.osuosl.org;
 dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com
 header.a=rsa-sha256 header.s=mimecast20190719 header.b=ibKhaRQZ
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id adWmylMhXrAt
 for <virtualization@lists.linux-foundation.org>;
 Mon,  5 Jun 2023 20:34:13 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org D665981774
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.129.124])
 by smtp1.osuosl.org (Postfix) with ESMTPS id D665981774
 for <virtualization@lists.linux-foundation.org>;
 Mon,  5 Jun 2023 20:34:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1685997251;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=B1aUzpMPNmlfrjcGhUkfuNr3whmW6qOECBZUIISypic=;
 b=ibKhaRQZogvkZyUyzSjkoYmFjrrMvdf2cj84fb3Cf8ea7+N5DL5zLpljhrUk45YuzpMakv
 5D3ewAdNrtsGrKagbdfWWpaZ2BW8OpEC1ghoLNWWTlRa94kZDrMcBkQAmmdMkhZjpB5GMy
 8pkFX504Rm6xy84TO05X7k0AIP+51Ng=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-357-eUWr7QALPyOWonMfkdpjaQ-1; Mon, 05 Jun 2023 16:34:08 -0400
X-MC-Unique: eUWr7QALPyOWonMfkdpjaQ-1
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.rdu2.redhat.com
 [10.11.54.3])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 3F54D800BFF;
 Mon,  5 Jun 2023 20:34:08 +0000 (UTC)
Received: from fedora.redhat.com (unknown [10.22.32.117])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 1EDD81121314;
 Mon,  5 Jun 2023 20:34:08 +0000 (UTC)
Received: by fedora.redhat.com (Postfix, from userid 1000)
 id BC70A16FE2C; Mon,  5 Jun 2023 16:34:07 -0400 (EDT)
Date: Mon, 5 Jun 2023 16:34:07 -0400
From: Vivek Goyal <vgoyal@redhat.com>
To: Peter-Jan Gootzen <peter-jan@gootzen.net>
Subject: Re: [PATCH V3] virtio-fs: Improved request latencies when Virtio
 queue is full
Message-ID: <ZH5Gv13svYAe6u42@redhat.com>
References: <20230602133224.1445655-1-peter-jan@gootzen.net>
MIME-Version: 1.0
In-Reply-To: <20230602133224.1445655-1-peter-jan@gootzen.net>
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.3
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Disposition: inline
Cc: miklos@szeredi.hu, stefanha@redhat.com,
 virtualization@lists.linux-foundation.org
X-BeenThere: virtualization@lists.linux-foundation.org
X-Mailman-Version: 2.1.15
Precedence: list
List-Id: Linux virtualization <virtualization.lists.linux-foundation.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/virtualization>, 
 <mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/virtualization/>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/virtualization>, 
 <mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: virtualization-bounces@lists.linux-foundation.org
Sender: "Virtualization" <virtualization-bounces@lists.linux-foundation.org>

On Fri, Jun 02, 2023 at 03:32:26PM +0200, Peter-Jan Gootzen wrote:
> When the Virtio queue is full, a work item is scheduled
> to execute in 1ms that retries adding the request to the queue.
> This is a large amount of time on the scale on which a
> virtio-fs device can operate. When using a DPU this is around
> 40us baseline without going to a remote server (4k, QD=1).
> This patch queues requests when the Virtio queue is full,
> and when a completed request is taken off, immediately fills
> it back up with queued requests.
> 
> This reduces the 99.9th percentile latencies in our tests by
> 60x and slightly increases the overall throughput, when using a
> queue depth 2x the size of the Virtio queue size, with a
> DPU-powered virtio-fs device.
> 
> Furthermore, the virtio-fs driver now also always lets -ENOMEM
> errors go to userspace instead of retrying the request in the
> driver.
> 
> Signed-off-by: Peter-Jan Gootzen <peter-jan@gootzen.net>
> ---
> V3: Fixed requests falling into the void when -ENOMEM and no new
> incoming requests. Virtio-fs now always lets -ENOMEM bubble up to
> userspace. Also made queue full condition more explicit with
> -ENOSPC in `send_forget_request`.
> V2: Not scheduling dispatch work anymore when not needed
> and changed delayed_work structs to work_struct structs
> 
>  fs/fuse/virtio_fs.c | 46 ++++++++++++++++++++++-----------------------
>  1 file changed, 23 insertions(+), 23 deletions(-)
> 
> diff --git a/fs/fuse/virtio_fs.c b/fs/fuse/virtio_fs.c
> index 4d8d4f16c727..3a3231ddb9e7 100644
> --- a/fs/fuse/virtio_fs.c
> +++ b/fs/fuse/virtio_fs.c
> @@ -45,7 +45,7 @@ struct virtio_fs_vq {
>  	struct work_struct done_work;
>  	struct list_head queued_reqs;
>  	struct list_head end_reqs;	/* End these requests */
> -	struct delayed_work dispatch_work;
> +	struct work_struct dispatch_work;
>  	struct fuse_dev *fud;
>  	bool connected;
>  	long in_flight;
> @@ -202,7 +202,7 @@ static void virtio_fs_drain_queue(struct virtio_fs_vq *fsvq)
>  	}
>  
>  	flush_work(&fsvq->done_work);
> -	flush_delayed_work(&fsvq->dispatch_work);
> +	flush_work(&fsvq->dispatch_work);
>  }
>  
>  static void virtio_fs_drain_all_queues_locked(struct virtio_fs *fs)
> @@ -346,6 +346,9 @@ static void virtio_fs_hiprio_done_work(struct work_struct *work)
>  			dec_in_flight_req(fsvq);
>  		}
>  	} while (!virtqueue_enable_cb(vq) && likely(!virtqueue_is_broken(vq)));
> +
> +	if (!list_empty(&fsvq->queued_reqs))
> +		schedule_work(&fsvq->dispatch_work);
>  	spin_unlock(&fsvq->lock);
>  }
>  
> @@ -353,7 +356,7 @@ static void virtio_fs_request_dispatch_work(struct work_struct *work)
>  {
>  	struct fuse_req *req;
>  	struct virtio_fs_vq *fsvq = container_of(work, struct virtio_fs_vq,
> -						 dispatch_work.work);
> +						 dispatch_work);
>  	int ret;
>  
>  	pr_debug("virtio-fs: worker %s called.\n", __func__);
> @@ -385,11 +388,9 @@ static void virtio_fs_request_dispatch_work(struct work_struct *work)
>  
>  		ret = virtio_fs_enqueue_req(fsvq, req, true);
>  		if (ret < 0) {
> -			if (ret == -ENOMEM || ret == -ENOSPC) {
> +			if (ret == -ENOSPC) {

I think this change should be a separate patch with proper justification.
This change has nothing to do with reducing the latency of submitting
the queued request.

Thanks
Vivek

>  				spin_lock(&fsvq->lock);
>  				list_add_tail(&req->list, &fsvq->queued_reqs);
> -				schedule_delayed_work(&fsvq->dispatch_work,
> -						      msecs_to_jiffies(1));
>  				spin_unlock(&fsvq->lock);
>  				return;
>  			}
> @@ -405,8 +406,8 @@ static void virtio_fs_request_dispatch_work(struct work_struct *work)
>  }
>  
>  /*
> - * Returns 1 if queue is full and sender should wait a bit before sending
> - * next request, 0 otherwise.
> + * Returns 0 if request has been successfully sent, otherwise -ENOSPC
> + * when the queue is full.
>   */
>  static int send_forget_request(struct virtio_fs_vq *fsvq,
>  			       struct virtio_fs_forget *forget,
> @@ -432,16 +433,12 @@ static int send_forget_request(struct virtio_fs_vq *fsvq,
>  
>  	ret = virtqueue_add_outbuf(vq, &sg, 1, forget, GFP_ATOMIC);
>  	if (ret < 0) {
> -		if (ret == -ENOMEM || ret == -ENOSPC) {
> +		if (ret == -ENOSPC) {
>  			pr_debug("virtio-fs: Could not queue FORGET: err=%d. Will try later\n",
>  				 ret);
>  			list_add_tail(&forget->list, &fsvq->queued_reqs);
> -			schedule_delayed_work(&fsvq->dispatch_work,
> -					      msecs_to_jiffies(1));
>  			if (!in_flight)
>  				inc_in_flight_req(fsvq);
> -			/* Queue is full */
> -			ret = 1;
>  		} else {
>  			pr_debug("virtio-fs: Could not queue FORGET: err=%d. Dropping it.\n",
>  				 ret);
> @@ -469,7 +466,7 @@ static void virtio_fs_hiprio_dispatch_work(struct work_struct *work)
>  {
>  	struct virtio_fs_forget *forget;
>  	struct virtio_fs_vq *fsvq = container_of(work, struct virtio_fs_vq,
> -						 dispatch_work.work);
> +						 dispatch_work);
>  	pr_debug("virtio-fs: worker %s called.\n", __func__);
>  	while (1) {
>  		spin_lock(&fsvq->lock);
> @@ -482,7 +479,7 @@ static void virtio_fs_hiprio_dispatch_work(struct work_struct *work)
>  
>  		list_del(&forget->list);
>  		spin_unlock(&fsvq->lock);
> -		if (send_forget_request(fsvq, forget, true))
> +		if (send_forget_request(fsvq, forget, true) == -ENOSPC)
>  			return;
>  	}
>  }
> @@ -647,6 +644,11 @@ static void virtio_fs_requests_done_work(struct work_struct *work)
>  			virtio_fs_request_complete(req, fsvq);
>  		}
>  	}
> +
> +	spin_lock(&fsvq->lock);
> +	if (!list_empty(&fsvq->queued_reqs))
> +		schedule_work(&fsvq->dispatch_work);
> +	spin_unlock(&fsvq->lock);
>  }
>  
>  /* Virtqueue interrupt handler */
> @@ -670,12 +672,12 @@ static void virtio_fs_init_vq(struct virtio_fs_vq *fsvq, char *name,
>  
>  	if (vq_type == VQ_REQUEST) {
>  		INIT_WORK(&fsvq->done_work, virtio_fs_requests_done_work);
> -		INIT_DELAYED_WORK(&fsvq->dispatch_work,
> -				  virtio_fs_request_dispatch_work);
> +		INIT_WORK(&fsvq->dispatch_work,
> +			  virtio_fs_request_dispatch_work);
>  	} else {
>  		INIT_WORK(&fsvq->done_work, virtio_fs_hiprio_done_work);
> -		INIT_DELAYED_WORK(&fsvq->dispatch_work,
> -				  virtio_fs_hiprio_dispatch_work);
> +		INIT_WORK(&fsvq->dispatch_work,
> +			  virtio_fs_hiprio_dispatch_work);
>  	}
>  }
>  
> @@ -1246,7 +1248,7 @@ __releases(fiq->lock)
>  	fsvq = &fs->vqs[queue_id];
>  	ret = virtio_fs_enqueue_req(fsvq, req, false);
>  	if (ret < 0) {
> -		if (ret == -ENOMEM || ret == -ENOSPC) {
> +		if (ret == -ENOSPC) {
>  			/*
>  			 * Virtqueue full. Retry submission from worker
>  			 * context as we might be holding fc->bg_lock.
> @@ -1254,8 +1256,6 @@ __releases(fiq->lock)
>  			spin_lock(&fsvq->lock);
>  			list_add_tail(&req->list, &fsvq->queued_reqs);
>  			inc_in_flight_req(fsvq);
> -			schedule_delayed_work(&fsvq->dispatch_work,
> -						msecs_to_jiffies(1));
>  			spin_unlock(&fsvq->lock);
>  			return;
>  		}
> @@ -1265,7 +1265,7 @@ __releases(fiq->lock)
>  		/* Can't end request in submission context. Use a worker */
>  		spin_lock(&fsvq->lock);
>  		list_add_tail(&req->list, &fsvq->end_reqs);
> -		schedule_delayed_work(&fsvq->dispatch_work, 0);
> +		schedule_work(&fsvq->dispatch_work);
>  		spin_unlock(&fsvq->lock);
>  		return;
>  	}
> -- 
> 2.34.1
> 

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
