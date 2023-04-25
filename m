Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 29774C6FD18
	for <virtualization@archiver.kernel.org>; Tue, 25 Apr 2023 12:40:36 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp2.osuosl.org (Postfix) with ESMTP id A36A940297;
	Tue, 25 Apr 2023 12:40:35 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org A36A940297
Authentication-Results: smtp2.osuosl.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=eVaJ450i
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
	by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id FYgBYld6j2im; Tue, 25 Apr 2023 12:40:34 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp2.osuosl.org (Postfix) with ESMTPS id 063A840529;
	Tue, 25 Apr 2023 12:40:34 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org 063A840529
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id CF94DC0036;
	Tue, 25 Apr 2023 12:40:33 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 1D9CFC002A
 for <virtualization@lists.linux-foundation.org>;
 Tue, 25 Apr 2023 12:40:33 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id EBEC360FFA
 for <virtualization@lists.linux-foundation.org>;
 Tue, 25 Apr 2023 12:40:32 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org EBEC360FFA
Authentication-Results: smtp3.osuosl.org;
 dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com
 header.a=rsa-sha256 header.s=mimecast20190719 header.b=eVaJ450i
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id jsSdMguPQWXj
 for <virtualization@lists.linux-foundation.org>;
 Tue, 25 Apr 2023 12:40:31 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 92BEC60FF6
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.133.124])
 by smtp3.osuosl.org (Postfix) with ESMTPS id 92BEC60FF6
 for <virtualization@lists.linux-foundation.org>;
 Tue, 25 Apr 2023 12:40:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1682426430;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=sym5/GwpOgOUNUvBOB0eNgCCMsyqEVQvUPUwFKzQhvg=;
 b=eVaJ450ikDoQBjtgIDzIzV/9KEOuHnBmcQCAxgqcI6IZG+9BsqzGlZ0//PqFYmrAmw/ohI
 eU5BJ5SvbDO5lBDmrPhr8VUjaLvdIztUH6ftgk1xSMehwfxKpRChI78VprX+L4iahVhk05
 5TJSkQaCYQul11dZOgHXSacArYgOC4w=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-116--VZxav7lMT2FPeDYcSlbZQ-1; Tue, 25 Apr 2023 08:40:27 -0400
X-MC-Unique: -VZxav7lMT2FPeDYcSlbZQ-1
Received: by mail-wm1-f70.google.com with SMTP id
 5b1f17b1804b1-3f18b63229bso57856925e9.0
 for <virtualization@lists.linux-foundation.org>;
 Tue, 25 Apr 2023 05:40:26 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1682426426; x=1685018426;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=sym5/GwpOgOUNUvBOB0eNgCCMsyqEVQvUPUwFKzQhvg=;
 b=CVRcBYBFL4/UYdlzjYgy7jStBPhV6YWFAHuRDUrCNDJlf2Gt2bmnH+Zb3KlwA7Fvyq
 9NB+QAfstYxtKhCw8aoppitcc2dcCwUlxMUHTcYtnRosUaHRPBAxxDUP8dzOWVpU5FmE
 seMXLBczkAKWkjoDLWSLMZ16FMjswiAKrZe8NbOuFyarbYbruv6sgNlf+jPvpVodXExD
 uiWHhsenUa5YRK5qaIIvzgIpn1pnnVNfciKH/GOUpkjwA71c2VsrCPP8BadBuiALDuYp
 AgyLjBpCvrUZJUQlVr8Uf5bTHRFtH5WyxWZT/apYA+W0ZjhtYudArRT5x7ZVpaPkPPHg
 sbUg==
X-Gm-Message-State: AAQBX9fpFv8kKflL+YFTt6Z4Rb4/90K3kSNppgQwzQehUbjA2lHQCcfh
 P4Gva9hlhiRcfF0HUoQXvifudvS5NJdXHVFOjqawfejZgSz3RA3AH+CQXbGHY0wuDyFHjW3gEIo
 mfKl7zrnST3EeUAcD5mC/g/rtUOBMyVk66iC/M3TKhQ==
X-Received: by 2002:a05:600c:5114:b0:3f1:6fb4:5645 with SMTP id
 o20-20020a05600c511400b003f16fb45645mr10951661wms.1.1682426425937; 
 Tue, 25 Apr 2023 05:40:25 -0700 (PDT)
X-Google-Smtp-Source: AKy350aOcJZaWAP2XurK0YcB78/MVzB3a4SbfPQ9/T3FHEIHFqS0/3AKC/hoI8zwh6WihM8FUfKAKg==
X-Received: by 2002:a05:600c:5114:b0:3f1:6fb4:5645 with SMTP id
 o20-20020a05600c511400b003f16fb45645mr10951645wms.1.1682426425610; 
 Tue, 25 Apr 2023 05:40:25 -0700 (PDT)
Received: from redhat.com ([2.55.61.39]) by smtp.gmail.com with ESMTPSA id
 o10-20020a05600c510a00b003ee443bf0c7sm18298331wms.16.2023.04.25.05.40.23
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 25 Apr 2023 05:40:25 -0700 (PDT)
Date: Tue, 25 Apr 2023 08:40:21 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Xuan Zhuo <xuanzhuo@linux.alibaba.com>
Subject: Re: [PATCH vhost v7 00/11] virtio core prepares for AF_XDP
Message-ID: <20230425083947-mutt-send-email-mst@kernel.org>
References: <20230425073613.8839-1-xuanzhuo@linux.alibaba.com>
 <20230425034700-mutt-send-email-mst@kernel.org>
 <1682409903.8734658-2-xuanzhuo@linux.alibaba.com>
 <20230425041246-mutt-send-email-mst@kernel.org>
 <1682410913.3294404-4-xuanzhuo@linux.alibaba.com>
MIME-Version: 1.0
In-Reply-To: <1682410913.3294404-4-xuanzhuo@linux.alibaba.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Disposition: inline
Cc: Jesper Dangaard Brouer <hawk@kernel.org>,
 Daniel Borkmann <daniel@iogearbox.net>, netdev@vger.kernel.org,
 John Fastabend <john.fastabend@gmail.com>, Alexei Starovoitov <ast@kernel.org>,
 virtualization@lists.linux-foundation.org,
 Christoph Hellwig <hch@infradead.org>,
 Alexander Lobakin <aleksander.lobakin@intel.com>,
 Jakub Kicinski <kuba@kernel.org>, bpf@vger.kernel.org,
 "David S. Miller" <davem@davemloft.net>
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

On Tue, Apr 25, 2023 at 04:21:53PM +0800, Xuan Zhuo wrote:
> On Tue, 25 Apr 2023 04:13:09 -0400, "Michael S. Tsirkin" <mst@redhat.com> wrote:
> > On Tue, Apr 25, 2023 at 04:05:03PM +0800, Xuan Zhuo wrote:
> > > On Tue, 25 Apr 2023 03:51:47 -0400, "Michael S. Tsirkin" <mst@redhat.com> wrote:
> > > > On Tue, Apr 25, 2023 at 03:36:02PM +0800, Xuan Zhuo wrote:
> > > > > ## About DMA APIs
> > > > >
> > > > > Now, virtio may can not work with DMA APIs when virtio features do not have
> > > > > VIRTIO_F_ACCESS_PLATFORM.
> > > > >
> > > > > 1. I tried to let DMA APIs return phy address by virtio-device. But DMA APIs just
> > > > >    work with the "real" devices.
> > > > > 2. I tried to let xsk support callballs to get phy address from virtio-net
> > > > >    driver as the dma address. But the maintainers of xsk may want to use dma-buf
> > > > >    to replace the DMA APIs. I think that may be a larger effort. We will wait
> > > > >    too long.
> > > > >
> > > > > So rethinking this, firstly, we can support premapped-dma only for devices with
> > > > > VIRTIO_F_ACCESS_PLATFORM. In the case of af-xdp, if the users want to use it,
> > > > > they have to update the device to support VIRTIO_F_RING_RESET, and they can also
> > > > > enable the device's VIRTIO_F_ACCESS_PLATFORM feature by the way.
> > > >
> > > > I don't understand this last sentence. If you think ring
> > > > reset can change device features then the answer is no, it can't.
> > >
> > >
> > > Sorry, I should remove "by the way".
> > >
> > >
> > > >
> > > > If you are saying device has to set VIRTIO_F_ACCESS_PLATFORM to
> > > > benefit from this work, that's fine at least as a first approach.
> > > > Note that setting VIRTIO_F_ACCESS_PLATFORM breaks old guests
> > > > (it's a secirity boundary), e.g. it is not available for
> > > > transitional devices.
> > > > So to support transitional devices, we might want to find another way to
> > > > address this down the road,
> > >
> > > Maybe dma-buf is a way. I'll look into it, especially some practice on xsk.
> > >
> > > > but as a first step, I agree just going with
> > > > DMA is fine.
> > >
> > >
> > > Thanks.
> >
> > Pls do make sure to disable the feature when !VIRTIO_F_ACCESS_PLATFORM
> > though.
> 
> If you refer to the implementation inside virtio-net, this feature will depend
> on the return of virtqueue_dma_dev().
> 
> But virtqueue_dma_dev() depends "use_dma_api". When xen_domain() is true and
> !VIRTIO_F_ACCESS_PLATFORM, the "use_dma_api" is true.
> 
> So what kind of situation do you mean?
> 
> Thanks.

E.g. a legacy device.

-- 
MST

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
