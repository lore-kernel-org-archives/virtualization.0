Return-Path: <SRS0=cXtE=IO=lists.linux-foundation.org=virtualization-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9BA6BC433DB
	for <virtualization@archiver.kernel.org>; Tue, 16 Mar 2021 08:19:39 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 3B2B564FEA
	for <virtualization@archiver.kernel.org>; Tue, 16 Mar 2021 08:19:39 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3B2B564FEA
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=virtualization-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by smtp2.osuosl.org (Postfix) with ESMTP id E193143169;
	Tue, 16 Mar 2021 08:19:38 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
	by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id gaZ94_n_MNbT; Tue, 16 Mar 2021 08:19:38 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp2.osuosl.org (Postfix) with ESMTP id 69A1542FFF;
	Tue, 16 Mar 2021 08:19:37 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 2AFE0C000C;
	Tue, 16 Mar 2021 08:19:37 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 568ECC000A
 for <virtualization@lists.linux-foundation.org>;
 Tue, 16 Mar 2021 08:19:35 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id 37E6683449
 for <virtualization@lists.linux-foundation.org>;
 Tue, 16 Mar 2021 08:19:35 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp1.osuosl.org (amavisd-new);
 dkim=pass (1024-bit key) header.d=redhat.com
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id moZZ_NLwVtkL
 for <virtualization@lists.linux-foundation.org>;
 Tue, 16 Mar 2021 08:19:34 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [216.205.24.124])
 by smtp1.osuosl.org (Postfix) with ESMTPS id CD655833CA
 for <virtualization@lists.linux-foundation.org>;
 Tue, 16 Mar 2021 08:19:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1615882772;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=MniBhQ3RzSi0Sb7KBRhVyLWPBNYVOlnsflJQeqHkfog=;
 b=CjwEDzv+gCatTGXjaLA+fMnQvUttecUR15RiywtRngtf8cFRxtT/i0x1SR8LTITS0VQQDr
 563EsdL5ayqxNOiUM1daSURjCxp/bkra2qCrfIuj+BqbJYPFiqOnw11SBP5Ki81t6zyRU9
 PwyfwcE7HohxPaO/t74j8wAoeNK6vVQ=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-531-hZKdfYS7PhyWtz8e2WgFtQ-1; Tue, 16 Mar 2021 04:19:30 -0400
X-MC-Unique: hZKdfYS7PhyWtz8e2WgFtQ-1
Received: by mail-wr1-f70.google.com with SMTP id m23so11278582wrh.7
 for <virtualization@lists.linux-foundation.org>;
 Tue, 16 Mar 2021 01:19:30 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to;
 bh=MniBhQ3RzSi0Sb7KBRhVyLWPBNYVOlnsflJQeqHkfog=;
 b=EUuMXziSp3s9jx14NgGUJDAy3JMHe3/xYg6Bot6z9Oluj2ynqwHOlwPrBLK+Uj+0aM
 qVgsC4VZPlW6ZI8oYjRbivw6R9QLUIJg+WxOoNm5KsvJ8J2C39e5ZFWuYd8rELGzh/77
 NEKeDrK1G9W2rOr3nEFYqMZinkgHemhNv4aYNrKV7Uu29oWnGLsPE4UX776tOIRrlzhg
 SAT6WQ5C23S1j6J1/axL45GrMrL0EjYElNDRQVb69o7adM91Xh2ua72SbZtebORjzXvZ
 08C9Rs6Peych34bE3NorJexLuO6gv+nUAQ+R6MOLbUjC+zoGH9ojuGmMswhICs2t4WEt
 ajlQ==
X-Gm-Message-State: AOAM532dLGbldmwE+UrPvKz1sango5FDpnFpoqaxmehGC7KX9oBWmG2g
 WBNZf/3B0LzEVZek+JIqhfOUkbr8wGVK0MenzCDp+zdI7lo9PQgD45RCpbGjS/NSxNkKJ5JhXOA
 W50aXeXK70QVZZ4W9fRtm0oLCzLXJEnqXK/m0FHA5OQ==
X-Received: by 2002:adf:c101:: with SMTP id r1mr3588571wre.38.1615882769681;
 Tue, 16 Mar 2021 01:19:29 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJw3yrqhv7aBh76dtNqiUxOZ4ukHur7zmHLkSny0+Wrsw9qDX0wwYrl0lffiae/HD+n9ms+NMg==
X-Received: by 2002:adf:c101:: with SMTP id r1mr3588545wre.38.1615882769502;
 Tue, 16 Mar 2021 01:19:29 -0700 (PDT)
Received: from steredhat (host-79-34-249-199.business.telecomitalia.it.
 [79.34.249.199])
 by smtp.gmail.com with ESMTPSA id h6sm2347823wmi.6.2021.03.16.01.19.28
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 16 Mar 2021 01:19:29 -0700 (PDT)
Date: Tue, 16 Mar 2021 09:19:26 +0100
From: Stefano Garzarella <sgarzare@redhat.com>
To: Arseny Krasnov <arseny.krasnov@kaspersky.com>
Subject: Re: [MASSMAIL KLMS] [virtio-comment] Re: [RFC PATCH v1]
 virtio-vsock: use enums instead of hardcoded constants
Message-ID: <20210316081926.apy3ut4p5lmvsft6@steredhat>
References: <20210315083547.2283420-1-arseny.krasnov@kaspersky.com>
 <20210315165350.7377478e.cohuck@redhat.com>
 <25dbb0d6-9e3d-515c-0a6f-10686b76a31a@kaspersky.com>
MIME-Version: 1.0
In-Reply-To: <25dbb0d6-9e3d-515c-0a6f-10686b76a31a@kaspersky.com>
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=sgarzare@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Disposition: inline
Cc: Andra Paraschiv <andraprs@amazon.com>,
 "Michael S. Tsirkin" <mst@redhat.com>, Cornelia Huck <cohuck@redhat.com>,
 Colin Ian King <colin.king@canonical.com>,
 "oxffffaa@gmail.com" <oxffffaa@gmail.com>,
 Norbert Slusarek <nslusarek@gmx.net>, Stefan Hajnoczi <stefanha@redhat.com>,
 "virtio-comment@lists.oasis-open.org" <virtio-comment@lists.oasis-open.org>,
 Jakub Kicinski <kuba@kernel.org>,
 "virtualization@lists.linux-foundation.org"
 <virtualization@lists.linux-foundation.org>,
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

On Tue, Mar 16, 2021 at 06:35:11AM +0300, Arseny Krasnov wrote:
>
>On 15.03.2021 18:53, Cornelia Huck wrote:
>> On Mon, 15 Mar 2021 11:35:41 +0300
>> Arseny Krasnov <arseny.krasnov@kaspersky.com> wrote:
>>
>>> This replaces constants defined in "bit X set to Y" manner
>>> with enums from Linux kernel uapi headers.
>>> ---
>>>  virtio-vsock.tex | 29 ++++++++++++++++++++++-------
>>>  1 file changed, 22 insertions(+), 7 deletions(-)
>>>
>>> diff --git a/virtio-vsock.tex b/virtio-vsock.tex
>>> index da7e641..a97a81e 100644
>>> --- a/virtio-vsock.tex
>>> +++ b/virtio-vsock.tex
>>> @@ -140,8 +140,14 @@ \subsubsection{Addressing}\label{sec:Device Types / Socket Device / Device Opera
>>>  consists of a (cid, port number) tuple. The header fields used for this are
>>>  \field{src_cid}, \field{src_port}, \field{dst_cid}, and \field{dst_port}.
>>>
>>> -Currently only stream sockets are supported. \field{type} is 1 for stream
>>> -socket types.
>>> +Currently only stream sockets are supported. \field{type} is one of the
>>> +following constants:
>>> +
>>> +\begin{lstlisting}
>>> +enum virtio_vsock_type {
>>> +	VIRTIO_VSOCK_TYPE_STREAM = 1,
>>> +};
>>> +\end{lstlisting}
>>>
>>>  Stream sockets provide in-order, guaranteed, connection-oriented delivery
>>>  without message boundaries.
>>> @@ -221,11 +227,20 @@ \subsubsection{Stream Sockets}\label{sec:Device Types / Socket Device / Device O
>>>  a listening socket does not exist on the destination or the destination has
>>>  insufficient resources to establish the connection.
>>>
>>> -When a connected socket receives VIRTIO_VSOCK_OP_SHUTDOWN the header
>>> -\field{flags} field bit 0 indicates that the peer will not receive any more
>>> -data and bit 1 indicates that the peer will not send any more data.  These
>>> -hints are permanent once sent and successive packets with bits clear do not
>>> -reset them.
>>> +When a connected socket receives VIRTIO_VSOCK_OP_SHUTDOWN, header \field{flags}
>>> +field is one of the following constants:
>> I don't think these two are required to be mutually exclusive (i.e.
>> both can be indicated at the same time?)
>
>I'm not sure, in Linux driver there are several cases when these constants are used
>
>independently from each over, but I think, this is question to implementation of virtio
>
>vsock protocol, while this patch is cosmetic for specification.
>

I think Cornelia's point is that from the "is one of the following 
constants" sentence it looks like only one of these flags can be set.
Instead both of them could be set together, and I guess this is the most 
frequent use case.

Thanks,
Stefano

>>
>>> +
>>> +\begin{lstlisting}
>>> +enum virtio_vsock_shutdown {
>>> +	VIRTIO_VSOCK_SHUTDOWN_RCV = 1,
>>> +	VIRTIO_VSOCK_SHUTDOWN_SEND = 2,
>>> +};
>>> +\end{lstlisting}
>>> +
>>> +VIRTIO_VSOCK_SHUTDOWN_RCV indicates that the peer will not receive any more
>>> +data and VIRTIO_VSOCK_SHUTDOWN_SEND indicates that the peer will not send
>>> +any more data.  These hints are permanent once sent and successive packets
>>> +with bits clear do not reset them.
>>>
>>>  The VIRTIO_VSOCK_OP_RST packet aborts the connection process or forcibly
>>>  disconnects a connected socket.
>>
>> This publicly archived list offers a means to provide input to the
>> OASIS Virtual I/O Device (VIRTIO) TC.
>>
>> In order to verify user consent to the Feedback License terms and
>> to minimize spam in the list archive, subscription is required
>> before posting.
>>
>> Subscribe: virtio-comment-subscribe@lists.oasis-open.org
>> Unsubscribe: virtio-comment-unsubscribe@lists.oasis-open.org
>> List help: virtio-comment-help@lists.oasis-open.org
>> List archive: https://lists.oasis-open.org/archives/virtio-comment/
>> Feedback License: https://www.oasis-open.org/who/ipr/feedback_license.pdf
>> List Guidelines: https://www.oasis-open.org/policies-guidelines/mailing-lists
>> Committee: https://www.oasis-open.org/committees/virtio/
>> Join OASIS: https://www.oasis-open.org/join/
>>
>>
>

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
