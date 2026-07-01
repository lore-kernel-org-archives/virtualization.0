Received: from mail3-164.sinamail.sina.com.cn (mail3-164.sinamail.sina.com.cn [202.108.3.164])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D2DCE3CF02B
	for <virtualization@lists.linux.dev>; Wed,  1 Jul 2026 23:45:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.108.3.164
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782949548; cv=none; b=ZEN4y606DyZc1OZ4gvkEzguIXd4emYsu/KLwJ8kB3lQgxDs4l3BUMFWFYkRs1IkyuLLDxJvQ7omzuoXnXJloZ4FBS7QfyyKUlpKKiyV1aVi9vpBDZV6a9k1j31gPipv/tvdu6gb++v/8Qx+qTeyNcnDKNqc27f5YW1PeRYf3LgQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782949548; c=relaxed/simple;
	bh=yCY1ZQ4+Oy4DwpOkJs5s9wVPlWFSgUreezLQhSyNDb4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=hSEfoUG3nHHSCOytw3TobNDdj5EU4v82I0MsODn5aODaJEhSUDODLDRv7JAeT6lJzWINKS6LmoeqoaiRj02rO99iEPvdt3NHu2it2McuXUDd2bUgt8oW8wMF64kMtBxoGmPaNGVc7iHpZyPN1Eb9W1K7eWLQNlRHPbQjJjrt1eU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sina.com; spf=pass smtp.mailfrom=sina.com; dkim=pass (1024-bit key) header.d=sina.com header.i=@sina.com header.b=scNntZUO; arc=none smtp.client-ip=202.108.3.164
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sina.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sina.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=sina.com header.i=@sina.com header.b="scNntZUO"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=sina.com; s=201208; t=1782949544;
	bh=xQ23ltzGIx0al3TzodxktcL0AEOqsC47kRrB7dugiMI=;
	h=From:Subject:Date:Message-ID;
	b=scNntZUOYAvW4HU/7qpjqHmHZVBzOd3PkqxzhJd0b2dxFHe85iwVwItSxmA6CxcWd
	 ZbPBIQYZe4KH4D7Xga7FGGTUDtBptHjJ7KyG34mGR4SBOcaS8P4e/tJyLD1kLnSOn/
	 rQP3/A/HMclBlDrFgh/Gerzyi4qErz6/aptppOk0=
X-SMAIL-HELO: localhost.localdomain
Received: from unknown (HELO localhost.localdomain)([114.249.62.144])
	by sina.com (10.54.253.32) with ESMTP
	id 6A45A60F00003880; Wed, 2 Jul 2026 07:43:14 +0800 (CST)
X-Sender: hdanton@sina.com
X-Auth-ID: hdanton@sina.com
Authentication-Results: sina.com;
	 spf=none smtp.mailfrom=hdanton@sina.com;
	 dkim=none header.i=none;
	 dmarc=none action=none header.from=hdanton@sina.com
X-SMAIL-MID: 6550824456920
X-SMAIL-UIID: DBFA2DA1DDDE481C94AB2F6835CD65D8-20260702-074314-1
From: Hillf Danton <hdanton@sina.com>
To: Ryosuke Yasuoka <ryasuoka@redhat.com>
Cc: Dmitry Osipenko <dmitry.osipenko@collabora.com>,
	Dmitry Baryshkov <lumag@kernel.org>,
	Javier Martinez Canillas <javierm@redhat.com>,
	dri-devel@lists.freedesktop.org,
	virtualization@lists.linux.dev,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH] drm/virtio: defer hotplug event from dequeue worker to avoid deadlock
Date: Thu,  2 Jul 2026 07:43:00 +0800
Message-ID: <20260701234301.361-1-hdanton@sina.com>
In-Reply-To: <18be2016e26ade27.a6e9e2496bc1f978.9bc3a62421115997@ryasuoka-thinkpadx1carbongen9.tokyo.csb>
References: 
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

On Wed, 1 Jul 2026 09:23:05 +0000 Ryosuke Yasuoka wrote:
>On 30/06/2026 16:46, Dmitry Osipenko wrote:
>> Could you please move drm_kms_helper_hotplug_event() to virtio_gpu_init(),
>> placing it after wait_event_timeout(display_info_pending)? This will avoid
>> additional work_struct that otherwise needs to be cancelled in
>> virtio_gpu_init() on the timeout.
>
>IIUC, moving the drm_kms_helper_hotplug_event() and _hpd_irq_event()
>into virtio_gpu_init() after wait_event_timeout() would not prevent the
>issue.
>
>Looking at the syzbot call traces[1][2], the deadlock occurs during
>drm_client_setup(), which runs after virtio_gpu_init() has already
>returned. The display_info_cb that triggers the deadlock is called from
>the dequeue worker while drm_client_register() holds clientlist_mutex.
>
>Thread A:
>virtio_gpu_probe()
> -> virtio_gpu_init()   // sends GET_DISPLAY_INFO and waits up to 5s
> -> drm_dev_register()
> -> drm_client_setup()   // deadlock happens HERE
>     -> drm_client_register()   // holds clientlist_mutex
>     ...
>     -> virtio_gpu_queue_fenced_ctrl_buffer()
>         -> wait_event() // waits for free space
>
>Thread B:
>virtio_gpu_dequeue_ctrl_func()
> -> reclaim_vbufs()   // make free space

I wonder if the deadlock could be cured by alternatively adding a wakeup
before the responce cb, given that free space is available.

> -> resp_cb()
>     -> virtio_gpu_cmd_get_display_info_cb
>         -> drm_helper_hpd_irq_event()
>         -> drm_kms_helper_hotplug_event()
>             -> drm_client_dev_hotplug() // need to lock clientlist_mutex
> -> wake_up()   // never reached
>
>IIUC the hotplug notification in display_info_cb is needed because it
>notifies DRM after updating by the callback with fresh data from the host.
>
>This work_struct ensures display_info_cb never blocks on
>clientlist_mutex in the dequeue worker, while preserving the hotplug
>notification with fresh data.
>
>[1] https://syzkaller.appspot.com/bug?id=d6dd6f86d3aaf7eebe7406e45c1c6e549453f224
>[2] https://syzkaller.appspot.com/bug?id=908bd910da5dd79b88de4cf7baf376cc873a922e
>
>Best regards,
>Ryosuke
