Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 331AC2DEA9B
	for <virtualization@lists.linux.dev>; Mon,  4 May 2026 08:36:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777883789; cv=none; b=uX0C/FP72aRCjhrX1h8HviKOB2C+a6qK3k0toaBFxOS2dRnoW+m7nSmKaHu8mKkphXMShZmzo/CXXvwLdceaufrGkuVj4Jcc24K/KsoH1+QYZJv+J++vS4LkTN1NfFUYtjNBOzRADohoQfzyoMykp2pfbOz+ca72fzpBp7tydnE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777883789; c=relaxed/simple;
	bh=GXNnxHMf7JqqaY3i4gT9/2mDjGXVwaj202ljpOt9mhw=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Q/3+jPX/ssf5YLCQjNAdmtODSO7rETBfC6BCDIvw+6flkVEKzp91pSPMy++RW31lmkKciSUDiFEkBKhxIXvmnKCQaqs5buKmqrqsWbQoVB/p7MRrpodKb9lByGQs5XQadi3BH9NAN8ggN49OsmKCsdQ4+biW4LDSaLBMRYgSzO8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de; spf=pass smtp.mailfrom=suse.de; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=nms4AKjY; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=3FBLLtjJ; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=nms4AKjY; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=3FBLLtjJ; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="nms4AKjY";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="3FBLLtjJ";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="nms4AKjY";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="3FBLLtjJ"
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 854A16AD9A;
	Mon,  4 May 2026 08:36:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1777883786; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=oIBG3/KUD7vA8nbYJxgOUipfNBkG8PolgTKOtufuuxo=;
	b=nms4AKjYVVHo/CyfU76t3uCNR5N4jLMXQ04lxo58pKFUEeXeZ7gyGnzzesB1r4hyZpfF+Z
	jydiBaR13HjKq3MSL8t64sw7eWosYhxEk82Kn/+YbPPIspYUR1brZU2OCgVTgmX/OEbjfV
	DNnRmaas8s/ZDjmOjxcx/+xt6HahNmE=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1777883786;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=oIBG3/KUD7vA8nbYJxgOUipfNBkG8PolgTKOtufuuxo=;
	b=3FBLLtjJF8kf+1EY/MgtvwXag5thPMbqk0qLR0OUon/M/z1EYHkZ9jdZ1gHgVwFMMCa10B
	86J9BoKytSN7n5DA==
Authentication-Results: smtp-out1.suse.de;
	dkim=pass header.d=suse.de header.s=susede2_rsa header.b=nms4AKjY;
	dkim=pass header.d=suse.de header.s=susede2_ed25519 header.b=3FBLLtjJ
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1777883786; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=oIBG3/KUD7vA8nbYJxgOUipfNBkG8PolgTKOtufuuxo=;
	b=nms4AKjYVVHo/CyfU76t3uCNR5N4jLMXQ04lxo58pKFUEeXeZ7gyGnzzesB1r4hyZpfF+Z
	jydiBaR13HjKq3MSL8t64sw7eWosYhxEk82Kn/+YbPPIspYUR1brZU2OCgVTgmX/OEbjfV
	DNnRmaas8s/ZDjmOjxcx/+xt6HahNmE=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1777883786;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=oIBG3/KUD7vA8nbYJxgOUipfNBkG8PolgTKOtufuuxo=;
	b=3FBLLtjJF8kf+1EY/MgtvwXag5thPMbqk0qLR0OUon/M/z1EYHkZ9jdZ1gHgVwFMMCa10B
	86J9BoKytSN7n5DA==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 2F911593A3;
	Mon,  4 May 2026 08:36:26 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id iQ9uCYpa+GlRbAAAD6G6ig
	(envelope-from <tzimmermann@suse.de>); Mon, 04 May 2026 08:36:26 +0000
Message-ID: <42cab775-8673-477a-837a-908bd0273e95@suse.de>
Date: Mon, 4 May 2026 10:36:25 +0200
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] drm/bochs: Drop manual put on probe error path
To: Myeonghun Pak <mhun512@gmail.com>
Cc: Gerd Hoffmann <kraxel@redhat.com>,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>, David Airlie <airlied@gmail.com>,
 Simona Vetter <simona@ffwll.ch>, virtualization@lists.linux.dev,
 dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org
References: <20260424123506.32275-1-mhun512@gmail.com>
 <43bbfbcf-4a8d-4039-9ebf-24672b7e6d0a@suse.de>
 <CAGEsz8FrkbQEWZbxV3Q0NkSxhQka575uemKMQtTJQaCm44ByxQ@mail.gmail.com>
 <5ca1cea2-9761-46ff-a575-53af23e79b36@suse.de>
 <CAGEsz8F54LaiJYGD6i-nW7hDiLTu6FOi4Z8fzb8b4=+9-OEH+Q@mail.gmail.com>
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
In-Reply-To: <CAGEsz8F54LaiJYGD6i-nW7hDiLTu6FOi4Z8fzb8b4=+9-OEH+Q@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [-4.51 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	R_DKIM_ALLOW(-0.20)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	MX_GOOD(-0.01)[];
	DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	URIBL_BLOCKED(0.00)[imap1.dmz-prg2.suse.org:helo,imap1.dmz-prg2.suse.org:rdns,suse.de:mid,suse.de:dkim,suse.de:email,suse.com:url];
	FREEMAIL_TO(0.00)[gmail.com];
	FUZZY_RATELIMITED(0.00)[rspamd.com];
	MIME_TRACE(0.00)[0:+];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	ARC_NA(0.00)[];
	RBL_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	FREEMAIL_ENVRCPT(0.00)[gmail.com];
	RCVD_TLS_ALL(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_TWO(0.00)[2];
	DNSWL_BLOCKED(0.00)[2a07:de40:b281:104:10:150:64:97:from,2a07:de40:b281:106:10:150:64:167:received];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	FREEMAIL_CC(0.00)[redhat.com,linux.intel.com,kernel.org,gmail.com,ffwll.ch,lists.linux.dev,lists.freedesktop.org,vger.kernel.org];
	MID_RHS_MATCH_FROM(0.00)[];
	RECEIVED_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:106:10:150:64:167:received];
	RCPT_COUNT_SEVEN(0.00)[9];
	DKIM_TRACE(0.00)[suse.de:+];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	SPAMHAUS_XBL(0.00)[2a07:de40:b281:104:10:150:64:97:from]
X-Rspamd-Action: no action
X-Spam-Flag: NO
X-Spam-Score: -4.51
X-Spam-Level: 
X-Rspamd-Server: rspamd1.dmz-prg2.suse.org
X-Rspamd-Queue-Id: 854A16AD9A

Hi

Am 30.04.26 um 15:52 schrieb Myeonghun Pak:
> Thanks for the explanation.
>
> I see your point now. My patch treated uart_add_one_port() failure as 
> a fatal
> probe failure, but the current code is intentionally trying to keep 
> the driver
> alive so that other MAX3100 ports can still be available even if one 
> port cannot
> be instantiated.
>
> Please drop this patch. I will not pursue this direction.

Why? The was patch was good AFAICT. It's just missing a Fixes tag.

Best regards
Thomas

>
> Thanks,
> Myeonghun
>
> 2026년 4월 24일 (금) 오후 11:59, Thomas Zimmermann 
> <tzimmermann@suse.de>님이 작성:
>
>     Hi
>
>     Am 24.04.26 um 15:40 schrieb Myeonghun Pak:
>     > Hi Thomas,
>     >
>     > Thank you for your reply. I will ensure that the requested
>     |Fixes| tag
>     > and |stable| CC are included in the next patch I send.
>     >
>     > Regarding your request for information about AI usage and how the
>     > issue was identified:
>     >
>     >   * This issue was identified during our ongoing static-analysis
>     >     research while reviewing kernel code.
>     >     1
>     >   
>      <https://mail.google.com/mail/u/0/#all/%23thread-f:1863355320119932959>
>     >   * Specifically, it was found by an experimental static
>     analysis tool
>     >     that we are currently developing. The tool is not public
>     yet, so I
>     >     prefer not to disclose further project details at this stage.
>     >
>     >   * AI was used only for cross-review, not as the primary means of
>     >     finding or fixing the bug.
>     >   * I manually reviewed the code and verified the issue before
>     sending
>     >     the patch.
>     >
>     > I will incorporate your requests and this additional context,
>     and then
>     > resend the modified patch.
>
>     Thanks a lot.
>
>     Reviewed-by: Thomas Zimmermann <tzimmermann@suse.de>
>
>     Best regards
>     Thomas
>
>     >
>     > Thank you.
>     >
>     > Myeonghun Pak
>     >
>     >
>     > 2026년 4월 24일 (금) 오후 10:25, Thomas Zimmermann
>     > <tzimmermann@suse.de>님이 작성:
>     >
>     >     Hi,
>     >
>     >     please add fixes tags to all these patches you're sending. You
>     >     also need
>     >     to CC stable so that they can be backported easily. Also
>     list the AI
>     >     you're using to find and create these patches.
>     >
>     >     Best regards
>     >     Thomas
>     >
>     >     Am 24.04.26 um 14:34 schrieb Myeonghun Pak:
>     >     > bochs_pci_probe() allocates the DRM device with
>     >     devm_drm_dev_alloc(),
>     >     > which registers a devres action to drop the initial DRM device
>     >     reference
>     >     > on driver detach or probe failure.
>     >     >
>     >     > The error path currently calls drm_dev_put() manually. If
>     probe then
>     >     > returns an error, devres will run the registered release
>     action
>     >     and put
>     >     > the same device again, after the first put may already have
>     >     released it.
>     >     >
>     >     > Return the probe error directly and let devres own the
>     final put.
>     >     >
>     >     > Signed-off-by: Myeonghun Pak <mhun512@gmail.com>
>     >     > ---
>     >     >   drivers/gpu/drm/tiny/bochs.c | 10 +++-------
>     >     >   1 file changed, 3 insertions(+), 7 deletions(-)
>     >     >
>     >     > diff --git a/drivers/gpu/drm/tiny/bochs.c
>     >     b/drivers/gpu/drm/tiny/bochs.c
>     >     > index 222e4ae1ab..5d8dc5efec 100644
>     >     > --- a/drivers/gpu/drm/tiny/bochs.c
>     >     > +++ b/drivers/gpu/drm/tiny/bochs.c
>     >     > @@ -761,25 +761,21 @@ static int bochs_pci_probe(struct
>     pci_dev
>     >     *pdev, const struct pci_device_id *ent
>     >     >
>     >     >       ret = pcim_enable_device(pdev);
>     >     >       if (ret)
>     >     > -             goto err_free_dev;
>     >     > +             return ret;
>     >     >
>     >     >       pci_set_drvdata(pdev, dev);
>     >     >
>     >     >       ret = bochs_load(bochs);
>     >     >       if (ret)
>     >     > -             goto err_free_dev;
>     >     > +             return ret;
>     >     >
>     >     >       ret = drm_dev_register(dev, 0);
>     >     >       if (ret)
>     >     > -             goto err_free_dev;
>     >     > +             return ret;
>     >     >
>     >     >       drm_client_setup(dev, NULL);
>     >     >
>     >     >       return ret;
>     >     > -
>     >     > -err_free_dev:
>     >     > -     drm_dev_put(dev);
>     >     > -     return ret;
>     >     >   }
>     >     >
>     >     >   static void bochs_pci_remove(struct pci_dev *pdev)
>     >
>     >     --
>     >     --
>     >     Thomas Zimmermann
>     >     Graphics Driver Developer
>     >     SUSE Software Solutions Germany GmbH
>     >     Frankenstr. 146, 90461 Nürnberg, Germany, www.suse.com
>     <http://www.suse.com>
>     >     <http://www.suse.com>
>     >     GF: Jochen Jaser, Andrew McDonald, Werner Knoblich, (HRB
>     36809, AG
>     >     Nürnberg)
>     >
>     >
>
>     -- 
>     --
>     Thomas Zimmermann
>     Graphics Driver Developer
>     SUSE Software Solutions Germany GmbH
>     Frankenstr. 146, 90461 Nürnberg, Germany, www.suse.com
>     <http://www.suse.com>
>     GF: Jochen Jaser, Andrew McDonald, Werner Knoblich, (HRB 36809, AG
>     Nürnberg)
>
>

-- 
--
Thomas Zimmermann
Graphics Driver Developer
SUSE Software Solutions Germany GmbH
Frankenstr. 146, 90461 Nürnberg, Germany, www.suse.com
GF: Jochen Jaser, Andrew McDonald, Werner Knoblich, (HRB 36809, AG Nürnberg)


