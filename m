Received: from sender4-pp-f112.zoho.com (sender4-pp-f112.zoho.com [136.143.188.112])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 94199381AF
	for <virtualization@lists.linux.dev>; Sun, 17 May 2026 16:14:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=136.143.188.112
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779034497; cv=pass; b=aMbHAQOIWRb0OGHq3/VkJJaXUXTI/d8nk+CH7f1NCWVqvrPq95nJNgA1eQ24WHrPJGLf8MfdDYbzzUGieREIWzFJP3ma/PczQgNLuvGfwdxO2s9lOO8vJ1ho02TgSEshj4oV8Q6S7ZhX60Dr7pjgKZH0COykQUdhMyOsR6UTTUo=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779034497; c=relaxed/simple;
	bh=zciJ29y6V7yiCwg5Y+ZUNqXXnQi5wfbsoF5QJvupyeI=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=hYtcxBoNCI2xPUdZW251Shv/fbzv3qvPK/yRD1xWWWZ27AJeHMoJyXabKvmLP1kNqJJ1BLRhLJJ8iMITRt08m3XJV1t/QlcmhTS/ytlJ66opdEd8YwrVC0tCMi1GIcdGw0KOZ+ytLz8V1aSELqEMyBGx0V8vpQ13G+XavnJ2pac=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (1024-bit key) header.d=collabora.com header.i=dmitry.osipenko@collabora.com header.b=kK3VDQIl; arc=pass smtp.client-ip=136.143.188.112
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=collabora.com header.i=dmitry.osipenko@collabora.com header.b="kK3VDQIl"
ARC-Seal: i=1; a=rsa-sha256; t=1779034483; cv=none; 
	d=zohomail.com; s=zohoarc; 
	b=M0Xub1lCq4wl/BRc1gcF4eJJCj/eSpnhkULjWNDElqQiyTW0UNbh3QJHtzkqlvUMpazbWCRIaca47D91LHTc4F0McBwD0MneF/WTNjeecN72k/unFO0eWUxDXcjdAx5fjKfY4DkMvac0cTGq9msZG9WAQVivFdoaWmF66X41GaI=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com; s=zohoarc; 
	t=1779034483; h=Content-Type:Content-Transfer-Encoding:Cc:Cc:Date:Date:From:From:In-Reply-To:MIME-Version:Message-ID:References:Subject:Subject:To:To:Message-Id:Reply-To; 
	bh=lTQnY3Wob79n+0pHlloPg9VDdqG3m8pLTGa60m2YmDw=; 
	b=HvhX71YnZ/4RKA5Sdq19cWUGLngYf6644gM99bCMz8criNBBvaD5uRv0yz/Aj++2ajTvG2AshS/iX5vNsL8Rj8sXJlTK5fHdazgHSga3fvVYXxDa23xrURBuaW4gtoPDRhuZMvQ6k6feL5kdCgaT164ffRKfuVudbFUAUP9Vd8E=
ARC-Authentication-Results: i=1; mx.zohomail.com;
	dkim=pass  header.i=collabora.com;
	spf=pass  smtp.mailfrom=dmitry.osipenko@collabora.com;
	dmarc=pass header.from=<dmitry.osipenko@collabora.com>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1779034483;
	s=zohomail; d=collabora.com; i=dmitry.osipenko@collabora.com;
	h=Message-ID:Date:Date:MIME-Version:Subject:Subject:To:To:Cc:Cc:References:From:From:In-Reply-To:Content-Type:Content-Transfer-Encoding:Message-Id:Reply-To;
	bh=lTQnY3Wob79n+0pHlloPg9VDdqG3m8pLTGa60m2YmDw=;
	b=kK3VDQIlpnav25+wGvbaoQB+J+x4Rv83gqmpDLjiPvqqFJeIWS/ppTaCBsQlelAN
	myuvqeE1jQ+rwxSHlJw5p6md+w07WhslZVYbtH3Vk7C0K1VlzybzLvwaYhITUhWhgka
	eKooLOSAEMWOG8qp8KjkA0KRagncd3x+8eoYnuuE=
Received: by mx.zohomail.com with SMTPS id 17790344794755.096580494770819;
	Sun, 17 May 2026 09:14:39 -0700 (PDT)
Message-ID: <afec1199-4889-4d35-964c-4432ec792fa3@collabora.com>
Date: Sun, 17 May 2026 19:14:32 +0300
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3] drm/virtio: use uninterruptible resv lock for plane
 updates
To: Deepanshu Kartikey <kartikey406@gmail.com>, airlied@redhat.com,
 kraxel@redhat.com, gurchetansingh@chromium.org, olvaffe@gmail.com,
 maarten.lankhorst@linux.intel.com, mripard@kernel.org, tzimmermann@suse.de,
 simona@ffwll.ch, sumit.semwal@linaro.org, christian.koenig@amd.com
Cc: dri-devel@lists.freedesktop.org, virtualization@lists.linux.dev,
 linux-kernel@vger.kernel.org, linux-media@vger.kernel.org,
 linaro-mm-sig@lists.linaro.org,
 syzbot+72bd3dd3a5d5f39a0271@syzkaller.appspotmail.com, stable@vger.kernel.org
References: <20260515084030.21986-1-kartikey406@gmail.com>
Content-Language: en-US
From: Dmitry Osipenko <dmitry.osipenko@collabora.com>
In-Reply-To: <20260515084030.21986-1-kartikey406@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ZohoMailClient: External

On 5/15/26 11:40, Deepanshu Kartikey wrote:
> +int virtio_gpu_array_lock_resv_uninterruptible(struct virtio_gpu_object_array *objs)
> +{
> +	unsigned int i;
> +	int ret = 0;
> +
> +	if (objs->nents == 1) {
> +		dma_resv_lock(objs->objs[0]->resv, NULL);
> +	} else {
> +		ret = drm_gem_lock_reservations(objs->objs, objs->nents,
> +						&objs->ticket);

drm_gem_lock_reservations() is interruptible. Given that only one BO
needs to be locked for the fix, make it
virtio_gpu_lock_one_resv_uninterruptible() and fail with -EINVAL if
objs->nents > 1

-- 
Best regards,
Dmitry
