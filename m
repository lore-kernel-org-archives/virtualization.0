Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 243E5C433F5
	for <virtualization@archiver.kernel.org>; Fri, 14 Jan 2022 12:54:06 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id B585B4168B;
	Fri, 14 Jan 2022 12:54:05 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
	by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id vF9mLNti0yUV; Fri, 14 Jan 2022 12:54:04 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp4.osuosl.org (Postfix) with ESMTPS id 124404034F;
	Fri, 14 Jan 2022 12:54:04 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id D3122C0030;
	Fri, 14 Jan 2022 12:54:03 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [IPv6:2605:bc80:3010::137])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 5DFF9C001E
 for <virtualization@lists.linux-foundation.org>;
 Fri, 14 Jan 2022 12:54:03 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id 542B84067C
 for <virtualization@lists.linux-foundation.org>;
 Fri, 14 Jan 2022 12:54:03 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id 1rWJsST9SBQJ
 for <virtualization@lists.linux-foundation.org>;
 Fri, 14 Jan 2022 12:54:02 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.129.124])
 by smtp4.osuosl.org (Postfix) with ESMTPS id 1A7804034F
 for <virtualization@lists.linux-foundation.org>;
 Fri, 14 Jan 2022 12:54:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1642164840;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=ptcxbmDhNHAam6/ZOOq/pD2mlDBGNl+RhNAPKypGuLo=;
 b=P71CZ+nU8U5bePRPRUAyypIFnqFS1QFsOfd5XxEDhCyM9zavtFhHl6hyu86X6qk69e/Q5m
 4bkYr2et6OZNneNe+mZRkWUau+XGEMFfgrIDP9zA/ACyEHMZfPmPfFv2Cy0lrGBFswpqvi
 VPtJbCykIdpsjHJDw2rmfHaClGnr8qg=
Received: from mail-ed1-f69.google.com (mail-ed1-f69.google.com
 [209.85.208.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-527-9kXn7bFbMmeTjQcvHvxLmg-1; Fri, 14 Jan 2022 07:53:57 -0500
X-MC-Unique: 9kXn7bFbMmeTjQcvHvxLmg-1
Received: by mail-ed1-f69.google.com with SMTP id
 z10-20020a05640235ca00b003f8efab3342so8300053edc.2
 for <virtualization@lists.linux-foundation.org>;
 Fri, 14 Jan 2022 04:53:57 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to;
 bh=ptcxbmDhNHAam6/ZOOq/pD2mlDBGNl+RhNAPKypGuLo=;
 b=UUSAyYDKYE0XautLUaHKsxZvnwa4qyW771pDjPybEpzNDEeGv5Z7gniCYOykCuezA8
 Qsv21Pw0rme+jeBYdMYQcCwd9sB5AGUzoLQeMb2Pj57eEO1HGbdK8GAa7pz1BlAa1Wmk
 NQiv8Da6chnODgr8I8heeQZp/Ktl6TmvFKsACsY2xprVphXd6zdRg59MiiN5ZS3zUEvj
 RJ5AnFsNCTqn8ra+JH3yPo5Ox1F02inc0K1g/I483k8eaCunQsVtL8HZl8o/7ulBIqvA
 5nz++GanDA4rJN+bKGowvIJHs0dRECizkzmGyiMqOCT4Ccz+2XOLqyGUfzIHGb9mSyJg
 goIQ==
X-Gm-Message-State: AOAM530cbLqJ5t97SieAIK+iJio7WoL5Q8tmEo0nD0r/MhIw2cACUXkI
 jJ6+v8OPffXJcAKH08ylmw+qAFDBb1YIVPCzyQk/K+JRRa28Ofm3m5AVY3V1iEKR2cwFL+TV7FL
 X19zSmf1QP32CgZhpNdq1RYivfLVYUwUfbvNDE9e/2w==
X-Received: by 2002:a05:6402:4c5:: with SMTP id
 n5mr8834324edw.122.1642164836388; 
 Fri, 14 Jan 2022 04:53:56 -0800 (PST)
X-Google-Smtp-Source: ABdhPJxzRlTVN4D9RIPOjbUkjJ6UZvAgSAci4zg/t/t4tdPVWcWZG5SicadQ0FsqRC/z3EnUNYaNwQ==
X-Received: by 2002:a05:6402:4c5:: with SMTP id
 n5mr8834309edw.122.1642164836134; 
 Fri, 14 Jan 2022 04:53:56 -0800 (PST)
Received: from redhat.com ([2.55.154.210])
 by smtp.gmail.com with ESMTPSA id h13sm2370063edl.96.2022.01.14.04.53.54
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 14 Jan 2022 04:53:55 -0800 (PST)
Date: Fri, 14 Jan 2022 07:53:52 -0500
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Si-Wei Liu <si-wei.liu@oracle.com>
Subject: Re: [PATCH 2/3] vdpa/mlx5: set_features should nack MQ if no CTRL_VQ
Message-ID: <20220114074855-mutt-send-email-mst@kernel.org>
References: <1642050651-16197-1-git-send-email-si-wei.liu@oracle.com>
 <1642050651-16197-3-git-send-email-si-wei.liu@oracle.com>
 <20220113014704-mutt-send-email-mst@kernel.org>
 <5d0e9db9-5649-6afc-f7d0-9723cddd59b0@oracle.com>
MIME-Version: 1.0
In-Reply-To: <5d0e9db9-5649-6afc-f7d0-9723cddd59b0@oracle.com>
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=mst@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Disposition: inline
Cc: lvivier@redhat.com, virtualization@lists.linux-foundation.org,
 eperezma@redhat.com, elic@nvidia.com
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

On Fri, Jan 14, 2022 at 12:51:55AM -0800, Si-Wei Liu wrote:
> 
> 
> On 1/12/2022 10:57 PM, Michael S. Tsirkin wrote:
> > On Thu, Jan 13, 2022 at 12:10:50AM -0500, Si-Wei Liu wrote:
> > > Made corresponding change per spec:
> > 
> > > The device MUST NOT offer a feature which requires another feature
> > > which was not offered.
> > Says nothing about the driver though, and you seem to be
> > doing things to driver features?
> Yes, it's about validation for driver features, though the spec doesn't have
> clear way how to deal with this situation. I guess this in reality leaves
> quite some space for the implementation. To step back, in recent days with
> latent spec revision for feature negotiation due to endianness and MTU
> validation, what do we expect device to work if the driver is not compliant
> and comes up with invalid features set? To clear a subset of driver features
> unsupported by the device, such that driver may figure out by reading it
> from device config space later on? Or fail the entire features and have
> driver to re-try a different setting? Do you feel its possible for device to
> clear a subset of invalid or unsupported features sent down by the driver,
> which may allow driver continue to work without having to fail the entire
> feature negotiation?
> 
> The current userspace implementation in qemu may filter out invalid features
> from driver by clearing a subset and tailor it to fit what host/device can
> offer. I thought it should be safe to follow the existing practice. That way
> guest driver can get know of the effective features during feature
> negotiation, or after features_ok is set (that's what I call by "re-read" of
> features, sorry if I used the wrong term). Did I miss something? I can
> definitely add more explanation for the motivation, remove the reference to
> spec and delete the Fixes tag to avoid confusions. Do you think this would
> work?
> 
> Another option would be just return failure for the set_driver_features()
> call when seeing (MQ && !CTRL_VQ). Simple enough and easy to implement.
> Efficient to indicate which individual feature is failing? Probably not,
> driver has to retry a few times using binary search to know.
> 
> > pls explain the motivation. which config are you trying to
> > fix what is current and expected behaviour.
> The current mq code for mlx5_vdpa driver is written in the assumption that
> MQ must come together with CTRL_VQ. I would like to point out that right now
> there's nowhere in the host side even QEMU to guarantee this assumption
> would hold. Were there a malicious driver sending down MQ without CTRL_VQ,
> it would compromise various spots such as is_index_valid() and
> is_ctrl_vq_idx(). This doesn't end up with immediate panic or security
> loophole in the host currently, but still the chance for this being taken
> advantage of is not zero, especially when future code change is involved.
> You can say it's code cleanup, but the added check helps harden the crispy
> assumption and assures peace of mind.

I think that right now the right thing to do is to validate untrusted
input and fail invalid operations.
The spec does say "VIRTIO_NET_F_MQ Requires VIRTIO_NET_F_CTRL_VQ".
If there are existing legacy drivers
violating some rules, then we should consider working around that (and
maybe documenting that in the spec in the legacy section).


> > 
> > > Fixes: 52893733f2c5 ("vdpa/mlx5: Add multiqueue support")
> > 
> > It's all theoretical right? Fixes really means
> > "if you have commit ABC then you should pick this one up".
> > not really appropriate for theoretical fixes.
> Yeah. This was discovered in code review. Didn't see a real issue. I can
> remove the tag.
> 
> -Siwei
> > 
> > > Signed-off-by: Si-Wei Liu<si-wei.liu@oracle.com>
> > > ---
> > >   drivers/vdpa/mlx5/net/mlx5_vnet.c | 16 +++++++++++++---
> > >   1 file changed, 13 insertions(+), 3 deletions(-)
> > > 
> > > diff --git a/drivers/vdpa/mlx5/net/mlx5_vnet.c b/drivers/vdpa/mlx5/net/mlx5_vnet.c
> > > index b53603d..46d4deb 100644
> > > --- a/drivers/vdpa/mlx5/net/mlx5_vnet.c
> > > +++ b/drivers/vdpa/mlx5/net/mlx5_vnet.c
> > > @@ -1897,11 +1897,21 @@ static u64 mlx5_vdpa_get_device_features(struct vdpa_device *vdev)
> > >   	return ndev->mvdev.mlx_features;
> > >   }
> > > -static int verify_min_features(struct mlx5_vdpa_dev *mvdev, u64 features)
> > > +static int verify_driver_features(struct mlx5_vdpa_dev *mvdev, u64 *features)
> > 
> > Good rename actually but document in commit log with an
> > explanation.
> > 
> > >   {
> > > -	if (!(features & BIT_ULL(VIRTIO_F_ACCESS_PLATFORM)))
> > > +	/* minimum features to expect */
> > > +	if (!(*features & BIT_ULL(VIRTIO_F_ACCESS_PLATFORM)))
> > >   		return -EOPNOTSUPP;
> > > +	/* Double check features combination sent down by the driver.
> > > +	 * NACK invalid feature due to the absence of depended feature.
> > Pls rewrite this to make it grammatical.  There's no NACK in spec. What
> > does this do? Fails to set FEATURES_OK?
> > 
> > > +	 * Driver is expected to re-read the negotiated features once
> > > +	 * return from set_driver_features.
> > once return is ungrammatical. What to say here depends on what
> > you mean by this, so I'm not sure.
> > 
> > 
> > Here's text from spec:
> > 
> > \item\label{itm:General Initialization And Device Operation /
> > Device Initialization / Read feature bits} Read device feature bits, and write the subset of feature bits
> >     understood by the OS and driver to the device.  During this step the
> >     driver MAY read (but MUST NOT write) the device-specific configuration fields to check that it can support the device before accepting it.
> > 
> > \item\label{itm:General Initialization And Device Operation / Device Initialization / Set FEATURES-OK} Set the FEATURES_OK status bit.  The driver MUST NOT accept
> >     new feature bits after this step.
> > 
> > \item\label{itm:General Initialization And Device Operation / Device Initialization / Re-read FEATURES-OK} Re-read \field{device status} to ensure the FEATURES_OK bit is still
> >     set: otherwise, the device does not support our subset of features
> >     and the device is unusable.
> > 
> > \item\label{itm:General Initialization And Device Operation / Device Initialization / Device-specific Setup} Perform device-specific setup, including discovery of virtqueues for the
> >     device, optional per-bus setup, reading and possibly writing the
> >     device's virtio configuration space, and population of virtqueues.
> > 
> > does not seem to talk about re-reading features.
> > What did I miss?
> > 
> > 
> > > +	 */
> > 
> > This comment confuses more than it clarifies. I would
> > - quote the spec
> > - explain why does code do what it does specifically for these features
> > 
> > > +	if ((*features & (BIT_ULL(VIRTIO_NET_F_MQ) | BIT_ULL(VIRTIO_NET_F_CTRL_VQ))) ==
> > > +            BIT_ULL(VIRTIO_NET_F_MQ))
> > > +		*features &= ~BIT_ULL(VIRTIO_NET_F_MQ);
> > > +
> > >   	return 0;
> > >   }
> > > @@ -1977,7 +1987,7 @@ static int mlx5_vdpa_set_driver_features(struct vdpa_device *vdev, u64 features)
> > >   	print_features(mvdev, features, true);
> > > -	err = verify_min_features(mvdev, features);
> > > +	err = verify_driver_features(mvdev, &features);
> > >   	if (err)
> > >   		return err;
> > > -- 
> > > 1.8.3.1

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
