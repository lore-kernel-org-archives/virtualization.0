Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0EA4C1917EB
	for <virtualization@lists.linux-foundation.org>; Tue, 30 Jul 2024 22:30:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=140.211.166.137
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722378602; cv=none; b=AGW5KzFzX1+Jd2R1JWykVFtRcJbl5VB4jf7gZTynIaOXSY4wVElkDS0FEUcFINshsD95wBk80r6T8Ty+h1WSNkCJHYizgdmlSCVvLU77UUuVxtEVC9INIqmPqbFD4lTMa5S8IKz0DJlbaLBGrxtuCIGo5T5/+qEQhBfXw2a7lmU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722378602; c=relaxed/simple;
	bh=iXwmhYCCcyRDw2DJIPfqL2B2J9LqKdHICiKlj40dCDM=;
	h=Date:From:To:cc:Subject:In-Reply-To:Message-ID:References:
	 MIME-Version:Content-Type; b=CkMZQgyGZW1wWQ0LyWtu4niXWbw7Q4Xz6A5GQeIsT7YHElSY262yuaBvuUE+LF47TXNG/j8W61ZnJxFrSCzIiTSwklur453wfutzb+vgC3Sov5uK2tw4LeM3WjOwEknXt6ORYlAwfZEb4UYLDNePupf7+HcfgeP2TWPLY2SzEj0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=VsnXh0cI; arc=none smtp.client-ip=140.211.166.137
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="VsnXh0cI"
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 91B164066E;
	Tue, 30 Jul 2024 22:30:00 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
X-Spam-Flag: NO
X-Spam-Score: -4.401
X-Spam-Level:
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id jOPe-WjPXp6O; Tue, 30 Jul 2024 22:29:59 +0000 (UTC)
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=2604:1380:4641:c500::1; helo=dfw.source.kernel.org; envelope-from=sstabellini@kernel.org; receiver=<UNKNOWN> 
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp4.osuosl.org 60D124066B
Authentication-Results: smtp4.osuosl.org; dmarc=pass (p=none dis=none) header.from=kernel.org
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org 60D124066B
Authentication-Results: smtp4.osuosl.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20201202 header.b=VsnXh0cI
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
	by smtp4.osuosl.org (Postfix) with ESMTPS id 60D124066B;
	Tue, 30 Jul 2024 22:29:58 +0000 (UTC)
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by dfw.source.kernel.org (Postfix) with ESMTP id AD36B62114;
	Tue, 30 Jul 2024 22:29:57 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 733B4C32782;
	Tue, 30 Jul 2024 22:29:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1722378597;
	bh=iXwmhYCCcyRDw2DJIPfqL2B2J9LqKdHICiKlj40dCDM=;
	h=Date:From:To:cc:Subject:In-Reply-To:References:From;
	b=VsnXh0cIy6MwRgYVov2Hu44Q4Oy3vb1WSweVdDxDaI97QumUZaMY8yvnIJ4nu3tdK
	 Qcah3xymNH1R6+gerYm9S2QtrUOH9w2EPp3hX0mLAcrTv5LEGF06PE/2BiHqakmqgR
	 oFfBFMVKfzS3GviRUTLV1g7i4AMqQMSgAGsE0gCWdxZwVJT1BJQ4CU6OrJlLpKoTbZ
	 YR95RfkHdzuAGmUh+mbn1vlQ5MkgdYiO0M0uz/m/fPVLkT/gzSGlgR5r/ymXcsHq3Y
	 bQv0u7POqU54AT+PkRoxBl5UNZ55ocumaEAdfM1yzfaMR+zvEkGgVAgyBp/NOH3BAB
	 vNr9zJ9isCXKg==
Date: Tue, 30 Jul 2024 15:29:54 -0700 (PDT)
From: Stefano Stabellini <sstabellini@kernel.org>
X-X-Sender: sstabellini@ubuntu-linux-20-04-desktop
To: Amneesh Singh <a-singh21@ti.com>, mst@redhat.com
cc: sstabellini@kernel.org, boris.ostrovsky@oracle.com, hch@infradead.org, 
    iommu@lists.linux-foundation.org, jasowang@redhat.com, jgross@suse.com, 
    konrad.wilk@oracle.com, linux-arm-kernel@lists.infradead.org, 
    linux-imx@nxp.com, linux-kernel@vger.kernel.org, peng.fan@nxp.com, 
    virtualization@lists.linux-foundation.org, x86@kernel.org, 
    xen-devel@lists.xenproject.org
Subject: Re: [PATCH] xen: introduce xen_vring_use_dma
In-Reply-To: <20240730105910.443753-1-a-singh21@ti.com>
Message-ID: <alpine.DEB.2.22.394.2407301519330.4857@ubuntu-linux-20-04-desktop>
References: <alpine.DEB.2.21.2007151001140.4124@sstabellini-ThinkPad-T480s> <20240730105910.443753-1-a-singh21@ti.com>
User-Agent: Alpine 2.22 (DEB 394 2020-01-19)
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII

On Tue, 30 Jul 2024, Amneesh Singh wrote:
> Hi Stefano,
> 
> First off, apologies for bumping this dead thread.
> 
> I came across this patch signed off by you recently
> https://github.com/Xilinx/linux-xlnx/commit/72cb5514953be3aa2ac00c57c9eaa100ecc67176
> 
> and was wondering if a patch replacing xen_domain() with xen_pv_domain() in
> vring_use_dma_api() can be sent upstream? If not, is there a reason why?

Hi Amneesh,

Yes this patch is still required for Xen on ARM and it fixes a real bug.
Unfortunately the upstreaming process stalled so we had to keep the fix
in our Xilinx Linux branch. Here is the link to the start of this
conversation and to the last message:

https://marc.info/?i=20200624091732.23944-1-peng.fan%40nxp.com
https://marc.info/?i=alpine.DEB.2.21.2007151001140.4124%40sstabellini-ThinkPad-T480s


Hi Michael, I see you are CCed to this email. Would you be open to
acking this patch now that a 3rd independent engineer from a different
company (NXP first, then AMD/Xilinx, now TI) has reported this as a bug
fix?


