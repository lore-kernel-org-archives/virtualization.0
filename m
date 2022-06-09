Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A8504C433EF
	for <virtualization@archiver.kernel.org>; Thu,  9 Jun 2022 08:54:44 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 5290A41B60;
	Thu,  9 Jun 2022 08:54:44 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
	by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id 14fFNtrQSbKK; Thu,  9 Jun 2022 08:54:42 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp4.osuosl.org (Postfix) with ESMTPS id 059EC41A64;
	Thu,  9 Jun 2022 08:54:42 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id C5ABFC0039;
	Thu,  9 Jun 2022 08:54:41 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [IPv6:2605:bc80:3010::133])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 522C0C002D
 for <virtualization@lists.linux-foundation.org>;
 Thu,  9 Jun 2022 08:54:40 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id 39EF340BF1
 for <virtualization@lists.linux-foundation.org>;
 Thu,  9 Jun 2022 08:54:40 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp2.osuosl.org (amavisd-new);
 dkim=pass (1024-bit key) header.d=redhat.com
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id tFqIe3kQFKlN
 for <virtualization@lists.linux-foundation.org>;
 Thu,  9 Jun 2022 08:54:39 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.129.124])
 by smtp2.osuosl.org (Postfix) with ESMTPS id 0AD4C405D4
 for <virtualization@lists.linux-foundation.org>;
 Thu,  9 Jun 2022 08:54:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1654764877;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=tvWtgkYBzt9DbATf2rlAmzgDtHttB4fvGNf4mSgVDKk=;
 b=DolXWM56kIehFrHaLgs76bgGZnaMv8sSSvBg01nrtGtckY6aUZzfdLttAQnIwIKg/9Uoil
 9bk+zR9JGyJe0HAWF8dfsqgfpXp0napFQMQlcGoTEmK5In8/NgaJcEtYgfI6k4CQ3VePqG
 rpSxg7uKi4GxbOwsqB4JulyMQJ1f8yM=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-187-CBDDtYkwOGSrt4n7i7VZDQ-1; Thu, 09 Jun 2022 04:54:36 -0400
X-MC-Unique: CBDDtYkwOGSrt4n7i7VZDQ-1
Received: by mail-wm1-f69.google.com with SMTP id
 az7-20020a05600c600700b0039c3ed7fa89so9915725wmb.8
 for <virtualization@lists.linux-foundation.org>;
 Thu, 09 Jun 2022 01:54:36 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to;
 bh=tvWtgkYBzt9DbATf2rlAmzgDtHttB4fvGNf4mSgVDKk=;
 b=mYbAkUQTcU0LQUSpbnqqxHjO8c3j6DZB5dYBINwdfs3tNfKvHCywJVW9vnR+c9s3oa
 6785Dw3L7m54X8S1qsfTg+WvzJjCpXMyJ3nsX8PolwNFeazTyHs2RvIpMnvBtaorYZJi
 gKxuoAddIwaKSzRA9wChG+dLG4rrHBWpRiNYWf30BpHjGUFxSuY7ViChyt7nb4kj21Ds
 8PkxfxECxVruNsM1vPOKGCz5CAwLjG9aKERcSW0pLxBHVqIArXIWD1ZdDwqopTW+oRRV
 6Red8YFEcJGQluF8OwlJPdG5DRswkGbGdChO3uBltRXSLdvlfm1s6zH7mHYkvk6cDmPc
 +ZTg==
X-Gm-Message-State: AOAM531VMNJQb0p2u2RXTagoOIjPXD4rsbEO2L0LEjQVbZaMFVYmnJNE
 cthQwouomvv6dA9HtnLByvIZ0ULOYlXzsOfJ7dnPs/o7qJLyb+AuxQypgcl4fQnNT5Ui7w4+QJb
 0bQruzERbmBbIqeE1486ikFMZXhBN7d4npaKS/oFIyQ==
X-Received: by 2002:adf:e5d0:0:b0:210:313a:e4dc with SMTP id
 a16-20020adfe5d0000000b00210313ae4dcmr36674909wrn.152.1654764875097; 
 Thu, 09 Jun 2022 01:54:35 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJzR7k/vdtBFj/GYt/MtBX7xF11gJz7ChUoPOTqELw1aa5VvOp+SIRJBSOhp8lJfnJDnuWfn3g==
X-Received: by 2002:adf:e5d0:0:b0:210:313a:e4dc with SMTP id
 a16-20020adfe5d0000000b00210313ae4dcmr36674875wrn.152.1654764874842; 
 Thu, 09 Jun 2022 01:54:34 -0700 (PDT)
Received: from sgarzare-redhat (host-79-46-200-40.retail.telecomitalia.it.
 [79.46.200.40]) by smtp.gmail.com with ESMTPSA id
 s19-20020a1cf213000000b0039c4945c753sm15291073wmc.39.2022.06.09.01.54.33
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 09 Jun 2022 01:54:33 -0700 (PDT)
Date: Thu, 9 Jun 2022 10:54:28 +0200
From: Stefano Garzarella <sgarzare@redhat.com>
To: Arseniy Krasnov <AVKrasnov@sberdevices.ru>
Subject: Re: [RFC PATCH v2 0/8] virtio/vsock: experimental zerocopy receive
Message-ID: <20220609085428.idi4qzydhdpzszzw@sgarzare-redhat>
References: <e37fdf9b-be80-35e1-ae7b-c9dfeae3e3db@sberdevices.ru>
MIME-Version: 1.0
In-Reply-To: <e37fdf9b-be80-35e1-ae7b-c9dfeae3e3db@sberdevices.ru>
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=sgarzare@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Disposition: inline
Cc: Krasnov Arseniy <oxffffaa@gmail.com>,
 "kvm@vger.kernel.org" <kvm@vger.kernel.org>,
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
I left some comments in the patches, and I'm adding something also here:

On Fri, Jun 03, 2022 at 05:27:56AM +0000, Arseniy Krasnov wrote:
>                              INTRODUCTION
>
>	Hello, this is experimental implementation of virtio vsock zerocopy
>receive. It was inspired by TCP zerocopy receive by Eric Dumazet. This API uses
>same idea: call 'mmap()' on socket's descriptor, then every 'getsockopt()' will
>fill provided vma area with pages of virtio RX buffers. After received data was
>processed by user, pages must be freed by 'madvise()'  call with MADV_DONTNEED
>flag set(if user won't call 'madvise()', next 'getsockopt()' will 
>fail).

If it is not too time-consuming, can we have a table/list to compare this 
and the TCP zerocopy?

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
>		uint32_t copy_len;
>	};
>
>Field  'length' allows user to know exact size of payload within each sequence
>of pages and 'flags' allows user to handle SOCK_SEQPACKET flags(such as message
>bounds or record bounds). Field 'copy_len' is described below in 'v1->v2' part.
>All other pages are data pages from RX queue.
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

In order to have a "userspace polling-friendly approach" and reduce 
number of syscall, can we allow for example the userspace to mmap at 
least the first header before packets arrive.
Then the userspace can poll a flag or other fields in the header to 
understand that there are new packets.

That would be cool, but in the meantime it would be nice to behave 
similarly to TCP, which is why the comparison table I mentioned earlier 
would be useful.

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
>Result in first column(where non-zerocopy works better than zerocopy) happens
>because time, spent in 'read()' system call is smaller that time in 'getsockopt'
>+ 'madvise'. I've checked that.
>
>I think, that results are not so impressive, but at least it is not worse than
>copy mode and there is no need to allocate memory for processing date.
>
>                                 PROBLEMS
>
>	Updated packet's allocation logic creates some problem: when host gets
>data from guest(in vhost-vsock), it allocates at least one page for each packet
>(even if packet has 1 byte payload). I think this could be resolved in several
>ways:
>	1) Make zerocopy rx mode disabled by default, so if user didn't enable
>it, current 'kmalloc()' way will be used. <<<<<<< (IMPLEMENTED IN V2)

Yep, but I think we should not allow to change it while we are connected 
(see comments in the patches.)

>	2) Use 'kmalloc()' for "small" packets, else call page allocator. But
>in this case, we have mix of packets, allocated in two different ways thus
>during zerocopying to user(e.g. mapping pages to vma), such small packets will
>be handled in some stupid way: we need to allocate one page for user, copy data
>to it and then insert page to user's vma.
>
>v1 -> v2:
> 1) Zerocopy receive mode could be enabled/disabled(disabled by default). I
>    didn't use generic SO_ZEROCOPY flag, because in virtio-vsock case this
>    feature depends on transport support. Instead of SO_ZEROCOPY, AF_VSOCK
>    layer flag was added: SO_VM_SOCKETS_ZEROCOPY, while previous meaning of
>    SO_VM_SOCKETS_ZEROCOPY(insert receive buffers to user's vm area) now
>    renamed to SO_VM_SOCKETS_MAP_RX.
> 2) Packet header which is exported to user now get new field: 'copy_len'.
>    This field handles special case:  user reads data from socket in non
>    zerocopy way(with disabled zerocopy) and then enables zerocopy feature.
>    In this case vhost part will switch data buffer allocation logic from
>    'kmalloc()' to direct calls for buddy allocator. But, there could be
>    some pending 'kmalloc()' allocated packets in socket's rx list, and then
>    user tries to read such packets in zerocopy way, dequeue will fail,
>    because SLAB pages could not be inserted to user's vm area. So when such
>    packet is found during zerocopy dequeue, dequeue loop will break and
>    'copy_len' will show size of such "bad" packet. After user detects this
>    case, it must use 'read()/recv()' calls to dequeue such packet.
> 3) Also may be move this features under config option?

Do you mean a build config like CONFIG_VSOCK_ZERO_COPY?

I'm not sure it's needed.

Thanks,
Stefano

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
