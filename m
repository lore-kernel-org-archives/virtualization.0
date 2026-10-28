Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.218.43
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1793202064;
	b=CSNYrUocwmJRdxY5P5bYtyZ+6VfzZGdHNnfp8aByThIHI5awxj4p3C8G06RBCu1Q1X0E
	 sPKG1jyiTAPkNCOuUAafmqirxKO5a0iwB4x1Nn5yJdhXC3H431IPYSbboDHJxjnOj3EeO
	 cm2VwOQXJ/8Ss6KUqekRF+2Hz6oHfIm3veGl+fYh32tLXwLRmKd+HFGrXcZfdhWfebEdW
	 KZNiUYYqeyEomOJTfltlErujIFYKTwX8aE/sceUNf+bJsjW9xFnre51eI+Gpek+N6AlIf
	 kUxu51UtSZsx5XVVcfmTw+jBBvB09bqlUUBlEcqEp06tXgp+lkPCdNYJNwk6pxD+cBg==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793202064;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:
	 MIME-Version:References:In-Reply-To:From:Date:X-Gm-Features:
	 Message-ID:Subject:To:Cc:Content-Type:Content-Transfer-Encoding;
	bh=35HLfcrc/AjiCKvsVtxqxuglfLVc60GMP3of72tM8d0=;
	b=y0d7vPdFrwh75tbjHelsSDTBJT11XOLlDWutOAfWLWyvzvCs/KvYSgpheY6znMA304gu
	 hHcaR+U7yAk3TeSYYEp6Rq8uIJ9T8LB9Ea3P6XHa2m89/o1Gia4OOBoFXaLUBoo1vhkbk
	 ZpWALELdX8rSVxB9XwbyouBDFSbUQ3azfJjBY2RabT0kcgqsyVulBWqgWtgs5Bd8zS3M0
	 xYrkRR80BmC8Vt3i7WPUyEnWxN/d7QyeJQJcmQ9poh61TqPaS7/xZz8TIcc3U71ah+Sgi
	 UP7aBC6eL0ckMGJhbAePSpvryH4gIEhXfaxaKu2aBcsIUPBephVb437evFrpM8BOtwA==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=google.com;
	spf=pass smtp.mailfrom=google.com;
	dkim=pass header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b="U5x6y/I+";
	arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.218.43
Received: from mail-ej1-f43.google.com (mail-ej1-f43.google.com [209.85.218.43])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 00657606A31E
	for <virtualization@lists.linux.dev>; Wed, 28 Oct 2026 15:41:03 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 00657606A31E
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b=U5x6y/I+
Received: by mail-ej1-f43.google.com with SMTP id a640c23a62f3a-c3f8d72d7ceso172805466b.3
        for <virtualization@lists.linux.dev>; Wed, 28 Oct 2026 08:41:03 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1793202062; cv=none;
        d=google.com; s=arc-20260327;
        b=QONfx5ht52zovAb6V84FDKlWWRF1fZO6p8bVTCM0OSk/8iLCYkJ0UEeTetn/d9/8Af
         mE987jAySRBWenloUrltSmB9iSCFKIe5FgcPtTrKkWDJg5kSPusT7ljlGNR5er1ShM9c
         tKHuXMSvRCzOC50e7q9y5zDmn7fx6bswkHNJfkraJUG4CNpGFufM9/4pXKtMV8ZPeDb/
         anaP/G8qu9/IGEZmaL/oxCtIB6MWzAFSs4+8MMge4WURuWBoFShfarbrpNhz41bUhL48
         EhbDSZ+pRK4RLsT0dggChY3liGg/e9MY1V1afjZnEIg224GacD2Oufv3xbozBHkV8And
         RZRg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=35HLfcrc/AjiCKvsVtxqxuglfLVc60GMP3of72tM8d0=;
        fh=oBvNonqnSMQkCIoWGL8xQxIx6bPYKWt05MZCL/u/Uwc=;
        b=eSrcr6vqcBg+aS5/XeNXaqnUvAMedAPngikdLSsns2ty6chrsCIKTSc52t2Xpvbi7B
         1ibYjB6aQe/BShSSEZ7wwJB6uz9qHd6MDRpusICoPdq6oH0Ulxoe/fOGOXq+IWcT8q0P
         kCWc70yXuZoBQBewKXWKna64hbuGzjJprysQI99Cz0Gq8jeQIqVWhSAMYlqCEEUJAwVv
         LnJymGCgxaHuxajDBVdOIRYX3fBau78as5oLDH8QI64apdMNcA8GcoMpk23o7/Y4IWZ4
         TgzFPtKVLByUzqeSna3dqj0YLL2pYGdVW1KsYsZvFJRUSK5U5+PP04vrtMldRglmQI81
         lVBg==;
        darn=lists.linux.dev
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20260707; t=1793202062; x=1793806862; darn=lists.linux.dev;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=35HLfcrc/AjiCKvsVtxqxuglfLVc60GMP3of72tM8d0=;
        b=U5x6y/I+SgkzclrFCXcxeYDhV6SGSF1EUL4CkO5cve20y6k3MDKYIMxzwlYSe3ddDV
         u2KorleDKwhacC+dD6kEyMZAllE5LrZ4wJJeaik3Os5z3mT8yPFNuDm4u6zHFwcPuYEk
         BFn6SM89CJHSIklLxD2lphwatCH2kLlMlU2fU0yM1mtb0SQAFBhKmU4leOKkG7sByU3R
         vgY899KEOevA2cp0dVqwLBdrpedRx1hIHZuxIKOop5ir0Hhz3FMii2sXYjs43J9s4g3N
         C1ay5ax7I68Fy2bSKdFnmCXXViZNM411YnPTDZ84CF8koCvDgyq/IinO+rcs9jXQH7f4
         eAfQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793202062; x=1793806862;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=35HLfcrc/AjiCKvsVtxqxuglfLVc60GMP3of72tM8d0=;
        b=Tndo6jXv+Cp/fcpVjEXY/Bbow1sHLRQXfv4uf+V3ebEz7oX+kZZzBeudHSBHIPArTu
         2Pi+KaVcxN6Db/uO1HKnNAiffzblHZ1J/MH8pz3s2H6ICoqOueSEvcBjx+LBCgyzkZdm
         Mc3Y4dgdx45d5ukmjyTqIVniGaK8fN7AtBMx8x5AP360WgMofiabJHQqOqUjuKsvBiy8
         3sBoYTV0DGRz1XjHlockcWI+TDiEH8pB082VuuxXnmTN4haarxkqkGsh/uDBvegb69pz
         9wMePKIl7W7GTbaYcqZp2JPsUUS5+eq8rvEEuklZynaXBcmL3r3v/MZTlJURRNdKgFOQ
         xqRA==
X-Forwarded-Encrypted: i=1; AKwUvBzu4NTEUp+hxL6mdw9KkJ66KbSwD6YpUxzpgmdnVTGgq/YaT9olK7e2y3b1htQb48IQCUErjkzL/LFag6UdBA==@lists.linux.dev
X-Gm-Message-State: AFq9FYLV9MVoyEVqpg/p4U0yLD9IQ/RGnMgK1SBeoE9Fl3W6DGr4v6Wu
	thC7NYLayAb5LTscwHx1wZW4F3hDtW8t1BQGqA7g5Fd6J+8c6G1+qKMpQsKtNJHlt/kdXd5bbDP
	zwCk3LLgWG8wQ9BCrBt+D6Hj2cUn8Llm/9keyvddi
X-Gm-Gg: AYBFou23dXQPY7dgHHyAyucDEef3hZFr9LO9s7wOCzjQ6TApUOM9xLg4AyodydkV8Kd
	sVTsLWvmr5D6Pa2PwMUC0CRT3T/hK1uoBm2XVXsGOkezwHu5yQaF8IM+5fsVcqZXcVCiSkZDiev
	P3QNiHM/ziKPdEqd5kn/cH0JEYs0h13cdJFCToJgxrmODeS37Xt901CRuMdiRZdBxu412b1IN6j
	l6+GQW4m/Uk3vl0K3LbSETtS0e+/sIiUs1pOe8uLLal4AFzCozkajwMH9nie2Csdo984g5nHDux
	7gR7tZqYyKQS2J71NrPz5Nh43Z/TmMukbYBNfKJPh1jQjvGW7S1hNJsRDRCC/AnaKfRbVSU1uTG
	f8eSepmnj9r/+LaKpBOALGnEzdUE2iKNmp7DyqlvmH7NKR+qulUVzSgxBIdi+QOOg6g==
X-Received: by 2002:a17:907:3ccb:b0:c41:30be:4f82 with SMTP id
 a640c23a62f3a-c49bdf82147mr200595566b.39.1793202061724; Wed, 28 Oct 2026
 08:41:01 -0700 (PDT)
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
 <20261027025616.1632690-11-kevinloughlin@google.com> <2976bc2d-2642-4448-9c1f-ec13e67e45d5@kernel.org>
In-Reply-To: <2976bc2d-2642-4448-9c1f-ec13e67e45d5@kernel.org>
From: Kevin Loughlin <kevinloughlin@google.com>
Date: Wed, 28 Oct 2026 08:40:47 -0700
X-Gm-Features: AclHuK9oWsApJE-SwbWIqUTDRpRi_a-FG1r_BRCTB7JJ3QabTlKp_kjVIFg_bKo
Message-ID: <CAGdbjmLXhPkutP3yCNYghP_tkvHm2Sa+6aBHF1+9abaai-4bAw@mail.gmail.com>
Subject: Re: [PATCH 10/13] virtio_balloon: add higher-order page inflation
To: "David Hildenbrand (Arm)" <david@kernel.org>
Cc: "Michael S. Tsirkin" <mst@redhat.com>, Jason Wang <jasowangio@gmail.com>, 
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

On Wed, Oct 28, 2026 at 1:59=E2=80=AFAM David Hildenbrand (Arm)
<david@kernel.org> wrote:
>
> On 10/27/26 03:56, Kevin Loughlin wrote:
> > In confidential computing guests requiring page state transitions,
> > unaccepted memory tracking operates at the EFI unaccepted memory unit
> > granularity (typically 2MB / order 9 on x86). Inflating the balloon
> > with 4KB pages would prevent unaccepting the backing 2MB unit.
> >
> > Inflate balloon pages at unaccepted_memory_order() when
> > virtballoon_cc_needs_state_transition() is true, while retaining
> > order-0 allocations for non-CoCo guests and CoCo guests that do not
> > use unaccepted memory transitions. When a higher-order balloon page
> > spans more 4KB balloon PFNs than VIRTIO_BALLOON_ARRAY_PFNS_MAX (256),
> > transmit its PFNs to the host in VIRTIO_BALLOON_ARRAY_PFNS_MAX chunks.
> >
> > Signed-off-by: Kevin Loughlin <kevinloughlin@google.com>
>
> Sorry, not happening. There is no migration support for these (large) thi=
ngs,
> and there likely won't be any time soon.
>
> NAK

Yeah, you're right. Another great reason to abandon the
inflate/deflate aspect of this series beyond what Michael pointed out.
I will follow up on the cover letter RE: how doing so might provide a
path forward for the CoCo free page reporting by simplifying things.
