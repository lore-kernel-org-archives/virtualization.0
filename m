Received: from casper.infradead.org (casper.infradead.org [90.155.50.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6AC477FD;
	Thu,  6 Mar 2025 04:52:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.50.34
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741236740; cv=none; b=hzB/wNUt9T0+hEv/w16Bi0l2hfvmcnblcTmRp07ri4GzUrsbwPsP0MpKyBPvvb03hV+EYyWlPIeoBJDgEk2rsLbS5Ml47PL5/7B4+9DCY9Egqd+E/6OE4nc6KBh+ZdvwTuEMdK6FKJig8CbhsEjIooJ3XtxH8gRfbzWAetNu+jg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741236740; c=relaxed/simple;
	bh=k6sCpy6YzMjw7AtI3rz610vzFd+iZ0fK9Cd9jE5n/Eo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=FSR+/CfvCIcB1iBPQuMdM4B2IdnpIcPrsGh1s4Td98ChbFKysfWrq9hA0GJt+Yc1Crz1aWd8gE+lDDGJ3HX8XBY1AoNxhzcbLuAmYC01PBwsrDeh/0fOyt14uoEZZzOoqWSQiiBjW1FHLDROUgJeZUExdA71B6iNo3mwwHzFS5U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=T4DxHqsR; arc=none smtp.client-ip=90.155.50.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="T4DxHqsR"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=PSV6KR/L2RCJUIUbykQwn+3XqvL7U90zxgqKneqEbw0=; b=T4DxHqsREMzOnsxlv3u/oTlt+/
	73IurSXLrDcL0/sykIwVZy8bMG38iXhrTyeXxr0tJxqK6NsRHlVcz1I1JFyveu9DmttTGiQUdWY4G
	eIooopUyLYl62tVcrpTdhURvmbOG9gVuCd6v3tC300MxtQvHlr0zl7UCz4LZdHzeH8QzYX/PluICc
	3FJLvIAawW2nQrnKgxsilYLe3E4WD1sehIBLWCy3sAUc2Inn1gQz0byszk6BgdnyHBGFkFudqN3/U
	XGugWdBVKT/HbLBipL3kbyR9HwW2I36Pzmyd13eikwCwYYwrSlug9ac2HwSJMBDaRd1qdd9+Jsc6Y
	4av/S6dg==;
Received: from willy by casper.infradead.org with local (Exim 4.98 #2 (Red Hat Linux))
	id 1tq3DJ-00000006oty-2yf4;
	Thu, 06 Mar 2025 04:52:05 +0000
Date: Thu, 6 Mar 2025 04:52:05 +0000
From: Matthew Wilcox <willy@infradead.org>
To: Ryosuke Yasuoka <ryasuoka@redhat.com>
Cc: maarten.lankhorst@linux.intel.com, mripard@kernel.org,
	tzimmermann@suse.de, airlied@gmail.com, simona@ffwll.ch,
	kraxel@redhat.com, gurchetansingh@chromium.org, olvaffe@gmail.com,
	akpm@linux-foundation.org, urezki@gmail.com, hch@infradead.org,
	dmitry.osipenko@collabora.com, jfalempe@redhat.com,
	dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org,
	virtualization@lists.linux.dev, linux-mm@kvack.org
Subject: Re: [PATCH drm-next 1/2] vmalloc: Add atomic_vmap
Message-ID: <Z8kp9Z9VgTpQmV9d@casper.infradead.org>
References: <20250305152555.318159-1-ryasuoka@redhat.com>
 <20250305152555.318159-2-ryasuoka@redhat.com>
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250305152555.318159-2-ryasuoka@redhat.com>

On Thu, Mar 06, 2025 at 12:25:53AM +0900, Ryosuke Yasuoka wrote:
> Some drivers can use vmap in drm_panic, however, vmap is sleepable and
> takes locks. Since drm_panic will vmap in panic handler, atomic_vmap
> requests pages with GFP_ATOMIC and maps KVA without locks and sleep.

In addition to the implicit GFP_KERNEL allocations Vlad mentioned, how
is this supposed to work?

> +	vn = addr_to_node(va->va_start);
> +
> +	insert_vmap_area(va, &vn->busy.root, &vn->busy.head);

If someone else is holding the vn->busy.lock because they're modifying the
busy tree, you'll corrupt the tree.  You can't just say "I can't take a
lock here, so I won't bother".  You need to figure out how to do something
safe without taking the lock.  For example, you could preallocate the
page tables and reserve a vmap area when the driver loads that would
then be usable for the panic situation.  I don't know that we have APIs
to let you do that today, but it's something that could be added.
