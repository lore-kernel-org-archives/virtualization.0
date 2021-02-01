Return-Path: <SRS0=ow7J=HD=lists.linux-foundation.org=virtualization-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 82342C433DB
	for <virtualization@archiver.kernel.org>; Mon,  1 Feb 2021 14:23:47 +0000 (UTC)
Received: from silver.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 07B6B64DAE
	for <virtualization@archiver.kernel.org>; Mon,  1 Feb 2021 14:23:46 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 07B6B64DAE
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=virtualization-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by silver.osuosl.org (Postfix) with ESMTP id C8B8F2045C;
	Mon,  1 Feb 2021 14:23:46 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from silver.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id s+Uo6yFt+29z; Mon,  1 Feb 2021 14:23:45 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by silver.osuosl.org (Postfix) with ESMTP id 84F1820027;
	Mon,  1 Feb 2021 14:23:45 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 6B26EC0174;
	Mon,  1 Feb 2021 14:23:45 +0000 (UTC)
Received: from hemlock.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 5DB34C013A
 for <virtualization@lists.linux-foundation.org>;
 Mon,  1 Feb 2021 14:23:43 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by hemlock.osuosl.org (Postfix) with ESMTP id 57F1686FBA
 for <virtualization@lists.linux-foundation.org>;
 Mon,  1 Feb 2021 14:23:43 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from hemlock.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id 1QahUL0VigMq
 for <virtualization@lists.linux-foundation.org>;
 Mon,  1 Feb 2021 14:23:41 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [216.205.24.124])
 by hemlock.osuosl.org (Postfix) with ESMTPS id 12D7D86FAD
 for <virtualization@lists.linux-foundation.org>;
 Mon,  1 Feb 2021 14:23:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1612189420;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=86wgtLiyakUoknVPpiVvEtMtCYGvN/TevNX9IJtMnLs=;
 b=XVj1crxNefJTqd2E1sFaBIwdGG1KpaKNSW/63+SDQMv+xFtEfSYsVjB2GLEuXtULdv3jhD
 tYQbLLjYtc7+0776snUJiAbU8FCBf75hWSPfA70t8qffzXSxmj0r5aNCYfPgeKsufnLF15
 +71/NM9Wl2GBm9cmgEaiqhIyHoU/v1c=
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-207-_8f4XVYuP8O47if7khQ1Kw-1; Mon, 01 Feb 2021 09:23:38 -0500
X-MC-Unique: _8f4XVYuP8O47if7khQ1Kw-1
Received: by mail-wr1-f71.google.com with SMTP id h18so10486604wrr.5
 for <virtualization@lists.linux-foundation.org>;
 Mon, 01 Feb 2021 06:23:38 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:content-transfer-encoding
 :in-reply-to;
 bh=86wgtLiyakUoknVPpiVvEtMtCYGvN/TevNX9IJtMnLs=;
 b=F8OzUZX22OO8XWXvFdtZ4pIX3Bb1dqKlmFl4icaxE8XtAL9qXQhB+v3db/BspRFldw
 JgnlvAKhjVrGqp5+L8cqwUTyHKdWelDEymaM7AdNsBGFcQgnvNxCqtM7T0slE+vSkgTQ
 u54b6VBP/gYoG/ldxPKrLcOjKj7SESU7WKGQwMqpU9oyF3Lfz/fdjL7jXa3UeN4a/t9J
 1O/5ApSivKSi1jQf9osh4gAHDREzvAzTo49kBcgW3PZtRx3CCgMFalJJuTSRu0hiTcne
 n9yKOUtgKNPLDTr45NO2SV+HXTNCGQruguvYteXT0nUnFGE4HCeT8G/8yFX/EmeWbYue
 MCOA==
X-Gm-Message-State: AOAM531ZokqUrQoVbhLTUvBkh6oHwMAlKgxdHT/GXADQHA1FkKfUgvF7
 abfrtLxN90NJWjPxBRdWO8chqk+JxJ2BS2nkv7crkqLy4hVlwIVRyztr3kKM/0rJ2Um8RPGUwi9
 GjOLilXqYF9CooUzjc/4/C8BmMtTWUOJUFGiVb1I9bA==
X-Received: by 2002:a05:6000:10cd:: with SMTP id
 b13mr18482283wrx.163.1612189417139; 
 Mon, 01 Feb 2021 06:23:37 -0800 (PST)
X-Google-Smtp-Source: ABdhPJwwNjDZs4wPbvLSs1VKoyvrMSmuyDsQUQk5MtEmGv49naG2WxLk2j3+tAQuFAzhm3cNzYFEAg==
X-Received: by 2002:a05:6000:10cd:: with SMTP id
 b13mr18482261wrx.163.1612189416906; 
 Mon, 01 Feb 2021 06:23:36 -0800 (PST)
Received: from steredhat (host-79-34-249-199.business.telecomitalia.it.
 [79.34.249.199])
 by smtp.gmail.com with ESMTPSA id x25sm21285174wmk.20.2021.02.01.06.23.34
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 01 Feb 2021 06:23:36 -0800 (PST)
Date: Mon, 1 Feb 2021 15:23:33 +0100
From: Stefano Garzarella <sgarzare@redhat.com>
To: Arseny Krasnov <arseny.krasnov@kaspersky.com>
Subject: Re: [RFC PATCH v3 00/13] virtio/vsock: introduce SOCK_SEQPACKET
 support
Message-ID: <20210201142333.7zcgoqq432y7kktb@steredhat>
References: <20210125110903.597155-1-arseny.krasnov@kaspersky.com>
 <20210128171923.esyna5ccv5s27jyu@steredhat>
 <63459bb3-da22-b2a4-71ee-e67660fd2e12@kaspersky.com>
 <20210129092604.mgaw3ipiyv6xra3b@steredhat>
 <cb6d5a9c-fd49-a9dd-33b3-52027ae2f71c@kaspersky.com>
 <20210201110258.7ze7a7izl7gesv4w@steredhat>
 <1b80eb27-4818-50d7-7454-ff6cc398422e@kaspersky.com>
MIME-Version: 1.0
In-Reply-To: <1b80eb27-4818-50d7-7454-ff6cc398422e@kaspersky.com>
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=sgarzare@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Disposition: inline
Cc: Andra Paraschiv <andraprs@amazon.com>,
 "kvm@vger.kernel.org" <kvm@vger.kernel.org>,
 "Michael S. Tsirkin" <mst@redhat.com>, Jeff Vander Stoep <jeffv@google.com>,
 "stsp2@yandex.ru" <stsp2@yandex.ru>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
 "virtualization@lists.linux-foundation.org"
 <virtualization@lists.linux-foundation.org>,
 "oxffffaa@gmail.com" <oxffffaa@gmail.com>,
 "netdev@vger.kernel.org" <netdev@vger.kernel.org>,
 Stefan Hajnoczi <stefanha@redhat.com>, Jakub Kicinski <kuba@kernel.org>,
 Colin Ian King <colin.king@canonical.com>,
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

On Mon, Feb 01, 2021 at 04:57:18PM +0300, Arseny Krasnov wrote:
>
>On 01.02.2021 14:02, Stefano Garzarella wrote:
>> On Fri, Jan 29, 2021 at 06:52:23PM +0300, Arseny Krasnov wrote:
>>> On 29.01.2021 12:26, Stefano Garzarella wrote:
>>>> On Fri, Jan 29, 2021 at 09:41:50AM +0300, Arseny Krasnov wrote:
>>>>> On 28.01.2021 20:19, Stefano Garzarella wrote:
>>>>>> Hi Arseny,
>>>>>> I reviewed a part, tomorrow I hope to finish the other patches.
>>>>>>
>>>>>> Just a couple of comments in the TODOs below.
>>>>>>
>>>>>> On Mon, Jan 25, 2021 at 02:09:00PM +0300, Arseny Krasnov wrote:
>>>>>>> 	This patchset impelements support of SOCK_SEQPACKET for virtio
>>>>>>> transport.
>>>>>>> 	As SOCK_SEQPACKET guarantees to save record boundaries, so to
>>>>>>> do it, new packet operation was added: it marks start of record (wi=
th
>>>>>>> record length in header), such packet doesn't carry any data.  To s=
end
>>>>>>> record, packet with start marker is sent first, then all data is se=
nt
>>>>>>> as usual 'RW' packets. On receiver's side, length of record is known
>>>>>> >from packet with start record marker. Now as  packets of one socket
>>>>>>> are not reordered neither on vsock nor on vhost transport layers, s=
uch
>>>>>>> marker allows to restore original record on receiver's side. If use=
r's
>>>>>>> buffer is smaller that record length, when all out of size data is
>>>>>>> dropped.
>>>>>>> 	Maximum length of datagram is not limited as in stream socket,
>>>>>>> because same credit logic is used. Difference with stream socket is
>>>>>>> that user is not woken up until whole record is received or error
>>>>>>> occurred. Implementation also supports 'MSG_EOR' and 'MSG_TRUNC' fl=
ags.
>>>>>>> 	Tests also implemented.
>>>>>>>
>>>>>>> Arseny Krasnov (13):
>>>>>>>  af_vsock: prepare for SOCK_SEQPACKET support
>>>>>>>  af_vsock: prepare 'vsock_connectible_recvmsg()'
>>>>>>>  af_vsock: implement SEQPACKET rx loop
>>>>>>>  af_vsock: implement send logic for SOCK_SEQPACKET
>>>>>>>  af_vsock: rest of SEQPACKET support
>>>>>>>  af_vsock: update comments for stream sockets
>>>>>>>  virtio/vsock: dequeue callback for SOCK_SEQPACKET
>>>>>>>  virtio/vsock: fetch length for SEQPACKET record
>>>>>>>  virtio/vsock: add SEQPACKET receive logic
>>>>>>>  virtio/vsock: rest of SOCK_SEQPACKET support
>>>>>>>  virtio/vsock: setup SEQPACKET ops for transport
>>>>>>>  vhost/vsock: setup SEQPACKET ops for transport
>>>>>>>  vsock_test: add SOCK_SEQPACKET tests
>>>>>>>
>>>>>>> drivers/vhost/vsock.c                   |   7 +-
>>>>>>> include/linux/virtio_vsock.h            |  12 +
>>>>>>> include/net/af_vsock.h                  |   6 +
>>>>>>> include/uapi/linux/virtio_vsock.h       |   9 +
>>>>>>> net/vmw_vsock/af_vsock.c                | 543 ++++++++++++++++------
>>>>>>> net/vmw_vsock/virtio_transport.c        |   4 +
>>>>>>> net/vmw_vsock/virtio_transport_common.c | 295 ++++++++++--
>>>>>>> tools/testing/vsock/util.c              |  32 +-
>>>>>>> tools/testing/vsock/util.h              |   3 +
>>>>>>> tools/testing/vsock/vsock_test.c        | 126 +++++
>>>>>>> 10 files changed, 862 insertions(+), 175 deletions(-)
>>>>>>>
>>>>>>> TODO:
>>>>>>> - Support for record integrity control. As transport could drop some
>>>>>>>   packets, something like "record-id" and record end marker need to
>>>>>>>   be implemented. Idea is that SEQ_BEGIN packet carries both record
>>>>>>>   length and record id, end marker(let it be SEQ_END) carries only
>>>>>>>   record id. To be sure that no one packet was lost, receiver checks
>>>>>>>   length of data between SEQ_BEGIN and SEQ_END(it must be same with
>>>>>>>   value in SEQ_BEGIN) and record ids of SEQ_BEGIN and SEQ_END(this
>>>>>>>   means that both markers were not dropped. I think that easiest way
>>>>>>>   to implement record id for SEQ_BEGIN is to reuse another field of
>>>>>>>   packet header(SEQ_BEGIN already uses 'flags' as record length).For
>>>>>>>   SEQ_END record id could be stored in 'flags'.
>>>>>> I don't really like the idea of reusing the 'flags' field for this
>>>>>> purpose.
>>>>>>
>>>>>>>     Another way to implement it, is to move metadata of both SEQ_END
>>>>>>>   and SEQ_BEGIN to payload. But this approach has problem, because
>>>>>>>   if we move something to payload, such payload is accounted by
>>>>>>>   credit logic, which fragments payload, while payload with record
>>>>>>>   length and id couldn't be fragmented. One way to overcome it is to
>>>>>>>   ignore credit update for SEQ_BEGIN/SEQ_END packet.Another solution
>>>>>>>   is to update 'stream_has_space()' function: current implementation
>>>>>>>   return non-zero when at least 1 byte is allowed to use,but updated
>>>>>>>   version will have extra argument, which is needed length. For 'RW'
>>>>>>>   packet this argument is 1, for SEQ_BEGIN it is sizeof(record len +
>>>>>>>   record id) and for SEQ_END it is sizeof(record id).
>>>>>> Is the payload accounted by credit logic also if hdr.op is not
>>>>>> VIRTIO_VSOCK_OP_RW?
>>>>> Yes, on send any packet with payload could be fragmented if
>>>>>
>>>>> there is not enough space at receiver. On receive 'fwd_cnt' and
>>>>>
>>>>> 'buf_alloc' are updated with header of every packet. Of course,
>>>>>
>>>>> to every such case i've described i can add check for 'RW'
>>>>>
>>>>> packet, to exclude payload from credit accounting, but this is
>>>>>
>>>>> bunch of dumb checks.
>>>>>
>>>>>> I think that we can define a specific header to put after the
>>>>>> virtio_vsock_hdr when hdr.op is SEQ_BEGIN or SEQ_END, and in this he=
ader
>>>>>> we can store the id and the length of the message.
>>>>> I think it is better than use payload and touch credit logic
>>>>>
>>>> Cool, so let's try this option, hoping there aren't a lot of issues.
>>> If i understand, current implementation has 'struct =

>>> virtio_vsock_hdr',
>>>
>>> then i'll add 'struct virtio_vsock_hdr_seq' with message length and id.
>>>
>>> After that, in 'struct virtio_vsock_pkt' which describes packet, field =
for
>>>
>>> header(which is 'struct virtio_vsock_hdr') must be replaced with new
>>>
>>> structure which=A0 contains both 'struct virtio_vsock_hdr' and 'struct
>>>
>>> virtio_vsock_hdr_seq', because header field of 'struct virtio_vsock_pkt'
>>>
>>> is buffer for virtio layer. After it all accesses to header(for example=
 to
>>>
>>> 'buf_alloc' field will go accross new=A0 structure with both headers:
>>>
>>> pkt->hdr.buf_alloc=A0=A0 ->=A0=A0 pkt->extended_hdr.classic_hdr.buf_all=
oc
>>>
>>> May be to avoid this, packet's header could be allocated dynamically
>>>
>>> in the same manner as packet's buffer? Size of allocation is always
>>>
>>> sizeof(classic header) + sizeof(seq header). In 'struct virtio_vsock_pk=
t'
>>>
>>> such header will be implemented as union of two pointers: class header
>>>
>>> and extended header containing classic and seq header. Which pointer
>>>
>>> to use is depends on packet's op.
>> I think that the 'classic header' can stay as is, and the extended
>> header can be dynamically allocated, as we do for the payload.
>>
>> But we have to be careful what happens if the other peer doesn't support
>> SEQPACKET and if it counts this extra header as a payload for the credit
>> mechanism.
>
>You mean put extra header to payload(buffer of second virtio desc),
>
>in this way on send/receive auxiliary 'if's are needed to avoid credit
>
>logic(or set length field in header of such packets to 0). But what
>
>about placing extra header after classic header in buffer of first virtio
>
>desc? In this case extra header is not payload and credit works as is.
>
>Or it is critical, that size of first buffer will be not same as size of
>
>classic header?

We need to think about compatibility with old drivers.

What would happen in this case?

I think it's easier to use the second buffer, usually used for the =

payload, to carry the extra header. Also, we can leave hdr.len =3D 0, so =

we are sure that it is not counted in credit mechanism.

If the driver supports SEQPACKET, it knows it must fetch extra header =

when it must handle SEQ_BEGIN/SEQ_END.

If it is not clear, I'll try to provide a simple PoC of a patch.

Thanks,
Stefano

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
