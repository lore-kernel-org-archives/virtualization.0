Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=170.10.133.124
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793213671;
	b=5CrCYQ4EgPa81QT0TzbXUQdf063+m5vQeS4oekRpH/J3uGOdiEBTM4oR5mTx3tu4Lk1m
	 N1CSkuMkmWIg93Lugrv1jCVwvKZ369jvwVAS+b9B0SFewP2ieU47IdWSPdeABddy1MVzH
	 6CI2ZXIfVmTu2txM+W/BYTg8DBfyiyzAnJ9/rgmCnEoQZDs7JZlW0Omo05khi8kWkdZxS
	 l0SBpb1U5nvvsRZZjYrXD+cPdy/k/bbVtaP2OzTy7lxcJkMyavo0Ckmia35ooj9bilwtO
	 c3XeGab6jDbUvt/LGfrq86jtKJJK2mmBm/OYQJaT5jApslHN2zrwNUIU9lxo5sc77Cg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793213671;
	h=DMARC-Filter:DKIM-Signature:Received:X-MC-Unique:
	 X-Mimecast-MFC-AGG-ID:Received:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:
	 X-Received:Received:Date:From:To:Cc:Subject:Message-ID:References:
	 MIME-Version:In-Reply-To:X-Mimecast-Spam-Score:X-Mimecast-MFC-PROC-ID:
	 X-Mimecast-Originator:Content-Type:Content-Disposition:
	 Content-Transfer-Encoding;
	bh=0vc/BwRMumh6GCDfZk9HEhgcPOmsWkZc9E+U0h5Wqek=;
	b=YEkTVYYxyzKOmj/r5NK7L4RS62Apm4ntSASnWJc46IgsKsyDMwwdd7SpMSkYiHolG71G
	 nFpwaaCEfsEh2qd6pbzdMtXSdy6NB9HJCUfWnYs6TcVArq7fZkljsGPCJRHtcshbHdr7R
	 CGnhHfKF+5+Ga3oa1ICKZ/PUNst5lwbj4uxXP6L7tnOm9aPURh4YnNtRHOoHTZFxU7+i+
	 ZaovzapK3DBAFzXpPVdK2lfIzXLDM0YVKibIAhtlX7XmbgdqbBpUCv0zXjXFYJlC48cCa
	 p2jFkvu5wqdkMIR721GmEovCUoqmoKbQhsf5+cvkusmWu8ILjWda+flenTd+jJ48XEQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=redhat.com;
	spf=pass smtp.mailfrom=redhat.com;
	dkim=pass header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b="EuckRQh/";
	arc=none smtp.remote-ip=170.10.133.124
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2879F606A31D
	for <virtualization@lists.linux.dev>; Wed, 28 Oct 2026 18:54:31 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 2879F606A31D
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=EuckRQh/
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1793213670;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=0vc/BwRMumh6GCDfZk9HEhgcPOmsWkZc9E+U0h5Wqek=;
	b=EuckRQh/vX6Rv2EuSqujU8lJJun/SUkyC6Qh2rfoMQq3qPnfosec12pC5sb9lOs6qL/1qb
	nURwjjkqi1dJXpO5J3uLIGX+eHQ8vyeEtnWlhf+2brDDz47cEGzPozrj9HgceiAn4IsQVI
	HEg3b9bnoEiE9os7FNiO/SgQk1ACvCs=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-622-bGgjrJJqP1qqmpCZWBxf7w-1; Wed, 28 Oct 2026 14:54:28 -0400
X-MC-Unique: bGgjrJJqP1qqmpCZWBxf7w-1
X-Mimecast-MFC-AGG-ID: bGgjrJJqP1qqmpCZWBxf7w_1793213668
Received: by mail-wm1-f69.google.com with SMTP id 5b1f17b1804b1-4a009f82bedso9350935e9.0
        for <virtualization@lists.linux.dev>; Wed, 28 Oct 2026 11:54:28 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793213667; x=1793818467;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :content-type:mime-version:references:message-id:subject:cc:to:from
         :date:x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=0vc/BwRMumh6GCDfZk9HEhgcPOmsWkZc9E+U0h5Wqek=;
        b=VUj+XGb5SAK78TKJetnGXMNsKKhC4pjUAqUDQLjbQsGzL+HkH0+kqehqszfeJJzD/L
         DfzP0JOnCfcLVe64NXLYyBUAVz1m0ENinswIO4hknxfu4Y0n1Eb7w27v0EZawwNlOrMq
         2eW46Zgw+a2kV389FqfeGF98mH1ew1l03HNCOWbc/mOrdSpR/38J7sbKnYLkIpZsWq9V
         gUnajyGVOjuFCvlq6khJDcIXquwSelFcyj7tewVoLoVC8RuhkxGd8PWpPoB/K+J5Ie3J
         1RhJqunimTt3z2rlPEVOSLg0vziFceKeO3nqHDcwKzGmp4HYzzQORXccmXD/HA6XkDIt
         axjQ==
X-Forwarded-Encrypted: i=1; AKwUvBzfy5WabHBtBV8ae2Sim36vrx+8fdqZF9myiNvv54Y5e+ICrRvsBo804R1bknmrYyMMqWvzg6rb88NslXs0dQ==@lists.linux.dev
X-Gm-Message-State: AFq9FYJ1UpJQEgPDHmModVPRqmiTh9C2qcGQtzUB/Mag21EYLnx8owRX
	2JMdRA9/QnDl/w0XgKmzRPyO8FUzMhgzLATf6OU5tfP45Ph26lYFDylcyMWeyqzlZseZH2a7qOC
	UelKR4MSWq6rpOvokwrTedyEpdzGRAwkx0xIoEUNwUBWmXWNBMi4aWZAZ+NfDf5lGNaaG
X-Gm-Gg: AYBFou3pBbrCm/AygQy/VObbTLb1rJHStvDix7KAbflMbl5fZeyQh/DL/JPbosw83d9
	73Jfhn9qeo1hZIkbp3bWyCLcWyCE40f7n6q10tChS3Z9jGbfwrjGv9iiK5ho/yL+kuM7zIpQjZl
	FsSodaSi4zj+9OHFusICUEJ/OidAG+ICaQF5BZe+U5lgjslA8wnju/UIKrp590r4IWhcb8b2dXq
	21bqF4fwMLfQlSHbZO+jMst9asNLaLuT+ZDz+PrKiLnXQboU5pYcgbS/tTNkZKXnvEHv6iqWaOq
	26FY33L/pOttLztsIAeB6ElCMN1MSEgy7XjivAYi0See154DO6hyBNBngLYw/YooR8w3Yi6qjm4
	yoDt/m0SKVJXAlskXA3dHYyPOWGxqfdUO90XXMh/Q
X-Received: by 2002:a05:600c:524a:b0:4a1:efba:511 with SMTP id 5b1f17b1804b1-4a9674e6bf7mr73578575e9.35.1793213667418;
        Wed, 28 Oct 2026 11:54:27 -0700 (PDT)
X-Received: by 2002:a05:600c:524a:b0:4a1:efba:511 with SMTP id 5b1f17b1804b1-4a9674e6bf7mr73577935e9.35.1793213666877;
        Wed, 28 Oct 2026 11:54:26 -0700 (PDT)
Received: from redhat.com ([2a0d:6fc0:1536:fc00:b838:383:1c7:6e81])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4aa80f04785sm10398775e9.4.2026.10.28.11.54.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 28 Oct 2026 11:54:26 -0700 (PDT)
Date: Wed, 28 Oct 2026 14:54:21 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Kevin Loughlin <kevinloughlin@google.com>
Cc: "David Hildenbrand (Arm)" <david@kernel.org>,
	Jason Wang <jasowangio@gmail.com>,
	Eugenio =?iso-8859-1?Q?P=E9rez?= <eperezma@redhat.com>,
	Xuan Zhuo <xuanzhuo@linux.alibaba.com>,
	Ard Biesheuvel <ardb@kernel.org>, Kiryl Shutsemau <kas@kernel.org>,
	Thomas Gleixner <tglx@kernel.org>, Ingo Molnar <mingo@redhat.com>,
	Borislav Petkov <bp@alien8.de>,
	Dave Hansen <dave.hansen@linux.intel.com>, x86@kernel.org,
	"H. Peter Anvin" <hpa@zytor.com>,
	Tom Lendacky <thomas.lendacky@amd.com>,
	Ashish Kalra <ashish.kalra@amd.com>,
	Michael Roth <michael.roth@amd.com>,
	Rick Edgecombe <rick.p.edgecombe@intel.com>,
	Andrew Morton <akpm@linux-foundation.org>,
	Vlastimil Babka <vbabka@kernel.org>,
	Mike Rapoport <rppt@kernel.org>,
	Suren Baghdasaryan <surenb@google.com>,
	Michal Hocko <mhocko@suse.com>,
	Brendan Jackman <brendan.jackman@linux.dev>,
	Johannes Weiner <hannes@cmpxchg.org>, Zi Yan <ziy@nvidia.com>,
	Alexander Duyck <alexanderduyck@fb.com>,
	virtualization@lists.linux.dev, linux-coco@lists.linux.dev,
	linux-efi@vger.kernel.org, linux-mm@kvack.org,
	linux-kernel@vger.kernel.org,
	Sidharth Telang <sidtelang@google.com>,
	Punit Salian <psalian@google.com>, Peter Gonda <pgonda@google.com>,
	Ackerley Tng <ackerleytng@google.com>,
	Jacky Li <jackyli@google.com>,
	Steve Rutherford <srutherford@google.com>,
	David Skidmore <davidskidmore@google.com>
Subject: Re: [PATCH 00/13] virtio_balloon, efi/unaccepted: support memory
 ballooning and free page reporting in CoCo guests
Message-ID: <20261028145316-mutt-send-email-mst@kernel.org>
References: <20261027025616.1632690-1-kevinloughlin@google.com>
 <279a92da-772c-422b-8047-ad37dbae211f@kernel.org>
 <CAGdbjmJ8qk7FCbGU85u9+db5_RtcrK2y_7TfNH+iuz+OJxebow@mail.gmail.com>
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Post: <mailto:virtualization@lists.linux.dev>
List-Help: <mailto:virtualization+help@lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
List-Owner: <mailto:virtualization+owner@lists.linux.dev>
Precedence: list
MIME-Version: 1.0
In-Reply-To: <CAGdbjmJ8qk7FCbGU85u9+db5_RtcrK2y_7TfNH+iuz+OJxebow@mail.gmail.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: ESYwI_kJkF9I3r54B4ZXLoqq8qo8UY-R9Nzs87L3VCo_1793213668
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit

On Wed, Oct 28, 2026 at 11:12:47AM -0700, Kevin Loughlin wrote:
> On Wed, Oct 28, 2026 at 2:01 AM David Hildenbrand (Arm)
> <david@kernel.org> wrote:
> >
> > On 10/27/26 03:56, Kevin Loughlin wrote:
> > >
> > [...]
> >
> > >  mm/page_alloc.c                               | 248 ++++++++++++-----
> >
> > This diff stat should give you a good indication why this series is not acceptable.
> 
> Got it. I will keep that in mind going forward, especially if I end up
> attempting a v2 that simplifies things.
> 
> On that note, I believe the majority of the bloat in mm/page_alloc.c
> comes from...
> 1. supporting the legacy inflate/deflate option
> 2. introducing support for various page sizes to be unaccepted
> 
> (1) I can get rid of by dropping the inflate/deflate option, which I
> think makes sense given free page reporting should be sufficient to
> enable dynamic guest downsizing in cooperative scenarios.
> 
> (2) becomes simpler in part just by doing (1). For further
> simplification, we could potentially restrict free page reporting for
> CoCo guests to the current 4 MB MAX_PAGE_ORDER instead of supporting
> any order 2 MB and up. There's a trade-off here for reporting
> effectiveness under fragmentation, but perhaps support for 4 MB only
> (and its relative simplicity) could be acceptable? Especially since we
> would then maintain the invariant that all pages on the unaccepted
> list are MAX_PAGE_ORDER?

I'm not sure what is meant here.
But if a lot of memory is free and it gets merged beyond MAX_PAGE_ORDER
and then it's not reported, that's counterintuitive.

> If I can sufficiently simplify the changes (especially in mm/), do you
> potentially see a path forward purely for the free page reporting
> aspect of this (dropping inflate/deflate)?
> 
> Thank you for taking the time to review, David!

