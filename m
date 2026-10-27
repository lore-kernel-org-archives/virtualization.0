Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=170.10.129.124
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793133575;
	b=mqBZ9v7IQr/HS6RI8hKVKRBtlycDAI8HcysORXHBduJAOC9tIYv9w1JlnjYwheH7+UcD
	 oJcIunA3L8KLTi6635Vpeb4cDHGaPz3nSbaLLM5Q5qIg0lUp8AYJK4PAyZ0VqoKJ/3qDr
	 kI6HEou2YlTQY6mK9oWLUlb+Tgsyjugz77cOEVr8M2MHBjZlup6pOv+Ear+CWkNExaJno
	 9eAAQ4byk4dviN434ORlj1Dt+owbnK/eZ5/I1p55FK+CQrRHbEFTzKSCMcDYIx4VdZtsR
	 wT0iw7FNjMbnSndeIuzRG0K76Ps82DB5hseh4ROw22YBMmM8EsB1Fm73cOyincbOQpA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793133575;
	h=DMARC-Filter:DKIM-Signature:Received:X-MC-Unique:
	 X-Mimecast-MFC-AGG-ID:Received:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:
	 X-Received:Received:Date:From:To:Cc:Subject:Message-ID:References:
	 MIME-Version:In-Reply-To:X-Mimecast-Spam-Score:X-Mimecast-MFC-PROC-ID:
	 X-Mimecast-Originator:Content-Type:Content-Disposition;
	bh=roOwYu0f5KwBgODRuBr3gTl9MLGpmNzor9SYb28//4o=;
	b=lQ5oY3XVgQXuNhWQk2T/4GLt2jD1JDMYbpI+SfcZEDezRd0O+x7rWbfPrCykBhD/4JVq
	 Jz0EUXbnMj/U4FMiKVooAuUsb+1ifs5UZQNo/xMbCfDr49HkgqR9Q3JxtZ79opYNqGOkn
	 447f+AGunGmDov0nShwG5kbDdEFCGdogzjZUQypIMjKI6Gvn0SE2Q0rtldhd4IhjidU1F
	 9zQgh2y5ffADNcIl7xuYAH0y6QtRWYhMJr/8DDfDDQmhBrEXcPsZBRuRYjIXAppTwxv0Z
	 IpF88y65G5wxaS+oJ1RhT7mAllrtrpjRFRvE9w/J1H6GnZFHrpG1nU3MGDZyhb0QnLw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=redhat.com;
	spf=pass smtp.mailfrom=redhat.com;
	dkim=pass header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=Yzz1bmfS;
	arc=none smtp.remote-ip=170.10.129.124
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 877FA606A31D
	for <virtualization@lists.linux.dev>; Tue, 27 Oct 2026 20:39:34 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 877FA606A31D
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=Yzz1bmfS
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1793133573;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=roOwYu0f5KwBgODRuBr3gTl9MLGpmNzor9SYb28//4o=;
	b=Yzz1bmfSNVbWf70ociut+9t8edvevKPOs03rhG9/4T0iDlgn/QgV5aHuQRgOWG1Xq7oOm3
	G/yTrFIjnNA1OL9Shmn8mjaw/PvzNV1ZPJzxoEcGuG2kCymCH8K3xa8orUefmA14BibdEx
	ef+G2ItOub3JXhwDkARyVecczJXoBVQ=
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-591-B3jYjykRO3KqHY-gg7NnxQ-1; Tue, 27 Oct 2026 16:39:30 -0400
X-MC-Unique: B3jYjykRO3KqHY-gg7NnxQ-1
X-Mimecast-MFC-AGG-ID: B3jYjykRO3KqHY-gg7NnxQ_1793133569
Received: by mail-wr1-f71.google.com with SMTP id ffacd0b85a97d-48dea677afcso132420f8f.1
        for <virtualization@lists.linux.dev>; Tue, 27 Oct 2026 13:39:29 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793133569; x=1793738369;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=roOwYu0f5KwBgODRuBr3gTl9MLGpmNzor9SYb28//4o=;
        b=Pxu80sSLmYuyPawin9PRexvTlov7soYn2LomteKywsUKoRJWx4c4oxEseFsVTReu2V
         hwWXBaqafJ1BVSNMyYLni+bvd0v8rL33LdUHK1QcXdrnYnQKBLBrRSfzdN3aOiVUjNvB
         7kTcapstg6NOjqnJ514MTh/cOcwtFwMaSpvzNQ+UHLARx2am88qqCvLuIahnQhg6O6Yv
         C8nn/vCmv79jb8xPhcoVzrXpWYPnZ5UG3KDy7Dd+OsnDJso5fms0yf4ypxTKdSdSUuso
         7HxFnrlOUVLFQVmCTRu1ljghUyfaOtq7tbQKtjjRhyEGPokthfRIqimd02AskjyM4iAF
         ZaFw==
X-Forwarded-Encrypted: i=1; AKwUvBxFhlubfHxAe4Vy4VbcW4sQ3ip6iOfTGUGoopwrc9nw0ztPQdBHVx07JrYWN2h8sjH1la7cvKrsvw1tCQ48bw==@lists.linux.dev
X-Gm-Message-State: AFq9FYJbsptVeIs/VdInT8LB9ehrBmBbnHXWr0l6dbdrrVUHtUbnfMmB
	QBtqwp5zRp2mhT/QY+JCHvt3ew9R1h1DHJaFGErbNag/Y92tlYWRYOmCicdQyZ0ClwC7TdRjNd3
	Nqv/rqnKd+pYiJiL1mp1zR01+6Cdik7h5k2PqrpNpaerGmivshF0p5zMh9A2X12xwdKvd
X-Gm-Gg: AYBFou01k/i7xwlB8sH+A+urfh5/EGLs+YP5i0qpA69KGx4As7aPZ5oe8klh3n/FQYR
	erh5aWZ9HAgeEcyDZ/7hoPYk85MQZ+gXSpPhKYKyKalmOZhB+krddSCtfaEkK2eTX1ygoYiPCrI
	o19dTtZdENt+kVEwq7m9sfAGmEFaLs9TueGnkCi9DGxxT/cqDUKH8asqKkD+8IXz2w4t4yN++kB
	jmt4hsuKojhvMglbKFHujseH5S8No2WA2udSSbJVzNucbd2jnym8YPnuff5IlXPynw6zSsPw/XO
	KwNSpHsy3+B0iqy+Afax86/Cf0FhCMnIxz2vBAQX4GIwDgk3mJbKvD//ZRk3ECGNukA=
X-Received: by 2002:a05:6000:60f:b0:48e:850:c0b7 with SMTP id ffacd0b85a97d-48e5d28705fmr1693088f8f.1.1793133568586;
        Tue, 27 Oct 2026 13:39:28 -0700 (PDT)
X-Received: by 2002:a05:6000:60f:b0:48e:850:c0b7 with SMTP id ffacd0b85a97d-48e5d28705fmr1693005f8f.1.1793133567964;
        Tue, 27 Oct 2026 13:39:27 -0700 (PDT)
Received: from redhat.com ([2a0d:6fc0:1536:fc00:b838:383:1c7:6e81])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-48e3ecdd5b3sm24553225f8f.53.2026.10.27.13.39.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 27 Oct 2026 13:39:24 -0700 (PDT)
Date: Tue, 27 Oct 2026 16:39:18 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Kevin Loughlin <kevinloughlin@google.com>
Cc: David Hildenbrand <david@kernel.org>, Jason Wang <jasowangio@gmail.com>,
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
Message-ID: <20261027163814-mutt-send-email-mst@kernel.org>
References: <20261027025616.1632690-1-kevinloughlin@google.com>
 <20261027051245-mutt-send-email-mst@kernel.org>
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Post: <mailto:virtualization@lists.linux.dev>
List-Help: <mailto:virtualization+help@lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
List-Owner: <mailto:virtualization+owner@lists.linux.dev>
Precedence: list
MIME-Version: 1.0
In-Reply-To: <20261027051245-mutt-send-email-mst@kernel.org>
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: GY_xMMZ0rsAwFbOA13LnW8ucRNx2OzwwLz_j1qpiWvA_1793133569
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Tue, Oct 27, 2026 at 06:29:35AM -0400, Michael S. Tsirkin wrote:
> On Tue, Oct 27, 2026 at 02:56:03AM +0000, Kevin Loughlin wrote:
> > This series enables virtio-balloon free page reporting and memory balloon
> > inflation/deflation in Confidential Computing (CoCo) guests, starting
> > with architectural hooks implemented for AMD SEV variants, in order to
> > support dynamic CoCo guest resizing.
> > 
> > Today, memory ballooning and free page reporting are essentially unusable
> > in CoCo guests due to three main roadblocks:
> 
> 
> For me, the bigger question is not whether we can, but whether we
> should. Considerations I would like to see addressed:
> 
> Security, e.g.: does knowing which memory is free leak information from
> the guest? If no, why not?
> Consider CONFIG_SHUFFLE_PAGE_ALLOCATOR, RANDSTRUCT, etc.
> 
> correctness, e.g.:  Linux has init on free (and default on windows), if
> initialized pages are dropped and host can not be trusted, they have to be
> re-initialized. Is this handled? I don't see it in code.
> 
> Also, performance, e.g.: How much does this re-initialization cost?
> 
> Management: it was simple with balloon off unconditionally.
> Now we are in murkier waters with various features offering
> various performance/security tradeoffs.
> What if some guests want the tradeoffs but others don't?
> 
> Documentation: for all of the above.
> 
> -- 
> MST

And to give this a bit more perspective, I present:

commit ab676b7d6fbf4b294bf198fb27ade5b0e865c7ce
Author: Kiryl Shutsemau <kas@kernel.org>
Date:   Mon Mar 9 23:11:12 2015 +0200

    pagemap: do not leak physical addresses to non-privileged userspace
    
    As pointed by recent post[1] on exploiting DRAM physical imperfection,
    /proc/PID/pagemap exposes sensitive information which can be used to do
    attacks.
    
    This disallows anybody without CAP_SYS_ADMIN to read the pagemap.
    
    [1] http://googleprojectzero.blogspot.com/2015/03/exploiting-dram-rowhammer-bug-to-gain.html
    
    [ Eventually we might want to do anything more finegrained, but for now
      this is the simple model.   - Linus ]
    
    Signed-off-by: Kirill A. Shutemov <kirill.shutemov@linux.intel.com>
    Acked-by: Konstantin Khlebnikov <khlebnikov@openvz.org>
    Acked-by: Andy Lutomirski <luto@amacapital.net>
    Cc: Pavel Emelyanov <xemul@parallels.com>
    Cc: Andrew Morton <akpm@linux-foundation.org>
    Cc: Mark Seaborn <mseaborn@chromium.org>
    Cc: stable@vger.kernel.org
    Signed-off-by: Linus Torvalds <torvalds@linux-foundation.org>


Leaking phys addresses to unpriveleged entities might not be wise.

-- 
MST

