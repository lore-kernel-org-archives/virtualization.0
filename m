Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 843621118A
	for <virtualization@lists.linux.dev>; Sat, 20 Apr 2024 10:05:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713607527; cv=none; b=MwqspvPP55tZkuJajbRGUvTkThGqso692f1dNyjB4r9OrqRk5U0bZOahwYa/98N6wyysEsSMFCmdmoC7tfTjPJMHCxO73ypCc3/FjUb9f/MhxoaXc1tgu7oywH6Uo8jUDcjyVNdlrjwU6gpJaBvv3onYCEDs/LCkEpqb99Kkb5Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713607527; c=relaxed/simple;
	bh=UKYeRD8/XiIyAg9qRBsvwBklh4EieGaHp8R88F3ZOck=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 In-Reply-To:Content-Type:Content-Disposition; b=iI6AeMmRrz0yHN3i4fHiWuRIfwTv3UsSGmg8pV1NRxr4rXv+wB/Zpd6eOI4mriOx5GpO3ybTmnrLpF891BAbIjfcWcNr+wP4IiBNDixglvmD6qb7dew2rVGEzAYlR1NeJy767kACZC0KbHSOWpCAFrGrKrfZqcrjCfbr7/sUGFo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=Azbt1Y+5; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Azbt1Y+5"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1713607523;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=dupUFX22MvWJlz2LiPNASjX/H+JRFaBqC9DPNGlEAKk=;
	b=Azbt1Y+5Bq3SR0V8qnkiI77kmtGeMvQV6hN/yh9OaYHP0XNn+S8G/mUNVQHWLmfJwgaKZX
	Ck0ULpPrNEl5m5iM5jwQ6xNbyLSo4Vp+QPYIM5iv3pXjWRqKUrTVr3jYJw+8YFABahxBxV
	ksTWwfPGZE8O3d4HZxeFv7PNBNxJIMs=
Received: from mail-lj1-f197.google.com (mail-lj1-f197.google.com
 [209.85.208.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-126-ZhpwG8z2Pti_Thv3U93ZDQ-1; Sat, 20 Apr 2024 06:05:22 -0400
X-MC-Unique: ZhpwG8z2Pti_Thv3U93ZDQ-1
Received: by mail-lj1-f197.google.com with SMTP id 38308e7fff4ca-2dc9b94d01aso18077071fa.2
        for <virtualization@lists.linux.dev>; Sat, 20 Apr 2024 03:05:21 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1713607520; x=1714212320;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=dupUFX22MvWJlz2LiPNASjX/H+JRFaBqC9DPNGlEAKk=;
        b=sf8biCAI4AzIake6bTlBjApMWCItEJVI9mBNP+rH1h2hzO5w0Wp8q6Qx6dPwtaucZl
         sDHET8kgVI1JOZv/1q+bQMBi+z5t3yZg0LcMkv0hyrGfxvPp24NGDU0N9Hk4fGMa6CvD
         +ijbVPsKAxv4mBFEn2R+eNweaNgPWNbzc2kCakelD0xd5uZDsonhofaY1hn3vM8P5RoY
         9q+B7ser91eBFIdic2jZJUNMhU+pTgJU+6ruUJsPDHV62mnY0URGE4Qy2UFonVqJHekf
         pGqrPMkWiUkcef6ONHKBYbRDSv6gfFwwIx2QH4hZe8ItukBKJpc815I6CgAWfnkKaeSl
         pE5g==
X-Forwarded-Encrypted: i=1; AJvYcCURGKTo99HWNXLN1evp4SaHV4zT6KEt/L6+YR8HaHk2QJDn5Nuj4BRcJgPd7WxdN23hnyGscGACCP1D+SIwjSUd5k36VUfXIDi+KI0znRc=
X-Gm-Message-State: AOJu0YwHsRwLC8nyKNwZfB/2qJYcPaNpTceiCZgb+IpD/g10QxpdaEMD
	1oA7F+KVng8JZQi7HEYH2YlddNezd//vWjTioEg6eBUMecCp1IQKi/glU7IL8GToVD4MqzVltjE
	KQVljbc6RmM+LCpE912TUdUif1siHcRmqYqDVAryA9ivLtqLfPWaNbXltXgHcaqER
X-Received: by 2002:a2e:9798:0:b0:2da:a73:4f29 with SMTP id y24-20020a2e9798000000b002da0a734f29mr3610199lji.30.1713607520478;
        Sat, 20 Apr 2024 03:05:20 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFYBnMGeF141NDJiiAEbx9ZNUBUqnu1GBz0moT4dPDvrOwYJoOemN0dK9MgDRfLJOyGBx1O+Q==
X-Received: by 2002:a2e:9798:0:b0:2da:a73:4f29 with SMTP id y24-20020a2e9798000000b002da0a734f29mr3610179lji.30.1713607519984;
        Sat, 20 Apr 2024 03:05:19 -0700 (PDT)
Received: from redhat.com ([2a06:c701:7429:3c00:dc4a:cd5:7b1c:f7c2])
        by smtp.gmail.com with ESMTPSA id i13-20020a05600c354d00b00419fba938d8sm973597wmq.27.2024.04.20.03.05.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 20 Apr 2024 03:05:19 -0700 (PDT)
Date: Sat, 20 Apr 2024 06:05:15 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Jeongjun Park <aha310510@gmail.com>
Cc: syzbot+6c21aeb59d0e82eb2782@syzkaller.appspotmail.com,
	stefanha@redhat.com, sgarzare@redhat.com, jasowang@redhat.com,
	kvm@vger.kernel.org, virtualization@lists.linux.dev,
	linux-kernel@vger.kernel.org, syzkaller-bugs@googlegroups.com
Subject: Re: [PATCH virt] virt: fix uninit-value in vhost_vsock_dev_open
Message-ID: <20240420060450-mutt-send-email-mst@kernel.org>
References: <000000000000be4e1c06166fdc85@google.com>
 <20240420085750.64274-1-aha310510@gmail.com>
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
In-Reply-To: <20240420085750.64274-1-aha310510@gmail.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Sat, Apr 20, 2024 at 05:57:50PM +0900, Jeongjun Park wrote:
> Change vhost_vsock_dev_open() to use kvzalloc() instead of kvmalloc()
> to avoid uninit state.
> 
> Reported-by: syzbot+6c21aeb59d0e82eb2782@syzkaller.appspotmail.com
> Fixes: dcda9b04713c ("mm, tree wide: replace __GFP_REPEAT by __GFP_RETRY_MAYFAIL with more useful semantic")
> Signed-off-by: Jeongjun Park <aha310510@gmail.com>

What value exactly is used uninitialized?

> ---
>  drivers/vhost/vsock.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/vhost/vsock.c b/drivers/vhost/vsock.c
> index ec20ecff85c7..652ef97a444b 100644
> --- a/drivers/vhost/vsock.c
> +++ b/drivers/vhost/vsock.c
> @@ -656,7 +656,7 @@ static int vhost_vsock_dev_open(struct inode *inode, struct file *file)
>  	/* This struct is large and allocation could fail, fall back to vmalloc
>  	 * if there is no other way.
>  	 */
> -	vsock = kvmalloc(sizeof(*vsock), GFP_KERNEL | __GFP_RETRY_MAYFAIL);
> +	vsock = kvzalloc(sizeof(*vsock), GFP_KERNEL | __GFP_RETRY_MAYFAIL);
>  	if (!vsock)
>  		return -ENOMEM;
>  
> -- 
> 2.34.1

