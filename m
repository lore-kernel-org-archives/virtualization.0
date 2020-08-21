Return-Path: <SRS0=hbIa=B7=lists.linux-foundation.org=virtualization-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-18.1 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,NICE_REPLY_A,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	UPPERCASE_50_75,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 786C1C433E1
	for <virtualization@archiver.kernel.org>; Fri, 21 Aug 2020 23:13:37 +0000 (UTC)
Received: from fraxinus.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 3C73E2067C
	for <virtualization@archiver.kernel.org>; Fri, 21 Aug 2020 23:13:37 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="SFkFEtDP"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3C73E2067C
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=virtualization-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by fraxinus.osuosl.org (Postfix) with ESMTP id 0318D86C92;
	Fri, 21 Aug 2020 23:13:37 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from fraxinus.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id djY9OKXv8-ku; Fri, 21 Aug 2020 23:13:34 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by fraxinus.osuosl.org (Postfix) with ESMTP id B34348623E;
	Fri, 21 Aug 2020 23:13:34 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 808FDC0889;
	Fri, 21 Aug 2020 23:13:34 +0000 (UTC)
Received: from hemlock.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by lists.linuxfoundation.org (Postfix) with ESMTP id C20B4C0051
 for <virtualization@lists.linux-foundation.org>;
 Fri, 21 Aug 2020 23:13:31 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by hemlock.osuosl.org (Postfix) with ESMTP id A9415886A3
 for <virtualization@lists.linux-foundation.org>;
 Fri, 21 Aug 2020 23:13:31 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from hemlock.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id 3gyJJH4k0Ve6
 for <virtualization@lists.linux-foundation.org>;
 Fri, 21 Aug 2020 23:13:28 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from casper.infradead.org (casper.infradead.org [90.155.50.34])
 by hemlock.osuosl.org (Postfix) with ESMTPS id 9ECEE88686
 for <virtualization@lists.linux-foundation.org>;
 Fri, 21 Aug 2020 23:13:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=infradead.org; s=casper.20170209; h=Content-Transfer-Encoding:Content-Type:
 In-Reply-To:MIME-Version:Date:Message-ID:From:References:Cc:To:Subject:Sender
 :Reply-To:Content-ID:Content-Description;
 bh=m7RfewVLa8YXRGQn+dkSgkj1/tUR4KO62lCzO2eGme0=; b=SFkFEtDPiTOFzC89MGpp0n9oGq
 mJvgsCKzGl00eAbqTVPpCyy9au4WCddYjJOixeUC+1Xel6PuGHY1pR/ZIXWe33lmrO8H1Wch+M9RM
 zHv9docnzihGwCvRHsI+QtWENI+YggQ4IWqycwtf+wi98kPeh904P/VHs3U0oxrRnzMUJKY9oUH+G
 /cVyZZ0zxgBPKkDSTrh9+aF2KQIiSMqxmJm9p6hvFc5cksZHMd6aC/+8l7fMFF99yfm7fyyY12/rT
 Ic6h5dclFxSdjl7FPnjlVO8Z7eXP9zwLji6+dcYrk/ybR+nCImqgNlNlv18vJPJCum8jJd6uMbK58
 SLF8VZ6A==;
Received: from [2601:1c0:6280:3f0::19c2]
 by casper.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
 id 1k9GDr-0001Qs-1n; Fri, 21 Aug 2020 23:13:23 +0000
Subject: Re: [PATCH] vdpa/mlx5: Avoid warnings about shifts on 32-bit platforms
To: Nathan Chancellor <natechancellor@gmail.com>,
 "Michael S. Tsirkin" <mst@redhat.com>, Jason Wang <jasowang@redhat.com>,
 Eli Cohen <eli@mellanox.com>
References: <20200821225018.940798-1-natechancellor@gmail.com>
From: Randy Dunlap <rdunlap@infradead.org>
Message-ID: <1975c0a0-c19a-c91e-dc10-2918061cc4e7@infradead.org>
Date: Fri, 21 Aug 2020 16:13:19 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.11.0
MIME-Version: 1.0
In-Reply-To: <20200821225018.940798-1-natechancellor@gmail.com>
Content-Language: en-US
Cc: clang-built-linux@googlegroups.com, linux-kernel@vger.kernel.org,
 virtualization@lists.linux-foundation.org
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

On 8/21/20 3:50 PM, Nathan Chancellor wrote:
> Clang warns several times when building for 32-bit ARM along the lines
> of:
> 
> drivers/vdpa/mlx5/net/mlx5_vnet.c:1462:31: warning: shift count >= width
> of type [-Wshift-count-overflow]
>                 ndev->mvdev.mlx_features |= BIT(VIRTIO_F_VERSION_1);
>                                             ^~~~~~~~~~~~~~~~~~~~~~~
> 
> This is related to the BIT macro, which uses an unsigned long literal,
> which is 32-bit on ARM so having a shift equal to or larger than 32 will
> cause this warning, such as the above, where VIRTIO_F_VERSION_1 is 32.
> To avoid this, use BIT_ULL, which will be an unsigned long long. This
> matches the size of the features field throughout this driver, which is
> u64 so there should be no functional change.
> 
> Fixes: 1a86b377aa21 ("vdpa/mlx5: Add VDPA driver for supported mlx5 devices")
> Link: https://github.com/ClangBuiltLinux/linux/issues/1140
> Signed-off-by: Nathan Chancellor <natechancellor@gmail.com>

Reported-by: Randy Dunlap <rdunlap@infradead.org>
on 2020-AUG-10 for i386:
https://lore.kernel.org/linux-next/5a7a0e6d-842a-78f6-aeac-c5b4c27b7186@infradead.org/
:(

Acked-by: Randy Dunlap <rdunlap@infradead.org> # build-tested

Thanks.

> ---
>  drivers/vdpa/mlx5/net/mlx5_vnet.c | 50 +++++++++++++++----------------
>  1 file changed, 25 insertions(+), 25 deletions(-)
> 
> diff --git a/drivers/vdpa/mlx5/net/mlx5_vnet.c b/drivers/vdpa/mlx5/net/mlx5_vnet.c
> index 9df69d5efe8c..70676a6d1691 100644
> --- a/drivers/vdpa/mlx5/net/mlx5_vnet.c
> +++ b/drivers/vdpa/mlx5/net/mlx5_vnet.c
> @@ -16,19 +16,19 @@
>  #define to_mvdev(__vdev) container_of((__vdev), struct mlx5_vdpa_dev, vdev)
>  
>  #define VALID_FEATURES_MASK                                                                        \
> -	(BIT(VIRTIO_NET_F_CSUM) | BIT(VIRTIO_NET_F_GUEST_CSUM) |                                   \
> -	 BIT(VIRTIO_NET_F_CTRL_GUEST_OFFLOADS) | BIT(VIRTIO_NET_F_MTU) | BIT(VIRTIO_NET_F_MAC) |   \
> -	 BIT(VIRTIO_NET_F_GUEST_TSO4) | BIT(VIRTIO_NET_F_GUEST_TSO6) |                             \
> -	 BIT(VIRTIO_NET_F_GUEST_ECN) | BIT(VIRTIO_NET_F_GUEST_UFO) | BIT(VIRTIO_NET_F_HOST_TSO4) | \
> -	 BIT(VIRTIO_NET_F_HOST_TSO6) | BIT(VIRTIO_NET_F_HOST_ECN) | BIT(VIRTIO_NET_F_HOST_UFO) |   \
> -	 BIT(VIRTIO_NET_F_MRG_RXBUF) | BIT(VIRTIO_NET_F_STATUS) | BIT(VIRTIO_NET_F_CTRL_VQ) |      \
> -	 BIT(VIRTIO_NET_F_CTRL_RX) | BIT(VIRTIO_NET_F_CTRL_VLAN) |                                 \
> -	 BIT(VIRTIO_NET_F_CTRL_RX_EXTRA) | BIT(VIRTIO_NET_F_GUEST_ANNOUNCE) |                      \
> -	 BIT(VIRTIO_NET_F_MQ) | BIT(VIRTIO_NET_F_CTRL_MAC_ADDR) | BIT(VIRTIO_NET_F_HASH_REPORT) |  \
> -	 BIT(VIRTIO_NET_F_RSS) | BIT(VIRTIO_NET_F_RSC_EXT) | BIT(VIRTIO_NET_F_STANDBY) |           \
> -	 BIT(VIRTIO_NET_F_SPEED_DUPLEX) | BIT(VIRTIO_F_NOTIFY_ON_EMPTY) |                          \
> -	 BIT(VIRTIO_F_ANY_LAYOUT) | BIT(VIRTIO_F_VERSION_1) | BIT(VIRTIO_F_ACCESS_PLATFORM) |      \
> -	 BIT(VIRTIO_F_RING_PACKED) | BIT(VIRTIO_F_ORDER_PLATFORM) | BIT(VIRTIO_F_SR_IOV))
> +	(BIT_ULL(VIRTIO_NET_F_CSUM) | BIT_ULL(VIRTIO_NET_F_GUEST_CSUM) |                                   \
> +	 BIT_ULL(VIRTIO_NET_F_CTRL_GUEST_OFFLOADS) | BIT_ULL(VIRTIO_NET_F_MTU) | BIT_ULL(VIRTIO_NET_F_MAC) |   \
> +	 BIT_ULL(VIRTIO_NET_F_GUEST_TSO4) | BIT_ULL(VIRTIO_NET_F_GUEST_TSO6) |                             \
> +	 BIT_ULL(VIRTIO_NET_F_GUEST_ECN) | BIT_ULL(VIRTIO_NET_F_GUEST_UFO) | BIT_ULL(VIRTIO_NET_F_HOST_TSO4) | \
> +	 BIT_ULL(VIRTIO_NET_F_HOST_TSO6) | BIT_ULL(VIRTIO_NET_F_HOST_ECN) | BIT_ULL(VIRTIO_NET_F_HOST_UFO) |   \
> +	 BIT_ULL(VIRTIO_NET_F_MRG_RXBUF) | BIT_ULL(VIRTIO_NET_F_STATUS) | BIT_ULL(VIRTIO_NET_F_CTRL_VQ) |      \
> +	 BIT_ULL(VIRTIO_NET_F_CTRL_RX) | BIT_ULL(VIRTIO_NET_F_CTRL_VLAN) |                                 \
> +	 BIT_ULL(VIRTIO_NET_F_CTRL_RX_EXTRA) | BIT_ULL(VIRTIO_NET_F_GUEST_ANNOUNCE) |                      \
> +	 BIT_ULL(VIRTIO_NET_F_MQ) | BIT_ULL(VIRTIO_NET_F_CTRL_MAC_ADDR) | BIT_ULL(VIRTIO_NET_F_HASH_REPORT) |  \
> +	 BIT_ULL(VIRTIO_NET_F_RSS) | BIT_ULL(VIRTIO_NET_F_RSC_EXT) | BIT_ULL(VIRTIO_NET_F_STANDBY) |           \
> +	 BIT_ULL(VIRTIO_NET_F_SPEED_DUPLEX) | BIT_ULL(VIRTIO_F_NOTIFY_ON_EMPTY) |                          \
> +	 BIT_ULL(VIRTIO_F_ANY_LAYOUT) | BIT_ULL(VIRTIO_F_VERSION_1) | BIT_ULL(VIRTIO_F_ACCESS_PLATFORM) |      \
> +	 BIT_ULL(VIRTIO_F_RING_PACKED) | BIT_ULL(VIRTIO_F_ORDER_PLATFORM) | BIT_ULL(VIRTIO_F_SR_IOV))
>  
>  #define VALID_STATUS_MASK                                                                          \
>  	(VIRTIO_CONFIG_S_ACKNOWLEDGE | VIRTIO_CONFIG_S_DRIVER | VIRTIO_CONFIG_S_DRIVER_OK |        \
> @@ -149,7 +149,7 @@ static bool mlx5_vdpa_debug;
>  
>  #define MLX5_LOG_VIO_FLAG(_feature)                                                                \
>  	do {                                                                                       \
> -		if (features & BIT(_feature))                                                      \
> +		if (features & BIT_ULL(_feature))                                                  \
>  			mlx5_vdpa_info(mvdev, "%s\n", #_feature);                                  \
>  	} while (0)
>  
> @@ -750,10 +750,10 @@ static bool vq_is_tx(u16 idx)
>  
>  static u16 get_features_12_3(u64 features)
>  {
> -	return (!!(features & BIT(VIRTIO_NET_F_HOST_TSO4)) << 9) |
> -	       (!!(features & BIT(VIRTIO_NET_F_HOST_TSO6)) << 8) |
> -	       (!!(features & BIT(VIRTIO_NET_F_CSUM)) << 7) |
> -	       (!!(features & BIT(VIRTIO_NET_F_GUEST_CSUM)) << 6);
> +	return (!!(features & BIT_ULL(VIRTIO_NET_F_HOST_TSO4)) << 9) |
> +	       (!!(features & BIT_ULL(VIRTIO_NET_F_HOST_TSO6)) << 8) |
> +	       (!!(features & BIT_ULL(VIRTIO_NET_F_CSUM)) << 7) |
> +	       (!!(features & BIT_ULL(VIRTIO_NET_F_GUEST_CSUM)) << 6);
>  }
>  
>  static int create_virtqueue(struct mlx5_vdpa_net *ndev, struct mlx5_vdpa_virtqueue *mvq)
> @@ -1439,13 +1439,13 @@ static u64 mlx_to_vritio_features(u16 dev_features)
>  	u64 result = 0;
>  
>  	if (dev_features & MLX5_VIRTIO_NET_F_GUEST_CSUM)
> -		result |= BIT(VIRTIO_NET_F_GUEST_CSUM);
> +		result |= BIT_ULL(VIRTIO_NET_F_GUEST_CSUM);
>  	if (dev_features & MLX5_VIRTIO_NET_F_CSUM)
> -		result |= BIT(VIRTIO_NET_F_CSUM);
> +		result |= BIT_ULL(VIRTIO_NET_F_CSUM);
>  	if (dev_features & MLX5_VIRTIO_NET_F_HOST_TSO6)
> -		result |= BIT(VIRTIO_NET_F_HOST_TSO6);
> +		result |= BIT_ULL(VIRTIO_NET_F_HOST_TSO6);
>  	if (dev_features & MLX5_VIRTIO_NET_F_HOST_TSO4)
> -		result |= BIT(VIRTIO_NET_F_HOST_TSO4);
> +		result |= BIT_ULL(VIRTIO_NET_F_HOST_TSO4);
>  
>  	return result;
>  }
> @@ -1459,15 +1459,15 @@ static u64 mlx5_vdpa_get_features(struct vdpa_device *vdev)
>  	dev_features = MLX5_CAP_DEV_VDPA_EMULATION(mvdev->mdev, device_features_bits_mask);
>  	ndev->mvdev.mlx_features = mlx_to_vritio_features(dev_features);
>  	if (MLX5_CAP_DEV_VDPA_EMULATION(mvdev->mdev, virtio_version_1_0))
> -		ndev->mvdev.mlx_features |= BIT(VIRTIO_F_VERSION_1);
> -	ndev->mvdev.mlx_features |= BIT(VIRTIO_F_ACCESS_PLATFORM);
> +		ndev->mvdev.mlx_features |= BIT_ULL(VIRTIO_F_VERSION_1);
> +	ndev->mvdev.mlx_features |= BIT_ULL(VIRTIO_F_ACCESS_PLATFORM);
>  	print_features(mvdev, ndev->mvdev.mlx_features, false);
>  	return ndev->mvdev.mlx_features;
>  }
>  
>  static int verify_min_features(struct mlx5_vdpa_dev *mvdev, u64 features)
>  {
> -	if (!(features & BIT(VIRTIO_F_ACCESS_PLATFORM)))
> +	if (!(features & BIT_ULL(VIRTIO_F_ACCESS_PLATFORM)))
>  		return -EOPNOTSUPP;
>  
>  	return 0;
> 
> base-commit: 8a7c3213db068135e816a6a517157de6443290d6
> 


-- 
~Randy
_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
