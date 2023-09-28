Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E9944CE7AFA
	for <virtualization@archiver.kernel.org>; Thu, 28 Sep 2023 05:31:47 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp2.osuosl.org (Postfix) with ESMTP id 5303040FBD;
	Thu, 28 Sep 2023 05:31:47 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org 5303040FBD
Authentication-Results: smtp2.osuosl.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=E4hPj2hG
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
	by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id SbJoeYNBRpo5; Thu, 28 Sep 2023 05:31:46 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp2.osuosl.org (Postfix) with ESMTPS id BC77F4018B;
	Thu, 28 Sep 2023 05:31:45 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org BC77F4018B
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 7CFA0C0071;
	Thu, 28 Sep 2023 05:31:45 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 4BCE4C0032
 for <virtualization@lists.linux-foundation.org>;
 Thu, 28 Sep 2023 05:31:44 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id 1F242404EF
 for <virtualization@lists.linux-foundation.org>;
 Thu, 28 Sep 2023 05:31:44 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org 1F242404EF
Authentication-Results: smtp4.osuosl.org;
 dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com
 header.a=rsa-sha256 header.s=mimecast20190719 header.b=E4hPj2hG
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id zyR1WucF7mxg
 for <virtualization@lists.linux-foundation.org>;
 Thu, 28 Sep 2023 05:31:42 +0000 (UTC)
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.133.124])
 by smtp4.osuosl.org (Postfix) with ESMTPS id 852BC404ED
 for <virtualization@lists.linux-foundation.org>;
 Thu, 28 Sep 2023 05:31:42 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org 852BC404ED
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1695879101;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=xp82++crOZoaM6X/LxOAj7IKSMWgMbb+sdsAJug1YDc=;
 b=E4hPj2hGiqsQvr9GUIH2tc+D/Q7kp15WecpFYXwTufCBiPUzPnhYzbDRPDuZ3G4kdqN5g5
 oI5kDtTuvPUCCdh39nMJ6bF+/i57diPWmVDluGlSIfwXxJx55zyGWww3tkhRhA5r5lFqCW
 xK56+8rD/S8lJCBOZt26Pv/lYlaTjcs=
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-182-gB0m_3ZMN8i5PXpD53fdxA-1; Thu, 28 Sep 2023 01:26:39 -0400
X-MC-Unique: gB0m_3ZMN8i5PXpD53fdxA-1
Received: by mail-wr1-f72.google.com with SMTP id
 ffacd0b85a97d-322d2acf4abso8386815f8f.0
 for <virtualization@lists.linux-foundation.org>;
 Wed, 27 Sep 2023 22:26:39 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1695878798; x=1696483598;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=xp82++crOZoaM6X/LxOAj7IKSMWgMbb+sdsAJug1YDc=;
 b=XTYJdYUqxGQAJwYfi9101VFR0XYMQZqudt/tbMUpIfBL+EIeeDla/fJOHagfvxdRs+
 SR9UtG0F69fv/HJea3Sdmix7zgF0H+hXiS3gyr+pdN0QPWzSPNsWx4hC+KqEVmYhMpW1
 xYUjJfPMHWvv/GJVx89lrGLVXg9OVL1cKzGZiJJghtZNHCa8RvO+JuT3sbjnTbryMjba
 u+8CrRHx8SJYoJfOtnQGF75zjUNpvRZokfuejRiszmmBZbqOub4hPfHG8/gbRz7WjqAi
 9TJ+aZNkjiT7h1BIVsI2DT1RZbTiJvG8ezgfj6jEIyMg9Vhx0+BlAtJHbsIPDPC0bwKk
 dkJg==
X-Gm-Message-State: AOJu0Ywmpt+y2JrvQnbYFa46J8gXHIZ8nyJdCdY1Vm8Pd2nTYVaGhYsP
 OilklHC/lqsdVpHGtjVjFPPCuWNRdSYns2S03PUjLG6YiBXx8oSNlzw4vb9cDfzfO8RfwL8UZiS
 hbjxYEjMFk7MsGKC2sc5zWw3lW5MkhwrueS49P64ocA==
X-Received: by 2002:adf:ee48:0:b0:321:4790:bb5e with SMTP id
 w8-20020adfee48000000b003214790bb5emr219024wro.38.1695878798332; 
 Wed, 27 Sep 2023 22:26:38 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFPQurwO0AoypE2TWDU+Q7g/w7BZXGQF9+IGHSN11iCczls2yJnowTHsFwo18o3y5sbXPmLcA==
X-Received: by 2002:adf:ee48:0:b0:321:4790:bb5e with SMTP id
 w8-20020adfee48000000b003214790bb5emr219011wro.38.1695878797857; 
 Wed, 27 Sep 2023 22:26:37 -0700 (PDT)
Received: from redhat.com ([2.52.19.249]) by smtp.gmail.com with ESMTPSA id
 a13-20020adff7cd000000b0031ad5fb5a0fsm3599926wrq.58.2023.09.27.22.26.35
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 27 Sep 2023 22:26:36 -0700 (PDT)
Date: Thu, 28 Sep 2023 01:26:33 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Jason Gunthorpe <jgg@nvidia.com>
Subject: Re: [PATCH vfio 10/11] vfio/virtio: Expose admin commands over
 virtio device
Message-ID: <20230928010136-mutt-send-email-mst@kernel.org>
References: <20230921124040.145386-1-yishaih@nvidia.com>
 <20230921124040.145386-11-yishaih@nvidia.com>
 <20230922055336-mutt-send-email-mst@kernel.org>
 <c3724e2f-7938-abf7-6aea-02bfb3881151@nvidia.com>
 <20230926072538-mutt-send-email-mst@kernel.org>
 <20230927131817.GA338226@nvidia.com>
 <20230927172806-mutt-send-email-mst@kernel.org>
 <20230927231600.GD339126@nvidia.com>
MIME-Version: 1.0
In-Reply-To: <20230927231600.GD339126@nvidia.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Disposition: inline
Cc: kvm@vger.kernel.org, maorg@nvidia.com,
 virtualization@lists.linux-foundation.org, jiri@nvidia.com, leonro@nvidia.com
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

On Wed, Sep 27, 2023 at 08:16:00PM -0300, Jason Gunthorpe wrote:
> On Wed, Sep 27, 2023 at 05:30:04PM -0400, Michael S. Tsirkin wrote:
> > On Wed, Sep 27, 2023 at 10:18:17AM -0300, Jason Gunthorpe wrote:
> > > On Tue, Sep 26, 2023 at 07:41:44AM -0400, Michael S. Tsirkin wrote:
> > > 
> > > > > By the way, this follows what was done already between vfio/mlx5 to
> > > > > mlx5_core modules where mlx5_core exposes generic APIs to execute a command
> > > > > and to get the a PF from a given mlx5 VF.
> > > > 
> > > > This is up to mlx5 maintainers. In particular they only need to worry
> > > > that their patches work with specific hardware which they likely have.
> > > > virtio has to work with multiple vendors - hardware and software -
> > > > and exposing a low level API that I can't test on my laptop
> > > > is not at all my ideal.
> > > 
> > > mlx5 has a reasonable API from the lower level that allows the vfio
> > > driver to safely issue commands. The API provides all the safety and
> > > locking you have been questioning here.
> > > 
> > > Then the vfio driver can form the commands directly and in the way it
> > > needs. This avoids spewing code into the core modules that is only
> > > used by vfio - which has been a key design consideration for our
> > > driver layering.
> > > 
> > > I suggest following the same design here as it has been well proven.
> > > Provide a solid API to operate the admin queue and let VFIO use
> > > it. One of the main purposes of the admin queue is to deliver commands
> > > on behalf of the VF driver, so this is a logical and reasonable place
> > > to put an API.
> > 
> > Not the way virtio is designed now. I guess mlx5 is designed in
> > a way that makes it safe.
> 
> If you can't reliably issue commmands from the VF at all it doesn't
> really matter where you put the code. Once that is established up then
> an admin command execution interface is a nice cut point for
> modularity.
> 
> The locking in mlx5 to make this safe is not too complex, if Feng
> missed some items for virtio then he can work to fix it up.

Above two paragraphs don't make sense to me at all. VF issues
no commands and there's no locking.

> > > VFIO live migration is expected to come as well once OASIS completes
> > > its work.
> > 
> > Exactly. Is there doubt vdpa will want to support live migration?
> > Put this code in a library please.
> 
> I have a doubt, you both said vdpa already does live migration, so
> what will it even do with a live migration interface to a PCI
> function?

This is not the thread to explain how vdpa live migration works now and
why it needs new interfaces, sorry. Suffice is to say right now on virtio
tc Parav from nvidia is arguing for vdpa to use admin commands for
migration.

> It already has to use full mediation to operate a physical virtio
> function, so it seems like it shouldn't need the migration interface?
> 
> Regardless, it is better kernel development hygiene to put the code
> where it is used and wait for a second user to consolidate it than to
> guess.
> 
> Jason

Sorry no time right now to argue philosophy. I gave some hints on how to
make the virtio changes behave in a way that I'm ok with maintaining.
Hope they help.

-- 
MST

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
