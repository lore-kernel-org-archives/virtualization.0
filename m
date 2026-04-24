Received: from mail-ed1-f54.google.com (mail-ed1-f54.google.com [209.85.208.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1FC152D63E5
	for <virtualization@lists.linux.dev>; Fri, 24 Apr 2026 07:16:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.208.54
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777015020; cv=pass; b=MjXQweBbSbQ1VXzbmwVAYA7+EbxE1reYo88nr33HsywR6XufwqWaz165NUbeizTNoboeFowJejpPenTIn4GWq5mo8w00qvSvt1TblMgp6Gmm662Tea2/sRANT7ZRGUeHD8wtYibpnb+DuH8Rf+93eAAgH+wCnFDJO3yxDLvp55k=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777015020; c=relaxed/simple;
	bh=W+ssi1VXndSbA3jTir7s/4LRoYtNUVNtJuZsueaDSGE=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=HW95EwgB6Gsok1dcfAQYgGF+aA+BQ1L+XTmM6LPqTkDmXRw/DyMZOjPN7aJFDdONObOhguPiLH6FNFqkZ60URtkRO3bd3VdJPTFXC4lkdPaSCtQ9CXEC3KnuK4xBnDJw3kVFSPIt87m97921XtMBP3oxQINo+DPsca/7TXjx8ls=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=LuiSxraO; arc=pass smtp.client-ip=209.85.208.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="LuiSxraO"
Received: by mail-ed1-f54.google.com with SMTP id 4fb4d7f45d1cf-67893fba9c3so2357678a12.2
        for <virtualization@lists.linux.dev>; Fri, 24 Apr 2026 00:16:57 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1777015016; cv=none;
        d=google.com; s=arc-20240605;
        b=akokV/j2f2wy5OIW/BtujMEkU5gzxUv+tZgKbZfMn+YpyBV0FvwjufIWRNv8ws24/v
         QRlcsAKhdbvVeKIBdHV5OQbOk8LAywVdcuC4EqMQN1ZUeTKACvkJbU3+4rHUO1V/7iW6
         v01xB+KtY4KPA/G1Ghvo9aN+QuGaw+ZA7+7JRv+hYYBE/7bU0iEHsqvt6lWE1HUT4EBP
         UgpZ08jxYbd4sXKbuKLjzrGO3iMf+B/bGMInaimnXukWpfvdXRkdj7fuvqE+mqSEZxfb
         Yt3L0pbbQQz8AO8Dfvv7dNaEsLQA2OvBwgxRCYt1aejdE3nflvgunmudCVK/0WClIAZE
         pRbQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=8uv1ap7wfpWSK/rjkumTWgHiVOSnLQXCSFDMADgPR1Y=;
        fh=hA2TLpsYqin19epXrfHQsBfoyEqCnjlMIgwnVmyccSc=;
        b=KROvvEH5vizWAuGp8fx7tRhqjPwF86FcWiBTpiqgr2XzwmStqZH0Zv8+fQt4OH0u/u
         hoGAPCH0GSYiryob6oxmV8nvy7JVeyyovvANHq5Y2FVB0iVbXMmgDjW6k89Xlppf74VS
         w/elqrtx/HSwpgVCPYgJB4ASfRPmwws95aqKU1NdVLrcBU6UJrOt17YAisYm4XgH+BKz
         N2v9dwoW8xrMIC4KElF2qvzVhlYaZzUNd5brn9Bp0ebgX9QJFssfk2V0RJNIZvoE24rn
         22RmM50vezFQTyxNGi7th/Q5sQ5LPC5MHYr1qIY3AkHFw/a9HT/bQUrYL5tpxutFtObk
         2hrQ==;
        darn=lists.linux.dev
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1777015016; x=1777619816; darn=lists.linux.dev;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=8uv1ap7wfpWSK/rjkumTWgHiVOSnLQXCSFDMADgPR1Y=;
        b=LuiSxraObyNbODlMfBA1wQ5plxHBJRkTPI7muM3lbvrOYB4SiI1VbZV0k/PZhMdXvA
         0ytm0/Dg/bN2HH3lh6exlw86geXA8eagxcFfWBxX/utBpKERzH8RHNxiyZtNpbCKVzMs
         nM+Ca16m2Zue1lsp4iySMCNBDE8b/Wg6gpG6bvE11gdYPhhLSC4syr1so7aO0HtsQSsQ
         veD8PfTqI7AdlMsIMnL3ihndPuKtqASlQmsu2cHOx5vx7vcpAU2/mIwlAWeNxtipn8je
         G2mlJgYAyhLlIlcD+DlMmbxCV7Th5qRzF8d1TpKfXsjHXtb4cTkcaaDFI22sUqRCNbpB
         23Ng==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1777015016; x=1777619816;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=8uv1ap7wfpWSK/rjkumTWgHiVOSnLQXCSFDMADgPR1Y=;
        b=hQn5zU81wS1w2AqkQeOt2vM2+NOrAonX70aXwt6f3WEnbwt+95sBB5e1YRbxpnfEzf
         A55l09raWeHhsLJMbEQwAFx/VG6413pghcb20cPbf9dNG7aCYYw6bAxKEAncr74f+KwJ
         ST6R0/xpwm05hnF1KL91y9s4Qs/ole8U1VIKAmTWO3agHbuKbCsAxcClAmItTPA9mWjl
         X7amBDNSsvv6hqOxhxgtjAsuSbckukJQkZn191AU4KjhNSsjuzSatSQip8vxCFZKobW4
         FWQ4BbO7tpmfDRUCAHA446JkgVWYpqw+0dyWX/CCHk23xx9D6LgpkOaFjzziwWE2BIZv
         11ow==
X-Forwarded-Encrypted: i=1; AFNElJ/AAR50PcRXuLlE97WEiAKXvqBZ7pXU87HRG1IZm1+YtgWyZp0HcGXzIRcTMJz0nksNkIw3Sphm2Q0JRi79kw==@lists.linux.dev
X-Gm-Message-State: AOJu0YyRjNVEtcJDzMpYJKpFyQMmf6aCu+yPhy88qaEkvu4eTH2znZHS
	SRNrkiF/wLSEXuuznTY1EhlUMuqB4ANO/Id73eq5SRQuzdccuyK830o3tFh87MpYrdfsmscrPtN
	MFrCX5zKLzhhCDfmh7t44Ihmhrria84M=
X-Gm-Gg: AeBDievcy0IthulnLIlkp/MHwpmVGOdrv/HGK69uo5LPPuHC83PvbmtUm2qg82+gYlW
	I0n1/Go/cxGGViqrF7jWlsg9HNJGVDOhkpJrB9t09VUYQpLoMpYcen/Q5fudgcGpOhOepU5K8Fq
	neJ6zBBOeIJAIqaool+SW5wGucRLxWNVcTR3iLsI7CGO8tljUVLfFpfqMqP1g8xFY/UOwmtTsrc
	4x+wH3nChNOREs0xD+TXK7KeFh9YRJ+rnlFK66SUYCLwIm12Be7UjWBPtaOVKSsGHokOAIj8N29
	plihMx5ZZ6Bb/6GXUe0K1Yxrjoc/OcptHBsYOQOM5XBTaL4dGEE=
X-Received: by 2002:a17:907:1ca1:b0:bad:dfe1:6a56 with SMTP id
 a640c23a62f3a-baddfe16c2dmr60367766b.30.1777015016077; Fri, 24 Apr 2026
 00:16:56 -0700 (PDT)
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
References: <cover.1776808209.git.mst@redhat.com> <006f9142e591ba8c340c3b354aee76aec5c285b9.1776808210.git.mst@redhat.com>
In-Reply-To: <006f9142e591ba8c340c3b354aee76aec5c285b9.1776808210.git.mst@redhat.com>
From: Magnus Lindholm <linmag7@gmail.com>
Date: Fri, 24 Apr 2026 09:16:43 +0200
X-Gm-Features: AQROBzARFJV36R4zYM7xbfHPyy5Ua1V3EjGjDIipUn9qIBzgKGxem5ahIafz8os
Message-ID: <CA+=Fv5T83qH-c0U4eXO84HQmG=225SepaxVYzrpQh_CWMhG5hg@mail.gmail.com>
Subject: Re: [PATCH RFC v3 10/19] mm: remove arch vma_alloc_zeroed_movable_folio
 overrides
To: "Michael S. Tsirkin" <mst@redhat.com>
Cc: linux-kernel@vger.kernel.org, Andrew Morton <akpm@linux-foundation.org>, 
	David Hildenbrand <david@kernel.org>, Vlastimil Babka <vbabka@kernel.org>, 
	Brendan Jackman <jackmanb@google.com>, Michal Hocko <mhocko@suse.com>, 
	Suren Baghdasaryan <surenb@google.com>, Jason Wang <jasowang@redhat.com>, 
	Andrea Arcangeli <aarcange@redhat.com>, Gregory Price <gourry@gourry.net>, linux-mm@kvack.org, 
	virtualization@lists.linux.dev, 
	Richard Henderson <richard.henderson@linaro.org>, Matt Turner <mattst88@gmail.com>, 
	Greg Ungerer <gerg@linux-m68k.org>, Geert Uytterhoeven <geert@linux-m68k.org>, 
	Heiko Carstens <hca@linux.ibm.com>, Vasily Gorbik <gor@linux.ibm.com>, 
	Alexander Gordeev <agordeev@linux.ibm.com>, Christian Borntraeger <borntraeger@linux.ibm.com>, 
	Sven Schnelle <svens@linux.ibm.com>, Thomas Gleixner <tglx@kernel.org>, Ingo Molnar <mingo@redhat.com>, 
	Borislav Petkov <bp@alien8.de>, Dave Hansen <dave.hansen@linux.intel.com>, x86@kernel.org, 
	"H. Peter Anvin" <hpa@zytor.com>, linux-alpha@vger.kernel.org, 
	linux-m68k@lists.linux-m68k.org, linux-s390@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Apr 22, 2026 at 12:01=E2=80=AFAM Michael S. Tsirkin <mst@redhat.com=
> wrote:
>
> Now that the generic vma_alloc_zeroed_movable_folio() uses
> __GFP_ZERO, the arch-specific macros on alpha, m68k, s390, and
> x86 that did the same thing are redundant.  Remove them.
>
> arm64 is not affected: it has a real function override that
> handles MTE tag zeroing, not just __GFP_ZERO.
>
> Suggested-by: David Hildenbrand <david@kernel.org>
> Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
> ---
>  arch/alpha/include/asm/page.h   | 3 ---
>  arch/m68k/include/asm/page_no.h | 3 ---
>  arch/s390/include/asm/page.h    | 3 ---
>  arch/x86/include/asm/page.h     | 3 ---
>  4 files changed, 12 deletions(-)
>
> diff --git a/arch/alpha/include/asm/page.h b/arch/alpha/include/asm/page.=
h
> index 59d01f9b77f6..4327029cd660 100644
> --- a/arch/alpha/include/asm/page.h
> +++ b/arch/alpha/include/asm/page.h
> @@ -12,9 +12,6 @@
>
>  extern void clear_page(void *page);
>
> -#define vma_alloc_zeroed_movable_folio(vma, vaddr) \
> -       vma_alloc_folio(GFP_HIGHUSER_MOVABLE | __GFP_ZERO, 0, vma, vaddr)
> -
>  extern void copy_page(void * _to, void * _from);
>  #define copy_user_page(to, from, vaddr, pg)    copy_page(to, from)
>

From an alpha perspective, this looks good to me.

Acked-by: Magnus Lindholm <linmag7@gmail.com>
