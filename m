Received: from mail-pz2-f38.google.com (mail-pz2-f38.google.com [74.125.228.38])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1F73937E2E4
	for <virtualization@lists.linux.dev>; Thu,  1 Oct 2026 06:49:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.228.38
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790837391; cv=none; b=idn5ZXnfPzQWoq3c9HGKkdUxyz4BueBGqsWV66eOonr1t/kEtl2K2BaLiEpFN857ByLYbeoPCPtJJCgEJQg0SO6tsSDnXvA3Ql/s+XaVoDFW8XQkX39DRrsNm3nFvmLa7x6zXtB1++aYfubAqDwFLulCgTLgo/gslWpHDuHgx+Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790837391; c=relaxed/simple;
	bh=kI4MqRXoz9tUKHuNpyi6hMIAkrKO5Y85UDsjot8YWRA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=E2pYqCNAMufACDGSXo8S/an8CFwiXPc0K0n1STMhCXHDPkeJKnZo3TmwnjsqPp9VDWcK3yIN2cQAEOCxuYAZ3WmjBaqYElArbl4FlNGcQ8Pofm7Ha7vuajv23dpAYl8HNBUSkr2gQetR5MyzicTF4MMvk/wBaOhQPBFotQNZsLo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=MtTm0v0U; arc=none smtp.client-ip=74.125.228.38
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="MtTm0v0U"
Received: by mail-pz2-f38.google.com with SMTP id d2e1a72fcca58-882c2bcef77so2976141b3a.3
        for <virtualization@lists.linux.dev>; Wed, 30 Sep 2026 23:49:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1790837389; x=1791442189; darn=lists.linux.dev;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=sqjFwTItW9Z6VE94NesB4AWUO0LgcGbOQzM8AGhhbUo=;
        b=MtTm0v0UZWZaa5V9hhPES4YynzKdfiKLjBq/UjIfFh7l0Bv3ArI6v/eYMAkS5mtVTP
         B++W4mqZMKD2FVTSA2kEZIdN6nQML++iMmA3zKJxqdPwKWSh6dmZgmdnXGCwl7ZDHamu
         blVdOrhUxqPfdUyA5lfCOuy4xfA0EgQKa6C8hFXBxup4dVUwoUnJFeXix6DXlNfSX53Q
         +/uycnsCGdZJ2I7xfWVNSAVbkZnFyLUgNpduChdmKHnCRJMmm7jMa7sm8SsZ0KMoWfm2
         grGtRAwNT8NTntkdKMTdMVMsSEjSEmzz8y5uaq9U8KKz0CD/MXM1pwMGTcGI0ZPVTq6u
         VBzg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790837389; x=1791442189;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=sqjFwTItW9Z6VE94NesB4AWUO0LgcGbOQzM8AGhhbUo=;
        b=0LGliC31mOKfZTQg0y6YQolRXKkU2bf6Pod6pJ8T42vELe+Ji8Xga4aPl6vUWRwOcx
         C3zvq4JHr1sNiVgoWidKvniROVEHGGMkM8a3Ob286oc4CRaIPBcdaMAbHtMNnEr2LcG4
         C0aEt8VHCz2Mq3epjZjiOrX8mb0KMP+UiqkCayuoAB6T/ZTgE5DurBy5BxQT2HgYq9JE
         lJa2TwsNVRhuyPY4LYMyaAI4kCKkGOtgR4pJNEoGTpo7nfhRuHBVBl7I84EFv9fAiMRA
         9w8nujJJnJ5Sr+EmiRLxJom3nwrBscxqwgklU8RxlPHTOv9bw7a2JETFo00GYGJ8aLiG
         jZWg==
X-Forwarded-Encrypted: i=1; AKwUvBw8RXlCeDULS01xlDexCWvEoXXDpO+nrdEKEXAHC3GLeYTDWxc7FT6h1fbm3JmeuXKXT3Q4bZBclEMMxGJaPQ==@lists.linux.dev
X-Gm-Message-State: AFuF++lX5ogIKBUn8KxCHSKt64O6e/7uUpKx8r5d8tmnCGDTxOFXWT/a
	qx13iav5sI1WYGYxn9VNdTX2vXLxxvNA/rHLNpxOrap9uNv6f7QeSAGuXjLclrlOvqY=
X-Gm-Gg: AYBFou0F18t124WW8Z5LXdKfuKjBfvm85onxdZIgbADAR4K6tqSwqsmDuIvrdyg5TVn
	sWzLXx3sc4btKLJ/obGi5cD8csoB7Z4aX8fEaOClr1ET1z2P/l8e8/DW/T8wd9QtufUEfz1BUGB
	Y1B9jYfst+BXrhdmunC2CBNgPfwNCNwl4Fmw31wQFrHTna/3fIyEFJD17ewWd6lD6aGZup1dAhl
	4VIs3pC5NnTCs+2lIqTEb6xNlwEeZlfuGeqQ+ZMQKe10c5sqsR2F5KV59yU0kZMGegXwPzg0Zqf
	xXzGu2kbyJbv0C3Dt+soV0vX6cEl9pDrqrVWysKChs5/UVgPW4k4eB/tMOJs46MuvJM+sXwNFfX
	pmoxKqUyxuEwzN3KXwGh4Qyx3TELRr8MLJVtOGyDTPZHBtB4LiY0nTdo/GQkk8tZT+uSOq4UrCm
	Fu6ZPhbViLiiefymqywZ3ox05Ho47MjV0WecZHinKPYCoxV7LX9i+6/XKyc99IUJurw5Tqhme/
X-Received: by 2002:a05:6a00:aa85:b0:880:6b49:2044 with SMTP id d2e1a72fcca58-8874c8d5a3dmr3078678b3a.38.1790837389439;
        Wed, 30 Sep 2026 23:49:49 -0700 (PDT)
Received: from localhost ([122.172.87.224])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-8886b1ccef0sm387165b3a.23.2026.09.30.23.49.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 30 Sep 2026 23:49:48 -0700 (PDT)
Date: Thu, 1 Oct 2026 12:19:45 +0530
From: Viresh Kumar <viresh.kumar@linaro.org>
To: Andi Shyti <andi.shyti@kernel.org>,
	Guangshuo Li <lgs201920130244@gmail.com>,
	Gavin Li <gavin.li@samsara.com>
Cc: "Michael S. Tsirkin" <mst@redhat.com>,
	Yuho Choi <oss.patchbox@gmail.com>,
	"Chen, Jian Jun" <jian.jun.chen@intel.com>,
	Vincent Whitchurch <vincent.whitchurch@axis.com>,
	linux-i2c@vger.kernel.org, virtualization@lists.linux.dev,
	linux-kernel@vger.kernel.org, stable@vger.kernel.org
Subject: Re: [PATCH v1] Revert "i2c: virtio: Avoid hang by using
 interruptible completion wait"
Message-ID: <ar4CiZZK4igx4Any@vireshk-B250M-D3H>
References: <20260922050251.403857-1-oss.patchbox@gmail.com>
 <20260922011619-mutt-send-email-mst@kernel.org>
 <arWHzKEfy6HKMZr1@zenone.zhora.eu>
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <arWHzKEfy6HKMZr1@zenone.zhora.eu>

On 24-09-26, 22:28, Andi Shyti wrote:
> Viresh, can I have a comment from you here, please?

This was discussed earlier as well, can you have a look at this thread too ?

https://lore.kernel.org/all/yaeiwzxxh42y3oxiro5uxaxbvralwqxweb6cx4vzwx4y7nards@cysus3gbvple/

-- 
viresh
