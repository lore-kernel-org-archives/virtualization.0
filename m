Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 07A4EC00528
	for <virtualization@archiver.kernel.org>; Thu, 13 Jul 2023 14:52:57 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 8456142089;
	Thu, 13 Jul 2023 14:52:57 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org 8456142089
Authentication-Results: smtp4.osuosl.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=ed/otZgv
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
	by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id 9FtW-2MMwDPG; Thu, 13 Jul 2023 14:52:56 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp4.osuosl.org (Postfix) with ESMTPS id A6B484207D;
	Thu, 13 Jul 2023 14:52:55 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org A6B484207D
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 7452AC0071;
	Thu, 13 Jul 2023 14:52:55 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [IPv6:2605:bc80:3010::136])
 by lists.linuxfoundation.org (Postfix) with ESMTP id B2C18C0032
 for <virtualization@lists.linux-foundation.org>;
 Thu, 13 Jul 2023 14:52:53 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id 7FD45613B4
 for <virtualization@lists.linux-foundation.org>;
 Thu, 13 Jul 2023 14:52:53 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 7FD45613B4
Authentication-Results: smtp3.osuosl.org;
 dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com
 header.a=rsa-sha256 header.s=mimecast20190719 header.b=ed/otZgv
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id X9C6ULTmnLmA
 for <virtualization@lists.linux-foundation.org>;
 Thu, 13 Jul 2023 14:52:52 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 0A93B6139F
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.133.124])
 by smtp3.osuosl.org (Postfix) with ESMTPS id 0A93B6139F
 for <virtualization@lists.linux-foundation.org>;
 Thu, 13 Jul 2023 14:52:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1689259971;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=a2zCtBlVMSfdNhn49F5fvGTfds6ip8Yk0SLr5SlzCTc=;
 b=ed/otZgvy/UyyX9Q+zmgkKF0WMj4VvaSOiQOuSpM/jZxh2mgeb2Bq0GTiSWg6Wp6Jxf1/+
 eVPsS78e7H/pGP1jFNz8vrCD76WKdNSHOCvjaI/b2eEZFm0V/AXmasoyJ3obL0F4MAO/IP
 wT7LniqQ5Y7bexPpFahoFIifjOFaXzs=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-662-JRbfjf4bMRqxqfOd3SapRg-1; Thu, 13 Jul 2023 10:52:49 -0400
X-MC-Unique: JRbfjf4bMRqxqfOd3SapRg-1
Received: by mail-wr1-f70.google.com with SMTP id
 ffacd0b85a97d-31429e93f26so585023f8f.2
 for <virtualization@lists.linux-foundation.org>;
 Thu, 13 Jul 2023 07:52:49 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1689259968; x=1691851968;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=a2zCtBlVMSfdNhn49F5fvGTfds6ip8Yk0SLr5SlzCTc=;
 b=ieO1Dtjh+tU/XOJH8PQEL3gOTYdSwU5AR1fDt5IHf9oC3NTmaiGmnUXwXN28w+ij9N
 xoBHNgXOyHbZzXsk8FEWX5piLhhnqmntCHAs6TuFiRW7vuGbGc0L7JJxeDtJE1RHFJSo
 iJf2Cvy8nDIPBUh9bkhqE36jyLYoNNJIPK07ZB9CaQS6RUdJ7k+fI12KSdAI+1jusiF6
 gNLH+jPgpynnYW0gAc+aYDGLY6fZGTa0KFVBWt/poFgLsjN178kB44eKr5SsnXJL7Xwy
 y6ia+kZewsHnSqUNGRQdQOXAEcIC01si6pVqum9OvEk+s0NF2dK9C8wnOmiLyAj9p8IX
 bjJg==
X-Gm-Message-State: ABy/qLbf1I3XohEkcJnkT9c+AJ7Do/wYSBObZIgf1AZSm77O6YDGyRdR
 0m5tXTE4fYoAR4GqLbyKQ1qbZ2ijlad/V4oNccwcqm/m7mhI0vwulAeTHL1lLG0YyXzVSsfHwCt
 k2gHe7EnkMbr8c+W5DkcxSuksMO4kGQJf7I+LlyHI4Q==
X-Received: by 2002:adf:f802:0:b0:314:3503:15ac with SMTP id
 s2-20020adff802000000b00314350315acmr1739356wrp.10.1689259968669; 
 Thu, 13 Jul 2023 07:52:48 -0700 (PDT)
X-Google-Smtp-Source: APBJJlHIe9bIwU8uwonGb/X776+z7KNCl4G7bhOiTrPif1cQEJqDIP/Vb7HU5xOiBtQ+0jRV7Mj+VA==
X-Received: by 2002:adf:f802:0:b0:314:3503:15ac with SMTP id
 s2-20020adff802000000b00314350315acmr1739345wrp.10.1689259968500; 
 Thu, 13 Jul 2023 07:52:48 -0700 (PDT)
Received: from redhat.com ([2.52.158.233]) by smtp.gmail.com with ESMTPSA id
 s14-20020adfea8e000000b00301a351a8d6sm8230571wrm.84.2023.07.13.07.52.46
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 13 Jul 2023 07:52:48 -0700 (PDT)
Date: Thu, 13 Jul 2023 10:52:44 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Christoph Hellwig <hch@infradead.org>
Subject: Re: [PATCH vhost v11 03/10] virtio_ring: introduce
 virtqueue_set_premapped()
Message-ID: <20230713105230-mutt-send-email-mst@kernel.org>
References: <20230710034237.12391-1-xuanzhuo@linux.alibaba.com>
 <20230710034237.12391-4-xuanzhuo@linux.alibaba.com>
 <ZK/cpSceLMovhmfR@infradead.org>
MIME-Version: 1.0
In-Reply-To: <ZK/cpSceLMovhmfR@infradead.org>
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

On Thu, Jul 13, 2023 at 04:14:45AM -0700, Christoph Hellwig wrote:
> On Mon, Jul 10, 2023 at 11:42:30AM +0800, Xuan Zhuo wrote:
> > This helper allows the driver change the dma mode to premapped mode.
> > Under the premapped mode, the virtio core do not do dma mapping
> > internally.
> > 
> > This just work when the use_dma_api is true. If the use_dma_api is false,
> > the dma options is not through the DMA APIs, that is not the standard
> > way of the linux kernel.
> 
> I have a hard time parsing this.

Me too unfortunately.

-- 
MST

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
