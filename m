Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ACE7D1F61D
	for <virtualization@lists.linux-foundation.org>; Mon, 13 Nov 2023 13:18:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b="X6iNkjwQ"
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 3D60581D4D
	for <virtualization@lists.linux-foundation.org>; Mon, 13 Nov 2023 13:18:44 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 3D60581D4D
Authentication-Results: smtp1.osuosl.org;
	dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.a=rsa-sha256 header.s=mail header.b=X6iNkjwQ
X-Virus-Scanned: amavisd-new at osuosl.org
X-Spam-Flag: NO
X-Spam-Score: -2.101
X-Spam-Level:
Received: from smtp1.osuosl.org ([127.0.0.1])
	by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id 1YwcSXI9id8q
	for <virtualization@lists.linux-foundation.org>;
	Mon, 13 Nov 2023 13:18:43 +0000 (UTC)
Received: from madras.collabora.co.uk (madras.collabora.co.uk [46.235.227.172])
	by smtp1.osuosl.org (Postfix) with ESMTPS id 1558581E6B
	for <virtualization@lists.linux-foundation.org>; Mon, 13 Nov 2023 13:18:42 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 1558581E6B
Received: from [10.3.2.161] (zone.collabora.co.uk [167.235.23.81])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: dmitry.osipenko)
	by madras.collabora.co.uk (Postfix) with ESMTPSA id EF94A6602F27;
	Mon, 13 Nov 2023 13:18:38 +0000 (GMT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
	s=mail; t=1699881520;
	bh=PsIR0GMAaqeUGdkQLSq03TGY+YtcolIVSMRqZDzc4JU=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=X6iNkjwQ8pObx2Yq1DU9viprvhAzw6KpMX/7M6wC4FvKDGMfxLVcYSFLxI9LSkM00
	 Rde7H5LmO6xc6SWwyoprZBk4t9b6gE2W+YfXYZVRz3gS50oZ50MpHUB5IHZ1jmDsop
	 xmjdsnRVIkvvADYlsOhztSTId32H6nhE2i/rkKGXYrHZpHEiYUb0s9kvfIOsTP8/z8
	 ZikdbAh/HYFzUqB62ESil2c4PqvnnhvxzxYivCwUltf7pykxcKlYLIgbtzAmFSjRUL
	 SklX/mE5/zPNykCY/JMvQX5RQ1ybYIIkXmEWdAYCGaW0zkZpeOar30hDaQkJkWvQia
	 BnBX7FQ8DMC1g==
Message-ID: <622e2064-095f-d2da-0ad1-887642306020@collabora.com>
Date: Mon, 13 Nov 2023 16:18:34 +0300
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.15.1
Subject: Re: [PATCH 2/2] drm/virtio: Modify RESOURCE_GET_LAYOUT ioctl
Content-Language: en-US
To: Julia Zhang <julia.zhang@amd.com>,
 Gurchetan Singh <gurchetansingh@chromium.org>, Chia-I Wu
 <olvaffe@gmail.com>, David Airlie <airlied@redhat.com>,
 Gerd Hoffmann <kraxel@redhat.com>, linux-kernel@vger.kernel.org,
 dri-devel@lists.freedesktop.org, amd-gfx@lists.freedesktop.org,
 virtualization@lists.linux-foundation.org
Cc: Pierre-Eric Pelloux-Prayer <pierre-eric.pelloux-prayer@amd.com>,
 Erik Faye-Lund <kusmabite@gmail.com>, =?UTF-8?B?TWFyZWsgT2zFocOhaw==?=
 <marek.olsak@amd.com>, Chen Jiqian <Jiqian.Chen@amd.com>,
 Huang Rui <ray.huang@amd.com>, Honglei Huang <honglei1.huang@amd.com>,
 Alex Deucher <alexander.deucher@amd.com>,
 =?UTF-8?Q?Christian_K=c3=b6nig?= <christian.koenig@amd.com>
References: <20231110071632.24612-1-julia.zhang@amd.com>
 <20231110071632.24612-3-julia.zhang@amd.com>
From: Dmitry Osipenko <dmitry.osipenko@collabora.com>
In-Reply-To: <20231110071632.24612-3-julia.zhang@amd.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 11/10/23 10:16, Julia Zhang wrote:
> Modify RESOURCE_GET_LAYOUT ioctl to handle the use case that query
> correct stride for guest linear resource before it is created.
> 
> Signed-off-by: Julia Zhang <julia.zhang@amd.com>
> ---
>  drivers/gpu/drm/virtio/virtgpu_drv.h   | 26 ++++++++------
>  drivers/gpu/drm/virtio/virtgpu_ioctl.c | 47 ++++++++++++--------------
>  drivers/gpu/drm/virtio/virtgpu_vq.c    | 35 +++++++++++--------
>  include/uapi/drm/virtgpu_drm.h         |  6 ++--
>  include/uapi/linux/virtio_gpu.h        |  8 ++---
>  5 files changed, 66 insertions(+), 56 deletions(-)

1. Please squash this all into a single patch. For upstream kernel it's
not acceptable to have subsequent commits modifying previous commits. To
commit message add your s-o-b, your co-developed-by tags and a brief
comment explaining changes you've done to the original patch.

Signed-off-by: Daniel Stone <daniels@collabora.com>
Co-developed-by: Julia Zhang <julia.zhang@amd.com> # query correct
stride for guest linear resource before it's created
Signed-off-by: Julia Zhang <julia.zhang@amd.com>

2. Make sure that patch passes `scripts/checkpatch.pl`

3. Add link to the commit message for the relevant Mesa MR that makes
use of the new ioctl. The MR should be already merged or ready to be merged.

Link: https://gitlab.freedesktop.org/mesa/mesa/-/merge_requests/123456

-- 
Best regards,
Dmitry

