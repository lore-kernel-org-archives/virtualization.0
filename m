Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EE54213A3ED
	for <virtualization@lists.linux-foundation.org>; Fri,  1 Aug 2025 21:21:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=140.211.166.136
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754083299; cv=none; b=ZSHyGtEXADT1hISM8T0GvVnlGTwg7S63kAiE8Cw2u3oansuByKySOutKm6Jyt9IQ6T2NFsSIkYjLgZAZxC28V6yII0nFIDkQj+5KeuWTZxZJXV1T/6YmHcVXX3Plwl1fmLgCG9wP8XBV+u6HM9wudsN5vP9hg41H5xxLq1qGrws=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754083299; c=relaxed/simple;
	bh=8Kri1HoPuh6lwB0F7qiPiOrJzYKY+av4+R1JiwsLGGY=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=thdiNNOjD6PY8XJydu/52O2N4kvabRAYjVp7sVezR/b8KkELrNTY9QRBEdpm9f/D1j9bAR0y4rEH+sYdA/dMA2TQFK2uJMyZft/Y0s5qRdTwG4+XvAAwDDfIY7Of02Sn++BvpGLvQEQSFyyx4VkYV6rDjpNwDcht775gSnWL1Ws=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b=bgvG2i0s; arc=none smtp.client-ip=140.211.166.136
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="bgvG2i0s"
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 77E01608D7
	for <virtualization@lists.linux-foundation.org>; Fri,  1 Aug 2025 21:21:37 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
X-Spam-Flag: NO
X-Spam-Score: -1.751
X-Spam-Level:
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id YYqv2gbVKrdB for <virtualization@lists.linux-foundation.org>;
 Fri,  1 Aug 2025 21:21:37 +0000 (UTC)
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=2a00:1450:4864:20::535; helo=mail-ed1-x535.google.com; envelope-from=torvalds@linuxfoundation.org; receiver=<UNKNOWN> 
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp3.osuosl.org A63176069D
Authentication-Results: smtp3.osuosl.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org A63176069D
Authentication-Results: smtp3.osuosl.org;
	dkim=pass (1024-bit key, unprotected) header.d=linux-foundation.org header.i=@linux-foundation.org header.a=rsa-sha256 header.s=google header.b=bgvG2i0s
Received: from mail-ed1-x535.google.com (mail-ed1-x535.google.com [IPv6:2a00:1450:4864:20::535])
	by smtp3.osuosl.org (Postfix) with ESMTPS id A63176069D
	for <virtualization@lists.linux-foundation.org>; Fri,  1 Aug 2025 21:21:35 +0000 (UTC)
Received: by mail-ed1-x535.google.com with SMTP id 4fb4d7f45d1cf-615622ed677so3629701a12.1
        for <virtualization@lists.linux-foundation.org>; Fri, 01 Aug 2025 14:21:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google; t=1754083294; x=1754688094; darn=lists.linux-foundation.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=BOAZkZ18mJY5AP4pAaTQp2Y2a24YFEEDzHLPHw5UlIc=;
        b=bgvG2i0s5cXvHfO8QS+Q7FgrllNn66+LY06jCUdxGL3c1cZgobZjFk8EAxr2nvpO0M
         Q/BR+EwDnyQrydr9ed6LjcKSU86JB357KcC/+MDBSTnjTUwgYDNBK3ZTHmz5h84YEI0C
         CMqv07CTc2mgXEo/iKgCQSxdJtk40LJlUM5g8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1754083294; x=1754688094;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=BOAZkZ18mJY5AP4pAaTQp2Y2a24YFEEDzHLPHw5UlIc=;
        b=OVXutST1s094MPPuXCPmUzzu96g6o86xc24G5JPMjfHjZs1zg2h/t3fWvzg4WToyI3
         E5OjzCRdelJwXl7xLQwA97x4ICrKf4+NCiz/OTaXDZqJRBwsbVI+hCtL/knzsGv+O8QA
         OpEgPrRT9hIyU+LUxoUQZyVrEXJQfWnaPdiM/S2RtJLU4GzDwK06hnt7Pk9d7P3NZ5Ep
         vjC8hKYEbaVFhwkKg4JiBBG83530rB8BKKdHQTQrwGWSCOeImZiubiPXxt6I1lXce8tQ
         W2AKxxJCj0kAaANzeULHBWTcpClCaKLy6KevLZrfVwlCB2NSltEVmNQG+zduaLtWY2Ot
         yfEw==
X-Forwarded-Encrypted: i=1; AJvYcCUr7fErcnFJrwTHwWHOYFEYNZmzrEHAj74sW3nNOVIkTnnraTI/5ETL513Mzz9sK6OpLLmC5J5cTB6uBynpqg==@lists.linux-foundation.org
X-Gm-Message-State: AOJu0YzUlOC/8X6AoVoheKb4iV8aZDveDLgnW39p1fGeLN7WWh1tr1re
	5z1Z0pYCQ9d2YcsHQhvbYCr+79aS/LAKv+mtm4C5aSsGlB5hB55RiJ0/IdYL/H3mxKC4hnTLJx3
	1R566c3hiwg==
X-Gm-Gg: ASbGncsG03g5WmIe/Z7ieDobvXjLEbkwEpJjsVfuyMgUaanmux3GpYMp/PGJtxAnvT8
	t2xZOrP0fexrRhG97DQfyOIZhRkX1tQmC9Wfam/bNPh4jZC9YCjEe3TKVrm3AtOfjjUSBvLuNLB
	tpDxf/mNNyZoKNeTJGzoAiF74N7xFMbfmD8X13kgI72ReRTeumotEdFuHbQ4kL7h/1VJKR0KQ5P
	gX2Tz9NQAEA5/Ir3+8kJBK+vAd5vo9FFQ9xlDw09VfZLa8jm7yzD93m/US64NgW6W3+I8hNZnVs
	kI5dqZFm6HQxakczD2/ONWTLyf29KRGpxBZHOmYQYp1YQPjzj0rLsFLn2AmQrt9RW7VCBjsvSTI
	FqTWEf8AIeoCKnDMa/2wSaePT6dBK6vXoAsaOEkhDXb7Wa+hArMQo3n9/WMOh5imjPIzSPtzf
X-Google-Smtp-Source: AGHT+IFGHWuWvjrCNUGWxkVgg9Rkf1Wl8hw3IKk23ebwyq7bi0gisfoLw2xnrYE1kE54BKC6SBelow==
X-Received: by 2002:a17:906:7956:b0:ae3:a812:a780 with SMTP id a640c23a62f3a-af940253a5dmr118101466b.61.1754083293807;
        Fri, 01 Aug 2025 14:21:33 -0700 (PDT)
Received: from mail-ed1-f50.google.com (mail-ed1-f50.google.com. [209.85.208.50])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-af91a0a3149sm336103366b.38.2025.08.01.14.21.32
        for <virtualization@lists.linux-foundation.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 01 Aug 2025 14:21:33 -0700 (PDT)
Received: by mail-ed1-f50.google.com with SMTP id 4fb4d7f45d1cf-615622ed677so3629667a12.1
        for <virtualization@lists.linux-foundation.org>; Fri, 01 Aug 2025 14:21:32 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCUJCK7pVX5nRHtS7/Hn4HXXl4f/0+vtVjW29yvCRgSAQQTIc4Cltd0Ii/A+aMkXcWdQrcFiRJL52BvGl0YBZw==@lists.linux-foundation.org
X-Received: by 2002:a17:907:3f99:b0:ae3:6657:9e73 with SMTP id
 a640c23a62f3a-af9400844fbmr144333466b.20.1754082923387; Fri, 01 Aug 2025
 14:15:23 -0700 (PDT)
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
References: <20250801091318-mutt-send-email-mst@kernel.org>
 <CAHk-=whgYijnRXoAxbYLsceWFWC8B8in17WOws5-ojsAkdrqTg@mail.gmail.com> <aI0rDljG8XYyiSvv@gallifrey>
In-Reply-To: <aI0rDljG8XYyiSvv@gallifrey>
From: Linus Torvalds <torvalds@linux-foundation.org>
Date: Fri, 1 Aug 2025 14:15:07 -0700
X-Gmail-Original-Message-ID: <CAHk-=wi1sKCKxzrrCKii9zjQiTAcChWpOCrBCASwRRi3KKXH3g@mail.gmail.com>
X-Gm-Features: Ac12FXxTQNyMa37gD218OICz8yv-5X8AXqC2OjqDUUC5iyMABu84wbERpHpCWcY
Message-ID: <CAHk-=wi1sKCKxzrrCKii9zjQiTAcChWpOCrBCASwRRi3KKXH3g@mail.gmail.com>
Subject: Re: [GIT PULL v2] virtio, vhost: features, fixes
To: "Dr. David Alan Gilbert" <linux@treblig.org>
Cc: "Michael S. Tsirkin" <mst@redhat.com>, kvm@vger.kernel.org, 
	virtualization@lists.linux-foundation.org, netdev@vger.kernel.org, 
	linux-kernel@vger.kernel.org, alok.a.tiwari@oracle.com, 
	anders.roxell@linaro.org, dtatulea@nvidia.com, eperezma@redhat.com, 
	eric.auger@redhat.com, jasowang@redhat.com, jonah.palmer@oracle.com, 
	kraxel@redhat.com, leiyang@redhat.com, lulu@redhat.com, 
	michael.christie@oracle.com, parav@nvidia.com, si-wei.liu@oracle.com, 
	stable@vger.kernel.org, viresh.kumar@linaro.org, wangyuli@uniontech.com, 
	will@kernel.org, wquan@redhat.com, xiaopei01@kylinos.cn
Content-Type: text/plain; charset="UTF-8"

On Fri, 1 Aug 2025 at 14:01, Dr. David Alan Gilbert <linux@treblig.org> wrote:
>
> My notes say that I saw my two vhost: vringh  deadcode patches in -next
> on 2025-07-17.

Oh. My bad.

My linux-next head was not up-to-date: I had fetched the new state,
but the branch was still pointing to the previous one.

My apologies - they are indeed there, and I was simply looking at stale state.

So while it's recently rebased, the commits have been in linux-next
and I was just wrong.

                Linus
