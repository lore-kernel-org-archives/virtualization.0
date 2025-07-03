Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4D58417996
	for <virtualization@lists.linux.dev>; Thu,  3 Jul 2025 08:23:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751531039; cv=none; b=K9kXZISmO7Sz71qUj6mP77gEUq36MB8TWV2XS/NTJmdCLWxIkPROKd0K4qEYzqmcATD8EN54R8iZ90K8nTknDWZlzE9Fn/U0uXKPY69KxhxakYBSQ+Sz08HwW9xP4bnjyEcq/yKnCylIUdQLG+v4x8hlg6B9bKq17U0vcGzIF3A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751531039; c=relaxed/simple;
	bh=o+NkW4UjRCYC3Ox02bP9Grs2dJLcAnd5IKgqdCW1eLE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 In-Reply-To:Content-Type:Content-Disposition; b=uxK/mj/zMyGrNIo8KJKeyfEeg7NAVtgdDpED5PoLnutfBYV9l/+Ao4oJ+cbWMrqv5tsurP2QGxXmQk9Qo5Yr5oNHiHJLbVv+CP7WPU9elnN4RvLLCd3nm+QVgWMOOxJRs46WZaI0s1JAWqyjGBan1XnuyufJjyUeLpSJJwtA67s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=BBzq4HO3; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="BBzq4HO3"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1751531037;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=Ke2YfmZqQvuyIhOn4BkIuW587OZjecPx0SDiI46FKLs=;
	b=BBzq4HO3bm4L8uLva9XYnQz9lPYd3fJB7qSfFcg70CN/g/2fBZkR9A1WTjK1BAz7yH/Ajo
	NXlfYP4aMyPBgRkdeGOpuAuE4aN66mQs39RJ2RZrwwFI+PjFEe5jp24Qy70qaTSFY0z51Z
	a60ik0/bwsbYRg9wZFX0mgJ1vCOijxk=
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-135-jn4azCi7MfatA-7oT8S6Mw-1; Thu, 03 Jul 2025 04:23:56 -0400
X-MC-Unique: jn4azCi7MfatA-7oT8S6Mw-1
X-Mimecast-MFC-AGG-ID: jn4azCi7MfatA-7oT8S6Mw_1751531035
Received: by mail-wr1-f69.google.com with SMTP id ffacd0b85a97d-3a4f85f31d9so3254287f8f.1
        for <virtualization@lists.linux.dev>; Thu, 03 Jul 2025 01:23:55 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1751531035; x=1752135835;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Ke2YfmZqQvuyIhOn4BkIuW587OZjecPx0SDiI46FKLs=;
        b=V8z9W21o+Wwr1X28cYZHAD/KpxGAmoBpZvjQiXrgqgkALebhlosdgP1uf2Rtbv/WQC
         CYtqEgFWJmCFhhhp8e7J6ng6rS2VnRn+yGVkPRRJfuGWXOJmjYwkHCXNs4GyhoQTZLfP
         VvDmnLpgcavBSuKvN7DsY/f7c9yMN0xVGNLEmS0qw63Wbjq5hteftyXF4Vai6tmni69c
         3++AHcmGGV+9Bbe/l8o2U28lHD5PdmBevp72BdEkQr6w4Z52Mwn4K+mHJgtLapTswHTv
         NpvmpOks7CsQq/6skr6shx45pELwuVHoMZv30Fk2uZvRpuA5Uh1cstPt3wChzMc2Tp9t
         VH1w==
X-Forwarded-Encrypted: i=1; AJvYcCW5Y2eIWuSx+Ho/JLOuaXVj/3QM3NTbaTuh4Ee41IbVQx0WKme/S9YArLvEDQO0ypHGSgMmPEVV66KII7D2/Q==@lists.linux.dev
X-Gm-Message-State: AOJu0YwIhyAHoWPrVHusiqgKW5C65Dus+Gh1AiGMVOjpcY8PeW7Hec13
	M2sKYdHLQR/rSkG1n3uYhliZlZBCOZ1T39aLNQYi/bidxwkiM0AAOGyLrMx/Pd9peYm4AyIAcgl
	Bq0CZ7NyDoauBpzq07wZJe6gTvpzdQ88ZUZemxzuVJ6UeJATRiV2HqT9DwrS0LZTbWV5g
X-Gm-Gg: ASbGnctWnwHyc4ucba5hjIWIzO+n/Jlkj52eUVcCOhnTDId6vj/Ii/BOupzxwtHtLzv
	bdTVaGNX8n08RJvZfI/O7GQsJQOfD8sJwHKIR2nVjs1M/cpXoWdhCN25MHiNO9cjC1VTs8oZl+4
	9NBke1QADTeZllkpOcsCo6aQ99EDWHATB5PSOSRiCvIjrbj2xRGhuzMCJWhRP755JnKO9qHnaMa
	IjuNq8L7TzX6xqBv3YEk70OPdVS4Xm0UwapY3/3QmMpXMeWRIrBH/zFz1eEGQSoTL7RznOuz8wj
	FvtxnGgTfhm9IWZhnit1UL+bfhs=
X-Received: by 2002:a05:6000:18ae:b0:3b3:9c75:c4cf with SMTP id ffacd0b85a97d-3b39c75c60dmr972428f8f.51.1751531034888;
        Thu, 03 Jul 2025 01:23:54 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHCYV82hCMNv406EdS8av4JOq7IBDVQLti9dcL/h1KSI+kswFV5uEQ+Wn0KudAapNB0JCaiDw==
X-Received: by 2002:a05:6000:18ae:b0:3b3:9c75:c4cf with SMTP id ffacd0b85a97d-3b39c75c60dmr972392f8f.51.1751531034265;
        Thu, 03 Jul 2025 01:23:54 -0700 (PDT)
Received: from sgarzare-redhat ([193.207.200.84])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3a892e5f92esm18167611f8f.90.2025.07.03.01.23.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 03 Jul 2025 01:23:53 -0700 (PDT)
Date: Thu, 3 Jul 2025 10:23:49 +0200
From: Stefano Garzarella <sgarzare@redhat.com>
To: Michal Luczaj <mhal@rbox.co>
Cc: "David S. Miller" <davem@davemloft.net>, 
	Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, 
	Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>, 
	Stefan Hajnoczi <stefanha@redhat.com>, virtualization@lists.linux.dev, netdev@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH net v3 3/3] vsock: Fix IOCTL_VM_SOCKETS_GET_LOCAL_CID to
 check also `transport_local`
Message-ID: <34n3no6ip55yftyqtdpww6jzsse4mhnk3pjmd5sfqhpp5nt3my@wiql5wlf3zzp>
References: <20250702-vsock-transports-toctou-v3-0-0a7e2e692987@rbox.co>
 <20250702-vsock-transports-toctou-v3-3-0a7e2e692987@rbox.co>
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
In-Reply-To: <20250702-vsock-transports-toctou-v3-3-0a7e2e692987@rbox.co>
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: iM-qLmc0ZBf5P0_H9VDbMeIc9QjsqYQ4x2AegjoZzNM_1751531035
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline

On Wed, Jul 02, 2025 at 03:38:45PM +0200, Michal Luczaj wrote:
>Support returning VMADDR_CID_LOCAL in case no other vsock transport is
>available.
>
>Fixes: 0e12190578d0 ("vsock: add local transport support in the vsock core")
>Suggested-by: Stefano Garzarella <sgarzare@redhat.com>
>Signed-off-by: Michal Luczaj <mhal@rbox.co>
>---
> net/vmw_vsock/af_vsock.c | 2 ++
> 1 file changed, 2 insertions(+)

Reviewed-by: Stefano Garzarella <sgarzare@redhat.com>

>
>diff --git a/net/vmw_vsock/af_vsock.c b/net/vmw_vsock/af_vsock.c
>index 9b2af5c63f7c2ae575c160415bd77208a3980835..c8398f9cec5296e07395df8e7ad0f52b8ceb65d5 100644
>--- a/net/vmw_vsock/af_vsock.c
>+++ b/net/vmw_vsock/af_vsock.c
>@@ -2581,6 +2581,8 @@ static long vsock_dev_do_ioctl(struct file *filp,
> 		cid = vsock_registered_transport_cid(&transport_g2h);
> 		if (cid == VMADDR_CID_ANY)
> 			cid = vsock_registered_transport_cid(&transport_h2g);
>+		if (cid == VMADDR_CID_ANY)
>+			cid = vsock_registered_transport_cid(&transport_local);
>
> 		if (put_user(cid, p) != 0)
> 			retval = -EFAULT;
>
>-- 
>2.49.0
>

