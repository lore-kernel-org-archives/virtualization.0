Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 71F38346AD7
	for <virtualization@lists.linux.dev>; Wed, 15 Apr 2026 10:42:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776249751; cv=none; b=p7QQx6u2YOCEljOAHoS77xbFR2OvyYSof4H7Yav+dB8Q0ZMYSGvDSYUc1VjzadttoGiHFOM22wUSZezoCoiIHmG/8xQ1FlfXqDHNeTpAFQ1hj2ne2Ly2R1rMtcGIwA+RyMlN9zFKgyd4Ag0+0plOjF5InqmSA7acGP51kCDVDIQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776249751; c=relaxed/simple;
	bh=Z8ZM7RZK8ybTCU1uHBOlcPD8CQy1Evp7Q8nKaT8TGXk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 In-Reply-To:Content-Type:Content-Disposition; b=gJlq4IOcL1idljHFOJjwFoVNiK+W43j9cj46q8CVJytoLbULTJxNt9JwXudK+E5FRm2zMeSD3ZDc01DdmWAidw7TRaESRTf+64bfBbxBQdmrFsfHPSCzqHY9QSeN27JlBL/aSEJ6IvO0RCCwXO3N/j9opOGzrt381gdwEROEQM4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=Rw8a4YiL; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Rw8a4YiL"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1776249749;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=S5Es++6jZY8aKLtLSfo9uIdq7eeB6041SLW/QpiJsjA=;
	b=Rw8a4YiL3pv/2sSexo+JrzTJ3KJ25llUedGxMr8Ph8Bw5TpEXud1Hgn8wXxRQlFVseCquz
	xWNZjWy2twLKniDQxWX+yQP4UY6kKNM5cEDEQmZr3BufUd3RcpxzGbNsqyGp831kn14p3N
	fuWVOiXiEe6VbdPIBy+L9uotpUA7g4g=
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-636-hqsEcHNKPhOH30ZkfDXfYw-1; Wed, 15 Apr 2026 06:42:26 -0400
X-MC-Unique: hqsEcHNKPhOH30ZkfDXfYw-1
X-Mimecast-MFC-AGG-ID: hqsEcHNKPhOH30ZkfDXfYw_1776249745
Received: by mail-wr1-f71.google.com with SMTP id ffacd0b85a97d-43d1bfbd219so4855947f8f.0
        for <virtualization@lists.linux.dev>; Wed, 15 Apr 2026 03:42:25 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776249745; x=1776854545;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=S5Es++6jZY8aKLtLSfo9uIdq7eeB6041SLW/QpiJsjA=;
        b=XeD1xSe9l12iLX5M+TC+XkaPWSPqBXnwjk0NfabvI+3jYC0t+afZyVUIUphCXbcDAa
         rO7vGa5pPJ2oQ34LbbWBRZDqO8No+zk93VFVgYn3sJLmaIfI6fGBiE0TNKJQA5/fT+UK
         tla6Zami5BtaxjqTZhzDA5TbO2RTf020TsYH4pQ5LmqeWwZx53bNGGUbncwxvknULB+n
         zBqgr63rLtXqb2tliwrCrdZ+gZaYQ+hyovJSR6O5b4deY8Qv+ZTZpyR/EbZHwdrSeSWy
         4CKVb0qovKZ5J3kqL9mF02qNxiuBKCNr4Eq88VydHMrEDINtBjBYIDusPPm1IR48ucvA
         UAPQ==
X-Forwarded-Encrypted: i=1; AFNElJ9CLq8meGE9u92lnQ+hXTRX0rnxd3J0EJAr06vIrfgcP712dYNtcXwjNG/LBWLDjuy84AqeMKIJilGNQ5LyuA==@lists.linux.dev
X-Gm-Message-State: AOJu0YwPcRuhjiaWvnvWHeTYpzOFlR5BZTLNWtmO15ZgFPFVwCW0HvRq
	m4/A9nj9Q0LAmHPVURXFtuz2CxG236ovke2EoJOJhnP2Aahkrm6GPIrGaF4UD68aNBbzO/dx7Kk
	AaKQ9bP6E7cnrR2f4kMRR/trBme6jpZ5jZOfGE9vZkBFhIv5mcevWRZE9oDMic7wqzLis
X-Gm-Gg: AeBDiesP8IhwWXbx1ngBAzD0C+M/g8N+I/F44zMDjwBY1epQrv2zwQWVhsTeCMk6Pzf
	7f23vRphUqEJcA/fc0IEsvenD5aowCSmUw+mjqE61MgegCmCoKGOjHYxYrskC/G64ffQjg55uOE
	/L7bmoRQ/qIjUVhKeGc2uIS2Ff3BoI3kpdCbct9zD4E0DcCpvGX0cPj66mJnF4ScDUcMDbzvRzo
	vWRmun4Z/714/Gtz9LxzvtgJnYJrkRyxYhVOwROtS2J82D/2aIZQvoal51QaaQHD7uCTSxDXMQw
	EkztsY4FAL6zc3KWxkQYIvn7D3v3heROqpvbuVBiBIxmWbA9g9EfPugIgNaYpBEi3mpGF9SsceX
	ipHUgfbu2dJbiJeRfA2UC1dWW1WpOBQhKVofCVrPeTI6y+MXZg1WEtko9ATwTo8hTempTufJP+7
	BnZnUqQQ==
X-Received: by 2002:a05:600c:34cd:b0:487:575:5e1 with SMTP id 5b1f17b1804b1-488d68c2cb4mr269861955e9.24.1776249744827;
        Wed, 15 Apr 2026 03:42:24 -0700 (PDT)
X-Received: by 2002:a05:600c:34cd:b0:487:575:5e1 with SMTP id 5b1f17b1804b1-488d68c2cb4mr269861615e9.24.1776249744366;
        Wed, 15 Apr 2026 03:42:24 -0700 (PDT)
Received: from sgarzare-redhat (host-87-16-204-83.retail.telecomitalia.it. [87.16.204.83])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-43ead3d5fd6sm4397440f8f.24.2026.04.15.03.42.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 15 Apr 2026 03:42:23 -0700 (PDT)
Date: Wed, 15 Apr 2026 12:42:16 +0200
From: Stefano Garzarella <sgarzare@redhat.com>
To: Michal Luczaj <mhal@rbox.co>
Cc: Norbert Szetei <norbert@doyensec.com>, 
	"David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>, 
	virtualization@lists.linux.dev, netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3 net] vsock: fix buffer size clamping order
Message-ID: <ad9q6r6ZBHIH7k4f@sgarzare-redhat>
References: <180118C5-8BCF-4A63-A305-4EE53A34AB9C@doyensec.com>
 <e965ff22-37b2-406d-b885-e2736e84c0f3@rbox.co>
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
In-Reply-To: <e965ff22-37b2-406d-b885-e2736e84c0f3@rbox.co>
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: hdmJ44zxD6fE2TTm8MhjMgtNE252M251cZ_Nc8sFM4Q_1776249745
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline

On Tue, Apr 14, 2026 at 04:22:04PM +0200, Michal Luczaj wrote:
>On 4/9/26 18:34, Norbert Szetei wrote:
>> In vsock_update_buffer_size(), the buffer size was being clamped to the
>> maximum first, and then to the minimum. If a user sets a minimum buffer
>> size larger than the maximum, the minimum check overrides the maximum
>> check, inverting the constraint.
>>
>> This breaks the intended socket memory boundaries by allowing the
>> vsk->buffer_size to grow beyond the configured vsk->buffer_max_size.
>>
>> Fix this by checking the minimum first, and then the maximum. This
>> ensures the buffer size never exceeds the buffer_max_size.
>
>Something may be missing. After adding another ioctl to your reproducer, I
>still see crashes.
>
>     SYSCHK(setsockopt(fd, AF_VSOCK, SO_VM_SOCKETS_BUFFER_MIN_SIZE, &min,
>                       sizeof(min)));
>+    SYSCHK(setsockopt(fd, AF_VSOCK, SO_VM_SOCKETS_BUFFER_MAX_SIZE, &min,
>+                      sizeof(min)));
> }
>
>[*] Setting buffer_min_size to 0x400000000.
>[socket][0] sending...
>
>refcount_t: saturated; leaking memory.
>WARNING: lib/refcount.c:22 at refcount_warn_saturate+0x7d/0xb0, CPU#2:
>a.out/1478
>...
>refcount_t: underflow; use-after-free.
>WARNING: lib/refcount.c:28 at refcount_warn_saturate+0x50/0xb0, CPU#12:
>kworker/12:0/80
>Workqueue: vsock-loopback vsock_loopback_work
>...
>

yeah, I pointed out the same during the bug discussion 
(https://lore.kernel.org/netdev/acuKUpZQq6z1DY_n@sgarzare-redhat/) and 
suggested to add a sysctl or reuse net.core.wmem_max/rmem_max
(https://lore.kernel.org/netdev/adYKERRYwzMIhZAl@sgarzare-redhat/)

Thanks,
Stefano

