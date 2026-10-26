Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793010145;
	b=sKBpVFBWwpxVMxXLfyA+KoH7hQUxDyc5hPiDMf1h0qgOWnvqwv4TbAuH9TN+w3qusF0l
	 W18vPcP6LGd55d+qTRl7plF0gqJa3Qytc6WRwVADQGN3YX0X+AJ8DlXsHs2H5ZHan2R7d
	 4r5DDDc5m5gsW43Ae2+9W4azOU+m1RE996P57r/sl8WIB9tSowQFPC9R/TglNnQc8qnwY
	 LMcoIkQzrenp1b1dMu6APaz6pnweWCS9ATeYHUmD0gXdqpFWmckyEF1BMHA5y0kIdJl3r
	 gHHQgtXuWHBeF0dN/btrgdoqx99kUH3ZkEw+1rH1EHvyXM0lOCGNpVACeUDwqThOWjg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793010145;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=AXUoYFo+cwVqLWZJ+2dHgemfWX+nriJDROeDiR68zbA=;
	b=UtsyfdrzIMpR96CoTNPUPR9sMt7JtdzK3eJ96yNl23s9Prz7L1dXUnTyYrP7S9lPCBOA
	 /NQybZ1InFJcu3OHtiZlpFU7DRAiLpAcXNVbxVIg2toxoyLLiqPwbGdOw9S1mdSxn1nmr
	 DFQleNvATz06NrD0HiHYQhB11A+G0AMw7klv1aREdmYEUcbBJO9NjzijOripruxkTPRmf
	 QkTaWNU3byKrhjgEJDltWkV7g0OadRi2DBEm9JJreJjwK+ojINZ4wAB/fA1hUXoGfiRWo
	 am0E0KW/Pa0QHV7T/3EadX9v0H1Hf6KLNKIL/lUmGqBAhl4VR9jw/FAjB1soPVdexhg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=JNnPDjqe;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A828D606A33A;
	Mon, 26 Oct 2026 10:22:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=JNnPDjqe
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D0D3D1F01825;
	Mon, 26 Oct 2026 10:22:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793010144;
	bh=AXUoYFo+cwVqLWZJ+2dHgemfWX+nriJDROeDiR68zbA=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=JNnPDjqedMFaUY3vhq8b3BmS/5KrcQaezFEDTMlV0Jy1HYmPxFdq9J5SxlM/ef28q
	 KTCEqktgSvYXHZVqFhQvfKFDQsAO6rdO7itLCE/PxWxHGBYaNCHPu1OVcSGE2KRL6P
	 4ayVq72ERP4KpbIXEOnfo3BwRGHQ0hQS2Zg0OpQOQ+Eec+Dy/KcF2YcXQVrrryWLZk
	 Yzx9DEjn/bxE8DPkPsGS/1oMfThB8ATd+1EfO700asLwIv4my0mkz0s6r9oIj28S8u
	 POsZpj740BMWHfakJbJ3E48U/WMMUcBofzZdV7tPIK9pBk2glf/6jNotiNc+Gwvv12
	 w2u18s8kL3YDg==
Message-ID: <sashiko-outbox-184929@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v2 07/23] drm/msm/dcp: Handle asynchronous HFI responses
Reply-To: sashiko-reviews@lists.linux.dev
To: "Jayant Shekhar" <jayant.shekhar@oss.qualcomm.com>
Cc: virtualization@lists.linux.dev, dri-devel@lists.freedesktop.org, devicetree@vger.kernel.org, robh@kernel.org, conor+dt@kernel.org, media-ci@linuxtv.org, "Michael
 S. Tsirkin" <mst@redhat.com>, "Eugenio Perez" <eperezma@redhat.com>
In-Reply-To: <20261026-jshekhar-dcp-hlos-v2-7-7cf014efdee1@oss.qualcomm.com>
References: <20261026-jshekhar-dcp-hlos-v2-0-7cf014efdee1@oss.qualcomm.com>
 <20261026-jshekhar-dcp-hlos-v2-7-7cf014efdee1@oss.qualcomm.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Mon, 26 Oct 2026 10:22:23 +0000
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Post: <mailto:virtualization@lists.linux.dev>
List-Help: <mailto:virtualization+help@lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
List-Owner: <mailto:virtualization+owner@lists.linux.dev>
Precedence: list

Thank you for your contribution! Sashiko AI review found 5 potential issue(=
s) to consider:
- [High] drm/msm/dcp: uninitialized completions in dcp_hfi_init() and dcp_h=
fi_deinit()
- [High] drm/msm/dcp: race re-scheduling resource_vote_work after dcp_hfi_s=
top()
- [High] drm/msm/dcp: race between dcp_hfi_clear_power_control_cb() and pow=
er_cb()
- [Medium] drm/msm/dcp: malformed RESOURCE_VOTE clobbers vote in dcp_hfi_di=
spatch_event()
- [Low] drm/msm/dcp: declarations placed after #endif include guard in dcp_=
hfi.h
--

commit 181941c645b83584ab1315f1b30bec1f0ef47673
Author: Jayant Shekhar <jayant.shekhar@oss.qualcomm.com>

drm/msm/dcp: Handle asynchronous HFI responses

This commit adds handling for asynchronous HFI messages in the DCP driver,
dispatching display events, caching capability payloads, invoking power
control callbacks, and deferring resource vote updates to a workqueue.

> diff --git a/drivers/gpu/drm/msm/dcp/dcp_hfi.h b/drivers/gpu/drm/msm/dcp/=
dcp_hfi.h
> index 23e1cd39b89d4..055e9c584892b 100644
> --- a/drivers/gpu/drm/msm/dcp/dcp_hfi.h
> +++ b/drivers/gpu/drm/msm/dcp/dcp_hfi.h

[ ... ]

> @@ -167,3 +211,8 @@ int dcp_hfi_send_no_wait_atomic_flags(struct dcp_hfi =
*hfi, u32 cmd,
>  				      enum hfi_packet_payload_type payload_type,
>  				      void *payload, u32 payload_size, u32 tx_flags);
>  #endif /* __DCP_HFI_H__ */
> +void dcp_hfi_set_power_control_cb(struct dcp_hfi *hfi, void *priv,
> +				  void (*cb)(void *priv, u32 display_id,
> +					     u32 power_mask, bool enable,
> +					     u32 packet_id));
> +void dcp_hfi_clear_power_control_cb(struct dcp_hfi *hfi, void *priv);

[Severity: Low]
Should the declarations for dcp_hfi_set_power_control_cb() and
dcp_hfi_clear_power_control_cb() be placed before #endif /* __DCP_HFI_H__ */
so they remain inside the header include guard?

> diff --git a/drivers/gpu/drm/msm/dcp/dcp_hfi_core.c b/drivers/gpu/drm/msm=
/dcp/dcp_hfi_core.c
> index 9f7ac798e13c4..774a5afac0f0a 100644
> --- a/drivers/gpu/drm/msm/dcp/dcp_hfi_core.c
> +++ b/drivers/gpu/drm/msm/dcp/dcp_hfi_core.c

[ ... ]

> @@ -227,6 +233,218 @@ void dcp_hfi_cmd_callback(struct virtqueue *vq)
>  	spin_unlock_irqrestore(&hfi->cmd_lock, flags);
>  }
> =20
> +static void dcp_hfi_store_caps_payload(struct dcp_hfi *hfi,
> +				       struct completion *done,
> +				       u8 *dst, u32 *dst_len,
> +				       const struct hfi_packet_info *pkt_info,
> +				       const char *name)
> +{
> +	u32 n;
> +
> +	if (!pkt_info->payload_ptr || !pkt_info->payload_size) {
> +		dev_dbg(hfi->dev, "%s: empty payload\n", name);
> +		return;
> +	}
> +
> +	if (pkt_info->payload_size > DCP_HFI_CAPS_BUF_SIZE) {
> +		dev_warn(hfi->dev, "%s: payload too large: %u\n",
> +			 name, pkt_info->payload_size);
> +		return;
> +	}
> +
> +	n =3D pkt_info->payload_size;
> +	memcpy(dst, pkt_info->payload_ptr, n);
> +	*dst_len =3D n;
> +	if (done)
> +		complete(done);
> +	dev_dbg(hfi->dev, "%s: stored %u bytes\n", name, n);
> +}
> +
> +/* Route asynchronous events and capability packets before flag handling=
. */
> +static bool dcp_hfi_dispatch_event(struct dcp_hfi *hfi,
> +				   const struct hfi_packet_info *pkt_info)
> +{
> +	switch (pkt_info->cmd) {

[ ... ]

> +	case HFI_COMMAND_DISPLAY_POWER_CONTROL: {
> +		u32 display_id =3D pkt_info->id & 0xFFFF;
> +		u32 power_mask =3D 0;
> +		bool enable =3D true;
> +		unsigned long flags;
> +		void *power_priv;
> +		void (*power_cb)(void *priv, u32 display_id,
> +				 u32 power_mask, bool enable, u32 packet_id);
> +
> +		if (pkt_info->payload_ptr &&
> +		    pkt_info->payload_size >=3D 2 * sizeof(u32)) {
> +			const u32 *p =3D pkt_info->payload_ptr;
> +
> +			power_mask =3D p[0];
> +			enable     =3D (p[1] =3D=3D HFI_TRUE);
> +		}
> +
> +		spin_lock_irqsave(&hfi->resp_drain_lock, flags);
> +		power_cb =3D hfi->power_control_cb;
> +		power_priv =3D hfi->power_control_priv;
> +		spin_unlock_irqrestore(&hfi->resp_drain_lock, flags);
> +
> +		if (power_cb)
> +			power_cb(power_priv, display_id, power_mask, enable,
> +				 pkt_info->packet_id);
> +		return true;
> +	}

[Severity: High]
Can power_cb() race with dcp_hfi_clear_power_control_cb() during teardown?

In dcp_hfi_dispatch_event(), HFI_COMMAND_DISPLAY_POWER_CONTROL copies
hfi->power_control_cb and hfi->power_control_priv under hfi->resp_drain_lock
and then drops the lock before calling power_cb(power_priv, ...).

Meanwhile, dcp_hfi_clear_power_control_cb() only clears those pointers under
hfi->resp_drain_lock and returns immediately:

drivers/gpu/drm/msm/dcp/dcp_hfi_core.c:dcp_hfi_clear_power_control_cb() {
	spin_lock_irqsave(&hfi->resp_drain_lock, flags);
	if (hfi->power_control_priv =3D=3D priv) {
		hfi->power_control_priv =3D NULL;
		hfi->power_control_cb =3D NULL;
	}
	spin_unlock_irqrestore(&hfi->resp_drain_lock, flags);
}

If a caller unregisters its callback and cancels its work or frees priv whi=
le
dcp_hfi_dispatch_event() has already dropped hfi->resp_drain_lock, couldn't
power_cb() still run after dcp_hfi_clear_power_control_cb() returns,
re-scheduling work or accessing power_priv after it is torn down?

> +
> +	case HFI_COMMAND_DEVICE_INIT_DEVICE_CAPS: {
> +		unsigned long flags;
> +
> +		spin_lock_irqsave(&hfi->caps_lock, flags);
> +		dcp_hfi_store_caps_payload(hfi, &hfi->caps_cache.device_done,
> +					   hfi->caps_cache.device_buf,
> +					   &hfi->caps_cache.device_len,
> +					   pkt_info, "DEVICE_INIT_DEVICE_CAPS");
> +		spin_unlock_irqrestore(&hfi->caps_lock, flags);
> +		return true;
> +	}
> +
> +	case HFI_COMMAND_DEVICE_INIT_DISPLAY_CAPS: {
> +		unsigned long flags;
> +
> +		spin_lock_irqsave(&hfi->caps_lock, flags);
> +		dcp_hfi_store_caps_payload(hfi, &hfi->caps_cache.display_done,
> +					   hfi->caps_cache.display_buf,
> +					   &hfi->caps_cache.display_len,
> +					   pkt_info, "DEVICE_INIT_DISPLAY_CAPS");
> +		spin_unlock_irqrestore(&hfi->caps_lock, flags);
> +		return true;
> +	}

[ ... ]

> +	case HFI_COMMAND_DEVICE_CALLBACK_RESOURCE_VOTE: {
> +		unsigned long vote_flags;
> +		u32 payload_size =3D pkt_info->payload_size;
> +		bool valid =3D pkt_info->payload_ptr && payload_size &&
> +			payload_size <=3D DCP_HFI_RESOURCE_VOTE_BUF_SIZE &&
> +			payload_size % sizeof(struct dcp_resource_vote_wire) =3D=3D 0;
> +
> +		if (!valid) {
> +			dev_warn_ratelimited(hfi->dev,
> +					     "dropping malformed RESOURCE_VOTE payload size=3D%u max=3D%u\n=
",
> +					     payload_size, DCP_HFI_RESOURCE_VOTE_BUF_SIZE);
> +			payload_size =3D 0;
> +		}
> +
> +		spin_lock_irqsave(&hfi->resource_vote_lock, vote_flags);
> +		if (payload_size)
> +			memcpy(hfi->resource_vote_buf, pkt_info->payload_ptr,
> +			       payload_size);
> +		hfi->resource_vote_len =3D payload_size;
> +		hfi->resource_vote_generation++;
> +		spin_unlock_irqrestore(&hfi->resource_vote_lock, vote_flags);

[Severity: Medium]
When a malformed HFI_COMMAND_DEVICE_CALLBACK_RESOURCE_VOTE packet arrives,
why does this set payload_size =3D 0 and continue instead of returning earl=
y?

By setting hfi->resource_vote_len =3D 0 and incrementing
hfi->resource_vote_generation under hfi->resource_vote_lock, a malformed
packet will clobber any valid resource vote already queued in
hfi->resource_vote_buf that dcp_hfi_resource_vote_work() has not yet
processed, causing dcp_hfi_resource_vote_work() to see len =3D=3D 0 and dro=
p the
earlier valid vote.

[ ... ]

> @@ -726,7 +987,10 @@ int dcp_hfi_init(struct dcp_drv *drv,
> =20
>  	spin_lock_init(&hfi->cmd_lock);
>  	spin_lock_init(&hfi->pending_lock);
> +	spin_lock_init(&hfi->resource_vote_lock);
>  	spin_lock_init(&hfi->resp_drain_lock);
> +	spin_lock_init(&hfi->caps_lock);
> +	mutex_init(&hfi->caps_cache_lock);

[Severity: High]
Where are hfi->caps_cache.device_done and hfi->caps_cache.display_done
initialized?

In dcp_hfi_init(), hfi is allocated with devm_kzalloc() and response buffers
are posted immediately via dcp_hfi_prepost_resp_bufs(), but init_completion=
()
is never called on hfi->caps_cache.device_done or
hfi->caps_cache.display_done. In addition, dcp_hfi_deinit() zeroes the enti=
re
struct with memset(&hfi->caps_cache, 0, sizeof(hfi->caps_cache)), which wip=
es
the embedded completion waitqueues and spinlocks.

If HFI_COMMAND_DEVICE_INIT_DEVICE_CAPS or
HFI_COMMAND_DEVICE_INIT_DISPLAY_CAPS arrives in
dcp_hfi_resp_callback()->dcp_hfi_dispatch_event()->dcp_hfi_store_caps_paylo=
ad()
while those completions are zeroed, won't complete(done) dereference a NULL
wait.task_list pointer in swake_up_locked()?

[ ... ]

> @@ -804,6 +1097,7 @@ void dcp_hfi_stop(struct dcp_hfi *hfi)
>  	atomic_set(&hfi->shutdown_in_progress, 1);
>  	spin_unlock_irqrestore(&hfi->cmd_lock, flags);
> =20
> +	cancel_work_sync(&hfi->resource_vote_work);
>  	cancel_delayed_work_sync(&hfi->resp_repost_work);
>  	dcp_hfi_cancel_pending(hfi, -ENODEV);
>  }

[Severity: High]
Can dcp_hfi_resp_callback() re-schedule hfi->resource_vote_work after
dcp_hfi_stop() has already called cancel_work_sync()?

In dcp_hfi_resp_callback(), hfi->shutdown_in_progress is only checked at the
start of the function, and hfi->resp_drain_lock is dropped while unpacking
packets and calling dcp_hfi_dispatch_event():

drivers/gpu/drm/msm/dcp/dcp_hfi_core.c:dcp_hfi_resp_callback() {
	if (!hfi || atomic_read(&hfi->shutdown_in_progress))
		return;

	spin_lock_irqsave(&hfi->resp_drain_lock, drain_flags);
	virtqueue_disable_cb(vq);
	for (;;) {
		while ((buf =3D virtqueue_get_buf(vq, &len)) !=3D NULL) {
			...
			spin_unlock_irqrestore(&hfi->resp_drain_lock, drain_flags);
			...
			} else if (dcp_hfi_dispatch_event(hfi, &pkt_info)) {
}

If dcp_hfi_stop() runs on another CPU while dcp_hfi_resp_callback() is
processing a buffer, dcp_hfi_stop() can set hfi->shutdown_in_progress =3D 1=
 and
finish cancel_work_sync(&hfi->resource_vote_work) before
dcp_hfi_dispatch_event() handles HFI_COMMAND_DEVICE_CALLBACK_RESOURCE_VOTE
and calls schedule_work(&hfi->resource_vote_work).

Since neither HFI_COMMAND_DEVICE_CALLBACK_RESOURCE_VOTE nor
dcp_hfi_resource_vote_work() checks hfi->shutdown_in_progress, and neither
dcp_hfi_quiesce_queues() nor dcp_hfi_deinit() cancels resource_vote_work
after virtqueue callbacks are synchronized, could dcp_hfi_resource_vote_wor=
k()
execute after teardown completes?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261026-jshekhar-d=
cp-hlos-v2-0-7cf014efdee1@oss.qualcomm.com?part=3D7
