Received: from sender4-pp-f112.zoho.com (sender4-pp-f112.zoho.com [136.143.188.112])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5121B1BCA1C
	for <virtualization@lists.linux.dev>; Thu,  9 Oct 2025 03:12:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=136.143.188.112
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759979550; cv=pass; b=JAWC4FfJUQM36BvfnaXQw6dD6nUwd47wQCjuD9jHSHEkFpwCvF0Amnr67IuuZAfU/4QQZAGFrRuA7p/uk3Epl2xZ3cdd/qZ0d/WbaIyGJASTo7fW7jIl3knYunmtEZl0LDR/9ZjKuhe4l4P9sA3UhW9ttfviS4irSfwgDyQ993M=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759979550; c=relaxed/simple;
	bh=SzKY8ajULXnQMkJwro6gWfjAnMCXuGprl977+wTeQNA=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=OZ3y81VFu15+d+YPDMXdGgpKB6q2v+zbhPgr8OZGf5bdtvg/5NlWSWgx/Rs53oVpyZFvUrxGshrEzWwHwXusXsi6nQhM92oNJZXttj9821gol5DA7b3Tr2V3YrpVBepYdQrS7bDXj6LdU3ycb2ekqPT7fW0e3XtS4bqBxtI7B+Y=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (1024-bit key) header.d=collabora.com header.i=dmitry.osipenko@collabora.com header.b=CyBs1SK5; arc=pass smtp.client-ip=136.143.188.112
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=collabora.com header.i=dmitry.osipenko@collabora.com header.b="CyBs1SK5"
ARC-Seal: i=1; a=rsa-sha256; t=1759979538; cv=none; 
	d=zohomail.com; s=zohoarc; 
	b=XwRbKGxXyD1jo0M0N4VIzR6ojXZmxwhgPGBwUyWRggJXwJC/pePX+9XCKOD/we8EfK1gm5HIxZr2s47G2mKSbl7I+P4UKp+qaAxYy9j/1VeuuIBqLaIMY4l6S9OTcrbD07EEsJn3jR9qfjlp6HL8jm0t8Dt84Yw4Gwi1A9nu+ro=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com; s=zohoarc; 
	t=1759979538; h=Content-Type:Content-Transfer-Encoding:Cc:Cc:Date:Date:From:From:In-Reply-To:MIME-Version:Message-ID:References:Subject:Subject:To:To:Message-Id:Reply-To; 
	bh=KRi9Dp8IwKCGBEjvVN1ZhH9rJI8hir+DEKoyo8v/Rl4=; 
	b=iaBPfWs9bTF+/ri6fJS4+ldc8+EG9U53k4pdktMMMJ/1jxzVYupA+qWhn4oKtcYXsHBgMoG4mD/AhgdqnrBKI/gx/tiiFkbNe+srJqwQYOALTKHSs5Rx1N0sqWpRfKX5r6XhXS+GncEmIStCS89w4S2bONZSixilop9Gq30fWN4=
ARC-Authentication-Results: i=1; mx.zohomail.com;
	dkim=pass  header.i=collabora.com;
	spf=pass  smtp.mailfrom=dmitry.osipenko@collabora.com;
	dmarc=pass header.from=<dmitry.osipenko@collabora.com>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1759979538;
	s=zohomail; d=collabora.com; i=dmitry.osipenko@collabora.com;
	h=Message-ID:Date:Date:MIME-Version:Subject:Subject:To:To:Cc:Cc:References:From:From:In-Reply-To:Content-Type:Content-Transfer-Encoding:Message-Id:Reply-To;
	bh=KRi9Dp8IwKCGBEjvVN1ZhH9rJI8hir+DEKoyo8v/Rl4=;
	b=CyBs1SK5MhxCXB9nCJeUNXpQjCIKsqO5sV3k5odoHlJVA/QEp62go6W41GBac047
	f4VCkG2JSMP47zAzU4WQUxR8QCjAgVmA5VEJoJVWQm6hu30zP7Q7GyPhoYBbZ2psRvt
	cUksUlH55NQ7bWF06GehTuxYEjkJrp9EmiNzAkAI=
Received: by mx.zohomail.com with SMTPS id 1759979536109504.4796089477394;
	Wed, 8 Oct 2025 20:12:16 -0700 (PDT)
Message-ID: <d3cfbc5a-11f0-4482-bf6b-ef890d182fc7@collabora.com>
Date: Thu, 9 Oct 2025 06:12:08 +0300
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 5.10] gpu/drm/virtio: fix error return in
 vgdev_output_init()
To: Alexandr Sapozhnkiov <alsp705@gmail.com>,
 David Airlie <airlied@redhat.com>, Gerd Hoffmann <kraxel@redhat.com>,
 Gurchetan Singh <gurchetansingh@chromium.org>, Chia-I Wu
 <olvaffe@gmail.com>, Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>,
 Daniel Vetter <daniel@ffwll.ch>, dri-devel@lists.freedesktop.org,
 virtualization@lists.linux.dev
Cc: lvc-project@linuxtesting.org
References: <20250922144418.41-1-alsp705@gmail.com>
From: Dmitry Osipenko <dmitry.osipenko@collabora.com>
Content-Language: en-US
In-Reply-To: <20250922144418.41-1-alsp705@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ZohoMailClient: External

On 9/22/25 17:44, Alexandr Sapozhnkiov wrote:
> From: Alexandr Sapozhnikov <alsp705@gmail.com>
> 
> Return value of function drm_crtc_init_with_planes(), 
> called at virtgpu_display.c:276, is not checked, 
> but it is usually checked for this function
> 
> Found by Linux Verification Center (linuxtesting.org) with SVACE.
> Signed-off-by: Alexandr Sapozhnikov <alsp705@gmail.com>
> ---
>  drivers/gpu/drm/virtio/virtgpu_display.c | 5 ++++-
>  1 file changed, 4 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/gpu/drm/virtio/virtgpu_display.c b/drivers/gpu/drm/virtio/virtgpu_display.c
> index ad924a8502e9..59b652e8a630 100644
> --- a/drivers/gpu/drm/virtio/virtgpu_display.c
> +++ b/drivers/gpu/drm/virtio/virtgpu_display.c
> @@ -253,6 +253,7 @@ static const struct drm_connector_funcs virtio_gpu_connector_funcs = {


Applied to misc-next with corrected coding style and edited commit
message, thanks.

-- 
Best regards,
Dmitry

