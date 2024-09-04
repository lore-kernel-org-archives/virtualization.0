Received: from mail-ot1-f46.google.com (mail-ot1-f46.google.com [209.85.210.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BC1BA1DB957
	for <virtualization@lists.linux.dev>; Wed,  4 Sep 2024 14:17:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725459457; cv=none; b=JpdJTJMWHK+PVDFEqfeZAwWGXo/4hscTJyQ3W/cTEChoDlQ/7x1dybOSsbZv3vkPXcNw4ZrQ/LAe4KMrFtOdvQq6Zp1CVqDg1ZI3tW8wakQDRWC/MrrgAt0BO8x65GfdQLs7hGoeyxHKXwzin0atQUxj5oTV0RVTjEc2huUp5Ks=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725459457; c=relaxed/simple;
	bh=YpWYjehxqSoX1O2diBW3rQ+5LlYEhl8sX1+bGP7Buqg=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=VjevwuWdQNNeyE74vaNkw78CL4ToAfG9KbQRgtsJe8IaEK6Ljd54Rpql1aH7fqFTg9QdTWaz/5sSATgcq6qpA8yHfku0CPCZFo1bNvRPnYB9E66gnlWpPieuthdVaKSiqPZwwDZzrKdQ+V4n64zt2PIOC4ybjlOu6Xk5oEAqopI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=digitalocean.com; spf=pass smtp.mailfrom=digitalocean.com; dkim=pass (1024-bit key) header.d=digitalocean.com header.i=@digitalocean.com header.b=KSYgT3cQ; arc=none smtp.client-ip=209.85.210.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=digitalocean.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=digitalocean.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=digitalocean.com header.i=@digitalocean.com header.b="KSYgT3cQ"
Received: by mail-ot1-f46.google.com with SMTP id 46e09a7af769-7092dd03223so2221847a34.1
        for <virtualization@lists.linux.dev>; Wed, 04 Sep 2024 07:17:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=digitalocean.com; s=google; t=1725459455; x=1726064255; darn=lists.linux.dev;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=YpWYjehxqSoX1O2diBW3rQ+5LlYEhl8sX1+bGP7Buqg=;
        b=KSYgT3cQSFk4BrCCAHh5dRX1vCjhY0J902XpXaKjTW4+HKUkejJCavUuTBBcLXcBb4
         CE1QyHB/huZKVp9RAXktfb2YVbtIgCYr6FmV1hrfX+Thsd8pPgGugUfDD+oc29jQOGc8
         HhFv1YKuGTVlDePSwPmzHEUAKIil9RSXT2ckM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1725459455; x=1726064255;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=YpWYjehxqSoX1O2diBW3rQ+5LlYEhl8sX1+bGP7Buqg=;
        b=lfbvChTWxbshrTeprAJZ33XABi5nVx0jpwMqRzdfBjvlUcY1La+tH0ku8NRpzPjyd4
         TNzmcoIZQwPPa5qeW8xbMrsVXGODAl9Xx5Ido9trO9Bk/+KX3XprWSvQkHNMQnmC3Ey0
         VDUJRNk0OZjvOoqxCSWq1RmdFtsnJs8kDeMlri9q3juc++LlOgZ3gWe5gPrxcDXGcKMu
         cIrPJH/ie4IqI4ygo45Qq79QGuGDsfdc744XHAJ8FQ6Qash1PqXH9pl49vaogseWqb2+
         fpM3Fftkkr+1aS0ba6qthUsDoTpsXXH0kmtcD/J/CR4PSc4rFjglT7dwfmgeTGWRytED
         CRfQ==
X-Forwarded-Encrypted: i=1; AJvYcCWXKHkUOwgvMdzNn0Fju1LsqyWMWJEzggj/0s74NJUN4vQLEE5hdAhnnC0eBZ9U5b7IbGEl3q9QTDe62XPLpg==@lists.linux.dev
X-Gm-Message-State: AOJu0YzYc/sXXjfqX7TA2LB1WVpaJstezPNNuWQ22jY+k58TrOnH6J0z
	V6Qua6kDP+Tl19Cndsm8BBbvvYfZoSP3iwkEwhUlbEnTKt5bBzHWs9g35ICfTHE=
X-Google-Smtp-Source: AGHT+IFwP+H+wYQzxGErCD9EQq5D9dyUypa2eD8A/emS3WXcZs6w9iPVclsGE4DXjzqy2S34HJ0W7g==
X-Received: by 2002:a05:6830:438b:b0:709:415b:8ab8 with SMTP id 46e09a7af769-70f706e25a3mr16758972a34.2.1725459454651;
        Wed, 04 Sep 2024 07:17:34 -0700 (PDT)
Received: from ?IPV6:2603:8080:7400:36da:9198:79cc:8e64:e479? ([2603:8080:7400:36da:9198:79cc:8e64:e479])
        by smtp.gmail.com with ESMTPSA id 46e09a7af769-70f7781ca5dsm2028225a34.18.2024.09.04.07.17.33
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 04 Sep 2024 07:17:34 -0700 (PDT)
Message-ID: <c2d0df0d-85ae-4605-ac37-71794105f3cd@digitalocean.com>
Date: Wed, 4 Sep 2024 09:17:33 -0500
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 2/2] vdpa: Remove ioctl VHOST_VDPA_SET_CONFIG per spec
 compliance
To: Dragos Tatulea <dtatulea@nvidia.com>, Jason Wang <jasowang@redhat.com>,
 Carlos Bilbao <carlos.bilbao.osdev@gmail.com>
Cc: mst@redhat.com, shannon.nelson@amd.com, sashal@kernel.org,
 alvaro.karsz@solid-run.com, christophe.jaillet@wanadoo.fr,
 steven.sistare@oracle.com, bilbao@vt.edu, xuanzhuo@linux.alibaba.com,
 johnah.palmer@oracle.com, eperezma@redhat.com, cratiu@nvidia.com,
 virtualization@lists.linux.dev, linux-kernel@vger.kernel.org
References: <20240903171514.201569-1-carlos.bilbao.osdev@gmail.com>
 <20240903171514.201569-3-carlos.bilbao.osdev@gmail.com>
 <CACGkMEvHU0VnOEZbVnEr1SvmOF5PhMtKk=M2o7Wwq-DUO9p7Uw@mail.gmail.com>
 <faafc28a-23a9-4dff-8223-1c72acb42443@nvidia.com>
Content-Language: en-US
From: Carlos Bilbao <cbilbao@digitalocean.com>
In-Reply-To: <faafc28a-23a9-4dff-8223-1c72acb42443@nvidia.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Hello,

On 9/4/24 12:58 AM, Dragos Tatulea wrote:
>
> On 04.09.24 05:38, Jason Wang wrote:
>> On Wed, Sep 4, 2024 at 1:15 AM Carlos Bilbao
>> <carlos.bilbao.osdev@gmail.com> wrote:
>>> From: Carlos Bilbao <cbilbao@digitalocean.com>
>>>
>>> Remove invalid ioctl VHOST_VDPA_SET_CONFIG and all its implementations
>>> with vdpa_config_ops->set_config(). This is needed per virtio spec
>>> requirements; virtio-spec v3.1 Sec 5.1.4 states that "All of the device
>>> configuration fields are read-only for the driver."
>>>
>>> Signed-off-by: Carlos Bilbao <cbilbao@digitalocean.com>
>> Note that only the config space of the modern device is read only. So
>> it should be fine to remove vp_vdpa which only works for modern
>> devices.
> Just out of curiosity: how will this work for devices that are not
> v1.3 compliant but are v1.2 compliant? Or is this true of all devices
> except eni?
>
> Thanks,
> Dragos
>> And for eni, it is a legacy only device, so we should not move the
>> set_config there.


Understood. I'll keep the ENI as is for v3 and will reach out to the maintainers.


>>
>> For the rest, we need the acks for those maintainers.


Thanks, Carlos


>>
>> Thanks
>>
