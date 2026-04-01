Received: from mail-yx1-f49.google.com (mail-yx1-f49.google.com [74.125.224.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C1F6147D941
	for <virtualization@lists.linux.dev>; Wed,  1 Apr 2026 17:33:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.224.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775064816; cv=none; b=HFub0L6n3+iTXSY0YvOF2FR7Zggpk6g/lDHwSM5x9bfe8tq//1vtGnKoFJjHvY+FA1BjIvvvTK0cgcgWONDmSHRCQkDRv5BhV6csPvD+ED1MMsk1P/FPTIsxen9G1GLErGHnHqOSvdlHK+SpPufIleCFfUIozFMgO/E2JWEDofo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775064816; c=relaxed/simple;
	bh=GALUpL9FcmSNoTtHE6SpePyLmLDTRd/mTbP3SWjUuZY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=UBfXcZ0UdXVi5Aj+T+AYZc6t0+wHK1jZW4iZcQ1hZGl9f37iI2Na3/MV5P0CIHjGlh0s8MIiDsFFTUXtPUxBG+CVH9z+C081qdqJdq0feSMTaOSofKHgyoIcG14T0Iz9aip9mGogPBWtBS0iLaqZ+oJljsvi7nGGlMr+LFOeYMI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=s1Iz1jDZ; arc=none smtp.client-ip=74.125.224.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="s1Iz1jDZ"
Received: by mail-yx1-f49.google.com with SMTP id 956f58d0204a3-65032e9cf01so610d50.3
        for <virtualization@lists.linux.dev>; Wed, 01 Apr 2026 10:33:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1775064814; x=1775669614; darn=lists.linux.dev;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=aLnfQJSw9REm8a9+311bKseMryW3/suAyHmSGj3g0SU=;
        b=s1Iz1jDZkAbEVIatKSbyV81ohrM+aVIowXOPLJkJnl597hGESjsqKL9/UnnIfhNZBH
         ny/AKzy1D1ed/a7e4kUbLR+eTOPOQ/5XUvpQu62jlSgAK2j/jRYt5fej/Qy2iKVZ7pUf
         2CPE2BG5+ysrwwkR05rATXowjw/V8nsBM8pihU6Kmdkzzs7Uju/CKomwQ9mUkWI1ALjq
         fF49iM5mP2Ar7Vfqde+KUV1/2e5zmnQd2ZcCPOuSxG5hV1XnwjX140cbgziChgQjNvX2
         C4tCaZrsqZU7GqVVDOYZHiMpBdrtZnbPkLWQcFrMTGQMIJ6TADOEmvBm9dSodpdlsEQ8
         dUeA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1775064814; x=1775669614;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=aLnfQJSw9REm8a9+311bKseMryW3/suAyHmSGj3g0SU=;
        b=b/tYW2YrgVDGKoqRAvQ8aNGfgCOAgdSoaPQ7KouiKx3E5/gUZ8Q3StGrhKu1dIX+4B
         DhH5Gc0W5PxUSGJD+6mgCsr7baVIzM/Zu4ja6wpQwz0gIpcwo2j+Ijsf81lK8h9DgwBG
         jU61UlxGhxOx5rED1VR1y0dn+tMGqqfRZRJwJ/Tj2eoUtUormVzYAUuFt0omq3fzjlwg
         PRGZ69NfihDIEKKGggTgiEZQsDXwlzQzJ4Bqw/LcMrLhY6324S0lxkQwwdSNVMJ7Zu6T
         gZ5PTnv5NtSWiSdHpInOzq8O32M+bLsVY/A684UdiS0rQBbZ1uMDxRT9X5+1UbztuUNM
         81AQ==
X-Forwarded-Encrypted: i=1; AJvYcCW0wCilt+z0K+QwACh7zC5v8cJ2g1KgqQnpFci7jdvIfSK8TmAls7VWd6C739hFR5nRblsR9DdT3yfth26DCA==@lists.linux.dev
X-Gm-Message-State: AOJu0YxR//Yofxwq33v4pYmOEDqA/3Z8kRwFOXqmdLwrizovpOh/B3pt
	cLOmKnXsk8AZzztjZrFyHrKm5PrxhMDc05I9yYStlB4w4h1DXhBBS4tf
X-Gm-Gg: ATEYQzxqptLYGKh6jxKEh9VfOZtlq07GF1npjxq9WFyxDx6A5Aq8NRUDV/GW3UmykJu
	5oNUOp+6MUs2t9yD49jS3x3GeHuGURhJqZ6O10gMhSPa290gGnwHzEz+6EZrcaZ9T4Z82iy9aei
	wDmYdydoVlCyToI30XPMHLpibzlzICF41s9/TR/4e686z1IIq6WGV3oblRE6gTrT2qMBFRfedhT
	5lZ/j+wlamtDeWycSvhDcWNaVBBi2SYTLZyoQbdbmwDVNafahE8nD+7myXkqVGwRduqWUvU1Mb6
	TJNyEyBQ6U+YbEiyKQfEzfos+OArQAJzjwZ5K5rvXs1Mymzm0FK1OMIJOUApnbW3cnKrrdYoHL8
	2jnZKn1bn00t8zxfBNABXunK2xPq0ZEWh+dlEqUPRQ4KHOYrWoMXlNCHOsipB9YL6JF7q5Paf2C
	1sxCaVKXdUdjYCrWbSuPraRvPWt4kkZYbv
X-Received: by 2002:a05:690e:1c20:b0:650:3aae:e2e6 with SMTP id 956f58d0204a3-6503aaee65fmr764874d50.20.1775064813767;
        Wed, 01 Apr 2026 10:33:33 -0700 (PDT)
Received: from syzkaller ([2a03:2880:25ff:5c::])
        by smtp.gmail.com with ESMTPSA id 956f58d0204a3-6503a828f3csm214698d50.3.2026.04.01.10.33.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 01 Apr 2026 10:33:32 -0700 (PDT)
Date: Wed, 1 Apr 2026 10:33:27 -0700
From: Bobby Eshleman <bobbyeshleman@gmail.com>
To: Stefano Garzarella <sgarzare@redhat.com>
Cc: netdev@vger.kernel.org, "David S. Miller" <davem@davemloft.net>,
	linux-kernel@vger.kernel.org,
	Bobby Eshleman <bobbyeshleman@meta.com>,
	Jakub Kicinski <kuba@kernel.org>, Simon Horman <horms@kernel.org>,
	virtualization@lists.linux.dev, Eric Dumazet <edumazet@google.com>,
	Paolo Abeni <pabeni@redhat.com>, Jin Liu <jinl@redhat.com>
Subject: Re: [PATCH net] vsock: initialize child_ns_mode_locked in
 vsock_net_init()
Message-ID: <ac1W53WyCMYyOv4f@syzkaller>
References: <20260401092153.28462-1-sgarzare@redhat.com>
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260401092153.28462-1-sgarzare@redhat.com>

On Wed, Apr 01, 2026 at 11:21:53AM +0200, Stefano Garzarella wrote:
> From: Stefano Garzarella <sgarzare@redhat.com>
> 
> The `child_ns_mode_locked` field lives in `struct net`, which persists
> across vsock module reloads. When the module is unloaded and reloaded,
> `vsock_net_init()` resets `mode` and `child_ns_mode` back to their
> default values, but does not reset `child_ns_mode_locked`.
> 
> The stale lock from the previous module load causes subsequent writes
> to `child_ns_mode` to silently fail: `vsock_net_set_child_mode()` sees
> the old lock, skips updating the actual value, and returns success
> when the requested mode matches the stale lock. The sysctl handler
> reports no error, but `child_ns_mode` remains unchanged.
> 
> Steps to reproduce:
>     $ modprobe vsock
>     $ echo local > /proc/sys/net/vsock/child_ns_mode
>     $ cat /proc/sys/net/vsock/child_ns_mode
>     local
>     $ modprobe -r vsock
>     $ modprobe vsock
>     $ echo local > /proc/sys/net/vsock/child_ns_mode
>     $ cat /proc/sys/net/vsock/child_ns_mode
>     global    <--- expected "local"
> 
> Fix this by initializing `child_ns_mode_locked` to 0 (unlocked) in
> `vsock_net_init()`, so the write-once mechanism works correctly after
> module reload.
> 
> Fixes: 102eab95f025 ("vsock: lock down child_ns_mode as write-once")
> Cc: bobbyeshleman@meta.com
> Reported-by: Jin Liu <jinl@redhat.com>
> Signed-off-by: Stefano Garzarella <sgarzare@redhat.com>
> ---
>  net/vmw_vsock/af_vsock.c | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/net/vmw_vsock/af_vsock.c b/net/vmw_vsock/af_vsock.c
> index 2f7d94d682cb..d912ed2f012a 100644
> --- a/net/vmw_vsock/af_vsock.c
> +++ b/net/vmw_vsock/af_vsock.c
> @@ -2928,6 +2928,7 @@ static void vsock_net_init(struct net *net)
>  		net->vsock.mode = vsock_net_child_mode(current->nsproxy->net_ns);
>  
>  	net->vsock.child_ns_mode = net->vsock.mode;
> +	net->vsock.child_ns_mode_locked = 0;
>  }
>  
>  static __net_init int vsock_sysctl_init_net(struct net *net)
> -- 
> 2.53.0
> 

Reviewed-by: Bobby Eshleman <bobbyeshleman@meta.com>
