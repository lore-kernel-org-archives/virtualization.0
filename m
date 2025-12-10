Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 50EE31C6B4
	for <virtualization@lists.linux-foundation.org>; Wed, 10 Dec 2025 02:06:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=140.211.166.136
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765332409; cv=none; b=Sgf61hkA0j/ICKXmQfWjAxjSY+0L4rJdqDKlukNLQSg6dDBIiJxtpukY3NY0NbDNmnxQK5ipznk71S/EW7QlBOd43gBx2BIFMQLRKZp+bhQ2bqR+bFNB9odS/fyhYyz8geIQzqOqczrLwnu+jTOcRJIWzvZ7INTz9lBNaaY/gk0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765332409; c=relaxed/simple;
	bh=dB4MkiK2v7MqEATSP66OXrd0I3cuJgQCFm92qrJ2lJ8=;
	h=MIME-Version:From:Date:Message-ID:Subject:To:Cc:Content-Type; b=p/0p79qqW98h5TF0ZGZ4CpybvIN91A83mS8U/ubURoYJgT5Ywu+13NVui2KNt5xIlLat4p7ELi3cFL8O42DNbzC4UjbGegFJelvzI8rQeScv3NmS3FVIJTCPPtuOwiuLs8fmZeMa4YHW7DOD7chnhJRf3g+FpfhYml8ydrYl4wk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=FG4xmEET; arc=none smtp.client-ip=140.211.166.136
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="FG4xmEET"
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id DB1DF60B07
	for <virtualization@lists.linux-foundation.org>; Wed, 10 Dec 2025 02:06:47 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
X-Spam-Flag: NO
X-Spam-Score: -1.849
X-Spam-Level:
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 9fMfBqZ_Y0_9 for <virtualization@lists.linux-foundation.org>;
 Wed, 10 Dec 2025 02:06:47 +0000 (UTC)
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=2607:f8b0:4864:20::433; helo=mail-pf1-x433.google.com; envelope-from=anhollander516@gmail.com; receiver=<UNKNOWN> 
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp3.osuosl.org 1B37660ADB
Authentication-Results: smtp3.osuosl.org; dmarc=pass (p=none dis=none) header.from=gmail.com
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 1B37660ADB
Authentication-Results: smtp3.osuosl.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20230601 header.b=FG4xmEET
Received: from mail-pf1-x433.google.com (mail-pf1-x433.google.com [IPv6:2607:f8b0:4864:20::433])
	by smtp3.osuosl.org (Postfix) with ESMTPS id 1B37660ADB
	for <virtualization@lists.linux-foundation.org>; Wed, 10 Dec 2025 02:06:46 +0000 (UTC)
Received: by mail-pf1-x433.google.com with SMTP id d2e1a72fcca58-7acd9a03ba9so6817033b3a.1
        for <virtualization@lists.linux-foundation.org>; Tue, 09 Dec 2025 18:06:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1765332406; x=1765937206; darn=lists.linux-foundation.org;
        h=cc:to:subject:message-id:date:from:mime-version:from:to:cc:subject
         :date:message-id:reply-to;
        bh=dB4MkiK2v7MqEATSP66OXrd0I3cuJgQCFm92qrJ2lJ8=;
        b=FG4xmEETXG7D16KtKq1ckafAJi++BWfnZHrjksR74atv/Bok3d066MZAghTZg6b3V8
         HHNGsmmoNU1lJs7f7Z/xtRyTWQ6Zx6K73wM6DHbvtMtKKgFHhRi2xqBVKG47auZOQYTa
         8UVvhB2g0LK3E4+rV+17/ERJzDyxhRl1Hnt6+/6lRqyjAVqBt8CJ6Br3y5nSb9OzqUFD
         s9FR6Ex4h8LttbdcEXtdQ1bcREu1qekhkuaGUeEu756hQs7LMNUmE3lVI9AFWrCyNEhf
         5bBhx1CQz4J28aH17pFhjkgXk2TJsK0m4MiVS0cmYYnxeSvy6alK01eGB2wfZZn8fB8q
         n18g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1765332406; x=1765937206;
        h=cc:to:subject:message-id:date:from:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=dB4MkiK2v7MqEATSP66OXrd0I3cuJgQCFm92qrJ2lJ8=;
        b=Fa1/SDx5sAx8kxH7TJnqY4hdfxMs36YnCTl5ao3RlSXmjQ61f6gVgI26r7y0iLHEdA
         A0WFtPWv5CLamb7u6jl7sSLSnKyDt/Dxa4BvyiKXd1/ZLp56gdQqQIIfwMYasMmQqdX7
         hd4u1X4VrbyV3v245TsWFM9qrkpqR3JviVpk2B1isMFah/ORE7dDB3rcEGjoKB4VYafh
         RdE0EktOumjttqtbs1ce1R9DqS07HorOZNioHuUrrJncLB9tIEPyDJ48a50j0Ttjlwg+
         5sPKiZvOyLGWm7357rjJ7r38T+oiEz1h+r+dZZ0d8Ukqtb7mAsK4T/Vx1OBTwUYIDyt7
         b7Qw==
X-Forwarded-Encrypted: i=1; AJvYcCWMH5g1GcFlb1aSpgRQdqoukdglq37ENntKhly5sj8Ji0w5KgUsWs2znDvMO2sje19yCyeHEGteG35ETp3pnA==@lists.linux-foundation.org
X-Gm-Message-State: AOJu0Yzc6wv7wruVVB4t+yjjkNCb66yd32CXXgBTocrhfPSfC5X5thmp
	ouRvXOQZ43LYWWlzQ0vf4HfaDX3HF877PHBRC8hzBBGRb2YnenKDl/yaJbYvo5jX2lQ3Q36TpdU
	/Qt4SmH1P3H3FNy9jfjQ6HGenPoz6IwM=
X-Gm-Gg: ASbGncup2Hh2AEM4G3FT1L2idhoPnJvtwwQAqJ2e+167s8+gry9FYUCzCx9PGQ3edWt
	TsqDW5hCSREkKKiKh9b+5eFKbtAV2QlDydS32I+gCJs59VivJuyYe9ObA6ima1VJIJVcZBZL5Tc
	3I/cdOTySABOQY/+2p3WmWRxJ0tVS9sBZ1MBW/v+aYZ5zbeJt19TRY7/K7wr3cDcimo6tAw1Dme
	K6LBQsYnfqMcFRrWiwuQmi6N/M1WM2EvB/qvGgO1blV6ZcQtEhCyz6CJOtGMYv2UnAWdeuSBvoJ
	I+BlMe1xL/yv7fTV6akniOsuiBBKPPXK+Rbvg+jVTyI/GbAdmh5v5zpTVmMsrY9gZ7yBOcEihar
	FrbXG+uIhhTCYXyo=
X-Google-Smtp-Source: AGHT+IER/q69FCL4HOlCuiPXSy/9N7+BJvlaJ8gV4++EQVcJdhe5QlTVR4toTFk0WEj9Sp4ps54/Zo8eUBI6B3SlAAg=
X-Received: by 2002:a05:7022:412:b0:11e:3e9:3e9a with SMTP id
 a92af1059eb24-11f296f4d4dmr601926c88.50.1765332406102; Tue, 09 Dec 2025
 18:06:46 -0800 (PST)
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
From: Avraham Hollander <anhollander516@gmail.com>
Date: Tue, 9 Dec 2025 21:06:35 -0500
X-Gm-Features: AQt7F2q1xvMw5Tfz9hXQre8HX4NLZBs_1JPIE2kAknJGpjV98GmMptN_Tf5kgB4
Message-ID: <CAP1mzZSH+VPhA5_53+LxSgOZe5JHqFP_uadWTpgTxrEXBc=52Q@mail.gmail.com>
Subject: Re: Bug#1054514: linux-image-6.1.0-13-amd64: Debian VM with qxl
 graphics freezes frequently
To: carnil@debian.org
Cc: 1054514@bugs.debian.org, airlied@redhat.com, daniel@ffwll.ch, 
	dreaming.about.electric.sheep@gmail.com, dri-devel@lists.freedesktop.org, 
	kraxel@redhat.com, linux-kernel@vger.kernel.org, 
	maarten.lankhorst@linux.intel.com, maddog@mir.com, mripard@kernel.org, 
	regressions@lists.linux.dev, spice-devel@lists.freedesktop.org, 
	timo.lindfors@iki.fi, tzimmermann@suse.de, 
	virtualization@lists.linux-foundation.org
Content-Type: text/plain; charset="UTF-8"

This is also happening to me in Debian Trixie, with the current
6.12.57 kernel. I can also test reverting the commit in the near
future if someone else doesn't get to it first. For now I'll just use
virtio-gpu, though it is a little slower.
