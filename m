Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DECCD524CB
	for <virtualization@lists.linux-foundation.org>; Tue, 23 Jan 2024 07:02:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=140.211.166.137
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705993354; cv=none; b=Q4wAe3Ude6M1vj77IOHpJ8HMA7K0Zl4Ri4mpl8g0CkN3jxTG0eA5iW8l0PPQpHELRDRdwRuaXviV9oPuR6RSYFZ4pzzeycRcTxcMRsrPlPuLzqgMuFZuvjQ0KTOvkMtok2EwilsyRE+ReaJj5jyN7wpdEV+4YQHb6rU2lmqYM44=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705993354; c=relaxed/simple;
	bh=PckbnojtQP7fIhmpNDhDIvlrNTBhrfSCfkOehTYrNes=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 In-Reply-To:Content-Type:Content-Disposition; b=sDun/iJSW/3s1Ul93WThLgK4UKXyjihXxzta7LJh1sFBbA1lFG1ItfQvUCSHQLqJYah84ktR3aB5fxtaLdoXClDb1kFmZ7MB7H9fqiYQ8RoIwJtOW+9oLcaqvcYtIZrWcF9VdUy/Bu5mNdlHuo3vg6RjW5qsvYxempj+UV+tGdA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=bvDJGNe8; arc=none smtp.client-ip=140.211.166.137
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="bvDJGNe8"
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 758B84188C
	for <virtualization@lists.linux-foundation.org>; Tue, 23 Jan 2024 07:02:32 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org 758B84188C
Authentication-Results: smtp4.osuosl.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=bvDJGNe8
X-Virus-Scanned: amavisd-new at osuosl.org
X-Spam-Flag: NO
X-Spam-Score: -2.099
X-Spam-Level:
Received: from smtp4.osuosl.org ([127.0.0.1])
	by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id 0ZPWa8u8NlhM
	for <virtualization@lists.linux-foundation.org>;
	Tue, 23 Jan 2024 07:02:31 +0000 (UTC)
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	by smtp4.osuosl.org (Postfix) with ESMTPS id 01A27408E9
	for <virtualization@lists.linux-foundation.org>; Tue, 23 Jan 2024 07:02:30 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org 01A27408E9
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1705993349;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=TsV76N5FsHio9dpfWTXAdKJMHXRNJk86MphFy5Q6dbc=;
	b=bvDJGNe8MI3mwy7As2gg5POHC/APm2KRznWsrUMRq2YaQasac9tb/WGnegBSFqtXkCy5G+
	zNVmuxq070grCE1H6UWwIsiujeokngcYrvBUpagcNRm9SKl6iuoL2zkO3Ovt0i9NdBFAdS
	nHzDmL9NqDNMhuwmolVAqA4U7CR5AYU=
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-444-H_TsAMzBMmSvNK2N_9jUhA-1; Tue, 23 Jan 2024 02:02:27 -0500
X-MC-Unique: H_TsAMzBMmSvNK2N_9jUhA-1
Received: by mail-wr1-f69.google.com with SMTP id ffacd0b85a97d-3392814b911so1070182f8f.1
        for <virtualization@lists.linux-foundation.org>; Mon, 22 Jan 2024 23:02:26 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1705993346; x=1706598146;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=TsV76N5FsHio9dpfWTXAdKJMHXRNJk86MphFy5Q6dbc=;
        b=cXddoZMndfu2sRwvsTVTzJ5eizBKo1STYvLsGyCYMeV+rJkeGjZZsIadZIF63E/8Hb
         /kvbmeGpFMqBb6+ZMBsm6LXptEcfSQZn5PEeNf6g8LT5odkSC+Pj0a1G1thXpsso3KGA
         HugHMpt7boqLlSDJX0nA+pZlyjrDGVgeQjJgnw5SEwcN2Kl83YMpVZ50q8VylEpkur2Q
         fR0ufwA8l619KG1QYNEA8bwg7WpeeTrwDF3VixrPQsrXc7+sSTfnG+D5h/I7cx2/VxH8
         SAWVfUi+0cEj5NRYjq4d4lP3bdSOG3MtNUUKFLpF9UQvQRHeqfdM3w7KoPZr3B4ta0N2
         giIw==
X-Gm-Message-State: AOJu0YwNbzXxgo2VDp6ryRArfBv5Ao2Ubfz/Ky6UIGHjYFYlGAkrrSJg
	wDb34ltJJjidH9yK+zP9r2b8EJ1helvAnJHlgJBafAG1G+6Vs30RVQekoxuK/Z/07Oo4GHdCCxO
	iT+//rUXGXJW0EKO6WfMFuUlGeEGbLQL4FCBwCsDBimzlMDrmMRy1tmRmMgUHedjm+asLbR0DOG
	XQbpw=
X-Received: by 2002:a5d:45c8:0:b0:339:2316:2dfd with SMTP id b8-20020a5d45c8000000b0033923162dfdmr2793875wrs.55.1705993345946;
        Mon, 22 Jan 2024 23:02:25 -0800 (PST)
X-Google-Smtp-Source: AGHT+IFKPCc/VKtZ0fB34YBJ8fKJhmwOhPLSe4PAnPOQ4TN+MbrkUQsJV7uRv9FqgcBj96Znj8l10A==
X-Received: by 2002:a5d:45c8:0:b0:339:2316:2dfd with SMTP id b8-20020a5d45c8000000b0033923162dfdmr2793868wrs.55.1705993345613;
        Mon, 22 Jan 2024 23:02:25 -0800 (PST)
Received: from redhat.com ([2a06:c701:73ef:4100:2cf6:9475:f85:181e])
        by smtp.gmail.com with ESMTPSA id d6-20020adff846000000b0033725783839sm15422511wrq.110.2024.01.22.23.02.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 22 Jan 2024 23:02:24 -0800 (PST)
Date: Tue, 23 Jan 2024 02:02:22 -0500
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Liang Chen <liangchen.linux@gmail.com>
Cc: jasowang@redhat.com, virtualization@lists.linux-foundation.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH] virtio_net: Support RX hash XDP hint
Message-ID: <20240123020132-mutt-send-email-mst@kernel.org>
References: <20240122102256.261374-1-liangchen.linux@gmail.com>
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
In-Reply-To: <20240122102256.261374-1-liangchen.linux@gmail.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Mon, Jan 22, 2024 at 06:22:56PM +0800, Liang Chen wrote:
> The RSS hash report is a feature that's part of the virtio specification.
> Currently, virtio backends like qemu, vdpa (mlx5), and potentially vhost
> (still a work in progress as per [1]) support this feature. While the
> capability to obtain the RSS hash has been enabled in the normal path,
> it's currently missing in the XDP path. Therefore, we are introducing XDP
> hints through kfuncs to allow XDP programs to access the RSS hash.
> 
> Signed-off-by: Liang Chen <liangchen.linux@gmail.com>
> ---
>  drivers/net/virtio_net.c | 56 ++++++++++++++++++++++++++++++++++++++++
>  1 file changed, 56 insertions(+)
> 
> diff --git a/drivers/net/virtio_net.c b/drivers/net/virtio_net.c
> index d7ce4a1011ea..1463a4709e3c 100644
> --- a/drivers/net/virtio_net.c
> +++ b/drivers/net/virtio_net.c
> @@ -4579,6 +4579,60 @@ static void virtnet_set_big_packets(struct virtnet_info *vi, const int mtu)
>  	}
>  }
>  
> +static int virtnet_xdp_rx_hash(const struct xdp_md *_ctx, u32 *hash,
> +			   enum xdp_rss_hash_type *rss_type)
> +{
> +	const struct xdp_buff *xdp = (void *)_ctx;
> +	struct virtio_net_hdr_v1_hash *hdr_hash;
> +	struct virtnet_info *vi;
> +
> +	if (!(xdp->rxq->dev->features & NETIF_F_RXHASH))
> +		return -ENODATA;
> +
> +	vi = netdev_priv(xdp->rxq->dev);
> +	hdr_hash = (struct virtio_net_hdr_v1_hash *)(xdp->data - vi->hdr_len);
> +
> +	switch (__le16_to_cpu(hdr_hash->hash_report)) {
> +		case VIRTIO_NET_HASH_REPORT_TCPv4:
> +			*rss_type = XDP_RSS_TYPE_L4_IPV4_TCP;
> +			break;
> +		case VIRTIO_NET_HASH_REPORT_UDPv4:
> +			*rss_type = XDP_RSS_TYPE_L4_IPV4_UDP;
> +			break;
> +		case VIRTIO_NET_HASH_REPORT_TCPv6:
> +			*rss_type = XDP_RSS_TYPE_L4_IPV6_TCP;
> +			break;
> +		case VIRTIO_NET_HASH_REPORT_UDPv6:
> +			*rss_type = XDP_RSS_TYPE_L4_IPV6_UDP;
> +			break;
> +		case VIRTIO_NET_HASH_REPORT_TCPv6_EX:
> +			*rss_type = XDP_RSS_TYPE_L4_IPV6_TCP_EX;
> +			break;
> +		case VIRTIO_NET_HASH_REPORT_UDPv6_EX:
> +			*rss_type = XDP_RSS_TYPE_L4_IPV6_UDP_EX;
> +			break;
> +		case VIRTIO_NET_HASH_REPORT_IPv4:
> +			*rss_type = XDP_RSS_TYPE_L3_IPV4;
> +			break;
> +		case VIRTIO_NET_HASH_REPORT_IPv6:
> +			*rss_type = XDP_RSS_TYPE_L3_IPV6;
> +			break;
> +		case VIRTIO_NET_HASH_REPORT_IPv6_EX:
> +			*rss_type = XDP_RSS_TYPE_L3_IPV6_EX;
> +			break;
> +		case VIRTIO_NET_HASH_REPORT_NONE:
> +		default:
> +			*rss_type = XDP_RSS_TYPE_NONE;
> +	}
> +
> +	*hash = __le32_to_cpu(hdr_hash->hash_value);
> +	return 0;
> +}
> +
> +static const struct xdp_metadata_ops virtnet_xdp_metadata_ops = {
> +	.xmo_rx_hash			= virtnet_xdp_rx_hash,
> +};
> +
>  static int virtnet_probe(struct virtio_device *vdev)
>  {
>  	int i, err = -ENOMEM;
> @@ -4613,6 +4667,8 @@ static int virtnet_probe(struct virtio_device *vdev)
>  	dev->ethtool_ops = &virtnet_ethtool_ops;
>  	SET_NETDEV_DEV(dev, &vdev->dev);
>  
> +	dev->xdp_metadata_ops = &virtnet_xdp_metadata_ops;
> +

How about making this assignment depend on 

xdp->rxq->dev->features & NETIF_F_RXHASH

?

>  	/* Do we support "hardware" checksums? */
>  	if (virtio_has_feature(vdev, VIRTIO_NET_F_CSUM)) {
>  		/* This opens up the world of extra features. */
> -- 
> 2.40.1

