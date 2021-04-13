Return-Path: <SRS0=XT4h=JK=lists.linux-foundation.org=virtualization-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1848BC433ED
	for <virtualization@archiver.kernel.org>; Tue, 13 Apr 2021 13:17:07 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id BCBC3613B1
	for <virtualization@archiver.kernel.org>; Tue, 13 Apr 2021 13:17:06 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BCBC3613B1
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=virtualization-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by smtp2.osuosl.org (Postfix) with ESMTP id 8D217401BA;
	Tue, 13 Apr 2021 13:17:06 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
	by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id ERQCioMPu8eO; Tue, 13 Apr 2021 13:17:03 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp2.osuosl.org (Postfix) with ESMTP id 84C3B400D7;
	Tue, 13 Apr 2021 13:17:02 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 40ECCC000B;
	Tue, 13 Apr 2021 13:17:02 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [IPv6:2605:bc80:3010::133])
 by lists.linuxfoundation.org (Postfix) with ESMTP id DA245C000A
 for <virtualization@lists.linux-foundation.org>;
 Tue, 13 Apr 2021 13:17:00 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id D60C6401BA
 for <virtualization@lists.linux-foundation.org>;
 Tue, 13 Apr 2021 13:17:00 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id jfErzoVUbVTt
 for <virtualization@lists.linux-foundation.org>;
 Tue, 13 Apr 2021 13:16:59 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [216.205.24.124])
 by smtp2.osuosl.org (Postfix) with ESMTPS id BF948400D7
 for <virtualization@lists.linux-foundation.org>;
 Tue, 13 Apr 2021 13:16:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1618319817;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=6sPiuDB+mVb3zJAm7jtrBdRSbvYlt3DoDiR/SpIZlyQ=;
 b=H5SdaawhafEeB8es56Kgsu3xDwEYObiY7pxzwOgS9PUNY+UQaDZ8mRNof1ym2Lo/6kBMkK
 YMfB6CU4wrzzCSX87nbVteRi2LtD/aVZryzO+hBC/dalgsp/G8LH535FUPWwEVx7Qan765
 qlqVjLQKSrdZK74eGfqpDGAbZb+0rTc=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-453-fBTjS_rWMl6aQmdjn3-BlQ-1; Tue, 13 Apr 2021 09:16:55 -0400
X-MC-Unique: fBTjS_rWMl6aQmdjn3-BlQ-1
Received: by mail-wm1-f70.google.com with SMTP id
 j187-20020a1c23c40000b0290127873d3384so2309571wmj.6
 for <virtualization@lists.linux-foundation.org>;
 Tue, 13 Apr 2021 06:16:55 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to;
 bh=6sPiuDB+mVb3zJAm7jtrBdRSbvYlt3DoDiR/SpIZlyQ=;
 b=b7GfaV/siM+Y90k2C5iUt1bDm+Kunh4Bx2H3aWEeG+zuDpLpDgRgQEqUnYflqAIXWB
 LMFUwfDKpL6GG20nDii+OJgsCgHuRRge8pVC1LgLx8I9LxSoasOnWm8LF+LETgViHS80
 mmPAFX1VNAXbAuSpAgNEBvK/C+uX9FSs/yWtHP4E8uIS2DmnqvnlDZwV6kJYZSVsZQJ+
 rFdFPTql9pw8YS9RDTUSVL3ok004F1rZPdtsQUKC8QWTEY5m+WjW8ooRCsWnXu3mHLxB
 jS5PKPtMkgg3nP/6zMy+iq59S34lSaYEZl1G5DIgX8vMnOp21pRWWxXT1YaUl/DqxuWA
 kl/Q==
X-Gm-Message-State: AOAM53138BjH7QVHbj8yHPmflXIgx8GCNNcffMz5dSa7NhMxmSWE7U9p
 F939MVPsDHNG2djygiwBPVvemfH85MWI2ur9uR5TQXovIsqV3bB28ecU7LenV4fZKoEOyPbxdXB
 bAPe9cEetrheiSmI+0H+WVLEsfJl/cNAy/DiI5JW+nQ==
X-Received: by 2002:a7b:c204:: with SMTP id x4mr4280781wmi.136.1618319814580; 
 Tue, 13 Apr 2021 06:16:54 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJwffjOaKajjPgz5o0BDyxu1oEFw4DqENcy8kJ3wdRzUKEBIdhJrHM05L4s5ijamKGec5HbOxQ==
X-Received: by 2002:a7b:c204:: with SMTP id x4mr4280761wmi.136.1618319814380; 
 Tue, 13 Apr 2021 06:16:54 -0700 (PDT)
Received: from redhat.com ([2a10:8006:2281:0:1994:c627:9eac:1825])
 by smtp.gmail.com with ESMTPSA id k7sm20573271wrw.64.2021.04.13.06.16.52
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 13 Apr 2021 06:16:53 -0700 (PDT)
Date: Tue, 13 Apr 2021 09:16:50 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Stefano Garzarella <sgarzare@redhat.com>
Subject: Re: [RFC v2] virtio-vsock: add description for datagram type
Message-ID: <20210413091251-mutt-send-email-mst@kernel.org>
References: <20210401043602.3510538-1-jiang.wang@bytedance.com>
 <YHRQGSSnkN8Zipy0@stefanha-x1.localdomain>
 <20210412142133.t44pn5pjy6fdcvk4@steredhat>
 <CAP_N_Z9VPkBKX9QD+cuzSSAn6dL0cpQ=EZs5vk+ByjjDpGgdBA@mail.gmail.com>
 <20210413125853.2dkldmp23vkkc74c@steredhat>
MIME-Version: 1.0
In-Reply-To: <20210413125853.2dkldmp23vkkc74c@steredhat>
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=mst@redhat.com
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
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: virtualization-bounces@lists.linux-foundation.org
Sender: "Virtualization" <virtualization-bounces@lists.linux-foundation.org>

On Tue, Apr 13, 2021 at 02:58:53PM +0200, Stefano Garzarella wrote:
> On Mon, Apr 12, 2021 at 03:42:23PM -0700, Jiang Wang . wrote:
> > On Mon, Apr 12, 2021 at 7:21 AM Stefano Garzarella <sgarzare@redhat.com> wrote:
> > > 
> > > On Mon, Apr 12, 2021 at 02:50:17PM +0100, Stefan Hajnoczi wrote:
> > > >On Thu, Apr 01, 2021 at 04:36:02AM +0000, jiang.wang wrote:
> > > >> Add supports for datagram type for virtio-vsock. Datagram
> > > >> sockets are connectionless and unreliable. To avoid contention
> > > >> with stream and other sockets, add two more virtqueues and
> > > >> a new feature bit to identify if those two new queues exist or not.
> > > >>
> > > >> Also add descriptions for resource management of datagram, which
> > > >> does not use the existing credit update mechanism associated with
> > > >> stream sockets.
> > > >>
> > > >> Signed-off-by: Jiang Wang <jiang.wang@bytedance.com>
> > > >> ---
> > > >> V2 addressed the comments for the previous version.
> > > >>
> > > >>  virtio-vsock.tex | 62 +++++++++++++++++++++++++++++++++++++++++++++++---------
> > > >>  1 file changed, 52 insertions(+), 10 deletions(-)
> > > >>
> > > >> diff --git a/virtio-vsock.tex b/virtio-vsock.tex
> > > >> index da7e641..62c12e0 100644
> > > >> --- a/virtio-vsock.tex
> > > >> +++ b/virtio-vsock.tex
> > > >> @@ -11,12 +11,25 @@ \subsection{Virtqueues}\label{sec:Device Types / Socket Device / Virtqueues}
> > > >>  \begin{description}
> > > >>  \item[0] rx
> > > >>  \item[1] tx
> > > >> +\item[2] datagram rx
> > > >> +\item[3] datagram tx
> > > >> +\item[4] event
> > > >> +\end{description}
> > > >> +The virtio socket device uses 5 queues if feature bit VIRTIO_VSOCK_F_DRGAM is set. Otherwise, it
> > > >> +only uses 3 queues, as the following. Rx and tx queues are always used for stream sockets.
> > > >> +
> > > >> +\begin{description}
> > > >> +\item[0] rx
> > > >> +\item[1] tx
> > > >>  \item[2] event
> > > >>  \end{description}
> > > >>
> > > >
> > > >I suggest renaming "rx" and "tx" to "stream rx" and "stream tx"
> > > >virtqueues and also adding this:
> > > >
> > > >  When behavior differs between stream and datagram rx/tx virtqueues
> > > >  their full names are used. Common behavior is simply described in
> > > >  terms of rx/tx virtqueues and applies to both stream and datagram
> > > >  virtqueues.
> > > >
> > > >This way you won't need to duplicate portions of the spec that deal with
> > > >populating the virtqueues, for example.
> > > >
> > > >It's also clearer to use a full name for stream rx/tx virtqueues instead
> > > >of calling them rx/tx virtqueues now that we have datagram rx/tx
> > > >virtqueues.
> > > >
> > > >> +
> > > >>  \subsection{Feature bits}\label{sec:Device Types / Socket Device / Feature bits}
> > > >>
> > > >> -There are currently no feature bits defined for this device.
> > > >> +\begin{description}
> > > >> +\item[VIRTIO_VSOCK_F_DGRAM (0)] Device has support for datagram socket type.
> > > >> +\end{description}
> > > >>
> > > >>  \subsection{Device configuration layout}\label{sec:Device Types / Socket Device / Device configuration layout}
> > > >>
> > > >> @@ -107,6 +120,9 @@ \subsection{Device Operation}\label{sec:Device Types / Socket Device / Device Op
> > > >>
> > > >>  \subsubsection{Virtqueue Flow Control}\label{sec:Device Types / Socket Device / Device Operation / Virtqueue Flow Control}
> > > >>
> > > >> +Flow control applies to stream sockets; datagram sockets do not have
> > > >> +flow control.
> > > >> +
> > > >>  The tx virtqueue carries packets initiated by applications and replies to
> > > >>  received packets.  The rx virtqueue carries packets initiated by the device and
> > > >>  replies to previously transmitted packets.
> > > >> @@ -140,12 +156,15 @@ \subsubsection{Addressing}\label{sec:Device Types / Socket Device / Device Opera
> > > >>  consists of a (cid, port number) tuple. The header fields used for this are
> > > >>  \field{src_cid}, \field{src_port}, \field{dst_cid}, and \field{dst_port}.
> > > >>
> > > >> -Currently only stream sockets are supported. \field{type} is 1 for stream
> > > >> -socket types.
> > > >> +Currently stream and datagram (dgram) sockets are supported. \field{type} is 1 for stream
> > > >> +socket types. \field{type} is 3 for dgram socket types.
> > > >>
> > > >>  Stream sockets provide in-order, guaranteed, connection-oriented delivery
> > > >>  without message boundaries.
> > > >>
> > > >> +Datagram sockets provide connectionless unreliable messages of
> > > >> +a fixed maximum length.
> > > >
> > > >Plus unordered (?) and with message boundaries. In other words:
> > > >
> > > >  Datagram sockets provide unordered, unreliable, connectionless message
> > > >  with message boundaries and a fixed maximum length.
> > > >
> > > >I didn't think of the fixed maximum length aspect before. I guess the
> > > >intention is that the rx buffer size is the message size limit? That's
> > > >different from UDP messages, which can be fragmented into multiple IP
> > > >packets and can be larger than 64KiB:
> > > >https://en.wikipedia.org/wiki/User_Datagram_Protocol#UDP_datagram_structure
> > > >
> > > >Is it possible to support large datagram messages in vsock? I'm a little
> > > >concerned that applications that run successfully over UDP will not be
> > > >portable if vsock has this limitation because it would impose extra
> > > >message boundaries that the application protocol might not tolerate.
> > > 
> > > Maybe we can reuse the same approach Arseny is using for SEQPACKET.
> > > Fragment the packets according to the buffers in the virtqueue and set
> > > the EOR flag to indicate the last packet in the message.
> > > 
> > Agree. Another option is to use the ones for skb since we may need to
> > use skbs for multiple transport support anyway.
> > 
> 
> The important thing I think is to have a single flag in virtio-vsock that
> identifies pretty much the same thing: this is the last fragment of a series
> to rebuild a packet.
> 
> We should reuse the same flag for DGRAM and SEQPACKET.
> 
> Thanks,
> Stefano

Well DGRAM can drop data so I wonder whether it can work ...

-- 
MST

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
