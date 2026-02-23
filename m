Received: from mail-yw1-f175.google.com (mail-yw1-f175.google.com [209.85.128.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5FA398248B
	for <virtualization@lists.linux.dev>; Mon, 23 Feb 2026 18:55:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771872902; cv=none; b=EqepL9WcgcdiGhVmGq/+Vf0L6jdvlVbdeAAc93yKS5/NfnrVDXi9QyjrQrvTzIEFkJZeNKb2SoDJtNnK9r2AjVP4Viku9T1ybdVmLfZCoZaXYn6935GdS2hv41Xnr9YNiYFJalaFg5T80zvjl4/6H5vmZPd/5Fc8/0K1jA2iMSI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771872902; c=relaxed/simple;
	bh=nctdjUKXo0u5+zaaCcHY+q1p5NNU/Ba/iOXcHcHJhqE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=YKSj+ORn8ULbrpnAGUAG7vga82zFqEZQeGtX1eYP5AEjv/lzUit5qpKonz5oPlsuHx5C1fxPZQKW3QucgxNxczmB+9DyOkVMzdxND0mxxnx7NWtdnNQDVvtkE09LavFdEiah6IxVUq8bZZrY0oc8nxGTum2p2jT7EKFo2PO0t4o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=gQ5hqCjG; arc=none smtp.client-ip=209.85.128.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="gQ5hqCjG"
Received: by mail-yw1-f175.google.com with SMTP id 00721157ae682-7982c3b7dfcso24755257b3.0
        for <virtualization@lists.linux.dev>; Mon, 23 Feb 2026 10:55:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1771872900; x=1772477700; darn=lists.linux.dev;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=Vud3sOYkGGFigTsBFe48YuQKgz6ijM9yPc/XUomBSLw=;
        b=gQ5hqCjGf8y1mnv9JNme5zgvdH2w+RKvwKhb5Q+xZRDBDn5l6BxBLQFfO0V2jaVhef
         2ciMHCO8xa/5pGwJ3W3n6tIQxg/7XdXBKbsU2kBVhD0hIqkAi4b8QYgP4HFwD0uDZ29S
         yT8ITOE87L0S8MMix9ykc899oz+kID+DJ6/Z7QLphrLWsLaSJikDx84kojuGfhGbwe0K
         dwnnVm4g776eN82chvyFnZPZDWPPWoXELQM6J7LsFBhfE4Q74C7tH8b3d+Clhlop+2fm
         rdZqAE08T8FwFJsCbR1hnkz1iQa+XjKRihp5AuOoqjpQulP1pneSIPY7GLQliYslls+o
         0jtw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1771872900; x=1772477700;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Vud3sOYkGGFigTsBFe48YuQKgz6ijM9yPc/XUomBSLw=;
        b=ozGlRrUx38N2ETS3p5kyVj1n8J9T9q/zi+QBRe09i0u3n6epMyR3U6NFHXTwA3KZce
         FqNzeGLABjPSf1Z2llpM0OvjBeiZiZpoW+v7VvFeJRa35RKE1pFy6mjR3YmDj5YPZFGN
         cgnSLHzy1dAbo97gASvSyfmrbKipmvez2XG5ugZ7Mh0eUc8vbTlJue+3pFfZ9LMyPEeA
         9QNARcUnKJmRfESFdaBIlcKwasTviWz9SWAEyvbel+sXq+EC//jshvAGpNIXDJNiAe5L
         AjzPTqGDj0xE+LWVe5Y0U87OE6e+21Al6yXC8+1AcprSLuqOrDTSeMn5526tW/CjQy9h
         I3Qg==
X-Gm-Message-State: AOJu0YyB66t9QofN7OFrc01Z76mQK+ENu6xiCVecZ8dguEQ1hOPFHpZq
	Ae3e6G7OhEuzacj37Be6htyZeeaNR6UzZvpK4Bx2aGG8E3gxkyWIUNcF
X-Gm-Gg: ATEYQzzKEsPI/XAbx9gL3Mu/6pNjKInaLGvqahUc7VeHqkdyDXURQci0kViP8C+tbAr
	GPC26Sa/5ZXgRaAB4n+LyqvHBaXAIFCNMy18CJ5S6ECXnYvqyWNTpExL7rsktg4tJadJlbcCing
	bUpNRsceLm2RJCA3xO4/OLZ5BQCWdwlJ3X9EL3597VKt/edJJipPFEvqcmwW+BVHydJ8tNPKXmc
	nL+d0hWuBCq4DjLjS0B3jPFoLWUbLjCCRqfVbt83sJN/CEGGIwWdarRlJpUnhvTOBWNuhZ+8qNQ
	HMJCaSo6EITMp0APuNFUI6XidNElkI3/uCF5LezCLR3w1me8ypBURZWKpauec/pv7jaNFNGSciU
	JmeEo64sRoohMWv7ITqQQZ/Pz6Der7DxLdK2PPfrCFFbbnKUu4SSHD2mAz5SZsgTSNvUO5bQBSf
	H0tx6BHBmAluOqzvUTvvs9dA8wzA9bHapFtZz/52s/kPltgjDGHkhlfTl2lA==
X-Received: by 2002:a05:690c:c244:b0:796:4626:7425 with SMTP id 00721157ae682-7982914a1ccmr83072927b3.49.1771872900476;
        Mon, 23 Feb 2026 10:55:00 -0800 (PST)
Received: from devvm11784.nha0.facebook.com ([2a03:2880:25ff:72::])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-7982dd88efcsm34856507b3.24.2026.02.23.10.54.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 23 Feb 2026 10:55:00 -0800 (PST)
Date: Mon, 23 Feb 2026 10:54:58 -0800
From: Bobby Eshleman <bobbyeshleman@gmail.com>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: virtualization@lists.linux.dev, netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Stefano Garzarella <sgarzare@redhat.com>,
	stable <stable@kernel.org>
Subject: Re: [PATCH net] vsock: Use container_of() to get net namespace in
 sysctl handlers
Message-ID: <aZyigkExZEUc1bYE@devvm11784.nha0.facebook.com>
References: <2026022318-rearview-gallery-ae13@gregkh>
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <2026022318-rearview-gallery-ae13@gregkh>

On Mon, Feb 23, 2026 at 06:32:18PM +0100, Greg Kroah-Hartman wrote:
> current->nsproxy is should not be accessed directly as syzbot has found
> that it could be NULL at times, causing crashes.  Fix up the af_vsock
> sysctl handlers to use container_of() to deal with the current net
> namespace instead of attempting to rely on current.
> 
> This is the same type of change done in commit 7f5611cbc487 ("rds:
> sysctl: rds_tcp_{rcv,snd}buf: avoid using current->nsproxy")
> 
> Cc: Stefano Garzarella <sgarzare@redhat.com>
> Cc: stable <stable@kernel.org>
> Assisted-by: gkh_clanker_2000
> Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
> ---
> 
> Note, this is compile-tested only.  Some of my scripts found this when
> looking for places that are missing fixes that were applied to other
> parts of the kernel.  I think the af_vsock code uses namespaces, but as
> I don't know the network stack at all I figured I would let you all
> review it to tell me how wrong I got this change and all is fine with
> the original code.
> 
> thanks,
> 
> greg k-h
> 
>  net/vmw_vsock/af_vsock.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/net/vmw_vsock/af_vsock.c b/net/vmw_vsock/af_vsock.c
> index 9880756d9eff..f4062c6a1944 100644
> --- a/net/vmw_vsock/af_vsock.c
> +++ b/net/vmw_vsock/af_vsock.c
> @@ -2825,7 +2825,7 @@ static int vsock_net_mode_string(const struct ctl_table *table, int write,
>  	if (write)
>  		return -EPERM;
>  
> -	net = current->nsproxy->net_ns;
> +	net = container_of(table->data, struct net, vsock.mode);
>  
>  	return __vsock_net_mode_string(table, write, buffer, lenp, ppos,
>  				       vsock_net_mode(net), NULL);
> @@ -2838,7 +2838,7 @@ static int vsock_net_child_mode_string(const struct ctl_table *table, int write,
>  	struct net *net;
>  	int ret;
>  
> -	net = current->nsproxy->net_ns;
> +	net = container_of(table->data, struct net, vsock.child_ns_mode);
>  
>  	ret = __vsock_net_mode_string(table, write, buffer, lenp, ppos,
>  				      vsock_net_child_mode(net), &new_mode);
> -- 
> 2.53.0
> 

Thanks Greg. LGTM, and passed all tests on my test setup.

I can't say if nsproxy can be null here in particular but better safe
than sorry.

Reviewed-by: Bobby Eshleman <bobbyeshleman@meta.com>
