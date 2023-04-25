Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B7FBBC6FD18
	for <virtualization@archiver.kernel.org>; Tue, 25 Apr 2023 08:12:29 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 5418381DE5;
	Tue, 25 Apr 2023 08:12:29 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 5418381DE5
Authentication-Results: smtp1.osuosl.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=iJJDiFy1
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
	by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id 1zhP8Wpbjf45; Tue, 25 Apr 2023 08:12:28 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp1.osuosl.org (Postfix) with ESMTPS id E928781DE0;
	Tue, 25 Apr 2023 08:12:27 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org E928781DE0
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id AFCE0C0036;
	Tue, 25 Apr 2023 08:12:27 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 6168CC002A
 for <virtualization@lists.linux-foundation.org>;
 Tue, 25 Apr 2023 08:12:26 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id 2E1874026A
 for <virtualization@lists.linux-foundation.org>;
 Tue, 25 Apr 2023 08:12:26 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org 2E1874026A
Authentication-Results: smtp2.osuosl.org;
 dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com
 header.a=rsa-sha256 header.s=mimecast20190719 header.b=iJJDiFy1
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id FsxVZ-qeC5V1
 for <virtualization@lists.linux-foundation.org>;
 Tue, 25 Apr 2023 08:12:25 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org 73F904019E
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.129.124])
 by smtp2.osuosl.org (Postfix) with ESMTPS id 73F904019E
 for <virtualization@lists.linux-foundation.org>;
 Tue, 25 Apr 2023 08:12:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1682410343;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=t71HgcdOLz2lcyahjqtdGmdShpS9YMcQtrEy3utJDfI=;
 b=iJJDiFy1Xgt6arHuLD5xCC4xDRfWgIJSyYgTL/w8LZZ1YqvYB3H/4I+L2gMrKmliMjmYvC
 BDz//MT763Wy5OXBUOP0tdDtMutahUqyT0rZounTvk78D74tzM0vY3v1r8Aw/h4iR+3mRx
 uYmqx4hF0gMuedSqDFEeuJzwPgpwGJY=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-341-UA97KKG7NvK5NXZ6Bl474w-1; Tue, 25 Apr 2023 04:12:12 -0400
X-MC-Unique: UA97KKG7NvK5NXZ6Bl474w-1
Received: by mail-wm1-f70.google.com with SMTP id
 5b1f17b1804b1-3f18b63229bso52082655e9.0
 for <virtualization@lists.linux-foundation.org>;
 Tue, 25 Apr 2023 01:12:12 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1682410331; x=1685002331;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=t71HgcdOLz2lcyahjqtdGmdShpS9YMcQtrEy3utJDfI=;
 b=dtfX7cq2ZHLx+6QigT8aJo7X3EXEqY8sFG1QFfrRpzDtVhITexkegBw7JyuEzcYe1w
 P49AX+BZ3PwU+/hYU75+xaP0vfOA7JlxFwmQ2AVwtnauQIcX5ylRIdhtZRC/SbNu62D1
 ie6fPXeJBMdhJBwY0jBw3VZhlP+axszeXdKoqhFh42tSA22gZRKUEe4E6YiiH6pU1FIc
 EzavA1qmTYKjrYAlTVd0MR/DFBekoFB/g0Z7SrUqcrBsl1xXEVxtFemxbEokV1Qf2y48
 A3tDwd2buyg+guhNmOfoMmiLuDUOIfdADsP+kSguuDKHrDromyZUmFDIgBq+uLvaJnma
 E1Yg==
X-Gm-Message-State: AAQBX9c2LdqDIcUkYVc3SUgRkNodJW6OBQvVXRhHAyCLSa5cgW++i4P2
 ZgqoDHkSydjPE77VrqA00iEVqOC1NuQbdnODplzrufXSQ7pFQlR/gA3a7f9DiIMldcZVYqydYnP
 G5Z0Z59aHobgc4ai3PRF4hnUUIHgUHY1G4CQ61fF8hQ==
X-Received: by 2002:a05:6000:c:b0:304:6d34:8fc9 with SMTP id
 h12-20020a056000000c00b003046d348fc9mr6841506wrx.2.1682410331251; 
 Tue, 25 Apr 2023 01:12:11 -0700 (PDT)
X-Google-Smtp-Source: AKy350YROM05Vji85jKML5EORZKXj7LBcybOF+TFqDsboJo9RpXcWM26KHTCi4FZ8x7JjzgYf8PVYg==
X-Received: by 2002:a05:6000:c:b0:304:6d34:8fc9 with SMTP id
 h12-20020a056000000c00b003046d348fc9mr6841476wrx.2.1682410330931; 
 Tue, 25 Apr 2023 01:12:10 -0700 (PDT)
Received: from redhat.com ([2.55.17.255]) by smtp.gmail.com with ESMTPSA id
 p17-20020a056000019100b002fda1b12a0bsm12594181wrx.2.2023.04.25.01.12.07
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 25 Apr 2023 01:12:10 -0700 (PDT)
Date: Tue, 25 Apr 2023 04:12:05 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Christoph Hellwig <hch@infradead.org>
Subject: Re: [PATCH net-next] xsk: introduce xsk_dma_ops
Message-ID: <20230425035259-mutt-send-email-mst@kernel.org>
References: <20230417181950.5db68526@kernel.org>
 <1681784379.909136-2-xuanzhuo@linux.alibaba.com>
 <20230417195400.482cfe75@kernel.org>
 <ZD4kMOym15pFcjq+@infradead.org>
 <20230417231947.3972f1a8@kernel.org>
 <ZD95RY9PjVRi7qz3@infradead.org>
 <20230419094506.2658b73f@kernel.org>
 <ZEDZaitjcX+egzvf@infradead.org>
 <1681981908.9700203-3-xuanzhuo@linux.alibaba.com>
 <ZEFlzdiyu2IAyX7a@infradead.org>
MIME-Version: 1.0
In-Reply-To: <ZEFlzdiyu2IAyX7a@infradead.org>
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Disposition: inline
Cc: Alexei Starovoitov <ast@kernel.org>,
 virtualization@lists.linux-foundation.org, Eric Dumazet <edumazet@google.com>,
 Xuan Zhuo <xuanzhuo@linux.alibaba.com>, Daniel Borkmann <daniel@iogearbox.net>,
 John Fastabend <john.fastabend@gmail.com>, Jakub Kicinski <kuba@kernel.org>,
 Paolo Abeni <pabeni@redhat.com>, Guenter Roeck <linux@roeck-us.net>,
 Maciej Fijalkowski <maciej.fijalkowski@intel.com>,
 Jesper Dangaard Brouer <hawk@kernel.org>,
 Jonathan Lemon <jonathan.lemon@gmail.com>,
 Magnus Karlsson <magnus.karlsson@intel.com>, Jens Axboe <axboe@kernel.dk>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 =?iso-8859-1?Q?Bj=F6rn_T=F6pel?= <bjorn@kernel.org>, netdev@vger.kernel.org,
 bpf@vger.kernel.org, Linus Torvalds <torvalds@linux-foundation.org>,
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

On Thu, Apr 20, 2023 at 09:18:21AM -0700, Christoph Hellwig wrote:
> On Thu, Apr 20, 2023 at 05:11:48PM +0800, Xuan Zhuo wrote:
> > I know that the current design of DMA API only supports some physical hardware,
> > but can it be modified or expanded?
> 
> I think the important point is that for some cases there is no need
> to dma map at all, and upper layers should be fine by that by just
> doing the dma mapping in helpers called by the driver.
> 
> The virtio drivers then check if platform_access is set, then call the
> generic dma mapping helper, or if not just allocate memory using
> alloc_pages and also skip all the sync calls.

In theory, absolutely. In practice modern virtio devices are ok,
the reason we are stuck supporting old legacy ones is because legacy
devices are needed to run old guests. And then people turn
around and run a new guest on the same device,
for example because they switch back and forth e.g.
for data recovery? Or because whoever is selling the
host wants to opt for maximum compatibility.

Teaching all of linux to sometimes use dma and sometimes not
is a lot of work, and for limited benefit of these legacy systems.
We do it in a limited number of cases but generally
making DMA itself DTRT sounds more attractive.

So special DMA ops for these makes some sense: yes the
firmware described DMA is wrong on these boxes but
buggy firmware is not so unusual, is it?
Given virtio devices actually are on a virtual bus (the virtio bus)
sticking the fake DMA ops on this bus seems to make sense
as a way to express this quirk.

No?

-- 
MST

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
