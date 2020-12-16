Return-Path: <SRS0=2z8p=FU=lists.linux-foundation.org=virtualization-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E995CC4361B
	for <virtualization@archiver.kernel.org>; Wed, 16 Dec 2020 19:57:53 +0000 (UTC)
Received: from hemlock.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 6ED3B230FA
	for <virtualization@archiver.kernel.org>; Wed, 16 Dec 2020 19:57:53 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6ED3B230FA
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=virtualization-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by hemlock.osuosl.org (Postfix) with ESMTP id EA20287698;
	Wed, 16 Dec 2020 19:57:52 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from hemlock.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id Ks8I8TIBOSKc; Wed, 16 Dec 2020 19:57:50 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by hemlock.osuosl.org (Postfix) with ESMTP id 1F20487693;
	Wed, 16 Dec 2020 19:57:50 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id E155BC0893;
	Wed, 16 Dec 2020 19:57:49 +0000 (UTC)
Received: from silver.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 1FBA8C013B
 for <virtualization@lists.linux-foundation.org>;
 Wed, 16 Dec 2020 19:57:48 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by silver.osuosl.org (Postfix) with ESMTP id F14352043A
 for <virtualization@lists.linux-foundation.org>;
 Wed, 16 Dec 2020 19:57:47 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from silver.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id wlfAQaGMDerL
 for <virtualization@lists.linux-foundation.org>;
 Wed, 16 Dec 2020 19:57:45 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [216.205.24.124])
 by silver.osuosl.org (Postfix) with ESMTPS id 8066220131
 for <virtualization@lists.linux-foundation.org>;
 Wed, 16 Dec 2020 19:57:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1608148664;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=dZZQKs4bp+ifj63PZO0dxaf27I/XYf/Zcar+TijNLXw=;
 b=Dydmq+s4w6D/Cl4EgmRseyijASK+xSL7Ggu8el2n6Az88H0Gp+GXZLSGOP3ItqblSz4eE2
 SpXSAbBuV/hFCHggDnpjSZZCB8tKvtj/eICKM5rwv/eycnM9/lU8oB9HZizsfIN3FSuah1
 s/l02gJaU5S7ezpMvxuz8Mun2fYfvmc=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-545-o8OBd7kZMYGzPI0J3zEEKw-1; Wed, 16 Dec 2020 14:57:42 -0500
X-MC-Unique: o8OBd7kZMYGzPI0J3zEEKw-1
Received: by mail-wm1-f70.google.com with SMTP id g82so2073730wmg.6
 for <virtualization@lists.linux-foundation.org>;
 Wed, 16 Dec 2020 11:57:42 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to;
 bh=dZZQKs4bp+ifj63PZO0dxaf27I/XYf/Zcar+TijNLXw=;
 b=Q0s5yMU51JzUiGhgRSTDwEGvY+b6diOSWFwny5Tdh4Kh2u2MQrp76Ad1sucKrTZ7nE
 QvNrnfbBuYICE0uGdUhIT9f4a3G8WrD/p3ENd7hFUBVX/aSKZDo/tHM22EjlmuqUrKTx
 P8Lx4zpZB/vYyJnlW/1SUDDksOMA9xXByizqZbRUGd77zM6GFmJKI72QuHIKXEKotjQO
 WHr2xtxQLZhrqowk+Sfk9dOgAt0Gaw/ebNtfOky0G/oSwP83yNgu9FW966okizk+N/FD
 f/Wg8IrgioLfzWjVDGWlylLMPgFWjOJMeH4M/N7jlmUktgUT6+vDq74DhHGRAJgZzWSp
 CXjQ==
X-Gm-Message-State: AOAM530SkSkScos8YUGRf28o/82gCIEk+c5ZYqFKrVnH4UsYPBOC3Qwc
 wWfEm78Dy/2X9DJ1fFmHbrileug9BxqCPIIZ6cjELsYUKU3vTLbHIFpLC3OCdlkRQtU2lsubvdc
 7a7zJnJ1EpDoubw019RxV2IzprwryAkgGO+azJSmMPg==
X-Received: by 2002:adf:e84f:: with SMTP id d15mr40434605wrn.245.1608148661111; 
 Wed, 16 Dec 2020 11:57:41 -0800 (PST)
X-Google-Smtp-Source: ABdhPJykOSySwK5/71U8nP5csaea+VdY5+sa9sCXKklxURZoKJ75YDToIwEQqq/BVfRShwNTFoTyJw==
X-Received: by 2002:adf:e84f:: with SMTP id d15mr40434596wrn.245.1608148660918; 
 Wed, 16 Dec 2020 11:57:40 -0800 (PST)
Received: from redhat.com (bzq-109-67-15-113.red.bezeqint.net. [109.67.15.113])
 by smtp.gmail.com with ESMTPSA id p9sm4049976wmm.17.2020.12.16.11.57.39
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 16 Dec 2020 11:57:40 -0800 (PST)
Date: Wed, 16 Dec 2020 14:57:37 -0500
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Parav Pandit <parav@nvidia.com>
Subject: Re: [PATCH 0/7] Introduce vdpa management tool
Message-ID: <20201216145724-mutt-send-email-mst@kernel.org>
References: <20201112064005.349268-1-parav@nvidia.com>
 <20201116142312.661786bb@kicinski-fedora-pc1c0hjn.dhcp.thefacebook.com>
 <BY5PR12MB432205C97D1AAEC1E8731FD4DCE20@BY5PR12MB4322.namprd12.prod.outlook.com>
 <20201216041303-mutt-send-email-mst@kernel.org>
 <20201216080610.08541f44@kicinski-fedora-pc1c0hjn.dhcp.thefacebook.com>
 <BY5PR12MB43227CBBF9A5CED02D74CA79DCC50@BY5PR12MB4322.namprd12.prod.outlook.com>
MIME-Version: 1.0
In-Reply-To: <BY5PR12MB43227CBBF9A5CED02D74CA79DCC50@BY5PR12MB4322.namprd12.prod.outlook.com>
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=mst@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Disposition: inline
Cc: Jakub Kicinski <kuba@kernel.org>, Eli Cohen <elic@nvidia.com>,
 "netdev@vger.kernel.org" <netdev@vger.kernel.org>,
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

On Wed, Dec 16, 2020 at 04:54:37PM +0000, Parav Pandit wrote:
> > From: Jakub Kicinski <kuba@kernel.org>
> > Sent: Wednesday, December 16, 2020 9:36 PM
> > 
> > On Wed, 16 Dec 2020 04:13:51 -0500 Michael S. Tsirkin wrote:
> > > > > > 3. Why not use ioctl() interface?
> > > > >
> > > > > Obviously I'm gonna ask you - why can't you use devlink?
> > > > >
> > > > This was considered.
> > > > However it seems that extending devlink for vdpa specific stats, devices,
> > config sounds overloading devlink beyond its defined scope.
> > >
> > > kuba what's your thinking here? Should I merge this as is?
> > 
> > No objections from me if people familiar with VDPA like it.
> 
> I was too occupied with the recent work on subfunction series.
> I wanted to change the "parentdev" to "mgmtdev" to make it little more clear for vdpa management tool to see vdpa mgmt device and operate on it.
> What do you think? Should I revise v2 or its late?

I need a rebase anyway, so sure.

-- 
MST

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
