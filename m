Return-Path: <SRS0=C5bb=M4=lists.linux-foundation.org=virtualization-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED,URIBL_RED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 216DAC432BE
	for <virtualization@archiver.kernel.org>; Thu,  5 Aug 2021 09:07:11 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id BB58761078
	for <virtualization@archiver.kernel.org>; Thu,  5 Aug 2021 09:07:10 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org BB58761078
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 83928403B3;
	Thu,  5 Aug 2021 09:07:10 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
	by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id 3iLSseZsQovm; Thu,  5 Aug 2021 09:07:09 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp4.osuosl.org (Postfix) with ESMTPS id 1090D4038A;
	Thu,  5 Aug 2021 09:07:09 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id C8D72C0010;
	Thu,  5 Aug 2021 09:07:08 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by lists.linuxfoundation.org (Postfix) with ESMTP id DEE91C000E
 for <virtualization@lists.linux-foundation.org>;
 Thu,  5 Aug 2021 09:07:06 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id B93B4403B3
 for <virtualization@lists.linux-foundation.org>;
 Thu,  5 Aug 2021 09:07:06 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id orT8fRhG_zKG
 for <virtualization@lists.linux-foundation.org>;
 Thu,  5 Aug 2021 09:07:05 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [216.205.24.124])
 by smtp4.osuosl.org (Postfix) with ESMTPS id AE3484038A
 for <virtualization@lists.linux-foundation.org>;
 Thu,  5 Aug 2021 09:07:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1628154424;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=KYnPAindt7gqrNcKUm5J79oEdrV+LI995OyYx3zHpCI=;
 b=GUHgm2vJAVAIOduhoqR1hEa9rqKSMkp3k3VM5wtQT6RkWRWvQBKyRnN+eDVE44BoMGT6a3
 Zud6oxuEfn9XhwCxprdnLPQmimw2QZ8DR26oigpUrqfIrvpHCVdZF8h9Q4aKmFEpr/meqk
 DUDQT8vzTrGiDjtbzy7ZL6rf3rUC5Ro=
Received: from mail-ej1-f71.google.com (mail-ej1-f71.google.com
 [209.85.218.71]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-473-LYgdapwTM1e-c8S_y-MkNA-1; Thu, 05 Aug 2021 05:07:02 -0400
X-MC-Unique: LYgdapwTM1e-c8S_y-MkNA-1
Received: by mail-ej1-f71.google.com with SMTP id
 n9-20020a1709063789b02905854bda39fcso9034ejc.1
 for <virtualization@lists.linux-foundation.org>;
 Thu, 05 Aug 2021 02:07:02 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to;
 bh=KYnPAindt7gqrNcKUm5J79oEdrV+LI995OyYx3zHpCI=;
 b=tRPKJFmdr1CsQvb8LqD6Yz6+D0yNxD1fVrbJ7BuX6BzD5j/s35GEr9bYreQTPAFWlF
 f1mpk/up5IPgoORYj8pACiv9CPQbpEf0X7Hlud0szbVOhZwh/dKlRQTOOJJdq3gLaENc
 wKHofxnID6+RkuLjMOI98uiuNEE4/tjfcGyz5EC+UYaiDZgLnAzTQpKZvUk855kav7FK
 fWpTRnDAfrc2JQJUGtsl9pTPdaQnwjQL5S3xymS7ziT5NNiHIXLh4KkA9AADYoAZ+g4e
 8wMFViVp8Vw4xsDjyGLPiPXdy9glryn5PV7l/7UTIAf0totl/CZfxBZdKtieNh9ZCV5s
 63LA==
X-Gm-Message-State: AOAM531EJIPLresh/3q1gRgG146N+JCsT/lN13i2EkRol4CwOn0JxjeG
 KFu7PegLVIuNMXQgAbdCI1ZwdqLxFjzFPzW+xr2cujBxQg2YxV3dgZNTTkzt0FllncVrMVaelQX
 SfFIyYaMduTuUNyfMxSjXckLVTW0yltbKXiyWfw/qNw==
X-Received: by 2002:a05:6402:6cb:: with SMTP id
 n11mr5231294edy.112.1628154420100; 
 Thu, 05 Aug 2021 02:07:00 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJwAbJ7jQEOwJQWtXjn6en2nBVwYWl56AzaGjrhqay1J4fO2ol2L+YJReWWqxkCDxYEG9cHRUg==
X-Received: by 2002:a05:6402:6cb:: with SMTP id
 n11mr5231265edy.112.1628154419930; 
 Thu, 05 Aug 2021 02:06:59 -0700 (PDT)
Received: from steredhat (host-79-18-148-79.retail.telecomitalia.it.
 [79.18.148.79])
 by smtp.gmail.com with ESMTPSA id b25sm2018211edv.9.2021.08.05.02.06.59
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 05 Aug 2021 02:06:59 -0700 (PDT)
Date: Thu, 5 Aug 2021 11:06:57 +0200
From: Stefano Garzarella <sgarzare@redhat.com>
To: Arseny Krasnov <arseny.krasnov@kaspersky.com>
Subject: Re: [RFC PATCH v1 0/7] virtio/vsock: introduce MSG_EOR flag for
 SEQPACKET
Message-ID: <20210805090657.y2sz3pzhruuolncq@steredhat>
References: <20210726163137.2589102-1-arseny.krasnov@kaspersky.com>
 <20210804125737.kbgc6mg2v5lw25wu@steredhat>
 <8e44442c-4cac-dcbc-a88d-17d9878e7d32@kaspersky.com>
MIME-Version: 1.0
In-Reply-To: <8e44442c-4cac-dcbc-a88d-17d9878e7d32@kaspersky.com>
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

On Thu, Aug 05, 2021 at 11:33:12AM +0300, Arseny Krasnov wrote:
>
>On 04.08.2021 15:57, Stefano Garzarella wrote:
>> Caution: This is an external email. Be cautious while opening links or attachments.
>>
>>
>>
>> Hi Arseny,
>>
>> On Mon, Jul 26, 2021 at 07:31:33PM +0300, Arseny Krasnov wrote:
>>>       This patchset implements support of MSG_EOR bit for SEQPACKET
>>> AF_VSOCK sockets over virtio transport.
>>>       Idea is to distinguish concepts of 'messages' and 'records'.
>>> Message is result of sending calls: 'write()', 'send()', 'sendmsg()'
>>> etc. It has fixed maximum length, and it bounds are visible using
>>> return from receive calls: 'read()', 'recv()', 'recvmsg()' etc.
>>> Current implementation based on message definition above.
>> Okay, so the implementation we merged is wrong right?
>> Should we disable the feature bit in stable kernels that contain it? Or
>> maybe we can backport the fixes...
>
>Hi,
>
>No, this is correct and it is message boundary based. Idea of this
>patchset is to add extra boundaries marker which i think could be
>useful when we want to send data in seqpacket mode which length
>is bigger than maximum message length(this is limited by transport).
>Of course we can fragment big piece of data too small messages, but 
>this
>requires to carry fragmentation info in data protocol. So In this case
>when we want to maintain boundaries receiver calls recvmsg() until 
>MSG_EOR found.
>But when receiver knows, that data is fit in maximum datagram length,
>it doesn't care about checking MSG_EOR just calling recv() or 
>read()(e.g.
>message based mode).

I'm not sure we should maintain boundaries of multiple send(), from 
POSIX standard [1]:

   SOCK_SEQPACKET
     Provides sequenced, reliable, bidirectional, connection-mode 
     transmission paths for records. A record can be sent using one or 
     more output operations and received using one or more input 
     operations, but a single operation never transfers part of more than 
     one record. Record boundaries are visible to the receiver via the 
     MSG_EOR flag.

 From my understanding a record could be sent with multiple send() and 
received, for example, with a single recvmsg().
The only boundary should be the MSG_EOR flag set by the user on the last 
send() of a record.

 From send() description [2]:

   MSG_EOR
     Terminates a record (if supported by the protocol).

 From recvmsg() description [3]:

   MSG_EOR
     End-of-record was received (if supported by the protocol).

Thanks,
Stefano

[1] 
https://pubs.opengroup.org/onlinepubs/9699919799/functions/socket.html
[2] https://pubs.opengroup.org/onlinepubs/9699919799/functions/send.html
[3] 
https://pubs.opengroup.org/onlinepubs/9699919799/functions/recvmsg.html

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
