Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F02B42BE65D
	for <virtualization@lists.linux.dev>; Fri, 25 Jul 2025 08:39:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753432779; cv=none; b=gXNWtXC2ZEIHGr4nUPZl+fw4dKDsni/2A+JukHq23hRrU/6NRToakw8HR5sL1r1dg2PBLzBRJqwS/l23Q4Vb/DxR5yb6XEHNxxIVEkmAgLCCPzaG0PZy3EuV5AgwckWVEOg6KeGvZv8lUKm+iQXqY1Wcga+BNLVa8IyHBz6Oaak=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753432779; c=relaxed/simple;
	bh=tBY0iimkxVoIBYuB3s33dxWd0cIaOYVPs9j9EliKe5o=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 In-Reply-To:Content-Type:Content-Disposition; b=uC+Im9f0p+86aHj72/iB/YCp8cMk95+of0RbOrqFSFxlti25rp5yBvvKgc1yHCR4SdQgVrPIWce2ApJTIxIUqLwVMNHcyXFyarW2GYogz7SP1qliP7TKcrch4XzOi1nxOZYuAnIf6EQPfoZP3Juq69IW3Y1dK2xctt9xUiUWGbU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=OJk7TxpC; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="OJk7TxpC"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1753432776;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=jtiFyoZfZGgkbcgP/8jfuIG2d1G6bK99JX46EtJwAvg=;
	b=OJk7TxpCCUlbCY48VcHsK5lpIvHaQPV+qWbqMvIqAoLgNxIzmA5VZ2XVfvSr0oKeNZuXTV
	dpSosKD+egjgwNxupWe+sKnWUDIHwB+IQ5lKLPEj9ZjwPNPTmep2n5WMBQ49J5ApIo4vjR
	FsbFNItAua3b7ZA7HGfHnDuYSJOS+/M=
Received: from mail-qv1-f69.google.com (mail-qv1-f69.google.com
 [209.85.219.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-517-mXwtqtHCMdKGAm_yWCPTJA-1; Fri, 25 Jul 2025 04:39:34 -0400
X-MC-Unique: mXwtqtHCMdKGAm_yWCPTJA-1
X-Mimecast-MFC-AGG-ID: mXwtqtHCMdKGAm_yWCPTJA_1753432774
Received: by mail-qv1-f69.google.com with SMTP id 6a1803df08f44-6fb50d92061so28917466d6.3
        for <virtualization@lists.linux.dev>; Fri, 25 Jul 2025 01:39:34 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1753432774; x=1754037574;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=jtiFyoZfZGgkbcgP/8jfuIG2d1G6bK99JX46EtJwAvg=;
        b=WQvQrkXtmC969uizFSDZULZPEI+/jLogAEZXZ/cGC6QEFGP/+/0xXE19zKfH3lsqm7
         NpYZrzsOul/PkGU09adC0E3w6Y77/1mTHWjTN6ZuVGekBDk9NEw+MiBWGtczyqHhVbAd
         U1qfCA7wguPik7rYA/uw3Ro1MeE4w1l41/ptGkJoB1EBh1DcbHNrnU7xPeT01Rw7XY39
         lauMRn7wqvZNNl1SkaNgQrX8bvorUPa3zpsrxmyl6SglwUtOS9aR0i8GSXR3Dnbhifjs
         u7UzufgFG37Ls8nW+Pj+ZqVrq0uSsMO5ZkFIBC6NU+ZHOLDkB54LyYxUUbRahU24V1H0
         FKwA==
X-Forwarded-Encrypted: i=1; AJvYcCV+geXrt3I63LON5iUaLDtB4pk662M5WqdKk/nFcbS8KycDJmbmbWT2RoppFqvk+mIV6EVsjqRaARXEKxCHCQ==@lists.linux.dev
X-Gm-Message-State: AOJu0Yxb8R6Yb0h48mEKv+tTKTnEz6v/bJ0BG+knAlF11HJYTiWdgZdR
	XTDRlCKQa88tzIfnsM46h80Sge86Wp14qa2DqJ2xAj+Mz3YNVeY2LNQHfQgzL/V4DjhZhnj9uT5
	av+fMGswea673VIsQU+TqghEF7TCaBaLgy56pZjySXIbcof6Zty5euofo3sJwlFY76gr1
X-Gm-Gg: ASbGncsI95Z+hmIDe1lBDOxdKDnznSVTk0FKrdy/Upp8b3aubv93ctARHMNAJOj54sL
	OEECp/QaCAjdZUtgxV/JN6GuS4VHQNvsM95MWPJirdYWltd+hzuA5iF3M56RhA6qfc44hrYEOva
	l3rhjfBFOJOT/6cMCpxBo+j7cbdGPgpN6pYRGtf0P60C4kqGMjvXpYvO/vnLU6N9SC0gcRgZV1Z
	an1r1Yqq3B/w1i7i+4mxj7Sh5OSRR++XHJmY/zel6SK8WzyXNu1eHSgL03IZb+96niM8yOJQ1Ui
	3p5SoRnG8uFjBFnhGyv28Acit1URjK5xHwaB/B6Y8lWdv9mwEtYCLHRDje4RHTtExIu9Gkp5+xS
	BdRBpQqdptzW+nGc=
X-Received: by 2002:a05:6214:242c:b0:6fa:bb26:1459 with SMTP id 6a1803df08f44-707204dceacmr12797396d6.7.1753432773691;
        Fri, 25 Jul 2025 01:39:33 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEuvrU/iDku3ReNmbC6er8A+AX9lbZ9M1ZVZ63Zo4Y0gnCBIubTMZ5l4qHxguWAFRNt5SjA+A==
X-Received: by 2002:a05:6214:242c:b0:6fa:bb26:1459 with SMTP id 6a1803df08f44-707204dceacmr12797146d6.7.1753432773224;
        Fri, 25 Jul 2025 01:39:33 -0700 (PDT)
Received: from sgarzare-redhat (host-79-45-205-118.retail.telecomitalia.it. [79.45.205.118])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-7070fca2189sm24242566d6.62.2025.07.25.01.39.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 25 Jul 2025 01:39:32 -0700 (PDT)
Date: Fri, 25 Jul 2025 10:39:25 +0200
From: Stefano Garzarella <sgarzare@redhat.com>
To: Wang Liang <wangliang74@huawei.com>
Cc: davem@davemloft.net, edumazet@google.com, kuba@kernel.org, 
	pabeni@redhat.com, horms@kernel.org, yuehaibing@huawei.com, 
	zhangchangzhong@huawei.com, virtualization@lists.linux.dev, netdev@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH net-next] vsock: remove unnecessary null check in
 vsock_getname()
Message-ID: <dqlpaa6nczbjmf5agbjktmlzu2avgnqjmsuisp2ic2hsvgxh7a@ruhby5c6lcbn>
References: <20250725013808.337924-1-wangliang74@huawei.com>
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
In-Reply-To: <20250725013808.337924-1-wangliang74@huawei.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: BwQd11NX4VT5Azi7lQepq_CRi7QZv0m8iUmtxqlRU_I_1753432774
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline

On Fri, Jul 25, 2025 at 09:38:08AM +0800, Wang Liang wrote:
>The local variable 'vm_addr' is always not NULL, no need to check it.
>
>Signed-off-by: Wang Liang <wangliang74@huawei.com>
>---
> net/vmw_vsock/af_vsock.c | 5 -----
> 1 file changed, 5 deletions(-)

Thanks for the cleanup! We've had it since the beginning, maybe some 
changes were made during initial development...

LGTM!

Reviewed-by: Stefano Garzarella <sgarzare@redhat.com>

>
>diff --git a/net/vmw_vsock/af_vsock.c b/net/vmw_vsock/af_vsock.c
>index 1053662725f8..fae512594849 100644
>--- a/net/vmw_vsock/af_vsock.c
>+++ b/net/vmw_vsock/af_vsock.c
>@@ -1028,11 +1028,6 @@ static int vsock_getname(struct socket *sock,
> 		vm_addr = &vsk->local_addr;
> 	}
>
>-	if (!vm_addr) {
>-		err = -EINVAL;
>-		goto out;
>-	}
>-
> 	/* sys_getsockname() and sys_getpeername() pass us a
> 	 * MAX_SOCK_ADDR-sized buffer and don't set addr_len.  Unfortunately
> 	 * that macro is defined in socket.c instead of .h, so we hardcode its
>-- 
>2.34.1
>
>

