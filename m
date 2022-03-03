Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 12598C433F5
	for <virtualization@archiver.kernel.org>; Thu,  3 Mar 2022 07:15:36 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id AA333415B3;
	Thu,  3 Mar 2022 07:15:36 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
	by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id GoSNYg23Xtms; Thu,  3 Mar 2022 07:15:35 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp4.osuosl.org (Postfix) with ESMTPS id 06FFE403C7;
	Thu,  3 Mar 2022 07:15:34 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id DA0E2C0012;
	Thu,  3 Mar 2022 07:15:34 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [IPv6:2605:bc80:3010::136])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 72397C000B
 for <virtualization@lists.linux-foundation.org>;
 Thu,  3 Mar 2022 07:15:34 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id 5967C60B66
 for <virtualization@lists.linux-foundation.org>;
 Thu,  3 Mar 2022 07:15:34 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp3.osuosl.org (amavisd-new);
 dkim=pass (1024-bit key) header.d=redhat.com
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id Ol9tFQ_rJc9v
 for <virtualization@lists.linux-foundation.org>;
 Thu,  3 Mar 2022 07:15:33 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.129.124])
 by smtp3.osuosl.org (Postfix) with ESMTPS id 2D2F160B65
 for <virtualization@lists.linux-foundation.org>;
 Thu,  3 Mar 2022 07:15:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1646291732;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=WSB8hB0bMHY663Butrt/qE43fhAgjQRyEqfwRmAlYIo=;
 b=UCSWZibiv/eB9TuFJh3Y+8m+eb/x3GChhcUR/4x9YMn6bOlQuRZ5OGgfSOxzZUXbYSHlNB
 fZ2I63VJyBkoj2Cribfvq8SZEKjPcciGrZpbPp1nFGiSjnvlr34wszp0bbFn/eTfLyDQYO
 JGjjzlXIJOKaKkdCxfDuCtWQQu03hsA=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-59-zTwA-nx7NfSPYzOakISUbA-1; Thu, 03 Mar 2022 02:15:30 -0500
X-MC-Unique: zTwA-nx7NfSPYzOakISUbA-1
Received: by mail-wm1-f69.google.com with SMTP id
 c62-20020a1c3541000000b003815245c642so2843406wma.6
 for <virtualization@lists.linux-foundation.org>;
 Wed, 02 Mar 2022 23:15:30 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to;
 bh=WSB8hB0bMHY663Butrt/qE43fhAgjQRyEqfwRmAlYIo=;
 b=wJTjvTCGjaSoYWbanH9m2VHPjYMkxKqNsA2IqmmeE6G7Sw5TEcYh0whsC/0IeL+Avj
 2z6+asgkd3+fXc/1lzdEOzuBEszLUWlFJ28ldLODEb011eJZAXInjlJ3X47woggZbwcd
 L6evznl6Clu/oNZh+eD5kGdJIWm+Rcz69dGSCOyUIrDCymqOLB6S1NCVRUBnANWNtDm2
 aIZFB2iQkqH5u/RZzwdgg6GWh4VYg/DVs8vSC+LTyX6FkBAHVIKteAgWjUjPZQLR0duD
 WSaopsMYkE9EX2cEcxS64+bECFMUzRO5Mk7hCOhHicAlpENkNzMvVx5mnZEXz6eWDBZ+
 Jgqw==
X-Gm-Message-State: AOAM533iG5yFGxTt6WoIs/mAHCKcUM1TSkxPi8olR3pwIFvSotvTvvUg
 eSDxToffh8xgkC5R5cVSlkejXo61sqM6V7jXm8OU6vZJTvZpfQu9vHkPyKvxsuuSr+x6/m5ZHWJ
 WfiwbioWqZQdrJPR3vXXSWDsJwY2tyQtT8hBmEvUI8g==
X-Received: by 2002:adf:b64c:0:b0:1e3:16d0:3504 with SMTP id
 i12-20020adfb64c000000b001e316d03504mr25806824wre.333.1646291729568; 
 Wed, 02 Mar 2022 23:15:29 -0800 (PST)
X-Google-Smtp-Source: ABdhPJyANDrNJHgNKmZzJqdZLJSSvMD1guwvuTZzm1xaIuemiEXj7OcN0AFOHlrfLxkWT2LxTTN26A==
X-Received: by 2002:adf:b64c:0:b0:1e3:16d0:3504 with SMTP id
 i12-20020adfb64c000000b001e316d03504mr25806798wre.333.1646291729271; 
 Wed, 02 Mar 2022 23:15:29 -0800 (PST)
Received: from redhat.com ([2.55.143.133]) by smtp.gmail.com with ESMTPSA id
 z5-20020a05600c0a0500b0037bb8df81a2sm10335362wmp.13.2022.03.02.23.15.26
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 02 Mar 2022 23:15:28 -0800 (PST)
Date: Thu, 3 Mar 2022 02:15:24 -0500
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Bobby Eshleman <beshleman.devbox@gmail.com>
Subject: Re: [virtio-comment] [PATCH v5 1/2] virtio-vsock: add description
 for datagram type
Message-ID: <20220303021413-mutt-send-email-mst@kernel.org>
References: <20210528040118.3253836-1-jiang.wang@bytedance.com>
 <20220224221547.2436395-1-beshleman.devbox@gmail.com>
 <20220224221547.2436395-2-beshleman.devbox@gmail.com>
 <20220302160958.62s34i2n2tccsscz@sgarzare-redhat>
 <20220303032801.yvlfu5vqqibu7eyo@ip-10-100-118-60.ec2.internal>
MIME-Version: 1.0
In-Reply-To: <20220303032801.yvlfu5vqqibu7eyo@ip-10-100-118-60.ec2.internal>
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=mst@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Disposition: inline
Cc: cong.wang@bytedance.com, duanxiongchun@bytedance.com,
 bobby.eshleman@bytedance.com, jiang.wang@bytedance.com, cohuck@redhat.com,
 virtualization@lists.linux-foundation.org, xieyongji@bytedance.com,
 chaiwen.cc@bytedance.com, stefanha@redhat.com,
 virtio-comment@lists.oasis-open.org, asias@redhat.com,
 arseny.krasnov@kaspersky.com, jhansen@vmware.com
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

On Thu, Mar 03, 2022 at 03:29:31AM +0000, Bobby Eshleman wrote:
> On Wed, Mar 02, 2022 at 05:09:58PM +0100, Stefano Garzarella wrote:
> > Hi Bobby,
> > Sorry for the delay, but I saw these patches today.
> > Please, can you keep me in CC?
> > 
> 
> Hey Stefano, sorry about that. I'm not sure how I lost your CC on this
> one. I'll make sure you are there moving forward.
> 
> I want to mention that I'm taking a look at
> https://gitlab.com/vsock/vsock/-/issues/1 in parallel with my dgram work
> here. After sending out this series we noticed potential overlap between
> the two issues. The additional dgram queues may become redundant if a
> fairness mechanism that solves issue #1 above also applies to
> connection-less protocols (similar to how the TC subsystem works). I've
> just begun sorting out potential solutions so no hard results yet. Just
> putting on your radar that the proposal here in v5 may be impacted if my
> investigation into issue #1 yields something adequate.


Well not mergeable, but datagram is upstream in Linux, is it not?
So we do want it in the spec IMHO, even if in the future there
will be a better protocol.

> > On Thu, Feb 24, 2022 at 10:15:46PM +0000, beshleman.devbox@gmail.com wrote:
> > > From: Jiang Wang <jiang.wang@bytedance.com>
> > > 
> 
> ... snip ...
> 
> > > 
> > > virtio-vsock.tex | 63 +++++++++++++++++++++++++++++++++++++++++++++++---------
> > > 1 file changed, 53 insertions(+), 10 deletions(-)
> > > 
> > > diff --git a/virtio-vsock.tex b/virtio-vsock.tex
> > > index d79984d..1a66a1b 100644
> > > --- a/virtio-vsock.tex
> > > +++ b/virtio-vsock.tex
> > > @@ -9,11 +9,26 @@ \subsection{Device ID}\label{sec:Device Types / Socket Device / Device ID}
> > > 
> > > \subsection{Virtqueues}\label{sec:Device Types / Socket Device / Virtqueues}
> > > \begin{description}
> > > -\item[0] rx
> > > -\item[1] tx
> > > +\item[0] stream rx
> > > +\item[1] stream tx
> > > +\item[2] datagram rx
> > > +\item[3] datagram tx
> > > +\item[4] event
> > > +\end{description}
> > > +The virtio socket device uses 5 queues if feature bit VIRTIO_VSOCK_F_DRGAM is set. Otherwise, it
> > > +only uses 3 queues, as the following.
> > 
> > We are also adding a new flag (VIRTIO_VSOCK_F_NO_IMPLIED_STREAM) to
> > provide the possibility to support for example only dgrams.
> > 
> > So I think we should consider the case where we have only DGRAM queues
> > (and it will be similar to the stream only case so 3 queues).
> > 
> > Maybe we could describe this part better and say that if we have both
> > STREAM (or SEQPACKET) and DGRAM set we have 5 queues, otherwise
> > only 3 queues.
> > 
> 
> Roger that.
> 
> > > \subsubsection{Buffer Space Management}\label{sec:Device Types / Socket Device / Device Operation / Buffer Space Management}
> > > \field{buf_alloc} and \field{fwd_cnt} are used for buffer space management of
> > > stream sockets. The guest and the device publish how much buffer space is
> > > @@ -170,7 +193,7 @@ \subsubsection{Buffer Space Management}\label{sec:Device Types / Socket Device /
> > > u32 peer_free = peer_buf_alloc - (tx_cnt - peer_fwd_cnt);
> > > \end{lstlisting}
> > > 
> > > -If there is insufficient buffer space, the sender waits until virtqueue buffers
> > > +For stream sockets, if there is insufficient buffer space, the sender waits until virtqueue buffers
> > 
> > stream and seqpacket
> > 
> > > are returned and checks \field{buf_alloc} and \field{fwd_cnt} again. Sending
> > > the VIRTIO_VSOCK_OP_CREDIT_REQUEST packet queries how much buffer space is
> > > available. The reply to this query is a VIRTIO_VSOCK_OP_CREDIT_UPDATE packet.
> > > @@ -178,22 +201,32 @@ \subsubsection{Buffer Space Management}\label{sec:Device Types / Socket Device /
> > > previously receiving a VIRTIO_VSOCK_OP_CREDIT_REQUEST packet. This allows
> > > communicating updates any time a change in buffer space occurs.
> > > 
> > > +Unlike stream sockets, dgram sockets do not use VIRTIO_VSOCK_OP_CREDIT_UPDATE
> > > +or VIRTIO_VSOCK_OP_CREDIT_REQUEST packets. The dgram buffer management is split
> > > +into two parts: senders and receivers. For senders, the packet is dropped if the
> > > +virtqueue is full. For receivers, the packet is dropped if there is no space
> > > +in the receive buffer.
> > > +
> > > \drivernormative{\paragraph}{Device Operation: Buffer Space Management}{Device Types / Socket Device / Device Operation / Buffer Space Management}
> > > -VIRTIO_VSOCK_OP_RW data packets MUST only be transmitted when the peer has
> > > -sufficient free buffer space for the payload.
> > > +For stream sockets, VIRTIO_VSOCK_OP_RW data packets MUST only be transmitted when the peer has
> > 
> > stream and seqpacket
> > 
> > > +sufficient free buffer space for the payload. For dgram sockets, VIRTIO_VSOCK_OP_RW data packets
> > > +MAY be transmitted when the peer rx buffer is full. Then the packet will be dropped by the peer,
> > > +and driver will not get any notification.
> > > 
> > > All packets associated with a stream flow MUST contain valid information in
> > > \field{buf_alloc} and \field{fwd_cnt} fields.
> > > 
> > > \devicenormative{\paragraph}{Device Operation: Buffer Space Management}{Device Types / Socket Device / Device Operation / Buffer Space Management}
> > > -VIRTIO_VSOCK_OP_RW data packets MUST only be transmitted when the peer has
> > > -sufficient free buffer space for the payload.
> > > +For stream sockets, VIRTIO_VSOCK_OP_RW data packets MUST only be transmitted when the peer has
> > 
> > stream and seqpacket
> > 
> 
> Roger that to all three instances above.
> 
> > > +sufficient free buffer space for the payload. For dgram sockets, VIRTIO_VSOCK_OP_RW data packets
> > > +MAY be transmitted when the peer rx buffer is full. Then the packet will be dropped by the peer,
> > > +and the device will not get any notification.
> > > 
> > > All packets associated with a stream flow MUST contain valid information in
> > > \field{buf_alloc} and \field{fwd_cnt} fields.
> > > 
> > > \subsubsection{Receive and Transmit}\label{sec:Device Types / Socket Device / Device Operation / Receive and Transmit}
> > > -The driver queues outgoing packets on the tx virtqueue and incoming packet
> > > +The driver queues outgoing packets on the tx virtqueue and allocates incoming packet
> > 
> > Is this change related?
> > 
> 
> I think we can remove this change.
> 
> 
> > > receive buffers on the rx virtqueue. Packets are of the following form:
> > > 
> > > \begin{lstlisting}
> > > @@ -206,6 +239,8 @@ \subsubsection{Receive and Transmit}\label{sec:Device Types / Socket Device / De
> > > Virtqueue buffers for outgoing packets are read-only. Virtqueue buffers for
> > > incoming packets are write-only.
> > > 
> > > +When transmitting packets to the device, \field{num_buffers} is not used.
> > > +
> > 
> > Leftover? Perhaps it should go in patch 2.
> > 
> 
> Ah yes, I thought I had the two well-separated but this snuck out from
> under me.
> 
> > > \drivernormative{\paragraph}{Device Operation: Receive and Transmit}{Device Types / Socket Device / Device Operation / Receive and Transmit}
> > > 
> > > The \field{guest_cid} configuration field MUST be used as the source CID when
> > > @@ -274,6 +309,14 @@ \subsubsection{Seqpacket Sockets}\label{sec:Device Types / Socket Device / Devic
> > > #define VIRTIO_VSOCK_SEQ_EOR (1 << 1)
> > > \end{lstlisting}
> > > 
> > > +\subsubsection{Datagram Sockets}\label{sec:Device Types / Socket Device / Device Operation / Datagram Sockets}
> > > +
> > > +Datagram (dgram) sockets are connectionless and unreliable. The sender just sends
> > > +a message to the peer and hopes it will be delivered. A VIRTIO_VSOCK_OP_RST reply is sent if
> > > +a receiving socket does not exist on the destination.
> > > +If the transmission or receiving buffers are full, the packets
> > > +are dropped.
> > > +
> > 
> > I'm not sure we should respond with RST if there's no socket bind on
> > the port.
> > 
> > What happens with UDP if we do a sendto to a closed port?
> > 
> > Thanks,
> > Stefano
> > 
> 
> With UDP this results in an ICMP Destination Unreachable message, which
> is explicitly not UDP but is experienced by the application nonetheless.
> There was some discussion from v1, and the design choice essentially
> came down to "how much do we want to be emulating of ICMP inside
> vsock?"
> 
> 
> - Bobby

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
