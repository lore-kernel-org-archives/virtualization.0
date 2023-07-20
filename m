Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7B213C001DC
	for <virtualization@archiver.kernel.org>; Thu, 20 Jul 2023 17:21:22 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id F06478277E;
	Thu, 20 Jul 2023 17:21:21 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org F06478277E
Authentication-Results: smtp1.osuosl.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=F/KlzH0q
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
	by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id 60nHmiFV1lHn; Thu, 20 Jul 2023 17:21:21 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp1.osuosl.org (Postfix) with ESMTPS id 898CE82210;
	Thu, 20 Jul 2023 17:21:20 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 898CE82210
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 5803FC0072;
	Thu, 20 Jul 2023 17:21:20 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [IPv6:2605:bc80:3010::136])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 2B6BFC0032
 for <virtualization@lists.linux-foundation.org>;
 Thu, 20 Jul 2023 17:21:19 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id F3BA361162
 for <virtualization@lists.linux-foundation.org>;
 Thu, 20 Jul 2023 17:21:18 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org F3BA361162
Authentication-Results: smtp3.osuosl.org;
 dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com
 header.a=rsa-sha256 header.s=mimecast20190719 header.b=F/KlzH0q
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id JfFDpZ0qzMUW
 for <virtualization@lists.linux-foundation.org>;
 Thu, 20 Jul 2023 17:21:17 +0000 (UTC)
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.133.124])
 by smtp3.osuosl.org (Postfix) with ESMTPS id E6BA461216
 for <virtualization@lists.linux-foundation.org>;
 Thu, 20 Jul 2023 17:21:16 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org E6BA461216
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1689873675;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=wSM6GucX481b3eiLRGSzd0Yk4eXovV4UB3ZZIve6VjA=;
 b=F/KlzH0qVwEjL63HZZ5VMc9kSoQQoNx0wHlWxsDKoje4SyCfm12kGm2Oi5ZnF1Q+DvvAZv
 35wRs6aUKs2IFOCIlC1jPSw1i2pbS7ahExDQXrjXw/kmesTNlMsxOTJxVSJhcNrPIOZ21b
 kcv5sRikmOQ8uxvU5edMPmsBj/kIJBQ=
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-634-dUeWETqbOZeJ75JAcM_ovg-1; Thu, 20 Jul 2023 13:21:13 -0400
X-MC-Unique: dUeWETqbOZeJ75JAcM_ovg-1
Received: by mail-wr1-f71.google.com with SMTP id
 ffacd0b85a97d-316f24a72e8so619597f8f.1
 for <virtualization@lists.linux-foundation.org>;
 Thu, 20 Jul 2023 10:21:13 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1689873672; x=1690478472;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=wSM6GucX481b3eiLRGSzd0Yk4eXovV4UB3ZZIve6VjA=;
 b=YPGkIuWG2ts2fUlB4ro3EglyXMlzUSFT85U0WKtY8GFqKHu/IwPUA5xHqsBnUJAPjz
 zzjYFk09FDMUOnpC52CQCBkbCwX0XVnGvwgMB90eLAdcuX5LJT/9wwmAo4KgWUliJURa
 InPNT3Qpbq658qFkXgHpg0r3ZtXWLET3d6HLxNxsFC6N6ZPXsdD9+iKKExHPuLE0W7CU
 yfVCdtbrTFK1T0eqtVSXI2H9qlukeklV3YmEw4X8GwqXBIEXqPqsjCKaTZTZn+Ge5kuU
 MGhWJzszFNSEGi1V0VOt4vN/Sqm2sA3S1hTfT3Ao6a831vk8L6kVb7iIqgCQbubzeDwo
 H+qA==
X-Gm-Message-State: ABy/qLZi74tgvW+/80dyamCcQlCzZEUmCsDjYnyLVWdtU7yarn6lkVn0
 GX5ed3idTdUnr/1KMNmFsBya4sag+tolr5BPrKFus93LoYpFqZTvC2tgYxqs0wcUB4XcS6QXgrn
 gQ9V/6v6DcsEzCxkvDWTLToDQQlYLegIR/fMYl9l82A==
X-Received: by 2002:a5d:6649:0:b0:314:1224:dbb8 with SMTP id
 f9-20020a5d6649000000b003141224dbb8mr2499438wrw.21.1689873672594; 
 Thu, 20 Jul 2023 10:21:12 -0700 (PDT)
X-Google-Smtp-Source: APBJJlF007YE1yWjdVWFoof0oyKSncqv4aObnTbLud+fUTRyjhlewOkL5ydanAjocCMP5uLzKLoEew==
X-Received: by 2002:a5d:6649:0:b0:314:1224:dbb8 with SMTP id
 f9-20020a5d6649000000b003141224dbb8mr2499428wrw.21.1689873672296; 
 Thu, 20 Jul 2023 10:21:12 -0700 (PDT)
Received: from redhat.com ([2.52.16.41]) by smtp.gmail.com with ESMTPSA id
 a5-20020adfdd05000000b0031433d8af0dsm1873233wrm.18.2023.07.20.10.21.10
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 20 Jul 2023 10:21:11 -0700 (PDT)
Date: Thu, 20 Jul 2023 13:21:07 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Christoph Hellwig <hch@infradead.org>
Subject: Re: [PATCH vhost v11 05/10] virtio_ring: introduce virtqueue_dma_dev()
Message-ID: <20230720131928-mutt-send-email-mst@kernel.org>
References: <20230710034237.12391-1-xuanzhuo@linux.alibaba.com>
 <20230710034237.12391-6-xuanzhuo@linux.alibaba.com>
 <ZK/cxNHzI23I6efc@infradead.org>
 <20230713104805-mutt-send-email-mst@kernel.org>
 <ZLjSsmTfcpaL6H/I@infradead.org>
MIME-Version: 1.0
In-Reply-To: <ZLjSsmTfcpaL6H/I@infradead.org>
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Disposition: inline
Cc: Xuan Zhuo <xuanzhuo@linux.alibaba.com>,
 Jesper Dangaard Brouer <hawk@kernel.org>,
 Daniel Borkmann <daniel@iogearbox.net>, netdev@vger.kernel.org,
 John Fastabend <john.fastabend@gmail.com>, Alexei Starovoitov <ast@kernel.org>,
 virtualization@lists.linux-foundation.org, Eric Dumazet <edumazet@google.com>,
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

On Wed, Jul 19, 2023 at 11:22:42PM -0700, Christoph Hellwig wrote:
> On Thu, Jul 13, 2023 at 10:51:59AM -0400, Michael S. Tsirkin wrote:
> > On Thu, Jul 13, 2023 at 04:15:16AM -0700, Christoph Hellwig wrote:
> > > On Mon, Jul 10, 2023 at 11:42:32AM +0800, Xuan Zhuo wrote:
> > > > Added virtqueue_dma_dev() to get DMA device for virtio. Then the
> > > > caller can do dma operation in advance. The purpose is to keep memory
> > > > mapped across multiple add/get buf operations.
> > > 
> > > This is just poking holes into the abstraction..
> > 
> > More specifically?
> 
> Because now you expose a device that can't be used for the non-dma
> mapping case and shoud be hidden.


Ah, ok.
Well I think we can add wrappers like virtio_dma_sync and so on.
There are NOP for non-dma so passing the dma device is harmless.

-- 
MST

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
