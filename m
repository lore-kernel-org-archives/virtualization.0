Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.128.177
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1793217008;
	b=vXPB6uQ2E14CvLWHFvwfSWTNgXz5bBKmX8lvTaIKIccu4ufkV+WGhgsoO7RM2avHZef5
	 sVABqCufNYVNNLoH0wzuikhYHTcqdUJgcYbaNf/KRNlmlHCFxl62+6h7PKuXch4LIyTv6
	 I/bvIznhmUmra+IJaMatZSSlUNQ6VAol/iMu219bRkrFAIchza5VpPZUMHLP4p29GHyL9
	 LMg5Iydmm8O8apfxjcGqw+0wRlJAHTsecAsnnjefNwGO53tn1sS/SMfk+KwjWoInNVg6Z
	 4ie4sNMMpcRqGlljTESdwlWmu/GtJ67cX1dcwwAwUTmpQIjtFfi22pkG6Q0BlDD/F4A==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793217008;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:
	 MIME-Version:References:In-Reply-To:From:Date:X-Gm-Features:
	 Message-ID:Subject:To:Cc:Content-Type:Content-Transfer-Encoding;
	bh=x6V0ut3kqKgQIto1YCEH+vR5sKEvkw9wBhgLEXh9NNo=;
	b=Gj6prSBQr79uSa8UcrU4wdShRTsnd05kitte7czFCcAdbiLHloXpN+5GPeIg1OH7z5H0
	 Qh3n1GeX9HJqtxuQBm9ZmwvC2sDm8pdphfeIHYeBTW8vbmbL1HQhjIUPilSyS52BiRlWL
	 /o+ah3Tq4OcMOgwu0tFY26EPKlxA0ulMr2ZxJ1h8lUThCDHmpUGuW8m43s+69lgzJHYx+
	 EYexQ9J5CNJo8RCd9FUxM14gJ78MBIw068CgD07zLHLLjK1hovKQZgrDtMZzeICSZSLH8
	 /+UA7y3lqevjQpeu+39+4J8U8hlyHy/tHO/lEP5OnUkBpqgM13A8CF4BHQ8i9HTQ+jw==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=google.com;
	spf=pass smtp.mailfrom=google.com;
	dkim=pass header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b=iknX4k6z;
	arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.128.177
Received: from mail-yw1-f177.google.com (mail-yw1-f177.google.com [209.85.128.177])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 82FE660A2602
	for <virtualization@lists.linux.dev>; Wed, 28 Oct 2026 19:50:07 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 82FE660A2602
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b=iknX4k6z
Received: by mail-yw1-f177.google.com with SMTP id 00721157ae682-8ae8607e8afso11331487b3.3
        for <virtualization@lists.linux.dev>; Wed, 28 Oct 2026 12:50:07 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1793217006; cv=none;
        d=google.com; s=arc-20260327;
        b=PJkEDooA53LuNTD2W8aBFASZXftA/9Ozj0NDTeyOKdK+oblCHRi0XBS8m3pdhth1+L
         vvItndZIC3TUiIF2JBrpB+2JeHZeHXexc8bUnJ/L1H3L1PRlnFLjqlypq1FQxo/hIWyL
         6LWdULJpbECxqgMLrR6QNLKKcMl5uXvTTUEY+0TIiyxtzOhAXIejqzHliMSY+k8mffSB
         wMboRdvdl1WKa2EyuSVT5sXvBmNdECMzgdnpgNKRnlpnk2fJtUc9kw3UDjyC37SEAjOg
         G5NBcQcmCzV+y8qeXh7AmJoFqiNxuUEG0ZHTLNWoO1XOZV7Qw5BGxotE9Cw/T1SJlq8L
         I7Rg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=x6V0ut3kqKgQIto1YCEH+vR5sKEvkw9wBhgLEXh9NNo=;
        fh=94QwtS1L1+Fb/BAQK63q+VN6JHYl3enEaATOk/wKHP4=;
        b=XyPVxinwf6rVvxEKaF6XvNTM+TpXd3DAknaafFV2rx5pi0ZhhavFCGQZNx8ltNtMFA
         f8Gcq0meioaulWakc9qLa6PB+2DHMg870EuDydwp+WMr2i6rVnoXPiurlBnTbDNf/IdQ
         izEKBFeXjkb7sglQ+H3R0ug71xWIk+jesJVbkeDQOqz9EjvV6mT/917HxB2l9xKlE5hA
         h7nPQ+wcg4MN+l6oU5/g0Xm87RjIUAJhE8xN49b+TibPZx/A6pQmJ/a8kCl/x+Z55hsN
         Ptyj1AsKsQWPf5L22EeRSOl4HYd+41rci0p8QFL47agesCvpmgOBcJC/1YoLKrVchqwI
         Wb9w==;
        darn=lists.linux.dev
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20260707; t=1793217006; x=1793821806; darn=lists.linux.dev;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=x6V0ut3kqKgQIto1YCEH+vR5sKEvkw9wBhgLEXh9NNo=;
        b=iknX4k6zYg2dZziG50S2UY4Tv6aHBrvWdtjTV/XZcwEKTXb622HSSpq8l6MNWsiAMS
         fRoMnkQRlDaMa+kj5WfL2feOMktpF4Uv8bp4apaO4tcPyoWS7U1DeEyCQkFlznCi3XRc
         37t0GDUT5FYuao1vm5/++bbBF13/dkGSh2PuUZrZ9QF7xA5gHhB6ZP++92qy8cufOwM0
         K94imXZ4LNqgJz2XCAb/Ubb5b8erXBm8LDUeZOyTF7rfw+C/N0zbIDSMN3nRDyZQvkiy
         kjSaRtEM5oSWEzO2SKn15K3P62wYp6xbze2gtl9c2B+/79TOSva5p4pMX8iWVoxoJzub
         TBMg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793217006; x=1793821806;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=x6V0ut3kqKgQIto1YCEH+vR5sKEvkw9wBhgLEXh9NNo=;
        b=HplzJh/eUDE2ACJNrCKj3FfgnHod9zxXF7hJa8XSxJwJCP6lzIGlJ8ck9TzcrVifA/
         RIfD12CFh4e7AVCl+C2B+1wPY7PFSUS4xmT1YsxhsAuboE3rFX6P5EAEu++Udo2eryqI
         w8ozLAY6PAqMuy/iUKp8M/8t62kLjABnCYgVuKYvqb2obnjpg5SpQ95+RDVUJoB3fGJ+
         Oe+TYgY0aNKrpCA5ITpnY0SkQFxJ6BIqWkMQ6JowoZqe9cz722QzVkBdjtAIECLFZ8wl
         Cm6nod1cHyTnnhwJkOiQSA/4kgs/Uqh04ezedEEsKywY83AKUwyuE9LMvvkTOkWStgn2
         AP6g==
X-Forwarded-Encrypted: i=1; AKwUvBzA//zVeQtODRtqOx9ykYcxz/ubCjP1gkpPnthJmRtyLCHf+7jcyyDMIL82zhqseEu6Rg8NaCP7SWypSdU9eg==@lists.linux.dev
X-Gm-Message-State: AFq9FYJn7o648xCsOv3cJPpeIBYE5nxobHwuFj9LeK6I9MDuI6dBs+Hc
	/fNOZbVvKmbH82Vps1/i4cP+Dn3yD3M8hvjFbWx2V4nc+TcNGBaCF2UnNgrhBgb8cOnsQDuuk3Q
	YUzUNPV7WPPYyE22FZFB+3QB0EbbUF0kDCjzD0xds
X-Gm-Gg: AYBFou2nx1iPl9PJE7UJjZ3Bbhd97jKJ8xXOdL3jUHSRjs7DlJ4mTScQCGD57vnhzHv
	EYUKugYL8tksTyZOxOYlpX2w4dk6tRYXVl9Q/4ugl6uLW30AWyh9TAdSaKpea766gsshoUhwZki
	kMx6aJtastsfOJUlnLpluhltBvg95r8vxDUZv9Gg36rroNbO+XCAm/LhJ3PUnsyPNQrRfOY2sto
	urlFc4CXrdxAS+U6aA1r0jjVOtEsCNp8EeDM9X6scJS2kwYOjxSwTdbfkQyf/CvADtvZUw9Xbyo
	OddjvYG1qO2h9VB/Wq747oWrIyXwzpffMShoRTVHaZTwehAgeM7sxQgFK6JCxEulJjET/GBFtdB
	IagOfzpjOjHG8syijl1/G0Cq0HdKuI+aov+KSyjHsk8RQI39KRucBxM0SEufNNLJAeQ==
X-Received: by 2002:a05:690c:498f:b0:8b1:a485:dee1 with SMTP id
 00721157ae682-8b1b5e870f8mr20662047b3.62.1793217005584; Wed, 28 Oct 2026
 12:50:05 -0700 (PDT)
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Post: <mailto:virtualization@lists.linux.dev>
List-Help: <mailto:virtualization+help@lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
List-Owner: <mailto:virtualization+owner@lists.linux.dev>
Precedence: list
MIME-Version: 1.0
References: <20261027025616.1632690-1-kevinloughlin@google.com>
 <279a92da-772c-422b-8047-ad37dbae211f@kernel.org> <CAGdbjmJ8qk7FCbGU85u9+db5_RtcrK2y_7TfNH+iuz+OJxebow@mail.gmail.com>
 <20261028145316-mutt-send-email-mst@kernel.org>
In-Reply-To: <20261028145316-mutt-send-email-mst@kernel.org>
From: Kevin Loughlin <kevinloughlin@google.com>
Date: Wed, 28 Oct 2026 12:49:53 -0700
X-Gm-Features: AclHuK-xGxvCvL4otBtvefj81uI5MhPmhwclIN6rdpDM6CRLGOUQBZrCbVhrSfI
Message-ID: <CAGdbjm+4Jqx8Xv3uvhgaaiThYuVT0vF6UGx83XUku04Q_PN+OA@mail.gmail.com>
Subject: Re: [PATCH 00/13] virtio_balloon, efi/unaccepted: support memory
 ballooning and free page reporting in CoCo guests
To: "Michael S. Tsirkin" <mst@redhat.com>
Cc: "David Hildenbrand (Arm)" <david@kernel.org>, Jason Wang <jasowangio@gmail.com>, 
	=?UTF-8?Q?Eugenio_P=C3=A9rez?= <eperezma@redhat.com>, 
	Xuan Zhuo <xuanzhuo@linux.alibaba.com>, Ard Biesheuvel <ardb@kernel.org>, 
	Kiryl Shutsemau <kas@kernel.org>, Thomas Gleixner <tglx@kernel.org>, Ingo Molnar <mingo@redhat.com>, 
	Borislav Petkov <bp@alien8.de>, Dave Hansen <dave.hansen@linux.intel.com>, x86@kernel.org, 
	"H. Peter Anvin" <hpa@zytor.com>, Tom Lendacky <thomas.lendacky@amd.com>, 
	Ashish Kalra <ashish.kalra@amd.com>, Michael Roth <michael.roth@amd.com>, 
	Rick Edgecombe <rick.p.edgecombe@intel.com>, Andrew Morton <akpm@linux-foundation.org>, 
	Vlastimil Babka <vbabka@kernel.org>, Mike Rapoport <rppt@kernel.org>, 
	Suren Baghdasaryan <surenb@google.com>, Michal Hocko <mhocko@suse.com>, 
	Brendan Jackman <brendan.jackman@linux.dev>, Johannes Weiner <hannes@cmpxchg.org>, Zi Yan <ziy@nvidia.com>, 
	Alexander Duyck <alexanderduyck@fb.com>, virtualization@lists.linux.dev, 
	linux-coco@lists.linux.dev, linux-efi@vger.kernel.org, linux-mm@kvack.org, 
	linux-kernel@vger.kernel.org, Sidharth Telang <sidtelang@google.com>, 
	Punit Salian <psalian@google.com>, Peter Gonda <pgonda@google.com>, 
	Ackerley Tng <ackerleytng@google.com>, Jacky Li <jackyli@google.com>, 
	Steve Rutherford <srutherford@google.com>, David Skidmore <davidskidmore@google.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Oct 28, 2026 at 11:54=E2=80=AFAM Michael S. Tsirkin <mst@redhat.com=
> wrote:
>
> On Wed, Oct 28, 2026 at 11:12:47AM -0700, Kevin Loughlin wrote:
> > On Wed, Oct 28, 2026 at 2:01=E2=80=AFAM David Hildenbrand (Arm)
> > <david@kernel.org> wrote:
> > >
> > > On 10/27/26 03:56, Kevin Loughlin wrote:
> > > >
> > > [...]
> > >
> > > >  mm/page_alloc.c                               | 248 ++++++++++++--=
---
> > >
> > > This diff stat should give you a good indication why this series is n=
ot acceptable.
> >
> > Got it. I will keep that in mind going forward, especially if I end up
> > attempting a v2 that simplifies things.
> >
> > On that note, I believe the majority of the bloat in mm/page_alloc.c
> > comes from...
> > 1. supporting the legacy inflate/deflate option
> > 2. introducing support for various page sizes to be unaccepted
> >
> > (1) I can get rid of by dropping the inflate/deflate option, which I
> > think makes sense given free page reporting should be sufficient to
> > enable dynamic guest downsizing in cooperative scenarios.
> >
> > (2) becomes simpler in part just by doing (1). For further
> > simplification, we could potentially restrict free page reporting for
> > CoCo guests to the current 4 MB MAX_PAGE_ORDER instead of supporting
> > any order 2 MB and up. There's a trade-off here for reporting
> > effectiveness under fragmentation, but perhaps support for 4 MB only
> > (and its relative simplicity) could be acceptable? Especially since we
> > would then maintain the invariant that all pages on the unaccepted
> > list are MAX_PAGE_ORDER?
>
> I'm not sure what is meant here.
> But if a lot of memory is free and it gets merged beyond MAX_PAGE_ORDER
> and then it's not reported, that's counterintuitive.

Sorry for the confusing phrasing on my part ("2 MB and up" vs. "4 MB only")=
.

MAX_PAGE_ORDER (order 10, 4 MB on x86_64) is the maximum order in the
buddy allocator, so free pages never merge beyond MAX_PAGE_ORDER.
Today, page reporting logic scans from page_reporting_order up though
MAX_PAGE_ORDER.

Accordingly, what I meant is:
- Currently, upstream mm/page_alloc.c assumes every block on
zone->unaccepted_pages is MAX_PAGE_ORDER (4 MB on x86_64).
- In v1, I set page_reporting_order to unaccepted_memory_order()
(order 9, 2 MB on x86_64) for CoCo guests, such that free page
reporting processes orders 9 and 10 (2 MB and 4 MB). However,
supporting 2 MB blocks on zone->unaccepted_pages required generalizing
mm/page_alloc.c to track variable-order unaccepted blocks (Patch 7),
not just MAX_PAGE_ORDER.
- If we instead set the CoCo reporting order to MAX_PAGE_ORDER, all
MAX_PAGE_ORDER free blocks are still reported, and we keep the
existing mm/page_alloc.c invariant that every entry on
zone->unaccepted_pages is MAX_PAGE_ORDER. The trade-off for this
simplified logic is that a standalone 2 MB free block whose buddy is
in use wouldn't be reported until its buddy is also freed, such that
they merge into a 4 MB block.
