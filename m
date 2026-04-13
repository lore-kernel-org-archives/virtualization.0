Received: from mail-wm1-f44.google.com (mail-wm1-f44.google.com [209.85.128.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D50143CD8A6
	for <virtualization@lists.linux.dev>; Mon, 13 Apr 2026 13:33:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776087186; cv=none; b=Io8pKxUIwu9FhJy3YeRg2IniAks/VgpbOKUNbHLEtRVBHjTpB/UAQAyW8oqZ4uQCHJC9LQ99sFDGO7lPFxqtE7mChKQL9QBaRUB80AeR+Axs6grBFdJXF4/e+cNrZUaYX5htg9Vit9HF//Hc3Hds8/eFtLoSnrikQ2DTtdvNTK0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776087186; c=relaxed/simple;
	bh=cNzldwXv7EEzDpZRh1GYW+jmgvH87VS+HrKz6Gcd/no=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=jFC/PQ9ez2udijiBW0rXuioUMlflD2MzKT0GwDKZlWVzpSgG7B6G/dilKpipo1l2PA/p5X9+DULW87ncbyXw6+6b8kxOupCwJUxiSn95odYg3cwy1bEFr3AKxP+5Fs5yAcAB4KlrtoN/dABMk06A2Hlj8q+fg/7U4KpM2go3+Qw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Z5U9PM5k; arc=none smtp.client-ip=209.85.128.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Z5U9PM5k"
Received: by mail-wm1-f44.google.com with SMTP id 5b1f17b1804b1-488ab2db91aso69616795e9.3
        for <virtualization@lists.linux.dev>; Mon, 13 Apr 2026 06:33:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1776087183; x=1776691983; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=NAr+JGO4ktVEFi2tj7VFYFMXV+IisACoZSycsDEBlws=;
        b=Z5U9PM5kgifGkcKwXYVCIx/tkhLZag76d6DSJxPuNhj79SiNaGdW3zkZc1oWXJiviT
         ukXJFGw7cOVlbAI9HqPJ3boDTQi6PkHEx3Kh/v2u5S1Thx2oJAue8HjJgBND++58O3Ig
         ISzPoY9h9ZRWvoNKy48qp5yGg4t7mfjlhUcDaiEOi4wJx6mW1VKJDh5N8DhzgVyt6NSq
         YpYFmRiLBXOWKMRpa2ckCkSGDe34Eu1A5UGWffKTJTz0NNAIw/yb0q8GNbKg2FvfkVzP
         xNu/NwSjZWf1oUpe2RaEwNlLJxDYkkhUpEkdPDyv2pVtuIImHBUn8NDu68ig7Yu+h8qt
         VRCA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776087183; x=1776691983;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=NAr+JGO4ktVEFi2tj7VFYFMXV+IisACoZSycsDEBlws=;
        b=BUBR2+VgP5DxrKSzm9eS/4x7PTFnnVIcdhl1AgjbS7edErbrqlvYq3o0i5/nqkECU5
         +/YfI20uZqVK4zIrizpQcTORnTzjBGq3mLG5HYryzuhwHeQJ/IvOy9sO4aBoA1HwoJDL
         LbmQXtV54dXz33iBzvmDmFyRWluLUP/jEk+NJWjpNYCsFFFl3jf5HN5o474eCmgbqubv
         wdQAnFxOi+kDMmngquNPHFYCEDEvd5XusNosIm5XvvktCtz4TbSFCvSDfplFkySQf4lf
         Qh7mB+XygCM21laYXHNIprE8ahH4jg6WULlWjYxFzc0/UFDSOd0bRvQaHBYnz8L8sTfT
         +Eig==
X-Forwarded-Encrypted: i=1; AFNElJ/5aHJUG59Kj24ZexYjQ2hWwzR9iY9V88LhGvOoUAi0mNC5oZlyi3X7jzwrhP6Xyr8yoKN1HbWzwcRcCpKiRA==@lists.linux.dev
X-Gm-Message-State: AOJu0YyX8DW+ssfqndCi+PsNTgEjdRXxXFxAGmHTSE3x5L7dz5gzAkun
	XhJ6qG+sy9U3QpBbKfdvbJkl9iV0Ez9lUpAqNZa1av5neo/r4UCNTz2n
X-Gm-Gg: AeBDieuFIM9DGK+T9LFz81tg3AdrSr3kceql8PJTIXCm0nFochNl9+x7yrIorbtbSik
	60tcU376Uvs4pIytpYlStBVeE/yaZEUiD/SEgr4KJlZRC6wzovW/AKB6dogkOEqHRYZNyFn/I+t
	y1fXV32hjnFy55OMtBENq9lZsBcPA+pR4mOYORlMQlz7IMC30RJ2p8hON1NAv6MyISpoEVniQqt
	r2FPyDpaINPrCbQBSJY0ZX7f0218tzIHKmidib4KSCPFjL6ySS2c4/eNM3BIhjdrabpR+BsuqmO
	N5WFe2pexuqFmudRBWLk5PMB8Fudb9uXH13o8L64XwYzGKKeCje/YRN/AVr5mu8KPzNNoudBFMM
	J77FLGRKFlhyJLMQHfWXsm6Wg9qjQCfQ6tuId8Tr/QmyWQrDH6mHMiUOdyk4YCeXqqdiXzBNZQ3
	gaDrRDAbqtB1fAtoRpq0/u1zv7n4VzeXjT9OzyzHGyeZ4/9gSZ5Tyv7yfF6m4idOC/
X-Received: by 2002:a05:600c:4443:b0:485:3a03:ceca with SMTP id 5b1f17b1804b1-488d686c044mr182576135e9.23.1776087183006;
        Mon, 13 Apr 2026 06:33:03 -0700 (PDT)
Received: from pumpkin (82-69-66-36.dsl.in-addr.zen.co.uk. [82.69.66.36])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-43d762decf6sm18410380f8f.8.2026.04.13.06.33.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 13 Apr 2026 06:33:02 -0700 (PDT)
Date: Mon, 13 Apr 2026 14:33:00 +0100
From: David Laight <david.laight.linux@gmail.com>
To: "Jinhui Guo" <guojinhui.liam@bytedance.com>
Cc: "Michael S. Tsirkin" <mst@redhat.com>, Eugenio =?UTF-8?B?UMOpcmV6?=
 <eperezma@redhat.com>, "Jason Wang" <jasowang@redhat.com>, "Jiri Pirko"
 <jiri@resnulli.us>, "Xuan Zhuo" <xuanzhuo@linux.alibaba.com>,
 <linux-kernel@vger.kernel.org>, <stable@vger.kernel.org>,
 <virtualization@lists.linux.dev>
Subject: Re: [PATCH] virtio_pci_modern: Use GFP_ATOMIC with
 spin_lock_irqsave held in virtqueue_exec_admin_cmd()
Message-ID: <20260413143300.16922e4f@pumpkin>
In-Reply-To: <20260413122244.534-1-guojinhui.liam@bytedance.com>
References: <20260413101759.6323fb68@pumpkin>
	<20260413122244.534-1-guojinhui.liam@bytedance.com>
X-Mailer: Claws Mail 4.1.1 (GTK 3.24.38; arm-unknown-linux-gnueabihf)
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Mon, 13 Apr 2026 20:22:44 +0800
"Jinhui Guo" <guojinhui.liam@bytedance.com> wrote:

> On Mon, Apr 13, 2026 at 10:17:59 +0100, David Laight wrote:
> > Or do the allocate before acquiring the lock (and free it not used
> > in the error path).  
> 
> Hi David,
> 
> Thanks for the suggestion.
> 
> Pre-allocating the memory outside the lock is indeed a good practice,
> but unfortunately it doesn't work in this specific virtqueue context.
> 
> The kmalloc() in question is not happening at the virtqueue_exec_admin_cmd()
> level. Instead, it is deeply embedded inside virtqueue_add_sgs()
> (specifically, in functions like alloc_indirect_split() or
> virtqueue_add_indirect_packed()) to allocate indirect descriptors when
> multiple SG elements are provided.
> 
> As a caller, we have no mechanism to pre-allocate this indirect descriptor
> memory and pass it down to virtqueue_add_sgs(). Furthermore, virtqueue_add_sgs()
> needs to atomically check the queue's num_free status, allocate the indirect
> table if necessary, and update the queue pointers. All these operations
> must be protected by admin_vq->lock to prevent concurrent admin command
> submissions from corrupting the virtqueue state.

It just sounds non-trivial...

> 
> Therefore, allocating before acquiring the lock isn't feasible here, and
> replacing GFP_KERNEL with GFP_ATOMIC (with a proper sleepable retry upon
> failure) seems to be the more viable fix.

The sleep-retry isn't really ideal - and may not make progress.

An 'interesting' solution would be to return the size of the kmalloc()
that failed, kmalloc() and kfree() a buffer of that size and hope
it is still available for the retry.
For a quick read of the code it is always a constant multiplied by the
number of fragments.

Although I only found kmalloc() in the 'indirect' paths.
I didn't spot what happens if the ring itself is full.

	David

> 
> Does this make sense?
> 
> Thanks,
> Jinhui

