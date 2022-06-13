Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B1EACC43334
	for <virtualization@archiver.kernel.org>; Mon, 13 Jun 2022 08:54:37 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp2.osuosl.org (Postfix) with ESMTP id 6FA5640983;
	Mon, 13 Jun 2022 08:54:37 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
	by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id aziXVyhf22QT; Mon, 13 Jun 2022 08:54:36 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp2.osuosl.org (Postfix) with ESMTPS id DEC3440911;
	Mon, 13 Jun 2022 08:54:35 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id B11DAC0039;
	Mon, 13 Jun 2022 08:54:35 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 249AAC002D
 for <virtualization@lists.linux-foundation.org>;
 Mon, 13 Jun 2022 08:54:34 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id F215A4025C
 for <virtualization@lists.linux-foundation.org>;
 Mon, 13 Jun 2022 08:54:33 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp4.osuosl.org (amavisd-new);
 dkim=pass (1024-bit key) header.d=redhat.com
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id 7nt2HyxNQnAh
 for <virtualization@lists.linux-foundation.org>;
 Mon, 13 Jun 2022 08:54:33 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.133.124])
 by smtp4.osuosl.org (Postfix) with ESMTPS id E778240210
 for <virtualization@lists.linux-foundation.org>;
 Mon, 13 Jun 2022 08:54:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1655110471;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=4KjgQ8HGSq2J7WMLesh9KTKYS17SXSbspP3uqq4OPEY=;
 b=FplIrzeUgx+JLlqGubSL0uimS0Q2/Ck7UozME/qb0CIAkAfBMXHbFS3h/JlWYzWcV1ElQr
 rCPZSwiJrpPvC0q2hQG0aO00l/r32bhS28A7cULL2dSinvho8a5m6bizUUp9RxpgPe+Z0U
 WOLBLHMy5gQBizKmybWh+QSQspT4jsY=
Received: from mail-qk1-f198.google.com (mail-qk1-f198.google.com
 [209.85.222.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-410-aFclOZUUMcKdyR8mC_ajiQ-1; Mon, 13 Jun 2022 04:54:30 -0400
X-MC-Unique: aFclOZUUMcKdyR8mC_ajiQ-1
Received: by mail-qk1-f198.google.com with SMTP id
 s8-20020a05620a0bc800b006a6d42a1a0eso4541293qki.3
 for <virtualization@lists.linux-foundation.org>;
 Mon, 13 Jun 2022 01:54:30 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:content-transfer-encoding
 :in-reply-to;
 bh=4KjgQ8HGSq2J7WMLesh9KTKYS17SXSbspP3uqq4OPEY=;
 b=myYaZwc5+QprMdqZ3G/b+tOjKTTByaDM7u1BYwTIz2oq26KloZzMzo5BrLDj80qvrx
 sx/irHYgTEHxG5wfpjoz6CbSr0BaBd9wDuQfLZ3NOqqB8/aKRRCVNYFNgKSNJZoY7Szc
 /RCT/w1vPyALAzeoyp2oZE/eeSwnzM+R5GCKpzDoJEhUvsTIF5RIKAcsA7KhwEQ/fjNc
 7p9G+tEyNFThBJebZjoNwf5Z2KKgQ5gMzxDWS4W+T79zy+tsmBGxG4mwPa35grRSjQde
 9Y8LXACR4j/h9WaczdV0molLLTN4YBbQ8rtJKMXjOJlrrX+5s1nCbefisxokK5T/7L91
 A/ow==
X-Gm-Message-State: AOAM531ucLf2odn1b2nRCjg+a6NtcbmNhkgLR9AeX14HzPfr+HhWOYq2
 tzTlEAa29rl/PkxxhP7GNMkUJrxVuuMZhxDaL8582P0W+8koF07Bf5jQtotnfxZIsR15b4nR1t6
 60CzFrvb5D0bMufVKFbXEDM9KUfz8fMeg2mkmOKv0Ig==
X-Received: by 2002:a37:a781:0:b0:6a6:9b4c:fc8d with SMTP id
 q123-20020a37a781000000b006a69b4cfc8dmr34331661qke.657.1655110470067; 
 Mon, 13 Jun 2022 01:54:30 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJxLKAhytZFfLQQeuW9E/Pm2tvxqTqKSiAxOefCJ0tsCfeagh1tGD4fU7pLQNZ/nHVdj1LceZg==
X-Received: by 2002:a37:a781:0:b0:6a6:9b4c:fc8d with SMTP id
 q123-20020a37a781000000b006a69b4cfc8dmr34331656qke.657.1655110469837; 
 Mon, 13 Jun 2022 01:54:29 -0700 (PDT)
Received: from sgarzare-redhat (host-79-46-200-40.retail.telecomitalia.it.
 [79.46.200.40]) by smtp.gmail.com with ESMTPSA id
 i198-20020a379fcf000000b006a73aefce28sm5814643qke.30.2022.06.13.01.54.26
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 13 Jun 2022 01:54:29 -0700 (PDT)
Date: Mon, 13 Jun 2022 10:54:20 +0200
From: Stefano Garzarella <sgarzare@redhat.com>
To: Arseniy Krasnov <AVKrasnov@sberdevices.ru>
Subject: Re: [RFC PATCH v2 0/8] virtio/vsock: experimental zerocopy receive
Message-ID: <20220613085420.e4limzn3dneuhu6y@sgarzare-redhat>
References: <e37fdf9b-be80-35e1-ae7b-c9dfeae3e3db@sberdevices.ru>
 <20220609085428.idi4qzydhdpzszzw@sgarzare-redhat>
 <1c58ec1f-f991-4527-726a-9f45c2ff5684@sberdevices.ru>
MIME-Version: 1.0
In-Reply-To: <1c58ec1f-f991-4527-726a-9f45c2ff5684@sberdevices.ru>
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
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset="iso-8859-1"; Format="flowed"
Errors-To: virtualization-bounces@lists.linux-foundation.org
Sender: "Virtualization" <virtualization-bounces@lists.linux-foundation.org>

On Thu, Jun 09, 2022 at 12:33:32PM +0000, Arseniy Krasnov wrote:
>On 09.06.2022 11:54, Stefano Garzarella wrote:
>> Hi Arseniy,
>> I left some comments in the patches, and I'm adding something also here:
>Thanks for comments
>>
>> On Fri, Jun 03, 2022 at 05:27:56AM +0000, Arseniy Krasnov wrote:
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
>> If it is not too time-consuming, can we have a table/list to compare thi=
s and the TCP zerocopy?
>You mean compare API with more details?

Yes, maybe a comparison from the user's point of view to do zero-copy =

with TCP and VSOCK.

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
>>> =A0=A0=A0=A0=A0=A0=A0 uint32_t copy_len;
>>> =A0=A0=A0=A0};
>>>
>>> Field=A0 'length' allows user to know exact size of payload within each=
 sequence
>>> of pages and 'flags' allows user to handle SOCK_SEQPACKET flags(such as=
 message
>>> bounds or record bounds). Field 'copy_len' is described below in 'v1->v=
2' part.
>>> All other pages are data pages from RX queue.
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
>>
>> In order to have a "userspace polling-friendly approach" and reduce numb=
er of syscall, can we allow for example the userspace to mmap at least the =
first header before packets arrive.
>> Then the userspace can poll a flag or other fields in the header to unde=
rstand that there are new packets.
>You mean to avoid 'poll()' syscall, user will spin on some flag, provided =
by kernel on some mapped page? I think yes. This is ok. Also i think, that =
i can avoid 'madvise' call
>to clear memory mapping before each 'getsockopt()' - let 'getsockopt()' do=
 'madvise()' job by removing pages from previous data. In this case only on=
e system call is needed - 'getsockopt()'.

Yes, that's right. I mean to support both, poll() for interrupt-based =

applications and the ability to actively poll a variable in the shared =

memory for applications that want to minimize latency.

Thanks,
Stefano

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
