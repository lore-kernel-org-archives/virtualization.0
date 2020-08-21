Return-Path: <SRS0=hbIa=B7=lists.linux-foundation.org=virtualization-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-14.3 required=3.0 tests=BAYES_00,
	DKIM_ADSP_CUSTOM_MED,DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,
	FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 580C0C433E1
	for <virtualization@archiver.kernel.org>; Fri, 21 Aug 2020 23:20:41 +0000 (UTC)
Received: from hemlock.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E91FB20656
	for <virtualization@archiver.kernel.org>; Fri, 21 Aug 2020 23:20:40 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Tm5kzNOT"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E91FB20656
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=virtualization-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by hemlock.osuosl.org (Postfix) with ESMTP id B7AF488796;
	Fri, 21 Aug 2020 23:20:40 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from hemlock.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id rEK5olsyasdz; Fri, 21 Aug 2020 23:20:39 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by hemlock.osuosl.org (Postfix) with ESMTP id A44A38874B;
	Fri, 21 Aug 2020 23:20:39 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 8AA4FC0889;
	Fri, 21 Aug 2020 23:20:39 +0000 (UTC)
Received: from silver.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 7A994C0051
 for <virtualization@lists.linux-foundation.org>;
 Fri, 21 Aug 2020 23:20:38 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by silver.osuosl.org (Postfix) with ESMTP id 691272322B
 for <virtualization@lists.linux-foundation.org>;
 Fri, 21 Aug 2020 23:20:38 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from silver.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id tfsRUM5p7nOX
 for <virtualization@lists.linux-foundation.org>;
 Fri, 21 Aug 2020 23:20:37 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from mail-qk1-f195.google.com (mail-qk1-f195.google.com
 [209.85.222.195])
 by silver.osuosl.org (Postfix) with ESMTPS id 0A3E520442
 for <virtualization@lists.linux-foundation.org>;
 Fri, 21 Aug 2020 23:20:37 +0000 (UTC)
Received: by mail-qk1-f195.google.com with SMTP id d14so2820934qke.13
 for <virtualization@lists.linux-foundation.org>;
 Fri, 21 Aug 2020 16:20:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=date:from:to:cc:subject:message-id:references:mime-version
 :content-disposition:in-reply-to;
 bh=KFJW4fwydEfmjMeeoqasxgVUbALGDw4QHt512/+zZ8Y=;
 b=Tm5kzNOT6giN2+6BpwpvAZPWcPZCNk5vjhUFP9pa2LGwovl/rJa3isWfJOkELNNocA
 XhIcKpWrTOPh+F/d0YnR1/m8nnU4NInZ84p/18szvFewdklGeee8mXSI2x8GR1xbTldV
 v9NP7eMccTaCUXP1BIZCgEktGKs28bs04gky5A1DcDK+ywEtTU9Z4d1GAlOn2oefHPKw
 djm8v2MsrZ31hjCzsp8l3Kk9nYn3BUfXhd+i0D0aE4WUOsOJZ96LJiLCM7GF15i68U6n
 ho+QzToAHvt1zx/wsOYkohlRqH7opi8y2m5MEyWilgYAV5D8vFkmgGhocyeNbeZhLHCY
 U4og==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to;
 bh=KFJW4fwydEfmjMeeoqasxgVUbALGDw4QHt512/+zZ8Y=;
 b=Zn+0E1vz3RszWNa9t1jUclmSd6frZYtgqXJY8dGLbXBLtk6QUnRkqaLTCyn4wmr4EH
 fo075Q7gT62n5vtZ7n00aZNWjfpZjaU4oAeaCqmt8l2vTJbc9gMQBKGpjCKcPAwgft5b
 yVlQseUiTUq/r8wGUA9PJ8/v2UJmIeHoyydm2ZE7z3ssvJGcJYYsSKL38UmR1d97J3P4
 zkBptNPeENlu32FoPuR/v63dd2H9kc+vGOl4DtIfwfQ2WSj1y7Fn2HtxP35J8+wJPIq5
 uAMSUz6gwCMc4rJmXcQygDx8NkQo7nZVViyZN0jWE32o2ZQqzJMHUud/ji9kRRqv96JR
 mRdQ==
X-Gm-Message-State: AOAM530fzAmTTBvq4io5HoWEdGWE+NESTlbIkGaCjLHCFytQbFiJ4kPv
 lHaYnXeBPWew+dnDpDxeJIs=
X-Google-Smtp-Source: ABdhPJzU1hR8kE6X2cbQIRblBnCHp6pSFeVe4TL6Y+JWrsG6caMtWxNHD9uWWwc2JPTQ2shjQUEt3w==
X-Received: by 2002:a37:44b:: with SMTP id 72mr4993211qke.494.1598052036025;
 Fri, 21 Aug 2020 16:20:36 -0700 (PDT)
Received: from ubuntu-n2-xlarge-x86 ([2604:1380:45d1:2600::1])
 by smtp.gmail.com with ESMTPSA id d196sm2964448qkg.96.2020.08.21.16.20.35
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 21 Aug 2020 16:20:35 -0700 (PDT)
Date: Fri, 21 Aug 2020 16:20:34 -0700
From: Nathan Chancellor <natechancellor@gmail.com>
To: Randy Dunlap <rdunlap@infradead.org>
Subject: Re: [PATCH] vdpa/mlx5: Avoid warnings about shifts on 32-bit platforms
Message-ID: <20200821232034.GA1472930@ubuntu-n2-xlarge-x86>
References: <20200821225018.940798-1-natechancellor@gmail.com>
 <1975c0a0-c19a-c91e-dc10-2918061cc4e7@infradead.org>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <1975c0a0-c19a-c91e-dc10-2918061cc4e7@infradead.org>
Cc: "Michael S. Tsirkin" <mst@redhat.com>, linux-kernel@vger.kernel.org,
 virtualization@lists.linux-foundation.org, clang-built-linux@googlegroups.com,
 Eli Cohen <eli@mellanox.com>
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

On Fri, Aug 21, 2020 at 04:13:19PM -0700, Randy Dunlap wrote:
> On 8/21/20 3:50 PM, Nathan Chancellor wrote:
> > Clang warns several times when building for 32-bit ARM along the lines
> > of:
> > 
> > drivers/vdpa/mlx5/net/mlx5_vnet.c:1462:31: warning: shift count >= width
> > of type [-Wshift-count-overflow]
> >                 ndev->mvdev.mlx_features |= BIT(VIRTIO_F_VERSION_1);
> >                                             ^~~~~~~~~~~~~~~~~~~~~~~
> > 
> > This is related to the BIT macro, which uses an unsigned long literal,
> > which is 32-bit on ARM so having a shift equal to or larger than 32 will
> > cause this warning, such as the above, where VIRTIO_F_VERSION_1 is 32.
> > To avoid this, use BIT_ULL, which will be an unsigned long long. This
> > matches the size of the features field throughout this driver, which is
> > u64 so there should be no functional change.
> > 
> > Fixes: 1a86b377aa21 ("vdpa/mlx5: Add VDPA driver for supported mlx5 devices")
> > Link: https://github.com/ClangBuiltLinux/linux/issues/1140
> > Signed-off-by: Nathan Chancellor <natechancellor@gmail.com>
> 
> Reported-by: Randy Dunlap <rdunlap@infradead.org>
> on 2020-AUG-10 for i386:
> https://lore.kernel.org/linux-next/5a7a0e6d-842a-78f6-aeac-c5b4c27b7186@infradead.org/
> :(

Sorry, I saw this in my own build tests and was not aware of the
previous report since I have not really been paying attention to
the mailing lists as of late :(

Should I need to do a v2, I will be sure to include that tag; otherwise,
it would be great if it could be picked up along with the below.

> Acked-by: Randy Dunlap <rdunlap@infradead.org> # build-tested

Thank you for testing!

> Thanks.
> 
> > ---
> >  drivers/vdpa/mlx5/net/mlx5_vnet.c | 50 +++++++++++++++----------------
> >  1 file changed, 25 insertions(+), 25 deletions(-)
> > 
> > diff --git a/drivers/vdpa/mlx5/net/mlx5_vnet.c b/drivers/vdpa/mlx5/net/mlx5_vnet.c
> > index 9df69d5efe8c..70676a6d1691 100644
> > --- a/drivers/vdpa/mlx5/net/mlx5_vnet.c
> > +++ b/drivers/vdpa/mlx5/net/mlx5_vnet.c
> > @@ -16,19 +16,19 @@
> >  #define to_mvdev(__vdev) container_of((__vdev), struct mlx5_vdpa_dev, vdev)
> >  
> >  #define VALID_FEATURES_MASK                                                                        \
> > -	(BIT(VIRTIO_NET_F_CSUM) | BIT(VIRTIO_NET_F_GUEST_CSUM) |                                   \
> > -	 BIT(VIRTIO_NET_F_CTRL_GUEST_OFFLOADS) | BIT(VIRTIO_NET_F_MTU) | BIT(VIRTIO_NET_F_MAC) |   \
> > -	 BIT(VIRTIO_NET_F_GUEST_TSO4) | BIT(VIRTIO_NET_F_GUEST_TSO6) |                             \
> > -	 BIT(VIRTIO_NET_F_GUEST_ECN) | BIT(VIRTIO_NET_F_GUEST_UFO) | BIT(VIRTIO_NET_F_HOST_TSO4) | \
> > -	 BIT(VIRTIO_NET_F_HOST_TSO6) | BIT(VIRTIO_NET_F_HOST_ECN) | BIT(VIRTIO_NET_F_HOST_UFO) |   \
> > -	 BIT(VIRTIO_NET_F_MRG_RXBUF) | BIT(VIRTIO_NET_F_STATUS) | BIT(VIRTIO_NET_F_CTRL_VQ) |      \
> > -	 BIT(VIRTIO_NET_F_CTRL_RX) | BIT(VIRTIO_NET_F_CTRL_VLAN) |                                 \
> > -	 BIT(VIRTIO_NET_F_CTRL_RX_EXTRA) | BIT(VIRTIO_NET_F_GUEST_ANNOUNCE) |                      \
> > -	 BIT(VIRTIO_NET_F_MQ) | BIT(VIRTIO_NET_F_CTRL_MAC_ADDR) | BIT(VIRTIO_NET_F_HASH_REPORT) |  \
> > -	 BIT(VIRTIO_NET_F_RSS) | BIT(VIRTIO_NET_F_RSC_EXT) | BIT(VIRTIO_NET_F_STANDBY) |           \
> > -	 BIT(VIRTIO_NET_F_SPEED_DUPLEX) | BIT(VIRTIO_F_NOTIFY_ON_EMPTY) |                          \
> > -	 BIT(VIRTIO_F_ANY_LAYOUT) | BIT(VIRTIO_F_VERSION_1) | BIT(VIRTIO_F_ACCESS_PLATFORM) |      \
> > -	 BIT(VIRTIO_F_RING_PACKED) | BIT(VIRTIO_F_ORDER_PLATFORM) | BIT(VIRTIO_F_SR_IOV))
> > +	(BIT_ULL(VIRTIO_NET_F_CSUM) | BIT_ULL(VIRTIO_NET_F_GUEST_CSUM) |                                   \
> > +	 BIT_ULL(VIRTIO_NET_F_CTRL_GUEST_OFFLOADS) | BIT_ULL(VIRTIO_NET_F_MTU) | BIT_ULL(VIRTIO_NET_F_MAC) |   \
> > +	 BIT_ULL(VIRTIO_NET_F_GUEST_TSO4) | BIT_ULL(VIRTIO_NET_F_GUEST_TSO6) |                             \
> > +	 BIT_ULL(VIRTIO_NET_F_GUEST_ECN) | BIT_ULL(VIRTIO_NET_F_GUEST_UFO) | BIT_ULL(VIRTIO_NET_F_HOST_TSO4) | \
> > +	 BIT_ULL(VIRTIO_NET_F_HOST_TSO6) | BIT_ULL(VIRTIO_NET_F_HOST_ECN) | BIT_ULL(VIRTIO_NET_F_HOST_UFO) |   \
> > +	 BIT_ULL(VIRTIO_NET_F_MRG_RXBUF) | BIT_ULL(VIRTIO_NET_F_STATUS) | BIT_ULL(VIRTIO_NET_F_CTRL_VQ) |      \
> > +	 BIT_ULL(VIRTIO_NET_F_CTRL_RX) | BIT_ULL(VIRTIO_NET_F_CTRL_VLAN) |                                 \
> > +	 BIT_ULL(VIRTIO_NET_F_CTRL_RX_EXTRA) | BIT_ULL(VIRTIO_NET_F_GUEST_ANNOUNCE) |                      \
> > +	 BIT_ULL(VIRTIO_NET_F_MQ) | BIT_ULL(VIRTIO_NET_F_CTRL_MAC_ADDR) | BIT_ULL(VIRTIO_NET_F_HASH_REPORT) |  \
> > +	 BIT_ULL(VIRTIO_NET_F_RSS) | BIT_ULL(VIRTIO_NET_F_RSC_EXT) | BIT_ULL(VIRTIO_NET_F_STANDBY) |           \
> > +	 BIT_ULL(VIRTIO_NET_F_SPEED_DUPLEX) | BIT_ULL(VIRTIO_F_NOTIFY_ON_EMPTY) |                          \
> > +	 BIT_ULL(VIRTIO_F_ANY_LAYOUT) | BIT_ULL(VIRTIO_F_VERSION_1) | BIT_ULL(VIRTIO_F_ACCESS_PLATFORM) |      \
> > +	 BIT_ULL(VIRTIO_F_RING_PACKED) | BIT_ULL(VIRTIO_F_ORDER_PLATFORM) | BIT_ULL(VIRTIO_F_SR_IOV))
> >  
> >  #define VALID_STATUS_MASK                                                                          \
> >  	(VIRTIO_CONFIG_S_ACKNOWLEDGE | VIRTIO_CONFIG_S_DRIVER | VIRTIO_CONFIG_S_DRIVER_OK |        \
> > @@ -149,7 +149,7 @@ static bool mlx5_vdpa_debug;
> >  
> >  #define MLX5_LOG_VIO_FLAG(_feature)                                                                \
> >  	do {                                                                                       \
> > -		if (features & BIT(_feature))                                                      \
> > +		if (features & BIT_ULL(_feature))                                                  \
> >  			mlx5_vdpa_info(mvdev, "%s\n", #_feature);                                  \
> >  	} while (0)
> >  
> > @@ -750,10 +750,10 @@ static bool vq_is_tx(u16 idx)
> >  
> >  static u16 get_features_12_3(u64 features)
> >  {
> > -	return (!!(features & BIT(VIRTIO_NET_F_HOST_TSO4)) << 9) |
> > -	       (!!(features & BIT(VIRTIO_NET_F_HOST_TSO6)) << 8) |
> > -	       (!!(features & BIT(VIRTIO_NET_F_CSUM)) << 7) |
> > -	       (!!(features & BIT(VIRTIO_NET_F_GUEST_CSUM)) << 6);
> > +	return (!!(features & BIT_ULL(VIRTIO_NET_F_HOST_TSO4)) << 9) |
> > +	       (!!(features & BIT_ULL(VIRTIO_NET_F_HOST_TSO6)) << 8) |
> > +	       (!!(features & BIT_ULL(VIRTIO_NET_F_CSUM)) << 7) |
> > +	       (!!(features & BIT_ULL(VIRTIO_NET_F_GUEST_CSUM)) << 6);
> >  }
> >  
> >  static int create_virtqueue(struct mlx5_vdpa_net *ndev, struct mlx5_vdpa_virtqueue *mvq)
> > @@ -1439,13 +1439,13 @@ static u64 mlx_to_vritio_features(u16 dev_features)
> >  	u64 result = 0;
> >  
> >  	if (dev_features & MLX5_VIRTIO_NET_F_GUEST_CSUM)
> > -		result |= BIT(VIRTIO_NET_F_GUEST_CSUM);
> > +		result |= BIT_ULL(VIRTIO_NET_F_GUEST_CSUM);
> >  	if (dev_features & MLX5_VIRTIO_NET_F_CSUM)
> > -		result |= BIT(VIRTIO_NET_F_CSUM);
> > +		result |= BIT_ULL(VIRTIO_NET_F_CSUM);
> >  	if (dev_features & MLX5_VIRTIO_NET_F_HOST_TSO6)
> > -		result |= BIT(VIRTIO_NET_F_HOST_TSO6);
> > +		result |= BIT_ULL(VIRTIO_NET_F_HOST_TSO6);
> >  	if (dev_features & MLX5_VIRTIO_NET_F_HOST_TSO4)
> > -		result |= BIT(VIRTIO_NET_F_HOST_TSO4);
> > +		result |= BIT_ULL(VIRTIO_NET_F_HOST_TSO4);
> >  
> >  	return result;
> >  }
> > @@ -1459,15 +1459,15 @@ static u64 mlx5_vdpa_get_features(struct vdpa_device *vdev)
> >  	dev_features = MLX5_CAP_DEV_VDPA_EMULATION(mvdev->mdev, device_features_bits_mask);
> >  	ndev->mvdev.mlx_features = mlx_to_vritio_features(dev_features);
> >  	if (MLX5_CAP_DEV_VDPA_EMULATION(mvdev->mdev, virtio_version_1_0))
> > -		ndev->mvdev.mlx_features |= BIT(VIRTIO_F_VERSION_1);
> > -	ndev->mvdev.mlx_features |= BIT(VIRTIO_F_ACCESS_PLATFORM);
> > +		ndev->mvdev.mlx_features |= BIT_ULL(VIRTIO_F_VERSION_1);
> > +	ndev->mvdev.mlx_features |= BIT_ULL(VIRTIO_F_ACCESS_PLATFORM);
> >  	print_features(mvdev, ndev->mvdev.mlx_features, false);
> >  	return ndev->mvdev.mlx_features;
> >  }
> >  
> >  static int verify_min_features(struct mlx5_vdpa_dev *mvdev, u64 features)
> >  {
> > -	if (!(features & BIT(VIRTIO_F_ACCESS_PLATFORM)))
> > +	if (!(features & BIT_ULL(VIRTIO_F_ACCESS_PLATFORM)))
> >  		return -EOPNOTSUPP;
> >  
> >  	return 0;
> > 
> > base-commit: 8a7c3213db068135e816a6a517157de6443290d6
> > 
> 
> 
> -- 
> ~Randy
> 
> -- 
> You received this message because you are subscribed to the Google Groups "Clang Built Linux" group.
> To unsubscribe from this group and stop receiving emails from it, send an email to clang-built-linux+unsubscribe@googlegroups.com.
> To view this discussion on the web visit https://groups.google.com/d/msgid/clang-built-linux/1975c0a0-c19a-c91e-dc10-2918061cc4e7%40infradead.org.
_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
