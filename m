Return-Path: <SRS0=XT4h=JK=lists.linux-foundation.org=virtualization-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1A1A4C433ED
	for <virtualization@archiver.kernel.org>; Tue, 13 Apr 2021 13:39:09 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A91E9613AB
	for <virtualization@archiver.kernel.org>; Tue, 13 Apr 2021 13:39:08 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A91E9613AB
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=virtualization-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 707596069B;
	Tue, 13 Apr 2021 13:39:08 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
	by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id kBV0_BJixPGq; Tue, 13 Apr 2021 13:39:07 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp3.osuosl.org (Postfix) with ESMTP id C583A605A3;
	Tue, 13 Apr 2021 13:39:06 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id A146AC000B;
	Tue, 13 Apr 2021 13:39:06 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 5D0B6C000A
 for <virtualization@lists.linux-foundation.org>;
 Tue, 13 Apr 2021 13:39:05 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id 4BB7F60698
 for <virtualization@lists.linux-foundation.org>;
 Tue, 13 Apr 2021 13:39:05 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id 0lLLYGo71HJ2
 for <virtualization@lists.linux-foundation.org>;
 Tue, 13 Apr 2021 13:39:04 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [216.205.24.124])
 by smtp3.osuosl.org (Postfix) with ESMTPS id D9537605A3
 for <virtualization@lists.linux-foundation.org>;
 Tue, 13 Apr 2021 13:39:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1618321142;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=ow0E9gpwyDaz2HOSh8HrKSuBBo6nWrLXHR3pkS5Q5Kk=;
 b=TRq2JLHMTgQO5zg8wWJnlBe6qVUsk7NOMvdoyQYe53Thyi0XSN70NvFtEwy5uSOxgL5zqh
 jUHj/kc3lfEafEoaUEwBThRiu+T2PHrfpIl8XpI5NRMvzhuv3qpXyiRAXpNEcKsVnm9E5O
 y3emRGSWczg9O1TSxOvMGlgnR1DbISE=
Received: from mail-ej1-f71.google.com (mail-ej1-f71.google.com
 [209.85.218.71]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-211-bgcosL3dNu-EwZ2wdN0Tag-1; Tue, 13 Apr 2021 09:38:57 -0400
X-MC-Unique: bgcosL3dNu-EwZ2wdN0Tag-1
Received: by mail-ej1-f71.google.com with SMTP id gn30so5059219ejc.3
 for <virtualization@lists.linux-foundation.org>;
 Tue, 13 Apr 2021 06:38:57 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to;
 bh=ow0E9gpwyDaz2HOSh8HrKSuBBo6nWrLXHR3pkS5Q5Kk=;
 b=gQcoiOBd/yGrgIwX5pizWjFOJcOiQTUVWqES+HDjuu0ujnO1QwK980ECddmDiQ/zbU
 KOdkZZa5lmU8WqKiuE/szsnocsYPK9MKL3/IAoSaoI+YqLAZ92IP1TVyV7Xf0oyH6oUI
 2dDF+OLjBTk/AghCGAuL0rlDKJRuokgboTyIDzMU42vU8yP8i64cUwrinPxUWZxqqlbL
 LVCN7i+M5+EEumQw99UPoXHjl/IPSrxsWz5c26cRbPr36vy5Bhz9etyV+bxJby2g1zi+
 TRybN/Wrtvqs2hxib2C3Ie0lcTLxAzKA+xYqUIIZYmO64J2QQDtB4GJ7DUJBi7pFHpu4
 1oBw==
X-Gm-Message-State: AOAM531BV+3kqm7hOGjtrtcI7Qxsy0HgI+dHjgzG9JX+3AtQIFe3sBQU
 QjW21FFtDhaEsDtTC6HI5UUhxX3de8AWLJKaeSrK0E/SlsCcEL4JAAHdFYsqKSSh/sDJKYiHWsD
 /ugKVblbSWZxfcxFaIaFJNfWEOzAI7XYCtHtKkY6k9g==
X-Received: by 2002:a50:f29a:: with SMTP id f26mr34846967edm.13.1618321136268; 
 Tue, 13 Apr 2021 06:38:56 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJzTqmdZe+r0njSZPJ+nmc8BeorKTzDbABQAP1cEwyVTXU+Tq0KJ409oqHxVfBJXDqj8Pw1SBA==
X-Received: by 2002:a50:f29a:: with SMTP id f26mr34846950edm.13.1618321136023; 
 Tue, 13 Apr 2021 06:38:56 -0700 (PDT)
Received: from steredhat (host-79-34-249-199.business.telecomitalia.it.
 [79.34.249.199])
 by smtp.gmail.com with ESMTPSA id n3sm7857824ejj.113.2021.04.13.06.38.55
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 13 Apr 2021 06:38:55 -0700 (PDT)
Date: Tue, 13 Apr 2021 15:38:52 +0200
From: Stefano Garzarella <sgarzare@redhat.com>
To: "Michael S. Tsirkin" <mst@redhat.com>
Subject: Re: [RFC v2] virtio-vsock: add description for datagram type
Message-ID: <20210413133852.ebkrlbyetiqu4uje@steredhat>
References: <20210401043602.3510538-1-jiang.wang@bytedance.com>
 <YHRQGSSnkN8Zipy0@stefanha-x1.localdomain>
 <20210412142133.t44pn5pjy6fdcvk4@steredhat>
 <CAP_N_Z9VPkBKX9QD+cuzSSAn6dL0cpQ=EZs5vk+ByjjDpGgdBA@mail.gmail.com>
 <20210413125853.2dkldmp23vkkc74c@steredhat>
 <20210413091251-mutt-send-email-mst@kernel.org>
MIME-Version: 1.0
In-Reply-To: <20210413091251-mutt-send-email-mst@kernel.org>
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=sgarzare@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Disposition: inline
Cc: cong.wang@bytedance.com, Xiongchun Duan <duanxiongchun@bytedance.com>,
 "Jiang Wang ." <jiang.wang@bytedance.com>, cohuck@redhat.com,
 virtualization@lists.linux-foundation.org, xieyongji@bytedance.com,
 Stefan Hajnoczi <stefanha@redhat.com>,
 Arseny Krasnov <arseny.krasnov@kaspersky.com>, asias@redhat.com
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

On Tue, Apr 13, 2021 at 09:16:50AM -0400, Michael S. Tsirkin wrote:
>On Tue, Apr 13, 2021 at 02:58:53PM +0200, Stefano Garzarella wrote:
>> On Mon, Apr 12, 2021 at 03:42:23PM -0700, Jiang Wang . wrote:
>> > On Mon, Apr 12, 2021 at 7:21 AM Stefano Garzarella <sgarzare@redhat.com> wrote:
>> > >
>> > > On Mon, Apr 12, 2021 at 02:50:17PM +0100, Stefan Hajnoczi wrote:
>> > > >On Thu, Apr 01, 2021 at 04:36:02AM +0000, jiang.wang wrote:
>> > > >> Add supports for datagram type for virtio-vsock. Datagram
>> > > >> sockets are connectionless and unreliable. To avoid contention
>> > > >> with stream and other sockets, add two more virtqueues and
>> > > >> a new feature bit to identify if those two new queues exist or not.
>> > > >>
>> > > >> Also add descriptions for resource management of datagram, which
>> > > >> does not use the existing credit update mechanism associated with
>> > > >> stream sockets.
>> > > >>
>> > > >> Signed-off-by: Jiang Wang <jiang.wang@bytedance.com>
>> > > >> ---
>> > > >> V2 addressed the comments for the previous version.
>> > > >>
>> > > >>  virtio-vsock.tex | 62 +++++++++++++++++++++++++++++++++++++++++++++++---------
>> > > >>  1 file changed, 52 insertions(+), 10 deletions(-)
>> > > >>
>> > > >> diff --git a/virtio-vsock.tex b/virtio-vsock.tex
>> > > >> index da7e641..62c12e0 100644
>> > > >> --- a/virtio-vsock.tex
>> > > >> +++ b/virtio-vsock.tex
>> > > >> @@ -11,12 +11,25 @@ \subsection{Virtqueues}\label{sec:Device Types / Socket Device / Virtqueues}
>> > > >>  \begin{description}
>> > > >>  \item[0] rx
>> > > >>  \item[1] tx
>> > > >> +\item[2] datagram rx
>> > > >> +\item[3] datagram tx
>> > > >> +\item[4] event
>> > > >> +\end{description}
>> > > >> +The virtio socket device uses 5 queues if feature bit VIRTIO_VSOCK_F_DRGAM is set. Otherwise, it
>> > > >> +only uses 3 queues, as the following. Rx and tx queues are always used for stream sockets.
>> > > >> +
>> > > >> +\begin{description}
>> > > >> +\item[0] rx
>> > > >> +\item[1] tx
>> > > >>  \item[2] event
>> > > >>  \end{description}
>> > > >>
>> > > >
>> > > >I suggest renaming "rx" and "tx" to "stream rx" and "stream tx"
>> > > >virtqueues and also adding this:
>> > > >
>> > > >  When behavior differs between stream and datagram rx/tx virtqueues
>> > > >  their full names are used. Common behavior is simply described in
>> > > >  terms of rx/tx virtqueues and applies to both stream and datagram
>> > > >  virtqueues.
>> > > >
>> > > >This way you won't need to duplicate portions of the spec that deal with
>> > > >populating the virtqueues, for example.
>> > > >
>> > > >It's also clearer to use a full name for stream rx/tx virtqueues instead
>> > > >of calling them rx/tx virtqueues now that we have datagram rx/tx
>> > > >virtqueues.
>> > > >
>> > > >> +
>> > > >>  \subsection{Feature bits}\label{sec:Device Types / Socket Device / Feature bits}
>> > > >>
>> > > >> -There are currently no feature bits defined for this device.
>> > > >> +\begin{description}
>> > > >> +\item[VIRTIO_VSOCK_F_DGRAM (0)] Device has support for datagram socket type.
>> > > >> +\end{description}
>> > > >>
>> > > >>  \subsection{Device configuration layout}\label{sec:Device Types / Socket Device / Device configuration layout}
>> > > >>
>> > > >> @@ -107,6 +120,9 @@ \subsection{Device Operation}\label{sec:Device Types / Socket Device / Device Op
>> > > >>
>> > > >>  \subsubsection{Virtqueue Flow Control}\label{sec:Device Types / Socket Device / Device Operation / Virtqueue Flow Control}
>> > > >>
>> > > >> +Flow control applies to stream sockets; datagram sockets do not have
>> > > >> +flow control.
>> > > >> +
>> > > >>  The tx virtqueue carries packets initiated by applications and replies to
>> > > >>  received packets.  The rx virtqueue carries packets initiated by the device and
>> > > >>  replies to previously transmitted packets.
>> > > >> @@ -140,12 +156,15 @@ \subsubsection{Addressing}\label{sec:Device Types / Socket Device / Device Opera
>> > > >>  consists of a (cid, port number) tuple. The header fields used for this are
>> > > >>  \field{src_cid}, \field{src_port}, \field{dst_cid}, and \field{dst_port}.
>> > > >>
>> > > >> -Currently only stream sockets are supported. \field{type} is 1 for stream
>> > > >> -socket types.
>> > > >> +Currently stream and datagram (dgram) sockets are supported. \field{type} is 1 for stream
>> > > >> +socket types. \field{type} is 3 for dgram socket types.
>> > > >>
>> > > >>  Stream sockets provide in-order, guaranteed, connection-oriented delivery
>> > > >>  without message boundaries.
>> > > >>
>> > > >> +Datagram sockets provide connectionless unreliable messages of
>> > > >> +a fixed maximum length.
>> > > >
>> > > >Plus unordered (?) and with message boundaries. In other words:
>> > > >
>> > > >  Datagram sockets provide unordered, unreliable, connectionless message
>> > > >  with message boundaries and a fixed maximum length.
>> > > >
>> > > >I didn't think of the fixed maximum length aspect before. I guess the
>> > > >intention is that the rx buffer size is the message size limit? That's
>> > > >different from UDP messages, which can be fragmented into multiple IP
>> > > >packets and can be larger than 64KiB:
>> > > >https://en.wikipedia.org/wiki/User_Datagram_Protocol#UDP_datagram_structure
>> > > >
>> > > >Is it possible to support large datagram messages in vsock? I'm a little
>> > > >concerned that applications that run successfully over UDP will not be
>> > > >portable if vsock has this limitation because it would impose extra
>> > > >message boundaries that the application protocol might not tolerate.
>> > >
>> > > Maybe we can reuse the same approach Arseny is using for SEQPACKET.
>> > > Fragment the packets according to the buffers in the virtqueue and set
>> > > the EOR flag to indicate the last packet in the message.
>> > >
>> > Agree. Another option is to use the ones for skb since we may need to
>> > use skbs for multiple transport support anyway.
>> >
>>
>> The important thing I think is to have a single flag in virtio-vsock that
>> identifies pretty much the same thing: this is the last fragment of a series
>> to rebuild a packet.
>>
>> We should reuse the same flag for DGRAM and SEQPACKET.
>>
>> Thanks,
>> Stefano
>
>Well DGRAM can drop data so I wonder whether it can work ...
>

Yep, this is true, but the channel should not be losing packets, so if 
the receiver discards packets, it knows that it must then discard all of 
them until the EOR.

If the transmitter has to discard a packet, actually that could be a 
problem...
We could provide another flag or a special packet to say that the rest 
of the packet won't arrive and so you have to discard it all.

Otherwise we need to go back to boundary packets as in the first 
implementation of SEQPACKET.

Stefano

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
