Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BF89230F53E
	for <virtualization@lists.linux-foundation.org>; Thu, 18 Sep 2025 15:01:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=140.211.166.137
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758207683; cv=none; b=tLBBE5WVAjVyMjIa1BLYEdBt9nURt51EFL6Q8dv434WjqFCQxCCgBUYvWhjheE5js3qh69FziIkjrctbV1SP32bGA/dpDV8lHjO/XcNCZNgSXLPcpkEpl3i9uXsJ/NnNbPa31Z96uwl/2tQWixqX3pCYbXD6W+YCRI1p8ViV+Ms=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758207683; c=relaxed/simple;
	bh=hm0HQnFHDuepzpar3SZ/hafXRi94TxogLGocQLL+sSo=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=dW69pl9tIv9rOfECcn/clZECYM4JNJXQrvSddPFp5noBWQAXJVNxePJHJre9RKZ64eJIizS9qeoKoS8Jl1Bw0g2BHPgfCAfgTPBXdbKD2PIk/WeJvLHIEvozo6K3jwqzydYQLbUIBi9WINy+kaUESkAFBGKCbXzYiQeB7JoNJoc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=MtTLlEGq; arc=none smtp.client-ip=140.211.166.137
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="MtTLlEGq"
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 42F5540DF4
	for <virtualization@lists.linux-foundation.org>; Thu, 18 Sep 2025 15:01:21 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
X-Spam-Flag: NO
X-Spam-Score: -9.601
X-Spam-Level:
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id KXwS4QnnjCZM for <virtualization@lists.linux-foundation.org>;
 Thu, 18 Sep 2025 15:01:20 +0000 (UTC)
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=2607:f8b0:4864:20::64a; helo=mail-pl1-x64a.google.com; envelope-from=3vb7maaykahcnzviexbjjbgz.xjh@flex--seanjc.bounces.google.com; receiver=<UNKNOWN> 
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp4.osuosl.org 6681340BC1
Authentication-Results: smtp4.osuosl.org; dmarc=pass (p=reject dis=none) header.from=google.com
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org 6681340BC1
Authentication-Results: smtp4.osuosl.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20230601 header.b=MtTLlEGq
Received: from mail-pl1-x64a.google.com (mail-pl1-x64a.google.com [IPv6:2607:f8b0:4864:20::64a])
	by smtp4.osuosl.org (Postfix) with ESMTPS id 6681340BC1
	for <virtualization@lists.linux-foundation.org>; Thu, 18 Sep 2025 15:01:18 +0000 (UTC)
Received: by mail-pl1-x64a.google.com with SMTP id d9443c01a7336-268141f759aso11170225ad.2
        for <virtualization@lists.linux-foundation.org>; Thu, 18 Sep 2025 08:01:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1758207676; x=1758812476; darn=lists.linux-foundation.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=3jaAVY6WwUqvQw+1OWwzrgyRuZwO/IzJmVcJETm6qRc=;
        b=MtTLlEGqFlJrvzGoI/b+mjhe9qraLl+wSd0ZL9IOd0cLbiiM6dRwBqyddfgsdLtMQJ
         68Aem+xWtRcHAGHKHnII9/22yxlD7hD+iYGWaI8odRVwZ5FFQMolRXOBUKMZX9/01BbS
         qaEh+uSSleAr7Pz/XBRJvuTexhCHx7aj9mUjp9torZ/nBzP0PFJeGo0j9w1gVv8CdlQX
         q1B5pjfxWRG4QWBPKL7AsnjaebU4oklNYLsa8FLtJaKC4lzNmjCdNL0nW4aTO/+D5/mH
         tfklIP4dY9pwcfnSu0mAPk/6xrCq6t99bJVQqUP/ipWRkIMj7Vy6ZEcvv3jcjBosD5uI
         oLuQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758207676; x=1758812476;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=3jaAVY6WwUqvQw+1OWwzrgyRuZwO/IzJmVcJETm6qRc=;
        b=ksWWb/6WXWRXliUzmEL71osh55YLCjzz4lDSD9nOQcEYlw/uB6Fi/1GGV2UdRIQ+oW
         tpEmhPbrdckHu50YBPjoXhSCoXYYCiLeTlw1aa4/qMFLclLoW206FWAbfG2am2jdJRQR
         +LhMKpM+m122k5ISRni0Fg8pEUlGILEXEojEIT01WGqDmuNOzUw0TxjL69hX2F29V1fT
         RLHvAnFDnYLB4TLl3d3pZGtH0iwDBopUvwlpfrcUV4llTxvbdNSVb90A34oy2zZW7dNr
         XbtLz+A5KjJ/gVcMI9zebwTB91cKQyQB0J/4Etb/psie9RJ6dNFZ5/6nS0A50jho74GN
         qZmg==
X-Forwarded-Encrypted: i=1; AJvYcCV+DDR+1dVUuYHHCuLrqBL1SeK1op41ufnel9bONyh387JM8qA8o/x5j6XxgLwKefhgooXkE2XViI5sBf7Bng==@lists.linux-foundation.org
X-Gm-Message-State: AOJu0YwlSulAM2Que7r/HIgQpB8qOTMv5U9ZYNfIzu6CJabIse0RaPj1
	7Q21fdqN4NhqSNK9Y9515XeBYlGRrLqTzZjgly/izhsGKG578+dfaZvRkPj9wzoXfsd2QUpsU2D
	KN88kxQ==
X-Google-Smtp-Source: AGHT+IFfK0oDh2ycr/Osr/E7Cn/yD1up1u2d31r7i+s3sYnsD2rX8bDF3WlsXIrIGTtuwXqE52kl8QvwPX0=
X-Received: from pjs1.prod.google.com ([2002:a17:90a:c01:b0:32e:ca6a:7ca9])
 (user=seanjc job=prod-delivery.src-stubby-dispatcher) by 2002:a17:902:da81:b0:269:a23e:9fd7
 with SMTP id d9443c01a7336-269a23ea2c9mr19135195ad.26.1758207676208; Thu, 18
 Sep 2025 08:01:16 -0700 (PDT)
Date: Thu, 18 Sep 2025 08:01:14 -0700
In-Reply-To: <20250918104144-mutt-send-email-mst@kernel.org>
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
Mime-Version: 1.0
References: <20250918104144-mutt-send-email-mst@kernel.org>
Message-ID: <aMweun6GrCSn3lDD@google.com>
Subject: Re: [GIT PULL] virtio,vhost: last minute fixes
From: Sean Christopherson <seanjc@google.com>
To: "Michael S. Tsirkin" <mst@redhat.com>
Cc: Linus Torvalds <torvalds@linux-foundation.org>, kvm@vger.kernel.org, 
	virtualization@lists.linux-foundation.org, netdev@vger.kernel.org, 
	linux-kernel@vger.kernel.org, alok.a.tiwari@oracle.com, ashwini@wisig.com, 
	filip.hejsek@gmail.com, hi@alyssa.is, leiyang@redhat.com, maxbr@linux.ibm.com, 
	stable@vger.kernel.org, zhangjiao2@cmss.chinamobile.com
Content-Type: text/plain; charset="us-ascii"

On Thu, Sep 18, 2025, Michael S. Tsirkin wrote:
> The following changes since commit 76eeb9b8de9880ca38696b2fb56ac45ac0a25c6c:
> 
>   Linux 6.17-rc5 (2025-09-07 14:22:57 -0700)
> 
> are available in the Git repository at:
> 
>   https://git.kernel.org/pub/scm/linux/kernel/git/mst/vhost.git tags/for_linus
> 
> for you to fetch changes up to 549db78d951726646ae9468e86c92cbd1fe73595:
> 
>   virtio_config: clarify output parameters (2025-09-16 05:37:03 -0400)
> 
> ----------------------------------------------------------------
> virtio,vhost: last minute fixes
> 
> More small fixes. Most notably this reverts a virtio console
> change since we made it without considering compatibility
> sufficiently.
> 
> Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
> 
> ----------------------------------------------------------------
> Alok Tiwari (1):
>       vhost-scsi: fix argument order in tport allocation error message
> 
> Alyssa Ross (1):
>       virtio_config: clarify output parameters
> 
> Ashwini Sahu (1):
>       uapi: vduse: fix typo in comment
> 
> Michael S. Tsirkin (1):
>       Revert "virtio_console: fix order of fields cols and rows"
> 
> Sean Christopherson (3):
>       vhost_task: Don't wake KVM x86's recovery thread if vhost task was killed

Gah!  I was too slow.  syzkaller found an issue with this patch.  I _think_ I
know what's going.  If my analysis is correct (wasn't able to repro the issue,
but found a bug through inspection), then I don't think we want to take this for
6.17 as-is.

https://lore.kernel.org/all/aMwdsFGkM-tMjHwc@google.com

>       vhost_task: Allow caller to omit handle_sigkill() callback
>       KVM: x86/mmu: Don't register a sigkill callback for NX hugepage recovery tasks
> 
> zhang jiao (1):
>       vhost: vringh: Modify the return value check
> 
>  arch/x86/kvm/mmu/mmu.c           |  7 +-----
>  drivers/char/virtio_console.c    |  2 +-
>  drivers/vhost/scsi.c             |  2 +-
>  drivers/vhost/vhost.c            |  2 +-
>  drivers/vhost/vringh.c           |  7 +++---
>  include/linux/sched/vhost_task.h |  1 +
>  include/linux/virtio_config.h    | 11 ++++----
>  include/uapi/linux/vduse.h       |  2 +-
>  kernel/vhost_task.c              | 54 ++++++++++++++++++++++++++++++++++++----
>  9 files changed, 65 insertions(+), 23 deletions(-)
> 
