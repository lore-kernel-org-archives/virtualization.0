Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id ECE8CC4332F
	for <virtualization@archiver.kernel.org>; Wed, 16 Nov 2022 07:11:50 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 6CCBA81E5D;
	Wed, 16 Nov 2022 07:11:50 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 6CCBA81E5D
Authentication-Results: smtp1.osuosl.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=Axqcl7/s
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
	by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id IjQHjQW0o4un; Wed, 16 Nov 2022 07:11:49 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp1.osuosl.org (Postfix) with ESMTPS id CDE9981E58;
	Wed, 16 Nov 2022 07:11:48 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org CDE9981E58
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 8BE31C0033;
	Wed, 16 Nov 2022 07:11:48 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [IPv6:2605:bc80:3010::137])
 by lists.linuxfoundation.org (Postfix) with ESMTP id E2D46C002D
 for <virtualization@lists.linux-foundation.org>;
 Wed, 16 Nov 2022 07:11:46 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id B4EF2400CA
 for <virtualization@lists.linux-foundation.org>;
 Wed, 16 Nov 2022 07:11:46 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org B4EF2400CA
Authentication-Results: smtp4.osuosl.org;
 dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com
 header.a=rsa-sha256 header.s=mimecast20190719 header.b=Axqcl7/s
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id S6OCT_r8rRZV
 for <virtualization@lists.linux-foundation.org>;
 Wed, 16 Nov 2022 07:11:45 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org 6694140091
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.129.124])
 by smtp4.osuosl.org (Postfix) with ESMTPS id 6694140091
 for <virtualization@lists.linux-foundation.org>;
 Wed, 16 Nov 2022 07:11:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1668582704;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=YeR1HH8eLiqndTkVdEHxtOh0ZX+ybGtO62/lbQhsynA=;
 b=Axqcl7/s9iRwLLdi0lD0CJNo3hmy46+pmbdtRcBzt/OzBfuZN7eJyxZNV0BJVD+R67FZM8
 414BTnSLq+NRufb5+Caw/HppsQmUzP799FbitroSiaep/gxqd9+TXUQVvjHg3S/pVzeUoD
 PrNsefYvlKxnSNZxYM1cHuQNPJ5d+mU=
Received: from mail-oi1-f198.google.com (mail-oi1-f198.google.com
 [209.85.167.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-611-a7cTiKL1PJaaKgW-5gYxLw-1; Wed, 16 Nov 2022 02:11:42 -0500
X-MC-Unique: a7cTiKL1PJaaKgW-5gYxLw-1
Received: by mail-oi1-f198.google.com with SMTP id
 r65-20020acaf344000000b0035a1d791805so5731243oih.19
 for <virtualization@lists.linux-foundation.org>;
 Tue, 15 Nov 2022 23:11:42 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=YeR1HH8eLiqndTkVdEHxtOh0ZX+ybGtO62/lbQhsynA=;
 b=5Zb3CGuYqoSad4u1mMpxhXx3BDA62acgdu2V+aoptwuPkjmrFxaM8eXye5zXE1niGU
 IMewZL2f4yow3G2oskUVyBqAkYTC7zD14eXxKTlVHjo+9yWxG9PSTYt2r+NkWfXbgHcC
 5sUVJRjkU4Xy0086p1SRNex3NezusbCR9tfusGkVqGP7CVOAbaNgW5Pa7K/gHN47VHBz
 lA+5ACWz6xpWb5xUEmoZYS2SyAjpv1Vu/HmqzZpBEndhvIOTHvcbtDjCCZ3zQT66FuJD
 A0e4KZJ0lRPJtQLOOFhU0vpwtB/8dJPhwFQzQmzFdcU8G3kxevLLgw5MZl9zzbCtjOQP
 9xGg==
X-Gm-Message-State: ANoB5pnLRdfSpwgBnDjgEQ2uMv+mtIfXo8sFxOzZOwscEMocudps0yi5
 q/lH0HV/cI9GQXVMlNak9Xaruk2uU1SMFwFKz1VoXL9/Sw0pTreex9bVyh4bd9QLi2lIM+TxB9/
 FffCFNtpHELmJSqYJtDeT5vh5SqmSfpG9fhN7ZYVknbV1DpthCkAm3tTqIA==
X-Received: by 2002:a05:6870:7d05:b0:13b:ef13:b650 with SMTP id
 os5-20020a0568707d0500b0013bef13b650mr961704oab.280.1668582702123; 
 Tue, 15 Nov 2022 23:11:42 -0800 (PST)
X-Google-Smtp-Source: AA0mqf4ECNLnwAetBRUMj97LLJ+MHt0sBOcFozMRqsxYzrPPOFRst9PUDF4iwco2keeBsu7Udqxb66mY0eGpPa0A7mQ=
X-Received: by 2002:a05:6870:7d05:b0:13b:ef13:b650 with SMTP id
 os5-20020a0568707d0500b0013bef13b650mr961698oab.280.1668582701893; Tue, 15
 Nov 2022 23:11:41 -0800 (PST)
MIME-Version: 1.0
References: <20221114070233.248-1-xieyongji@bytedance.com>
 <20221114070233.248-4-xieyongji@bytedance.com>
 <CACGkMEsbScqRtZeJ51ySiYdR_DrHwVAEGg_n0TR2mA2nK9e7sQ@mail.gmail.com>
 <CACycT3s8CbO1YD3AAzN-iXEkf6MKM7ihK+=NFik+33HDjanBJQ@mail.gmail.com>
 <CACGkMEvOYqBrFz5Fp2fL=QBU0fLBAZXLtXtX2OhMg+DuJPSUmQ@mail.gmail.com>
 <CACycT3uwqNb=+9P=Ta7pw5qUCRfJXveMUX==CYPrtE=+OQBCrg@mail.gmail.com>
In-Reply-To: <CACycT3uwqNb=+9P=Ta7pw5qUCRfJXveMUX==CYPrtE=+OQBCrg@mail.gmail.com>
From: Jason Wang <jasowang@redhat.com>
Date: Wed, 16 Nov 2022 15:11:30 +0800
Message-ID: <CACGkMEstonrKHHkr2Bi3Yd=driTMu_qBC5D9Xvxz4pWqs23e-w@mail.gmail.com>
Subject: Re: [PATCH 3/6] vduse: Add sysfs interface for irq affinity setup
To: Yongji Xie <xieyongji@bytedance.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Cc: virtualization <virtualization@lists.linux-foundation.org>,
 "Michael S. Tsirkin" <mst@redhat.com>
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

On Tue, Nov 15, 2022 at 10:49 AM Yongji Xie <xieyongji@bytedance.com> wrote:
>
> On Mon, Nov 14, 2022 at 4:55 PM Jason Wang <jasowang@redhat.com> wrote:
> >
> > On Mon, Nov 14, 2022 at 4:20 PM Yongji Xie <xieyongji@bytedance.com> wrote:
> > >
> > > On Mon, Nov 14, 2022 at 3:58 PM Jason Wang <jasowang@redhat.com> wrote:
> > > >
> > > > On Mon, Nov 14, 2022 at 3:16 PM Xie Yongji <xieyongji@bytedance.com> wrote:
> > > > >
> > > > > Add sysfs interface for each vduse virtqueue to setup
> > > > > irq affinity. This would be useful for performance
> > > > > tuning, e.g., mitigate the virtqueue lock contention
> > > > > in virtio block driver.
> > > >
> > > > Do we have any perforamnce numbers for this?
> > > >
> > >
> > > Almost 50% improvement (600k iops -> 900k iops) in the high iops
> > > workloads. I have mentioned it in the cover-letter.
> >
> > For some reason, I miss that.
> >
> > I also wonder if we can do this automatically, then there's no need to
> > play with sysfs which is kind of a burden for the management layer.
> >
>
> This is hard to do since vduse doesn't know which cpu should be bound
> for a certain virtqueue.

Probably via the kick_vq()? It probably won't work when notification
is disabled. But we need to think a little bit more about this.
Requiring management software to do ad-hoc running just for VDUSE
seems not easy.

Thanks

>
> Thanks,
> Yongji
>

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
