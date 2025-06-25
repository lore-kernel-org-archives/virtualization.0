Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 102A5286418
	for <virtualization@lists.linux.dev>; Wed, 25 Jun 2025 08:43:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750841006; cv=none; b=PNyXGRYeXLcYxpdx1EDsZXHQGrPk2dbaSqnxGbG0Rjoqrwxv234Rec9IiBx9l6lvHzzc9aK3t+yoIKUnOXqg50PdCl4OGzDDOBETXFfbfLHWmhJbItaghTzwKRPAzR6Cox/rwpWeQbjkpM5GMBS5O5PHQ8bj/kR205le864qYFI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750841006; c=relaxed/simple;
	bh=BKtDcFi1Di1ki3VEVQwPsdVZaQrBBaEmFv2TZrKgRUk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 In-Reply-To:Content-Type:Content-Disposition; b=kkd89uyBuNcHB0oyzP1ADRLQQbKv83P5Pz9NYPGW4t25GUnAuXVxVmPmChBwRiAC/L1zQHc7y3IjkizzUwzt1jg+1ofu9MtwfhVO3P0zH91dt4JevLD/8Ub26ZDZI0rTV6GSL52X/mLyRwmaVkxD7ukxTitEt+r6WbcoGFO83O4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=Ehjd1MSk; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Ehjd1MSk"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1750841004;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=fBqo0mSOQ7uYPQmFn/GbeEwpagKUqVWJtoBByFsAo4c=;
	b=Ehjd1MSkvhjTlx03oy4I3RO9VY2YCKhhylowJ8ptvq0lBxVCJKbuFdvQqVIK6NnqnuR00W
	wg07tTR5uX5bnjErS3yia0I85XaymRmpEJ8NDgkLLMZB22WtN9/a9AuJU8Y5TqUZxbR8MX
	uuwDsdYuS8D2LrdvXv6N1964hsQddxM=
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-436-hF7IoiGKPeSNfrnceLRoCQ-1; Wed, 25 Jun 2025 04:43:22 -0400
X-MC-Unique: hF7IoiGKPeSNfrnceLRoCQ-1
X-Mimecast-MFC-AGG-ID: hF7IoiGKPeSNfrnceLRoCQ_1750841001
Received: by mail-wr1-f72.google.com with SMTP id ffacd0b85a97d-3a56b3dee17so323188f8f.0
        for <virtualization@lists.linux.dev>; Wed, 25 Jun 2025 01:43:21 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1750841001; x=1751445801;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=fBqo0mSOQ7uYPQmFn/GbeEwpagKUqVWJtoBByFsAo4c=;
        b=ecED5NZ9IwFOmaJSpXB1CY4KnrSgbA2rkUuUbWvBE+8YFJnPMpVdPlbaULo0dh5HhU
         pI9piefUrEgw/CEPUhAMT1ewxaqIfeUA4FnHcHlOfxP3S61HwwnC4GFD7ykBQSg1Fl70
         4Tq8h40x3Rx3E78YNUyq04K1WdqQ/k+wseyoNgilOtDjoUzurJcesWdkgQHE5rGiwqbL
         QBRyH3o5iMKwlBqP518WUPndP99oNMbIcCRxt9AmL7goId0LNaM7a39iZNcQFwpc1zMV
         afDHAYkWKIt9IJjAu59hUvWydC5/YUZJq7/2BXOGMYVr5Ypq//aAmWDOkWhhX4gAolGY
         Gocg==
X-Forwarded-Encrypted: i=1; AJvYcCVVTDzaQLQn/qIfA1FEXUVoQmnApuTO3Ft59K/90Xozn4oJ8iQey3yzXLK4xqa3gzLIeCGl5Mj0pDjFVoyyIg==@lists.linux.dev
X-Gm-Message-State: AOJu0YxN19WIPYqpKNHB5y/JkyIQ38c4OXiv8JDe8dlfqeMok4uE2Qv+
	fLDLHgYCfXpuhY9fvcS2bqDywFgjsKLQgez574IpOaLc5cQQq3IP5Q3zTv4ESC15p4DC0NpQW2C
	LQaHm3yQO6BrGnDwQeAOLQW2t5jwmnFmieY3Vl/DoJqSdQ+hd1Gb6+NO886dcZbt+3hX9
X-Gm-Gg: ASbGncvKOsVk4Yi8998p4DdeV4XIJno44+6/1mJZfeQJONGcMcPGDswLSE2eiXbNox1
	CzUIfbgnBV4ZGTYgmkb42m/ifbXPRAhmEWrEHMuWzcnfLdIrJ/T0fA9rY9xA2DbZLEER8mMDPvL
	6xpV9ctKdEi3TXsYXv4rFVL01CqxlVw+v/VUSMySOCglIJgi5vs22QTOLTLttIla37HhxTMW51B
	QOrObEN7o5CbTgsC/8PcxOrsyn6yr1yFKSao5zi4JuvsfXbvyueN/CUDo8em/2gfOzmIM/kS3rQ
	EGU7WHxiypKUwDyQXfWY4m1Ci06r
X-Received: by 2002:a5d:64e6:0:b0:3a4:f722:a46b with SMTP id ffacd0b85a97d-3a6e71ff6aamr5892467f8f.15.1750841000855;
        Wed, 25 Jun 2025 01:43:20 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEwLmN7pgjPo42yw5pKV9YdU4xug/vMd5HIXDLqwYvt3dwxUtKIILfncsdF1q/xkL+ig67Dmg==
X-Received: by 2002:a5d:64e6:0:b0:3a4:f722:a46b with SMTP id ffacd0b85a97d-3a6e71ff6aamr5892437f8f.15.1750841000364;
        Wed, 25 Jun 2025 01:43:20 -0700 (PDT)
Received: from sgarzare-redhat ([193.207.151.122])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-45382363f7fsm12918295e9.27.2025.06.25.01.43.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 25 Jun 2025 01:43:19 -0700 (PDT)
Date: Wed, 25 Jun 2025 10:43:12 +0200
From: Stefano Garzarella <sgarzare@redhat.com>
To: Michal Luczaj <mhal@rbox.co>
Cc: "David S. Miller" <davem@davemloft.net>, 
	Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, 
	Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>, 
	Stefan Hajnoczi <stefanha@redhat.com>, virtualization@lists.linux.dev, netdev@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH RFC net v2 1/3] vsock: Fix transport_{g2h,h2g} TOCTOU
Message-ID: <zdiqu6pszqwb4y5o7oqzdovfvzkbrvc6ijuxoef2iloklahyoy@njsnvn7hfwye>
References: <20250620-vsock-transports-toctou-v2-0-02ebd20b1d03@rbox.co>
 <20250620-vsock-transports-toctou-v2-1-02ebd20b1d03@rbox.co>
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
In-Reply-To: <20250620-vsock-transports-toctou-v2-1-02ebd20b1d03@rbox.co>
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: v3c7ddZpigkF1tG-bX4Fyg6tgr6NzOe-JIkWFFoqTtI_1750841001
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline

On Fri, Jun 20, 2025 at 09:52:43PM +0200, Michal Luczaj wrote:
>vsock_find_cid() and vsock_dev_do_ioctl() may race with module unload.
>transport_{g2h,h2g} may become NULL after the NULL check.
>
>Introduce vsock_transport_local_cid() to protect from a potential
>null-ptr-deref.
>
>KASAN: null-ptr-deref in range [0x0000000000000118-0x000000000000011f]
>RIP: 0010:vsock_find_cid+0x47/0x90
>Call Trace:
> __vsock_bind+0x4b2/0x720
> vsock_bind+0x90/0xe0
> __sys_bind+0x14d/0x1e0
> __x64_sys_bind+0x6e/0xc0
> do_syscall_64+0x92/0x1c0
> entry_SYSCALL_64_after_hwframe+0x4b/0x53
>
>KASAN: null-ptr-deref in range [0x0000000000000118-0x000000000000011f]
>RIP: 0010:vsock_dev_do_ioctl.isra.0+0x58/0xf0
>Call Trace:
> __x64_sys_ioctl+0x12d/0x190
> do_syscall_64+0x92/0x1c0
> entry_SYSCALL_64_after_hwframe+0x4b/0x53
>
>Fixes: c0cfa2d8a788 ("vsock: add multi-transports support")
>Suggested-by: Stefano Garzarella <sgarzare@redhat.com>
>Signed-off-by: Michal Luczaj <mhal@rbox.co>
>---
> net/vmw_vsock/af_vsock.c | 23 +++++++++++++++++------
> 1 file changed, 17 insertions(+), 6 deletions(-)
>
>diff --git a/net/vmw_vsock/af_vsock.c b/net/vmw_vsock/af_vsock.c
>index 2e7a3034e965db30b6ee295370d866e6d8b1c341..63a920af5bfe6960306a3e5eeae0cbf30648985e 100644
>--- a/net/vmw_vsock/af_vsock.c
>+++ b/net/vmw_vsock/af_vsock.c
>@@ -531,9 +531,21 @@ int vsock_assign_transport(struct vsock_sock *vsk, struct vsock_sock *psk)
> }
> EXPORT_SYMBOL_GPL(vsock_assign_transport);
>
>+static u32 vsock_transport_local_cid(const struct vsock_transport **transport)

Why we need double pointer?

>+{
>+	u32 cid = VMADDR_CID_ANY;
>+
>+	mutex_lock(&vsock_register_mutex);
>+	if (*transport)
>+		cid = (*transport)->get_local_cid();
>+	mutex_unlock(&vsock_register_mutex);
>+
>+	return cid;
>+}
>+
> bool vsock_find_cid(unsigned int cid)
> {
>-	if (transport_g2h && cid == transport_g2h->get_local_cid())
>+	if (cid == vsock_transport_local_cid(&transport_g2h))
> 		return true;
>
> 	if (transport_h2g && cid == VMADDR_CID_HOST)
>@@ -2536,18 +2548,17 @@ static long vsock_dev_do_ioctl(struct file *filp,
> 			       unsigned int cmd, void __user *ptr)
> {
> 	u32 __user *p = ptr;
>-	u32 cid = VMADDR_CID_ANY;
> 	int retval = 0;
>+	u32 cid;
>
> 	switch (cmd) {
> 	case IOCTL_VM_SOCKETS_GET_LOCAL_CID:
> 		/* To be compatible with the VMCI behavior, we prioritize the
> 		 * guest CID instead of well-know host CID (VMADDR_CID_HOST).
> 		 */
>-		if (transport_g2h)
>-			cid = transport_g2h->get_local_cid();
>-		else if (transport_h2g)
>-			cid = transport_h2g->get_local_cid();
>+		cid = vsock_transport_local_cid(&transport_g2h);
>+		if (cid == VMADDR_CID_ANY)
>+			cid = vsock_transport_local_cid(&transport_h2g);

I still prefer the old `if ... else if ...`, what is the reason of this
change? I may miss the point.

But overall LGTM!

Thanks,
Stefano

>
> 		if (put_user(cid, p) != 0)
> 			retval = -EFAULT;
>
>-- 
>2.49.0
>

