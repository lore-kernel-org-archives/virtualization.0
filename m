Return-Path: <SRS0=ZIIO=PN=lists.linux-foundation.org=virtualization-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 77557C433EF
	for <virtualization@archiver.kernel.org>; Mon, 25 Oct 2021 21:10:09 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 0D9C460E05
	for <virtualization@archiver.kernel.org>; Mon, 25 Oct 2021 21:10:08 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org 0D9C460E05
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id B92334048A;
	Mon, 25 Oct 2021 21:10:08 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
	by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id 5hQQQihJNQmA; Mon, 25 Oct 2021 21:10:07 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp4.osuosl.org (Postfix) with ESMTPS id AAC164018E;
	Mon, 25 Oct 2021 21:10:06 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 74608C0019;
	Mon, 25 Oct 2021 21:10:06 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [IPv6:2605:bc80:3010::138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 0ACABC000E
 for <virtualization@lists.linux-foundation.org>;
 Mon, 25 Oct 2021 21:10:05 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id EEAB480DAC
 for <virtualization@lists.linux-foundation.org>;
 Mon, 25 Oct 2021 21:10:04 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp1.osuosl.org (amavisd-new);
 dkim=pass (1024-bit key) header.d=redhat.com
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id J6oMf8JUBpGk
 for <virtualization@lists.linux-foundation.org>;
 Mon, 25 Oct 2021 21:10:03 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [216.205.24.124])
 by smtp1.osuosl.org (Postfix) with ESMTPS id B650480D43
 for <virtualization@lists.linux-foundation.org>;
 Mon, 25 Oct 2021 21:10:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1635196202;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=jiCj1Dd83x3citihACVoPC1hMPCA+Vsk0IBZb4n1UuI=;
 b=Wif2wuwEPBfRwRvzDtBGoLTfyikVlrgPFBx5G2+WpskD6kZ7VxzlrHe8vQipxUKxcCG6Xa
 ODOo0H1+05mZ8wBg9tAMVN60lJBjtAg5kNJW4wbhSBGAWFvf8PAUvWIBrmv7hth9CYWyAQ
 v+YHWyAjyYW34oUdusSvpXy+B7IuYX4=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-171-kMzx0uvFP9qHVlNPfg1CnA-1; Mon, 25 Oct 2021 17:10:01 -0400
X-MC-Unique: kMzx0uvFP9qHVlNPfg1CnA-1
Received: by mail-wm1-f69.google.com with SMTP id
 b197-20020a1c1bce000000b0032ca040eb40so158754wmb.7
 for <virtualization@lists.linux-foundation.org>;
 Mon, 25 Oct 2021 14:10:00 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to;
 bh=jiCj1Dd83x3citihACVoPC1hMPCA+Vsk0IBZb4n1UuI=;
 b=Ri7BO7brEv4PMCrV/4w1VBSsbTK66sp0vH8TGpmDY5yT7BKqyI9c16NwDs4SsoSeQW
 qWFGRHLH3FssWCyowDsbye1EkaifHQM3Vn+Z20VbJ0QCRuo/BS+906D7hqdKq+EcBN1Y
 AzzvEYJBMW4tHWk5KSVVltL0o2wUyE8V1OIrbKdYawk2ipyxkpeASwZWhMoeLu01Gpfv
 SDYziW/wjFjShLExXlDcndFl2kBxYcS7s87RMJkPWRcfMlOMH/Nt0yxO+4euKVP4wjiW
 tOvGyZrP4aV6u3eR+zvwg2KRncDmHhcCCLir6RDmOd8R8caQ1rGZvO3RbD29r+52H4Am
 CFzQ==
X-Gm-Message-State: AOAM533xuevM4oKp6sUno1+imkO4YCcqvR564d7/HdTwDdAE4ccx7qYI
 kMUxc5+UlJ4Htp5Jujuj76uyahyoHKVyGdAxiNjD1uGY0FfWc5fIWYjVb8uAbXR4aP7piSdjRJx
 0/HhL0WvV3A/60yNrlyiXPRsSyexhO9m66CvOJSqiAQ==
X-Received: by 2002:a1c:a1c2:: with SMTP id
 k185mr10408885wme.113.1635196199910; 
 Mon, 25 Oct 2021 14:09:59 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJynvPh5e4Ewz12tJb9reo5vEF9DMt6k3ovDZHl4BXPt99sYAyEpdp3ALKCkNCUdugMBbNou4Q==
X-Received: by 2002:a1c:a1c2:: with SMTP id
 k185mr10408870wme.113.1635196199725; 
 Mon, 25 Oct 2021 14:09:59 -0700 (PDT)
Received: from redhat.com ([2.55.12.86])
 by smtp.gmail.com with ESMTPSA id u10sm13879565wrm.34.2021.10.25.14.09.57
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 25 Oct 2021 14:09:58 -0700 (PDT)
Date: Mon, 25 Oct 2021 17:09:55 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Max Gurtovoy <mgurtovoy@nvidia.com>
Subject: Re: [PATCH] virtio_blk: allow 0 as num_request_queues
Message-ID: <20211025170516-mutt-send-email-mst@kernel.org>
References: <20211024135412.1516393-1-mst@redhat.com>
 <855eb993-074b-24b9-a184-d479bd0b342b@nvidia.com>
 <20211024105841-mutt-send-email-mst@kernel.org>
 <a2060fc7-cc4d-c4d4-e7fe-e4a1e544104f@nvidia.com>
 <20211024114746-mutt-send-email-mst@kernel.org>
 <ad3d2af0-08ef-f878-c6cb-9ceaa42166d3@nvidia.com>
MIME-Version: 1.0
In-Reply-To: <ad3d2af0-08ef-f878-c6cb-9ceaa42166d3@nvidia.com>
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

On Mon, Oct 25, 2021 at 01:30:19AM +0300, Max Gurtovoy wrote:
> 
> On 10/24/2021 6:49 PM, Michael S. Tsirkin wrote:
> > On Sun, Oct 24, 2021 at 06:29:59PM +0300, Max Gurtovoy wrote:
> > > On 10/24/2021 6:11 PM, Michael S. Tsirkin wrote:
> > > > On Sun, Oct 24, 2021 at 05:19:33PM +0300, Max Gurtovoy wrote:
> > > > > On 10/24/2021 4:54 PM, Michael S. Tsirkin wrote:
> > > > > > The default value is 0 meaning "no limit". However if 0
> > > > > > is specified on the command line it is instead silently
> > > > > > converted to 1. Further, the value is already validated
> > > > > > at point of use, there's no point in duplicating code
> > > > > > validating the value when it is set.
> > > > > > 
> > > > > > Simplify the code while making the behaviour more consistent
> > > > > > by using plain module_param.
> > > > > > 
> > > > > > Fixes: 1a662cf6cb9a ("virtio-blk: add num_request_queues module parameter")
> > > > > > Cc: Max Gurtovoy <mgurtovoy@nvidia.com>
> > > > > > Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
> > > > > > ---
> > > > > >     drivers/block/virtio_blk.c | 14 +-------------
> > > > > >     1 file changed, 1 insertion(+), 13 deletions(-)
> > > > > > 
> > > > > > diff --git a/drivers/block/virtio_blk.c b/drivers/block/virtio_blk.c
> > > > > > index 6318134aab76..c336d9bb9105 100644
> > > > > > --- a/drivers/block/virtio_blk.c
> > > > > > +++ b/drivers/block/virtio_blk.c
> > > > > > @@ -30,20 +30,8 @@
> > > > > >     #define VIRTIO_BLK_INLINE_SG_CNT	2
> > > > > >     #endif
> > > > > > -static int virtblk_queue_count_set(const char *val,
> > > > > > -		const struct kernel_param *kp)
> > > > > > -{
> > > > > > -	return param_set_uint_minmax(val, kp, 1, nr_cpu_ids);
> > > > > > -}
> > > > > > -
> > > > > > -static const struct kernel_param_ops queue_count_ops = {
> > > > > > -	.set = virtblk_queue_count_set,
> > > > > > -	.get = param_get_uint,
> > > > > > -};
> > > > > > -
> > > > > >     static unsigned int num_request_queues;
> > > > > > -module_param_cb(num_request_queues, &queue_count_ops, &num_request_queues,
> > > > > > -		0644);
> > > > > > +module_param(num_request_queues, uint, 0644);
> > > > > Not the best solution.
> > > > > 
> > > > > You can set the param to 1024 but in practice nr_cpu_ids can be 32 for
> > > > > example.
> > > > Well your patch does make it possible to know what nr_cpu_ids is.
> > > > But does it matter? The actual number of queues is still capped
> > > > by the num_queues of the device. And I'm concerned that some
> > > > userspace comes to depend on reading back nr_cpu_ids
> > > > from there, which will cement this as part of ABI instead of
> > > > being an implementation detail.
> > > > Exposing the actual number of queues in sysfs might make more sense ...
> > > > 
> > > > Generally you suggested embedded as a use-case, and I don't really
> > > > see lots of embedded userspace poking at this parameter in sysfs.
> > > > 
> > > > What I'd like to see, and attempted to achieve here:
> > > > - avoid code duplication
> > > > - consistency: some way to specify the parameter but still make it have the default value
> > > > 
> > > > Better suggestions are welcome.
> > > Just change return param_set_uint_minmax(val, kp, 1, nr_cpu_ids);
> > > 
> > > to
> > > 
> > > return param_set_uint_minmax(val, kp, *0*, nr_cpu_ids);
> > > 
> > > The real amount can be exposed by common sysfs.
> > > 
> > > We'll extend virtio_driver to have a new callback to return this value. If
> > > callback doesn't exist - return -1 (unknown value).
> > That doesn't avoid code duplication - the limit of nr_cpu_ids
> > is applied twice.
> 
> It's a small logic duplication and not code duplication.
> 
> The param_set_uint_minmax is a new API to make sure that the value is in the
> limit you set it, and it will only called if the user explicitly set the
> module parameter.
> 
> In your case, you allow setting 0 value in the comment for the module
> parameter. And this is the oneline change I suggested above.
> 
> The second check in the code is for the case that the user didn't set the
> module parameter explicitly and we need to make sure we don't set num_queues
> to 0 (the default value).
> 
> So I'm ok with these 2 checks.
> 
> Adding a sysfs entry might be nice as incremental patch.
> 
> Let me know if needed, I'll make sure it will be implemented.

No idea. Frankly I'm not sure I fully get the usecase for this feature
but we have an ack from people who know much more about storage. I don't
really want to have too much tricky code dealing with this cornercase
though, so I'd like this as simple as possible.

If you have a mind to implement the sysfs attribute, go ahead - if
someone acks I'll merge it no problem.


> > 
> > > > > >     MODULE_PARM_DESC(num_request_queues,
> > > > > >     		 "Limit the number of request queues to use for blk device. "
> > > > > >     		 "0 for no limit. "

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
