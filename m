Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9FC932D6621
	for <virtualization@lists.linux.dev>; Fri, 19 Dec 2025 09:06:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766135184; cv=none; b=D/xLd+VTtRBhNcfH8LbYgeAYk8jl4rXE3MIRrqQLqM213NKh35e3exPoc/WPK2w1acQJZAaUA6JtTtKRA5XK+1pjwRkcRLqg7JP6ojJyGDsbAZbKcwOEILTncqau/9tn8FxGTuGnGVfHKxSBnD1xNKu2ugjvKp9ucl5Udg3sBeo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766135184; c=relaxed/simple;
	bh=Ya983u4axH6kjlKeYBWtPpboTZW33y5xeVr4MOP0TRA=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=mPGwDplzzdRV+QKF6tm/16KvCHA49xHxPntlDD5gVzcpS3vSeOAxDBSB9TeO5+Kp20sE7QkHq+t2/7Epf2j/BR2jFAJXLELaSIV25p/arW1CPOLEfKpG45yAJhQGSQ3sOX8CzRwBgwotuIkt/Nv5d0Xk++6Nke5dyPSyk4MV+MU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=DvoYspIx; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="DvoYspIx"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1766135181;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=uEJJ3ZBJInAIh15iKCZRVqfAs4YnUHwyNO2S/KWdSaM=;
	b=DvoYspIxx7whvLsOvRUlWLraKaTJf74XQZvts/1Q6/Z1gg8Lc470FRlHXPUJWNauZgPoUE
	v7M0xigBeW0muY5A7Fnzdy7m530lsjJdhSlQSuAy/wXf4hh3nbR3IYTyBOn9u/E3aqpOUz
	FFVz/gpjQjXknU3QBY28MAQt4uS729U=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-408-SrI2VAdHMhmeAk2ucECHew-1; Fri, 19 Dec 2025 04:06:20 -0500
X-MC-Unique: SrI2VAdHMhmeAk2ucECHew-1
X-Mimecast-MFC-AGG-ID: SrI2VAdHMhmeAk2ucECHew_1766135179
Received: by mail-wm1-f72.google.com with SMTP id 5b1f17b1804b1-4779d8fd4ecso8736445e9.1
        for <virtualization@lists.linux.dev>; Fri, 19 Dec 2025 01:06:19 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1766135179; x=1766739979;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=uEJJ3ZBJInAIh15iKCZRVqfAs4YnUHwyNO2S/KWdSaM=;
        b=jS6gS/PZtnZeLPPC8NvYROZ/roRNzpjJZtvcSP3rLcR8jdP0IiT7uFlzuYzBPv0/KL
         HUvHca0dEjKNfh9fpbLx64dVv1p7lO/vISHw0KSpbTjejhm9feUKtis9N401Ulgi7roR
         gosoIumm1sMqVR9hbA2joPmkwfEF7y+icKa0Sog1yG96FlmkqQO5hGMF3LwxVpDzoh3B
         ZuYIztBdN6nCLOx1KjWu9elGpwQolHXYIwesBSvy4l/JohFfsIbrztIPuZmhVlTB1cA5
         4BpaudFrL1RjKf6iSXLeBctXZ99niJ3y9+OyFPGkpT3mJUtAREJlPw6dVHTQIqzM+Q+e
         8TIg==
X-Gm-Message-State: AOJu0YyjYuon1IEXt3q+AeHqkZeRHjvyyByDpnLgPtG1rpfNk1VDBJiF
	QaQCMdAABN/XXU/s9KZg+C7aC7Ewr6FdBWuiyRNZGQsBwlj5U2bWlnsZ0MT8G5YRzRu+j+2lmJ1
	v5zgB8ksoxRyUnjAGYdiup+8LYg1jtg1Cf1+6a6vEDGsb4Ye9WWMGae6ODx6eyMJ4O4nd
X-Gm-Gg: AY/fxX7N7hBwFe8t3HCCXdw0Wq8Ryw5mQd7hqUX9W/A+T8R7kr31l7GfIj0Ac6IFZjq
	3yRWpIIRfydx9LV5XEKlWuS5EF+acUz5tFRzIkkIthpC75qthIuzOEyuaUEzx9/sYaIWSdWlzhT
	fpdb4cyjDVDE8kaA5nC0wAk0GL30+FImYd2nnP9lnVZGcbl9iKjpjDiMZGN96VxMgXwWLrsT944
	beXApS4+1o0yihPfcGjLfQNS6YZsfjMrAb03n9s18yurLUd0VpBz0q6YsjVVpYvo+VsxF+7tGJ5
	74wTTRcavp28rGXofWAZgpyIFdsu2m0Y+VWmEgdElKkZKC8j+UDf4f2E33e7aSPizBHgzEzVKc4
	8ejioNDd7+gBb
X-Received: by 2002:a05:600c:c493:b0:45d:5c71:769d with SMTP id 5b1f17b1804b1-47d18ba7befmr19461115e9.8.1766135178935;
        Fri, 19 Dec 2025 01:06:18 -0800 (PST)
X-Google-Smtp-Source: AGHT+IE7eioW6Xn+tnoEhKXG2yusHQOhJIOjn1R2GKM3dKlAw2syLOpgGZtPDJfLlzWKSUJFj636Ug==
X-Received: by 2002:a05:600c:c493:b0:45d:5c71:769d with SMTP id 5b1f17b1804b1-47d18ba7befmr19460835e9.8.1766135178533;
        Fri, 19 Dec 2025 01:06:18 -0800 (PST)
Received: from [192.168.88.32] ([216.128.11.227])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-47be3963fc3sm32985095e9.0.2025.12.19.01.06.17
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 19 Dec 2025 01:06:17 -0800 (PST)
Message-ID: <63de3a12-36bc-45bf-a3e5-89246f4ec73f@redhat.com>
Date: Fri, 19 Dec 2025 10:06:16 +0100
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next ] vdpa: fix caching attributes of MMIO regions by
 setting them explicitly
To: mst@redhat.com
Cc: virtualization@lists.linux.dev, eperezma@redhat.com, kvm@vger.kernel.org,
 jerinj@marvell.com, ndabilpuram@marvell.com, schalla@marvell.com,
 Kommula Shiva Shankar <kshankar@marvell.com>, netdev@vger.kernel.org,
 jasowang@redhat.com
References: <20251216175918.544641-1-kshankar@marvell.com>
From: Paolo Abeni <pabeni@redhat.com>
In-Reply-To: <20251216175918.544641-1-kshankar@marvell.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: oX7wcn2Q_yVCRAokUo195fSvewUoRQQoCAp-_bPdVL8_1766135179
X-Mimecast-Originator: redhat.com
Content-Language: en-US
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 12/16/25 6:59 PM, Kommula Shiva Shankar wrote:
> Explicitly set non-cached caching attributes for MMIO regions.
> Default write-back mode can cause CPU to cache device memory,
> causing invalid reads and unpredictable behavior.
> 
> Invalid read and write issues were observed on ARM64 when mapping the
> notification area to userspace via mmap.
> 
> Signed-off-by: Kommula Shiva Shankar <kshankar@marvell.com>

@Micheal: despite the net-next prefix, I assume this patch will go via
your tree, as it looks unrelated from networking.

Cheers,

Paolo

