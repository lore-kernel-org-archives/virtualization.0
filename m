Received: from sender4-pp-f112.zoho.com (sender4-pp-f112.zoho.com [136.143.188.112])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C0905219A9F
	for <virtualization@lists.linux.dev>; Thu,  9 Jan 2025 14:05:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=136.143.188.112
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736431509; cv=pass; b=Jo2LfGycm3pHv1053/Ioa/RYUQSs2+Rz5V+K2xLtSZS8wv7PLfxarz06DLBwRorPw15U2/j/POUbcVViIIiIxQPbTyfFFqNbwESLjprUbNYhxyZ2W/K7o17UJCgtGf9PfVCk3mu8rCyiqdTIgqSY8rHRNaC/Xi2qLS9bbGduERc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736431509; c=relaxed/simple;
	bh=kYkbx8fRjemR2zpEjvRAvcosWd1yCodW6h8M+ZpPQSY=;
	h=Message-ID:Date:MIME-Version:Subject:From:To:Cc:References:
	 In-Reply-To:Content-Type; b=nyJDz/I2FzsbgJ4k8RPQ6W2q/wmiqeI+aixOj3J/tJv3/3o03HPBLTni8j6gaewh8QErahAyGO4A1yqzBxOPldT7d0GWhIEPkMGw24e3R8qbTOmrhAFCF/gn2N8h/yy/XZtk0zc/RY+5JW8D0QgCdRd/FV9BAYz+MCDunVYV+ZU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (1024-bit key) header.d=collabora.com header.i=dmitry.osipenko@collabora.com header.b=RPDyYgWF; arc=pass smtp.client-ip=136.143.188.112
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=collabora.com header.i=dmitry.osipenko@collabora.com header.b="RPDyYgWF"
ARC-Seal: i=1; a=rsa-sha256; t=1736431496; cv=none; 
	d=zohomail.com; s=zohoarc; 
	b=U3Ow3LFaJH/sbNtN6KkZ4AyMXbWtrHLKpjVzAnC46PMFz94gEJvOWoRhIFnpjLqQ8QQbYIepVA/re1OGytiXSsUTi+1UT3qx0hKx/tEqU9Ot2gJdBzFTejb+uRjdeHwm6Yvpy/H8H7YSvl6n4AZ1b+hIm0A/FMziA0oniOhSgw0=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com; s=zohoarc; 
	t=1736431496; h=Content-Type:Content-Transfer-Encoding:Cc:Cc:Date:Date:From:From:In-Reply-To:MIME-Version:Message-ID:References:Subject:Subject:To:To:Message-Id:Reply-To; 
	bh=F9mFngC+DCR+DBz+4XxB0JwQ/lImo2qdcTd+mjD3q4w=; 
	b=TGGlzUmVMOeqF67RtMguueqt090oayv2nBv+Lz447ZkZhucKjxrelKqMMDRk9D/0R3JQKbZH/0FZvDWqnWrWjGd7qxt69oDq0o3moGCBefi1xuBV0qpj68iHse+SLfQRZ8IUlyB5gL6pHaLp4VDcX3lUvlWOExhBU5CkY7YTpB0=
ARC-Authentication-Results: i=1; mx.zohomail.com;
	dkim=pass  header.i=collabora.com;
	spf=pass  smtp.mailfrom=dmitry.osipenko@collabora.com;
	dmarc=pass header.from=<dmitry.osipenko@collabora.com>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1736431496;
	s=zohomail; d=collabora.com; i=dmitry.osipenko@collabora.com;
	h=Message-ID:Date:Date:MIME-Version:Subject:Subject:From:From:To:To:Cc:Cc:References:In-Reply-To:Content-Type:Content-Transfer-Encoding:Message-Id:Reply-To;
	bh=F9mFngC+DCR+DBz+4XxB0JwQ/lImo2qdcTd+mjD3q4w=;
	b=RPDyYgWFEfWqoCiL5sfiDzfhwi4Ks10esGFDv2cKapjK6EXFqu+tuHGMCBbfPFsE
	nLBKOnoRFQzDLQSNIYsaQ34x6G8/jIpXQHi/bSGvW+F3GNgYrmeEB5yXlGw8udEtmdX
	ox//GCIZtHTYeVYBZMUIhtc056k/HJmdNoDfZlJo=
Received: by mx.zohomail.com with SMTPS id 17364314932331023.2938194147448;
	Thu, 9 Jan 2025 06:04:53 -0800 (PST)
Message-ID: <2e4851e1-976d-4eb3-9171-3f77aff93979@collabora.com>
Date: Thu, 9 Jan 2025 17:04:49 +0300
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v1] drm/virtio: Factor out common dmabuf unmapping code
From: Dmitry Osipenko <dmitry.osipenko@collabora.com>
To: David Airlie <airlied@redhat.com>, Gerd Hoffmann <kraxel@redhat.com>,
 Gurchetan Singh <gurchetansingh@chromium.org>, Chia-I Wu
 <olvaffe@gmail.com>, Kim Dongwon <dongwon.kim@intel.com>,
 Kasireddy Vivek <vivek.kasireddy@intel.com>
Cc: Rob Clark <robdclark@gmail.com>, dri-devel@lists.freedesktop.org,
 virtualization@lists.linux.dev, linux-kernel@vger.kernel.org,
 kernel@collabora.com
References: <20241202053955.2451321-1-dmitry.osipenko@collabora.com>
Content-Language: en-US
In-Reply-To: <20241202053955.2451321-1-dmitry.osipenko@collabora.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ZohoMailClient: External

On 12/2/24 08:39, Dmitry Osipenko wrote:
> Move out dmabuf detachment and unmapping into separate function. This
> removes duplicated code and there is no need to check the GEM's kref now,
> since both bo->attached and bo->sgt are unset under held reservation lock.
> 
> Signed-off-by: Dmitry Osipenko <dmitry.osipenko@collabora.com>
> ---
>  drivers/gpu/drm/virtio/virtgpu_prime.c | 35 ++++++++++++++------------
>  1 file changed, 19 insertions(+), 16 deletions(-)

Made a minor rebase on top of the recent UAF fix and applied to misc-next.

-- 
Best regards,
Dmitry
