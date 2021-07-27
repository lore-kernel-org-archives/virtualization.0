Return-Path: <SRS0=8N1b=MT=lists.linux-foundation.org=virtualization-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D4517C4338F
	for <virtualization@archiver.kernel.org>; Tue, 27 Jul 2021 09:58:17 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 8107261390
	for <virtualization@archiver.kernel.org>; Tue, 27 Jul 2021 09:58:17 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org 8107261390
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 3890F404F7;
	Tue, 27 Jul 2021 09:58:17 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
	by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id QOJNHq5qgkm0; Tue, 27 Jul 2021 09:58:16 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp4.osuosl.org (Postfix) with ESMTPS id 9112E404E9;
	Tue, 27 Jul 2021 09:58:15 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 47360C0010;
	Tue, 27 Jul 2021 09:58:15 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [IPv6:2605:bc80:3010::137])
 by lists.linuxfoundation.org (Postfix) with ESMTP id B01A7C000E
 for <virtualization@lists.linux-foundation.org>;
 Tue, 27 Jul 2021 09:58:13 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id 8ACA640529
 for <virtualization@lists.linux-foundation.org>;
 Tue, 27 Jul 2021 09:58:13 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id MNjlLOG0fWLq
 for <virtualization@lists.linux-foundation.org>;
 Tue, 27 Jul 2021 09:58:12 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.133.124])
 by smtp4.osuosl.org (Postfix) with ESMTPS id E3951405DE
 for <virtualization@lists.linux-foundation.org>;
 Tue, 27 Jul 2021 09:58:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1627379888;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=T2rQBG2yVNE7y1+uB+3b6lsmKXViZKQecoiM/1czVBA=;
 b=e+SanA5Wdl+5n4ah4wEtIfE6BCap+km0LZeKV078GUrKqS9yiV8OX3C5Nts3HvjmqoBRRQ
 9hWFi58u9XjBv14NdPp1U48AAfMPT0582Aqj7EByYX46zamDoF4rjPNJLWFq0EFQY6hV/b
 fVqn2RqizOXzuOfqwvdeMDryk5Z4PJE=
Received: from mail-ed1-f72.google.com (mail-ed1-f72.google.com
 [209.85.208.72]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-56-qITsQVAyNbGqOXGy5cjsbw-1; Tue, 27 Jul 2021 05:58:07 -0400
X-MC-Unique: qITsQVAyNbGqOXGy5cjsbw-1
Received: by mail-ed1-f72.google.com with SMTP id
 d6-20020a50f6860000b02903bc068b7717so1213823edn.11
 for <virtualization@lists.linux-foundation.org>;
 Tue, 27 Jul 2021 02:58:07 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to;
 bh=T2rQBG2yVNE7y1+uB+3b6lsmKXViZKQecoiM/1czVBA=;
 b=Se8SfgN07pxTVSRIx8qX/P3/laRXD0C2wqs2CPkbwFAQEhxA140/HeRu2gqjlczGGo
 lGwlZTRNnNZaq3FUXcUzvqJIRbmV5z3ftPDYg/fSvI130mdhR+n8AO0VxBoZW3ykcZNr
 7U+IN8pSgC2G+IxsMNxyTeCyR0BPcGaKfMZKlZht314lTLsy21N1jpnOgZJOPOKcRtS2
 kfYPW3LhnhE/kzABwAkK1Ahc0Zv0U+D+5DDfz4tDA9hytu1nJGf/0DGVwWqawesTBFN4
 5OpyVDkFSlaGkTHJY7e15SmfTLOSP9h7PmnFq83vSSBXF5hAmjXBUfw6iddNiz+mOZCu
 yYMA==
X-Gm-Message-State: AOAM530rlzwtsXjeg0firRaGQn8kzYoonJRRJCXgNBcbjxw0Yk9vahXl
 pUM2wpAv4cgYl5WOcx8zLrZ1OV5rC/WDeD++weiuVeSqTaa4CE0COEsSDH4BPNwVIkoaps7hxEO
 lnnp6Gszcv2UHkRDHBm1CxhKmqW6S44vLUPFhb7ndNA==
X-Received: by 2002:a17:906:ce47:: with SMTP id
 se7mr3742428ejb.240.1627379886418; 
 Tue, 27 Jul 2021 02:58:06 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJx8eyrbNlN1DVbEoRIS2U/HCt0SR/iGRuCNgiSKmvCYAIQaFF1wZB5TRpL7dxgdXFiMYR9Wkg==
X-Received: by 2002:a17:906:ce47:: with SMTP id
 se7mr3742409ejb.240.1627379886242; 
 Tue, 27 Jul 2021 02:58:06 -0700 (PDT)
Received: from steredhat (host-79-18-148-79.retail.telecomitalia.it.
 [79.18.148.79])
 by smtp.gmail.com with ESMTPSA id f18sm726664ejx.23.2021.07.27.02.58.05
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 27 Jul 2021 02:58:05 -0700 (PDT)
Date: Tue, 27 Jul 2021 11:58:03 +0200
From: Stefano Garzarella <sgarzare@redhat.com>
To: Arseny Krasnov <arseny.krasnov@kaspersky.com>
Subject: Re: [MASSMAIL KLMS] Re: [RFC PATCH v1 0/7] virtio/vsock: introduce
 MSG_EOR flag for SEQPACKET
Message-ID: <20210727095803.s26subp3pgclqzvi@steredhat>
References: <20210726163137.2589102-1-arseny.krasnov@kaspersky.com>
 <20210727075948.yl4w3foqa6rp4obg@steredhat>
 <2df68589-96b9-abd4-ad1c-e25918b908a9@kaspersky.com>
MIME-Version: 1.0
In-Reply-To: <2df68589-96b9-abd4-ad1c-e25918b908a9@kaspersky.com>
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=sgarzare@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Disposition: inline
Cc: Andra Paraschiv <andraprs@amazon.com>,
 "kvm@vger.kernel.org" <kvm@vger.kernel.org>,
 "Michael S. Tsirkin" <mst@redhat.com>,
 "netdev@vger.kernel.org" <netdev@vger.kernel.org>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
 "virtualization@lists.linux-foundation.org"
 <virtualization@lists.linux-foundation.org>,
 "oxffffaa@gmail.com" <oxffffaa@gmail.com>,
 Norbert Slusarek <nslusarek@gmx.net>, Stefan Hajnoczi <stefanha@redhat.com>,
 Jakub Kicinski <kuba@kernel.org>, Colin Ian King <colin.king@canonical.com>,
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

On Tue, Jul 27, 2021 at 12:34:36PM +0300, Arseny Krasnov wrote:
>
>On 27.07.2021 10:59, Stefano Garzarella wrote:
>> Caution: This is an external email. Be cautious while opening links or attachments.
>>
>>
>>
>> On Mon, Jul 26, 2021 at 07:31:33PM +0300, Arseny Krasnov wrote:
>>>       This patchset implements support of MSG_EOR bit for SEQPACKET
>>> AF_VSOCK sockets over virtio transport.
>>>       Idea is to distinguish concepts of 'messages' and 'records'.
>>> Message is result of sending calls: 'write()', 'send()', 'sendmsg()'
>>> etc. It has fixed maximum length, and it bounds are visible using
>>> return from receive calls: 'read()', 'recv()', 'recvmsg()' etc.
>>> Current implementation based on message definition above.
>>>       Record has unlimited length, it consists of multiple message,
>>> and bounds of record are visible via MSG_EOR flag returned from
>>> 'recvmsg()' call. Sender passes MSG_EOR to sending system call and
>>> receiver will see MSG_EOR when corresponding message will be processed.
>>>       To support MSG_EOR new bit was added along with existing
>>> 'VIRTIO_VSOCK_SEQ_EOR': 'VIRTIO_VSOCK_SEQ_EOM'(end-of-message) - now it
>>> works in the same way as 'VIRTIO_VSOCK_SEQ_EOR'. But 'VIRTIO_VSOCK_SEQ_EOR'
>>> is used to mark 'MSG_EOR' bit passed from userspace.
>> At this point it's probably better to rename the old flag, so we stay
>> compatible.
>>
>> What happens if one of the two peers does not support MSG_EOR handling,
>> while the other does?
>>
>> I'll do a closer review in the next few days.
>Thank You, also i think MSG_EOR support must be described in spec

Yep, sure!

What do you think about the concerns above?

Stefano

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
