Received: from wp530.webpack.hosteurope.de (wp530.webpack.hosteurope.de [80.237.130.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CC28C381C4;
	Tue,  7 May 2024 05:04:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=80.237.130.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715058269; cv=none; b=iV+86h0z+VBH6BNEnMwcelL9rG+MxHXr/bV7VDJJBAwc2IEB5ZmlFLk/jeJyxT9EV5fdf/cipkfTJK+EvTu1Os2yFf7S/gg07d6yP67F1hkDOquJTZBbvWIUSlYobl+hrYjvjOWYK1fOGk9CfpmEgE0GOpWxUru0k6hADbs2NUI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715058269; c=relaxed/simple;
	bh=24/H3T0QFclFVrI+hVG7Y+bOQKXkotNmMck/gaj7A74=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=J0CP4ObmQP2Dw+JMRmycMSI6JBJ2AzNvsQLQb9ng0ZG1MazmgG6LHuioYR1NdL1uBKl1oMMQ/Jy2bV+Ncb10sEay8jW8c/bI3aCqHeU3RGtzOkoV7LR6wH2TD+GLiIZG8aIxLZZqyiBSg+6WF/JMiMcIkCwqyREGpnB802YJvU0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=leemhuis.info; spf=pass smtp.mailfrom=leemhuis.info; dkim=pass (2048-bit key) header.d=leemhuis.info header.i=@leemhuis.info header.b=DVuSshs1; arc=none smtp.client-ip=80.237.130.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=leemhuis.info
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=leemhuis.info
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=leemhuis.info header.i=@leemhuis.info header.b="DVuSshs1"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=leemhuis.info; s=he214686; h=Content-Transfer-Encoding:Content-Type:
	In-Reply-To:Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:From:Sender:Reply-To:Subject:Date:Message-ID:To:Cc:MIME-Version:
	Content-Type:Content-Transfer-Encoding:Content-ID:Content-Description:
	In-Reply-To:References; bh=24/H3T0QFclFVrI+hVG7Y+bOQKXkotNmMck/gaj7A74=;
	t=1715058267; x=1715490267; b=DVuSshs17wvNBWeF1Lo4UfS7W6KhJ6wnMgsVkM1cYkgIGDr
	MiEPi/ucslq8vW7/r2l4GB8ssYWjGvRwOrhy3+S+nZkUPdvjjpb7zaTz8xrOEi7nmxQuPRyjWqGq2
	HPUyh4UxsVpWd1XOsvR3HlUtX8a+f5wLci/SzIwe9S6OqMSpOLSvU69XSwiRyGanx3VxzTwfDwJLu
	v3VA2D8UlvGz1s/Mi5vlRkrVq6zP+1Psx0q+IrlZ80Q304gSBp1BfaNkiFW5CTKKAYXtZlgc3eAnw
	Fezo992YUNJWTjBm0naHddpyfgNmbQoWHDQ2TSPp55LhayCiE9g+mS/k2iAtdsQw==;
Received: from [2a02:8108:8980:2478:8cde:aa2c:f324:937e]; authenticated
	by wp530.webpack.hosteurope.de running ExIM with esmtpsa (TLS1.3:ECDHE_RSA_AES_128_GCM_SHA256:128)
	id 1s4Czw-0004Fn-6H; Tue, 07 May 2024 07:04:16 +0200
Message-ID: <ac41c761-27c9-48c3-bd80-d94d4db291e8@leemhuis.info>
Date: Tue, 7 May 2024 07:04:14 +0200
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [Regression] 6.9.0: WARNING: workqueue: WQ_MEM_RECLAIM
 ttm:ttm_bo_delayed_delete [ttm] is flushing !WQ_MEM_RECLAIM
 events:qxl_gc_work [qxl]
To: David Wang <00107082@163.com>
Cc: airlied@gmail.com, airlied@redhat.com, daniel@ffwll.ch,
 dreaming.about.electric.sheep@gmail.com, dri-devel@lists.freedesktop.org,
 kraxel@redhat.com, linux-kernel@vger.kernel.org,
 maarten.lankhorst@linux.intel.com, mripard@kernel.org,
 regressions@lists.linux.dev, spice-devel@lists.freedesktop.org,
 tzimmermann@suse.de, virtualization@lists.linux.dev
References: <20240430061337.764633-1-00107082@163.com>
 <20240506143003.4855-1-00107082@163.com>
From: "Linux regression tracking (Thorsten Leemhuis)"
 <regressions@leemhuis.info>
Content-Language: en-US, de-DE
Reply-To: Linux regressions mailing list <regressions@lists.linux.dev>
In-Reply-To: <20240506143003.4855-1-00107082@163.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-bounce-key: webpack.hosteurope.de;regressions@leemhuis.info;1715058267;3db3413f;
X-HE-SMSGID: 1s4Czw-0004Fn-6H



On 06.05.24 16:30, David Wang wrote:
>> On 30.04.24 08:13, David Wang wrote:

>> And confirmed that the warning is caused by
>> 07ed11afb68d94eadd4ffc082b97c2331307c5ea and reverting it can fix.
>
> The kernel warning still shows up in 6.9.0-rc7.
> (I think 4 high load processes on a 2-Core VM could easily trigger the kernel warning.)

Thx for the report. Linus just reverted the commit 07ed11afb68 you
mentioned in your initial mail (I put that quote in again, see above):

3628e0383dd349 ("Reapply "drm/qxl: simplify qxl_fence_wait"")
https://git.kernel.org/torvalds/c/3628e0383dd349f02f882e612ab6184e4bb3dc10

So this hopefully should be history now.

Ciao, Thorsten
