Return-Path: <SRS0=ivLu=BN=lists.linux-foundation.org=virtualization-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EEB70C433DF
	for <virtualization@archiver.kernel.org>; Mon,  3 Aug 2020 20:35:06 +0000 (UTC)
Received: from fraxinus.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E101322CB1
	for <virtualization@archiver.kernel.org>; Mon,  3 Aug 2020 20:35:06 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="bvliKX02"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E101322CB1
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=virtualization-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by fraxinus.osuosl.org (Postfix) with ESMTP id 6686085A37;
	Mon,  3 Aug 2020 20:35:06 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from fraxinus.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id M-lvAGF1H5sD; Mon,  3 Aug 2020 20:35:05 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by fraxinus.osuosl.org (Postfix) with ESMTP id DC3C48583F;
	Mon,  3 Aug 2020 20:35:05 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id CC336C0050;
	Mon,  3 Aug 2020 20:35:05 +0000 (UTC)
Received: from fraxinus.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by lists.linuxfoundation.org (Postfix) with ESMTP id DF4F3C004C
 for <virtualization@lists.linux-foundation.org>;
 Mon,  3 Aug 2020 20:35:04 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by fraxinus.osuosl.org (Postfix) with ESMTP id C7B458586A
 for <virtualization@lists.linux-foundation.org>;
 Mon,  3 Aug 2020 20:35:04 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from fraxinus.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id pACLenpL-Ux4
 for <virtualization@lists.linux-foundation.org>;
 Mon,  3 Aug 2020 20:35:02 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from us-smtp-1.mimecast.com (us-smtp-delivery-1.mimecast.com
 [205.139.110.120])
 by fraxinus.osuosl.org (Postfix) with ESMTPS id 757798583F
 for <virtualization@lists.linux-foundation.org>;
 Mon,  3 Aug 2020 20:35:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1596486901;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=J++JsNedboNVUbv/gxh63osNPbWqGD9pU0YvctCeDm0=;
 b=bvliKX02As9udwaEMi0P2nKKE8bMVJEFKftQZYpEPE1pPTAd0KGB3zP6q5t4QccG8yghYo
 PpIulptU0HEASv78n/NawPQgb5WxxE1RRNNtH1qIB754ApM2kQFcsmsHCHBU2Iqq4ulOHi
 0w0m+TAJaP/voJGzk/sMpIH6E/5bpOw=
Received: from mail-qk1-f200.google.com (mail-qk1-f200.google.com
 [209.85.222.200]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-348-ga6UsPUHNF2K3-pEnMsrhg-1; Mon, 03 Aug 2020 16:34:57 -0400
X-MC-Unique: ga6UsPUHNF2K3-pEnMsrhg-1
Received: by mail-qk1-f200.google.com with SMTP id k142so26975199qke.7
 for <virtualization@lists.linux-foundation.org>;
 Mon, 03 Aug 2020 13:34:57 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:content-transfer-encoding
 :in-reply-to;
 bh=w4BJWn0OFbloyNEKW+pvD9R5ezJo0Picl13T+Bha9IM=;
 b=Hv1XfN95RFlTrF6SvXKnd9cgOaVO5IKUgE/hSJYMATxe7KxJeSeLqFS1J3PBN2V8GC
 ugmqgIqT6hyQIKButDvYB6DyjmddrupQSci+YAsJclCDkQbndiOO7p4f478uW+34J01Y
 aUs/ZWa4jGAewM55c8x/juQ6Qftpku2N6N1iQjZMUBNfQWmzDbbv59Tt7J+7TQ+EZNPv
 uQ0H69t9IGRAbzaijDOP9/jciaD6FqfEIgcX+oZlQHTflbQL/Yrg8OPCMKPJYkBlHTVF
 XhLesdQ4Xsxjl4jMRoZr0OQFHrkvkA83HfNwQ95J9GM9I4PTlWE3eVLGhNAqohArqwcS
 hQSQ==
X-Gm-Message-State: AOAM5307qEGHb1oi3sDXdIip1NAsm0Cwz2LMPCz0t5nEPFKQWl7u5YBE
 cVmE3WzfOJh8W9CvvC5c/+KsoIwuFJLHs8A1eWx9hVchSBMmhOlIvV2P6c1tqVeENlnlX52zn+A
 U2L3CMeEdSJ3AUxv5H5JRWeiGqEHqwxNn9vD4ozJ7XA==
X-Received: by 2002:a0c:9b85:: with SMTP id o5mr18907113qve.11.1596486897282; 
 Mon, 03 Aug 2020 13:34:57 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJxvGy1muSaAsUQEYp2jWmeN6mFZFo5SHwfathQRXjTM8ZraPWxB2MOxfd/RWjT4CwEPQBY29w==
X-Received: by 2002:a0c:9b85:: with SMTP id o5mr18907092qve.11.1596486897049; 
 Mon, 03 Aug 2020 13:34:57 -0700 (PDT)
Received: from redhat.com (bzq-79-177-102-128.red.bezeqint.net.
 [79.177.102.128])
 by smtp.gmail.com with ESMTPSA id j16sm20957593qke.87.2020.08.03.13.34.52
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 03 Aug 2020 13:34:55 -0700 (PDT)
Date: Mon, 3 Aug 2020 16:34:50 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Eli Cohen <eli@mellanox.com>
Subject: Re: [PATCH V3 vhost next 00/10] VDPA support for Mellanox ConnectX
 devices
Message-ID: <20200803163235-mutt-send-email-mst@kernel.org>
References: <20200728060539.4163-1-eli@mellanox.com>
 <1dbac14a-5909-ff0a-8e90-534847f93d50@redhat.com>
 <20200728063211.GA229972@mtl-vdi-166.wap.labs.mlnx>
 <ef857921-4b9a-8e48-d5cd-5ef585e8f15c@redhat.com>
 <83eb3fdc-83d5-7f88-bef4-602e60c19662@redhat.com>
 <20200729055452.GA31247@mtl-vdi-166.wap.labs.mlnx>
MIME-Version: 1.0
In-Reply-To: <20200729055452.GA31247@mtl-vdi-166.wap.labs.mlnx>
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Disposition: inline
Cc: shahafs@mellanox.com, parav@mellanox.com, linux-kernel@vger.kernel.org,
 virtualization@lists.linux-foundation.org, saeedm@mellanox.com
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

On Wed, Jul 29, 2020 at 08:54:52AM +0300, Eli Cohen wrote:
> On Tue, Jul 28, 2020 at 02:53:34PM +0800, Jason Wang wrote:
> > =

> > Just notice Michael's vhost branch can not compile due to this commit:
> > =

> > commit fee8fe6bd8ccacd27e963b71b4f943be3721779e
> > Author: Michael S. Tsirkin <mst@redhat.com>
> > Date:=C2=A0=C2=A0 Mon Jul 27 10:51:55 2020 -0400
> > =

> > =C2=A0=C2=A0=C2=A0 vdpa: make sure set_features in invoked for legacy
> > =

> > Let's wait for Michael to clarify the correct branch to use then.
> >
> =

> Michael, are you going to send a path to a git tree that I can rebase my
> series on top of it, or maybe you can just take my v3 and apply them on
> the right tree? If you do, you can take Jason's patches from the series
> he posted here https://lkml.org/lkml/2020/7/1/301 and take my 0003-0010
> patches.
> =

> Let me know.

It's a bit too hard to figure out how to put these pieces together, when
I tried I run into some conflicts, and given I can't test them I'd
rather you did this.  Please also note kbuild test bot reported a build
failure on mips.

A good tree to base your work on is the linux-next branch
in https://git.kernel.org/pub/scm/linux/kernel/git/mst/vhost.git

Thanks!
-- =

MST

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
