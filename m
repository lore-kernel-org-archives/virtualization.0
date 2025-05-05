Received: from sender3-pp-f112.zoho.com (sender3-pp-f112.zoho.com [136.143.184.112])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 259E5258CD3
	for <virtualization@lists.linux.dev>; Mon,  5 May 2025 16:22:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=136.143.184.112
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746462177; cv=pass; b=SBy/bE4/iRwF252Xu7K3piP14bHjob9PL7mPhzZvceRR9360xx32g3NK5c+KO+9W2wFsePG+yCunMAIWFbrYyqf6/BZJAVJ51cSib6X6+PVVEkzgC7mF/SxiWjDfLmEan7Wq/Z+TXfUiIcDPyepEdJ77sT7Dv/b+GbkUjItPlwY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746462177; c=relaxed/simple;
	bh=7OvQ9Fo0tUTXljcF2N+k29uN7bcPhl/8/tSD+MUKVZs=;
	h=Message-ID:Date:MIME-Version:Subject:From:To:Cc:References:
	 In-Reply-To:Content-Type; b=GmDIGMQkITz6BqnKa496pTjx8I4bodf5Nt53HpnGXmOg3+TtnA3rjGYer9Fqr9BYOU5adPTtqUIULN5mUPAasPVsqXV/pBdJyt0RvVoO/zmjHtE8/qBurA8INBiz+DRDRbOYtPfvbKdzwhPWo/xLERQVc7Tt2pgb6HuV49TTFnc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (1024-bit key) header.d=collabora.com header.i=dmitry.osipenko@collabora.com header.b=ZPhpFQpD; arc=pass smtp.client-ip=136.143.184.112
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=collabora.com header.i=dmitry.osipenko@collabora.com header.b="ZPhpFQpD"
ARC-Seal: i=1; a=rsa-sha256; t=1746462161; cv=none; 
	d=zohomail.com; s=zohoarc; 
	b=Z/pEykjnon0LWQmbob4yKSYuKsmWmcHky+HCf9cBweMRAte5XDu0iJpCfRiDeGYGqy3GNi7BRJOi1jD9t+5fD+DL2j1SpFFoirXxwLvBgv5fEhG2atZT5cwFLrUDz7XB1QthxkBfImJpuM5Pf7YczZKBoG/YwNsMOn2qDPHOBdc=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com; s=zohoarc; 
	t=1746462161; h=Content-Type:Content-Transfer-Encoding:Cc:Cc:Date:Date:From:From:In-Reply-To:MIME-Version:Message-ID:References:Subject:Subject:To:To:Message-Id:Reply-To; 
	bh=Cn34lMEWOSB8EK9h95x7SSV4y9boi8anfMX1Giz4Mis=; 
	b=jxM6qLSgW54nnqKwt23RPf41T0Bf9oklvHKepYq41mhEalUZQoHNqSgixChXnQ/rFiNIMnLei4k38BjHUHkeMimvnzwH1/tj0ceuo5XSkrhrrg+w95F8OZIrJbNeBfzPnWEPr3ZJAasSNBdw/aOfeUuBDBRvJasTzGgGRrrf+M0=
ARC-Authentication-Results: i=1; mx.zohomail.com;
	dkim=pass  header.i=collabora.com;
	spf=pass  smtp.mailfrom=dmitry.osipenko@collabora.com;
	dmarc=pass header.from=<dmitry.osipenko@collabora.com>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1746462161;
	s=zohomail; d=collabora.com; i=dmitry.osipenko@collabora.com;
	h=Message-ID:Date:Date:MIME-Version:Subject:Subject:From:From:To:To:Cc:Cc:References:In-Reply-To:Content-Type:Content-Transfer-Encoding:Message-Id:Reply-To;
	bh=Cn34lMEWOSB8EK9h95x7SSV4y9boi8anfMX1Giz4Mis=;
	b=ZPhpFQpD5dzmzC0l9ZimFix67MJ/zDeGB3W4LKqi1CBXX6ZYiks6l9usZNiwzxq4
	EQdVM4ipZPIc/rPy90WEJWOCHn7dfM6SP3E9oGSolShBNNZWjLYyVnI163B/zPRxpDI
	TA1eaLNEvE0wkkNVnNNNnp/FuUafcTC8x132VXqk=
Received: by mx.zohomail.com with SMTPS id 174646215944673.6589727735876;
	Mon, 5 May 2025 09:22:39 -0700 (PDT)
Message-ID: <c3ae2790-20d8-4220-848e-7b02b185e893@collabora.com>
Date: Mon, 5 May 2025 19:22:35 +0300
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 3/3] virtgpu: deallocate capsets on device deinit
From: Dmitry Osipenko <dmitry.osipenko@collabora.com>
To: Manos Pitsidianakis <manos.pitsidianakis@linaro.org>,
 David Airlie <airlied@redhat.com>, Gerd Hoffmann <kraxel@redhat.com>,
 Gurchetan Singh <gurchetansingh@chromium.org>, Chia-I Wu
 <olvaffe@gmail.com>, Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>,
 Simona Vetter <simona@ffwll.ch>
Cc: =?UTF-8?Q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Viresh Kumar <viresh.kumar@linaro.org>, dri-devel@lists.freedesktop.org,
 virtualization@lists.linux.dev, linux-kernel@vger.kernel.org
References: <20250505-virtgpu-queue-cleanup-v1-v1-0-810923da2b1e@linaro.org>
 <20250505-virtgpu-queue-cleanup-v1-v1-3-810923da2b1e@linaro.org>
 <5271820d-7afd-45e5-8103-b7d4fc818278@collabora.com>
Content-Language: en-US
In-Reply-To: <5271820d-7afd-45e5-8103-b7d4fc818278@collabora.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ZohoMailClient: External

On 5/5/25 18:58, Dmitry Osipenko wrote:
> On 5/5/25 11:59, Manos Pitsidianakis wrote:
>> diff --git a/drivers/gpu/drm/virtio/virtgpu_kms.c b/drivers/gpu/drm/virtio/virtgpu_kms.c
>> index 7b3c4d314f8eee692e2842a7056d6dc64936fc2f..a8b751179332b9ec2fbba1392a6ee0e638a5192e 100644
>> --- a/drivers/gpu/drm/virtio/virtgpu_kms.c
>> +++ b/drivers/gpu/drm/virtio/virtgpu_kms.c
>> @@ -286,6 +286,10 @@ void virtio_gpu_deinit(struct drm_device *dev)
>>  	flush_work(&vgdev->cursorq.dequeue_work);
>>  	flush_work(&vgdev->config_changed_work);
>>  	virtio_reset_device(vgdev->vdev);
>> +	spin_lock(&vgdev->display_info_lock);
>> +	drmm_kfree(dev, vgdev->capsets);
>> +	vgdev->capsets = NULL;
>> +	spin_unlock(&vgdev->display_info_lock);
> 
> Isn't this lock superfluous?

Wait a minute, vgdev->capsets is allocated using drmm, hence it's
auto-freed when DRM device is freed. This patch shouldn't be needed.

-- 
Best regards,
Dmitry
