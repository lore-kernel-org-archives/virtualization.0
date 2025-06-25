Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 27C0527932E
	for <virtualization@lists.linux.dev>; Wed, 25 Jun 2025 08:54:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750841694; cv=none; b=BaPKsW1qdfJXnwM3yC0cmpd/7YOnhyRV7e2nDDKr9n1qbEfbAh14A5UznWHi+KT7N7SLmZlfyi0vj2m2pZJsh/bqaO9XBNVTFL4OHCUHX3+RtoWrdYuYx7wffEjPWOkbqT3APlooahugCHuq7f8ezCBGpBSLp+r9HP+KTugaJs8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750841694; c=relaxed/simple;
	bh=IMHNO1bT1El4HG2JXEHyLJZxCIu/EzODJnWdqZWBHw8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 In-Reply-To:Content-Type:Content-Disposition; b=luQRG2vF0CwKU2HObDE92431JOPvk4tiatDofxgkHpSIqQjM98UIVekFpDDWeYIwxLtqJgvA9BOr1t6eDBO7JAWYJOjB0Ri6Cl6Wx9rL4XWibdySZHgWhpbXNo5TnNIQONxMPacTK2II6gcmqCjk98xk9VOgzro5q8+cspA+S4U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=Z1el1kpo; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Z1el1kpo"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1750841692;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=H7SojeMD2gps8cZo3IPHcE59cXnndpk0obLuxFCFG5c=;
	b=Z1el1kposlKIEOiLAV5lV80eTCdBGTnkOlhexFoZkGFqYnWkq2QvDl1r+1aMLJjYQX2LsV
	l5S4uK2T6M42wTBClw7CG9gZDL5dZlKWiqqp6jBm9Wfta/rHsJrbOScUXvK75EHnwTqJCU
	mqfojcACy85tC3rNZXe4sf87nNrx3RU=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-622-jpVHnFucN0SOa4Qvnp0eDw-1; Wed, 25 Jun 2025 04:54:49 -0400
X-MC-Unique: jpVHnFucN0SOa4Qvnp0eDw-1
X-Mimecast-MFC-AGG-ID: jpVHnFucN0SOa4Qvnp0eDw_1750841688
Received: by mail-wm1-f72.google.com with SMTP id 5b1f17b1804b1-450d64026baso7435625e9.1
        for <virtualization@lists.linux.dev>; Wed, 25 Jun 2025 01:54:48 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1750841688; x=1751446488;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=H7SojeMD2gps8cZo3IPHcE59cXnndpk0obLuxFCFG5c=;
        b=E5nirLmnwxDYyJhDhaZNBpUSsvisKtx6JG0HteR4f39CYl5ZwBtjC3CHfLrTKWzCMp
         YvbQKWrr9W+OIE0CEd+yM6ZBXi8MVvpUjmWKNJMEb3u7r53CuWD8jatmJA9oeuMj8YRX
         B/Z9Ft8R6qVr3qI1q8TS4uh2YnCV3vDkmMSZ8DSdvlDyBxgoQ9/uQQ5NhfKidZvh8zCc
         6HKCqoZis1/TXCj6LfNvuTnnsXZ/D82BT4fGjYRXKvx9U6lCp7psyHIEVSIfzzusspXx
         ur/0jXG3yFFJyggzGdSCyG2Ue6X8RYVks0LQpQyq0cISK5z3YIBeKG55csFqT4Da7HEE
         MLkQ==
X-Forwarded-Encrypted: i=1; AJvYcCW9DfHaKl3lJG1LtG8I51jdlsMN0iGWndDvAsMdD+v9GSZmR4h1rqO8sKiNC01edpKRGS8afYfpTK5LajVqSQ==@lists.linux.dev
X-Gm-Message-State: AOJu0Yyrx0HhfPiB5o1dGn6zwW72XkIYpajb+I/C+FJ0sLrA8DSIr5vk
	5mcrCmalAFHSy5lHrv+HKABf4Ps6UWSlC6dhuJPBuUai8gTNF8YMriJL0g/8t1vjnGtFLDPj64C
	RE/xL2VhrDXDRs+Q3v9twoBFLQ0CmiP1VvJrNxIHP418Hh5nme7DsCME8ypwH6nb9jv/+
X-Gm-Gg: ASbGncvmrzQg2aeVK74pMHU00soN3HMh0I4foKLpmIZLtPycAfi/0sc027mvgYiF4Bw
	RjCLK3ycZ2CjfCJYMldDn7vw4I2N6a3YfCBof2M4FpBNJ8sT5kp1Cl8iiA4pCw6uSwiZ2rZbt4J
	3I7/Z+C1RoOqt1iB5biR4ZOCvAIBOG3leJF5H6kd3ze98C8vqB6VUVhoD6URY3wSy8w8StdEaai
	dxPj15HxeZ/tO9h77V1HkOdrd6+M/yPpB75HJa31I9cnb/f7Yxvc2TWFbYDNmuc2Ko7Jo2k5kFZ
	YP3E8igu0txoy2c3yC+j0HzhL7hN
X-Received: by 2002:a05:600c:35d2:b0:450:d00d:d0 with SMTP id 5b1f17b1804b1-45381ae467cmr18288055e9.19.1750841687670;
        Wed, 25 Jun 2025 01:54:47 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGYLN8WpVcipmrn+PxxvTbwwdYiFGmiYVj3yUsHDD0K7ZUDXBWM8hLnXLAMurjH8x8NH2rxcA==
X-Received: by 2002:a05:600c:35d2:b0:450:d00d:d0 with SMTP id 5b1f17b1804b1-45381ae467cmr18287785e9.19.1750841687044;
        Wed, 25 Jun 2025 01:54:47 -0700 (PDT)
Received: from sgarzare-redhat ([193.207.151.122])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-453823ad247sm13350055e9.26.2025.06.25.01.54.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 25 Jun 2025 01:54:46 -0700 (PDT)
Date: Wed, 25 Jun 2025 10:54:40 +0200
From: Stefano Garzarella <sgarzare@redhat.com>
To: Michal Luczaj <mhal@rbox.co>
Cc: "David S. Miller" <davem@davemloft.net>, 
	Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, 
	Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>, 
	Stefan Hajnoczi <stefanha@redhat.com>, virtualization@lists.linux.dev, netdev@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH RFC net v2 3/3] vsock: Fix IOCTL_VM_SOCKETS_GET_LOCAL_CID
 to check also `transport_local`
Message-ID: <uqap2qzmvkfqxfqssxnt5anni6jhdupnarriinblznv5lfk764@qkrjq22xeygb>
References: <20250620-vsock-transports-toctou-v2-0-02ebd20b1d03@rbox.co>
 <20250620-vsock-transports-toctou-v2-3-02ebd20b1d03@rbox.co>
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
In-Reply-To: <20250620-vsock-transports-toctou-v2-3-02ebd20b1d03@rbox.co>
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: tyAZ2BJssF-K1iMsMtnvrKMPbs891cykkNK4qKJ99uc_1750841688
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline

On Fri, Jun 20, 2025 at 09:52:45PM +0200, Michal Luczaj wrote:
>Support returning VMADDR_CID_LOCAL in case no other vsock transport is
>available.
>
>Fixes: 0e12190578d0 ("vsock: add local transport support in the vsock core")
>Suggested-by: Stefano Garzarella <sgarzare@redhat.com>
>Signed-off-by: Michal Luczaj <mhal@rbox.co>
>---
>man vsock(7) mentions IOCTL_VM_SOCKETS_GET_LOCAL_CID vs. VMADDR_CID_LOCAL:
>
>   Ioctls
>       ...
>       IOCTL_VM_SOCKETS_GET_LOCAL_CID
>              ...
>              Consider using VMADDR_CID_ANY when binding instead of
>              getting the local CID with IOCTL_VM_SOCKETS_GET_LOCAL_CID.
>
>   Local communication
>       ....
>       The local CID obtained with IOCTL_VM_SOCKETS_GET_LOCAL_CID can be
>       used for the same purpose, but it is preferable to use
>       VMADDR_CID_LOCAL.
>
>I was wondering it that would need some rewriting, since we're adding
>VMADDR_CID_LOCAL as a possible ioctl's return value.

IIRC the reason was, that if we have for example a G2H module loaded, 
the ioctl returns the CID of that module (e.g. 42). So, we can use both 
42 and VMADDR_CID_LOCAL to do the loopback communication, but we 
encourage to always use VMADDR_CID_LOCAL.  With this change we basically 
don't change that, but we change the fact that if there is only the 
loopback module loaded, before the ioctl returned VMADDR_CID_ANY, while 
now it returns LOCAL rightly.

So, IMO we are fine.

>---
> net/vmw_vsock/af_vsock.c | 2 ++
> 1 file changed, 2 insertions(+)
>
>diff --git a/net/vmw_vsock/af_vsock.c b/net/vmw_vsock/af_vsock.c
>index a1b1073a2c89f865fcdb58b38d8e7feffcf1544f..4bdb4016bd14d790f3d217d5063be64a1553b194 100644
>--- a/net/vmw_vsock/af_vsock.c
>+++ b/net/vmw_vsock/af_vsock.c
>@@ -2577,6 +2577,8 @@ static long vsock_dev_do_ioctl(struct file *filp,
> 		cid = vsock_transport_local_cid(&transport_g2h);
> 		if (cid == VMADDR_CID_ANY)
> 			cid = vsock_transport_local_cid(&transport_h2g);
>+		if (cid == VMADDR_CID_ANY && transport_local)
>+			cid = VMADDR_CID_LOCAL;

why not `cid = vsock_transport_local_cid(&transport_local)` like for 
H2G?

Thanks,
Stefano

>
> 		if (put_user(cid, p) != 0)
> 			retval = -EFAULT;
>
>-- 
>2.49.0
>

