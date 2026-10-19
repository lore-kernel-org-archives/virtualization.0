Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D454E48C40B
	for <virtualization@lists.linux.dev>; Mon, 19 Oct 2026 07:27:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792394855; cv=none; b=egh3hH/eetghjxBKsjEYWeOiewSE+0fpRhx24i9WytczZdVnsWa4k2Zhsr7OsXGTCDhTI3aGDiX79WnqZAfekPS3sY3Ev95JXU3KinNZzVtONh39mKmKd1sQEjahFRUKrLV/jVHtxqLzEYDpVJxYUvQppxv/3FFe85s9K51tmNE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792394855; c=relaxed/simple;
	bh=bqrg4G8cr5p+2Mmdoh8Z8d3C8MJQK+UFJ0LEd5n1mXU=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Z2VHRjJY9aC7GI+cDXdHFthg6Kp+S/71AtJYKHr+bih4diahykN1p16vTr4g+5kScC2LUQ+oU4MTLYliPaKXKwphb9NCsMZJO95B3R7EpOqpnNaZ13BAEBPCwbw1ggVhs4PRw4RWg1bv80PEyAhZwecvOz+ALMsAGxizAA1we2o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de; spf=pass smtp.mailfrom=suse.de; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=aEE1aBwN; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=g28J2IZr; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=y0vs1p13; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=jVnNHByn; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="aEE1aBwN";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="g28J2IZr";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="y0vs1p13";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="jVnNHByn"
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id E10AA21EE0;
	Mon, 19 Oct 2026 07:27:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1792394852; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=8gwtEvnBP0BVtb6VtjfUzVpvxKMZWMiqNCiCewKifPI=;
	b=aEE1aBwNaUsYCvtYkgJT0aubqeudC+6DC5FERQaNMZqA/VQV016QVcmT5o4ySIKuXVM58d
	i24qZ1Dg1VsLcY4t4bIGxQPukc5K8DfPIiICxR5+RAccK8LVydXfX/WmCNpYC+Dh/nslOo
	YBt8CZNhy2FfZgv4l1UGxnEbVclYOgY=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1792394852;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=8gwtEvnBP0BVtb6VtjfUzVpvxKMZWMiqNCiCewKifPI=;
	b=g28J2IZrZK5U1x3oNoMxiviKFQVX77ZoIDu/RJJXQjQAsardnBaDD7sLjloZFbAi/ii197
	tTJM0c9j1H1vyYDg==
Authentication-Results: smtp-out1.suse.de;
	dkim=pass header.d=suse.de header.s=susede2_rsa header.b=y0vs1p13;
	dkim=pass header.d=suse.de header.s=susede2_ed25519 header.b=jVnNHByn
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1792394851; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=8gwtEvnBP0BVtb6VtjfUzVpvxKMZWMiqNCiCewKifPI=;
	b=y0vs1p13x2BUW2wsa8KfSlJMy7xFLxC4jhXhWoK4IV6b9FDmlXi6AcZY3zadOmBGPcsdLv
	aujF57TytioXfG6LzgXsQKYWdrpBE8+soUeO0QCExo+qMQJa+MF2XgTmSTl62n41mi5pll
	AigHcK6NJHc2BodA7jWWGtG4nNM+CVY=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1792394851;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=8gwtEvnBP0BVtb6VtjfUzVpvxKMZWMiqNCiCewKifPI=;
	b=jVnNHBynE+nXE7Qu7joKu6WKymIxNks9qXyezA5EA3enbXJdZ8k7D5VppiwjVvu20Ua+Xd
	sMgEE7WDf2hAsWAQ==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 75BA4134B3;
	Mon, 19 Oct 2026 07:27:31 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id ha4aFGPG1WpFIgAAD6G6ig
	(envelope-from <tzimmermann@suse.de>); Mon, 19 Oct 2026 07:27:31 +0000
Message-ID: <f91ca908-689f-4732-bfb3-0e254c22361d@suse.de>
Date: Mon, 19 Oct 2026 09:27:30 +0200
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] drm/virtio: inline drm_simple_encoder_init()
To: Melih Emik <melihemik@noirlang.tr>, airlied@redhat.com,
 kraxel@redhat.com, dmitry.osipenko@collabora.com
Cc: gurchetansingh@chromium.org, olvaffe@gmail.com,
 maarten.lankhorst@linux.intel.com, mripard@kernel.org, simona@ffwll.ch,
 dri-devel@lists.freedesktop.org, virtualization@lists.linux.dev,
 linux-kernel@vger.kernel.org
References: <20261018112844.360262-1-melihemik@noirlang.tr>
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
In-Reply-To: <20261018112844.360262-1-melihemik@noirlang.tr>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Rspamd-Action: no action
X-Spam-Score: -4.50
X-Spam-Flag: NO
X-Spamd-Result: default: False [-4.50 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	R_DKIM_ALLOW(-0.20)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	XM_UA_NO_VERSION(0.01)[];
	MX_GOOD(-0.01)[];
	RCPT_COUNT_TWELVE(0.00)[12];
	ARC_NA(0.00)[];
	RBL_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	MIME_TRACE(0.00)[0:+];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	FREEMAIL_ENVRCPT(0.00)[gmail.com];
	RCVD_TLS_ALL(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_TWO(0.00)[2];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	FREEMAIL_CC(0.00)[chromium.org,gmail.com,linux.intel.com,kernel.org,ffwll.ch,lists.freedesktop.org,lists.linux.dev,vger.kernel.org];
	DNSWL_BLOCKED(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	RECEIVED_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:106:10:150:64:167:received];
	MID_RHS_MATCH_FROM(0.00)[];
	DKIM_TRACE(0.00)[suse.de:+];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.de:dkim,imap1.dmz-prg2.suse.org:helo,imap1.dmz-prg2.suse.org:rdns,suse.com:url]
X-Spam-Level: 
X-Rspamd-Queue-Id: E10AA21EE0
X-Rspamd-Server: rspamd2.dmz-prg2.suse.org

Hi

Am 18.10.26 um 13:28 schrieb Melih Emik:
> The helper drm_simple_encoder_init() is deprecated because it adds an
> unnecessary intermediate layer between atomic modesetting and DRM drivers,
> as documented in Documentation/gpu/todo.rst.
>
> Inline the functionality by calling drm_encoder_init() directly with a
> local instance of struct drm_encoder_funcs. This allows removing the
> dependency on <drm/drm_simple_kms_helper.h> in favor of
> <drm/drm_encoder.h>.

These have all been fixed already. You need to work on drm-tip, drm-misc 
or a driver-specific git tree for development.

Best regards
Thomas


>
> Signed-off-by: Melih Emik <melihemik@noirlang.tr>
> ---
> Tested:
> - Compiled with W=1 on x86_64 with zero warnings or errors.
> - Verified with lockdep and debug mutexes enabled
>    (CONFIG_PROVE_LOCKING=y, CONFIG_DEBUG_MUTEXES=y).
> - Boot-tested full bzImage in QEMU with -device virtio-gpu-pci and
>    initcall_debug, confirming successful probe and initialization
>    (probe of virtio0 with driver virtio_gpu returned 0) and zero
>    lockdep/kernel warnings.
> - Verified with scripts/checkpatch.pl (0 errors, 0 warnings).
>
>   drivers/gpu/drm/virtio/virtgpu_display.c | 11 +++++++++--
>   1 file changed, 9 insertions(+), 2 deletions(-)
>
> diff --git a/drivers/gpu/drm/virtio/virtgpu_display.c b/drivers/gpu/drm/virtio/virtgpu_display.c
> index a1a875a0c706..1bdbf452d111 100644
> --- a/drivers/gpu/drm/virtio/virtgpu_display.c
> +++ b/drivers/gpu/drm/virtio/virtgpu_display.c
> @@ -28,11 +28,11 @@
>   #include <drm/drm_atomic_helper.h>
>   #include <drm/drm_damage_helper.h>
>   #include <drm/drm_edid.h>
> +#include <drm/drm_encoder.h>
>   #include <drm/drm_fourcc.h>
>   #include <drm/drm_gem_framebuffer_helper.h>
>   #include <drm/drm_print.h>
>   #include <drm/drm_probe_helper.h>
> -#include <drm/drm_simple_kms_helper.h>
>   #include <drm/drm_vblank.h>
>   #include <drm/drm_vblank_helper.h>
>   
> @@ -232,6 +232,10 @@ static enum drm_mode_status virtio_gpu_conn_mode_valid(struct drm_connector *con
>   	return MODE_BAD;
>   }
>   
> +static const struct drm_encoder_funcs virtio_gpu_encoder_funcs = {
> +	.destroy = drm_encoder_cleanup,
> +};
> +
>   static const struct drm_encoder_helper_funcs virtio_gpu_enc_helper_funcs = {
>   	.mode_set   = virtio_gpu_enc_mode_set,
>   	.enable     = virtio_gpu_enc_enable,
> @@ -306,7 +310,10 @@ static int vgdev_output_init(struct virtio_gpu_device *vgdev, int index)
>   	if (vgdev->has_edid)
>   		drm_connector_attach_edid_property(connector);
>   
> -	drm_simple_encoder_init(dev, encoder, DRM_MODE_ENCODER_VIRTUAL);
> +	ret = drm_encoder_init(dev, encoder, &virtio_gpu_encoder_funcs,
> +			       DRM_MODE_ENCODER_VIRTUAL, NULL);
> +	if (ret)
> +		return ret;
>   	drm_encoder_helper_add(encoder, &virtio_gpu_enc_helper_funcs);
>   	encoder->possible_crtcs = 1 << index;
>   

-- 
--
Thomas Zimmermann
Graphics Driver Developer
SUSE Software Solutions Germany GmbH
Frankenstr. 146, 90461 Nürnberg, Germany, www.suse.com
GF: Stefan Gaiser, Jochen Jaser, Abhinav Puri, (HRB 36809, AG Nürnberg)


