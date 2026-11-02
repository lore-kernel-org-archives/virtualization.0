Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=195.135.223.131
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793620996;
	b=dK1OFoB4qpxUHk/vzK2QHNMeeshb5zh4tI+aq1bGy1FBM9boCK7wO+LJMNQTg2LaIpR4
	 O30E+edNmVbsCRVJUEyqIS4iEIiIcuBcsubIkEbz0G3bbtmiKt0RfkPuctdrQD1eUDwS4
	 IluwAk/nK322S8CaI1UFzRh053588Ga8Q0xi4Kut/2JrXRm/hRkTyezXTJZ6QSoa49akA
	 2KnG+URFDP09kVQNwPdRYcE0fHotbbEGzvXA9b/7Aq2k/yz0cEZPIG89trSykmzX5tq6/
	 4r+/wtZcM5uEP8PC4jFx4ZNlgBNNcU4Ptuy/3/YAr31MKsDuKk3NC6maPUQlrPWyDWw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793620996;
	h=DMARC-Filter:Received:DKIM-Signature:DKIM-Signature:DKIM-Signature:
	 DKIM-Signature:Received:Received:Message-ID:Date:MIME-Version:
	 User-Agent:Subject:To:Cc:References:Content-Language:From:Autocrypt:
	 In-Reply-To:Content-Type:Content-Transfer-Encoding:X-Rspamd-Queue-Id:
	 X-Spam-Level:X-Rspamd-Server:X-Rspamd-Action:X-Spam-Flag:
	 X-Spamd-Result:X-Spam-Score;
	bh=frqkDGBD+6EVVRqi/tZxj+Mhl2t78i65eP2cIT8s4Wg=;
	b=in3Pas6eiqj/wN00ceQJOlZxMelIKNW2yJn6Ur27C5QDoWB3fmNR3DKhinjFYDLz65/P
	 pOgBlborVyqXrQPnwZSwIL/bmqhNrF72vfW0CpiMDpWtU6+PYRKwRJudvSWmztz2nAkwM
	 HtGB9nqLRnb0GIYmtUCj87CwdEK2rn7wb4d8FqWki69KYjqlpGZb21BJsXxto0DzM0B5d
	 /fx77Zg3FN0oi/Aeyt2GR1bcGkVUIsJmwHzDrnvSdXhePikyK57QlCGcawZToM0H3dNpv
	 99aRAFtd+Pi9g3FYNvewnRQlN5Kfy8zbKWDq16U1gjfmfSzCS03EeoMgCUuxGm+D+Qw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=suse.de;
	spf=pass smtp.mailfrom=suse.de;
	dkim=pass header.d=suse.de header.i=@suse.de header.a=rsa-sha256 header.s=susede2_rsa header.b="FgmgBtA/";
	dkim=pass header.d=suse.de header.i=@suse.de header.a=ed25519-sha256 header.s=susede2_ed25519 header.b=bIvpuomS;
	dkim=pass header.d=suse.de header.i=@suse.de header.a=rsa-sha256 header.s=susede2_rsa header.b="FgmgBtA/";
	dkim=neutral header.d=suse.de header.i=@suse.de header.a=ed25519-sha256 header.s=susede2_ed25519 header.b=bIvpuomS;
	arc=none smtp.remote-ip=195.135.223.131
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 88B25606A327;
	Mon,  2 Nov 2026 12:03:15 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 88B25606A327
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=suse.de header.i=@suse.de header.a=rsa-sha256 header.s=susede2_rsa header.b=FgmgBtA/;
	dkim=pass header.d=suse.de header.i=@suse.de header.a=ed25519-sha256 header.s=susede2_ed25519 header.b=bIvpuomS;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.a=rsa-sha256 header.s=susede2_rsa header.b=FgmgBtA/;
	dkim=neutral header.d=suse.de header.i=@suse.de header.a=ed25519-sha256 header.s=susede2_ed25519 header.b=bIvpuomS
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 66E5D1F798;
	Mon,  2 Nov 2026 12:03:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1793620993; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=frqkDGBD+6EVVRqi/tZxj+Mhl2t78i65eP2cIT8s4Wg=;
	b=FgmgBtA/1V/R/fq5ql6+x+5DkKvXeHQGgyfYlDEEV1YZSuRwqinjrfcmnCF87sCe8yJwxb
	RmkWaJyra46Qndkrv3/lYq9+V6knXJuHzNkMeAcRc9EbCIcnvB4skGfSX5yfw25N5xXlRm
	msDDm6hOU8jSm3/O2ikrKMY4oooWeVg=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1793620993;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=frqkDGBD+6EVVRqi/tZxj+Mhl2t78i65eP2cIT8s4Wg=;
	b=bIvpuomSKBWgxbz6YyufjD00rn19p7qjttKduwu7BfXRlzUV2lu0wwbE/KPtIc+2uBSfvW
	H8ir5uV24KXPiTDw==
Authentication-Results: smtp-out2.suse.de;
	dkim=pass header.d=suse.de header.s=susede2_rsa header.b="FgmgBtA/";
	dkim=pass header.d=suse.de header.s=susede2_ed25519 header.b=bIvpuomS
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1793620993; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=frqkDGBD+6EVVRqi/tZxj+Mhl2t78i65eP2cIT8s4Wg=;
	b=FgmgBtA/1V/R/fq5ql6+x+5DkKvXeHQGgyfYlDEEV1YZSuRwqinjrfcmnCF87sCe8yJwxb
	RmkWaJyra46Qndkrv3/lYq9+V6knXJuHzNkMeAcRc9EbCIcnvB4skGfSX5yfw25N5xXlRm
	msDDm6hOU8jSm3/O2ikrKMY4oooWeVg=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1793620993;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=frqkDGBD+6EVVRqi/tZxj+Mhl2t78i65eP2cIT8s4Wg=;
	b=bIvpuomSKBWgxbz6YyufjD00rn19p7qjttKduwu7BfXRlzUV2lu0wwbE/KPtIc+2uBSfvW
	H8ir5uV24KXPiTDw==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id E3E26134B3;
	Mon,  2 Nov 2026 12:03:12 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id 1MC5IgB86GpZHQAAD6G6ig
	(envelope-from <tzimmermann@suse.de>); Mon, 02 Nov 2026 12:03:12 +0000
Message-ID: <69278b02-30f2-465d-8990-023165e1bc5d@suse.de>
Date: Mon, 2 Nov 2026 13:03:12 +0100
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Post: <mailto:virtualization@lists.linux.dev>
List-Help: <mailto:virtualization+help@lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
List-Owner: <mailto:virtualization+owner@lists.linux.dev>
Precedence: list
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4] drm/vblank: Don't arm vblank timer with invalid frame
 duration
To: =?UTF-8?B?VmlsbGUgU3lyasOkbMOk?= <ville.syrjala@linux.intel.com>
Cc: me@romanilin.is, louis.chauvet@bootlin.com,
 maarten.lankhorst@linux.intel.com, mripard@kernel.org, airlied@gmail.com,
 simona@ffwll.ch, javierm@redhat.com, dmitry.osipenko@collabora.com,
 regressions@leemhuis.info, peter.m.arnesen@gmail.com,
 dri-devel@lists.freedesktop.org, virtualization@lists.linux.dev,
 sashiko-reviews@lists.linux.dev
References: <20260914110004.211027-1-tzimmermann@suse.de>
 <auIMt8XmmaVykZTC@intel.com> <2c2f33cf-da6f-4e31-84bb-768778d7b063@suse.de>
 <auSIZNhP4DTj8Nb2@intel.com> <be8e41da-5ef1-4c37-a044-171ab1f32c6d@suse.de>
 <auSgII_W-FJJz44W@intel.com> <f406b2f6-cad9-411f-941a-7e4f26af3947@suse.de>
 <c874d311-f7b1-4a24-ab75-b502ba1c5e58@suse.de> <auTAf4ul_xzhk44v@intel.com>
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
In-Reply-To: <auTAf4ul_xzhk44v@intel.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: 66E5D1F798
X-Spam-Level: 
X-Rspamd-Server: rspamd2.dmz-prg2.suse.org
X-Rspamd-Action: no action
X-Spam-Flag: NO
X-Spamd-Result: default: False [-12.00 / 50.00];
	SUSE_INTERNAL_BYPASS(-9.00)[];
	BAYES_HAM(-3.00)[100.00%];
	SUSPICIOUS_RECIPS(1.50)[];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	R_DKIM_ALLOW(-0.20)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	MX_GOOD(-0.01)[];
	XM_UA_NO_VERSION(0.01)[];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	ARC_NA(0.00)[];
	RBL_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	RCPT_COUNT_TWELVE(0.00)[14];
	MIME_TRACE(0.00)[0:+];
	FREEMAIL_ENVRCPT(0.00)[gmail.com];
	RCVD_TLS_ALL(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_TWO(0.00)[2];
	DNSWL_BLOCKED(0.00)[2a07:de40:b281:106:10:150:64:167:received];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	FREEMAIL_CC(0.00)[romanilin.is,bootlin.com,linux.intel.com,kernel.org,gmail.com,ffwll.ch,redhat.com,collabora.com,leemhuis.info,lists.freedesktop.org,lists.linux.dev];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[];
	RECEIVED_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:106:10:150:64:167:received];
	DKIM_TRACE(0.00)[suse.de:+];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[gitlab.freedesktop.org:url,suse.com:url,suse.de:dkim,imap1.dmz-prg2.suse.org:rdns,imap1.dmz-prg2.suse.org:helo]
X-Spam-Score: -12.00

Hi

Am 30.10.26 um 17:06 schrieb Ville Syrjälä:
[...]
>>   
>>   		drm_mode_copy(&new_crtc_state->adjusted_mode, &new_crtc_state->mode);
>> +
>> +		if (!new_crtc_state->enable)
>> +			continue;
>> +
>> +		ret = drm_crtc_vblank_mode_fixup(crtc, &new_crtc_state->mode,
>> +						 &new_crtc_state->adjusted_mode);
> We don't want this hack applied to all drivers. It's a problem
> for a single driver, so that one driver should handle it.

By single driver, you mean virtgpu?

The bug is in Spice' vdagent, which specifies the pixel clock in kHz 
instead of Hz. (Apparently in the block at [1].)  AFAIU Spice, it runs 
on any graphics driver, with a strong preference for virtgpu or qxl. The 
docs and bug reports are somewhat contradictory. But I'd say that at 
least the drivers for virtual-guest graphics are affected; maybe others.

[1] 
https://gitlab.freedesktop.org/spice/linux/vd_agent/-/blob/master/src/vdagent/x11-randr.c?ref_type=heads#L321

Best regards
Thomas


>
>> +		if (!ret) {
>> +			drm_dbg_atomic(crtc->dev, "[CRTC:%d:%s] vblank fixup failed\n",
>> +				       crtc->base.id, crtc->name);
>> +			return -EINVAL;
>> +		}
>>   	}
>>   
>>   	for_each_new_connector_in_state(state, connector, new_conn_state, i) {
>> diff --git a/drivers/gpu/drm/drm_vblank.c b/drivers/gpu/drm/drm_vblank.c
>> index f90fb2d13e42..6e826c3b6c42 100644
>> --- a/drivers/gpu/drm/drm_vblank.c
>> +++ b/drivers/gpu/drm/drm_vblank.c
>> @@ -620,6 +620,74 @@ wait_queue_head_t *drm_crtc_vblank_waitqueue(struct drm_crtc *crtc)
>>   }
>>   EXPORT_SYMBOL(drm_crtc_vblank_waitqueue);
>>   
>> +static int drm_vblank_validate_dotclock(u16 crtc_htotal, u16 crtc_vtotal, u32 flags, int dotclock)
>> +{
>> +	unsigned int frame_size;
>> +	u64 linedur_ns, framedur_ns;
>> +
>> +	if (dotclock <= 0)
>> +		return -EINVAL;
>> +
>> +	frame_size = (unsigned int)crtc_htotal * (unsigned int)crtc_vtotal;
>> +
>> +	/*
>> +	 * Convert scanline length in pixels and video dot clock to line duration
>> +	 * and frame duration in nanoseconds.
>> +	 */
>> +	linedur_ns  = div_u64((u64)crtc_htotal * 1000000, dotclock);
>> +	framedur_ns = div_u64((u64)frame_size * 1000000, dotclock);
>> +
>> +	/*
>> +	 * Fields of interlaced scanout modes are only half a frame duration.
>> +	 */
>> +	if (flags & DRM_MODE_FLAG_INTERLACE)
>> +		framedur_ns /= 2;
>> +
>> +	if (linedur_ns > INT_MAX || framedur_ns > INT_MAX)
>> +		return -ERANGE; /* dot clock too low */
>> +
>> +	return 0;
>> +}
>> +
>> +bool drm_crtc_vblank_mode_fixup(struct drm_crtc *crtc, const struct drm_display_mode *mode,
>> +				struct drm_display_mode *adjusted_mode)
>> +{
>> +	struct drm_device *dev = crtc->dev;
>> +	unsigned int pipe = drm_crtc_index(crtc);
>> +	int dotclock = adjusted_mode->crtc_clock;
>> +	int ret;
>> +
>> +	if (!drm_dev_has_vblank(dev))
>> +		return true;
>> +
>> +	if (drm_WARN_ON(dev, pipe >= dev->num_crtcs))
>> +		return false;
>> +
>> +	ret = drm_vblank_validate_dotclock(adjusted_mode->crtc_htotal,
>> +					   adjusted_mode->crtc_vtotal,
>> +					   adjusted_mode->flags, dotclock);
>> +	if (ret == -ERANGE) {
>> +		int dotclock_1000;
>> +
>> +		/*
>> +		 * SPICE' vd_agent has a bug where it specifies the dot clock in kHz
>> +		 * instead of Hz. Setting up a vblank interrupt or timer for such a
>> +		 * mode overflows the calculation in drm_calc_timestamping_constants().
>> +		 * An errno code of ERANGE specifically points to this problem. Try
>> +		 * converting the dot clock to Hz and validate again.
>> +		 */
>> +		if (check_mul_overflow(dotclock, 1000, &dotclock_1000)) {
>> +			ret = drm_vblank_validate_dotclock(adjusted_mode->crtc_htotal,
>> +							   adjusted_mode->crtc_vtotal,
>> +							   adjusted_mode->flags, dotclock_1000);
>> +			if (!ret)
>> +				adjusted_mode->crtc_clock = dotclock_1000;
>> +		}
>> +	}
>> +
>> +	return !ret;
>> +}
>> +EXPORT_SYMBOL(drm_crtc_vblank_mode_fixup);
>>   
>>   /**
>>    * drm_calc_timestamping_constants - calculate vblank timestamp constants
>> diff --git a/include/drm/drm_vblank.h b/include/drm/drm_vblank.h
>> index 2fcef9c0f5b1..a3628c477f59 100644
>> --- a/include/drm/drm_vblank.h
>> +++ b/include/drm/drm_vblank.h
>> @@ -311,6 +311,8 @@ void drm_crtc_vblank_on(struct drm_crtc *crtc);
>>   u64 drm_crtc_accurate_vblank_count(struct drm_crtc *crtc);
>>   void drm_crtc_vblank_restore(struct drm_crtc *crtc);
>>   
>> +bool drm_crtc_vblank_mode_fixup(struct drm_crtc *crtc, const struct drm_display_mode *mode,
>> +				struct drm_display_mode *adjusted_mode);
>>   void drm_calc_timestamping_constants(struct drm_crtc *crtc,
>>   				     const struct drm_display_mode *mode);
>>   wait_queue_head_t *drm_crtc_vblank_waitqueue(struct drm_crtc *crtc);
>> -- 
>> 2.56.0
>>
>

-- 
--
Thomas Zimmermann
Graphics Driver Developer
SUSE Software Solutions Germany GmbH
Frankenstr. 146, 90461 Nürnberg, Germany, www.suse.com
GF: Stefan Gaiser, Jochen Jaser, Abhinav Puri, (HRB 36809, AG Nürnberg)


