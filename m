Received: from pegase2.c-s.fr (pegase2.c-s.fr [93.17.235.10])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 040A229D260
	for <virtualization@lists.linux.dev>; Thu,  4 Sep 2025 07:21:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=93.17.235.10
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756970476; cv=none; b=mM4/Xcj0nVbzYAovKfSXmHo6cq8i0/ujLV89BRs1b0Wnqd2c1OMg+QiEa92EngDbjR5JioUweg7Dl9ZFhPLE2klMw/qW8/pJ1d/RcTa06iiV5pGv5C2To5XwQ4TTsVAwYC/+GwAf5M1L+gpywPcE8foelezCwYwX1pmMQy9Tn1w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756970476; c=relaxed/simple;
	bh=64Idyk7KpaYg2cooNWe1O1ydAYcDe1fcDSernhyvyEM=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=rvbO0PyzwRR543PFkI9Ko2P0YNBw7cT//ho9ATG1hy13odR0XdCjMu/NY5VX/kKm5YnoOz1QcYvimAd4LFl9nARTUKfyLkVcZLhzmihNf2pW2gVTWdAmzOd8k8PTK0u0v1B9E0g93juC8qa3qq06Pq/U717MOFYHYibt2nPbM7s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=csgroup.eu; spf=pass smtp.mailfrom=csgroup.eu; arc=none smtp.client-ip=93.17.235.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=csgroup.eu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=csgroup.eu
Received: from localhost (mailhub4.si.c-s.fr [172.26.127.67])
	by localhost (Postfix) with ESMTP id 4cHVwp4xsdz9sVh;
	Thu,  4 Sep 2025 09:10:02 +0200 (CEST)
X-Virus-Scanned: amavisd-new at c-s.fr
Received: from pegase2.c-s.fr ([172.26.127.65])
	by localhost (pegase2.c-s.fr [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id WEv7Y2YJZkgd; Thu,  4 Sep 2025 09:10:02 +0200 (CEST)
Received: from messagerie.si.c-s.fr (messagerie.si.c-s.fr [192.168.25.192])
	by pegase2.c-s.fr (Postfix) with ESMTP id 4cHVwp4BWrz9sVk;
	Thu,  4 Sep 2025 09:10:02 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
	by messagerie.si.c-s.fr (Postfix) with ESMTP id 784388B764;
	Thu,  4 Sep 2025 09:10:02 +0200 (CEST)
X-Virus-Scanned: amavisd-new at c-s.fr
Received: from messagerie.si.c-s.fr ([127.0.0.1])
	by localhost (messagerie.si.c-s.fr [127.0.0.1]) (amavisd-new, port 10023)
	with ESMTP id JZAEJLwTYdG3; Thu,  4 Sep 2025 09:10:02 +0200 (CEST)
Received: from [192.168.235.99] (unknown [192.168.235.99])
	by messagerie.si.c-s.fr (Postfix) with ESMTP id 23FBF8B763;
	Thu,  4 Sep 2025 09:10:02 +0200 (CEST)
Message-ID: <3b333f4e-9817-4a5b-bf0a-f8a9d33575e9@csgroup.eu>
Date: Thu, 4 Sep 2025 09:10:01 +0200
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 5/7] powerpc: Stop calling page_address() in
 free_pages()
To: "Vishal Moola (Oracle)" <vishal.moola@gmail.com>, linux-mm@kvack.org
Cc: linux-kernel@vger.kernel.org, Andrew Morton <akpm@linux-foundation.org>,
 linux-block@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
 linuxppc-dev@lists.ozlabs.org, linux-riscv@lists.infradead.org,
 linux-efi@vger.kernel.org, virtualization@lists.linux.dev,
 Madhavan Srinivasan <maddy@linux.ibm.com>,
 Michael Ellerman <mpe@ellerman.id.au>,
 "Ritesh Harjani (IBM)" <ritesh.list@gmail.com>
References: <20250903185921.1785167-1-vishal.moola@gmail.com>
 <20250903185921.1785167-6-vishal.moola@gmail.com>
From: Christophe Leroy <christophe.leroy@csgroup.eu>
Content-Language: fr-FR
In-Reply-To: <20250903185921.1785167-6-vishal.moola@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit



Le 03/09/2025 à 20:59, Vishal Moola (Oracle) a écrit :
> free_pages() should be used when we only have a virtual address. We
> should call __free_pages() directly on our page instead.
> 
> Signed-off-by: Vishal Moola (Oracle) <vishal.moola@gmail.com>
> Reviewed-by: Ritesh Harjani (IBM) <ritesh.list@gmail.com>

Reviewed-by: Christophe Leroy <christophe.leroy@csgroup.eu>

> ---
>   arch/powerpc/mm/book3s64/radix_pgtable.c | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/arch/powerpc/mm/book3s64/radix_pgtable.c b/arch/powerpc/mm/book3s64/radix_pgtable.c
> index be523e5fe9c5..73977dbabcf2 100644
> --- a/arch/powerpc/mm/book3s64/radix_pgtable.c
> +++ b/arch/powerpc/mm/book3s64/radix_pgtable.c
> @@ -780,7 +780,7 @@ static void __meminit free_vmemmap_pages(struct page *page,
>   		while (nr_pages--)
>   			free_reserved_page(page++);
>   	} else
> -		free_pages((unsigned long)page_address(page), order);
> +		__free_pages(page, order);
>   }
>   
>   static void __meminit remove_pte_table(pte_t *pte_start, unsigned long addr,

