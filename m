Received: from linux.microsoft.com (linux.microsoft.com [13.77.154.182])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1CCF33B27D2
	for <virtualization@lists.linux.dev>; Mon,  1 Jun 2026 14:02:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=13.77.154.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780322521; cv=none; b=FPlM0cX7phByKlmI0/peA06J7UB6LT6Tey+oHuY7tXwUVetg84HpvS9dP3H8Gu/XGEh7pVqOz8c4j6Ga+W3Z4cDvsSTz50XSyxY6o9SLrBIphd11RbazTMfuLrIbJMW1kwPhJjdlOjQmgIvlpy7mQJ7MgrMpuzt9riWfXtJrcMo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780322521; c=relaxed/simple;
	bh=ah6j4Gj2LOrt7SgWxqwHO3lXkONLbw7YjCRvT9SH714=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ntl68+PZkK7RfUSPgIrlfrE2iWMb/VACcnlioqg0nJAtkEvIR5Q0+prLLt48fQVkUcIzsOXDtvbcNsNLkjO4ydjVHV5UkdbtJMxdo+a0s0YImFU9cPKfIzwNHv+11Eu9F8W2R5cquSUKJvyLOZQ1rnn9ZWkEl1omyhzk10itvnE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com; spf=pass smtp.mailfrom=linux.microsoft.com; dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b=iqQvugAm; arc=none smtp.client-ip=13.77.154.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.microsoft.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b="iqQvugAm"
Received: by linux.microsoft.com (Postfix, from userid 1216)
	id B9FBE20B7166; Mon,  1 Jun 2026 07:01:46 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com B9FBE20B7166
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
	s=default; t=1780322506;
	bh=EcC8oiBSWrZKUG36fS+G6X0zfViyyPCNJtfKczWUozg=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=iqQvugAmtyeiPwjUP+vTRA8RroodNpMYwaeUz9TjyF6j8OPrRuDWHl/uW+MjOK2ta
	 1yFKe88FFz/vDqJquUtDOADt4qn6VkthwM4dJ6sj1afchnVsEBzhLm8rpHrs7JAqTw
	 GBsHJD6dBi5okk1UqzV578yXfx9azvosSv4qZ1rA=
Date: Mon, 1 Jun 2026 10:01:46 -0400
From: Hamza Mahfooz <hamzamahfooz@linux.microsoft.com>
To: Thomas Zimmermann <tzimmermann@suse.de>
Cc: mripard@kernel.org, maarten.lankhorst@linux.intel.com,
	airlied@redhat.com, airlied@gmail.com, simona@ffwll.ch,
	admin@kodeit.net, gargaditya08@proton.me, paul@crapouillou.net,
	jani.nikula@linux.intel.com, mhklinux@outlook.com,
	zack.rusin@broadcom.com, bcm-kernel-feedback-list@broadcom.com,
	dri-devel@lists.freedesktop.org, linux-hyperv@vger.kernel.org,
	intel-gfx@lists.freedesktop.org, intel-xe@lists.freedesktop.org,
	linux-mips@vger.kernel.org, virtualization@lists.linux.dev
Subject: Re: [PATCH v4 07/10] drm/damage-helper: Remove old state from
 drm_atomic_helper_damage_iter_init()
Message-ID: <ah2QyuW9/CUoPy0e@linuxonhyperv3.guj3yctzbm1etfxqx2vob5hsef.xx.internal.cloudapp.net>
References: <20260530185716.65688-1-tzimmermann@suse.de>
 <20260530185716.65688-8-tzimmermann@suse.de>
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260530185716.65688-8-tzimmermann@suse.de>

On Sat, May 30, 2026 at 08:53:20PM +0200, Thomas Zimmermann wrote:
> Nothing in drm_atomic_helper_damage_iter_init() requires the old
> plane state. Remove the parameter and mass-convert callers.
> 
> Most callers now no longer require the old plane state in their plane's
> atomic_update helper. Remove it as well.
> 
> Signed-off-by: Thomas Zimmermann <tzimmermann@suse.de>
> Acked-by: Zack Rusin <zack.rusin@broadcom.com>
> ---

Acked-by: Hamza Mahfooz <hamzamahfooz@linux.microsoft.com> # hyperv
