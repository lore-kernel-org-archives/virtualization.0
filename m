Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9CBA73A9856
	for <virtualization@lists.linux.dev>; Wed, 24 Jun 2026 12:29:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782304167; cv=none; b=djRLkFJJH11mv8ycJMLR+svUtu+ayWKjTfaIvG3XWLfVc5rBYvutbXb+VxOpuDCBxQf4xQGwE8eTWuerpMPdAdczatNvqeDrf9hJK1k8umY3NIViKAZrCT67E2fO8en+KsOW5CPmm4WUDsImO16DUjtHfD0VWsHz1afqNmFHMW8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782304167; c=relaxed/simple;
	bh=kl72IjQB4r8Mj690f0sUnXtHd1ElCNuCYNR8bLEx9zk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=N8qJWnIVh4oqjn5wT9H4SiTfVu8CB4OcW7H7CgCQkuWorXYFBHfhslOipNdn1qCja3W3Wz71Lp0kgHDpCdjV7pEalVmSAB8tANfXR+ThjJ+HYkwnfSbEns/V0/XFKfsHqAGog43AxxD/QJjeJFJ9EKicjfuPHyTe9NYJOegLdQ4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=EyR0cK8g; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="EyR0cK8g"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 00CCD1F00A3E;
	Wed, 24 Jun 2026 12:29:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1782304166;
	bh=vLFDKfatClB4S8ssznZTLIRUnzRia7uBrtLEqy9t/ek=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=EyR0cK8gTidJXBYhqgvqIgBnPh9+CTQutCo9XWYZ+eRmDqdJy/417jZ9UiInoVz9z
	 uQjL6cccG3Tp3Gm75itu/W4o+jiimu+iW3YV0/IDi7LAs5Eq2XGrFILvVdqONJKDlO
	 YSMY0mYOh9XUqAG102c/jidc952SGjm4pEFFXrfgFkPlfnJfh6bNSwy+hkao1puiPm
	 NZNH0wdAGQ87cCFf93BjOIEDEmNurMNLWyhFPIAT+2Pt03ZrZK6lY1vJCskIVJ4iv2
	 LLOXo30HRnvVo0G9niCIefsNNJvJSr9S4qwS/tJxfOYk7ATreurdjFwvvq5GsEB0CQ
	 21dbu4sL4dt9w==
Received: from phl-compute-03.internal (phl-compute-03.internal [10.202.2.43])
	by mailfauth.phl.internal (Postfix) with ESMTP id 598D0F40079;
	Wed, 24 Jun 2026 08:29:25 -0400 (EDT)
Received: from phl-frontend-04 ([10.202.2.163])
  by phl-compute-03.internal (MEProxy); Wed, 24 Jun 2026 08:29:25 -0400
X-ME-Sender: <xms:pc07akVgWsrz8Um1BZEfEsb-lC3PRABzLRgVC0koasw9QSjY29BfKA>
    <xme:pc07aq_FtrgoYLR5Dn1xUbUFEwB4biEy8UISgM2Vm2OWJ-lB0Fb60-dAXhLHvyVrI
    h3k5aMlSeFP6tswjZUqL-AO5pEMs5gs1CiCSq7b6UxPfkFdub8IqtM>
X-ME-Received: <xmr:pc07ai_AJa60Y8IhCkwr9ntYkKgGzFxURn4o1PCyRoJp9TWZ9teN8OcVLu-TlQ>
X-ME-Proxy-Cause: dmFkZTGQArAWzBSIqfuCjB0QzONNhA+q1CTAuSMwuEBhzBy/tzZqNdZnhLnrUk/bzcO1Ob
    qV5IsSKZlnlHEtJlLVg73sfCfTAynNDnYDTF4kwRi+w+FTkK0Cj/188NyX7JkGKPWfnNxe
    ZM17FZj2tytGZvcbggL5ccIEAiZubQjW2zQ07p6w8z8ORw0594PYKzpLhaAAFoTGFnu7lT
    mIFyKVlsfgsicOOXIpKoRyBfzhw2QmhbjRQVUl1F5TMPInjH/W7zYT1cpsVHPi/+sVRVBH
    vqkvswFzfuR86M13twlXL/uVXDyIS9Q4ttcM4JAEe/dw44lKApfjLlgg9VpuTCIqLAFjs3
    RIA08dwy6F4iWczpnRZXpo4MPQHLqROZILWVGAZorUDkjAOXQ9gbs4OT+/LmgsSZczp9kf
    Mste3iIbGoP6dN+l35jCfBfax7CLUTb32ma3ijo+GQyaxJK9cXrdbLgtaerKNVPgnvzlEN
    IlvY4DPzmirrQtEpYzqpe12TSlwKsaHdbR1fF79xctOLhKnilhIdzucN0G7k1UhMedTSsH
    DbVx+0ULLLZW8+dmXHpGOf4T4invnzS8frZk2Tt7Ep0X498mJvzSVJ/UXteMpHepPcfvKA
    xlXAu8rDHYyKGBhWoYKFnqWQB673AsBFiFd08KCD3eiDhOfGQBC9yk3SsWfg
X-ME-Proxy: <xmx:pc07at1we4XECoMGHO5PAcbvgNrgjBcErfNgS9jqsN-Xcp400eZFHQ>
    <xmx:pc07anbgisMzY7jfVVYbR1bbUyJDaIt3NTXZ4E4xg9kUJoTaiP5hJA>
    <xmx:pc07apuEJT-3QZIZ3OSgUYSSXiwmoyV6xRIRHC_90igBK6QJd-h1wA>
    <xmx:pc07auBhOE8MJxJOBUX_7HTvZLd1VfIWbm5cjeiZgu1x4gDB3iICOw>
    <xmx:pc07akA2QBIBPbKFZjZL3NU288XO95EK2pW6Hq5m8DsRA9ZiCSKf_tBr>
Feedback-ID: i10464835:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 24 Jun 2026 08:29:23 -0400 (EDT)
Date: Wed, 24 Jun 2026 13:29:17 +0100
From: Kiryl Shutsemau <kas@kernel.org>
To: Zhenzhong Duan <zhenzhong.duan@intel.com>
Cc: marcandre.lureau@redhat.com, david@kernel.org, 
	rick.p.edgecombe@intel.com, prsampat@amd.com, pbonzini@redhat.com, mst@redhat.com, 
	peterx@redhat.com, chenyi.qiang@intel.com, elena.reshetova@intel.com, 
	michael.roth@amd.com, ackerleytng@google.com, linux-kernel@vger.kernel.org, 
	linux-coco@lists.linux.dev, virtualization@lists.linux.dev, x86@kernel.org, 
	yilun.xu@intel.com, xiaoyao.li@intel.com, chao.p.peng@intel.com
Subject: Re: [RFCv2 PATCH 2/6] efi/unaccepted: Set unaccepted bits for all
 hotplug memory
Message-ID: <ajvNXyYwb7FXAJhP@thinkstation>
References: <20260623101739.79695-1-zhenzhong.duan@intel.com>
 <20260623101739.79695-3-zhenzhong.duan@intel.com>
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260623101739.79695-3-zhenzhong.duan@intel.com>

On Tue, Jun 23, 2026 at 06:17:33AM -0400, Zhenzhong Duan wrote:
> In coco guests, hotpluggable memory ranges are initially unaccepted.
> While a previous change expanded the unaccepted memory bitmap boundaries
> to include these hotplug spaces, the actual bits inside the bitmap are
> not yet marked as unaccepted.
> 
> Walks SRAT a second time after the bitmap is allocated and sets the bits
> corresponding to hotpluggable ranges.
> 
> This ensures the bitmap state accurately reflects all static and hotplug
> memory ranges before booting kernel.
> 
> Signed-off-by: Zhenzhong Duan <zhenzhong.duan@intel.com>
> ---
>  .../firmware/efi/libstub/unaccepted_memory.c   | 18 ++++++++++++++++++
>  1 file changed, 18 insertions(+)
> 
> diff --git a/drivers/firmware/efi/libstub/unaccepted_memory.c b/drivers/firmware/efi/libstub/unaccepted_memory.c
> index bfbb78bd7b8a..01bed8e751ca 100644
> --- a/drivers/firmware/efi/libstub/unaccepted_memory.c
> +++ b/drivers/firmware/efi/libstub/unaccepted_memory.c
> @@ -92,6 +92,23 @@ static void update_mem_boundaries(struct acpi_srat_mem_affinity *mem, struct sra
>  		*(ctx->mem_end) = range_end;
>  }
>  
> +static void mark_hotplug_memory_unaccepted(struct acpi_srat_mem_affinity *mem,
> +					   struct srat_parse_ctx *ctx)
> +{
> +	u64 unit_size = unaccepted_table->unit_size;
> +	u64 start, end;
> +
> +	start = round_up(mem->base_address, unit_size);
> +	end = round_down(mem->base_address + mem->length, unit_size);

We can get here with start > end if srat range is less then unit_size.

> +
> +	/* Translate to offsets from the beginning of the bitmap */
> +	start -= unaccepted_table->phys_base;
> +	end -= unaccepted_table->phys_base;
> +
> +	bitmap_set(unaccepted_table->bitmap,
> +		   start / unit_size, (end - start) / unit_size);
> +}
> +
>  efi_status_t allocate_unaccepted_bitmap(__u32 nr_desc,
>  					struct efi_boot_memmap *map)
>  {
> @@ -169,6 +186,7 @@ efi_status_t allocate_unaccepted_bitmap(__u32 nr_desc,
>  	unaccepted_table->phys_base = unaccepted_start;
>  	unaccepted_table->size = bitmap_size;
>  	memset(unaccepted_table->bitmap, 0, bitmap_size);
> +	parse_acpi_srat_regions(mark_hotplug_memory_unaccepted, &ctx);
>  
>  	status = efi_bs_call(install_configuration_table,
>  			     &unaccepted_table_guid, unaccepted_table);
> -- 
> 2.52.0
> 

-- 
  Kiryl Shutsemau / Kirill A. Shutemov
