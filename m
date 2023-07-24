Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 53200EB64DD
	for <virtualization@archiver.kernel.org>; Mon, 24 Jul 2023 20:06:04 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp2.osuosl.org (Postfix) with ESMTP id D21A5400EC;
	Mon, 24 Jul 2023 20:06:03 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org D21A5400EC
Authentication-Results: smtp2.osuosl.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=Q787B0JZ
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
	by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id UInJnFGqI0Ys; Mon, 24 Jul 2023 20:06:03 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp2.osuosl.org (Postfix) with ESMTPS id 4FA2D4016B;
	Mon, 24 Jul 2023 20:06:02 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org 4FA2D4016B
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 1C960C0072;
	Mon, 24 Jul 2023 20:06:02 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [IPv6:2605:bc80:3010::137])
 by lists.linuxfoundation.org (Postfix) with ESMTP id E4428C0032
 for <virtualization@lists.linux-foundation.org>;
 Mon, 24 Jul 2023 20:06:00 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id A9D9A41823
 for <virtualization@lists.linux-foundation.org>;
 Mon, 24 Jul 2023 20:06:00 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org A9D9A41823
Authentication-Results: smtp4.osuosl.org;
 dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com
 header.a=rsa-sha256 header.s=mimecast20190719 header.b=Q787B0JZ
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id w9msS-pMu81h
 for <virtualization@lists.linux-foundation.org>;
 Mon, 24 Jul 2023 20:05:59 +0000 (UTC)
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.129.124])
 by smtp4.osuosl.org (Postfix) with ESMTPS id 99ED5417B3
 for <virtualization@lists.linux-foundation.org>;
 Mon, 24 Jul 2023 20:05:59 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org 99ED5417B3
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1690229158;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=LYP2jsSM7wu6tSo9cTMLY8NXdl2pRsOxDL4GNzMi1ow=;
 b=Q787B0JZRTTRlmmyNaU18kQc0tVJ6lC9ojPGB3/yGzQkpv4AeYtOaIP+VDzt3VJQ6h/1wQ
 eSOYQvQhWD7UYGc83MKnJ2zVugjNiAp5PyHLHLcci4Df3j6IfvxysfI7X6GEvwK5OuoNkX
 aPHbnT6GZIKebcgi0VwmKH6TphpFHo8=
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-687-AqSubIvXP9C1yuf89OWhkA-1; Mon, 24 Jul 2023 16:05:56 -0400
X-MC-Unique: AqSubIvXP9C1yuf89OWhkA-1
Received: by mail-wr1-f71.google.com with SMTP id
 ffacd0b85a97d-2f2981b8364so2816135f8f.1
 for <virtualization@lists.linux-foundation.org>;
 Mon, 24 Jul 2023 13:05:55 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1690229155; x=1690833955;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=LYP2jsSM7wu6tSo9cTMLY8NXdl2pRsOxDL4GNzMi1ow=;
 b=Qey2+pXfH4eoQBS7puk1XzPYWKqFf7602Lkxg4p7seVcvA2d6adbgKx7gJDY6bjSUN
 TyLumUSZZ/1hgZrre+3VSpEVY85f9Djfq6v6XbmYdsYwhqQt199mWzPGETnZqX5QVoHg
 V2EDjSTOcjs7gFIab9hggH9LF0z9wr89FX6yErU0QIDU6QhiBeILyamviIb/kiKr/syN
 dK7nXFDaUjCopAzYEfkAm7mJUwgUi5ZZu/2zGH5BDcJAGlUlubaqeA51Lnc7ibwf6mdU
 C1HSAVaHulpaAp/XWazUbXyLAD9muVYrxNsHkhlCbaQGntfsalxadafIR+aBlIynCvCJ
 jr8A==
X-Gm-Message-State: ABy/qLZlYpJmbwLuVm8MStZAq9AZWtYCh4Ju1Y+miaegCsZsFiNF6JRc
 K40kW7MV9zhl+HQJLsddWgzFoNhsTrgD9UGkqZ9LSDC5kKxtnGy4Dpprx4nkLm38H7PYXcHOnpI
 GRTVMDD6FlB7SrqRHpgWOeZbgWZ4iyu3Suq/S+sGvPw==
X-Received: by 2002:adf:eb05:0:b0:315:a043:5e03 with SMTP id
 s5-20020adfeb05000000b00315a0435e03mr8052326wrn.55.1690229154963; 
 Mon, 24 Jul 2023 13:05:54 -0700 (PDT)
X-Google-Smtp-Source: APBJJlF8FTgAqrCH/MKiiYnFPararbVVgu6QGFkBPQebzHQooTua9/IeyBAZ0Zi401PXfeUNSe4JJA==
X-Received: by 2002:adf:eb05:0:b0:315:a043:5e03 with SMTP id
 s5-20020adfeb05000000b00315a0435e03mr8052311wrn.55.1690229154666; 
 Mon, 24 Jul 2023 13:05:54 -0700 (PDT)
Received: from redhat.com ([2.55.164.187]) by smtp.gmail.com with ESMTPSA id
 d15-20020aa7ce0f000000b0052238bc70ccsm1181121edv.89.2023.07.24.13.05.52
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 24 Jul 2023 13:05:53 -0700 (PDT)
Date: Mon, 24 Jul 2023 16:05:50 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Xuan Zhuo <xuanzhuo@linux.alibaba.com>
Subject: Re: [PATCH vhost v11 05/10] virtio_ring: introduce virtqueue_dma_dev()
Message-ID: <20230724160511-mutt-send-email-mst@kernel.org>
References: <20230710034237.12391-1-xuanzhuo@linux.alibaba.com>
 <20230710034237.12391-6-xuanzhuo@linux.alibaba.com>
 <ZK/cxNHzI23I6efc@infradead.org>
 <20230713104805-mutt-send-email-mst@kernel.org>
 <ZLjSsmTfcpaL6H/I@infradead.org>
 <1689835514.217712-8-xuanzhuo@linux.alibaba.com>
 <ZLja73TJ1Ow19xdr@infradead.org>
 <1689838441.2670174-9-xuanzhuo@linux.alibaba.com>
MIME-Version: 1.0
In-Reply-To: <1689838441.2670174-9-xuanzhuo@linux.alibaba.com>
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

On Thu, Jul 20, 2023 at 03:34:01PM +0800, Xuan Zhuo wrote:
> On Wed, 19 Jul 2023 23:57:51 -0700, Christoph Hellwig <hch@infradead.org> wrote:
> > On Thu, Jul 20, 2023 at 02:45:14PM +0800, Xuan Zhuo wrote:
> > >  virtqueue_dma_dev() return the device that working with the DMA APIs.
> > >  Then that can be used like other devices. So what is the problem.
> > >
> > >  I always think the code path without the DMA APIs is the trouble for you.
> >
> > Because we now have an API where the upper level drivers sometimes
> > see the dma device and sometimes not.
> 
> No dma device is just for the old devices.
> 
> The API without DMA dev are only compatible with older devices. We can't give up
> these old devices, but we also have to embrace new features.
> 
> > This will be abused and cause
> > trouble sooner than you can say "layering".
> 
> I don't understand what the possible trouble here is.
> 
> When no dma device, the driver just does the same thing as before.
> 
> Thanks.

Instead of skipping operations, Christoph wants wrappers that
do nothing for non dma case.

-- 
MST

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
