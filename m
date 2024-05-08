Received: from mail-lf1-f42.google.com (mail-lf1-f42.google.com [209.85.167.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 28F832BAED;
	Wed,  8 May 2024 12:35:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715171714; cv=none; b=jpnzjiV9g0pa8bn8olALrlj5PRO07oyavps4JQAFSoADDBHEHUsHbHm2d46nQNEoKfiisIoQTV6lRbvZRN6gwDwstpf21PTLdKtubJVqlWyHkTvzqhyHOzIuVlcsccMuMSYem5JL+4D145LXLrahexu33v1R5USYGKTffBF4Rto=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715171714; c=relaxed/simple;
	bh=i2JLkQ5wqYLV4moBdZnxKtMAd2an5huS7pmMXcoLDiA=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=AAWnm8/J6ySvi06aGXgT1LVwwEOu224c/GPngURsABBt+tw18siCaAjMAUN613WsfWBa0Pep+FTYMj19F738XetdXFXGa00cys+4u+jtPa+bsoiAPEc4Z0mmJGAnrBKL4WspnG4XvwrWe6aWqM/8czbPgyw/C7gjCYMtsVkV8PA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=R3QfxrLw; arc=none smtp.client-ip=209.85.167.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="R3QfxrLw"
Received: by mail-lf1-f42.google.com with SMTP id 2adb3069b0e04-5210684cee6so2796496e87.0;
        Wed, 08 May 2024 05:35:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1715171710; x=1715776510; darn=lists.linux.dev;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=AGqJENKGu2VDw1JweApXY7Cnx0SgkltEUbGukf+76pw=;
        b=R3QfxrLwuO3AIpte9vwWLjT7P61B/oXCFzYwT6YJXbyIM3vuZU1ByTh/+H+QPz2Tw2
         GJ17h4dM/T6oTOeyFzIlg2PDtkRX21/tasGBibyMjd1BR6+V/Mp8GrcMoo68PS5N1fG8
         nug6wN3dOZMS2Js6rwCK/FYu/Gtj1ZvTp3KoLSM6V7DTods24/Gx2/Lil5vEilSKiWlB
         9xzMEGW42DxFHoUMbwLwVA7f/S9BbJJbvPpbx0jPLN972DtmK7FW/Qt2nxfFwfqtxb4P
         Q6HHmuRCNTsY9yYTgU3CQAg3N5a5ql1eyTUPOR8cxsQU35S1Cc1Fm02cANidfjql4epp
         vBXQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1715171710; x=1715776510;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=AGqJENKGu2VDw1JweApXY7Cnx0SgkltEUbGukf+76pw=;
        b=Qku8uaJZL3NSq08fOo6Ndujvf4f6CmR5KhdV203TuhFMhDDiAoR+XFCdJcn+TlHUXI
         nkvRrpxPGo1PwuboR2JE29RU7ATU+bAydP0NISYycvddkTpeujBoLVfzGNOvTugM5sSh
         F5I7y4aPgl+uvvntd+4ZdPzbADuTY8fMY9tpRAtj6tIz026rYKUKRURE5v5ydjMflymo
         2iB+P0zFjdVGNQUg0MymTGnrLHKr+d5yG3+4UKQEX1d4MpDR/hagSBXKtUlNZ+KwSQtt
         RHKOjY/AvV9bA1PYBMSWTScZefw5LqhSqWWCf3uovqMX9QDUT7rLVVEmRKMrG+V0akvo
         t/qw==
X-Forwarded-Encrypted: i=1; AJvYcCUkm6wTLYYqyGLuyZI2XaLD96E6Nk7MwZsVW+HbzN0mprq+y51ALwesaVvlaSXusA9Z+XqZ1Wir1FOx5MzTrK9ADRwhx8eebYdvbRjqjpM=
X-Gm-Message-State: AOJu0YybF4qyDtGl80hmlwivJgBKO/VifuRw7dBsT7y6E3+o0seOVExE
	jA1zB8vCkJginxXkMl4p2QGSwog/A2LvrDDF4AxJcRmld+pgOHekCRAO9c0Z
X-Google-Smtp-Source: AGHT+IGEhgoz0oL9QWFm1uMJ3wjDKHCYFTJDY7pYc8SqD9sY6qgDMaPrAs6eZsiz9jKDcFCAfaIogw==
X-Received: by 2002:ac2:4c2b:0:b0:51e:11d5:bcaa with SMTP id 2adb3069b0e04-5217c56e432mr1461968e87.39.1715171709955;
        Wed, 08 May 2024 05:35:09 -0700 (PDT)
Received: from [130.235.83.196] (nieman.control.lth.se. [130.235.83.196])
        by smtp.gmail.com with ESMTPSA id b2-20020a056512060200b0051f0225e0a4sm2492021lfe.227.2024.05.08.05.35.09
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 08 May 2024 05:35:09 -0700 (PDT)
Message-ID: <b57f8ede-5de6-4d3d-96a0-d2fdc6c31174@gmail.com>
Date: Wed, 8 May 2024 14:35:07 +0200
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [Regression] 6.9.0: WARNING: workqueue: WQ_MEM_RECLAIM
 ttm:ttm_bo_delayed_delete [ttm] is flushing !WQ_MEM_RECLAIM
 events:qxl_gc_work [qxl]
To: Linux regressions mailing list <regressions@lists.linux.dev>,
 David Wang <00107082@163.com>
Cc: airlied@gmail.com, airlied@redhat.com, daniel@ffwll.ch,
 dreaming.about.electric.sheep@gmail.com, dri-devel@lists.freedesktop.org,
 kraxel@redhat.com, linux-kernel@vger.kernel.org,
 maarten.lankhorst@linux.intel.com, mripard@kernel.org,
 spice-devel@lists.freedesktop.org, tzimmermann@suse.de,
 virtualization@lists.linux.dev, stable@vger.kernel.org
References: <20240430061337.764633-1-00107082@163.com>
 <20240506143003.4855-1-00107082@163.com>
 <ac41c761-27c9-48c3-bd80-d94d4db291e8@leemhuis.info>
Content-Language: en-US
From: Anders Blomdell <anders.blomdell@gmail.com>
In-Reply-To: <ac41c761-27c9-48c3-bd80-d94d4db291e8@leemhuis.info>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit



On 2024-05-07 07:04, Linux regression tracking (Thorsten Leemhuis) wrote:
> 
> 
> On 06.05.24 16:30, David Wang wrote:
>>> On 30.04.24 08:13, David Wang wrote:
> 
>>> And confirmed that the warning is caused by
>>> 07ed11afb68d94eadd4ffc082b97c2331307c5ea and reverting it can fix.
>>
>> The kernel warning still shows up in 6.9.0-rc7.
>> (I think 4 high load processes on a 2-Core VM could easily trigger the kernel warning.)
> 
> Thx for the report. Linus just reverted the commit 07ed11afb68 you
> mentioned in your initial mail (I put that quote in again, see above):
> 
> 3628e0383dd349 ("Reapply "drm/qxl: simplify qxl_fence_wait"")
> https://git.kernel.org/torvalds/c/3628e0383dd349f02f882e612ab6184e4bb3dc10
> 
> So this hopefully should be history now.
> 
> Ciao, Thorsten
> 
Since this affects the 6.8 series (6.8.7 and onwards), I made a CC to stable@vger.kernel.org

/Anders
