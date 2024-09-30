Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DE25718E758
	for <virtualization@lists.linux.dev>; Mon, 30 Sep 2024 14:27:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727706464; cv=none; b=AHe97anlufUjeS2OvoZYCBdgTeEbptxe0GrFVMJgKzJOxxbJ33dobj432sVXr/XzStC+kpS8M7E2dfLmcCyTG+yfZVN23363dSdWMjrJuSG6BD3y2bXQqIILCYUKG6EK6Mp2gI4Puiopb+Gp8WbDHKCXOOTPTRlMgcCmcTDtGs0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727706464; c=relaxed/simple;
	bh=EeYyLF20aDFEbuavaL7j2KagAYQQasGHqOcT6pXxFaI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 In-Reply-To:Content-Type:Content-Disposition; b=ZbDQ3iX5JjCq3dWcDk/tFd5+xE90P0VZse6/8If3rFaxrtote7HXpwkcjm8Lwk5SwgZjwXmr3E6DBElSjVYAgw2QprIKbUvCpK1j+PR4dbtW9pHOCFp+PjZmWdtSt6yExK02buTvfM/+qSaUF91R+QjRIIlb1DLDyJjvqSMJjLs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=Q+YJyeal; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Q+YJyeal"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1727706461;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=4ytbPBd95cWqX8Nn+fM7i9ZT4U+6yWcLeNhuCcF4JcQ=;
	b=Q+YJyealfuOlFs5Y2qZZ23YpxmCHLdBf5Y8ZE+DqwvCfi/K3Ka9es6PHoyLpSHjLmv+EqT
	iFeG1SdL+ivUF9wXFju/Y44vzZ/j44lErkKXgYOBTKxZB7BcxpuTjzYWwUpeFinfn4pin8
	DPxGf/fYG2Ptkk7bAtXPAMcGY5oaGHY=
Received: from mail-oi1-f197.google.com (mail-oi1-f197.google.com
 [209.85.167.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-151-BO-j-DgPPWqqwFISE5OeWA-1; Mon, 30 Sep 2024 10:27:39 -0400
X-MC-Unique: BO-j-DgPPWqqwFISE5OeWA-1
Received: by mail-oi1-f197.google.com with SMTP id 5614622812f47-3e04b73b7b7so4124315b6e.0
        for <virtualization@lists.linux.dev>; Mon, 30 Sep 2024 07:27:39 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1727706459; x=1728311259;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=4ytbPBd95cWqX8Nn+fM7i9ZT4U+6yWcLeNhuCcF4JcQ=;
        b=UxWwweSK2ZsHoJzsxXqPVVGNBX2ydqIlIBv3n++CxEAgYFDV93B0bm50iQ1Pe4V76Z
         Vav7CECwyPTP62ymgkGsNstrsX2+tVMiY4U4NVy4ynN6gJlwqXdgggjmI3r55UUC4JgK
         qVp23pxgzcAcRZIQ1Cc7tzh/G2akEmMhrkXhD/8WH0flTsJ/O1QtKiSHFTKVJCp74BXQ
         sR+QSTF1RF88phX+XJ5U3AtllqHPk3KyMrNi2+yFphEt0pMsKoOhk+w835NedGI7L4+Z
         GtG5+Pgr5lYcotV+OAWKhW9m9qVzNhdn+iI3wMaX6LTdG3SGYxbiRkszjJ/6Dyd8wrs5
         C8iA==
X-Forwarded-Encrypted: i=1; AJvYcCUGh3CquFiUPSESs+7sbdevoGeUqwKkE7df3TmChz/qg7/NyFJjokaEPZO+hoGghBj53CziSd+i8xwaQLMMVg==@lists.linux.dev
X-Gm-Message-State: AOJu0YzjmpCJXMKKGW+g7o0jwMPsYWlAp/jh+hBF9dKXROkm8rmKeSYC
	LlEhKKrJ0whRISajzuVidY889M/+NMZl8MRMxP6OVOwD1gs6YtqHn0cIz7hlu3QS6+c2vwyzlLd
	7PFB+JWkk7lQxOEZ7aH60IzLQBR2KVI5vJVuuOGO1chu/YcP7UDcoVZ+7B34KfUOE
X-Received: by 2002:a05:6358:7201:b0:1af:15b5:7ca0 with SMTP id e5c5f4694b2df-1becbc29d1emr438412455d.6.1727706458901;
        Mon, 30 Sep 2024 07:27:38 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGIrMRsWhZz29fSWrh8R6+DMZiFE0fzWTDB+zeNZvgXRTdMVS2bFMuus9C1n6IS1/FhZMePYA==
X-Received: by 2002:a05:6358:7201:b0:1af:15b5:7ca0 with SMTP id e5c5f4694b2df-1becbc29d1emr438410055d.6.1727706458474;
        Mon, 30 Sep 2024 07:27:38 -0700 (PDT)
Received: from sgarzare-redhat (host-79-46-200-231.retail.telecomitalia.it. [79.46.200.231])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-6cb3b68ec20sm40159986d6.135.2024.09.30.07.27.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 30 Sep 2024 07:27:37 -0700 (PDT)
Date: Mon, 30 Sep 2024 16:27:14 +0200
From: Stefano Garzarella <sgarzare@redhat.com>
To: Alexander Mikhalitsyn <aleksandr.mikhalitsyn@canonical.com>, 
	kuba@kernel.org
Cc: stefanha@redhat.com, "Michael S. Tsirkin" <mst@redhat.com>, 
	Jason Wang <jasowang@redhat.com>, Eugenio =?utf-8?B?UMOpcmV6?= <eperezma@redhat.com>, 
	kvm@vger.kernel.org, virtualization@lists.linux.dev, netdev@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] vhost/vsock: specify module version
Message-ID: <w3fc6fwdwaakygtoktjzavm4vsqq2ks3lnznyfcouesuu7cqog@uiq3y4gjj5m3>
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
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline

On Sun, Sep 29, 2024 at 08:21:03PM GMT, Alexander Mikhalitsyn wrote:
>Add an explicit MODULE_VERSION("0.0.1") specification for the vhost_vsock module.
>
>It is useful because it allows userspace to check if vhost_vsock is there when it is
>configured as a built-in.
>
>This is what we have *without* this change and when vhost_vsock is configured
>as a module and loaded:
>
>$ ls -la /sys/module/vhost_vsock
>total 0
>drwxr-xr-x   5 root root    0 Sep 29 19:00 .
>drwxr-xr-x 337 root root    0 Sep 29 18:59 ..
>-r--r--r--   1 root root 4096 Sep 29 20:05 coresize
>drwxr-xr-x   2 root root    0 Sep 29 20:05 holders
>-r--r--r--   1 root root 4096 Sep 29 20:05 initsize
>-r--r--r--   1 root root 4096 Sep 29 20:05 initstate
>drwxr-xr-x   2 root root    0 Sep 29 20:05 notes
>-r--r--r--   1 root root 4096 Sep 29 20:05 refcnt
>drwxr-xr-x   2 root root    0 Sep 29 20:05 sections
>-r--r--r--   1 root root 4096 Sep 29 20:05 srcversion
>-r--r--r--   1 root root 4096 Sep 29 20:05 taint
>--w-------   1 root root 4096 Sep 29 19:00 uevent
>
>When vhost_vsock is configured as a built-in there is *no* /sys/module/vhost_vsock directory at all.
>And this looks like an inconsistency.
>
>With this change, when vhost_vsock is configured as a built-in we get:
>$ ls -la /sys/module/vhost_vsock/
>total 0
>drwxr-xr-x   2 root root    0 Sep 26 15:59 .
>drwxr-xr-x 100 root root    0 Sep 26 15:59 ..
>--w-------   1 root root 4096 Sep 26 15:59 uevent
>-r--r--r--   1 root root 4096 Sep 26 15:59 version
>
>Signed-off-by: Alexander Mikhalitsyn <aleksandr.mikhalitsyn@canonical.com>
>---
> drivers/vhost/vsock.c | 1 +
> 1 file changed, 1 insertion(+)
>
>diff --git a/drivers/vhost/vsock.c b/drivers/vhost/vsock.c
>index 802153e23073..287ea8e480b5 100644
>--- a/drivers/vhost/vsock.c
>+++ b/drivers/vhost/vsock.c
>@@ -956,6 +956,7 @@ static void __exit vhost_vsock_exit(void)
>
> module_init(vhost_vsock_init);
> module_exit(vhost_vsock_exit);
>+MODULE_VERSION("0.0.1");

I was looking at other commits to see how versioning is handled in order 
to make sense (e.g. using the same version of the kernel), and I saw 
many commits that are removing MODULE_VERSION because they say it 
doesn't make sense in in-tree modules.

In particular the interesting thing is from nfp, where 
`MODULE_VERSION(UTS_RELEASE);` was added with this commit:

1a5e8e350005 ("nfp: populate MODULE_VERSION")

And then removed completely with this commit:

b4f37219813f ("net/nfp: Update driver to use global kernel version")

CCing Jakub since he was involved, so maybe he can give us some 
pointers.

Thanks,
Stefano

> MODULE_LICENSE("GPL v2");
> MODULE_AUTHOR("Asias He");
> MODULE_DESCRIPTION("vhost transport for vsock ");
>-- 
>2.34.1
>

