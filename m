Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6B3913191D4
	for <virtualization@lists.linux.dev>; Wed, 26 Nov 2025 23:31:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764199888; cv=none; b=S5SIr0PZdBXIpYMUVSDztHVGRst38gd9YcAJdL0xU1LqhM5yh8YFRnD+RT1oaQsXFUFp6cTJth+phhumwOh0joIxbRfqbacpQZ04LEEvKcxfcH4UyHOHwoFCfVdX1YfAIuhjBxs38ifRxeYjGFn3GYwfcO1uIuHvTMWZMDMWQ18=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764199888; c=relaxed/simple;
	bh=yFNIi8DTjY/UB56wGpgXzrHmqQnS+mB0/nAhgkygiK0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 In-Reply-To:Content-Type:Content-Disposition; b=A5LrBTKz/wUimpobl7DdcJpYPDw/V0cbWMh+pXDXyxTRI30BG5P0uVl09khnMBAZWsQFGh0h2kZkPTJMoQPI9GIAKBwdcZ6RiFHrU19HwcCoZ0keqPVGqzlDlRXbzMIEExTuaqENS8boY+NApSQcaDN84lslI2sqk60YyRkWibc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=CnWGZ8sO; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="CnWGZ8sO"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1764199886;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=BBj4v5CDhCaSOnmP98D4k4FodyYHO+5JcI7F7kgJOdE=;
	b=CnWGZ8sOnlDrKWTppIXy9rmMoJiaZVRVZySZsOjHw3wJ8UVFWqSGaqTIDUeuMVFh1vzpTy
	hxwm64XtGUy2p4s0DXp/o9yP1rFV8TkGHA2kj+Hv/jeJGe7jPboXNIjgavu3dyuKFcUmKk
	55u9YO5rqUFlIqQcN/PxD84mwuFPOOQ=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-533-mYq_M0dXO8K2m4rUzW54TA-1; Wed, 26 Nov 2025 18:31:23 -0500
X-MC-Unique: mYq_M0dXO8K2m4rUzW54TA-1
X-Mimecast-MFC-AGG-ID: mYq_M0dXO8K2m4rUzW54TA_1764199882
Received: by mail-wm1-f70.google.com with SMTP id 5b1f17b1804b1-477563a0c75so897875e9.1
        for <virtualization@lists.linux.dev>; Wed, 26 Nov 2025 15:31:22 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1764199882; x=1764804682;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=BBj4v5CDhCaSOnmP98D4k4FodyYHO+5JcI7F7kgJOdE=;
        b=MAcAdxJQD/PSZ2cMw6foWUQv+LH2aFYnRwF15fyP8L7AKZILAgpzxBpNd7piOqv+gG
         ED8+kbmhqa5I7FxpJu+bt0e8w0cem5x3KxFG9SluMyagC+ta6RinG4DK/vsOo5u7AR3x
         u8tGrf9/jD4N6VsicZyvvd9GXFQ9gHuJ8Xysg/hZqbkX6sYPafdWYP+asklHTlHE+B8d
         PaQkXhJMgeVYrMaEAuLBMiCKWdVZu944AoPsP35ZdLuf/FuiQgPJskLmA34eKYxvwD7N
         BPzgr72yTWuhmhZaLVQD6Zf6Wj1qdGwfic0lD+rszmiyvNnFPR3/U9Tn7B+NxvA9MCPR
         ZfJQ==
X-Forwarded-Encrypted: i=1; AJvYcCXJbl/iAjHQiz8SQMVKYe43eUpKNYOJGRc/SRaVYVKAwW0CxukYMhg0C3IvWMArLZGLdK8j1QaAJEKXHqvvGw==@lists.linux.dev
X-Gm-Message-State: AOJu0YwpB9FdwcJok22vwaNXtpctqxd8mDoSfciJ2SPN9nw2P6909YSt
	0n6/RcvHnzfWooDdxZbFFkl4DJF14QQ08T5H4kvwC+19bj++7w11+zE31MypedBH3IXFvbDCPnh
	n0Y/Cb4r0ID4las5ICP5xX/Ipvny1mrp3qHABpvCZM3U8Gge68UilYaaqqN/jlrW3evfJ
X-Gm-Gg: ASbGncsm6f73kol6AVACcoTByVEL8zn+K+Tx6TlVVZjQAar60dEa+6jprAGeFu5GXPr
	xodqaIZqknonidfnIeK5jsXnIvOjIOF1IgLvt3uRCgMWL4uAmLZen3JUnDemI+tVi1PVqMZqN81
	6YiGQaCx6+s/VvsJVz3IOPLQF42BDYm9TVRM81abNNAycby01OSY7fe1GpcpeOBKHV0sP9IG2hJ
	+CJCYnVkwlzb5tHXds6IgQO2dW74VlRKraGCntochxrmBrkUrmzh3DORVbLVKcsebxv9TCjAmot
	JoWgUCXlWHudtpERiZmvBFxZ8SLtjDJFi4rOST+lXcJnBKR7ZNpIY2uJsZ+I0fMuWEQMT8nWPBE
	ib3RHb1RG/BVe924m2EtXgUveuLbdXw==
X-Received: by 2002:a05:600c:21cb:b0:477:acb7:7141 with SMTP id 5b1f17b1804b1-4790f03337dmr23815415e9.3.1764199881837;
        Wed, 26 Nov 2025 15:31:21 -0800 (PST)
X-Google-Smtp-Source: AGHT+IHvsPc8i4qlwSOov+ZFIUbJXh0qRN5MOs/+9Y7azH6GR/o2n03YQmnKCjFnc5uZOpB6h284EQ==
X-Received: by 2002:a05:600c:21cb:b0:477:acb7:7141 with SMTP id 5b1f17b1804b1-4790f03337dmr23815225e9.3.1764199881338;
        Wed, 26 Nov 2025 15:31:21 -0800 (PST)
Received: from redhat.com (IGLD-80-230-39-63.inter.net.il. [80.230.39.63])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-47906cb9715sm52884525e9.2.2025.11.26.15.31.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 26 Nov 2025 15:31:20 -0800 (PST)
Date: Wed, 26 Nov 2025 18:31:17 -0500
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Daniel Jurgens <danielj@nvidia.com>
Cc: netdev@vger.kernel.org, jasowang@redhat.com, pabeni@redhat.com,
	virtualization@lists.linux.dev, parav@nvidia.com,
	shshitrit@nvidia.com, yohadt@nvidia.com, xuanzhuo@linux.alibaba.com,
	eperezma@redhat.com, jgg@ziepe.ca, kevin.tian@intel.com,
	kuba@kernel.org, andrew+netdev@lunn.ch, edumazet@google.com
Subject: Re: [PATCH net-next v13 05/12] virtio_net: Query and set flow filter
 caps
Message-ID: <20251126182919-mutt-send-email-mst@kernel.org>
References: <20251126193539.7791-1-danielj@nvidia.com>
 <20251126193539.7791-6-danielj@nvidia.com>
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
In-Reply-To: <20251126193539.7791-6-danielj@nvidia.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: U2p3dQQD8innB3yO-Bk7sg2zOE0lkVunzz9lbtu0nLE_1764199882
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Wed, Nov 26, 2025 at 01:35:32PM -0600, Daniel Jurgens wrote:
> @@ -5812,6 +6019,17 @@ static int virtnet_restore_up(struct virtio_device *vdev)
>  			return err;
>  	}
>  
> +	/* Initialize flow filters. Not supported is an acceptable and common
> +	 * return code
> +	 */
> +	rtnl_lock();
> +	err = virtnet_ff_init(&vi->ff, vi->vdev);
> +	if (err && err != -EOPNOTSUPP) {
> +		rtnl_unlock();
> +		return err;

does not look like this rolls back previous
initialization on error (probe does).


> +	}
> +	rtnl_unlock();
> +
>  	netif_tx_lock_bh(vi->dev);
>  	netif_device_attach(vi->dev);
>  	netif_tx_unlock_bh(vi->dev);
> @@ -7145,6 +7363,15 @@ static int virtnet_probe(struct virtio_device *vdev)
>  	}
>  	vi->guest_offloads_capable = vi->guest_offloads;
>  
> +	/* Initialize flow filters. Not supported is an acceptable and common
> +	 * return code
> +	 */
> +	err = virtnet_ff_init(&vi->ff, vi->vdev);
> +	if (err && err != -EOPNOTSUPP) {
> +		rtnl_unlock();
> +		goto free_unregister_netdev;
> +	}
> +
>  	rtnl_unlock();
>  
>  	err = virtnet_cpu_notif_add(vi);
> @@ -7160,6 +7387,7 @@ static int virtnet_probe(struct virtio_device *vdev)
>  
>  free_unregister_netdev:
>  	unregister_netdev(dev);
> +	virtnet_ff_cleanup(&vi->ff);
>  free_failover:
>  	net_failover_destroy(vi->failover);
>  free_vqs:
> @@ -7209,6 +7437,7 @@ static void virtnet_remove(struct virtio_device *vdev)
>  	virtnet_free_irq_moder(vi);
>  
>  	unregister_netdev(vi->dev);
> +	virtnet_ff_cleanup(&vi->ff);
>  
>  	net_failover_destroy(vi->failover);
>  

