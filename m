Received: from mail-yx1-f44.google.com (mail-yx1-f44.google.com [74.125.224.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3F2B42135D7
	for <virtualization@lists.linux.dev>; Tue, 24 Feb 2026 00:24:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.224.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771892653; cv=none; b=QG4dy2m2nkvHp7qGS4w89Mu2hgK+19XDRR9H/4KGbkRBYsZYnNUQneo4DaF4DN1h1ri8yE6WdcIHsD8BKlUy94Hy4SNmzkmuvT4BUtDMPyRmbwyZq6RyeH+hhjGxnC94I0x09sWYji/1+NxuPuKUE+xo5GKtvWlVLMUH4yTnbhQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771892653; c=relaxed/simple;
	bh=jKHWyDAu0xJvzI3WO6+meQgDEHUikzp88qy14INmcPk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=sj3f1MQ0BQFxc83pyinSHOOVEV2AORNvFOACs3J2b52ZKJnBuH5p6WnLhX5QIAEQBlH/nFi2L+RADBXorNgR4UFb1+0vA21e9uGoH7h7ABl/OyTiXa9AMe8xSccd0SK4DDxMhVAY43C4TwKssW98W/tJIQXWmAhywk7DM8xAZtk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=St4TNmq1; arc=none smtp.client-ip=74.125.224.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="St4TNmq1"
Received: by mail-yx1-f44.google.com with SMTP id 956f58d0204a3-64c9707fc11so743119d50.2
        for <virtualization@lists.linux.dev>; Mon, 23 Feb 2026 16:24:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1771892650; x=1772497450; darn=lists.linux.dev;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=u1akxnV01TuuqkqVdn8oJReBwARp0bMrNePNSdt98A4=;
        b=St4TNmq1itbhTCzd3dyMBsiye9YQECX5snsTKhh4/vVYTfWUPYOETIu5T/Z8Dq1uIt
         Sq2lhpf6UFqU9RoLZh0ZkQwZ/f3DDOClGIRuD/0zyHbKblPkQnkPY6BYdS+4dFa4yRJH
         /VYVfPbd43L5SHNF6hqBbIyvO58LKSuN4THWvoYglJ9wWWfklf6CKq2R6pB6mFmFRgPl
         f/e2vcHstpGatBP7sWYgj/j6ORdrgCCw9KfKwTRClQpHVJM2JTEMSkkbc73b4VpuPygf
         iUcYqr6G2zMLtoU57rP3/u70SKlQ6xgpW6ok7SNgJfJgS+ZZfjX4uSM2YokNHTRsk4hN
         8yKg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1771892650; x=1772497450;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=u1akxnV01TuuqkqVdn8oJReBwARp0bMrNePNSdt98A4=;
        b=Tu7a8D1zezsCq5Tyq7kZUyIwosmHkcrApEo+Hazru6jgxoDCiCZ9dcoG8KNXNLNnVl
         jv7/w98egKvFHJdGiSGEru8LJ292eToDJPkTXGF4fwgLsPE2vQ8NFtHN5hBTlO+H/pSV
         +D6FjnsvLYXDAFVGsyLEiCn2vk/G7f25H3HE7w545tmjcFNY7gxyGGO23KT3uDt01BpD
         DhgBP0czS9cVTtson+mIku6k1zEY/xnxKaOGoHudGMhHCSbdd2QXoYpoaEoMl/ThnxrZ
         a09t73WWRzOeW9EIMKmPuU57qixVFBTAqOTg13PReqTwWANJOq4WZWo2p9exTE/Y6njd
         ltCg==
X-Gm-Message-State: AOJu0Yy2WE7F4bAsbx1nSDPBB2vJG+NsQaFRr5iTxgqCjSltAeqd0ELP
	49nZiZbgr/BLXn+z0v3LG+qj6g6qBgHbJJd0vaNC5loDM4QZ/rX7i3pX
X-Gm-Gg: ATEYQzxvyAqTUgRxLkWN5UHesNvHzqedDa7ayBvWGr+9D+pANAnoZWMt7GHTwPcHWsM
	tU/ptyJjXqaTkmYQIJhoyhGv2OxiBaJh+4yLw6ZM2c1Fx2b6ewEmy1O0987owGaBmX8GzmD+VG+
	4xAA/99SZIYwRHOAEvMP+/KmZaHLUyDvzupFKHxvB47Qp9zlR08JY4Y19akXYr3gikMxBdPzR19
	9dTs+FekWaMnh/zM3nFuVRr2nWsXMqc9+pMNNeT6wY+lrG+mlVqWdMpDceT8p1Qk6iAp4TBCW+1
	ryTzz+gviP7wcrRYYU+WAME+PDJuDblGbLRA8i7s8lS0nq/gKypfhlrTH0oml1ckLd/QIEhCPUU
	OM+6VDsleFhjP3GzRwr4tjvjAyxeWxbMNiQbtVOL4Bx9BSkfac/7Xd0hCUjjDsrP8U/BJ+Bu5AY
	egNcgCVrCCFprSnn7bsFpgo1z/pcHyqZadusxhZr4zy8ePGgQ=
X-Received: by 2002:a05:690e:4149:b0:649:4906:770a with SMTP id 956f58d0204a3-64c788d2821mr7812527d50.8.1771892650119;
        Mon, 23 Feb 2026 16:24:10 -0800 (PST)
Received: from devvm11784.nha0.facebook.com ([2a03:2880:25ff:41::])
        by smtp.gmail.com with ESMTPSA id 956f58d0204a3-64c7a35d839sm3891935d50.13.2026.02.23.16.24.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 23 Feb 2026 16:24:09 -0800 (PST)
Date: Mon, 23 Feb 2026 16:24:07 -0800
From: Bobby Eshleman <bobbyeshleman@gmail.com>
To: Stefano Garzarella <sgarzare@redhat.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>,
	Stefan Hajnoczi <stefanha@redhat.com>,
	Shuah Khan <shuah@kernel.org>,
	Bobby Eshleman <bobbyeshleman@meta.com>,
	"Michael S. Tsirkin" <mst@redhat.com>,
	Jonathan Corbet <corbet@lwn.net>,
	Shuah Khan <skhan@linuxfoundation.org>
Cc: virtualization@lists.linux.dev, netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org, kvm@vger.kernel.org,
	linux-kselftest@vger.kernel.org, linux-doc@vger.kernel.org,
	kuniyu@google.com, ncardwell@google.com,
	Daan De Meyer <daan.j.demeyer@gmail.com>
Subject: Re: [PATCH net v3 2/3] vsock: lock down child_ns_mode as write-once
Message-ID: <aZzvp52L4smGF7cM@devvm11784.nha0.facebook.com>
References: <20260223-vsock-ns-write-once-v3-0-c0cde6959923@meta.com>
 <20260223-vsock-ns-write-once-v3-2-c0cde6959923@meta.com>
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260223-vsock-ns-write-once-v3-2-c0cde6959923@meta.com>

On Mon, Feb 23, 2026 at 02:38:33PM -0800, Bobby Eshleman wrote:
> From: Bobby Eshleman <bobbyeshleman@meta.com>
> 
> Two administrator processes may race when setting child_ns_mode as one
> process sets child_ns_mode to "local" and then creates a namespace, but
> another process changes child_ns_mode to "global" between the write and
> the namespace creation. The first process ends up with a namespace in
> "global" mode instead of "local". While this can be detected after the
> fact by reading ns_mode and retrying, it is fragile and error-prone.
> 
> Make child_ns_mode write-once so that a namespace manager can set it
> once and be sure it won't change. Writing a different value after the
> first write returns -EBUSY. This applies to all namespaces, including
> init_net, where an init process can write "local" to lock all future
> namespaces into local mode.
> 
> Fixes: eafb64f40ca4 ("vsock: add netns to vsock core")
> Suggested-by: Daan De Meyer <daan.j.demeyer@gmail.com>
> Suggested-by: Stefano Garzarella <sgarzare@redhat.com>
> Co-developed-by: Stefano Garzarella <sgarzare@redhat.com>
> Signed-off-by: Stefano Garzarella <sgarzare@redhat.com>

Stefano, I wasn't sure if you wanted the Co-developed-by and S-o-b on
this iteration, but I added it just in case. Please let me know, if that
wasn't what you intended.

Best,
Bobby
