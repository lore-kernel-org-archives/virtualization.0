Received: from sender4-pp-f112.zoho.com (sender4-pp-f112.zoho.com [136.143.188.112])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CC80125B66A
	for <virtualization@lists.linux.dev>; Mon,  5 May 2025 15:58:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=136.143.188.112
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746460718; cv=pass; b=jO/6jh/McVjI7VzZWyDWcPYq7BMwqaZ9aWWOTe9sSCSuD2G9vC0COChFCiFPCOpXiFYk9PMbg0QU5BrB+yyFCMr3ExZafm/fj5C2Z1GoCdk4oXqkASX2rfWj6JlN7n4VMzChZX6HLLGkuFHABKfkEZUGZogGnKIN28RWMZtLnYQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746460718; c=relaxed/simple;
	bh=dqzIEx/W4l4vbBcDBDn0WwrxquzWxWupbZcwuG21YlQ=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=hn1zyaLPsma440OpgoHSx/ECm8F1khLdX10y+b+ZmEeB4TmctxblYffjVjjJYlVfU8bvpHy9kBSTKpj0ehASgS02BkDztduLJmSeqryfNQ6uXd8xdky/0nh+4shzCAqkN4D7H/yr1gwL5o3uT5Cl8WT993JBt3VX4CRv+JCkHkE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (1024-bit key) header.d=collabora.com header.i=dmitry.osipenko@collabora.com header.b=f49hcz9h; arc=pass smtp.client-ip=136.143.188.112
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=collabora.com header.i=dmitry.osipenko@collabora.com header.b="f49hcz9h"
ARC-Seal: i=1; a=rsa-sha256; t=1746460699; cv=none; 
	d=zohomail.com; s=zohoarc; 
	b=hkUgx6Mj/ja9r8LQOpbhvnz1tEB+uND8C0BBBexnI5VPuVRmlXjhYVAadafBQ15CdzBdIRUx8FegOjiFlym9ZtjgkE9ODh1Mt6ZZSbIR1f9e11P4e3QctvXi1EHd82wzxM6kbBOSXj4S7wJIHMJId/O7icQXyS/TzkmDO3u5gZU=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com; s=zohoarc; 
	t=1746460699; h=Content-Type:Content-Transfer-Encoding:Cc:Cc:Date:Date:From:From:In-Reply-To:MIME-Version:Message-ID:References:Subject:Subject:To:To:Message-Id:Reply-To; 
	bh=TBneRj8Wi3aNUjuAlFYRMoAHRWU9YFWZYst/MYENSsQ=; 
	b=YflmZBIk1tFU68O2ldxn8mopG7vCn7GTdSFAwknks0prURZvK9A7rPQjV6FTt1uiMhFZBcbvkoFhGXE25+k5VXbaDzGogEEBvfO7VyBJnIuX6mY0G7V99aGizFPypIg+j2bW7sLDOeiGeBhM7B7KxD1h484CkrVllc5TyBSVGkc=
ARC-Authentication-Results: i=1; mx.zohomail.com;
	dkim=pass  header.i=collabora.com;
	spf=pass  smtp.mailfrom=dmitry.osipenko@collabora.com;
	dmarc=pass header.from=<dmitry.osipenko@collabora.com>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1746460699;
	s=zohomail; d=collabora.com; i=dmitry.osipenko@collabora.com;
	h=Message-ID:Date:Date:MIME-Version:Subject:Subject:To:To:Cc:Cc:References:From:From:In-Reply-To:Content-Type:Content-Transfer-Encoding:Message-Id:Reply-To;
	bh=TBneRj8Wi3aNUjuAlFYRMoAHRWU9YFWZYst/MYENSsQ=;
	b=f49hcz9h3d8aXahF6KPCqBKJrWYbRPoyLvDAgCu9MCKQjf694ZHcTHtrzmuJr/bB
	4kRh+yznnWV8nhiOHyqMEO8AjlBXISA0t4Ggo7CqaA7m4avMt+jeyMZVj2hj/9K1Hr4
	Olo9ZhRpErCWAmyQItoVLm5iQq4gqgKGOzLEqP0k=
Received: by mx.zohomail.com with SMTPS id 1746460696721946.0446506917006;
	Mon, 5 May 2025 08:58:16 -0700 (PDT)
Message-ID: <5271820d-7afd-45e5-8103-b7d4fc818278@collabora.com>
Date: Mon, 5 May 2025 18:58:11 +0300
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 3/3] virtgpu: deallocate capsets on device deinit
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
Content-Language: en-US
From: Dmitry Osipenko <dmitry.osipenko@collabora.com>
In-Reply-To: <20250505-virtgpu-queue-cleanup-v1-v1-3-810923da2b1e@linaro.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ZohoMailClient: External

On 5/5/25 11:59, Manos Pitsidianakis wrote:
> diff --git a/drivers/gpu/drm/virtio/virtgpu_kms.c b/drivers/gpu/drm/virtio/virtgpu_kms.c
> index 7b3c4d314f8eee692e2842a7056d6dc64936fc2f..a8b751179332b9ec2fbba1392a6ee0e638a5192e 100644
> --- a/drivers/gpu/drm/virtio/virtgpu_kms.c
> +++ b/drivers/gpu/drm/virtio/virtgpu_kms.c
> @@ -286,6 +286,10 @@ void virtio_gpu_deinit(struct drm_device *dev)
>  	flush_work(&vgdev->cursorq.dequeue_work);
>  	flush_work(&vgdev->config_changed_work);
>  	virtio_reset_device(vgdev->vdev);
> +	spin_lock(&vgdev->display_info_lock);
> +	drmm_kfree(dev, vgdev->capsets);
> +	vgdev->capsets = NULL;
> +	spin_unlock(&vgdev->display_info_lock);

Isn't this lock superfluous?

-- 
Best regards,
Dmitry
