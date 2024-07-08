Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A7F347E103
	for <virtualization@lists.linux-foundation.org>; Mon,  8 Jul 2024 11:26:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=140.211.166.136
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720437986; cv=none; b=BnKE4YJSB1JEfLKA14pZJSXm8M6rHEqHVSf03vIv/N7OH17jxenCebawTIywG4C+EHGkFpoowAFwwM5R1dzL9Ph+b7M9YYUe1Dxb3+c+/ssFc97JvvXOXL0vXOJ7Pv5Gj1IShIh2pvmeNXlFzwM1cLtXsOg/vD1toVxxGfvwEyw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720437986; c=relaxed/simple;
	bh=BiZcXjD0MF9+4zB3dvLvvXJajt6y3TabHLQgZnFuMWQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 In-Reply-To:Content-Type:Content-Disposition; b=JEGdIOMiKZ49RpUpioH0h10yOzCPPFvUK8MD4RfoG23EKNx7ED0Tc7//QKntx5el5uJ7BwnD0VTg6ULM19Oa8f4L8HaxTuTFMQI1mQF3qF4UmrX9CCGVZAHwEdijwAB74MTtZpXtflzAAaMP5Qn61J35paBe+0ujDGWN1q5XuU0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=LQ2uiRb4; arc=none smtp.client-ip=140.211.166.136
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="LQ2uiRb4"
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 5057A6084D
	for <virtualization@lists.linux-foundation.org>; Mon,  8 Jul 2024 11:26:25 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
X-Spam-Flag: NO
X-Spam-Score: -2.099
X-Spam-Level:
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id gc3U5UTMg-XO for <virtualization@lists.linux-foundation.org>;
 Mon,  8 Jul 2024 11:26:24 +0000 (UTC)
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=170.10.133.124; helo=us-smtp-delivery-124.mimecast.com; envelope-from=mst@redhat.com; receiver=<UNKNOWN> 
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp3.osuosl.org 91B61607F8
Authentication-Results: smtp3.osuosl.org; dmarc=pass (p=none dis=none) header.from=redhat.com
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 91B61607F8
Authentication-Results: smtp3.osuosl.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=LQ2uiRb4
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	by smtp3.osuosl.org (Postfix) with ESMTPS id 91B61607F8
	for <virtualization@lists.linux-foundation.org>; Mon,  8 Jul 2024 11:26:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1720437983;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=H+1JhCgg1e3xAL9ukropoVjm3oRaKeBDSlDAr3D/8Qw=;
	b=LQ2uiRb4y0F2J7JPP2jAPWoWTFUClBHHxp2E+Qbd89I8uOrZAy+inh3DFb+Y0T01VSpxfT
	7kRMCTXTJgz1y0YPpDMDv0BZun1XsEXlSKFRrtJ0nARZ75C9GkJMGehmCOOj0I860W6vYt
	sA3AjlHCyyCschv7y8MIsnJ2OAY1kCQ=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-10-d5P4lDGZPOOkV0jY-138iw-1; Mon, 08 Jul 2024 07:26:22 -0400
X-MC-Unique: d5P4lDGZPOOkV0jY-138iw-1
Received: by mail-wm1-f69.google.com with SMTP id 5b1f17b1804b1-42668796662so9399565e9.2
        for <virtualization@lists.linux-foundation.org>; Mon, 08 Jul 2024 04:26:21 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1720437981; x=1721042781;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=H+1JhCgg1e3xAL9ukropoVjm3oRaKeBDSlDAr3D/8Qw=;
        b=XLudiP4oaQJQDIG2DVg0Pk92f4zMvvV+Jk9KVSq7xYCa63m56q3HYmlSZajKlz+gRd
         sk3SotKPHPcgCE/Ev2gse8TAuI993Lp16wqG66Tn4IzOsaibconmBOLTgl+MHoFfz3ZY
         p+Zc9PseU6fQP66bHxD0sd+bO81cPGBfHXveCIPwNDS1+RkgTWksjvfxbODFWJpPa4Nk
         ZiGSu4eY97Xo8qKWSnlm4sVFpKb7nXshYKmZrLM7bqITNQtLHgqHG+puaC9Bq5YU+Fen
         iICTWCl8b4q5xQE0KJBjGMfNlxYGeF8Jt1L2SJMAzEzK447NVrDvtuLw07YnMHm4bW/R
         vBmQ==
X-Forwarded-Encrypted: i=1; AJvYcCVSa8Z6JyMwudBR3upUplTWI++ijVzdQSpXZ5hM9g7OSrdNQhEuupudzw4AbM1n3MxUXWA4qpwOQd5Vd5Jx5HlPo0yOX8GXJy7iZtUiYagSyvlwoHkqpvhEpQ==
X-Gm-Message-State: AOJu0YwotrZbVevDAz2h21k8wbzXBwBRLb9T/mEYzcSQ2MllzRGaVKsi
	h+Ojd7Mg58fbJnKLKrlcIz8G+dbKdNFIAET462mtj3YklsjwA3p2Xo3kxwaQMJ3J0qiGa8o31Vl
	Fx0l6M3CQFZ0oU9UhFENiKH9XbddDjNkOpDH2x4taQrEZHppdfutkt7uvLeZW5TqySVMcg7u9gx
	495uY=
X-Received: by 2002:a05:600c:1d11:b0:426:6e9a:7a1e with SMTP id 5b1f17b1804b1-4266e9a7b2cmr4958715e9.35.1720437980863;
        Mon, 08 Jul 2024 04:26:20 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGGpA7ji/rZ+8HL55hEF/BG5Syq+7fVBtOtgJNBvAR3h2aS4f0cQ39/TmwMykXfwdCiYI7Sog==
X-Received: by 2002:a05:600c:1d11:b0:426:6e9a:7a1e with SMTP id 5b1f17b1804b1-4266e9a7b2cmr4958475e9.35.1720437980375;
        Mon, 08 Jul 2024 04:26:20 -0700 (PDT)
Received: from redhat.com ([2.52.29.103])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4265c2a99c7sm59914285e9.1.2024.07.08.04.26.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 08 Jul 2024 04:26:19 -0700 (PDT)
Date: Mon, 8 Jul 2024 07:26:15 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Cindy Lu <lulu@redhat.com>
Cc: dtatulea@nvidia.com, jasowang@redhat.com, parav@nvidia.com,
	sgarzare@redhat.com, netdev@vger.kernel.org,
	virtualization@lists.linux-foundation.org,
	linux-kernel@vger.kernel.org, kvm@vger.kernel.org
Subject: Re: [PATCH] vdpa/mlx5: Add the support of set mac address
Message-ID: <20240708072603-mutt-send-email-mst@kernel.org>
References: <20240708065549.89422-1-lulu@redhat.com>
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
In-Reply-To: <20240708065549.89422-1-lulu@redhat.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Mon, Jul 08, 2024 at 02:55:49PM +0800, Cindy Lu wrote:
> Add the function to support setting the MAC address.
> For vdpa/mlx5, the function will use mlx5_mpfs_add_mac
> to set the mac address
> 
> Tested in ConnectX-6 Dx device
> 
> Signed-off-by: Cindy Lu <lulu@redhat.com>

Is this on top of your other patchset?

> ---
>  drivers/vdpa/mlx5/net/mlx5_vnet.c | 23 +++++++++++++++++++++++
>  1 file changed, 23 insertions(+)
> 
> diff --git a/drivers/vdpa/mlx5/net/mlx5_vnet.c b/drivers/vdpa/mlx5/net/mlx5_vnet.c
> index 26ba7da6b410..f78701386690 100644
> --- a/drivers/vdpa/mlx5/net/mlx5_vnet.c
> +++ b/drivers/vdpa/mlx5/net/mlx5_vnet.c
> @@ -3616,10 +3616,33 @@ static void mlx5_vdpa_dev_del(struct vdpa_mgmt_dev *v_mdev, struct vdpa_device *
>  	destroy_workqueue(wq);
>  	mgtdev->ndev = NULL;
>  }
> +static int mlx5_vdpa_set_attr_mac(struct vdpa_mgmt_dev *v_mdev,
> +				  struct vdpa_device *dev,
> +				  const struct vdpa_dev_set_config *add_config)
> +{
> +	struct mlx5_vdpa_dev *mvdev = to_mvdev(dev);
> +	struct mlx5_vdpa_net *ndev = to_mlx5_vdpa_ndev(mvdev);
> +	struct mlx5_core_dev *mdev = mvdev->mdev;
> +	struct virtio_net_config *config = &ndev->config;
> +	int err;
> +	struct mlx5_core_dev *pfmdev;
> +
> +	if (add_config->mask & (1 << VDPA_ATTR_DEV_NET_CFG_MACADDR)) {
> +		if (!is_zero_ether_addr(add_config->net.mac)) {
> +			memcpy(config->mac, add_config->net.mac, ETH_ALEN);
> +			pfmdev = pci_get_drvdata(pci_physfn(mdev->pdev));
> +			err = mlx5_mpfs_add_mac(pfmdev, config->mac);
> +			if (err)
> +				return -1;
> +		}
> +	}
> +	return 0;
> +}
>  
>  static const struct vdpa_mgmtdev_ops mdev_ops = {
>  	.dev_add = mlx5_vdpa_dev_add,
>  	.dev_del = mlx5_vdpa_dev_del,
> +	.dev_set_attr = mlx5_vdpa_set_attr_mac,
>  };
>  
>  static struct virtio_device_id id_table[] = {
> -- 
> 2.45.0

