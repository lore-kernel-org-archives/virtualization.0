Received: from mail-pl1-f174.google.com (mail-pl1-f174.google.com [209.85.214.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 69CE63ADB89
	for <virtualization@lists.linux.dev>; Tue, 13 Oct 2026 08:58:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791881930; cv=none; b=i2eCUt5Sx/eiLPCdpXPdtOwyACOdaiK238bZKpmSH/TwSQZwFe/1ucIMkKJHZKKfl5UWkyOmn0/OHPoU5Erir3vman6GUJ7DeP3Ynsex02LAqG9PPohNdMAjx2XR6nEmQLM4t0o9HW5fOajahVptKbbx6KRNksE6mifLd4DlIGg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791881930; c=relaxed/simple;
	bh=vTfdCxEdBXHQYMPQG2sI01/Fee10SmTRjVOVPrVV/a4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=SWVe8qC6AOGEKMGZVU11RY4m69aL0W1ZvA9gSEiv0G8ukDFzOZexZ4tVXiNB51PYIjCrmDuzlzz/B8U15K+WUM8+Js89r7rvspyJVBN8yzZ9v20r6BZ48s37iW09muBSdnZYd6iBGUIWzzMloSh/5F01qfFfjhqr4hodo/Mlaac=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=W5CTAjC3; arc=none smtp.client-ip=209.85.214.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="W5CTAjC3"
Received: by mail-pl1-f174.google.com with SMTP id d9443c01a7336-2e8da6ef7ddso8747185ad.3
        for <virtualization@lists.linux.dev>; Tue, 13 Oct 2026 01:58:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1791881929; x=1792486729; darn=lists.linux.dev;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=vTfdCxEdBXHQYMPQG2sI01/Fee10SmTRjVOVPrVV/a4=;
        b=W5CTAjC3n+HHm0vRbznuAJmVYF/QDBe3hXLcFNJWqsCfkO0szOG+lYXBi0tESwws7w
         cw6txgZBoxkdiNPLzUBCKN7rmcSe32dCUejx9sx1JeM+yz4rRGIFsVBGGQVeq4kiY4oi
         Y7cAfBMcp+4N+d53InlPYJYJTxfmiNr9i1BW6wQqHhdPPmCx1clbtRIetBb8UB5IXXTy
         KxFCbYRefo4KPtws5/xKvOb5oxBmzfMtag0HftcSPWl1CUQXadEhpCQOkJTnp1aYy/8c
         6csKWAsNuEYauJsmM3YRRQjJFbkKmg4q7geQoARSCsYGks7wf/3yLHjPzLwpallTjVwk
         Kluw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791881929; x=1792486729;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:date:subject:cc:to:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=vTfdCxEdBXHQYMPQG2sI01/Fee10SmTRjVOVPrVV/a4=;
        b=Bskk/Zw1ePXBW6WCvf+Jeyt3zrk9e6RRfhVmwczPfZOj8wxPreVp66ykeQARwRwn/v
         Ip7XFxCBnjG/AqBIAPKQg+uUAb+4o95vyFLvv0dWrwF2V+XcxJJtJsZpY99+FI2HYHz6
         bFGb3mxvhVA59BeQlbGKsITm+dnNFY4flcwpWN71l36eNwUuq4a6CYlBGHEHJo7LEsHq
         MVoyLymiR+Fu55cZv4xrc6ohd570QFdWhim1omfCWU51hbLHRFW6g9JnBNDOX/57UMSJ
         H+x3J+TvVJOjtuuluL/SIa1vCb/EiL9Ft0QUb4k/4O4CLXgoEuJouaZLtgw5T+oPm43C
         SiVg==
X-Gm-Message-State: AFq9FYK1uahz4RFW9py4c8XAPYbOiE8Lkgat7uv5N31g5YMxoI7R19yK
	EzPVIWi6kA5Rs+fwvJvKB7rukAjYqrVQIODBDScOrvGXYcz1BBZ8vsl8
X-Gm-Gg: AYBFou3DPeBGO653GOqCfW31H4TDQzgJ3IoE+ibVPqYEbTjT/HKmbMvFce3f/jyjJbo
	Z8DqcrE21QqP2RaPxWhj1EXj7gzyjpunoPcQvhxfwRFqttdzKy/2LfdPnHqgFQbSD/ic+XLdtty
	3S+hEYQOXUf62Pwb2Fm6v3KLfdWGG7uywBZsT4YpOGT8IjprZB5T+vIOg7aLrAkcALO+oiCEh7q
	a4Qc3btO+mHrezA7l0gqnK8RvhtoYbkwbyIw5xkJzbTfdYZCfvsVql+ovesQ4uuPEDjQOvKSTtM
	LmZtJFlN00m/3vf69gLQ9DZfn4qkmV5YanQLntEf/u8/+q5U6E6duXTKj3pxAZJLZkqZ5IsD4Hn
	ODdhOSZQEHSrbBE0gOcUTeCgaQZZzXwJdEiim4ZBZ9UruIyPoQjjNLjxmkHPoeUnneHvJ7rOr4R
	mqBmIIXfLULFGip1+zbEUlLJTZaBxK10JyAKdJnxSj0oejXLar/3UbiqIm/r6mViMvjFHMp+2oE
	/2No/Jm1t8x7rLwP1Xp0wYZ/HoVL/PIHDtKK3+AIbiQvwuueVuT7gwS/l9exE4Jdnyd5Zg2Z5dq
	bRhVHI9j7OLQJ8Tc
X-Received: by 2002:a17:902:ce02:b0:2e2:e3aa:7a35 with SMTP id d9443c01a7336-2e842cdbb52mr99456075ad.36.1791881928729;
        Tue, 13 Oct 2026 01:58:48 -0700 (PDT)
Received: from localhost.localdomain ([183.96.175.225])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2e8421b298dsm51354965ad.33.2026.10.13.01.58.42
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Tue, 13 Oct 2026 01:58:45 -0700 (PDT)
From: Joonho Lee <mynameisjune111@gmail.com>
To: sashiko-bot@kernel.org
Cc: virtualization@lists.linux.dev,
	"Michael S . Tsirkin" <mst@redhat.com>,
	Eugenio Perez <eperezma@redhat.com>,
	Takashi Iwai <tiwai@suse.com>,
	linux-sound@vger.kernel.org
Subject: Re: [PATCH v2 2/5] ALSA: virtio: Recover PCM state after a failed start
Date: Tue, 13 Oct 2026 17:58:40 +0900
Message-ID: <179188181241.52451.2155648650411097919@gmail.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <sashiko-outbox-169220@kernel.org>
References: <cover.1791877396.git.mynameisjune111@gmail.com> <sashiko-outbox-169220@kernel.org>
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Thanks for pointing this out. The ALSA stream lock does not cover these
callbacks, so the stopped accesses need the driver's own lock.

In v3, all accesses to vss->stopped use vss->lock, including open, STOP,
hw_params, prepare and the final clear in sync_stop. The RELEASE decision
and stopped=true transition are in one critical section. Allocation,
control-message waits and work cancellation remain outside the spinlock.

The regression catches the unlocked v2 accesses and passes 73 lifecycle
checks with v3. This uses deterministic source instrumentation, not KCSAN.

The updated series is in the new [PATCH v3 0/5] thread.

v3 cover Message-ID: <cover.1791881787.git.mynameisjune111@gmail.com>
