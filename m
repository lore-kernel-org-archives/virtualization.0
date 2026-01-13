Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C4E5D29D27D
	for <virtualization@lists.linux.dev>; Tue, 13 Jan 2026 15:42:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768318941; cv=none; b=Sddg4jOysosXELIeBW7+w/hknGXhEYKW56eMwNcr9B53DGY4B6U6azdy8IIugQ8P6eJnzXg8hP2ju2MF+bT7ATauacQZX/gL77Zi2pnRV6i5+pAb7Nv2SozYeJUjoyOhNxyICQeIAwT+/Uj6xrpxbM+SjrLQLNo4cd+KDCJyX/Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768318941; c=relaxed/simple;
	bh=z0ktrf9THh1+HjKG5G+Ar30QQHeNINGUrFDEbpyqHsg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 In-Reply-To:Content-Type:Content-Disposition; b=f4tt6XJ3FS5SS0Px3nWy3YHClC2yGkaspAovl+KLi4Lnsr+sc4IC4Iuh5sVVCm8VqwuMj5ZL0bEImj4Xudb17ntAr5zdfxu56WZFiv8rsFZnDXsjNIlJdyo3yjHcd26F0+0XLtSWF8MAPqS7KuSF4MzbID42TOD0BsMe4IU+l7s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=LV9PXd/g; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="LV9PXd/g"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1768318938;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=VJEPhbiWRGNl7Jboc5mq3GBmXz9jBXvM23UB3dUFjRY=;
	b=LV9PXd/gXyzpcWQx6Sl8WWRqddeGd1BVbWsrIG/Tspzhnetk5UQCe38IFqOyw25jcaohVg
	3ZPNNLODNo2gTfXaUENurKKO0vvsh0YRcgXQRHz5RUSwrTZV1LHekSVcIutzu9wE7YDt9E
	BZhMWTgIl7r1RnHkrqlWeaPDgBVn358=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-159-VqUbDnXGMYmV1Pa36Tqipg-1; Tue, 13 Jan 2026 10:42:16 -0500
X-MC-Unique: VqUbDnXGMYmV1Pa36Tqipg-1
X-Mimecast-MFC-AGG-ID: VqUbDnXGMYmV1Pa36Tqipg_1768318935
Received: by mail-wm1-f72.google.com with SMTP id 5b1f17b1804b1-47edee0b11cso3045935e9.1
        for <virtualization@lists.linux.dev>; Tue, 13 Jan 2026 07:42:16 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1768318935; x=1768923735;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=VJEPhbiWRGNl7Jboc5mq3GBmXz9jBXvM23UB3dUFjRY=;
        b=fdW1kt2uUXb7Q0SV8cq963ZAFxO861cajmifHtCiMYmKP/GB85oQqYQ/NpvycLXo28
         BUHqEqsD7mDKWRbvHba7lGA9vuCnkBjef5LfZT8yNs8KafT9JLZ2NK5blnSEMN49cRkb
         Y737MJhMHcEmswpxxPxi5U1yL5tBnVhBSDp+whSj/6awX32PWgvMnypnBYlPq5XwM8mq
         9LQlHspAmmm70N0fE88fqgYgV5kjGYFbo8vEZWbId7tny9kxqXtcGbM6CBMeX/d6ks0j
         7yEjLnUg9RGespJ3ILyT87ubPSaitPJq8L6I8kxG8ci/AdRPwWeLuM9nmeMnYhkR6QmS
         rHBw==
X-Forwarded-Encrypted: i=1; AJvYcCWeJCQd93Og1BMv8jQ8rflUIGc/wS1D87xTTRZ97zArrfzoEarNRq2v4cQ+qXSOJRMoHs+Fx9oYj/BekssKJA==@lists.linux.dev
X-Gm-Message-State: AOJu0YwCAhsnQkz7BkorDSkB86tKlw22Yxyd0MvEXM5wFeotKD/Pb3+T
	/9f/s/n6vOJeGSSEK1fpcPnQRDq2IEwJrCGDUD2GgBfXeSIunFbGBmXbmvv4vDFxf++5z7LQRFN
	djJkfyNULCN8By7+RPFlXJsHdGCASW2dX98xzoJCKtMykebe9fj5bU2lMLgpGh/K82nVg
X-Gm-Gg: AY/fxX7G86uSQN7faz9RKJj8GmLaFfq7+aeSK/rMrA4c42Pux7BcqF0TwZuRbtcUDAJ
	Q9o7oJ0Xj4gAM0hIA4TLkrrZLOQxB1qEc8Mc3z7ZbAY5jkSx2dr1tqblSCSxHfwuY9p4NTE5dNq
	e11ZE4rtwUuxLOBeTlNYl2gD7LhV/VccYytCeQcSBnGy0OldUkath25xiSxTYpyTLw81DHyXb95
	iNw1Rd4ASOBuc76u9DkdXp/+u5BJTY2TDVS/ZV4hUVe8Jk+QC982ti+wEsbJ9085L0jdxzxfjd2
	1nszpNsWC6G4Chci5IbrLSmJAdXtYbZ+piCA8KS+CYhxOuGBsNgfdKHi3tT4bBr3dfz7ken01q+
	HI1yycpMc25kFzCH70BKDVOr/i+hmsTZn25ISHizOzn2obpgzktwaGEko1NPsbA==
X-Received: by 2002:a05:600c:620c:b0:46e:33b2:c8da with SMTP id 5b1f17b1804b1-47d84b3be47mr241263055e9.32.1768318935389;
        Tue, 13 Jan 2026 07:42:15 -0800 (PST)
X-Google-Smtp-Source: AGHT+IH4paz0040d/vitY+T5rv1eo5WHxtcQ4X4vPvSUCFKLot5Wf40qNTKU1VjGBirJbB8u4247Wg==
X-Received: by 2002:a05:600c:620c:b0:46e:33b2:c8da with SMTP id 5b1f17b1804b1-47d84b3be47mr241262525e9.32.1768318934958;
        Tue, 13 Jan 2026 07:42:14 -0800 (PST)
Received: from sgarzare-redhat (host-87-12-25-233.business.telecomitalia.it. [87.12.25.233])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-432bd0e1adbsm45281481f8f.17.2026.01.13.07.42.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 13 Jan 2026 07:42:14 -0800 (PST)
Date: Tue, 13 Jan 2026 16:42:07 +0100
From: Stefano Garzarella <sgarzare@redhat.com>
To: Bobby Eshleman <bobbyeshleman@gmail.com>
Cc: "David S. Miller" <davem@davemloft.net>, 
	Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, 
	Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>, 
	Stefan Hajnoczi <stefanha@redhat.com>, "Michael S. Tsirkin" <mst@redhat.com>, 
	Jason Wang <jasowang@redhat.com>, Eugenio =?utf-8?B?UMOpcmV6?= <eperezma@redhat.com>, 
	Xuan Zhuo <xuanzhuo@linux.alibaba.com>, "K. Y. Srinivasan" <kys@microsoft.com>, 
	Haiyang Zhang <haiyangz@microsoft.com>, Wei Liu <wei.liu@kernel.org>, Dexuan Cui <decui@microsoft.com>, 
	Bryan Tan <bryan-bt.tan@broadcom.com>, Vishnu Dasa <vishnu.dasa@broadcom.com>, 
	Broadcom internal kernel review list <bcm-kernel-feedback-list@broadcom.com>, Shuah Khan <shuah@kernel.org>, Long Li <longli@microsoft.com>, 
	linux-kernel@vger.kernel.org, virtualization@lists.linux.dev, netdev@vger.kernel.org, 
	kvm@vger.kernel.org, linux-hyperv@vger.kernel.org, linux-kselftest@vger.kernel.org, 
	berrange@redhat.com, Sargun Dhillon <sargun@sargun.me>, 
	Bobby Eshleman <bobbyeshleman@meta.com>
Subject: Re: [PATCH net-next v14 04/12] selftests/vsock: increase timeout to
 1200
Message-ID: <aWZnnHxzaV9pgwzb@sgarzare-redhat>
References: <20260112-vsock-vmtest-v14-0-a5c332db3e2b@meta.com>
 <20260112-vsock-vmtest-v14-4-a5c332db3e2b@meta.com>
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
In-Reply-To: <20260112-vsock-vmtest-v14-4-a5c332db3e2b@meta.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: EbOV9MZPoaKx6TPq5bQeNd1PsOMMcgAGQsUGsJnvgT4_1768318935
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline

On Mon, Jan 12, 2026 at 07:11:13PM -0800, Bobby Eshleman wrote:
>From: Bobby Eshleman <bobbyeshleman@meta.com>
>
>Increase the timeout from 300s to 1200s. On a modern bare metal server
>my last run showed the new set of tests taking ~400s. Multiply by an
>(arbitrary) factor of three to account for slower/nested runners.
>
>Signed-off-by: Bobby Eshleman <bobbyeshleman@meta.com>
>---
> tools/testing/selftests/vsock/settings | 2 +-
> 1 file changed, 1 insertion(+), 1 deletion(-)

Reviewed-by: Stefano Garzarella <sgarzare@redhat.com>

>
>diff --git a/tools/testing/selftests/vsock/settings b/tools/testing/selftests/vsock/settings
>index 694d70710ff0..79b65bdf05db 100644
>--- a/tools/testing/selftests/vsock/settings
>+++ b/tools/testing/selftests/vsock/settings
>@@ -1 +1 @@
>-timeout=300
>+timeout=1200
>
>-- 
>2.47.3
>

