Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793011976;
	b=txpxdFpUF9HRs8ErJvshklf+uLRF3lLpRRk0/Itu5J6p24PbuM5yaeD9bM/et+P5Gbk1
	 CHHoobrKQGrbihw+TKfa7gwjj33p8Gg9QlMQCBVKMUJaLxY1KPol4d17/LdahCvF4mOjK
	 jXEag1A2MPyJEgR0Q1HQfxYgVXFwQOda4izGNPcuOxH7U+yusxqz1Cjb9X4AyLYQbjctE
	 3bVg5avMmHWt2+SV8JIi1Hdcjz0JmpunkTg3lKdePCVxg7RaqMfoUHDSxQpc/UtJHTemS
	 mC7rb0DK0i5nzpAsTuFofcPVeatifnAOMIQyUqFydOT0p80xeyx1c3ve+G9kfTaVzow==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793011976;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=zQURHhq9ZWhEvJJ14uZwYSAyydn02+qGomsj+76FuPI=;
	b=hV1Lg8jq83OaMC7vTSESl+lLYMLKsLJ6cKWVN1XtXafp+sZAjOYfL3qDPrfJs1Mxms4l
	 RL8eww7RoFI7cflgJMipNFv2tdmP0g+0tUw4kSDT6jJzDI6092x4UKnS8ShOMW3CoOcwL
	 mXdT4643xads6ghT0EF8ATpx6+uz2SR8+aAmGcAHTal7pwWGHXalribrMN5ZnUgpHw/mX
	 OsQ+hyQ3CZjeD9+WJ0qrt1YDlAhK8ob5DMYBXyGo+cGxe3A77CkHupzJZgDdowmGtzZet
	 37cedihvvFGd9kpgm/AFEKjy+Z+ZPGMZKGyz8Ch18yuGcPmluPj3aV33dkDtgsgXOrQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=bxbvyhCL;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 12325606A322;
	Mon, 26 Oct 2026 10:52:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=bxbvyhCL
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 34E181F01825;
	Mon, 26 Oct 2026 10:52:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793011975;
	bh=zQURHhq9ZWhEvJJ14uZwYSAyydn02+qGomsj+76FuPI=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=bxbvyhCL8NlLwXUBl5UftlLxsHd9w8QIebou2Y++f0lBrbGSLFXhlkvoksTwb6g9r
	 Q+XWzZIuZDPYsoq3HxS8cnYk5KGlcITP3Fnuwzdhsg38hFz7Tgs+b9i2Icr+S3+jrv
	 zPtZLtbdWqpxxIdJ54GIApVchPu8j2Jzhq6n+S5m0tSvt+6uiMBLPMSXQ5h77dO7bc
	 h0ZwM8qcEA6nMxRJzRp3gJa9fgbpFfwRMkgU9c02xdEPkf2FePfRyY78t0+6tvmV81
	 9xh9FbrkCCrikp0muz25xM7A+X+DjAne+HvCaU6GuIRKWScCMsagCuZeIWQWasFzcV
	 sWRVXG9D31i9Q==
Message-ID: <sashiko-outbox-185022@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v2 09/23] drm/msm/dcp: Add generic HFI display commands
Reply-To: sashiko-reviews@lists.linux.dev
To: "Jayant Shekhar" <jayant.shekhar@oss.qualcomm.com>
Cc: virtualization@lists.linux.dev, dri-devel@lists.freedesktop.org, devicetree@vger.kernel.org, robh@kernel.org, conor+dt@kernel.org, media-ci@linuxtv.org, "Michael
 S. Tsirkin" <mst@redhat.com>, "Eugenio Perez" <eperezma@redhat.com>
In-Reply-To: <20261026-jshekhar-dcp-hlos-v2-9-7cf014efdee1@oss.qualcomm.com>
References: <20261026-jshekhar-dcp-hlos-v2-0-7cf014efdee1@oss.qualcomm.com>
 <20261026-jshekhar-dcp-hlos-v2-9-7cf014efdee1@oss.qualcomm.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Mon, 26 Oct 2026 10:52:54 +0000
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Post: <mailto:virtualization@lists.linux.dev>
List-Help: <mailto:virtualization+help@lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
List-Owner: <mailto:virtualization+owner@lists.linux.dev>
Precedence: list

Thank you for your contribution! Sashiko AI review found 2 potential issue(=
s) to consider:
- [High] drm/msm/dcp: completion corruption and unlocked caps_cache in dcp_=
hfi_kms.c
- [High] drm/msm/dcp: pipe count clobbering in dcp_hfi_parse_init_caps_kv()
--

commit 90bc8a62bf35e8d6f13a5451d4e21b3d608a5097
Author: Jayant Shekhar <jayant.shekhar@oss.qualcomm.com>

drm/msm/dcp: Add generic HFI display commands

This commit adds generic HFI display command helpers and capability parsing
for the firmware-owned DCP display pipeline, translating DRM state for
resources, CRTCs, planes, bandwidth, and frame sequencing into HFI commands
and properties.

> diff --git a/drivers/gpu/drm/msm/dcp/dcp_hfi_kms.c b/drivers/gpu/drm/msm/=
dcp/dcp_hfi_kms.c
> new file mode 100644
> index 0000000000000..ac8000a8ee900
> --- /dev/null
> +++ b/drivers/gpu/drm/msm/dcp/dcp_hfi_kms.c
> @@ -0,0 +1,366 @@

[ ... ]

> +static void dcp_hfi_caps_cache_init(struct dcp_hfi_caps_cache *cache)
> +{
> +	init_completion(&cache->device_done);
> +	init_completion(&cache->display_done);
> +}
> +
> +static void dcp_hfi_caps_cache_start(struct dcp_hfi *hfi)
> +{
> +	memset(&hfi->caps_cache, 0, sizeof(hfi->caps_cache));
> +	dcp_hfi_caps_cache_init(&hfi->caps_cache);
> +}
> +
> +static void dcp_hfi_caps_cache_stop(struct dcp_hfi *hfi)
> +{
> +	memset(&hfi->caps_cache, 0, sizeof(hfi->caps_cache));
> +}
> +
> +int dcp_hfi_send_device_init(struct dcp_hfi *hfi)
> +{
> +	int ret;
> +
> +	mutex_lock(&hfi->caps_cache_lock);
> +	dcp_hfi_caps_cache_start(hfi);
> +
> +	/* Payload and flags follow the HFI device-command definition. */
> +	dev_dbg(hfi->dev,
> +		"HFI DEVICE_INIT cmd=3D0x%x flags=3D0x%x timeout=3D%ums\n",
> +		HFI_COMMAND_DEVICE_INIT,
> +		HFI_TX_FLAGS_RESPONSE_REQUIRED | HFI_TX_FLAGS_NON_DISCARDABLE,
> +		DCP_HFI_TIMEOUT_INIT_MS);
> +
> +	ret =3D dcp_hfi_send_sync(hfi,
> +				HFI_COMMAND_DEVICE_INIT,
> +				HFI_CMD_BUFF_DEVICE, 0,
> +				HFI_PAYLOAD_NONE, NULL, 0,
> +				HFI_TX_FLAGS_RESPONSE_REQUIRED |
> +				HFI_TX_FLAGS_NON_DISCARDABLE,
> +				NULL, 0,
> +				DCP_HFI_TIMEOUT_INIT_MS);
> +	if (ret) {
> +		dev_err(hfi->dev, "HFI DEVICE_INIT failed: %d\n", ret);
> +		dcp_hfi_caps_cache_stop(hfi);
> +	} else {
> +		dev_dbg(hfi->dev, "HFI DEVICE_INIT succeeded\n");
> +	}
> +
> +	mutex_unlock(&hfi->caps_cache_lock);
> +	return ret;
> +}
> +
> +static void dcp_hfi_parse_init_caps_kv(struct dcp_caps *caps,
> +				       u32 prop_key,
> +				       const u32 *payload,
> +				       u32 max_words)
> +{
> +	u32 prop_id =3D HFI_PROP_ID(prop_key);
> +	u32 count, i;
> +
> +	if (!payload || !max_words)
> +		return;
> +
> +	switch (prop_id) {

[ ... ]

> +	case HFI_PROPERTY_DEVICE_INIT_VIG_INDICES:
> +		if (max_words < 1)
> +			break;
> +		count =3D payload[0];
> +		if (count > max_words - 1)
> +			count =3D max_words - 1;
> +		caps->num_vig_pipes =3D 0;
> +		caps->virt_vig_count =3D 0;
> +		for (i =3D 0; i < count; i++) {
> +			u32 idx =3D payload[1 + i];
> +
> +			if (DCP_REC_ID(idx) =3D=3D 0) {
> +				if (caps->num_vig_pipes < DCP_MAX_SSPP_COUNT)
> +					caps->vig_pipe_ids[caps->num_vig_pipes++] =3D idx;
> +			} else {
> +				if (caps->virt_vig_count < DCP_MAX_SSPP_COUNT)
> +					caps->vig_r1_indices[caps->virt_vig_count++] =3D idx;
> +			}
> +		}
> +		break;
> +	case HFI_PROPERTY_DEVICE_INIT_DMA_INDICES:
> +		if (max_words < 1)
> +			break;
> +		count =3D payload[0];
> +		if (count > max_words - 1)
> +			count =3D max_words - 1;
> +		caps->num_dma_pipes =3D 0;
> +		caps->virt_dma_count =3D 0;
> +		for (i =3D 0; i < count; i++) {
> +			u32 idx =3D payload[1 + i];
> +
> +			if (DCP_REC_ID(idx) =3D=3D 0) {
> +				if (caps->num_dma_pipes < DCP_MAX_SSPP_COUNT)
> +					caps->dma_pipe_ids[caps->num_dma_pipes++] =3D idx;
> +			} else {
> +				if (caps->virt_dma_count < DCP_MAX_SSPP_COUNT)
> +					caps->dma_r1_indices[caps->virt_dma_count++] =3D idx;
> +			}
> +		}
> +		break;

[Severity: High]
Won't resetting both the primary and rect-1 pipe counters here clobber the
previously parsed pipe counts when dcp_hfi_get_capabilities() parses multip=
le
capability buffers into the same struct dcp_caps?

In drivers/gpu/drm/msm/dcp/hfi/hfi_properties_device.h, both rect-0 pipes
(DCP_REC_ID(idx) =3D=3D 0) and rect-1 multirect pipes (DCP_REC_ID(idx) !=3D=
 0) use
HFI_PROPERTY_DEVICE_INIT_VIG_INDICES and HFI_PROPERTY_DEVICE_INIT_DMA_INDIC=
ES.

dcp_hfi_get_capabilities() calls dcp_hfi_parse_kv_buf() sequentially on
cache->device_buf, cache->display_buf, cache->vig_buf, cache->dma_buf,
cache->vig_r1_buf, and cache->dma_r1_buf.

When cache->vig_r1_buf and cache->dma_r1_buf are parsed after the primary
pipe buffers, their HFI_PROPERTY_DEVICE_INIT_VIG_INDICES and
HFI_PROPERTY_DEVICE_INIT_DMA_INDICES properties contain only rect-1 indices,
which unconditionally resets caps->num_vig_pipes and caps->num_dma_pipes ba=
ck
to 0. As a result, caps->max_planes evaluates to 0 and
dcp_hfi_get_capabilities() fails with -EINVAL ("invalid DCP caps: no scanout
pipes"). Conversely, if device_buf contains both rect-0 and rect-1 indices
and vig_buf/dma_buf contain only rect-0 indices, parsing vig_buf/dma_buf
resets caps->virt_vig_count and caps->virt_dma_count to 0.

[ ... ]

> +int dcp_hfi_get_capabilities(struct dcp_hfi *hfi, struct dcp_caps *caps)
> +{
> +	struct dcp_hfi_caps_cache *cache;
> +	int ret =3D 0, opt_ret;
> +
> +	memset(caps, 0, sizeof(*caps));
> +
> +	mutex_lock(&hfi->caps_cache_lock);
> +	cache =3D &hfi->caps_cache;
> +
> +	if (!wait_for_completion_timeout(&cache->device_done,
> +					 msecs_to_jiffies(DCP_HFI_TIMEOUT_CAPS_MS))) {
> +		dev_err(hfi->dev,
> +			"DEVICE_INIT_DEVICE_CAPS timeout after %ums\n",
> +			DCP_HFI_TIMEOUT_CAPS_MS);
> +		ret =3D -ETIMEDOUT;
> +		goto out_free_cache;
> +	}
> +
> +	if (!cache->device_len) {
> +		dev_err(hfi->dev, "DEVICE_INIT_DEVICE_CAPS: empty payload\n");
> +		ret =3D -ENODATA;
> +		goto out_free_cache;
> +	}
> +
> +	ret =3D dcp_hfi_parse_kv_buf(hfi, caps, cache->device_buf,
> +				   cache->device_len);
> +	if (ret)
> +		goto out_free_cache;
> +
> +	if (!wait_for_completion_timeout(&cache->display_done,
> +					 msecs_to_jiffies(DCP_HFI_TIMEOUT_CAPS_MS))) {
> +		dev_warn(hfi->dev,
> +			 "DEVICE_INIT_DISPLAY_CAPS not received\n");
> +	} else if (cache->display_len > 0) {
> +		opt_ret =3D dcp_hfi_parse_kv_buf(hfi, caps, cache->display_buf,
> +					       cache->display_len);
> +		if (opt_ret) {
> +			dev_warn(hfi->dev,
> +				 "DISPLAY_CAPS parse failed: %d (non-fatal)\n",
> +				 opt_ret);
> +		}
> +	}
> +	if (cache->vig_len > 0) {
> +		opt_ret =3D dcp_hfi_parse_kv_buf(hfi, caps, cache->vig_buf,
> +					       cache->vig_len);
> +		if (opt_ret)
> +			dev_warn(hfi->dev,
> +				 "VIG_CAPS parse failed: %d (non-fatal)\n",
> +				 opt_ret);
> +		else
> +			dcp_hfi_log_pipe_ids(hfi->dev, "VIG_CAPS",
> +					     caps->vig_pipe_ids,
> +					     caps->num_vig_pipes);
> +	}

[ ... ]

> +out_free_cache:
> +	dcp_hfi_caps_cache_stop(hfi);
> +	mutex_unlock(&hfi->caps_cache_lock);
> +	return ret;
> +}

[Severity: High]
Can zeroing hfi->caps_cache in dcp_hfi_caps_cache_stop() corrupt
device_done and display_done while capability events are still in flight, a=
nd
does caps_cache access here race with dcp_hfi_dispatch_event()?

struct dcp_hfi_caps_cache embeds the device_done and display_done struct
completion objects. Calling memset(&hfi->caps_cache, 0,
sizeof(hfi->caps_cache)) in dcp_hfi_caps_cache_stop() (and in
dcp_hfi_caps_cache_start() before dcp_hfi_caps_cache_init(), as well as pri=
or
to the first dcp_hfi_send_device_init() call after dcp_hfi_init() posts
response buffers) zeroes wait.lock and sets wait.task_list.next and
wait.task_list.prev to NULL.

In dcp_hfi_get_capabilities(), a timeout on display_done is treated as a
non-fatal warning and execution proceeds to out_free_cache, where
dcp_hfi_caps_cache_stop() zeroes hfi->caps_cache. The same happens if
device_done times out, if dcp_hfi_parse_kv_buf() fails on device_buf, or if
dcp_hfi_send_sync() times out in dcp_hfi_send_device_init().

If HFI_COMMAND_DEVICE_INIT_DEVICE_CAPS or
HFI_COMMAND_DEVICE_INIT_DISPLAY_CAPS then arrives in
dcp_hfi_resp_callback()->dcp_hfi_dispatch_event()->dcp_hfi_store_caps_paylo=
ad(),
complete() calls swake_up_locked() on the zeroed completion. Because
list_empty(&q->task_list) checks READ_ONCE(head->next) =3D=3D head, a NULL =
next
pointer evaluates as non-empty and causes a NULL pointer dereference in
interrupt context (along with operating on a zeroed raw_spinlock_t).

In addition, dcp_hfi_dispatch_event() in dcp_hfi_core.c protects writes to
hfi->caps_cache with spin_lock_irqsave(&hfi->caps_lock, flags), whereas
dcp_hfi_caps_cache_start(), dcp_hfi_caps_cache_stop(), and
dcp_hfi_get_capabilities() only hold the mutex hfi->caps_cache_lock and nev=
er
acquire hfi->caps_lock. Because VIG_CAPS, DMA_CAPS, VIG_R1_CAPS, and
DMA_R1_CAPS have no completion wait in dcp_hfi_get_capabilities(), reading
cache->vig_buf, cache->dma_buf, cache->vig_r1_buf, and cache->dma_r1_buf (a=
nd
zeroing hfi->caps_cache at out_free_cache) can also race concurrently with
dcp_hfi_store_caps_payload() on another CPU.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261026-jshekhar-d=
cp-hlos-v2-0-7cf014efdee1@oss.qualcomm.com?part=3D9
