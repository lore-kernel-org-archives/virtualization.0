Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CDBDD15624D
	for <virtualization@lists.linux.dev>; Mon, 10 Feb 2025 11:14:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739186081; cv=none; b=JO0XOAGgAorZvJZYArQb7jTYe33unlasmGqbMk3Kg+Jg7mP/o+vNPmbeAvMXQ44aYkcKKYCejIthaClva/rhjt1GrRPjp6Lga2XdBe4TR3VLU1EXaMh5XNEwM0Zn5KqwLP1TIVHBzeTPAh9ujQbVsFjxACQrkBVVPGJSOeFW4K0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739186081; c=relaxed/simple;
	bh=etnoAPtfodu3j6OnVm6MbzL6CeTvVzZhtPqNGUr80Rc=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=r96r5tV8Zfjpyvy5KTMa5tsZmrcWC7Zg3ciaAGQ2MzeoLu2DY9209XSEnfN5DGIGx06IpzZk7aSuiIBLLKm7tSceWpasoI596QoSFjup4J6xSJXCy3tiRWe6UQ3Mf/2XYE+j1bzKLMIQVWoWqDi0NoCeyCDOBsw/uFj84Qm2Wvk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=U+fF5Mrc; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="U+fF5Mrc"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1739186078;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=G/KMdZICnl582Io+/HgvG4CL9bgg3ycPLDrs0NWni5g=;
	b=U+fF5MrcD9/057KOFhdSRTZnIGHDSIY0VWTXMLYgKAruD4qnU2GBJMpAGVK8qm62GKA6IK
	pYIKoj4FuiPV76CyOB7LO3n+b1mHuWvF/qoElWRPjSXkH18TTKS1mS/QSTVZ7ZxrLTK3TW
	Pvp0JaoMSYQkictpT8j1oLoXKNfq6/w=
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-148-Pa8FsYa7NaaRZ9Vh_2uWJQ-1; Mon, 10 Feb 2025 06:14:37 -0500
X-MC-Unique: Pa8FsYa7NaaRZ9Vh_2uWJQ-1
X-Mimecast-MFC-AGG-ID: Pa8FsYa7NaaRZ9Vh_2uWJQ
Received: by mail-wr1-f69.google.com with SMTP id ffacd0b85a97d-38dcd8ddc5eso1839238f8f.3
        for <virtualization@lists.linux.dev>; Mon, 10 Feb 2025 03:14:37 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1739186076; x=1739790876;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=G/KMdZICnl582Io+/HgvG4CL9bgg3ycPLDrs0NWni5g=;
        b=DDaqMqlCvj3cFGRUDy8zEMkF7VWx+iOQwbLZJyMLAVoI3Fvb7e6+Qbb4/gmcCpwfH7
         3EnVTESM3eBz2znEznwuMg5mATiDAQzBWYzqVWnf2Xq4ZXzsI5u4k9BHmi6g2lKraqvT
         FAO+EJaRWrbt7ylQ/Yu9xYvzRqPLM1qB5InZTDqT47EMwHwG6+p4yeE94lJkc6h6IQi0
         XxlxYCSrSLxDo/3v4PZkywnJDnHloxH948mDRU+sQvM/APFavYml0OPr7uDi8YXbqezv
         7c+QazSNK4G2TGyEi4AAYsZo8tK4Y3M9AqeCm26t8orgYwY9L5LXQjR3ss3MPl5KXJ1B
         3Jdg==
X-Gm-Message-State: AOJu0YwB+jT4RfNaB5e+yrzAvAegVKpMIJLEYBg7sElOW3Ty8/B0g202
	YFr7Zd92uA47XuPRMvY4fOHVHyKZS+dNiwtl3VC4SD21WgMuzNu1GXbD2qMl/J71mv0E968lu4a
	6A5w8Uk6gqF/u5Qf+vSs1fcXEesIH6LYJjn7+hkcivW8HXfyZmamGPNgnXV993GNX
X-Gm-Gg: ASbGncvXiev/zOnmUVU/RX0VZRm0D4wyW+1T/lGaPt9ha4YiB2Bo0/FCucZTVhjrwU+
	1dHxQaOU8+sqavju9Yk0mMj7hOFwpiqiukpfbiXZrEeXEcoFFCDJry17GSTp7GGzMaV085lgaFz
	V/Drrub5pNHXmdTzfC+2cH3ZVLonLCe52wKQIEObgVAqcJARgn3FjrA+7yvBD1q+x3VhD8QRIuF
	cACIMZV7dUNiksVzEjBWFP1bgULpgzR0qTpbfx5jnntGG8qdJmueebLl/FYNe6/Lq6mydnLV9im
	LLWxegyz6A+7VRU+o1sZ++mBovaNrDHzHG05ygrG3HE7
X-Received: by 2002:a05:6000:1448:b0:38d:af2e:d5c3 with SMTP id ffacd0b85a97d-38dc8dd1864mr9217940f8f.17.1739186076219;
        Mon, 10 Feb 2025 03:14:36 -0800 (PST)
X-Google-Smtp-Source: AGHT+IGo6CfURy22Wovwne0UJ4k3nKGVnkr/wgeTUUI2em35sZPS2GM9P0+LoW8IoS7CA0xajZHCog==
X-Received: by 2002:a05:6000:1448:b0:38d:af2e:d5c3 with SMTP id ffacd0b85a97d-38dc8dd1864mr9217915f8f.17.1739186075845;
        Mon, 10 Feb 2025 03:14:35 -0800 (PST)
Received: from ?IPV6:2a01:e0a:c:37e0:ced3:55bd:f454:e722? ([2a01:e0a:c:37e0:ced3:55bd:f454:e722])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-43935c4f4aasm70175115e9.22.2025.02.10.03.14.34
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 10 Feb 2025 03:14:35 -0800 (PST)
Message-ID: <3c0e06d4-b5b7-45cf-bc42-8f12b293b7da@redhat.com>
Date: Mon, 10 Feb 2025 12:14:33 +0100
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v7] drm/virtio: Add drm_panic support
To: Dmitry Osipenko <dmitry.osipenko@collabora.com>,
 Ryosuke Yasuoka <ryasuoka@redhat.com>, airlied@redhat.com,
 kraxel@redhat.com, gurchetansingh@chromium.org, olvaffe@gmail.com,
 maarten.lankhorst@linux.intel.com, mripard@kernel.org, tzimmermann@suse.de,
 daniel@ffwll.ch
Cc: virtualization@lists.linux.dev, linux-kernel@vger.kernel.org,
 dri-devel@lists.freedesktop.org
References: <20250206104300.416014-1-ryasuoka@redhat.com>
 <d8a453e9-c8ce-4a7d-8fb9-08a13c44d7f3@collabora.com>
From: Jocelyn Falempe <jfalempe@redhat.com>
In-Reply-To: <d8a453e9-c8ce-4a7d-8fb9-08a13c44d7f3@collabora.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: PceTfG1BHA7w3Vz7_AvT82n70itLKaxjCcOJH5Glz_M_1739186076
X-Mimecast-Originator: redhat.com
Content-Language: en-US, fr
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 09/02/2025 18:45, Dmitry Osipenko wrote:
> On 2/6/25 13:42, Ryosuke Yasuoka wrote:
>> Virtio gpu supports the drm_panic module, which displays a message to
>> the screen when a kernel panic occurs. It is supported where it has
>> vmapped shmem BO.
>>
>> Signed-off-by: Jocelyn Falempe <jfalempe@redhat.com>
>> Signed-off-by: Ryosuke Yasuoka <ryasuoka@redhat.com>
>> ---
> 
> Applied to misc-next, thanks!
> 
> I've tested v7 with a different capsets, works well. For a non-VT FB the
> vmap indeed will be needed. Looking forward to the atomic vmap support.
> The rough idea of the atomic vmap helper is to make vmap code paths fail
> whenever hitting path that needs to sleep. Likely will be easy to implement.
> 

Thanks for your support.

I will see if we can do something for atomic vmap support for shmem.

Best regards,

-- 

Jocelyn

