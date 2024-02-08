Received: from mail-io1-f43.google.com (mail-io1-f43.google.com [209.85.166.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9E8AF1CF91
	for <virtualization@lists.linux.dev>; Thu,  8 Feb 2024 18:32:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707417170; cv=none; b=E4/Ro1Qw/x4Uz7kGvRuSH6gn7RzL1vjyp8DoxLIL88MtanQ8uODQ9MiAfJHWJe6PCPaS6jG2kZwPuS7JGKAjCLyxqA096KAbZat3+/HZdtRHRpdCXN9xf+i9oTAB0S2eq1d8Fmefqain9YITqvWd1ce3R0z5fya7xNFsTYGSRi0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707417170; c=relaxed/simple;
	bh=wHrLFJRfnNXUeGVogN8+9OPpwE8Sci1mCOxtvg4QYxM=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=tWDUYl+m56OgOvETNgW93SzGR0L53ydb7Ho9P+lhP0D0ixsyz6iK4WPVt4Q7QKFpxBSmYZbPpBgho31Svp80whNeiB+XH/lmt4xukEQBJzejZKxbyeFTS0SvUU48xW4va0++V1EXFFut7mTQ5GOCggQrwdgUEnp0ljnnO4PPtcI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk; spf=pass smtp.mailfrom=kernel.dk; dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b=r6cRdLbQ; arc=none smtp.client-ip=209.85.166.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kernel.dk
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b="r6cRdLbQ"
Received: by mail-io1-f43.google.com with SMTP id ca18e2360f4ac-7c427cba7a0so906239f.0
        for <virtualization@lists.linux.dev>; Thu, 08 Feb 2024 10:32:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20230601.gappssmtp.com; s=20230601; t=1707417168; x=1708021968; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=mOhSHI8k2xKwemaGiMogUyPw3fznz8Z4LeXfby4qFPk=;
        b=r6cRdLbQtS/WOFCOghipzmgtQxLtqQ2xwUuW2Bn3o4mh8U1W0f/8oryXCNcUsNUFit
         bCjrOwP4aSEcUiGOv9Wjl0haq1oKPUF51f6IGDWn2QIEQfr54QnBt237mXufzs6hhekB
         35V4OEiJSBMDSgPPDY4W848/rsiuOWz6ZGg8QhhyDrpXzysQkGzw8aZAizTdAYPWBF2Y
         v8NtyBZCIJy4asyp3KaYbEL1ydjO1h9WGhxhN7ly21H+2kPXFhXaNCrL4iOCArP0VsnE
         oe4Mxbnt2M5Obq425hvGSf2M4oLNksCuDCPOv2UcZtmU137Er9Nnx4gCenROv8Hq0bu8
         thPQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707417168; x=1708021968;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=mOhSHI8k2xKwemaGiMogUyPw3fznz8Z4LeXfby4qFPk=;
        b=tTnvUIcI6InZf16OB+yz20f2G3d4H9P+IrWdvpdzSzlICJa6rSsKBLPgpiNjpO92FE
         7ATX568mlMJtWw43jiRXEEZLfZtBNUT/bCakqmnZt2vZb6grIu/s0ahFt9abRBBJo2Pu
         e42a9LuKWyvYH4Ov/Q7VJgA8ReHdhlT7GKELtf4R0EXqQixy478y0+q5QWicq4rKfiXh
         EGWSBOLbBefx+LKCFQ//ds+OZc2rf4ijp0LiC7G9c8v74Dle4xkaYdhtuO32g7NsUG3o
         H3mdguiF2/ouQTQZHoxxICoBSCuIMpOvc2WyxbqodCKmZJhSTdGEn47ThLQ+1x+3gMgN
         KMeQ==
X-Forwarded-Encrypted: i=1; AJvYcCUonqiGsUjfPEp47gpar1I90HDZ5xwbloIWPp06JhnyROlH/Q1iwvocT5cWrxOmFjgDVFUMbIja5jnfQG7mN6oMA6GEYunnTAIRoFsOgCc=
X-Gm-Message-State: AOJu0YwFHttImzkd1A0Uwr21ZbiMtz4IY2/PyNZzIBrRHLOeMNosMOj9
	tuZTlJ+AGhJsxLRhvSIpU3G4ztXndSOAtLQeq3Nu+nZMIfb6AGUORUAXLCnCZ8o=
X-Google-Smtp-Source: AGHT+IFUz3Bw6ISDd3GciQ1PkFFh8jMes3QifdbnhSrBnemaIeE1jkbp9UgMWYTHjwPHgVAExcNiZg==
X-Received: by 2002:a5e:c00f:0:b0:7c3:f2c1:e8aa with SMTP id u15-20020a5ec00f000000b007c3f2c1e8aamr525375iol.0.1707417167749;
        Thu, 08 Feb 2024 10:32:47 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCUFN35oyK3P1Kl19g4DVSeOHdJqd7hNO/fEF+Zn4banyLzmAsUB9dGTmHJlmPGk8rbasaMLmyBct6zafrB+IPmSrFNfMSJmIjvgqC6BIW/sXung/TkbPIraqxtSnUKoxgCzcR1eTIU2rXeLNPkRpe+cBazdeEfW3xUzPh50tskx/g83+xSWNhgagQt8yuHn0rXntnK3Hom2LBu+VnXBS1N6c9T8kjDFqLuqg0OPZQtOqUj4jiLTWT2sLAdc7ngzJBCXRJoTClL/ugYT05us0HGmMECzo0pJ6mIeZnRw6bKwhdGg7yG7Qu64tHQhCjlYr8CdWDwNWF5cl8j0vwggM4B50jjH0wskBEp31CDh/xkNOz6MhRJ0GX6rk+Dv+jWMWPU=
Received: from [127.0.0.1] ([96.43.243.2])
        by smtp.gmail.com with ESMTPSA id t13-20020a6bdb0d000000b007c3fbe781f2sm50823ioc.5.2024.02.08.10.32.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 08 Feb 2024 10:32:47 -0800 (PST)
From: Jens Axboe <axboe@kernel.dk>
To: stefanha@redhat.com, mst@redhat.com, jasowang@redhat.com, 
 Yi Sun <yi.sun@unisoc.com>
Cc: sunyibuaa@gmail.com, hongyu.jin@unisoc.com, zhiguo.niu@unisoc.com, 
 xuanzhuo@linux.alibaba.com, pbonzini@redhat.com, 
 virtualization@lists.linux.dev, linux-block@vger.kernel.org, 
 linux-kernel@vger.kernel.org
In-Reply-To: <20240129085250.1550594-1-yi.sun@unisoc.com>
References: <20240129085250.1550594-1-yi.sun@unisoc.com>
Subject: Re: [PATCH V2] virtio-blk: Ensure no requests in virtqueues before
 deleting vqs.
Message-Id: <170741716688.1391883.2946265788968193577.b4-ty@kernel.dk>
Date: Thu, 08 Feb 2024 11:32:46 -0700
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.12.5-dev-2aabd


On Mon, 29 Jan 2024 16:52:50 +0800, Yi Sun wrote:
> Ensure no remaining requests in virtqueues before resetting vdev and
> deleting virtqueues. Otherwise these requests will never be completed.
> It may cause the system to become unresponsive.
> 
> Function blk_mq_quiesce_queue() can ensure that requests have become
> in_flight status, but it cannot guarantee that requests have been
> processed by the device. Virtqueues should never be deleted before
> all requests become complete status.
> 
> [...]

Applied, thanks!

[1/1] virtio-blk: Ensure no requests in virtqueues before deleting vqs.
      (no commit info)

Best regards,
-- 
Jens Axboe



