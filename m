Received: from mail-pf1-f172.google.com (mail-pf1-f172.google.com [209.85.210.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ADB1517730
	for <virtualization@lists.linux.dev>; Mon, 15 Jan 2024 16:34:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kernel.dk
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b="20JcHDQK"
Received: by mail-pf1-f172.google.com with SMTP id d2e1a72fcca58-6db1bbfe67cso508391b3a.1
        for <virtualization@lists.linux.dev>; Mon, 15 Jan 2024 08:34:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20230601.gappssmtp.com; s=20230601; t=1705336455; x=1705941255; darn=lists.linux.dev;
        h=content-transfer-encoding:in-reply-to:from:references:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=j6THmBHKwr126QpcBLJNhEIM800qyv4bqH84HI2YM/E=;
        b=20JcHDQKpP5r/G0JvR9g4Ud9QDar9hKHgSMvFADGULLzpGHNaZJkOycwQG/7DvPKch
         nFRMnlpF3k43qudKNPUq3VNJWoK1jEi77hP2B8UwvRu3eqttn6iuNi3spW9cUBFjf+7N
         ZDeT+p8720tBItCQ3dbzY/5OSfCE1isYEvHI9fZ8MbSBiR5zsuXECB82Xa6Ct9u8ceA7
         zycl5cpK6QMt9murIAlag25As+iS1GME41o0RPYBN0Hd6yMceDlZE8asDZtvnkFQRmuw
         p6d/MJJxPsqBgdckjWPn57usoEtCkJzRftJR8+SPF99Wg24GuI6SRYDYqQ6RiAyOb0rR
         w8mA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1705336455; x=1705941255;
        h=content-transfer-encoding:in-reply-to:from:references:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=j6THmBHKwr126QpcBLJNhEIM800qyv4bqH84HI2YM/E=;
        b=Ww3wGX1IRSoHIIgxzUXUeCL/qNTyR585wtGHAI3F+3FF6lemX9WUrDxGKHwGWvcwhf
         AuTripm6URn9mxOtlFv+BZasDWwH9gGZHDLa8DCJt3aMQ83GnT3A5w+oNT9P/zufJuSA
         a/T4DE3qU1fHqNF9Hudx088bmjUC5UnVzWXBSX4wudzxxw6WADFfSKQtKKvA4LKPmbHW
         aMO6N959tw9W2ztYfT2+F1bXfjloUPyw1wN+MHSnz+VIiuPMK9tSo5sPIcmUFcrg/BgP
         H3y0sna5T/oJxmUFY6Ly59Vadl1QDH59SUfHvSNQ0PjmUj4Li9J+kqejQCqS79K015zz
         ZWAQ==
X-Gm-Message-State: AOJu0Yzs1tAmd64Y9SMo20mF9NLm2OOhLBi/vaZ1U6ovysmAviId/EVH
	XjmIcYxqhZHniCoXsKIiuT5eIDS5roO+MQ==
X-Google-Smtp-Source: AGHT+IHeq3Qnc8h9xWosZ889FmAVEveTjcqj9NBtjDjHjQCTYmQVZo+EQfiakYqaI5/nv0/MnetTPg==
X-Received: by 2002:a05:6a00:4b45:b0:6d7:e74b:a517 with SMTP id kr5-20020a056a004b4500b006d7e74ba517mr12945631pfb.3.1705336455055;
        Mon, 15 Jan 2024 08:34:15 -0800 (PST)
Received: from [192.168.1.150] ([198.8.77.194])
        by smtp.gmail.com with ESMTPSA id q26-20020a62ae1a000000b006d98ae070c3sm7752343pff.135.2024.01.15.08.34.13
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 15 Jan 2024 08:34:14 -0800 (PST)
Message-ID: <76ce2a94-5c55-45f4-b554-bd58ad10a2a7@kernel.dk>
Date: Mon, 15 Jan 2024 09:34:13 -0700
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] virtio_blk: remove duplicate check if queue is broken in
 virtblk_done
Content-Language: en-US
To: Li RongQing <lirongqing@baidu.com>, virtualization@lists.linux.dev,
 mst@redhat.com, jasowang@redhat.com, xuanzhuo@linux.alibaba.com,
 pbonzini@redhat.com, stefanha@redhat.com
References: <20240113040947.47354-1-lirongqing@baidu.com>
From: Jens Axboe <axboe@kernel.dk>
In-Reply-To: <20240113040947.47354-1-lirongqing@baidu.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 1/12/24 9:09 PM, Li RongQing wrote:
> virtqueue_enable_cb() will call virtqueue_poll() which will check if
> queue is broken at beginning, so remove the virtqueue_is_broken() call

Applied, thanks.

-- 
Jens Axboe


