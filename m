Return-Path: <SRS0=XT4h=JK=lists.linux-foundation.org=virtualization-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 98147C433B4
	for <virtualization@archiver.kernel.org>; Tue, 13 Apr 2021 22:01:10 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id EBE0F61249
	for <virtualization@archiver.kernel.org>; Tue, 13 Apr 2021 22:01:09 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org EBE0F61249
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=bytedance.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=virtualization-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 8EA9440E73;
	Tue, 13 Apr 2021 22:01:09 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
	by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id QBdjmyWq1q-4; Tue, 13 Apr 2021 22:01:08 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp4.osuosl.org (Postfix) with ESMTP id 3A704406B9;
	Tue, 13 Apr 2021 22:01:07 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 00044C000B;
	Tue, 13 Apr 2021 22:01:06 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [IPv6:2605:bc80:3010::138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 17CA4C000A
 for <virtualization@lists.linux-foundation.org>;
 Tue, 13 Apr 2021 22:01:05 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id F0EE083B5C
 for <virtualization@lists.linux-foundation.org>;
 Tue, 13 Apr 2021 22:01:04 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp1.osuosl.org (amavisd-new);
 dkim=pass (2048-bit key) header.d=bytedance-com.20150623.gappssmtp.com
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id 4PC6YQtEqvU2
 for <virtualization@lists.linux-foundation.org>;
 Tue, 13 Apr 2021 22:01:02 +0000 (UTC)
X-Greylist: whitelisted by SQLgrey-1.8.0
Received: from mail-ot1-x335.google.com (mail-ot1-x335.google.com
 [IPv6:2607:f8b0:4864:20::335])
 by smtp1.osuosl.org (Postfix) with ESMTPS id A8EAE837D3
 for <virtualization@lists.linux-foundation.org>;
 Tue, 13 Apr 2021 22:01:02 +0000 (UTC)
Received: by mail-ot1-x335.google.com with SMTP id
 p6-20020a9d69460000b029028bb7c6ff64so1448369oto.10
 for <virtualization@lists.linux-foundation.org>;
 Tue, 13 Apr 2021 15:01:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=bytedance-com.20150623.gappssmtp.com; s=20150623;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=2Mv07gYex90Y+jTMkTCA6BFD2FEIzXH4kDM+8Hw4qnc=;
 b=C6Hdp1jwtyUv2Oyes9yWRd9B38R6DlHX7RIncjm23uM/WPj5Tp5EYQJhbq3XvW4zdO
 vGSL1qyJmpldcymqC28JNDh7F2hhdefWOgyfvJxEKBhQFuzewEVd/CWYeZWq3KyW+XaE
 74q+XecrBq7BIIpRzPxIr2JRrR6r7v/0ZyEBHkkVdX6a7rPQ4v+S8dkkkZzjMn5y+WhI
 F/VW6N2m2GSt7zWNvl+ZQMh7TivAiZuIwSbBWOEV2qFfE6G9hLmxZNj8MkvP9neYzq/D
 3br6PMsetvMlgB+PoKEy4Sp3KTsxQCjyjNpattSXAcs/YAaFppL4jsjv7nqx7KTWUgG0
 Y/zg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=2Mv07gYex90Y+jTMkTCA6BFD2FEIzXH4kDM+8Hw4qnc=;
 b=EpOnWn21vK/OFDghcN4/T4Zm0WnvN/Ds45kxNYj0O0AfgV7+QF5/BnYb+Q3hdnZvhK
 dMpAA829hSm91Uz8Qj+ZiW3uAqkIu+dAEXY70pUR8j2ZmMgLpkxFuI1fBmZT90+WZSEK
 QdY2pZ/pPPUNLpclT6vfgvlpHvrg+qJpLE4HBaBenAreZ/FQ2PZvW0ip/Zde8vvZA+Nh
 OZPS0mOJabAAcFVKuqOKGcmU0wD3zVK8hTY+4juH3tyzpRR6vQ1AaJ23e+43YxaVmuEh
 QXfWM05hT4O3A/IN2tw6t8HC0FUdDsaiyDICBCSWF4ruosQNRZTnwMXwHKQuYTkSXbGC
 0zsg==
X-Gm-Message-State: AOAM530FtUi04ZGyCTkp41kmMbVf5f8fpIPly6o5v1GjqV0qXFezM4kW
 ZIN0g4HC2n2sj3oR5UinH1qOomTM7BiYQsiCqsjzVA==
X-Google-Smtp-Source: ABdhPJwqBZkqJ4PwOG7Nnr1IEyhuBnjXD9qBCxVkUTRlbE3H5O92YBesrbaBJ7M4pnRbemHOVj6NeHyXYAtPENhtWz8=
X-Received: by 2002:a05:6830:1359:: with SMTP id
 r25mr7688666otq.180.1618351261215; 
 Tue, 13 Apr 2021 15:01:01 -0700 (PDT)
MIME-Version: 1.0
References: <20210401043602.3510538-1-jiang.wang@bytedance.com>
 <YHRQGSSnkN8Zipy0@stefanha-x1.localdomain>
 <20210412142133.t44pn5pjy6fdcvk4@steredhat>
 <CAP_N_Z9VPkBKX9QD+cuzSSAn6dL0cpQ=EZs5vk+ByjjDpGgdBA@mail.gmail.com>
 <20210413125853.2dkldmp23vkkc74c@steredhat>
 <20210413091251-mutt-send-email-mst@kernel.org>
 <20210413133852.ebkrlbyetiqu4uje@steredhat>
 <20210413094722-mutt-send-email-mst@kernel.org>
 <20210413140351.6vmffxqnj4azpyzx@steredhat>
 <20210413155635-mutt-send-email-mst@kernel.org>
In-Reply-To: <20210413155635-mutt-send-email-mst@kernel.org>
From: "Jiang Wang ." <jiang.wang@bytedance.com>
Date: Tue, 13 Apr 2021 15:00:50 -0700
Message-ID: <CAP_N_Z__jRGzr+aOoCAZZggroUN1iyPo7ydAkCX6SdFuHvbH-Q@mail.gmail.com>
Subject: Re: Re: [RFC v2] virtio-vsock: add description for datagram type
To: "Michael S. Tsirkin" <mst@redhat.com>
Cc: cong.wang@bytedance.com, Xiongchun Duan <duanxiongchun@bytedance.com>,
 cohuck@redhat.com, virtualization@lists.linux-foundation.org,
 xieyongji@bytedance.com, Stefan Hajnoczi <stefanha@redhat.com>,
 asias@redhat.com, Arseny Krasnov <arseny.krasnov@kaspersky.com>
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

On Tue, Apr 13, 2021 at 12:58 PM Michael S. Tsirkin <mst@redhat.com> wrote:
>
> On Tue, Apr 13, 2021 at 04:03:51PM +0200, Stefano Garzarella wrote:
> > On Tue, Apr 13, 2021 at 09:50:45AM -0400, Michael S. Tsirkin wrote:
> > > On Tue, Apr 13, 2021 at 03:38:52PM +0200, Stefano Garzarella wrote:
> > > > On Tue, Apr 13, 2021 at 09:16:50AM -0400, Michael S. Tsirkin wrote:
> > > > > On Tue, Apr 13, 2021 at 02:58:53PM +0200, Stefano Garzarella wrote:
> > > > > > On Mon, Apr 12, 2021 at 03:42:23PM -0700, Jiang Wang . wrote:
> > > > > > > On Mon, Apr 12, 2021 at 7:21 AM Stefano Garzarella <sgarzare@redhat.com> wrote:
> > > > > > > >
> > > > > > > > On Mon, Apr 12, 2021 at 02:50:17PM +0100, Stefan Hajnoczi wrote:
> > > > > > > > >On Thu, Apr 01, 2021 at 04:36:02AM +0000, jiang.wang wrote:
> > > > > > > > >> Add supports for datagram type for virtio-vsock. Datagram
> > > > > > > > >> sockets are connectionless and unreliable. To avoid contention
> > > > > > > > >> with stream and other sockets, add two more virtqueues and
> > > > > > > > >> a new feature bit to identify if those two new queues exist or not.
> > > > > > > > >>
> > > > > > > > >> Also add descriptions for resource management of datagram, which
> > > > > > > > >> does not use the existing credit update mechanism associated with
> > > > > > > > >> stream sockets.
> > > > > > > > >>
> > > > > > > > >> Signed-off-by: Jiang Wang <jiang.wang@bytedance.com>
> > > > > > > > >> ---
> > > > > > > > >> V2 addressed the comments for the previous version.
> > > > > > > > >>
> > > > > > > > >>  virtio-vsock.tex | 62 +++++++++++++++++++++++++++++++++++++++++++++++---------
> > > > > > > > >>  1 file changed, 52 insertions(+), 10 deletions(-)
> > > > > > > > >>
> > > > > > > > >> diff --git a/virtio-vsock.tex b/virtio-vsock.tex
> > > > > > > > >> index da7e641..62c12e0 100644
> > > > > > > > >> --- a/virtio-vsock.tex
> > > > > > > > >> +++ b/virtio-vsock.tex
> > > > > > > > >> @@ -11,12 +11,25 @@ \subsection{Virtqueues}\label{sec:Device Types / Socket Device / Virtqueues}
> > > > > > > > >>  \begin{description}
> > > > > > > > >>  \item[0] rx
> > > > > > > > >>  \item[1] tx
> > > > > > > > >> +\item[2] datagram rx
> > > > > > > > >> +\item[3] datagram tx
> > > > > > > > >> +\item[4] event
> > > > > > > > >> +\end{description}
> > > > > > > > >> +The virtio socket device uses 5 queues if feature bit VIRTIO_VSOCK_F_DRGAM is set. Otherwise, it
> > > > > > > > >> +only uses 3 queues, as the following. Rx and tx queues are always used for stream sockets.
> > > > > > > > >> +
> > > > > > > > >> +\begin{description}
> > > > > > > > >> +\item[0] rx
> > > > > > > > >> +\item[1] tx
> > > > > > > > >>  \item[2] event
> > > > > > > > >>  \end{description}
> > > > > > > > >>
> > > > > > > > >
> > > > > > > > >I suggest renaming "rx" and "tx" to "stream rx" and "stream tx"
> > > > > > > > >virtqueues and also adding this:
> > > > > > > > >
> > > > > > > > >  When behavior differs between stream and datagram rx/tx virtqueues
> > > > > > > > >  their full names are used. Common behavior is simply described in
> > > > > > > > >  terms of rx/tx virtqueues and applies to both stream and datagram
> > > > > > > > >  virtqueues.
> > > > > > > > >
> > > > > > > > >This way you won't need to duplicate portions of the spec that deal with
> > > > > > > > >populating the virtqueues, for example.
> > > > > > > > >
> > > > > > > > >It's also clearer to use a full name for stream rx/tx virtqueues instead
> > > > > > > > >of calling them rx/tx virtqueues now that we have datagram rx/tx
> > > > > > > > >virtqueues.
> > > > > > > > >
> > > > > > > > >> +
> > > > > > > > >>  \subsection{Feature bits}\label{sec:Device Types / Socket Device / Feature bits}
> > > > > > > > >>
> > > > > > > > >> -There are currently no feature bits defined for this device.
> > > > > > > > >> +\begin{description}
> > > > > > > > >> +\item[VIRTIO_VSOCK_F_DGRAM (0)] Device has support for datagram socket type.
> > > > > > > > >> +\end{description}
> > > > > > > > >>
> > > > > > > > >>  \subsection{Device configuration layout}\label{sec:Device Types / Socket Device / Device configuration layout}
> > > > > > > > >>
> > > > > > > > >> @@ -107,6 +120,9 @@ \subsection{Device Operation}\label{sec:Device Types / Socket Device / Device Op
> > > > > > > > >>
> > > > > > > > >>  \subsubsection{Virtqueue Flow Control}\label{sec:Device Types / Socket Device / Device Operation / Virtqueue Flow Control}
> > > > > > > > >>
> > > > > > > > >> +Flow control applies to stream sockets; datagram sockets do not have
> > > > > > > > >> +flow control.
> > > > > > > > >> +
> > > > > > > > >>  The tx virtqueue carries packets initiated by applications and replies to
> > > > > > > > >>  received packets.  The rx virtqueue carries packets initiated by the device and
> > > > > > > > >>  replies to previously transmitted packets.
> > > > > > > > >> @@ -140,12 +156,15 @@ \subsubsection{Addressing}\label{sec:Device Types / Socket Device / Device Opera
> > > > > > > > >>  consists of a (cid, port number) tuple. The header fields used for this are
> > > > > > > > >>  \field{src_cid}, \field{src_port}, \field{dst_cid}, and \field{dst_port}.
> > > > > > > > >>
> > > > > > > > >> -Currently only stream sockets are supported. \field{type} is 1 for stream
> > > > > > > > >> -socket types.
> > > > > > > > >> +Currently stream and datagram (dgram) sockets are supported. \field{type} is 1 for stream
> > > > > > > > >> +socket types. \field{type} is 3 for dgram socket types.
> > > > > > > > >>
> > > > > > > > >>  Stream sockets provide in-order, guaranteed, connection-oriented delivery
> > > > > > > > >>  without message boundaries.
> > > > > > > > >>
> > > > > > > > >> +Datagram sockets provide connectionless unreliable messages of
> > > > > > > > >> +a fixed maximum length.
> > > > > > > > >
> > > > > > > > >Plus unordered (?) and with message boundaries. In other words:
> > > > > > > > >
> > > > > > > > >  Datagram sockets provide unordered, unreliable, connectionless message
> > > > > > > > >  with message boundaries and a fixed maximum length.
> > > > > > > > >
> > > > > > > > >I didn't think of the fixed maximum length aspect before. I guess the
> > > > > > > > >intention is that the rx buffer size is the message size limit? That's
> > > > > > > > >different from UDP messages, which can be fragmented into multiple IP
> > > > > > > > >packets and can be larger than 64KiB:
> > > > > > > > >https://en.wikipedia.org/wiki/User_Datagram_Protocol#UDP_datagram_structure
> > > > > > > > >
> > > > > > > > >Is it possible to support large datagram messages in vsock? I'm a little
> > > > > > > > >concerned that applications that run successfully over UDP will not be
> > > > > > > > >portable if vsock has this limitation because it would impose extra
> > > > > > > > >message boundaries that the application protocol might not tolerate.
> > > > > > > >
> > > > > > > > Maybe we can reuse the same approach Arseny is using for SEQPACKET.
> > > > > > > > Fragment the packets according to the buffers in the virtqueue and set
> > > > > > > > the EOR flag to indicate the last packet in the message.
> > > > > > > >
> > > > > > > Agree. Another option is to use the ones for skb since we may need to
> > > > > > > use skbs for multiple transport support anyway.
> > > > > > >
> > > > > >
> > > > > > The important thing I think is to have a single flag in virtio-vsock that
> > > > > > identifies pretty much the same thing: this is the last fragment of a series
> > > > > > to rebuild a packet.
> > > > > >
> > > > > > We should reuse the same flag for DGRAM and SEQPACKET.
> > > > > >
> > > > > > Thanks,
> > > > > > Stefano
> > > > >
> > > > > Well DGRAM can drop data so I wonder whether it can work ...
> > > > >
> > > >
> > > > Yep, this is true, but the channel should not be losing packets, so if the
> > > > receiver discards packets, it knows that it must then discard all of them
> > > > until the EOR.
> > >
> > > That is not so easy - they can come mixed up from multiple sources.
> >
> > I think we can prevent mixing because virtuqueue is point to point and its
> > use is not thread safe, so the access (in the same peer) is already
> > serialized.
> > In the end the packet would be fragmented only before copying it to the
> > virtuqueue.
> >
> > But maybe I missed something...
>
> Well I ask what's the point of fragmenting then. I assume it's so we
> can pass huge messages around so you can't keep locks ...
>
I have a related question. How to determine the suitable size of a
fragment?  Unlike stream or seqpacket sockets, the datagram
sockets do not know the available recv buf of the listener. Eg.if the listener
free recv buf is 64KB, and the sender wants to send a 256KB packet, how
does the sender know what the fragment size is? One option is to
use some default  fragment size and try to send those fragments. But those
fragments could still be dropped by the receiver.

>
> > > Sure linux net core does this but with fragmentation added in,
> > > I start wondering whether you are beginning to reinvent the net stack
> > > ...
> >
> > No, I hope not :-), in the end our advantage is that we have a channel that
> > doesn't lose packets, so I guess we can make assumptions that the network
> > stack can't.
> >
> > Thanks,
> > Stefano
>
> I still don't know how will credit accounting work for datagram,
> but proposals I saw seem to actually lose packets ...

Yes, I agree that is a problem. In my mind, the accounting is
different from the credit mechanism used by the stream sockets.
The accounting is for the sender side only and the packets may
still be dropped at the receiving side if it is larger than the
available recv buf.


> --
> MST
>
_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
