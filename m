Received: from madrid.collaboradmins.com (madrid.collaboradmins.com [46.235.227.194])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DFE701E49D
	for <virtualization@lists.linux.dev>; Mon,  8 Jul 2024 14:30:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=46.235.227.194
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720449025; cv=none; b=C72MTipr62Lcd49cTSrQxs2N22RDK0quDgOttKxUd0tH91lNjXQF1LiJB4E7K/Lk4Q07zwTlz/86iDasjEiOWODnh4o0orh9u1Ws7Gzwuukunur3SOcI9Ps7vJOG0UMq1IkiX+noj6x2E3vcemykJPr2aBT9xMQmlXB9Q4tRJ7g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720449025; c=relaxed/simple;
	bh=UK1alpRLVojcjqHEMZmxpNsz5oT0x+BMwmb8zL2rljs=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=kIBxoNzTy8IxCpUKre95QOm43/wvsM0/dBnCtjZ7RaSgH6FB8HCNXA9ZE3i/no2Upn2VcNUou8MmpKmoeSN1MIT2i5qAgWceqX3Rv09zHEJCvCLgKcy8B9stuQlKnqwV/McX4OnnpaWWPjJSNoKUgu0wJcxcafPTEIQi6mImkGI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b=qH4/G02J; arc=none smtp.client-ip=46.235.227.194
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b="qH4/G02J"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
	s=mail; t=1720449022;
	bh=UK1alpRLVojcjqHEMZmxpNsz5oT0x+BMwmb8zL2rljs=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=qH4/G02JPZf6ORUyvihDWgmTXxaRGQkoJHgQhA8/6V8aH9d+9K7wpl0FLOH02ktfL
	 TtP6QEBx2u6tFNWtK9NcDM5aaHSOPkyzkD10KZs+PFI682EPyd53ilE7GiKvRywgbw
	 8DZbYc+Rdg0XipfpfLid+GjVdkPBvW8pxVIUa2nlKF7w+KIqgW1b7dh39AF6vxS/mF
	 DlRibNlH5CYI0oDI5rJdZ2NMAXDy4S0/mjRr/I19KDzilORWeewoe/ObabbnXE8QO3
	 j+daDceJz+rZlYMy+PHbbIOuVpRxTkIxIvptFYOHiVQsRt1ezMef0qBTu6gUdHwv+p
	 B2c7u9d8Viwqw==
Received: from [100.109.49.129] (cola.collaboradmins.com [195.201.22.229])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: dmitry.osipenko)
	by madrid.collaboradmins.com (Postfix) with ESMTPSA id D322937811CD;
	Mon,  8 Jul 2024 14:30:20 +0000 (UTC)
Message-ID: <21750085-dbb0-4fc5-8644-ebed5373dde9@collabora.com>
Date: Mon, 8 Jul 2024 17:30:18 +0300
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] drm/qxl: Pin buffer objects for internal mappings
To: Thomas Zimmermann <tzimmermann@suse.de>, airlied@redhat.com,
 kraxel@redhat.com, zack.rusin@broadcom.com, airlied@gmail.com,
 daniel@ffwll.ch, maarten.lankhorst@linux.intel.com, mripard@kernel.org,
 david.kaplan@amd.com, christian.koenig@amd.com
Cc: regressions@leemhuis.info, virtualization@lists.linux.dev,
 spice-devel@lists.freedesktop.org, dri-devel@lists.freedesktop.org,
 Daniel Vetter <daniel.vetter@ffwll.ch>
References: <20240708142208.194361-1-tzimmermann@suse.de>
Content-Language: en-US
From: Dmitry Osipenko <dmitry.osipenko@collabora.com>
In-Reply-To: <20240708142208.194361-1-tzimmermann@suse.de>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

On 7/8/24 17:21, Thomas Zimmermann wrote:
> Add qxl_bo_pin_and_vmap() that pins and vmaps a buffer object in one
> step. Update callers of the regular qxl_bo_vmap(). Fixes a bug where
> qxl accesses an unpinned buffer object while it is being moved; such
> as with the monitor-description BO. An typical error is shown below.
> 
> [    4.303586] [drm:drm_atomic_helper_commit_planes] *ERROR* head 1 wrong: 65376256x16777216+0+0
> [    4.586883] [drm:drm_atomic_helper_commit_planes] *ERROR* head 1 wrong: 65376256x16777216+0+0
> [    4.904036] [drm:drm_atomic_helper_commit_planes] *ERROR* head 1 wrong: 65335296x16777216+0+0
> [    5.374347] [drm:qxl_release_from_id_locked] *ERROR* failed to find id in release_idr
> 
> Commit b33651a5c98d ("drm/qxl: Do not pin buffer objects for vmap")
> removed the implicit pin operation from qxl's vmap code. This is the
> correct behavior for GEM and PRIME interfaces, but the pin is still
> needed for qxl internal operation.
> 
> Also add a corresponding function qxl_bo_vunmap_and_unpin() and remove
> the old qxl_bo_vmap() helpers.
> 
> Future directions: BOs should not be pinned or vmapped unnecessarily.
> The pin-and-vmap operation should be removed from the driver and a
> temporary mapping should be established with a vmap_local-like helper.
> See the client helper drm_client_buffer_vmap_local() for semantics.
> 
> v2:
> - unreserve BO on errors in qxl_bo_pin_and_vmap() (Dmitry)
> 
> Signed-off-by: Thomas Zimmermann <tzimmermann@suse.de>
> Fixes: b33651a5c98d ("drm/qxl: Do not pin buffer objects for vmap")
> Reported-by: David Kaplan <david.kaplan@amd.com>
> Closes: https://lore.kernel.org/dri-devel/ab0fb17d-0f96-4ee6-8b21-65d02bb02655@suse.de/
> Tested-by: David Kaplan <david.kaplan@amd.com>
> Reviewed-by: Daniel Vetter <daniel.vetter@ffwll.ch>
> Cc: Thomas Zimmermann <tzimmermann@suse.de>
> Cc: Dmitry Osipenko <dmitry.osipenko@collabora.com>
> Cc: Christian König <christian.koenig@amd.com>
> Cc: Zack Rusin <zack.rusin@broadcom.com>
> Cc: Dave Airlie <airlied@redhat.com>
> Cc: Gerd Hoffmann <kraxel@redhat.com>
> Cc: virtualization@lists.linux.dev
> Cc: spice-devel@lists.freedesktop.org
> ---
>  drivers/gpu/drm/qxl/qxl_display.c | 14 +++++++-------
>  drivers/gpu/drm/qxl/qxl_object.c  | 13 +++++++++++--
>  drivers/gpu/drm/qxl/qxl_object.h  |  4 ++--
>  3 files changed, 20 insertions(+), 11 deletions(-)

Reviewed-by: Dmitry Osipenko <dmitry.osipenko@collabora.com>

-- 
Best regards,
Dmitry

