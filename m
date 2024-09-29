Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6245937708
	for <virtualization@lists.linux.dev>; Sun, 29 Sep 2024 19:03:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727636598; cv=none; b=gZHV+dPPV/PZVTvp/g7ZrLRhVD+BvSsIM3AN5k9eK4nhf6OxaFrTvPVak/ioeugeouJ0FzygTXP8Wt6T8/1yc2P+x2pxdd4oX7LQX0jaNTvypnQWWKC794gBwi+jXzsWN4ynC7bw1j1rk8ZjT6s48KGtyx4VmQG0ZENDaUbri/A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727636598; c=relaxed/simple;
	bh=mJ6aNO0lKWxfxwO0/xyx1DBweeTD58gqYEGwbYFCjtE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 In-Reply-To:Content-Type:Content-Disposition; b=H1RCaqL/uAQldcFefeAOhLo1KBOUaBEGIozc0PXF6EEnq231Avm4XQV6JvX1eDkZgx0yncMHOFxo3FigrqmbRYLTx3/LSc1dAlr4SNAAxFBqBUyYZdsTTk10T/2aAWr9slAKdNLkuti6JFHRJegmjoWztpgXPTrcijakvg5Lwuw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=W6QBdhMh; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="W6QBdhMh"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1727636594;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=x6bUJlkki1ztWLf5NuN8u9UlosagMsCbrNTD0ZptiK8=;
	b=W6QBdhMhXDhsP2v7ea8DSJNBBF57/Fx+sjdfSd+QfqSJ1TzTFu53G9M3+D4Y0J9Q6b3PX3
	89l1JpFstgZJ2kgaKKmtWcUaSd83le4C7u8js1nZRDqTABwQtJGT7Qk6NxfSZsmQ7ePS/v
	M9cmimDM2oLnW7zxmgQ+cmyaBD2KOks=
Received: from mail-ej1-f72.google.com (mail-ej1-f72.google.com
 [209.85.218.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-562-z-Ly3rrOM6W4MDOUnl275Q-1; Sun, 29 Sep 2024 15:03:13 -0400
X-MC-Unique: z-Ly3rrOM6W4MDOUnl275Q-1
Received: by mail-ej1-f72.google.com with SMTP id a640c23a62f3a-a8d3085ab6fso262080666b.0
        for <virtualization@lists.linux.dev>; Sun, 29 Sep 2024 12:03:12 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1727636592; x=1728241392;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=x6bUJlkki1ztWLf5NuN8u9UlosagMsCbrNTD0ZptiK8=;
        b=Tbss10FrkdaoE1Kf2gudpgjQdiMtyuFZqZfxhcyJXO+yDRSx98f0xDxURX0rdj4BgJ
         TwBufPMF9fLfDAjwyHxUiL2AXnbeP4ouUOB8PdEK4GTsxt82zzh5lrkyf29zYLtrKxvX
         TdEpHHCoF5mogmuNBkrBdcxyhp0fpHCfGEdwuYByV8JkWk5OuHe7FVjpiLaFwd46eTDF
         OdzxPCfjosogTRYV8ZPqSnXpaCpPY/3DznMFmXMx8fPTUIbzMwi5VMJgE6e4GMYtTzpJ
         EtP/xf99A9AXySqAAAWzTFSVPyNE7XGmfTjL/03cI6hVSEXHpep2s5/4YcUx/7z8tehs
         gZfw==
X-Forwarded-Encrypted: i=1; AJvYcCWaxggQ5BfQmw2O8mT5BT9I097othiMbU5OEXXki1vqNHEgGgxI3zLVvs3RD0IVzFNHNeYIVXZeW0KvgpIYdg==@lists.linux.dev
X-Gm-Message-State: AOJu0YwHt5Kxm0ziT7dFqlh1LL3c7RlKXXMGDE4HRv6Fe3lLO+y6rOpR
	Y2DwPvobXZ4Nw0HM9wPXrYctjlPsZmKRdf4O4jmjwHJa1a5szn0U1EJ1bW24ofcAXoZAxH2fbPF
	7YWakJFzSt7FiY90DelgF0Rc4DD6bl5/ORC42C9iyAz07vxI5dJ+XY+fCEsIjoe7s
X-Received: by 2002:a17:907:3203:b0:a86:851e:3a2b with SMTP id a640c23a62f3a-a93c49299e7mr1036679966b.29.1727636591858;
        Sun, 29 Sep 2024 12:03:11 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFQDd9sJy+FimmEzDQjyiUcueim9sVTOWfbarbSrm0RdNbR85RpVYfEUSJyhVZkPo8TSYJtwg==
X-Received: by 2002:a17:907:3203:b0:a86:851e:3a2b with SMTP id a640c23a62f3a-a93c49299e7mr1036678366b.29.1727636591515;
        Sun, 29 Sep 2024 12:03:11 -0700 (PDT)
Received: from redhat.com ([2a02:14f:17b:822e:847c:4023:a734:1389])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a93c2947e49sm412253866b.135.2024.09.29.12.03.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 29 Sep 2024 12:03:10 -0700 (PDT)
Date: Sun, 29 Sep 2024 15:03:04 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Alexander Mikhalitsyn <aleksandr.mikhalitsyn@canonical.com>
Cc: stefanha@redhat.com, Stefano Garzarella <sgarzare@redhat.com>,
	Jason Wang <jasowang@redhat.com>,
	Eugenio =?iso-8859-1?Q?P=E9rez?= <eperezma@redhat.com>,
	kvm@vger.kernel.org, virtualization@lists.linux.dev,
	netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] vhost/vsock: specify module version
Message-ID: <20240929150147-mutt-send-email-mst@kernel.org>
References: <20240929182103.21882-1-aleksandr.mikhalitsyn@canonical.com>
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
In-Reply-To: <20240929182103.21882-1-aleksandr.mikhalitsyn@canonical.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Sun, Sep 29, 2024 at 08:21:03PM +0200, Alexander Mikhalitsyn wrote:
> Add an explicit MODULE_VERSION("0.0.1") specification for the vhost_vsock module.
> 
> It is useful because it allows userspace to check if vhost_vsock is there when it is
> configured as a built-in.
> 
> This is what we have *without* this change and when vhost_vsock is configured
> as a module and loaded:
> 
> $ ls -la /sys/module/vhost_vsock
> total 0
> drwxr-xr-x   5 root root    0 Sep 29 19:00 .
> drwxr-xr-x 337 root root    0 Sep 29 18:59 ..
> -r--r--r--   1 root root 4096 Sep 29 20:05 coresize
> drwxr-xr-x   2 root root    0 Sep 29 20:05 holders
> -r--r--r--   1 root root 4096 Sep 29 20:05 initsize
> -r--r--r--   1 root root 4096 Sep 29 20:05 initstate
> drwxr-xr-x   2 root root    0 Sep 29 20:05 notes
> -r--r--r--   1 root root 4096 Sep 29 20:05 refcnt
> drwxr-xr-x   2 root root    0 Sep 29 20:05 sections
> -r--r--r--   1 root root 4096 Sep 29 20:05 srcversion
> -r--r--r--   1 root root 4096 Sep 29 20:05 taint
> --w-------   1 root root 4096 Sep 29 19:00 uevent
> 
> When vhost_vsock is configured as a built-in there is *no* /sys/module/vhost_vsock directory at all.
> And this looks like an inconsistency.

And that's expected.

> With this change, when vhost_vsock is configured as a built-in we get:
> $ ls -la /sys/module/vhost_vsock/
> total 0
> drwxr-xr-x   2 root root    0 Sep 26 15:59 .
> drwxr-xr-x 100 root root    0 Sep 26 15:59 ..
> --w-------   1 root root 4096 Sep 26 15:59 uevent
> -r--r--r--   1 root root 4096 Sep 26 15:59 version

Sorry, what I'd like to see is an explanation which userspace
is broken without this change, and whether this patch fixes is.



> Signed-off-by: Alexander Mikhalitsyn <aleksandr.mikhalitsyn@canonical.com>
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

