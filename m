Received: from out199-14.us.a.mail.aliyun.com (out199-14.us.a.mail.aliyun.com [47.90.199.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CF2716F2F2;
	Thu, 28 Nov 2024 03:12:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=47.90.199.14
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732763537; cv=none; b=e+gPZUT4zC1I+C2SYfBwvLR4SYza6HVisVFLebwXa1szis9yrPYemkxEitXmY7WjHxWeUebyxS9+g+Foo9ahjFjW9iWJxwLVXObSNpt29PB0oNeKN+KqasabuwrkM/9t7cqGCGLbDNvXvSwOGb61867/5vbdE2g+TZ4J/1vGLCc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732763537; c=relaxed/simple;
	bh=g8JJAJlUvP8YzoIEcLORQPdsG+CbSntTqAdUb6tYJIE=;
	h=Message-ID:Subject:Date:From:To:Cc:References:In-Reply-To; b=QiNlk1JuJFE10hmpzEzrGV7HF/10O4cjkAqZX9C3NCZNbbUTbAgTrV6pYAtByED5+SpDpgPFdiaDwWMHAx4E6NAwIXAGBM0aJbNyzfEIrqvDoLK69CzIvg/nnOW+etSQz5cjmwE8oZcMUKmPI9iQiDMLeXoUfIyNj8At67FgWfY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; spf=pass smtp.mailfrom=linux.alibaba.com; dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b=JtcHRSMD; arc=none smtp.client-ip=47.90.199.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b="JtcHRSMD"
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1732763517; h=Message-ID:Subject:Date:From:To;
	bh=tmeqebB5HPloXn2Zv0PoMaJ6A6Q7GYB/buoOXLLVkx8=;
	b=JtcHRSMDQEgWTSV0za6PwzjcV7oerb+KFiSNIK1m4XupiiTom8yL/HE1BF7xE9BbsrvXUxFYQfEEro9t8+UCGFthKpLbbo21I3DM01cTbWIm+3iu7wDikar7EowNyKNCzWGUXg5acku7dxpCjq2MGF7fN+tRqrqq9XOEUpT1iRs=
Received: from localhost(mailfrom:xuanzhuo@linux.alibaba.com fp:SMTPD_---0WKO3-e9_1732763516 cluster:ay36)
          by smtp.aliyun-inc.com;
          Thu, 28 Nov 2024 11:11:56 +0800
Message-ID: <1732763459.0668714-1-xuanzhuo@linux.alibaba.com>
Subject: Re: drivers/virtio/virtio_ring.c:1162:11: error: 'struct vring_virtqueue' has no member named 'premapped'
Date: Thu, 28 Nov 2024 11:10:59 +0800
From: Xuan Zhuo <xuanzhuo@linux.alibaba.com>
To: Naresh Kamboju <naresh.kamboju@linaro.org>
Cc: "Michael S. Tsirkin" <mst@redhat.com>,
 Jason Wang <jasowang@redhat.com>,
 eperezma@redhat.com,
 Sasha Levin <sashal@kernel.org>,
 Dan Carpenter <dan.carpenter@linaro.org>,
 Anders Roxell <anders.roxell@linaro.org>,
 Arnd Bergmann <arnd@arndb.de>,
 virtualization@lists.linux.dev,
 open list <linux-kernel@vger.kernel.org>,
 lkft-triage@lists.linaro.org,
 Linux Regressions <regressions@lists.linux.dev>
References: <CA+G9fYsF3x+ZXURQmgA1yQj-eiobr378HbodpJf4ncng7QYXmg@mail.gmail.com>
In-Reply-To: <CA+G9fYsF3x+ZXURQmgA1yQj-eiobr378HbodpJf4ncng7QYXmg@mail.gmail.com>
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>

On Wed, 27 Nov 2024 13:30:59 +0530, Naresh Kamboju <naresh.kamboju@linaro.org> wrote:
> The following build errors were noticed for arm64, arm, x86_64 and riscv.
>
> First seen on Sasha Linus-next 441d2975754ad94f3ce2e29f672824bc2dc5120c.
>   Good: 07e98e730a08081b6d0b5c3a173b0487c36ed27f
>   Bad:  441d2975754ad94f3ce2e29f672824bc2dc5120c

There maybe one conflict between net-next and vhost, how did you handle it?

Thanks


>
> arm64, arm, riscv and x86_64:
>   build:
>     * clang-19-defconfig
>     * gcc-13-defconfig
>     * clang-19-lkftconfig
>     * gcc-13-lkftconfig
>
> Reported-by: Linux Kernel Functional Testing <lkft@linaro.org>
>
> Build error:
> ---------
> drivers/virtio/virtio_ring.c: In function '__vring_new_virtqueue_split':
> drivers/virtio/virtio_ring.c:1162:11: error: 'struct vring_virtqueue'
> has no member named 'premapped'
>  1162 |         vq->premapped = false;
>       |           ^~
> drivers/virtio/virtio_ring.c:1163:11: error: 'struct vring_virtqueue'
> has no member named 'do_unmap'
>  1163 |         vq->do_unmap = vq->use_dma_api;
>       |           ^~
> make[5]: *** [scripts/Makefile.build:229: drivers/virtio/virtio_ring.o] Error 1
>
> Build image:
> -----------
> - https://qa-reports.linaro.org/lkft/sashal-linus-next/build/v6.11-25212-gbe03d2e1a06f/testrun/26081256/suite/build/test/gcc-13-lkftconfig-rcutorture/log
> - https://qa-reports.linaro.org/lkft/sashal-linus-next/build/v6.11-25212-gbe03d2e1a06f/testrun/26081256/suite/build/test/gcc-13-lkftconfig-rcutorture/history/
> - https://qa-reports.linaro.org/lkft/sashal-linus-next/build/v6.11-25212-gbe03d2e1a06f/testrun/26081256/suite/build/test/gcc-13-defconfig/history/
> - https://storage.tuxsuite.com/public/linaro/lkft/builds/2pPghaTDWgXtaR5FXfFS4Ay3d4C/
>
> $ git log --oneline
> 07e98e730a08081b6d0b5c3a173b0487c36ed27f..441d2975754ad94f3ce2e29f672824bc2dc5120c
>  -- drivers/virtio/virtio_ring.c
>    441d2975754ad Merge tag 'for_linus' of
> https://git.kernel.org/pub/scm/linux/kernel/git/mst/vhost into
> linus-next
>    a49c26f761d2b virtio: Make vring_new_virtqueue support packed vring
>
> Steps to reproduce:
> ------------
> - tuxsuite build \
>     --git-repo https://git.kernel.org/pub/scm/linux/kernel/git/sashal/linus-next.git
> \
>     --git-sha be03d2e1a06f7bd4be131c48f1c5555e83470a4d \
>     --target-arch arm64 \
>     --toolchain gcc-13 \
>     --kconfig https://storage.tuxsuite.com/public/linaro/lkft/builds/2pPghaTDWgXtaR5FXfFS4Ay3d4C/config
>
> metadata:
> ----
>   git repo: https://git.kernel.org/pub/scm/linux/kernel/git/sashal/linus-next.git
>   git sha: ed9a4ad6e5bd3a443e81446476718abebee47e82
>   kernel config:
> https://storage.tuxsuite.com/public/linaro/lkft/builds/2pPghaTDWgXtaR5FXfFS4Ay3d4C/config
>   build url: https://storage.tuxsuite.com/public/linaro/lkft/builds/2pPghaTDWgXtaR5FXfFS4Ay3d4C/
>   toolchain: gcc-13, clang-19 and clang-nightly
>   config: defconfig, lkftconfig
>   arch: arm64, arm, x86_64 and riscv
>
> --
> Linaro LKFT
> https://lkft.linaro.org
