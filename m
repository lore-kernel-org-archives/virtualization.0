Received: from sender6-op-o11.zoho.com (sender6-op-o11.zoho.com [165.173.180.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 76C5F3B5F5D
	for <virtualization@lists.linux.dev>; Fri,  9 Oct 2026 17:40:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=165.173.180.11
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791567609; cv=pass; b=OBr2f8HReg5S0tCltx1djw/kUGvuwT/2BVIR+z8PkjMsbiEof938UzChqz613FACaPxGtz/WramNP9MAAFUHbMQL6HLEyGrzqXXlG/wTz87/h7HkNWDKIKKlUtu/TR65ipkLMDfw30xBFl9xdGo2UVrhHF9l9t/lqL5aCjzcEYc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791567609; c=relaxed/simple;
	bh=tTdETWehUdf3mm92X+P34MK2XxnJziK39cJr67gku28=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=nzFW0wvXDsfq1oSN3X7SKgnsfcGvnYkV1yKG3aeKCCZqPh7pLYbOa9a4NyOvvldej1rM+xTD+hjaSwIfB8ppp3fO51bbJk77g8GipDskFUQb55MLLquTt3oR5CIwn+pBCM5IuymkmtbF1DxZL0sDuVYw2plNmYNz8rZPZnIY4Xs=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (1024-bit key) header.d=collabora.com header.i=dmitry.osipenko@collabora.com header.b=HADyDoHe; arc=pass smtp.client-ip=165.173.180.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=collabora.com header.i=dmitry.osipenko@collabora.com header.b="HADyDoHe"
ARC-Seal: i=1; a=rsa-sha256; t=1791567601; cv=none; 
	d=zohomail.com; s=zohoarc; 
	b=YbFIjIUzpXDBuujkYUL/AOBDcvYaNW1Qtaai/qPI7+V9PeG6h9pNLsD6tQAuOAzbLm/ew8qXRJ/azqOdcHXjMBHTEoe/VsTYP5GCkwZJJUyvoeiKIE+OhvPZ5d6TAV7qrRtPLyOvJ5f/CMHP+9ZCMVjD0BLeRtJ+Ze5zfETblaw=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com; s=zohoarc; 
	t=1791567601; h=Content-Type:Content-Transfer-Encoding:Cc:Cc:Date:Date:From:From:In-Reply-To:MIME-Version:Message-ID:Subject:Subject:To:To:Message-Id:Reply-To; 
	bh=q37dDx8QDacAUOm7BGUBoeF+NDXNcQ2RJoiSumQlbLA=; 
	b=O27cpX7ILmp95fpdRZP9Q1TR9TNYdj6q7HILAQ6yWJgx9TfukpCCQWcT6GKrwDNSH1MP2JWsJiacGvBIIyS95660kgFPSGjS0JRkFLMMFfYa7kXBLC7NG+9MQZUZtGGv2IBpMFANumbfieoMzH0wfaX59DwZe3kgCMzxvZXUUUU=
ARC-Authentication-Results: i=1; mx.zohomail.com;
	dkim=pass  header.i=collabora.com;
	spf=pass  smtp.mailfrom=dmitry.osipenko@collabora.com;
	dmarc=pass header.from=<dmitry.osipenko@collabora.com>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1791567601;
	s=zohomail; d=collabora.com; i=dmitry.osipenko@collabora.com;
	h=Message-ID:Date:Date:MIME-Version:Subject:Subject:To:To:Cc:Cc:From:From:In-Reply-To:Content-Type:Content-Transfer-Encoding:Message-Id:Reply-To;
	bh=q37dDx8QDacAUOm7BGUBoeF+NDXNcQ2RJoiSumQlbLA=;
	b=HADyDoHeyFYtYzS4Tz3GeY07DcOmmK7qp4VekX0o60zbeKI/4uGQccayH8vbdY16
	XGisKIQBgzADLuElgCNbFA4sNwcshok2rN6oWH3xJo2E8IoPmJ1QP0ayUA9jATMkwmE
	ywgOJs/iAibNLOkcODni7AgWO5K5xqbGTwEZYneo=
Received: by smtp.zohomail.com with SMTPS id 1791567599341604.3808848113907;
	Fri, 9 Oct 2026 10:39:59 -0700 (PDT)
Message-ID: <bf25fc38-95d7-4cb5-b0ee-6afe1488e5e7@collabora.com>
Date: Fri, 9 Oct 2026 20:39:54 +0300
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] drm/virtio: share one vbuf cache across all devices
To: Nguyen Ngoc Thang <ngocthang2710.1999@gmail.com>,
 Hillf Danton <hdanton@sina.com>
Cc: David Airlie <airlied@redhat.com>, Gerd Hoffmann <kraxel@redhat.com>,
 Gurchetan Singh <gurchetansingh@chromium.org>,
 Thomas Zimmermann <tzimmermann@suse.de>, linux-kernel@vger.kernel.org,
 syzbot+1b129b44597a126d2d79@syzkaller.appspotmail.com,
 dri-devel@lists.freedesktop.org, virtualization@lists.linux.dev
References: <20260927000323.299-1-hdanton@sina.com>
 <20260927040911.15181-1-ngocthang2710.1999@gmail.com>
Content-Language: en-US
From: Dmitry Osipenko <dmitry.osipenko@collabora.com>
In-Reply-To: <20260927040911.15181-1-ngocthang2710.1999@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ZohoMailClient: External

27.09.2026 07:09, Nguyen Ngoc Thang пишет:
> On Sun, 27 Sep 2026, Hillf Danton wrote:
>> What is unclear -- why is kmalloc failing to work in 2026?
> 
> kmalloc isn't failing. The failure is in kmem_cache_create(): the driver
> creates a dedicated cache with a fixed global name for each device, so a
> second probe while the first drm_device is still alive (release is
> deferred by an open /dev/fbN) trips the duplicate-name check.
> 
> Your question made me look at whether the dedicated cache is needed at all.
> A vbuf is sizeof(struct virtio_gpu_vbuffer) + 96 + 24 = 216 bytes, which
> lands in kmalloc-256 anyway, so the cache buys nothing over kzalloc()/kfree().
> Dropping it also removes the lifetime problem entirely and needs no
> module-level state.
> 
> I'll send a v2 that switches the kmem_cache_zalloc() calls and
> kmem_cache_free() to kzalloc()/kfree() and deletes the cache setup and
> teardown.
> 
> Thanks,
> Nguyen Ngoc Thang

kmem_cache is used by GPU drivers to avoid kmalloc stalls in a
latency-sensitive job-submission code path.

The /dev/fb reference doesn't sound right as normally removal of
framebuffers is required before GPU driver can be unbound. Such bug
reports should be treated as invalid, BTW [1].

Assume the similar "duplicated" kmemcache problem should exists if there
is more than one virtio-gpu device in a system. I suggest you to
validate this case and if it has the problem, might be better to make
kmemcache's static instead of creating dynamically.

[1] https://www.phoronix.com/news/Linux-Taint-Forced-Bind

-- 
Best regards,
Dmitry
