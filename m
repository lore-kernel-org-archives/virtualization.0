Received: from mail-ed2-f12.google.com (mail-ed2-f12.google.com [74.125.228.76])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 072904A99AE
	for <virtualization@lists.linux.dev>; Tue, 15 Sep 2026 22:55:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.228.76
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789512919; cv=none; b=sGvlk4lrE/Q9b7otC4qU1zGn5PkM/g2cEFxmf/D+/PJYKDf9nO5l5W7zv1Y223OAM2vk/kUWA6MUWgmjkzFTkbcyIXNX5s+gJucLCr3l3Botv68VtBlIcQZADdaDFRMCboifZcPTgBrK7vSGzGL+xVGHTWAdn3z1NJ83RFzouNE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789512919; c=relaxed/simple;
	bh=ITz7hBythv5OWTbmQ9c4e1mzRPysX2+YTMbCrseTj6Y=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=QGYo+fPq7jEKjY56gAJDlYnrvmY94wbQ81dMfGMLFsQ5gizK9qf4iMSr37fxQhjgETYxtVSizXneXDfsAFXy+YjJ8mFW5Xka+mqjQdCdiva2kpgYSmVuFx+PrfNhZGpVafgYnNrKICxLIzCUKQyCwrd5ZbLgu8Mb6C1li9naTkk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org; spf=pass smtp.mailfrom=linuxfoundation.org; dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b=bJZenX8J; arc=none smtp.client-ip=74.125.228.76
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="bJZenX8J"
Received: by mail-ed2-f12.google.com with SMTP id 4fb4d7f45d1cf-6a605844571so457292a12.3
        for <virtualization@lists.linux.dev>; Tue, 15 Sep 2026 15:55:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google; t=1789512915; x=1790117715; darn=lists.linux.dev;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=7NEEN5klK6sYQ7k8fj+V0z2WeSFVNwjy5fJJIdfiMPQ=;
        b=bJZenX8JXqD6FS78xuoeBBpFYtXcXYcaxsUhNZYXRIEGt7FvL0CP8L8I2YUM7y1A9M
         HKTStPggXWQsj33TyL0dl1WzbF4sF14IsW+5Rjk+LASvrwYfOSn9HD1qR59DYl6laP3G
         o82o1SZbkDvYJ4xth29LXrgScL0gZR2pddhOI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1789512915; x=1790117715;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=7NEEN5klK6sYQ7k8fj+V0z2WeSFVNwjy5fJJIdfiMPQ=;
        b=CXX0NnUlrPqXSVQ/u9QYl2KyFkbDWXZm/kBstbAQH4K8x0IpDSF+Z7kkNfA8jUQNmi
         Wo80CWsMFSndswbBNzL7oM6bXjaerCr6VUb2vq7bPhDRitu0UCNvpPDUvrZYqov6aGWM
         DMsCV12EHv3n7N92j+hXKBJQj7/ZYqS89w7s9LG9/nH1J2gaMDIfHkd/QjtJA4JkK7Yx
         SaDH9lTOrQQMwliZRlfOqc0bBZZmFR5H6IXIS9Wcm0zI4++BGeQWGF1SI0lRkM9en33f
         Gt0XrVm+L8TwhUhZfycDro1+bwLfcZYL/ypmeYOeAx/m8BJF5Tzi0OzyMADipdg6Vy+q
         5dnQ==
X-Forwarded-Encrypted: i=1; AKwUvBx6ENhJU9Ppou88HzZaEoRVYtRcrjU7mOGhan9U21WswHdPvtrS3Q0wh4uxMX9qm9l8b3kWitfuCd2nUgN/lg==@lists.linux.dev
X-Gm-Message-State: AFuF++kYgsmJj12/K4AUHRd5d1QHeJukKWnNX4wL2eqVXQI1Zk3x0Pn3
	DlLXemANGJ/C/DLQV6+WABxzlsDKT/cENZHk+wFVLXdIsKV9Wpdy8TMo7IpDvCV9AfhLh9Y4MNi
	+apWNDMolpw==
X-Gm-Gg: AYBFou2jytdJrAbwf6vqCdsyTQIJit47av4W58NxHeQpPjlCgfbhqlAO2kN5Txik0AF
	7dPk7xOAf1tAjNosEAb42bXyDlbgirezM0YQIrtL8GoV0ceDF2a3zCdIu7qZmVcS+bxC41e6ORq
	dEx+tu38IgmdqsnFsbq3eTswr0zoNAEcgtk6digHwARN2RdsoF7OaA4yrhq7szAQ2DQJ6g183At
	1lDUXizZT3InJt5oL3HUewuHvJeJm7Vq8Ig7YKGQsM/wPWypTVSzfJvCIKyc4ZCvHjzCOEQAN5P
	k4TM+7VnVfz15dB+qLXRAviW6I7+XoaTQWsGBLQN83NHXmy1abMzx21ngip+N+IztTjOp8HBmg0
	r924RkCX9Wu3ticZk+SEBCmpMsaxUXeON9HO9DK2m9ZXTxbjv+ucRE3JEBjrbQ5E9MRL+3XsjBo
	OdAGmqBU5phxnL0lvy3t+D9Z3BnWYmr+O6a9k+C+/8PsV19VODBehd6AHZDfqLMItWeiarXRvff
	f8yw8x/zjNfm6fsFYsPIliuxQmxoO4pplO5XeWLUSotJ3BI
X-Received: by 2002:a05:6402:21c7:b0:6a9:a628:1402 with SMTP id 4fb4d7f45d1cf-6aa22256ae7mr220497a12.6.1789512915193;
        Tue, 15 Sep 2026 15:55:15 -0700 (PDT)
Received: from mail-ed2-f18.google.com (mail-ed2-f18.google.com. [74.125.228.82])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-6aa1d228edfsm386380a12.10.2026.09.15.15.55.14
        for <virtualization@lists.linux.dev>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 15 Sep 2026 15:55:14 -0700 (PDT)
Received: by mail-ed2-f18.google.com with SMTP id 4fb4d7f45d1cf-6a9adea43b6so509029a12.0
        for <virtualization@lists.linux.dev>; Tue, 15 Sep 2026 15:55:14 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AKwUvBxG2qIXzx8bx0DsrqRwgra08gC7OFHBK9ugDpzPZMHZUCFtSlOiPx+hoBtxtuTrK5D7zGfr3ILhsUPTaS/acg==@lists.linux.dev
X-Received: by 2002:a05:6402:5d1:b0:6a9:a6c0:e5ef with SMTP id
 4fb4d7f45d1cf-6aa2244ef06mr218172a12.37.1789512913950; Tue, 15 Sep 2026
 15:55:13 -0700 (PDT)
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
References: <20260915-work-fd-reserve-unify-folded-v1-0-4d5217d6b246@kernel.org>
 <CAHk-=wjeamU=_RYT9cR3dZJ2N-Teo-N1+aYh7jwhrB=iWXD0cg@mail.gmail.com> <CACSVV028AdnTYa6OKDeoJYCau58uTkKMgEdqTn7crNSV8QZxOA@mail.gmail.com>
In-Reply-To: <CACSVV028AdnTYa6OKDeoJYCau58uTkKMgEdqTn7crNSV8QZxOA@mail.gmail.com>
From: Linus Torvalds <torvalds@linux-foundation.org>
Date: Tue, 15 Sep 2026 15:54:57 -0700
X-Gmail-Original-Message-ID: <CAHk-=wjhJF91TCO0Zqeuf+caG2tQZ4AzbLr2qFmRmnMM4dbh4g@mail.gmail.com>
X-Gm-Features: AcwNN1Wx2MaYDtFtmeOlL6MnzYY7doY_FEPpziKatTBWbLOeKsjmritQ5JuAL3M
Message-ID: <CAHk-=wjhJF91TCO0Zqeuf+caG2tQZ4AzbLr2qFmRmnMM4dbh4g@mail.gmail.com>
Subject: Re: [PATCH RFC POC 00/50] file: handle files on syscall exit
To: rob.clark@oss.qualcomm.com
Cc: Christian Brauner <brauner@kernel.org>, Alexander Viro <viro@zeniv.linux.org.uk>, 
	Jann Horn <jannh@google.com>, Jan Kara <jack@suse.cz>, Ingo Molnar <mingo@redhat.com>, 
	Peter Zijlstra <peterz@infradead.org>, linux-fsdevel@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-mm@kvack.org, 
	Oleg Nesterov <oleg@redhat.com>, linux-alpha@vger.kernel.org, 
	linux-snps-arc@lists.infradead.org, linux-arm-kernel@lists.infradead.org, 
	linux-csky@vger.kernel.org, linux-hexagon@vger.kernel.org, 
	linux-m68k@lists.linux-m68k.org, linux-mips@vger.kernel.org, 
	linux-openrisc@vger.kernel.org, linux-parisc@vger.kernel.org, 
	linux-sh@vger.kernel.org, sparclinux@vger.kernel.org, 
	linux-um@lists.infradead.org, Jens Axboe <axboe@kernel.dk>, io-uring@vger.kernel.org, 
	netdev@vger.kernel.org, linuxppc-dev@lists.ozlabs.org, 
	linux-gpio@vger.kernel.org, linux-arm-msm@vger.kernel.org, 
	dri-devel@lists.freedesktop.org, bpf@vger.kernel.org, 
	David Airlie <airlied@redhat.com>, virtualization@lists.linux.dev, kvm@vger.kernel.org, 
	kexec@lists.infradead.org, linux-hyperv@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

On Tue, 15 Sept 2026 at 15:21, Rob Clark <rob.clark@oss.qualcomm.com> wrote:
>
> With fd's it is more than just about error rollback.. exposing an fd
> to userspace mid-way thru an ioctl is an easy security bug to write..

That isn't very common code. It's something that is done by a few
strange cases, and yes, those cases should just do it right.

But "those few cases should do it right" does not mean "make a whole
new subsystem for this thing that makes a simple "open" actually be
slower and stranger".

             Linus
