Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 23C1517BCA
	for <virtualization@lists.linux.dev>; Mon, 29 Apr 2024 23:31:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714433489; cv=none; b=hOK4AkRGu0UHvzGHlgISrBvXkQ/cNI3KZTd2qrzazA5jGzDm8IQ0t5SHloabRNJYidu4pp8c67vbyFm3Qfze2yp956l101Xx+TI0fGey9qbhw8uQDfD07MJ2QT0UiNCI/IKA909TNQv8WIkKPXphw32dSFbCZFSi+wWrGg8FWWQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714433489; c=relaxed/simple;
	bh=uqj4V0skS+CEC8NZm0u8vNAfU7/jX2gON652FcP3oRc=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=ds5kMWcaH9O839jDoiVoHry/eba8c8hQsxSZmYE5Leyx8eDEOJeRB+5zfAT6CDPRq7eowxaYGly7FuOf4mxgbQny62PJYXN6ARm1D5TdTthGJQiqdjre6Pl5kDYj5STj8sLg+X6yG5E/+SHXrYsLuO3vG7tPSDjA6G/bq3BaRio=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=ZZDuVPCa; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="ZZDuVPCa"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1714433487;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=WSjdbinHyW1mkl/2RciXGi7LJcTI4CBgysLnfFPLy8s=;
	b=ZZDuVPCamYai0VSXX5SNQvK9kSVBFWDcwuwZM8l0Lk4pbghH677YkxQ/eT0hbP7BZCVAyr
	IZ9V4/OP6MWUeWcUtE+VCl+oTTuQuVVKWvpW+l9YQC4abjuhKE99dFUV3RM7Tf2xSqTUOz
	Vg1yP3mIoVmO/MkH7qWceqZSwBmie2M=
Received: from mail-pl1-f199.google.com (mail-pl1-f199.google.com
 [209.85.214.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-269-fsIf41fUMpSS0Qk5ETGsLA-1; Mon, 29 Apr 2024 19:31:25 -0400
X-MC-Unique: fsIf41fUMpSS0Qk5ETGsLA-1
Received: by mail-pl1-f199.google.com with SMTP id d9443c01a7336-1e2c0d3eadeso51937665ad.0
        for <virtualization@lists.linux.dev>; Mon, 29 Apr 2024 16:31:25 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1714433484; x=1715038284;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=WSjdbinHyW1mkl/2RciXGi7LJcTI4CBgysLnfFPLy8s=;
        b=Dj6sccl9AbCwYRpC9b1YLzwkGg6V/GjSbmgyFolGDe22IG15+Z1hnX4KpUWxu6kGdb
         5sQSUxKB6suIqyyUe12LauiGkrQAnxofINAaZf4VlYqQa0YHGX9DV5UaX9csAIcJ6Jmr
         /cGMV2+wc1hqjPSWkEXfWVMGu4pIf6O2nedd2pTIOuAmVD497wCLycVHzP6WhyfHM+yY
         Mw9DjxkR/2nRPW4DoNmwi0WX3LrB4w2tmoeMBUdUHWMG6lM/MAfCs1xzDljAbSO7xkua
         8z6ieb6CE+VhNVZFIafS5OLTALr1UUatzuyTGKe9BrOy3tLhJf2FvuKAaW11vau9zOVw
         4JZQ==
X-Gm-Message-State: AOJu0Yy4mUHWJcQYCcFVdLF0WwU3c1ginV9Xpks44q/tH59gL99Hl5dK
	6e7wflFX9+RJVC94SX9J7ovGNY//ASueIte/hFiCYuw7cMraDwtEqCOQFH6FGPSN2U7jNwb+RWj
	FPzRReBfL1rxySN+Y6zmUOA78eekzFnsVY1rbSUYAW+qIN9/cQmkb6yjK0agxdzGnv2+tFF9+
X-Received: by 2002:a17:903:2409:b0:1e9:a0ce:f618 with SMTP id e9-20020a170903240900b001e9a0cef618mr11564136plo.69.1714433484114;
        Mon, 29 Apr 2024 16:31:24 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IF3e9Pfy4WGNwSUUoxTKAPNsdqjkvEKIg+2mxHAdsBmatNV2ftHrHQ/ozCS3sFtSigko90WTQ==
X-Received: by 2002:a17:903:2409:b0:1e9:a0ce:f618 with SMTP id e9-20020a170903240900b001e9a0cef618mr11564121plo.69.1714433483816;
        Mon, 29 Apr 2024 16:31:23 -0700 (PDT)
Received: from [192.168.68.50] ([43.252.112.88])
        by smtp.gmail.com with ESMTPSA id u17-20020a17090341d100b001eb3d459143sm5443739ple.48.2024.04.29.16.31.21
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 29 Apr 2024 16:31:23 -0700 (PDT)
Message-ID: <4dbd2f9e-0769-4b9f-89af-d864f404c86a@redhat.com>
Date: Tue, 30 Apr 2024 09:31:18 +1000
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 0/4] vhost: Cleanup
To: "Michael S. Tsirkin" <mst@redhat.com>
Cc: virtualization@lists.linux.dev, linux-kernel@vger.kernel.org,
 jasowang@redhat.com, shan.gavin@gmail.com
References: <20240429101400.617007-1-gshan@redhat.com>
 <20240429144955-mutt-send-email-mst@kernel.org>
From: Gavin Shan <gshan@redhat.com>
In-Reply-To: <20240429144955-mutt-send-email-mst@kernel.org>
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Language: en-US
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 4/30/24 04:50, Michael S. Tsirkin wrote:
> On Mon, Apr 29, 2024 at 08:13:56PM +1000, Gavin Shan wrote:
>> This is suggested by Michael S. Tsirkin according to [1] and the goal
>> is to apply smp_rmb() inside vhost_get_avail_idx() if needed. With it,
>> the caller of the function needn't to worry about memory barriers. Since
>> we're here, other cleanups are also applied.
>>
>> [1] https://lore.kernel.org/virtualization/20240327155750-mutt-send-email-mst@kernel.org/
> 
> 
> Patch 1 makes some sense, gave some comments. Rest I think we should
> just drop.
> 

Sure, v3 has been sent with PATCH[v2 2/3/4] dropped. Please take a look
when you getting a chance.

v3: https://lore.kernel.org/virtualization/20240429232748.642356-1-gshan@redhat.com/T/#u

Thanks,
Gavin

