Received: from sender4-pp-f112.zoho.com (sender4-pp-f112.zoho.com [136.143.188.112])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E50BA2557C
	for <virtualization@lists.linux.dev>; Sun,  2 Feb 2025 17:19:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=136.143.188.112
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738516783; cv=pass; b=Awfn5tPLlbkx8MC7rUV6Sptrc4Ze+l87R8W81fthjUr4Sf8Lg0In+kJYy6B5ULzSy73pQ7IRvsSBtUy7zHRtzQU+M96Yz99U3HnHgaWqUR9ueLthZ74KY8QrRdUPdhFZ8sDSJpfjFvS/rgEUfmlaZ+igRGwVIqubTsF7IlX79Kc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738516783; c=relaxed/simple;
	bh=fGQMiCK9CrCF6TbcjORmMHlOTSvhAOG6dGnTBSK8B9I=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=GENksyLFTvpJgchJNSjaxyewFg6DGhUZSnxxVWuaPDtKw0hfn/Qyq4oG23RTx6/UD71APNfFOaaBAxEgm9ElU+fFc47X1kcV31XJLCt3LDcsfHB0wU1f/gJO5mD2b9fggnx1UeUZxy086Dx7qcYTWvWBs1VotoVNNfWXMwCMADA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (1024-bit key) header.d=collabora.com header.i=dmitry.osipenko@collabora.com header.b=BkugCsYm; arc=pass smtp.client-ip=136.143.188.112
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=collabora.com header.i=dmitry.osipenko@collabora.com header.b="BkugCsYm"
ARC-Seal: i=1; a=rsa-sha256; t=1738516774; cv=none; 
	d=zohomail.com; s=zohoarc; 
	b=ZnRhLNNxgEXsgHDP2LS3+Z/zm9FX5Om4C64v5sYZZ7aqcFMID6K4Y90MfAqyaRf8UcI3RPAdJhClPd7zzaNl8YB/qGDVp7ZnvqdI/yVjqIezykV4+CnI+xWbq/43IPqI9RTeyac6aDzgmmo45u6+7cAULNY71kzEBNeu0xRUlDQ=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com; s=zohoarc; 
	t=1738516774; h=Content-Type:Content-Transfer-Encoding:Cc:Cc:Date:Date:From:From:In-Reply-To:MIME-Version:Message-ID:References:Subject:Subject:To:To:Message-Id:Reply-To; 
	bh=4H7toTV6/oya19NAiBnTrweJg3ebJuxR26HF1E8ORHw=; 
	b=jTkGxChbP2YClbU3eK7zgwR2Dx5om7Uun9UL5hbDM7Dgz3jMsuO3HyyoPyDgeTNkFoyyIRqE4ovBTHgzHczBLoNfqy797PJp2eA+ipL2Qt4ZBlngj8/u4qzK0Akv4IlL+KZe7eZ+eBGNhMxKQO69EukvH/H3kCmX9VoJKnJQU6Q=
ARC-Authentication-Results: i=1; mx.zohomail.com;
	dkim=pass  header.i=collabora.com;
	spf=pass  smtp.mailfrom=dmitry.osipenko@collabora.com;
	dmarc=pass header.from=<dmitry.osipenko@collabora.com>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1738516774;
	s=zohomail; d=collabora.com; i=dmitry.osipenko@collabora.com;
	h=Message-ID:Date:Date:MIME-Version:Subject:Subject:To:To:Cc:Cc:References:From:From:In-Reply-To:Content-Type:Content-Transfer-Encoding:Message-Id:Reply-To;
	bh=4H7toTV6/oya19NAiBnTrweJg3ebJuxR26HF1E8ORHw=;
	b=BkugCsYmG3nqXQI0SYwsuP4Dv4MVuz5Ii+Kl+t8i9so6Yg6Q6yD/ogFd9ecnEyhW
	FeqLuHTvCfyAH++chSnjJEeqx+nnkz/SFXxTI5DPTbmoPB+EMpwkbULl8dUTHEP9CYQ
	nqNi+pfcdy7FoMbh10Rzo3/TlUKZORkBmhesqUFM=
Received: by mx.zohomail.com with SMTPS id 1738516770241998.3275094604038;
	Sun, 2 Feb 2025 09:19:30 -0800 (PST)
Message-ID: <df650764-e9d8-487c-97f7-a7d810444dfa@collabora.com>
Date: Sun, 2 Feb 2025 20:19:25 +0300
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v6] drm/virtio: Add drm_panic support
To: Ryosuke Yasuoka <ryasuoka@redhat.com>, airlied@redhat.com,
 kraxel@redhat.com, gurchetansingh@chromium.org, olvaffe@gmail.com,
 maarten.lankhorst@linux.intel.com, mripard@kernel.org, tzimmermann@suse.de,
 daniel@ffwll.ch, jfalempe@redhat.com
Cc: virtualization@lists.linux.dev, linux-kernel@vger.kernel.org,
 dri-devel@lists.freedesktop.org
References: <20250130090517.201356-1-ryasuoka@redhat.com>
Content-Language: en-US
From: Dmitry Osipenko <dmitry.osipenko@collabora.com>
In-Reply-To: <20250130090517.201356-1-ryasuoka@redhat.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ZohoMailClient: External

On 1/30/25 12:05, Ryosuke Yasuoka wrote:
> diff --git a/drivers/gpu/drm/virtio/virtgpu_drv.h b/drivers/gpu/drm/virtio/virtgpu_drv.h
> index f42ca9d8ed10..44511f316851 100644
> --- a/drivers/gpu/drm/virtio/virtgpu_drv.h
> +++ b/drivers/gpu/drm/virtio/virtgpu_drv.h
> @@ -126,6 +126,12 @@ struct virtio_gpu_object_array {
>  	struct drm_gem_object *objs[] __counted_by(total);
>  };
>  
> +#define MAX_INLINE_CMD_SIZE   96
> +#define MAX_INLINE_RESP_SIZE  24
> +#define VBUFFER_SIZE	      (sizeof(struct virtio_gpu_vbuffer) \
> +			      + MAX_INLINE_CMD_SIZE		 \
> +			      + MAX_INLINE_RESP_SIZE)
> +

Let's keep these definitions in the old place if it's unnecessary to
move them.

-- 
Best regards,
Dmitry
