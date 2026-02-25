Received: from out30-101.freemail.mail.aliyun.com (out30-101.freemail.mail.aliyun.com [115.124.30.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C7AAA3033CB
	for <virtualization@lists.linux.dev>; Wed, 25 Feb 2026 09:22:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=115.124.30.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772011333; cv=none; b=ujqqTTlkXXpPanxAMh8uE/odfyYkfbwzkmcZbdordiJGQRsr4CDbasrV7/s3l0J4Sro2scxKqrvB4grOgJ0paAE2AujkyP7epLZU8djQ/EiXQgCEmnttTVwEtCMPb6W+88pdPrZX7gkJ67X7PeYE+tGs3no9ePeKLYX3tPectNs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772011333; c=relaxed/simple;
	bh=usJdWGjdVWHyoeOFLpeq87JVlSPKqO+60Ixrrf+Cd2w=;
	h=Message-ID:Subject:Date:From:To:Cc:References:In-Reply-To; b=HtFibpqwL21fVN6JeKCxjSWDV7TTui70Vkee8bP2ektDR6GF1PRNVmRwGsuoF9dekAepLZogl0JyeTDGeY66jdRcZdYwiBaChAwqT8JIZQANzIJSi2d4qgsJpSFnS5iU5WAdzey2KnFhXKPI66HGmsxZF8FJNynf4xquFJkRAds=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; spf=pass smtp.mailfrom=linux.alibaba.com; dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b=BFEGSs69; arc=none smtp.client-ip=115.124.30.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b="BFEGSs69"
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1772011323; h=Message-ID:Subject:Date:From:To;
	bh=Jij/vp1VmGg7OCxxZ+6UMDbKQTv+EwP6Pty7TdVomV0=;
	b=BFEGSs69wj3iCD1/hqFBumbpEYZ9YRf5Mk1BY7j+IRKCpK0GbdKZg3LgvwqmlFrz2treoerfSOBbYbF+cNN9wtE6QRhzZl3YjMyq77aLNqZSnTlSZmVKW2oV0eLPzwjO6FNLUO5QOQp0LmvrrochV80iWkAr66h2u1GbXn3C+Tc=
Received: from localhost(mailfrom:xuanzhuo@linux.alibaba.com fp:SMTPD_---0Wzm3MxA_1772011321 cluster:ay36)
          by smtp.aliyun-inc.com;
          Wed, 25 Feb 2026 17:22:02 +0800
Message-ID: <1772010702.3747633-2-xuanzhuo@linux.alibaba.com>
Subject: Re: [PATCH net-next,2/2] virtio_net: replace RSS key size max check with BUILD_BUG_ON
Date: Wed, 25 Feb 2026 17:11:42 +0800
From: Xuan Zhuo <xuanzhuo@linux.alibaba.com>
To: Srujana Challa <schalla@marvell.com>
Cc: <pabeni@redhat.com>,
 <mst@redhat.com>,
 <jasowang@redhat.com>,
 <xuanzhuo@linux.alibaba.com>,
 <eperezma@redhat.com>,
 <davem@davemloft.net>,
 <edumazet@google.com>,
 <kuba@kernel.org>,
 <ndabilpuram@marvell.com>,
 <kshankar@marvell.com>,
 <schalla@marvell.com>,
 <netdev@vger.kernel.org>,
 <virtualization@lists.linux.dev>
References: <20260224065850.962826-1-schalla@marvell.com>
 <20260224065850.962826-2-schalla@marvell.com>
In-Reply-To: <20260224065850.962826-2-schalla@marvell.com>
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>

On Tue, 24 Feb 2026 12:28:50 +0530, Srujana Challa <schalla@marvell.com> wrote:
> Since NETDEV_RSS_KEY_LEN was increased to 256 in net-next, use
> BUILD_BUG_ON to enforce the limit at compile time and remove the
> redundant runtime max check.
>
> Signed-off-by: Srujana Challa <schalla@marvell.com>
> ---
>  drivers/net/virtio_net.c | 8 +-------
>  1 file changed, 1 insertion(+), 7 deletions(-)
>
> diff --git a/drivers/net/virtio_net.c b/drivers/net/virtio_net.c
> index eeefe8abc122..768ad5523dfa 100644
> --- a/drivers/net/virtio_net.c
> +++ b/drivers/net/virtio_net.c
> @@ -6639,13 +6639,7 @@ static int virtnet_validate(struct virtio_device *vdev)
>  			__virtio_clear_bit(vdev, VIRTIO_NET_F_RSS);
>  			__virtio_clear_bit(vdev, VIRTIO_NET_F_HASH_REPORT);
>  		}
> -		if (key_sz > NETDEV_RSS_KEY_LEN) {
> -			dev_warn(&vdev->dev,
> -				 "rss_max_key_size=%u exceeds driver limit %u, disabling RSS\n",
> -				 key_sz, NETDEV_RSS_KEY_LEN);
> -			__virtio_clear_bit(vdev, VIRTIO_NET_F_RSS);
> -			__virtio_clear_bit(vdev, VIRTIO_NET_F_HASH_REPORT);
> -		}
> +		BUILD_BUG_ON(type_max(key_sz) >= NETDEV_RSS_KEY_LEN);

Do we really need this check?

If I understand correctly, the intention is to cap key_sz at 256. However, since
key_sz is of type u8, its maximum value is inherently 255, making this check
redundant. This is not only limited by this kernel code, the virtio-net spec
defines this.

Moreover, if NETDEV_RSS_KEY_LEN is ever reduced to a value smaller than 256 in
the future, this check would no longer enforce the intended limit correctly.


Moreover, you should add a cover letter.

Thanks.





>  	}
>
>  	return 0;
> --
> 2.25.1
>
