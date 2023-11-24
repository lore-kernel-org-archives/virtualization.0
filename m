Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 18AFF1EB33
	for <virtualization@lists.linux-foundation.org>; Fri, 24 Nov 2023 10:41:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="qqxW+0tA"
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 816B66144E
	for <virtualization@lists.linux-foundation.org>; Fri, 24 Nov 2023 10:41:28 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 816B66144E
Authentication-Results: smtp3.osuosl.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20201202 header.b=qqxW+0tA
X-Virus-Scanned: amavisd-new at osuosl.org
X-Spam-Flag: NO
X-Spam-Score: -4.401
X-Spam-Level:
Received: from smtp3.osuosl.org ([127.0.0.1])
	by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id 4n4G5dORf78t
	for <virtualization@lists.linux-foundation.org>;
	Fri, 24 Nov 2023 10:41:28 +0000 (UTC)
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
	by smtp3.osuosl.org (Postfix) with ESMTPS id E4E9260AE8
	for <virtualization@lists.linux-foundation.org>; Fri, 24 Nov 2023 10:41:27 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org E4E9260AE8
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by dfw.source.kernel.org (Postfix) with ESMTP id 3077962158;
	Fri, 24 Nov 2023 10:41:27 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 80675C433C8;
	Fri, 24 Nov 2023 10:41:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1700822486;
	bh=mx8zbhH9XuRFKow8SMM4vIllq541PDHZLX4FbTHewh0=;
	h=Date:From:To:Subject:In-Reply-To:References:Cc:From;
	b=qqxW+0tALhs6DPa50m/V0TDQBDRvKe6AVAWJNKYhn3V8Pyho0tFULZ7QAjdBeRiZs
	 z4IodWvCbcDaqeIplw2I2Xc2q8vxPJthU8sMsFBRxH84qNOAAcVKkvX+7I+Jf8Ayhk
	 xQgh62ZjZ6Pu++q35Yb86wsxRDAHjNS/zPkcvoe64CKbbrntFpNE8JAD2Dyi5zt8zc
	 7p6INUCsxodERYJmS0t19p1m4z+XuNfeLutyVZAdO6sd+LhZ149p0PauBQOORB2tNT
	 B+99y/nbY4HyeN/CCRge+Hye2knoWDH8DTYY/DzC9J6G3gMVGVWo54JR8EPhmC80tf
	 YnE554xIeHfCA==
Message-ID: <5ebb290e629a83f12525c2ddf0ca2082.mripard@kernel.org>
Date: Fri, 24 Nov 2023 10:41:24 +0000
From: "Maxime Ripard" <mripard@kernel.org>
To: "Dmitry Osipenko" <dmitry.osipenko@collabora.com>
Subject: Re: [PATCH v18 07/26] drm/shmem-helper: Use refcount_t for
 pages_use_count
In-Reply-To: <20231029230205.93277-8-dmitry.osipenko@collabora.com>
References: <20231029230205.93277-8-dmitry.osipenko@collabora.com>
Cc: dri-devel@lists.freedesktop.org, kernel@collabora.com, linux-kernel@vger.kernel.org, virtualization@lists.linux-foundation.org, "Boris
 Brezillon" <boris.brezillon@collabora.com>, "Chia-I Wu" <olvaffe@gmail.com>,
 =?utf-8?b?Q2hyaXN0aWFuIEvDtm5pZw==?= <christian.koenig@amd.com>, "Daniel
 Vetter" <daniel@ffwll.ch>, "David Airlie" <airlied@gmail.com>, "Emma Anholt" <emma@anholt.net>, "Gerd
 Hoffmann" <kraxel@redhat.com>, "Gurchetan Singh" <gurchetansingh@chromium.org>, "Maarten
 Lankhorst" <maarten.lankhorst@linux.intel.com>, "Maxime Ripard" <mripard@kernel.org>, "Melissa
 Wen" <mwen@igalia.com>, "Qiang Yu" <yuq825@gmail.com>, "Steven Price" <steven.price@arm.com>, "Thomas
 Zimmermann" <tzimmermann@suse.de>
Content-Transfer-Encoding: 7bit
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>

On Mon, 30 Oct 2023 02:01:46 +0300, Dmitry Osipenko wrote:
> Use atomic refcount_t helper for pages_use_count to optimize pin/unpin
> functions by skipping reservation locking while GEM's pin refcount > 1.
> 
> Reviewed-by: Boris Brezillon <boris.brezillon@collabora.com>
> Suggested-by: Boris Brezillon <boris.brezillon@collabora.com>
> 
> [ ... ]

Acked-by: Maxime Ripard <mripard@kernel.org>

Thanks!
Maxime
