Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5309AEE8018
	for <virtualization@archiver.kernel.org>; Fri,  8 Sep 2023 15:25:29 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 9F88D41862;
	Fri,  8 Sep 2023 15:25:28 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org 9F88D41862
Authentication-Results: smtp4.osuosl.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=eJPl64i+
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
	by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id EbPpvd818ODV; Fri,  8 Sep 2023 15:25:27 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp4.osuosl.org (Postfix) with ESMTPS id BB14741758;
	Fri,  8 Sep 2023 15:25:26 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org BB14741758
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 8C854C0039;
	Fri,  8 Sep 2023 15:25:26 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 56FE5C0032
 for <virtualization@lists.linux-foundation.org>;
 Fri,  8 Sep 2023 15:25:25 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id 3F19882207
 for <virtualization@lists.linux-foundation.org>;
 Fri,  8 Sep 2023 15:25:25 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 3F19882207
Authentication-Results: smtp1.osuosl.org;
 dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com
 header.a=rsa-sha256 header.s=mimecast20190719 header.b=eJPl64i+
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id ewxiv-VJVrVX
 for <virtualization@lists.linux-foundation.org>;
 Fri,  8 Sep 2023 15:25:24 +0000 (UTC)
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.129.124])
 by smtp1.osuosl.org (Postfix) with ESMTPS id 3C863821F4
 for <virtualization@lists.linux-foundation.org>;
 Fri,  8 Sep 2023 15:25:24 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 3C863821F4
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1694186723;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=NABqDGLYLNPmUxO0QILxeEybmyL7dFx39ewlk67l+44=;
 b=eJPl64i+iOtmaL/D6UPh0vLF53gQPwcmhM5GYRRuKapc9jhymh5Np1mZ6AyNaKflhJuDwh
 r8Mqq4lLtePlcgr8BTZVinQvBUwRUSmq4j3RJFxXG3XYOTLfY7qJCf7TS3ldODpxvkCH4p
 Jg1n4WSiC8SWM75Rd9R2Xvl5mpuYzoU=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-3-GubM347jPU2THVRKaKEW6Q-1; Fri, 08 Sep 2023 11:25:19 -0400
X-MC-Unique: GubM347jPU2THVRKaKEW6Q-1
Received: from smtp.corp.redhat.com (int-mx10.intmail.prod.int.rdu2.redhat.com
 [10.11.54.10])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 3AB4880268A;
 Fri,  8 Sep 2023 15:25:19 +0000 (UTC)
Received: from fedora (unknown [10.72.120.2])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 59AAE403171;
 Fri,  8 Sep 2023 15:25:12 +0000 (UTC)
Date: Fri, 8 Sep 2023 23:25:08 +0800
From: Ming Lei <ming.lei@redhat.com>
To: Jens Axboe <axboe@kernel.dk>
Subject: Re: [PATCH V3] io_uring: fix IO hang in io_wq_put_and_exit from
 do_exit()
Message-ID: <ZPs81IAYfB8J78Pv@fedora>
References: <20230908093009.540763-1-ming.lei@redhat.com>
 <58227846-6b73-46ef-957f-d9b1e0451899@kernel.dk>
 <ZPsxCYFgZjIIeaBk@fedora>
 <0f85a6b5-3ba6-4b77-bb7d-79f365dbb44c@kernel.dk>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <0f85a6b5-3ba6-4b77-bb7d-79f365dbb44c@kernel.dk>
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.10
Cc: David Howells <dhowells@redhat.com>,
 Pavel Begunkov <asml.silence@gmail.com>, mst@redhat.com,
 virtualization@lists.linux-foundation.org, linux-block@vger.kernel.org,
 ming.lei@redhat.com, io-uring@vger.kernel.org,
 Chengming Zhou <zhouchengming@bytedance.com>
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

On Fri, Sep 08, 2023 at 08:44:45AM -0600, Jens Axboe wrote:
> On 9/8/23 8:34 AM, Ming Lei wrote:
> > On Fri, Sep 08, 2023 at 07:49:53AM -0600, Jens Axboe wrote:
> >> On 9/8/23 3:30 AM, Ming Lei wrote:
> >>> diff --git a/io_uring/io_uring.c b/io_uring/io_uring.c
> >>> index ad636954abae..95a3d31a1ef1 100644
> >>> --- a/io_uring/io_uring.c
> >>> +++ b/io_uring/io_uring.c
> >>> @@ -1930,6 +1930,10 @@ void io_wq_submit_work(struct io_wq_work *work)
> >>>  		}
> >>>  	}
> >>>  
> >>> +	/* It is fragile to block POLLED IO, so switch to NON_BLOCK */
> >>> +	if ((req->ctx->flags & IORING_SETUP_IOPOLL) && def->iopoll_queue)
> >>> +		issue_flags |= IO_URING_F_NONBLOCK;
> >>> +
> >>
> >> I think this comment deserves to be more descriptive. Normally we
> >> absolutely cannot block for polled IO, it's only OK here because io-wq
> > 
> > Yeah, we don't do that until commit 2bc057692599 ("block: don't make REQ_POLLED
> > imply REQ_NOWAIT") which actually push the responsibility/risk up to
> > io_uring.
> > 
> >> is the issuer and not necessarily the poller of it. That generally falls
> >> upon the original issuer to poll these requests.
> >>
> >> I think this should be a separate commit, coming before the main fix
> >> which is below.
> > 
> > Looks fine, actually IO_URING_F_NONBLOCK change isn't a must, and the
> > approach in V2 doesn't need this change.
> > 
> >>
> >>> @@ -3363,6 +3367,12 @@ __cold void io_uring_cancel_generic(bool cancel_all, struct io_sq_data *sqd)
> >>>  		finish_wait(&tctx->wait, &wait);
> >>>  	} while (1);
> >>>  
> >>> +	/*
> >>> +	 * Reap events from each ctx, otherwise these requests may take
> >>> +	 * resources and prevent other contexts from being moved on.
> >>> +	 */
> >>> +	xa_for_each(&tctx->xa, index, node)
> >>> +		io_iopoll_try_reap_events(node->ctx);
> >>
> >> The main issue here is that if someone isn't polling for them, then we
> > 
> > That is actually what this patch is addressing, :-)
> 
> Right, that part is obvious :)
> 
> >> get to wait for a timeout before they complete. This can delay exit, for
> >> example, as we're now just waiting 30 seconds (or whatever the timeout
> >> is on the underlying device) for them to get timed out before exit can
> >> finish.
> > 
> > For the issue on null_blk, device timeout handler provides
> > forward-progress, such as requests are released, so new IO can be
> > handled.
> > 
> > However, not all devices support timeout, such as virtio device.
> 
> That's a bug in the driver, you cannot sanely support polled IO and not
> be able to deal with timeouts. Someone HAS to reap the requests and
> there are only two things that can do that - the application doing the
> polled IO, or if that doesn't happen, a timeout.

OK, then device driver timeout handler has new responsibility of covering
userspace accident, :-)

We may document this requirement for driver.

So far the only one should be virtio-blk, and the two virtio storage
drivers never implement timeout handler.

> 
> > Here we just call io_iopoll_try_reap_events() to poll submitted IOs
> > for releasing resources, so no need to rely on device timeout handler
> > any more, and the extra exit delay can be avoided.
> > 
> > But io_iopoll_try_reap_events() may not be enough because io_wq
> > associated with current context can get released resource immediately,
> > then new IOs are submitted successfully, but who can poll these new
> > submitted IOs, then all device resources can be held by this (freed)io_wq
> > for nothing.
> > 
> > I guess we may have to take the approach in patch V2 by only canceling
> > polled IO for avoiding the thread_exit regression, or other ideas?
> 
> Ideally the behavior seems like it should be that if a task goes away,
> any pending polled IO it has should be reaped. With the above notion
> that a driver supporting poll absolutely must be able to deal with
> timeouts, it's not a strict requirement as we know that requests will be
> reaped.

Then looks the io_uring fix is less important, and I will see if one
easy fix can be figured out, one way is to reap event when exiting both
current task and the associated io_wq.

Thanks,
Ming

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
