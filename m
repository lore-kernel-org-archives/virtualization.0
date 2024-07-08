Received: from madrid.collaboradmins.com (madrid.collaboradmins.com [46.235.227.194])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3DAFD73461
	for <virtualization@lists.linux.dev>; Mon,  8 Jul 2024 11:55:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=46.235.227.194
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720439711; cv=none; b=R9mXLUts6PzYS1tnyJHdCJndFzKeWWkUKeyV0wE9eC9dm6iGVDMf5N37KsfP4uzhn9x9mxP2sf9F79mIb4n4gGfmUOpGLltvlTnRaoftebKaz4wbQJhdkfL5e9tjKFXkguDStxfeDv21hiU1KyiH5YXM+OTZ4A4Uf4J9hbPwHSM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720439711; c=relaxed/simple;
	bh=w3xvsgnndMrOM/34Wyw1Scx/GCcX7wlvt69E7QiIYkg=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=KB7TXmTBtrWEe8YUGcdrBxR7hbEhwco9Zi+Lh1d40YUvERg0VcxXyDVkA7QfSPaL85oHxE2yI83BKY1oRcEJ1SeBeVQL2xqCRicZgB7R14htuIMMxqz77tc+ImFMeia0NR4Di4w0AI/BeokP2++xJI3QczUZQ4gTmBCZRDKJ3KI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b=n98jwju1; arc=none smtp.client-ip=46.235.227.194
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b="n98jwju1"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
	s=mail; t=1720439708;
	bh=w3xvsgnndMrOM/34Wyw1Scx/GCcX7wlvt69E7QiIYkg=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=n98jwju1/uzeoV0fEL8f8dFVQZNtHK4ynGYPEq6fTbt9U0wsIbuv2k1DLmv2PZ5CH
	 sO1zo6Xy9NaN0z3g+MtcZh5ecoYQ/E/uUCXmgj1doOF6mHCUb0vzhAJbi7ZhrjVkuz
	 G1dHyxtsO3CMmto9RRXJDZCnLj8l0c1wTm5FmNpir1jrHEIoX6rh0nhzecdKBYfpY5
	 69qksMV2eEDSKwJVI1GRC3YsKWFP3JfddOQiUB8LtSkNqZ0P3DiMK7oewEqfpB76uJ
	 BvJpjRVeBsJDyGmgDJpQotrx8omTbsLcIBUGRNi72BEZ9Y/m6ZW/7mrn0Sn4VCkNQV
	 ct+6daOAFYzOg==
Received: from [100.109.49.129] (cola.collaboradmins.com [195.201.22.229])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: dmitry.osipenko)
	by madrid.collaboradmins.com (Postfix) with ESMTPSA id 3CF7E378216D;
	Mon,  8 Jul 2024 11:55:07 +0000 (UTC)
Message-ID: <b18c4505-efd2-403b-9bde-eed510c832f9@collabora.com>
Date: Mon, 8 Jul 2024 14:55:04 +0300
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] drm/qxl: Pin buffer objects for internal mappings
To: Thomas Zimmermann <tzimmermann@suse.de>, airlied@redhat.com,
 kraxel@redhat.com, zack.rusin@broadcom.com, airlied@gmail.com,
 daniel@ffwll.ch, maarten.lankhorst@linux.intel.com, mripard@kernel.org
Cc: regressions@leemhuis.info, virtualization@lists.linux.dev,
 spice-devel@lists.freedesktop.org, dri-devel@lists.freedesktop.org,
 David Kaplan <david.kaplan@amd.com>,
 =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>
References: <20240702142034.32615-1-tzimmermann@suse.de>
Content-Language: en-US
From: Dmitry Osipenko <dmitry.osipenko@collabora.com>
In-Reply-To: <20240702142034.32615-1-tzimmermann@suse.de>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 7/2/24 17:20, Thomas Zimmermann wrote:
> @@ -190,7 +190,13 @@ int qxl_bo_vmap(struct qxl_bo *bo, struct iosys_map *map)
>  	if (r)
>  		return r;
>  
> +	r = qxl_bo_pin_locked(bo);
> +	if (r)
> +		return r;

Is qxl_bo_unreserve() missing here?

> +
>  	r = qxl_bo_vmap_locked(bo, map);
> +	if (r)
> +		qxl_bo_unpin_locked(bo);
>  	qxl_bo_unreserve(bo);
>  	return r;

-- 
Best regards,
Dmitry

