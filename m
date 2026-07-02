Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2BB74353A60;
	Thu,  2 Jul 2026 15:29:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783006185; cv=none; b=YGMN2I+ez9dkdjgYQb2tlO5hKD9cAP50vn4MVLjV+ECgA8iMkrRGw5MNZtPCZmqx45LGL8GY0gAo29Owe2PYcESvVwc5p/QcdNtXXShHn/DMdGb5GtJpIlzNQD+aEgGS/xFk34Z7L0GLO+fAT2LqwApvF/zxisih0RbZI+RJJQs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783006185; c=relaxed/simple;
	bh=IG8+GuC0aOA3AscYCiOBhfySi1vGUfpQ7FDL8abr1iM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Ea6OsBWJgvkwR7Z+O/fk+4Z4cJMSaL6WKqIJFtf7tY5nRWyCcRgvdCnBubJr/lM3vLZ+T6tn8sJJY4+U7+3NdWmdCISK3/tvQZ9mtN9YsITs7HZeZgmD07UrCcXjgb6gVx881J7FIGfuJ3/0tIQP4szTtG1mWcbjmZbcX88mAUo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=EZDY+QGc; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="EZDY+QGc"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BA7DF1F000E9;
	Thu,  2 Jul 2026 15:29:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1783006184;
	bh=AmvNH9wwHqyoIMesePnV6/zMDBtlSz51dFh4yHJ1BTo=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=EZDY+QGcsghhDIw9rxbIhnPAJRijthrModhJ3dAoSN5cVM+YkTpcpEvD+KPlh/M/u
	 Qwt3kZkRl2OzXpZ8lNBF20cEMvcQmjr2C3N0OBOmi3krbMnyRHMJTEBJXrtiCGLkys
	 hVceGk9nKeLivyWhhq1nb1heVf5ntbaXnUG4S4OpDlt89/1RU+lLBy/OziQBm1WY0f
	 mLETtt6Kv1hVTKJQz++mgHlN+PUF+ac9yH5QtMrmNRfTW7GoeSyD7Rts3hi3Don33s
	 UtJfTmtwGOSlfBDJEzVdm8IjgP96nHmx5GxFIPDKfkfCebxxa9UBrNHRuHW+T6BGzw
	 FkrA9PbgKP9aQ==
Date: Thu, 2 Jul 2026 16:29:20 +0100
From: Lorenzo Stoakes <ljs@kernel.org>
To: Lance Yang <lance.yang@linux.dev>
Cc: akpm@linux-foundation.org, tsbogend@alpha.franken.de, 
	maddy@linux.ibm.com, mpe@ellerman.id.au, maarten.lankhorst@linux.intel.com, 
	mripard@kernel.org, tzimmermann@suse.de, airlied@gmail.com, simona@ffwll.ch, 
	l.stach@pengutronix.de, inki.dae@samsung.com, sw0312.kim@samsung.com, 
	kyungmin.park@samsung.com, krzk@kernel.org, peter.griffin@linaro.org, 
	jani.nikula@linux.intel.com, joonas.lahtinen@linux.intel.com, rodrigo.vivi@intel.com, 
	tursulin@ursulin.net, robin.clark@oss.qualcomm.com, lumag@kernel.org, lyude@redhat.com, 
	dakr@kernel.org, tomi.valkeinen@ideasonboard.com, hjc@rock-chips.com, 
	heiko@sntech.de, andy.yan@rock-chips.com, thierry.reding@kernel.org, 
	mperttunen@nvidia.com, jonathanh@nvidia.com, kraxel@redhat.com, 
	dmitry.osipenko@collabora.com, zack.rusin@broadcom.com, matthew.brost@intel.com, 
	thomas.hellstrom@linux.intel.com, oleksandr_andrushchenko@epam.com, deller@gmx.de, bcrl@kvack.org, 
	viro@zeniv.linux.org.uk, brauner@kernel.org, muchun.song@linux.dev, osalvador@suse.de, 
	david@kernel.org, ziy@nvidia.com, baolin.wang@linux.alibaba.com, 
	liam@infradead.org, npache@redhat.com, ryan.roberts@arm.com, dev.jain@arm.com, 
	baohua@kernel.org, hughd@google.com, vbabka@kernel.org, rppt@kernel.org, 
	surenb@google.com, mhocko@suse.com, jannh@google.com, pfalcato@suse.de, 
	kees@kernel.org, perex@perex.cz, tiwai@suse.com, linux-mips@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org, dri-devel@lists.freedesktop.org, 
	etnaviv@lists.freedesktop.org, linux-arm-kernel@lists.infradead.org, 
	linux-samsung-soc@vger.kernel.org, intel-gfx@lists.freedesktop.org, linux-arm-msm@vger.kernel.org, 
	freedreno@lists.freedesktop.org, nouveau@lists.freedesktop.org, 
	linux-rockchip@lists.infradead.org, linux-tegra@vger.kernel.org, virtualization@lists.linux.dev, 
	intel-xe@lists.freedesktop.org, xen-devel@lists.xenproject.org, linux-fbdev@vger.kernel.org, 
	linux-aio@kvack.org, linux-fsdevel@vger.kernel.org, linux-mm@kvack.org, 
	linux-sound@vger.kernel.org
Subject: Re: [PATCH 06/13] mm/vma: convert vm_pgprot_modify() to use
 vma_flags_t and rename
Message-ID: <akaC-xxNr8ZyN4aH@lucifer>
References: <548ba81b2971734d4d2143237ad1465bd1b2f525.1782760670.git.ljs@kernel.org>
 <20260702122116.65642-1-lance.yang@linux.dev>
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260702122116.65642-1-lance.yang@linux.dev>

On Thu, Jul 02, 2026 at 08:21:16PM +0800, Lance Yang wrote:
>
> On Mon, Jun 29, 2026 at 08:25:29PM +0100, Lorenzo Stoakes wrote:
> >Update vm_pgprot_modify() to use the new VMA flags type vma_flags_t, and
> >rename to vma_pgprot_modify() accordingly.
> >
> >This is part of the ongoing work to convert vm_flags_t to vma_flags_t, in
> >order to eliminate the arbitrary limit of the number of bits in a system
> >word on available VMA flags.
> >
> >Update VMA userland tests accordingly, updating vma_set_page_prot() to no
> >longer inline vma_pgprot_modify(), rather we can simply define
> >vma_pgprot_modify() as a static inline function and the tests will pick it
> >up from vma.h.
> >
> >No functional change intended.
> >
> >Signed-off-by: Lorenzo Stoakes <ljs@kernel.org>
> >---
> [...]
> >diff --git a/mm/vma.h b/mm/vma.h
> >index bcf0c2773449..6a8abb8ae937 100644
> >--- a/mm/vma.h
> >+++ b/mm/vma.h
> >@@ -522,9 +522,11 @@ static inline bool vma_wants_manual_pte_write_upgrade(struct vm_area_struct *vma
> > }
> >
> > #ifdef CONFIG_MMU
> >-static inline pgprot_t vm_pgprot_modify(pgprot_t oldprot, vm_flags_t vm_flags)
> >+static inline pgprot_t vma_pgprot_modify(pgprot_t oldprot, vma_flags_t vma_flags)
> > {
> >-	return pgprot_modify(oldprot, vm_get_page_prot(vm_flags));
> >+	const pgprot_t prot = vma_get_page_prot(vma_flags);
> >+
> >+	return pgprot_modify(oldprot, prot);
>
> Nit: could this just stay as a single return? something like:
>
> return pgprot_modify(oldprot, vma_get_page_prot(vma_flags));

I feel it's a bit clearer this way, separating out the two, I know it's a super
tiny difference but anyway :P

>
> Otherwise, LGTM, feel free to add:
>
> Reviewed-by: Lance Yang <lance.yang@linux.dev>

Thanks!

>
> [...]

Cheers, Lorenzo
