Received: from mail-wm1-f50.google.com (mail-wm1-f50.google.com [209.85.128.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 998FD3D3CF9
	for <virtualization@lists.linux.dev>; Wed, 11 Mar 2026 10:47:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773226062; cv=none; b=ryWpbuFERLwj58Vl1+IK/SBP+dng6EIvMv2dbQ7wHwE7hqvI/XvnQtG8PBFTlyJQ2+x9gOolXiLx7pNnRym87rXUc0Hc3vOmpOVZmXluKd92VlvRWz67prxHnwvfZ89BImI++Czq52OarSuFF2X+Rtm60ocU5k1Jgxfm2tkU5cI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773226062; c=relaxed/simple;
	bh=zRCIOZXGAulewyBbqGE0TlQlTPqeFeIDTbPGyy24MV0=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=M/Kvey38hxllltljXfUMcc0Q0tWF+/5PyKrN9phktKQxGWnHkG3ATtbdm6KS0CpsAme7GrSDTLiT9fBCVdIL57ALELxUEsO1pj0IgxmWrCUGRlRMNdO7Et2C3DSFDYEl0Y2ARDIs2wdfyOtsmkSOaIdm1vxK5oWecDvWPZ648R4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=aU3dKPp2; arc=none smtp.client-ip=209.85.128.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="aU3dKPp2"
Received: by mail-wm1-f50.google.com with SMTP id 5b1f17b1804b1-482f454be5bso9529155e9.0
        for <virtualization@lists.linux.dev>; Wed, 11 Mar 2026 03:47:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1773226059; x=1773830859; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=us9WYwCiTBLLsk5cVeG22xmuXfkRkjPu0Kbcd1njBZs=;
        b=aU3dKPp2duUrQNET//pjg1VpIJAQ80/CnZsrv0pqjZnHUubIKgP54x0UOCa94ozCHI
         7Ja2CgYBv/SGayR1wmgXqHaAV7TJGJ/GmBZ5fW8uQZzGc9GXWbmpcltqPs0w11qp3ldj
         iof30vpQnpWDL/Zv3sY1ACmip5ibGqXtdNrDFYI2fgOKLO9yu/DHoWS7FssrSJADuUvO
         vL7HrzKIIujN2H6gUF4bgZGBnDWuzHemrsILKMsX5PVuULH4Q89/0IEIYUUc2sqAoHTr
         7IN6DvcsmRFSOp/0YcIaraV3xJpbTR1572BcItKgbJcgqCfhPTMc7A1UZ20JI7QlbAW1
         o+kw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1773226059; x=1773830859;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=us9WYwCiTBLLsk5cVeG22xmuXfkRkjPu0Kbcd1njBZs=;
        b=wppcCamzLvZEdio5ecuQND80LvmRFHmI8Q9J7sddfLEm/h4rTOEtSZLH9kFMnIymTs
         g15vOA49gfM3v9O5lW57LhdKRGyeMVqU6A4NmtdMYcSWD/odtm/w6TBpqYwu/BrUs1iA
         aAf9y9Y/Goqy5SiJbAuhWobCKpVdt3/MFeMEvhm279QmqbW84G8vnYk3O1PAcOzSr8Ja
         4D+O4RJpfhVs0tJ7KT7eQjJmcNq4CxVmlMAQClQl7xGXVb8kIlRjeWZs/Pg0bJ/ihlbe
         45L133CoR2pUmqTxda4JWqodziXdMTYNatxRh45k+oje5spF5onOT8Tk629Crcxdyh7f
         izCw==
X-Forwarded-Encrypted: i=1; AJvYcCVS9PGTEkuFdlUw/KDk5HYJsMhx+2YgbqfDEOPdybDLBwaZkMgb2PwNyFJP84vJude4njgy3Sjwd4xt9BgSag==@lists.linux.dev
X-Gm-Message-State: AOJu0Yyvh/rmYrz/XC3iiTQId7B/U+35KAILje4L7ZSqEflySUcWtPgE
	VSYKvFn5SEOkhzQFr8EBW3gjw5IpIvveT3bP6LQT/YWvuZwpveG9kkq1
X-Gm-Gg: ATEYQzxRdZsiRqThOfOS+Z3oDcY0xivRyojibC/Y+CKpc1tltAa8xKB3fk8zHOBhEVm
	n7pXbvS9QeDwTGMgx02iJLuCZfBZjvB2mUbODTyxiPQTpelkQ4olLY8ReHFGCVYo2dIJIZwQVqV
	+SYvRpBlaP4DiStv5kWY6nZyJ1A+GwhImAD74NY2IOZ097uroieZsk2JYswNyQ3jaksS9UmUnZk
	3oOuwO2dv1S4RpR09CbiR7icJRb6cN0tiQjAZenKtZ0c1aPvrle6zLR1trapf/A50ZCI2BoCnZb
	bimi6tbic66BFAT6mKq7VT0eC74mex3/1sqTZcJueGzu5Y0CoBYGCXttL0GGjcQxXIIx+XkVFAB
	Y32T0f5LkOQAd7C/R6jM5KoJo7WtBJ/29YhdTEwnFct6nwYgPoFfNBFstJbmtBMXmNLhLlQSQfU
	/7Qfru2dpo+Pf3Egz5k2Lw4N0m7lEjZJrHnIi5VXc7PQylYSnJ7wHFMuAICEQou5Sm4SyPmOpZ8
	LE=
X-Received: by 2002:a05:600c:5298:b0:479:13e9:3d64 with SMTP id 5b1f17b1804b1-4854b291dc2mr30148705e9.15.1773226058755;
        Wed, 11 Mar 2026 03:47:38 -0700 (PDT)
Received: from pumpkin (82-69-66-36.dsl.in-addr.zen.co.uk. [82.69.66.36])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-439f820a2f1sm5725154f8f.30.2026.03.11.03.47.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 11 Mar 2026 03:47:38 -0700 (PDT)
Date: Wed, 11 Mar 2026 10:47:36 +0000
From: David Laight <david.laight.linux@gmail.com>
To: Christian Brauner <brauner@kernel.org>
Cc: Linus Torvalds <torvalds@linux-foundation.org>,
 linux-kernel@vger.kernel.org, linux-modules@vger.kernel.org,
 linux-nfs@vger.kernel.org, bpf@vger.kernel.org, kunit-dev@googlegroups.com,
 linux-doc@vger.kernel.org, linux-trace-kernel@vger.kernel.org,
 netfs@lists.linux.dev, io-uring@vger.kernel.org, audit@vger.kernel.org,
 rcu@vger.kernel.org, kvm@vger.kernel.org, virtualization@lists.linux.dev,
 netdev@vger.kernel.org, linux-mm@kvack.org,
 linux-security-module@vger.kernel.org, Christian Loehle
 <christian.loehle@arm.com>, linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH v2 1/2] kthread: remove kthread_exit()
Message-ID: <20260311104736.51b53405@pumpkin>
In-Reply-To: <20260310-work-kernel-exit-v2-1-30711759d87b@kernel.org>
References: <20260310-work-kernel-exit-v2-0-30711759d87b@kernel.org>
	<20260310-work-kernel-exit-v2-1-30711759d87b@kernel.org>
X-Mailer: Claws Mail 4.1.1 (GTK 3.24.38; arm-unknown-linux-gnueabihf)
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Tue, 10 Mar 2026 15:56:09 +0100
Christian Brauner <brauner@kernel.org> wrote:

> In 28aaa9c39945 ("kthread: consolidate kthread exit paths to prevent use-after-free")
> we folded kthread_exit() into do_exit() when we fixed a nasty UAF bug.
> We left kthread_exit() around as an alias to do_exit(). Remove it
> completely.
...
> -#define module_put_and_kthread_exit(code) kthread_exit(code)
> +#define module_put_and_kthread_exit(code) do_exit(code)

I'm intrigued...
How does that actually know to do the module_put()?
(I know it does one - otherwise my driver wouldn't unload.)

The corresponding try_module_get(THIS_MODULE) is done before the
kthread_run() (and has to be 'put' if that fails).
So there is an explicit 'get' but an implicit 'put'.

While a loadable module that creates a kthread usually needs to give
the kthread a reference to its module and then have that reference
released as the kthread exits, I can imagine cases where that isn't true.
(Or broken code that just hopes the module won't be unloaded just
as the kthread exits.)

It actually makes me think that module_put_and_exit() ought to have
a 'module' parameter.
Or, perhaps, kthread_create() should have the module parameter and
hold a reference to that module until it exits.

	David
