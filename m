Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=91.218.175.125
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793473551;
	b=dPAMbYo/XiPf8afonVbhzPCji1BH4gXrfO+5SN5Vp6hC2nwGdg1Hao/HfycqFCWDhMID
	 ViwXWYQPxMDmTO70Vd968YMoAV/uYi+NwAdBxknAKXHt9Ij2TMCpEvhf6r1PgvhGkwtpf
	 cQeUFvc8FdN1ydO5HVGcgcUUT9EY7vzi/9G1/Nx0b+IoabfEOxyQIbNLAVeZLNKE37Hwt
	 0tJjnryi8+0tLbwdPyTQ6N0hjsf4AfR8yeuww3+9Ez2Wn5kBgXPXuCs08EbVvBquylNlE
	 fgzJgHIS8pUzs8ARx82jLrqm0IRg8tIfsRU5s20h8bsJdCWLpeE+FIeGg/+y6AQxpiA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793473551;
	h=DMARC-Filter:X-Envelope-To:DKIM-Signature:X-Envelope-To:Received:
	 X-Mizu-Trace-ID:X-Migadu-Flow:Date:From:To:Cc:Subject:Message-ID:
	 References:MIME-Version:Content-Type:Content-Disposition:In-Reply-To;
	bh=gF9FP3okBGaulujfi92bns4Xp8Ex+d3QT0+PXv65Qbc=;
	b=dHsUXQisnOr+aw0j414kyiqkKX15R9f5EPTIa2h8INo9ATOrjzamKJBk9+8/HxfFBkWR
	 R/JkXdgHqV3PL++E0sD0v3/vuZeThpSGT4YvhmXcTnF/vrmAqb8Asf03Nig+CKy+x0TbJ
	 7TIal9asPoF4/afptsDER4xFqbWF41J91oEuHhqvW4FcgF/mt8xAcdGHGFtrU0zc1dVU0
	 CbVybCFU40/TW0NUw6yjdhV2P9Ew0o8pNxFlpyOlkBYs8nxFf4g6gvQ9n4sR7SypDTuk5
	 PDLPdEapy/mGkp1jj9uShDKBGU84t50eP7ewSyyhaevlg+mprKY7s2nybfxrlFFlw5Q==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=linux.dev;
	spf=pass smtp.mailfrom=linux.dev;
	dkim=pass header.d=linux.dev header.i=@linux.dev header.a=rsa-sha256 header.s=key1 header.b=L+kUzswU;
	arc=none smtp.remote-ip=91.218.175.125
Received: from mta0.migadu.com (out-125.mta0.migadu.com [91.218.175.125])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 80471606A31A
	for <virtualization@lists.linux.dev>; Sat, 31 Oct 2026 19:05:50 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 80471606A31A
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=linux.dev header.i=@linux.dev header.a=rsa-sha256 header.s=key1 header.b=L+kUzswU
X-Envelope-To: virtualization@lists.linux.dev
DKIM-Signature: a=rsa-sha256; bh=CbfwumJvnyRc/dDe61N2E5Z8vQbZC6EGlE3DNJg/ZIY=;
 c=simple/simple; d=linux.dev;
 h=from:to:subject:date:message-id:mime-version:content-type; s=key1;
 t=1793473548; v=1; x=1794078348;
 b=L+kUzswUjTbrCAF3gBbUSurdKdsKj8MZEDq3pv1MtmxPfnmkV6eaP7fpicoaaCg99i7IM0+4
 7sw4Vg89mBBHSl+qpwa5wyK2IaKINMjmI/qcBAaEpIdAZSjndcegit7olkOzgokYC3dsc1jAwIQ
 F0jRYA0WvxGfcvP7innvIAF8=
X-Envelope-To: virtualization@lists.linux.dev
Received: by smtp.migadu.com with ESMTPS id 801ab3a65b468602;
	Sat, 31 Oct 2026 19:05:48 +0000
X-Mizu-Trace-ID: 801ab3a65b468602
X-Migadu-Flow: FLOW_OUT
Date: Sat, 31 Oct 2026 12:05:43 -0700
From: Shakeel Butt <shakeel.butt@linux.dev>
To: Aamir Ahmed <elb12345@hotmail.co.uk>
Cc: "Michael S. Tsirkin" <mst@redhat.com>, 
	Jason Wang <jasowangio@gmail.com>, Eugenio =?utf-8?B?UMOpcmV6?= <eperezma@redhat.com>, 
	Valentin Schneider <vschneid@redhat.com>, Aaron Lu <ziqianlu@bytedance.com>, 
	Peter Zijlstra <peterz@infradead.org>, kvm@vger.kernel.org, virtualization@lists.linux.dev, 
	netdev@vger.kernel.org, linux-kernel@vger.kernel.org, stable@vger.kernel.org
Subject: Re: [PATCH] vhost: Run TIF_NOTIFY_RESUME work in the vhost_task loop
Message-ID: <auY6zHDao6R6bFNz@linux.dev>
References: <AS8P251MB00012469E6ECBEA2B7D87BB0C86C2@AS8P251MB0001.EURP251.PROD.OUTLOOK.COM>
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
In-Reply-To: <AS8P251MB00012469E6ECBEA2B7D87BB0C86C2@AS8P251MB0001.EURP251.PROD.OUTLOOK.COM>

On Sat, Oct 31, 2026 at 01:33:13AM +0000, Aamir Ahmed wrote:
> Since commit e1fad12dcb66 ("sched/fair: Switch to task based throttle
> model"), a throttled task is only dequeued when TWA_RESUME task_work
> runs on its way back to user mode.
> 
> vhost workers never return to user mode, and vhost_task_fn() only runs
> task_work via get_signal() when a signal is pending. A busy vhost worker
> therefore ignores its cgroup's cpu.max, while its runtime is still
> charged to the group, throttling the group's other tasks (typically the
> VM's vCPUs) harder.
> 
> Run pending notify-resume work at the top of the worker loop, as io-wq
> does in io_run_task_work(). Commit 12013e3d4695 ("KVM: powerpc: Use
> generic xfer to guest work function") fixed the same problem for KVM.
> 
> Fixes: e1fad12dcb66 ("sched/fair: Switch to task based throttle model")
> Cc: stable@vger.kernel.org # 6.18+
> Assisted-by: LLM
> Signed-off-by: Aamir Ahmed <elb12345@hotmail.co.uk>

I have this (almost) same patch but for different reasons i.e. memory.high and
block throtlling. 

http://lore.kernel.org/20261031181004.4193627-1-shakeel.butt@linux.dev

If you don't mind, can you update the commit message to also include that it
will fix memory.high and cgroup block throttling as well?

You can add:

Reviewed-by: Shakeel Butt <shakeel.butt@linux.dev>
Tested-by: Shakeel Butt <shakeel.butt@linux.dev>


BTW there is a similar issue with io_uring SQPOLL thread which I am fixing
(testing at the moment), you might be interested.

thanks,
Shakeel
