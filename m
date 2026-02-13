Received: from mail-yx1-f42.google.com (mail-yx1-f42.google.com [74.125.224.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CF60A2F872
	for <virtualization@lists.linux.dev>; Fri, 13 Feb 2026 01:19:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.224.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770945574; cv=none; b=RQbuxD2MjrIRkbONjCWuKU0xqCx7KnXXiNGe77QLfve9E/4IvBvSTcLBmZujl2PbXvT7LUZ7o5NQz+Iv23FcZOZfQ++yLJgHP81Xcsb/u/r0DLO74Sb6H4acVEpmZlyw2J5axSmS9gXdrCGfqWi9xlG7+tTRVb8RuJ+I1ZPzsOM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770945574; c=relaxed/simple;
	bh=pOqP7VM+mApaVUNM4EB88815+w4SRLILG/EjieeLe+4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=CgPoZAVnjpKYFIULmWnkrnsktA4yIwgPH9/a4cHD4amPPaUDfG1x8M7uDggpgiCifbN7g/hd4qLNLE6z0RfMOxrM7Usux9rK//nu7w6IFBG2YyykQTKCX2jlXHWEmb0VFRHn6/OVfWqLc2K2PjzJPGT6G17tPcqs8+Q0OIsgqFk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=gI8roOd/; arc=none smtp.client-ip=74.125.224.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="gI8roOd/"
Received: by mail-yx1-f42.google.com with SMTP id 956f58d0204a3-649dbff9727so371678d50.3
        for <virtualization@lists.linux.dev>; Thu, 12 Feb 2026 17:19:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1770945573; x=1771550373; darn=lists.linux.dev;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=DdSR/hkZOakiS24NkJpFojfOy/j7sfQd+s+nYYhJiVE=;
        b=gI8roOd/cNU4VYnxxa01KWAtR11oB720GM4uif3syKg8DhqD4nVlVpa/caTZnM3TxO
         wAWU4zwq09xBKURrEULV6R/ZlhziQHEqN0CXgDpyVvhDqkSIkv5Iqfz4X3eceHkmORie
         fGHCWDgE966rmpXCJMq7f9R8Ep43LMBK0uYTC1B378+Shy6vpBgoeZ3omJg0Q5u7pC0G
         q1cKYkTyvskDHxGisl8gygydhJAItg60Q3mCTQMIuuxeP8DIii26NG+x9eaAXMTGUowm
         bA0rMsWoPs9q9/9qjrINqlEc+Vm2F5pfKvNzcsvKqBcL3ssbKtCAqQuDt9oA0qiTOrQU
         goJw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1770945573; x=1771550373;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=DdSR/hkZOakiS24NkJpFojfOy/j7sfQd+s+nYYhJiVE=;
        b=sLKvyKW5f0sFJvQbus+pCEnlR2Me9uIHGEJ2MY7TzGFczrVaPhfVqq19TruZLEOlKG
         IqTEij/8OJoN+2/O2o/azJdvIVZZHK7DKgkNTE5Mp0lETZYRGciIAi1GGRu5NiE03Qzt
         P8aFdnizGV0GE1kf2ApIE8a66BIEGqdx4Rk+mrWSl9PBvjFdT+D6v27dCVxJQEThZSYl
         KMKYWRhv3QpJdCejg8vNgsAqM7lPHSs6S3wbIekgWjgxPEwU8+mDz/2OYN+rU6xbMVyV
         YtpXYe1N6F1giSrFqyhBE/bmqXjFVVdj5wCjHpad3yiIvsRURrLnlvoG0XkU8MJnMqu/
         Sjbg==
X-Forwarded-Encrypted: i=1; AJvYcCXkvBdqhEqcuO/cDPw077+p5EB5qbbEPA/1THXa1oMunpBdpsp+LECs1tHYR4Mn9VNPQDoAan39iiKe7rrClQ==@lists.linux.dev
X-Gm-Message-State: AOJu0YyO+9tYeCE1QqeuuwZOWd4hU87omhm5sqCLBubiNQu+dBaoHRmh
	PIqg09mmGOkR/GDqgymJn7WYz6ZV3jvr+cOH0sVMxpfilaDbHCA1DYC3
X-Gm-Gg: AZuq6aLWKgjjsC45QdPoYv7xpmBOS5JcXBBNaIWKEInzIXZucezvt1tLPXpwd9BdXGx
	4v/Whhm4Kih7tZW4TWJ+z5+2A1wgVirjx+qs8K0iZkCaDCfRynPR7qkL1tvDe1rQc/72MrOmqra
	EKjDBMccKXu/zxcoNvs57nu5HzYKd11lnEa7mt26NVJ43Lcd7zgFK6uTCSqVAu4IglqxqfBdzPZ
	PzX0hJRZv43uro0F9beQ/A0pd+ieo/QemuCdivFfubR26eE0H66/KWkLNdQ44GoJeP++iLON4Jt
	K1UNuDULUnO3PjI92q+BPpwMEFk9dNbcP5JrKaMSQOhDM5A2cVDd6vIG749heV4Ccuo8HVH5Ses
	5GB4RLRNLXKqhg1dt3Q0klEDuzwp3GBihu4qAVBfravVYCrLXNEVOmZFLOieNN+5dSRp4HunaNX
	ZiXvPKm+aYTzYmGFUxLUapHk/gmjqmTAnp+Oyy9WNkleGRvnY=
X-Received: by 2002:a05:690e:4304:b0:64a:d1bd:8c65 with SMTP id 956f58d0204a3-64c19b63848mr65513d50.95.1770945572751;
        Thu, 12 Feb 2026 17:19:32 -0800 (PST)
Received: from devvm11784.nha0.facebook.com ([2a03:2880:25ff:4a::])
        by smtp.gmail.com with ESMTPSA id 956f58d0204a3-64afc95acabsm6061484d50.13.2026.02.12.17.19.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 12 Feb 2026 17:19:32 -0800 (PST)
Date: Thu, 12 Feb 2026 17:19:31 -0800
From: Bobby Eshleman <bobbyeshleman@gmail.com>
To: Stefano Garzarella <sgarzare@redhat.com>
Cc: netdev@vger.kernel.org, Eric Dumazet <edumazet@google.com>,
	linux-kernel@vger.kernel.org,
	Bobby Eshleman <bobbyeshleman@meta.com>,
	Jakub Kicinski <kuba@kernel.org>, virtualization@lists.linux.dev,
	Paolo Abeni <pabeni@redhat.com>,
	"Michael S. Tsirkin" <mst@redhat.com>,
	Simon Horman <horms@kernel.org>,
	"David S. Miller" <davem@davemloft.net>
Subject: Re: [PATCH net 2/2] vsock: prevent child netns mode switch from
 local to global
Message-ID: <aY58I15Csp1CU8xI@devvm11784.nha0.facebook.com>
References: <20260212205916.97533-1-sgarzare@redhat.com>
 <20260212205916.97533-3-sgarzare@redhat.com>
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260212205916.97533-3-sgarzare@redhat.com>

On Thu, Feb 12, 2026 at 09:59:16PM +0100, Stefano Garzarella wrote:
> From: Stefano Garzarella <sgarzare@redhat.com>
> 
> A "local" namespace can change its `child_ns_mode` sysctl to "global",
> allowing nested namespaces to access global CIDs. This can be exploited
> by an unprivileged user who gained CAP_NET_ADMIN through a user
> namespace.
> 
> Prevent this by rejecting writes that attempt to set `child_ns_mode` to
> "global" when the current namespace's mode is "local".
> 
> Fixes: eafb64f40ca4 ("vsock: add netns to vsock core")
> Cc: bobbyeshleman@meta.com
> Signed-off-by: Stefano Garzarella <sgarzare@redhat.com>
> ---
>  net/vmw_vsock/af_vsock.c | 15 ++++++++++++---
>  1 file changed, 12 insertions(+), 3 deletions(-)
> 
> diff --git a/net/vmw_vsock/af_vsock.c b/net/vmw_vsock/af_vsock.c
> index 3b629b4a0359..9880756d9eff 100644
> --- a/net/vmw_vsock/af_vsock.c
> +++ b/net/vmw_vsock/af_vsock.c
> @@ -95,8 +95,9 @@
>   *     the namespace's own ns_mode.
>   *
>   *   Changing child_ns_mode only affects newly created namespaces, not the
> - *   current namespace or existing children. At namespace creation, ns_mode
> - *   is inherited from the parent's child_ns_mode.
> + *   current namespace or existing children. A "local" namespace cannot set
> + *   child_ns_mode to "global". At namespace creation, ns_mode is inherited
> + *   from the parent's child_ns_mode.
>   *
>   *   The init_net mode is "global" and cannot be modified.
>   *
> @@ -2844,8 +2845,16 @@ static int vsock_net_child_mode_string(const struct ctl_table *table, int write,
>  	if (ret)
>  		return ret;
>  
> -	if (write)
> +	if (write) {
> +		/* Prevent a "local" namespace from escalating to "global",
> +		 * which would give nested namespaces access to global CIDs.
> +		 */
> +		if (vsock_net_mode(net) == VSOCK_NET_MODE_LOCAL &&
> +		    new_mode == VSOCK_NET_MODE_GLOBAL)
> +			return -EPERM;
> +
>  		vsock_net_set_child_mode(net, new_mode);
> +	}
>  
>  	return 0;
>  }
> -- 
> 2.53.0
> 

Thanks for the fix!

Reviewed-by: Bobby Eshleman <bobbyeshleman@meta.com>
