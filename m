Received: from mail-vs2-f12.google.com (mail-vs2-f12.google.com [74.125.227.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CD89C4BA1D3
	for <virtualization@lists.linux.dev>; Tue, 15 Sep 2026 17:30:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.227.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789493418; cv=none; b=t6+CL6PcTNPMd4itCwaCf9v7+kgsPcxRw7aZjBKRnBHtQ1I9HFbXq4+NqH/VDlhs4NMprKzRrgL49Y0nJdUEX/b5kYEEOnCmABaiwNYLMD4jl3lGI/vEucqV2z5QUiLiZcmQw84VxhkApaF0pc07j5CckydCjYjb99VQbDOeIMc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789493418; c=relaxed/simple;
	bh=VwBUcuZPFg1BLZxP9DxF8spw7i/So+6y5IlyEFSLMuc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Y5YB+4guQ8ObhYW62tmqYC2ZP+Th2hwxAAhoPzz4lYd3qY8VnmxWeZtGcuLDYUr3HATssycy8g6HhxI0403Pg3LHL2mqkYXKBLgWk07pdZ4drb7lvQ4fTrFC0fBrf8u0EiCmETjfP13KNZQd3HQd6wG4cvmECrOYBXl6UYYGngE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=FExjj1uo; arc=none smtp.client-ip=74.125.227.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="FExjj1uo"
Received: by mail-vs2-f12.google.com with SMTP id 71dfb90a1353d-5c67e4d8d8aso2955303e0c.1
        for <virtualization@lists.linux.dev>; Tue, 15 Sep 2026 10:30:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1789493415; x=1790098215; darn=lists.linux.dev;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=VwBUcuZPFg1BLZxP9DxF8spw7i/So+6y5IlyEFSLMuc=;
        b=FExjj1uo4MKfwYbbjxVdcS8gZVjDTCWN3Shkzw1sd3yHnfl2tZ67FWu75vSMB4I7O6
         6L7c5PzgCMaU6KHrbfiSenjdOANWG0zzy7Y2qDztzeME3L+9vDiXO5H0Z5igxq01lk1e
         /b7NJzP360sLwyZr1w+0G8nO1oSEZWaEOEJC4bqgvs9H4sFt+U2UU8HqWPgUkFpXwqt1
         lGzZmO+rckfjzImOq/ZwHj9x3DY8oZDV0cajNJg+N5JghTcv/LXXgHvaIj42txijWrTh
         wf5puRrjUOVGbUHO1QhKVOmgELaby55juu3u9Rj41MdIjp/mHjClAnG0yAAtHhkb2fLu
         TrhQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1789493415; x=1790098215;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:date:subject:cc:to:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=VwBUcuZPFg1BLZxP9DxF8spw7i/So+6y5IlyEFSLMuc=;
        b=QLG8hiQbXSzlQ7VlTuHTVlw8Xzjw/suKqWO7PhVuIaMyjqD667kBj2okE+5vcLcid9
         au9oP8o70evnVdmZu+o9/zQNM0LUi3bJ9NwxXR8Wdh/Ix25S+15jDWspRxEOXc6wGuwh
         hr1S7AeEfqxMI8GyCQSEbEmVNkn8AHDANRbRsZGwo0o8vnRiiuQZ6TsKH2aidKE1lwzj
         6W1eudsq0xM2wx2gZNU5A+hRhpPP5unMabCIUtFQ0ZDHyOVhvBVBS4ZaDrySHlsDr/pg
         Q7+iLZttSjKDRxgRM5jG7zRvCVcuq6QryzFzG/thvjbQeXTu+/7qwM/X/POp+OIb0a/s
         NOew==
X-Forwarded-Encrypted: i=1; AKwUvBxvOsPsaKCipwqp6O1kFZKGX/oPsSFixWwVM9fxcHYySMVsWj3Z0oQFqspl013osr+r8DtjLQkEv/0uXto7wQ==@lists.linux.dev
X-Gm-Message-State: AFuF++md+sAaqXJdyJEj1GttmXOMMmsipYRMszBtyKW8R+PKlD/VP4hs
	rS25SDknQaJYkFDDvQbqvXxzqCJkYQCnJ9XVqEJYEJa6cSlVPncw0OKA
X-Gm-Gg: AYBFou0iqrfI6G7zk66rvA4QpPPq01n/CZ7P6F8pZ19I3YWoIVEMsxGCkkBPKuuGUVl
	PLRQSve0+F0Zww5dHLifJ02ifns/Aj2QhfRr6GTyxJViCUkqi+k7YDNLtZgQGXH52aCi1qSnuzT
	l3pky/MI6D79uF3WQseYVgXbuj4GbLSM30MDGBPdt/wMUDLCB/f+nzVpVrrA2Sh16uz3m+CTKDd
	K3Cf3mMiEDbsgGivGpIgvr48FZajQ9vS71ltXy0tpROQ2+0ftbos0v3oZPfEZ5iix5sAAuGpiPU
	QR+CW0okOSuotRvsLEkg3EIm3q5UCDNVK8bbl/rcKrqw9SXxfZiHZVSMfimyq+BNxgifnYQc2wi
	mgc2JAI6SyknPwBneAdp6XoCpvccKs1bsyzApWJRYxeXblgG41At01hjEWouYHZi31PNsaKxSKG
	y0zgAOeU6Ajrgt3uKTQMTQ8x6fhulU6JIZQC5KQV0cYM36fs0IewSUHUiA1wn17WoB
X-Received: by 2002:a05:6122:894:b0:5c7:ebed:1018 with SMTP id 71dfb90a1353d-5c981d87e33mr5580194e0c.8.1789493415229;
        Tue, 15 Sep 2026 10:30:15 -0700 (PDT)
Received: from beelink.. ([187.13.206.89])
        by smtp.gmail.com with ESMTPSA id 71dfb90a1353d-5c9989fa82esm153202e0c.4.2026.09.15.10.30.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 15 Sep 2026 10:30:14 -0700 (PDT)
From: Aldo Ariel Panzardo <qwe.aldo@gmail.com>
To: Luigi Leonardi <leonardi@redhat.com>,
	Stefano Garzarella <sgarzare@redhat.com>
Cc: Bobby Eshleman <bobbyeshleman@meta.com>,
	davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	horms@kernel.org,
	virtualization@lists.linux.dev,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	stable@vger.kernel.org,
	Aldo Ariel Panzardo <qwe.aldo@gmail.com>
Subject: Re: [PATCH v2] vsock: ignore empty child namespace mode writes
Date: Tue, 15 Sep 2026 14:29:33 -0300
Message-ID: <20260915172952.3174810-1-qwe.aldo@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260915141547.3010692-1-qwe.aldo@gmail.com>
References: <20260915141547.3010692-1-qwe.aldo@gmail.com>
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Hi Luigi, Stefano,

Thanks for taking a look.

Luigi — nothing fancy, I was just reading sysctl handlers and
noticed that __vsock_net_mode_string() bails early on a zero-length
write without touching new_mode. Since the child mode can only be
set once, an empty write that sneaks through locks it with whatever
was on the stack. CONFIG_INIT_STACK_ALL_ZERO hides the whole thing,
which is probably why nobody hit it in practice.

Stefano — yeah, makes more sense to bail before calling the helper
at all. Fixed in v3, and I added the CCs I missed.

Cheers,
Aldo
