Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.128.179
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1793209912;
	b=xmWyfBlOAC2lqQSdVDM5+46Pwo7X2MtvyTbqqgLxTj+OCkn0tqZ65wqWwer7XAqkPtmB
	 5t5kzBMLUHTNZjvENzZh3xsMXypSHJlQAAR7AmT1j7OfQZOvgAyghbCjJFJ+Y7IkKlB2b
	 DTjMikzzFi2s8C7FjdsUXk/8F2jwhvuiQ0RIeICnlH8/RIdW8JTQwWoTFkFRgpYLvcqwX
	 WmMinnQxlEQAMdvWv9AW8p+yc5qyZktfB+iQ6BInvBdWZcuryLbusDCgS/2srHcPbNAzO
	 zZMNCMbAEPPIu0Hi+jbKrbZcHbz5LYKNJfHYRAfhQZHdGj63+0j3nhCcSYchXGwKVLg==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793209912;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:
	 MIME-Version:References:In-Reply-To:From:Date:X-Gm-Features:
	 Message-ID:Subject:To:Cc:Content-Type:Content-Transfer-Encoding;
	bh=mF/L3R2/oy06ccOwt7FWjRMyAPem26+3IHOwef8ICXY=;
	b=MYc8ymzbIpDUaJxbkNNnIiXRc7824o5KyZxMTtm6wFrdcibydf4fuBCzCHS7y5fdS4F3
	 cbQ9DIhoMsobarzUAA9OdqPDeQnadfhkLGJbes8/TH8R6RfxB412R5fuM9JLjkuYb3hHG
	 nUado6LRXlGTh2R/XZSZgE27b5vlkHlQICBqeJUo3zOdV7w3mjf9+f4XKKq77j3z2D735
	 aO4eCj0qpPlQhlx7m0uOyb0QsCw24CTNI0vcqzqNPLY0vRtlSBzA0XL4aeUCxBqHXDxMe
	 0sOpmLvAyik0JTsCxyZsJBUTTkrbg9sR0g+4CXFUGR5/jIz+uNg6cLgjuzKMqdDBnBA==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=google.com;
	spf=pass smtp.mailfrom=google.com;
	dkim=pass header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b=FZiONIAZ;
	arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.128.179
Received: from mail-yw1-f179.google.com (mail-yw1-f179.google.com [209.85.128.179])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CD3AA60A2604
	for <virtualization@lists.linux.dev>; Wed, 28 Oct 2026 17:51:51 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org CD3AA60A2604
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b=FZiONIAZ
Received: by mail-yw1-f179.google.com with SMTP id 00721157ae682-8b0a921ee46so12082017b3.2
        for <virtualization@lists.linux.dev>; Wed, 28 Oct 2026 10:51:51 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1793209911; cv=none;
        d=google.com; s=arc-20260327;
        b=UZaaY6bgB+AqeYWlVeVHGkBwIKfCeD+g8T64Njb4w+Hgnh0hc9+c/OyER2LZbtt92R
         k7nEWPG8bZoBJ5Ae4hscnAGmBWd/vqn+OeC26VQNnGYKs1b3+5KrhgRCBJVW5Epb/5gU
         SFXykEznd/1G8ktLZRDf798ILqSGFDCxCKCTiWoHDy/4J27TjAaF2lmiIXPxQBILsC4f
         Aswv+iydXVOyLuSTE2vdNgRUsyKHztZWkFbJKdH+XLJ3JRc8uio51Q7suFerW3UuV3mx
         med7BaZB+Hf4E0Pz7oXuqUIB6SJbqLG8YdzGxkNhxwUwZgSewlc+2zzoUKQrNf18yCv1
         1hBA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=mF/L3R2/oy06ccOwt7FWjRMyAPem26+3IHOwef8ICXY=;
        fh=KsKfPlFTW7vUpRyjbXmnAzCUFeSnLcE1sJa2vsaaheU=;
        b=S96KvwiiEFaX29SxzWkd+L+I8OYWrZkyZaKTUT68adMLM3g9uvT1EYlOJdkeEDEBT6
         17d9yXIKe17Z61hL3QDc+gjZNioxlFZaGS71RRzIrWpYIY7kLN+nRnrDPYO450Z5EZvo
         MSXTihMcIyY6w6XSpAwBMGZ3m74DJ56/aaVpmPadHGhmtZMh+CgA18n/L5eekpIluyaO
         QXFcWZV0iqp1PLxfhwGcowfy5L4KCiQAQe3zTbE18SscC0WD3q6zpJ8ZEFgLWM+EvGt0
         ea08FUsPaseottld9ZkebnnIR94jBdIuytZ/JPxHxH6/oNM32RIqcSPa9Twpx6mFaOP8
         OzGQ==;
        darn=lists.linux.dev
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20260707; t=1793209911; x=1793814711; darn=lists.linux.dev;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=mF/L3R2/oy06ccOwt7FWjRMyAPem26+3IHOwef8ICXY=;
        b=FZiONIAZ4+fN7A/Asrz6IRtwKo57iXMqV5y2AGdZCoYNqDLv1ZDGddxJCF0W3ZbfFr
         QUL0DNEIwuRRGg0yKlfLq8YM6eUQjyTFGj7hbcEmyE2XgXkSVBBtIMepun7VwbVhNC9t
         dy9mThuenTmJUikN0sNIodpvMLinKxAlDJqvjRWblAVDbJsXdx2jwlLiRQk8MF9WfgZD
         nLjexp4HKbIpQ+9ujAocmoa2JudmC20dRMWO262jo/N5fxWXkoTJr0jzgku9S379j3Pr
         14pD8t8Zx6E2DdvRptlwDO2bTmpo9LM3WGCROPIYGlNBHct+1GoJf5/wXdMP9tBLPnyE
         4MUQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793209911; x=1793814711;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=mF/L3R2/oy06ccOwt7FWjRMyAPem26+3IHOwef8ICXY=;
        b=JxfA0f2rraLMlXijU61u8LzeS68+NUc2jd8MMgIK4fmCM4XKB7rzWSmVtZgXLM6Svk
         ly7hjmiH+lJS0mHWFNDv/Pvla4PqqYlDfyxDnF3NM8dR/OpgoJuOMOdoWCweBqiNqBRU
         +oUE94GuNK+jNi+5rtXuUeaJVbMOOePR/4dqCmE+0wswfSlK3/XkfXUpPZWd2va1kfAu
         +UC3BDzqt/avzxJyVX5At6TateAyFpchMpYd2XxFEs4blEfaN141QuT/VQ1pYJxMeV1d
         v9RStspB8Sw4Djsjv8mwssYP6k4T/R5GHOfIlkFRp3MMNbXrxiStWDcafEFpknp3TpxY
         GaEQ==
X-Forwarded-Encrypted: i=1; AKwUvBwM/4PTeBSlqOIbpjIjox7wc1oAjINbhPemB1wVU5B1rsoHV2rHUVqt7YTUWp1ogINBaBqpQUxU7gy7afvyig==@lists.linux.dev
X-Gm-Message-State: AFq9FYIxDuMwBuKTnybvX1wW2oHYeHKxLzzSRnkm3T5NsbayOX6k4lAl
	Ju08PlVX0dMfKils77qcncpLQEoDQTXbXVftCrtR0FCv8tYwHNQPL2xBJDsXhTy5hcfjr2h36bI
	YCxNtSkFQuVXUoi1eBu20JV8Y6mOyAoIuQr695TGQ
X-Gm-Gg: AYBFou30+z4lDmrmANsUIqZXegsC9c/iLhrHg/AGWmYpgbXfYsqvKJ8nhZac5JM1dNF
	mWFESGCT7oxPJCU5KuNacGASVAV298dYLXSGZlpBsyIQVm4DoEbYBaZ5cXOFYN7db4ZwM4h271E
	p6F/KPBHMZH0wwAYMehKlrIq7VdEP5qTc6ZbDknnVhCK1COmdpOSDMuTr8ZKpx5no73/PJsGRcy
	tk8/Fnaor7dv5Pqa2bZWDTIUqkpKeMrK5JxTBYmIY7vo1XG57O8kmfoI+ildOyMXEAGVrGq3P16
	2FYjNxRJ/MWPzlEhN23gKw/m8ID8hYUJZueVZ7021kGgF+sG/lBmw59oSNT2HHO3nz8wdAAI9/1
	+725xsSUGkpWUKBL93V5HQsD+k1XWqNtoJ9rkn5SqKp6zEVCJ2L35P3Dkm7SJIOJuYQ==
X-Received: by 2002:a05:690c:c512:b0:89a:63da:fa8f with SMTP id
 00721157ae682-8b1b5d5b9a8mr19678387b3.74.1793209910194; Wed, 28 Oct 2026
 10:51:50 -0700 (PDT)
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
 <20261027051245-mutt-send-email-mst@kernel.org> <20261027163814-mutt-send-email-mst@kernel.org>
In-Reply-To: <20261027163814-mutt-send-email-mst@kernel.org>
From: Kevin Loughlin <kevinloughlin@google.com>
Date: Wed, 28 Oct 2026 10:51:39 -0700
X-Gm-Features: AclHuK9-u99s7D6HT09CfAyO9Ftn7vr_iH3z9UIt21N8WRT_BYsbqycnLIpHOb4
Message-ID: <CAGdbjm+f+b8bMBFMdqXavXx79NSnXzDFeJRUxZdEox_+dKV6tw@mail.gmail.com>
Subject: Re: [PATCH 00/13] virtio_balloon, efi/unaccepted: support memory
 ballooning and free page reporting in CoCo guests
To: "Michael S. Tsirkin" <mst@redhat.com>
Cc: David Hildenbrand <david@kernel.org>, Jason Wang <jasowangio@gmail.com>, 
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

On Tue, Oct 27, 2026 at 1:39=E2=80=AFPM Michael S. Tsirkin <mst@redhat.com>=
 wrote:
>
> On Tue, Oct 27, 2026 at 06:29:35AM -0400, Michael S. Tsirkin wrote:
> > On Tue, Oct 27, 2026 at 02:56:03AM +0000, Kevin Loughlin wrote:
> > > This series enables virtio-balloon free page reporting and memory bal=
loon
> > > inflation/deflation in Confidential Computing (CoCo) guests, starting
> > > with architectural hooks implemented for AMD SEV variants, in order t=
o
> > > support dynamic CoCo guest resizing.
> > >
> > > Today, memory ballooning and free page reporting are essentially unus=
able
> > > in CoCo guests due to three main roadblocks:
> >
> >
> > For me, the bigger question is not whether we can, but whether we
> > should. Considerations I would like to see addressed:

Thanks for raising these. I will address all of them in more detail if
I send a v2, but here are a few shorter thoughts that I'd love your
input on. For brevity, I will ignore the inflate/deflate case for
CoCo, since I'm planning to drop that, and just focus on free page
reporting...

> > Security, e.g.: does knowing which memory is free leak information from
> > the guest? If no, why not?
> > Consider CONFIG_SHUFFLE_PAGE_ALLOCATOR, RANDSTRUCT, etc.

I think the min order we'd support for CoCo free page reporting is 2
MB (and tbh we might do 4 MB only for reasons I will mention in my
reply to David's comments in a bit here). On that note, I 100% agree
there would be some new direct leakage of "which 2MB or 4 MB regions
are recently-freed or recently re-used inside the guest", which may
present some side channels to infer other information.

Some related channels are already open in CoCo and don't seem to be
signficantly worsened at first glance (ex: for
CONFIG_SHUTTLE_PAGE_ALLOCATOR, the hypervisor can already induce
faults on any GPA at 4 KB granularity). However, there is of course
strictly-more information leaked by adding CoCo free page reporting.
My hope is that the coarseness is a reasonable tradeoff for some
guests, but I will follow up in more detail.

Aside: now that I'm looking at it, I think some aspects of upstream
page shuffling logic might actually skip the unaccepted pages even
today, so perhaps we should change this regardless of this series. I
admittedly don't have as much context here right now.

> > correctness, e.g.:  Linux has init on free (and default on windows), if
> > initialized pages are dropped and host can not be trusted, they have to=
 be
> > re-initialized. Is this handled? I don't see it in code.
> >
> > Also, performance, e.g.: How much does this re-initialization cost?

I think the existing accept_page() logic (which would re-run if we
fault a reported page back in) is wired up to
free_pages_prepare_init(), so I didn't introduce anything new here.
However, I'll verify this and call it out either way if there's a v2
of this series.

> >
> > Management: it was simple with balloon off unconditionally.
> > Now we are in murkier waters with various features offering
> > various performance/security tradeoffs.
> > What if some guests want the tradeoffs but others don't?
> >
> > Documentation: for all of the above.

100% agreed. I lean towards an opt-in policy for CoCo free page
reporting (ex: via guest kernel command line, which could be attested
as part of guest boot as one way to verify the setting matches
expectations), but please let me know if you have other thoughts.

> And to give this a bit more perspective, I present:
>
> commit ab676b7d6fbf4b294bf198fb27ade5b0e865c7ce
> Author: Kiryl Shutsemau <kas@kernel.org>
> Date:   Mon Mar 9 23:11:12 2015 +0200
>
>     pagemap: do not leak physical addresses to non-privileged userspace
>
>     As pointed by recent post[1] on exploiting DRAM physical imperfection=
,
>     /proc/PID/pagemap exposes sensitive information which can be used to =
do
>     attacks.
 [...]
> Leaking phys addresses to unpriveleged entities might not be wise.

Yeah, while the host already controls GPA -> HPA mappings, the free
page reporting would indeed likely give finer-grained timing control
of what 2 MB or 4 MB GPA regions map to which HPAs. So yes, another
potential case for "let's only support this if CoCo guest opts-in."
WDYT?

Thank you for taking the time to review, Michael!
