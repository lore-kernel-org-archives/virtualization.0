Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 945092FBDE0
	for <virtualization@lists.linux.dev>; Thu, 25 Sep 2025 11:49:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758800994; cv=none; b=JUHvS+wU8uTBbT9w1/VT2pdVKTnJ+ffcSXGl5ynQh1LVOoRhAeoWkikSlJsMrV+MgTUPmEk8T4UyLhn1jLY/wr4JKOpxtc+Px4mx3SECqfr3EOSU/yMwZHmmNo2sEdFqPxQcgeyrLpSS1Yj60L0ptPBqVeMKPZXuAKwl0X1Wdrs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758800994; c=relaxed/simple;
	bh=t0e0Wy9HiD96QW6i2mmx1lwB0XsE2scmYpVQv+XaRu8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 In-Reply-To:Content-Type:Content-Disposition; b=kWFEYKFh3lOanN+O14LNAGcGuFiC7ddd55j/K7Ew6VQ0m6+n9fntX/Xj5gYLI0MJWRV+Hy0AnInbdFz4/BntCddQ1N0RqZwFnCme6DBs8hOVYCER1R2/aG2aa7bd/LykMqcb1EJSF6DjQoBdvdkVuvB4HeKCLP4bTUYNdKLrlGk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=LlxPo4Zj; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="LlxPo4Zj"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1758800991;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=+KVPxjCMCSupXy09kWALvkdL9X3jhSe67fQlVKrtFiE=;
	b=LlxPo4Zj3L0a5LvedujXj9wMdBsONcKoDLtTdrcp8l/nKnEea4SuOHA8TURpjWKispPP8x
	0d1dtF2Xdi5ig187UlmZc98Sq37trlaSvUUdoU8iEXXSxON7ehig/NdiGQ1HLi1b6cw18g
	ejiutCpschH6XxeWaKgciur73s/4NdA=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-207-Cc7KIty0OjyuJO-TZHpzQA-1; Thu, 25 Sep 2025 07:49:46 -0400
X-MC-Unique: Cc7KIty0OjyuJO-TZHpzQA-1
X-Mimecast-MFC-AGG-ID: Cc7KIty0OjyuJO-TZHpzQA_1758800985
Received: by mail-wm1-f72.google.com with SMTP id 5b1f17b1804b1-45b990eb77cso5393645e9.0
        for <virtualization@lists.linux.dev>; Thu, 25 Sep 2025 04:49:45 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758800985; x=1759405785;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=+KVPxjCMCSupXy09kWALvkdL9X3jhSe67fQlVKrtFiE=;
        b=P/Y6216g55tgXAa3Qm82MvFCZFca6zJMMy7geINdPFABUBIAnbXhbXj6f+W8oI+Y6a
         hoDSxyIvGbQtxGNHoxQnwgvSvfiKSuw6O1YTRvAJ2FKdXkkCx6Z38iyoC9gdggSFkOvN
         fQLfY6dbF3rODOeLT9iIBihNvIL3d5vS1g33Snpa6AUDimfcujHzX1b5JV1FByj4QOzR
         sMxrQGqKyV9IOg7C3l9XD/HZZ9hupqnHzCRhZNi01Uwar9AsBRij2HyZtwQnaiO2BZIY
         A3UGd6Mjpglx+uVioytovQ6z6eRPk0QzMVQSy2t4dtU4HMnqFj0KB3TCAT58/KbOWjQb
         5yTQ==
X-Forwarded-Encrypted: i=1; AJvYcCXXbSsf/0n4G3D1xN3dkjztlmdvmlIOUym10d8Vt8hQQLrbPpvlNNCL6u6jJvrM5qE1sYl+SCFF2CrevO1jrg==@lists.linux.dev
X-Gm-Message-State: AOJu0YyH92R7ZFhswJYtOiAKDKdepZ4IaIyVrQK1BwrIDpO4vED3j5ur
	Z9GOtnAj9VCUhx16HayhWM5F0lyyoLog8GOUsJz/2VKivwusi/cBWTnI69OiopMIyVQzl65IVpy
	89D9sWbTFM8eEaJgpviLQC/BlIpP5kqE3PB0yhTVVbtJNlqAYNRFFtqfxO3FmmHA2P182
X-Gm-Gg: ASbGncscd+7AfvFjQaJTRJ02xeDTHdpbbElXSyPYMGPc3E3bJHrppipZ3u7Oq+JyAzY
	1dGEZEZXgtQAIWhN+V+p2+2doa7I5nkGIAgXjUwr0ND9K2caYZssHhQmAe8GB4aXvFDhU0bX5qe
	dp1l0MX8y/JBcGRQcbjZ/PMDvYic+U1dQ1E5mLS5mbtAg9L/rMKTHf2TL+sfCNdFg4MK4VgDrnc
	pqs0Oe4RG0izyAS7UWXAJlJdb3SywvB4AinR7KiTY08N6QsBM7VKNVlJaElmAuLx+eX66xjSdBt
	q1xYlhCfMJw6ZwdtHwHXlHzx8BZeMPernA==
X-Received: by 2002:a05:600c:4ecc:b0:46e:33ed:bca4 with SMTP id 5b1f17b1804b1-46e33edbe6fmr21722945e9.15.1758800984852;
        Thu, 25 Sep 2025 04:49:44 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEnkMk4Mj0ELsCsrAjcuQkpsgbxny3/tEAQCMvsxl7J67IGzgbX3TMTdlCtiY5/jDU50JELDA==
X-Received: by 2002:a05:600c:4ecc:b0:46e:33ed:bca4 with SMTP id 5b1f17b1804b1-46e33edbe6fmr21722805e9.15.1758800984415;
        Thu, 25 Sep 2025 04:49:44 -0700 (PDT)
Received: from redhat.com ([2a0d:6fc0:1538:2200:56d4:5975:4ce3:246f])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-40fb74e46bcsm2758466f8f.8.2025.09.25.04.49.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 25 Sep 2025 04:49:43 -0700 (PDT)
Date: Thu, 25 Sep 2025 07:49:40 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Parav Pandit <parav@nvidia.com>
Cc: Dan Jurgens <danielj@nvidia.com>, Jason Wang <jasowang@redhat.com>,
	netdev@vger.kernel.org, alex.williamson@redhat.com,
	pabeni@redhat.com, virtualization@lists.linux.dev,
	shshitrit@nvidia.com, yohadt@nvidia.com, xuanzhuo@linux.alibaba.com,
	eperezma@redhat.com, shameerali.kolothum.thodi@huawei.com,
	jgg@ziepe.ca, kevin.tian@intel.com, kuba@kernel.org,
	andrew+netdev@lunn.ch, edumazet@google.com,
	Yishai Hadas <yishaih@nvidia.com>
Subject: Re: [PATCH net-next v3 01/11] virtio-pci: Expose generic device
 capability operations
Message-ID: <20250925074814-mutt-send-email-mst@kernel.org>
References: <20250923141920.283862-1-danielj@nvidia.com>
 <20250923141920.283862-2-danielj@nvidia.com>
 <CACGkMEtkqhvsP1-b8zBnrFZwnK3LvEO4GBN52rxzdbOXJ3J7Qw@mail.gmail.com>
 <20250924021637-mutt-send-email-mst@kernel.org>
 <16019785-ca9e-4d63-8a0f-c2f3fdcd32b8@nvidia.com>
 <20250925021351-mutt-send-email-mst@kernel.org>
 <4fa7bf85-e935-45aa-bb2f-f37926397c31@nvidia.com>
 <20250925062741-mutt-send-email-mst@kernel.org>
 <92ca5ed1-629d-4dc3-85fc-f1c6299a42ba@nvidia.com>
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
In-Reply-To: <92ca5ed1-629d-4dc3-85fc-f1c6299a42ba@nvidia.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: _NILaFKtTVaEkc7YvJ5wZ9YadwjMt8Ld-SLTQvHRiQg_1758800985
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Thu, Sep 25, 2025 at 04:15:19PM +0530, Parav Pandit wrote:
> 
> On 25-09-2025 04:05 pm, Michael S. Tsirkin wrote:
> > On Thu, Sep 25, 2025 at 03:21:38PM +0530, Parav Pandit wrote:
> > > Function pointers are there for multiple transports to implement their own
> > > implementation.
> > My understanding is that you want to use flow control admin commands
> > in virtio net, without making it depend on virtio pci.
> No flow control in vnet.
> > This why the callbacks are here. Is that right?
> 
> No. callbacks are there so that transport agnostic layer can invoke it,
> which is drivers/virtio/virtio.c.
> 
> And transport specific code stays in transport layer, which is presently
> following config_ops design.
> 
> > 
> > That is fair enough, but it looks like every new command then
> > needs a lot of boilerplate code with a callback a wrapper and
> > a transport implementation.
> 
> Not really. I dont see any callbacks or wrapper in current proposed patches.
> 
> All it has is transport specific implementation of admin commands.
> 
> > 
> > 
> > Why not just put all this code in virtio core? It looks like the
> > transport just needs to expose an API to find the admin vq.
> 
> Can you please be specific of which line in the current code can be moved to
> virtio core?
> 
> When the spec was drafted, _one_ was thinking of admin command transport
> over non admin vq also.
> 
> So current implementation of letting transport decide on how to transport a
> command seems right to me.
> 
> But sure, if you can pin point the lines of code that can be shifted to
> generic layer, that would be good.

I imagine a get_admin_vq operation in config_ops. The rest of the
code seems to be transport independent and could be part of
the core. WDYT?

-- 
MST

