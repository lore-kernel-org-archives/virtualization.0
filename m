Return-Path: <SRS0=XT4h=JK=lists.linux-foundation.org=virtualization-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8F4F7C433ED
	for <virtualization@archiver.kernel.org>; Tue, 13 Apr 2021 14:04:04 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 40AEF61242
	for <virtualization@archiver.kernel.org>; Tue, 13 Apr 2021 14:04:04 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 40AEF61242
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=virtualization-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by smtp2.osuosl.org (Postfix) with ESMTP id D85EC405D1;
	Tue, 13 Apr 2021 14:04:03 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
	by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id wXcZa35JQj-w; Tue, 13 Apr 2021 14:04:02 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp2.osuosl.org (Postfix) with ESMTP id 16553400F5;
	Tue, 13 Apr 2021 14:04:02 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id E6B52C000C;
	Tue, 13 Apr 2021 14:04:01 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 082CAC000A
 for <virtualization@lists.linux-foundation.org>;
 Tue, 13 Apr 2021 14:04:00 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id EAF3C844BE
 for <virtualization@lists.linux-foundation.org>;
 Tue, 13 Apr 2021 14:03:59 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp1.osuosl.org (amavisd-new);
 dkim=pass (1024-bit key) header.d=redhat.com
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id XoRJw91hUe3y
 for <virtualization@lists.linux-foundation.org>;
 Tue, 13 Apr 2021 14:03:58 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [216.205.24.124])
 by smtp1.osuosl.org (Postfix) with ESMTPS id 8585384420
 for <virtualization@lists.linux-foundation.org>;
 Tue, 13 Apr 2021 14:03:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1618322637;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=HI2Zujwb9j5nTa8RRfSe0PnItP2kMGGTmComGwCTQ9s=;
 b=EIY+cu0RWh9pgj5NagCM167oQzZhH/7M+sRBfMoGSBdc0Jh0lL884zQR7WMmbHzKjsuOe4
 9bHf/Ggkm1pd76RCU5qCoVarWiiRefpkEI0bDoVTxvgMzgX8iuzVEZM4ggH2m/mCThhjnz
 dfNoekbBgVlzgLgaL/v7q2Qcv+EjI0s=
Received: from mail-ed1-f72.google.com (mail-ed1-f72.google.com
 [209.85.208.72]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-129-De201Av5OPuALAIx0egUYg-1; Tue, 13 Apr 2021 10:03:55 -0400
X-MC-Unique: De201Av5OPuALAIx0egUYg-1
Received: by mail-ed1-f72.google.com with SMTP id
 o4-20020a0564024384b0290378d45ecf57so1335846edc.12
 for <virtualization@lists.linux-foundation.org>;
 Tue, 13 Apr 2021 07:03:55 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to;
 bh=HI2Zujwb9j5nTa8RRfSe0PnItP2kMGGTmComGwCTQ9s=;
 b=PZRskJNCNtNhhghfDDuEzHfm+U5TE73PooSEK1tzp3KZ7JoGZe3GPCn7ZGQ5DtI/Zn
 TB9L/6xQb9cDb4HkxBwWwHKpaPxp2zwv7CTNw9l3nwaHppKGyzudy6GIuuHcxiUohRfG
 8WavKjL0T4JNlPWhFtWPtCYMlw13/i27x4W8d/ylQFPVB5IG6Ig1a1JJvNld71tOXM63
 tkO1kiYoe6iCdNnAtLxkqfR9CEwYx65idS6LxhwReW41yJshLu89vihu4ax0PTbq/uqK
 BAuRVS1BM4yqwlhBk7VVl4gGrzJjB7oKgvhvXKIwWHgajU82MXFYeBx6wapAMkwf26Bg
 JPlw==
X-Gm-Message-State: AOAM532LZRJRZacJ4Qje5QyowUDRIH5qHKtnRyNnGZyxX4k6b7VfPFt4
 9MAqDp12SQ1rL1g3q5g0TuSLyzy8j7RTuZXpWOvixZWeEM+tNlYp479IPMKT0Y83iY/QuzEdK20
 q/g1sOElB9erlChIkDb7GnjgcJefghPcrmB7fbnARiA==
X-Received: by 2002:a17:906:2808:: with SMTP id
 r8mr23899670ejc.140.1618322634073; 
 Tue, 13 Apr 2021 07:03:54 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJyywByiPtjWHdFXPsRIrruSxikwacsIuQJKKH4ZCxE9Mf9mTmkiNC2CQF6R2nYWn7w9vPdsdA==
X-Received: by 2002:a17:906:2808:: with SMTP id
 r8mr23899641ejc.140.1618322633867; 
 Tue, 13 Apr 2021 07:03:53 -0700 (PDT)
Received: from steredhat (host-79-34-249-199.business.telecomitalia.it.
 [79.34.249.199])
 by smtp.gmail.com with ESMTPSA id l9sm5357586ejz.96.2021.04.13.07.03.52
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 13 Apr 2021 07:03:53 -0700 (PDT)
Date: Tue, 13 Apr 2021 16:03:51 +0200
From: Stefano Garzarella <sgarzare@redhat.com>
To: "Michael S. Tsirkin" <mst@redhat.com>
Subject: Re: [RFC v2] virtio-vsock: add description for datagram type
Message-ID: <20210413140351.6vmffxqnj4azpyzx@steredhat>
References: <20210401043602.3510538-1-jiang.wang@bytedance.com>
 <YHRQGSSnkN8Zipy0@stefanha-x1.localdomain>
 <20210412142133.t44pn5pjy6fdcvk4@steredhat>
 <CAP_N_Z9VPkBKX9QD+cuzSSAn6dL0cpQ=EZs5vk+ByjjDpGgdBA@mail.gmail.com>
 <20210413125853.2dkldmp23vkkc74c@steredhat>
 <20210413091251-mutt-send-email-mst@kernel.org>
 <20210413133852.ebkrlbyetiqu4uje@steredhat>
 <20210413094722-mutt-send-email-mst@kernel.org>
MIME-Version: 1.0
In-Reply-To: <20210413094722-mutt-send-email-mst@kernel.org>
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

On Tue, Apr 13, 2021 at 09:50:45AM -0400, Michael S. Tsirkin wrote:
>On Tue, Apr 13, 2021 at 03:38:52PM +0200, Stefano Garzarella wrote:
>> On Tue, Apr 13, 2021 at 09:16:50AM -0400, Michael S. Tsirkin wrote:
>> > On Tue, Apr 13, 2021 at 02:58:53PM +0200, Stefano Garzarella wrote:
>> > > On Mon, Apr 12, 2021 at 03:42:23PM -0700, Jiang Wang . wrote:
>> > > > On Mon, Apr 12, 2021 at 7:21 AM Stefano Garzarella <sgarzare@redhat.com> wrote:
>> > > > >
>> > > > > On Mon, Apr 12, 2021 at 02:50:17PM +0100, Stefan Hajnoczi wrote:
>> > > > > >On Thu, Apr 01, 2021 at 04:36:02AM +0000, jiang.wang wrote:
>> > > > > >> Add supports for datagram type for virtio-vsock. Datagram
>> > > > > >> sockets are connectionless and unreliable. To avoid contention
>> > > > > >> with stream and other sockets, add two more virtqueues and
>> > > > > >> a new feature bit to identify if those two new queues exist or not.
>> > > > > >>
>> > > > > >> Also add descriptions for resource management of datagram, which
>> > > > > >> does not use the existing credit update mechanism associated with
>> > > > > >> stream sockets.
>> > > > > >>
>> > > > > >> Signed-off-by: Jiang Wang <jiang.wang@bytedance.com>
>> > > > > >> ---
>> > > > > >> V2 addressed the comments for the previous version.
>> > > > > >>
>> > > > > >>  virtio-vsock.tex | 62 +++++++++++++++++++++++++++++++++++++++++++++++---------
>> > > > > >>  1 file changed, 52 insertions(+), 10 deletions(-)
>> > > > > >>
>> > > > > >> diff --git a/virtio-vsock.tex b/virtio-vsock.tex
>> > > > > >> index da7e641..62c12e0 100644
>> > > > > >> --- a/virtio-vsock.tex
>> > > > > >> +++ b/virtio-vsock.tex
>> > > > > >> @@ -11,12 +11,25 @@ \subsection{Virtqueues}\label{sec:Device Types / Socket Device / Virtqueues}
>> > > > > >>  \begin{description}
>> > > > > >>  \item[0] rx
>> > > > > >>  \item[1] tx
>> > > > > >> +\item[2] datagram rx
>> > > > > >> +\item[3] datagram tx
>> > > > > >> +\item[4] event
>> > > > > >> +\end{description}
>> > > > > >> +The virtio socket device uses 5 queues if feature bit VIRTIO_VSOCK_F_DRGAM is set. Otherwise, it
>> > > > > >> +only uses 3 queues, as the following. Rx and tx queues are always used for stream sockets.
>> > > > > >> +
>> > > > > >> +\begin{description}
>> > > > > >> +\item[0] rx
>> > > > > >> +\item[1] tx
>> > > > > >>  \item[2] event
>> > > > > >>  \end{description}
>> > > > > >>
>> > > > > >
>> > > > > >I suggest renaming "rx" and "tx" to "stream rx" and "stream tx"
>> > > > > >virtqueues and also adding this:
>> > > > > >
>> > > > > >  When behavior differs between stream and datagram rx/tx virtqueues
>> > > > > >  their full names are used. Common behavior is simply described in
>> > > > > >  terms of rx/tx virtqueues and applies to both stream and datagram
>> > > > > >  virtqueues.
>> > > > > >
>> > > > > >This way you won't need to duplicate portions of the spec that deal with
>> > > > > >populating the virtqueues, for example.
>> > > > > >
>> > > > > >It's also clearer to use a full name for stream rx/tx virtqueues instead
>> > > > > >of calling them rx/tx virtqueues now that we have datagram rx/tx
>> > > > > >virtqueues.
>> > > > > >
>> > > > > >> +
>> > > > > >>  \subsection{Feature bits}\label{sec:Device Types / Socket Device / Feature bits}
>> > > > > >>
>> > > > > >> -There are currently no feature bits defined for this device.
>> > > > > >> +\begin{description}
>> > > > > >> +\item[VIRTIO_VSOCK_F_DGRAM (0)] Device has support for datagram socket type.
>> > > > > >> +\end{description}
>> > > > > >>
>> > > > > >>  \subsection{Device configuration layout}\label{sec:Device Types / Socket Device / Device configuration layout}
>> > > > > >>
>> > > > > >> @@ -107,6 +120,9 @@ \subsection{Device Operation}\label{sec:Device Types / Socket Device / Device Op
>> > > > > >>
>> > > > > >>  \subsubsection{Virtqueue Flow Control}\label{sec:Device Types / Socket Device / Device Operation / Virtqueue Flow Control}
>> > > > > >>
>> > > > > >> +Flow control applies to stream sockets; datagram sockets do not have
>> > > > > >> +flow control.
>> > > > > >> +
>> > > > > >>  The tx virtqueue carries packets initiated by applications and replies to
>> > > > > >>  received packets.  The rx virtqueue carries packets initiated by the device and
>> > > > > >>  replies to previously transmitted packets.
>> > > > > >> @@ -140,12 +156,15 @@ \subsubsection{Addressing}\label{sec:Device Types / Socket Device / Device Opera
>> > > > > >>  consists of a (cid, port number) tuple. The header fields used for this are
>> > > > > >>  \field{src_cid}, \field{src_port}, \field{dst_cid}, and \field{dst_port}.
>> > > > > >>
>> > > > > >> -Currently only stream sockets are supported. \field{type} is 1 for stream
>> > > > > >> -socket types.
>> > > > > >> +Currently stream and datagram (dgram) sockets are supported. \field{type} is 1 for stream
>> > > > > >> +socket types. \field{type} is 3 for dgram socket types.
>> > > > > >>
>> > > > > >>  Stream sockets provide in-order, guaranteed, connection-oriented delivery
>> > > > > >>  without message boundaries.
>> > > > > >>
>> > > > > >> +Datagram sockets provide connectionless unreliable messages of
>> > > > > >> +a fixed maximum length.
>> > > > > >
>> > > > > >Plus unordered (?) and with message boundaries. In other words:
>> > > > > >
>> > > > > >  Datagram sockets provide unordered, unreliable, connectionless message
>> > > > > >  with message boundaries and a fixed maximum length.
>> > > > > >
>> > > > > >I didn't think of the fixed maximum length aspect before. I guess the
>> > > > > >intention is that the rx buffer size is the message size limit? That's
>> > > > > >different from UDP messages, which can be fragmented into multiple IP
>> > > > > >packets and can be larger than 64KiB:
>> > > > > >https://en.wikipedia.org/wiki/User_Datagram_Protocol#UDP_datagram_structure
>> > > > > >
>> > > > > >Is it possible to support large datagram messages in vsock? I'm a little
>> > > > > >concerned that applications that run successfully over UDP will not be
>> > > > > >portable if vsock has this limitation because it would impose extra
>> > > > > >message boundaries that the application protocol might not tolerate.
>> > > > >
>> > > > > Maybe we can reuse the same approach Arseny is using for SEQPACKET.
>> > > > > Fragment the packets according to the buffers in the virtqueue and set
>> > > > > the EOR flag to indicate the last packet in the message.
>> > > > >
>> > > > Agree. Another option is to use the ones for skb since we may need to
>> > > > use skbs for multiple transport support anyway.
>> > > >
>> > >
>> > > The important thing I think is to have a single flag in virtio-vsock that
>> > > identifies pretty much the same thing: this is the last fragment of a series
>> > > to rebuild a packet.
>> > >
>> > > We should reuse the same flag for DGRAM and SEQPACKET.
>> > >
>> > > Thanks,
>> > > Stefano
>> >
>> > Well DGRAM can drop data so I wonder whether it can work ...
>> >
>>
>> Yep, this is true, but the channel should not be losing packets, so if the
>> receiver discards packets, it knows that it must then discard all of them
>> until the EOR.
>
>That is not so easy - they can come mixed up from multiple sources.

I think we can prevent mixing because virtuqueue is point to point and 
its use is not thread safe, so the access (in the same peer) is already 
serialized.
In the end the packet would be fragmented only before copying it to the 
virtuqueue.

But maybe I missed something...

>Sure linux net core does this but with fragmentation added in,
>I start wondering whether you are beginning to reinvent the net stack
>...

No, I hope not :-), in the end our advantage is that we have a channel 
that doesn't lose packets, so I guess we can make assumptions that the 
network stack can't.

Thanks,
Stefano

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
