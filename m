Received: from va-1-114.ptr.blmpb.com (va-1-114.ptr.blmpb.com [209.127.230.114])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E294B3C552F
	for <virtualization@lists.linux.dev>; Mon, 13 Apr 2026 12:23:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.127.230.114
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776082992; cv=none; b=Z96OYDbf0YKdA9elmEvZlWbPfwIQFzv1wqw6ZRV+S77GC/0sWAwaW/Hgsg2SpI7CgTAkjT4oSL/NkrMn23tOIK+3n/ag5HBjtbjog1jiAjvF+RGm7doq4Z9EcWd0ArLUEGSBGV27eoWulJxWv6Kcbog8S0EYKA8bVZdNzLWRz9M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776082992; c=relaxed/simple;
	bh=BBkzYw2zsCOt65g0/czwmFam61bS0fD+YbV9/bZ3PTc=;
	h=Cc:Subject:In-Reply-To:To:From:Date:Message-Id:Mime-Version:
	 References:Content-Type; b=GYj3tnRt35ekq4l50uj+Mvku/E+GlFjjKgpiAZZ2xAQxO2s7Kko1189UBqRn4rK2SGmHENO7aMWLWWF0ZosVVAiQP+bvAmGuByHVZYjYTki9sqp5/hLP86BahqS4zzZMQ2BITcsM8rwvDBXSQ6f59CjGJb/11+e7GJUml8bRwIQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com; spf=pass smtp.mailfrom=bytedance.com; dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b=jE8R4+iY; arc=none smtp.client-ip=209.127.230.114
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bytedance.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b="jE8R4+iY"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 s=2212171451; d=bytedance.com; t=1776082981; h=from:subject:
 mime-version:from:date:message-id:subject:to:cc:reply-to:content-type:
 mime-version:in-reply-to:message-id;
 bh=BBkzYw2zsCOt65g0/czwmFam61bS0fD+YbV9/bZ3PTc=;
 b=jE8R4+iYADVxS7UvGT4SGVzHU136YhJtExmhVQInByWqxUfKy08yVE9/LajSXBG98uOT9F
 wnEVKXl8cul+u4nzck33Cv11ogqUP7Z9c3Ea8tcXVWpVE/ZkXa7dhdMCZy+zYKosEgOgvX
 9PpT9jDZpOpdt4RK/ZyHl3nJZsne77E7P8DndrRq1W/KAtYYLsfyq2KGym0vyaX4J2eqOO
 Ww5ZQ1rADuDkuLS1uki4C2CHMVHgfRm9C3kO67OsBBvP4qyk86YyoYCXAz5v1hhwoQol5o
 mOze6xCBwe5HVelLVSDEX6oRHhWpF3YepEttOTMxgdS1hSeVRQHHdbPYaZj6rg==
Cc: "Michael S. Tsirkin" <mst@redhat.com>, 
	=?utf-8?q?Eugenio_P=C3=A9rez?= <eperezma@redhat.com>, 
	"Jinhui Guo" <guojinhui.liam@bytedance.com>, 
	"Jason Wang" <jasowang@redhat.com>, "Jiri Pirko" <jiri@resnulli.us>, 
	"Xuan Zhuo" <xuanzhuo@linux.alibaba.com>, <linux-kernel@vger.kernel.org>, 
	<stable@vger.kernel.org>, <virtualization@lists.linux.dev>
Subject: Re: [PATCH] virtio_pci_modern: Use GFP_ATOMIC with spin_lock_irqsave held in virtqueue_exec_admin_cmd()
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20260413101759.6323fb68@pumpkin>
Content-Transfer-Encoding: 7bit
X-Lms-Return-Path: <lba+269dce023+bb28eb+lists.linux.dev+guojinhui.liam@bytedance.com>
To: "David Laight" <david.laight.linux@gmail.com>
From: "Jinhui Guo" <guojinhui.liam@bytedance.com>
Date: Mon, 13 Apr 2026 20:22:44 +0800
Message-Id: <20260413122244.534-1-guojinhui.liam@bytedance.com>
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
Mime-Version: 1.0
X-Original-From: Jinhui Guo <guojinhui.liam@bytedance.com>
References: <20260413101759.6323fb68@pumpkin>
Content-Type: text/plain; charset=UTF-8

On Mon, Apr 13, 2026 at 10:17:59 +0100, David Laight wrote:
> Or do the allocate before acquiring the lock (and free it not used
> in the error path).

Hi David,

Thanks for the suggestion.

Pre-allocating the memory outside the lock is indeed a good practice,
but unfortunately it doesn't work in this specific virtqueue context.

The kmalloc() in question is not happening at the virtqueue_exec_admin_cmd()
level. Instead, it is deeply embedded inside virtqueue_add_sgs()
(specifically, in functions like alloc_indirect_split() or
virtqueue_add_indirect_packed()) to allocate indirect descriptors when
multiple SG elements are provided.

As a caller, we have no mechanism to pre-allocate this indirect descriptor
memory and pass it down to virtqueue_add_sgs(). Furthermore, virtqueue_add_sgs()
needs to atomically check the queue's num_free status, allocate the indirect
table if necessary, and update the queue pointers. All these operations
must be protected by admin_vq->lock to prevent concurrent admin command
submissions from corrupting the virtqueue state.

Therefore, allocating before acquiring the lock isn't feasible here, and
replacing GFP_KERNEL with GFP_ATOMIC (with a proper sleepable retry upon
failure) seems to be the more viable fix.

Does this make sense?

Thanks,
Jinhui
