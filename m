Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EEB69C433EF
	for <virtualization@archiver.kernel.org>; Fri,  8 Jul 2022 08:39:03 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 76F6084105;
	Fri,  8 Jul 2022 08:39:03 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 76F6084105
Authentication-Results: smtp1.osuosl.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=VhsQYURy
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
	by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id aCWJd4vzuR4o; Fri,  8 Jul 2022 08:39:02 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp1.osuosl.org (Postfix) with ESMTPS id 1C0B984081;
	Fri,  8 Jul 2022 08:39:02 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 1C0B984081
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id DCC6FC0033;
	Fri,  8 Jul 2022 08:39:01 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id D065DC002D
 for <virtualization@lists.linux-foundation.org>;
 Fri,  8 Jul 2022 08:39:00 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id 9D46584117
 for <virtualization@lists.linux-foundation.org>;
 Fri,  8 Jul 2022 08:39:00 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 9D46584117
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id Qo---aEMrklW
 for <virtualization@lists.linux-foundation.org>;
 Fri,  8 Jul 2022 08:39:00 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org E220684081
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.133.124])
 by smtp1.osuosl.org (Postfix) with ESMTPS id E220684081
 for <virtualization@lists.linux-foundation.org>;
 Fri,  8 Jul 2022 08:38:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1657269538;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=VjRlQXGGGY292fDcz+4b7uINrKnhV/T0exw7xiAeg2E=;
 b=VhsQYURyrHJiFDz3D4NkX08zqMfBM/kAMa6HnTdbZTLWQ4mqY1RBlwygyOFn5wmuzvAeJ+
 iN/4d25yUmavxvp5sB1i8m2zSIDwJZt1hvR++KR/bBkJnJVAgDE3POXuH2TrOFsx3KdC9j
 Dim1dQCKDENPIZpH0dFMT27/2qAck8Q=
Received: from mail-lf1-f70.google.com (mail-lf1-f70.google.com
 [209.85.167.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-434-0kKG6XFhO4yOA--nmvRUIQ-1; Fri, 08 Jul 2022 04:38:51 -0400
X-MC-Unique: 0kKG6XFhO4yOA--nmvRUIQ-1
Received: by mail-lf1-f70.google.com with SMTP id
 r2-20020a19da02000000b00488c1f8322bso1703801lfg.9
 for <virtualization@lists.linux-foundation.org>;
 Fri, 08 Jul 2022 01:38:50 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=VjRlQXGGGY292fDcz+4b7uINrKnhV/T0exw7xiAeg2E=;
 b=beTiifDoF5o6akFPM1tPgiVX5KRQBHXwawURg3TTXJBxCkO+gc7zOcSN10Tx+ZCC9A
 0QYc7bTCth/zzBOq5JJCfXbB9Hnjougwq1zuPp1SgR/Z0lnlwbs9r2UoQxN7mp1nsJm1
 I3uL3If9pgfMKEcwrwUcS7hCzC66WubkHrpDs8chjrZUanRPevbTXoTev6If7ZvPZtI1
 DOQjhCrRojK3n6QHKHWi+cMZZCN7bDyKRGsS32GK1QCJPk6urTHOurma9jNi3UVYZRTG
 LqBUkQ1uwqlXhzDh+64vFTLBQQjCFbTLxhUnCjemTB88TDpmuORuX2fqp9rF92EEqRGn
 ILnQ==
X-Gm-Message-State: AJIora/6kHXHDDXt3o8AUswPIg5cDaC7dcWMyYwkO7T5s9Soz7jQvouZ
 qoVJVHijNjZ8uzwuRat9V3bjP80EOImqljUs0Z8+xe5zgKj6NEaduyQy22QD3R/S2ze5b6z3q+J
 s7TqG6QuVr5WIVHpm8hjHtDnAOlRjiUEkNTlvdPdySew8ZSVMmEwD1v9d8A==
X-Received: by 2002:a05:6512:3b8e:b0:481:1a75:452 with SMTP id
 g14-20020a0565123b8e00b004811a750452mr1757475lfv.238.1657269529283; 
 Fri, 08 Jul 2022 01:38:49 -0700 (PDT)
X-Google-Smtp-Source: AGRyM1v/lqDZF8NOO7f0vLkQWh9o4W/nvu/S+XKeijIEihRuhlgQCp5a7p0RH7eYUIqfOvRGedEpaTlBeRW3khfgko0=
X-Received: by 2002:a05:6512:3b8e:b0:481:1a75:452 with SMTP id
 g14-20020a0565123b8e00b004811a750452mr1757462lfv.238.1657269529036; Fri, 08
 Jul 2022 01:38:49 -0700 (PDT)
MIME-Version: 1.0
References: <20220706050503.171-1-xieyongji@bytedance.com>
 <CACGkMEv1tzenaGSUvYXEuxdmXyaZxQ24QspXRRA_95mMp4PWSg@mail.gmail.com>
 <CACycT3u3kOzzQjKBYNAB5vtpgcmPg7FjJ5yTYMtQo0SJVrBmZg@mail.gmail.com>
In-Reply-To: <CACycT3u3kOzzQjKBYNAB5vtpgcmPg7FjJ5yTYMtQo0SJVrBmZg@mail.gmail.com>
From: Jason Wang <jasowang@redhat.com>
Date: Fri, 8 Jul 2022 16:38:37 +0800
Message-ID: <CACGkMEvtC1VmGjhV6QpEeu+nUikGj5eT79hhyS59rpK1s31TUg@mail.gmail.com>
Subject: Re: [PATCH v2 0/5] VDUSE: Support registering userspace memory as
 bounce buffer
To: Yongji Xie <xieyongji@bytedance.com>
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=jasowang@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Cc: mst <mst@redhat.com>, Liu Xiaodong <xiaodong.liu@intel.com>,
 linux-kernel <linux-kernel@vger.kernel.org>,
 virtualization <virtualization@lists.linux-foundation.org>,
 Maxime Coquelin <maxime.coquelin@redhat.com>,
 Stefan Hajnoczi <stefanha@redhat.com>, songmuchun@bytedance.com
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

On Wed, Jul 6, 2022 at 6:16 PM Yongji Xie <xieyongji@bytedance.com> wrote:
>
> On Wed, Jul 6, 2022 at 5:30 PM Jason Wang <jasowang@redhat.com> wrote:
> >
> > On Wed, Jul 6, 2022 at 1:05 PM Xie Yongji <xieyongji@bytedance.com> wrote:
> > >
> > > Hi all,
> > >
> > > This series introduces some new ioctls: VDUSE_IOTLB_GET_INFO,
> > > VDUSE_IOTLB_REG_UMEM and VDUSE_IOTLB_DEREG_UMEM to support
> > > registering and de-registering userspace memory for IOTLB
> > > as bounce buffer in virtio-vdpa case.
> > >
> > > The VDUSE_IOTLB_GET_INFO ioctl can help user to query IOLTB
> > > information such as bounce buffer size. Then user can use
> > > those information on VDUSE_IOTLB_REG_UMEM and
> > > VDUSE_IOTLB_DEREG_UMEM ioctls to register and de-register
> > > userspace memory for IOTLB.
> > >
> > > During registering and de-registering, the DMA data in use
> > > would be copied from kernel bounce pages to userspace bounce
> > > pages and back.
> > >
> > > With this feature, some existing application such as SPDK
> > > and DPDK can leverage the datapath of VDUSE directly and
> > > efficiently as discussed before [1][2]. They can register
> > > some preallocated hugepages to VDUSE to avoid an extra
> > > memcpy from bounce-buffer to hugepages.
> >
> > This is really interesting.
> >
> > But a small concern on uAPI is that this seems to expose the VDUSE
> > internal implementation (bounce buffer) to userspace. We tried hard to
> > hide it via the GET_FD before. Anyway can we keep it?
> >
>
> Another way is changing GET_FD ioctl to add a flag or reuse 'perm'
> field to indicate whether a IOVA region supports userspace memory
> registration. Then userspace can use
> VDUSE_IOTLB_REG_UMEM/VDUSE_IOTLB_DEREG_UMEM to register/deregister
> userspace memory for this IOVA region.

Looks better.

> Any suggestions?

I wonder what's the value of keeping the compatibility with the kernel
mmaped bounce buffer. It means we need to take extra care on e.g data
copying when reg/reg user space memory.

Can we simply allow the third kind of fd that only works for umem registration?

Thanks

>
> Thanks,
> Yongji
>

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
