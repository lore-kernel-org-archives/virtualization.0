Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9E5C73AAF65
	for <virtualization@lists.linux.dev>; Tue,  1 Sep 2026 11:46:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788263174; cv=none; b=Qwi3ODMnhYU9oEHiqTH8cjPJ0sezAQDbCle5zPz/BRa4WGfrbDKXRoqaarzfsg+bMP/l+yLF+b9dvwMBFLwxiB+wXW+SATXJbfsVUDnmbTva0iNFGzExogOshIVQeVgSswkjYBWt3B6SYBtiaMHlwkL4KHRxk6NcpWXZJB9V45Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788263174; c=relaxed/simple;
	bh=XmKRw4xFZ+aFsFUFwMtmdt8rig926R0hh8g93EypO0E=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=hFb9JGqvIKfnY2Dsx8LD1qCjfRNPvembYw/Cou67DyPOcFT68swoBf4cywe+zF5XArYqce3s336i2+soYvPQaOG/1CTAS5YKaekufmZiVU7H4RuGS+4matCLlgtqmxL48ghYckapwlEbA3d4SmagHIpnrSEbF8O/bkBcHAJK4Iw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de; spf=pass smtp.mailfrom=suse.de; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=oQ4OXuf/; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=jD78iQRc; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=j7lsJgJ/; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=FD4DGu3O; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="oQ4OXuf/";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="jD78iQRc";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="j7lsJgJ/";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="FD4DGu3O"
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 86FBB1FB3B;
	Tue,  1 Sep 2026 11:46:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1788263165; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=UNR1ZtUXqeFxjl7a4LYkrTsdWlDZ1XMW3bvG4buQpuw=;
	b=oQ4OXuf/OAKY75Hfp76dYovN7xlJPfnY4Cv9I71KQooWtYatmiHxfTxlJrQGQOPkbWOePu
	oik5U5TgtU1hlhQ0c7nwsSsiNu4zt5Iw5GxmKScS7O3n0E5jy1e3BOwERlocb0csyyC+ib
	DQA+h0RlDM2C+9A77Rz+q9bdA2y2t1w=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1788263165;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=UNR1ZtUXqeFxjl7a4LYkrTsdWlDZ1XMW3bvG4buQpuw=;
	b=jD78iQRcRdtfLZVz8gJo/sPR/D3JSWecLODqaNdHZOw05vrivzxaj3pe6RkvsHI6OkddB/
	VD2pg5xuB4t9SsAQ==
Authentication-Results: smtp-out2.suse.de;
	dkim=pass header.d=suse.de header.s=susede2_rsa header.b="j7lsJgJ/";
	dkim=pass header.d=suse.de header.s=susede2_ed25519 header.b=FD4DGu3O
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1788263161; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=UNR1ZtUXqeFxjl7a4LYkrTsdWlDZ1XMW3bvG4buQpuw=;
	b=j7lsJgJ/ibzxcGc0Zk+nc6sIXpGLZ+BnCG71/C4XqNDQ/+YlgapM3VgLPd0wBgjGJVTM9E
	PPE4X7nGWIhJgm8PMi7DLhk4uUv3gwqJbrfzXDKoyHGNucw9BN4dtIbjH/s9OHVwjY1lhu
	0U/jIiabYGEFnLAzCBHy8n8csNU70TM=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1788263161;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=UNR1ZtUXqeFxjl7a4LYkrTsdWlDZ1XMW3bvG4buQpuw=;
	b=FD4DGu3OSkPCc9LXIviTh/R3QhMU/Lh3e7/ygKBScncuBBF5J8caJBAGMHF98iN6CG2RNz
	q/s94ChwbXh5gGCw==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id F03301369E;
	Tue,  1 Sep 2026 11:46:00 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id MMI8Ofi6lmqQTQAAD6G6ig
	(envelope-from <tzimmermann@suse.de>); Tue, 01 Sep 2026 11:46:00 +0000
Message-ID: <00e6bf78-aff7-422e-8ec9-024d9f10e4d0@suse.de>
Date: Tue, 1 Sep 2026 13:46:00 +0200
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 3/4] drm/virtio: create blend mode property on cursor
 plane
To: Qinyun Tan <qinyuntan@linux.alibaba.com>, dri-devel@lists.freedesktop.org
Cc: airlied@redhat.com, jfalempe@redhat.com, kraxel@redhat.com,
 dmitry.osipenko@collabora.com, hansg@kernel.org,
 maarten.lankhorst@linux.intel.com, mripard@kernel.org, simona@ffwll.ch,
 leandro.ribeiro@collabora.com, daniels@collabora.com,
 pekka.paalanen@collabora.com, virtualization@lists.linux.dev,
 spice-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org
References: <20260901083234.1828755-1-qinyuntan@linux.alibaba.com>
 <20260901083234.1828755-4-qinyuntan@linux.alibaba.com>
Content-Language: en-US
From: Thomas Zimmermann <tzimmermann@suse.de>
Autocrypt: addr=tzimmermann@suse.de; keydata=
 xsBNBFs50uABCADEHPidWt974CaxBVbrIBwqcq/WURinJ3+2WlIrKWspiP83vfZKaXhFYsdg
 XH47fDVbPPj+d6tQrw5lPQCyqjwrCPYnq3WlIBnGPJ4/jreTL6V+qfKRDlGLWFjZcsrPJGE0
 BeB5BbqP5erN1qylK9i3gPoQjXGhpBpQYwRrEyQyjuvk+Ev0K1Jc5tVDeJAuau3TGNgah4Yc
 hdHm3bkPjz9EErV85RwvImQ1dptvx6s7xzwXTgGAsaYZsL8WCwDaTuqFa1d1jjlaxg6+tZsB
 9GluwvIhSezPgnEmimZDkGnZRRSFiGP8yjqTjjWuf0bSj5rUnTGiyLyRZRNGcXmu6hjlABEB
 AAHNJ1Rob21hcyBaaW1tZXJtYW5uIDx0emltbWVybWFubkBzdXNlLmRlPsLAjgQTAQgAOAIb
 AwULCQgHAgYVCgkICwIEFgIDAQIeAQIXgBYhBHIX+6yM6c9jRKFo5WgNwR1TC3ojBQJftODH
 AAoJEGgNwR1TC3ojx1wH/0hKGWugiqDgLNXLRD/4TfHBEKmxIrmfu9Z5t7vwUKfwhFL6hqvo
 lXPJJKQpQ2z8+X2vZm/slsLn7J1yjrOsoJhKABDi+3QWWSGkaGwRJAdPVVyJMfJRNNNIKwVb
 U6B1BkX2XDKDGffF4TxlOpSQzdtNI/9gleOoUA8+jy8knnDYzjBNOZqLG2FuTdicBXblz0Mf
 vg41gd9kCwYXDnD91rJU8tzylXv03E75NCaTxTM+FBXPmsAVYQ4GYhhgFt8S2UWMoaaABLDe
 7l5FdnLdDEcbmd8uLU2CaG4W2cLrUaI4jz2XbkcPQkqTQ3EB67hYkjiEE6Zy3ggOitiQGcqp
 j//OwE0EWznS4AEIAMYmP4M/V+T5RY5at/g7rUdNsLhWv1APYrh9RQefODYHrNRHUE9eosYb
 T6XMryR9hT8XlGOYRwKWwiQBoWSDiTMo/Xi29jUnn4BXfI2px2DTXwc22LKtLAgTRjP+qbU6
 3Y0xnQN29UGDbYgyyK51DW3H0If2a3JNsheAAK+Xc9baj0LGIc8T9uiEWHBnCH+RdhgATnWW
 GKdDegUR5BkDfDg5O/FISymJBHx2Dyoklv5g4BzkgqTqwmaYzsl8UxZKvbaxq0zbehDda8lv
 hFXodNFMAgTLJlLuDYOGLK2AwbrS3Sp0AEbkpdJBb44qVlGm5bApZouHeJ/+n+7r12+lqdsA
 EQEAAcLAdgQYAQgAIAIbDBYhBHIX+6yM6c9jRKFo5WgNwR1TC3ojBQJftOH6AAoJEGgNwR1T
 C3ojVSkIALpAPkIJPQoURPb1VWjh34l0HlglmYHvZszJWTXYwavHR8+k6Baa6H7ufXNQtThR
 yIxJrQLW6rV5lm7TjhffEhxVCn37+cg0zZ3j7zIsSS0rx/aMwi6VhFJA5hfn3T0TtrijKP4A
 SAQO9xD1Zk9/61JWk8OysuIh7MXkl0fxbRKWE93XeQBhIJHQfnc+YBLprdnxR446Sh8Wn/2D
 Ya8cavuWf2zrB6cZurs048xe0UbSW5AOSo4V9M0jzYI4nZqTmPxYyXbm30Kvmz0rYVRaitYJ
 4kyYYMhuULvrJDMjZRvaNe52tkKAvMevcGdt38H4KSVXAylqyQOW5zvPc4/sq9c=
In-Reply-To: <20260901083234.1828755-4-qinyuntan@linux.alibaba.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Level: 
X-Rspamd-Action: no action
X-Rspamd-Server: rspamd2.dmz-prg2.suse.org
X-Rspamd-Queue-Id: 86FBB1FB3B
X-Spamd-Result: default: False [-5.51 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	DWL_DNSWL_LOW(-1.00)[suse.de:dkim];
	R_DKIM_ALLOW(-0.20)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	NEURAL_HAM_SHORT(-0.20)[-0.999];
	MIME_GOOD(-0.10)[text/plain];
	MX_GOOD(-0.01)[];
	DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	RBL_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	ARC_NA(0.00)[];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[16];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[suse.de:+];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_TWO(0.00)[2];
	FROM_EQ_ENVFROM(0.00)[];
	RCVD_TLS_ALL(0.00)[];
	DNSWL_BLOCKED(0.00)[2a07:de40:b281:106:10:150:64:167:received];
	RECEIVED_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:106:10:150:64:167:received];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:rdns,imap1.dmz-prg2.suse.org:helo,suse.com:url,alibaba.com:email,suse.de:dkim,suse.de:email,suse.de:mid]
X-Spam-Flag: NO
X-Spam-Score: -5.51



Am 01.09.26 um 10:32 schrieb Qinyun Tan:
> Since commit 860e748bddcc ("drm: ensure blend mode supported if pixel
> format with alpha exposed"), drm_mode_config_validate() warns when a
> plane exposes an alpha pixel format but not the "pixel blend mode"
> property. The virtio-gpu cursor plane (HOST_ARGB8888) trips this.
>
> The virtio-gpu specification does not define the cursor alpha
> semantics. The host forwards the cursor pixels verbatim to its display
> frontends, and the remote cursor protocols among them (SPICE alpha
> cursors, the VNC "Cursor With Alpha" encoding) both define
> pre-multiplied alpha, matching what userspace has always assumed when
> the property is not attached. Expose a "pixel blend mode" property
> advertising only DRM_MODE_BLEND_PREMULTI to make these semantics
> explicit and silence the warning. The primary plane only exposes
> HOST_XRGB8888, so the call is gated to the cursor. No functional
> change.
>
> Fixes: 860e748bddcc ("drm: ensure blend mode supported if pixel format with alpha exposed")
> Signed-off-by: Qinyun Tan <qinyuntan@linux.alibaba.com>

Reviewed-by: Thomas Zimmermann <tzimmermann@suse.de>

> ---
> v2: no code change; explain the protocol-level justification for
> PREMULTI in the commit message.
>
>   drivers/gpu/drm/virtio/virtgpu_plane.c | 4 ++++
>   1 file changed, 4 insertions(+)
>
> diff --git a/drivers/gpu/drm/virtio/virtgpu_plane.c b/drivers/gpu/drm/virtio/virtgpu_plane.c
> index 1d1b27ece62a7..640815af40980 100644
> --- a/drivers/gpu/drm/virtio/virtgpu_plane.c
> +++ b/drivers/gpu/drm/virtio/virtgpu_plane.c
> @@ -24,6 +24,7 @@
>    */
>   
>   #include <drm/drm_atomic_helper.h>
> +#include <drm/drm_blend.h>
>   #include <drm/drm_damage_helper.h>
>   #include <drm/drm_fourcc.h>
>   #include <drm/drm_gem_atomic_helper.h>
> @@ -609,6 +610,9 @@ struct drm_plane *virtio_gpu_plane_init(struct virtio_gpu_device *vgdev,
>   
>   	if (type == DRM_PLANE_TYPE_PRIMARY)
>   		drm_plane_enable_fb_damage_clips(plane);
> +	else if (type == DRM_PLANE_TYPE_CURSOR)
> +		drm_plane_create_blend_mode_property(plane,
> +						     BIT(DRM_MODE_BLEND_PREMULTI));
>   
>   	return plane;
>   }

-- 
--
Thomas Zimmermann
Graphics Driver Developer
SUSE Software Solutions Germany GmbH
Frankenstr. 146, 90461 Nürnberg, Germany, www.suse.com
GF: Jochen Jaser, Andrew McDonald, (HRB 36809, AG Nürnberg)


