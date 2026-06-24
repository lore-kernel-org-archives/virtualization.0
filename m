Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D3388221723
	for <virtualization@lists.linux.dev>; Wed, 24 Jun 2026 12:33:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782304401; cv=none; b=pxmuwU1cAJ/PU0ShjEobz70xbOxpV0+4HEXY41SgzF+7iX8el3prwG6ABIooNDq5xN6o9dc/B8sn1hoa6uyISqclO+EjkiWOtmup5cR3JF4cjJ8FSb0nuk5a4yIfSHvx0QzyM2iOAVsSro/72xIjjDG6zqghrgl8A5VS/5cTLXs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782304401; c=relaxed/simple;
	bh=aXKEZeAIyTQvGAvWdKWZTpM9Tn7v8MPQIk0I3bgXiwU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=WJuu7oNd5baYAD1lCY+PmlrEQgR0nPsLj4J2r7eqnlJTuU3dDlGLeLKsMhg+0zKGmFkT9yuxx1j/pXcu40uQ+Fevx2+dwY0UV49x15FtefhHsE2iGpaOAe47bpur2Fq1OGAunwp37zAP6Ko7X3IXdLwKByNNUBTfJ4hZZiAWG7o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ZB1jNphk; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ZB1jNphk"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 266EC1F00A3E;
	Wed, 24 Jun 2026 12:33:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1782304400;
	bh=Nki/E82hyr5wzO/AYQ3QdWs1GuwADLma1GsoIRocgYM=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=ZB1jNphkHO6MwhR6XuqIIqKqYY9iu0gKejp6yxcLX1F7oq21yymnhbvHzmuu2X5Pj
	 Vp+mInO7vlxUEtgKaxdQZdSe6BOA8Yb6uxxhNwTP1ARX24J0FvaLWPOKU+tCuoBZDK
	 rs/T6PP6Yp289i6COE981MCh4bobEWM8kDODAdnr1+XtXLwCLKXFWOEiSWn4XxRLBa
	 2Jmg3GyZ/rRB9KJrkjE8hpsDyEVvLN+mvYvGaeOlxTAMAfFH2YwGVEYUn1aRpO1N7J
	 P6oihZBRIdZkq+ugURrxuqPLTayhll/Jcgg1YfMaw5KwJ9HNeGZItwEuBv8wXDYy38
	 q1KIIm+K5SKvw==
Received: from phl-compute-04.internal (phl-compute-04.internal [10.202.2.44])
	by mailfauth.phl.internal (Postfix) with ESMTP id 4E2A9F40084;
	Wed, 24 Jun 2026 08:33:19 -0400 (EDT)
Received: from phl-frontend-04 ([10.202.2.163])
  by phl-compute-04.internal (MEProxy); Wed, 24 Jun 2026 08:33:19 -0400
X-ME-Sender: <xms:j847agv6zFQJ6Lx56W2Ad4SsiRvOg-ldB6AexUeLL31cCY7YoLpJ9w>
    <xme:j847aqOCde6aTy69J-ZJ7macCNXtZ9cgdkhACmaT_YRaHehyWwaNRJH5qcbHIXZPE
    Skt63GLQpWw26ymfylH34ojkfWxZE0akXU-e1yvWZrKY2H5VqW-IlI>
X-ME-Received: <xmr:j847arXbzKtAE4MYHqfHd4KAxT03nQYyEsqwQ5TsclJrcapKPjlnwPBNuFn3zg>
X-ME-Proxy-Cause: dmFkZTEshFasPiuUqrsCqlwMRprq3eUmLI2Qea4inUfatnVfKbcgTrYCk/YZwKl+RFjobo
    UKJrX0das8rKVf3QXBESD63zwVytHbUc6Y1UbALzr/gAwy9p/QgDo5dMJZMh+Db6azfrSF
    hMVBZcH5gVUrD145SS8mpc0HAgSEuRCqOfwe9hQQPGNFikP0flMvElGrfmlv4U25n6y0DG
    u0CWBVQvazrLfUtEasDGaka78VCXTqNa/Yf5HFs1Ut/jqOYlJICz26w4tbplGi8sdNaB7k
    ML8jtKLbzQe7NICpn95E+XLFKPoJHnJ9gQy9xPst1WDc7Uy+5MeRf+yZn6Iz6zmG5WAuGn
    AzzYuc5kqB81AXIuW4xjXYtVsh5Cf2PSh96QRbRcuMmNTLZDcDtBNST0NgHasnXURmxhqo
    nlF16s6ZnExY1kkiyU3XbmAq/UHPkeF/lmJXTHXYU2Uk1nq1wCSHxKpfg40D7v6SpwTrks
    ozgfiH/UBAbQxtruqE5qrpzF9wwSf0dUFaOsSOuepEykXIufsrbKbwWt88wuxtC3EO2Ohe
    aQP6l5peBETAbMbCUUrMlpDzX/iYqpWHhhkuJteI7K/34E10kxXRu9kQ9Yxz91KWVHh1mm
    5sF/yJ+5CE+rXoqH+soQSVuVINZsKlnMMbfA6ysjl1QdZcUauXbVXZ5DiS3g
X-ME-Proxy: <xmx:j847ar2E3odeoKaMGsLVMwjTFaTF8lVUUXn1kwJ_GiFKqsLKkTXp1w>
    <xmx:j847alO1ppDq5ehSS1WZXmNeD2CIZKvnqz_bgslW9I_nGEMlxdhkjg>
    <xmx:j847arQKQdUgvCggDOoBDlgAu17N4oLk_IXNBa9dIeeS7PSP_jvZBQ>
    <xmx:j847agE10SgRUgRg2ZUB3jYpLk-027wOlmnk7aEjw9FoEVfq-o72sQ>
    <xmx:j847ak4h1h-_EYk4PBGiujMCnAHihXqPj1AuWYYSGNYpbqF9LZXdMoFc>
Feedback-ID: i10464835:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 24 Jun 2026 08:33:18 -0400 (EDT)
Date: Wed, 24 Jun 2026 13:33:17 +0100
From: Kiryl Shutsemau <kas@kernel.org>
To: Zhenzhong Duan <zhenzhong.duan@intel.com>
Cc: marcandre.lureau@redhat.com, david@kernel.org, 
	rick.p.edgecombe@intel.com, prsampat@amd.com, pbonzini@redhat.com, mst@redhat.com, 
	peterx@redhat.com, chenyi.qiang@intel.com, elena.reshetova@intel.com, 
	michael.roth@amd.com, ackerleytng@google.com, linux-kernel@vger.kernel.org, 
	linux-coco@lists.linux.dev, virtualization@lists.linux.dev, x86@kernel.org, 
	yilun.xu@intel.com, xiaoyao.li@intel.com, chao.p.peng@intel.com
Subject: Re: [RFCv2 PATCH 5/6] mm/memory_hotplug: Support ACPI hotplug/unplug
 for coco guest
Message-ID: <ajvOP9NwqNstgNvl@thinkstation>
References: <20260623101739.79695-1-zhenzhong.duan@intel.com>
 <20260623101739.79695-6-zhenzhong.duan@intel.com>
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260623101739.79695-6-zhenzhong.duan@intel.com>

On Tue, Jun 23, 2026 at 06:17:36AM -0400, Zhenzhong Duan wrote:
> +	spin_lock_irqsave(&unaccepted_memory_lock, flags);
> +	for (; range_start < bitmap_size; range_start = range_end) {
> +		unsigned long phys_start, phys_end;
> +		unsigned long unaccepted_one, plugged_zero;
> +
> +		range_start = find_next_andnot_bit(plugged_bitmap, unaccepted->bitmap,
> +						   bitmap_size, range_start);
> +
> +		if (range_start >= bitmap_size)
> +			break;
> +
> +		unaccepted_one = find_next_bit(unaccepted->bitmap, bitmap_size, range_start);
> +		plugged_zero = find_next_zero_bit(plugged_bitmap, bitmap_size, range_start);
> +		range_end = min(unaccepted_one, plugged_zero);
> +
> +		phys_start = range_start * unit_size + unaccepted->phys_base;
> +		phys_end = range_end * unit_size + unaccepted->phys_base;
> +
> +		arch_unaccept_memory(phys_start, phys_end);
> +		bitmap_set(unaccepted->bitmap, range_start, range_end - range_start);
> +	}
> +	spin_unlock_irqrestore(&unaccepted_memory_lock, flags);

Accept TDCALL under the spin lock will kill scalability.

-- 
  Kiryl Shutsemau / Kirill A. Shutemov
