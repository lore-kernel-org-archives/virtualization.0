Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 779BD1925BC
	for <virtualization@lists.linux.dev>; Sat, 10 Jan 2026 23:49:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768088981; cv=none; b=RSmNvGyBStx5Sor0uKUybr3AE/bY2F4PRLgN2ieNf9FjR0+T4t6dHVyLlc1H4i/9f2eilKwl28aigpZWiVqUc2fRzXG5l4abBC2SEx8PkERxNNWj51q6crv/7jDqEGVxLpTE0FHbtHb8ELXdknGDiUTopCXJEEjjzejjOGfZFQw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768088981; c=relaxed/simple;
	bh=ywkmT19fvcODYWaHy+o4MdzSP0DRkGuaOlqiSNGtiiU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 In-Reply-To:Content-Type:Content-Disposition; b=NFYXOMuj4gZdf5tXaJqHjGqghOClj6ZPGOz8h7JiLyLMAT7LZWsfYu+Gx3lE/tob3f+vyCAVl4JMHcbQu8apOkOG+05o5ZZNM4BLgBSNueBgZQfk1eqOJRQN2Y1SyP2FDH5RwdTQ9/+bJZ3GrAW0p86BvHFxV2GCvxqSG4jxyE0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=ft9MQg5a; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="ft9MQg5a"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1768088979;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=nksX34u+zq7KDVyqe7hemXG/aIx66LziluisrlBZomg=;
	b=ft9MQg5avKEFX4suFWCx46PBkLlPeKs5alNVN7m2+rA0wjKIMw3SrKeNE/qLtnLprCs55+
	ceBk204jwFUnaWukI79xAVeITa3NpeBJubHi8E1cSRjxeDJjJb1fZQ4Yq2PREi7ZEqyttZ
	iKLt7BvPfHZJd/aqDnU3hS5OTcuQ+CE=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-636-PYcFaAZFNBS7V3SXIwDLgQ-1; Sat, 10 Jan 2026 18:49:38 -0500
X-MC-Unique: PYcFaAZFNBS7V3SXIwDLgQ-1
X-Mimecast-MFC-AGG-ID: PYcFaAZFNBS7V3SXIwDLgQ_1768088977
Received: by mail-wm1-f72.google.com with SMTP id 5b1f17b1804b1-47d3c9b8c56so55099795e9.0
        for <virtualization@lists.linux.dev>; Sat, 10 Jan 2026 15:49:38 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1768088977; x=1768693777;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=nksX34u+zq7KDVyqe7hemXG/aIx66LziluisrlBZomg=;
        b=kisrcZUHeN3YwhDus1I4nG3zIL+nLOpfwlsxBVkTXYTTMBbbqQfVuJircu4/pQhPJ7
         YIuErDXo9xX3kJCJJG7vxydEOmGgLSQ5ZNo4YhkmD6OK4mHABfrLQ6zWMFheh00pLOyW
         PzxisHtELWNVkvTjox/vnMDdylvka7VWxECPHvHLUDC4NJmKkBwm9NPnP5HK3sIYAiRF
         BF7j1W8aiBKxk6rAxaVqf7Z8GHdplI/ihetqXstfMIKiJT34gMFHA5nRyQdZQkLcuwwk
         2hosWSuIk00j75h24flJDCk2c4PLZGl0Zd01ovG3EsVb0rURYTBdyjqqUVVRnmCI4Qhe
         B4XQ==
X-Forwarded-Encrypted: i=1; AJvYcCUcW5Xd91++7GkkDHerUtZgKczh9j84ZZhir2sVqTFq1TtOulfvxo/F/vqWMM4rbRCVQa1KU/A0FmgUwV32uQ==@lists.linux.dev
X-Gm-Message-State: AOJu0Yy1gdb2VHPpUPgg3OuGnhcygDA9lBsuYPdjgSBYlPp7OKnI0qIP
	ppeZpZ3QY0uyoNR4LKB1wTIKVjPfKwPWfxjLUsDmWubKMCxzOKevldqzYTUODgn4bxT3S4vyXee
	HYYYsdx81vyhzA7PE5N0ib9OuCps2iSWtdHNzwqCezn5lNFM+y5KBlEg7q7aHVhroLxbD
X-Gm-Gg: AY/fxX5sxIIYAh8SPC20SGoMnyrcdkgsKUuL9DfGaqB43YurUJ04tJtrZDW7WoORv1x
	yAeEXoDL3wlKouJDQQk28cyIB1HoQVjq9z7EEJX6vZFMMZ4FTchGjzhFIBHYNWFUbBp9R7Idjwj
	in/Lm8DvRU47Oxng7aPBICjpW8+FlYEEjLKz6YCYPqPqOK/+DyvOrakEFymyzOMsouGaMde5WTn
	97hADXXBDB8CoBxD/D+SHoF+UuUFI9jSH+maDpM5bK4HtZloZF2lxXpNVnqXe3oa6t9CZ08KLE6
	lYw0EM9g7afRrtSh6yDVAa+D9P4qMfU2fZVdbImox+xrrB4CXp0sqnEXM9Jct+Hjw4dlfeYWzzl
	D2QGA6yOiaKE2B5hqMN56b4ZQY/sIffg=
X-Received: by 2002:a05:6000:4301:b0:431:864:d48f with SMTP id ffacd0b85a97d-432c37746c9mr15169985f8f.27.1768088976936;
        Sat, 10 Jan 2026 15:49:36 -0800 (PST)
X-Google-Smtp-Source: AGHT+IEF1xlqAdt2YFNNLBzxt86rJlusfYuOKpjkZGykzrrRj1y05yr5e6zjlirW1YfIneeou+Ak+g==
X-Received: by 2002:a05:6000:4301:b0:431:864:d48f with SMTP id ffacd0b85a97d-432c37746c9mr15169978f8f.27.1768088976546;
        Sat, 10 Jan 2026 15:49:36 -0800 (PST)
Received: from redhat.com (IGLD-80-230-35-22.inter.net.il. [80.230.35.22])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-432bd0e199bsm29991360f8f.16.2026.01.10.15.49.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 10 Jan 2026 15:49:35 -0800 (PST)
Date: Sat, 10 Jan 2026 18:49:32 -0500
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Eugenio =?iso-8859-1?Q?P=E9rez?= <eperezma@redhat.com>
Cc: linux-kernel@vger.kernel.org, virtualization@lists.linux.dev,
	Maxime Coquelin <mcoqueli@redhat.com>,
	Laurent Vivier <lvivier@redhat.com>, Cindy Lu <lulu@redhat.com>,
	jasowang@redhat.com, Xuan Zhuo <xuanzhuo@linux.alibaba.com>,
	Stefano Garzarella <sgarzare@redhat.com>,
	Yongji Xie <xieyongji@bytedance.com>
Subject: Re: [PATCH v11 07/12] vduse: refactor vdpa_dev_add for goto err
 handling
Message-ID: <20260110184915-mutt-send-email-mst@kernel.org>
References: <20260109152430.512923-1-eperezma@redhat.com>
 <20260109152430.512923-8-eperezma@redhat.com>
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
In-Reply-To: <20260109152430.512923-8-eperezma@redhat.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: b7pQPRWM5E4mG4IzCav939DOjG2oH0jUuuAIy1LoiL8_1768088977
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit

On Fri, Jan 09, 2026 at 04:24:25PM +0100, Eugenio Pérez wrote:
> Next patches introduce more error paths in this function.  Refactor it
> so they can be accomodated through gotos.

accommodated

> 
> Acked-by: Jason Wang <jasowang@redhat.com>
> Reviewed-by: Xie Yongji <xieyongji@bytedance.com>
> Signed-off-by: Eugenio Pérez <eperezma@redhat.com>
> ---
> v6: New in v6.
> ---
>  drivers/vdpa/vdpa_user/vduse_dev.c | 22 ++++++++++++++--------
>  1 file changed, 14 insertions(+), 8 deletions(-)
> 
> diff --git a/drivers/vdpa/vdpa_user/vduse_dev.c b/drivers/vdpa/vdpa_user/vduse_dev.c
> index 0386434577b5..f7a45f396cf8 100644
> --- a/drivers/vdpa/vdpa_user/vduse_dev.c
> +++ b/drivers/vdpa/vdpa_user/vduse_dev.c
> @@ -2171,21 +2171,27 @@ static int vdpa_dev_add(struct vdpa_mgmt_dev *mdev, const char *name,
>  						  dev->bounce_size);
>  	mutex_unlock(&dev->domain_lock);
>  	if (!dev->domain) {
> -		put_device(&dev->vdev->vdpa.dev);
> -		return -ENOMEM;
> +		ret = -ENOMEM;
> +		goto domain_err;
>  	}
>  
>  	ret = _vdpa_register_device(&dev->vdev->vdpa, dev->vq_num);
>  	if (ret) {
> -		put_device(&dev->vdev->vdpa.dev);
> -		mutex_lock(&dev->domain_lock);
> -		vduse_domain_destroy(dev->domain);
> -		dev->domain = NULL;
> -		mutex_unlock(&dev->domain_lock);
> -		return ret;
> +		goto register_err;
>  	}
>  
>  	return 0;
> +
> +register_err:
> +	mutex_lock(&dev->domain_lock);
> +	vduse_domain_destroy(dev->domain);
> +	dev->domain = NULL;
> +	mutex_unlock(&dev->domain_lock);
> +
> +domain_err:
> +	put_device(&dev->vdev->vdpa.dev);
> +
> +	return ret;
>  }
>  
>  static void vdpa_dev_del(struct vdpa_mgmt_dev *mdev, struct vdpa_device *dev)
> -- 
> 2.52.0

