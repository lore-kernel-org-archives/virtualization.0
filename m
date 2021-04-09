Return-Path: <SRS0=E6mM=JG=lists.linux-foundation.org=virtualization-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 16618C433B4
	for <virtualization@archiver.kernel.org>; Fri,  9 Apr 2021 14:27:20 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B5D9061186
	for <virtualization@archiver.kernel.org>; Fri,  9 Apr 2021 14:27:19 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B5D9061186
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=virtualization-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 7AF4F84174;
	Fri,  9 Apr 2021 14:27:19 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
	by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id 9SpAZ0AUNkMz; Fri,  9 Apr 2021 14:27:18 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp1.osuosl.org (Postfix) with ESMTP id F3CD883CEF;
	Fri,  9 Apr 2021 14:27:17 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id CB18AC000B;
	Fri,  9 Apr 2021 14:27:17 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [IPv6:2605:bc80:3010::133])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 017C8C000A
 for <virtualization@lists.linux-foundation.org>;
 Fri,  9 Apr 2021 14:27:15 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id CF69640198
 for <virtualization@lists.linux-foundation.org>;
 Fri,  9 Apr 2021 14:27:15 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp2.osuosl.org (amavisd-new);
 dkim=pass (1024-bit key) header.d=redhat.com
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id gE2tEGzfbY7I
 for <virtualization@lists.linux-foundation.org>;
 Fri,  9 Apr 2021 14:27:12 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.133.124])
 by smtp2.osuosl.org (Postfix) with ESMTPS id B4E9640155
 for <virtualization@lists.linux-foundation.org>;
 Fri,  9 Apr 2021 14:27:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1617978431;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=LB9KAATf2xz7DlV2AtRY37TOuznBrvul3p+pz/3bjKM=;
 b=LJz4sjsKIOvwtJTPpQVafk5TXiEaW4hwOagFZpyWRgynCt03Mi4IwYlYR4W9QRezSkKV69
 2qRngnfUKZP0/kjdlOUeb3fnqB1cyaJZLEYdznbunWtIUm4PgsIqk44g1aDp+/XeHhV2i/
 0SlfzpzFhfRJ3PYf0xCExPDVzRKmOIU=
Received: from mail-ej1-f70.google.com (mail-ej1-f70.google.com
 [209.85.218.70]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-434-HR6vPbbRNvaWW09pIJJC0Q-1; Fri, 09 Apr 2021 10:27:09 -0400
X-MC-Unique: HR6vPbbRNvaWW09pIJJC0Q-1
Received: by mail-ej1-f70.google.com with SMTP id d6so2248470ejd.15
 for <virtualization@lists.linux-foundation.org>;
 Fri, 09 Apr 2021 07:27:09 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:content-transfer-encoding
 :in-reply-to;
 bh=LB9KAATf2xz7DlV2AtRY37TOuznBrvul3p+pz/3bjKM=;
 b=aPhryf1M0J2uf03XW/lacESV1M1hKOxu+CFRHrDJsYrAJXwfFV0nD3X3TVxIXQar1h
 HL8bGN5s+qcfXnNhNLjdEA7ug1x20vr9vQZEinOpR2gPJulFllaoVFHj1KoCzzB/L9Be
 1WpjO5r8v4x8JVG0aKoOsqs7O0LRqSSIFseOYIVUtlHh7oZMkALqkeUcyNAQIzV3oI8U
 2yv2Bk76xyI0rSln/uQtHtEAXRhC4uk1hp4dtuVdBq+kMf3QHFoLso31XAtcoAd9SJcI
 zq1MStkmlW0kqmk/qZUeHcJo6zQyeSwryQnCq+gw8s5pvI9VOVOGeFGOUjWGP/fYlybl
 flOQ==
X-Gm-Message-State: AOAM531EpYykazbo5twwc5w6jsG9kuZAEYs7lWoNYAdl7OsapXiLzXmD
 7VNabafn0NyiuyB+iTkuB8EM+UlaP6m8TIrcQgcB4vICkMBU5S2l7fZbY4i3jwdJ9n87QOQXz1G
 en1ZeTfEp/oR+KwTFWIaZv+HXO4NmjvN6E5xr0PxkKQ==
X-Received: by 2002:a05:6402:4301:: with SMTP id
 m1mr18424652edc.210.1617978428190; 
 Fri, 09 Apr 2021 07:27:08 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJwsf9XMHs+0unVWNHmIPU/3gIg5qaBeubribqiODIdNzjuIbgc+cms3zrVwGn2T1/8SfE1Bdw==
X-Received: by 2002:a05:6402:4301:: with SMTP id
 m1mr18424623edc.210.1617978427921; 
 Fri, 09 Apr 2021 07:27:07 -0700 (PDT)
Received: from steredhat (host-79-34-249-199.business.telecomitalia.it.
 [79.34.249.199])
 by smtp.gmail.com with ESMTPSA id cw11sm1349450ejc.67.2021.04.09.07.27.06
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 09 Apr 2021 07:27:07 -0700 (PDT)
Date: Fri, 9 Apr 2021 16:27:05 +0200
From: Stefano Garzarella <sgarzare@redhat.com>
To: Arseny Krasnov <arseny.krasnov@kaspersky.com>
Subject: Re: [virtio-comment] Re: [MASSMAIL KLMS] Re: [virtio-comment] Re:
 [MASSMAIL KLMS] Re: [virtio-comment] [RFC PATCH v4 2/2] virtio-vsock:
 SOCK_SEQPACKET description
Message-ID: <20210409142705.xsp56d5negdww6lc@steredhat>
References: <YGH8IqLRdh5JCZyT@stefanha-x1.localdomain>
 <230d95fd-29e8-465b-0ab2-b406d614c11b@kaspersky.com>
 <20210329212818.qdeprjhep745yeur@steredhat>
 <d6d92105-f7d4-74a3-4acc-fcfb40872b76@kaspersky.com>
 <YGLnfAxvy83jLkmG@stefanha-x1.localdomain>
 <2061f2ab-f3fc-c059-7cfc-a34b06f061fe@kaspersky.com>
 <YGMuVWL1waLpTkFI@stefanha-x1.localdomain>
 <64023aef-2e6b-b4bf-6569-ea71f7ee53de@kaspersky.com>
 <YGSLreQSCe5CBZbY@stefanha-x1.localdomain>
 <486fe58d-4472-d5e6-11d9-062408c59c1e@kaspersky.com>
MIME-Version: 1.0
In-Reply-To: <486fe58d-4472-d5e6-11d9-062408c59c1e@kaspersky.com>
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=sgarzare@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Disposition: inline
Cc: Andra Paraschiv <andraprs@amazon.com>,
 "Michael S. Tsirkin" <mst@redhat.com>, "cohuck@redhat.com" <cohuck@redhat.com>,
 Colin Ian King <colin.king@canonical.com>,
 "oxffffaa@gmail.com" <oxffffaa@gmail.com>,
 Norbert Slusarek <nslusarek@gmx.net>, Stefan Hajnoczi <stefanha@redhat.com>,
 "virtio-comment@lists.oasis-open.org" <virtio-comment@lists.oasis-open.org>,
 Jakub Kicinski <kuba@kernel.org>,
 "virtualization@lists.linux-foundation.org"
 <virtualization@lists.linux-foundation.org>,
 "David S. Miller" <davem@davemloft.net>, Jorgen Hansen <jhansen@vmware.com>,
 Alexander Popov <alex.popov@linux.com>
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

On Sat, Apr 03, 2021 at 12:45:54PM +0300, Arseny Krasnov wrote:
>
>On 31.03.2021 17:48, Stefan Hajnoczi wrote:
>> On Tue, Mar 30, 2021 at 05:24:19PM +0300, Arseny Krasnov wrote:
>>> On 30.03.2021 16:57, Stefan Hajnoczi wrote:
>>>> On Tue, Mar 30, 2021 at 12:50:06PM +0300, Arseny Krasnov wrote:
>>>>> On 30.03.2021 11:55, Stefan Hajnoczi wrote:
>>>>>> On Tue, Mar 30, 2021 at 09:15:39AM +0300, Arseny Krasnov wrote:
>>>>>>> On 30.03.2021 00:28, Stefano Garzarella wrote:
>>>>>>>> On Mon, Mar 29, 2021 at 08:33:27PM +0300, Arseny Krasnov wrote:
>>>>>>>>> On 29.03.2021 19:11, Stefan Hajnoczi wrote:
>>>>>>>>>> On Fri, Mar 26, 2021 at 12:02:50PM +0300, Arseny Krasnov wrote:
>>>>>>>>>>> @@ -98,6 +102,10 @@ \subsection{Device Operation}\label{sec:Dev=
ice Types / Socket Device / Device Op
>>>>>>>>>>>  #define VIRTIO_VSOCK_OP_CREDIT_UPDATE  6
>>>>>>>>>>>  /* Request the peer to send the credit info to us */
>>>>>>>>>>>  #define VIRTIO_VSOCK_OP_CREDIT_REQUEST 7
>>>>>>>>>>> +/* Message begin for SOCK_SEQPACKET */
>>>>>>>>>>> +#define VIRTIO_VSOCK_OP_SEQ_BEGIN      8
>>>>>>>>>>> +/* Message end for SOCK_SEQPACKET */
>>>>>>>>>>> +#define VIRTIO_VSOCK_OP_SEQ_END        9
>>>>>>>>>> The struct virtio_vsock_hdr->flags field is le32 and currently u=
nused.
>>>>>>>>>> Could 24 bits be used for a unique message id and 8 bits for fla=
gs? 1
>>>>>>>>>> flag bit could be used for end-of-message and the remaining 7 bi=
ts could
>>>>>>>>>> be reserved. That way SEQ_BEGIN and SEQ_END are not necessary.
>>>>>>>>>> Pressure
>>>>>>>>>> on the virtqueue would be reduced and performance should be comp=
arable
>>>>>>>>>> to SOCK_STREAM.
>>>>>>>>> Well, my first versions of SOCK_SEQPACKET implementation, worked
>>>>>>>>> something like this: i used flags field of header as length of wh=
ole
>>>>>>>>> message. I discussed it with Stefano Garzarella, and he told that=
 it
>>>>>>>>> will
>>>>>>>>> be better to use special "header" in packet's payload, to keep so=
me
>>>>>>>>> SOCK_SEQPACKET specific data, instead of reusing packet's header
>>>>>>>>> fields.
>>>>>>>> IIRC in the first implementation SEQ_BEGIN was an empty message an=
d we
>>>>>>>> didn't added the msg_id yet. So since we needed to carry both id a=
nd
>>>>>>>> total length, I suggested to use the payload to put these extra
>>>>>>>> information.
>>>>>>>>
>>>>>>>> IIUC what Stefan is suggesting is a bit different and I think it s=
hould
>>>>>>>> be cool to implement: we can remove the boundary packets, use only=
 8
>>>>>>>> bits for the flags, and add a new field to reuse the 24 unused bit=
s,
>>>>>>>> maybe also 16 bits would be enough.
>>>>>>>> At that point we will only use the EOR flag to know the last packe=
t.
>>>>>>>>
>>>>>>>> The main difference will be that the receiver will know the total =
size
>>>>>>>> only when the last packet is received.
>>>>>>>>
>>>>>>>> Do you see any issue on that approach?
>>>>>>> It will work, except we can't check that any packet of message,
>>>>>>>
>>>>>>> except last(with EOR bit) was dropped, since receiver don't know
>>>>>>>
>>>>>>> real length of message. If it is ok, then i can implement it.
>>>>>> The credit mechanism ensures that packets are not dropped, so it's n=
ot
>>>>>> necessary to check for this condition.
>>>>>>
>>>>>> By the way, is a unique message ID needed? My understanding is:
>>>>>>
>>>>>> If two messages are being sent on a socket at the same time either t=
heir
>>>>>> order is serialized (whichever message began first) or it is undefin=
ed
>>>>>> (whichever message completes first).
>>>>> If we are talking about case, when two threads writes to one socket a=
t the same time,
>>>>>
>>>>> in Linux it is possible that two message will interleave(for vsock). =
But as i know, for example
>>>>>
>>>>> when TCP socket is used, both 'write()' calls will be serialized. May=
 be it is bug of vsock: when
>>>>>
>>>>> first writer goes out of space, it will sleep. Then second writer tri=
es to send something, but
>>>>>
>>>>> as free space is over, it will sleep too. Then, credit update is rece=
ived from peer. Both sender's
>>>>>
>>>>> will be woken up, but sender which grab socket lock first will contin=
ue to send it's message.
>>>>>
>>>>> So may be we can add something like semaphore to new/vmw_vsock/af_vso=
ck.c which will
>>>>>
>>>>> serialize two 'write()' calls: second sender enters 'write()' path, o=
nly when first left this path.
>>>>>
>>>>> My implementation doesn't care about that, because i wanted to add se=
maphore later, by another
>>>>>
>>>>> patch.
>>>> Yes, that is definitely an issue that the driver needs to take care of
>>>> if we don't have unique message IDs. Thanks for explaining!
>>> So may I=A0 include patch with serializer to next version of my patchse=
t?
>> Sounds good!
>
>There is small problem with approach, when we remove SEQ_BEGIN/SEQ_END =

>
>bounds of messages in flags field(EOR bit ) of packet header: consider cas=
e, when vhost sends data
>
>to guest(let it be 64kb). In vhost vsock driver, big buffer of packet(for =
example 64kb) will
>
>be splitted to small buffers, to fit guests's virtio rx descriptors(in cur=
rent implementation of
>
>Linux it is 4kb). All fields of new headers in rx queue will be copied fro=
m fields of header
>
>of big packet(except len field).=A0 Thus we get 16 headers with=A0 EOR bit=
 set.
>set.
>
>
>May be it is possible to:
>
>1) Handle such bit in vhost driver(set EOR bit in flags only for last smal=
l buffer of guests rx queue)
>
>OR
>
>2) I can remove SEQ_BEGIN, msg_len and msg_id. But keep SEQ_END op. This w=
ill be special
>
>packet which marks end of message without any payload. In this case, such =
packet will be
>
>processed by vhost "as is".
>
>
>What do You think?
>

IMHO option 1 is the best and should not be too complicated to =

implement.

Do you see a specific issue?

Thanks,
Stefano

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
