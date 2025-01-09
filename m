Received: from sender4-pp-f112.zoho.com (sender4-pp-f112.zoho.com [136.143.188.112])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B30FA63B9
	for <virtualization@lists.linux.dev>; Thu,  9 Jan 2025 14:04:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=136.143.188.112
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736431495; cv=pass; b=h1hAjuJyg5uCiUEZtpD4mVKK/pHWmJEhPkACAkRIRz+6m0ToASU6f4xaRbCRmxjy1SyRzgLrZBhc32ciuKdZg9Eze5mlxYnjJmZ6RnkzbxrFTvRs7tSdSCTJY9wlkfz1leF7bJyaMLC3l0p6Vu0I2oWyPzJNrJKpQMXFwK6wmgE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736431495; c=relaxed/simple;
	bh=1V2FDVfPEFd74vG5UOqBEIKGPFxWfwpOUZxZhWX9yhA=;
	h=Message-ID:Date:MIME-Version:Subject:From:To:Cc:References:
	 In-Reply-To:Content-Type; b=QJe3IUt64VgMIA8IXj70CVHgQOM2Avaim8/s6HmxgrGtIw/746ek69rbGSBtZu2vGOHFq9JTJ7OipMsxemwme9D4/nfRPJxOM3Ibf5GUlxp+BFyp9n/J7CXLSk8fAf+rGuTsHLa3pC0LUe3FDC9yER4WO9S9YQweJ1dNQMEiVRE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (1024-bit key) header.d=collabora.com header.i=dmitry.osipenko@collabora.com header.b=WuemZPtz; arc=pass smtp.client-ip=136.143.188.112
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=collabora.com header.i=dmitry.osipenko@collabora.com header.b="WuemZPtz"
ARC-Seal: i=1; a=rsa-sha256; t=1736431480; cv=none; 
	d=zohomail.com; s=zohoarc; 
	b=KGT+pVEVs4jKJQOl5p3/F7gu7ZF/JVYNgrGIMEIeAaLp+YV6eU6LqWMPQIFH1rXGVBadY10xVzw4tcNF6A9OYjZNGKx83r7owDuFZHxW2UluLvo0yQRgfeCKjQwR7R7rL7pxQbsmz5ydLDOpgRPJ41H7hAHbC7IpVuJ7NSQSPrE=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com; s=zohoarc; 
	t=1736431480; h=Content-Type:Content-Transfer-Encoding:Cc:Cc:Date:Date:From:From:In-Reply-To:MIME-Version:Message-ID:References:Subject:Subject:To:To:Message-Id:Reply-To; 
	bh=bcqWNMUStJZ6jHPZb3MXrarOvbjtKx/W6s5RI+ES+io=; 
	b=lQmUA/c6n42ycbdr3htviEExMukcvp6BX8NdL9HaKMiwYd3Vo/BzQtW6uoy1jOOSW9Zlg2zjCkUNH5a5kVF6eR42T6i2XuVrDe1Fr42IxKfn5ZnVt75Nv1mCJn+3t42StAYJiMgUEYFI6kbpSF4pyEbPXf4sbWff3BKQM1PRLVI=
ARC-Authentication-Results: i=1; mx.zohomail.com;
	dkim=pass  header.i=collabora.com;
	spf=pass  smtp.mailfrom=dmitry.osipenko@collabora.com;
	dmarc=pass header.from=<dmitry.osipenko@collabora.com>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1736431480;
	s=zohomail; d=collabora.com; i=dmitry.osipenko@collabora.com;
	h=Message-ID:Date:Date:MIME-Version:Subject:Subject:From:From:To:To:Cc:Cc:References:In-Reply-To:Content-Type:Content-Transfer-Encoding:Message-Id:Reply-To;
	bh=bcqWNMUStJZ6jHPZb3MXrarOvbjtKx/W6s5RI+ES+io=;
	b=WuemZPtzzqAAT8fofaOA/nd6wACy0kowej3TLJf5vXITQyDJfulZwxV2Xwr3VwAD
	5iqYMjSmO/8RRPyenAmM1TULOwxw0vXC4QblmnEOCgc+FjQcRYV4lQstnZvB+6W4Hun
	sfmpvx26TUCYDuJDqjwHZrWK8AREvN9mK4p4JS6Y=
Received: by mx.zohomail.com with SMTPS id 1736431477342198.9363372975331;
	Thu, 9 Jan 2025 06:04:37 -0800 (PST)
Message-ID: <f545d847-404b-4eea-91b5-2a7f80156fd4@collabora.com>
Date: Thu, 9 Jan 2025 17:04:33 +0300
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v1] drm/virtio: Set missing bo->attached flag
From: Dmitry Osipenko <dmitry.osipenko@collabora.com>
To: David Airlie <airlied@redhat.com>, Gerd Hoffmann <kraxel@redhat.com>,
 Gurchetan Singh <gurchetansingh@chromium.org>, Chia-I Wu
 <olvaffe@gmail.com>, Kim Dongwon <dongwon.kim@intel.com>,
 Kasireddy Vivek <vivek.kasireddy@intel.com>
Cc: Rob Clark <robdclark@gmail.com>, dri-devel@lists.freedesktop.org,
 virtualization@lists.linux.dev, linux-kernel@vger.kernel.org,
 kernel@collabora.com
References: <20241129155357.2265357-1-dmitry.osipenko@collabora.com>
Content-Language: en-US
In-Reply-To: <20241129155357.2265357-1-dmitry.osipenko@collabora.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ZohoMailClient: External

On 11/29/24 18:53, Dmitry Osipenko wrote:
> VirtIO-GPU driver now supports detachment of shmem BOs from host, but
> doing it only for imported dma-bufs. Mark all shmem BOs as attached, not
> just dma-bufs. This is a minor correction since detachment of a non-dmabuf
> BOs not supported today.
> 
> Signed-off-by: Dmitry Osipenko <dmitry.osipenko@collabora.com>
> ---
>  drivers/gpu/drm/virtio/virtgpu_prime.c | 1 -
>  drivers/gpu/drm/virtio/virtgpu_vq.c    | 3 +++
>  2 files changed, 3 insertions(+), 1 deletion(-)

Applied to misc-next

-- 
Best regards,
Dmitry
