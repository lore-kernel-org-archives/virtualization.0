Return-Path: <SRS0=Yk2c=PM=lists.linux-foundation.org=virtualization-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 44BDCC433EF
	for <virtualization@archiver.kernel.org>; Sun, 24 Oct 2021 15:12:05 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id AD733604D2
	for <virtualization@archiver.kernel.org>; Sun, 24 Oct 2021 15:12:04 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org AD733604D2
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 67B65402ED;
	Sun, 24 Oct 2021 15:12:04 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
	by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id OB4eylsQcxkp; Sun, 24 Oct 2021 15:12:03 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp4.osuosl.org (Postfix) with ESMTPS id 01FB5402DF;
	Sun, 24 Oct 2021 15:12:02 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id BED15C0019;
	Sun, 24 Oct 2021 15:12:02 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 8B15BC000E
 for <virtualization@lists.linux-foundation.org>;
 Sun, 24 Oct 2021 15:12:01 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id 7E7DC400DD
 for <virtualization@lists.linux-foundation.org>;
 Sun, 24 Oct 2021 15:12:01 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp2.osuosl.org (amavisd-new);
 dkim=pass (1024-bit key) header.d=redhat.com
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id eInsyJ3RCp35
 for <virtualization@lists.linux-foundation.org>;
 Sun, 24 Oct 2021 15:12:00 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [216.205.24.124])
 by smtp2.osuosl.org (Postfix) with ESMTPS id 53019400B5
 for <virtualization@lists.linux-foundation.org>;
 Sun, 24 Oct 2021 15:12:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1635088319;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=Sd2F/rv0/rYPqdyLkTSI2b2h2/QE9BM0Qe4Pjpyf4UM=;
 b=hd1q1KNDbG+43Mdrfl6JMaC4POgcu6FiRsXLRAFOOXtoY3LUbUeVSr0GDw6Awgb2xKvGpg
 QuQXD3ivxlnsoM5M5xywEJ88dIWYjH66HdqyPnjhqKI/4eQk4j/9LdtEW8dcCW0+SKh/GB
 o8dsOjyKMyZE7vkp1gSZQqyWLd1e0L0=
Received: from mail-ed1-f70.google.com (mail-ed1-f70.google.com
 [209.85.208.70]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-489-ytvc6J0HMg2kl9v718sBvw-1; Sun, 24 Oct 2021 11:11:57 -0400
X-MC-Unique: ytvc6J0HMg2kl9v718sBvw-1
Received: by mail-ed1-f70.google.com with SMTP id
 u17-20020a50d511000000b003daa3828c13so7661186edi.12
 for <virtualization@lists.linux-foundation.org>;
 Sun, 24 Oct 2021 08:11:57 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to;
 bh=Sd2F/rv0/rYPqdyLkTSI2b2h2/QE9BM0Qe4Pjpyf4UM=;
 b=akWbeHfUgeyCWyfmcWLBBOwnRbHxk1g6FpkCNORN2vesMOcztBuS2mSW7u5uiRDj5Q
 U+aeOp3t/It2xAWeQcNqO0eq6wX7l34caiaoaMsQ8mNJvo644D/tJ1Wq7G/kMWcXud2T
 KoGn7VeIv26bkZq9wtIlRF2Yptq3pJT8wRjNs1FbIMOCyhG9tph7VRqtLyI5wX4z/ojR
 LP/4OGKYWZpqp3JTs5SwCu6LBtvWLQh2K+IbkK9SzkOQODBjijQ1+PDN64fRSmw6XR3U
 4irGI0MSSy1z53lBTPMk9hAmBOlMXuKzuYcfzeMb1KqkUxgRCotfFqBCXatQxRVxsPXq
 NPmA==
X-Gm-Message-State: AOAM533CJD6ToBJMEAF/wm8Zjhjtwi9ag+rVyUx9mTC1tjr3k18IujsM
 HewBGG23yC41Vjr8zom4j3FCQEIoKf79trYBY7ZtNXa47ZVpuH3uVc7mX+G5I1TzGBDo0w/EsKk
 TN/4GyWqqExk9iqYPSI2p0usJimM7DrFRFWaMi3Vy4A==
X-Received: by 2002:a17:906:2346:: with SMTP id
 m6mr15112447eja.512.1635088316552; 
 Sun, 24 Oct 2021 08:11:56 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJxnbdd6RsZKytm29Sr1ykC3If/f4opiXGmBqrEf8/Foj95mR0OgBYQPl3pTDCqV4RSW7O4AMg==
X-Received: by 2002:a17:906:2346:: with SMTP id
 m6mr15112407eja.512.1635088316246; 
 Sun, 24 Oct 2021 08:11:56 -0700 (PDT)
Received: from redhat.com ([2.55.151.113])
 by smtp.gmail.com with ESMTPSA id gb3sm4479930ejc.81.2021.10.24.08.11.53
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 24 Oct 2021 08:11:55 -0700 (PDT)
Date: Sun, 24 Oct 2021 11:11:51 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Max Gurtovoy <mgurtovoy@nvidia.com>
Subject: Re: [PATCH] virtio_blk: allow 0 as num_request_queues
Message-ID: <20211024105841-mutt-send-email-mst@kernel.org>
References: <20211024135412.1516393-1-mst@redhat.com>
 <855eb993-074b-24b9-a184-d479bd0b342b@nvidia.com>
MIME-Version: 1.0
In-Reply-To: <855eb993-074b-24b9-a184-d479bd0b342b@nvidia.com>
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=mst@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Disposition: inline
Cc: Jens Axboe <axboe@kernel.dk>, linux-kernel@vger.kernel.org,
 virtualization@lists.linux-foundation.org, linux-block@vger.kernel.org,
 Stefan Hajnoczi <stefanha@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>
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

On Sun, Oct 24, 2021 at 05:19:33PM +0300, Max Gurtovoy wrote:
> 
> On 10/24/2021 4:54 PM, Michael S. Tsirkin wrote:
> > The default value is 0 meaning "no limit". However if 0
> > is specified on the command line it is instead silently
> > converted to 1. Further, the value is already validated
> > at point of use, there's no point in duplicating code
> > validating the value when it is set.
> > 
> > Simplify the code while making the behaviour more consistent
> > by using plain module_param.
> > 
> > Fixes: 1a662cf6cb9a ("virtio-blk: add num_request_queues module parameter")
> > Cc: Max Gurtovoy <mgurtovoy@nvidia.com>
> > Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
> > ---
> >   drivers/block/virtio_blk.c | 14 +-------------
> >   1 file changed, 1 insertion(+), 13 deletions(-)
> > 
> > diff --git a/drivers/block/virtio_blk.c b/drivers/block/virtio_blk.c
> > index 6318134aab76..c336d9bb9105 100644
> > --- a/drivers/block/virtio_blk.c
> > +++ b/drivers/block/virtio_blk.c
> > @@ -30,20 +30,8 @@
> >   #define VIRTIO_BLK_INLINE_SG_CNT	2
> >   #endif
> > -static int virtblk_queue_count_set(const char *val,
> > -		const struct kernel_param *kp)
> > -{
> > -	return param_set_uint_minmax(val, kp, 1, nr_cpu_ids);
> > -}
> > -
> > -static const struct kernel_param_ops queue_count_ops = {
> > -	.set = virtblk_queue_count_set,
> > -	.get = param_get_uint,
> > -};
> > -
> >   static unsigned int num_request_queues;
> > -module_param_cb(num_request_queues, &queue_count_ops, &num_request_queues,
> > -		0644);
> > +module_param(num_request_queues, uint, 0644);
> 
> Not the best solution.
> 
> You can set the param to 1024 but in practice nr_cpu_ids can be 32 for
> example.

Well your patch does make it possible to know what nr_cpu_ids is.
But does it matter? The actual number of queues is still capped
by the num_queues of the device. And I'm concerned that some
userspace comes to depend on reading back nr_cpu_ids
from there, which will cement this as part of ABI instead of
being an implementation detail.
Exposing the actual number of queues in sysfs might make more sense ...

Generally you suggested embedded as a use-case, and I don't really
see lots of embedded userspace poking at this parameter in sysfs.

What I'd like to see, and attempted to achieve here:
- avoid code duplication
- consistency: some way to specify the parameter but still make it have the default value

Better suggestions are welcome.

> 
> >   MODULE_PARM_DESC(num_request_queues,
> >   		 "Limit the number of request queues to use for blk device. "
> >   		 "0 for no limit. "

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
