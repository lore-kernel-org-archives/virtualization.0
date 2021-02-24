Return-Path: <SRS0=cI1G=H2=lists.linux-foundation.org=virtualization-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1F374C433E0
	for <virtualization@archiver.kernel.org>; Wed, 24 Feb 2021 08:35:30 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 8115E64E20
	for <virtualization@archiver.kernel.org>; Wed, 24 Feb 2021 08:35:29 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8115E64E20
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=virtualization-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 0E3406F5D9;
	Wed, 24 Feb 2021 08:35:29 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
	by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id r0PvqIVuabwQ; Wed, 24 Feb 2021 08:35:28 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp3.osuosl.org (Postfix) with ESMTP id 8A52A6F5BD;
	Wed, 24 Feb 2021 08:35:27 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 444E8C000A;
	Wed, 24 Feb 2021 08:35:27 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 3FE92C0001
 for <virtualization@lists.linux-foundation.org>;
 Wed, 24 Feb 2021 08:35:26 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id 3BF3B414ED
 for <virtualization@lists.linux-foundation.org>;
 Wed, 24 Feb 2021 08:35:26 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp2.osuosl.org (amavisd-new);
 dkim=pass (1024-bit key) header.d=redhat.com
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id Fvodcp-XR184
 for <virtualization@lists.linux-foundation.org>;
 Wed, 24 Feb 2021 08:35:25 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [216.205.24.124])
 by smtp2.osuosl.org (Postfix) with ESMTPS id 412DC43077
 for <virtualization@lists.linux-foundation.org>;
 Wed, 24 Feb 2021 08:35:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1614155723;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=u2cCLiq5dRL7OLoCY/lyttfbFxENLjxHql4LOuHz3Jg=;
 b=gXwz39Fpub4G351WfynhN+4siVmpYj301DiAmH09ycO9VzIXYAW3pU3YiW5DRSSakJeMIj
 CjN5ryjENZehK77fLfaZv5lSuXyuv1JWYQNHiikJRdjRSCm5ckPD2aoXI2NC2e9PzfLzkI
 d2qT90agymVtmPfmPLV6pFAo8ORkBjg=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-55--yLJNzyXOOabhBD1QgHyzg-1; Wed, 24 Feb 2021 03:35:21 -0500
X-MC-Unique: -yLJNzyXOOabhBD1QgHyzg-1
Received: by mail-wm1-f72.google.com with SMTP id b201so249389wmb.9
 for <virtualization@lists.linux-foundation.org>;
 Wed, 24 Feb 2021 00:35:20 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to;
 bh=u2cCLiq5dRL7OLoCY/lyttfbFxENLjxHql4LOuHz3Jg=;
 b=DCXJmzZOWRjGxo+DCDzv7XZx33wJgrMEa9QyJnopXe09gFx3JZfZI/AjHB+Y/DUogt
 1JbluxY9HvWM7f+os1nLeO+qZWkGGynKHsmNA5jzxrSV3/iHJrZJHxenTiUzRO6DQm/p
 CJsHxJ7HbsAEd1hemJrds5s6pk5r+mr5KZnuB3/GjcJytmjxtJOIlrQ9Ojvjnvkkn1lX
 +/xWXAREaLbxZByp1UHSuFeghQJFFVNePLQaqf+VMT5fmxlGaPoy9P4A1ujjrgoVAXnC
 ei7eIQGM+HJWn9ZKM5SlwcmqNNRsrAmLKB3BISSQvyUW8YksBg/KNAio4Vm+S8dLqu3i
 Oy0Q==
X-Gm-Message-State: AOAM532Dhy0Vb/Go2RJhGMGirh4voGDwe6nZwlI8VX30IfBiLzB6dulN
 AnsD7Khy6RYDmn23zkuZJlg5pMvtnsWhXq3Yz9B/k+Mhd4UZDbLKf/B8mxu6Q37AfS4CcZmph1I
 sPSv7xZIRrGl+R/qmzJFEfurVarDkOIJu5jyBEyGCXA==
X-Received: by 2002:a1c:c906:: with SMTP id f6mr2571786wmb.128.1614155719952; 
 Wed, 24 Feb 2021 00:35:19 -0800 (PST)
X-Google-Smtp-Source: ABdhPJxKD3EgkojM04mK/2unwdiZBQo5BwpQUu3yMCwRrLcbPtdC8ONeJZN9YjQd8V8wZCs15R2MeQ==
X-Received: by 2002:a1c:c906:: with SMTP id f6mr2571773wmb.128.1614155719766; 
 Wed, 24 Feb 2021 00:35:19 -0800 (PST)
Received: from steredhat (host-79-34-249-199.business.telecomitalia.it.
 [79.34.249.199])
 by smtp.gmail.com with ESMTPSA id g18sm2173103wrw.40.2021.02.24.00.35.18
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 24 Feb 2021 00:35:19 -0800 (PST)
Date: Wed, 24 Feb 2021 09:35:16 +0100
From: Stefano Garzarella <sgarzare@redhat.com>
To: Arseny Krasnov <arseny.krasnov@kaspersky.com>
Subject: Re: [RFC PATCH v5 00/19] virtio/vsock: introduce SOCK_SEQPACKET
 support
Message-ID: <20210224083516.kkxlkoin632iaqik@steredhat>
References: <20210218053347.1066159-1-arseny.krasnov@kaspersky.com>
 <20210222142311.gekdd7gsm33wglos@steredhat>
 <20210223145016.ddavx6fihq4akdim@steredhat>
 <7a280168-cb54-ae26-4697-c797f6b04708@kaspersky.com>
 <20210224082319.yrmqr6zs7emvghw3@steredhat>
 <710d9dc2-3a0c-ea0b-fb02-68b460e6282e@kaspersky.com>
MIME-Version: 1.0
In-Reply-To: <710d9dc2-3a0c-ea0b-fb02-68b460e6282e@kaspersky.com>
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=sgarzare@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Disposition: inline
Cc: Andra Paraschiv <andraprs@amazon.com>,
 "kvm@vger.kernel.org" <kvm@vger.kernel.org>,
 "Michael S. Tsirkin" <mst@redhat.com>,
 "netdev@vger.kernel.org" <netdev@vger.kernel.org>,
 "stsp2@yandex.ru" <stsp2@yandex.ru>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
 "virtualization@lists.linux-foundation.org"
 <virtualization@lists.linux-foundation.org>,
 "oxffffaa@gmail.com" <oxffffaa@gmail.com>,
 Norbert Slusarek <nslusarek@gmx.net>, Stefan Hajnoczi <stefanha@redhat.com>,
 Colin Ian King <colin.king@canonical.com>, Jakub Kicinski <kuba@kernel.org>,
 "David S. Miller" <davem@davemloft.net>, Jorgen Hansen <jhansen@vmware.com>
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

On Wed, Feb 24, 2021 at 11:28:50AM +0300, Arseny Krasnov wrote:
>
>On 24.02.2021 11:23, Stefano Garzarella wrote:
>> On Wed, Feb 24, 2021 at 07:29:25AM +0300, Arseny Krasnov wrote:
>>> On 23.02.2021 17:50, Stefano Garzarella wrote:
>>>> On Mon, Feb 22, 2021 at 03:23:11PM +0100, Stefano Garzarella wrote:
>>>>> Hi Arseny,
>>>>>
>>>>> On Thu, Feb 18, 2021 at 08:33:44AM +0300, Arseny Krasnov wrote:
>>>>>> 	This patchset impelements support of SOCK_SEQPACKET for virtio
>>>>>> transport.
>>>>>> 	As SOCK_SEQPACKET guarantees to save record boundaries, so to
>>>>>> do it, two new packet operations were added: first for start of record
>>>>>> and second to mark end of record(SEQ_BEGIN and SEQ_END later). Also,
>>>>>> both operations carries metadata - to maintain boundaries and payload
>>>>>> integrity. Metadata is introduced by adding special header with two
>>>>>> fields - message count and message length:
>>>>>>
>>>>>> 	struct virtio_vsock_seq_hdr {
>>>>>> 		__le32  msg_cnt;
>>>>>> 		__le32  msg_len;
>>>>>> 	} __attribute__((packed));
>>>>>>
>>>>>> 	This header is transmitted as payload of SEQ_BEGIN and SEQ_END
>>>>>> packets(buffer of second virtio descriptor in chain) in the same way as
>>>>>> data transmitted in RW packets. Payload was chosen as buffer for this
>>>>>> header to avoid touching first virtio buffer which carries header of
>>>>>> packet, because someone could check that size of this buffer is equal
>>>>>> to size of packet header. To send record, packet with start marker is
>>>>>> sent first(it's header contains length of record and counter), then
>>>>>> counter is incremented and all data is sent as usual 'RW' packets and
>>>>>> finally SEQ_END is sent(it also carries counter of message, which is
>>>>>> counter of SEQ_BEGIN + 1), also after sedning SEQ_END counter is
>>>>>> incremented again. On receiver's side, length of record is known from
>>>>>> packet with start record marker. To check that no packets were dropped
>>>>>> by transport, counters of two sequential SEQ_BEGIN and SEQ_END are
>>>>>> checked(counter of SEQ_END must be bigger that counter of SEQ_BEGIN by
>>>>>> 1) and length of data between two markers is compared to length in
>>>>>> SEQ_BEGIN header.
>>>>>> 	Now as  packets of one socket are not reordered neither on
>>>>>> vsock nor on vhost transport layers, such markers allows to restore
>>>>>> original record on receiver's side. If user's buffer is smaller that
>>>>>> record length, when all out of size data is dropped.
>>>>>> 	Maximum length of datagram is not limited as in stream socket,
>>>>>> because same credit logic is used. Difference with stream socket is
>>>>>> that user is not woken up until whole record is received or error
>>>>>> occurred. Implementation also supports 'MSG_EOR' and 'MSG_TRUNC' flags.
>>>>>> 	Tests also implemented.
>>>>> I reviewed the first part (af_vsock.c changes), tomorrow I'll review
>>>>> the rest. That part looks great to me, only found a few minor issues.
>>>> I revieiwed the rest of it as well, left a few minor comments, but I
>>>> think we're well on track.
>>>>
>>>> I'll take a better look at the specification patch tomorrow.
>>> Great, Thank You
>>>> Thanks,
>>>> Stefano
>>>>
>>>>> In the meantime, however, I'm getting a doubt, especially with regard
>>>>> to other transports besides virtio.
>>>>>
>>>>> Should we hide the begin/end marker sending in the transport?
>>>>>
>>>>> I mean, should the transport just provide a seqpacket_enqueue()
>>>>> callbacl?
>>>>> Inside it then the transport will send the markers. This is because
>>>>> some transports might not need to send markers.
>>>>>
>>>>> But thinking about it more, they could actually implement stubs for
>>>>> that calls, if they don't need to send markers.
>>>>>
>>>>> So I think for now it's fine since it allows us to reuse a lot of
>>>>> code, unless someone has some objection.
>>> I thought about that, I'll try to implement it in next version. Let's see...
>> If you want to discuss it first, write down the idea you want to
>> implement, I wouldn't want to make you do unnecessary work. :-)
>
>Idea is simple, in iov iterator of 'struct msghdr' which is passed to
>
>enqueue callback we have two fields: 'iov_offset' which is byte
>
>offset inside io vector where next data must be picked and 'count'
>
>which is rest of unprocessed bytes in io vector. So in seqpacket
>
>enqueue callback if 'iov_offset' is 0 i'll send SEQBEGIN, and if
>
>'count' is 0 i'll send SEQEND.
>

Got it, make sense and it's defently more transparent for the vsock 
core!
Go head, maybe adding a comment in the vsock core explaining this, so 
other developers can understand better if they want to support SEPACKET 
in other transports.

Thanks,
Stefano

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
