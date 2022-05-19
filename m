Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0174BC433FE
	for <virtualization@archiver.kernel.org>; Thu, 19 May 2022 07:42:25 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp2.osuosl.org (Postfix) with ESMTP id A81D540137;
	Thu, 19 May 2022 07:42:25 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
	by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id Il_qWJmIL0Br; Thu, 19 May 2022 07:42:24 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp2.osuosl.org (Postfix) with ESMTPS id BF2FE40012;
	Thu, 19 May 2022 07:42:23 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id A2663C0032;
	Thu, 19 May 2022 07:42:23 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [IPv6:2605:bc80:3010::137])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 96124C002D
 for <virtualization@lists.linux-foundation.org>;
 Thu, 19 May 2022 07:42:22 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id 75375409FC
 for <virtualization@lists.linux-foundation.org>;
 Thu, 19 May 2022 07:42:22 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp4.osuosl.org (amavisd-new);
 dkim=pass (1024-bit key) header.d=redhat.com
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id HRMCMA8J25rX
 for <virtualization@lists.linux-foundation.org>;
 Thu, 19 May 2022 07:42:20 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.129.124])
 by smtp4.osuosl.org (Postfix) with ESMTPS id 668A54098D
 for <virtualization@lists.linux-foundation.org>;
 Thu, 19 May 2022 07:42:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1652946138;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=cvqAbFwyOy/1zL1S6HRh5fV62j9SvG6xV+pywCiM0s4=;
 b=HcHkiLR+mCVGf0SXtGF4ZotucAIofYTksKFOpNgkegxjgj+/5VG1L/HuQcYFaiSh2gKl1o
 FyUA2I/EnPhw0JFkUeA+9jrx7f7H0p5POT14JMZmjagdrypu/xaK9N8k6W2Xgm2MSq5aq3
 +oYhnGKkjB517QXXP1oaH1cwTq/C8ss=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-441-RZIMs8_vOqGGYuYl5x_yJw-1; Thu, 19 May 2022 03:42:17 -0400
X-MC-Unique: RZIMs8_vOqGGYuYl5x_yJw-1
Received: by mail-wr1-f70.google.com with SMTP id
 w4-20020adfbac4000000b0020acba4b779so1237679wrg.22
 for <virtualization@lists.linux-foundation.org>;
 Thu, 19 May 2022 00:42:17 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:content-transfer-encoding
 :in-reply-to;
 bh=cvqAbFwyOy/1zL1S6HRh5fV62j9SvG6xV+pywCiM0s4=;
 b=6EhSZzdulkyFcLO7SorsgXrUMbOj6X4iaJ4DbZfH6ayV5wdh4+OCsty0j3JCsZsX02
 +8eQhjdSUqJvxQ1t+9ONZJECEqP47dcvri7TTrEMRr8jqhvnXhfQfoFGndL5Ju1DuKUi
 KJctnglv2Ctt+TwgSVkOzQ2S857NeZu9h3f0oFO0jNQu2yDeR4qfCqb4zcRTCKxTVzbv
 xeWCcyVqzLZFa9tDAG4kz9xKqRGqsWWHrEjMMeYPiop6DkTbmgKiHB3BPkf3nlSdBFuf
 O/TOTLcHSg0vGkiHrgc/qFWG2qMWkZ9tVNDoNMevy2OiJmHvwn72VBE9/hPcC3Rznpyh
 xE7w==
X-Gm-Message-State: AOAM531aXYbu/02uXxvezYQ34D++VMdUZMOq6kr3gDdxCWKMQoIYf1y2
 yo1Bv4orsUcQv+Cv3dVFvLUHcZ96+Qfc8tzEkwvMpQo5xC2xJbCR/+hGw0X+J81NMUrGVcMt63O
 YD6tNXSBJI82ZlZX/qazGdjQHRvwPKSDDu8N9tEBI6g==
X-Received: by 2002:adf:fc01:0:b0:20c:ff9a:2c53 with SMTP id
 i1-20020adffc01000000b0020cff9a2c53mr2777588wrr.142.1652946136356; 
 Thu, 19 May 2022 00:42:16 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJwy1RIN+3649xxZgoziLceMYBr379oOuNJk2Q0fkOptX1BdRiNvrexDD2PURYMqifmoNJPg5Q==
X-Received: by 2002:adf:fc01:0:b0:20c:ff9a:2c53 with SMTP id
 i1-20020adffc01000000b0020cff9a2c53mr2777570wrr.142.1652946136006; 
 Thu, 19 May 2022 00:42:16 -0700 (PDT)
Received: from sgarzare-redhat (host-87-12-25-16.business.telecomitalia.it.
 [87.12.25.16]) by smtp.gmail.com with ESMTPSA id
 n10-20020a1c720a000000b00397099b8cffsm3412771wmc.1.2022.05.19.00.42.14
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 19 May 2022 00:42:15 -0700 (PDT)
Date: Thu, 19 May 2022 09:42:08 +0200
From: Stefano Garzarella <sgarzare@redhat.com>
To: Arseniy Krasnov <AVKrasnov@sberdevices.ru>
Subject: Re: [RFC PATCH v1 0/8] virtio/vsock: experimental zerocopy receive
Message-ID: <20220519074208.q2bmytl2dphtjgse@sgarzare-redhat>
References: <7cdcb1e1-7c97-c054-19cf-5caeacae981d@sberdevices.ru>
 <20220517151404.vqse5tampdsaaeji@sgarzare-redhat>
 <413d821f-3893-befa-7009-2f87ef51af7a@sberdevices.ru>
MIME-Version: 1.0
In-Reply-To: <413d821f-3893-befa-7009-2f87ef51af7a@sberdevices.ru>
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

On Wed, May 18, 2022 at 11:04:30AM +0000, Arseniy Krasnov wrote:
>Hello Stefano,
>
>On 17.05.2022 18:14, Stefano Garzarella wrote:
>> Hi Arseniy,
>>
>> On Thu, May 12, 2022 at 05:04:11AM +0000, Arseniy Krasnov wrote:
>>> =A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=
=A0=A0=A0=A0=A0 INTRODUCTION
>>>
>>> =A0=A0=A0=A0Hello, this is experimental implementation of virtio vsock =
zerocopy
>>> receive. It was inspired by TCP zerocopy receive by Eric Dumazet. This =
API uses
>>> same idea: call 'mmap()' on socket's descriptor, then every 'getsockopt=
()' will
>>> fill provided vma area with pages of virtio RX buffers. After received =
data was
>>> processed by user, pages must be freed by 'madvise()'=A0 call with MADV=
_DONTNEED
>>> flag set(if user won't call 'madvise()', next 'getsockopt()' will fail).
>>
>> Sounds cool, but maybe we would need some socket/net experts here for re=
view.
>
>Yes, that would be great
>
>>
>> Could we do something similar for the sending path as well?
>
>Here are thoughts about zerocopy transmission:
>
>I tried to implement this feature in the following way: user creates
>some page aligned buffer, then during tx packet allocation instead of
>creating data buffer with 'kmalloc()', i tried to add user's buffer
>to virtio queue. But found problem: as kernel virtio API uses virtual
>addresses to add new buffers, in the deep of virtio subsystem
>'virt_to_phys()' is called to get physical address of buffer, so user's
>virtual address won't be translated correctly to physical address(in
>theory, i can perform page walk for such user's va, get physical address
>and pass some "fake" virtual address to virtio API in order to make
>'virt_to_phys()' return valid physical address(but i think this is ugly).

And maybe we should also pin the pages to prevent them from being =

replaced.

I think we should do something similar to what we do in vhost-vdpa.
Take a look at vhost_vdpa_pa_map() in drivers/vhost/vdpa.c

>
>
>If we are talking about 'mmap()' way, i think we can do the following:
>user calls 'mmap()' on socket, kernel fills newly created mapping with
>allocated pages(all pages have rw permissions). Now user can use pages
>of this mapping(e.g. fill it with data). Finally, to start transmission,
>user calls 'getsockopt()' or some 'ioctl()' and kernel processes data of
>this mapping. Also as this call will return immediately(e.g. it is
>asynchronous), some completion logic must be implemented. For example
>use same way as MSG_ZEROCOPY uses - poll error queue of socket to get
>message that pages could be reused, or don't allow user to work with
>these pages: unmap it, perform transmission and finally free pages.
>To start new transmission user need to call 'mmap()' again.
>
>                            OR
>
>I think there is another unusual way for zerocopy tx: let's use 'vmsplice(=
)'
>/'splice()'. In this approach to transmit something, user does the followi=
ng
>steps:
>1) Creates pipe.
>2) Calls 'vmsplice(SPLICE_F_GIFT)' on this pipe, insert data pages to it.
>   SPLICE_F_GIFT allows user to forget about allocated pages - kernel will
>   free it.
>3) Calls 'splice(SPLICE_F_MOVE)' from pipe to socket. SPLICE_F_MOVE will
>   move pages from pipe to socket(e.g. in special socket callback we got
>   set of pipe's pages as input argument and all pages will be inserted
>   to virtio queue).
>
>But as SPLICE_F_MOVE support is disabled, it must be repaired first.

Splice seems interesting, but it would be nice If we do something =

similar to TCP. IIUC they use a flag for send(2):

     send(fd, buf, sizeof(buf), MSG_ZEROCOPY);

  =

>
>>
>>>
>>> =A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=
=A0=A0=A0=A0=A0=A0=A0=A0 DETAILS
>>>
>>> =A0=A0=A0=A0Here is how mapping with mapped pages looks exactly: first =
page mapping
>>> contains array of trimmed virtio vsock packet headers (in contains only=
 length
>>> of data on the corresponding page and 'flags' field):
>>>
>>> =A0=A0=A0=A0struct virtio_vsock_usr_hdr {
>>> =A0=A0=A0=A0=A0=A0=A0 uint32_t length;
>>> =A0=A0=A0=A0=A0=A0=A0 uint32_t flags;
>>> =A0=A0=A0=A0};
>>>
>>> Field=A0 'length' allows user to know exact size of payload within each=
 sequence
>>> of pages and 'flags' allows user to handle SOCK_SEQPACKET flags(such as=
 message
>>> bounds or record bounds). All other pages are data pages from RX queue.
>>>
>>> =A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 Page 0=A0=A0=A0=A0=A0 Page 1=A0=A0=A0=
=A0=A0 Page N
>>>
>>> =A0=A0=A0=A0[ hdr1 .. hdrN ][ data ] .. [ data ]
>>> =A0=A0=A0=A0=A0=A0=A0=A0=A0 |=A0=A0=A0=A0=A0=A0=A0 |=A0=A0=A0=A0=A0=A0 =
^=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 ^
>>> =A0=A0=A0=A0=A0=A0=A0=A0=A0 |=A0=A0=A0=A0=A0=A0=A0 |=A0=A0=A0=A0=A0=A0 =
|=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 |
>>> =A0=A0=A0=A0=A0=A0=A0=A0=A0 |=A0=A0=A0=A0=A0=A0=A0 *-------------------*
>>> =A0=A0=A0=A0=A0=A0=A0=A0=A0 |=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=
=A0 |
>>> =A0=A0=A0=A0=A0=A0=A0=A0=A0 |=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=
=A0 |
>>> =A0=A0=A0=A0=A0=A0=A0=A0=A0 *----------------*
>>>
>>> =A0=A0=A0=A0Of course, single header could represent array of pages (wh=
en packet's
>>> buffer is bigger than one page).So here is example of detailed mapping =
layout
>>> for some set of packages. Lets consider that we have the following sequ=
ence=A0 of
>>> packages: 56 bytes, 4096 bytes and 8200 bytes. All pages: 0,1,2,3,4 and=
 5 will
>>> be inserted to user's vma(vma is large enough).
>>>
>>> =A0=A0=A0=A0Page 0: [[ hdr0 ][ hdr 1 ][ hdr 2 ][ hdr 3 ] ... ]
>>> =A0=A0=A0=A0Page 1: [ 56 ]
>>> =A0=A0=A0=A0Page 2: [ 4096 ]
>>> =A0=A0=A0=A0Page 3: [ 4096 ]
>>> =A0=A0=A0=A0Page 4: [ 4096 ]
>>> =A0=A0=A0=A0Page 5: [ 8 ]
>>>
>>> =A0=A0=A0=A0Page 0 contains only array of headers:
>>> =A0=A0=A0=A0'hdr0' has 56 in length field.
>>> =A0=A0=A0=A0'hdr1' has 4096 in length field.
>>> =A0=A0=A0=A0'hdr2' has 8200 in length field.
>>> =A0=A0=A0=A0'hdr3' has 0 in length field(this is end of data marker).
>>>
>>> =A0=A0=A0=A0Page 1 corresponds to 'hdr0' and has only 56 bytes of data.
>>> =A0=A0=A0=A0Page 2 corresponds to 'hdr1' and filled with data.
>>> =A0=A0=A0=A0Page 3 corresponds to 'hdr2' and filled with data.
>>> =A0=A0=A0=A0Page 4 corresponds to 'hdr2' and filled with data.
>>> =A0=A0=A0=A0Page 5 corresponds to 'hdr2' and has only 8 bytes of data.
>>>
>>> =A0=A0=A0=A0This patchset also changes packets allocation way: today im=
plementation
>>> uses only 'kmalloc()' to create data buffer. Problem happens when we tr=
y to map
>>> such buffers to user's vma - kernel forbids to map slab pages to user's=
 vma(as
>>> pages of "not large" 'kmalloc()' allocations are marked with PageSlab f=
lag and
>>> "not large" could be bigger than one page). So to avoid this, data buff=
ers now
>>> allocated using 'alloc_pages()' call.
>>>
>>> =A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=
=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 TESTS
>>>
>>> =A0=A0=A0=A0This patchset updates 'vsock_test' utility: two tests for n=
ew feature
>>> were added. First test covers invalid cases. Second checks valid transm=
ission
>>> case.
>>
>> Thanks for adding the test!
>>
>>>
>>> =A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=
=A0=A0=A0=A0=A0=A0=A0 BENCHMARKING
>>>
>>> =A0=A0=A0=A0For benchmakring I've added small utility 'rx_zerocopy'. It=
 works in
>>> client/server mode. When client connects to server, server starts sendi=
ng exact
>>> amount of data to client(amount is set as input argument).Client reads =
data and
>>> waits for next portion of it. Client works in two modes: copy and zero-=
copy. In
>>> copy mode client uses 'read()' call while in zerocopy mode sequence of =
'mmap()'
>>> /'getsockopt()'/'madvise()' are used. Smaller amount of time for transm=
ission
>>> is better. For server, we can set size of tx buffer and for client we c=
an set
>>> size of rx buffer or rx mapping size(in zerocopy mode). Usage of this u=
tility
>>> is quiet simple:
>>>
>>> For client mode:
>>>
>>> ./rx_zerocopy --mode client [--zerocopy] [--rx]
>>>
>>> For server mode:
>>>
>>> ./rx_zerocopy --mode server [--mb] [--tx]
>>>
>>> [--mb] sets number of megabytes to transfer.
>>> [--rx] sets size of receive buffer/mapping in pages.
>>> [--tx] sets size of transmit buffer in pages.
>>>
>>> I checked for transmission of 4000mb of data. Here are some results:
>>>
>>> =A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=
=A0=A0 size of rx/tx buffers in pages
>>> =A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 *------------------------------=
---------------------*
>>> =A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 |=A0=A0=A0 8=A0=A0 |=A0=A0=A0 3=
2=A0=A0=A0 |=A0=A0=A0 64=A0=A0 |=A0=A0 256=A0=A0=A0 |=A0=A0 512=A0=A0=A0 |
>>> *--------------*--------*----------*---------*----------*----------*
>>> |=A0=A0 zerocopy=A0=A0 |=A0=A0 24=A0=A0 |=A0=A0 10.6=A0=A0 |=A0 12.2=A0=
=A0 |=A0=A0 23.6=A0=A0 |=A0=A0=A0 21=A0=A0=A0 | secs to
>>> *--------------*---------------------------------------------------- pr=
ocess
>>> | non-zerocopy |=A0=A0 13=A0=A0 |=A0=A0 16.4=A0=A0 |=A0 24.7=A0=A0 |=A0=
=A0 27.2=A0=A0 |=A0=A0 23.9=A0=A0 | 4000 mb
>>> *--------------*----------------------------------------------------
>>>
>>> I think, that results are not so impressive, but at least it is not wor=
se than
>>> copy mode and there is no need to allocate memory for processing date.
>>
>> Why is it twice as slow in the first column?
>
>May be this is because memory copying for small buffers is very fast... i'=
ll
>analyze it deeply.

Maybe I misunderstood, by small buffers here what do you mean?

I thought 8 was the number of pages, so 32KB buffers.

>
>>
>>>
>>> =A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=
=A0=A0=A0=A0=A0=A0=A0=A0 PROBLEMS
>>>
>>> =A0=A0=A0=A0Updated packet's allocation logic creates some problem: whe=
n host gets
>>> data from guest(in vhost-vsock), it allocates at least one page for eac=
h packet
>>> (even if packet has 1 byte payload). I think this could be resolved in =
several
>>> ways:
>>
>> Can we somehow copy the incoming packets into the payload of the already=
 queued packet?
>
>May be, i'll analyze it...

Thanks!

>
>>
>> This reminds me that we have yet to fix a similar problem with kmalloc()=
 as well...
>>
>> https://bugzilla.kernel.org/show_bug.cgi?id=3D215329
>
>Yes, but it is a little bit different case: IIUC this bug happens because =
'kmalloc()'
>uses memory chunks of some preallocated size.

Yep, I mean I think the problem is that when we receive 1-byte packets, =

we have all the header queued up that we don't consider in the credit =

mechanism. A little bit different.

>
>>
>>> =A0=A0=A0=A01) Make zerocopy rx mode disabled by default, so if user di=
dn't enable
>>> it, current 'kmalloc()' way will be used.
>>
>> That sounds reasonable to me, I guess also TCP needs a setsockopt() call=
 to enable the feature, right?
>
>Yes, You're right. I think i'll add this to v2.
>
>>
>>> =A0=A0=A0=A02) Use 'kmalloc()' for "small" packets, else call page allo=
cator. But
>>> in this case, we have mix of packets, allocated in two different ways t=
hus
>>> during zerocopying to user(e.g. mapping pages to vma), such small packe=
ts will
>>> be handled in some stupid way: we need to allocate one page for user, c=
opy data
>>> to it and then insert page to user's vma.
>>
>> It seems more difficult to me, but at the same time doable. I would go m=
ore on option 1, though.
>>
>>>
>>> P.S: of course this is experimental RFC, so what do You think guys?
>>
>> It seems cool :-)
>>
>> But I would like some feedback from the net guys to have some TCP-like t=
hings.
>
>Ok, i'll prepare v2 anyway: i need to analyze performance, may be more tes=
t coverage, rebase
>over latest kernel and work on packet allocation problem(from above).

If you have time, it would be cool to modify some performance tool that =

already supports vsock to take advantage of this feature and look better =

at performance.

We currently have both iperf3 (I have a modified fork for vsock [1]) and =

uperf (they have merged upstream the vsock support).

Perhaps the easiest to tweak is iperf-vsock, it should already have a =

--zerocopy option.

Thanks,
Stefano

[1] https://github.com/stefano-garzarella/iperf-vsock

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
