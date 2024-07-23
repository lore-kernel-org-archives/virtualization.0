Received: from madrid.collaboradmins.com (madrid.collaboradmins.com [46.235.227.194])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5290C1534FB
	for <virtualization@lists.linux.dev>; Tue, 23 Jul 2024 15:52:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=46.235.227.194
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721749954; cv=none; b=GykGWbgoBNq5EY4aerpyflU1dFeKx0TlaIih/5cZjjVDiuIbkXMY3TGl+tNZv+DeH4IXQAUyQStC5Rx4xvhW/TY3J1F2AYyJ6W5ajzJNUBZYa2pk/BpLT9dX9GNW0qf/cXkieNeo3XIO/pqwYFq8JgtEn2rUlaamanP6kmTLZyg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721749954; c=relaxed/simple;
	bh=Rm5Y5iNW/32GoQmcTW6S0lvAHwERKDMbGT5yagBdX0M=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=muOETU4fzNJf60QfdLcW/R02NfN0stwDJ6P3d/2oSuItlt2UT2MczIX4iw/Mu6kJeHeRp37n0mOdTmw6153HCieQfSfAMES+WwV4vVMrGHIiGGOtULtgSzEtHikXolE6AQOqhoc090TUcaXiY4T+Iw6ONSifHaCAlz2hnAxunmI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b=Yepvqxd7; arc=none smtp.client-ip=46.235.227.194
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b="Yepvqxd7"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
	s=mail; t=1721749949;
	bh=Rm5Y5iNW/32GoQmcTW6S0lvAHwERKDMbGT5yagBdX0M=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=Yepvqxd71jAWDoe683qziilODGx2MnT3pHB4AwzSPj/ns30bPEk40H78R0zLPg237
	 2n304IHKiuULikuE/6ggrLJanuY7XqS/5NN5uanBzyT48TreNMXTU3a4M0/F8MQt2Y
	 lRCPTl8eTTPBQizjUdBiUewwAshTWJ9vS3XT0QfA++K9RyR0R5rZGnSI7S0J3+itFp
	 uWOD5vuEhwK8/sQcaVJeAgKg545vORSXt8ObidsM7dI9rXnCEzEgSOz5Ame5IxqYJC
	 QPkeYCbeNMFrADqsifwYB04C2H64Bm2hSmlBk0YwGSp6q8q2a0U3C1muIiCeNXvRWi
	 sIwpjhbd3djZw==
Received: from [100.109.49.129] (cola.collaboradmins.com [195.201.22.229])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: dmitry.osipenko)
	by madrid.collaboradmins.com (Postfix) with ESMTPSA id 6A2BC3781144;
	Tue, 23 Jul 2024 15:52:28 +0000 (UTC)
Message-ID: <8e8313d4-b748-460b-bcb8-89d738747211@collabora.com>
Date: Tue, 23 Jul 2024 18:52:25 +0300
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] [PATCH RESEND] drm/virtio: fix memory leak of vbuf
To: Weishi Li <liweishi@kylinos.cn>, airlied@redhat.com, kraxel@redhat.com,
 gurchetansingh@chromium.org, olvaffe@gmail.com,
 maarten.lankhorst@linux.intel.com, mripard@kernel.org, tzimmermann@suse.de,
 daniel@ffwll.ch
Cc: dri-devel@lists.freedesktop.org, virtualization@lists.linux.dev,
 linux-kernel@vger.kernel.org
References: <20240509015225.38669-1-liweishi@kylinos.cn>
Content-Language: en-US
From: Dmitry Osipenko <dmitry.osipenko@collabora.com>
In-Reply-To: <20240509015225.38669-1-liweishi@kylinos.cn>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 5/9/24 04:52, Weishi Li wrote:
> @@ -356,12 +356,14 @@ static int virtio_gpu_queue_ctrl_sgs(struct virtio_gpu_device *vgdev,
>  
>  	ret = virtqueue_add_sgs(vq, sgs, outcnt, incnt, vbuf, GFP_ATOMIC);
>  	WARN_ON(ret);
> +	if (ret < 0 && ret != -ENOSPC) {
> +		free_vbuf(vgdev, vbuf);

Don't see why -ENOSPC shouldn't free buffer. If you trying to fix a
theoretical leak, then not worth doing it, IMO. Not apparent how to test
this error code path and it's not easy to review it.

-- 
Best regards,
Dmitry

