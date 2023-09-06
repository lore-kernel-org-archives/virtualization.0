Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D5B97EB8FD6
	for <virtualization@archiver.kernel.org>; Wed,  6 Sep 2023 14:28:28 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp2.osuosl.org (Postfix) with ESMTP id 288DA4150D;
	Wed,  6 Sep 2023 14:28:28 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org 288DA4150D
Authentication-Results: smtp2.osuosl.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=Fsti92pw
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
	by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id lIOQFoVKuQ6h; Wed,  6 Sep 2023 14:28:27 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp2.osuosl.org (Postfix) with ESMTPS id 4F896400B8;
	Wed,  6 Sep 2023 14:28:26 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org 4F896400B8
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 10FDAC0071;
	Wed,  6 Sep 2023 14:28:26 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [IPv6:2605:bc80:3010::136])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 56403C0032
 for <virtualization@lists.linux-foundation.org>;
 Wed,  6 Sep 2023 14:28:24 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id 305396076C
 for <virtualization@lists.linux-foundation.org>;
 Wed,  6 Sep 2023 14:28:24 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 305396076C
Authentication-Results: smtp3.osuosl.org;
 dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com
 header.a=rsa-sha256 header.s=mimecast20190719 header.b=Fsti92pw
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id Jh9v0XigAJ5P
 for <virtualization@lists.linux-foundation.org>;
 Wed,  6 Sep 2023 14:28:22 +0000 (UTC)
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.133.124])
 by smtp3.osuosl.org (Postfix) with ESMTPS id 89C72600C5
 for <virtualization@lists.linux-foundation.org>;
 Wed,  6 Sep 2023 14:28:22 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 89C72600C5
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1694010501;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=aHdVspGi7s+wvB5Iso+GOeNjG9LwQeHcnA9Ys8DT76I=;
 b=Fsti92pwFUrXukjBEYFSOd3JlyHvfZXN2MNYBXGVenKwJelQlj7/6Ga27LyJUgw8S9qPBv
 0YjnLYHDQAWKswQH61JaAUmhg7N1nz36FPdv62XhaBKiZ+8ZQglwtUiiMNFCVs3d0+54qV
 iTxexH/4JG8YLRSgePtMsZ06/IxEyRk=
Received: from mail-qv1-f70.google.com (mail-qv1-f70.google.com
 [209.85.219.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-316-KXNzDayoNdulGGv3vCC8OQ-1; Wed, 06 Sep 2023 10:28:17 -0400
X-MC-Unique: KXNzDayoNdulGGv3vCC8OQ-1
Received: by mail-qv1-f70.google.com with SMTP id
 6a1803df08f44-649832c0cf3so32718546d6.0
 for <virtualization@lists.linux-foundation.org>;
 Wed, 06 Sep 2023 07:28:17 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1694010497; x=1694615297;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=aHdVspGi7s+wvB5Iso+GOeNjG9LwQeHcnA9Ys8DT76I=;
 b=K7SZYpQpHpaNTU3j2dO+ZAnhq2VOMkA984agkuCPrKU3KbbyXCGeZKPcmG/BLkVhkB
 5bfqKWIK5Wew2kf7NGaOMaMGQFkcNM+osbu+7cKXmI/T8RT+aUdEcj0GvlcYEt8WwvyT
 dRV05VDm/5eVdC2ZA7raEBXPAvd0RDjzKyNhO6M0c8Ku7cRQy03nzolGikgfeqNAvVoE
 HJ/4fXT5XmtcXhOlzW8YiW21fKBT9xEXxd8Iad4TZg++8vJbBW8tiZccJN2X+/Pcj80b
 syjyqxZ5kX6ri0ARikYkQU/C59VQ1W4hh31wHtHm2HdZuTP6AzEqN313mwjOXzvLtpJc
 uBfQ==
X-Gm-Message-State: AOJu0YwdzVCxuuP16qD36K8KdC4Chiqbzw/baidyELzjFoM8+79mloQa
 VhwVHhKGbsIeGajYYVxniyAjEs9fH4VSMVOIMAdhsWfB+amnDzMDTFDLUYMyAB2mOszuUOj1pJc
 ytRdQYCq92ovaE7wKj+XX6vv8wZ5BwNvh/t2lI2rDJg==
X-Received: by 2002:a0c:e493:0:b0:64a:7da3:a700 with SMTP id
 n19-20020a0ce493000000b0064a7da3a700mr15502317qvl.20.1694010497113; 
 Wed, 06 Sep 2023 07:28:17 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGr50o8YS0XxnQ/09J921eumLo6lvaepN/VP09UlyPciN8m0FUlbx2hbhLHf4VnzsY19ma2Xw==
X-Received: by 2002:a0c:e493:0:b0:64a:7da3:a700 with SMTP id
 n19-20020a0ce493000000b0064a7da3a700mr15502294qvl.20.1694010496717; 
 Wed, 06 Sep 2023 07:28:16 -0700 (PDT)
Received: from sgarzare-redhat ([46.222.232.23])
 by smtp.gmail.com with ESMTPSA id
 b12-20020a0ccd0c000000b0064f59ca89basm5507285qvm.45.2023.09.06.07.28.14
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 06 Sep 2023 07:28:16 -0700 (PDT)
Date: Wed, 6 Sep 2023 16:28:12 +0200
From: Stefano Garzarella <sgarzare@redhat.com>
To: "Michael S. Tsirkin" <mst@redhat.com>
Subject: Re: [PATCH] virtio-vsock: add VIRTIO_VSOCK_F_DGRAM feature bit
Message-ID: <6hwqps3x554jcanr2i6kv7u4jmz3lfwcoesuyzxbr3sh3xsnd7@2embgkcj264f>
References: <20230829212945.3420727-1-bobby.eshleman@bytedance.com>
 <h6wtvcglyw55enk6shdogbfnw3m6zbmb4lv65uhznpwzqjw5sc@vc7clkjbxfep>
 <ZPLAip/TWqvWZ0hv@bullseye>
 <20230902043334-mutt-send-email-mst@kernel.org>
MIME-Version: 1.0
In-Reply-To: <20230902043334-mutt-send-email-mst@kernel.org>
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Disposition: inline
Cc: Bobby Eshleman <bobbyeshleman@gmail.com>, cong.wang@bytedance.com,
 Bobby Eshleman <bobby.eshleman@bytedance.com>, jiang.wang@bytedance.com,
 virtio-dev@lists.oasis-open.org, cohuck@redhat.com,
 virtualization@lists.linux-foundation.org, stefanha@redhat.com,
 virtio-comment@lists.oasis-open.org, arseny.krasnov@kaspersky.com
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

On Sat, Sep 02, 2023 at 04:35:25AM -0400, Michael S. Tsirkin wrote:
>On Sat, Sep 02, 2023 at 04:56:42AM +0000, Bobby Eshleman wrote:
>> On Fri, Sep 01, 2023 at 02:45:14PM +0200, Stefano Garzarella wrote:
>> > On Tue, Aug 29, 2023 at 09:29:45PM +0000, Bobby Eshleman wrote:
>> > > This adds support for datagrams to the virtio-vsock device.
>> > >
>> > > virtio-vsock already supports stream and seqpacket types. The existing
>> > > message types and header fields are extended to support datagrams.
>> > > Semantic differences between the flow types are stated, as well as any
>> > > additional requirements for devices and drivers implementing this
>> > > feature.
>> > >
>> > > Signed-off-by: Bobby Eshleman <bobby.eshleman@bytedance.com>
>> > > ---
>> > > device-types/vsock/description.tex | 95 +++++++++++++++++++++++++++---
>> > > 1 file changed, 88 insertions(+), 7 deletions(-)
>> > >
>> > > diff --git a/device-types/vsock/description.tex b/device-types/vsock/description.tex
>> > > index 7d91d159872f..638dca8e5da1 100644
>> > > --- a/device-types/vsock/description.tex
>> > > +++ b/device-types/vsock/description.tex
>> > > @@ -20,6 +20,7 @@ \subsection{Feature bits}\label{sec:Device Types / Socket Device / Feature bits}
>> > > \item[VIRTIO_VSOCK_F_STREAM (0)] stream socket type is supported.
>> > > \item[VIRTIO_VSOCK_F_SEQPACKET (1)] seqpacket socket type is supported.
>> > > \item[VIRTIO_VSOCK_F_NO_IMPLIED_STREAM (2)] stream socket type is not implied.
>> > > +\item[VIRTIO_VSOCK_F_DGRAM (3)] datagram socket type is supported.
>> > > \end{description}
>> > >
>> > > \drivernormative{\subsubsection}{Feature bits}{Device Types / Socket Device / Feature bits}
>> > > @@ -167,17 +168,22 @@ \subsubsection{Addressing}\label{sec:Device Types / Socket Device / Device Opera
>> > > consists of a (cid, port number) tuple. The header fields used for this are
>> > > \field{src_cid}, \field{src_port}, \field{dst_cid}, and \field{dst_port}.
>> > >
>> > > -Currently stream and seqpacket sockets are supported. \field{type} is 1 (VIRTIO_VSOCK_TYPE_STREAM)
>> > > -for stream socket types, and 2 (VIRTIO_VSOCK_TYPE_SEQPACKET) for seqpacket socket types.
>> > > +
>> > > +Currently stream, seqpacket, and datagram sockets are supported. \field{type} is
>> > > +1 (VIRTIO_VSOCK_TYPE_STREAM) for stream socket types, 2 (VIRTIO_VSOCK_TYPE_SEQPACKET) for
>> > > +seqpacket socket types, and 3 (VIRTIO_VSOCK_TYPE_DGRAM) for datagram socket types.
>> > >
>> > > \begin{lstlisting}
>> > > #define VIRTIO_VSOCK_TYPE_STREAM    1
>> > > #define VIRTIO_VSOCK_TYPE_SEQPACKET 2
>> > > +#define VIRTIO_VSOCK_TYPE_DGRAM     3
>> > > \end{lstlisting}
>> > >
>> > > Stream sockets provide in-order, guaranteed, connection-oriented delivery
>> > > without message boundaries. Seqpacket sockets provide in-order, guaranteed,
>> > > -connection-oriented delivery with message and record boundaries.
>> > > +connection-oriented delivery with message and record boundaries. Datagram
>> > > +sockets provide connection-less, best-effort delivery of messages, with no
>> > > +order or reliability guarantees.
>> > >
>> > > \subsubsection{Buffer Space Management}\label{sec:Device Types / Socket Device / Device Operation / Buffer Space Management}
>> > > \field{buf_alloc} and \field{fwd_cnt} are used for buffer space management of
>> > > @@ -203,16 +209,19 @@ \subsubsection{Buffer Space Management}\label{sec:Device Types / Socket Device /
>> > > previously receiving a VIRTIO_VSOCK_OP_CREDIT_REQUEST packet. This allows
>> > > communicating updates any time a change in buffer space occurs.
>> > >
>> > > +\field{buf_alloc} and \field{fwd_cnt} are reserved for future use by datagram
>> > > +sockets. These fields are not used for datagram buffer space management.
>> > > +
>> > > \drivernormative{\paragraph}{Device Operation: Buffer Space Management}{Device Types / Socket Device / Device Operation / Buffer Space Management}
>> > > -VIRTIO_VSOCK_OP_RW data packets MUST only be transmitted when the peer has
>> > > -sufficient free buffer space for the payload.
>> > > +For stream and seqpacket flows, VIRTIO_VSOCK_OP_RW data packets MUST only be
>> > > +transmitted when the peer has sufficient free buffer space for the payload.
>> > >
>> > > All packets associated with a stream flow MUST contain valid information in
>> > > \field{buf_alloc} and \field{fwd_cnt} fields.
>> > >
>> > > \devicenormative{\paragraph}{Device Operation: Buffer Space
>> > > Management}{Device Types / Socket Device / Device Operation / Buffer
>> > > Space Management}
>> > > -VIRTIO_VSOCK_OP_RW data packets MUST only be transmitted when the peer has
>> > > -sufficient free buffer space for the payload.
>> > > +For stream and seqpacket flows, VIRTIO_VSOCK_OP_RW data packets MUST only be
>> > > +transmitted when the peer has sufficient free buffer space for the payload.
>> > >
>> > > All packets associated with a stream flow MUST contain valid information in
>> > > \field{buf_alloc} and \field{fwd_cnt} fields.
>> > > @@ -299,6 +308,78 @@ \subsubsection{Seqpacket Sockets}\label{sec:Device Types / Socket Device / Devic
>> > > #define VIRTIO_VSOCK_SEQ_EOR (1 << 1)
>> > > \end{lstlisting}
>> > >
>> > > +\subsubsection{Datagram Sockets}\label{sec:Device Types / Socket Device / Device Operation / Datagram Sockets}
>> > > +
>> > > +\drivernormative{\paragraph}{Device Operation: Packet Fragmentation}{Device Types / Socket Device / Datagram Sockets / Fragmentation}
>> > > +
>> > > +Drivers MAY disassemble packets into smaller fragments. If drivers fragment a
>> > > +packet, they MUST follow the fragmentation rules described in section
>> > > +\ref{sec:Device Types / Socket Device / Device Operation / Datagram Sockets / Fragmentation}.
>> > > +
>> > > +Drivers MUST support assembly of received packet fragments according to the
>> > > +fragmentation rules described in section
>> > > +\ref{sec:Device Types / Socket Device / Device Operation / Datagram
>> > > Sockets / Fragmentation}.
>> > > +
>> > > +\devicenormative{\paragraph}{Device Operation: Packet Fragmentation}{Device Types / Socket Device / Datagram Sockets / Fragmentation}
>> > > +
>> > > +Devices MAY disassemble packets into smaller fragments. If devices fragment a
>> > > +packet, they MUST follow the fragmentation rules described in section
>> > > +\ref{sec:Device Types / Socket Device / Device Operation / Datagram Sockets / Fragmentation}.
>> > > +
>> > > +Devices MUST support assembly of received packet fragments according to the
>> > > +fragmentation rules described in section
>> > > +\ref{sec:Device Types / Socket Device / Device Operation / Datagram Sockets / Fragmentation}.
>> > > +
>> > > +\drivernormative{\paragraph}{Device Operation: Packet Dropping}{Device Types / Socket Device / Datagram Sockets / Dropping}
>> > > +
>> > > +The driver MAY drop received packets with no notification to the device. This
>> > > +can happen if, for example, there are insufficient resources or no socket
>> > > +exists for the destination address.
>> > > +
>> > > +\devicenormative{\paragraph}{Device Operation: Packet Dropping}{Device Types / Socket Device / Datagram Sockets / Dropping}
>> > > +
>> > > +The device MAY drop received packets with no notification to the driver. This
>> > > +can happen if, for example, there are insufficient resources or no socket
>> > > +exists for the destination address.
>> >
>> > Should we provide some notification if the socket does not exist at the
>> > destination?
>> >
>>
>> Yes, I think so. I believe a start/stop congestion notification scheme
>> actually manages this issue well.
>>
>> For example, the source begins sending packets to a destination.
>>
>> The destination finds that there exists no socket for that destination
>> address. The destination sends a "stop" notification to the source that
>> contains the address in question. Meanwhile, packets are still coming in
>> but they are being dropped.
>>
>> The source receives the "stop" notification with the address and adds it
>> to the "stopped destinations" list. Any new packet destination address
>> will be compared to that list. Any matches will be dropped before
>> sending (and ideally, before wasting time allocating the packet).
>>
>> Only when a socket is bound to an address that matches a "stopped"
>> address does the destination send a "start" notification to any source
>> it has previusly sent a "stop" notification to.

mmm, keeping the state forever could facilitate a DoS, perhaps we
should provide a timeout after which to try again

>>
>> Once "start" is received, flow may resume as normal.
>
>Again, dropping as control flow tactic has a bunch of problems.
>Blocking senders sounds more reasonable.

Yep, I think so.

>
>
>> > > +
>> > > +\paragraph{Datagram Fragmentation}\label{sec:Device Types / Socket Device / Device Operation / Datagram Sockets / Fragmentation}
>> > > +
>> > > +\field{flags} may have the following bit set:
>> > > +
>> > > +\begin{lstlisting}
>> > > +#define VIRTIO_VSOCK_DGRAM_EOM (1 << 0)
>> > > +\end{lstlisting}
>> > > +
>> > > +When the header \field{flags} field bit VIRTIO_VSOCK_DGRAM_EOM (bit 0) is set,
>> > > +it indicates that the current payload is the end of a datagram fragment
>> > > OR that
>> > > +the current payload is an entire datagram packet.
>> >
>> > In the destination, if we discard some fragments, then could we
>> > reconstruct a different datagram from the one sent?
>> >
>> > Is that anything acceptable?
>> >
>>
>> Dropping fragments should be explicitly disallowed. The sender is
>> explicitly disallowed from NOT placing fragments on the virtqueue, but I
>> see that I am missing the piece that states that they may not be dropped
>> on the receive side.
>>
>> I think it is worth mentioning that implicit in this spec is that
>> socket-to-socket dgram communication is unreliable, but device-to-driver
>> (and vice versa) is still reliable. That is, we can rely at least on the
>> virtqueues to work... and if they fail then the device/driver can simply
>> requeue (think send_pkt_queue in Linux)... so there is some reliability
>> at the lowest layer.

Yep, we should clarify this better.

Thanks,
Stefano

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
