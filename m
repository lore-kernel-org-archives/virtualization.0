Return-Path: <SRS0=YXi0=PY=lists.linux-foundation.org=virtualization-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9019DC433F5
	for <virtualization@archiver.kernel.org>; Fri,  5 Nov 2021 10:16:01 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 43A3860EBC
	for <virtualization@archiver.kernel.org>; Fri,  5 Nov 2021 10:16:01 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org 43A3860EBC
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=suse.de
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 0319281D70;
	Fri,  5 Nov 2021 10:16:01 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
	by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id tO6bII3qXIFv; Fri,  5 Nov 2021 10:16:00 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp1.osuosl.org (Postfix) with ESMTPS id 7961481D65;
	Fri,  5 Nov 2021 10:15:59 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 37C6FC0012;
	Fri,  5 Nov 2021 10:15:59 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by lists.linuxfoundation.org (Postfix) with ESMTP id E66E9C000E
 for <virtualization@lists.linux-foundation.org>;
 Fri,  5 Nov 2021 10:15:57 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id CBA824043A
 for <virtualization@lists.linux-foundation.org>;
 Fri,  5 Nov 2021 10:15:57 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp2.osuosl.org (amavisd-new);
 dkim=pass (1024-bit key) header.d=suse.de header.b="orCQK/xM";
 dkim=neutral reason="invalid (unsupported algorithm ed25519-sha256)"
 header.d=suse.de header.b="2o9Kzvfv"
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id tTgYdIdvHbMW
 for <virtualization@lists.linux-foundation.org>;
 Fri,  5 Nov 2021 10:15:57 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.220.28])
 by smtp2.osuosl.org (Postfix) with ESMTPS id AB298400AF
 for <virtualization@lists.linux-foundation.org>;
 Fri,  5 Nov 2021 10:15:56 +0000 (UTC)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id 4A33C21892;
 Fri,  5 Nov 2021 10:15:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1636107354; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=tzTStpT68H1flecD6y0xE4GHTy0YcwY+IxQpIsRqqTk=;
 b=orCQK/xM7Fxu+9/vAh7QbfVPbIdqUpTpXj1XwR7Jf8ilitnc78Rb8FuxnTVyVEJMLrM4Ke
 T2H1J37LhFPuGK808OMYW+fcwSYaLQt0X+Faiba0cYU0nCr/8rtzHjs55GjJHzjvsUq1rR
 Wo/LEqfvVBQM9Hu2tdCXr6/cI8l3Oj4=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1636107354;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=tzTStpT68H1flecD6y0xE4GHTy0YcwY+IxQpIsRqqTk=;
 b=2o9KzvfvWSimE78oUDZsxslr4eL6oFkfsr4fkk8/E0mYkWOKmDaw88BB/NzI2GN8jup1c1
 dAfMCesmf9V1TsCg==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id C65C513FE2;
 Fri,  5 Nov 2021 10:15:53 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
 by imap2.suse-dmz.suse.de with ESMTPSA id pG1lL1kEhWFsfgAAMHmgww
 (envelope-from <tzimmermann@suse.de>); Fri, 05 Nov 2021 10:15:53 +0000
Message-ID: <51ed4aec-9496-5ccc-97f2-1328ffd767ae@suse.de>
Date: Fri, 5 Nov 2021 11:15:53 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.2.1
Subject: Re: [PATCH v2 1/2] drm: Add a drm_drv_enabled() to check if drivers
 should be enabled
Content-Language: en-US
To: Javier Martinez Canillas <javierm@redhat.com>,
 Jani Nikula <jani.nikula@linux.intel.com>, linux-kernel@vger.kernel.org
References: <20211104160707.1407052-1-javierm@redhat.com>
 <20211104160707.1407052-2-javierm@redhat.com> <87ilx7ae3v.fsf@intel.com>
 <0c07f121-42d3-9f37-1e14-842fb685b501@redhat.com>
 <d4a64906-69e5-3250-2362-79f2afac0a23@suse.de>
 <38dbcc8f-2f95-6846-537f-9b85468bfa87@redhat.com>
From: Thomas Zimmermann <tzimmermann@suse.de>
In-Reply-To: <38dbcc8f-2f95-6846-537f-9b85468bfa87@redhat.com>
Cc: Pekka Paalanen <pekka.paalanen@collabora.com>,
 Dave Airlie <airlied@redhat.com>, Peter Robinson <pbrobinson@gmail.com>,
 David Airlie <airlied@linux.ie>, Daniel Vetter <daniel.vetter@ffwll.ch>,
 intel-gfx@lists.freedesktop.org, "Pan, Xinhui" <Xinhui.Pan@amd.com>,
 Alex Deucher <alexander.deucher@amd.com>, dri-devel@lists.freedesktop.org,
 Gurchetan Singh <gurchetansingh@chromium.org>,
 =?UTF-8?Q?Michel_D=c3=a4nzer?= <michel@daenzer.net>,
 Hans de Goede <hdegoede@redhat.com>,
 VMware Graphics <linux-graphics-maintainer@vmware.com>,
 amd-gfx@lists.freedesktop.org, Rodrigo Vivi <rodrigo.vivi@intel.com>,
 nouveau@lists.freedesktop.org, spice-devel@lists.freedesktop.org,
 virtualization@lists.linux-foundation.org,
 =?UTF-8?Q?Christian_K=c3=b6nig?= <christian.koenig@amd.com>,
 Ben Skeggs <bskeggs@redhat.com>
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
Content-Type: multipart/mixed; boundary="===============4676465360172788423=="
Errors-To: virtualization-bounces@lists.linux-foundation.org
Sender: "Virtualization" <virtualization-bounces@lists.linux-foundation.org>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--===============4676465360172788423==
Content-Language: en-US
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="------------B6UIr1uaa90BoK3L0T3a7xAT"

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--------------B6UIr1uaa90BoK3L0T3a7xAT
Content-Type: multipart/mixed; boundary="------------i143tV5bKgPhhjLIGaoCb4k9";
 protected-headers="v1"
From: Thomas Zimmermann <tzimmermann@suse.de>
To: Javier Martinez Canillas <javierm@redhat.com>,
 Jani Nikula <jani.nikula@linux.intel.com>, linux-kernel@vger.kernel.org
Cc: "Pan, Xinhui" <Xinhui.Pan@amd.com>,
 Pekka Paalanen <pekka.paalanen@collabora.com>,
 Hans de Goede <hdegoede@redhat.com>, David Airlie <airlied@linux.ie>,
 Daniel Vetter <daniel.vetter@ffwll.ch>, dri-devel@lists.freedesktop.org,
 Rodrigo Vivi <rodrigo.vivi@intel.com>, amd-gfx@lists.freedesktop.org,
 Gurchetan Singh <gurchetansingh@chromium.org>,
 Ben Skeggs <bskeggs@redhat.com>,
 VMware Graphics <linux-graphics-maintainer@vmware.com>,
 Gerd Hoffmann <kraxel@redhat.com>, spice-devel@lists.freedesktop.org,
 nouveau@lists.freedesktop.org, Alex Deucher <alexander.deucher@amd.com>,
 Dave Airlie <airlied@redhat.com>, =?UTF-8?Q?Christian_K=c3=b6nig?=
 <christian.koenig@amd.com>, virtualization@lists.linux-foundation.org,
 intel-gfx@lists.freedesktop.org, =?UTF-8?Q?Michel_D=c3=a4nzer?=
 <michel@daenzer.net>, Peter Robinson <pbrobinson@gmail.com>
Message-ID: <51ed4aec-9496-5ccc-97f2-1328ffd767ae@suse.de>
Subject: Re: [PATCH v2 1/2] drm: Add a drm_drv_enabled() to check if drivers
 should be enabled
References: <20211104160707.1407052-1-javierm@redhat.com>
 <20211104160707.1407052-2-javierm@redhat.com> <87ilx7ae3v.fsf@intel.com>
 <0c07f121-42d3-9f37-1e14-842fb685b501@redhat.com>
 <d4a64906-69e5-3250-2362-79f2afac0a23@suse.de>
 <38dbcc8f-2f95-6846-537f-9b85468bfa87@redhat.com>
In-Reply-To: <38dbcc8f-2f95-6846-537f-9b85468bfa87@redhat.com>

--------------i143tV5bKgPhhjLIGaoCb4k9
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: base64

SGkNCg0KQW0gMDUuMTEuMjEgdW0gMTA6NDggc2NocmllYiBKYXZpZXIgTWFydGluZXogQ2Fu
aWxsYXM6DQo+IEhlbGxvIFRob21hcywNCj4gDQo+IE9uIDExLzUvMjEgMDk6NDMsIFRob21h
cyBaaW1tZXJtYW5uIHdyb3RlOg0KPj4gSGkNCj4+DQo+PiBBbSAwNC4xMS4yMSB1bSAyMTow
OSBzY2hyaWViIEphdmllciBNYXJ0aW5leiBDYW5pbGxhczoNCj4+PiBIZWxsbyBKYW5pLA0K
Pj4+DQo+Pj4gT24gMTEvNC8yMSAyMDo1NywgSmFuaSBOaWt1bGEgd3JvdGU6DQo+Pj4+IE9u
IFRodSwgMDQgTm92IDIwMjEsIEphdmllciBNYXJ0aW5leiBDYW5pbGxhcyA8amF2aWVybUBy
ZWRoYXQuY29tPiB3cm90ZToNCj4+Pj4+ICsvKioNCj4+Pj4+ICsgKiBkcm1fZHJ2X2VuYWJs
ZWQgLSBDaGVja3MgaWYgYSBEUk0gZHJpdmVyIGNhbiBiZSBlbmFibGVkDQo+Pj4+PiArICog
QGRyaXZlcjogRFJNIGRyaXZlciB0byBjaGVjaw0KPj4+Pj4gKyAqDQo+Pj4+PiArICogQ2hl
Y2tzIHdoZXRoZXIgYSBEUk0gZHJpdmVyIGNhbiBiZSBlbmFibGVkIG9yIG5vdC4gVGhpcyBt
YXkgYmUgdGhlIGNhc2UNCj4+Pj4+ICsgKiBpZiB0aGUgIm5vbW9kZXNldCIga2VybmVsIGNv
bW1hbmQgbGluZSBwYXJhbWV0ZXIgaXMgdXNlZC4NCj4+Pj4+ICsgKg0KPj4+Pj4gKyAqIFJl
dHVybjogMCBvbiBzdWNjZXNzIG9yIGEgbmVnYXRpdmUgZXJyb3IgY29kZSBvbiBmYWlsdXJl
Lg0KPj4+Pj4gKyAqLw0KPj4+Pj4gK2ludCBkcm1fZHJ2X2VuYWJsZWQoY29uc3Qgc3RydWN0
IGRybV9kcml2ZXIgKmRyaXZlcikNCj4+DQo+PiBKYW5pIG1lbnRpb25lZCB0aGF0IGk5MTUg
YWJzb2x1dGVseSB3YW50cyB0aGlzIHRvIHJ1biBmcm9tIHRoZQ0KPj4gbW9kdWxlX2luaXQg
ZnVuY3Rpb24uIEJlc3QgaXMgdG8gZHJvcCB0aGUgcGFyYW1ldGVyLg0KPj4NCj4gDQo+IE9r
LiBJIG5vdyB3b25kZXIgdGhvdWdoIGhvdyBtdWNoIHZhbHVlIHdvdWxkIGFkZCB0aGlzIGZ1
bmN0aW9uIHNpbmNlDQo+IGl0IHdpbGwganVzdCBiZSBhIHdyYXBwZXIgYXJvdW5kIHRoZSBu
b21vZGVzZXQgY2hlY2suDQo+IA0KPiBXZSB0YWxrZWQgYWJvdXQgYWRkaW5nIGEgbmV3IERS
SVZFUl9HRU5FUklDIGZlYXR1cmUgZmxhZyBhbmQgY2hlY2sgZm9yDQo+IHRoaXMsIGJ1dCBh
cyBkYW52ZXQgbWVudGlvbmVkIHRoYXQgaXMgbm90IHJlYWxseSBuZWVkZWQuIFdlIGp1c3Qg
bmVlZA0KPiB0byBhdm9pZCB0ZXN0aW5nIGZvciBub21vZGVzZXQgaW4gdGhlIHNpbXBsZWRy
bSBkcml2ZXIuDQo+IA0KPiBEbyB5b3UgZW52aXNpb24gb3RoZXIgY29uZGl0aW9uIHRoYXQg
Y291bGQgYmUgYWRkZWQgbGF0ZXIgdG8gZGlzYWJsZSBhDQo+IERSTSBkcml2ZXIgPyBPciBk
byB5b3UgdGhpbmsgdGhhdCBqdXN0IGZyb20gYSBjb2RlIHJlYWRhYmlsaXR5IHBvaW50IG9m
DQo+IHZpZXcgbWFrZXMgd29ydGggaXQgPw0KDQpEUklWRVJfR0VORVJJQyB3b3VsZCBoYXZl
IGJlZW4gbmljZSwgYnV0IGl0J3Mgbm90IGhhcHBlbmluZyBub3cuDQoNCkkgc3VnZ2VzdCB0
byBtb3ZlIG92ZXIgdGhlIG5vbW9kZXNldCBwYXJhbWV0ZXIgKGkuZS4sIHRoaXMgcGF0Y2hz
ZXQpLCANCnRoZW4gbWFrZSB0aGUgY29uZmlnIG9wdGlvbiBzeXN0ZW0gYWdub3N0aWMsIGFu
ZCBmaW5hbGx5IGFkZCB0aGUgdGVzdCB0byANCmFsbCBkcml2ZXJzIGV4cGVjdCBzaW1wbGVk
cm0uIFRoYXQgc2hvdWxkIHNvbHZlIHRoZSBpbW1pbmVudCBwcm9ibGVtLg0KDQpCZXN0IHJl
Z2FyZHMNClRob21hcw0KDQo+IA0KPj4+Pj4gK3sNCj4+Pj4+ICsJaWYgKHZnYWNvbl90ZXh0
X2ZvcmNlKCkpIHsNCj4+Pj4+ICsJCURSTV9JTkZPKCIlcyBkcml2ZXIgaXMgZGlzYWJsZWRc
biIsIGRyaXZlci0+bmFtZSk7DQo+Pj4+PiArCQlyZXR1cm4gLUVOT0RFVjsNCj4+Pj4+ICsJ
fQ0KPj4NCj4+IElmIHdlIHJ1biB0aGlzIGZyb20gd2l0aGluIGEgbW9kdWxlX2luaXQgZnVu
Y3Rpb24sIHdlJ2QgZ2V0IHBsZW50eSBvZg0KPj4gdGhlc2Ugd2FybmluZ3MgaWYgZHJpdmVy
cyBhcmUgY29tcGlsZWQgaW50byB0aGUga2VybmVsLiBNYXliZSBzaW1wbHkNCj4+IHJlbW92
ZSB0aGUgbWVzc2FnZS4gVGhlcmUncyBhbHJlYWR5IGEgd2FybmluZyBwcmludGVkIGJ5IHRo
ZSBub21vZGVzZXQNCj4+IGhhbmRsZXIuDQo+Pg0KPiANCj4gSW5kZWVkLiBJJ2xsIGp1c3Qg
ZHJvcCBpdC4NCj4gDQo+Pj4+PiArDQo+Pj4+PiArCXJldHVybiAwOw0KPj4+Pj4gK30NCj4+
Pj4+ICtFWFBPUlRfU1lNQk9MKGRybV9kcnZfZW5hYmxlZCk7DQo+Pj4+DQo+Pj4+IFRoZSBu
YW1lIGltcGxpZXMgYSBib29sIHJldHVybiwgYnV0IGl0J3Mgbm90Lg0KPj4+Pg0KPj4+PiAJ
aWYgKGRybV9kcnZfZW5hYmxlZCguLi4pKSB7DQo+Pj4+IAkJLyogc3VycHJpc2UsIGl0J3Mg
ZGlzYWJsZWQhICovDQo+Pj4+IAl9DQo+Pj4+DQo+Pj4NCj4+PiBJdCB1c2VkIHRvIHJldHVy
biBhIGJvb2wgaW4gdjIgYnV0IFRob21hcyBzdWdnZXN0ZWQgYW4gaW50IGluc3RlYWQgdG8N
Cj4+PiBoYXZlIGNvbnNpc3RlbmN5IG9uIHRoZSBlcnJubyBjb2RlIHRoYXQgd2FzIHJldHVy
bmVkIGJ5IHRoZSBjYWxsZXJzLg0KPj4+DQo+Pj4gSSBzaG91bGQgcHJvYmFibHkgbmFtZSB0
aGF0IGZ1bmN0aW9uIGRpZmZlcmVudGx5IHRvIGF2b2lkIGNvbmZ1c2lvbi4NCj4+DQo+PiBZ
ZXMsIHBsZWFzZS4NCj4+DQo+IA0KPiBkcm1fZHJpdmVyX2NoZWNrKCkgbWF5YmUgPw0KPiAg
IA0KPiBCZXN0IHJlZ2FyZHMsDQo+IA0KDQotLSANClRob21hcyBaaW1tZXJtYW5uDQpHcmFw
aGljcyBEcml2ZXIgRGV2ZWxvcGVyDQpTVVNFIFNvZnR3YXJlIFNvbHV0aW9ucyBHZXJtYW55
IEdtYkgNCk1heGZlbGRzdHIuIDUsIDkwNDA5IE7DvHJuYmVyZywgR2VybWFueQ0KKEhSQiAz
NjgwOSwgQUcgTsO8cm5iZXJnKQ0KR2VzY2jDpGZ0c2bDvGhyZXI6IEl2byBUb3Rldg0K

--------------i143tV5bKgPhhjLIGaoCb4k9--

--------------B6UIr1uaa90BoK3L0T3a7xAT
Content-Type: application/pgp-signature; name="OpenPGP_signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="OpenPGP_signature"

-----BEGIN PGP SIGNATURE-----

wsF5BAABCAAjFiEExndm/fpuMUdwYFFolh/E3EQov+AFAmGFBFkFAwAAAAAACgkQlh/E3EQov+BM
VxAApJ+gCwrWKtMnfMCIOdE1H5sy5UiFFRJhaFO9nWmtTfxEkKFpICSMRdQjvfXmVpzfF9d4XU24
R0ORKedqqjdlvs1N9IO/0w3YzrdnchVmel9qwBbuqaO8okKuyhWqgAE87D/lhExbiUejptg1JNKJ
OWC33FOGtNwkNnV6QUwLuMABt39tqBGJewiQd/agaEMt/JTaB6O4wdPf/CkESKiniZZ1Sk4+ilsl
Oi2mPR6Vse1Q0zCfy2pDhKlNVhQoxwSJSz74lHHssfse/eex+a5Tg3gsgQII3ka2tJELoOzuBMGG
IfsX0xT4lGnY9EvrrP7tPm48q6oqY3febUebBgJPnctqcpmdexGOx0hQ+LXbBcOzhFwDva8I09/K
Z/wR8yUPKNxLgXBk1ZwmCQ1SLR/sBc9S9zYWB8SBMlOBsil7lVT1bQSftVOh/qhWY+VdCU8I2Xgr
NsySLGVoj+LbUMLYuSke8IzcmgdPohY9oNM97N6eflxeeB20nSk9pvvqN8FBRPBYUgGNvAg3hD3t
Vsz/mGCx1LXlhrJlk37Fu9nDPKeQliaNNAiQsfdvVAl18aptfS2jCEgYewMDOHC5jaw5/OMSS4y3
l0W+Gy8BI91wwm0xevVaN4b8I0/UtAiPx1k0xO1V3gSyTalUob6+SgPT//FN5VaRSFrX8aKDWA3/
NNo=
=XthL
-----END PGP SIGNATURE-----

--------------B6UIr1uaa90BoK3L0T3a7xAT--

--===============4676465360172788423==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
--===============4676465360172788423==--
