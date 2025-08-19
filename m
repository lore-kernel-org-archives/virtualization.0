Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B527B29E0E7
	for <virtualization@lists.linux.dev>; Tue, 19 Aug 2025 02:48:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755571740; cv=none; b=KHOYT0GLc2ZajUswpY7WSpuoFPYp+XGY5/1u4So9vGaNsPEguZBnvq+dPWTqhUzPSB6U9Pw64JEGaEu9aUmttyf5CRbL4GEe2+EQk8eYcC8G8XIQrzlIuRj/4VPF8/jXn9u8s4olGv82lbLtyf0QwsHPCs9/OuXO0lxhV6A22y0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755571740; c=relaxed/simple;
	bh=rKki1UBfO66wOspZuH0gsX0riYu6EtAjgPc5TTW/K7M=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=hO3a2btSZBJX82ywyaQxoMYcMXc4xct4wbRNMDRKyvPsPsbjwlADw494I7vIK/Ja7avTKRccJSeOlWwZguxJwT8knJAg+iERwRbHhPlSzHVtbn0UPuQgqGuQqEb92xMPVRd7bv/rm7RDfUSFqqa0seLPxCoAgKUp7gRi25z34yY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=VUSF0ysO; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="VUSF0ysO"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1755571737;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=rKki1UBfO66wOspZuH0gsX0riYu6EtAjgPc5TTW/K7M=;
	b=VUSF0ysO9epIsYzfH5mvFHFJLtI6accpAd8PnvK7UjTqrgYm8rY4C9bhsM+H+75/fuvI6q
	sUFWaj57AmmHM73cuEWqCfdFbpR6jXHUJM+BC+6ISVXlQ2AT+IIq2+FEm4FocOybNvW+qD
	JF6hyEmZwSUkNAyDOP/V4Sger5DxrIU=
Received: from mail-pj1-f71.google.com (mail-pj1-f71.google.com
 [209.85.216.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-93-NHvbxAUmNVOhOyyjeAtKgA-1; Mon, 18 Aug 2025 22:48:53 -0400
X-MC-Unique: NHvbxAUmNVOhOyyjeAtKgA-1
X-Mimecast-MFC-AGG-ID: NHvbxAUmNVOhOyyjeAtKgA_1755571733
Received: by mail-pj1-f71.google.com with SMTP id 98e67ed59e1d1-3232669f95eso4640542a91.0
        for <virtualization@lists.linux.dev>; Mon, 18 Aug 2025 19:48:53 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755571732; x=1756176532;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=rKki1UBfO66wOspZuH0gsX0riYu6EtAjgPc5TTW/K7M=;
        b=Q+kRQzJKLNBjFryDcpRRG2U0TQyaCFimK2d0wPSL16uqpvldtSAst1k5cbcabwVlSx
         9Qb5AjNcnkuK08QI01Tvf1/lK/OQPvlG1umSSFaJGEj5zpvzO4QJyzlmtQSSc0hTDGpN
         nxYYCe/oY82gC8FoUtzpTQo8jfN6SCInsH/fcAp6clIAi8shhW+C1VlUuS5Gug8x0rR+
         r0nWuALLT2vWSi2XD2bKzdg28IOdw/bHIBoC7QiOmqAkMYlrspWDaAOAQYG2PyOB6nkG
         SzQ3hWWSTBrc7fjV3yRWwayWogpt5SK9pXQ29tDTUAzflhqgJnT3FcsteoIXqqh6bt5K
         pCQg==
X-Forwarded-Encrypted: i=1; AJvYcCXlSNG60C9hKrW6XKOIU8/sVfnvBwrSAiISsOelxrit0/8ZgmhhC4KEFR6JqBNdrF0QYQhRHLU9tdAxIzk3pA==@lists.linux.dev
X-Gm-Message-State: AOJu0YxoLXyjdq8LOQMCD7rA2L6IVl2KqnEqoBTavv7kKhV/B8EP56ls
	gA7/LF3nf8FBjUvOymgBX6iT17f2E46lfPyoR0pQFAqJXclDPXmZ+xMyjWDTkDRv2zlGx/NfBKE
	fDf/+cQ9xhEFJu3BM9HplklUHl5BfZI9si1S5Otz9/DtwOPkcWvEAXWJ2d6qjOodSE0HGUCdt71
	fAjBhQ9Iig8BWHHymYhK79ht7A4n3ZpmX/JFXUThCHICc=
X-Gm-Gg: ASbGncvODorHz/MyjcZ6HwxmauvAtGGM8eosxUIH+AOTMhRpLb5nPhmRWsLypA9ihZj
	2snJ24TUaydAIqrmE6uw6dhfCJBMAUbIf6NDgsrA2PKp+bwgci7x3Mikh7dhZwyA0Eix/C81dpX
	pYW+0UtlNxkaHaO6QV18Ys4Cg=
X-Received: by 2002:a17:90b:388c:b0:2f8:34df:5652 with SMTP id 98e67ed59e1d1-32476a6c3b0mr1536782a91.21.1755571732533;
        Mon, 18 Aug 2025 19:48:52 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IF6dKD0oWKP+FU214PIKLYVdhY8eEWItrOTXjcxGw6l+G1j5qcpIfVxj44ZLVtPTiZnrRSk7uCddgfYxZ/3F0A=
X-Received: by 2002:a17:90b:388c:b0:2f8:34df:5652 with SMTP id
 98e67ed59e1d1-32476a6c3b0mr1536750a91.21.1755571731921; Mon, 18 Aug 2025
 19:48:51 -0700 (PDT)
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
References: <20250815085503.3034e391@kernel.org> <CGME20250818011515epcas5p21295745d0e831fd988706877d598f913@epcas5p2.samsung.com>
 <20250818011522.1334212-1-junnan01.wu@samsung.com> <20250818083917.435a4263@kernel.org>
In-Reply-To: <20250818083917.435a4263@kernel.org>
From: Jason Wang <jasowang@redhat.com>
Date: Tue, 19 Aug 2025 10:48:37 +0800
X-Gm-Features: Ac12FXwGjt0tc43brXAcZucIny41hc0azUrrUQ6OWLOA5fDrbWEhAZEnJ-HtEtw
Message-ID: <CACGkMEsVJcb2YYvfXYA0soE++cPEmQatkC0tB+shNKB=OTteWg@mail.gmail.com>
Subject: Re: [PATCH net] virtio_net: adjust the execution order of function
 `virtnet_close` during freeze
To: Jakub Kicinski <kuba@kernel.org>
Cc: Junnan Wu <junnan01.wu@samsung.com>, andrew+netdev@lunn.ch, davem@davemloft.net, 
	edumazet@google.com, eperezma@redhat.com, lei19.wang@samsung.com, 
	linux-kernel@vger.kernel.org, mst@redhat.com, netdev@vger.kernel.org, 
	pabeni@redhat.com, q1.huang@samsung.com, virtualization@lists.linux.dev, 
	xuanzhuo@linux.alibaba.com, ying123.xu@samsung.com
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: _wy0QDyQOK4jAzaP5tkRb0lqfVnTE3ygyJyEwkAqmXE_1755571733
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Aug 18, 2025 at 11:39=E2=80=AFPM Jakub Kicinski <kuba@kernel.org> w=
rote:
>
> On Mon, 18 Aug 2025 09:15:22 +0800 Junnan Wu wrote:
> > > > Yes, you are right. The commit of this fix tag is the first commit =
I
> > > > found which add function `virtnet_poll_cleantx`. Actually, we are n=
ot
> > > > sure whether this issue appears after this commit.
> > > >
> > > > In our side, this issue is found by chance in version 5.15.
> > > >
> > > > It's hard to find the key commit which cause this issue
> > > > for reason that the reproduction of this scenario is too complex.
> > >
> > > I think the problem needs to be more clearly understood, and then it
> > > will be easier to find the fixes tag. At the face of it the patch
> > > makes it look like close() doesn't reliably stop the device, which
> > > is highly odd.
> >
> > Yes, you are right. It is really strange that `close()` acts like
> > that, because current order has worked for long time. But panic call
> > stack in our env shows that the function `virtnet_close` and
> > `netif_device_detach` should have a correct execution order. And it
> > needs more time to find the fixes tag. I wonder that is it must have
> > fixes tag to merge?
> >
> > By the way, you mentioned that "the problem need to be more clearly
> > understood", did you mean the descriptions and sequences in commit
> > message are not easy to understand? Do you have some suggestions
> > about this?
>
> Perhaps Jason gets your explanation and will correct me, but to me it
> seems like the fix is based on trial and error rather than clear
> understanding of the problem. If you understood the problem clearly
> you should be able to find the Fixes tag without a problem..
>

+1

The code looks fine but the fixes tag needs to be correct.

Thanks

