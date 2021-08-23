Return-Path: <SRS0=r7vL=NO=lists.linux-foundation.org=virtualization-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 56787C4338F
	for <virtualization@archiver.kernel.org>; Mon, 23 Aug 2021 16:04:57 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id EA03B613DA
	for <virtualization@archiver.kernel.org>; Mon, 23 Aug 2021 16:04:56 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org EA03B613DA
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id B3BBE80DE5;
	Mon, 23 Aug 2021 16:04:56 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
	by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id fgD5sI2PVWsw; Mon, 23 Aug 2021 16:04:52 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp1.osuosl.org (Postfix) with ESMTPS id 8A94B80CC5;
	Mon, 23 Aug 2021 16:04:51 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 5BEC8C001A;
	Mon, 23 Aug 2021 16:04:51 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [IPv6:2605:bc80:3010::133])
 by lists.linuxfoundation.org (Postfix) with ESMTP id B64CDC000E
 for <virtualization@lists.linux-foundation.org>;
 Mon, 23 Aug 2021 16:04:49 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id 368F5402DD
 for <virtualization@lists.linux-foundation.org>;
 Mon, 23 Aug 2021 16:03:13 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp2.osuosl.org (amavisd-new);
 dkim=pass (1024-bit key) header.d=redhat.com
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id J3qWuF7a8tyJ
 for <virtualization@lists.linux-foundation.org>;
 Mon, 23 Aug 2021 16:03:08 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.133.124])
 by smtp2.osuosl.org (Postfix) with ESMTPS id 59C60402C9
 for <virtualization@lists.linux-foundation.org>;
 Mon, 23 Aug 2021 16:03:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1629734587;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=VGHv+t7XJoBwzuDgFH5TfVqMsvYX/VooC0Y/PX4tAJg=;
 b=JHliH3CtHNRsdQXcMSlaqLP8p4QbfNp83TsKt3GE2AK8OaK8cIdWM0kaM0bUI3h9eAJhZz
 LTm9Pw657VzOu0Y9EeXHuGQOJ3vIGyOMjOLdQ04zwm6+wWfrNw+dLFRtvCbGApZsdvLTfO
 5feYonCNCdpJCnG8kh1mw4SEOMJ+8FU=
Received: from mail-ej1-f69.google.com (mail-ej1-f69.google.com
 [209.85.218.69]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-386-dRsSEIcJNe-md7CJNvfrdg-1; Mon, 23 Aug 2021 12:03:03 -0400
X-MC-Unique: dRsSEIcJNe-md7CJNvfrdg-1
Received: by mail-ej1-f69.google.com with SMTP id
 q15-20020a17090622cf00b005c42d287e6aso1860177eja.18
 for <virtualization@lists.linux-foundation.org>;
 Mon, 23 Aug 2021 09:03:03 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to;
 bh=VGHv+t7XJoBwzuDgFH5TfVqMsvYX/VooC0Y/PX4tAJg=;
 b=h46yyhwKSvC1IZT1tCbTaPaQTPI6fv2686vrJVmKYAUYjQeQNQpPXD1KZHiDSqeZcX
 kPpTflmnFzfSoSCkBTEIi1JYwXTxnl2nxW/ISNgxLA7gh0OlIcC3yWu6Zt3JUEe7uwz4
 7a4/cDkMEoIUHDYRsNrCEamRl6xgHFmydgm8DnuAG8eDcnc8MbWWq6A1ZK5UMAt17YN/
 sqUkrpmBH/ZZhG7aJv5PORFe0Jzyy9urB9EKbKGDplShmRGv8Vd8w/bmqDkMGaWsKpJd
 y8sdHYemLzsUCtNKSxncrHn4aynV171UdPSFs/Kb4VAHgh+3/Tpn53vZKKKteriurEtK
 iifA==
X-Gm-Message-State: AOAM531BZ6uaRB461vLs91TOimQcDTOdlP4uKz2uq9jwtzLnDyxp/hOY
 In7XjOjcbWMjFdw3t65yd1xKuefhpDgX9YlH5tX4yFIgUbwvUIusniXa+W+xZPyHaLwBMjRvdm0
 4i9ej/9J91BlfedR7xNXpn5EB+MPRQLYEUK+t0qEC4g==
X-Received: by 2002:a17:906:7d83:: with SMTP id
 v3mr36533879ejo.216.1629734582618; 
 Mon, 23 Aug 2021 09:03:02 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJxxp+uh6vvWHOggK+XZVQUmVCS8/2sf2bFFTaajhAycYy86aqPRfIaBgTC4eogFB5ay7zzGmA==
X-Received: by 2002:a17:906:7d83:: with SMTP id
 v3mr36533860ejo.216.1629734582438; 
 Mon, 23 Aug 2021 09:03:02 -0700 (PDT)
Received: from redhat.com ([2.55.137.225])
 by smtp.gmail.com with ESMTPSA id f8sm9832100edy.57.2021.08.23.09.03.00
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 23 Aug 2021 09:03:01 -0700 (PDT)
Date: Mon, 23 Aug 2021 12:02:58 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Yongji Xie <xieyongji@bytedance.com>
Subject: Re: [PATCH v5] virtio-blk: Add validation for block size in config
 space
Message-ID: <20210823120229-mutt-send-email-mst@kernel.org>
References: <CACycT3sNRRBrSTJOUr=POc-+BOAgfT7+qgFE2BLBTGJ30cZVsQ@mail.gmail.com>
 <dc8e7f6d-9aa6-58c6-97f7-c30391aeac5d@nvidia.com>
 <CACycT3v83sVvUWxZ-+SDyeXMPiYd0zi5mtmg8AkXYgVLxVpTvA@mail.gmail.com>
 <06af4897-7339-fca7-bdd9-e0f9c2c6195b@nvidia.com>
 <CACycT3usFyVyBuJBz2n5TRPveKKUXTqRDMo76VkGu7NCowNmvg@mail.gmail.com>
 <6d6154d7-7947-68be-4e1e-4c1d0a94b2bc@nvidia.com>
 <CACycT3sxeUQa7+QA0CAx47Y3tVHKigcQEfEHWi04aWA5xbgA9A@mail.gmail.com>
 <7f0181d7-ff5c-0346-66ee-1de3ed23f5dd@nvidia.com>
 <20210823080952-mutt-send-email-mst@kernel.org>
 <CACycT3sR6Y5XiK6_xX2ni8w9mqmSxkrb639ByDzV2W+Jz79Dnw@mail.gmail.com>
MIME-Version: 1.0
In-Reply-To: <CACycT3sR6Y5XiK6_xX2ni8w9mqmSxkrb639ByDzV2W+Jz79Dnw@mail.gmail.com>
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=mst@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Disposition: inline
Cc: Max Gurtovoy <mgurtovoy@nvidia.com>,
 linux-kernel <linux-kernel@vger.kernel.org>,
 virtualization <virtualization@lists.linux-foundation.org>,
 linux-block@vger.kernel.org, Stefan Hajnoczi <stefanha@redhat.com>
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

On Mon, Aug 23, 2021 at 08:40:30PM +0800, Yongji Xie wrote:
> On Mon, Aug 23, 2021 at 8:13 PM Michael S. Tsirkin <mst@redhat.com> wrote:
> >
> > On Mon, Aug 23, 2021 at 01:45:31PM +0300, Max Gurtovoy wrote:
> > > It helpful if there is a justification for this.
> > >
> > > In this case, no such HW device exist and the only device that can cause
> > > this trouble today is user space VDUSE device that must be validated by the
> > > emulation VDUSE kernel driver.
> > >
> > > Otherwise, will can create 1000 commit like this in the virtio level (for
> > > example for each feature for each virtio device).
> >
> > Yea, it's a lot of work but I don't think it's avoidable.
> >
> > > >
> > > > > > > > And regardless of userspace device, we still need to fix it for other cases.
> > > > > > > which cases ? Do you know that there is a buggy HW we need to workaround ?
> > > > > > >
> > > > > > No, there isn't now. But this could be a potential attack surface if
> > > > > > the host doesn't trust the device.
> > > > > If the host doesn't trust a device, why it continues using it ?
> > > > >
> > > > IIUC this is the case for the encrypted VMs.
> > >
> > > what do you mean encrypted VM ?
> > >
> > > And how this small patch causes a VM to be 100% encryption supported ?
> > >
> > > > > Do you suggest we do these workarounds in all device drivers in the kernel ?
> > > > >
> > > > Isn't it the driver's job to validate some unreasonable configuration?
> > >
> > > The check should be in different layer.
> > >
> > > Virtio blk driver should not cover on some strange VDUSE stuff.
> >
> > Yes I'm not convinced VDUSE is a valid use-case. I think that for
> > security and robustness it should validate data it gets from userspace
> > right there after reading it.
> > But I think this is useful for the virtio hardening thing.
> > https://lwn.net/Articles/865216/
> >
> > Yongji - I think the commit log should be much more explicit that
> > this is hardening. Otherwise people get confused and think this
> > needs a CVE or a backport for security.
> >
> 
> OK, do I need to send a v6? This patch seems to be already merged into
> Linus's tree.
> 
> Thanks,
> Yongji

No, it's a comment for the future - I assume you will keep adding this
kind of validation in other places.

-- 
MST

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
