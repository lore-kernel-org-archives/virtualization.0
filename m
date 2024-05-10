Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 33E7348CE0
	for <virtualization@lists.linux.dev>; Fri, 10 May 2024 19:48:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.15
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715370499; cv=none; b=UFlj8s80iRaQDzLi3NV6ixpUBFoql+FL2sOit3Cd4m2qQbS+z6dh+kYI60sP8EODhK/frY2am2e20BjaU62m9JdWHYY/G/CgO4OgcXML+SY7liiP8t3r0TTmkiGU/sUFmKrhMNmAvIqrtfvZ12qXerYdRQdqrBZKkj2g31k01Bg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715370499; c=relaxed/simple;
	bh=CMiGL2sWd2aGfbdzvEKmNZY9N4FQgtR15I4ohL35fkM=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=G/6CqFaixvUcLqTqvqG4ujAYBFXBwxGZAggAV4Ey2wfEnEEe5JG0pzSPK/XELh4BqAeZfW3InHJ57xYu1x+GwSIg2xRsQBlX1wT5WKL+XECj1YGZdsUpx0Exuk+GoGmPQJ8jL2M4k+G2/rEPqnnNAuyZxp0vI+UV2TcaIreElYo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=hJX3BQXB; arc=none smtp.client-ip=192.198.163.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="hJX3BQXB"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1715370498; x=1746906498;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=CMiGL2sWd2aGfbdzvEKmNZY9N4FQgtR15I4ohL35fkM=;
  b=hJX3BQXBU1S9o3o/QEODwapJ+1HgO/mimDGFYdWP6pgSGLSMYyOkxMea
   89VSYcJCGwyJ/yqIFL4tuqWQNL2paNxj+z9QBhUho29ZEV0Ery8XfpIom
   i0bPEy46JmOKOi6/wB+UxkclxOLt0hc+fjvmk+wZzXYN2e9G73aPXWgZy
   eDRDV8ZksZdzx75y9arVeqW2NQVebRMVfcKdQxeD20KBtlhGGqbr2vxkB
   fJb/YQMbzjrCuD9Gz101uvGvzagzxsRFOkWkhusCWWckfEdUgNyQnGN57
   hxGkLXBXNkdGNFKIo2MhM8SHp40ZIsg1kedS0hia5TVMrdPNjI4ylzU/T
   w==;
X-CSE-ConnectionGUID: JXMrVUoOSSWWULYx09U+xA==
X-CSE-MsgGUID: mbg4zSpIQPqLlbG0wvQxbQ==
X-IronPort-AV: E=McAfee;i="6600,9927,11069"; a="11534169"
X-IronPort-AV: E=Sophos;i="6.08,151,1712646000"; 
   d="scan'208";a="11534169"
Received: from fmviesa008.fm.intel.com ([10.60.135.148])
  by fmvoesa109.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 May 2024 12:48:18 -0700
X-CSE-ConnectionGUID: f/ugZBk2QXGZrOQ7kSzH3w==
X-CSE-MsgGUID: UkmdNvhORKeQLtMkM2bQlQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.08,151,1712646000"; 
   d="scan'208";a="29662577"
Received: from viggo.jf.intel.com (HELO [127.0.0.1]) ([10.54.77.144])
  by fmviesa008.fm.intel.com with ESMTP; 10 May 2024 12:48:15 -0700
Message-ID: <e7047fd5-8bcf-42aa-9729-125bb7304f35@linux.intel.com>
Date: Fri, 10 May 2024 12:48:15 -0700
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/1] x86/vector: Fix vector leak during CPU offline
To: Dongli Zhang <dongli.zhang@oracle.com>, x86@kernel.org
Cc: tglx@linutronix.de, mingo@redhat.com, Borislavbp@alien8.de,
 dave.hansen@linux.intel.com, hpa@zytor.com, joe.jin@oracle.com,
 linux-kernel@vger.kernel.org, virtualization@lists.linux.dev
References: <20240510190623.117031-1-dongli.zhang@oracle.com>
From: Dave Hansen <dave.hansen@linux.intel.com>
Content-Language: en-US
Autocrypt: addr=dave.hansen@linux.intel.com; keydata=
 xsFNBE6HMP0BEADIMA3XYkQfF3dwHlj58Yjsc4E5y5G67cfbt8dvaUq2fx1lR0K9h1bOI6fC
 oAiUXvGAOxPDsB/P6UEOISPpLl5IuYsSwAeZGkdQ5g6m1xq7AlDJQZddhr/1DC/nMVa/2BoY
 2UnKuZuSBu7lgOE193+7Uks3416N2hTkyKUSNkduyoZ9F5twiBhxPJwPtn/wnch6n5RsoXsb
 ygOEDxLEsSk/7eyFycjE+btUtAWZtx+HseyaGfqkZK0Z9bT1lsaHecmB203xShwCPT49Blxz
 VOab8668QpaEOdLGhtvrVYVK7x4skyT3nGWcgDCl5/Vp3TWA4K+IofwvXzX2ON/Mj7aQwf5W
 iC+3nWC7q0uxKwwsddJ0Nu+dpA/UORQWa1NiAftEoSpk5+nUUi0WE+5DRm0H+TXKBWMGNCFn
 c6+EKg5zQaa8KqymHcOrSXNPmzJuXvDQ8uj2J8XuzCZfK4uy1+YdIr0yyEMI7mdh4KX50LO1
 pmowEqDh7dLShTOif/7UtQYrzYq9cPnjU2ZW4qd5Qz2joSGTG9eCXLz5PRe5SqHxv6ljk8mb
 ApNuY7bOXO/A7T2j5RwXIlcmssqIjBcxsRRoIbpCwWWGjkYjzYCjgsNFL6rt4OL11OUF37wL
 QcTl7fbCGv53KfKPdYD5hcbguLKi/aCccJK18ZwNjFhqr4MliQARAQABzU5EYXZpZCBDaHJp
 c3RvcGhlciBIYW5zZW4gKEludGVsIFdvcmsgQWRkcmVzcyAjMikgPGRhdmUuaGFuc2VuQGxp
 bnV4LmludGVsLmNvbT7CwXgEEwECACIFAlRAAv0CGwMGCwkIBwMCBhUIAgkKCwQWAgMBAh4B
 AheAAAoJEGg1lTBwyZKwgjMP/19ErEr2gZW5HufybCDiyP/oYlPd3bNpp+iF85pcjN7+lT+K
 eMUOaGAPxJ896ZdCChByqicVmgVaVZBghrLADCDhTbXmRohYf0naPI3qfHsnzvt6Z7QVaDb+
 aXzROQvRnlVkTays23MkLwUM9vP259/FD3hAJVXQU+l3uNCGn4J41YtrJPmR5N7WpoU1U6RZ
 UF0OgPnflG/h9cXYA8jgJbRulYneADIi7T95vf832Nexa4xZnBKat6usArH9B7Gw82jSZgv+
 g1Nm+KA/KCSZMbRf9xbG+NWk3708q8nlDXN3JyXe+8RwnlRCJEzYSz7wO681/NKyfc0lMa8k
 u1NtvjbIC3hA7VTD62dwLv/sxpCSywLlM9otgFJsQ3kRe7yCNila89GFasNepyQ1vv8p1tSJ
 cD8tejoSUprAeSp1xhq2ZIFvvXh7Es76141oNIhusxah/wSfoE3bnUOOyrn8im6mpYhAtCKD
 YQi03MPt2UG6+Jiy8Pb05W0wNpSRXato3xD4CIPdooYQHmQb3Gq/SF9nfN6qAG+w4k6uubjY
 YKXWrFC7pFESQ5O+ZMyfbvSniPEVlR4eLQrlRh75PON6iojMHf33AsSKAJzvf+rgagGXXJ3u
 5x6kuaLffTkOD4gCe4S9VwP5/uJKyH+OfUqxxLzvye0p98sipmg3yl1qV4VSzsFNBFRjzmoB
 EACyAxbvUEhdGDGNg0JhDdezyTdN8C9BFsdxyTLnSH31NRiyp1QtuxvcqGZjb2trDVuCbIzR
 rgMZLVgo3uprMIOx1CXEgmn23Zhh0EpdVHM8IKx9Z7V0r+rrpRWFE8/wQZngKYVi49PGoZj5
 0ZEifEJ5qn/HNsp2+Y+bTUjDdgWMATg9DiFMyv8fvoqgNsNyrrZTnSgoLzdxr89FGHZCoSoA
 K8gfgFHuO54BlI8QOfPDG9WDPJ66HCodjTlBEr/Cwq6GruxS5i2Y33YVqxvFvDa1tUtl+iJ2
 SWKS9kCai2DR3BwVONJEYSDQaven/EHMlY1q8Vln3lGPsS11vSUK3QcNJjmrgYxH5KsVsf6P
 NRj9mp8Z1kIGqjRx08+nnyStWC0gZH6NrYyS9rpqH3j+hA2WcI7De51L4Rv9pFwzp161mvtc
 6eC/GxaiUGuHBNAVP0PY0fqvIC68p3rLIAW3f97uv4ce2RSQ7LbsPsimOeCo/5vgS6YQsj83
 E+AipPr09Caj0hloj+hFoqiticNpmsxdWKoOsV0PftcQvBCCYuhKbZV9s5hjt9qn8CE86A5g
 5KqDf83Fxqm/vXKgHNFHE5zgXGZnrmaf6resQzbvJHO0Fb0CcIohzrpPaL3YepcLDoCCgElG
 MGQjdCcSQ+CiFCRl0Bvyj1YZUql+ZkptgGjikQARAQABwsFfBBgBAgAJBQJUY85qAhsMAAoJ
 EGg1lTBwyZKwl4IQAIKHs/9po4spZDFyfDjunimEhVHqlUt7ggR1Hsl/tkvTSze8pI1P6dGp
 2XW6AnH1iaynyRcoyT0ZJ+Zmm4xAH1zqKjWplzqdb/dO28qk0bPso8+1oPO8oDhLm1+tY+cO
 vufXkBTm+whm+AyNTjaCRt6aSMnA/QHVGSJ8grrTJCoACVNhnXg/R0g90g8iV8Q+IBZyDkG0
 tBThaDdw1B2lasInUTeb9EiVfL/Zjdg5VWiF9LL7iS+9hTeVdR09vThQ/DhVbCNxVk+DtyBH
 sjOKifrVsYepWpRGBIAu3bK8eXtyvrw1igWTNs2wazJ71+0z2jMzbclKAyRHKU9JdN6Hkkgr
 2nPb561yjcB8sIq1pFXKyO+nKy6SZYxOvHxCcjk2fkw6UmPU6/j/nQlj2lfOAgNVKuDLothI
 xzi8pndB8JjuKktE5HJqUUMXePkAYIxEQ0mMc8Po7tuXdejgPMwgP7x65xtfEqI0RuzbUioF
 ltsp1jUaRwQZMTsCeQDdjpgHsj+P2ZDeEKCbma4m6Ez/YWs4+zDm1X8uZDkZcfQlD9NldbKD
 JEXLIjYWo1PHhYepSffIWPyvBMBTW2W5FRjJ4vLRrJSUoEfJuPQ3vW9Y73foyo/qFoURHO48
 AinGPZ7PC7TFvUaNOTjKedrqHkaOcqB185ahG2had0xnFsDPlx5y
In-Reply-To: <20240510190623.117031-1-dongli.zhang@oracle.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 5/10/24 12:06, Dongli Zhang wrote:
>  	} else {
> +		/*
> +		 * This call borrows from the comments and implementation
> +		 * of apic_update_vector(): "If the target CPU is offline
> +		 * then the regular release mechanism via the cleanup
> +		 * vector is not possible and the vector can be immediately
> +		 * freed in the underlying matrix allocator.".
> +		 */
> +		irq_matrix_free(vector_matrix, apicd->prev_cpu,
> +				apicd->prev_vector, apicd->is_managed);
>  		apicd->prev_vector = 0;
>  	}

I know it's just two sites, but I'd much rather spend the space on a
helper function than a copy-and-pasted comment.  Wouldn't something like
this make it like stupidly obvious what's going on:

        if (cpu_online(cpu)) {
		...
        } else {
		irq_matrix_free_offline(apicd->prev_cpu,
					apicd->prev_vector,
					apicd->is_managed);
                apicd->prev_vector = 0;
        }

/* Free a vector when the target CPU is offline */
static void irq_matrix_free_offline(...)
{
	lockdep_assert_held(&vector_lock);
	WARN_ON_ONCE(!cpu_offline(apicd->prev_cpu));

	/*
	 * The regular release mechanism via the cleanup vector is not
	 * possible.  Immediately free the vector in the underlying
	 * matrix allocator.
 	 */
	irq_matrix_free(&whatever, cpu, vector, managed);
}

It would also be rather hard to screw up even if someone called it on an
online CPU because you'd get a nice warning.
