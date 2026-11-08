Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.167.199
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794136288;
	b=R2J4E4IH3tlouYeK/pQHBzl86VbAPnEE7TBT9+HrGWeteTxdw8xlFLNlBuywOZcORBwD
	 5Mx8A0N41VYJoGJmUUK5R04yFxtJ5HLKMHhmoSCvhPGi/vSkNBJKymHQupoUOtw8D3sVc
	 iPSBGQmVnHgo+NEK6G5Jp30VUSFHLMg/76DN/ReU2Mys2mKaJSYSoXtQFOZp9U7yhUvDI
	 MbNjs0lPLoB7DTZ/R1ZLHATDhdT0n9JcmMSHhLEoSugaAsxd1qN3JE5tK7l33wIT/tfUp
	 YVC5SZmBB7VdOUIf1ak10wRiDsUZHdziNbF63lJc1+6Kr9MCG8FQtjh8AS2M3P7nYCw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794136288;
	h=DMARC-Filter:Received:X-Google-DKIM-Signature:X-Forwarded-Encrypted:
	 X-Gm-Message-State:MIME-Version:X-Received:Date:In-Reply-To:
	 X-Google-Appengine-App-Id:X-Google-Appengine-App-Id-Alias:Message-ID:
	 Subject:From:To:Content-Type;
	bh=fHKEKHdPjoZhYVJRZoCAKKckDq3mCm+7VXF61UEPMbE=;
	b=00T6kOtEbmT1U1P0mBoWyTFBz2noWJsnVDtPpA+pnUJGUjW2ISOppcdJdSQxrSkbfcsa
	 qY/D4Brr3zDEAKHz54/LDswgB2AAkDI5XoaNjlsfKpQ1MxjCIpSa8WHS+BJgXBpHRlGSm
	 zZnILY4JMGiAtWq2+6w6ECkrUi4SuJ6lfrIfWrPXkJkr7jl9KxdlB6RIydLaRKMnUZyb9
	 RH6pwLLb2WvsOHeu21GBpIzZ06ayu2t/gVzGO2HiRFN4R67kpOTqIahNzL9zUN/CEF0WX
	 9Z97z2zDV8Pw41FMrvKsnOnGM5qN+69jaq3vQ9eb3bKJvHVaUrxbLGoia79mfdZA68w==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=fail header.from=syzkaller.appspotmail.com;
	spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com;
	arc=none smtp.remote-ip=209.85.167.199
Received: from mail-oi1-f199.google.com (mail-oi1-f199.google.com [209.85.167.199])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 900DE606A321
	for <virtualization@lists.linux.dev>; Sun,  8 Nov 2026 11:11:28 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 900DE606A321
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-oi1-f199.google.com with SMTP id 5614622812f47-5641cd2cc13so20490b6e.0
        for <virtualization@lists.linux.dev>; Sun, 08 Nov 2026 03:11:28 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794136287; x=1794741087;
        h=content-type:to:from:subject:message-id:in-reply-to:date
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=fHKEKHdPjoZhYVJRZoCAKKckDq3mCm+7VXF61UEPMbE=;
        b=ZWmBka/Ps01ggEeEh4yfk99ZBqw8fAYW8ElAy0kMx5MbyNbPXpuoMlh9etLUUoFwm+
         ResrLvANRIN1O387QgEd+gqbQYjFRleyFtDb4Gxa0f8kdTF3r9iHDDOJW6KxvB1U53XJ
         47kiZEUg4081YEMr3PGLhfFPBcCFJuzjafAwJelZFF4DvluMOmvQ+OToEwAZ1PdtzKhH
         VAPKYUmx0VjfHhzgCaY8x6jsnMuqx/QVJA+4K40e6rxxnuWEMySKPlOXM3rDg98S+7gy
         D1ywrJO2UhhnSlSNjYDoJqMBsb9sCBgnf0rFERwTSYr4S7hHThqkT1jtDzkEsffs9wMh
         nNdg==
X-Forwarded-Encrypted: i=1; AL+hErGUk3Wg3DjuuvbRAAB39cCr8pZZQ5t71k5cukqzskhlWnmXw8IcnN3Z21uuFw5yj2t1MRoLexBRxPM1cP5/Rg==@lists.linux.dev
X-Gm-Message-State: APuU4Z8wos45SC4DCcXrOscGVaHeHGZPnS/nOFsDzYTwoxa2B4LeZ8xp
	/ojII3iaeIEJemtXIQJRyx8FDVIQOCDwKs0RWkolYWij4vpTdNB3R28H91AGyTPPqWyedh9Eh/5
	tyVdJ3TSM/+64Rl/BKGmlDZCqRWDVBR028WQkBhGlaIV/P/3lxOChhGf8bPg=
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Post: <mailto:virtualization@lists.linux.dev>
List-Help: <mailto:virtualization+help@lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
List-Owner: <mailto:virtualization+owner@lists.linux.dev>
Precedence: list
MIME-Version: 1.0
X-Received: by 2002:a05:6808:1a0b:b0:567:f6db:8b46 with SMTP id
 5614622812f47-568143a1689mr647675b6e.34.1794136287572; Sun, 08 Nov 2026
 03:11:27 -0800 (PST)
Date: Sun, 08 Nov 2026 03:11:27 -0800
In-Reply-To: <6a6a98ca.86abc875.e5c3d.0057.GAE@google.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <6af058df.f50b2b3a.2c0de7.0007.GAE@google.com>
Subject: Re: [moderation] KFENCE: use-after-free read in virtqueue_get_buf_ctx
From: syzbot <syzbot+0f659760bac1ecb01812@syzkaller.appspotmail.com>
To: david@kernel.org, eperezma@redhat.com, jasowangio@gmail.com, 
	linux-kernel@vger.kernel.org, mst@redhat.com, stable@vger.kernel.org, 
	syzkaller-bugs@googlegroups.com, 
	syzkaller-upstream-moderation@googlegroups.com, 
	virtualization@lists.linux.dev, xuanzhuo@linux.alibaba.com, 
	zhaimingbing@cmss.chinamobile.com
Content-Type: text/plain; charset="UTF-8"

Auto-closing this bug as obsolete.
Crashes did not happen for a while, no reproducer and no activity.
