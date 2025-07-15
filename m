Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E205ABE65
	for <virtualization@lists.linux.dev>; Tue, 15 Jul 2025 22:01:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752616866; cv=none; b=dVZZeIOYxq9GDVdO5LFEytE80n0VpPgqalMcIAejMWkI5LNDhk81Ta4FqmKAb5cLi2IhJrxBVoPaF34IK3KdZ1uT568Wani4BN8DvKaJxxDkpp61mfVwgIhTKgCe1+Z2+0G7s+5YR1y5TrhFBP1HLgt/3hP8tih5tB2gyeH1tVM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752616866; c=relaxed/simple;
	bh=aw4VtfDqjuaCSCkMl9eKdyKesdQJxtCTX+BsCCEcx7A=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=OyBgRkS4dLzYuyuCJuc3wcQLetE7z6dmbDBrxDUjYKrLmo/Tt3ECwI9bRDFBjMWfgyOXi55doIXp6Uu+2Tgi6HWTD9NGkqIifzlcdd0Jn1UTGyQIauLDVNWPfFroJbBFmlUJ0GV25EoHBasw/uuPEJusTfRzAbf64pX1AMBFv7k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=fnT6mzsv; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="fnT6mzsv"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1752616863;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=kLAwa3dvkrMO6tqYCU+aUo3W6TsJmM1uaesMjUYNHF8=;
	b=fnT6mzsv34iKi5PckdhaSQUeIYqMDP4xF0Ya/qqoJ8KlFq0H5llioxa6PrLBUBayBO0uIS
	mTHCpgtwHgBTYqFPw5wksnBsgzHncKN8mdKhaLWYSAbcGSYZ1B8+a8qmcaOyzKuFtr2VMv
	YEKmxMW6/zI7/3PyCjar+QB0tKoNv40=
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-142-cqthykicMUmD69Iaz1aW-Q-1; Tue, 15 Jul 2025 18:01:02 -0400
X-MC-Unique: cqthykicMUmD69Iaz1aW-Q-1
X-Mimecast-MFC-AGG-ID: cqthykicMUmD69Iaz1aW-Q_1752616861
Received: by mail-wr1-f71.google.com with SMTP id ffacd0b85a97d-3a5058f9ef4so2520367f8f.2
        for <virtualization@lists.linux.dev>; Tue, 15 Jul 2025 15:01:01 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752616861; x=1753221661;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=kLAwa3dvkrMO6tqYCU+aUo3W6TsJmM1uaesMjUYNHF8=;
        b=RItVkhwIf779h/2NnW0n+FuI/VKhboxX01R86ErraFyihz0ZrQ4mekCbQvHM3BLc5U
         36u/CCSsHyWHeJe/LGFTxqBm9bLri0TDhykACOu12W+oruG5akeNnfoFduvtMfLzXY9U
         vZgtEOVpSupAk7Mk32694I+q/srT0fAMmx9T/I1B40c60ac9IWb05ILvGNLjjno7+5d6
         pqhZdGykpKsKL/RIDBj7MTdPxXJyZqd52vrnNYmZIZ9iqPAPVtATGMC1r9lngsJzX8gz
         /t0qR4vAz6ubh7BFDS6/bYGboW97/fdgNd8c8zq5fprX0SvsYfGMMEFbgJqaa7+5TRmO
         pkDQ==
X-Forwarded-Encrypted: i=1; AJvYcCVG0mCeGqhWq8jP/d2PZJx6295a2z+bAAu0XK96fnE5iZmtmFbBPtS0zbnW0ygOOceMCeQVthrtBAJ05u+Pmw==@lists.linux.dev
X-Gm-Message-State: AOJu0YwVfp6qPKtAOiV2uWdPNgb7DY3uYDOMqzlAIM6kKUtJafslkAa0
	8m7xMI7KDWLsPzXixLRx8eoicfQYcAI7YiCJ5MP2Au1JQbkt0l2DsZP+asmhkuszv8T4wSVFX9T
	blOTewEBteJbJc0ljAjtwJeZGcvvNH0Taki9hkg3qZkk4xkx/mQJ0utWoXOBW4dr4Wa3F
X-Gm-Gg: ASbGncuOOSSD9s3bfG2TFCnI503lR+ZS3GCGbv9C+Jqcwc1qZQBqwO1211LQm62beFZ
	ja7FH2BeUpKSw62Tf0WaPcTLbrnFxKLw+Ag8OyLmuNeWyJeMWC487wUmayVdzxWkGMoqlBL3YlF
	16kg69eX9tlIV7GhZ0LPfmaumojz87ONCKiAPJKaNBv69A5K2Opz0YFZ7gdSAeS+El9MILhWUTd
	IsJ8/m8Y5SR4cROoksf/objOBfg47mHiQgrAH3dO0dRqzRzZxxwp6rVnBGUoFtTgwmeCXHSywii
	HfBZPYqPB2Toq7lKN6J6FgAyDiVneQSQztANpAnbdr4MjRKrFUKzyrA6NLh918jEOnqmHz03e9M
	H
X-Received: by 2002:a5d:5d0c:0:b0:3a8:30b8:cb93 with SMTP id ffacd0b85a97d-3b60dd95a75mr555275f8f.32.1752616860701;
        Tue, 15 Jul 2025 15:01:00 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHLDHsg8OR9x/gIzmibOJxTfaj3TRrHrpjR78a3np6L7t4fAQSv39mTDqr+YfaxcUEbilL4qw==
X-Received: by 2002:a5d:5d0c:0:b0:3a8:30b8:cb93 with SMTP id ffacd0b85a97d-3b60dd95a75mr555234f8f.32.1752616860168;
        Tue, 15 Jul 2025 15:01:00 -0700 (PDT)
Received: from ?IPV6:2a01:e0a:c:37e0:5b4d:4594:545c:dd8? ([2a01:e0a:c:37e0:5b4d:4594:545c:dd8])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3b5e8e26c97sm16368518f8f.90.2025.07.15.15.00.59
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 15 Jul 2025 15:00:59 -0700 (PDT)
Message-ID: <05c40a0a-d2b0-4f55-981f-6da3765eebb2@redhat.com>
Date: Wed, 16 Jul 2025 00:00:56 +0200
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH drm-next] drm/bochs: Add support for drm_panic
To: Askar Safin <safinaskar@zohomail.com>
Cc: ryasuoka <ryasuoka@redhat.com>, airlied <airlied@gmail.com>,
 dri-devel <dri-devel@lists.freedesktop.org>, kraxel <kraxel@redhat.com>,
 linux-kernel <linux-kernel@vger.kernel.org>,
 "maarten.lankhorst" <maarten.lankhorst@linux.intel.com>,
 mripard <mripard@kernel.org>, simona <simona@ffwll.ch>,
 tzimmermann <tzimmermann@suse.de>,
 virtualization <virtualization@lists.linux.dev>
References: <20250613132023.106946-1-ryasuoka@redhat.com>
 <20250714000456.14-1-safinaskar@zohomail.com>
 <1961897d-cf42-4495-aec7-f4c20dfe7566@redhat.com>
 <1980fcccefe.10a7c92b36705.2744765212931179004@zohomail.com>
From: Jocelyn Falempe <jfalempe@redhat.com>
In-Reply-To: <1980fcccefe.10a7c92b36705.2744765212931179004@zohomail.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: Pvwp6rhzBpHRV_Q9TATqJUUtmMe76s7_jKlXSKhgwfU_1752616861
X-Mimecast-Originator: redhat.com
Content-Language: en-US, fr
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 15/07/2025 22:35, Askar Safin wrote:
>   ---- On Tue, 15 Jul 2025 12:57:04 +0400  Jocelyn Falempe <jfalempe@redhat.com> wrote ---
>   > "Normal panics", is just the console logs through fbcon. The problem is
> 
> Thank you for answer! Is this possible to configure system such that fbcon works normally,
> VTs work normally (i. e. via framebuffer), but when panic happens, it is displayed via drm_panic? This seems to
> be solution to the problem.

Yes, that's the default if you use a drm driver like bochs with fbdev 
emulation enabled. (Of course you can't have DRM panic on a pure fbdev 
driver).

There was a concurrency problem between fbcon and DRM panic, and I've 
solved it a year ago with:
https://patchwork.freedesktop.org/series/136182/

So make sure you have the following in your .config:

CONFIG_FRAMEBUFFER_CONSOLE=y
CONFIG_DRM_FBDEV_EMULATION=y
CONFIG_DRM_PANIC=y
CONFIG_DRM_PANIC_SCREEN="kmsg"

Best regards,

-- 

Jocelyn

> 
> --
> Askar Safin
> https://types.pl/@safinaskar
> 

