Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5B38B535A7
	for <virtualization@lists.linux-foundation.org>; Fri,  8 Mar 2024 09:45:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=140.211.166.137
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709891127; cv=none; b=J8kxEALQRp12oEFUjckmw6j/HpYi0+nQ9gCrlbK/vhxxbCoNpJbfZUElXlErwkqGuf6ZzTLZpi7wlgEAyI37nYWJaViSs6CH9FlLOdOY6yYBXrlhTDxLs6xhwnUiAyabjHGyicobChQ1YMMV7h61iR1cZwE8+y9g4dZZWnqNvd4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709891127; c=relaxed/simple;
	bh=9nk/LM8qbXxqqrGQTnt5jKWaF87oDn2J91q3tvQdGAc=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=c1ceFFXhSVV2wz7VRVURPmY/vTVU4ESubeidgQEAXV7X8YatKL7iFH/otxQgoQIcxhQYbvpYseHy3zXx6R+4pstVRQivaRHOKpSYfl6O0+4XJqql3odQEgJ+zx8kiPOejvHY5/n1HdxEiY2FUZThaw8kFClQQen4ynIgW+dDk9U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=leemhuis.info header.i=@leemhuis.info header.b=MyNZGUHa; arc=none smtp.client-ip=140.211.166.137
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=leemhuis.info header.i=@leemhuis.info header.b="MyNZGUHa"
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id F1FEB41932
	for <virtualization@lists.linux-foundation.org>; Fri,  8 Mar 2024 09:45:25 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
X-Spam-Flag: NO
X-Spam-Score: -2.1
X-Spam-Level:
Received: from smtp4.osuosl.org ([127.0.0.1])
	by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id zrBml2Lb7DO8
	for <virtualization@lists.linux-foundation.org>;
	Fri,  8 Mar 2024 09:45:24 +0000 (UTC)
X-Greylist: delayed 2771 seconds by postgrey-1.37 at util1.osuosl.org; Fri, 08 Mar 2024 09:45:24 UTC
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp4.osuosl.org 7E5A3408B5
Authentication-Results: smtp4.osuosl.org; dmarc=none (p=none dis=none) header.from=leemhuis.info
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org 7E5A3408B5
Authentication-Results: smtp4.osuosl.org;
	dkim=pass (2048-bit key, unprotected) header.d=leemhuis.info header.i=@leemhuis.info header.a=rsa-sha256 header.s=he214686 header.b=MyNZGUHa
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=80.237.130.52; helo=wp530.webpack.hosteurope.de; envelope-from=regressions@leemhuis.info; receiver=<UNKNOWN> 
Received: from wp530.webpack.hosteurope.de (wp530.webpack.hosteurope.de [80.237.130.52])
	by smtp4.osuosl.org (Postfix) with ESMTPS id 7E5A3408B5
	for <virtualization@lists.linux-foundation.org>; Fri,  8 Mar 2024 09:45:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=leemhuis.info; s=he214686; h=Content-Transfer-Encoding:Content-Type:
	In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:Message-ID:From:
	Sender:Reply-To:Subject:Date:Message-ID:To:Cc:MIME-Version:Content-Type:
	Content-Transfer-Encoding:Content-ID:Content-Description:In-Reply-To:
	References; bh=9nk/LM8qbXxqqrGQTnt5jKWaF87oDn2J91q3tvQdGAc=; t=1709891124;
	x=1710323124; b=MyNZGUHaAOBLpOuaJV2ItpVsMltJUVnB1OA6MJV2Jk6i9e6Ox4AaiJ3i0BRMr
	SnA+6LswZePwxmnuidv4Bzo4C18YAshiGILxEg7/4NDTWBGiYjCISbDyOupnXon/dd5gBXxuM3TLH
	jOlZ3LyeCo/GH9fSrPmsyhpuXCIk0l3fmpyFxJ9ubdxQupq12WIoCs1XzEfJ0uaxLEQWfqA2IjRKq
	cmqEg+OpN1Ezt9O/puKpr45MPHp1n360CGA/DD86PGTPnBuvZPejfMH0I8hvI1j39fkc4J5u+DQiy
	VSH8+svmsWARNU1n+eluSyUILAMBVWKC5fjGtTgAUj0JpsjS7Q==;
Received: from [2a02:8108:8980:2478:8cde:aa2c:f324:937e]; authenticated
	by wp530.webpack.hosteurope.de running ExIM with esmtpsa (TLS1.3:ECDHE_RSA_AES_128_GCM_SHA256:128)
	id 1riW4D-0001ul-M1; Fri, 08 Mar 2024 09:59:01 +0100
Message-ID: <7c7e363b-ec9b-4b46-a0bf-7ae062d734d1@leemhuis.info>
Date: Fri, 8 Mar 2024 09:58:59 +0100
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/1] drm/qxl: fixes qxl_fence_wait
Content-Language: en-US, de-DE
To: Alex Constantino <dreaming.about.electric.sheep@gmail.com>
Cc: 1054514@bugs.debian.org, airlied@redhat.com, carnil@debian.org,
 daniel@ffwll.ch, dri-devel@lists.freedesktop.org, kraxel@redhat.com,
 linux-kernel@vger.kernel.org, regressions@lists.linux.dev,
 spice-devel@lists.freedesktop.org, timo.lindfors@iki.fi,
 tzimmermann@suse.de, virtualization@lists.linux-foundation.org
References: <fb0fda6a-3750-4e1b-893f-97a3e402b9af@leemhuis.info>
 <20240308010851.17104-1-dreaming.about.electric.sheep@gmail.com>
 <20240308010851.17104-2-dreaming.about.electric.sheep@gmail.com>
From: Thorsten Leemhuis <regressions@leemhuis.info>
In-Reply-To: <20240308010851.17104-2-dreaming.about.electric.sheep@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-bounce-key: webpack.hosteurope.de;regressions@leemhuis.info;1709891124;025a823d;
X-HE-SMSGID: 1riW4D-0001ul-M1

On 08.03.24 02:08, Alex Constantino wrote:
> Fix OOM scenario by doing multiple notifications to the OOM handler through
> a busy wait logic.
> Changes from commit 5a838e5d5825 ("drm/qxl: simplify qxl_fence_wait") would
> result in a '[TTM] Buffer eviction failed' exception whenever it reached a
> timeout.

Thx for working on this.

> Fixes: 5a838e5d5825 ("drm/qxl: simplify qxl_fence_wait")
> Link: https://lore.kernel.org/regressions/fb0fda6a-3750-4e1b-893f-97a3e402b9af@leemhuis.info

Nitpicking: that ideally should be pointing to
https://lore.kernel.org/regressions/ZTgydqRlK6WX_b29@eldamar.lan/ , as
that the report and not just a reply to prod things.

Ciao, Thorsten
