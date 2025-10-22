Received: from out30-111.freemail.mail.aliyun.com (out30-111.freemail.mail.aliyun.com [115.124.30.111])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 678F0278158
	for <virtualization@lists.linux.dev>; Wed, 22 Oct 2025 03:54:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=115.124.30.111
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761105301; cv=none; b=hDo9yHqaXHDDq1aPyHmFri9l/5peXgmp0skIZlGgY0D0Ff+jCTMuJazSjRA8rP9esSN3O/zqjOg7EhwdZW3ZgQLIIOwJ473m8psHc28LxaOdbAqCT+QpV82sVHFqvB0jBn9pRH6KiHWQ7jZLKppDy/D8ya+YITekxFVaIZpH2as=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761105301; c=relaxed/simple;
	bh=uQfk3Le9KERMMWm52SnZ/oM/1kH5gLp0h68A3u/zq7I=;
	h=Message-ID:Subject:Date:From:To:Cc:References:In-Reply-To; b=mwP1pm0IZDhqVtkMTlMgllx3zTygQu5wu5lVyrtxeNi7Q/LinYrLkEEqbp0hjFWmseN1hUrTPBMTxKpzDowK2I5IV9KC1ZhQ+MuquHU6V5Uiz0Hk3YT31gP4brF3tOnAO1YyVPXd3RidHRGoFtM4NIyqrSD5pNcTxbSLYfhehj8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; spf=pass smtp.mailfrom=linux.alibaba.com; dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b=uQANblin; arc=none smtp.client-ip=115.124.30.111
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b="uQANblin"
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1761105295; h=Message-ID:Subject:Date:From:To;
	bh=S0LUDwuX2bVNX84XTQkfDh81t8I2QtGUEauu7kdK/QI=;
	b=uQANblin50gzpIj42XzDV45dJTF17+9iY/AHO+6jjvUi6MZ0J9pWu45pr5/+Jn3ZGlSPVY7RTLDpa7SsBNZ5Z3dRCYv5H6xlcoqOd2SNc0JdVptul8QcnVrfwXUvEwjhABa1IqliHBMKMcCXMs16ev8W0tbCNr2ZOM/CABMrKls=
Received: from localhost(mailfrom:xuanzhuo@linux.alibaba.com fp:SMTPD_---0WqlI4cU_1761105294 cluster:ay36)
          by smtp.aliyun-inc.com;
          Wed, 22 Oct 2025 11:54:55 +0800
Message-ID: <1761105287.0200958-1-xuanzhuo@linux.alibaba.com>
Subject: Re: [PATCH net V2] virtio-net: zero unused hash fields
Date: Wed, 22 Oct 2025 11:54:47 +0800
From: Xuan Zhuo <xuanzhuo@linux.alibaba.com>
To: Jason Wang <jasowang@redhat.com>
Cc: netdev@vger.kernel.org,
 stable@vger.kernel.org,
 mst@redhat.com,
 jasowang@redhat.com,
 eperezma@redhat.com,
 pabeni@redhat.com,
 virtualization@lists.linux.dev,
 linux-kernel@vger.kernel.org
References: <20251022034421.70244-1-jasowang@redhat.com>
In-Reply-To: <20251022034421.70244-1-jasowang@redhat.com>
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>

On Wed, 22 Oct 2025 11:44:21 +0800, Jason Wang <jasowang@redhat.com> wrote:
> When GSO tunnel is negotiated virtio_net_hdr_tnl_from_skb() tries to
> initialize the tunnel metadata but forget to zero unused rxhash
> fields. This may leak information to another side. Fixing this by
> zeroing the unused hash fields.

Reviewed-by: Xuan Zhuo <xuanzhuo@linux.alibaba.com>

>
> Acked-by: Michael S. Tsirkin <mst@redhat.com>
> Fixes: a2fb4bc4e2a6a ("net: implement virtio helpers to handle UDP GSO tunneling")
> Cc: <stable@vger.kernel.org>
> Signed-off-by: Jason Wang <jasowang@redhat.com>
> ---
>  include/linux/virtio_net.h | 4 ++++
>  1 file changed, 4 insertions(+)
>
> diff --git a/include/linux/virtio_net.h b/include/linux/virtio_net.h
> index 20e0584db1dd..4d1780848d0e 100644
> --- a/include/linux/virtio_net.h
> +++ b/include/linux/virtio_net.h
> @@ -401,6 +401,10 @@ virtio_net_hdr_tnl_from_skb(const struct sk_buff *skb,
>  	if (!tnl_hdr_negotiated)
>  		return -EINVAL;
>
> +        vhdr->hash_hdr.hash_value = 0;
> +        vhdr->hash_hdr.hash_report = 0;
> +        vhdr->hash_hdr.padding = 0;
> +
>  	/* Let the basic parsing deal with plain GSO features. */
>  	skb_shinfo(skb)->gso_type &= ~tnl_gso_type;
>  	ret = virtio_net_hdr_from_skb(skb, hdr, true, false, vlan_hlen);
> --
> 2.42.0
>
