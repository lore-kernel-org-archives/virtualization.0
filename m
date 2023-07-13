Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 85322C0015E
	for <virtualization@archiver.kernel.org>; Thu, 13 Jul 2023 14:47:39 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 11A6B613A5;
	Thu, 13 Jul 2023 14:47:39 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 11A6B613A5
Authentication-Results: smtp3.osuosl.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=B1sD9MnZ
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
	by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id gBtvmYcsGmNJ; Thu, 13 Jul 2023 14:47:38 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp3.osuosl.org (Postfix) with ESMTPS id 91D3E613AD;
	Thu, 13 Jul 2023 14:47:37 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 91D3E613AD
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 685C3C0071;
	Thu, 13 Jul 2023 14:47:37 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by lists.linuxfoundation.org (Postfix) with ESMTP id DB23EC0032
 for <virtualization@lists.linux-foundation.org>;
 Thu, 13 Jul 2023 14:47:36 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id ADBE8613B4
 for <virtualization@lists.linux-foundation.org>;
 Thu, 13 Jul 2023 14:47:36 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org ADBE8613B4
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id jM8l3b3jMty7
 for <virtualization@lists.linux-foundation.org>;
 Thu, 13 Jul 2023 14:47:36 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org E6106613AD
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.133.124])
 by smtp3.osuosl.org (Postfix) with ESMTPS id E6106613AD
 for <virtualization@lists.linux-foundation.org>;
 Thu, 13 Jul 2023 14:47:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1689259654;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=iealZFgg2DniFqya6LNgQsH+iMMS+6L0OLnGn56hn70=;
 b=B1sD9MnZY66hJXT83eHtunZqZlnPIEPVCdzVn04SXrCAd+T2qh/Npwyy3lz5xNeLHnQ8P5
 5xiZ2FFYuaT01pPhhMZINFyIVdA7ywrw4J9t7IwkJ0GsaXbngzP9X79UZD1l27h7oHu6FR
 uDp3MaJnDhvva9YL+oO7hI7oQ1c8op4=
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-610-JGmNbzHhMJCOFa-RrsFTqg-1; Thu, 13 Jul 2023 10:47:29 -0400
X-MC-Unique: JGmNbzHhMJCOFa-RrsFTqg-1
Received: by mail-wr1-f72.google.com with SMTP id
 ffacd0b85a97d-2f2981b8364so465574f8f.1
 for <virtualization@lists.linux-foundation.org>;
 Thu, 13 Jul 2023 07:47:28 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1689259648; x=1691851648;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=iealZFgg2DniFqya6LNgQsH+iMMS+6L0OLnGn56hn70=;
 b=Sk+wczMi/TmQ+X5Vp4yid0Dn3pBu2qSuJcgaS44ijtW4fgggxASWPqq4HMFqSxSYFa
 7+23R1iV6ZeOhjNLUwdpWVQhcwxu3ZRX6lwRgWhDU4253bO/H/hnRXBhOJOLhLMARdDL
 60yeP4xQs1YTuXVgXEQz5vVQHWohIN3da/YX8C0f3KqJKNW2z+dpylY2yNfe2rYUIom+
 w+CMa5tvfMfpoEnMmUdlrIpJZRHYbsBscrQk82sQmZbpnpfSmAImtpCZly4fGzXlEHp9
 2aIBkIH4HyUUtj07Zp3zpSJlqPttcqtkCMO4XwOdWSqFWBn7GSm33/6WKe97hQGNgYSz
 aCvQ==
X-Gm-Message-State: ABy/qLbb07R2JXr3uKIttBYIbwWKbNHuzzsAN45IGE5fFkD3jiGG38Ey
 cMXRtOzBUp62hsK/w03Jcj4VdOrMYXN61cJMle8UKLq8hTOpQKTHeTRl/DJp4sP9gBfYkfjvwVA
 6ZdYh+GXualn6fqOX1NEBJUVBikuE52v518ErNMQDzA==
X-Received: by 2002:a5d:4eca:0:b0:314:362d:6d7b with SMTP id
 s10-20020a5d4eca000000b00314362d6d7bmr2048944wrv.19.1689259648001; 
 Thu, 13 Jul 2023 07:47:28 -0700 (PDT)
X-Google-Smtp-Source: APBJJlG8e9y7hkjgQHjtW8y2oQn6ZCN15HI4NlGXFd+3he125O+mhw8erfUncBxCq24lPOgrWlvKHg==
X-Received: by 2002:a5d:4eca:0:b0:314:362d:6d7b with SMTP id
 s10-20020a5d4eca000000b00314362d6d7bmr2048922wrv.19.1689259647712; 
 Thu, 13 Jul 2023 07:47:27 -0700 (PDT)
Received: from redhat.com ([2.52.158.233]) by smtp.gmail.com with ESMTPSA id
 p5-20020a5d4e05000000b003143d80d11dsm8094529wrt.112.2023.07.13.07.47.25
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 13 Jul 2023 07:47:27 -0700 (PDT)
Date: Thu, 13 Jul 2023 10:47:23 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Christoph Hellwig <hch@infradead.org>
Subject: Re: [PATCH vhost v11 03/10] virtio_ring: introduce
 virtqueue_set_premapped()
Message-ID: <20230713104542-mutt-send-email-mst@kernel.org>
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
> 
> More importantly having two modes seems very error prone going down
> the route.  If the premapping is so important, why don't we do it
> always?

There are a gazillion virtio drivers and most of them just use the
virtio API, without bothering with these micro-optimizations.  virtio
already tracks addresses so mapping/unmapping them for DMA is easier
done in the core.  It's only networking and only with XDP where the
difference becomes measureable.

-- 
MST

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
