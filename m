Received: from out-174.mta0.migadu.com (out-174.mta0.migadu.com [91.218.175.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3C36346AF08
	for <virtualization@lists.linux.dev>; Thu,  2 Jul 2026 11:41:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782992521; cv=none; b=c4mqX4JUkEo/Pi0FUia1Y1tJ0ty34ZVUKd8UPbf/jJHhyRQ4p+UUqENicUju86aWrxxaNDPz+iCRdWCZMU0BbPqF1x0JSoHjLvyloUC6ucBaVfWjZGVp9rFYGU1e1/SXx9CaXyBcuLWsDbsOg0Wudna17Q2ZAaQl80EK4hiEkj4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782992521; c=relaxed/simple;
	bh=vPHtV6pxZdlKjLiAMh+TI96h/MjbfgTMGiJB5aRI1Dw=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=uxTG7AwwMWntGSnnfw91+vRfQbg+NRh0kRQCWlosaaQwp1tqpBeuSpD1CU9fDJGj6ZKvUKfG2KaOii5xD60YKu3Cioa/xx1aw3Ty2fwSqmIrpcV63KJoHz5L6Ys5ItVK+kUBE+IyC1jfz3vyP95kKzcoQY5X9cSPE//ReTtiK6A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=ElylzNP2; arc=none smtp.client-ip=91.218.175.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="ElylzNP2"
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1782992513;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=vPHtV6pxZdlKjLiAMh+TI96h/MjbfgTMGiJB5aRI1Dw=;
	b=ElylzNP2HZvUF6FtGgLgsW4vT0OTcdy2XorLGs6M4jbsXqc3kVIN25VDlrp06Kwp+MnkF0
	7eCUNpZQUAu53ooUNOnYLe8bcSqU2lbFmJuaAoucdQs+qEK4yKsjIpHuYOtBIHp/EvNPEl
	ujU0zKbwsKGW+OA8vv+O0JU4vozY/FA=
From: Lance Yang <lance.yang@linux.dev>
To: ljs@kernel.org
Cc: akpm@linux-foundation.org,
	tsbogend@alpha.franken.de,
	maddy@linux.ibm.com,
	mpe@ellerman.id.au,
	maarten.lankhorst@linux.intel.com,
	mripard@kernel.org,
	tzimmermann@suse.de,
	airlied@gmail.com,
	simona@ffwll.ch,
	l.stach@pengutronix.de,
	inki.dae@samsung.com,
	sw0312.kim@samsung.com,
	kyungmin.park@samsung.com,
	krzk@kernel.org,
	peter.griffin@linaro.org,
	jani.nikula@linux.intel.com,
	joonas.lahtinen@linux.intel.com,
	rodrigo.vivi@intel.com,
	tursulin@ursulin.net,
	robin.clark@oss.qualcomm.com,
	lumag@kernel.org,
	lyude@redhat.com,
	dakr@kernel.org,
	tomi.valkeinen@ideasonboard.com,
	hjc@rock-chips.com,
	heiko@sntech.de,
	andy.yan@rock-chips.com,
	thierry.reding@kernel.org,
	mperttunen@nvidia.com,
	jonathanh@nvidia.com,
	kraxel@redhat.com,
	dmitry.osipenko@collabora.com,
	zack.rusin@broadcom.com,
	matthew.brost@intel.com,
	thomas.hellstrom@linux.intel.com,
	oleksandr_andrushchenko@epam.com,
	deller@gmx.de,
	bcrl@kvack.org,
	viro@zeniv.linux.org.uk,
	brauner@kernel.org,
	muchun.song@linux.dev,
	osalvador@suse.de,
	david@kernel.org,
	ziy@nvidia.com,
	baolin.wang@linux.alibaba.com,
	liam@infradead.org,
	npache@redhat.com,
	ryan.roberts@arm.com,
	dev.jain@arm.com,
	baohua@kernel.org,
	lance.yang@linux.dev,
	hughd@google.com,
	vbabka@kernel.org,
	rppt@kernel.org,
	surenb@google.com,
	mhocko@suse.com,
	jannh@google.com,
	pfalcato@suse.de,
	kees@kernel.org,
	perex@perex.cz,
	tiwai@suse.com,
	linux-mips@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linuxppc-dev@lists.ozlabs.org,
	dri-devel@lists.freedesktop.org,
	etnaviv@lists.freedesktop.org,
	linux-arm-kernel@lists.infradead.org,
	linux-samsung-soc@vger.kernel.org,
	intel-gfx@lists.freedesktop.org,
	linux-arm-msm@vger.kernel.org,
	freedreno@lists.freedesktop.org,
	nouveau@lists.freedesktop.org,
	linux-rockchip@lists.infradead.org,
	linux-tegra@vger.kernel.org,
	virtualization@lists.linux.dev,
	intel-xe@lists.freedesktop.org,
	xen-devel@lists.xenproject.org,
	linux-fbdev@vger.kernel.org,
	linux-aio@kvack.org,
	linux-fsdevel@vger.kernel.org,
	linux-mm@kvack.org,
	linux-sound@vger.kernel.org
Subject: Re: [PATCH 04/13] mm: update generic_get_unmapped_area[_topdown]() to use vma_flags_t
Date: Thu,  2 Jul 2026 19:41:35 +0800
Message-Id: <20260702114135.4189-1-lance.yang@linux.dev>
In-Reply-To: <cef55b19f86c110952f13829aefa4859db3a70ed.1782760670.git.ljs@kernel.org>
References: <cef55b19f86c110952f13829aefa4859db3a70ed.1782760670.git.ljs@kernel.org>
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT


On Mon, Jun 29, 2026 at 08:25:27PM +0100, Lorenzo Stoakes wrote:
>As part of the changes converting VMA flags from a system word size to a
>bitmap, extend this change to generic_get_unmapped_area() and
>generic_get_unmapped_area_topdown(), which also allows us to convert
>stack_guard_placement() as well.
>
>We retain arch_get_unmapped_area() and arch_get_unmapped_area_topdown()
>as-is for now, using legacy_to_vma_flags() as necessary to do so.
>
>No functional change intended.
>
>Signed-off-by: Lorenzo Stoakes <ljs@kernel.org>
>---

Nothing jumped out at me ;) Feel free to add:

Reviewed-by: Lance Yang <lance.yang@linux.dev>
