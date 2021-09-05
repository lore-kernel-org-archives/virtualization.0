Return-Path: <SRS0=SKE2=N3=lists.linux-foundation.org=virtualization-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8D04AC433EF
	for <virtualization@archiver.kernel.org>; Sun,  5 Sep 2021 20:19:08 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 20FFF60F4A
	for <virtualization@archiver.kernel.org>; Sun,  5 Sep 2021 20:19:08 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org 20FFF60F4A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id D929760672;
	Sun,  5 Sep 2021 20:19:07 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
	by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id QRbkTm-V81vM; Sun,  5 Sep 2021 20:19:07 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp3.osuosl.org (Postfix) with ESMTPS id 62CAF60613;
	Sun,  5 Sep 2021 20:19:06 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 37FEFC0010;
	Sun,  5 Sep 2021 20:19:06 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [IPv6:2605:bc80:3010::136])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 17F37C000E
 for <virtualization@lists.linux-foundation.org>;
 Sun,  5 Sep 2021 20:19:05 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id ED6C160614
 for <virtualization@lists.linux-foundation.org>;
 Sun,  5 Sep 2021 20:19:04 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id YRH1YdAcNgMj
 for <virtualization@lists.linux-foundation.org>;
 Sun,  5 Sep 2021 20:19:03 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.133.124])
 by smtp3.osuosl.org (Postfix) with ESMTPS id BA62D60613
 for <virtualization@lists.linux-foundation.org>;
 Sun,  5 Sep 2021 20:19:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1630873142;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=fQWW6TpVY//HFZs2vSUfOxyHJTX08YzLd3xkHk5EtPE=;
 b=gDHHWoQ/mdoJrXRrA2VRUOOssa237FPhqjve29w2HObJax97aCvB7mtRDJ30IfkizcSdoT
 rW+urlvvQgrPIuQmZOsuPbqpda+GlP7VIMkz/ob7CjwgnpoWYJaw6LEoDg2tbP9ooxIppg
 FzvUDfbLF+Y682Gfy4C7GUbjXZRLRAI=
Received: from mail-ej1-f69.google.com (mail-ej1-f69.google.com
 [209.85.218.69]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-520-XVQV5_N3PDyMaNKCXEJVBg-1; Sun, 05 Sep 2021 16:18:58 -0400
X-MC-Unique: XVQV5_N3PDyMaNKCXEJVBg-1
Received: by mail-ej1-f69.google.com with SMTP id
 x6-20020a170906710600b005c980192a39so1367500ejj.9
 for <virtualization@lists.linux-foundation.org>;
 Sun, 05 Sep 2021 13:18:58 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to;
 bh=fQWW6TpVY//HFZs2vSUfOxyHJTX08YzLd3xkHk5EtPE=;
 b=HpPHiw/EItVhlbiBb+M5XkxctJ9EDlxEA9goZJiGlyNxMEEHmRKA3oAdfhuC9uJ3jc
 8iMlibSg9P/few6JXNLw1BjSQg/y7BLp2m1wrbkecUK7dp+hdNtITzxeS/9iMcVJimPK
 p2nkiPTNoPGU4EEttXcpLzZpH+i0ZVUqJBZJwpwZHYLkwZiSDxmIt5+dC/Bu+Jr2pccw
 No9Enjc10QuX3td+B8FKNz31eiuaVBP59fhJKIPOKmx8DYZhXmAdEmfGPdllcE5tcLeO
 PNKo2t9f2qFouRLnXGjKsdx3umlmweMjx+4dyJy5C8JXDNMTupF8IrxBZuWt1XWN2S6Y
 n9sw==
X-Gm-Message-State: AOAM532I5A9fnJF/fEDuk1R6DF9uqrkrv7z3vqdoU5+asveV2wy/mAVl
 6x1wUpC2MMZwN4aeueuSN4RHh0/vZhGZUF8ALeQi9Yhcpl7ER0rZtitkpS1ycTGWaQwzRFxnmyQ
 6kcRmlZQAnMSkARM+069HTRpWk2SDuFUx2eEuJIozww==
X-Received: by 2002:a50:c31e:: with SMTP id a30mr9935805edb.123.1630873137568; 
 Sun, 05 Sep 2021 13:18:57 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJzZyj5klHOKXtKHJVij4O41tF6RVru9NpoUc9SoZ7Oi7i9goRlBONg0sRdXLSdPiSXG6ezXvw==
X-Received: by 2002:a50:c31e:: with SMTP id a30mr9935790edb.123.1630873137307; 
 Sun, 05 Sep 2021 13:18:57 -0700 (PDT)
Received: from redhat.com ([2.55.131.183])
 by smtp.gmail.com with ESMTPSA id k6sm3292620edv.77.2021.09.05.13.18.54
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 05 Sep 2021 13:18:56 -0700 (PDT)
Date: Sun, 5 Sep 2021 16:18:52 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Arseny Krasnov <arseny.krasnov@kaspersky.com>
Subject: Re: [PATCH net-next v5 0/6] virtio/vsock: introduce MSG_EOR flag for
 SEQPACKET
Message-ID: <20210905161809-mutt-send-email-mst@kernel.org>
References: <20210903123016.3272800-1-arseny.krasnov@kaspersky.com>
 <20210905115139-mutt-send-email-mst@kernel.org>
 <4558e96b-6330-667f-955b-b689986f884f@kaspersky.com>
 <20210905121932-mutt-send-email-mst@kernel.org>
 <5b20410a-fb8f-2e38-59d9-74dc6b8a9d4f@kaspersky.com>
MIME-Version: 1.0
In-Reply-To: <5b20410a-fb8f-2e38-59d9-74dc6b8a9d4f@kaspersky.com>
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=mst@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Disposition: inline
Cc: Andra Paraschiv <andraprs@amazon.com>,
 "kvm@vger.kernel.org" <kvm@vger.kernel.org>,
 "netdev@vger.kernel.org" <netdev@vger.kernel.org>,
 "stsp2@yandex.ru" <stsp2@yandex.ru>,
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
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: virtualization-bounces@lists.linux-foundation.org
Sender: "Virtualization" <virtualization-bounces@lists.linux-foundation.org>

On Sun, Sep 05, 2021 at 07:21:10PM +0300, Arseny Krasnov wrote:
> 
> On 05.09.2021 19:19, Michael S. Tsirkin wrote:
> > On Sun, Sep 05, 2021 at 07:02:44PM +0300, Arseny Krasnov wrote:
> >> On 05.09.2021 18:55, Michael S. Tsirkin wrote:
> >>> On Fri, Sep 03, 2021 at 03:30:13PM +0300, Arseny Krasnov wrote:
> >>>> 	This patchset implements support of MSG_EOR bit for SEQPACKET
> >>>> AF_VSOCK sockets over virtio transport.
> >>>> 	First we need to define 'messages' and 'records' like this:
> >>>> Message is result of sending calls: 'write()', 'send()', 'sendmsg()'
> >>>> etc. It has fixed maximum length, and it bounds are visible using
> >>>> return from receive calls: 'read()', 'recv()', 'recvmsg()' etc.
> >>>> Current implementation based on message definition above.
> >>>> 	Record has unlimited length, it consists of multiple message,
> >>>> and bounds of record are visible via MSG_EOR flag returned from
> >>>> 'recvmsg()' call. Sender passes MSG_EOR to sending system call and
> >>>> receiver will see MSG_EOR when corresponding message will be processed.
> >>>> 	Idea of patchset comes from POSIX: it says that SEQPACKET
> >>>> supports record boundaries which are visible for receiver using
> >>>> MSG_EOR bit. So, it looks like MSG_EOR is enough thing for SEQPACKET
> >>>> and we don't need to maintain boundaries of corresponding send -
> >>>> receive system calls. But, for 'sendXXX()' and 'recXXX()' POSIX says,
> >>>> that all these calls operates with messages, e.g. 'sendXXX()' sends
> >>>> message, while 'recXXX()' reads messages and for SEQPACKET, 'recXXX()'
> >>>> must read one entire message from socket, dropping all out of size
> >>>> bytes. Thus, both message boundaries and MSG_EOR bit must be supported
> >>>> to follow POSIX rules.
> >>>> 	To support MSG_EOR new bit was added along with existing
> >>>> 'VIRTIO_VSOCK_SEQ_EOR': 'VIRTIO_VSOCK_SEQ_EOM'(end-of-message) - now it
> >>>> works in the same way as 'VIRTIO_VSOCK_SEQ_EOR'. But 'VIRTIO_VSOCK_SEQ_EOR'
> >>>> is used to mark 'MSG_EOR' bit passed from userspace.
> >>>> 	This patchset includes simple test for MSG_EOR.
> >>> I'm prepared to merge this for this window,
> >>> but I'm not sure who's supposed to ack the net/vmw_vsock/af_vsock.c
> >>> bits. It's a harmless variable renaming so maybe it does not matter.
> >>>
> >>> The rest is virtio stuff so I guess my tree is ok.
> >>>
> >>> Objections, anyone?
> >> https://lkml.org/lkml/2021/9/3/76 this is v4. It is same as v5 in af_vsock.c changes.
> >>
> >> It has Reviewed by from Stefano Garzarella.
> > Is Stefano the maintainer for af_vsock then?
> > I wasn't sure.
> Ack, let's wait for maintainer's comment


The specific patch is a trivial variable renaming so
I parked this in my tree for now, will merge unless I
hear any objections in the next couple of days.

> >>>
> >>>>  Arseny Krasnov(6):
> >>>>   virtio/vsock: rename 'EOR' to 'EOM' bit.
> >>>>   virtio/vsock: add 'VIRTIO_VSOCK_SEQ_EOR' bit.
> >>>>   vhost/vsock: support MSG_EOR bit processing
> >>>>   virtio/vsock: support MSG_EOR bit processing
> >>>>   af_vsock: rename variables in receive loop
> >>>>   vsock_test: update message bounds test for MSG_EOR
> >>>>
> >>>>  drivers/vhost/vsock.c                   | 28 +++++++++++++----------
> >>>>  include/uapi/linux/virtio_vsock.h       |  3 ++-
> >>>>  net/vmw_vsock/af_vsock.c                | 10 ++++----
> >>>>  net/vmw_vsock/virtio_transport_common.c | 23 ++++++++++++-------
> >>>>  tools/testing/vsock/vsock_test.c        |  8 ++++++-
> >>>>  5 files changed, 45 insertions(+), 27 deletions(-)
> >>>>
> >>>>  v4 -> v5:
> >>>>  - Move bitwise and out of le32_to_cpu() in 0003.
> >>>>
> >>>>  v3 -> v4:
> >>>>  - 'sendXXX()' renamed to 'send*()' in 0002- commit msg.
> >>>>  - Comment about bit restore updated in 0003-.
> >>>>  - 'same' renamed to 'similar' in 0003- commit msg.
> >>>>  - u32 used instead of uint32_t in 0003-.
> >>>>
> >>>>  v2 -> v3:
> >>>>  - 'virtio/vsock: rename 'EOR' to 'EOM' bit.' - commit message updated.
> >>>>  - 'VIRTIO_VSOCK_SEQ_EOR' bit add moved to separate patch.
> >>>>  - 'vhost/vsock: support MSG_EOR bit processing' - commit message
> >>>>    updated.
> >>>>  - 'vhost/vsock: support MSG_EOR bit processing' - removed unneeded
> >>>>    'le32_to_cpu()', because input argument was already in CPU
> >>>>    endianness.
> >>>>
> >>>>  v1 -> v2:
> >>>>  - 'VIRTIO_VSOCK_SEQ_EOR' is renamed to 'VIRTIO_VSOCK_SEQ_EOM', to
> >>>>    support backward compatibility.
> >>>>  - use bitmask of flags to restore in vhost.c, instead of separated
> >>>>    bool variable for each flag.
> >>>>  - test for EAGAIN removed, as logically it is not part of this
> >>>>    patchset(will be sent separately).
> >>>>  - cover letter updated(added part with POSIX description).
> >>>>
> >>>> Signed-off-by: Arseny Krasnov <arseny.krasnov@kaspersky.com>
> >>>> -- 
> >>>> 2.25.1
> >

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
