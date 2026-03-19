Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2EAD83E558E
	for <virtualization@lists.linux.dev>; Thu, 19 Mar 2026 15:26:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773934009; cv=none; b=BfDKQ2jihuW93BZpxZAAqhkgl3NioiwR7C9YiPdqxbAagS+HOq/71BTBq5lmyMj/LSMzX9BrlTsFrv/PhggFP/SX9EHKf2fZRhd/2IkM8onyWUF6qfgMO94VabHDFjK6BLLrBjXwPrm+1TPssd0VZjMc9Tt4cBM09uon/uaGkXo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773934009; c=relaxed/simple;
	bh=8u9XVghpeZayjXE20GtvjRqRjcPfiLDqL51fDWUW2GA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 In-Reply-To:Content-Type:Content-Disposition; b=aey0Xb+NRE/eWSjzLHeuRpmkNsR6krIrovVTTf6qU4faqRvc64jzr8MoyOmZ5197NsVwGRMZoDeZWYGOLsugRt8xHVK7Lkn8wD2w1ZJwJOKLaNqLW97G1ENTcFq7yMnjA5dIvS6LeIIWkZH2uF/I2B7MGALwYi/vMR26ci+rYjM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=VbJULAXv; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="VbJULAXv"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1773934003;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=aqMFvMUuTu6qfzQanxBGrjvh23hJYBpTzo7fMX6Yp2Y=;
	b=VbJULAXvFoRbp8qZewcZ3LHQn38KN56ORJxj2XLvvdp37e3IS0oYoak1VesxgbihQdfbMZ
	8d9ZerkmEo8kVBvyX9lNUQIfk7w6ss9t3coe19O1lwKvDfWnEqEpKrivxWshx86MFrqYrR
	tD4GXy4TodCle/0x1undLS9UW4Wei7A=
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-170-c8n1lVTCN-q4EN8ZVS04Aw-1; Thu, 19 Mar 2026 11:26:42 -0400
X-MC-Unique: c8n1lVTCN-q4EN8ZVS04Aw-1
X-Mimecast-MFC-AGG-ID: c8n1lVTCN-q4EN8ZVS04Aw_1773934001
Received: by mail-wr1-f72.google.com with SMTP id ffacd0b85a97d-439f5c57c52so699572f8f.1
        for <virtualization@lists.linux.dev>; Thu, 19 Mar 2026 08:26:42 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1773934001; x=1774538801;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=aqMFvMUuTu6qfzQanxBGrjvh23hJYBpTzo7fMX6Yp2Y=;
        b=PYTSFrceeOorsvIKkIin+v/WEtI9pCnpbAkoKgZqhZ3VQIMvcfz3af7M2iuErVJcvv
         bHI11ynzdN29/CjmwraoI0S3XGQ/SBCCzAUv7s0JPyYuS+h0GXVEIEcyW9UKmJtBWMJ3
         yT6oz6fmPdzxL9QvrvsrINDnsMTgOGYMJRo7bVO8KFb0blg2gtMcIu8whiP9XWw+kB+v
         RIuuBmgfpeW6oTTWc4gPQtrJuvJO+dGZj32XcLXgLRwZNbGMZ8Lb9nckIL/FGTrsYK+F
         GU7n86UI8QJ5U5SKPiQIgVeIKdQPmyP0LQcTEKAlPIu1+xUisgFlkjwiHREIOrH7oRjn
         EfPg==
X-Forwarded-Encrypted: i=1; AJvYcCUSsZIQaYC5o+U0GiEAHa56v8jLy/F88/IXeOzJ/UCeGUwTC2mwi0N8YOUgaQEcVN6u8CbFBCRhgAZpBhlstg==@lists.linux.dev
X-Gm-Message-State: AOJu0YyycKKkL/So5Fwsg/u8TnkCOTEoapyE/480151jFMq4FTdfR3TR
	aKfUMpIu5iNNHFVCI19oz+HKXx0jZ0NUhe0gMeKSXbJJvbhRPHOuTrkD+nM8k0K/PeZVNZOMSwg
	h3eAHzN/sseTAWeYV4jovwYp6fbupp2oyyya3GBDwZI8AGjQRf8zFTKCy9II9eJMfdL/z
X-Gm-Gg: ATEYQzxe9DFv/9tWsEj2BUm9jaJU+SRPTd5Q7aYvdV5H+ZpYoHf5Zto5yBQ8T+9xrN+
	IcgGBtos5FK4GVIuK0K6BYhd5iTCp3mpGgj6v/MwIWHcwVNx7kPDbAN3bxNnDoRm8zZcs7Y40zb
	Uo0ILz2wP6fRWSVsGlrd29BmYfhnx8x0Bs2djDptS4JVO74WTxeZWqLdGc0koQqgiUl1sxefp7/
	QAtX+15RWSmMA/xZKgieuQKbhu63d5/1ZanRNceqcdIcFTAWMMsUdoc6oBzZYg3SCq6IIsGoMMo
	MXJy/Tn3pda/+S/LHZ6Fmu4JixO1w79U90VIg9GGNRDCU/AclPUWgUbuVASBFK9dsIBGVViCslD
	qX0fBiJjswd1h+2hC
X-Received: by 2002:a05:6000:2285:b0:439:d8e2:9a40 with SMTP id ffacd0b85a97d-43b527cba00mr12920961f8f.55.1773934001099;
        Thu, 19 Mar 2026 08:26:41 -0700 (PDT)
X-Received: by 2002:a05:6000:2285:b0:439:d8e2:9a40 with SMTP id ffacd0b85a97d-43b527cba00mr12920891f8f.55.1773934000426;
        Thu, 19 Mar 2026 08:26:40 -0700 (PDT)
Received: from redhat.com ([2a0d:6fc0:1525:da00:3ac2:1a22:72ff:4256])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-43b518a3d78sm18187742f8f.34.2026.03.19.08.26.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 19 Mar 2026 08:26:39 -0700 (PDT)
Date: Thu, 19 Mar 2026 11:26:37 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Kenner de Azevedo dos Santos Miranda <kenner.linuxdev@gmail.com>
Cc: jasowang@redhat.com, xuanzhuo@linux.alibaba.com, eperezma@redhat.com,
	virtualization@lists.linux.dev, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] virtio: fix kernel-doc warnings for virtio_device
Message-ID: <20260319112552-mutt-send-email-mst@kernel.org>
References: <20260312105139.60811-1-kenner.linuxdev@gmail.com>
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
In-Reply-To: <20260312105139.60811-1-kenner.linuxdev@gmail.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: wXmSwJkmGOnFITQXM66qh37KudVGbfUrRlVod30XVfE_1773934001
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Thu, Mar 12, 2026 at 06:51:39AM -0400, Kenner de Azevedo dos Santos Miranda wrote:
> The following warnings were reported when running 'make htmldocs':
> 
>   WARNING: ./include/linux/virtio.h:188 struct member 'map'
>   not described in 'virtio_device'
> 
>   WARNING: ./include/linux/virtio.h:188 struct member
>   'VIRTIO_DECLARE_FEATURES(features' not described in
>   'virtio_device'
> 
>   WARNING: ./include/linux/virtio.h:188 struct member 'vmap'
>   not described in 'virtio_device'
> 
> Document the map and vmap fields in struct virtio_device.
> 
> Also avoid kernel-doc confusion caused by the VIRTIO_DECLARE_FEATURES()
> macro by documenting the logical @features field.
> 
> After these changes, running 'make htmldocs' no longer reports warnings
> for map, vmap, or VIRTIO_DECLARE_FEATURES().
> 
> Signed-off-by: Kenner de Azevedo dos Santos Miranda <kenner.linuxdev@gmail.com>


I will queue this. Thanks!

> ---
>  include/linux/virtio.h | 5 ++++-
>  1 file changed, 4 insertions(+), 1 deletion(-)
> 
> diff --git a/include/linux/virtio.h b/include/linux/virtio.h
> index 3bbc4cb6a672..074d36453177 100644
> --- a/include/linux/virtio.h
> +++ b/include/linux/virtio.h
> @@ -157,11 +157,13 @@ struct virtio_admin_cmd {
>   * @id: the device type identification (used to match it with a driver).
>   * @config: the configuration ops for this device.
>   * @vringh_config: configuration ops for host vrings.
> + * @map: virtio specific mapping operations used by the device or transport.
>   * @vqs: the list of virtqueues for this device.
>   * @features: the 64 lower features supported by both driver and device.
>   * @features_array: the full features space supported by both driver and
> - *		    device.
> + *                device.
>   * @priv: private pointer for the driver's use.
> + * @vmap: mapping token passed to virtio mapping helpers and transport ops.
>   * @debugfs_dir: debugfs directory entry.
>   * @debugfs_filter_features: features to be filtered set by debugfs.
>   */
> @@ -179,6 +181,7 @@ struct virtio_device {
>  	const struct vringh_config_ops *vringh_config;
>  	const struct virtio_map_ops *map;
>  	struct list_head vqs;
> +       /* See @features */
>  	VIRTIO_DECLARE_FEATURES(features);
>  	void *priv;
>  	union virtio_map vmap;
> -- 
> 2.43.0

