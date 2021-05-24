Return-Path: <SRS0=LFKT=KT=lists.linux-foundation.org=virtualization-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CA12CC04FF3
	for <virtualization@archiver.kernel.org>; Mon, 24 May 2021 11:29:19 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 7D34561153
	for <virtualization@archiver.kernel.org>; Mon, 24 May 2021 11:29:19 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7D34561153
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=virtualization-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 3C25683139;
	Mon, 24 May 2021 11:29:19 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
	by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id ZKdYgi55hi02; Mon, 24 May 2021 11:29:18 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp1.osuosl.org (Postfix) with ESMTP id D5048830A7;
	Mon, 24 May 2021 11:29:17 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id ADBCBC000E;
	Mon, 24 May 2021 11:29:17 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 094D6C0001
 for <virtualization@lists.linux-foundation.org>;
 Mon, 24 May 2021 11:29:16 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id EB378830A7
 for <virtualization@lists.linux-foundation.org>;
 Mon, 24 May 2021 11:29:15 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id ewYYjBPbzSTa
 for <virtualization@lists.linux-foundation.org>;
 Mon, 24 May 2021 11:29:14 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.133.124])
 by smtp1.osuosl.org (Postfix) with ESMTPS id A903783046
 for <virtualization@lists.linux-foundation.org>;
 Mon, 24 May 2021 11:29:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1621855753;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=bdwoDJvx6nyyrKAEQUkO/UbiPa0wBkzcARRH4uDNPS8=;
 b=UHFok8y6/iwahO5TANNwV8weZqDs4U2BeHj5DL4OX5nt864a47ngyrG3CAYVK7gP0qhX6Z
 9oZTtUHxczIktMdPNvY/f0cd9jQU2bgabdzJSu75k5B1qPOpPlLVYDi7HSjktRh4XX85Mr
 1LrVCMojF64YCOoTDhv8HwcbrhQ3fyY=
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-2-6JKFGOm7NLi0PUvcJj30FA-1; Mon, 24 May 2021 07:29:11 -0400
X-MC-Unique: 6JKFGOm7NLi0PUvcJj30FA-1
Received: by mail-wr1-f71.google.com with SMTP id
 i15-20020a5d558f0000b029011215b1cf5cso6586879wrv.22
 for <virtualization@lists.linux-foundation.org>;
 Mon, 24 May 2021 04:29:11 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:content-transfer-encoding
 :in-reply-to;
 bh=bdwoDJvx6nyyrKAEQUkO/UbiPa0wBkzcARRH4uDNPS8=;
 b=gQxt+r8Lv0FBauhr+1XF+96MFaFo6mpqVJnq6opc7vj+9DrjjHfA/54jWaLhJ1B27I
 n9uqjnxhnm26TOuoZRpd8n1Fi+y69QfyxwCLvpTkeKt1pmLuer+2aJ9UP9FwEdGSqOIN
 fwpCEpNATAl+HUdLUm/5LYnYMzP2QaO7TGeHLRZkkSqS6yEhkIX32zr2LxrffG45Y0QH
 ax5vgDcJuQB0SkVjyDp4PiU0s2KP5jvjh5B365/yPG5K6wibrLaVFBZCC8XkQDMzT/VE
 K3fua6Wtxgb1p3KWEW2lDeKh0BWgIVA2z75NoOXXv3nzOehbpQb3eaPHrtdpd71n74Yc
 DVPw==
X-Gm-Message-State: AOAM531kiBAclIwQC71MrA1dkZvIppGM639bq3qyNg5S520zCVwoo+vz
 4/IyGDbD+WP/vYxRjH8CWvWTZo6b2NO+4HJsM8yYgatpHs6cDeXVx/1zu2F7r27/MyWp1/jvjaP
 wvF3COleSgGe2tWazgaZwPK4p4M65NA7b4KMTRV9WbQ==
X-Received: by 2002:a1c:80d0:: with SMTP id b199mr5352544wmd.6.1621855750565; 
 Mon, 24 May 2021 04:29:10 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJwD0Lj8HUxQIPdKNjwHSG1dvaESqSL7EtMlk4wjFJ9C+j3FI5KHdRtBhD63kf563OPCDtnGEQ==
X-Received: by 2002:a1c:80d0:: with SMTP id b199mr5352533wmd.6.1621855750405; 
 Mon, 24 May 2021 04:29:10 -0700 (PDT)
Received: from redhat.com ([2a10:8006:fcda:0:90d:c7e7:9e26:b297])
 by smtp.gmail.com with ESMTPSA id v18sm14359624wro.18.2021.05.24.04.29.08
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 24 May 2021 04:29:09 -0700 (PDT)
Date: Mon, 24 May 2021 07:29:06 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Eugenio Perez Martin <eperezma@redhat.com>
Subject: Re: [RFC v3 00/29] vDPA software assisted live migration
Message-ID: <20210524072739-mutt-send-email-mst@kernel.org>
References: <20210519162903.1172366-1-eperezma@redhat.com>
 <20210524053144-mutt-send-email-mst@kernel.org>
 <CAJaqyWcVm55qjaDpQsuLzaY0FCzjW2ARyvOWCdfS9RJNoOM7Aw@mail.gmail.com>
MIME-Version: 1.0
In-Reply-To: <CAJaqyWcVm55qjaDpQsuLzaY0FCzjW2ARyvOWCdfS9RJNoOM7Aw@mail.gmail.com>
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=mst@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Disposition: inline
Cc: Parav Pandit <parav@mellanox.com>, Markus Armbruster <armbru@redhat.com>,
 qemu-level <qemu-devel@nongnu.org>, Harpreet Singh Anand <hanand@xilinx.com>,
 Xiao W Wang <xiao.w.wang@intel.com>, Stefan Hajnoczi <stefanha@redhat.com>,
 Eli Cohen <eli@mellanox.com>, virtualization@lists.linux-foundation.org,
 Eric Blake <eblake@redhat.com>, Michael Lilja <ml@napatech.com>
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
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Errors-To: virtualization-bounces@lists.linux-foundation.org
Sender: "Virtualization" <virtualization-bounces@lists.linux-foundation.org>

On Mon, May 24, 2021 at 12:37:48PM +0200, Eugenio Perez Martin wrote:
> On Mon, May 24, 2021 at 11:38 AM Michael S. Tsirkin <mst@redhat.com> wrot=
e:
> >
> > On Wed, May 19, 2021 at 06:28:34PM +0200, Eugenio P=E9rez wrote:
> > > Commit 17 introduces the buffer forwarding. Previous one are for
> > > preparations again, and laters are for enabling some obvious
> > > optimizations. However, it needs the vdpa device to be able to map
> > > every IOVA space, and some vDPA devices are not able to do so. Checki=
ng
> > > of this is added in previous commits.
> >
> > That might become a significant limitation. And it worries me that
> > this is such a big patchset which might yet take a while to get
> > finalized.
> >
> =

> Sorry, maybe I've been unclear here: Latter commits in this series
> address this limitation. Still not perfect: for example, it does not
> support adding or removing guest's memory at the moment, but this
> should be easy to implement on top.
> =

> The main issue I'm observing is from the kernel if I'm not wrong: If I
> unmap every address, I cannot re-map them again. But code in this
> patchset is mostly final, except for the comments it may arise in the
> mail list of course.
> =

> > I have an idea: how about as a first step we implement a transparent
> > switch from vdpa to a software virtio in QEMU or a software vhost in
> > kernel?
> >
> > This will give us live migration quickly with performance comparable
> > to failover but without dependance on guest cooperation.
> >
> =

> I think it should be doable. I'm not sure about the effort that needs
> to be done in qemu to hide these "hypervisor-failover devices" from
> guest's view but it should be comparable to failover, as you say.
> =

> Networking should be ok by its nature, although it could require care
> on the host hardware setup. But I'm not sure how other types of
> vhost/vdpa devices may work that way. How would a disk/scsi device
> switch modes? Can the kernel take control of the vdpa device through
> vhost, and just start reporting with a dirty bitmap?
> =

> Thanks!

It depends of course, e.g. blk is mostly reads/writes so
not a lot of state. just don't reorder or drop requests.

> > Next step could be driving vdpa from userspace while still copying
> > packets to a pre-registered buffer.
> >
> > Finally your approach will be a performance optimization for devices
> > that support arbitrary IOVA.
> >
> > Thoughts?
> >
> > --
> > MST
> >

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
