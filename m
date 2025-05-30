Received: from mail-ed1-f43.google.com (mail-ed1-f43.google.com [209.85.208.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A82BB1E515
	for <virtualization@lists.linux.dev>; Fri, 30 May 2025 16:27:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748622444; cv=none; b=gv5Z3I/yZJ3DClPI2qJtUiKFD9xV9hghqE02w388BqtgMxtFbQKU1391oT8XXvnWYvzgZEfIVwaMCeR0u87IPOBp5aH2wa+pIpZDtTAdWVkrdsFs40oWnRnnzdjwS4A/aSpCDiFFJcosuptP4PA58lCCdWUVJNKmaDr+7jeKN48=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748622444; c=relaxed/simple;
	bh=dF1+gDmyxY/9rUreETaqbpogRNLbyWryW5tlSGlkXTU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=ZGnWA4KDGcveT8rFsegXdXGmHYxlmfncDCm942ZuolL1mJ5o7cxhsYckGRRw3Fec2q+AfAMHlJEMQD1duEAg8k+3u2psYrdNmk0wUv1UvsQ+jopBY0d+wMcJk2VvXEQD4IA67/kuJnUqX1siD6yEDgeiD+Ka38NfAiFaoDZPPAk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=Ch8rsYgB; arc=none smtp.client-ip=209.85.208.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="Ch8rsYgB"
Received: by mail-ed1-f43.google.com with SMTP id 4fb4d7f45d1cf-6000791e832so11064a12.1
        for <virtualization@lists.linux.dev>; Fri, 30 May 2025 09:27:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1748622441; x=1749227241; darn=lists.linux.dev;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Wb7EzNeuZNtT7LoNB6YIvTwNTIj8nYWDYSy4GeuX+MM=;
        b=Ch8rsYgBQ6d6jFgS6T80U18wo+9WRIRDcEYwvHRWH9zFbAaxhEpFrme0/69B5X5H/g
         MwWearZwZ5ppkpZ1cUvEURoCGjThJC3/jKdglj6wdRrFhB6MsIEER6cws3wCI4EhpciD
         /d1xsuRZxMGoNivLZkyHnooRlJHfjQfIBfNYlmxlrdQfGdFPOB155g+5pQRO5RaghjFX
         O1M8Hqc3YOI4Zohxj2bDtLu3sXwoDOJ3ayY49M4zFhI8lzSGfZQcBawrwszj44fuNggJ
         RkBKmJ84Y6NiyHAgVPqEQRaT39zGcLMwKXFy/qLAtbuEgcALsJoIZFLBRidPi/N+6GNq
         uBvg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1748622441; x=1749227241;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Wb7EzNeuZNtT7LoNB6YIvTwNTIj8nYWDYSy4GeuX+MM=;
        b=kWAAzxESwIJx/5jdUH/UOrmQQ0jFz7JsprHkjpx3NVUHxeb7gozYjRHyLuy65zns27
         LpBdrq5NFBgYeigf/qz5dMTGVmfmZOVOQUrbje54AVuia/24FmLvS58c7lBkKjdfFUS9
         7UMcNBIqjdvrenpz3WnJYkteVfNirXyvCRYzpOcqprX9Cru1ZbZkV7UAKuuhBuCvTQbH
         ipMJUggn4jVGYjRRYCUHmsw+jSlwAHccuUJrTiOK10VeO2fNMVJizctFsZUb+IUtjpLL
         kBYqM8tCceqsYHYM5VSZuaWZF2MA1pwkBFXPBC2slcVfGfxSa20hhP5LFL+KBvc9Jsyn
         wnMw==
X-Forwarded-Encrypted: i=1; AJvYcCXKL7cBbwL67PDxS8v0ZvdeJEn1NU3ilO+L6Sifa0xQjfkU+WPUPF6P7e7/apEQfImCj5+RS4otKETqQO9Ojg==@lists.linux.dev
X-Gm-Message-State: AOJu0YyeNDHXN6rvykbS0Mt22yE1kQZkGsrJX2b+mrpIDTBrW9asZJ/L
	jsO9YD5zT9ZyFihYe/oz3C4jj9813lz7nJelhFXiW5NMl9hf48CMFJpu6Kksh0D0nLwmld/QzkZ
	Ho2uc0fakoKJb8+XdSibeigYzLvUDDmw6fPvwcYjO
X-Gm-Gg: ASbGncsQ5aXpaZcSMBC7MnvX9Pm4dEUDVXMw6qpU/hxMn+g/XVcQO4aH3Ao0S+Xofl7
	KEAvfSZkgGRNoOX7tpAqaFqz/4ndOFV1XzELvqt8LItBWT+8PoUYfh0rogiMLTHs0RccvtfnlIM
	EXFts7E+iKyJY9cYCj1iWbTKrg72ssKm4MMRZh6+xRE4mO5pRYKYsjltht70EuNimzjP4XdG8=
X-Google-Smtp-Source: AGHT+IFvo4UeYXqvvR6hGpmlYjccx/P9qAgBVyNpakUtwWnk/plyYyjpSLFfr/exrsOHq2DB2NbEp4NJnsA/fPm9vYQ=
X-Received: by 2002:a50:f608:0:b0:5e6:15d3:ffe7 with SMTP id
 4fb4d7f45d1cf-60577a55f40mr88916a12.7.1748622440589; Fri, 30 May 2025
 09:27:20 -0700 (PDT)
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
References: <20250530140446.2387131-1-ryan.roberts@arm.com> <20250530140446.2387131-2-ryan.roberts@arm.com>
In-Reply-To: <20250530140446.2387131-2-ryan.roberts@arm.com>
From: Jann Horn <jannh@google.com>
Date: Fri, 30 May 2025 18:26:44 +0200
X-Gm-Features: AX0GCFt5gaAeg9wlqckCjWiqvoyfvAtwj8XYq0jNIyzkBuWgoy0LcwI3HloBVMo
Message-ID: <CAG48ez2k6ZmM-335EQjXeL6OtKzuOjVPWQDuJ75ww9Z6NMeg5w@mail.gmail.com>
Subject: Re: [RFC PATCH v1 1/6] fs/proc/task_mmu: Fix pte update and tlb
 maintenance ordering in pagemap_scan_pmd_entry()
To: Ryan Roberts <ryan.roberts@arm.com>
Cc: Catalin Marinas <catalin.marinas@arm.com>, Will Deacon <will@kernel.org>, 
	Madhavan Srinivasan <maddy@linux.ibm.com>, Michael Ellerman <mpe@ellerman.id.au>, 
	Nicholas Piggin <npiggin@gmail.com>, Christophe Leroy <christophe.leroy@csgroup.eu>, 
	"David S. Miller" <davem@davemloft.net>, Andreas Larsson <andreas@gaisler.com>, 
	Juergen Gross <jgross@suse.com>, Ajay Kaher <ajay.kaher@broadcom.com>, 
	Alexey Makhalov <alexey.makhalov@broadcom.com>, Thomas Gleixner <tglx@linutronix.de>, 
	Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>, 
	Dave Hansen <dave.hansen@linux.intel.com>, "H. Peter Anvin" <hpa@zytor.com>, 
	Boris Ostrovsky <boris.ostrovsky@oracle.com>, "Aneesh Kumar K.V" <aneesh.kumar@kernel.org>, 
	Andrew Morton <akpm@linux-foundation.org>, Peter Zijlstra <peterz@infradead.org>, 
	Arnd Bergmann <arnd@arndb.de>, David Hildenbrand <david@redhat.com>, 
	Lorenzo Stoakes <lorenzo.stoakes@oracle.com>, "Liam R. Howlett" <Liam.Howlett@oracle.com>, 
	Vlastimil Babka <vbabka@suse.cz>, Mike Rapoport <rppt@kernel.org>, Suren Baghdasaryan <surenb@google.com>, 
	Michal Hocko <mhocko@suse.com>, Alexei Starovoitov <ast@kernel.org>, 
	Andrey Ryabinin <ryabinin.a.a@gmail.com>, linux-arm-kernel@lists.infradead.org, 
	linux-kernel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org, 
	sparclinux@vger.kernel.org, virtualization@lists.linux.dev, 
	xen-devel@lists.xenproject.org, linux-mm@kvack.org, 
	Andy Lutomirski <luto@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, May 30, 2025 at 4:04=E2=80=AFPM Ryan Roberts <ryan.roberts@arm.com>=
 wrote:
> pagemap_scan_pmd_entry() was previously modifying ptes while in lazy mmu
> mode, then performing tlb maintenance for the modified ptes, then
> leaving lazy mmu mode. But any pte modifications during lazy mmu mode
> may be deferred until arch_leave_lazy_mmu_mode(), inverting the required
> ordering between pte modificaiton and tlb maintenance.
>
> Let's fix that by leaving mmu mode, forcing all the pte updates to be
> actioned, before doing the tlb maintenance.
>
> This is a theorectical bug discovered during code review.
>
> Fixes: 52526ca7fdb9 ("fs/proc/task_mmu: implement IOCTL to get and option=
ally clear info about PTEs")

Hmm... isn't lazy mmu mode supposed to also delay TLB flushes, and
preserve the ordering of PTE modifications and TLB flushes?

Looking at the existing implementations of lazy MMU:

 - In Xen PV implementation of lazy MMU, I see that TLB flush
hypercalls are delayed as well (xen_flush_tlb(),
xen_flush_tlb_one_user() and xen_flush_tlb_multi() all use
xen_mc_issue(XEN_LAZY_MMU) which delays issuing if lazymmu is active).
 - The sparc version also seems to delay TLB flushes, and sparc's
arch_leave_lazy_mmu_mode() seems to do TLB flushes via
flush_tlb_pending() if necessary.
 - powerpc's arch_leave_lazy_mmu_mode() also seems to do TLB flushes.

Am I missing something?

If arm64 requires different semantics compared to all existing
implementations and doesn't delay TLB flushes for lazy mmu mode, I
think the "Fixes" tag should point to your addition of lazy mmu
support for arm64.

> Signed-off-by: Ryan Roberts <ryan.roberts@arm.com>
> ---
>  fs/proc/task_mmu.c | 3 +--
>  1 file changed, 1 insertion(+), 2 deletions(-)
>
> diff --git a/fs/proc/task_mmu.c b/fs/proc/task_mmu.c
> index 994cde10e3f4..361f3ffd9a0c 100644
> --- a/fs/proc/task_mmu.c
> +++ b/fs/proc/task_mmu.c
> @@ -2557,10 +2557,9 @@ static int pagemap_scan_pmd_entry(pmd_t *pmd, unsi=
gned long start,
>         }
>
>  flush_and_return:
> +       arch_leave_lazy_mmu_mode();
>         if (flush_end)
>                 flush_tlb_range(vma, start, addr);
> -
> -       arch_leave_lazy_mmu_mode();

I think this ordering was probably intentional, because doing it this
way around allows Xen PV to avoid one more hypercall, because the TLB
flush can be batched together with the page table changes?


>         pte_unmap_unlock(start_pte, ptl);
>
>         cond_resched();
> --
> 2.43.0
>
