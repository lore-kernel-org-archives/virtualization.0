Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.138
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1795528305;
	b=KpivBjZyUcuyybJmUqaiQV/ASPNDPVFv93Zpnyhe8FwwRZBCHfzJaXe4ulYvoALLS2jP
	 FyVXA6PxztPnIyZ7yefFb6Oy3ONajPM891TAwDjVl3EaYe+Mo7peJO81Xphlb1xVdaLoc
	 MKwjJ8AsqRzBZUJQ/ZIp979MKFHM0f2z1IhxIJF6k08CPFZeWTynLothIV2Zcbix5/kOB
	 adgrpG33KAdFk8vwkopAcrUxagtu365Ef6Epg1Ff/asrYrMwx4tq/6aB3TyZbsQVtiNMQ
	 Y9tXZ9kQ62w9bJvfiNPMx83xV7ADJrbr6xWdB0J5BuhaQLJhX6BunYOXBlIbDaqdByQ==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795528305;
	h=Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 Received:DKIM-Signature:Date:From:To:Cc:Subject:Message-ID:References:
	 MIME-Version:Content-Type:Content-Disposition:In-Reply-To;
	bh=wG3ZtixJaFFhkZXxYdcnHox9YkW7VVSHInEX8jMe+5w=;
	b=fYTWPdxaKp5grVwPo+tsqPhJXClNTJFP7PLV5GiN+FHqut8ZAKsoiNvvQcNgHtO8lQTA
	 /fywqLU+TREEBmmRNO5BN3GpWKxcmScSvtLNxzzwZ7zwe+Ih6GP+Vt8+pcZ7YQdtS47y2
	 26NDrlfwlHMiHLbI6zDVhhdM14+cbo8EMcUexQCBJJJWvv+l7UeuiOgcZbqmdgzImzi6j
	 BJ0akK3i7iSzjlxqhDaMHwccXYRKuSH/WLFeVgRngbqU7A18nYC2fPEruHYR9Lc3lG0jL
	 ALD110jVVtaHt8p70hOxS+bW7j5QZw2VeORSdmYxIzkN4w845hS1rrCsGJbE1yYGpvw==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=BKhJ5xLI;
	arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.138
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 23880606A322
	for <virtualization@lists.linux-foundation.org>; Tue, 24 Nov 2026 13:51:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=BKhJ5xLI
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id D53328101B
	for <virtualization@lists.linux-foundation.org>; Tue, 24 Nov 2026 13:51:44 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
X-Spam-Flag: NO
X-Spam-Score: -2.651
X-Spam-Level:
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id s2_w-CLRZlcZ for <virtualization@lists.linux-foundation.org>;
 Tue, 24 Nov 2026 13:51:44 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp1.osuosl.org 2DE1780FF3
Authentication-Results: smtp1.osuosl.org; arc=none smtp.remote-ip=172.105.4.254
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1795528304;
	b=bsFQlq+iHUygb51ZM4gMnvkMW4quwuq22JPNQpc7Tlt2m37gKC/ysBaIzykMPehM2GuA
	 4nnWRQRP/miSXvu/n8YC2aTaTEOrthiDhgCSZiTw1VmIVAw8NbowsEpM8H8SWrMCoQVy4
	 lZfMXE4qIar7VV+bukIjzrjYZah3ja+TbjH42bOGbYUFFdcDEEbbhY6AXM6bpM3hkF7si
	 veJN2g2bAA5WoCAM/L8YqJXanzxmrhMsc/Nd7DAn9wh6UhAE08xVtGwMjcHDE7YgFyYbr
	 8LugaPb+r30bM8cKPxVhTDehqkjC4YcKXsAjwcPytolwnife2GUUGSMrikEQXQM5vVA==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1795528304;
	h=Received-SPF:Received:Received:DKIM-Signature:Date:From:To:Cc:
	 Subject:Message-ID:References:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To;
	bh=wG3ZtixJaFFhkZXxYdcnHox9YkW7VVSHInEX8jMe+5w=;
	b=peIYUub2jr3ZsVOV3kKHrGCPaxd6uRbT0CQn8WEMes9xMn2ZiIr9ZXYAwv/xe+SVszIx
	 x+W1JGbF71aWJ16Nmtkc8prdgsClRUkkUkBMRsrCIgnPq/MIiqr+LE02yqzm51xzsoBpR
	 80EG4RdOWHWB8hEcJ0ehTN7c5NPD9h1c4JG7urG4RQQvOxAy9CeYaIGrJaUrU0OF4Zt1I
	 QPP92Wgz1jEbi8cyn0sfHl2rlvNpi5GdO1VbkUQqNeX8k9bDjyhyJOq1oSjtlLhmFWQ8B
	 zof5nt+7pSRQW5A5eNktualYofWZqan0C0TQIj3vquQb2O1hDpEGbqovlkdoAh5WTOw==
ARC-Authentication-Results: i=1; smtp1.osuosl.org; 
	dmarc=pass header.from=kernel.org;
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=BKhJ5xLI;
	arc=none smtp.remote-ip=172.105.4.254
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=172.105.4.254; helo=tor.source.kernel.org; envelope-from=ljs@kernel.org; receiver=<UNKNOWN> 
Authentication-Results: smtp1.osuosl.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org
Authentication-Results: smtp1.osuosl.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=BKhJ5xLI
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
	by smtp1.osuosl.org (Postfix) with ESMTPS id 2DE1780FF3
	for <virtualization@lists.linux-foundation.org>; Tue, 24 Nov 2026 13:51:43 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	by tor.source.kernel.org (Postfix) with ESMTP id 2735162084;
	Tue, 24 Nov 2026 13:51:41 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 160D31F000C0;
	Tue, 24 Nov 2026 13:51:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795528300;
	bh=wG3ZtixJaFFhkZXxYdcnHox9YkW7VVSHInEX8jMe+5w=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=BKhJ5xLI57wn3jcdh+k3UYMM+UZH/iP3LwGv3HpcYTAoS7feQKOPpAaR9qn3kUsth
	 vhoY/yvQd+Vbke+6trVtFw2wfac1ic3ibsn1lKpZ7h7zWG3Re5RfpxKcYWb+fRhbSO
	 vkrIYcEg0evcjLmDX6Qs24X0cPCxS5NYQ100VdjZ3HPx1rc39UbHRgyth/e+hZ3oSl
	 tDQpsNq+vvcfGOQu95049GJxDBFm2NcxzC17vmRGtf/8cZ2hyUHR7Nhko/L4bdnUUP
	 ef5f2Me+jA6dLerR0uj8pREuFrxw43n0k6GOh71YtVQ+XClfgJBkVFlbWZo6YZujpe
	 zBcg8RxjFwkkw==
Date: Tue, 24 Nov 2026 13:51:29 +0000
From: "Lorenzo Stoakes (ARM)" <ljs@kernel.org>
To: "Michael S. Tsirkin" <mst@redhat.com>
Cc: Linus Torvalds <torvalds@linux-foundation.org>, kvm@vger.kernel.org, 
	virtualization@lists.linux-foundation.org, netdev@vger.kernel.org, linux-kernel@vger.kernel.org, 
	2312891301@qq.com, blum@kernel.org, co+6dcbccedc9ec6452@bugs.sh, 
	eperezma@redhat.com, fangxy@xiaopeng.com, jasowangio@gmail.com, 
	kmehltretter@gmail.com, linfeng.sun.dev@gmail.com, lirongqing@baidu.com, 
	longpareto@gmail.com, oss.patchbox@gmail.com, p@1g4.org, phx0fer@gmail.com, 
	physicalmtea@gmail.com, sergiiushakov@google.com, shubham@octane.security, 
	stable@vger.kernel.org, stjepan.poljak@gmail.com, 
	syzbot+13df72e0dc4be5c62215@syzkaller.appspotmail.com, tavhadia@gmail.com, tjdqudcks0424@naver.com, tz2294@columbia.edu, 
	xieyongji@bytedance.com, xmei5@asu.edu, yuz08559@gmail.com, zenghui.yu@linux.dev, 
	zhaimingbing@cmss.chinamobile.com, zhangjiao2@cmss.chinamobile.com
Subject: Re: [GIT PULL] vhost,virtio,vdpa: bugfixes
Message-ID: <awWOpS3HR_2FTN3I@gremlin>
References: <20261104081535-mutt-send-email-mst@kernel.org>
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Post: <mailto:virtualization@lists.linux.dev>
List-Help: <mailto:virtualization+help@lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
List-Owner: <mailto:virtualization+owner@lists.linux.dev>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20261104081535-mutt-send-email-mst@kernel.org>

On Wed, Nov 04, 2026 at 08:15:35AM -0500, Michael S. Tsirkin wrote:
> chenglong.ma (1):
>       vduse: fix VA/PA confusion in the coherent page fault path

This has landed as commit bb2e6f166547 ("vduse: fix VA/PA confusion in the
coherent page fault path") but I don't see the patch anywhere on lore (off-list
security report?)

Anyway, clearly nobody actually _ran_ this code in 7.4, not even claude, as
it's completely broken.

Commit 99fd6bf43d5d ("mm/vma: enforce that mm-managed mappings may not set
VMA_IO_BIT") literally made setting VM_IO incorrectly, like this patch does, a
WARN_ON error on mmap(), i.e. it _refuses_ to mmap it :)

It looks like it doesn't need VM_IO anyway, the other changes in the patch
make it redundant AFAICT, so you should send something like the below with
a Fixes pointing at bb2e6f166547:

--- a/drivers/vdpa/vdpa_user/iova_domain.c
+++ b/drivers/vdpa/vdpa_user/iova_domain.c
@@ static int vduse_domain_mmap(struct file *file, struct vm_area_struct *vma)
-       vm_flags_set(vma, VM_IO | VM_DONTDUMP | VM_DONTEXPAND);
+       vm_flags_set(vma, VM_DONTDUMP | VM_DONTEXPAND);

--
Cheers, Lorenzo
