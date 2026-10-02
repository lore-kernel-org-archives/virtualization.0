Received: from mail-qk2-f40.google.com (mail-qk2-f40.google.com [74.125.230.232])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 241CF498902
	for <virtualization@lists.linux.dev>; Fri,  2 Oct 2026 13:22:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=74.125.230.232
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790947375; cv=pass; b=J+S7YVakewEA5bPlz5Roy05jooeuxqlm6HAF01J19tU/sYlQbE4epSROrURPj1ulItuzYOs9Un+er4mEYPe7alurkJZJG2yaKZ4d3WExZeD7onA4Ou2kKaZYYrWT5LTNgpfj6lYzlX1QaHLCsgqQ23jJD3rBOm3CXVAHjfX0dfc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790947375; c=relaxed/simple;
	bh=bXv+OzGfGyUqcNVSEAB3EcnVmtZJQIIB5GyxKlXPwB4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=d9Kni7W+WXXrhN0AHptnAh1JGcTTiJ8HY+1kdb0cSy7CoCsOlu/mt3fD2USF9M9kSKOyLOwuCui6pZKiLvT/v4V4X9tWYzzadZFgjWTjFc5aebcftJ14Y1I8MCkT07Tm4i1tVVdSK8p4cgmnM5cJSPUTb/gOGxQsoAKLvJ7ncCw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=oVw13rFR; arc=pass smtp.client-ip=74.125.230.232
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="oVw13rFR"
Received: by mail-qk2-f40.google.com with SMTP id af79cd13be357-93cc48a2aeaso138721285a.2
        for <virtualization@lists.linux.dev>; Fri, 02 Oct 2026 06:22:52 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1790947372; cv=none;
        d=google.com; s=arc-20260327;
        b=mvi77pV1+v0vTgmpGFIAeIzep4LgWqklsRcLTIMIEqM/wWLSg/5YwYyDByOeCEhe2n
         EdIIJ6VEPjEzzjLX2jR3nkSBUHge9sh+lR40y/AJ7I3+ufi6s5z4QKn/k4H++CBmIJMU
         S6P54IvPEsaXjms0C69pOZUY+SoDgmmGgqlewx0wb+GKCDZPWr1/Q7lHXATpgr0orr81
         mOdirE/P1K/BiFbam3pmXiW8yHtM4VO01MitlBJWo6pR0ifdP3XaQe8Rrm0IX0JO+0TC
         kzZX1Airfi7flY9Gbm+E5JI/F7kMdSq6tDqyvo0qUmRTHsVymc3MaDyImFY99buAHPw6
         PG/Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:dkim-signature;
        bh=6snyJBSj8ioMJc468jkCyOEuW/eCFo/MXP5mA8YOdC8=;
        fh=5f2SkOenxggYr/4A9CeSA3B01uLbp1Oc44lvfuXlJh4=;
        b=SLjZZs+TNe7DJ6x504VK5XgncXSkG95+OORcxTmmFP+iplJ/yx8+JL6jNLTPNMtZ7+
         6YGZSbnrZeDTtq8U6rkmyKQmqak4+k3Cf//AGCPnWxIqv5WdX9iDlrf+6fRNR7fVIOY3
         XtdHYVKncwGyrr8t2laefd419sgRi2Kkarlxb/Y+a4ubKZPL371XytIrW2Tc4ycXvD+c
         h4g0Vk7dUhyncvrlHSJj8UD/cLuoRxh+IaSjf/3iuub83GJygtzN1QMfwXsEklncDOLf
         5NEyxNBkXUUQslZZlLthbQPdFWEFLXpyT0nvGKXSda2K13dorNwmsdujpsgqnRjpsicK
         kh5w==;
        darn=lists.linux.dev
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1790947372; x=1791552172; darn=lists.linux.dev;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=6snyJBSj8ioMJc468jkCyOEuW/eCFo/MXP5mA8YOdC8=;
        b=oVw13rFRyOltR4J959RT9/QB/jG75KDbwvZkiX6V4lou0IQlDGOWKRYtcUEQcLgHwQ
         VLNLWHeep0XXRumVHPJWpAyVZBhKIkc1ssLrGKEvTa8+WuzgQoVwoDsqRqHoQ7Sh52fi
         b1C5n7WeySe6b3qUBuVxrjwtf6WRCYgfweIerBb/D+jNMXGmRKt4PSzxwG3zLPGICVmF
         /kMkFPZ8v3Nu54Ol6RtJqqyYJRKboc7WZG+1ixTyuA2U2ZAudr/Q0cWQL7YSiTPMoFXJ
         5iLVk+gmaXcvQNPOgzJEvl+NIpHWC9wGfoXoGLGUxv0ZlGbEplbcTYvo31jjPid7F8Ia
         yvXQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790947372; x=1791552172;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=6snyJBSj8ioMJc468jkCyOEuW/eCFo/MXP5mA8YOdC8=;
        b=GwmaQ1baLjNRF25xd8pe0pgsUIwj45UgEgt2cBLql2abZj+PxAAUAATfq1HINrHpNX
         nL9CbjOrajEBmmsqoeYhrIlgWIzmm9k01IeiE236KUa7JL/FGVnKo/kXnDJByTVDoS5c
         8kgGrqL3GV8FtC2bRDlxCXBoIEtsa58B4pLZluUy2Czu7RDDlSdFeOyZOlz/SVt+v/s1
         egDehbMHclY643+fXMOgH8ru9tn2rTwVZVY1zsAVNB04sNlQWsY+n59ZJZ+f+k8a3Vua
         XCpFoY+n7eSuOu0i6wFA6O0xiPTkWDXfnzcd0lygMn5f/JF3aBH13sMOJnevdJ+jb7D6
         BeqQ==
X-Forwarded-Encrypted: i=1; AKwUvBxZDHoptFPTVZ+KL4fDhr3VlGq4am8nu5xoF4VYOvvVM9jghIFBTxF2ZVp4GFJFInxmX+a/n4bbUa+i4mIY6Q==@lists.linux.dev
X-Gm-Message-State: AFuF++mYJpcvvZWvAAzqHBRgIQ/oXaDlaI7da6Nsl56N+ZIL/ZV8qy33
	04kJ5AjnhXG5paXn1BzqEQo9LlamFkNyVGBufnkStoIvJMa3sfTjqHqmeyaK/eW1jN1OWfTiCVt
	Vvo0U+XNPmiSiQdpLg1umNhWv3ZACMp0=
X-Gm-Gg: AYBFou0Wrbns4i2gIX4KvoF6SK3jn2z1jtKVf68DkgA/UX/6Q33ICAd0D7pRuP1oURt
	OBqlAa2EqIoYi+1ipQtKRwKqbnuizZfi8rfJfDC2iajXiO3BoOOhKMMFnvlxw/0ExE2EuG1DtNO
	5JfyB9S6iTLM/708AlW6EaO9OYfnM9w3kpihDSInzwkY70wvtjfxxKtoWNlRuo+DT7/n7k2X6DD
	WhPT3jEPOBoXQFzgd7lPYR3k2YKHJ9chDVxvUlH2xRSq3cSr3exg50CGiSuFm6zOX3LPzTVu3eY
	s+Id6a/D5oeIYrX+dRN1nMp40N9C6zFzA6nFewiVHW7rjxzJgaaV1YY=
X-Received: by 2002:a05:620a:4493:b0:939:ede4:a499 with SMTP id
 af79cd13be357-93ce7ab3ab2mr434910385a.5.1790947371465; Fri, 02 Oct 2026
 06:22:51 -0700 (PDT)
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
References: <20261002074551.318789-1-physicalmtea@gmail.com> <ar95red76pmfQwvF@sgarzare-redhat>
In-Reply-To: <ar95red76pmfQwvF@sgarzare-redhat>
From: Jia Jia <physicalmtea@gmail.com>
Date: Fri, 2 Oct 2026 21:22:15 +0800
X-Gm-Features: AclHuK8I62AZnyoE6xfS86fnLkS54v7RxBiMcJlNIxeI4Z6FP8O_7gPM89wJ3jY
Message-ID: <CAJwVaM+uA0TSZuJFXyeK1-1HUAiqs0zOpK2rJ1mBGa8380_=yA@mail.gmail.com>
Subject: Re: [PATCH 0/5] vsock: reduce RX per-packet socket overhead
To: Stefano Garzarella <sgarzare@redhat.com>
Cc: stefanha@redhat.com, mst@redhat.com, jasowangio@gmail.com, 
	eperezma@redhat.com, virtualization@lists.linux.dev, netdev@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

>
> On Fri, Oct 02, 2026 at 07:45:46AM +0000, physicalmtea@gmail.com wrote:
> >From: Jia Jia <physicalmtea@gmail.com>
> >
> >This series reduces per-packet socket overhead in the virtio-vsock RX
> >worker.
>
> I did a quick look but IMO this is hard to review, please try to keep
> patches as small as possible, e.g. where you are introducing ctx, store
> ctx->net in a net variable, so you don't need to touch the entire
> function, etc.

Thanks for the review and suggestions.
Will do. I will unpack ctx into local variables to minimize the diff.

>
> Please check https://docs.kernel.org/process/coding-assistants.html
> and also https://docs.kernel.org/process/submitting-patches.html
> ans also https://docs.kernel.org/process/maintainer-netdev.html#git-trees-and-patch-flow
> (I guess this is net-next material).
>

Thanks, I'll reread them. Targeting net-next for v2.

> I don't think this series was sent properly, I tried
> `b4 am 20261002074551.318789-1-physicalmtea@gmail.com` without success
> and also looking at
> https://lore.kernel.org/virtualization/20261002074551.318789-1-physicalmtea@gmail.com/
> I can't see the full series, please check your workflow.
>

Sorry for the broken thread. I will fix the git-send-email setup for v2.

> Also, is this for vsock core or just virtio-vsock? if it's just
> virtio-vsock transports, please use "vsock/virtio" prefix.
>
>

It is for virtio-vsock. Will use the "vsock/virtio:" prefix.

> >
> >Patch 1: separate socket lookup from locked packet processing.
> >
> >Patch 2: keep one socket lock across a bounded run of established
> >STREAM/RW packets for the same native socket.
> >
> >Patch 3: reuse the locked socket for later packets with the same
> >address tuple.
> >
> >Patch 4: coalesce default write-space notifications while that
> >lock is held.
> >
> >Patch 5: defer the default readable callback until after the batch
> >unlocks. Custom callbacks retain per-packet notification behavior.
> >
> >Performance:
> >
> >Tested on single-stream AF_VSOCK (1 reader on Guest CPU0, virtio-vsock IRQ
> >on Guest CPU1, fresh QEMU guest per state, 16 balanced AB/BA pairs per
> >payload).
>
> What the host is using? vhost-vsock?
>

Yes, vhost-vsock.

> >
> >End-to-end RX throughput (64K receiver buffer, SO_RCVLOWAT=1):
> >
> >  payload  baseline RX (G/s)  PATCH RX (G/s)  throughput change (95% CI)
>
> What G is? Gbit? Gbytes?
>

Gbit/s. Will fix the table headers.

> >  256B     0.5722             1.0286          +79.76% [+75.40%, +84.23%]
> >  512B     1.1464             1.9779          +72.53% [+69.50%, +75.63%]
> >  1K       2.2714             3.6368          +60.12% [+56.92%, +63.37%]
> >  4K       3.9095             7.7160          +97.37% [+92.09%, +102.79%]
>
> Why stop to 4k?
>

Stopped at 4K because the throughput gains were steadily increasing.
Will test up to 64K and include the results in v2.

> >
> >Fixed-syscall stress test (receiver buffer = sender write size; RX in G/s):
> >
> >  payload baseline RX PATCH RX throughput change (95% CI) recv() base/patch
> >  256B     0.2885       0.6737    +133.50% [+123.58%, +143.86%]  1048577/1048577
> >  512B     0.5631       1.2091    +114.71% [+104.97%, +124.92%]  1048577/1048577
> >  1K       1.5361       2.9678    +93.20% [+80.15%, +107.20%]     1048577/1048577
> >  4K       2.8378       6.1878    +118.05% [+109.15%, +127.33%]  538802/525645
> >
> >Request-response latency (Ping-Pong RTT, 10,000 requests):
>
> What tool did you used for both throughput and latency?
>

Throughput: tools/testing/vsock/vsock_perf
Latency: custom userspace ping-pong RTT tool (CLOCK_MONOTONIC).
Will document both in the cover letter.

> >
> >  payload  baseline mean RTT (us)  PATCH mean RTT (us)  change (95% CI)
> >  256B     126.968                124.541              -1.91% [-3.35%, -0.45%]
> >  4K       130.362                126.664              -2.84% [-5.12%, -0.50%]
>
> Whys only this payload cases? For latency we should use even try small
> payloads IMO like 64 bytes.
>

Thanks for the suggestion. I'll add a 64B payload test for latency in v2.

> Thanks,
> Stefano
>
> >
> >Diagnostic Guest CPU1 system-wide cycles (fixed-64K receiver, with perf):
> >
> >  Buffer size  baseline cycles/B  PATCH cycles/B  cycles change (95% CI)
> >  256B     15.287            13.630          -10.84% [-12.51%, -9.14%]
> >  512B      7.306             6.611           -9.51% [-10.92%, -8.08%]
> >  1K        3.811             3.458           -9.25% [-10.96%, -7.50%]
> >  4K        1.850             1.669           -9.75% [-11.78%, -7.67%]
> >
> >Jia Jia (5):
> >  vsock: split socket lookup from locked RX processing
> >  vsock: amortize RX socket locking for stream packets
> >  vsock: reuse same-flow socket lookup in RX batches
> >  vsock: coalesce RX write-space notifications in lock batches
> >  vsock: defer RX readable notifications until batch unlock
> >
> > include/linux/virtio_vsock.h            |  14 ++
> > include/net/af_vsock.h                  |   3 +
> > net/vmw_vsock/af_vsock.c                |   2 +
> > net/vmw_vsock/virtio_transport.c        |  48 ++++-
> > net/vmw_vsock/virtio_transport_common.c | 341 +++++++++++++++++++++++++++-----
> > 5 files changed, 357 insertions(+), 51 deletions(-)
> >
> >base-commit: f5f84daefcd92d7a630066635ecea1433ed5eac7
> >--
> >2.53.0
> >
>
