Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D6D2638E8DC
	for <virtualization@lists.linux.dev>; Thu,  2 Jul 2026 07:12:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782976373; cv=none; b=fOBZFwv4vYKePaFkWzGl5ozNE+QQ0kqWtnd75SlwqtaC2E1gE7M+RjLnJA5ISlu+Uu9/gn+dJPwgo08+isexsm6cYtecXJ4JSObV0Xx6bDZkar3f5OvWS1NbedzvX3mg0pD55FVPj/fVoPsmiCw0l1V+mnm0I+vUVJbi+/rr8z4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782976373; c=relaxed/simple;
	bh=27dcR1DIgJXwa9YNkW/Zb4HNwCqBEnyovfUit2VscA8=;
	h=MIME-Version:From:To:In-Reply-To:Cc:Subject:Message-ID:Date:
	 Content-Type; b=TnBWTmdLE5BO3EKiqHFRTbBqJhMWlsaa6l38ARc6zPtBqSaUcBWhE6AI2CjtFIqkAUK1zbevdVrQG+S+rEJU66JUVouIptwtV4LIySq5z5TnTjS6KwE66WMM0R6jyJf563nqwi/SDtZGZ0DRnoSlPB7twjoskQulRrnESbpslJs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=fyKxElqR; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="fyKxElqR"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1782976370;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:  in-reply-to:in-reply-to;
	bh=hxdCQj6NzsZ0fMBpIQu3pY1Ddr/TRKQeJvgNYNHVEJc=;
	b=fyKxElqRMxQbwLXUVDzEm7SM6V1IsPsjejZJp4nrHsU1KHCslgvsvxtdVjdnhl3hlt0EY9
	5FTbnwnEa+KvXZk5S2ivc83wgZNCEg0IWhEe9VUSr51OcSY+3khtBLYgjNJl+S2YI7TgyC
	smEhmPKPgIgS/Ci6DKPafotgC6yywQY=
Received: from mail-pj1-f69.google.com (mail-pj1-f69.google.com
 [209.85.216.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-681-xhdFSWlmN5-3NPLRahDi6Q-1; Thu, 02 Jul 2026 03:12:49 -0400
X-MC-Unique: xhdFSWlmN5-3NPLRahDi6Q-1
X-Mimecast-MFC-AGG-ID: xhdFSWlmN5-3NPLRahDi6Q_1782976369
Received: by mail-pj1-f69.google.com with SMTP id 98e67ed59e1d1-38010ab3c0bso1738499a91.0
        for <virtualization@lists.linux.dev>; Thu, 02 Jul 2026 00:12:49 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782976369; x=1783581169;
        h=content-transfer-encoding:date:message-id:subject:cc:in-reply-to:to
         :from:mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=PhGng+hd9qECLzQceD/9OUpAsw5HRAD3GeuzTLZHbzY=;
        b=K65G7L22y6VfGpL6uwJNFJQdzJQwtE/uc2l2DG2XxiHMzddICmuASeheLR4bH0Ya2J
         GjPwjVjwV/XyIs+UN/FiJgxuRdZK+Isuj1CqxFn/cEqIpymUegPnzKsU6ROccPr3P/YN
         M+Iwmj0BTkMubQ+in5rxgMQ7tK7QPMbMDhOVt4bRIm9cluKrUvny0b+GUFotcARo1VPc
         q2suIwZea8A5qUoAbDPy2QS2HtuTQOUZH5TU1n5nH7DUDV/lym5+wrN9tvzEhAxD7UcO
         zNR5irOxaGpIA4xX89r2XXxuAhagVHdWQwCe/ZO/K3xCcZuBBsxdSnKJ6AVhcJbqRzMr
         pTKg==
X-Forwarded-Encrypted: i=1; AHgh+RpsqcFZlyvtbtGB/bLyiOrkyRrs9O3FM8+Hn8F+zfhon9+ZGcw5rztTt6e8EaIQCQTLy+bXLOJByyJyetn67g==@lists.linux.dev
X-Gm-Message-State: AOJu0Yyf/ts2gP8Rg9kwKnztiTzjSsHo6V+U6q3DGpqbhd24kX/cGyVU
	dwoHl83ny39zCQqjan0uSsSZWBdxRLsdWVjzZZBhV/VkhbcLz1IqFRWmC8PVtthkBTIHZQCyCru
	bqTpGvXO95CWRC+oqNInQ0zOECr9bqvo3wEzD6Aai2YD89BWHJygAcQgyebUFZHPOcx8Z
X-Gm-Gg: AfdE7clCuGW1S91QrO2EWpnA3U8qKknDfCNMUVlywQRpd/u2em33352T2pc2alUHA+l
	3uiKxGYxVj7CYEMFIcXIxWiZz2Ud18gwIZyB52Ghezjn4iuG6NqeiDl6pmLOHaOuBsVFKO13m1w
	jMTSk3nQ7+uxPrlihDnjmHfCmPXgffs1MQToOaTx0N2ANw/R4lSlafkn459K+MKl20NPLWoBinW
	up9KjrE9Ui21/Od9pAubFGJqQf6VFdMHq+kKq3pJ3Cj8ZIrkEJhGO40XSrPxPaEbeQktsPgh9S7
	HH02AsyKT8rkr/aEgJJjowLfA1fUFilatEd0qPymbbnCLSEPQ2Vd1cwwG5U3fDx1Yj6K6a5TGA2
	BtTcirg3BEyc5MBOBnAVmWCXZnOGn9P9vlk4TGgTs1fU85VCN
X-Received: by 2002:a17:90b:5148:b0:380:21b7:e727 with SMTP id 98e67ed59e1d1-380ba8d0fd6mr4293590a91.14.1782976368560;
        Thu, 02 Jul 2026 00:12:48 -0700 (PDT)
X-Received: by 2002:a17:90b:5148:b0:380:21b7:e727 with SMTP id 98e67ed59e1d1-380ba8d0fd6mr4293543a91.14.1782976367846;
        Thu, 02 Jul 2026 00:12:47 -0700 (PDT)
Received: from ryasuoka-thinkpadx1carbongen9.tokyo.csb ([126.143.164.49])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-380e17cb4b7sm577673a91.13.2026.07.02.00.12.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 02 Jul 2026 00:12:47 -0700 (PDT)
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
From: "Ryosuke Yasuoka" <ryasuoka@redhat.com>
To: "Hillf Danton" <hdanton@sina.com>
In-Reply-To: <20260701234301.361-1-hdanton@sina.com>
Cc: "Dmitry Osipenko" <dmitry.osipenko@collabora.com>, 
	"Dmitry Baryshkov" <lumag@kernel.org>, 
	"Javier Martinez Canillas" <javierm@redhat.com>, 
	<dri-devel@lists.freedesktop.org>, <virtualization@lists.linux.dev>, 
	<linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] drm/virtio: defer hotplug event from dequeue worker to avoid
	 deadlock
Message-ID: <18be678e97322160.8f56a0770e5621ab.8d175eba8a62d6be@ryasuoka-thinkpadx1carbongen9.tokyo.csb>
Date: Thu, 2 Jul 2026 07:12:44 +0000
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: CwArIW89haypxEtA3l7m6JiT-LkrCdHAMUjRvQ0I3Ng_1782976369
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable



On 02/07/2026 07:43, Hillf Danton wrote:
> On Wed, 1 Jul 2026 09:23:05 +0000 Ryosuke Yasuoka wrote:
>>On 30/06/2026 16:46, Dmitry Osipenko wrote:
>>> Could you please move drm_kms_helper_hotplug_event() to virtio_gpu_init=
(),
>>> placing it after wait_event_timeout(display_info_pending)? This will av=
oid
>>> additional work_struct that otherwise needs to be cancelled in
>>> virtio_gpu_init() on the timeout.
>>
>>IIUC, moving the drm_kms_helper_hotplug_event() and _hpd_irq_event()
>>into virtio_gpu_init() after wait_event_timeout() would not prevent the
>>issue.
>>
>>Looking at the syzbot call traces[1][2], the deadlock occurs during
>>drm_client_setup(), which runs after virtio_gpu_init() has already
>>returned. The display_info_cb that triggers the deadlock is called from
>>the dequeue worker while drm_client_register() holds clientlist_mutex.
>>
>>Thread A:
>>virtio_gpu_probe()
>> -> virtio_gpu_init()   // sends GET_DISPLAY_INFO and waits up to 5s
>> -> drm_dev_register()
>> -> drm_client_setup()   // deadlock happens HERE
>>     -> drm_client_register()   // holds clientlist_mutex
>>     ...
>>     -> virtio_gpu_queue_fenced_ctrl_buffer()
>>         -> wait_event() // waits for free space
>>
>>Thread B:
>>virtio_gpu_dequeue_ctrl_func()
>> -> reclaim_vbufs()   // make free space
>=20
> I wonder if the deadlock could be cured by alternatively adding a wakeup
> before the responce cb, given that free space is available.

Thanks for your comment. I agree that moving wake_up() before response
cb would help in most cases, and I think it is a reasonable aproach.
However, there are a few rare scenarios where the deadlock can still
occur:

1. If reclaim_vbufs() does not free enough slots to satisfy
num_free >=3D elemcnt, wake_up() fires but the wait_event() condition
evaluates false. Thread A remains asleep holding clientlist_mutex, and
the dequeue worker proceeds to display_info_cb which blocks on
clientlist_mutex.
2. Even if enough slots are freed, there is a small window between
wait_event() returning and Thread A acquiring spin_lock(&qlock) at the
"goto again" path in virtio_gpu_queue_ctrl_sgs(). Another thread can
consume the freed slots during this window, causing Thread A to loop=20
back to wait_event() still holding clientlist_mutex.
3. Reordering wake_up() before resp_cb inverts the natural "process
response, then signal completion" pattern, which could introduce subtle
issues if a future resp_cb depends on side effects that should happen
after wake_up(), I believe.

These scenarios are likely rare in practice, but the schedule_work()
approach avoids all of them entirely by ensuring the dequeue worker
never touches clientlist_mutex. It also follows the same pattern
already used by config_changed_work in this driver.

Best regards
Ryosuke

>=20
>> -> resp_cb()
>>     -> virtio_gpu_cmd_get_display_info_cb
>>         -> drm_helper_hpd_irq_event()
>>         -> drm_kms_helper_hotplug_event()
>>             -> drm_client_dev_hotplug() // need to lock clientlist_mutex
>> -> wake_up()   // never reached
>>
>>IIUC the hotplug notification in display_info_cb is needed because it
>>notifies DRM after updating by the callback with fresh data from the host=
.
>>
>>This work_struct ensures display_info_cb never blocks on
>>clientlist_mutex in the dequeue worker, while preserving the hotplug
>>notification with fresh data.
>>
>>[1] https://syzkaller.appspot.com/bug?id=3Dd6dd6f86d3aaf7eebe7406e45c1c6e=
549453f224
>>[2] https://syzkaller.appspot.com/bug?id=3D908bd910da5dd79b88de4cf7baf376=
cc873a922e
>>
>>Best regards,
>>Ryosuke

