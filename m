Return-Path: <SRS0=GFjK=P3=lists.linux-foundation.org=virtualization-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6A0E4C433EF
	for <virtualization@archiver.kernel.org>; Mon,  8 Nov 2021 08:50:42 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 048B76125F
	for <virtualization@archiver.kernel.org>; Mon,  8 Nov 2021 08:50:41 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org 048B76125F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=suse.de
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id BE9D480E07;
	Mon,  8 Nov 2021 08:50:41 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
	by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id wErFy0YHzcIe; Mon,  8 Nov 2021 08:50:41 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp1.osuosl.org (Postfix) with ESMTPS id 75C0580D49;
	Mon,  8 Nov 2021 08:50:40 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 3A6D5C0019;
	Mon,  8 Nov 2021 08:50:40 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by lists.linuxfoundation.org (Postfix) with ESMTP id E460EC000E
 for <virtualization@lists.linux-foundation.org>;
 Mon,  8 Nov 2021 08:50:38 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id CE341606D5
 for <virtualization@lists.linux-foundation.org>;
 Mon,  8 Nov 2021 08:50:38 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp3.osuosl.org (amavisd-new);
 dkim=pass (1024-bit key) header.d=suse.de header.b="BmQTdXuk";
 dkim=neutral reason="invalid (unsupported algorithm ed25519-sha256)"
 header.d=suse.de header.b="VZRN1w65"
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id WF2RtgP_JXFJ
 for <virtualization@lists.linux-foundation.org>;
 Mon,  8 Nov 2021 08:50:38 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.220.28])
 by smtp3.osuosl.org (Postfix) with ESMTPS id 21654606CB
 for <virtualization@lists.linux-foundation.org>;
 Mon,  8 Nov 2021 08:50:38 +0000 (UTC)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id 6C64C2190B;
 Mon,  8 Nov 2021 08:50:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1636361435; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=W4jPKsYsST6dQr9FRHWQB8IhrRDqgJUuPMCwmMcL1OY=;
 b=BmQTdXukc2jnriCWni+h9SnBGCG/MSJwC2eKwHdoo6tX8GqZpxxVtzcwJAmIvskgHaOFSR
 N7WNn/yHy3W8fhN52ITT+QqfLTw90ko/X8lUmLzfVLbtB9rngD9kheoGVAobPqHxY5P+PC
 Ax11rEb/x2bxBfM1/ARz8aoDNzmHnOQ=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1636361435;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=W4jPKsYsST6dQr9FRHWQB8IhrRDqgJUuPMCwmMcL1OY=;
 b=VZRN1w65luOREgI/fW4AsRxHjcldMmvFAZVmW/QFOlinfGWcCGGts5mWHrKLh3HDUE1qED
 3jxPkaFrVE5Rt4BQ==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 0B317139CF;
 Mon,  8 Nov 2021 08:50:35 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
 by imap2.suse-dmz.suse.de with ESMTPSA id nzyxAdvkiGHbZAAAMHmgww
 (envelope-from <tzimmermann@suse.de>); Mon, 08 Nov 2021 08:50:35 +0000
Message-ID: <20ba6cd3-74bd-a212-f483-e0b73a95dbc1@suse.de>
Date: Mon, 8 Nov 2021 09:50:33 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.2.1
Subject: Re: [PATCH v2 1/9] drm/format-helper: Export drm_fb_clip_offset()
Content-Language: en-US
To: =?UTF-8?Q?Noralf_Tr=c3=b8nnes?= <noralf@tronnes.org>, daniel@ffwll.ch,
 airlied@linux.ie, mripard@kernel.org, maarten.lankhorst@linux.intel.com,
 drawat.floss@gmail.com, airlied@redhat.com, kraxel@redhat.com,
 david@lechnology.com, sam@ravnborg.org, javierm@redhat.com,
 kernel@amanoeldawod.com, dirty.ice.hu@gmail.com, michael+lkml@stapelberg.ch,
 aros@gmx.com, joshua@stroblindustries.com, arnd@arndb.de
References: <20211101141532.26655-1-tzimmermann@suse.de>
 <20211101141532.26655-2-tzimmermann@suse.de>
 <31701408-4e54-58a4-93c9-c946ef2488af@tronnes.org>
From: Thomas Zimmermann <tzimmermann@suse.de>
In-Reply-To: <31701408-4e54-58a4-93c9-c946ef2488af@tronnes.org>
Cc: linux-hyperv@vger.kernel.org, dri-devel@lists.freedesktop.org,
 virtualization@lists.linux-foundation.org
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
Content-Type: multipart/mixed; boundary="===============7996756382734164120=="
Errors-To: virtualization-bounces@lists.linux-foundation.org
Sender: "Virtualization" <virtualization-bounces@lists.linux-foundation.org>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--===============7996756382734164120==
Content-Language: en-US
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="------------lD2yecSCRPS0fHZxMRlz2kT3"

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--------------lD2yecSCRPS0fHZxMRlz2kT3
Content-Type: multipart/mixed; boundary="------------ILABsSxHpNUGpDZlZ0x220hF";
 protected-headers="v1"
From: Thomas Zimmermann <tzimmermann@suse.de>
To: =?UTF-8?Q?Noralf_Tr=c3=b8nnes?= <noralf@tronnes.org>, daniel@ffwll.ch,
 airlied@linux.ie, mripard@kernel.org, maarten.lankhorst@linux.intel.com,
 drawat.floss@gmail.com, airlied@redhat.com, kraxel@redhat.com,
 david@lechnology.com, sam@ravnborg.org, javierm@redhat.com,
 kernel@amanoeldawod.com, dirty.ice.hu@gmail.com, michael+lkml@stapelberg.ch,
 aros@gmx.com, joshua@stroblindustries.com, arnd@arndb.de
Cc: linux-hyperv@vger.kernel.org, dri-devel@lists.freedesktop.org,
 virtualization@lists.linux-foundation.org
Message-ID: <20ba6cd3-74bd-a212-f483-e0b73a95dbc1@suse.de>
Subject: Re: [PATCH v2 1/9] drm/format-helper: Export drm_fb_clip_offset()
References: <20211101141532.26655-1-tzimmermann@suse.de>
 <20211101141532.26655-2-tzimmermann@suse.de>
 <31701408-4e54-58a4-93c9-c946ef2488af@tronnes.org>
In-Reply-To: <31701408-4e54-58a4-93c9-c946ef2488af@tronnes.org>

--------------ILABsSxHpNUGpDZlZ0x220hF
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: base64

SGkNCg0KQW0gMDUuMTEuMjEgdW0gMjE6NDggc2NocmllYiBOb3JhbGYgVHLDuG5uZXM6DQo+
IA0KPiANCj4gRGVuIDAxLjExLjIwMjEgMTUuMTUsIHNrcmV2IFRob21hcyBaaW1tZXJtYW5u
Og0KPj4gUHJvdmlkZSBhIGZ1bmN0aW9uIHRoYXQgY29tcHV0ZXMgdGhlIG9mZnNldCBpbnRv
IGEgYmxpdCBkZXN0aW5hdGlvbg0KPj4gYnVmZmVyLiBUaGlzIHdpbGwgYWxsb3cgdG8gbW92
ZSBkZXN0aW5hdGlvbi1idWZmZXIgY2xpcHBpbmcgaW50byB0aGUNCj4+IGZvcm1hdC1oZWxw
ZXIgY2FsbGVycy4NCj4+DQo+PiB2MjoNCj4+IAkqIHByb3ZpZGUgZG9jdW1lbnRhdGlvbiAo
U2FtKQ0KPj4gCSogcmV0dXJuICd1bnNpZ25lZCBpbnQnIChTYW0sIE5vcmFsZikNCj4+DQo+
PiBTaWduZWQtb2ZmLWJ5OiBUaG9tYXMgWmltbWVybWFubiA8dHppbW1lcm1hbm5Ac3VzZS5k
ZT4NCj4+IC0tLQ0KPiANCj4gUmV2aWV3ZWQtYnk6IE5vcmFsZiBUcsO4bm5lcyA8bm9yYWxm
QHRyb25uZXMub3JnPg0KDQpUaGFua3MgYSBsb3QuIE1heSBJIGFzayB5b3UgdG8gYWxzbyBy
ZXZpZXcgcGF0Y2hlcyA3IHRvIDk/DQoNCkJlc3QgcmVnYXJkcw0KVGhvbWFzDQoNCj4gDQoN
Ci0tIA0KVGhvbWFzIFppbW1lcm1hbm4NCkdyYXBoaWNzIERyaXZlciBEZXZlbG9wZXINClNV
U0UgU29mdHdhcmUgU29sdXRpb25zIEdlcm1hbnkgR21iSA0KTWF4ZmVsZHN0ci4gNSwgOTA0
MDkgTsO8cm5iZXJnLCBHZXJtYW55DQooSFJCIDM2ODA5LCBBRyBOw7xybmJlcmcpDQpHZXNj
aMOkZnRzZsO8aHJlcjogSXZvIFRvdGV2DQo=

--------------ILABsSxHpNUGpDZlZ0x220hF--

--------------lD2yecSCRPS0fHZxMRlz2kT3
Content-Type: application/pgp-signature; name="OpenPGP_signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="OpenPGP_signature"

-----BEGIN PGP SIGNATURE-----

wsF5BAABCAAjFiEExndm/fpuMUdwYFFolh/E3EQov+AFAmGI5NkFAwAAAAAACgkQlh/E3EQov+Be
qA//XwewE2/PKfqRQ5WOmehdS85n0nBqN87KWV5UT+SMeMSRl6sofDg04IRmD7gVlUMXGz/L4gIt
9sgF246+onbk11K7TFBD1jK05pruCd/0E7UCNek6Fv7z+kPs0e/LmjowwMZfWllWKD5MLJBvEEaU
UeDBpu0HSuemjcZIWapkl8m3KmtDWCsUWmifzb3I5OFBo2k3eF1DIrEBh2wbZ0+tTToG4tDGYS5s
uwhgt/DvjH9gRLVPly2Vtzpw1XOSpRF6Q86xuUu6IIe+zQtWhnSFUnKCu0ol2m1D71szr9G9UsGA
tLQzLZBeiLdK4Cq805BczBtgo6B/ylDB49in7k/znSymrtfbeVMkhGxUMEbcEwG77nkBwwccY24h
tRau5jTRbqPqpcgruK4J0tuoSV+ext56jAf1jmcEPGmpHbcPg4ONbY8oA3R5Pt00oTvN8l6YxUYe
PsQ77aueV2xG8hDP0sWj75HuHhwztO5nIru8T1kwIBOpGyWhs7qjDsDhO9i+joDDRvAd0qaUprSs
uTT6e7+COX2rRv63LPHTOgKM+YIT8xIrNj9uAwDVszyf0LgackGR6F3Cr9RKozQDywJ61lKW95Fw
Wt62Scq6VhFajUwZjRf+CnGzm2S3zRVR3r0OGZ2o1yCfZfrv0GRrOWfnkz9E+dfP85SSFfkFzuaP
R6A=
=iTI9
-----END PGP SIGNATURE-----

--------------lD2yecSCRPS0fHZxMRlz2kT3--

--===============7996756382734164120==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
--===============7996756382734164120==--
