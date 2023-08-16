Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 07EA8C25B7D
	for <virtualization@archiver.kernel.org>; Wed, 16 Aug 2023 21:10:40 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 7F66B61416;
	Wed, 16 Aug 2023 21:10:40 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 7F66B61416
Authentication-Results: smtp3.osuosl.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=UkXbOlo4
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
	by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id StV8V9_NHlba; Wed, 16 Aug 2023 21:10:39 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp3.osuosl.org (Postfix) with ESMTPS id E381860D77;
	Wed, 16 Aug 2023 21:10:38 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org E381860D77
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id B4805C0072;
	Wed, 16 Aug 2023 21:10:38 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 22669C0032
 for <virtualization@lists.linux-foundation.org>;
 Wed, 16 Aug 2023 21:10:37 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id EA8D882009
 for <virtualization@lists.linux-foundation.org>;
 Wed, 16 Aug 2023 21:10:36 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org EA8D882009
Authentication-Results: smtp1.osuosl.org;
 dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com
 header.a=rsa-sha256 header.s=mimecast20190719 header.b=UkXbOlo4
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id fbB5SkGy4pb9
 for <virtualization@lists.linux-foundation.org>;
 Wed, 16 Aug 2023 21:10:36 +0000 (UTC)
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.133.124])
 by smtp1.osuosl.org (Postfix) with ESMTPS id EE8AE81FF0
 for <virtualization@lists.linux-foundation.org>;
 Wed, 16 Aug 2023 21:10:35 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org EE8AE81FF0
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1692220234;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=lmvhOImdcPsDgCoClmG52OKtaZmuqbcjQU1wtGTz/Hk=;
 b=UkXbOlo4+JY77fNOYIK5SaMtx7ntSgRLnMJUWm0kbFPK+xVjqaWXol+f7tuithj+xlYLP7
 vzBJeswZSLudaggTC/FfAxyi+D4y8+Jig0Xaqd7z4DJCbBvFIkdAlu6A3iylmLBJH6nQca
 KsFD4J7BelbkLqQUaFc5WI69okl8Lgg=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-56--HRmax_sMJeSbVZ5qWRZzQ-1; Wed, 16 Aug 2023 17:10:30 -0400
X-MC-Unique: -HRmax_sMJeSbVZ5qWRZzQ-1
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.rdu2.redhat.com
 [10.11.54.4])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 7B0468DC660;
 Wed, 16 Aug 2023 21:10:30 +0000 (UTC)
Received: from fedora.redhat.com (unknown [10.22.32.124])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id E48662026D4B;
 Wed, 16 Aug 2023 21:10:29 +0000 (UTC)
Received: by fedora.redhat.com (Postfix, from userid 1000)
 id 2C40B17B0CB; Wed, 16 Aug 2023 17:10:25 -0400 (EDT)
Date: Wed, 16 Aug 2023 17:10:25 -0400
From: Vivek Goyal <vgoyal@redhat.com>
To: Peter-Jan Gootzen <peter-jan@gootzen.net>
Subject: Re: [PATCH V4] virtio-fs: Improved request latencies when Virtio
 queue is full
Message-ID: <ZN07QR2SFfjOYunC@redhat.com>
References: <20230703191457.1847740-1-peter-jan@gootzen.net>
MIME-Version: 1.0
In-Reply-To: <20230703191457.1847740-1-peter-jan@gootzen.net>
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.4
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

On Mon, Jul 03, 2023 at 09:14:59PM +0200, Peter-Jan Gootzen wrote:
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
> Signed-off-by: Peter-Jan Gootzen <peter-jan@gootzen.net>
> ---
> V4: Removed return value on error changes to simplify patch,
> that should be changed in another patch.
> V3: Fixed requests falling into the void when -ENOMEM and no new
> incoming requests. Virtio-fs now always lets -ENOMEM bubble up to
> userspace. Also made queue full condition more explicit with
> -ENOSPC in `send_forget_request`.
> V2: Not scheduling dispatch work anymore when not needed
> and changed delayed_work structs to work_struct structs
> 
>  fs/fuse/virtio_fs.c | 32 +++++++++++++++++---------------
>  1 file changed, 17 insertions(+), 15 deletions(-)
> 
> diff --git a/fs/fuse/virtio_fs.c b/fs/fuse/virtio_fs.c
> index 4d8d4f16c727..a676297db09b 100644
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
> @@ -388,8 +391,6 @@ static void virtio_fs_request_dispatch_work(struct work_struct *work)
>  			if (ret == -ENOMEM || ret == -ENOSPC) {
>  				spin_lock(&fsvq->lock);
>  				list_add_tail(&req->list, &fsvq->queued_reqs);
> -				schedule_delayed_work(&fsvq->dispatch_work,
> -						      msecs_to_jiffies(1));
>  				spin_unlock(&fsvq->lock);

If we are running low on memroy and very first request gets queued, then
we had deadlock as there is no completion happening after that. I think
I pointed this out in V2 as well. 

I think first you need to write a patch to return -ENOMEM to user space
and then second patch queues the request only on -ENOSPC.

Thanks
Vivek

>  				return;
>  			}
> @@ -436,8 +437,6 @@ static int send_forget_request(struct virtio_fs_vq *fsvq,
>  			pr_debug("virtio-fs: Could not queue FORGET: err=%d. Will try later\n",
>  				 ret);
>  			list_add_tail(&forget->list, &fsvq->queued_reqs);
> -			schedule_delayed_work(&fsvq->dispatch_work,
> -					      msecs_to_jiffies(1));
>  			if (!in_flight)
>  				inc_in_flight_req(fsvq);
>  			/* Queue is full */
> @@ -469,7 +468,7 @@ static void virtio_fs_hiprio_dispatch_work(struct work_struct *work)
>  {
>  	struct virtio_fs_forget *forget;
>  	struct virtio_fs_vq *fsvq = container_of(work, struct virtio_fs_vq,
> -						 dispatch_work.work);
> +						 dispatch_work);
>  	pr_debug("virtio-fs: worker %s called.\n", __func__);
>  	while (1) {
>  		spin_lock(&fsvq->lock);
> @@ -647,6 +646,11 @@ static void virtio_fs_requests_done_work(struct work_struct *work)
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
> @@ -670,12 +674,12 @@ static void virtio_fs_init_vq(struct virtio_fs_vq *fsvq, char *name,
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
> @@ -1254,8 +1258,6 @@ __releases(fiq->lock)
>  			spin_lock(&fsvq->lock);
>  			list_add_tail(&req->list, &fsvq->queued_reqs);
>  			inc_in_flight_req(fsvq);
> -			schedule_delayed_work(&fsvq->dispatch_work,
> -						msecs_to_jiffies(1));
>  			spin_unlock(&fsvq->lock);
>  			return;
>  		}
> @@ -1265,7 +1267,7 @@ __releases(fiq->lock)
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
