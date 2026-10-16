Received: from mail-lj1-f173.google.com (mail-lj1-f173.google.com [209.85.208.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 242114EDCC3
	for <virtualization@lists.linux.dev>; Fri, 16 Oct 2026 16:12:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.208.173
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792167166; cv=pass; b=UEN34SpKzwlCcPgrhTWbUjWaFDrxxAqkGMn57TjHzp7UThDGWcqTj9lLng/cI4rjRk4XXMzUji+GaW6rP9SpEVTptizfPXQ2MoZKst+Zu5D0+Ck+TgPoqYAIt7RjvjxPf5OmPmQBsi9gUUqASUeADWqV85QS4KpEme7/WMIFkdM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792167166; c=relaxed/simple;
	bh=zBk/WWunbgjQ1PnhejDQFmkv3G3u9bY8Wo8DwzlmXqg=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=RvHNkPphxN5FHh89w0s+iJpfy2+HUOzt82X2ikTLQl51vlvGoWJTHnw/pRV/ocbVm3SDeAkTVkaZ1IWz6ibz6U8MDcpXDoiuNdfmMEeocZ/XX5mSO2dIBGfOV6dWmN/IN7CuCEwUvyz/09t2AcvimuxOvoW9kKLCZDY2l6fYsQ4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=nebusec.ai; spf=pass smtp.mailfrom=nebusec.ai; dkim=pass (2048-bit key) header.d=nebusec.ai header.i=@nebusec.ai header.b=lM1VkOhD; arc=pass smtp.client-ip=209.85.208.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=nebusec.ai
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nebusec.ai
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nebusec.ai header.i=@nebusec.ai header.b="lM1VkOhD"
Received: by mail-lj1-f173.google.com with SMTP id 38308e7fff4ca-3a777d4f321so366791fa.0
        for <virtualization@lists.linux.dev>; Fri, 16 Oct 2026 09:12:42 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1792167161; cv=none;
        d=google.com; s=arc-20260327;
        b=Cuua9APcvFRXNDD8Y8CZifGhQyT4sEmuVexhvrlDkYFpLMW4/vxEEnjMnopc5W6q6S
         3l2xzmpeeNY6onkWsawrhURY5qB+2ATKenKi5OMBJoLdlPWRKI4mdjz1bzYHaB5CSHkY
         a+o8tVoGDWc4/9DQVudVR3Qi0WU6AJa8fM1Lxymc7Hav1lv0gGXlRG5Mh50MJ5RUr8gC
         Jj3jTI+pvnfUm7QtgqoDoI0BklGcQMC4VCXm0roFxFxJ9+gm+674pVTLUrEoxTS5H5Ae
         59iptwcgQj4M+HLLSVombxK5q74j20MPoE1pWFcfA6AHCYFRAFbfQkr/T5yA6YNsNR/b
         aiIA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=1DBXJxHvquUaLKJ+tkdkfcHBt7XZVv/oRHXlHwD+SAo=;
        fh=T96gClJAKeOFSFsdwjhFPSmQWcplqCqeigkNe/U+2vA=;
        b=lfrQ600JNC7eN8We2GMnURMKh7MRO+M1mHPkYJuxlglnY3vSydssEQTBVpTSisB05B
         QpB3BgpwnQnrwOSVdhN/elIRGVbYlwrwcS5/HGGyETal0Teaap6hdhZOWjYXNr4pmbcV
         TCR9pXL7Ddz3VO1pLUOYXNEaAs9gEF2I/xVZkHzxBD4f041l5Eph8ubmpGi2mwXlrGBx
         7cJ+UYWr4TbxKwWhf2BTHQn6Y6mXxe48o9H6d+9i3s/nBNo9YjMuGZDlShUBaiNhg6qo
         WxKzSSS2zxIOiVaEExu3yimaRjaoGtU7N6rHUfzO2twRP1UyWuTU3IkFN8mNu6mooHrF
         ppvQ==;
        darn=lists.linux.dev
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=nebusec.ai; s=google; t=1792167161; x=1792771961; darn=lists.linux.dev;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=1DBXJxHvquUaLKJ+tkdkfcHBt7XZVv/oRHXlHwD+SAo=;
        b=lM1VkOhDwTyY8vs+tX7TUqqswIKvXPuzfPkoFMXv1RsQ1/qHJLixAeCf6KaRxlPqyP
         VCq3Pqb7DKdlf7T4VDzzBqNHCuCjZoQzYawp1/EsuTXM9IRpWdaReCRC8NxSaZPcFNQI
         Yu4y/gfWwZPyg2im3jEPGL99ptNfCkR8BobavYWml4Jp54HknpO8DUwdH1qcC3jlSL4H
         DY82/E+mLfd0wt1UwHgldoVI84Ql3JrxcyeZ3B7C9WPLTB6qMS5SMddhTwfoRdTw3jEO
         aLT/1nEKIf1yKrb+n33k+YajpVZvyDGiXWFao/8I1re5ResOddIxTJi63HCPysOfUOHp
         cJ+g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792167161; x=1792771961;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=1DBXJxHvquUaLKJ+tkdkfcHBt7XZVv/oRHXlHwD+SAo=;
        b=Df/viXyhTK0u5/wYzdlLnPCTBz3c6BLAWmKfMsmRmeKUHb5n0xwEDZ4O505Y5vXHhF
         6ozKnChRbFLpGxPMfP7r+LNr4X14LkmMUeo+NdzNignS2s9iGKD0dJbg1i/ixbJ5EJBA
         jib6SxaFMLJYclloe5Ht4Knf6OQdq0PAUnaP6rDpOpiDdoykYltAlj1nINbdj7FNC/Q0
         0PtQGibwlc74jwLoDmLkT62igEoj9y8FdRnWtQNJxmdGqMM9B1N8ICobV1auMrBZLpgz
         4yWbZ7dmpsVKS99jB7WsqCqgxGZr1z81DCw3tQj9IBtW4XyqEaTWyuLfUYdBIW1OB+z2
         X/HQ==
X-Forwarded-Encrypted: i=1; AKwUvBzn1h6dlJWrdNylzoaHVAENEll5C1i+rbkH/hH/v18IhGPmJi3MvLLOGXGE5cQ/GZL5klpiz9HD4Cf5TxBAKA==@lists.linux.dev
X-Gm-Message-State: AFq9FYKfsfkCp0ZrZ7qkniBlR0wzZS+7ryKjzi4cyl+GAzDVM0N9V96i
	uW4spHhm8VX47zYg4j33q4E14YuLTwgR/qT1buJKdbtRc8CacwOVb0JFw6zXc3af8hiE4nrqBYV
	qxVbCWBAVIo9yILXZBXneZ19s50AzBArSUT3b8Xa6QFQ=
X-Gm-Gg: AYBFou3BKp4tCigQEbtfygiA0/S6KRj0oTUuydL9PN7wzTaPS/GRLN/NqpGEpE/7OLm
	DugtZHLPAljmM2l7nNwBapMILVr9s1ym9PCE7UFJ2eOiGNgfYZ7RU734GfI0NlS91nLvnJEWlX/
	SfgeWUvRcd/8eyKtn4xkd0kCW2FaM5xO25UGUXmmoS9NQcu+ijO4t+CfhCHex6fOtNU6Qy86ZaS
	XYKUNLdBqTaMKXJRTR41P0RzzoB/er47znsTWm+Oj6ZVqbt0e73i7PyB6IdG8VRUN6qfp4dijU6
	ofk3fms6EIzbQeYJ4xWXPgEAPE7WSubca4wD8L0iPb4oSYtC2N5DRHWlpqiaGsHW9bHKZwzN1eC
	3q6zM+vpYeQ==
X-Received: by 2002:a2e:9a10:0:b0:3a9:c840:10ee with SMTP id
 38308e7fff4ca-3ab2927a909mr511431fa.5.1792167160733; Fri, 16 Oct 2026
 09:12:40 -0700 (PDT)
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
References: <cover.1792048855.git.zihanx@nebusec.ai> <atCtUFcG9b4ykXY3@strlen.de>
In-Reply-To: <atCtUFcG9b4ykXY3@strlen.de>
From: zihan xi <zihanx@nebusec.ai>
Date: Sat, 17 Oct 2026 00:12:27 +0800
X-Gm-Features: AclHuK9WXLPZ_WQaM633BzwfDjRGTUWRZmkMt1BFBbMb-E1VSzEd_hb2wxJXXZk
Message-ID: <CAANe3eTSz3-EE0=9JNFBMFDqZ9NUfScHdi8EN30UVaTiRq0vcg@mail.gmail.com>
Subject: Re: [PATCH nf v8 0/3] netfilter: bound asynchronous packet duplication
To: Florian Westphal <fw@strlen.de>
Cc: netfilter-devel@vger.kernel.org, virtualization@lists.linux.dev, 
	intel-wired-lan@lists.osuosl.org, bpf@vger.kernel.org, pablo@netfilter.org, 
	phil@nwl.cc, davem@davemloft.net, edumazet@kernel.org, pabeni@redhat.com, 
	horms@kernel.org, kaber@trash.net, jengelh@medozas.de, andrew+netdev@lunn.ch, 
	mst@redhat.com, jasowangio@gmail.com, eperezma@redhat.com, 
	xuanzhuo@linux.alibaba.com, aleksander.lobakin@intel.com, ast@kernel.org, 
	daniel@iogearbox.net, hawk@kernel.org, john.fastabend@gmail.com, 
	sdf@fomichev.me, magnus.karlsson@intel.com, maciej.fijalkowski@intel.com, 
	willemb@google.com, alice.kernel@fastmail.im, eilaimemedsnaimel@gmail.com, 
	imv4bel@gmail.com, shiming.cheng@mediatek.com, sd@queasysnail.net, 
	vega@nebusec.ai, root@tr0jan.top
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Oct 15, 2026 at 6:39=E2=80=AFPM Florian Westphal <fw@strlen.de> wro=
te:
>
> Zihan Xi <zihanx@nebusec.ai> wrote:
> > Hi Linux kernel maintainers,
> >
> > We found and validated an issue in netfilter packet duplication. The bu=
g
> > is reachable by an unprivileged user in user and network namespaces.
> > Bounded tests exercised the fixes. Non-duplication packet semantics are
> > intended to remain unchanged. MIRRED flow offload for affected netdev d=
up
> > rules is rejected because it cannot enforce the duplication-depth limit=
.
> >
> > We will provide detailed information about the bug
> > in this email, along with a PoC to trigger it.
>
> Series makes no sense to me, sorry.  I dislike the 2nd patch, I see no
> reason why we need to make changes all over the place for this...?
>
> Also, if we go with 2nd patch, why do we still need the first?
>
> > The IPv4 and IPv6 duplication helpers use a task-local guard while a cl=
oned
> > packet traverses output hooks. If NFQUEUE suspends that traversal, the
> > output call can return and clear the guard before a later verdict resum=
es
> > the remaining hooks. The resumed packet can reach another duplication
> > consumer without the original guard. This can cause repeated packet
> > processing and consume CPU and network resources.
>
> "Don't do that, then"?
>
> I think the kernel should not crash when misused, but I don't think
> kernel should have to do extreme stunts to detect such loops.
>
> There are probably many other ways to make kernel allocate lots of
> memory or waste cpu cycles.
>
> E.g. via create use of veth and bridges, sched plug, teql, ...
>
> > Patch 1 records the
> > guard in the queue entry and restores it during reinjection. It keeps
> > bottom halves disabled during the reinjection traversal, restoring the
> > verdict task state before reenabling them.
>
> Its small enough, so I have no objections to this patch.
>
> > The netdev nft dup path has a separate synchronous transmit recursion
> > counter. It does not accompany a duplicated skb through asynchronous
> > software receive paths. Patch 2 carries a bounded duplication depth thr=
ough
> > skb and supported XDP conversions, resets it on reused buffers, and rej=
ects
> > MIRRED flow offload where the software depth cannot be enforced. This s=
cope
> > covers software skb/XDP continuity, not packet loops through physical
> > hardware or userspace device round trips.
>
> I think it would be better to first go to the drawing board and make ONE
> facility that governs the recursion part.
>
> From a quick glance, the difference is historical from time when
> per-module pcpu counters were used, so nf_dup netdev could not see the st=
ate
> of nft_dup toggle.  Now that its in task struct anyway, maybe its time to
> just zap the egress recursion counter and first make a patch that
> uses the bool toggle for both egress and normal dup?
>
> I would like to remove code, not add more.
>
> > At PRE_ROUTING and LOCAL_IN, the IPv4 and IPv6 helpers decrement TTL or
> > hop limit on the copy. Patch 3 stops creating copies when the value is
> > <=3D 1, so the decrement cannot reach zero or wrap a zero value to the
> > maximum.
>
> Thats unrelated problem.  There are other places that do TTL/HL
> decrements.  I think it makes sense to clean this up in -next and
> add common helpers and then use those.

Hi Florian,

Following up on my earlier note, I reviewed the NFQUEUE and netdev
paths and narrowed the proposed fix.

For IPv4/IPv6 duplication through NFQUEUE, the queue entry can preserve
current->in_nf_duplicate from the task that queued the packet. Reinjection
can restore that value while hook traversal resumes, then restore the
verdict task's previous value on exit. The reinjection path also needs
bottom halves disabled across that traversal so the task-local state
cannot be changed by BH processing during reinjection. The fail-open
case is synchronous: the queue entry carries the set state, so the
diagnostic must not warn merely because current->in_nf_duplicate is set
on entry.

The netdev duplication path is separate. It uses
nf_dev_xmit_recursion(), and the current counter does not follow the skb
through asynchronous software receive paths. My earlier patch 2 tried
to cover skb/XDP state propagation across those paths, but I agree that
it was too broad and complex. I have dropped it from this series rather
than present it as a complete or sufficiently small design. I have also
dropped the unrelated TTL/hop-limit change.

I will send a one-patch v9 series for the NFQUEUE guard preservation
only. It does not address netdev duplication or claim to provide a
general facility for bounding every asynchronous duplication path.

Best regards,
Zihan
