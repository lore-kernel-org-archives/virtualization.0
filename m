Received: from sender6-op-o11.zoho.com (sender6-op-o11.zoho.com [165.173.180.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D33FE3A7843
	for <virtualization@lists.linux.dev>; Sun, 20 Sep 2026 18:41:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=165.173.180.11
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789929694; cv=pass; b=BPoqLtBktAUl8li4sticRsDFyDs6C6dF98Z6trJF3tl8QNbs6kNz0yLsNYAFqNsXj0dVo0d6dAFkySBcuGfz4MLT6SVGT7lBT+PCbYUuzsmQ1Wb5iRS7Y58iiQDEmzKf0ilQk5DXqqalEc+8y3ne2AhJwNAFXMm5bM2W2LVRcYQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789929694; c=relaxed/simple;
	bh=06jo8iCPoivl7B4GfLJDpduKbNXr5BiAAmnhVPuiPNM=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=MKkbVDom11016k6wGk1mgPGTouxraA+nLST5dYvSNCj1HGgLatI+1StCYLrRnlkhXRNEZyGB2+9uhOvQuWpCHDiZIQT298EJ0rPngj3Eo9yEVbY9mbg26/BcG+Qq916MvYZasGwbCEJmFANgQNBnNSlZhjBMVGSeZdmdhRYF6B4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (1024-bit key) header.d=collabora.com header.i=dmitry.osipenko@collabora.com header.b=DLE+rv5w; arc=pass smtp.client-ip=165.173.180.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=collabora.com header.i=dmitry.osipenko@collabora.com header.b="DLE+rv5w"
ARC-Seal: i=1; a=rsa-sha256; t=1789929674; cv=none; 
	d=zohomail.com; s=zohoarc; 
	b=UBv0cN6RpWya8pAxrTp28ncAIaopa1TrvxEnE91GykOwc9HjP3ZIgohTF3D40J2ruSDU2MfHBeJKuuZLm5eMAUXmcxzvam2OM20u86tC/pJ2lu1ChpAGHBDupUaA71COiCZ3Qr18+H4bp1XNIpo/J+qY8BuhFHNx4Ak8x4deSMU=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com; s=zohoarc; 
	t=1789929674; h=Content-Type:Content-Transfer-Encoding:Cc:Cc:Date:Date:From:From:In-Reply-To:MIME-Version:Message-ID:Subject:Subject:To:To:Message-Id:Reply-To; 
	bh=6cJEo9tKI/esWhR3WngLiNKa/CZW5i3OXVrCTZNe76Q=; 
	b=h7gAPXEzBhzEt39eWqHCpLZLoueIT35AsRVaJxuCIkLLrL0FiUgfN5koycw1ni9qLnHHqhpHuuVP4XxH+gROlwr3fD5MhbThVEO175hgrmDfzJQDQJjG+ARUH1T74m2rqAPRVOsBgWWqAsFkC8sT8BmIEcstBOFVCNiXsEeQII8=
ARC-Authentication-Results: i=1; mx.zohomail.com;
	dkim=pass  header.i=collabora.com;
	spf=pass  smtp.mailfrom=dmitry.osipenko@collabora.com;
	dmarc=pass header.from=<dmitry.osipenko@collabora.com>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1789929674;
	s=zohomail; d=collabora.com; i=dmitry.osipenko@collabora.com;
	h=Message-ID:Date:Date:MIME-Version:Subject:Subject:To:To:Cc:Cc:From:From:In-Reply-To:Content-Type:Content-Transfer-Encoding:Message-Id:Reply-To;
	bh=6cJEo9tKI/esWhR3WngLiNKa/CZW5i3OXVrCTZNe76Q=;
	b=DLE+rv5wQs0jX7DmnjRD/EnzI3LFMnqqdlIydFFw5+KimlFDTov8zaWGVkz3ZoHg
	VgzKKYULooLH94MygBkaov9xaoyt3aapKbOwNkynn8LKTdxX75YX5iCmvfyxH1pAP5A
	AhNGaMLHEhgBgbR5CPhTA2Ff+DAyxJls93Xtw68I=
Received: by smtp.zohomail.com with SMTPS id 1789929672840636.3156490213071;
	Sun, 20 Sep 2026 11:41:12 -0700 (PDT)
Message-ID: <658fa074-5b9b-4123-a7d1-4c257b702854@collabora.com>
Date: Sun, 20 Sep 2026 21:41:09 +0300
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 0/2] drm/virtio: Damage clip fixes
To: Lyude Paul <lyude@redhat.com>, dri-devel@lists.freedesktop.org,
 virtualization@lists.linux.dev, linux-kernel@lists.freedesktop.org
Cc: David Airlie <airlied@redhat.com>,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 linux-kernel@vger.kernel.org, Simona Vetter <simona@ffwll.ch>,
 Gerd Hoffmann <kraxel@redhat.com>, Thomas Zimmermann <tzimmermann@suse.de>,
 Maxime Ripard <mripard@kernel.org>,
 Christian Hergert <christian@sourceandstack.com>
References: <20260903211914.1109100-1-lyude@redhat.com>
Content-Language: en-US
From: Dmitry Osipenko <dmitry.osipenko@collabora.com>
In-Reply-To: <20260903211914.1109100-1-lyude@redhat.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ZohoMailClient: External

On 9/4/26 00:15, Lyude Paul wrote:
> A previous associate of mine asked if someone would be able to help with
> upstreaming some work that they had done recently for virtio, and I was
> more then happy to help. These fixes help maintain FB damage clips
> between framebuffer changes, which were previously discarded even when
> userspace provided accumulated per-buffer damage.
> 
> Patches apply on top of drm-misc/drm-misc-next.
> 
> Christian Hergert (2):
>   drm/virtio: preserve damage clips for rendered resources
>   drm/virtio: Recalculate ignore_damage_clips on every update
> 
>  drivers/gpu/drm/virtio/virtgpu_plane.c | 10 +++++++---
>  1 file changed, 7 insertions(+), 3 deletions(-)
> 
> 
> base-commit: f9c2f70ee41544717b3c209083073db1e21f919b

Applied to misc-next, thanks!

-- 
Best regards,
Dmitry
