Return-Path: <SRS0=wWNv=I3=lists.linux-foundation.org=virtualization-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9CB83C433C1
	for <virtualization@archiver.kernel.org>; Mon, 29 Mar 2021 21:28:30 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 3AF336192E
	for <virtualization@archiver.kernel.org>; Mon, 29 Mar 2021 21:28:30 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3AF336192E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=virtualization-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id E9F4483A8C;
	Mon, 29 Mar 2021 21:28:29 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
	by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id iKKptfy5Rhgh; Mon, 29 Mar 2021 21:28:29 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp1.osuosl.org (Postfix) with ESMTP id 872CA83A88;
	Mon, 29 Mar 2021 21:28:28 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 58B3EC000B;
	Mon, 29 Mar 2021 21:28:28 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 3792DC000A
 for <virtualization@lists.linux-foundation.org>;
 Mon, 29 Mar 2021 21:28:27 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id 21E7983A8C
 for <virtualization@lists.linux-foundation.org>;
 Mon, 29 Mar 2021 21:28:27 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id YUgLEX0ctqq4
 for <virtualization@lists.linux-foundation.org>;
 Mon, 29 Mar 2021 21:28:26 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [216.205.24.124])
 by smtp1.osuosl.org (Postfix) with ESMTPS id 1E1B183A88
 for <virtualization@lists.linux-foundation.org>;
 Mon, 29 Mar 2021 21:28:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1617053304;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=j+cm1EWNiJi+MpDP97wAsldnFcIKGumh3WOzF4/A6iU=;
 b=Ss8wb++ATQBqS/6dLuJWIrmQAoyamYA0nyjxxZb+ciB3rIDg1QAKkzWrxXGe3tjewRgS9l
 fly4SNGNTP06tiEwEBylFYR2d7N7xL6PBDtbLSIvpw7E+XdZl/F8GQo4XJPBBsyLitZlSB
 U8nWErpXcK6Bj8ySf/0OxCx5qivu9IQ=
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-249-OJm7gNNKMBCTmET-_xG-Ww-1; Mon, 29 Mar 2021 17:28:22 -0400
X-MC-Unique: OJm7gNNKMBCTmET-_xG-Ww-1
Received: by mail-wr1-f71.google.com with SMTP id a15so7569010wrf.19
 for <virtualization@lists.linux-foundation.org>;
 Mon, 29 Mar 2021 14:28:22 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to;
 bh=j+cm1EWNiJi+MpDP97wAsldnFcIKGumh3WOzF4/A6iU=;
 b=ucO893ifZUbcLP4r49U/iL97216ae6F1tGE7asE9RASO1hn4giSNAp3XQLVjbHKmcg
 X5as0nSKq0BiL/WZJyTVGuEKRown1RclrXRLcknBgxqZtl2xl5LGdq44o7LLIfFZ+MPK
 hcxwXE5qS2VAntZgwzM0iGXNxTujm8A/H+WzP/puKiEiv/rhTSvjp283IEEQ/TG2N+Ny
 wDGH9N8w/42wQITTsM9Hvs7Ww+eWoWyNtp0oDqy44lKqvAsz0kxSdZl9+vCO9t05fWjj
 5X7EmtlL7P+1qRXU0e6A3QSZHHV4AnlkkyJAvHZo051mMIfefp3CT3CQ40TRrj+fejWM
 wQbA==
X-Gm-Message-State: AOAM533MdG1C9KvY8MCxh4T9N3b/6kyhfExPTN/2Flvo2UnHXc9LiIos
 YQwn+jtXDddEMH4oGuh6deca0V2gLn3EoMfd4uKMaoJkSKmdYPdLyVZCbcuLr+5+In6rk6llh5D
 LW6EWlLTKkWY+cABaoZzGeVblAMrvnV4mWI8kJiaoCA==
X-Received: by 2002:a05:600c:4108:: with SMTP id
 j8mr789238wmi.183.1617053301263; 
 Mon, 29 Mar 2021 14:28:21 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJxutQU40YHZVn6WUstrECh/mXFw4G8D7btffDkXEwIx8c1lbUH8whWR3RCkEfY4Aum3ZCLFXA==
X-Received: by 2002:a05:600c:4108:: with SMTP id
 j8mr789214wmi.183.1617053301025; 
 Mon, 29 Mar 2021 14:28:21 -0700 (PDT)
Received: from steredhat (host-79-34-249-199.business.telecomitalia.it.
 [79.34.249.199])
 by smtp.gmail.com with ESMTPSA id x11sm849820wme.9.2021.03.29.14.28.20
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 29 Mar 2021 14:28:20 -0700 (PDT)
Date: Mon, 29 Mar 2021 23:28:18 +0200
From: Stefano Garzarella <sgarzare@redhat.com>
To: Arseny Krasnov <arseny.krasnov@kaspersky.com>
Subject: Re: [virtio-comment] [RFC PATCH v4 2/2] virtio-vsock: SOCK_SEQPACKET
 description
Message-ID: <20210329212818.qdeprjhep745yeur@steredhat>
References: <20210326090154.1144100-1-arseny.krasnov@kaspersky.com>
 <20210326090254.1144486-1-arseny.krasnov@kaspersky.com>
 <YGH8IqLRdh5JCZyT@stefanha-x1.localdomain>
 <230d95fd-29e8-465b-0ab2-b406d614c11b@kaspersky.com>
MIME-Version: 1.0
In-Reply-To: <230d95fd-29e8-465b-0ab2-b406d614c11b@kaspersky.com>
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=sgarzare@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Disposition: inline
Cc: Andra Paraschiv <andraprs@amazon.com>,
 "Michael S. Tsirkin" <mst@redhat.com>, cohuck@redhat.com,
 Colin Ian King <colin.king@canonical.com>, oxffffaa@gmail.com,
 Norbert Slusarek <nslusarek@gmx.net>, Stefan Hajnoczi <stefanha@redhat.com>,
 virtio-comment@lists.oasis-open.org, Jakub Kicinski <kuba@kernel.org>,
 virtualization@lists.linux-foundation.org,
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

On Mon, Mar 29, 2021 at 08:33:27PM +0300, Arseny Krasnov wrote:
>
>On 29.03.2021 19:11, Stefan Hajnoczi wrote:
>> On Fri, Mar 26, 2021 at 12:02:50PM +0300, Arseny Krasnov wrote:
>>> This adds description of SOCK_SEQPACKET socket type
>>> support for virtio-vsock.
>>>
>>> Signed-off-by: Arseny Krasnov <arseny.krasnov@kaspersky.com>
>>> ---
>>>  virtio-vsock.tex | 65 +++++++++++++++++++++++++++++++++++++++++++-----
>>>  1 file changed, 59 insertions(+), 6 deletions(-)
>>>
>>> diff --git a/virtio-vsock.tex b/virtio-vsock.tex
>>> index ad57f9d..c366de7 100644
>>> --- a/virtio-vsock.tex
>>> +++ b/virtio-vsock.tex
>>> @@ -17,6 +17,10 @@ \subsection{Virtqueues}\label{sec:Device Types / Socket Device / Virtqueues}
>>>  \subsection{Feature bits}\label{sec:Device Types / Socket Device / Feature bits}
>>>
>>>  There are currently no feature bits defined for this device.
>> ^ This line is now out of date :)
>Ack
>>
>>> +\begin{description}
>>> +\item VIRTIO_VSOCK_F_SEQPACKET (0) SOCK_SEQPACKET socket type is
>>> +    supported.
>>> +\end{description}
>>>
>>>  \subsection{Device configuration layout}\label{sec:Device Types / Socket Device / Device configuration layout}
>>>
>>> @@ -98,6 +102,10 @@ \subsection{Device Operation}\label{sec:Device Types / Socket Device / Device Op
>>>  #define VIRTIO_VSOCK_OP_CREDIT_UPDATE  6
>>>  /* Request the peer to send the credit info to us */
>>>  #define VIRTIO_VSOCK_OP_CREDIT_REQUEST 7
>>> +/* Message begin for SOCK_SEQPACKET */
>>> +#define VIRTIO_VSOCK_OP_SEQ_BEGIN      8
>>> +/* Message end for SOCK_SEQPACKET */
>>> +#define VIRTIO_VSOCK_OP_SEQ_END        9
>> The struct virtio_vsock_hdr->flags field is le32 and currently unused.
>> Could 24 bits be used for a unique message id and 8 bits for flags? 1
>> flag bit could be used for end-of-message and the remaining 7 bits could
>> be reserved. That way SEQ_BEGIN and SEQ_END are not necessary.  
>> Pressure
>> on the virtqueue would be reduced and performance should be comparable
>> to SOCK_STREAM.
>
>Well, my first versions of SOCK_SEQPACKET implementation, worked
>something like this: i used flags field of header as length of whole
>message. I discussed it with Stefano Garzarella, and he told that it 
>will
>be better to use special "header" in packet's payload, to keep some
>SOCK_SEQPACKET specific data, instead of reusing packet's header
>fields.

IIRC in the first implementation SEQ_BEGIN was an empty message and we 
didn't added the msg_id yet. So since we needed to carry both id and 
total length, I suggested to use the payload to put these extra 
information.

IIUC what Stefan is suggesting is a bit different and I think it should 
be cool to implement: we can remove the boundary packets, use only 8 
bits for the flags, and add a new field to reuse the 24 unused bits, 
maybe also 16 bits would be enough.
At that point we will only use the EOR flag to know the last packet.

The main difference will be that the receiver will know the total size 
only when the last packet is received.

Do you see any issue on that approach?

Thanks,
Stefano

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
