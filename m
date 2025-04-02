Received: from mail-yw1-f170.google.com (mail-yw1-f170.google.com [209.85.128.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 31A501DE3AD
	for <virtualization@lists.linux.dev>; Wed,  2 Apr 2025 18:45:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743619518; cv=none; b=e3xhHXdGqEMBk0A8ii8KlDp7HAv0PLmSa9wLFmVvKY+T6QURGiQJyot8Do0utqpRSbAb6nBXof79f6LT4+F5VpvcOqtIMm2kxvwIaYd9g2XcAef07VAzLanzzijnVrdQzxOjRBMoYvfzJ6Q1iHGngE6kONXpzeIQrHrj58ng538=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743619518; c=relaxed/simple;
	bh=vGhArAQH1Bq6m++fYceod3QyTAZ0Z0KlWXfiZp4Ak2I=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=dHPYZLaaX7yt475kszTnTYZufRxc6WUK3IeL04ZW9g5tAoj+D0s7wsFen/mRiMwR/WgCEGJXSXaPs6Yojia2qMa9YPp1MypiSXHA+4lLkkt9Q0lI1qO83tlBf46Y8BUwNX7j4Hn1zSyKyTtDMp+17Ue5NEYAoA9VewbEZoS1eDM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Dm6v/kY6; arc=none smtp.client-ip=209.85.128.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Dm6v/kY6"
Received: by mail-yw1-f170.google.com with SMTP id 00721157ae682-6f7031ea11cso1616707b3.2
        for <virtualization@lists.linux.dev>; Wed, 02 Apr 2025 11:45:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1743619516; x=1744224316; darn=lists.linux.dev;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=xrd9rhAP2VF8H2guxJAgaMmc1BAZwOh7QKhbshcNLJU=;
        b=Dm6v/kY6IL3YBqOWpjKMy//5aPgOqB8vuBIbUoeTfbkhsq7EHoICL8D+L+S3IjvHuf
         iEEVWGjgmZB5frlhT1X65JsvyxMIUodSa4KIQSLLVoL7b9kmpKq7VKRTvLLzLHhVBo6X
         N1gyE0KO9a0HscxMKoLZYFRCX2Qq9DWY72ANNgQx6d+12aQ2jFBVThJhgV6pFSlLOVh6
         5aoMJw22WHQ3BoQg/NmxxeBg9u5AhDSnoVwLWaEtmFNHVq+ZH/RtEIVZWjvTBBTnGiyn
         iIKc2Cey5Bxrm0JWkH2a/yZQZ+zAcdIhhfaQ0i2pqVG7vHWmWeIGbtJMmkTD5v7VFrGH
         tZMg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1743619516; x=1744224316;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=xrd9rhAP2VF8H2guxJAgaMmc1BAZwOh7QKhbshcNLJU=;
        b=BPjWhNy70TNh3H3DKij8BIdX6snthR4vaH3C7P0VBX11AE/O9g0QLWp8zSVsk3lq/N
         o9EQ0mvAC5yaPzzm0vMG0aWV7qe4tHFEPcZkIdi2DmarwwatBKNVzmyezvWeHqI05fci
         1O20AI4iGnFp4w9MejDwZPna3VsYqLC9q+XOAuI+W2m2Rh7FpkpZ8C9feFiAvrcpxHYy
         0d/dnMrPPaqLAChqa1urVGDMo0aOM+YUfuPRwX7iNasRMkvsX4PTDgby+ncwIA3lhgI/
         yjcDYUdBQotb37e6sdnMnTpw79zfBvG1FQUi32YkHSTF0aoqzctKRqw25uauEcBrIl3h
         RhuA==
X-Forwarded-Encrypted: i=1; AJvYcCUpslOhuMehbKogVuhVcj8cT+mSL49pff1bEsCkt3elN6Mqgv1e28Auya4ayhXc7i26O9VWnmJa8tYfBACmng==@lists.linux.dev
X-Gm-Message-State: AOJu0YwDBVdqIEk2aVA6UiT6FItVrQMC/yGfpILnUbFZBClxNxOiIvT0
	CujK8OL5Aip0+lceySCQvRgcf/D/Foa8H+8+rYPzlrhSNZkNeZqe
X-Gm-Gg: ASbGncse9bXXFPCGyaYZ18GTQpJPrWPWSTuPYcwoqTNsttoehgi1D3HBuLhkpPT1+pQ
	px//4xn86oTVK7CSpLIqdoLiA3UCIoxBAJTq+1S59lSaO+cUTvm4k7NOHn1LDywTCwo9d7CfqvL
	2TU1NWVk7tvpy5uXWOxvEkHfzc0NST1kLb82KLbqdaHA8JOeUzPZB4kJxlJQS7+uIZLkT7Ke7qa
	Hfl6TivjriJvfs3ZDgRLvbPXKo/IujCHhuoHXZ94I4JabDyJr2a0rJ0CvKYXX39OHCc7nh+vOx9
	Qsx1VrzqcGVswlJUUiqPhbB3N6hsUMtU905sUmMg2eG3ij3IVkI=
X-Google-Smtp-Source: AGHT+IEWyT4pv5lWH9jwWo/gBD5TVxCNEn6VD+Sl5d8QNuM1ecZtig6lmPxe9flawrV2VOlo0o4YsA==
X-Received: by 2002:a05:690c:6e09:b0:6fd:3d82:f900 with SMTP id 00721157ae682-70257275106mr266156487b3.20.1743619516065;
        Wed, 02 Apr 2025 11:45:16 -0700 (PDT)
Received: from [10.138.35.215] ([45.134.140.51])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-7023a3c3958sm34004787b3.50.2025.04.02.11.45.11
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 02 Apr 2025 11:45:15 -0700 (PDT)
Message-ID: <6fb21077-c254-49a7-97fd-64c87322ea43@gmail.com>
Date: Wed, 2 Apr 2025 14:45:35 -0400
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 7/7] drm/virtio: implement userptr: add interval tree
To: Dmitry Osipenko <dmitry.osipenko@collabora.com>,
 "Huang, Honglei1" <Honglei1.Huang@amd.com>, David Airlie
 <airlied@redhat.com>, Gerd Hoffmann <kraxel@redhat.com>,
 Gurchetan Singh <gurchetansingh@chromium.org>, Chia-I Wu
 <olvaffe@gmail.com>, Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>,
 Simona Vetter <simona@ffwll.ch>, Rob Clark <robdclark@gmail.com>,
 Huang Rui <ray.huang@amd.com>
Cc: dri-devel@lists.freedesktop.org, virtualization@lists.linux.dev,
 linux-kernel@vger.kernel.org
References: <20250321080029.1715078-1-honglei1.huang@amd.com>
 <20250321080029.1715078-8-honglei1.huang@amd.com>
 <810789ec-c034-4bdd-961a-f49c67336e45@collabora.com>
 <6e796751-86f3-42e5-b0a6-3a3602d3af13@amd.com>
 <975582a3-313b-4989-aac2-c3b309ba55b6@collabora.com>
Content-Language: en-US
From: Demi Marie Obenour <demiobenour@gmail.com>
Autocrypt: addr=demiobenour@gmail.com; keydata=
 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
 +MYSfkEjBz0E8CLOcAw7JIwAaeBT
In-Reply-To: <975582a3-313b-4989-aac2-c3b309ba55b6@collabora.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 4/2/25 8:34 AM, Dmitry Osipenko wrote:
> On 4/2/25 04:53, Huang, Honglei1 wrote:
>>
>> On 2025/3/30 19:57, Dmitry Osipenko wrote:
>>> If the purpose of this feature is to dedup usrptr BOs of a the single
>>> process/application, can this can be done in userspace? 
> 
> I assume it can be done in userspace, don't see why it needs to be in
> kernel.

The kernel definitely does not need to be responsible for deduplication,
but is it safe to allow userspace to create overlapping BOs, especially
ones that are partially but not entirely overlapping?  If the userspace
libraries ~everyone will be using refuse to create such BOs, then
overlapping BOs will be tested by ~nobody, and untested kernel code is
a good place for security vulnerabilities to linger.

If there are no legitimate use-cases for overlapping BOs, I would treat
attempts to create them as an errors and return -EINVAL, indicating that
the userspace code attempting to create them is buggy.  Userspace can
deduplicate the BOs itself if necessary.  Of course, there need to be
tests for userspace attempting to create overlapping BOs, including
attempting to do so concurrently from multiple threads.

That said, probably the most important part is consistency with userptr
in other (non-virtio) drivers, such as Intel and AMD.  If they allow
overlapping userptr BOs, then virtio should too; if they do not, then
virtio should also forbid them.
-- 
Sincerely,
Demi Marie Obenour (she/her/hers)
