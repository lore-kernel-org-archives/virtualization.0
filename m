Return-Path: <SRS0=i4sF=I4=lists.linux-foundation.org=virtualization-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 72B99C433DB
	for <virtualization@archiver.kernel.org>; Tue, 30 Mar 2021 07:32:26 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id EB0126191B
	for <virtualization@archiver.kernel.org>; Tue, 30 Mar 2021 07:32:25 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org EB0126191B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=virtualization-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by smtp2.osuosl.org (Postfix) with ESMTP id 875D340118;
	Tue, 30 Mar 2021 07:32:25 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
	by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id ADNA3pFnkLZY; Tue, 30 Mar 2021 07:32:24 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp2.osuosl.org (Postfix) with ESMTP id 1C6FE400E0;
	Tue, 30 Mar 2021 07:32:24 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id E2544C000C;
	Tue, 30 Mar 2021 07:32:23 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 236B4C000A
 for <virtualization@lists.linux-foundation.org>;
 Tue, 30 Mar 2021 07:32:22 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id EF3BC60822
 for <virtualization@lists.linux-foundation.org>;
 Tue, 30 Mar 2021 07:32:21 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp3.osuosl.org (amavisd-new);
 dkim=pass (1024-bit key) header.d=redhat.com
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id VF1WcUce0YOO
 for <virtualization@lists.linux-foundation.org>;
 Tue, 30 Mar 2021 07:32:20 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.133.124])
 by smtp3.osuosl.org (Postfix) with ESMTPS id CA9B76081E
 for <virtualization@lists.linux-foundation.org>;
 Tue, 30 Mar 2021 07:32:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1617089539;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=HIK2E8IdK4a2a+1KgcQOAlvCAmKgzEgX+ErBDuO75BU=;
 b=dCOvx0ukyvV9mC+sygs7mUAEphoVv7XuWSYTqyeMIi2TSKuuVc7Cv0gwkaqHcgj8DBs0X5
 Xuf+ZFXo8gNk+r2IwWItP0GEmutRtki4aUDRQuDph0o39QzhkW6j7GztlwgyPCtjmqwkfA
 +Pbptof7HCI2aP/xX+a3RHVnA4y1qLc=
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-18-Etbc89wHMtmspSE-ubBWkQ-1; Tue, 30 Mar 2021 03:32:15 -0400
X-MC-Unique: Etbc89wHMtmspSE-ubBWkQ-1
Received: by mail-wr1-f71.google.com with SMTP id t14so9994712wrx.12
 for <virtualization@lists.linux-foundation.org>;
 Tue, 30 Mar 2021 00:32:15 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to;
 bh=HIK2E8IdK4a2a+1KgcQOAlvCAmKgzEgX+ErBDuO75BU=;
 b=YbdEYK84OX6jeU36kjt1VREJCQiVarvTSkr2X3PGu8RGsfEogfNye2HG/LYRZ32qZR
 YaHnR9NVPXga6VBsXkALDyAoJsGU7TzUNmy1T6CQ3y66m94+EdQRBL+jRz4dlY8yEeIc
 9CP4rYM8rMkN0ZnPddMiOT3JQ2a6MT6c9cRa7w1xST3DGfrdTlyWfAGof9LxKxjuAqM0
 I9MQj7uHf5s7d1M2yecSqX0oaApLg/vFQkvUrcjewiPuXaJjqDi7tvk2XocQp3JIyE6x
 jgdZW116zt12o1s2Qu5H0iWi5LkAf3+3BAOD4zjX0Bg8j/MgKJVWHqfqmjeeyQDmwqtL
 SDIQ==
X-Gm-Message-State: AOAM533aXB5UWw4WFEYk8BZTi6uqAlr5qXJeo4PYLRFB0GpO+Sati+Lq
 FjPPTtMP69xjws7cd5PTJJap5Pt3XnFXDrq8i2wfCHkgAKmx+P6FVHtc+bLVdUBI0URpwk2W3tA
 WeZPG/+DrK0AvKApaCC/zg+MFs7jVI8zQD+C4q1VK9g==
X-Received: by 2002:a05:6000:186a:: with SMTP id
 d10mr31598834wri.303.1617089533983; 
 Tue, 30 Mar 2021 00:32:13 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJxq6UQLm16l1C/JlM+I3EJCB11McM7E12KcY7rNxzkmSG3XJcLLO7zVesj/zgbLPYhO9I96kg==
X-Received: by 2002:a05:6000:186a:: with SMTP id
 d10mr31598804wri.303.1617089533738; 
 Tue, 30 Mar 2021 00:32:13 -0700 (PDT)
Received: from steredhat (host-79-34-249-199.business.telecomitalia.it.
 [79.34.249.199])
 by smtp.gmail.com with ESMTPSA id h14sm40487615wrq.45.2021.03.30.00.32.12
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 30 Mar 2021 00:32:13 -0700 (PDT)
Date: Tue, 30 Mar 2021 09:32:10 +0200
From: Stefano Garzarella <sgarzare@redhat.com>
To: Arseny Krasnov <arseny.krasnov@kaspersky.com>
Subject: Re: [virtio-comment] Re: [MASSMAIL KLMS] Re: [virtio-comment] [RFC
 PATCH v4 2/2] virtio-vsock: SOCK_SEQPACKET description
Message-ID: <20210330073210.cxur42unvhbsux5e@steredhat>
References: <20210326090154.1144100-1-arseny.krasnov@kaspersky.com>
 <20210326090254.1144486-1-arseny.krasnov@kaspersky.com>
 <YGH8IqLRdh5JCZyT@stefanha-x1.localdomain>
 <230d95fd-29e8-465b-0ab2-b406d614c11b@kaspersky.com>
 <20210329212818.qdeprjhep745yeur@steredhat>
 <d6d92105-f7d4-74a3-4acc-fcfb40872b76@kaspersky.com>
MIME-Version: 1.0
In-Reply-To: <d6d92105-f7d4-74a3-4acc-fcfb40872b76@kaspersky.com>
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
Content-Transfer-Encoding: 7bit
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Errors-To: virtualization-bounces@lists.linux-foundation.org
Sender: "Virtualization" <virtualization-bounces@lists.linux-foundation.org>

On Tue, Mar 30, 2021 at 09:15:39AM +0300, Arseny Krasnov wrote:
>
>On 30.03.2021 00:28, Stefano Garzarella wrote:
>> On Mon, Mar 29, 2021 at 08:33:27PM +0300, Arseny Krasnov wrote:
>>> On 29.03.2021 19:11, Stefan Hajnoczi wrote:
>>>> On Fri, Mar 26, 2021 at 12:02:50PM +0300, Arseny Krasnov wrote:
>>>>> This adds description of SOCK_SEQPACKET socket type
>>>>> support for virtio-vsock.
>>>>>
>>>>> Signed-off-by: Arseny Krasnov <arseny.krasnov@kaspersky.com>
>>>>> ---
>>>>>  virtio-vsock.tex | 65 +++++++++++++++++++++++++++++++++++++++++++-----
>>>>>  1 file changed, 59 insertions(+), 6 deletions(-)
>>>>>
>>>>> diff --git a/virtio-vsock.tex b/virtio-vsock.tex
>>>>> index ad57f9d..c366de7 100644
>>>>> --- a/virtio-vsock.tex
>>>>> +++ b/virtio-vsock.tex
>>>>> @@ -17,6 +17,10 @@ \subsection{Virtqueues}\label{sec:Device Types / Socket Device / Virtqueues}
>>>>>  \subsection{Feature bits}\label{sec:Device Types / Socket Device / Feature bits}
>>>>>
>>>>>  There are currently no feature bits defined for this device.
>>>> ^ This line is now out of date :)
>>> Ack
>>>>> +\begin{description}
>>>>> +\item VIRTIO_VSOCK_F_SEQPACKET (0) SOCK_SEQPACKET socket type is
>>>>> +    supported.
>>>>> +\end{description}
>>>>>
>>>>>  \subsection{Device configuration layout}\label{sec:Device Types / Socket Device / Device configuration layout}
>>>>>
>>>>> @@ -98,6 +102,10 @@ \subsection{Device Operation}\label{sec:Device Types / Socket Device / Device Op
>>>>>  #define VIRTIO_VSOCK_OP_CREDIT_UPDATE  6
>>>>>  /* Request the peer to send the credit info to us */
>>>>>  #define VIRTIO_VSOCK_OP_CREDIT_REQUEST 7
>>>>> +/* Message begin for SOCK_SEQPACKET */
>>>>> +#define VIRTIO_VSOCK_OP_SEQ_BEGIN      8
>>>>> +/* Message end for SOCK_SEQPACKET */
>>>>> +#define VIRTIO_VSOCK_OP_SEQ_END        9
>>>> The struct virtio_vsock_hdr->flags field is le32 and currently unused.
>>>> Could 24 bits be used for a unique message id and 8 bits for flags? 1
>>>> flag bit could be used for end-of-message and the remaining 7 bits could
>>>> be reserved. That way SEQ_BEGIN and SEQ_END are not necessary.
>>>> Pressure
>>>> on the virtqueue would be reduced and performance should be comparable
>>>> to SOCK_STREAM.
>>> Well, my first versions of SOCK_SEQPACKET implementation, worked
>>> something like this: i used flags field of header as length of whole
>>> message. I discussed it with Stefano Garzarella, and he told that it
>>> will
>>> be better to use special "header" in packet's payload, to keep some
>>> SOCK_SEQPACKET specific data, instead of reusing packet's header
>>> fields.
>> IIRC in the first implementation SEQ_BEGIN was an empty message and we
>> didn't added the msg_id yet. So since we needed to carry both id and
>> total length, I suggested to use the payload to put these extra
>> information.
>>
>> IIUC what Stefan is suggesting is a bit different and I think it should
>> be cool to implement: we can remove the boundary packets, use only 8
>> bits for the flags, and add a new field to reuse the 24 unused bits,
>> maybe also 16 bits would be enough.
>> At that point we will only use the EOR flag to know the last packet.
>>
>> The main difference will be that the receiver will know the total size
>> only when the last packet is received.
>>
>> Do you see any issue on that approach?
>
>It will work, except we can't check that any packet of message,
>
>except last(with EOR bit) was dropped, since receiver don't know
>
>real length of message. If it is ok, then i can implement it.
>

This is true, but where can a packet be lost?

The channel is lossless, so it can be lost either by the transmitter or 
the receiver, but only in critical cases where for example the whole 
system has run out of memory, but in this case we can't do much, maybe 
only reset the connection.

Thanks,
Stefano

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
