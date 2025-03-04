Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 43E7B1D95B4
	for <virtualization@lists.linux-foundation.org>; Tue,  4 Mar 2025 11:14:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=140.211.166.136
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741086889; cv=pass; b=m7bPuN7pQF1huNhYGsVJIB9DQjdCAH2EkElq5jEy8JaR1ShNGDti6rTeRnCFtrqM1N7zfCpUr4Fxu9bieUGDN2b6ttGsP/LOdHLCjYR0Dd5dBNcvkV3Pel8tQ79HdWCsO+ysIUen3HJmAx0COH+R+aZ4tx8ubI9Me8Il65P62Dc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741086889; c=relaxed/simple;
	bh=mt7hEnVoH9ixJLgXuCnPk+QEtURpCqfN/VDQ8rFvN+o=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=cKNinDWJQDPBxP/hjBMEuxBO0bU7e8IURIFrh1CvcpsL+vE3opMybxM5gFTxekYPKfOUGoZLshfFMRgJBFMxZbLXIzsz1s4PejD6gIvbApA0DmKsuXYI2LW/piP9pB4uv2O0uLeLAPmZRGbyP6+Q66j8w4hw0INDSVwnUYCVmCc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=collabora.com header.i=dmitry.osipenko@collabora.com header.b=AE6MV5R4; arc=pass smtp.client-ip=140.211.166.136
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=collabora.com header.i=dmitry.osipenko@collabora.com header.b="AE6MV5R4"
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id C4444605BD
	for <virtualization@lists.linux-foundation.org>; Tue,  4 Mar 2025 11:14:47 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
X-Spam-Flag: NO
X-Spam-Score: -5.789
X-Spam-Level:
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id hSxiOlHCx177 for <virtualization@lists.linux-foundation.org>;
 Tue,  4 Mar 2025 11:14:47 +0000 (UTC)
X-Greylist: delayed 904 seconds by postgrey-1.37 at util1.osuosl.org; Tue, 04 Mar 2025 11:14:46 UTC
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp3.osuosl.org 17CE2605AD
Authentication-Results: smtp3.osuosl.org; dmarc=pass (p=none dis=none) header.from=collabora.com
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 17CE2605AD
Authentication-Results: smtp3.osuosl.org;
	dkim=pass (1024-bit key, unprotected) header.d=collabora.com header.i=dmitry.osipenko@collabora.com header.a=rsa-sha256 header.s=zohomail header.b=AE6MV5R4
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=136.143.188.112; helo=sender4-pp-f112.zoho.com; envelope-from=dmitry.osipenko@collabora.com; receiver=<UNKNOWN> 
Received: from sender4-pp-f112.zoho.com (sender4-pp-f112.zoho.com [136.143.188.112])
	by smtp3.osuosl.org (Postfix) with ESMTPS id 17CE2605AD
	for <virtualization@lists.linux-foundation.org>; Tue,  4 Mar 2025 11:14:46 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; t=1741085958; cv=none; 
	d=zohomail.com; s=zohoarc; 
	b=JgfciHxqZYyFSSfuhuv5vjVyq//D99mHx5wTVSy9RmDJQHUdgiW35c7twCWqZwXHJg5n6De5YA97iavK7rHFe4ZhbZrbqOVRu/MIFqxTAl3i8Ek8/V8XpRONF2QR1vml1jp/0laKIYlgLGG3QbMSkM3f3s5kXuhHBZoeS38vm3E=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com; s=zohoarc; 
	t=1741085958; h=Content-Type:Content-Transfer-Encoding:Cc:Cc:Date:Date:From:From:In-Reply-To:MIME-Version:Message-ID:References:Subject:Subject:To:To:Message-Id:Reply-To; 
	bh=Dbsr2DzMdYZQ4tGo8UWZqeyiKrIzRaj9gxDPB5xSI+M=; 
	b=ctwWrTWsqBfu/EzXaZS6O/bRL5u2s6IExQLG1qbNHnvSx8k8iZ9bK0sE/9ULBOFKRSJTUDAon6fCTw/HUDAvSeHwoTkpAt7BNLXRQiubBqCUxdcGNrLUVG7DuzWQ8fUweLmWJVQDDXKwcBylXbhxF5UqpwIeqAY79vC5LK9HvtY=
ARC-Authentication-Results: i=1; mx.zohomail.com;
	dkim=pass  header.i=collabora.com;
	spf=pass  smtp.mailfrom=dmitry.osipenko@collabora.com;
	dmarc=pass header.from=<dmitry.osipenko@collabora.com>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1741085958;
	s=zohomail; d=collabora.com; i=dmitry.osipenko@collabora.com;
	h=Message-ID:Date:Date:MIME-Version:Subject:Subject:To:To:Cc:Cc:References:From:From:In-Reply-To:Content-Type:Content-Transfer-Encoding:Message-Id:Reply-To;
	bh=Dbsr2DzMdYZQ4tGo8UWZqeyiKrIzRaj9gxDPB5xSI+M=;
	b=AE6MV5R4+ndvbYnirTlQbXoIphSwJhAjOCrPYHODCALnoq6TCaJFUpwnUQgu8B7B
	GoVR7tT2Yh2PDT2PxyUJotLWTUnWda1TM2n6wQzgI2GQAy8Ml7LBrxMm159NK0pzL7j
	Xn8UXuv45TdXfxx1lLGgOpgsOVxmEW8NByqxB3NI=
Received: by mx.zohomail.com with SMTPS id 174108595555814.859596015899456;
	Tue, 4 Mar 2025 02:59:15 -0800 (PST)
Message-ID: <6b7d95b7-a9dd-43c9-b1db-8a636b85ad51@collabora.com>
Date: Tue, 4 Mar 2025 13:59:09 +0300
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v19 22/30] drm/shmem-helper: Add common memory shrinker
To: Thomas Zimmermann <tzimmermann@suse.de>, David Airlie
 <airlied@gmail.com>, Gerd Hoffmann <kraxel@redhat.com>,
 Gurchetan Singh <gurchetansingh@chromium.org>, Chia-I Wu
 <olvaffe@gmail.com>, Daniel Vetter <daniel@ffwll.ch>,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>,
 =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>,
 Qiang Yu <yuq825@gmail.com>, Steven Price <steven.price@arm.com>,
 Boris Brezillon <boris.brezillon@collabora.com>,
 Emma Anholt <emma@anholt.net>, Melissa Wen <mwen@igalia.com>
Cc: kernel@collabora.com, linux-kernel@vger.kernel.org,
 dri-devel@lists.freedesktop.org, virtualization@lists.linux-foundation.org
References: <20240105184624.508603-1-dmitry.osipenko@collabora.com>
 <20240105184624.508603-23-dmitry.osipenko@collabora.com>
 <d1f856c7-47dd-4f1d-a124-973064dcd1f0@suse.de>
From: Dmitry Osipenko <dmitry.osipenko@collabora.com>
Content-Language: en-US
In-Reply-To: <d1f856c7-47dd-4f1d-a124-973064dcd1f0@suse.de>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ZohoMailClient: External

On 3/4/25 13:29, Thomas Zimmermann wrote:
> Hi
> 
> Am 05.01.24 um 19:46 schrieb Dmitry Osipenko:
>> Introduce common drm-shmem shrinker for DRM drivers.
> 
> What's the status of this patch?

It was de-prioritized on my list a year ago as I had to move to a higher
priority problems. Rebasing and re-testing these patches takes much
time, it either has to be split up in a smaller parts or applied in one go.

The current status is that I started to work on v20 rather long time ago
and the patches need to be rebased and re-tested again. Heard that
Panthor driver may want shmem shrinker more than others today.

-- 
Best regards,
Dmitry
