Received: from mail-wr1-f48.google.com (mail-wr1-f48.google.com [209.85.221.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 21B191B142D
	for <virtualization@lists.linux.dev>; Sat, 23 May 2026 16:36:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779554162; cv=none; b=T9/7YYapiwtAuZ+ug09p/oQ/xaAzwFtC45XjhbxiG/3xbwsoouSx2T9YY2PkUk6quG2rKHnN5vO5JlPxHlkxxZtRi1n69mXMY295tNF79h0hDGDPC816OSuOYmCuHvXDB770ZAxgMoJ2o5PBZfRFZPB69KRZR7wdx7ykD26AtP4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779554162; c=relaxed/simple;
	bh=SnLk0HaLAeDp9CB1O+cT5QTtRXJhfOlf8pVOAJpSIsI=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=HmqiTACty9agSPMEXU65vlWoXCwiJwUjW/QiETnKbW8P6bG9XgPa+N+BpzxkEo9z6cqVf08mOanfiv8DibJ8ccOWZvewJzZFZ/EAN5pQmjeQysW6JgW9QrWu7sKcGj/MFEn6/ET0YBSna4AbiKKJshf9gwOPXX3wB/LMBE2ieW8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=gXhZUDVC; arc=none smtp.client-ip=209.85.221.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="gXhZUDVC"
Received: by mail-wr1-f48.google.com with SMTP id ffacd0b85a97d-44ccbd3290aso7449292f8f.2
        for <virtualization@lists.linux.dev>; Sat, 23 May 2026 09:36:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1779554159; x=1780158959; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Iqbi0SmV4l8cOiZU/jCD2RWz3CBg4dHUkTOED22sLyI=;
        b=gXhZUDVC17RrWpjV44xwbslDToIsbXJ4tn6tZECHVFJ2i236YMi4ILLJt46sRXGHNR
         NX1xmVITE13IrSz6cVofRC7iBZInVYHvxqxz+5awSZuPTN1bZAaScsszYpLENqihU6UX
         rpIbaGDredNQZ3gxmckvDlILbzV7o5ej5ujNxBmrD8GB/n+rCK+V9R8VEQ9RLmM9wJud
         ZuriVAtpGJ7vT8YSrKKVuHaKFJDIWueaeKNGHlkkmDN0iQy+0LncaGc0P9dLxgSU1hMn
         ZOEI1GJ2+ZO+WlXg9JawhMVj9hrHIEjowfL6d3DeXpDWPoeOv6MPYOiFLma3fB1xRf2H
         tDqQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779554159; x=1780158959;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=Iqbi0SmV4l8cOiZU/jCD2RWz3CBg4dHUkTOED22sLyI=;
        b=sN0JiZpIHtCNsX2+TfmHr7BwoFHanS7xLgYKcfvF+alT92NDvzesROdiHnktqTc7YJ
         3DSIH4cSknwslH72hoc16n4JiM2ELmNmeDMcjursPLWodY+MvwyAJ7RGWmFM0rz1dNu/
         4CbXSHRaB4aaw1rFcx84rle1UMxW1neJNJPaRBRolSgrF0o4RbltjbMRIlZ3j5ONvPvX
         fB2PIbEGskXd0l1BhMjRSrgdJ+B98iaTAo7V5Q4834uMl25QVXbibMhWgAkJTaakAe9B
         yjhdDUHw/QNqfZJhd0bvQuysxo2PpJNsXezRc5IFjps1o6m7cD6F6B3a+wwM02vrxycz
         iIcg==
X-Forwarded-Encrypted: i=1; AFNElJ+zVfQg28CdZhXwuUNamYrejL3nFRj2jvh9Bs/fiqb8PxDZ2hUjwqqtwk1DOYKPqkhkunPgPFRFTsp3Cr2cGQ==@lists.linux.dev
X-Gm-Message-State: AOJu0Yyokh+3cvHdwt18X82UhVMDP/z6BbSquOtYrumXxmpumvAhqibJ
	/i6IlXXRqYlaL0Rlnbe9+PwpnpMoq3jT8fC6XNJlSoZW+6TJw5NspiFm
X-Gm-Gg: Acq92OGXRTWSbYqLOn/zxAB74JtTRh6YrTo5hotwoW/Lt61/gQf5ZVj9fVGcfY4U/x1
	oBRK8IyKoQ3xNCaIx5gtotF7FJvrK276laysTLnFuyJwp+7uAxXPudAT23gXzKN/6WYWo0a8YMA
	VoSd5qcF6RIrI7PZE40o4tNR+mEIzJYJhjjrajhkgMKr/atcCtjvq9catjfKo0uGLaz0wGLn4W5
	jZflUtUpsKPr/HwPfDV+lwJ7bWywIUGSwswRvDWBfbwK/S6U1rbrzBXQNrBhmgbwV9/hNUe9MtJ
	MRIYJo2cSukfahCXPb8tFshDlEoxq9H58/D0Yi1RVMRY8wMMiG5OOYDwrP2+gDIgDwzlYx46+tg
	t8YpfybzkW1FthnL0XCssdr9lWzdhf3dx2UQRnP9DbygRi4f9dn+sWb6BJh2yRYGHEclgONk7qy
	ra7jsopWdaHJ+2HYrCxUJ8hnOOBb2G0ATd+ZilBEeO/Ien366Vn6XKECb+MFRSCmKB
X-Received: by 2002:a05:6000:29d3:b0:45d:3cbf:bdda with SMTP id ffacd0b85a97d-45eb38bb000mr9671985f8f.20.1779554159363;
        Sat, 23 May 2026 09:35:59 -0700 (PDT)
Received: from pumpkin (82-69-66-36.dsl.in-addr.zen.co.uk. [82.69.66.36])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-45eb6d493dfsm13521078f8f.23.2026.05.23.09.35.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 23 May 2026 09:35:59 -0700 (PDT)
Date: Sat, 23 May 2026 17:35:57 +0100
From: David Laight <david.laight.linux@gmail.com>
To: patchwork-bot+netdevbpf@kernel.org
Cc: Stefano Garzarella <sgarzare@redhat.com>, netdev@vger.kernel.org,
 xuanzhuo@linux.alibaba.com, horms@kernel.org,
 virtualization@lists.linux.dev, linux-kernel@vger.kernel.org,
 kvm@vger.kernel.org, kuba@kernel.org, eperezma@redhat.com,
 pabeni@redhat.com, mst@redhat.com, davem@davemloft.net,
 jasowang@redhat.com, stefanha@redhat.com, edumazet@google.com,
 stable@vger.kernel.org
Subject: Re: [PATCH net] vsock/virtio: fix skb overhead overflow on 32-bit
 builds
Message-ID: <20260523173557.5cc4f4f6@pumpkin>
In-Reply-To: <177950282964.1445071.6600517211632117224.git-patchwork-notify@kernel.org>
References: <20260521124732.125771-1-sgarzare@redhat.com>
	<177950282964.1445071.6600517211632117224.git-patchwork-notify@kernel.org>
X-Mailer: Claws Mail 4.1.1 (GTK 3.24.38; arm-unknown-linux-gnueabihf)
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Sat, 23 May 2026 02:20:29 +0000
patchwork-bot+netdevbpf@kernel.org wrote:

> Hello:
> 
> This patch was applied to netdev/net.git (main)
> by Jakub Kicinski <kuba@kernel.org>:

Did anyone else notice that is isn't a bug?

There is no way that a 'count of bytes of kernel memory' can overflow
the size of 'long'.

-- David
 
> 
> On Thu, 21 May 2026 14:47:32 +0200 you wrote:
> > From: Stefano Garzarella <sgarzare@redhat.com>
> > 
> > On 32-bit architectures, both skb_queue_len() and SKB_TRUESIZE(0) evaluate
> > to 32-bit values. The multiplication can overflow before being assigned to
> > the u64 skb_overhead variable, making the skb overhead check ineffective.
> > 
> > Cast skb_queue_len() to u64 so the multiplication is always performed in
> > 64-bit arithmetic.
> > 
> > [...]  
> 
> Here is the summary with links:
>   - [net] vsock/virtio: fix skb overhead overflow on 32-bit builds
>     https://git.kernel.org/netdev/net/c/4157501b9a8f
> 
> You are awesome, thank you!

