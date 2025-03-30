Received: from sender4-pp-f112.zoho.com (sender4-pp-f112.zoho.com [136.143.188.112])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1D2F92BB04
	for <virtualization@lists.linux.dev>; Sun, 30 Mar 2025 12:05:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=136.143.188.112
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743336313; cv=pass; b=P6NOgfMGZQj7hpMiukDw1aK7iqZSTDLI62qOUzhAxzGcNvD3p4W8HHbmaCGTxrk3t6C/mt/wz7Wxi4qnqtED+WYTziSjxTQdZR9Bw5Au1yp8WB7ur2CPpwblBopH6qhrqHt4fQ6C7mzOznc/mfrsKGgWBrEVG4zQ6+ZYJxCgp3c=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743336313; c=relaxed/simple;
	bh=wHLGoWFBo5YvZAEyHie+2xVyde9ziJq3tmbRRF8p4zQ=;
	h=Message-ID:Date:MIME-Version:Subject:From:To:Cc:References:
	 In-Reply-To:Content-Type; b=sp+0whmEmXXTQ3V1Xk5gDwOH6r7TGspBNvY6T+Kf4PVKoRWR1Taj8swR0WF7GCVLWuZb5Pe0F7IVQaapPK2RTj3RRe9J04Fgn8AKHllpRK80EbUI6UEVQ72KVM+/TqrFvzzjQbwd+NxxH//Jm5tVGCvozyvI1T6SpBYhFXw+21k=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (1024-bit key) header.d=collabora.com header.i=dmitry.osipenko@collabora.com header.b=WgbCVWQe; arc=pass smtp.client-ip=136.143.188.112
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=collabora.com header.i=dmitry.osipenko@collabora.com header.b="WgbCVWQe"
ARC-Seal: i=1; a=rsa-sha256; t=1743336295; cv=none; 
	d=zohomail.com; s=zohoarc; 
	b=ngBBVrPQmzffRS95xiwif4eLpbKPEp6RYTlEwBG0EAeh204PgYt1EQxa9yoONgVDc6HAY/KJ4FpOXYOqzsmiBHxWB8zNZ/sfYM9QjT/fIfkOgF09E1ETAS2yYAz6xh17diYaOjtIgpD84LU+AumKeAtp/2tnVj1AkExZxF3ibUo=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com; s=zohoarc; 
	t=1743336295; h=Content-Type:Content-Transfer-Encoding:Cc:Cc:Date:Date:From:From:In-Reply-To:MIME-Version:Message-ID:References:Subject:Subject:To:To:Message-Id:Reply-To; 
	bh=cqOTHyVwuqlsTFcnXqzpe3w998N03y04ggCtpRPGV2U=; 
	b=Q8zLZHzpCFwEWr9diKZeJckWezcAWCSUI+pGfz2v0HQjrekwcHQtkMqu7tmaHMeCnVceR5lxUQUXQ1JEpeYPDTwVRmDQzWGcUtuUZ+xZhmQlUrYGAJZZX4CBUW3VUvjmHY/e31+Ryk3C2wG7yfD1WhGZpClRWU21hxlJCqMc9Ac=
ARC-Authentication-Results: i=1; mx.zohomail.com;
	dkim=pass  header.i=collabora.com;
	spf=pass  smtp.mailfrom=dmitry.osipenko@collabora.com;
	dmarc=pass header.from=<dmitry.osipenko@collabora.com>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1743336295;
	s=zohomail; d=collabora.com; i=dmitry.osipenko@collabora.com;
	h=Message-ID:Date:Date:MIME-Version:Subject:Subject:From:From:To:To:Cc:Cc:References:In-Reply-To:Content-Type:Content-Transfer-Encoding:Message-Id:Reply-To;
	bh=cqOTHyVwuqlsTFcnXqzpe3w998N03y04ggCtpRPGV2U=;
	b=WgbCVWQeWg5Uny7bJUO9EyooYp5D97+bYpkCma/U4EBq8qyBCL7yT59ANHBaz/qG
	JR6MDVDlxeyI6y4UflUQdambgAGw2VXTKGHB6kDSUkOIcIwL9zeC0ztbwuRuVKNTUWA
	19Wlm6rUldoS4H+TMuhVXfrU5rM9g7tTbnpZmFs8=
Received: by mx.zohomail.com with SMTPS id 1743336294729887.841721981765;
	Sun, 30 Mar 2025 05:04:54 -0700 (PDT)
Message-ID: <467838dc-a549-4c15-84ea-1322043542d1@collabora.com>
Date: Sun, 30 Mar 2025 15:04:50 +0300
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 7/7] drm/virtio: implement userptr: add interval tree
From: Dmitry Osipenko <dmitry.osipenko@collabora.com>
To: Honglei Huang <honglei1.huang@amd.com>, David Airlie
 <airlied@redhat.com>, Gerd Hoffmann <kraxel@redhat.com>,
 Gurchetan Singh <gurchetansingh@chromium.org>, Chia-I Wu
 <olvaffe@gmail.com>, Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>,
 Simona Vetter <simona@ffwll.ch>, Rob Clark <robdclark@gmail.com>,
 Huang Rui <ray.huang@amd.com>
Cc: dri-devel@lists.freedesktop.org, virtualization@lists.linux.dev,
 linux-kernel@vger.kernel.org, Demi Marie Obenour <demiobenour@gmail.com>
References: <20250321080029.1715078-1-honglei1.huang@amd.com>
 <20250321080029.1715078-8-honglei1.huang@amd.com>
 <810789ec-c034-4bdd-961a-f49c67336e45@collabora.com>
Content-Language: en-US
In-Reply-To: <810789ec-c034-4bdd-961a-f49c67336e45@collabora.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ZohoMailClient: External

On 3/30/25 14:57, Dmitry Osipenko wrote:
>> +	userptr = virtio_gpu_userptr_from_addr_range(
>> +		vfpriv, params->userptr, params->userptr + params->size - 1UL);
> Is it possible that userptr address will be same for two different
> processes?

See now the vfpriv->userptrs_tree, i.e. it's not a global tree.

-- 
Best regards,
Dmitry
