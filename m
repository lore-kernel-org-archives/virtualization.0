Return-Path: <SRS0=Yk2c=PM=lists.linux-foundation.org=virtualization-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 46FCFC433F5
	for <virtualization@archiver.kernel.org>; Sun, 24 Oct 2021 15:49:13 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id EE6B960F9C
	for <virtualization@archiver.kernel.org>; Sun, 24 Oct 2021 15:49:12 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org EE6B960F9C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id B2F3780B1F;
	Sun, 24 Oct 2021 15:49:12 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
	by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id DWDED2EbK6v1; Sun, 24 Oct 2021 15:49:11 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp1.osuosl.org (Postfix) with ESMTPS id 3833780A84;
	Sun, 24 Oct 2021 15:49:11 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 14480C0019;
	Sun, 24 Oct 2021 15:49:11 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 00CFEC000E
 for <virtualization@lists.linux-foundation.org>;
 Sun, 24 Oct 2021 15:49:09 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id CFE1440173
 for <virtualization@lists.linux-foundation.org>;
 Sun, 24 Oct 2021 15:49:09 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp4.osuosl.org (amavisd-new);
 dkim=pass (1024-bit key) header.d=redhat.com
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id 4QayeIsYmDem
 for <virtualization@lists.linux-foundation.org>;
 Sun, 24 Oct 2021 15:49:08 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [216.205.24.124])
 by smtp4.osuosl.org (Postfix) with ESMTPS id 89B4040220
 for <virtualization@lists.linux-foundation.org>;
 Sun, 24 Oct 2021 15:49:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1635090547;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=iIwcOgxDydqUDrVTMb3PzkTwW1PIvsFo+sr+SoGyWp4=;
 b=Lezx+wcDzENcBlLvsQ0Zckk1dkY2EAnT/lH85Jq2/g0Z06FnwOv0I5SKYGi34FGYqPGMhG
 A2UNpzUG4v7ps6WZiRKlcmEcn3veiSf2XXGtbxGPDfiFSr/5hMwk3TnNUuSX+a1YSHcWjR
 99B9aRdoCb4FeYaHhV/1QGXc9wjSY+w=
Received: from mail-ed1-f71.google.com (mail-ed1-f71.google.com
 [209.85.208.71]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-533-i-OT-1EpPRiCWu9QDppPuQ-1; Sun, 24 Oct 2021 11:49:06 -0400
X-MC-Unique: i-OT-1EpPRiCWu9QDppPuQ-1
Received: by mail-ed1-f71.google.com with SMTP id
 g6-20020a056402424600b003dd2b85563bso5011749edb.7
 for <virtualization@lists.linux-foundation.org>;
 Sun, 24 Oct 2021 08:49:05 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to;
 bh=iIwcOgxDydqUDrVTMb3PzkTwW1PIvsFo+sr+SoGyWp4=;
 b=c+MQ+aJYTGpBTriP7Eblx9UUCIHNSbt555JEu94dn8k8+eEbaTLP+ogOsnYo3QkkuP
 jsuJNmlW2SdXgly39pksVsXlt1LDR6Xt8gmxAnUM6mIECs5LHvRE7pjH2SKTdIGEBXZ5
 KC6BDj8v77gnWxaSY/GrhwDGZ/Tog8QPWdwZH59MEIF0+qVEuqGlZONPyoCCuAe3jfxs
 ZicrrMwGAtGA8pqrdpWnswhBBAcOSbEPKSwHRF56IEyvBPh6sDVRLyd/LJYXUJXy0wQd
 pxjzNy1eojr2d6/nhLWstjeZLPBbDAwZ7/B8gLRtA+tUa11+n0JH1KzR7AbvMlKUNLxL
 /esQ==
X-Gm-Message-State: AOAM532QZjDNGEmpxDWUfQZeVu6DdCalXUa4ZQUHMXZg3Vdu/guQrBte
 JiKuDi2w6hOk50qMBU1HJiYavzpdHTjQ+F1rKDjtcU21rszqXPxsFd5Mvfgndto/HaGYFwzZiHe
 Ylf5nFg5g5napKpVTusBSXDBK2WXKE/mnzgcn4xx5EQ==
X-Received: by 2002:a05:6402:27cd:: with SMTP id
 c13mr18732577ede.377.1635090545011; 
 Sun, 24 Oct 2021 08:49:05 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJwceJaD3mgfUfOcL3JmT6ez6YIJACUuR4rgEbsYq8YD1WUQPLwHGdhd5PCLO6vxePnaWXJKGQ==
X-Received: by 2002:a05:6402:27cd:: with SMTP id
 c13mr18732560ede.377.1635090544850; 
 Sun, 24 Oct 2021 08:49:04 -0700 (PDT)
Received: from redhat.com ([2.55.151.113])
 by smtp.gmail.com with ESMTPSA id j1sm7558360edk.53.2021.10.24.08.49.02
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 24 Oct 2021 08:49:04 -0700 (PDT)
Date: Sun, 24 Oct 2021 11:49:00 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Max Gurtovoy <mgurtovoy@nvidia.com>
Subject: Re: [PATCH] virtio_blk: allow 0 as num_request_queues
Message-ID: <20211024114746-mutt-send-email-mst@kernel.org>
References: <20211024135412.1516393-1-mst@redhat.com>
 <855eb993-074b-24b9-a184-d479bd0b342b@nvidia.com>
 <20211024105841-mutt-send-email-mst@kernel.org>
 <a2060fc7-cc4d-c4d4-e7fe-e4a1e544104f@nvidia.com>
MIME-Version: 1.0
In-Reply-To: <a2060fc7-cc4d-c4d4-e7fe-e4a1e544104f@nvidia.com>
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

On Sun, Oct 24, 2021 at 06:29:59PM +0300, Max Gurtovoy wrote:
> 
> On 10/24/2021 6:11 PM, Michael S. Tsirkin wrote:
> > On Sun, Oct 24, 2021 at 05:19:33PM +0300, Max Gurtovoy wrote:
> > > On 10/24/2021 4:54 PM, Michael S. Tsirkin wrote:
> > > > The default value is 0 meaning "no limit". However if 0
> > > > is specified on the command line it is instead silently
> > > > converted to 1. Further, the value is already validated
> > > > at point of use, there's no point in duplicating code
> > > > validating the value when it is set.
> > > > 
> > > > Simplify the code while making the behaviour more consistent
> > > > by using plain module_param.
> > > > 
> > > > Fixes: 1a662cf6cb9a ("virtio-blk: add num_request_queues module parameter")
> > > > Cc: Max Gurtovoy <mgurtovoy@nvidia.com>
> > > > Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
> > > > ---
> > > >    drivers/block/virtio_blk.c | 14 +-------------
> > > >    1 file changed, 1 insertion(+), 13 deletions(-)
> > > > 
> > > > diff --git a/drivers/block/virtio_blk.c b/drivers/block/virtio_blk.c
> > > > index 6318134aab76..c336d9bb9105 100644
> > > > --- a/drivers/block/virtio_blk.c
> > > > +++ b/drivers/block/virtio_blk.c
> > > > @@ -30,20 +30,8 @@
> > > >    #define VIRTIO_BLK_INLINE_SG_CNT	2
> > > >    #endif
> > > > -static int virtblk_queue_count_set(const char *val,
> > > > -		const struct kernel_param *kp)
> > > > -{
> > > > -	return param_set_uint_minmax(val, kp, 1, nr_cpu_ids);
> > > > -}
> > > > -
> > > > -static const struct kernel_param_ops queue_count_ops = {
> > > > -	.set = virtblk_queue_count_set,
> > > > -	.get = param_get_uint,
> > > > -};
> > > > -
> > > >    static unsigned int num_request_queues;
> > > > -module_param_cb(num_request_queues, &queue_count_ops, &num_request_queues,
> > > > -		0644);
> > > > +module_param(num_request_queues, uint, 0644);
> > > Not the best solution.
> > > 
> > > You can set the param to 1024 but in practice nr_cpu_ids can be 32 for
> > > example.
> > Well your patch does make it possible to know what nr_cpu_ids is.
> > But does it matter? The actual number of queues is still capped
> > by the num_queues of the device. And I'm concerned that some
> > userspace comes to depend on reading back nr_cpu_ids
> > from there, which will cement this as part of ABI instead of
> > being an implementation detail.
> > Exposing the actual number of queues in sysfs might make more sense ...
> > 
> > Generally you suggested embedded as a use-case, and I don't really
> > see lots of embedded userspace poking at this parameter in sysfs.
> > 
> > What I'd like to see, and attempted to achieve here:
> > - avoid code duplication
> > - consistency: some way to specify the parameter but still make it have the default value
> > 
> > Better suggestions are welcome.
> 
> Just change return param_set_uint_minmax(val, kp, 1, nr_cpu_ids);
> 
> to
> 
> return param_set_uint_minmax(val, kp, *0*, nr_cpu_ids);
> 
> The real amount can be exposed by common sysfs.
> 
> We'll extend virtio_driver to have a new callback to return this value. If
> callback doesn't exist - return -1 (unknown value).

That doesn't avoid code duplication - the limit of nr_cpu_ids
is applied twice.

> > 
> > > >    MODULE_PARM_DESC(num_request_queues,
> > > >    		 "Limit the number of request queues to use for blk device. "
> > > >    		 "0 for no limit. "

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
