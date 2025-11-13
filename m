Received: from sender4-pp-f112.zoho.com (sender4-pp-f112.zoho.com [136.143.188.112])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A16082BD03
	for <virtualization@lists.linux.dev>; Thu, 13 Nov 2025 02:28:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=136.143.188.112
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763000915; cv=pass; b=kbRek6vsD3LElzkECOj2OhCvXHLft3XqUxkYG/dNpRu4zNxPmAwmpt7uf1DpecZpNC71sTOLT0LNbOSNAwRM7jooX6oV7/w7DFok/pX8RgOjLd0WQCm9GTJbilAvAOJNF1fiN5RR7N/ya8U+9/FMFYyPnJGWXXnrqHF5d1wQaRc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763000915; c=relaxed/simple;
	bh=/FP5DyRytsdlgqAF02XUAu48hXpTRdOBFZcQcDwcQMY=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=rh3HBUYL30kQtC8wvHiS9jcxBMAKsd6Kh4pPxKTyiXa4/mn21DemIKnxZi5LfrawyHCi4AjPwexB8x1hXgm9K9oFUts+6eVsoS3lBlHosmpgiL894E/Ie4Oj1BdXh0ZmR6RcWwMHhwYcs++VuybXtVN4omQq5wcgRhwrrdQ+h0w=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (1024-bit key) header.d=collabora.com header.i=dmitry.osipenko@collabora.com header.b=HLSrsczI; arc=pass smtp.client-ip=136.143.188.112
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=collabora.com header.i=dmitry.osipenko@collabora.com header.b="HLSrsczI"
ARC-Seal: i=1; a=rsa-sha256; t=1763000905; cv=none; 
	d=zohomail.com; s=zohoarc; 
	b=QOXoLRPKZJnnSuO9Fyo1Vep1RIhLKfUSt+sCW6+HMBSWPbRRdECmashijBYT/x4eZda2U/U3A/Zkjl7f/SZE8AD9Xq+KKbcwoUCm+reZ6NiOrZuiCdH4N6KKTg6LWy3hD4CR6IUxM00mPNDjQfHTK7AzX1cQIU3B2sv+BKJHjU0=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com; s=zohoarc; 
	t=1763000905; h=Content-Type:Content-Transfer-Encoding:Date:Date:From:From:In-Reply-To:MIME-Version:Message-ID:References:Subject:Subject:To:To:Message-Id:Reply-To:Cc; 
	bh=WVo+VYg/7XEVG4AiQ+g7ZNcwWrXnBYHst4gCom/13Xo=; 
	b=QahlkIr0EYqBWhHcx6FZ1cxoyXKKeSMB9Nf/RJ5jpMdXg5u+WGPDMvwS4gu3kt8o2WGvf2SPbfctmImFw+UKWg0ANJ6O1AaAcxMFaj/K2/i47lARmZeD55knybjbFmsVLzt7Xns52tpsk7zQJQAak+ogLFXiQWyLsHBnOAhC/IU=
ARC-Authentication-Results: i=1; mx.zohomail.com;
	dkim=pass  header.i=collabora.com;
	spf=pass  smtp.mailfrom=dmitry.osipenko@collabora.com;
	dmarc=pass header.from=<dmitry.osipenko@collabora.com>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1763000905;
	s=zohomail; d=collabora.com; i=dmitry.osipenko@collabora.com;
	h=Message-ID:Date:Date:MIME-Version:Subject:Subject:To:To:References:From:From:In-Reply-To:Content-Type:Content-Transfer-Encoding:Message-Id:Reply-To:Cc;
	bh=WVo+VYg/7XEVG4AiQ+g7ZNcwWrXnBYHst4gCom/13Xo=;
	b=HLSrsczITCgGyJq1D983V9K8vp7fWe2q8t4XizklLm372A78ob2gpAlLjtAAYnC3
	VArhuR5fRThF+KIWljm76a+DgMRoMGekmCYjUbcWAtKEHJA/dO2bFlDEqv8A99LoBXF
	S9baNhpz8o8DTBcKSZH9lnakVl949tkFwQPoA3+c=
Received: by mx.zohomail.com with SMTPS id 1763000902278326.27648556926727;
	Wed, 12 Nov 2025 18:28:22 -0800 (PST)
Message-ID: <7f06489d-0ed8-4d7b-a152-9cb35e04dbb0@collabora.com>
Date: Thu, 13 Nov 2025 05:28:15 +0300
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/3] drm/virtio: honor blob_alignment requirements
To: Sergio Lopez <slp@redhat.com>, David Airlie <airlied@redhat.com>,
 Gerd Hoffmann <kraxel@redhat.com>,
 Gurchetan Singh <gurchetansingh@chromium.org>, Chia-I Wu
 <olvaffe@gmail.com>, Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>,
 Simona Vetter <simona@ffwll.ch>, "Michael S. Tsirkin" <mst@redhat.com>,
 Jason Wang <jasowang@redhat.com>, Xuan Zhuo <xuanzhuo@linux.alibaba.com>,
 =?UTF-8?Q?Eugenio_P=C3=A9rez?= <eperezma@redhat.com>,
 dri-devel@lists.freedesktop.org, virtualization@lists.linux.dev,
 linux-kernel@vger.kernel.org
References: <20251110125213.12633-1-slp@redhat.com>
 <20251110125213.12633-3-slp@redhat.com>
Content-Language: en-US
From: Dmitry Osipenko <dmitry.osipenko@collabora.com>
In-Reply-To: <20251110125213.12633-3-slp@redhat.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ZohoMailClient: External

On 11/10/25 15:52, Sergio Lopez wrote:
> diff --git a/drivers/gpu/drm/virtio/virtgpu_vq.c b/drivers/gpu/drm/virtio/virtgpu_vq.c
> index 8181b22b9b46..d558ba2d213a 100644
> --- a/drivers/gpu/drm/virtio/virtgpu_vq.c
> +++ b/drivers/gpu/drm/virtio/virtgpu_vq.c
> @@ -1393,6 +1393,10 @@ int virtio_gpu_cmd_map(struct virtio_gpu_device *vgdev,
>  	struct virtio_gpu_vbuffer *vbuf;
>  	struct virtio_gpu_resp_map_info *resp_buf;
>  
> +	if (vgdev->has_blob_alignment &&
> +	    !IS_ALIGNED(offset, vgdev->blob_alignment))
> +		return -EINVAL;

The vram offset should have been validated when obj is created. Checking
offset here on cmd_map() should be unnecessary.

-- 
Best regards,
Dmitry
