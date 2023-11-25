Received: from mail-pj1-f46.google.com (mail-pj1-f46.google.com [209.85.216.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7E0E0814
	for <virtualization@lists.linux.dev>; Sat, 25 Nov 2023 05:02:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Pe78GO57"
Received: by mail-pj1-f46.google.com with SMTP id 98e67ed59e1d1-28041176e77so1957008a91.0
        for <virtualization@lists.linux.dev>; Fri, 24 Nov 2023 21:02:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1700888522; x=1701493322; darn=lists.linux.dev;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=1zU4LUKVhSEBAEyImAqsIdHza582cUZbQQkgImwexMQ=;
        b=Pe78GO572Pe7cCKYQ3ro3+dU7vJl9+iDNkiA9VpWYr0OqVUmoNEi8CGtSGGxXDmQz4
         vvA0zBHIkhwTWyrn4Aw4UzpSMXtd/2yXFtRUfPeHbpPP3E9TOpI2vi5XK2TqceDCw5YV
         sCU4mZi7oVANYTP/it5xE3p1ZWGMy88/lZlDf3zmGueO4EdZr4XqqmaPdoEhVwZ+5VfV
         8iPC8q8ynsFAiurTx8NQgNKA+vRXjd8OyqB6vRNHjMoSX/QPKhqFsPTSUJxTOQ9cnTT2
         5yzYEuBK8dXYU6KwtF+PXmPwTH5FwVSBvQdTBlaYwNYb6T5k7CVR9w9S3tQsI5/NiEDh
         pzSQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1700888522; x=1701493322;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=1zU4LUKVhSEBAEyImAqsIdHza582cUZbQQkgImwexMQ=;
        b=Rl7YEIT5mxk/sHUsrK8Z5UZ977MbV5iDwRVWRRf8ma9gdVWkTfP0CWJ4JLEsgMK7Ac
         qtpaVuydoAABYsZXxPCRB27xYEOG4wqJE2KJadZQOdgPYDP6q2UNVWBW9rNetQZvzv76
         4ZChSGGB20NBF05+njiKFtjSd9OoqG/PNAQjfVTxkydpPFxcdCYazFDHq3Oh37sr96Rb
         jDEnrz8uvq59zA1bd3TcK6JeM1H/yijaY8zQ+BzgWbAOxL8Cqk58jA7b7bKzvNsoej0f
         0VVhAsD372rYBYJCFqwJILeo3W+30J+XSPgS6hi2SjN/HuXXHW5GE1BTMAqIQOHBnWZe
         l0fg==
X-Gm-Message-State: AOJu0YxHgml6DxesGbcEYxKzFc3rl24WwfucihM6aGzXEV3IrfiL8Geq
	dRKkRHh7jus+gzpz68Lvu+c=
X-Google-Smtp-Source: AGHT+IG1IDjtyfsrrILxO18zuVqQT7XqP8yMv76aZUE10M3VFt0iss8rhyKJKH/e41UIHwf3Slp0HQ==
X-Received: by 2002:a17:903:228c:b0:1cc:ec21:9a64 with SMTP id b12-20020a170903228c00b001ccec219a64mr5277780plh.17.1700888521800;
        Fri, 24 Nov 2023 21:02:01 -0800 (PST)
Received: from google.com ([2620:15c:9d:2:8b5c:82d0:578f:d0])
        by smtp.gmail.com with ESMTPSA id ba8-20020a170902720800b001c7443d0890sm4029794plb.102.2023.11.24.21.02.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 24 Nov 2023 21:02:01 -0800 (PST)
Date: Fri, 24 Nov 2023 21:01:58 -0800
From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
To: Alexey Makhalov <amakhalov@vmware.com>
Cc: linux-kernel@vger.kernel.org, virtualization@lists.linux.dev,
	hpa@zytor.com, x86@kernel.org, dave.hansen@linux.intel.co,
	bp@alien8.d, mingo@redhat.com, tglx@linutronix.de, zackr@vmware.com,
	timothym@vmware.com, dri-devel@lists.freedesktop.org,
	daniel@ffwll.ch, airlied@gmail.com, tzimmermann@suse.de,
	mripard@kernel.org, maarten.lankhorst@linux.intel.com,
	netdev@vger.kernel.org, richardcochran@gmail.com,
	linux-input@vger.kernel.org, linux-graphics-maintainer@vmware.com,
	pv-drivers@vmware.com, namit@vmware.com, akaher@vmware.com,
	jsipek@vmware.com
Subject: Re: [PATCH 4/6] input/vmmouse: Use vmware_hypercall API
Message-ID: <ZWF_xnotegtBElA5@google.com>
References: <20231122233058.185601-1-amakhalov@vmware.com>
 <20231122233058.185601-5-amakhalov@vmware.com>
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231122233058.185601-5-amakhalov@vmware.com>

On Wed, Nov 22, 2023 at 03:30:49PM -0800, Alexey Makhalov wrote:
> Switch from VMWARE_HYPERCALL macro to vmware_hypercall API.
> Eliminate arch specific code. No functional changes intended.
> 
> Signed-off-by: Alexey Makhalov <amakhalov@vmware.com>

Acked-by: Dmitry Torokhov <dmitry.torokhov@gmail.com>

Please feel free to merge with the rest of the series.

Thanks.

-- 
Dmitry
