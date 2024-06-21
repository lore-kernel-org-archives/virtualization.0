Received: from out30-130.freemail.mail.aliyun.com (out30-130.freemail.mail.aliyun.com [115.124.30.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0F69318E20
	for <virtualization@lists.linux.dev>; Fri, 21 Jun 2024 08:48:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=115.124.30.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718959706; cv=none; b=FH6xLv0u4RDdzylyASNOxxNnv9Z9S/lUHRWOI0v6/AZ5b0ZYrtcREkR1meoWL1ya8bmxvZUJ9Y+BvUR11/F8mLfkpx2068GwCvbfoW6BXmLgWyzsSJCWXyzaoaUd9wq5y+kEzSE/YNZPMmXpWlP6DDQsggJSKmDBINhneanfdWQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718959706; c=relaxed/simple;
	bh=cmNro0s81V3ggh/XTjBQaqQoYmXEBF36FlD7ZvBjvqU=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=V3I32h6ZCwspBnOB2dt5urgnfNH2f+6uxEKZvtsqLTybpQA2NfxokUpuov72Tvvx48cr2rRhOPJxiG/PCSkGu+1ClWc3AmhyRF3j1qAiTnlDfNoySLm9T/mWfRvHPkb3dgqQ44XAw0EhpTgfB+7h5wl47vRGlCnCboBSpu7Xjzo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; spf=pass smtp.mailfrom=linux.alibaba.com; dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b=OVpS7mjf; arc=none smtp.client-ip=115.124.30.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b="OVpS7mjf"
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1718959696; h=Message-ID:Date:MIME-Version:Subject:To:From:Content-Type;
	bh=3vsqKJpmmEF1YlrnBNdvTctEj6bpEdbnO2+TdQxtZ1w=;
	b=OVpS7mjfb7JXn6AJjapNVQb5Kc6ihoNX579Byee0PJTELa+dG8LDybOClzAn3S51qy5G7Bv5caczAD9ZB2bK0FEtWW22JApTjh7fZORqWdc3S3RjQMcIs9SRj1vdXHmH3986A38lsTGPu1+tGqFb6lqjwmU7SUI8IVsyEUBIFWc=
X-Alimail-AntiSpam:AC=PASS;BC=-1|-1;BR=01201311R981e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=maildocker-contentspam033037067112;MF=hengqi@linux.alibaba.com;NM=1;PH=DS;RN=13;SR=0;TI=SMTPD_---0W8vhyN2_1718959694;
Received: from 30.221.148.166(mailfrom:hengqi@linux.alibaba.com fp:SMTPD_---0W8vhyN2_1718959694)
          by smtp.aliyun-inc.com;
          Fri, 21 Jun 2024 16:48:15 +0800
Message-ID: <78a99414-314d-452e-938b-07e86182a8bf@linux.alibaba.com>
Date: Fri, 21 Jun 2024 16:48:13 +0800
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] drm/qxl: Add check for drm_cvt_mode
To: Chen Ni <nichen@iscas.ac.cn>
Cc: virtualization@lists.linux.dev, spice-devel@lists.freedesktop.org,
 dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org,
 airlied@redhat.com, kraxel@redhat.com, maarten.lankhorst@linux.intel.com,
 mripard@kernel.org, tzimmermann@suse.de, airlied@gmail.com, daniel@ffwll.ch,
 noralf@tronnes.org
References: <20240621071031.1987974-1-nichen@iscas.ac.cn>
From: Heng Qi <hengqi@linux.alibaba.com>
In-Reply-To: <20240621071031.1987974-1-nichen@iscas.ac.cn>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit


在 2024/6/21 下午3:10, Chen Ni 写道:
> Add check for the return value of drm_cvt_mode() and return the error if
> it fails in order to avoid NULL pointer dereference.
>
> Fixes: 1b043677d4be ("drm/qxl: add qxl_add_mode helper function")
> Signed-off-by: Chen Ni <nichen@iscas.ac.cn>
> ---
>   drivers/gpu/drm/qxl/qxl_display.c | 3 +++
>   1 file changed, 3 insertions(+)
>
> diff --git a/drivers/gpu/drm/qxl/qxl_display.c b/drivers/gpu/drm/qxl/qxl_display.c
> index c6d35c33d5d6..86a5dea710c0 100644
> --- a/drivers/gpu/drm/qxl/qxl_display.c
> +++ b/drivers/gpu/drm/qxl/qxl_display.c
> @@ -236,6 +236,9 @@ static int qxl_add_mode(struct drm_connector *connector,
>   		return 0;
>   
>   	mode = drm_cvt_mode(dev, width, height, 60, false, false, false);
> +	if (!mode)
> +		return 0;
> +
>   	if (preferred)
>   		mode->type |= DRM_MODE_TYPE_PREFERRED;
>   	mode->hdisplay = width;

Reviewed-by: Heng Qi <hengqi@linux.alibaba.com>

Thanks.
