Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E20A6C433F5
	for <virtualization@archiver.kernel.org>; Tue, 17 May 2022 15:14:21 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 726CA84029;
	Tue, 17 May 2022 15:14:21 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
	by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id FL6Jbx4KPQp4; Tue, 17 May 2022 15:14:20 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp1.osuosl.org (Postfix) with ESMTPS id E38B884026;
	Tue, 17 May 2022 15:14:19 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id B7B2CC0032;
	Tue, 17 May 2022 15:14:19 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [IPv6:2605:bc80:3010::136])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 036F2C002D
 for <virtualization@lists.linux-foundation.org>;
 Tue, 17 May 2022 15:14:19 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id D7956611AA
 for <virtualization@lists.linux-foundation.org>;
 Tue, 17 May 2022 15:14:18 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp3.osuosl.org (amavisd-new);
 dkim=pass (1024-bit key) header.d=redhat.com
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id NT7cKY4rjnsn
 for <virtualization@lists.linux-foundation.org>;
 Tue, 17 May 2022 15:14:17 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.133.124])
 by smtp3.osuosl.org (Postfix) with ESMTPS id 88CFF61191
 for <virtualization@lists.linux-foundation.org>;
 Tue, 17 May 2022 15:14:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1652800456;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=zDg6wjmfUwF9ifzpSYYO2kPnU8cCr2A246HnYdWDqzY=;
 b=QS205yLe0fDlM0CE9B7kpakdjwqWxoWBb/kc6BAfZbGiNfocNyptoxII6sr/+/Yz/rhNc0
 GzTaFwIQVbLb/vYcaXyYoN/IOaeA/yY+WGsJzfB1G+AjbQttOSyOnVupdvoZyfLVlNiSoh
 W+eMi4u5PESKHpSFId2AzdDHK0M0nx0=
Received: from mail-qv1-f69.google.com (mail-qv1-f69.google.com
 [209.85.219.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-108-kxf4BFXkO9O9hHiey0Iz7A-1; Tue, 17 May 2022 11:14:15 -0400
X-MC-Unique: kxf4BFXkO9O9hHiey0Iz7A-1
Received: by mail-qv1-f69.google.com with SMTP id
 w6-20020a05621404a600b00461c740f357so5997165qvz.6
 for <virtualization@lists.linux-foundation.org>;
 Tue, 17 May 2022 08:14:15 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to;
 bh=zDg6wjmfUwF9ifzpSYYO2kPnU8cCr2A246HnYdWDqzY=;
 b=f66iH5SdVJ1kxfB2YQBuOPD0PRzE6oDifoGu71FjwSk9QTtYklbDSCrX4crOrzX+lX
 VgmRR3CxlBXaPPe9mUGm1x58khVn/Q7QChLWAnk9jOIQBz5bD4ammPG/RK5xdyA7A+uI
 LhnKEgrFlmK+2KLKE3q0YCZcuLs5lfj6NtMMOrObQGv4vqAJRx42015oUmz8U5Yiyhun
 aNv3APbsIfdhpRYfcfFJbYCZ/kj5jfd3ybR5cJz6COZLlgKJAm6/+WlBGL+JxZl8aOEa
 yI7miyhBF4Td0Ka55IBiIvuCtMnsrCnEcxee9FW29/6vHaRB6qRU4/DCO4GF54rTkY5m
 3hGQ==
X-Gm-Message-State: AOAM533o0yWtHwrivErmOyAVJ9Mlu8CBQ3+S0iu9Yz0yvpqoTFDCdwMQ
 PCMypeRXDFhTz3WRidxBhv96On0z+faDLuEs9NIIqNOmXgCoCfW09wuMPA6v8AWFOhapPm6pJRv
 pvbPkPvkk7DY3RwE+sYZwHvGhRoaYAw7n56gBsKcOjw==
X-Received: by 2002:a05:6214:2aa6:b0:45b:474:f9d7 with SMTP id
 js6-20020a0562142aa600b0045b0474f9d7mr20456628qvb.75.1652800454674; 
 Tue, 17 May 2022 08:14:14 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJw/BKkbx8m7APmdAwXMw6SgVlGa68Jz3O00qhGKjVlF/OOrYsrrU0GaJ2fqzzjTz3cD1U+3rg==
X-Received: by 2002:a05:6214:2aa6:b0:45b:474:f9d7 with SMTP id
 js6-20020a0562142aa600b0045b0474f9d7mr20456598qvb.75.1652800454354; 
 Tue, 17 May 2022 08:14:14 -0700 (PDT)
Received: from sgarzare-redhat (host-87-12-25-16.business.telecomitalia.it.
 [87.12.25.16]) by smtp.gmail.com with ESMTPSA id
 b21-20020ac85415000000b002f39b99f68asm7817273qtq.36.2022.05.17.08.14.11
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 17 May 2022 08:14:13 -0700 (PDT)
Date: Tue, 17 May 2022 17:14:04 +0200
From: Stefano Garzarella <sgarzare@redhat.com>
To: Arseniy Krasnov <AVKrasnov@sberdevices.ru>
Subject: Re: [RFC PATCH v1 0/8] virtio/vsock: experimental zerocopy receive
Message-ID: <20220517151404.vqse5tampdsaaeji@sgarzare-redhat>
References: <7cdcb1e1-7c97-c054-19cf-5caeacae981d@sberdevices.ru>
MIME-Version: 1.0
In-Reply-To: <7cdcb1e1-7c97-c054-19cf-5caeacae981d@sberdevices.ru>
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=sgarzare@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Disposition: inline
Cc: "kvm@vger.kernel.org" <kvm@vger.kernel.org>,
 "Michael S. Tsirkin" <mst@redhat.com>,
 "netdev@vger.kernel.org" <netdev@vger.kernel.org>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
 "virtualization@lists.linux-foundation.org"
 <virtualization@lists.linux-foundation.org>,
 Stefan Hajnoczi <stefanha@redhat.com>, kernel <kernel@sberdevices.ru>,
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
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
Content-Transfer-Encoding: 7bit
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Errors-To: virtualization-bounces@lists.linux-foundation.org
Sender: "Virtualization" <virtualization-bounces@lists.linux-foundation.org>

Hi Arseniy,

On Thu, May 12, 2022 at 05:04:11AM +0000, Arseniy Krasnov wrote:
>                              INTRODUCTION
>
>	Hello, this is experimental implementation of virtio vsock zerocopy
>receive. It was inspired by TCP zerocopy receive by Eric Dumazet. This API uses
>same idea: call 'mmap()' on socket's descriptor, then every 'getsockopt()' will
>fill provided vma area with pages of virtio RX buffers. After received data was
>processed by user, pages must be freed by 'madvise()'  call with MADV_DONTNEED
>flag set(if user won't call 'madvise()', next 'getsockopt()' will fail).

Sounds cool, but maybe we would need some socket/net experts here for 
review.

Could we do something similar for the sending path as well?

>
>                                 DETAILS
>
>	Here is how mapping with mapped pages looks exactly: first page mapping
>contains array of trimmed virtio vsock packet headers (in contains only length
>of data on the corresponding page and 'flags' field):
>
>	struct virtio_vsock_usr_hdr {
>		uint32_t length;
>		uint32_t flags;
>	};
>
>Field  'length' allows user to know exact size of payload within each sequence
>of pages and 'flags' allows user to handle SOCK_SEQPACKET flags(such as message
>bounds or record bounds). All other pages are data pages from RX queue.
>
>             Page 0      Page 1      Page N
>
>	[ hdr1 .. hdrN ][ data ] .. [ data ]
>           |        |       ^           ^
>           |        |       |           |
>           |        *-------------------*
>           |                |
>           |                |
>           *----------------*
>
>	Of course, single header could represent array of pages (when packet's
>buffer is bigger than one page).So here is example of detailed mapping layout
>for some set of packages. Lets consider that we have the following sequence  of
>packages: 56 bytes, 4096 bytes and 8200 bytes. All pages: 0,1,2,3,4 and 5 will
>be inserted to user's vma(vma is large enough).
>
>	Page 0: [[ hdr0 ][ hdr 1 ][ hdr 2 ][ hdr 3 ] ... ]
>	Page 1: [ 56 ]
>	Page 2: [ 4096 ]
>	Page 3: [ 4096 ]
>	Page 4: [ 4096 ]
>	Page 5: [ 8 ]
>
>	Page 0 contains only array of headers:
>	'hdr0' has 56 in length field.
>	'hdr1' has 4096 in length field.
>	'hdr2' has 8200 in length field.
>	'hdr3' has 0 in length field(this is end of data marker).
>
>	Page 1 corresponds to 'hdr0' and has only 56 bytes of data.
>	Page 2 corresponds to 'hdr1' and filled with data.
>	Page 3 corresponds to 'hdr2' and filled with data.
>	Page 4 corresponds to 'hdr2' and filled with data.
>	Page 5 corresponds to 'hdr2' and has only 8 bytes of data.
>
>	This patchset also changes packets allocation way: today implementation
>uses only 'kmalloc()' to create data buffer. Problem happens when we try to map
>such buffers to user's vma - kernel forbids to map slab pages to user's vma(as
>pages of "not large" 'kmalloc()' allocations are marked with PageSlab flag and
>"not large" could be bigger than one page). So to avoid this, data buffers now
>allocated using 'alloc_pages()' call.
>
>                                   TESTS
>
>	This patchset updates 'vsock_test' utility: two tests for new feature
>were added. First test covers invalid cases. Second checks valid transmission
>case.

Thanks for adding the test!

>
>                                BENCHMARKING
>
>	For benchmakring I've added small utility 'rx_zerocopy'. It works in
>client/server mode. When client connects to server, server starts sending exact
>amount of data to client(amount is set as input argument).Client reads data and
>waits for next portion of it. Client works in two modes: copy and zero-copy. In
>copy mode client uses 'read()' call while in zerocopy mode sequence of 'mmap()'
>/'getsockopt()'/'madvise()' are used. Smaller amount of time for transmission
>is better. For server, we can set size of tx buffer and for client we can set
>size of rx buffer or rx mapping size(in zerocopy mode). Usage of this utility
>is quiet simple:
>
>For client mode:
>
>./rx_zerocopy --mode client [--zerocopy] [--rx]
>
>For server mode:
>
>./rx_zerocopy --mode server [--mb] [--tx]
>
>[--mb] sets number of megabytes to transfer.
>[--rx] sets size of receive buffer/mapping in pages.
>[--tx] sets size of transmit buffer in pages.
>
>I checked for transmission of 4000mb of data. Here are some results:
>
>                           size of rx/tx buffers in pages
>               *---------------------------------------------------*
>               |    8   |    32    |    64   |   256    |   512    |
>*--------------*--------*----------*---------*----------*----------*
>|   zerocopy   |   24   |   10.6   |  12.2   |   23.6   |    21    | secs to
>*--------------*---------------------------------------------------- process
>| non-zerocopy |   13   |   16.4   |  24.7   |   27.2   |   23.9   | 4000 mb
>*--------------*----------------------------------------------------
>
>I think, that results are not so impressive, but at least it is not worse than
>copy mode and there is no need to allocate memory for processing date.

Why is it twice as slow in the first column?

>
>                                 PROBLEMS
>
>	Updated packet's allocation logic creates some problem: when host gets
>data from guest(in vhost-vsock), it allocates at least one page for each packet
>(even if packet has 1 byte payload). I think this could be resolved in several
>ways:

Can we somehow copy the incoming packets into the payload of the already 
queued packet?

This reminds me that we have yet to fix a similar problem with kmalloc() 
as well...

https://bugzilla.kernel.org/show_bug.cgi?id=215329

>	1) Make zerocopy rx mode disabled by default, so if user didn't enable
>it, current 'kmalloc()' way will be used.

That sounds reasonable to me, I guess also TCP needs a setsockopt() call 
to enable the feature, right?

>	2) Use 'kmalloc()' for "small" packets, else call page allocator. But
>in this case, we have mix of packets, allocated in two different ways thus
>during zerocopying to user(e.g. mapping pages to vma), such small packets will
>be handled in some stupid way: we need to allocate one page for user, copy data
>to it and then insert page to user's vma.

It seems more difficult to me, but at the same time doable. I would go 
more on option 1, though.

>
>P.S: of course this is experimental RFC, so what do You think guys?

It seems cool :-)

But I would like some feedback from the net guys to have some TCP-like 
things.

Thanks,
Stefano

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
