Received: from r3-11.sinamail.sina.com.cn (r3-11.sinamail.sina.com.cn [202.108.3.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 52B582C21D0
	for <virtualization@lists.linux.dev>; Wed, 14 Oct 2026 01:41:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.108.3.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791942098; cv=none; b=I6WV9m1tauk0ZoKn/xshmTueHhVUp4//gx/qCV6bieIkKDzjxZ6McX1lxVeVadbleedEs6RjclrY2jIIOlwB22x1GLT8mCtDn+mr5I9DpgeD0FiC5JsiknJM+/3eoxuycTQqhg18KC6haqG1UuGpUikjibZ6fHSUbzrRczn6hSo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791942098; c=relaxed/simple;
	bh=bCaUzIelB9WpZwF/pwMwTNqan3Z0wPcZ2evd+e1nY4E=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=KYDOlTd8kg85Y1MYSHOmogssbTEgtQBQrbB3cCV3LqUy3LYk0pTYjotl1z2m5e/MlhaibF7AIh0SaWzsw220hvrtfpdciHCw+rbm4Gq23EIk2OJZoikP7DHyLysRvYclWnJ31TwENzOuAGEw0ea2ioKFbch4uU43SFIpXHO1b5Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sina.com; spf=pass smtp.mailfrom=sina.com; dkim=pass (1024-bit key) header.d=sina.com header.i=@sina.com header.b=JbzSKmni; arc=none smtp.client-ip=202.108.3.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sina.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sina.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=sina.com header.i=@sina.com header.b="JbzSKmni"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=sina.com; s=201208; t=1791942094;
	bh=Gukd+7qBDkCL0LwJkx1bGcwYtROGaDWytHz0r2JFleE=;
	h=From:Subject:Date:Message-ID;
	b=JbzSKmniJVAA9CnbW+dTXOK6MSIOaz03h3PuzPjG6QBj4CBto4wJiDOjG+b4HOAAh
	 EKq1abq/gLIJCOMMG9j2RhEvEEWjTaQluWEf22NyGeIlaCmpcdkqXPEP0Dsgzmf0lY
	 q/cxqba5XjGV/4Sn/+03cFMSCV3rnWWpX5/OZyWY=
X-SMAIL-HELO: localhost.localdomain
Received: from unknown (HELO localhost.localdomain)([114.249.62.194])
	by sina.com (10.54.253.34) with ESMTP
	id 6ACEDDC100004107; Wed, 14 Oct 2026 09:41:25 +0800 (CST)
X-Sender: hdanton@sina.com
X-Auth-ID: hdanton@sina.com
Authentication-Results: sina.com;
	 spf=none smtp.mailfrom=hdanton@sina.com;
	 dkim=none header.i=none;
	 dmarc=none action=none header.from=hdanton@sina.com
X-SMAIL-MID: 3659906291904
X-SMAIL-UIID: 3E8AF85D807741DB8AE66A308ECF1F7E-20261014-094125-1
From: Hillf Danton <hdanton@sina.com>
To: Dmitry Osipenko <dmitry.osipenko@collabora.com>
Cc: David Airlie <airlied@redhat.com>,
	Gerd Hoffmann <kraxel@redhat.com>,
	Gurchetan Singh <gurchetansingh@chromium.org>,
	Thomas Zimmermann <tzimmermann@suse.de>,
	Nguyen Ngoc Thang <ngocthang2710.1999@gmail.com>,
	linux-kernel@vger.kernel.org,
	syzbot+1b129b44597a126d2d79@syzkaller.appspotmail.com,
	dri-devel@lists.freedesktop.org,
	virtualization@lists.linux.dev
Subject: Re: [PATCH] drm/virtio: share one vbuf cache across all devices
Date: Wed, 14 Oct 2026 09:41:10 +0800
Message-ID: <20261014014112.515-1-hdanton@sina.com>
In-Reply-To: <bf25fc38-95d7-4cb5-b0ee-6afe1488e5e7@collabora.com>
References: 
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

On Fri, 9 Oct 2026 20:39:54 +0300 Dmitry Osipenko wrote:
>27.09.2026 07:09, Nguyen Ngoc Thang пишет:
>> On Sun, 27 Sep 2026, Hillf Danton wrote:
>>> What is unclear -- why is kmalloc failing to work in 2026?
>> 
>> kmalloc isn't failing. The failure is in kmem_cache_create(): the driver
>> creates a dedicated cache with a fixed global name for each device, so a
>> second probe while the first drm_device is still alive (release is
>> deferred by an open /dev/fbN) trips the duplicate-name check.
>> 
>> Your question made me look at whether the dedicated cache is needed at all.
>> A vbuf is sizeof(struct virtio_gpu_vbuffer) + 96 + 24 = 216 bytes, which
>> lands in kmalloc-256 anyway, so the cache buys nothing over kzalloc()/kfree().
>> Dropping it also removes the lifetime problem entirely and needs no
>> module-level state.
>> 
>> I'll send a v2 that switches the kmem_cache_zalloc() calls and
>> kmem_cache_free() to kzalloc()/kfree() and deletes the cache setup and
>> teardown.
>> 
>> Thanks,
>> Nguyen Ngoc Thang
>
> kmem_cache is used by GPU drivers to avoid kmalloc stalls in a
> latency-sensitive job-submission code path.
>
This makes no sense before showing the stall, given my failure of locating
the lore page where the tglx dude was taught a few years back (by Mathew
Wilcox?) that the percpu page is faster that thought.
