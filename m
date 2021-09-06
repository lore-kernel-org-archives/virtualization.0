Return-Path: <SRS0=ZzT7=N4=lists.linux-foundation.org=virtualization-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ECA4CC433F5
	for <virtualization@archiver.kernel.org>; Mon,  6 Sep 2021 08:03:54 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id AABC360F43
	for <virtualization@archiver.kernel.org>; Mon,  6 Sep 2021 08:03:54 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org AABC360F43
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by smtp2.osuosl.org (Postfix) with ESMTP id 5E3CD40241;
	Mon,  6 Sep 2021 08:03:54 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
	by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id Pt_HUWJiUTkj; Mon,  6 Sep 2021 08:03:53 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp2.osuosl.org (Postfix) with ESMTPS id B0FD740180;
	Mon,  6 Sep 2021 08:03:52 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 87741C001C;
	Mon,  6 Sep 2021 08:03:52 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [IPv6:2605:bc80:3010::138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 1D789C001B
 for <virtualization@lists.linux-foundation.org>;
 Mon,  6 Sep 2021 08:03:51 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id EF74481771
 for <virtualization@lists.linux-foundation.org>;
 Mon,  6 Sep 2021 08:03:50 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp1.osuosl.org (amavisd-new);
 dkim=pass (1024-bit key) header.d=redhat.com
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id WCPdaqPv_xjH
 for <virtualization@lists.linux-foundation.org>;
 Mon,  6 Sep 2021 08:03:48 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.133.124])
 by smtp1.osuosl.org (Postfix) with ESMTPS id 05A1880DFA
 for <virtualization@lists.linux-foundation.org>;
 Mon,  6 Sep 2021 08:03:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1630915427;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=W2g1b9NX3P4QOnCtZSdNu+sJkQfvHZK6OJZ7BDJqDLg=;
 b=O7E8auYCwSb/u+8Z4sbADpBHr1kHQmmBxtW3N98XxQPVXLTMHUitknV9M2h5WN9pbdXLNv
 SaZFRihMhBdiliJdd18u1rxwLhUM8nVs5ojbKZmj01ad9aislA0F/NwL+0g+1UrpuNzOtq
 gL+bq7NGZj4GDt6SADFZLddBPnE2Y10=
Received: from mail-ed1-f72.google.com (mail-ed1-f72.google.com
 [209.85.208.72]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-386-Gh0_FuOkPX2AqacXuFH0PQ-1; Mon, 06 Sep 2021 04:03:45 -0400
X-MC-Unique: Gh0_FuOkPX2AqacXuFH0PQ-1
Received: by mail-ed1-f72.google.com with SMTP id
 y11-20020aa7d50b000000b003ca1ef38cf3so3297136edq.7
 for <virtualization@lists.linux-foundation.org>;
 Mon, 06 Sep 2021 01:03:45 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to;
 bh=W2g1b9NX3P4QOnCtZSdNu+sJkQfvHZK6OJZ7BDJqDLg=;
 b=suhTyQ8/VPqGdFSMRD6ewZBvGv6jeXDM7E/qAbSmN+hgWweSALvuUN3KrsUoNlq9iM
 uXEGkBeqS3D2OCi0G0laNL+VSwAp1bq5bQruXeHzYf/2MxisOkCe3ks80imKLDUPAj0Y
 JgRMKatj8QAiJCaqjQHXSRjbrKCO+Jz/daNAbGj9p4ZW2YhoE6gO5R5Z68mw6XdNXuGm
 WEJXV2pTLObOx9ZP5LPjQdRC8JpFbLTAszEpbwRJA+lBG8dz85I5WbSYg5zNZAQgpCx1
 9gKQhfcmgEzZ0YCKSJsf+zrMkd/jMjNNavNQwOQXinPgCH4RDkJvbJU6jZDtYbm5Gz/r
 fC6w==
X-Gm-Message-State: AOAM5337Dq5giz3sKEvXFVwBDkc/3LpXwcqwbcIpenTIEEHmM7cKbbiO
 5apkXKbQgPasJuIuqqG+IQj9majlyn68FfnOEl8nnpYoktFuFTJgez/S+hLCxnp+1YHzGr1V7cZ
 s3MoITo/ARiU5JosqTp+gtT0zQkBk1s+i/YycFj51/A==
X-Received: by 2002:a05:6402:148:: with SMTP id
 s8mr12049806edu.298.1630915424072; 
 Mon, 06 Sep 2021 01:03:44 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJxRJf9kq4wjR1PeMax4DOv0vHAJxFFvRjMlnKsmrmMvqdiz5jcTh29LDuagCJ7xkcWidZAWDA==
X-Received: by 2002:a05:6402:148:: with SMTP id
 s8mr12049783edu.298.1630915423910; 
 Mon, 06 Sep 2021 01:03:43 -0700 (PDT)
Received: from redhat.com ([2.55.131.183])
 by smtp.gmail.com with ESMTPSA id c25sm3423749ejm.9.2021.09.06.01.03.40
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 06 Sep 2021 01:03:43 -0700 (PDT)
Date: Mon, 6 Sep 2021 04:03:38 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Stefano Garzarella <sgarzare@redhat.com>
Subject: Re: [PATCH net-next v5 0/6] virtio/vsock: introduce MSG_EOR flag for
 SEQPACKET
Message-ID: <20210906040148-mutt-send-email-mst@kernel.org>
References: <20210903123016.3272800-1-arseny.krasnov@kaspersky.com>
 <20210905115139-mutt-send-email-mst@kernel.org>
 <4558e96b-6330-667f-955b-b689986f884f@kaspersky.com>
 <20210905121932-mutt-send-email-mst@kernel.org>
 <5b20410a-fb8f-2e38-59d9-74dc6b8a9d4f@kaspersky.com>
 <20210905161809-mutt-send-email-mst@kernel.org>
 <20210906073315.n7qgsv3gm7dasgzu@steredhat>
MIME-Version: 1.0
In-Reply-To: <20210906073315.n7qgsv3gm7dasgzu@steredhat>
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
 Arseny Krasnov <arseny.krasnov@kaspersky.com>,
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

On Mon, Sep 06, 2021 at 09:33:15AM +0200, Stefano Garzarella wrote:
> On Sun, Sep 05, 2021 at 04:18:52PM -0400, Michael S. Tsirkin wrote:
> > On Sun, Sep 05, 2021 at 07:21:10PM +0300, Arseny Krasnov wrote:
> > > 
> > > On 05.09.2021 19:19, Michael S. Tsirkin wrote:
> > > > On Sun, Sep 05, 2021 at 07:02:44PM +0300, Arseny Krasnov wrote:
> > > >> On 05.09.2021 18:55, Michael S. Tsirkin wrote:
> > > >>> On Fri, Sep 03, 2021 at 03:30:13PM +0300, Arseny Krasnov wrote:
> > > >>>> 	This patchset implements support of MSG_EOR bit for SEQPACKET
> > > >>>> AF_VSOCK sockets over virtio transport.
> > > >>>> 	First we need to define 'messages' and 'records' like this:
> > > >>>> Message is result of sending calls: 'write()', 'send()', 'sendmsg()'
> > > >>>> etc. It has fixed maximum length, and it bounds are visible using
> > > >>>> return from receive calls: 'read()', 'recv()', 'recvmsg()' etc.
> > > >>>> Current implementation based on message definition above.
> > > >>>> 	Record has unlimited length, it consists of multiple message,
> > > >>>> and bounds of record are visible via MSG_EOR flag returned from
> > > >>>> 'recvmsg()' call. Sender passes MSG_EOR to sending system call and
> > > >>>> receiver will see MSG_EOR when corresponding message will be processed.
> > > >>>> 	Idea of patchset comes from POSIX: it says that SEQPACKET
> > > >>>> supports record boundaries which are visible for receiver using
> > > >>>> MSG_EOR bit. So, it looks like MSG_EOR is enough thing for SEQPACKET
> > > >>>> and we don't need to maintain boundaries of corresponding send -
> > > >>>> receive system calls. But, for 'sendXXX()' and 'recXXX()' POSIX says,
> > > >>>> that all these calls operates with messages, e.g. 'sendXXX()' sends
> > > >>>> message, while 'recXXX()' reads messages and for SEQPACKET, 'recXXX()'
> > > >>>> must read one entire message from socket, dropping all out of size
> > > >>>> bytes. Thus, both message boundaries and MSG_EOR bit must be supported
> > > >>>> to follow POSIX rules.
> > > >>>> 	To support MSG_EOR new bit was added along with existing
> > > >>>> 'VIRTIO_VSOCK_SEQ_EOR': 'VIRTIO_VSOCK_SEQ_EOM'(end-of-message) - now it
> > > >>>> works in the same way as 'VIRTIO_VSOCK_SEQ_EOR'. But 'VIRTIO_VSOCK_SEQ_EOR'
> > > >>>> is used to mark 'MSG_EOR' bit passed from userspace.
> > > >>>> 	This patchset includes simple test for MSG_EOR.
> > > >>> I'm prepared to merge this for this window,
> > > >>> but I'm not sure who's supposed to ack the net/vmw_vsock/af_vsock.c
> > > >>> bits. It's a harmless variable renaming so maybe it does not matter.
> > > >>>
> > > >>> The rest is virtio stuff so I guess my tree is ok.
> > > >>>
> > > >>> Objections, anyone?
> > > >> https://lkml.org/lkml/2021/9/3/76 this is v4. It is same as v5 in af_vsock.c changes.
> > > >>
> > > >> It has Reviewed by from Stefano Garzarella.
> > > > Is Stefano the maintainer for af_vsock then?
> > > > I wasn't sure.
> 
> I'm maintaining virtio-vsock stuff, but I'm reviewing most of the af_vsock
> patches. We don't have an entry for it in MAINTAINERS, maybe we should.

Yea, please add that. And the test I guess?
It's now Dave and while he's great as we all know,
reducing the load on him is a good thing to do.

> > > Ack, let's wait for maintainer's comment
> > 
> > 
> > The specific patch is a trivial variable renaming so
> > I parked this in my tree for now, will merge unless I
> > hear any objections in the next couple of days.
> 
> I agree, I think your tree is fine, since this series is mostly about
> virtio-vsock.
> 
> Thanks,
> Stefano

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
