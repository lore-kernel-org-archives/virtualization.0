Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 56C571E9B12
	for <virtualization@lists.linux.dev>; Tue, 13 May 2025 08:46:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747126003; cv=none; b=CAPcjpwnfDEEuVPNVMkDgZo8DZkRGRy9oKM4paxJpjBtPwuLi0bpEasky+JRMLo4decgGawS3UNh9fTFy6/KobOtl7XcJr+TSE4Cl9t1GzLpHtL2m3NgG6fm8LPX8mXQbF8xAbZiDqoQ598EBtDfWR7UKZBbXb1M+Xu/aEtwlA0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747126003; c=relaxed/simple;
	bh=0GuB8YSQVYr0KabdMIst+G/9Rpiw1lRZH38yOGphJQA=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=nIHOQe6+1HMC+w7AFdz35HJ/FxyfiLZx+3LJZIYW6IqGRrwK/I2EJkqTxeDcTj2W3oCPUeYdEjnqWcws6d0TqbR0gfXVNEYBetOH5n4WZGJOxDmfeQ4ItsZiGVfArXeMlI69yHP3L3EwL7vAwO3jcRxRSnElHDfZXDk5Xcnr85A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=BxAavT39; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="BxAavT39"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1747126001;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=D8xs4ZKnWv12yh+gYHNpynmUdUuOUulNWlTmGaOn+wA=;
	b=BxAavT39c2R0cAbBz1LA6Bv4vwX2JPL0IyWYgqHb7cF2s/NFSTXLnVR17bFqeTZun49J/f
	/P6V7Fa4c9rsACahYaEEUwH8QuOb45cjnN/6NrM4QhtA7mKhD0NLlzVBPXNJuOT6xYxhz0
	YJw359PoukxPcXKnjTQdREl9wTTuct8=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-674-Q-6wwjFjM5ywug-8y3LZ6g-1; Tue, 13 May 2025 04:46:39 -0400
X-MC-Unique: Q-6wwjFjM5ywug-8y3LZ6g-1
X-Mimecast-MFC-AGG-ID: Q-6wwjFjM5ywug-8y3LZ6g_1747125997
Received: by mail-wm1-f69.google.com with SMTP id 5b1f17b1804b1-43cec217977so26573765e9.0
        for <virtualization@lists.linux.dev>; Tue, 13 May 2025 01:46:38 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1747125997; x=1747730797;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=D8xs4ZKnWv12yh+gYHNpynmUdUuOUulNWlTmGaOn+wA=;
        b=iUxWuzNo8JzjODBfwweWh0O+TG2m1BMQM25MW4pxYkOO76Nn+dM3bQjdecoAxNUaQs
         Hy+nW1Cs9Y6yc0rS/eJVui+pLQA2uoZZZv7VX8yTdCWvBaVgzrYRrJ1jdj3auUL+OUno
         kp4Lwvts0GE9GbJk/k/dXz26/iGfcxlUoNlvSer1jeIUEI7QNks4hglQ1c0JMlvxfebG
         tywIZHfBmu7PigROER6O3ZedSFwQTDRHpnbjuVmuVeOjY9qfwKT/S2hrYAg98NcTzNQI
         wLdPE/2DPybG65Mb6CFkf+fLGh3VrRtO3yyKZ/0kmY3Gzfynsb2ojhIEpjD45qbkrgBq
         LsDg==
X-Gm-Message-State: AOJu0YxtMVsSruwSU0yv6+kCVk23QZRJnPQTHGm30mMSNHAXX9tgfU8f
	/46dhkeYG/QDbeSBIRMfmDvlT5pDyi844USOBiiENBPYW/rwjnc3jzCetdx/BVVezRjwBZylWo4
	7+KL3lUC+YLSfNgCY6A0ho4jVyjU9x0kXdEHLrAjRb/q6Lb4C2lbBh9HPbihS3PGJ
X-Gm-Gg: ASbGncvDpE3h0dradoPVuHT0WFDIAlj1qpF+dmPlJGlkR34XndwQKW/mnMKCrPo7d5v
	JZce0cYx+vVCAO82Iu0CB1tOa9Ff8jCMWVdThxSuN3G27cRqWNy+mHJkVARGCOyRjvU5gjp5Uxq
	9e88RQ7bbpAi/t8Fxph5ZcTiYQ0RBPlFHliUrJRMz/hHwmb3/aghvu2IejLE9jIT6iZWJ1npieG
	Qeeh9Rbw+Y3hS6D0+XoY7PnJIzign593+vFnZjQSqkQStb7J0Gs9XuqaiObi3MHurqOfQ7q33BH
	nh/k+u0Ez3l++BzFSSo=
X-Received: by 2002:a05:6000:240d:b0:3a2:3b9:5c97 with SMTP id ffacd0b85a97d-3a203b95dfcmr6727883f8f.10.1747125997352;
        Tue, 13 May 2025 01:46:37 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGDSttFe6Jwez3R7wkedD9iVeYiW0wRrmLZ9nP6Bo/A7PDTZwr6SDdFpC1d8B773hGd0wePnw==
X-Received: by 2002:a05:6000:240d:b0:3a2:3b9:5c97 with SMTP id ffacd0b85a97d-3a203b95dfcmr6727864f8f.10.1747125996972;
        Tue, 13 May 2025 01:46:36 -0700 (PDT)
Received: from ?IPV6:2a0d:3341:cc59:6510::f39? ([2a0d:3341:cc59:6510::f39])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3a1f5a4c804sm15585138f8f.95.2025.05.13.01.46.36
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 13 May 2025 01:46:36 -0700 (PDT)
Message-ID: <2d2a92d2-1844-49de-a869-4caf2677b099@redhat.com>
Date: Tue, 13 May 2025 10:46:35 +0200
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net v2] vsock/test: Fix occasional failure in SIOCOUTQ
 tests
To: Konstantin Shkolnyy <kshk@linux.ibm.com>, sgarzare@redhat.com
Cc: virtualization@lists.linux.dev, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org, mjrosato@linux.ibm.com
References: <20250507151456.2577061-1-kshk@linux.ibm.com>
From: Paolo Abeni <pabeni@redhat.com>
In-Reply-To: <20250507151456.2577061-1-kshk@linux.ibm.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: 46qRfSp-KyXrGSC3vg-NaDp3oFjOf31phoqQtx8oGcg_1747125997
X-Mimecast-Originator: redhat.com
Content-Language: en-US
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 5/7/25 5:14 PM, Konstantin Shkolnyy wrote:
> These tests:
>     "SOCK_STREAM ioctl(SIOCOUTQ) 0 unsent bytes"
>     "SOCK_SEQPACKET ioctl(SIOCOUTQ) 0 unsent bytes"
> output: "Unexpected 'SIOCOUTQ' value, expected 0, got 64 (CLIENT)".
> 
> They test that the SIOCOUTQ ioctl reports 0 unsent bytes after the data
> have been received by the other side. However, sometimes there is a delay
> in updating this "unsent bytes" counter, and the test fails even though
> the counter properly goes to 0 several milliseconds later.
> 
> The delay occurs in the kernel because the used buffer notification
> callback virtio_vsock_tx_done(), called upon receipt of the data by the
> other side, doesn't update the counter itself. It delegates that to
> a kernel thread (via vsock->tx_work). Sometimes that thread is delayed
> more than the test expects.
> 
> Change the test to poll SIOCOUTQ until it returns 0 or a timeout occurs.
> 
> Signed-off-by: Konstantin Shkolnyy <kshk@linux.ibm.com>

Could you please provide a suitable fixes tag?

No need to repost, just reply here.

Thanks!

Paolo

