Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 41C59C0015E
	for <virtualization@archiver.kernel.org>; Tue, 25 Jul 2023 07:34:48 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id AB5A560AEF;
	Tue, 25 Jul 2023 07:34:47 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org AB5A560AEF
Authentication-Results: smtp3.osuosl.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=WFzYSvc8
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
	by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id n5L5vbqDn7Uy; Tue, 25 Jul 2023 07:34:47 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp3.osuosl.org (Postfix) with ESMTPS id 27EEC6080A;
	Tue, 25 Jul 2023 07:34:46 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 27EEC6080A
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 03581C0071;
	Tue, 25 Jul 2023 07:34:46 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 48AF4C0032
 for <virtualization@lists.linux-foundation.org>;
 Tue, 25 Jul 2023 07:34:45 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id 1A24A40937
 for <virtualization@lists.linux-foundation.org>;
 Tue, 25 Jul 2023 07:34:45 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org 1A24A40937
Authentication-Results: smtp4.osuosl.org;
 dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com
 header.a=rsa-sha256 header.s=mimecast20190719 header.b=WFzYSvc8
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id njfE9lLLp1Jc
 for <virtualization@lists.linux-foundation.org>;
 Tue, 25 Jul 2023 07:34:44 +0000 (UTC)
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.133.124])
 by smtp4.osuosl.org (Postfix) with ESMTPS id E96A3408F3
 for <virtualization@lists.linux-foundation.org>;
 Tue, 25 Jul 2023 07:34:43 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org E96A3408F3
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1690270482;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=KlVTXLyWcMpMPMMm7emcajIWT4tUJXS33YzR+iu8MUw=;
 b=WFzYSvc8fS4ekvBWJ645ATUf4YDeGDKUpK9E6iplByVi7LflHwtxgY/q8PpY1wxS/3sTsE
 13RbEKXQRnOEVG6X3eg0FYaxQ9/ErUCfP10ZVcJ7XIftcH0ncNH593Bf4bcwjdMbGf5N8v
 ymhypeXmp0U73t4VXwh2EbXzAzD+OTU=
Received: from mail-ej1-f72.google.com (mail-ej1-f72.google.com
 [209.85.218.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-364-yN08k05zPGy2ebYEhYsrDA-1; Tue, 25 Jul 2023 03:34:40 -0400
X-MC-Unique: yN08k05zPGy2ebYEhYsrDA-1
Received: by mail-ej1-f72.google.com with SMTP id
 a640c23a62f3a-99388334de6so386587366b.0
 for <virtualization@lists.linux-foundation.org>;
 Tue, 25 Jul 2023 00:34:40 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1690270480; x=1690875280;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=KlVTXLyWcMpMPMMm7emcajIWT4tUJXS33YzR+iu8MUw=;
 b=h3a77yiNcf217bfZQTz4TuhdSUn6LHmMuTKHQJhMytisyn3kNPIc0mFDnh7pt7b74f
 qXL/rg8+tuApgGKhHDMIX92evWpnMqv3vOGuYN+/LghKjpzBj2tqclrdE61En1tzYrzn
 HB+UUFFu3mvt3tDDuGEqRiLm9uo8v0Tu7RtImbx9Pxu3BdnT/kz8yhh9PLy/PQJ9BEbp
 yM/b2sBVhP/VwPEz0hgJe+iY+kBILFVKRqd8EB+AC+pj5vuuXPu9rcBgKJ4QIfaNVaj5
 YGC7y3lPLSsAc2aXqF4Su4g9xI63jAHC1iLF//sJjUmOt8UqxvTeYLYxS+TqIrOLJyFG
 GV1g==
X-Gm-Message-State: ABy/qLa/o+ZIoH1oxOuLtu6oHTW6YhvJw+kATaAJEFLr+5BkiOQY9p0j
 j5iD8ICz3AuxAk5P1nwmKuoNAJ84vlBvkR5mp7faBKQxNGzHwiS77rsKit0L9uE6z92c4kcCimR
 mYSeyn7+2YXLGlKXI/Y0J8LwGP1JPDQijzuIHRqAZcg==
X-Received: by 2002:a17:906:3281:b0:99b:48d3:5488 with SMTP id
 1-20020a170906328100b0099b48d35488mr12217613ejw.24.1690270479824; 
 Tue, 25 Jul 2023 00:34:39 -0700 (PDT)
X-Google-Smtp-Source: APBJJlHNg+hM1hzoNAK32i8hsz4doeAFqPyABedd7VMtD2jNuY0tQh5xK77D0UqFEO1XA6riO6GpBA==
X-Received: by 2002:a17:906:3281:b0:99b:48d3:5488 with SMTP id
 1-20020a170906328100b0099b48d35488mr12217587ejw.24.1690270479464; 
 Tue, 25 Jul 2023 00:34:39 -0700 (PDT)
Received: from redhat.com ([2.55.164.187]) by smtp.gmail.com with ESMTPSA id
 k16-20020a1709063fd000b009894b476310sm7790738ejj.163.2023.07.25.00.34.36
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 25 Jul 2023 00:34:38 -0700 (PDT)
Date: Tue, 25 Jul 2023 03:34:34 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Xuan Zhuo <xuanzhuo@linux.alibaba.com>
Subject: Re: [PATCH vhost v11 05/10] virtio_ring: introduce virtqueue_dma_dev()
Message-ID: <20230725033321-mutt-send-email-mst@kernel.org>
References: <20230710034237.12391-1-xuanzhuo@linux.alibaba.com>
 <20230710034237.12391-6-xuanzhuo@linux.alibaba.com>
 <ZK/cxNHzI23I6efc@infradead.org>
 <20230713104805-mutt-send-email-mst@kernel.org>
 <ZLjSsmTfcpaL6H/I@infradead.org>
 <20230720131928-mutt-send-email-mst@kernel.org>
 <ZL6qPvd6X1CgUD4S@infradead.org>
 <1690251228.3455179-1-xuanzhuo@linux.alibaba.com>
MIME-Version: 1.0
In-Reply-To: <1690251228.3455179-1-xuanzhuo@linux.alibaba.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Disposition: inline
Cc: Jesper Dangaard Brouer <hawk@kernel.org>,
 Daniel Borkmann <daniel@iogearbox.net>, netdev@vger.kernel.org,
 John Fastabend <john.fastabend@gmail.com>, Alexei Starovoitov <ast@kernel.org>,
 virtualization@lists.linux-foundation.org,
 Christoph Hellwig <hch@infradead.org>, Eric Dumazet <edumazet@google.com>,
 Jakub Kicinski <kuba@kernel.org>, bpf@vger.kernel.org,
 Paolo Abeni <pabeni@redhat.com>, "David S. Miller" <davem@davemloft.net>
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

On Tue, Jul 25, 2023 at 10:13:48AM +0800, Xuan Zhuo wrote:
> On Mon, 24 Jul 2023 09:43:42 -0700, Christoph Hellwig <hch@infradead.org> wrote:
> > On Thu, Jul 20, 2023 at 01:21:07PM -0400, Michael S. Tsirkin wrote:
> > > Well I think we can add wrappers like virtio_dma_sync and so on.
> > > There are NOP for non-dma so passing the dma device is harmless.
> >
> > Yes, please.
> 
> 
> I am not sure I got this fully.
> 
> Are you mean this:
> https://lore.kernel.org/all/20230214072704.126660-8-xuanzhuo@linux.alibaba.com/
> https://lore.kernel.org/all/20230214072704.126660-9-xuanzhuo@linux.alibaba.com/
> 
> Then the driver must do dma operation(map and sync) by these virtio_dma_* APIs.
> No care the device is non-dma device or dma device.

yes

> Then the AF_XDP must use these virtio_dma_* APIs for virtio device.

We'll worry about AF_XDP when the patch is posted.

-- 
MST

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
