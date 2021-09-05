Return-Path: <SRS0=SKE2=N3=lists.linux-foundation.org=virtualization-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5B1E5C433EF
	for <virtualization@archiver.kernel.org>; Sun,  5 Sep 2021 15:15:30 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 04C5960C51
	for <virtualization@archiver.kernel.org>; Sun,  5 Sep 2021 15:15:29 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org 04C5960C51
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id B88B080E43;
	Sun,  5 Sep 2021 15:15:29 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
	by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id wgXUUkQ5z04R; Sun,  5 Sep 2021 15:15:28 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp1.osuosl.org (Postfix) with ESMTPS id 5080B80E0D;
	Sun,  5 Sep 2021 15:15:28 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 217F7C0010;
	Sun,  5 Sep 2021 15:15:28 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id BFAE2C000E
 for <virtualization@lists.linux-foundation.org>;
 Sun,  5 Sep 2021 15:15:26 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id 97C9180E0D
 for <virtualization@lists.linux-foundation.org>;
 Sun,  5 Sep 2021 15:15:26 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id hdVqs9Qz6zKW
 for <virtualization@lists.linux-foundation.org>;
 Sun,  5 Sep 2021 15:15:26 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [216.205.24.124])
 by smtp1.osuosl.org (Postfix) with ESMTPS id 0003880DF7
 for <virtualization@lists.linux-foundation.org>;
 Sun,  5 Sep 2021 15:15:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1630854924;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=5ZzmZ3cm/kvau4n2g5RTLrehaLVkdjZ73wl5vRun3Qc=;
 b=jSK9066dndq/16yyZBjVD5G0DhGL841NBQX95/08sI4ETdDbUXTWGI8788lkGLXBurmWa3
 eic/dwJ7/bEGq9U6YkgPzMlp+mwLEhKpXO2rDPnAPevhFIrHvcAbJrIw6SUHOfZDNZw2Hu
 Id2QV8oeQD0UGizoVFqZbUWG6vS3P6Q=
Received: from mail-ed1-f72.google.com (mail-ed1-f72.google.com
 [209.85.208.72]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-231-uAvAcOBONVGScHoMaDsKMQ-1; Sun, 05 Sep 2021 11:15:23 -0400
X-MC-Unique: uAvAcOBONVGScHoMaDsKMQ-1
Received: by mail-ed1-f72.google.com with SMTP id
 w18-20020aa7cb52000000b003c95870200fso2272004edt.16
 for <virtualization@lists.linux-foundation.org>;
 Sun, 05 Sep 2021 08:15:23 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to;
 bh=5ZzmZ3cm/kvau4n2g5RTLrehaLVkdjZ73wl5vRun3Qc=;
 b=qFOdFDHuBiyeXzyaymddLetLe1U/K6WUVzZBBb7hskl0PjdoAj6dDRAs5Bo5gfV8G7
 OhXOSJmLME9MjYcRf2qiMBY7ZFkAKVPqWz4mDhUmgIB27EzxshDKn2IHP9GXumIk6QxJ
 JMJzsCx8gDrVPN7Ozmu9lIkfHYwZKXY8Gkia9Xr9RoRcxahaQA7VaM0SwYeCS6cAUrM6
 SY5OZzUzjAdjFy79mS2ZXPpWxvcfMS9kKACRctxgiR0G5CXz1fV1edLz/8hTkoxa95kj
 5mVJaNsFHB8pQACIZvRLB515nWex82mezO5IDMkLp7bEwXXVxoxfInKiSaM3A+blCuo+
 f5lQ==
X-Gm-Message-State: AOAM532ZoIh5A9PaIkw4BYOGVaSV1dKu6GdXzAk7jazIdke2qQj39Inn
 lTwekxT3+hzRTr/YqN7yorzM3rqaeZqMHypEAXDHIErpIYgDbFSavi06ZQIENpgqxu+/aPdOUq9
 wqMha6LO9aTmki0SXXxAz/K4M1kwPoWEeT82eIs2N3w==
X-Received: by 2002:a17:906:1f54:: with SMTP id
 d20mr9200343ejk.48.1630854922110; 
 Sun, 05 Sep 2021 08:15:22 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJzWbCojxNISr+mKnf+beM5xR3SEos+shGuS9gvYwwtR/FWexU0zALsrFPLXDAs6YgRpFnkV0Q==
X-Received: by 2002:a17:906:1f54:: with SMTP id
 d20mr9200330ejk.48.1630854921973; 
 Sun, 05 Sep 2021 08:15:21 -0700 (PDT)
Received: from redhat.com ([2.55.131.183])
 by smtp.gmail.com with ESMTPSA id cf11sm2997982edb.65.2021.09.05.08.15.18
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 05 Sep 2021 08:15:20 -0700 (PDT)
Date: Sun, 5 Sep 2021 11:15:16 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Leon Romanovsky <leon@kernel.org>
Subject: Re: [PATCH v3 1/1] virtio-blk: add num_request_queues module parameter
Message-ID: <20210905111415-mutt-send-email-mst@kernel.org>
References: <20210902204622.54354-1-mgurtovoy@nvidia.com>
 <YTR12AHOGs1nhfz1@unreal>
 <b2e60035-2e63-3162-6222-d8c862526a28@gmail.com>
 <YTSZ6CYM6BCsbVmk@unreal>
MIME-Version: 1.0
In-Reply-To: <YTSZ6CYM6BCsbVmk@unreal>
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=mst@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Disposition: inline
Cc: Max Gurtovoy <mgurtovoy@nvidia.com>, linux-block@vger.kernel.org,
 kvm@vger.kernel.org, israelr@nvidia.com, nitzanc@nvidia.com,
 virtualization@lists.linux-foundation.org, hch@infradead.org,
 Chaitanya Kulkarni <ckulkarnilinux@gmail.com>, axboe@kernel.dk,
 stefanha@redhat.com, oren@nvidia.com
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

On Sun, Sep 05, 2021 at 01:20:24PM +0300, Leon Romanovsky wrote:
> On Sun, Sep 05, 2021 at 01:49:46AM -0700, Chaitanya Kulkarni wrote:
> > 
> > On 9/5/2021 12:46 AM, Leon Romanovsky wrote:
> > > > +static unsigned int num_request_queues;
> > > > +module_param_cb(num_request_queues, &queue_count_ops, &num_request_queues,
> > > > +		0644);
> > > > +MODULE_PARM_DESC(num_request_queues,
> > > > +		 "Number of request queues to use for blk device. Should > 0");
> > > > +
> > > Won't it limit all virtio block devices to the same limit?
> > > 
> > > It is very common to see multiple virtio-blk devices on the same system
> > > and they probably need different limits.
> > > 
> > > Thanks
> > 
> > 
> > Without looking into the code, that can be done adding a configfs
> > 
> > interface and overriding a global value (module param) when it is set from
> > 
> > configfs.
> 
> So why should we do double work instead of providing one working
> interface from the beginning?
> 
> Thanks
> 
> > 
> > 

The main way to do it is really from the hypervisor. This one
is a pretty blunt instrument, Max here says it's useful to reduce
memory usage of the driver. If that's the usecase then a global limit
seems sufficient.

-- 
MST

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
