Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 20780C61DA4
	for <virtualization@archiver.kernel.org>; Thu, 16 Feb 2023 12:03:12 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 618B56002E;
	Thu, 16 Feb 2023 12:03:11 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 618B56002E
Authentication-Results: smtp3.osuosl.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=suse.de header.i=@suse.de header.a=rsa-sha256 header.s=susede2_rsa header.b=kDfr3Q9w;
	dkim=fail reason="signature verification failed" header.d=suse.de header.i=@suse.de header.a=ed25519-sha256 header.s=susede2_ed25519 header.b=dVX1a7S3
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
	by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id UMf-0gRUpRqh; Thu, 16 Feb 2023 12:03:10 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp3.osuosl.org (Postfix) with ESMTPS id AB97760655;
	Thu, 16 Feb 2023 12:03:09 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org AB97760655
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 7B42CC0033;
	Thu, 16 Feb 2023 12:03:09 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id A248BC002B
 for <virtualization@lists.linux-foundation.org>;
 Thu, 16 Feb 2023 12:03:08 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id 7C35880F7E
 for <virtualization@lists.linux-foundation.org>;
 Thu, 16 Feb 2023 12:03:08 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 7C35880F7E
Authentication-Results: smtp1.osuosl.org;
 dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de
 header.a=rsa-sha256 header.s=susede2_rsa header.b=kDfr3Q9w; 
 dkim=pass header.d=suse.de header.i=@suse.de header.a=ed25519-sha256
 header.s=susede2_ed25519 header.b=dVX1a7S3
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id s_9LGBZDsK5V
 for <virtualization@lists.linux-foundation.org>;
 Thu, 16 Feb 2023 12:03:04 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 7B0E380C7B
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.220.29])
 by smtp1.osuosl.org (Postfix) with ESMTPS id 7B0E380C7B
 for <virtualization@lists.linux-foundation.org>;
 Thu, 16 Feb 2023 12:03:04 +0000 (UTC)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id B537F1FE56;
 Thu, 16 Feb 2023 12:03:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1676548982; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=d67c9qdRI89d74h17k4dk/pFOIXSWUw6WOPM+4sgU9M=;
 b=kDfr3Q9wiL0PMEC6/+cokNqJQWhrkFHofEIe3AwgM1ZiDwwMrGseg0vjFJj/mnWRsd38VE
 mUDnEBPAdQEqww4RkEDhRMe32pL1ySBl9U3l+6HXtg55CO8gdyI6bsOB66sP01soKL61mk
 4ahPEWOVpuqfsC84UtR8PcwtWUqZfDc=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1676548982;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=d67c9qdRI89d74h17k4dk/pFOIXSWUw6WOPM+4sgU9M=;
 b=dVX1a7S3rsEG8Jg9myQcxvAdnUSh5Cg9KXP24+DQj9eAfn4GZ7kE7BLJS3L6WZS3bKBrkx
 2wFL2OhmI5rL4yBw==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 8BD28131FD;
 Thu, 16 Feb 2023 12:03:02 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
 by imap2.suse-dmz.suse.de with ESMTPSA id Li8pIXYb7mOgNgAAMHmgww
 (envelope-from <tzimmermann@suse.de>); Thu, 16 Feb 2023 12:03:02 +0000
Message-ID: <306e110d-4d1f-cb9c-6f9b-c8a5ddd48a61@suse.de>
Date: Thu, 16 Feb 2023 13:03:02 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.6.1
Subject: Re: [PATCH 17/17] drm/cirrus: Use VGA macro constants to unblank
Content-Language: en-US
To: Gerd Hoffmann <kraxel@redhat.com>
References: <20230215161517.5113-1-tzimmermann@suse.de>
 <20230215161517.5113-18-tzimmermann@suse.de>
 <20230216113330.rmzmkdvpxdqk2nrd@sirius.home.kraxel.org>
From: Thomas Zimmermann <tzimmermann@suse.de>
In-Reply-To: <20230216113330.rmzmkdvpxdqk2nrd@sirius.home.kraxel.org>
Cc: javierm@redhat.com, dri-devel@lists.freedesktop.org,
 virtualization@lists.linux-foundation.org, daniel@ffwll.ch, airlied@redhat.com,
 sam@ravnborg.org
X-BeenThere: virtualization@lists.linux-foundation.org
X-Mailman-Version: 2.1.15
Precedence: list
List-Id: Linux virtualization <virtualization.lists.linux-foundation.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/virtualization>, 
 <mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/virtualization/>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/virtualization>, 
 <mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Content-Type: multipart/mixed; boundary="===============3526896872923621044=="
Errors-To: virtualization-bounces@lists.linux-foundation.org
Sender: "Virtualization" <virtualization-bounces@lists.linux-foundation.org>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--===============3526896872923621044==
Content-Language: en-US
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="------------QJEWgNBKh3sO9KV0Y42j0ff5"

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--------------QJEWgNBKh3sO9KV0Y42j0ff5
Content-Type: multipart/mixed; boundary="------------zFHk7vqzkZMCjSSQ3iYBGwXJ";
 protected-headers="v1"
From: Thomas Zimmermann <tzimmermann@suse.de>
To: Gerd Hoffmann <kraxel@redhat.com>
Cc: airlied@redhat.com, daniel@ffwll.ch, sam@ravnborg.org,
 javierm@redhat.com, dri-devel@lists.freedesktop.org,
 virtualization@lists.linux-foundation.org
Message-ID: <306e110d-4d1f-cb9c-6f9b-c8a5ddd48a61@suse.de>
Subject: Re: [PATCH 17/17] drm/cirrus: Use VGA macro constants to unblank
References: <20230215161517.5113-1-tzimmermann@suse.de>
 <20230215161517.5113-18-tzimmermann@suse.de>
 <20230216113330.rmzmkdvpxdqk2nrd@sirius.home.kraxel.org>
In-Reply-To: <20230216113330.rmzmkdvpxdqk2nrd@sirius.home.kraxel.org>

--------------zFHk7vqzkZMCjSSQ3iYBGwXJ
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: base64

SGksDQoNCnRoYW5rcyBmb3IgdGFraW5nIGEgbG9vayBhdCB0aGUgcGF0Y2hlcy4NCg0KQW0g
MTYuMDIuMjMgdW0gMTI6MzMgc2NocmllYiBHZXJkIEhvZmZtYW5uOg0KPiBPbiBXZWQsIEZl
YiAxNSwgMjAyMyBhdCAwNToxNToxN1BNICswMTAwLCBUaG9tYXMgWmltbWVybWFubiB3cm90
ZToNCj4+IFNldCB0aGUgVkdBIGJpdCBmb3IgdW5ibGFua2luZyB3aXRoIG1hY3JvIGNvbnN0
YW50cyBpbnN0ZWFkIG9mIG1hZ2ljDQo+PiB2YWx1ZXMuIE5vIGZ1bmN0aW9uYWwgY2hhbmdl
cy4NCj4gDQo+IGJsYW5rL3VuYmxhbmsgc2hvdWxkIHdvcmsgc2ltbGlhciB0byBib2NocyAo
c2VlIGNvbW1pdCAyNTBlNzQzOTE1ZDQpLA0KPiB0aGF0IGlzIG1heWJlIGEgbmljZSB0aGlu
ZyB0byBhZGQgb2YgeW91IG1vZGVybml6ZSB0aGUgZHJpdmVyIGFueXdheS4NClllYWgsIGl0
J3MgdGhlIFZHQSBQQVMgZmllbGQuIFsxXSBCdXQgaXMgaXQgcmVhbGx5IGNhbGxlZCBibGFu
a2luZz8gUEFTIA0KY29udHJvbHMgcGFsZXR0ZSBhY2Nlc3MsIGJ1dCBibGFua2luZyBpcyBz
b3VuZHMgbW9yZSBsaWtlIERQTVMuDQoNClRoZSBQQVMgc2V0dGluZyBpcyBhY3R1YWxseSBw
YXJ0IG9mIHRoZSBwcmltYXJ5IHBsYW5lLCBzbyBpdCdzIGN1cnJlbnQgDQpsb2NhdGlvbiBp
biB0aGUgQ1JUQyBjb2RlIGlzIG1pc2xlYWRpbmcuIEkgZGlkbid0IHdhbnQgdG8gY2hhbmdl
IHRoZSANCmRyaXZlciBsb2dpYyB0b28gbXVjaCwgYnV0IEkgZ3Vlc3MgSSdsbCBmaXggdGhh
dCBpbiB0aGUgbmV4dCBpdGVyYXRpb24uDQoNCkJlc3QgcmVnYXJkcw0KVGhvbWFzDQoNClsx
XSANCmh0dHBzOi8vd2ViLnN0YW5mb3JkLmVkdS9jbGFzcy9jczE0MC9wcm9qZWN0cy9waW50
b3Mvc3BlY3MvZnJlZXZnYS92Z2EvYXR0cnJlZy5odG0jM0MwDQoNCj4gDQo+IHRha2UgY2Fy
ZSwNCj4gICAgR2VyZA0KPiANCg0KLS0gDQpUaG9tYXMgWmltbWVybWFubg0KR3JhcGhpY3Mg
RHJpdmVyIERldmVsb3Blcg0KU1VTRSBTb2Z0d2FyZSBTb2x1dGlvbnMgR2VybWFueSBHbWJI
DQpNYXhmZWxkc3RyLiA1LCA5MDQwOSBOw7xybmJlcmcsIEdlcm1hbnkNCihIUkIgMzY4MDks
IEFHIE7DvHJuYmVyZykNCkdlc2Now6RmdHNmw7xocmVyOiBJdm8gVG90ZXYNCg==

--------------zFHk7vqzkZMCjSSQ3iYBGwXJ--

--------------QJEWgNBKh3sO9KV0Y42j0ff5
Content-Type: application/pgp-signature; name="OpenPGP_signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="OpenPGP_signature"

-----BEGIN PGP SIGNATURE-----

wsF5BAABCAAjFiEExndm/fpuMUdwYFFolh/E3EQov+AFAmPuG3YFAwAAAAAACgkQlh/E3EQov+C3
mRAAzS5nN5txKkdrqqqLttOSiPOmLn7fdgn4yA2WACQdhxsZCxoADVBXezKqW4J6OaawppnpMlZY
p0oaqg75p70tbRkyovYQauXButoi9OhJoeZe8a0Y4AJtqlbnJHm/gsUB67Q5+rlmS4GakkwqX01D
J2q+DbK+dr/rTGZJa0tPd2XWWaqIWtoBBycMoHJ5ajuOUTEkWAMOGzkrnD2FGpaGsIInHDPNa68R
Yz8OjxWIthni5T9QvSlG2LvblCGVw8uK9LmOKOSCiNe8YKqLMiJGz4OMKiThn9zMUOwjIgJ+Yp+c
yFHOXuK4dvqBGQ41N9Cgk8u07+qE/u9hc1M/FxSPk6Ybk6BNNgJqqkSi4YXQPM3l/sU6Hz8KHbtn
uUD2MPb/Psy1fcsHzJraEyLZD01GGp8vID0ThslWnht4L/Nndxq0LKxweF3psph67BN+kizyOqPv
KRyfO8hQC9/3a5goC7opeuGimPVCg/7/7XDTM31Y8uog0QW2u26WDhB7PJ7FincOWolabKQ0iL+u
FTRspw5/hcU/PEsRpuc2EacTxvdAeONDMDFKUrM/aDa+A7X6jjOaxabz0Iq/zfOQttDgDQrclnGz
wByZbc8xbko3+ar6CDb84lVY+HOSMLJ7gNSBdQjYziNiQ7ABWcS99S1Ad1rWg27KGX9aoo8ukVdO
3a8=
=6K9N
-----END PGP SIGNATURE-----

--------------QJEWgNBKh3sO9KV0Y42j0ff5--

--===============3526896872923621044==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
--===============3526896872923621044==--
