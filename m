Received: from mail-io1-f50.google.com (mail-io1-f50.google.com [209.85.166.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B77B51C5D74
	for <virtualization@lists.linux.dev>; Fri, 31 Jan 2025 15:13:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738336427; cv=none; b=lwlgI3GqutWZT8k+bCNT1XSfdPSbfmA4soA/a+nIlVp92MurUgcrd/A2vdTbG1kwlxKieoQzS1P7lcYKKZRoR7K1hXwoVhgS45t5fcOYdht+Hoq46jSuLqlXEOMmUo/Il+B+xef++YkUHJ4kISk0TBr5keMshulNMt+VD2hR1e0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738336427; c=relaxed/simple;
	bh=4gQp82pyQdSv9h4bIaao3v5flWvB/YqaorWgObY4Jfg=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=ZuWi8IpWl1bIbDK3w33TQ3iSmJ6bkkc6aR6vVRe8A8gGjEG1m6Zm0hIdvLRJX18TCaI8bfPFifDuu36HyA3OPIMKt9EQeyAIwZteADWnhVPvXb+pBBY0HQy+/yR7BQgT/Voa1tj63lAYJeUpN0ReMzyteZuFMTAzMK4y7TxOGb0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk; spf=pass smtp.mailfrom=kernel.dk; dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b=HSbYR6ob; arc=none smtp.client-ip=209.85.166.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kernel.dk
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b="HSbYR6ob"
Received: by mail-io1-f50.google.com with SMTP id ca18e2360f4ac-844ee166150so55056139f.2
        for <virtualization@lists.linux.dev>; Fri, 31 Jan 2025 07:13:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20230601.gappssmtp.com; s=20230601; t=1738336425; x=1738941225; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=U+9HC8EV1wWIoNgKbafn8wjlhkFnTml5y5fJi9ZNauA=;
        b=HSbYR6obCGf+beVuXDm08xJGas4qKGnF+54tcctFI0CMGaaH0RREmEa5ZSOzPXcUWx
         dzNYx1dQ2clI2mChL1gkziirRup6tSdUZ/B0MX0+F5eMqPdUpI8XPGgK9iEulbQL2wAg
         f7Iugnan0GaABOB9SMokvDJluWdSMJ43m2s+O9VVvKXQ1PcoJzkh/JRvUDZwVhE8CG9N
         a39UDpFfHKLyPZ6DAJo8epqVxWn4C5pfl6u2t14DGqef0jBeGQc5sYG9SwyQwi+L7uPO
         37S198kVXpR4Z0MqisuGQs1bnHbJCuVncv2H9x7vhaoBz0FH6IIN9hk9zs1Z/fuDwUKX
         6eRw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1738336425; x=1738941225;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=U+9HC8EV1wWIoNgKbafn8wjlhkFnTml5y5fJi9ZNauA=;
        b=pWlSLTtXykWft5r1UZ6+ZasxmLZ5O/UT6Cwm585rzYVvDNWJtiaOVvQrOtJNhy9NxN
         NCfsLNsc108HhqZarAz5m7ryP02DNO7weGtIFJtlysb/wCdVLN4yGZKqNQaaCUBpx5Cy
         4XU771WFy99rexZZV1YD18PBpmSA1E0rkk/16i9PIcoFwKV0X/VuGm40/acEhl1Fmcup
         XmA6xn9nGJc2HSEU4JVjOpfGJz1tTB2E+uZsipTSUJ4OQeNCJ/oeln0r7oof8u+Yqzgk
         goW4mxz0jYj7P3i8NoVitjoirwG8Pi+QvsYhADiTz8YnwMs+UEuXIxI0RkjDOMPr2KKr
         fNGQ==
X-Forwarded-Encrypted: i=1; AJvYcCXS3PfQWent/m59yzOvZJ1C22DrcAdccbN0vIC25TEPvqTT9Tf4clVqGIoPVyDcURtgsq+93rDOWlImiZcVBA==@lists.linux.dev
X-Gm-Message-State: AOJu0Yw1KOx8xXLACfhPYKnoBKzHYxiK773yWymJo4m1ufo7xCNLrZ+u
	Irhr5kiH2OO9yBZ9q6sEP/Xtgpt4HbLDf4nzPozfA8bPAUeu8ltAtrV+FIfE/iw=
X-Gm-Gg: ASbGncsm18YQUpErTP8NxY5LFMrNaw1vNeyr0XmVubZdop3sXgVQy6Da9FZRnnSl63U
	XLI52E8EYRl9EJI0D7J2Ze0y2Q+wez5hvOX9XKwAY1C36/GlM1CqIgU4hVIBT15ePJPccOG9GH2
	Yj/5yZn8sEMKvJftFF9mELO75UdV9p/lz+whv5lXf8r8XKCUSDSiOUe8EQulIXCvcjm37fW7tHl
	s5ELHxKnAEUcExj2nWctmwvvwg10she8wBA6DntgrcUZFRbhJLxQlIi+7z5hJwHxb7F45YSQiL0
	MQCN1A==
X-Google-Smtp-Source: AGHT+IHdBYkV/Lcjpt9Dx2u2hBI2V53NbB2KTd/PWwFq4iCV5vqkwpfG1ZQm3S6I8vweH0IHJRW4Uw==
X-Received: by 2002:a05:6602:6406:b0:843:ea9a:acc4 with SMTP id ca18e2360f4ac-85427e24fa1mr1154985639f.8.1738336424835;
        Fri, 31 Jan 2025 07:13:44 -0800 (PST)
Received: from [127.0.0.1] ([96.43.243.2])
        by smtp.gmail.com with ESMTPSA id 8926c6da1cb9f-4ec746c920dsm856099173.125.2025.01.31.07.13.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 31 Jan 2025 07:13:44 -0800 (PST)
From: Jens Axboe <axboe@kernel.dk>
To: Christoph Hellwig <hch@lst.de>
Cc: Ming Lei <ming.lei@redhat.com>, linux-block@vger.kernel.org, 
 nbd@other.debian.org, ceph-devel@vger.kernel.org, 
 virtualization@lists.linux.dev, linux-mtd@lists.infradead.org, 
 linux-nvme@lists.infradead.org, linux-scsi@vger.kernel.org
In-Reply-To: <20250131120352.1315351-2-hch@lst.de>
References: <20250131120352.1315351-1-hch@lst.de>
 <20250131120352.1315351-2-hch@lst.de>
Subject: Re: [PATCH] block: force noio scope in blk_mq_freeze_queue
Message-Id: <173833642386.354079.3672902422068183900.b4-ty@kernel.dk>
Date: Fri, 31 Jan 2025 08:13:43 -0700
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.14.3-dev-14bd6


On Fri, 31 Jan 2025 13:03:47 +0100, Christoph Hellwig wrote:
> When block drivers or the core block code perform allocations with a
> frozen queue, this could try to recurse into the block device to
> reclaim memory and deadlock.  Thus all allocations done by a process
> that froze a queue need to be done without __GFP_IO and __GFP_FS.
> Instead of tying to track all of them down, force a noio scope as
> part of freezing the queue.
> 
> [...]

Applied, thanks!

[1/1] block: force noio scope in blk_mq_freeze_queue
      commit: 1e1a9cecfab3f22ebef0a976f849c87be8d03c1c

Best regards,
-- 
Jens Axboe



