Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 96BB6C433F5
	for <virtualization@archiver.kernel.org>; Tue, 24 May 2022 07:33:13 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 431EB82C75;
	Tue, 24 May 2022 07:33:13 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
	by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id k1HDB-__aUbr; Tue, 24 May 2022 07:33:12 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp1.osuosl.org (Postfix) with ESMTPS id 8AB6482C21;
	Tue, 24 May 2022 07:33:11 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 5BB7BC0032;
	Tue, 24 May 2022 07:33:11 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [IPv6:2605:bc80:3010::138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 5FD1BC002D
 for <virtualization@lists.linux-foundation.org>;
 Tue, 24 May 2022 07:33:10 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id 44E4E82C75
 for <virtualization@lists.linux-foundation.org>;
 Tue, 24 May 2022 07:33:10 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id J8HlLTqwX75w
 for <virtualization@lists.linux-foundation.org>;
 Tue, 24 May 2022 07:33:09 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.133.124])
 by smtp1.osuosl.org (Postfix) with ESMTPS id E4F8982C21
 for <virtualization@lists.linux-foundation.org>;
 Tue, 24 May 2022 07:33:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1653377587;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=nc0quxO4J16P5xk58WIaztMrbbSvqm8aAXmU1D9eYJ4=;
 b=BHyqGHdvfWqzkK/ZYuVxUeDIaeKeuQ7EqtVIwd+soCjy39JXWZSZuOZjAGJHW550pK8CoU
 jVnRf1LrIndGIP+4s1Ssj5iZVe5xaX0KCfiGifspD25vpmZ2VbMC6NnieW7pe+JFU6hqAx
 SOLiKTsz+lrJSwX+ziowj+FQsoFz0K8=
Received: from mail-qv1-f70.google.com (mail-qv1-f70.google.com
 [209.85.219.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-490-i9qpTcAYOwCYtcvugtmDuA-1; Tue, 24 May 2022 03:33:06 -0400
X-MC-Unique: i9qpTcAYOwCYtcvugtmDuA-1
Received: by mail-qv1-f70.google.com with SMTP id
 ck16-20020a05621404d000b00461bcafbbe9so12700192qvb.23
 for <virtualization@lists.linux-foundation.org>;
 Tue, 24 May 2022 00:33:06 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:content-transfer-encoding
 :in-reply-to;
 bh=nc0quxO4J16P5xk58WIaztMrbbSvqm8aAXmU1D9eYJ4=;
 b=hTImeWvXTbqtBhMIqHmYiIp8XFvlwqYuLBzUS6funI7IDggJZhI5Sballoa+hkcN7s
 gKVvje/IXzSnQLkdw3IKWz3c0dVG/b5x1ZRxDnqhd7VuLSNcf38zFQBeF71wVeIMLrdl
 6ui/sENJ1TBQtY/prLCeVW84vjJ2Ttt56XYgkx+3i3T+Ke4g7WNDE1z5XFUNLkRqkUeJ
 +PmDlMfI5Jye2su1eRZhPZjrRZxuvWYts68lJUV9ErVSOY4F77dinaogRq2Og4ul3aCt
 F6ez1uLkFYFBTiakdOaM2Xut4h1M3zvuZcU1Wg4TXMJYFcNnW1dIROLUdJIk4lvnxpQL
 atPA==
X-Gm-Message-State: AOAM5338gRJShBJ5BSQM1pjAyNCx2CvBMee20M1K4wQ9sDXiY0wSv2x7
 JUdww4oug1XcMhfEfPFwGQHVSzaDUU2GH0RDtuxuAJ5EOxm0dC39ezh7RWREqCsIvmlrubi/2ei
 QHQvXnHeG2aMmA3E1NO3AcNTLRsYouG/fn3kLL6+3mw==
X-Received: by 2002:a05:6214:29ed:b0:462:12c7:e525 with SMTP id
 jv13-20020a05621429ed00b0046212c7e525mr14337050qvb.103.1653377585720; 
 Tue, 24 May 2022 00:33:05 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJxpE9SJiGYXMMYBtv5GJ5wp83RMZiYPAjWM+XCwHFqeq/+El/4WVAF+CheI3qT9ZUG1nbeKrQ==
X-Received: by 2002:a05:6214:29ed:b0:462:12c7:e525 with SMTP id
 jv13-20020a05621429ed00b0046212c7e525mr14337012qvb.103.1653377585290; 
 Tue, 24 May 2022 00:33:05 -0700 (PDT)
Received: from sgarzare-redhat (host-87-12-25-16.business.telecomitalia.it.
 [87.12.25.16]) by smtp.gmail.com with ESMTPSA id
 m24-20020ae9e018000000b006a37710ef89sm4011426qkk.115.2022.05.24.00.33.02
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 24 May 2022 00:33:04 -0700 (PDT)
Date: Tue, 24 May 2022 09:32:56 +0200
From: Stefano Garzarella <sgarzare@redhat.com>
To: Arseniy Krasnov <AVKrasnov@sberdevices.ru>
Subject: Re: [RFC PATCH v1 0/8] virtio/vsock: experimental zerocopy receive
Message-ID: <20220524073256.fpaknbcm7w5trata@sgarzare-redhat>
References: <7cdcb1e1-7c97-c054-19cf-5caeacae981d@sberdevices.ru>
 <20220517151404.vqse5tampdsaaeji@sgarzare-redhat>
 <413d821f-3893-befa-7009-2f87ef51af7a@sberdevices.ru>
 <20220519074208.q2bmytl2dphtjgse@sgarzare-redhat>
 <27f906a8-181f-e6d8-f5a1-035604a2decb@sberdevices.ru>
MIME-Version: 1.0
In-Reply-To: <27f906a8-181f-e6d8-f5a1-035604a2decb@sberdevices.ru>
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
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset="iso-8859-1"; Format="flowed"
Errors-To: virtualization-bounces@lists.linux-foundation.org
Sender: "Virtualization" <virtualization-bounces@lists.linux-foundation.org>

On Fri, May 20, 2022 at 11:09:11AM +0000, Arseniy Krasnov wrote:
>Hello Stefano,
>
>On 19.05.2022 10:42, Stefano Garzarella wrote:
>> On Wed, May 18, 2022 at 11:04:30AM +0000, Arseniy Krasnov wrote:
>>> Hello Stefano,
>>>
>>> On 17.05.2022 18:14, Stefano Garzarella wrote:
>>>> Hi Arseniy,
>>>>
>>>> On Thu, May 12, 2022 at 05:04:11AM +0000, Arseniy Krasnov wrote:
>>>>> =A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=
=A0=A0=A0=A0=A0 INTRODUCTION
>>>>>
>>>>> =A0=A0=A0=A0Hello, this is experimental implementation of virtio vsoc=
k zerocopy
>>>>> receive. It was inspired by TCP zerocopy receive by Eric Dumazet. Thi=
s API uses
>>>>> same idea: call 'mmap()' on socket's descriptor, then every 'getsocko=
pt()' will
>>>>> fill provided vma area with pages of virtio RX buffers. After receive=
d data was
>>>>> processed by user, pages must be freed by 'madvise()'=A0 call with MA=
DV_DONTNEED
>>>>> flag set(if user won't call 'madvise()', next 'getsockopt()' will fai=
l).
>>>>
>>>> Sounds cool, but maybe we would need some socket/net experts here for =
review.
>>>
>>> Yes, that would be great
>>>
>>>>
>>>> Could we do something similar for the sending path as well?
>>>
>>> Here are thoughts about zerocopy transmission:
>>>
>>> I tried to implement this feature in the following way: user creates
>>> some page aligned buffer, then during tx packet allocation instead of
>>> creating data buffer with 'kmalloc()', i tried to add user's buffer
>>> to virtio queue. But found problem: as kernel virtio API uses virtual
>>> addresses to add new buffers, in the deep of virtio subsystem
>>> 'virt_to_phys()' is called to get physical address of buffer, so user's
>>> virtual address won't be translated correctly to physical address(in
>>> theory, i can perform page walk for such user's va, get physical address
>>> and pass some "fake" virtual address to virtio API in order to make
>>> 'virt_to_phys()' return valid physical address(but i think this is ugly=
).
>>
>> And maybe we should also pin the pages to prevent them from being replac=
ed.
>>
>> I think we should do something similar to what we do in vhost-vdpa.
>> Take a look at vhost_vdpa_pa_map() in drivers/vhost/vdpa.c
>
>Hm, ok. I'll read about vdpa...
>
>>
>>>
>>>
>>> If we are talking about 'mmap()' way, i think we can do the following:
>>> user calls 'mmap()' on socket, kernel fills newly created mapping with
>>> allocated pages(all pages have rw permissions). Now user can use pages
>>> of this mapping(e.g. fill it with data). Finally, to start transmission,
>>> user calls 'getsockopt()' or some 'ioctl()' and kernel processes data of
>>> this mapping. Also as this call will return immediately(e.g. it is
>>> asynchronous), some completion logic must be implemented. For example
>>> use same way as MSG_ZEROCOPY uses - poll error queue of socket to get
>>> message that pages could be reused, or don't allow user to work with
>>> these pages: unmap it, perform transmission and finally free pages.
>>> To start new transmission user need to call 'mmap()' again.
>>>
>>> =A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=
=A0=A0=A0 OR
>>>
>>> I think there is another unusual way for zerocopy tx: let's use 'vmspli=
ce()'
>>> /'splice()'. In this approach to transmit something, user does the foll=
owing
>>> steps:
>>> 1) Creates pipe.
>>> 2) Calls 'vmsplice(SPLICE_F_GIFT)' on this pipe, insert data pages to i=
t.
>>> =A0 SPLICE_F_GIFT allows user to forget about allocated pages - kernel =
will
>>> =A0 free it.
>>> 3) Calls 'splice(SPLICE_F_MOVE)' from pipe to socket. SPLICE_F_MOVE will
>>> =A0 move pages from pipe to socket(e.g. in special socket callback we g=
ot
>>> =A0 set of pipe's pages as input argument and all pages will be inserted
>>> =A0 to virtio queue).
>>>
>>> But as SPLICE_F_MOVE support is disabled, it must be repaired first.
>>
>> Splice seems interesting, but it would be nice If we do something simila=
r to TCP. IIUC they use a flag for send(2):
>>
>> =A0=A0=A0 send(fd, buf, sizeof(buf), MSG_ZEROCOPY);
>>
>
>Yes, but in this way i think:
>1) What is 'buf'? It can't be user's address, since this buffer must be in=
serted to tx queue.
>   E.g. it must be allocated by kernel and then returned to user for tx pu=
rposes. In TCP
>   case, 'buf' is user's address(of course page aligned) because TCP logic=
 uses sk_buff which
>   allows to use such memory as data buffer.

IIUC we can pin that buffer like we do in vhost-vdpa, and use it in the =

VQ.

>2) To wait tx process is done(e.g. pages can be used again), such =

>API(send + MSG_ZEROCOPY),
>   uses socket's error queue - poll events that tx is finished. So same =

>   way must be
>   implemented for virtio vsock.

Yeah, I think so.

>
>> =A0
>>>
>>>>
>>>>>
>>>>> =A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=
=A0=A0=A0=A0=A0=A0=A0=A0 DETAILS
>>>>>
>>>>> =A0=A0=A0=A0Here is how mapping with mapped pages looks exactly: firs=
t page mapping
>>>>> contains array of trimmed virtio vsock packet headers (in contains on=
ly length
>>>>> of data on the corresponding page and 'flags' field):
>>>>>
>>>>> =A0=A0=A0=A0struct virtio_vsock_usr_hdr {
>>>>> =A0=A0=A0=A0=A0=A0=A0 uint32_t length;
>>>>> =A0=A0=A0=A0=A0=A0=A0 uint32_t flags;
>>>>> =A0=A0=A0=A0};
>>>>>
>>>>> Field=A0 'length' allows user to know exact size of payload within ea=
ch sequence
>>>>> of pages and 'flags' allows user to handle SOCK_SEQPACKET flags(such =
as message
>>>>> bounds or record bounds). All other pages are data pages from RX queu=
e.
>>>>>
>>>>> =A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 Page 0=A0=A0=A0=A0=A0 Page 1=A0=A0=
=A0=A0=A0 Page N
>>>>>
>>>>> =A0=A0=A0=A0[ hdr1 .. hdrN ][ data ] .. [ data ]
>>>>> =A0=A0=A0=A0=A0=A0=A0=A0=A0 |=A0=A0=A0=A0=A0=A0=A0 |=A0=A0=A0=A0=A0=
=A0 ^=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 ^
>>>>> =A0=A0=A0=A0=A0=A0=A0=A0=A0 |=A0=A0=A0=A0=A0=A0=A0 |=A0=A0=A0=A0=A0=
=A0 |=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 |
>>>>> =A0=A0=A0=A0=A0=A0=A0=A0=A0 |=A0=A0=A0=A0=A0=A0=A0 *-----------------=
--*
>>>>> =A0=A0=A0=A0=A0=A0=A0=A0=A0 |=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=
=A0=A0 |
>>>>> =A0=A0=A0=A0=A0=A0=A0=A0=A0 |=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=
=A0=A0 |
>>>>> =A0=A0=A0=A0=A0=A0=A0=A0=A0 *----------------*
>>>>>
>>>>> =A0=A0=A0=A0Of course, single header could represent array of pages (=
when packet's
>>>>> buffer is bigger than one page).So here is example of detailed mappin=
g layout
>>>>> for some set of packages. Lets consider that we have the following se=
quence=A0 of
>>>>> packages: 56 bytes, 4096 bytes and 8200 bytes. All pages: 0,1,2,3,4 a=
nd 5 will
>>>>> be inserted to user's vma(vma is large enough).
>>>>>
>>>>> =A0=A0=A0=A0Page 0: [[ hdr0 ][ hdr 1 ][ hdr 2 ][ hdr 3 ] ... ]
>>>>> =A0=A0=A0=A0Page 1: [ 56 ]
>>>>> =A0=A0=A0=A0Page 2: [ 4096 ]
>>>>> =A0=A0=A0=A0Page 3: [ 4096 ]
>>>>> =A0=A0=A0=A0Page 4: [ 4096 ]
>>>>> =A0=A0=A0=A0Page 5: [ 8 ]
>>>>>
>>>>> =A0=A0=A0=A0Page 0 contains only array of headers:
>>>>> =A0=A0=A0=A0'hdr0' has 56 in length field.
>>>>> =A0=A0=A0=A0'hdr1' has 4096 in length field.
>>>>> =A0=A0=A0=A0'hdr2' has 8200 in length field.
>>>>> =A0=A0=A0=A0'hdr3' has 0 in length field(this is end of data marker).
>>>>>
>>>>> =A0=A0=A0=A0Page 1 corresponds to 'hdr0' and has only 56 bytes of dat=
a.
>>>>> =A0=A0=A0=A0Page 2 corresponds to 'hdr1' and filled with data.
>>>>> =A0=A0=A0=A0Page 3 corresponds to 'hdr2' and filled with data.
>>>>> =A0=A0=A0=A0Page 4 corresponds to 'hdr2' and filled with data.
>>>>> =A0=A0=A0=A0Page 5 corresponds to 'hdr2' and has only 8 bytes of data.
>>>>>
>>>>> =A0=A0=A0=A0This patchset also changes packets allocation way: today =
implementation
>>>>> uses only 'kmalloc()' to create data buffer. Problem happens when we =
try to map
>>>>> such buffers to user's vma - kernel forbids to map slab pages to user=
's vma(as
>>>>> pages of "not large" 'kmalloc()' allocations are marked with PageSlab=
 flag and
>>>>> "not large" could be bigger than one page). So to avoid this, data bu=
ffers now
>>>>> allocated using 'alloc_pages()' call.
>>>>>
>>>>> =A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=
=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 TESTS
>>>>>
>>>>> =A0=A0=A0=A0This patchset updates 'vsock_test' utility: two tests for=
 new feature
>>>>> were added. First test covers invalid cases. Second checks valid tran=
smission
>>>>> case.
>>>>
>>>> Thanks for adding the test!
>>>>
>>>>>
>>>>> =A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=
=A0=A0=A0=A0=A0=A0=A0 BENCHMARKING
>>>>>
>>>>> =A0=A0=A0=A0For benchmakring I've added small utility 'rx_zerocopy'. =
It works in
>>>>> client/server mode. When client connects to server, server starts sen=
ding exact
>>>>> amount of data to client(amount is set as input argument).Client read=
s data and
>>>>> waits for next portion of it. Client works in two modes: copy and zer=
o-copy. In
>>>>> copy mode client uses 'read()' call while in zerocopy mode sequence o=
f 'mmap()'
>>>>> /'getsockopt()'/'madvise()' are used. Smaller amount of time for tran=
smission
>>>>> is better. For server, we can set size of tx buffer and for client we=
 can set
>>>>> size of rx buffer or rx mapping size(in zerocopy mode). Usage of this=
 utility
>>>>> is quiet simple:
>>>>>
>>>>> For client mode:
>>>>>
>>>>> ./rx_zerocopy --mode client [--zerocopy] [--rx]
>>>>>
>>>>> For server mode:
>>>>>
>>>>> ./rx_zerocopy --mode server [--mb] [--tx]
>>>>>
>>>>> [--mb] sets number of megabytes to transfer.
>>>>> [--rx] sets size of receive buffer/mapping in pages.
>>>>> [--tx] sets size of transmit buffer in pages.
>>>>>
>>>>> I checked for transmission of 4000mb of data. Here are some results:
>>>>>
>>>>> =A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=
=A0=A0 size of rx/tx buffers in pages
>>>>> =A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 *----------------------------=
-----------------------*
>>>>> =A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 |=A0=A0=A0 8=A0=A0 |=A0=A0=A0=
 32=A0=A0=A0 |=A0=A0=A0 64=A0=A0 |=A0=A0 256=A0=A0=A0 |=A0=A0 512=A0=A0=A0 |
>>>>> *--------------*--------*----------*---------*----------*----------*
>>>>> |=A0=A0 zerocopy=A0=A0 |=A0=A0 24=A0=A0 |=A0=A0 10.6=A0=A0 |=A0 12.2=
=A0=A0 |=A0=A0 23.6=A0=A0 |=A0=A0=A0 21=A0=A0=A0 | secs to
>>>>> *--------------*---------------------------------------------------- =
process
>>>>> | non-zerocopy |=A0=A0 13=A0=A0 |=A0=A0 16.4=A0=A0 |=A0 24.7=A0=A0 |=
=A0=A0 27.2=A0=A0 |=A0=A0 23.9=A0=A0 | 4000 mb
>>>>> *--------------*----------------------------------------------------
>>>>>
>>>>> I think, that results are not so impressive, but at least it is not w=
orse than
>>>>> copy mode and there is no need to allocate memory for processing date.
>>>>
>>>> Why is it twice as slow in the first column?
>>>
>>> May be this is because memory copying for small buffers is very fast...=
 i'll
>>> analyze it deeply.
>>
>> Maybe I misunderstood, by small buffers here what do you mean?
>>
>> I thought 8 was the number of pages, so 32KB buffers.
>
>Yes, 8 is size in pages. Anyway, i need to check it more deeply.

Okay, thanks!

Stefano

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
