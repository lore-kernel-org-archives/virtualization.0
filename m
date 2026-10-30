Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=195.135.223.131
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793374409;
	b=XkgGs9WLcenKc/M74tHVp/XZfJU6NS2fXLICDX3du2yvKBBBYUNegSIIeXFKtnh6gDao
	 K64v0cVHSQXMyzKn4Ltvg3sGeoZTmcLAys+ySvr9NRPYSDVvMI/sD/6p2EJLqHTSxusMa
	 mMz+Vno4dpvC27tqouRctMIy8PjLyngpJtrxTBxVfLh2fdVpAVCfX54gsD9BU23tid/p5
	 h2/BvamjNUiCGErkk/XTS3k56mOPPmrYJRg/Dvrh9rUQBAwqsdWlrJEMwAQad4r/Ychbh
	 bbCvKOs2U5tLiHNuZ0KCtdrZkbItosiO5tJZmKZgh6WIQbfG3ZcoSopStQl9k+ZC8SQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793374409;
	h=DMARC-Filter:Received:DKIM-Signature:DKIM-Signature:DKIM-Signature:
	 DKIM-Signature:Received:Received:Content-Type:Message-ID:Date:
	 MIME-Version:User-Agent:Subject:From:To:Cc:References:
	 Content-Language:Autocrypt:In-Reply-To:X-Spam-Flag:X-Spam-Level:
	 X-Spamd-Result:X-Spam-Score;
	bh=IYP01JhZVa5ugAr2uKMD9idrHqwuhB+ARU1Efs3ktAU=;
	b=vU1w7mHx8ynzH8iQ0m55Enq5tpwqraWVegOb7TFZJTaAjXeuKjKrfzeEQsCVouhiprWn
	 bVpa9vt53CzNf/DZPg7mCc0mahT1cEdrs4pWCuS6vKPvRFI+6WWXNgeJxb8Y23g2kuco9
	 jitwyNmog2W524QJS8chvcHEzo4QLCNWYs4Sb93GDIGE9/+HLECHQOgldNFcrvJf9gSAb
	 T91pxlmgC1TBCYMpBoNTU1TF0m3vCx1Sxw2z6xoCJWEp3IZfjJZ1ixCubCbnenKdMbJB4
	 gchYQnrQ7XupWBjJJH/n2GBYl2igI5zGHIW3k6v5yrtFF2YhBzOOxT7PZix9WBLf7Rw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=suse.de;
	spf=pass smtp.mailfrom=suse.de;
	dkim=pass header.d=suse.de header.i=@suse.de header.a=rsa-sha256 header.s=susede2_rsa header.b="p/R+CCDg";
	dkim=pass header.d=suse.de header.i=@suse.de header.a=ed25519-sha256 header.s=susede2_ed25519 header.b=7bnqxcm7;
	dkim=pass header.d=suse.de header.i=@suse.de header.a=rsa-sha256 header.s=susede2_rsa header.b=08NcNPEs;
	dkim=neutral header.d=suse.de header.i=@suse.de header.a=ed25519-sha256 header.s=susede2_ed25519 header.b=6im3jhmF;
	arc=none smtp.remote-ip=195.135.223.131
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F10B0606A31A;
	Fri, 30 Oct 2026 15:33:28 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org F10B0606A31A
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=suse.de header.i=@suse.de header.a=rsa-sha256 header.s=susede2_rsa header.b=p/R+CCDg;
	dkim=pass header.d=suse.de header.i=@suse.de header.a=ed25519-sha256 header.s=susede2_ed25519 header.b=7bnqxcm7;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.a=rsa-sha256 header.s=susede2_rsa header.b=08NcNPEs;
	dkim=neutral header.d=suse.de header.i=@suse.de header.a=ed25519-sha256 header.s=susede2_ed25519 header.b=6im3jhmF
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id C5C3A20D27;
	Fri, 30 Oct 2026 15:33:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1793374407; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=IYP01JhZVa5ugAr2uKMD9idrHqwuhB+ARU1Efs3ktAU=;
	b=p/R+CCDgoRs1nWTAEQn2dh7DLWNgJh3hkUAtbaVA16cl3lPUiAp5AUyO03iZKVXc/z4BOJ
	8IV3wvIZN7+MJm+BHa73lsCL2pJ6Q+KCil1MDwKfJfUM7HQyt37bodOt5xs1yqlbr4Y36C
	xYUfBBmBkMHes1DE0HAMH/uMttcTjAw=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1793374407;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=IYP01JhZVa5ugAr2uKMD9idrHqwuhB+ARU1Efs3ktAU=;
	b=7bnqxcm77ibeZ9IaOspvZAHV6szv5Y08AxI5RuJsNGviZbWKZykNP/w41/cT23ylLLxnRd
	0++TtmQfvv1mmpAA==
Authentication-Results: smtp-out2.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1793374405; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=IYP01JhZVa5ugAr2uKMD9idrHqwuhB+ARU1Efs3ktAU=;
	b=08NcNPEsooeWE+/PaoDIA/jiEBhTxMNJ/jLjm9Szw6xv0ug4Gq+kf0/MdMKduLdWndz00M
	Mnv04laFHxbOeSyWQ6VGl4gNIq/CY9nqNhfzaIAB/WUpW1QZLBy3hZUvfZUk/kNxyM1FVh
	OZYABfqmMdJOLP+3t607gH3EB7wp/Y8=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1793374405;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=IYP01JhZVa5ugAr2uKMD9idrHqwuhB+ARU1Efs3ktAU=;
	b=6im3jhmFMNr+0rEqZ/2udW/fwxZqYH+aIq+cGB3XNoSSO37OuaZXUt8M/JxKruWK0oOKLR
	m3oggdN8XA/1MNBQ==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 4B64013432;
	Fri, 30 Oct 2026 15:33:25 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id kWoSN8S45Gq8XAAAD6G6ig
	(envelope-from <tzimmermann@suse.de>); Fri, 30 Oct 2026 15:33:25 +0000
Content-Type: multipart/mixed; boundary="------------m5N7pT1M0uTlmwV63O0Qzjrq"
Message-ID: <c874d311-f7b1-4a24-ab75-b502ba1c5e58@suse.de>
Date: Fri, 30 Oct 2026 16:33:24 +0100
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
From: Thomas Zimmermann <tzimmermann@suse.de>
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
Content-Language: en-US
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
In-Reply-To: <f406b2f6-cad9-411f-941a-7e4f26af3947@suse.de>
X-Spam-Flag: NO
X-Spam-Level: 
X-Spamd-Result: default: False [-6.93 / 50.00];
	SUSE_INTERNAL_BYPASS(-9.00)[];
	BAYES_HAM(-3.00)[100.00%];
	NEURAL_SPAM_LONG(2.76)[0.790];
	SUSPICIOUS_RECIPS(1.50)[];
	MIME_BASE64_TEXT_BOGUS(1.00)[];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[multipart/mixed,text/plain,text/x-patch];
	MIME_BASE64_TEXT(0.10)[];
	XM_UA_NO_VERSION(0.01)[];
	RCPT_COUNT_TWELVE(0.00)[14];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	MIME_TRACE(0.00)[0:+,1:+,2:+];
	ARC_NA(0.00)[];
	DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	FREEMAIL_ENVRCPT(0.00)[gmail.com];
	FREEMAIL_CC(0.00)[romanilin.is,bootlin.com,linux.intel.com,kernel.org,gmail.com,ffwll.ch,redhat.com,collabora.com,leemhuis.info,lists.freedesktop.org,lists.linux.dev];
	RCVD_TLS_ALL(0.00)[];
	RCVD_COUNT_TWO(0.00)[2];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[];
	HAS_ATTACHMENT(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[romanilin.is:email,imap1.dmz-prg2.suse.org:helo]
X-Spam-Score: -6.93

This is a multi-part message in MIME format.
--------------m5N7pT1M0uTlmwV63O0Qzjrq
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit



Am 30.10.26 um 15:25 schrieb Thomas Zimmermann:
[...]
> How about we add a dedicated mode_fixup helper for vblank validation? 
> It would run after new CRTC's mode_fixup callback. [1] There we could 
> try to adapt the CRTC's adjusted_mode.  Since we know the bug exactly, 
> we can try to detect it, fix it, and document it.
>

The attached patch implements this idea. It does work in the sense that 
it doesn't immediately break my testing setup.

Thorsten (or anyone else) could you please test if this patch also 
resolve the bug with SPICE?



>>
>

-- 
--
Thomas Zimmermann
Graphics Driver Developer
SUSE Software Solutions Germany GmbH
Frankenstr. 146, 90461 Nürnberg, Germany, www.suse.com
GF: Stefan Gaiser, Jochen Jaser, Abhinav Puri, (HRB 36809, AG Nürnberg)


--------------m5N7pT1M0uTlmwV63O0Qzjrq
Content-Type: text/x-patch; charset=UTF-8;
 name="0001-drm-vblank-Don-t-arm-vblank-timer-with-invalid-frame.patch"
Content-Disposition: attachment;
 filename*0="0001-drm-vblank-Don-t-arm-vblank-timer-with-invalid-frame.pa";
 filename*1="tch"
Content-Transfer-Encoding: base64

RnJvbSAyYTc2ZDA0YmZjMzYzMGMxZDZiYjc5YjNkNjRlY2JjYWRmODYwMDkwIE1vbiBTZXAg
MTcgMDA6MDA6MDAgMjAwMQpGcm9tOiBSb21hbiBJbGluIDxtZUByb21hbmlsaW4uaXM+CkRh
dGU6IFRodSwgMiBKdWwgMjAyNiAyMToxMDoyNyArMDMwMApTdWJqZWN0OiBbUEFUQ0hdIGRy
bS92Ymxhbms6IERvbid0IGFybSB2YmxhbmsgdGltZXIgd2l0aCBpbnZhbGlkIGZyYW1lCiBk
dXJhdGlvbgoKV2hlbiBhIENSVEMncyBkaXNwbGF5IG1vZGUgY2FycmllcyBhIHRvbyBzbWFs
bCBwaXhlbCBjbG9jaywKZHJtX2NhbGNfdGltZXN0YW1waW5nX2NvbnN0YW50cygpIGNvbXB1
dGVzIGEgZnJhbWUgZHVyYXRpb24gdGhhdApleGNlZWRzIElOVF9NQVguIGRybV92Ymxhbmtf
Y3J0Yy5mcmFtZWR1cl9ucyBiZWNvbWVzIG5lZ2F0aXZlLgpkcm1fY3J0Y192Ymxhbmtfc3Rh
cnRfdGltZXIoKSB0aGVuIGFybXMgdGhlIHZibGFuayBocnRpbWVyIHdpdGggdGhpcwppbnRl
cnZhbCwgYWZ0ZXIgd2hpY2ggdmJsYW5rIGV2ZW50cyBhcmUgbm8gbG9uZ2VyIGRlbGl2ZXJl
ZC4gUGVuZGluZwpwYWdlIGZsaXBzIG5ldmVyIGNvbXBsZXRlIGFuZCB0aGUgZGlzcGxheSBh
cHBlYXJzIGZyb3plbi4KClRoaXMgY291bGQgYmUgdHJpZ2dlcmVkIG9uIHZpcnRpby1ncHUg
Z3Vlc3RzIHRoYXQgaGF2ZSBkeW5hbWljIHJlc29sdXRpb24KZW5hYmxlZDogd2hlbiB0aGUg
U1BJQ0UgYWdlbnQgb3IgdGhlIFggc2VydmVyIHJlc2l6ZXMgdGhlIG91dHB1dCwgaXQKc3Vi
bWl0cyBhIG1vZGUgd2hvc2UgcGl4ZWwgY2xvY2sgaXMgb2ZmIGJ5IGEgZmFjdG9yIG9mIDEw
MDAsIGUuZy46CgogICAgY2xvY2sgPSA0MDYga0h6LCBodG90YWwgPSAzMTUyLCB2dG90YWwg
PSAyMTQ4CgogICAgZnJhbWVkdXJfbnMgPSAzMTUyICogMjE0OCAqIDEwMDAwMDAgLyA0MDYg
PSAxNjY3NTg1MjIxNiBucyAofjE2LjcgcykKCjE2Njc1ODUyMjE2IGRvZXMgbm90IGZpdCBp
bnRvIGFuIGludCBhbmQgd3JhcHMgdG8gcm91Z2hseSAtNTA0MDAwMDAwLgpuc190b19rdGlt
ZSgpIHRoZW4geWllbGRzIGEgbmVnYXRpdmUgaW50ZXJ2YWwgYW5kIHRoZSB0aW1lciBzdG9w
cyB3b3JraW5nLgoKRm91bmQgYnkgYmlzZWN0aW9uLCB3aGljaCBwb2ludGVkIGF0IGNvbW1p
dCBhMDM2ZjVmY2VlZGIgKCJkcm0vdmlydGdwdToKVXNlIHZibGFuayB0aW1lciIpLiBUaGF0
IGNvbW1pdCBtZXJlbHkgbWFkZSB2aXJ0aW8tZ3B1IHVzZSB0aGUgdmJsYW5rCnRpbWVyIGFu
ZCB0aGVyZWJ5IGV4cG9zZWQgdGhlIHByZS1leGlzdGluZyBwcm9ibGVtIGluIHRoZSB0aW1l
ciBzZXR1cAphZGRlZCBieSBjb21taXQgNzRhZmViODEyODUwICgiZHJtL3ZibGFuazogQWRk
IHZibGFuayB0aW1lciIpLgoKVG8gZml4IHRoaXMsIGludHJvZHVjZSBkcm1fY3J0Y192Ymxh
bmtfbW9kZV9maXh1cCgpIHRvIGRldGVjdCBhbmQgYWRqdXN0CnRoZSBib2d1cyBwaXhlbCBj
bG9jay4gVGhlIGhlbHBlciBydW5zIHVuY29uZGl0aW9uYWxseSBhdCB0aGUgYmVnaW5uaW5n
Cm9mIHRoZSBtb2RlLWZpeHVwIGNvZGUuIERyaXZlcnMgc3RpbGwgaGF2ZSB0aGUgb3Bwb3J0
dW5pdHkgdG8gZGV0ZWN0IGJvZ3VzCmFkanVzdG1lbnRzIGluIGxhdGVyIG1vZGUtZml4dXAg
c3RlcHMuCgp2NToKLSBmaXggdXAgdGhlIGJyb2tlbiBwaXhlbCBjbG9jayBiZWZvcmVoYW5k
IChWaWxsZSkKdjQ6Ci0gYXZvaWQgbG9nIHNwYW1taW5nIHdpdGggZHJtX3dhcm5fb25jZSgp
CgpGaXhlczogNzRhZmViODEyODUwICgiZHJtL3ZibGFuazogQWRkIHZibGFuayB0aW1lciIp
ClNpZ25lZC1vZmYtYnk6IFJvbWFuIElsaW4gPG1lQHJvbWFuaWxpbi5pcz4KCm1vZGVfZml4
dXAKClJldmVydCAiZHJtL3ZibGFuazogRG9uJ3QgYXJtIHZibGFuayB0aW1lciB3aXRoIGlu
dmFsaWQgZnJhbWUgZHVyYXRpb24iCgpUaGlzIHJldmVydHMgY29tbWl0IGYzY2E3ODY4MmE0
Zjk2MDc0NDRhM2RhZmJlMTJhYjZhY2RiMWZhMmYuCi0tLQogZHJpdmVycy9ncHUvZHJtL2Ry
bV9hdG9taWNfaGVscGVyLmMgfCAxMSArKysrKwogZHJpdmVycy9ncHUvZHJtL2RybV92Ymxh
bmsuYyAgICAgICAgfCA2OCArKysrKysrKysrKysrKysrKysrKysrKysrKysrKwogaW5jbHVk
ZS9kcm0vZHJtX3ZibGFuay5oICAgICAgICAgICAgfCAgMiArCiAzIGZpbGVzIGNoYW5nZWQs
IDgxIGluc2VydGlvbnMoKykKCmRpZmYgLS1naXQgYS9kcml2ZXJzL2dwdS9kcm0vZHJtX2F0
b21pY19oZWxwZXIuYyBiL2RyaXZlcnMvZ3B1L2RybS9kcm1fYXRvbWljX2hlbHBlci5jCmlu
ZGV4IDlkMDA2Zjk4NDEzYS4uNmEwZjA0YTcyMjkyIDEwMDY0NAotLS0gYS9kcml2ZXJzL2dw
dS9kcm0vZHJtX2F0b21pY19oZWxwZXIuYworKysgYi9kcml2ZXJzL2dwdS9kcm0vZHJtX2F0
b21pY19oZWxwZXIuYwpAQCAtNDMyLDYgKzQzMiwxNyBAQCBtb2RlX2ZpeHVwKHN0cnVjdCBk
cm1fYXRvbWljX2NvbW1pdCAqc3RhdGUpCiAJCQljb250aW51ZTsKIAogCQlkcm1fbW9kZV9j
b3B5KCZuZXdfY3J0Y19zdGF0ZS0+YWRqdXN0ZWRfbW9kZSwgJm5ld19jcnRjX3N0YXRlLT5t
b2RlKTsKKworCQlpZiAoIW5ld19jcnRjX3N0YXRlLT5lbmFibGUpCisJCQljb250aW51ZTsK
KworCQlyZXQgPSBkcm1fY3J0Y192YmxhbmtfbW9kZV9maXh1cChjcnRjLCAmbmV3X2NydGNf
c3RhdGUtPm1vZGUsCisJCQkJCQkgJm5ld19jcnRjX3N0YXRlLT5hZGp1c3RlZF9tb2RlKTsK
KwkJaWYgKCFyZXQpIHsKKwkJCWRybV9kYmdfYXRvbWljKGNydGMtPmRldiwgIltDUlRDOiVk
OiVzXSB2YmxhbmsgZml4dXAgZmFpbGVkXG4iLAorCQkJCSAgICAgICBjcnRjLT5iYXNlLmlk
LCBjcnRjLT5uYW1lKTsKKwkJCXJldHVybiAtRUlOVkFMOworCQl9CiAJfQogCiAJZm9yX2Vh
Y2hfbmV3X2Nvbm5lY3Rvcl9pbl9zdGF0ZShzdGF0ZSwgY29ubmVjdG9yLCBuZXdfY29ubl9z
dGF0ZSwgaSkgewpkaWZmIC0tZ2l0IGEvZHJpdmVycy9ncHUvZHJtL2RybV92YmxhbmsuYyBi
L2RyaXZlcnMvZ3B1L2RybS9kcm1fdmJsYW5rLmMKaW5kZXggZjkwZmIyZDEzZTQyLi42ZTgy
NmMzYjZjNDIgMTAwNjQ0Ci0tLSBhL2RyaXZlcnMvZ3B1L2RybS9kcm1fdmJsYW5rLmMKKysr
IGIvZHJpdmVycy9ncHUvZHJtL2RybV92YmxhbmsuYwpAQCAtNjIwLDYgKzYyMCw3NCBAQCB3
YWl0X3F1ZXVlX2hlYWRfdCAqZHJtX2NydGNfdmJsYW5rX3dhaXRxdWV1ZShzdHJ1Y3QgZHJt
X2NydGMgKmNydGMpCiB9CiBFWFBPUlRfU1lNQk9MKGRybV9jcnRjX3ZibGFua193YWl0cXVl
dWUpOwogCitzdGF0aWMgaW50IGRybV92YmxhbmtfdmFsaWRhdGVfZG90Y2xvY2sodTE2IGNy
dGNfaHRvdGFsLCB1MTYgY3J0Y192dG90YWwsIHUzMiBmbGFncywgaW50IGRvdGNsb2NrKQor
eworCXVuc2lnbmVkIGludCBmcmFtZV9zaXplOworCXU2NCBsaW5lZHVyX25zLCBmcmFtZWR1
cl9uczsKKworCWlmIChkb3RjbG9jayA8PSAwKQorCQlyZXR1cm4gLUVJTlZBTDsKKworCWZy
YW1lX3NpemUgPSAodW5zaWduZWQgaW50KWNydGNfaHRvdGFsICogKHVuc2lnbmVkIGludClj
cnRjX3Z0b3RhbDsKKworCS8qCisJICogQ29udmVydCBzY2FubGluZSBsZW5ndGggaW4gcGl4
ZWxzIGFuZCB2aWRlbyBkb3QgY2xvY2sgdG8gbGluZSBkdXJhdGlvbgorCSAqIGFuZCBmcmFt
ZSBkdXJhdGlvbiBpbiBuYW5vc2Vjb25kcy4KKwkgKi8KKwlsaW5lZHVyX25zICA9IGRpdl91
NjQoKHU2NCljcnRjX2h0b3RhbCAqIDEwMDAwMDAsIGRvdGNsb2NrKTsKKwlmcmFtZWR1cl9u
cyA9IGRpdl91NjQoKHU2NClmcmFtZV9zaXplICogMTAwMDAwMCwgZG90Y2xvY2spOworCisJ
LyoKKwkgKiBGaWVsZHMgb2YgaW50ZXJsYWNlZCBzY2Fub3V0IG1vZGVzIGFyZSBvbmx5IGhh
bGYgYSBmcmFtZSBkdXJhdGlvbi4KKwkgKi8KKwlpZiAoZmxhZ3MgJiBEUk1fTU9ERV9GTEFH
X0lOVEVSTEFDRSkKKwkJZnJhbWVkdXJfbnMgLz0gMjsKKworCWlmIChsaW5lZHVyX25zID4g
SU5UX01BWCB8fCBmcmFtZWR1cl9ucyA+IElOVF9NQVgpCisJCXJldHVybiAtRVJBTkdFOyAv
KiBkb3QgY2xvY2sgdG9vIGxvdyAqLworCisJcmV0dXJuIDA7Cit9CisKK2Jvb2wgZHJtX2Ny
dGNfdmJsYW5rX21vZGVfZml4dXAoc3RydWN0IGRybV9jcnRjICpjcnRjLCBjb25zdCBzdHJ1
Y3QgZHJtX2Rpc3BsYXlfbW9kZSAqbW9kZSwKKwkJCQlzdHJ1Y3QgZHJtX2Rpc3BsYXlfbW9k
ZSAqYWRqdXN0ZWRfbW9kZSkKK3sKKwlzdHJ1Y3QgZHJtX2RldmljZSAqZGV2ID0gY3J0Yy0+
ZGV2OworCXVuc2lnbmVkIGludCBwaXBlID0gZHJtX2NydGNfaW5kZXgoY3J0Yyk7CisJaW50
IGRvdGNsb2NrID0gYWRqdXN0ZWRfbW9kZS0+Y3J0Y19jbG9jazsKKwlpbnQgcmV0OworCisJ
aWYgKCFkcm1fZGV2X2hhc192YmxhbmsoZGV2KSkKKwkJcmV0dXJuIHRydWU7CisKKwlpZiAo
ZHJtX1dBUk5fT04oZGV2LCBwaXBlID49IGRldi0+bnVtX2NydGNzKSkKKwkJcmV0dXJuIGZh
bHNlOworCisJcmV0ID0gZHJtX3ZibGFua192YWxpZGF0ZV9kb3RjbG9jayhhZGp1c3RlZF9t
b2RlLT5jcnRjX2h0b3RhbCwKKwkJCQkJICAgYWRqdXN0ZWRfbW9kZS0+Y3J0Y192dG90YWws
CisJCQkJCSAgIGFkanVzdGVkX21vZGUtPmZsYWdzLCBkb3RjbG9jayk7CisJaWYgKHJldCA9
PSAtRVJBTkdFKSB7CisJCWludCBkb3RjbG9ja18xMDAwOworCisJCS8qCisJCSAqIFNQSUNF
JyB2ZF9hZ2VudCBoYXMgYSBidWcgd2hlcmUgaXQgc3BlY2lmaWVzIHRoZSBkb3QgY2xvY2sg
aW4ga0h6CisJCSAqIGluc3RlYWQgb2YgSHouIFNldHRpbmcgdXAgYSB2YmxhbmsgaW50ZXJy
dXB0IG9yIHRpbWVyIGZvciBzdWNoIGEKKwkJICogbW9kZSBvdmVyZmxvd3MgdGhlIGNhbGN1
bGF0aW9uIGluIGRybV9jYWxjX3RpbWVzdGFtcGluZ19jb25zdGFudHMoKS4KKwkJICogQW4g
ZXJybm8gY29kZSBvZiBFUkFOR0Ugc3BlY2lmaWNhbGx5IHBvaW50cyB0byB0aGlzIHByb2Js
ZW0uIFRyeQorCQkgKiBjb252ZXJ0aW5nIHRoZSBkb3QgY2xvY2sgdG8gSHogYW5kIHZhbGlk
YXRlIGFnYWluLgorCQkgKi8KKwkJaWYgKGNoZWNrX211bF9vdmVyZmxvdyhkb3RjbG9jaywg
MTAwMCwgJmRvdGNsb2NrXzEwMDApKSB7CisJCQlyZXQgPSBkcm1fdmJsYW5rX3ZhbGlkYXRl
X2RvdGNsb2NrKGFkanVzdGVkX21vZGUtPmNydGNfaHRvdGFsLAorCQkJCQkJCSAgIGFkanVz
dGVkX21vZGUtPmNydGNfdnRvdGFsLAorCQkJCQkJCSAgIGFkanVzdGVkX21vZGUtPmZsYWdz
LCBkb3RjbG9ja18xMDAwKTsKKwkJCWlmICghcmV0KQorCQkJCWFkanVzdGVkX21vZGUtPmNy
dGNfY2xvY2sgPSBkb3RjbG9ja18xMDAwOworCQl9CisJfQorCisJcmV0dXJuICFyZXQ7Cit9
CitFWFBPUlRfU1lNQk9MKGRybV9jcnRjX3ZibGFua19tb2RlX2ZpeHVwKTsKIAogLyoqCiAg
KiBkcm1fY2FsY190aW1lc3RhbXBpbmdfY29uc3RhbnRzIC0gY2FsY3VsYXRlIHZibGFuayB0
aW1lc3RhbXAgY29uc3RhbnRzCmRpZmYgLS1naXQgYS9pbmNsdWRlL2RybS9kcm1fdmJsYW5r
LmggYi9pbmNsdWRlL2RybS9kcm1fdmJsYW5rLmgKaW5kZXggMmZjZWY5YzBmNWIxLi5hMzYy
OGM0NzdmNTkgMTAwNjQ0Ci0tLSBhL2luY2x1ZGUvZHJtL2RybV92YmxhbmsuaAorKysgYi9p
bmNsdWRlL2RybS9kcm1fdmJsYW5rLmgKQEAgLTMxMSw2ICszMTEsOCBAQCB2b2lkIGRybV9j
cnRjX3ZibGFua19vbihzdHJ1Y3QgZHJtX2NydGMgKmNydGMpOwogdTY0IGRybV9jcnRjX2Fj
Y3VyYXRlX3ZibGFua19jb3VudChzdHJ1Y3QgZHJtX2NydGMgKmNydGMpOwogdm9pZCBkcm1f
Y3J0Y192YmxhbmtfcmVzdG9yZShzdHJ1Y3QgZHJtX2NydGMgKmNydGMpOwogCitib29sIGRy
bV9jcnRjX3ZibGFua19tb2RlX2ZpeHVwKHN0cnVjdCBkcm1fY3J0YyAqY3J0YywgY29uc3Qg
c3RydWN0IGRybV9kaXNwbGF5X21vZGUgKm1vZGUsCisJCQkJc3RydWN0IGRybV9kaXNwbGF5
X21vZGUgKmFkanVzdGVkX21vZGUpOwogdm9pZCBkcm1fY2FsY190aW1lc3RhbXBpbmdfY29u
c3RhbnRzKHN0cnVjdCBkcm1fY3J0YyAqY3J0YywKIAkJCQkgICAgIGNvbnN0IHN0cnVjdCBk
cm1fZGlzcGxheV9tb2RlICptb2RlKTsKIHdhaXRfcXVldWVfaGVhZF90ICpkcm1fY3J0Y192
Ymxhbmtfd2FpdHF1ZXVlKHN0cnVjdCBkcm1fY3J0YyAqY3J0Yyk7Ci0tIAoyLjU2LjAKCg==


--------------m5N7pT1M0uTlmwV63O0Qzjrq--
