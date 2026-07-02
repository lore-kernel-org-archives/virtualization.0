Received: from smtp153-170.sina.com.cn (smtp153-170.sina.com.cn [61.135.153.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C88CF428481
	for <virtualization@lists.linux.dev>; Thu,  2 Jul 2026 08:25:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=61.135.153.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782980748; cv=none; b=L4+bRLGzCPtTWvpt0loKKUt+bPWEMtKnbVG24dQDUXuAnvsJA+QxPj+LI+mqTE3y47YLoG6V8Gm2GTgxzk6a5/Bs+L7KU5keXVg1HH8ewlXAq/W6KxOlKK3nnnzuToJ/iNfFVb5vct/wWAGytId7x2QITRNjE/+4HAS9xuc+mCg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782980748; c=relaxed/simple;
	bh=0fBVFYhoXHBhPHsgcDW2xSKL08hn962Bxe+a+G3t8Tw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Xa6gZXv7fp4M+Uq0AX8rZ5y0sak5ErNDNcL8TT6TqWICAdg13soFuhJMqtvjnVWiZv2H3ikBfDpLAi02yq8WI8omXGDPI+w0BGv/OsT68g2/VuCz8z4kEwbhg1JxLghmawJNtlxXnod+/fdjDq29+vE/AkjC0nh2hnGVc3jPSBM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sina.com; spf=pass smtp.mailfrom=sina.com; dkim=pass (1024-bit key) header.d=sina.com header.i=@sina.com header.b=iGQTjBkX; arc=none smtp.client-ip=61.135.153.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sina.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sina.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=sina.com header.i=@sina.com header.b="iGQTjBkX"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=sina.com; s=201208; t=1782980740;
	bh=dmmoJgg+0zg52YaXd3a/e/RT6muwcoryyA80mm/IHAU=;
	h=From:Subject:Date:Message-ID;
	b=iGQTjBkX46e57djVz/8sltvAki3qqPUwnSrymZvwq6wYDCKLp9AgqX2B/z+APbTcd
	 T1JGiSM01wwwqZ0gm+I9wzxNAkbKEd7tH2s6GKNdozx5yPp/ZM3SJuCaGhiFkeggvf
	 WzISo6MdX6hCcg0FkK8B5XcrgIt+lDQgw4kQAYDY=
X-SMAIL-HELO: localhost.localdomain
Received: from unknown (HELO localhost.localdomain)([114.249.62.144])
	by sina.com (10.54.253.34) with ESMTP
	id 6A4620780000166B; Thu, 2 Jul 2026 16:25:30 +0800 (CST)
X-Sender: hdanton@sina.com
X-Auth-ID: hdanton@sina.com
Authentication-Results: sina.com;
	 spf=none smtp.mailfrom=hdanton@sina.com;
	 dkim=none header.i=none;
	 dmarc=none action=none header.from=hdanton@sina.com
X-SMAIL-MID: 9223576291952
X-SMAIL-UIID: 05424C4F371B4537B8CFE6310E47270C-20260702-162530-1
From: Hillf Danton <hdanton@sina.com>
To: "Ryosuke Yasuoka" <ryasuoka@redhat.com>
Cc: "Dmitry Osipenko" <dmitry.osipenko@collabora.com>,
	"Dmitry Baryshkov" <lumag@kernel.org>,
	"Javier Martinez Canillas" <javierm@redhat.com>,
	dri-devel@lists.freedesktop.org,
	virtualization@lists.linux.dev,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH] drm/virtio: defer hotplug event from dequeue worker to avoid deadlock
Date: Thu,  2 Jul 2026 16:25:16 +0800
Message-ID: <20260702082517.380-1-hdanton@sina.com>
In-Reply-To: <18be678e97322160.8f56a0770e5621ab.8d175eba8a62d6be@ryasuoka-thinkpadx1carbongen9.tokyo.csb>
References: 
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

On Thu, 2 Jul 2026 07:12:44 +0000 Ryosuke Yasuoka wrote:
>On 02/07/2026 07:43, Hillf Danton wrote:
>> On Wed, 1 Jul 2026 09:23:05 +0000 Ryosuke Yasuoka wrote:
>>>On 30/06/2026 16:46, Dmitry Osipenko wrote:
>>>> Could you please move drm_kms_helper_hotplug_event() to virtio_gpu_init(),
>>>> placing it after wait_event_timeout(display_info_pending)? This will avoid
>>>> additional work_struct that otherwise needs to be cancelled in
>>>> virtio_gpu_init() on the timeout.
>>>
>>>IIUC, moving the drm_kms_helper_hotplug_event() and _hpd_irq_event()
>>>into virtio_gpu_init() after wait_event_timeout() would not prevent the
>>>issue.
>>>
>>>Looking at the syzbot call traces[1][2], the deadlock occurs during
>>>drm_client_setup(), which runs after virtio_gpu_init() has already
>>>returned. The display_info_cb that triggers the deadlock is called from
>>>the dequeue worker while drm_client_register() holds clientlist_mutex.
>>>
>>>Thread A:
>>>virtio_gpu_probe()
>>> -> virtio_gpu_init()   // sends GET_DISPLAY_INFO and waits up to 5s
>>> -> drm_dev_register()
>>> -> drm_client_setup()   // deadlock happens HERE
>>>     -> drm_client_register()   // holds clientlist_mutex
>>>     ...
>>>     -> virtio_gpu_queue_fenced_ctrl_buffer()
>>>         -> wait_event() // waits for free space
>>>
>>>Thread B:
>>>virtio_gpu_dequeue_ctrl_func()
>>> -> reclaim_vbufs()   // make free space
>> 
>> I wonder if the deadlock could be cured by alternatively adding a wakeup
>> before the responce cb, given that free space is available.
>
>Thanks for your comment. I agree that moving wake_up() before response
>cb would help in most cases, and I think it is a reasonable aproach.
>However, there are a few rare scenarios where the deadlock can still
>occur:
>
>1. If reclaim_vbufs() does not free enough slots to satisfy
>num_free >= elemcnt, wake_up() fires but the wait_event() condition
>evaluates false. Thread A remains asleep holding clientlist_mutex, and
>the dequeue worker proceeds to display_info_cb which blocks on
>clientlist_mutex.

	task0		task1
	lock clientlist_mutex
	wait_event(for enough free slots)

			free some slots
			lock clientlist_mutex
			unlock clientlist_mutex
			wakeup
	deadlock

The clientlist_mutex will not be released without enough slots freed, so more
free slots and wakeup are needed to cure the deadlock, with nothing to do with
acquiring the mutex in the workqueue context.

Your workqueue approach works by removing the dependence of wakeup on acquiring
the mutex, without enough free slots guaranteed.

In short, wakeup before acquiring the mutex is the right thing to do, I mean
it is not the only one at all.

>2. Even if enough slots are freed, there is a small window between
>wait_event() returning and Thread A acquiring spin_lock(&qlock) at the
>"goto again" path in virtio_gpu_queue_ctrl_sgs(). Another thread can
>consume the freed slots during this window, causing Thread A to loop 
>back to wait_event() still holding clientlist_mutex.

Ditto

>3. Reordering wake_up() before resp_cb inverts the natural "process
>response, then signal completion" pattern, which could introduce subtle
>issues if a future resp_cb depends on side effects that should happen
>after wake_up(), I believe.
>
Different taste

>These scenarios are likely rare in practice, but the schedule_work()
>approach avoids all of them entirely by ensuring the dequeue worker
>never touches clientlist_mutex. It also follows the same pattern
>already used by config_changed_work in this driver.
>
>Best regards
>Ryosuke
>
>> 
>>> -> resp_cb()
>>>     -> virtio_gpu_cmd_get_display_info_cb
>>>         -> drm_helper_hpd_irq_event()
>>>         -> drm_kms_helper_hotplug_event()
>>>             -> drm_client_dev_hotplug() // need to lock clientlist_mutex
>>> -> wake_up()   // never reached
>>>
>>>IIUC the hotplug notification in display_info_cb is needed because it
>>>notifies DRM after updating by the callback with fresh data from the host.
>>>
>>>This work_struct ensures display_info_cb never blocks on
>>>clientlist_mutex in the dequeue worker, while preserving the hotplug
>>>notification with fresh data.
>>>
>>>[1] https://syzkaller.appspot.com/bug?id=d6dd6f86d3aaf7eebe7406e45c1c6e549453f224
>>>[2] https://syzkaller.appspot.com/bug?id=908bd910da5dd79b88de4cf7baf376cc873a922e
>>>
>>>Best regards,
>>>Ryosuke
