Received: from mail-pg1-f175.google.com (mail-pg1-f175.google.com [209.85.215.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8DD7A3BB9EB
	for <virtualization@lists.linux.dev>; Wed, 19 Aug 2026 02:39:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787107171; cv=none; b=mQnmUwDfgVbyypVTvB22YD/OPGhNBoFhv0H945gMHXl52LFmxVd8OfW5fLXoMSg13XQdSflLfX4k9Hf+ytB7adsEuhEQJTs9O+Lrymm3uof09ySDcGtIqBPmkau5jFVFjyGfuU3UikTerPckmUKDHJCyDRaSNRnQajTUB9bCxUQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787107171; c=relaxed/simple;
	bh=mqfcpoab9k8WhlBl2faNXU5zZtz9PCikczEVHCi9ucA=;
	h=Date:From:To:CC:Subject:In-Reply-To:References:Message-ID:
	 MIME-Version:Content-Type; b=sVXXPjLPha3oCAgiwZA1E7+d10wm6azn3FCjjia4kzi2SDAZij2BLgHku9qmfvSaoBb5WGTyLYJpesht15XctIcx4AbEz6Gg6XthI59selzAdgroBIN9xfS//Kebkh/uMy9g/ImlLnJVZge8Fukmtm9TFN+oRdmeA5yRxlUOXm8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=cpIxj6Zc; arc=none smtp.client-ip=209.85.215.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="cpIxj6Zc"
Received: by mail-pg1-f175.google.com with SMTP id 41be03b00d2f7-ca80d708489so271645a12.1
        for <virtualization@lists.linux.dev>; Tue, 18 Aug 2026 19:39:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1787107170; x=1787711970; darn=lists.linux.dev;
        h=content-transfer-encoding:content-type:mime-version:message-id
         :references:in-reply-to:user-agent:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to:content-type;
        bh=eQyoOyf6SSUoapDzSHBCy3JEgU3A95lRqlJ7qpIL3Tw=;
        b=cpIxj6Zccz8dNDVPpwh8zPzlI4OjNjX0nefnKZJO8go3DXTamQNh2AZW+LgJpeFpHA
         o1k+QP9Vy7LWSi1gPdrBTyUDm5QI6K+TC8ZU/CR4246DAnWJUXri62GCCxr2qBU6sHem
         y/zRH8NSxMsYseK6mYtHgUuqxKpEn+orOGbxF7dIUk56Og87yS56CNuJ2+5/eT27w4kX
         pCgKn5uLEfXLnxCBMZi1OlT9yvPN0EQfUdKRmH64mR94J5oSPvAE/Pk83wqo8UE2cZyM
         bWqIYH3DDvL9YU3yzGvdfSHvX29YMyJGGTILarvs8qam+qs3rPTztO9DBi4nOCYnejXh
         UQug==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1787107170; x=1787711970;
        h=content-transfer-encoding:content-type:mime-version:message-id
         :references:in-reply-to:user-agent:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=eQyoOyf6SSUoapDzSHBCy3JEgU3A95lRqlJ7qpIL3Tw=;
        b=MQfB00NMmUFdEGJb98Sa/ks6uSAkiYkOArM8/Sk74yykBgvvE5zzAjj2dm4sVd99ZG
         qw5qikJvQ3tWB7MT+SMw6RnRiqIQ+l4MJ3joCYNXwzTQ5+0klTpAbhiEerZeKGfQaAx8
         +u4+qN+/Bbg2OfKiXaD41sDWefBLUS6lG6BZDrTnfOPXRUMcXEKZx6gu8n06M8BzrC5z
         wZq5cZjV0uXuNNysBAJEfUWmtzCVfcJcnP9MDG+WsyLJ2kPegau83Yxg7O1cgWvpboqC
         PfBz/8xVL+BJgLV7i34BgsKOI+189AkNAgXrBl40C/PLMFg/W6FzqvZcGhH/TGlX3BE2
         ZQyg==
X-Gm-Message-State: AOJu0YypecszE2purEjM/FVfRdrrGMM+I92aRFysRVtF1wgnd3qU/FtM
	SJ4OCi2roB+v+OntXtYUT9g3ZlHW0PMgKQOwA7Oh5Y7Pxfs0LJ6OCvzG
X-Gm-Gg: AR+sD10cvTQ5eOq2xRIkrKSn3syxVIEO3B35mxnLtm8kU1n9Eer4/FGR1zgnN8Q1XRS
	2Ol/yvVCOht8aU2tvpVHtS7R0fhc809tA971/7YOQM1hv+mDW5+7IeCO3O6T0VPrDht9UxmWElv
	NtIuyuxMeAcBEvCL83R1iR/9Tog/0ZEnGEe0+yAO8fZuCHBeEo7dj13OsL5/3kQ7/0WtYpvGIvb
	frWVYqtKKQZwWfzi6OqVReI3VwWGbfqkVYf5dssg1mcR+k+IwRrVp+vzRiLbXrsvelHyjmDBJ+L
	/K98ZKtjeQbW2B+gWs33lqacp17R777YMIypIOhKc45NFmOWC2B/7/iMzdXTuXOCkKc1AYuF8hW
	V8d/CZ9OewvFlbk2zMAb3y15l7cD+4H93XCjxXHe/q1oAtsFriVPCTh7X45HGJNAI6k0PEkDFJj
	tdkHyC23gx7xCeYS9pi4UJxbTxUymPypQlILSQ00CWWVkLLPSXeeeQEjMCisdCofhhwGNTsVxvE
	Cpma8EAFUYvMf5xHSnprRZZwmomFQNPYNwFAHk3eRTsMmygHbLoYGJN13X/AUdX
X-Received: by 2002:a17:90a:ec83:b0:36b:b903:994 with SMTP id 98e67ed59e1d1-3957f86d960mr2483000a91.4.1787107169635;
        Tue, 18 Aug 2026 19:39:29 -0700 (PDT)
Received: from ehlo.thunderbird.net ([2001:4430:c218:3060:358c:2257:2fee:9457])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3957fb60a2bsm818814a91.17.2026.08.18.19.39.28
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 18 Aug 2026 19:39:29 -0700 (PDT)
Date: Wed, 19 Aug 2026 11:39:26 +0900
From: Sungho Bae <baver.bae@gmail.com>
To: Breno Leitao <leitao@debian.org>, Amit Shah <amit@kernel.org>,
 Arnd Bergmann <arnd@arndb.de>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 Sungho Bae <baver.bae@lge.com>
CC: virtualization@lists.linux.dev, linux-kernel@vger.kernel.org,
 kernel-team@meta.com
Subject: =?US-ASCII?Q?Re=3A_=5BPATCH=5D_virtio=5Fconsole=3A_allocate_?=
 =?US-ASCII?Q?the_port=5Fbuffer_with_the_caller=27s_gfp?=
User-Agent: K-9 Mail for Android
In-Reply-To: <aoQggUaBZC9GeY1Y@gmail.com>
References: <20260810-serial-v1-1-abbe51602c13@debian.org> <aoQggUaBZC9GeY1Y@gmail.com>
Message-ID: <6B66D650-D65F-4176-ACBF-DC42488883AB@gmail.com>
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: quoted-printable

I am sorry for the late reply=2E
I fully agree with your patch=2E
It was my mistake=2E I should have to allocate the buffer with gfp flags=
=2E
Thank you for the corrections=2E


On 2026=EB=85=84 8=EC=9B=94 18=EC=9D=BC =EC=98=A4=ED=9B=84 6=EC=8B=9C 6=EB=
=B6=84 37=EC=B4=88 GMT+09:00, Breno Leitao <leitao@debian=2Eorg> =EC=9E=91=
=EC=84=B1=ED=95=A8:
>On Mon, Aug 10, 2026 at 09:40:00AM -0700, Breno Leitao wrote:
>> put_chars() runs from the hvc console write path with preemption
>> disabled, so it asks alloc_buf() for GFP_ATOMIC=2E Only the data buffer
>> gets it: the struct port_buffer itself keeps the GFP_KERNEL default, so
>> the allocation can enter direct reclaim and sleep=2E A write to /dev/km=
sg
>> on a CONFIG_DEBUG_ATOMIC_SLEEP kernel splats:
>>=20
>>   BUG: sleeping function called from invalid context at =2E/include/lin=
ux/sched/mm=2Eh:320
>>   in_atomic(): 1, irqs_disabled(): 1, non_block: 0, pid: 1, name: virtm=
e-ng-init
>>   preempt_count: 1, expected: 0
>>   Preemption disabled at:
>>   [<ffffffff813fd90d>] vprintk_emit+0x17d/0x510
>>   Call Trace:
>>    <TASK>
>>    dump_stack_lvl+0x69/0xa0
>>    __might_resched+0x37a/0x4d0
>>    __kmalloc_cache_noprof+0x94/0x5f0
>>    put_chars+0x209/0x3e0
>>    hvc_console_print+0x234/0x640
>>    console_flush_all+0x4fc/0x950
>>    console_unlock+0xbf/0x1b0
>>    vprintk_emit+0x312/0x510
>>    devkmsg_emit+0xba/0x110
>>    devkmsg_write+0x21b/0x2e0
>>    vfs_write+0x4dc/0x9d0
>>    ksys_write+0x108/0x1e0
>>    do_syscall_64+0xfa/0x460
>>    </TASK>
>>=20
>> Pass gfp on to that allocation too=2E
>>=20
>> Fixes: fc220d6be3c7 ("virtio_console: refactor __send_to_port() buffer =
ownership")
>> Signed-off-by: Breno Leitao <leitao@debian=2Eorg>
>
>Ping?=20
>
