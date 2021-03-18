Return-Path: <SRS0=KYCx=IQ=lists.linux-foundation.org=virtualization-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C59E8C433E0
	for <virtualization@archiver.kernel.org>; Thu, 18 Mar 2021 17:59:40 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 48FD764EE2
	for <virtualization@archiver.kernel.org>; Thu, 18 Mar 2021 17:59:40 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 48FD764EE2
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=bytedance.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=virtualization-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by smtp2.osuosl.org (Postfix) with ESMTP id 0089D43291;
	Thu, 18 Mar 2021 17:59:40 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
	by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id 9wWTuLeUZFyO; Thu, 18 Mar 2021 17:59:38 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp2.osuosl.org (Postfix) with ESMTP id 2FB01400A4;
	Thu, 18 Mar 2021 17:59:38 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 10E35C000B;
	Thu, 18 Mar 2021 17:59:38 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 5FFF4C0001
 for <virtualization@lists.linux-foundation.org>;
 Thu, 18 Mar 2021 17:59:36 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id 46D8B43291
 for <virtualization@lists.linux-foundation.org>;
 Thu, 18 Mar 2021 17:59:36 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id Of3lYa9upNyj
 for <virtualization@lists.linux-foundation.org>;
 Thu, 18 Mar 2021 17:59:33 +0000 (UTC)
X-Greylist: whitelisted by SQLgrey-1.8.0
Received: from mail-ot1-x336.google.com (mail-ot1-x336.google.com
 [IPv6:2607:f8b0:4864:20::336])
 by smtp2.osuosl.org (Postfix) with ESMTPS id CB161400A4
 for <virtualization@lists.linux-foundation.org>;
 Thu, 18 Mar 2021 17:59:32 +0000 (UTC)
Received: by mail-ot1-x336.google.com with SMTP id
 31-20020a9d00220000b02901b64b9b50b1so6002104ota.9
 for <virtualization@lists.linux-foundation.org>;
 Thu, 18 Mar 2021 10:59:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=bytedance-com.20150623.gappssmtp.com; s=20150623;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=PQORW0k6aXBLez+6t/0qulwQK/VMX/+YA6XQBNyl4CI=;
 b=cYaUDXSW8EZiuPpL1Hzwj8CC6rKfy4SFCIowcClN9MI60zHe1I8xOJD0Dbgq/AjBrS
 q+pKbt6UN5kcott6WJNbwiRjZ0lnAIIb/FN2887jtqmz2BhYVoYO3aI752x3+LwVXh2m
 VHk4gz5USPwTZlMWN2FD6k3lnFsvL5OEVw+tsLPKxbWNsslQxxIYIf2+4hbCJM5KqKXV
 SX+WbgCyH54apJoGZhXc6b1b8bDOBX4qwJOoPT2K+vcOT87JelGbHzDtA/Vto+i5JqB1
 qMig7TsOCXT0AfMXdYOblZN1p/GEeovL4uDWy3RL0r/wuA87UHWdOOyaVwVupz2C/mTn
 GRGw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=PQORW0k6aXBLez+6t/0qulwQK/VMX/+YA6XQBNyl4CI=;
 b=Qw+5wSBSo1tMpATlv5YE5x7h7L+RRAp6oHb8QWsTU/JIRQ4YDKrw5AEonKA9wRwPcF
 gk0wNxc/+OzMEE2yEUrGt29FC7/EPgk+qfL4x70Qnc80dz/jlfhPbac26RHSMuYd++FE
 1pmhA+2K3IV/y/dzcEGz0Pi8ALXWWTw1AWBlKO0R/OWYHt/pwMW//sL6g5hbLWJoJvgI
 TT4jfqw/vggwajk6LWaUqMudaDzh9dzSdPxDgIiTnMZ1rxtvcLgESCBbel9JAWRUtAGl
 bY9Xd3JWv8+EHIO/jySb1JEr1X33UeH3dwnuxdsK/KY9+CKabSNLKinX6l48kY9zrHhr
 vjow==
X-Gm-Message-State: AOAM532AhsEHthOtuzMUs611WMPmxtirihDOal5OJQapwMdMMDud5JMX
 5XYbCYNI8Nh8WIjmo5mBCqRYjxtjMnXQAbJqPp598w==
X-Google-Smtp-Source: ABdhPJy96YZ7g5exdwtlhyPX0Kb1+E+aZLsSkYbBLxUMjA1YNmnerPra0CzkEm51YA5sNY3wPCeCRef0N4xnd2zwsjU=
X-Received: by 2002:a9d:ef1:: with SMTP id 104mr8114463otj.180.1616090371508; 
 Thu, 18 Mar 2021 10:59:31 -0700 (PDT)
MIME-Version: 1.0
References: <20210316215644.2254177-1-jiang.wang@bytedance.com>
 <YFIj+FQQzZmVAqWw@stefanha-x1.localdomain>
In-Reply-To: <YFIj+FQQzZmVAqWw@stefanha-x1.localdomain>
From: "Jiang Wang ." <jiang.wang@bytedance.com>
Date: Thu, 18 Mar 2021 10:59:20 -0700
Message-ID: <CAP_N_Z857fnkc4GejHt_t_nxnhXC60=S51i_XQ-AdgXO2NipFA@mail.gmail.com>
Subject: Re: [External] Re: [RFC PATCH] virtio-vsock: add description for
 datagram type
To: Stefan Hajnoczi <stefanha@redhat.com>
Cc: cong.wang@bytedance.com, Xiongchun Duan <duanxiongchun@bytedance.com>,
 "Michael S. Tsirkin" <mst@redhat.com>, cohuck@redhat.com,
 virtualization@lists.linux-foundation.org, xieyongji@bytedance.com,
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

On Wed, Mar 17, 2021 at 8:45 AM Stefan Hajnoczi <stefanha@redhat.com> wrote:
>
> On Tue, Mar 16, 2021 at 09:56:44PM +0000, jiang.wang wrote:
> > Add supports for datagram type for virtio-vsock. Datagram
> > sockets are connectionless and unreliable. To avoid contention
> > with stream and other sockets, add two more virtqueues and
> > a new feature bit to identify if those two new queues exist or not.
> >
> > Also add descriptions for resouce management of datagram, which
> > does not use the existing credit update mechanism associated with
> > stream sockets.
> >
> > Signed-off-by: Jiang Wang <jiang.wang@bytedance.com>
> > ---
> >  virtio-vsock.tex | 72 ++++++++++++++++++++++++++++++++++++++++++++++++--------
> >  1 file changed, 62 insertions(+), 10 deletions(-)
> >
> > diff --git a/virtio-vsock.tex b/virtio-vsock.tex
> > index da7e641..a2ff0a4 100644
> > --- a/virtio-vsock.tex
> > +++ b/virtio-vsock.tex
> > @@ -9,14 +9,27 @@ \subsection{Device ID}\label{sec:Device Types / Socket Device / Device ID}
> >
> >  \subsection{Virtqueues}\label{sec:Device Types / Socket Device / Virtqueues}
> >  \begin{description}
> > +\item[0] stream rx
> > +\item[1] stream tx
> > +\item[2] dgram rx
> > +\item[3] dgram tx
> > +\item[4] event
> > +\end{description}
> > +The virtio socket device uses 5 queues if feature bit VIRTIO_VSOCK_DRGAM is set. Otherwise, it
> > +only uses 3 queues, as the following.
> > +
> > +\begin{description}
> >  \item[0] rx
> >  \item[1] tx
> >  \item[2] event
> >  \end{description}
> >
> > +
> >  \subsection{Feature bits}\label{sec:Device Types / Socket Device / Feature bits}
> >
> > -There are currently no feature bits defined for this device.
> > +\begin{description}
> > +\item[VIRTIO_VSOCK_DGRAM (0)] Device has support for datagram sockets type.
> > +\end{description}
>
> By convention feature bits are named VIRTIO_<device>_F_<feature>. Please
> add the "_F_".
>
Sure.

> >
> >  \subsection{Device configuration layout}\label{sec:Device Types / Socket Device / Device configuration layout}
> >
> > @@ -76,6 +89,7 @@ \subsection{Device Operation}\label{sec:Device Types / Socket Device / Device Op
> >       le32 flags;
> >       le32 buf_alloc;
> >       le32 fwd_cnt;
> > +     le64 timestamp;
>
> Adding this field breaks old devices and drivers. Please make this field
> conditional on the dgram socket type or the VIRTIO_VSOCK_F_DGRAM feature
> bit.
>
> Also, are all the other fields still used with dgram sockets? Maybe you
> can use a union instead to reuse some space?

I will make this new field depending on the dgram socket type.

For the union idea, could I change the order of those fields? Dgram does not use
flags and fwd_cnt fields, and I want to put them together with a union
of a le64 timestamp.
Something like:

struct virtio_vsock_hdr {
  le64 src_cid;
  le64 dst_cid;
  le32 src_port;
  le32 dst_port;
  le32 len;
  le16 type;
  le16 op;
  le32 buf_alloc;
 union {
        struct {
              le32 flags;
              le32 fwd_cnt;
        } stream;
        le64 dgram_timestamp;
     } internal; // or a better name
};

> >  };
> >  \end{lstlisting}
> >
> > @@ -121,11 +135,14 @@ \subsubsection{Virtqueue Flow Control}\label{sec:Device Types / Socket Device /
> >  packets.  With additional resources, it becomes possible to process incoming
> >  packets even when outgoing packets cannot be sent.
> >
> > -Eventually even the additional resources will be exhausted and further
> > +For stream type, eventually even the additional resources will be exhausted and further
> >  processing is not possible until the other side processes the virtqueue that
> >  it has neglected.  This stop to processing prevents one side from causing
> >  unbounded resource consumption in the other side.
> >
> > +For datagram type, the additional resources have a fixed size limit to prevent
> > +unbounded resource consumption.
> > +
> >  \drivernormative{\paragraph}{Device Operation: Virtqueue Flow Control}{Device Types / Socket Device / Device Operation / Virtqueue Flow Control}
> >
> >  The rx virtqueue MUST be processed even when the tx virtqueue is full so long as there are additional resources available to hold packets outside the tx virtqueue.
> > @@ -140,12 +157,15 @@ \subsubsection{Addressing}\label{sec:Device Types / Socket Device / Device Opera
> >  consists of a (cid, port number) tuple. The header fields used for this are
> >  \field{src_cid}, \field{src_port}, \field{dst_cid}, and \field{dst_port}.
> >
> > -Currently only stream sockets are supported. \field{type} is 1 for stream
> > -socket types.
> > +Currently stream and datagram (dgram) sockets are supported. \field{type} is 1 for stream
> > +socket types. \field{type} is 3 for dgram socket types.
> >
> >  Stream sockets provide in-order, guaranteed, connection-oriented delivery
> >  without message boundaries.
> >
> > +Datagram socekts provide connectionless unreliable messages of
>
> s/socekts/sockets/
>
> > +a fixed maximum length.
> > +
> >  \subsubsection{Buffer Space Management}\label{sec:Device Types / Socket Device / Device Operation / Buffer Space Management}
> >  \field{buf_alloc} and \field{fwd_cnt} are used for buffer space management of
> >  stream sockets. The guest and the device publish how much buffer space is
> > @@ -170,20 +190,41 @@ \subsubsection{Buffer Space Management}\label{sec:Device Types / Socket Device /
> >  previously receiving a VIRTIO_VSOCK_OP_CREDIT_REQUEST packet. This allows
> >  communicating updates any time a change in buffer space occurs.
> >
> > +For datagram sockets, \field{buf_alloc} is also used on the rx side. Unlike stream
> > +sockets, dgram sockets do not use VIRTIO_VSOCK_OP_CREDIT_UPDATE or
> > +VIRTIO_VSOCK_OP_CREDIT_REQUEST packets. The dgram sender does not check if
> > +the \field{buf_alloc} of the peer is full or not. If it is full, the packet
> > +will be dropped. To limit resouce usage of the sender, \field{dgram_tx_bytes}
>
> s/resouce/resource/
>
> \field{dgram_tx_bytes} is not included in any struct definition?

dgram_tx_bytes is a field in struct vhost_vsock and virtio_vsock. But
I don't see them
mentioned in the spec.

> > +is used for each VM and host. Only payload bytes are counted and header bytes are not
>
> Please use the VIRTIO specification terms "driver" and "device" instead
> of VM and host.
Sure.

> It's not clear to me what "used" means. What exactly do the driver and
> device need to do?

In the  Linux and KVM case, I added the dgram_tx_bytes to vhost_vsock
and virtio_vsock.
Then in virtio_transport_send_pkt() and vhost_transport_send_pkt(),
the code will increase and check
dgram_tx_bytes first. If dgram_tx_bytes is no less than
VIRTIO_VSOCK_MAX_DGRAM_BUF_SIZE,
the function will free the pkt with virtio_transport_free_pkt() and
then return. The dgram_tx_bytes
is decreased in vhost_transport_do_send_pkt, just before each
virtio_transport_free_pkt() is called.
It is similar for the device case.

The goal is to limit the memory usage for the vsock. Since dgram does
not use credit, the sender
can send far more packets than the receiver can handle. If we don't
add the above check, the
sender can use lots of memory and cause OOM in the Linux kernel.

I am not sure if these details are too much for a spec or not. But I
think it will be good to
add some description. Or we can just say that the sender ( device or
the driver ) must not use
unlimited resources.


> > +included. If \field{dgram_tx_bytes} is equal to VIRTIO_VSOCK_MAX_DGRAM_BUF_SIZE,
> > +the send will fail.
>
> Does the device reject dgram packets or does the driver refuse to send
> more dgram packets?

The sender will drop the packets. This one is independent of the rx
side. If the device is the
sender, device will drop the packets. If the driver is the sender, the
driver will drop the packets.

> > +
> > +For dgram, since \field{dgram_tx_byte} is shared within a VM or host, a tx_timeout and
> > +a timer are used for each outgoing packet. If a packet is not delivered within
> > +tx_timeout, it will be dropped to make free space for other dgram sockets.
>
> What does this mean? Does the timeout cause the device to drop packets
> that haven't been handled yet (e.g. read by a host userspace process)?

This is on the sender side (regardless of the driver or the device ).
This  is similar to
above mentioned dgram_tx_bytes. Dgram_tx_bytes only makes sure if the memory
usage reaches a limit, the sender will not consume more memory. But
dgram_tx_bytes
is shared among different dgram sockets for a device or the driver, a
misbehave or
malicious dgram socket can potentially use all memory and block other
dgram sockets.
from sending any new packets. To handle this case,
the tx_timeout is used to free some space from the sender's memory pool, so that
other dgram sockets can continue to send some packets.

> POSIX Sockets have a receive socket buffer (rcvbuf) that is used for
> memory accounting and dropping packets. Operating systems implementing
> POSIX Sockets would use that to decide when incoming packets are
> dropped. It seems like dgram_tx_byte does something similar at the
> device level and I'm not sure why it's necessary?

dgram_tx_byte is for the tx (sender) side. The receive buffer you mentioned
is on the receiving side.

> In the POSIX Sockets model the virtio-vsock tx virtqueue is processed by
> the device and packets are read into socket rcvbuf. They do not stay in
> the virtqueue. This involves an extra data copy but it keeps the
> virtqueue as empty as possible so that further communication is
> possible.
> > +
> >  \drivernormative{\paragraph}{Device Operation: Buffer Space Management}{Device Types / Socket Device / Device Operation / Buffer Space Management}
> > -VIRTIO_VSOCK_OP_RW data packets MUST only be transmitted when the peer has
> > -sufficient free buffer space for the payload.
> > +For stream sockets, VIRTIO_VSOCK_OP_RW data packets MUST only be transmitted when the peer has
> > +sufficient free buffer space for the payload. For dgram sockets, VIRTIO_VSOCK_OP_RW data packets
> > +can be transmitted when the peer buffer is full. Then the pacekt will be dropped.
>
> s/can/MAY/
>
> s/pacekt/packet/
>
> "Then the packet will be dropped" is not clear to me. Is it saying the
> device drops packets when buffer space has exceeded?

Yes, see above replies.

> >
> >  All packets associated with a stream flow MUST contain valid information in
> >  \field{buf_alloc} and \field{fwd_cnt} fields.
> >
> > +All packets associated with a dgram flow MUST contain valid information in
> > +\field{timestamp} field, which will be used to check for tx timeout.
>
> What are the units of the timestamp field?

I am thinking about using jiffy in the Linux kernel. But for a more
generic virtio spec, maybe
we should use something more generic for the people not familiar with
Linux kernel?

> > +
> >  \devicenormative{\paragraph}{Device Operation: Buffer Space Management}{Device Types / Socket Device / Device Operation / Buffer Space Management}
> > -VIRTIO_VSOCK_OP_RW data packets MUST only be transmitted when the peer has
> > -sufficient free buffer space for the payload.
> > +For stream sockets, VIRTIO_VSOCK_OP_RW data packets MUST only be transmitted when the peer has
> > +sufficient free buffer space for the payload. For dgram sockets, VIRTIO_VSOCK_OP_RW data packets
> > +can be transmitted when the peer buffer is full. Then the pacekt will be dropped.
> >
> >  All packets associated with a stream flow MUST contain valid information in
> >  \field{buf_alloc} and \field{fwd_cnt} fields.
> >
> > +All packets associated with a dgram flow MUST contain valid information in
> > +\field{timestamp} field.
> > +
> >  \subsubsection{Receive and Transmit}\label{sec:Device Types / Socket Device / Device Operation / Receive and Transmit}
> >  The driver queues outgoing packets on the tx virtqueue and incoming packet
> >  receive buffers on the rx virtqueue. Packets are of the following form:
> > @@ -203,14 +244,14 @@ \subsubsection{Receive and Transmit}\label{sec:Device Types / Socket Device / De
> >  The \field{guest_cid} configuration field MUST be used as the source CID when
> >  sending outgoing packets.
> >
> > -A VIRTIO_VSOCK_OP_RST reply MUST be sent if a packet is received with an
> > +For stream socekts, A VIRTIO_VSOCK_OP_RST reply MUST be sent if a packet is received with an
> >  unknown \field{type} value.
> >
> >  \devicenormative{\paragraph}{Device Operation: Receive and Transmit}{Device Types / Socket Device / Device Operation / Receive and Transmit}
> >
> >  The \field{guest_cid} configuration field MUST NOT contain a reserved CID as listed in \ref{sec:Device Types / Socket Device / Device configuration layout}.
> >
> > -A VIRTIO_VSOCK_OP_RST reply MUST be sent if a packet is received with an
> > +For stream sockets, A VIRTIO_VSOCK_OP_RST reply MUST be sent if a packet is received with an
> >  unknown \field{type} value.
> >
> >  \subsubsection{Stream Sockets}\label{sec:Device Types / Socket Device / Device Operation / Stream Sockets}
> > @@ -240,6 +281,17 @@ \subsubsection{Stream Sockets}\label{sec:Device Types / Socket Device / Device O
> >  destination) address tuple for a new connection while the other peer is still
> >  processing the old connection.
> >
> > +\subsubsection{Datagram Sockets}\label{sec:Device Types / Socket Device / Device Operation / Stream Sockets}
> > +
> > +Datagram (dgram) sockets are connectionless and unreliable. The sender just send
> > +a message to the peer and hope it will be delivered. If there is no socket binds the
> > +address on the other end, or the transmision or receving buffers are full, the packets
> > +will be droped. Each packet may have a source cid and
>
> s/dropped/
>
> Please stick to UDP semantics as much as possible so that applications
> can be ported easily and developers aren't surprised by unexpected
> behavior. UDP packets sent to a destination that has no listen socket
> result in a Connection Refused error. vsock dgrams should behave in the
> same way.

Sure.Will do

> > +source port, the receiver can use them to send back a reply message.
>
> The VIRTIO specification avoids using the word "may" (as well as "must"
> and "should") outside the normative sections of the specification.
>
> It's unclear what this sentence means: can the driver set the source cid
> and source port to zero or an arbitary number if it does not need a
> reply? (I guess the answer is "no" but the sentence implies setting the
> source cid and source port is optional.)

Right, the driver should always set the source port correctly. Will fix it.

> > +
> > +Dgram sockets preserve the message boundaries. A message is either sent or dropped.
>
> What does "a message is either sent or dropped" mean? Does it mean
> messages are delivered once or not at all, but they are never
> duplicated?

Yes.

Thanks for all the comments. I will fix those spelling errors and use
a spell check
next time. I hope I answered all your questions. Please let me know if I missed
any questions or anything still not clear.
_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
