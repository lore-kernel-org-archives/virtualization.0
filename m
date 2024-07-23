Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7675F15216A
	for <virtualization@lists.linux-foundation.org>; Tue, 23 Jul 2024 11:29:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=140.211.166.138
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721734162; cv=none; b=EuNSIUdBdT7vjmck5VMR08qM/qSA7D9FQ6ARfzOaYFRDJEkQUjgT2k/656j5KFp05hMJGwOchR/GfgfI0uqkt3kjhNerzqNW8Pm7uZsuorkD3uXpJprgz26r6KAMzjEy3WF/nNQnac43H9SM7kfCNDqb8eXMLgB/X4pKZVGCN5A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721734162; c=relaxed/simple;
	bh=ywiEz9lNEQ9WmelnvEr3eWbFdDAiCBnoLZvMkLA1J4w=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 In-Reply-To:Content-Type:Content-Disposition; b=EqqqFYNv7+MG7LTPPkpEfWn7rndPCHCUiuHqrMN8zhZwj2DmdZcXXZZP5A5fKdfO/6K1cuvJ1W6UjyNUZgQJPZ2vXolAP9GK+ph7gdZhKShS8+1bqjMw/phniKJKyvDAEl/ef8JVQb/S41Qfbz+ZWD4g5S0G1JI6iUIi9vhPmHA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=XaJqXoHb; arc=none smtp.client-ip=140.211.166.138
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="XaJqXoHb"
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id F0ECB80E2B
	for <virtualization@lists.linux-foundation.org>; Tue, 23 Jul 2024 11:29:20 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
X-Spam-Flag: NO
X-Spam-Score: -2.099
X-Spam-Level:
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 31qRmVTCl9sd for <virtualization@lists.linux-foundation.org>;
 Tue, 23 Jul 2024 11:29:20 +0000 (UTC)
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=170.10.129.124; helo=us-smtp-delivery-124.mimecast.com; envelope-from=mst@redhat.com; receiver=<UNKNOWN> 
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp1.osuosl.org 3584F80584
Authentication-Results: smtp1.osuosl.org; dmarc=pass (p=none dis=none) header.from=redhat.com
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 3584F80584
Authentication-Results: smtp1.osuosl.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=XaJqXoHb
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	by smtp1.osuosl.org (Postfix) with ESMTPS id 3584F80584
	for <virtualization@lists.linux-foundation.org>; Tue, 23 Jul 2024 11:29:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1721734158;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=s7jCTUnDItxD8cjWWIIoCSjBuZfVeWntboTVzts3D7o=;
	b=XaJqXoHbPkrTBwYkEoMI0DP4JRrZj0OfypKTkORfsUw7xm5zComkMXDRSqzCzBeEuAFrR7
	lxUQ9tSlizR6kb7qkKE3Jf3p2B00Bc9LmLNDxKf01Q8nrVqUZ/7K72RQVEku2ZxjQqWF5b
	5UM2jsoHAgjzBVFLHRrw1U+BAyhFF1Q=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-101-fhzJ4pnAMauTJRxEx-dhoQ-1; Tue, 23 Jul 2024 07:29:16 -0400
X-MC-Unique: fhzJ4pnAMauTJRxEx-dhoQ-1
Received: by mail-wm1-f69.google.com with SMTP id 5b1f17b1804b1-42725ef39e2so38856835e9.0
        for <virtualization@lists.linux-foundation.org>; Tue, 23 Jul 2024 04:29:16 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1721734155; x=1722338955;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=s7jCTUnDItxD8cjWWIIoCSjBuZfVeWntboTVzts3D7o=;
        b=td1W/6EaclgHNFTHKgdlAAdBnMuw7qekgvnlIgzYP1I10twdQbFn68/S2fkIt+jduy
         gCS09bYzMhQajes2A+I/7wMJGJdhLQjkpmoHScoERjMbkpHzKLARfjsNCS4638X54wkz
         gHFOqrPdJb8pFAR/yoKhwvTi4O/jjcZ16VrYt9kOPe3oArNLB3XHjvwLpUmx26mzMKQk
         oo3Ej2SzrsNiqx6n13lW9kXBOEAHKFjwwAty5nmSNkSVDajpxnrNimlWFXe+CCKLAAZf
         R0H4RJwlzXRdwko453aE8gwlNTGT7twsPtSc/TEjj90Qwi+UwurJiIiABqdjuR1qWiwb
         +8KA==
X-Forwarded-Encrypted: i=1; AJvYcCVtVTtqMM1CiI7W8vPIfFkoXNWuxGAx8tjtdiisiU76WLsfOredN4BYNUE1QCgX3FSxBOS3ntZuKWT6tRBfUZUVqCajX7VzEQO1rbo2Wp/6sDVQHVidGs4N8g==
X-Gm-Message-State: AOJu0YxKtii2K8S9J0gvpGkcXGfSTtWDSSykN9fg7l4qNop2mNzAhllp
	XilxMhBxA4JcuOuLOKRC66gl20AaSP3H9PVoZhseUUOMD1cXFv23fZZ+A1yqLPZRbcMzaSUX/Bw
	ZIBVimRK6jMSwBczcA4/I+ga51juXiDZQW56E+mUhc4m2PMKvxJKCrCaBuHszkpZotZG9zHdw2C
	ctqBE=
X-Received: by 2002:a05:600c:198a:b0:426:5ef5:bcb1 with SMTP id 5b1f17b1804b1-427dc516030mr62453865e9.6.1721734155393;
        Tue, 23 Jul 2024 04:29:15 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEy8f4+JM8Dv9qpEpAG+F85IIgy6v0jInHBiNNS5aGKN9kSnvuaOCv+YAidUy3L2q08C0jGsg==
X-Received: by 2002:a05:600c:198a:b0:426:5ef5:bcb1 with SMTP id 5b1f17b1804b1-427dc516030mr62453655e9.6.1721734154739;
        Tue, 23 Jul 2024 04:29:14 -0700 (PDT)
Received: from redhat.com ([2a0d:6fc7:440:9c9a:ffee:509d:1766:aa7f])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-427d2a95530sm187309455e9.45.2024.07.23.04.29.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 23 Jul 2024 04:29:14 -0700 (PDT)
Date: Tue, 23 Jul 2024 07:29:10 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Dragos Tatulea <dtatulea@nvidia.com>
Cc: Parav Pandit <parav@nvidia.com>,
	"sgarzare@redhat.com" <sgarzare@redhat.com>,
	"virtualization@lists.linux-foundation.org" <virtualization@lists.linux-foundation.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"lulu@redhat.com" <lulu@redhat.com>,
	"netdev@vger.kernel.org" <netdev@vger.kernel.org>,
	"jasowang@redhat.com" <jasowang@redhat.com>
Subject: Re: [PATH v5 3/3] vdpa/mlx5: Add the support of set mac address
Message-ID: <20240723072712-mutt-send-email-mst@kernel.org>
References: <20240723054047.1059994-1-lulu@redhat.com>
 <20240723054047.1059994-4-lulu@redhat.com>
 <d8031e518cf47c57c31b903cb9613692bbff7d0d.camel@nvidia.com>
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
In-Reply-To: <d8031e518cf47c57c31b903cb9613692bbff7d0d.camel@nvidia.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Tue, Jul 23, 2024 at 07:49:44AM +0000, Dragos Tatulea wrote:
> On Tue, 2024-07-23 at 13:39 +0800, Cindy Lu wrote:
> > Add the function to support setting the MAC address.
> > For vdpa/mlx5, the function will use mlx5_mpfs_add_mac
> > to set the mac address
> > 
> > Tested in ConnectX-6 Dx device
> > 
> > Signed-off-by: Cindy Lu <lulu@redhat.com>
> > ---
> >  drivers/vdpa/mlx5/net/mlx5_vnet.c | 28 ++++++++++++++++++++++++++++
> >  1 file changed, 28 insertions(+)
> > 
> > diff --git a/drivers/vdpa/mlx5/net/mlx5_vnet.c b/drivers/vdpa/mlx5/net/mlx5_vnet.c
> > index ecfc16151d61..7fce952d650f 100644
> > --- a/drivers/vdpa/mlx5/net/mlx5_vnet.c
> > +++ b/drivers/vdpa/mlx5/net/mlx5_vnet.c
> > @@ -3785,10 +3785,38 @@ static void mlx5_vdpa_dev_del(struct vdpa_mgmt_dev *v_mdev, struct vdpa_device *
> >  	destroy_workqueue(wq);
> >  	mgtdev->ndev = NULL;
> >  }
> > +static int mlx5_vdpa_set_attr(struct vdpa_mgmt_dev *v_mdev,
> > +			      struct vdpa_device *dev,
> > +			      const struct vdpa_dev_set_config *add_config)
> > +{
> > +	struct virtio_net_config *config;
> > +	struct mlx5_core_dev *pfmdev;
> > +	struct mlx5_vdpa_dev *mvdev;
> > +	struct mlx5_vdpa_net *ndev;
> > +	struct mlx5_core_dev *mdev;
> > +	int err = -EINVAL;
> > +
> > +	mvdev = to_mvdev(dev);
> > +	ndev = to_mlx5_vdpa_ndev(mvdev);
> > +	mdev = mvdev->mdev;
> > +	config = &ndev->config;
> > +
> > +	down_write(&ndev->reslock);
> > +	if (add_config->mask & (1 << VDPA_ATTR_DEV_NET_CFG_MACADDR)) {
> > +		pfmdev = pci_get_drvdata(pci_physfn(mdev->pdev));
> > +		err = mlx5_mpfs_add_mac(pfmdev, config->mac);
> > +		if (0 == err)
> if (!err) would be nicer. Not a deal breaker though.

	yes, no yodda style please. It, I can not stand.


> Reviewed-by: Dragos Tatulea <dtatulea@nvidia.com>
> 
> > +			memcpy(config->mac, add_config->net.mac, ETH_ALEN);
> > +	}
> > +
> > +	up_write(&ndev->reslock);
> > +	return err;
> > +}
> >  
> >  static const struct vdpa_mgmtdev_ops mdev_ops = {
> >  	.dev_add = mlx5_vdpa_dev_add,
> >  	.dev_del = mlx5_vdpa_dev_del,
> > +	.dev_set_attr = mlx5_vdpa_set_attr,
> >  };
> >  
> >  static struct virtio_device_id id_table[] = {
> 

