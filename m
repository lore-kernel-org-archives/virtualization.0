Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D6F4517DE36
	for <virtualization@lists.linux.dev>; Sun, 29 Sep 2024 16:56:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727628980; cv=none; b=obcmOTLC9n9v6uX5i+++tt1fx7GvyHnimu5hkk+K4vW+3X/gc6BG5nvcOrMOX1z3RpOMDRSS5V0CMOlEh3KT4yz5CG2uU0XVo9crbruOcSPlXZUXea0wpBsouBqDqVW65iPXUMm6qp5km5G5LeFAtcMWjX4wuehS/oM7U+enxWs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727628980; c=relaxed/simple;
	bh=OuNHc8PIGaHQxuUXtKbA+OFDsOJlQHplpqTyjl6z6CQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 In-Reply-To:Content-Type:Content-Disposition; b=RtV6ml3Aq/idVVChmVAakOh/sjDCWit2ZeyuyZSMouP1eSZU/v8D0eyWG3KXNHbh62jUc39G48UkvHkb//c1fz+mDVEQ/sLx8hohf8ZBkTFreOrVFoZNuq/YChzJl9PeIqqfed+7cHfvknBqamz+u36SUQPYaHXhxrsL9shHK34=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=gvxRlCpN; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="gvxRlCpN"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1727628977;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=kqpozjXyhnvHlQRJu2I4WgyAmmMM5tqK0NqWHw3trQE=;
	b=gvxRlCpNpVZ/2muNJIXrtsPCkMWrzb0f30fzbR6/QAs9BVlLOBxh6MB9msoNcLkA6O5FEl
	acTAM6+5T9oTtivrfqQ6frPcHqzAORtKbbsOXF6zLFEjZxMA0PDbQeHLj0bWIsW0GCpn+U
	htMEbr3JngO63MMUVAJ+le02n3f2AoM=
Received: from mail-ej1-f69.google.com (mail-ej1-f69.google.com
 [209.85.218.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-299-teIyBlHAPu6JAPsVc5jzcQ-1; Sun, 29 Sep 2024 12:56:16 -0400
X-MC-Unique: teIyBlHAPu6JAPsVc5jzcQ-1
Received: by mail-ej1-f69.google.com with SMTP id a640c23a62f3a-a8b6ed71659so220465666b.0
        for <virtualization@lists.linux.dev>; Sun, 29 Sep 2024 09:56:16 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1727628975; x=1728233775;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=kqpozjXyhnvHlQRJu2I4WgyAmmMM5tqK0NqWHw3trQE=;
        b=EhykyrbsFfnzUoaNqHtarY+iQ0RMaA/Abbyr7wGYEFh9RLXOAudRMeLGF89wcYrH0C
         o+0a/1fZSo1lFeWF4DwWPfcfP61zhBxL3hKJ8Ip7XeWnx/gV7IT7cOeF6O4EmEjuxuQA
         sZmNmfqKVbw8T3YUnU3lK2kVFLtmw5Cuotkc6EpN83tB0r3QdOVXFIyMBfJ7UYDOE/Ow
         5iFSkp7QuS5OleWEBoUzsI+b5zZZimuDVYPvaeBez916cCW0T/GN4VVIzTUe9yUAq106
         sHmjlz+mDy2yBW4rYvBz1FacQUE52N3Pqnfz0zvCUtv25WHx+ckewVp6UHC4sMEzlsxe
         VMCw==
X-Forwarded-Encrypted: i=1; AJvYcCVNQIZnVqjhyUoe1D/5GYUEsIGwRgtzLGz6grp3214gfQY2+SLmIHkTlCHZisgK+XnnOMpAe2goXPeefkDMXg==@lists.linux.dev
X-Gm-Message-State: AOJu0YzONBLwEuK71tFEtgYSMwI9qIoS3/GuYWI5/KqJt3OE+G1KgzKe
	fAHhy+Gqrubzo19LDuJmvTe1JafDw9hlnS4MqSVwgYabZzftOf4bULi4+XbfetAmo4szbXi2A4w
	JzMWqanp5z+4l6JTncN4FHiTsJeXEKnveo8jYbVG6j+Nv+XUMXJtsizTGq+Aj6Jqh
X-Received: by 2002:a17:907:3eaa:b0:a8a:9054:8391 with SMTP id a640c23a62f3a-a93c48f8884mr1026229766b.5.1727628975225;
        Sun, 29 Sep 2024 09:56:15 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEBabYhMMakXtMQtZ10IYuTuTjIcGwfv1lKDLcZNtfQ8gg556HasAqswG+Wg0TAOWoqjInzRQ==
X-Received: by 2002:a17:907:3eaa:b0:a8a:9054:8391 with SMTP id a640c23a62f3a-a93c48f8884mr1026226866b.5.1727628974679;
        Sun, 29 Sep 2024 09:56:14 -0700 (PDT)
Received: from redhat.com ([2a02:14f:17b:822e:847c:4023:a734:1389])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a93c2775995sm398955366b.41.2024.09.29.09.56.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 29 Sep 2024 09:56:13 -0700 (PDT)
Date: Sun, 29 Sep 2024 12:56:09 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Alexander Mikhalitsyn <aleksandr.mikhalitsyn@canonical.com>
Cc: stefanha@redhat.com, Stefano Garzarella <sgarzare@redhat.com>,
	Jason Wang <jasowang@redhat.com>,
	Eugenio =?iso-8859-1?Q?P=E9rez?= <eperezma@redhat.com>,
	kvm@vger.kernel.org, virtualization@lists.linux.dev,
	netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] vhost/vsock: specify module version
Message-ID: <20240929125245-mutt-send-email-mst@kernel.org>
References: <20240926161641.189193-1-aleksandr.mikhalitsyn@canonical.com>
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
In-Reply-To: <20240926161641.189193-1-aleksandr.mikhalitsyn@canonical.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Thu, Sep 26, 2024 at 06:16:40PM +0200, Alexander Mikhalitsyn wrote:
> Add an explicit MODULE_VERSION("0.0.1") specification
> for a vhost_vsock module. It is useful because it allows
> userspace to check if vhost_vsock is there when it is
> configured as a built-in.
> 
> Without this change, there is no /sys/module/vhost_vsock directory.
> 
> With this change:
> $ ls -la /sys/module/vhost_vsock/
> total 0
> drwxr-xr-x   2 root root    0 Sep 26 15:59 .
> drwxr-xr-x 100 root root    0 Sep 26 15:59 ..
> --w-------   1 root root 4096 Sep 26 15:59 uevent
> -r--r--r--   1 root root 4096 Sep 26 15:59 version
> 
> Signed-off-by: Alexander Mikhalitsyn <aleksandr.mikhalitsyn@canonical.com>


Why not check that the misc device is registered?
I'd rather not add a new UAPI until actually necessary.

> ---
>  drivers/vhost/vsock.c | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/drivers/vhost/vsock.c b/drivers/vhost/vsock.c
> index 802153e23073..287ea8e480b5 100644
> --- a/drivers/vhost/vsock.c
> +++ b/drivers/vhost/vsock.c
> @@ -956,6 +956,7 @@ static void __exit vhost_vsock_exit(void)
>  
>  module_init(vhost_vsock_init);
>  module_exit(vhost_vsock_exit);
> +MODULE_VERSION("0.0.1");
>  MODULE_LICENSE("GPL v2");
>  MODULE_AUTHOR("Asias He");
>  MODULE_DESCRIPTION("vhost transport for vsock ");
> -- 
> 2.34.1

