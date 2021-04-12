Return-Path: <SRS0=TAdK=JJ=lists.linux-foundation.org=virtualization-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 08518C433B4
	for <virtualization@archiver.kernel.org>; Mon, 12 Apr 2021 14:21:47 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 83D3D61287
	for <virtualization@archiver.kernel.org>; Mon, 12 Apr 2021 14:21:46 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 83D3D61287
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=virtualization-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 50F9A60A93;
	Mon, 12 Apr 2021 14:21:46 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
	by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id 57Pxl2_QgRWj; Mon, 12 Apr 2021 14:21:45 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp3.osuosl.org (Postfix) with ESMTP id C5E11605ED;
	Mon, 12 Apr 2021 14:21:44 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id A9864C000B;
	Mon, 12 Apr 2021 14:21:44 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [IPv6:2605:bc80:3010::138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 92876C000A
 for <virtualization@lists.linux-foundation.org>;
 Mon, 12 Apr 2021 14:21:43 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id 8161183A43
 for <virtualization@lists.linux-foundation.org>;
 Mon, 12 Apr 2021 14:21:43 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp1.osuosl.org (amavisd-new);
 dkim=pass (1024-bit key) header.d=redhat.com
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id qJqCk-yYDJRn
 for <virtualization@lists.linux-foundation.org>;
 Mon, 12 Apr 2021 14:21:42 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [216.205.24.124])
 by smtp1.osuosl.org (Postfix) with ESMTPS id 6113B839CD
 for <virtualization@lists.linux-foundation.org>;
 Mon, 12 Apr 2021 14:21:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1618237301;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=fEoPCE5Zl95phw9Aa/pNBBcLpIsEAA3IfnkxVnAYhUE=;
 b=VuY9ggsgH8ouZh5buUHCpuei88ZHEZyjN4+W/Ay57+oYlArw8zggmtMMfoafqNt/Unjh3Y
 Ge6qRhxK/7lvN/PjLwiZZ4q7dbwJu7yLNZtUeCi6tIm1Ypp/y+aUE5QE/XBfl+GAgpyr7E
 jznXBzLPJQmiWWr6QYVProAJNqknezk=
Received: from mail-ed1-f70.google.com (mail-ed1-f70.google.com
 [209.85.208.70]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-339-_xm4iOMCPzWZM4FRcFVqqA-1; Mon, 12 Apr 2021 10:21:37 -0400
X-MC-Unique: _xm4iOMCPzWZM4FRcFVqqA-1
Received: by mail-ed1-f70.google.com with SMTP id b8so3332584ede.5
 for <virtualization@lists.linux-foundation.org>;
 Mon, 12 Apr 2021 07:21:37 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to;
 bh=fEoPCE5Zl95phw9Aa/pNBBcLpIsEAA3IfnkxVnAYhUE=;
 b=WkKQzTzaUK1FvVC4irRyF4hOx6emQPaiDFZ/6SMor58KHCJP2Ixy5xQe8qve/NnjAG
 7CQpt1+JOounq8mTa8XOtsBlgv/mM6eEPqMqsWZM6oOWMafCuFIsFpSqghRzqHuxx/hn
 qMVdwoCZxgrqdlBomgVo8JCKsqJsK13xuYJndWOOhZuh+bVubjvAT68M319VSA6RXMGB
 eQ9DVS+C7tOc0EZS/ZP24PfnPM2Zlw48CwW9XYYmgMGNTUykqFPjGcNZyFCcERLGw854
 cU0mzBIQZx60qqt87sL/1M4YaKzylPKuBuPwc/dQGfENb61WB/kVwm5Rqc1cOqegf8ia
 zsKg==
X-Gm-Message-State: AOAM533/+3x816KP/jglEHv8TdclsAO1cms4fasCVXI6A9TbddG6vkaG
 7L79gSHASUIln42rRSbIoldAan8R1bzLAJF3iXALE2F21c+AGT9soej6lG90afebT8B7sfLLdpE
 uk+5Y30Abl2GkUO1wh6J3isGMRojLP8+uEUXXxxbCIg==
X-Received: by 2002:a50:ec8c:: with SMTP id e12mr29776387edr.249.1618237296133; 
 Mon, 12 Apr 2021 07:21:36 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJw9gjDooSftNOYMYVbeeFqj4upNosMbVvtvf/bHPeEeMvHovM0k0H1e/7ERd8WhyHzQXEdnVg==
X-Received: by 2002:a50:ec8c:: with SMTP id e12mr29776369edr.249.1618237295964; 
 Mon, 12 Apr 2021 07:21:35 -0700 (PDT)
Received: from steredhat (host-79-34-249-199.business.telecomitalia.it.
 [79.34.249.199])
 by smtp.gmail.com with ESMTPSA id y21sm6785205edv.31.2021.04.12.07.21.35
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 12 Apr 2021 07:21:35 -0700 (PDT)
Date: Mon, 12 Apr 2021 16:21:33 +0200
From: Stefano Garzarella <sgarzare@redhat.com>
To: Stefan Hajnoczi <stefanha@redhat.com>
Subject: Re: [RFC v2] virtio-vsock: add description for datagram type
Message-ID: <20210412142133.t44pn5pjy6fdcvk4@steredhat>
References: <20210401043602.3510538-1-jiang.wang@bytedance.com>
 <YHRQGSSnkN8Zipy0@stefanha-x1.localdomain>
MIME-Version: 1.0
In-Reply-To: <YHRQGSSnkN8Zipy0@stefanha-x1.localdomain>
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=sgarzare@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Disposition: inline
Cc: cong.wang@bytedance.com, duanxiongchun@bytedance.com,
 "jiang.wang" <jiang.wang@bytedance.com>, mst@redhat.com, cohuck@redhat.com,
 virtualization@lists.linux-foundation.org, xieyongji@bytedance.com,
 asias@redhat.com, arseny.krasnov@kaspersky.com
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

On Mon, Apr 12, 2021 at 02:50:17PM +0100, Stefan Hajnoczi wrote:
>On Thu, Apr 01, 2021 at 04:36:02AM +0000, jiang.wang wrote:
>> Add supports for datagram type for virtio-vsock. Datagram
>> sockets are connectionless and unreliable. To avoid contention
>> with stream and other sockets, add two more virtqueues and
>> a new feature bit to identify if those two new queues exist or not.
>>
>> Also add descriptions for resource management of datagram, which
>> does not use the existing credit update mechanism associated with
>> stream sockets.
>>
>> Signed-off-by: Jiang Wang <jiang.wang@bytedance.com>
>> ---
>> V2 addressed the comments for the previous version.
>>
>>  virtio-vsock.tex | 62 +++++++++++++++++++++++++++++++++++++++++++++++---------
>>  1 file changed, 52 insertions(+), 10 deletions(-)
>>
>> diff --git a/virtio-vsock.tex b/virtio-vsock.tex
>> index da7e641..62c12e0 100644
>> --- a/virtio-vsock.tex
>> +++ b/virtio-vsock.tex
>> @@ -11,12 +11,25 @@ \subsection{Virtqueues}\label{sec:Device Types / Socket Device / Virtqueues}
>>  \begin{description}
>>  \item[0] rx
>>  \item[1] tx
>> +\item[2] datagram rx
>> +\item[3] datagram tx
>> +\item[4] event
>> +\end{description}
>> +The virtio socket device uses 5 queues if feature bit VIRTIO_VSOCK_F_DRGAM is set. Otherwise, it
>> +only uses 3 queues, as the following. Rx and tx queues are always used for stream sockets.
>> +
>> +\begin{description}
>> +\item[0] rx
>> +\item[1] tx
>>  \item[2] event
>>  \end{description}
>>
>
>I suggest renaming "rx" and "tx" to "stream rx" and "stream tx"
>virtqueues and also adding this:
>
>  When behavior differs between stream and datagram rx/tx virtqueues
>  their full names are used. Common behavior is simply described in
>  terms of rx/tx virtqueues and applies to both stream and datagram
>  virtqueues.
>
>This way you won't need to duplicate portions of the spec that deal with
>populating the virtqueues, for example.
>
>It's also clearer to use a full name for stream rx/tx virtqueues instead
>of calling them rx/tx virtqueues now that we have datagram rx/tx
>virtqueues.
>
>> +
>>  \subsection{Feature bits}\label{sec:Device Types / Socket Device / Feature bits}
>>
>> -There are currently no feature bits defined for this device.
>> +\begin{description}
>> +\item[VIRTIO_VSOCK_F_DGRAM (0)] Device has support for datagram socket type.
>> +\end{description}
>>
>>  \subsection{Device configuration layout}\label{sec:Device Types / Socket Device / Device configuration layout}
>>
>> @@ -107,6 +120,9 @@ \subsection{Device Operation}\label{sec:Device Types / Socket Device / Device Op
>>
>>  \subsubsection{Virtqueue Flow Control}\label{sec:Device Types / Socket Device / Device Operation / Virtqueue Flow Control}
>>
>> +Flow control applies to stream sockets; datagram sockets do not have
>> +flow control.
>> +
>>  The tx virtqueue carries packets initiated by applications and replies to
>>  received packets.  The rx virtqueue carries packets initiated by the device and
>>  replies to previously transmitted packets.
>> @@ -140,12 +156,15 @@ \subsubsection{Addressing}\label{sec:Device Types / Socket Device / Device Opera
>>  consists of a (cid, port number) tuple. The header fields used for this are
>>  \field{src_cid}, \field{src_port}, \field{dst_cid}, and \field{dst_port}.
>>
>> -Currently only stream sockets are supported. \field{type} is 1 for stream
>> -socket types.
>> +Currently stream and datagram (dgram) sockets are supported. \field{type} is 1 for stream
>> +socket types. \field{type} is 3 for dgram socket types.
>>
>>  Stream sockets provide in-order, guaranteed, connection-oriented delivery
>>  without message boundaries.
>>
>> +Datagram sockets provide connectionless unreliable messages of
>> +a fixed maximum length.
>
>Plus unordered (?) and with message boundaries. In other words:
>
>  Datagram sockets provide unordered, unreliable, connectionless message
>  with message boundaries and a fixed maximum length.
>
>I didn't think of the fixed maximum length aspect before. I guess the
>intention is that the rx buffer size is the message size limit? That's
>different from UDP messages, which can be fragmented into multiple IP
>packets and can be larger than 64KiB:
>https://en.wikipedia.org/wiki/User_Datagram_Protocol#UDP_datagram_structure
>
>Is it possible to support large datagram messages in vsock? I'm a little
>concerned that applications that run successfully over UDP will not be
>portable if vsock has this limitation because it would impose extra
>message boundaries that the application protocol might not tolerate.

Maybe we can reuse the same approach Arseny is using for SEQPACKET. 
Fragment the packets according to the buffers in the virtqueue and set 
the EOR flag to indicate the last packet in the message.

Thanks,
Stefano

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
