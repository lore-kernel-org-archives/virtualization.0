Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 239E9C54EE9
	for <virtualization@archiver.kernel.org>; Thu, 22 Sep 2022 17:01:38 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp2.osuosl.org (Postfix) with ESMTP id 9E8674014A;
	Thu, 22 Sep 2022 17:01:37 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org 9E8674014A
Authentication-Results: smtp2.osuosl.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=eCZi3g29
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
	by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id PFCJzf901aUt; Thu, 22 Sep 2022 17:01:36 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp2.osuosl.org (Postfix) with ESMTPS id 3F79641029;
	Thu, 22 Sep 2022 17:01:36 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org 3F79641029
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 16E81C0033;
	Thu, 22 Sep 2022 17:01:36 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [IPv6:2605:bc80:3010::138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 2C833C0032
 for <virtualization@lists.linux-foundation.org>;
 Thu, 22 Sep 2022 17:01:31 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id ED39C83F74
 for <virtualization@lists.linux-foundation.org>;
 Thu, 22 Sep 2022 17:01:30 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org ED39C83F74
Authentication-Results: smtp1.osuosl.org;
 dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com
 header.a=rsa-sha256 header.s=mimecast20190719 header.b=eCZi3g29
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id YKUipZmIAuCU
 for <virtualization@lists.linux-foundation.org>;
 Thu, 22 Sep 2022 17:01:30 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 394AA83F67
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.133.124])
 by smtp1.osuosl.org (Postfix) with ESMTPS id 394AA83F67
 for <virtualization@lists.linux-foundation.org>;
 Thu, 22 Sep 2022 17:01:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1663866089;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=U9Sr8YICdCu6GQF/2wHQLM2nRHwhuk3bcum4Id2WWLU=;
 b=eCZi3g293ktiN31Enl/bmyzfVIybJXvZwp1cp8zYQ3XCA68xC5YberGLLoKqxT0F/3xyX5
 y912w5BrJmvwIb0+rgLzZUlB3wtv7g9j3WaVyOWyZm48nrqS1+QyzXZu7kywtgbLxxBqoT
 vh6ZzKirQTeKBY3aqk+luP8S2FTEmiA=
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-126-jxQgouiuNruFhTmiiGZElQ-1; Thu, 22 Sep 2022 13:01:26 -0400
X-MC-Unique: jxQgouiuNruFhTmiiGZElQ-1
Received: by mail-wr1-f71.google.com with SMTP id
 c21-20020adfa315000000b0022adc2a2edaso3417749wrb.0
 for <virtualization@lists.linux-foundation.org>;
 Thu, 22 Sep 2022 10:01:26 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date;
 bh=U9Sr8YICdCu6GQF/2wHQLM2nRHwhuk3bcum4Id2WWLU=;
 b=kippkS0DfTYl8fXydK1CxYbwxeF+Vi0ZOhFk22IBlQY+K+y3+hLNs46ocgDJKiw950
 TpdLn4DW4t+OsAE+u7Ux8RggT3JZf4j7JbPBagmGJNdkHYyruuJMtqecSzBffQVvDVDH
 z2tzB2EiUnjlEfy/9YYsAKwrwMHZTnIfaBckzxxyv23s+X5dfwxg+hpk+1gLKYCd5xIb
 detTIRlgn60Ab6bsZS3lStpkj2k9LBZZWci3odWKoXp8cCuYfDXvdXuopXlLhb5oFeiP
 WnryPDWSzB+2HRX9HITY/34Z6t6rpJkOLwoHx+VEzpuBtfF2499J9xYUZ/Sz9agMQiza
 Dotw==
X-Gm-Message-State: ACrzQf3euobNsPdeQZ0mOGf/OSXpKNTrprALB9XmkRuPWwaTU0eVPF+9
 sUuf4mRmKgfH0tQq1vzv/yS51YpjokM770EcPFBSz0p+QteV5wWwmW8SDYmx9f90BDB1p56M6xW
 JykaH0gmqzBoB4/VyEDwnvPXjw0jXyUyMdU/2/qz09A==
X-Received: by 2002:a5d:6388:0:b0:228:c792:aabe with SMTP id
 p8-20020a5d6388000000b00228c792aabemr2669934wru.689.1663866085184; 
 Thu, 22 Sep 2022 10:01:25 -0700 (PDT)
X-Google-Smtp-Source: AMsMyM4sIQov4Lsx8/ngj+iGn4/VThzrMM0tkQAqwA6Ev7a1KO6j4dy1ldlQi7uOpVH6LWOm6CaapA==
X-Received: by 2002:a5d:6388:0:b0:228:c792:aabe with SMTP id
 p8-20020a5d6388000000b00228c792aabemr2669912wru.689.1663866084887; 
 Thu, 22 Sep 2022 10:01:24 -0700 (PDT)
Received: from redhat.com ([2.55.16.18]) by smtp.gmail.com with ESMTPSA id
 l18-20020a05600c27d200b003b4868eb6bbsm53966wmb.23.2022.09.22.10.01.21
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 22 Sep 2022 10:01:24 -0700 (PDT)
Date: Thu, 22 Sep 2022 13:01:19 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Suwan Kim <suwan.kim027@gmail.com>
Subject: Re: [PATCH v2] virtio-blk: Fix WARN_ON_ONCE in virtio_queue_rq()
Message-ID: <20220922130102-mutt-send-email-mst@kernel.org>
References: <20220830150153.12627-1-suwan.kim027@gmail.com>
 <20220831124441.ai5xratdpemiqmyv@quentin>
 <CAFNWusaxT38RyQBFZu6jN_kaL3p3hTQ0oXPQZkZdEJ3VjUMVWg@mail.gmail.com>
 <20220922125632-mutt-send-email-mst@kernel.org>
MIME-Version: 1.0
In-Reply-To: <20220922125632-mutt-send-email-mst@kernel.org>
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Disposition: inline
Cc: linux-block@vger.kernel.org, Pankaj Raghav <pankydev8@gmail.com>,
 acourbot@chromium.org, virtualization@lists.linux-foundation.org,
 hch@infradead.org, stefanha@redhat.com, pbonzini@redhat.com
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

On Thu, Sep 22, 2022 at 12:57:01PM -0400, Michael S. Tsirkin wrote:
> On Thu, Sep 22, 2022 at 11:45:15PM +0900, Suwan Kim wrote:
> > Hi Michael,
> > 
> > Can this patch be merged to the next rc?
> > We received two bug reports about this issue and need to fix it.
> > 
> > Regards,
> > Suwan Kim
> > 
> > 
> > On Wed, Aug 31, 2022 at 9:44 PM Pankaj Raghav <pankydev8@gmail.com> wrote:
> > >
> > > On Wed, Aug 31, 2022 at 12:01:53AM +0900, Suwan Kim wrote:
> > > > If a request fails at virtio_queue_rqs(), it is inserted to requeue_list
> > > > and passed to virtio_queue_rq(). Then blk_mq_start_request() can be called
> > > > again at virtio_queue_rq() and trigger WARN_ON_ONCE like below trace because
> > > > request state was already set to MQ_RQ_IN_FLIGHT in virtio_queue_rqs()
> > > > despite the failure.
> > > >
> > > > To avoid calling blk_mq_start_request() twice, This patch moves the
> > > > execution of blk_mq_start_request() to the end of virtblk_prep_rq().
> > > > And instead of requeuing failed request to plug list in the error path of
> > > > virtblk_add_req_batch(), it uses blk_mq_requeue_request() to change failed
> > > > request state to MQ_RQ_IDLE. Then virtblk can safely handle the request
> > > > on the next trial.
> > > >
> > > > Fixes: 0e9911fa768f ("virtio-blk: support mq_ops->queue_rqs()")
> > > > Reported-by: Alexandre Courbot <acourbot@chromium.org>
> > > > Tested-by: Alexandre Courbot <acourbot@chromium.org>
> > > > Signed-off-by: Suwan Kim <suwan.kim027@gmail.com>
> > > > ---
> > > Looks good.
> > > Reviewed-by: Pankaj Raghav <p.raghav@samsung.com>
> 
> Stefan, Paolo, any feedback here?

Oh, Stefan acked. Sorry. Will queue now.


> -- 
> MST

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
