Received: from mail-lj1-f175.google.com (mail-lj1-f175.google.com [209.85.208.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 36916513556
	for <virtualization@lists.linux.dev>; Thu, 15 Oct 2026 11:33:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.208.175
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792064031; cv=pass; b=KVNPMqDZSJf/Oh4qmnUiZegPmQ6NAWj9zQdEaxviYDevHRHREqzdrY2Y4AL5ti5MnaWQqlJN2DLKibVUTHTcDpFhcGk7O9k3vY6lXnLOv894h7RzdzclpvOhRsMuIrOp3dj+R3u9N+dngCMvCqkxvVjqQMjdIo7XMKS66zsOXzQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792064031; c=relaxed/simple;
	bh=78wXkLFw/SMfWWA5rRLBi3jwnfNyUqDFiIvYEtDeyqc=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=MFEj5+ySz5/oyZj1mbRn7GTfakVOUN2oawPU3gtzQekFSMnt344eZhpdR7cxuwzj8cjY4k6lc3vy0HPme8GRg/NJH8ddGkb2dlnfe3qTWXohc3xjEXKBlPnXBso2WQ4IQDrKCnY4W2rZlPiMRtkG3MENN90RNU78QlSTOOTY8Hg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=nebusec.ai; spf=pass smtp.mailfrom=nebusec.ai; dkim=pass (2048-bit key) header.d=nebusec.ai header.i=@nebusec.ai header.b=VLU4ZouW; arc=pass smtp.client-ip=209.85.208.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=nebusec.ai
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nebusec.ai
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nebusec.ai header.i=@nebusec.ai header.b="VLU4ZouW"
Received: by mail-lj1-f175.google.com with SMTP id 38308e7fff4ca-3ab06692d33so2482631fa.1
        for <virtualization@lists.linux.dev>; Thu, 15 Oct 2026 04:33:45 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1792064024; cv=none;
        d=google.com; s=arc-20260327;
        b=ACY7vNlgfwii5BFdxVfgXzG9cV1EjxsEsayUY/+RRFN+lEyPE+ZZMJx0zQIDpnLnnI
         0IC7iOyiWO4oa/JJP1UKErEwcNHm4UxbrWqtlegOhmERxMqje6j9g+eoOI4YfpVM32W4
         0XOeMSKz4yrnLzrUGu1ESoqY1rZwf7feiBXqT5c5bLh5D3zMVUIFgC3LlR7CxenCofGg
         HC8B/zK6F+2FjUTSiw6IJHToM113JT0PHUwZXNHxH1wxPqql9IEexkYn2mlckcwct1Xf
         6OJQJSesbkP8hEMHJjYJm7FmUPnrawvp3N6WbSpr9/fCH3CUpD01v5izFKTTV7hZN983
         8hjQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=kVkAPVeV3U3Z1r6vn3DHdC0uUky7cOD11NYVy4jKyNM=;
        fh=K4niGLhseU0W3VIhuSdpNXpfAlO2IZ7EJOteUs+LPJI=;
        b=JTwjdsGEWPVmu7iYaZNq14uTFNMNCQg7FkNSnWQAF2y0z8AzL05BvsYGyfnZBf8xTQ
         UYz4N73MZcgydv6fDH3ua4l7xxCxj8ztfUIeNwRNBMnkJkwJ7XEO1dnZ1caCfrx8kDgm
         xb1WJgUJbjm0cN04YvuapNcfi6jd4MY/9IrrBYFd/rD/Z0NoFDShiPaMbvb3yw7YUoC3
         5viOBt61jQgCvq8bQD9GedO2sAFTO/Qu4eiJq0pifBJ4FXQ3WdTLZh+6oIR3HPtme2gt
         zcon6jFDPm1cqClPpYAXb/Is1mjSQ1FPErDWD6wLkCbI7P+zdZfSCrf2j95Coc94ZPcI
         5pbg==;
        darn=lists.linux.dev
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=nebusec.ai; s=google; t=1792064024; x=1792668824; darn=lists.linux.dev;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=kVkAPVeV3U3Z1r6vn3DHdC0uUky7cOD11NYVy4jKyNM=;
        b=VLU4ZouWu5znH95ctUFR6yVOosAVp9tSwHFMFsAaRZfXqRJOn0UNZHoB0kqFWEYv0N
         2Yu7W72Yjy6AddNzBr2GIkq9R1Qe6caNNjFJWx9/CWgqdOwr/ZawxIPn+NNk1NC6gooS
         4QJjxTN/kcxfMFCbPKr4r5LubeRqNFFX6AP9rK0Pp/WYvMM+GPMO7MNRTb9ZxDv2Dhzd
         FdhKj22OO/ub02xamft/fRu+J2xKbC3JvAk4fvkzRT7k0lv3jysajv2Mp3l6xVNQrnim
         D+HuMHO46ylf7MWID2En/SajPpSQI4FHkNsclj3aDittgs7GP9LNmRFuGTYc4AHgAnN5
         5Eyw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792064024; x=1792668824;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=kVkAPVeV3U3Z1r6vn3DHdC0uUky7cOD11NYVy4jKyNM=;
        b=wOwLV08YUTtB5M9oqmPxJI+OKbSThHVPR06FeFvf56LjXaC7ld/Xi9zY4+lXNrjNS8
         kWAlbvXUhZxXrM4HraIAbI8Te9y5cQjvn8Ycj91PUuhI7KiVqfHYcKVUhCnjtFiuu457
         vydj3TmRBwQl+uJ9xr8k+JbYpMuJsCTPZsGq5dOfSMGVIR7OjI/Y49Ivm2wxlpjEwcrG
         1VX6BeVSrwfrM0D/UhWQXlOFAXIwRx4AfnPKsU9R/xGoRD0FvJ7BhmGHEo2Aim3OMxOm
         OoCRR3llWEDVEx0R76rtKaXNZm19eRg/ipM7Xo39lhDmNHCd42642GjxHIO1lBoab7/D
         ENtw==
X-Forwarded-Encrypted: i=1; AKwUvBx5boru9McOuL3wguDyNfqLXWWmkgGNB2hnw0VTzmdxJf2T1Gon2k6R35NgdHQh9LoMA4K9JbkRJ3XiOpZGZQ==@lists.linux.dev
X-Gm-Message-State: AFq9FYLZWoJucqQP9EsqV+2kNP60B0NUSwKmjAAAnHmvH/uzcw494Q/t
	ooKtU+H4HMNFWl13PSsxgC+6pKggsiNxcKq1/7pw8r26b6o9JFUTYcL6blzfgdMRQOeB1AnlV1X
	pUwEB8hglzobw+LDuVZ8qQLc8fJU5NL1KPHtVYYR3Av4=
X-Gm-Gg: AYBFou32riawA77hQx2kaAlrIK23sH0Fkv4H/6/ErW/y/CLPtiTzxRH97tvL6P1D7h5
	HTDwYkKKFDsEf28Bd61GM3C+pGk0j6/DfJsfqaPSPJHX9MTyCE1cIQAqYxAijRmAVAbDU0PTqfB
	GyA7xfuN3dBOm6cnpaID+K+naayp5wjwZINd3AMjBtkyv4KlybzPQL+PSSN6zIy0nUYfYl1ivGc
	k27fsGJ+nkX539wmmdRBnKdd6EtHuuG55jMvO9GoS1qR7y1v3GEaf3EKYCsKXlkdY6NS1lO8UlI
	jS6z0qFI1iG627EVYF1/3xYwH8K858fD9Mi6mrcMCXeuf97O305YWB3Ze+40j10fZBaosexYFoI
	y82jwEJZ1Fw==
X-Received: by 2002:a2e:b019:0:b0:3a6:53b7:65f with SMTP id
 38308e7fff4ca-3a9c56e2e18mr32007541fa.24.1792064023930; Thu, 15 Oct 2026
 04:33:43 -0700 (PDT)
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
References: <cover.1792048855.git.zihanx@nebusec.ai> <atCtUFcG9b4ykXY3@strlen.de>
In-Reply-To: <atCtUFcG9b4ykXY3@strlen.de>
From: zihan xi <zihanx@nebusec.ai>
Date: Thu, 15 Oct 2026 19:33:31 +0800
X-Gm-Features: AclHuK_8_Kk2IIVBq5gfnontRtGKaffdTFvzSUc3-5H_TGMTs9I-jfqzlZDWd3I
Message-ID: <CAANe3eS=72iEkSwLGToMZmv_Drk3Naky2OL8oM_11GZztR3s4g@mail.gmail.com>
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

Thanks for taking the time to review this series. Your comments make
clear that I have not yet presented a sufficiently simple, coherent
design, particularly why both patches 1 and 2 are needed.

I will go back to the recursion-guard design and first evaluate
whether the existing current->in_nf_duplicate flag can be used by both
the IPv4/IPv6 and netdev duplication paths, replacing the separate
egress recursion counter. I will check the effects on the counter=E2=80=99s
other users and verify the relevant egress, bottom-half, and
asynchronous receive paths before deciding whether a task-local flag
is sufficient. I will not assume that it covers asynchronous paths
without evidence.

I understand that you have no objection to patch 1 on its own. I will
nevertheless check whether the unified design makes its NFQUEUE
queue-entry state redundant; if not, I will keep that change limited
to the NFQUEUE state-lifetimeissue.

I agree that the TTL/hop-limit change is separate from this series. I
will leave it out and consider it independently alongside the
common-helper work in -next.

I also take your point about scope: the goal should be a simple,
coherent recursion guard for this duplication behavior, not a general
mechanism for detecting every possible source of CPU or memory
consumption. I will return with the path analysis and a smaller design
before sending another series.

Best regards,
Zihan
