Return-Path: <SRS0=2z8p=FU=lists.linux-foundation.org=virtualization-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EFBB0C4361B
	for <virtualization@archiver.kernel.org>; Wed, 16 Dec 2020 09:14:03 +0000 (UTC)
Received: from fraxinus.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 4291622B4B
	for <virtualization@archiver.kernel.org>; Wed, 16 Dec 2020 09:14:03 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4291622B4B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=virtualization-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by fraxinus.osuosl.org (Postfix) with ESMTP id A25EE85EEF;
	Wed, 16 Dec 2020 09:14:02 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from fraxinus.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id kgUHlYrPkIzW; Wed, 16 Dec 2020 09:14:02 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by fraxinus.osuosl.org (Postfix) with ESMTP id 1625085E7D;
	Wed, 16 Dec 2020 09:14:02 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id E4AE1C0893;
	Wed, 16 Dec 2020 09:14:01 +0000 (UTC)
Received: from hemlock.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 55FF3C013B
 for <virtualization@lists.linux-foundation.org>;
 Wed, 16 Dec 2020 09:14:00 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by hemlock.osuosl.org (Postfix) with ESMTP id 4E3538767A
 for <virtualization@lists.linux-foundation.org>;
 Wed, 16 Dec 2020 09:14:00 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from hemlock.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id ZFohvQC9-diI
 for <virtualization@lists.linux-foundation.org>;
 Wed, 16 Dec 2020 09:13:59 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [216.205.24.124])
 by hemlock.osuosl.org (Postfix) with ESMTPS id 78F7F87671
 for <virtualization@lists.linux-foundation.org>;
 Wed, 16 Dec 2020 09:13:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1608110038;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=xlZr8e4b4QyEqbJXLhWMSpFHmJcnFFKnckGLJnj/rQc=;
 b=YwVOh6ZR7RhngYFEuE1QA4m6gW5SQ95xMJjFpEituiJ+RayGw/ciAQ/0IR3HMXks3DFAxj
 DkRsMquMB40cb5c6xHbCFq6u8AQcLox/s+cO+THY5u/zag8fhFuHXbzQiaiOFlSF0TisAR
 QP8vc/fss62OIgHrOrRn5xf3xSGGoR4=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-559-3XOryLjPOyalmXD2esfnBA-1; Wed, 16 Dec 2020 04:13:56 -0500
X-MC-Unique: 3XOryLjPOyalmXD2esfnBA-1
Received: by mail-wm1-f70.google.com with SMTP id f187so1081263wme.3
 for <virtualization@lists.linux-foundation.org>;
 Wed, 16 Dec 2020 01:13:56 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to;
 bh=xlZr8e4b4QyEqbJXLhWMSpFHmJcnFFKnckGLJnj/rQc=;
 b=Uzif1bD0+M8ZiELhlWlLl2XtQfyavURGIeamKu6tMzGuFJgDry2LSEhiH4PRf1qtCy
 VjfacPe6uMvpooXIm3/3KfIT7ej+X4+pbTbRUuyfeuSstZg6wTJ9B1x/w5Er3GIazDPJ
 UuWroxGmgucF2hCh+cDCbnDswS4QQ8QA/1OQMlXYvvgsuORlI/gZCsxYQpFf0RzExGbp
 lW3e7kUX6G85+W7AmPAOW+pXtaHSG4N/075Bn5lcgDCRroG+iGzFJ9vcCrSl0f7NTguQ
 2Mt4PhCqfuvu0y7SRyMU9gZUlUDGtEqXDOl7SZrBOureSIuVOUXRjsNgET6LrCGgay/6
 aMpg==
X-Gm-Message-State: AOAM530BGhV7SUKAHWE/tOJxMX58vNwjLmOmyO3J5LRBTkZkCTbVFTcQ
 oe8MHJ/1yy7pU7fKCZOJhofPdwR9qv4OekR7H+wjA5NqgRvMVAlUGuC1zxb1brCwJnMWwdzQaal
 2uPnezOG+YXa0iNsSXXemL1KSrohIOhazu/tfEmullA==
X-Received: by 2002:a5d:488d:: with SMTP id g13mr36918135wrq.274.1608110035367; 
 Wed, 16 Dec 2020 01:13:55 -0800 (PST)
X-Google-Smtp-Source: ABdhPJyI3sJg2iK/Z+eccnrmwQSJxjia/Jdn5DdNW1wULhddirz2EPzKlyh5o9nq4APX2mKTbDY2QA==
X-Received: by 2002:a5d:488d:: with SMTP id g13mr36918110wrq.274.1608110035183; 
 Wed, 16 Dec 2020 01:13:55 -0800 (PST)
Received: from redhat.com (bzq-109-67-15-113.red.bezeqint.net. [109.67.15.113])
 by smtp.gmail.com with ESMTPSA id p9sm1831190wmm.17.2020.12.16.01.13.53
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 16 Dec 2020 01:13:54 -0800 (PST)
Date: Wed, 16 Dec 2020 04:13:51 -0500
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Parav Pandit <parav@nvidia.com>
Subject: Re: [PATCH 0/7] Introduce vdpa management tool
Message-ID: <20201216041303-mutt-send-email-mst@kernel.org>
References: <20201112064005.349268-1-parav@nvidia.com>
 <20201116142312.661786bb@kicinski-fedora-pc1c0hjn.dhcp.thefacebook.com>
 <BY5PR12MB432205C97D1AAEC1E8731FD4DCE20@BY5PR12MB4322.namprd12.prod.outlook.com>
MIME-Version: 1.0
In-Reply-To: <BY5PR12MB432205C97D1AAEC1E8731FD4DCE20@BY5PR12MB4322.namprd12.prod.outlook.com>
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=mst@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Disposition: inline
Cc: Jakub Kicinski <kuba@kernel.org>,
 "netdev@vger.kernel.org" <netdev@vger.kernel.org>, Eli Cohen <elic@nvidia.com>,
 "virtualization@lists.linux-foundation.org"
 <virtualization@lists.linux-foundation.org>
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

On Tue, Nov 17, 2020 at 07:51:56PM +0000, Parav Pandit wrote:
> 
> 
> > From: Jakub Kicinski <kuba@kernel.org>
> > Sent: Tuesday, November 17, 2020 3:53 AM
> > 
> > On Thu, 12 Nov 2020 08:39:58 +0200 Parav Pandit wrote:
> > > FAQs:
> > > -----
> > > 1. Where does userspace vdpa tool reside which users can use?
> > > Ans: vdpa tool can possibly reside in iproute2 [1] as it enables user
> > > to create vdpa net devices.
> > >
> > > 2. Why not create and delete vdpa device using sysfs/configfs?
> > > Ans:
> > 
> > > 3. Why not use ioctl() interface?
> > 
> > Obviously I'm gonna ask you - why can't you use devlink?
> > 
> This was considered.
> However it seems that extending devlink for vdpa specific stats, devices, config sounds overloading devlink beyond its defined scope.

kuba what's your thinking here? Should I merge this as is?

> > > Next steps:
> > > -----------
> > > (a) Post this patchset and iproute2/vdpa inclusion, remaining two
> > > drivers will be coverted to support vdpa tool instead of creating
> > > unmanaged default device on driver load.
> > > (b) More net specific parameters such as mac, mtu will be added.
> > 
> > How does MAC and MTU belong in this new VDPA thing?
> MAC only make sense when user wants to run VF/SF Netdev and vdpa together with different mac address.
> Otherwise existing devlink well defined API to have one MAC per function is fine.
> Same for MTU, if queues of vdpa vs VF/SF Netdev queues wants have different MTU it make sense to add configure per vdpa device.

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
