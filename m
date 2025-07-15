Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A88322D63F1
	for <virtualization@lists.linux.dev>; Tue, 15 Jul 2025 08:57:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752569834; cv=none; b=ftm2be9dgXxSfYRSHYjrFOuvL3qVsjPKYJCYKQToAaaIdDAvqrbwQN80Eg8fy3+7kwFqtqY9hN/XRrWl/lyssnYuNTsefVHys+X8bt+Fkvw81YO8aLhShcWSy2jTFWDTNWnVMlkJA7TS/GdjudnkyTdSovNoza77/57+jVxJ1+U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752569834; c=relaxed/simple;
	bh=d73xnGvBnn/yLem+NJtj+Cl8ZtWrSonr6udO9YJ9Nl8=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=nDxXtCpAKqdfdh4Ltg0ezuQiBFx/cCnartWrMAMI0L2Y1MN+IGaOFC3So+lVNPZr3UjEm8wadlBZrPUW1nfFaTDoVKFAg9LGdzCzExGwEHWD0Co+bE/G7TrgM2OZPFqioQNUXubKJrZogFPzieQnYAgWMXfEO6VP9Be4oqObXYE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=ZlvIYR+E; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="ZlvIYR+E"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1752569831;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=q4S6jLcDw14s0h5C7UNges46jen9fUJCj9Z3x6/+JdE=;
	b=ZlvIYR+ESpQB9Xwp4SBr2GiVHuudykaq2tCWqv/NZLy7vSai//30+JU31yQa6daQZWLdD6
	5pJ/ako1qSkELv10gmnf9czHuxFnAg7BclBZ92LWMGKD4WdP5QQ5K3vbDZd2GtHthS1RXX
	jgv0ai3qt93DkIYbExKrswfnUwdtRAs=
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-648-T99wCSDOO8qaTnZnmvryhw-1; Tue, 15 Jul 2025 04:57:09 -0400
X-MC-Unique: T99wCSDOO8qaTnZnmvryhw-1
X-Mimecast-MFC-AGG-ID: T99wCSDOO8qaTnZnmvryhw_1752569828
Received: by mail-wr1-f71.google.com with SMTP id ffacd0b85a97d-3b604541741so1195469f8f.3
        for <virtualization@lists.linux.dev>; Tue, 15 Jul 2025 01:57:09 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752569828; x=1753174628;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=q4S6jLcDw14s0h5C7UNges46jen9fUJCj9Z3x6/+JdE=;
        b=DRTddI8tf9buCM4vDYHsGtrf+vHs6NVggzDGvfeaCURyokeFTBwPzBVTSoZI6HUfos
         NoRXjJBuOi3iF9IFazcvS05bzJmYoAaQIQdq/VNST+G3VqbWIJPY4QeJLIAC6jjAgGF0
         6vWlYuDW5M3Kb4ApL1kWsSYMr1RG4r7mJqemJQ6Dt5PXEo56zzexzM6jvT8r0lHURxqU
         HGUS4dfCs99Lc2h2BcM5ZQWK18/aGkDdGmFOjtxISzr8ElDvFo4L/0jD/5LYZwY17LlJ
         1JEtOdB8WCEBm4Z4Xq07Io8A83dySDxko0h4PMMXslzVsldjDHxBLfzffWhZnjCs+apH
         R2sg==
X-Forwarded-Encrypted: i=1; AJvYcCWwtkYpAkzOImQHv3TzwpdZ0dWu057HUoZ9AawgWhw7w/oKu8VdRPE9EtwauFQ6ETduqunhvqUovZZjZOWu8g==@lists.linux.dev
X-Gm-Message-State: AOJu0YxLKHk8ktKm5GdyXCmQNMx5jp2qToXWu6iq/hSYvQN76yjBsjpG
	hiP9R+ID2daxYhYBtB6BE89KbOdljX/pzWfsAu5rdPeNPE74edPw5v66XLXYrU5ICNuZf/D/9jH
	DW24527tKTAGTYOEb8hJ/BXiTpflyShgG9V/fBH2jEBYNuN1kHR0NbZdYHkes8/GUTj+H
X-Gm-Gg: ASbGncvJDPdgM/cqGgWJLrbNeLUGx2QocX3wZ7/lBwE+6ZndVXfgxTfGA6GB+Q86/KE
	wZLqUnJwkOu68TSFJbZ6mU0wBPW4Vnzu49TQ8uTUiexepWEskM1ejioSv0lJddjpYNsjHJAcJac
	MLhx/chJewyNG+7RgVDVzTKP2MIpm6gti9xGpI1Z1lCMl6qXJYZQYAhd7gfwMt2JkrMyInSbLy/
	Eg6yGW6LR02yiclW+kK5YeMFY/Nk7vdJFAC65uCFCZ/y4zpy7Ol5yAXdjVOsdWegFhrE2EiPQRB
	KbDUQd10cGYvsJh0Bwi9FQkRHS2fBgHp7fDJvHhKRWuzLynWf64XJngn0dLumYi91qKf7q5J2tk
	6
X-Received: by 2002:a5d:5d83:0:b0:3a5:541c:b40f with SMTP id ffacd0b85a97d-3b5f2dac5a1mr11824722f8f.9.1752569828085;
        Tue, 15 Jul 2025 01:57:08 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IG6Kkel0yuQmQmEmb1zMwEbLFifDV9RypChWcFY6iUumNdJ0EnvBVHg1wUa4OJOhXqqUwTFlA==
X-Received: by 2002:a5d:5d83:0:b0:3a5:541c:b40f with SMTP id ffacd0b85a97d-3b5f2dac5a1mr11824702f8f.9.1752569827645;
        Tue, 15 Jul 2025 01:57:07 -0700 (PDT)
Received: from ?IPV6:2a01:e0a:c:37e0:5b4d:4594:545c:dd8? ([2a01:e0a:c:37e0:5b4d:4594:545c:dd8])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3b5e8e0d872sm14765473f8f.60.2025.07.15.01.57.06
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 15 Jul 2025 01:57:07 -0700 (PDT)
Message-ID: <1961897d-cf42-4495-aec7-f4c20dfe7566@redhat.com>
Date: Tue, 15 Jul 2025 10:57:04 +0200
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH drm-next] drm/bochs: Add support for drm_panic
To: Askar Safin <safinaskar@zohomail.com>, ryasuoka@redhat.com
Cc: airlied@gmail.com, dri-devel@lists.freedesktop.org, kraxel@redhat.com,
 linux-kernel@vger.kernel.org, maarten.lankhorst@linux.intel.com,
 mripard@kernel.org, simona@ffwll.ch, tzimmermann@suse.de,
 virtualization@lists.linux.dev
References: <20250613132023.106946-1-ryasuoka@redhat.com>
 <20250714000456.14-1-safinaskar@zohomail.com>
From: Jocelyn Falempe <jfalempe@redhat.com>
In-Reply-To: <20250714000456.14-1-safinaskar@zohomail.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: Eho-BYIgh451vBQpgYQodImxwU-zenCHsnYcNOIu5ig_1752569828
X-Mimecast-Originator: redhat.com
Content-Language: en-US, fr
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 14/07/2025 02:04, Askar Safin wrote:
> Are normal panics (i. e. not drm panics) still supposed to work with bochs?

"Normal panics", is just the console logs through fbcon. The problem is 
that this is not designed to work in a panic context, so on some driver 
it can work, but it's not reliable. Also depending on the panic source 
(Like if the panic occurs in IRQ context), you probably won't see anything.
I think the regression is likely because the driver switched to use a 
shadow buffer (ie: fbcon draws to a buffer in system memory, which is 
copied to the "VRAM" in a workqueue, and workqueues are disabled in a 
panic context). So there is no easy fix for the fbcon panic.

This patch series, only take care of DRM panic. You can get the same 
output as fbcon, by selecting CONFIG_DRM_PANIC_SCREEN"kmsg".

-- 

Jocelyn

> 
> If yes, then I want to point out that they, in fact, don't work since 2019.
> I. e. panics are not shown in Qemu if:
> 1) bochs is used
> 2) we use "normal" panics (not drm panics)
> 
> I already reported this here: https://lore.kernel.org/regressions/197f290e30b.eaadc7bc7913.7315623184036672946@zohomail.com/T/#u ,
> but nobody answered.
> 
> --
> Askar Safin
> 

