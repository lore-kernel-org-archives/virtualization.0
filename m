Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 11AAC353A6E;
	Thu,  2 Jul 2026 15:25:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783005902; cv=none; b=Qd4kOVxePvxrcYJLOsUCq9/HomTZoky5sSi9wy3i9phrqoATOoao/niSELzLkpNOaEe+5BLRp5ahi46Z34pOCHuMBsdyznLa6DAGy7e/VmUxrSKtgVnOTmwFRZLeNufoB22Qy6hIk0I3yB2c6Vv+/UUOGbQ8TY9x3Z6otz16F9Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783005902; c=relaxed/simple;
	bh=PdIrpbOgawWvi9UkUjXo0VCjVwbZVIb5PqySnXAuTkg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=TN29T6AhXcZuSpKNxIGE7y+2hc8UTp+8t9eaMlyPwfqvnwevA+SaiQmU8F5uJ02ghjtTZl50wS5wI+YgEPevIx++RUIfgOxnfaHZl/bBPR5A9xYvkMVvyviMYBYq5RtUmxa71dYZ8t+gXZ7SvEdxxAFIp2wlCfyq+aiBs3mz4dA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=kbG+cL/z; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="kbG+cL/z"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5F0E41F000E9;
	Thu,  2 Jul 2026 15:24:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1783005900;
	bh=LX3BYrLY2k63JpXB67A/Bjg+Ew5yjhUF+WJZEyA1fRw=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=kbG+cL/z/Lm6qSE4udnGibaK8FsMK4daZd2R+hoEFAnemIecEE1GgHP0X+YmGanAO
	 lUy6V/tOsn4eLItop07tyF1+tKZLAB376Z73zBZZR/VxVccPToewSf2zWsClidLb0a
	 1ba3VdHACF4EGJhQZxBSvTHBcWlMH/zUclnichRT0/C3hk+pIj4TS7GYchozD+ZWNu
	 evu0CqyUEndELEE8NUvVmpXBep2Kukvvzwrnf2DWGzh4uAWg/PKpNORRO9bOZEjI+M
	 pMTZGas90E8+KBulzvC/BZdad1hSIx2FR4a50cjXxyZVyxi/oq6E9v6gCdozTTgwHV
	 VbLDs0NzwuGjg==
Date: Thu, 2 Jul 2026 16:24:37 +0100
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
Subject: Re: [PATCH 05/13] mm: prefer mm->def_vma_flags in mm logic
Message-ID: <akaCFf_SjccZznnP@lucifer>
References: <3b4ccdc38819b42ddc79ee5a795831208ac7986c.1782760670.git.ljs@kernel.org>
 <20260702121022.49113-1-lance.yang@linux.dev>
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260702121022.49113-1-lance.yang@linux.dev>

On Thu, Jul 02, 2026 at 08:10:22PM +0800, Lance Yang wrote:
>
> On Mon, Jun 29, 2026 at 08:25:28PM +0100, Lorenzo Stoakes wrote:
> >Currently mm->def_flags (of type vm_flags_t) is union'd with
> >mm->def_vma_flags (of type vma_flags_t).
> >
> >As part of the effort to convert vm_flags_t usage to vma_flags_t (in order
> >to no longer be arbitrarily limited to a system word size for VMA flags),
> >prefer mm->def_vma_flags to mm->def_flags throughout the mm logic.
> >
> >No functional change intended.
> >
> >Signed-off-by: Lorenzo Stoakes <ljs@kernel.org>
> >---
> > mm/debug.c |  2 +-
> > mm/mlock.c | 13 +++++++------
> > mm/mmap.c  | 11 ++++++-----
> > mm/vma.c   |  4 ++--
> > 4 files changed, 16 insertions(+), 14 deletions(-)
> >
> >diff --git a/mm/debug.c b/mm/debug.c
> >index 497654b36f1a..f0a354a9496a 100644
> >--- a/mm/debug.c
> >+++ b/mm/debug.c
> >@@ -226,7 +226,7 @@ void dump_mm(const struct mm_struct *mm)
> > 		mm->numa_next_scan, mm->numa_scan_offset, mm->numa_scan_seq,
> > #endif
> > 		atomic_read(&mm->tlb_flush_pending),
> >-		mm->def_flags, &mm->def_flags
> >+		vma_flags_to_legacy(mm->def_vma_flags), &mm->def_vma_flags
> > 	);
>
> While at it, one thing for later: dump_mm() still assumes one-world VMA
> flags. That works today since vma_flags_t is one word. Maybe worth a
> BUILD_BUG_ON() here, before that stops being true?

Ah yeah that could actually be pretty straightforward, if you see
https://www.kernel.org/doc/Documentation/printk-formats.txt there is a bitmap
format that could be used.

Can do that on a respin!

>
> Not a big deal though. Feel free to add:
>
> Reviewed-by: Lance Yang <lance.yang@linux.dev>
>
> > }
> > EXPORT_SYMBOL(dump_mm);
> [...]

Cheers, Lorenzo
