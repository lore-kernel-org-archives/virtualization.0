Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 20DE31DED63
	for <virtualization@lists.linux.dev>; Wed,  1 Apr 2026 06:24:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775024677; cv=none; b=uHWUHjiT+RdGTy7yJtig65DarBkLzewrbHIrz+Psk+o8ww1IbEVTO/EblGKJ7ihETX3eQ9pVC15huVmpzfbV5WHNL7sBTXHzgoIhzDugEskSsj733b3TwUQqoJhKGLoFKz/hrA45ZvWLmcYRZLadZpDxdfisvOST6RVilMH2DUc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775024677; c=relaxed/simple;
	bh=cEb/sxyPv2rPVhv3t3hryULSRtHWPCchgqhpyvipU7Y=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=dZQoL/lN1Fyhkp8/RFw1v2w8Af6H0TZ6YD5lpVm/B29ezoXfJB9AWkHthTxkr+EOsewmB0IhhojaNaN82SjPZlFhi4NOZdq8YBPjC8OE+VMMaEP4mDBY1wqzsYc7YX1oELycxUMB0MkmxBr4nZYpBeGswjXdrITrT7iUUTq4QBU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de; spf=pass smtp.mailfrom=suse.de; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=hm71gxeV; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=xICUwHcY; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=hm71gxeV; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=xICUwHcY; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="hm71gxeV";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="xICUwHcY";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="hm71gxeV";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="xICUwHcY"
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 0230A5BCDD;
	Wed,  1 Apr 2026 06:24:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1775024674; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=WkMZFf1YLFOp20aiXd0j6w1gfYwVnV5uHLDkoTFp1VA=;
	b=hm71gxeVq4Y5jDWrOp1IRQlGBtXm055PclgbkYdk2uSd7HAp1I8QXZEjLsKZpZ6EBaS/7W
	Ae4dmOTNj/WGe93klKC7fDkvUWtmXVqXAE+LjdPzUzTXSSUpOMKbcWHp1pWWVPZcP1/FiZ
	QL+lAEFi2soaHPvzM5IYvt2neTJdDQs=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1775024674;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=WkMZFf1YLFOp20aiXd0j6w1gfYwVnV5uHLDkoTFp1VA=;
	b=xICUwHcYZd5rnO6eYrILOLkqy5w6rEmW0r71mVxc5rv18vdRURVJ1B+Q2SH3xZvi/UDLnD
	Xxq1pg/z2XPqe6CA==
Authentication-Results: smtp-out2.suse.de;
	dkim=pass header.d=suse.de header.s=susede2_rsa header.b=hm71gxeV;
	dkim=pass header.d=suse.de header.s=susede2_ed25519 header.b=xICUwHcY
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1775024674; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=WkMZFf1YLFOp20aiXd0j6w1gfYwVnV5uHLDkoTFp1VA=;
	b=hm71gxeVq4Y5jDWrOp1IRQlGBtXm055PclgbkYdk2uSd7HAp1I8QXZEjLsKZpZ6EBaS/7W
	Ae4dmOTNj/WGe93klKC7fDkvUWtmXVqXAE+LjdPzUzTXSSUpOMKbcWHp1pWWVPZcP1/FiZ
	QL+lAEFi2soaHPvzM5IYvt2neTJdDQs=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1775024674;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=WkMZFf1YLFOp20aiXd0j6w1gfYwVnV5uHLDkoTFp1VA=;
	b=xICUwHcYZd5rnO6eYrILOLkqy5w6rEmW0r71mVxc5rv18vdRURVJ1B+Q2SH3xZvi/UDLnD
	Xxq1pg/z2XPqe6CA==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 8F2F44A0B0;
	Wed,  1 Apr 2026 06:24:33 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id 1bgYISG6zGmnBwAAD6G6ig
	(envelope-from <tzimmermann@suse.de>); Wed, 01 Apr 2026 06:24:33 +0000
Message-ID: <47e26c77-4efe-414e-a851-67791bde3a8c@suse.de>
Date: Wed, 1 Apr 2026 08:24:32 +0200
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] drm/virtgpu: Add PM support for suspend/resume
To: Morris Pan <morris.pan@mediatek.com>, airlied@redhat.com,
 kraxel@redhat.com, dmitry.osipenko@collabora.com
Cc: srv_heupstream@mediatek.com, gurchetansingh@chromium.org,
 olvaffe@gmail.com, maarten.lankhorst@linux.intel.com, mripard@kernel.org,
 simona@ffwll.ch, dri-devel@lists.freedesktop.org,
 virtualization@lists.linux.dev
References: <20260401061050.1035881-1-morris.pan@mediatek.com>
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
In-Reply-To: <20260401061050.1035881-1-morris.pan@mediatek.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Rspamd-Action: no action
X-Rspamd-Server: rspamd2.dmz-prg2.suse.org
X-Spamd-Result: default: False [-4.51 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	R_DKIM_ALLOW(-0.20)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	MX_GOOD(-0.01)[];
	DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	FUZZY_RATELIMITED(0.00)[rspamd.com];
	RBL_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	ARC_NA(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[12];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	MIME_TRACE(0.00)[0:+];
	SPAMHAUS_XBL(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	FREEMAIL_ENVRCPT(0.00)[gmail.com];
	FREEMAIL_CC(0.00)[mediatek.com,chromium.org,gmail.com,linux.intel.com,kernel.org,ffwll.ch,lists.freedesktop.org,lists.linux.dev];
	RCVD_TLS_ALL(0.00)[];
	RCVD_COUNT_TWO(0.00)[2];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	DNSWL_BLOCKED(0.00)[2a07:de40:b281:104:10:150:64:97:from,2a07:de40:b281:106:10:150:64:167:received];
	RECEIVED_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:106:10:150:64:167:received];
	MID_RHS_MATCH_FROM(0.00)[];
	DKIM_TRACE(0.00)[suse.de:+];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.com:url,mediatek.com:email,suse.de:dkim,suse.de:mid,bootlin.com:url,imap1.dmz-prg2.suse.org:helo,imap1.dmz-prg2.suse.org:rdns]
X-Rspamd-Queue-Id: 0230A5BCDD
X-Spam-Flag: NO
X-Spam-Score: -4.51
X-Spam-Level: 

Hi

Am 01.04.26 um 08:10 schrieb Morris Pan:
> Add freeze/restore callbacks to handle system suspend/resume.
> During freeze, delete virtqueues and reset device.
> During restore, reinitialize virtqueues and mark device ready.
>
> Signed-off-by: Morris Pan <morris.pan@mediatek.com>
> ---
>   drivers/gpu/drm/virtio/virtgpu_drv.c | 40 +++++++++++++++++++++++++++-
>   1 file changed, 39 insertions(+), 1 deletion(-)
>
> diff --git a/drivers/gpu/drm/virtio/virtgpu_drv.c b/drivers/gpu/drm/virtio/virtgpu_drv.c
> index a5ce96fb8a1d..fbca0a82958c 100644
> --- a/drivers/gpu/drm/virtio/virtgpu_drv.c
> +++ b/drivers/gpu/drm/virtio/virtgpu_drv.c
> @@ -145,6 +145,40 @@ static void virtio_gpu_config_changed(struct virtio_device *vdev)
>   	schedule_work(&vgdev->config_changed_work);
>   }
>   
> +#ifdef CONFIG_PM_SLEEP
> +static int virtgpu_freeze(struct virtio_device *vdev)
> +{

I think you first need to call drm_mode_config_helper_suspend() [1] to 
stop DRM and save the current state.

[1] 
https://elixir.bootlin.com/linux/v6.19.10/source/drivers/gpu/drm/drm_modeset_helper.c#L179

> +	vdev->config->del_vqs(vdev);
> +	virtio_reset_device(vdev);
> +
> +	return 0;
> +}
> +
> +static int virtgpu_restore(struct virtio_device *vdev)
> +{
> +	int ret;
> +	struct virtqueue *vqs[2];
> +	struct drm_device *dev = vdev->priv;
> +	struct virtio_gpu_device *vgdev = dev->dev_private;
> +	struct virtqueue_info vqs_info[] = {
> +		{ "control", virtio_gpu_ctrl_ack },
> +		{ "cursor", virtio_gpu_cursor_ack },
> +	};
> +
> +	ret = virtio_find_vqs(vdev, 2, vqs, vqs_info, NULL);
> +	if (ret) {
> +		DRM_ERROR("failed to find virtio queues\n");
> +		return ret;
> +	}
> +
> +	vgdev->ctrlq.vq = vqs[0];
> +	vgdev->cursorq.vq = vqs[1];
> +	virtio_device_ready(vdev);

And here you have to call drm_mode_config_helper_resume() [2] to restore 
the DRM state from before the freeze.

[2] 
https://elixir.bootlin.com/linux/v6.19.10/source/drivers/gpu/drm/drm_modeset_helper.c#L227

Best regards
Thomas

> +
> +	return 0;
> +}
> +#endif
> +
>   static struct virtio_device_id id_table[] = {
>   	{ VIRTIO_ID_GPU, VIRTIO_DEV_ANY_ID },
>   	{ 0 },
> @@ -172,7 +206,11 @@ static struct virtio_driver virtio_gpu_driver = {
>   	.probe = virtio_gpu_probe,
>   	.remove = virtio_gpu_remove,
>   	.shutdown = virtio_gpu_shutdown,
> -	.config_changed = virtio_gpu_config_changed
> +	.config_changed = virtio_gpu_config_changed,
> +#ifdef CONFIG_PM_SLEEP
> +	.freeze = virtgpu_freeze,
> +	.restore = virtgpu_restore
> +#endif
>   };
>   
>   static int __init virtio_gpu_driver_init(void)

-- 
--
Thomas Zimmermann
Graphics Driver Developer
SUSE Software Solutions Germany GmbH
Frankenstr. 146, 90461 Nürnberg, Germany, www.suse.com
GF: Jochen Jaser, Andrew McDonald, Werner Knoblich, (HRB 36809, AG Nürnberg)


