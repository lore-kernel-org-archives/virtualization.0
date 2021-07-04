Return-Path: <SRS0=80gr=L4=lists.linux-foundation.org=virtualization-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CC163C07E9B
	for <virtualization@archiver.kernel.org>; Sun,  4 Jul 2021 09:54:42 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 7E9E661248
	for <virtualization@archiver.kernel.org>; Sun,  4 Jul 2021 09:54:42 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7E9E661248
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=virtualization-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by smtp2.osuosl.org (Postfix) with ESMTP id 3B365402C1;
	Sun,  4 Jul 2021 09:54:42 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
	by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id C6qFn1_s67oD; Sun,  4 Jul 2021 09:54:41 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp2.osuosl.org (Postfix) with ESMTPS id 8F0BD40001;
	Sun,  4 Jul 2021 09:54:40 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 6105AC001A;
	Sun,  4 Jul 2021 09:54:40 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [IPv6:2605:bc80:3010::136])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 6C768C000E
 for <virtualization@lists.linux-foundation.org>;
 Sun,  4 Jul 2021 09:54:39 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id 5989B60737
 for <virtualization@lists.linux-foundation.org>;
 Sun,  4 Jul 2021 09:54:39 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp3.osuosl.org (amavisd-new);
 dkim=pass (1024-bit key) header.d=redhat.com
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id 46uUTdaYrPHJ
 for <virtualization@lists.linux-foundation.org>;
 Sun,  4 Jul 2021 09:54:38 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [216.205.24.124])
 by smtp3.osuosl.org (Postfix) with ESMTPS id 4B1246072C
 for <virtualization@lists.linux-foundation.org>;
 Sun,  4 Jul 2021 09:54:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1625392476;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=VYPXgNYdb3c09oXqHPIxazq2MDtMHdph5d1ic1D1Bi8=;
 b=hu4Qn8oQ7Vk9HRFIRoKRhWEcu57eAc2nYE/E571CyiU7FQLtGxU1W87flSGDIdB4ikLDlE
 YXHbC3RZ7U3IWUTi64ELM0xGm3f1cn+nZEGMSHXOXQ+u8r8KV1REzDnf1dI1W+RjmifL17
 umvRdSQobi1XqxqUlvHGoDvUlVAGXHU=
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-121-dZGRRxXAP4-TIGOWXecT6g-1; Sun, 04 Jul 2021 05:54:35 -0400
X-MC-Unique: dZGRRxXAP4-TIGOWXecT6g-1
Received: by mail-wr1-f69.google.com with SMTP id
 x8-20020a5d54c80000b029012583535285so5421399wrv.8
 for <virtualization@lists.linux-foundation.org>;
 Sun, 04 Jul 2021 02:54:35 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to;
 bh=VYPXgNYdb3c09oXqHPIxazq2MDtMHdph5d1ic1D1Bi8=;
 b=fPKISynlLgmepjEd5HDnIB/Eor/D78OMpCWlM1lwZ1SknpAB/E3p8mEz+s3HwOoYUG
 Cm7YxHZ3+d5BWY361Q4MoDxffUL+JnIb1pOTcoRlQIU39/V2P/uWYVWVIVPC+B4r2Crw
 6M7BEwcObUd81eQCsgCHr/ic37FoqnRmbSypRWWYx4g+6hunIvNCVu/YIb7TbX7xej+u
 KlUx+qkkBAfgDnnhUNkdSi0r+E3/fXM8J5XVXMYxAtIMtLnR196iQx00nYRzX4fKGmgo
 /EVb3ojxfP1+oSo9hKWqQxi0962cTISpyVg5Y48NQG59KoiavLiJk9Zv8fPjadSLSVyv
 /n7Q==
X-Gm-Message-State: AOAM533hdjqJEC2W+OuuSGMr9hRkc6S1xbGyWkNr0zXIdNttNAbNepfw
 mGtilTMhEkiyF21jTJFGnQHcyYVtg4NVjdlrC/8CGpfQv/H7m9ua0KRM3yKDFnpLrM6eUv/iQZF
 zYJDdgPCYbuIBYpKz3ATNQ+5liMIAKIramssCW1K3Ww==
X-Received: by 2002:a7b:c8d9:: with SMTP id f25mr8743139wml.153.1625392474342; 
 Sun, 04 Jul 2021 02:54:34 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJyWmhMPJZJ9uEg3kxS9p3QQw859N5k7H/UO+tCXIvTNNDhdZj57iiThsIDoBtYfE9gIxTqrUg==
X-Received: by 2002:a7b:c8d9:: with SMTP id f25mr8743122wml.153.1625392474177; 
 Sun, 04 Jul 2021 02:54:34 -0700 (PDT)
Received: from redhat.com ([2.55.4.39])
 by smtp.gmail.com with ESMTPSA id c12sm10458200wrr.90.2021.07.04.02.54.31
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 04 Jul 2021 02:54:33 -0700 (PDT)
Date: Sun, 4 Jul 2021 05:54:29 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Arseny Krasnov <arseny.krasnov@kaspersky.com>
Subject: Re: [RFC PATCH v2 0/6] Improve SOCK_SEQPACKET receive logic
Message-ID: <20210704055037-mutt-send-email-mst@kernel.org>
References: <20210704080820.88746-1-arseny.krasnov@kaspersky.com>
 <20210704042843-mutt-send-email-mst@kernel.org>
 <b427dee7-5c1b-9686-9004-05fa05d45b28@kaspersky.com>
MIME-Version: 1.0
In-Reply-To: <b427dee7-5c1b-9686-9004-05fa05d45b28@kaspersky.com>
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=mst@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Disposition: inline
Cc: Andra Paraschiv <andraprs@amazon.com>,
 "kvm@vger.kernel.org" <kvm@vger.kernel.org>,
 "netdev@vger.kernel.org" <netdev@vger.kernel.org>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
 "virtualization@lists.linux-foundation.org"
 <virtualization@lists.linux-foundation.org>,
 "oxffffaa@gmail.com" <oxffffaa@gmail.com>,
 Norbert Slusarek <nslusarek@gmx.net>, Stefan Hajnoczi <stefanha@redhat.com>,
 Colin Ian King <colin.king@canonical.com>, Jakub Kicinski <kuba@kernel.org>,
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
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: virtualization-bounces@lists.linux-foundation.org
Sender: "Virtualization" <virtualization-bounces@lists.linux-foundation.org>

On Sun, Jul 04, 2021 at 12:23:03PM +0300, Arseny Krasnov wrote:
> 
> On 04.07.2021 11:30, Michael S. Tsirkin wrote:
> > On Sun, Jul 04, 2021 at 11:08:13AM +0300, Arseny Krasnov wrote:
> >> 	This patchset modifies receive logic for SOCK_SEQPACKET.
> >> Difference between current implementation and this version is that
> >> now reader is woken up when there is at least one RW packet in rx
> >> queue of socket and data is copied to user's buffer, while merged
> >> approach wake up user only when whole message is received and kept
> >> in queue. New implementation has several advantages:
> >>  1) There is no limit for message length. Merged approach requires
> >>     that length must be smaller than 'peer_buf_alloc', otherwise
> >>     transmission will stuck.
> >>  2) There is no need to keep whole message in queue, thus no
> >>     'kmalloc()' memory will be wasted until EOR is received.
> >>
> >>     Also new approach has some feature: as fragments of message
> >> are copied until EOR is received, it is possible that part of
> >> message will be already in user's buffer, while rest of message
> >> still not received. And if user will be interrupted by signal or
> >> timeout with part of message in buffer, it will exit receive loop,
> >> leaving rest of message in queue. To solve this problem special
> >> callback was added to transport: it is called when user was forced
> >> to leave exit loop and tells transport to drop any packet until
> >> EOR met.
> > Sorry about commenting late in the game.  I'm a bit lost
> >
> >
> > SOCK_SEQPACKET
> > Provides sequenced, reliable, bidirectional, connection-mode transmission paths for records. A record can be sent using one or more output operations and received using one or more input operations, but a single operation never transfers part of more than one record. Record boundaries are visible to the receiver via the MSG_EOR flag.
> >
> > it's supposed to be reliable - how is it legal to drop packets?
> 
> Sorry, seems i need to rephrase description. "Packet" here means fragment of record(message) at transport
> 
> layer. As this is SEQPACKET mode, receiver could get only whole message or error, so if only several fragments
> 
> of message was copied (if signal received for example) we can't return it to user - it breaks SEQPACKET sense. I think,
> 
> in this case we can drop rest of record's fragments legally.
> 
> 
> Thank You

Would not that violate the reliable property? IIUC it's only ok to
return an error if socket gets closed. Just like e.g. TCP ...



> >
> >
> >> When EOR is found, this mode is disabled and normal packet
> >> processing started. Note, that when 'drop until EOR' mode is on,
> >> incoming packets still inserted in queue, reader will be woken up,
> >> tries to copy data, but nothing will be copied until EOR found.
> >> It was possible to drain such unneeded packets it rx work without
> >> kicking user, but implemented way is simplest. Anyway, i think
> >> such cases are rare.
> >
> >>     New test also added - it tries to copy to invalid user's
> >> buffer.
> >>
> >> Arseny Krasnov (16):
> >>  af_vsock/virtio/vsock: change seqpacket receive logic
> >>  af_vsock/virtio/vsock: remove 'seqpacket_has_data' callback
> >>  virtio/vsock: remove 'msg_count' based logic
> >>  af_vsock/virtio/vsock: add 'seqpacket_drop()' callback
> >>  virtio/vsock: remove record size limit for SEQPACKET
> >>  vsock_test: SEQPACKET read to broken buffer
> >>
> >>  drivers/vhost/vsock.c                   |   2 +-
> >>  include/linux/virtio_vsock.h            |   7 +-
> >>  include/net/af_vsock.h                  |   4 +-
> >>  net/vmw_vsock/af_vsock.c                |  44 ++++----
> >>  net/vmw_vsock/virtio_transport.c        |   2 +-
> >>  net/vmw_vsock/virtio_transport_common.c | 103 ++++++++-----------
> >>  net/vmw_vsock/vsock_loopback.c          |   2 +-
> >>  tools/testing/vsock/vsock_test.c        | 120 ++++++++++++++++++++++
> >>  8 files changed, 193 insertions(+), 91 deletions(-)
> >>
> >>  v1 -> v2:
> >>  Patches reordered and reorganized.
> >>
> >> Signed-off-by: Arseny Krasnov <arseny.krasnov@kaspersky.com>
> >> ---
> >>  cv.txt | 0
> >>  1 file changed, 0 insertions(+), 0 deletions(-)
> >>  create mode 100644 cv.txt
> >>
> >> diff --git a/cv.txt b/cv.txt
> >> new file mode 100644
> >> index 000000000000..e69de29bb2d1
> >> -- 
> >> 2.25.1
> >

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
