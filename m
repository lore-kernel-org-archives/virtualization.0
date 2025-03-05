Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 396412561BB
	for <virtualization@lists.linux-foundation.org>; Wed,  5 Mar 2025 20:19:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=140.211.166.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741205973; cv=none; b=LrnJTNz0x7FHURiBnks+E0M/2rb5RXukG23YqoDa/VklKs5ZhYV0f5Lzu+a21q7FDMHca4bPk3HioGEFVIB9HzP9uCFkhRVH25NueIPAoX2/VGp9SKQodkOpvHMthxUljbu48iYg1d0tjfJ4+WqLCgIPL1nmTMAuHGAvDl2JfhE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741205973; c=relaxed/simple;
	bh=DFv/aofqC6RxYldakRl4YDuw3IKqapk4Psuo0zdjGi4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=I5syhJZw1MqxuvccDIgf4N1Jwqqe7hkZ4wz1BHBPfUNArLkyNFE8CGSdfGcHXU4WTIgVc+txt9I1iptLEpaFLpQ8QKSXbz+U2yebVvGbY9r+9PUO/X2IhJdcrLHJri+P9Fe5COoU2Lnvr/Ukm8HujRXJaZJp4yTeRSE6DAZ5SCk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Dj2b9y15; arc=none smtp.client-ip=140.211.166.133
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Dj2b9y15"
Received: from localhost (localhost [127.0.0.1])
	by smtp2.osuosl.org (Postfix) with ESMTP id B4B7A40484
	for <virtualization@lists.linux-foundation.org>; Wed,  5 Mar 2025 20:19:30 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
X-Spam-Flag: NO
X-Spam-Score: -2.099
X-Spam-Level:
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id J8WTfDcE-cZE for <virtualization@lists.linux-foundation.org>;
 Wed,  5 Mar 2025 20:19:30 +0000 (UTC)
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=2607:f8b0:4864:20::636; helo=mail-pl1-x636.google.com; envelope-from=bobbyeshleman@gmail.com; receiver=<UNKNOWN> 
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp2.osuosl.org D049240527
Authentication-Results: smtp2.osuosl.org; dmarc=pass (p=none dis=none) header.from=gmail.com
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org D049240527
Authentication-Results: smtp2.osuosl.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20230601 header.b=Dj2b9y15
Received: from mail-pl1-x636.google.com (mail-pl1-x636.google.com [IPv6:2607:f8b0:4864:20::636])
	by smtp2.osuosl.org (Postfix) with ESMTPS id D049240527
	for <virtualization@lists.linux-foundation.org>; Wed,  5 Mar 2025 20:19:29 +0000 (UTC)
Received: by mail-pl1-x636.google.com with SMTP id d9443c01a7336-223f4c06e9fso21301355ad.1
        for <virtualization@lists.linux-foundation.org>; Wed, 05 Mar 2025 12:19:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1741205969; x=1741810769; darn=lists.linux-foundation.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=ggSYKjNiS8Boto5d0Yt8S4og/EP9GTSZBqieM3le2yU=;
        b=Dj2b9y15Ojo5qDTtP02MQMKIrJUp2wuj86mh1wPKQr9sNgr6YFrW7ZUKK/WRL9Erc/
         mWfLLedaMOCySMpXGi7an5IbXbWN7UvQtloKuHrlL/CdZ74b4DtqqnfjAMUDQbTk8zT9
         i5HY2dCMrxVyy0z7DuZds2jNJqSFXZAjdYufGLZ9DfdKs7/NkSCTLe8n/WTy6kJuEX3E
         DBSvdzwhcDPbo7dF2FqERnRcX0gk5DmuZ/oWYfDWABO4X2tumAnM5AKuTHGNvc4kxmYp
         PaMW8gqdw5SiRPtdvLwNnn/YfpfT2W8XwiFNU7kJK5IcTEcqLFYqW2r7yV14I+pAjQdi
         d3SQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741205969; x=1741810769;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ggSYKjNiS8Boto5d0Yt8S4og/EP9GTSZBqieM3le2yU=;
        b=pKjb4TWHvaWyVnkmXiJ2jFymOLAngHddCSrgwY7WJhJ+vz46/jUtl+F8gGnOO32IPw
         g9RWtWrxVQuKx2Ax31w/AqycEbd1slvYSOx06OVoQBtuoVdenTQj6eP1FZIdGOOX3LZ3
         DcCGQgc0hrazLQ55i7DPNn5Fw4kS6BOAdkjIbWmZ18ZeYlttZQjzXXGil1Mw9oMuBylU
         fOALQzZHNYqxv2Y5XE6oA8EfROx0QQ7Q0js9Q9JzHcQgTBlGfm2+s0touEdHNLOJTHNH
         61EqpNbhwZ26LhWIbk0w/5nFTW5KG+raSErR7UNBcQoOZqH1knpFi98vx1ia6GMOBdgo
         E8Hg==
X-Forwarded-Encrypted: i=1; AJvYcCXVKaHeSCCXxGhgo8fFktLBFuOp8LN9qudfXp0EF6aQWccHw0EmN0rKjrGkhmaormRlvunRg/v5jMDjhDClEQ==@lists.linux-foundation.org
X-Gm-Message-State: AOJu0YyGkw2Sge8dT5V5OPU+4i27K0F0sav959/vGnRKgUZyYGivsse2
	0f/tkKL1d+egV0gWR0eRUXQ1c6L+tVzwyKPcaxT9BvEMakJYqk6X
X-Gm-Gg: ASbGncsSgmuuJzKJK7FifAZgiHbgV+bPfAnZPjgI3s52k/VwuCYG1DMd5L9+C/FHVAD
	cdl4U25ujKox2bLfCYFE1DpuxMZjrNbSVj74CzHd8Cj6BI28gx0p3LTKmM2N5sTT+7RAjLprApx
	6ZhILvN4PYHsQ9OEDEXQWdw5tnk1S+tKJ4S30uq3BvDByvZ41FvxiqUKvc4Eh5aOvIfNO3JAufC
	JoFLGVTliFRARy9bGdgRgPHAbP3w/PKhosKCq5ERcX3NmXyoMZKSePdEekm/UJeqm+rNUSnAIyH
	dxZ3c+EDhkCf6vnZ11U+09t/zBLYqwijELFx+5WlMVPPeW6DzNTRBZ3L05La2x/ejbg=
X-Google-Smtp-Source: AGHT+IHr2tihJ0au2ICgSWnpCRu00yBghmKv/sVI+EDCEbOk0rg+rxUiD5JA8UUFm0k+OdDJoEO2eA==
X-Received: by 2002:a17:903:1aab:b0:223:fb95:b019 with SMTP id d9443c01a7336-224094a3c17mr11459415ad.24.1741205968892;
        Wed, 05 Mar 2025 12:19:28 -0800 (PST)
Received: from devvm6277.cco0.facebook.com ([2a03:2880:2ff:71::])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-7363fa7f540sm8189030b3a.38.2025.03.05.12.19.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 05 Mar 2025 12:19:27 -0800 (PST)
Date: Wed, 5 Mar 2025 12:19:26 -0800
From: Bobby Eshleman <bobbyeshleman@gmail.com>
To: Stefano Garzarella <sgarzare@redhat.com>
Cc: "Michael S. Tsirkin" <mst@redhat.com>, Jakub Kicinski <kuba@kernel.org>,
	davem@davemloft.net, netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org, Jorgen Hansen <jhansen@vmware.com>,
	Jason Wang <jasowang@redhat.com>, kvm@vger.kernel.org,
	Stefan Hajnoczi <stefanha@redhat.com>,
	virtualization@lists.linux-foundation.org,
	linux-hyperv@vger.kernel.org, Dexuan Cui <decui@microsoft.com>
Subject: Re: [PATCH net-next 1/3] vsock: add network namespace support
Message-ID: <Z8ixzohy9a0b9QZ2@devvm6277.cco0.facebook.com>
References: <20200116172428.311437-1-sgarzare@redhat.com>
 <20200116172428.311437-2-sgarzare@redhat.com>
 <20250305022900-mutt-send-email-mst@kernel.org>
 <CAGxU2F5C1kTN+z2XLwATvs9pGq0HAvXhKp6NUULos7O3uarjCA@mail.gmail.com>
 <Z8hzu3+VQKKjlkRN@devvm6277.cco0.facebook.com>
 <CAGxU2F5EBpC1z7QY1VoPewxgEy3zU7P1nZH48PtOV1BtgN=Eyg@mail.gmail.com>
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAGxU2F5EBpC1z7QY1VoPewxgEy3zU7P1nZH48PtOV1BtgN=Eyg@mail.gmail.com>

On Wed, Mar 05, 2025 at 05:07:13PM +0100, Stefano Garzarella wrote:
> On Wed, 5 Mar 2025 at 16:55, Bobby Eshleman <bobbyeshleman@gmail.com> wrote:
> >
> > Do you know of any use cases for guest-side vsock netns?
> 
> Yep, as I mentioned in another mail this morning, the use case is
> nested VMs or containers running in the L1 guests.
> Users (e.g. Kata) would like to hide the L0<->L1 vsock channel in the
> container, so anything running there can't talk with the L0 host.
> 
> BTW we can do that incrementally if it's too complicated.
> 

Got it! I will try your solution with /dev/vsock-netns (unless there are
strong feelings otherwise), and if it becomes hairy maybe I'll omit it
in the next rev.

I don't think my earlier concern about port collissions in the G2H
scenario is worth worrying about without a real use case, that doesn't
sound expected by any users right now.

Thanks,
Bobby
