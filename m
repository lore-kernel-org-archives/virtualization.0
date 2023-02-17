Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A4007C05027
	for <virtualization@archiver.kernel.org>; Fri, 17 Feb 2023 12:23:59 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 2957441A50;
	Fri, 17 Feb 2023 12:23:59 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org 2957441A50
Authentication-Results: smtp4.osuosl.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=suse.de header.i=@suse.de header.a=rsa-sha256 header.s=susede2_rsa header.b=wSD0+pq4;
	dkim=fail reason="signature verification failed" header.d=suse.de header.i=@suse.de header.a=ed25519-sha256 header.s=susede2_ed25519 header.b=NstaHwo+
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
	by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id 1tMi71D6Gqvg; Fri, 17 Feb 2023 12:23:58 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp4.osuosl.org (Postfix) with ESMTPS id 479CC41677;
	Fri, 17 Feb 2023 12:23:57 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org 479CC41677
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 173BAC0033;
	Fri, 17 Feb 2023 12:23:57 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [IPv6:2605:bc80:3010::133])
 by lists.linuxfoundation.org (Postfix) with ESMTP id B2FE0C002B
 for <virtualization@lists.linux-foundation.org>;
 Fri, 17 Feb 2023 12:23:55 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id 8DBA14016B
 for <virtualization@lists.linux-foundation.org>;
 Fri, 17 Feb 2023 12:23:55 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org 8DBA14016B
Authentication-Results: smtp2.osuosl.org;
 dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de
 header.a=rsa-sha256 header.s=susede2_rsa header.b=wSD0+pq4; 
 dkim=pass header.d=suse.de header.i=@suse.de header.a=ed25519-sha256
 header.s=susede2_ed25519 header.b=NstaHwo+
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id u1ig3ASlBAfA
 for <virtualization@lists.linux-foundation.org>;
 Fri, 17 Feb 2023 12:23:54 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org 51B1D4011D
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.220.28])
 by smtp2.osuosl.org (Postfix) with ESMTPS id 51B1D4011D
 for <virtualization@lists.linux-foundation.org>;
 Fri, 17 Feb 2023 12:23:54 +0000 (UTC)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id AC84D33992;
 Fri, 17 Feb 2023 12:23:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1676636630; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=3ddjyR8ugi+S5EIlkCa0m8Ts4ukLHdqO1La6lUfJnoI=;
 b=wSD0+pq4c8y3/HMH8Nyb0OTN4FQ7YFTLzzgJSOLK7DgGGlnlQ3fmp1X5XPIrCLY5gpigXY
 Xdbl4uGraYhW+fnEFyJ+8J0vx6q63aQWlH/mp10I0tyOxdXSzTF542n6N7K8LC9zYwQhuH
 e7iIk+DEMwb6IKXMADDJ4p1xQqbRMrU=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1676636630;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=3ddjyR8ugi+S5EIlkCa0m8Ts4ukLHdqO1La6lUfJnoI=;
 b=NstaHwo+vCdFmJTjkC3/azoenRagWe35BGJMiekBa0DMrSbQjfzNPrTIbnBQTI6HSyu8F/
 LekfIzhJwYFYrNBw==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 3549F13274;
 Fri, 17 Feb 2023 12:23:50 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
 by imap2.suse-dmz.suse.de with ESMTPSA id fC0KDNZx72MpZAAAMHmgww
 (envelope-from <tzimmermann@suse.de>); Fri, 17 Feb 2023 12:23:50 +0000
Message-ID: <bd44b702-34b5-816f-9ef9-00205a4375d0@suse.de>
Date: Fri, 17 Feb 2023 13:23:49 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.6.1
Subject: Re: [PATCH v10 03/11] drm/gem: Add evict() callback to
 drm_gem_object_funcs
Content-Language: en-US
To: Dmitry Osipenko <dmitry.osipenko@collabora.com>,
 David Airlie <airlied@gmail.com>, Gerd Hoffmann <kraxel@redhat.com>,
 Gurchetan Singh <gurchetansingh@chromium.org>, Chia-I Wu
 <olvaffe@gmail.com>, Daniel Vetter <daniel@ffwll.ch>,
 Daniel Almeida <daniel.almeida@collabora.com>,
 Gustavo Padovan <gustavo.padovan@collabora.com>,
 Daniel Stone <daniel@fooishbar.org>,
 Tomeu Vizoso <tomeu.vizoso@collabora.com>,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>, Rob Clark <robdclark@gmail.com>,
 Sumit Semwal <sumit.semwal@linaro.org>,
 =?UTF-8?Q?Christian_K=c3=b6nig?= <christian.koenig@amd.com>,
 Qiang Yu <yuq825@gmail.com>, Steven Price <steven.price@arm.com>,
 Alyssa Rosenzweig <alyssa.rosenzweig@collabora.com>,
 Rob Herring <robh@kernel.org>, Sean Paul <sean@poorly.run>,
 Dmitry Baryshkov <dmitry.baryshkov@linaro.org>,
 Abhinav Kumar <quic_abhinavk@quicinc.com>
References: <20230108210445.3948344-1-dmitry.osipenko@collabora.com>
 <20230108210445.3948344-4-dmitry.osipenko@collabora.com>
From: Thomas Zimmermann <tzimmermann@suse.de>
In-Reply-To: <20230108210445.3948344-4-dmitry.osipenko@collabora.com>
Cc: kernel@collabora.com, linux-kernel@vger.kernel.org,
 dri-devel@lists.freedesktop.org, virtualization@lists.linux-foundation.org
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
Content-Type: multipart/mixed; boundary="===============2427011307348285726=="
Errors-To: virtualization-bounces@lists.linux-foundation.org
Sender: "Virtualization" <virtualization-bounces@lists.linux-foundation.org>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--===============2427011307348285726==
Content-Language: en-US
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="------------XgxlqJUeJZ17gdNZZniu83tv"

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--------------XgxlqJUeJZ17gdNZZniu83tv
Content-Type: multipart/mixed; boundary="------------vYWkz1BEleRqHYNcrZkuGPM3";
 protected-headers="v1"
From: Thomas Zimmermann <tzimmermann@suse.de>
To: Dmitry Osipenko <dmitry.osipenko@collabora.com>,
 David Airlie <airlied@gmail.com>, Gerd Hoffmann <kraxel@redhat.com>,
 Gurchetan Singh <gurchetansingh@chromium.org>, Chia-I Wu
 <olvaffe@gmail.com>, Daniel Vetter <daniel@ffwll.ch>,
 Daniel Almeida <daniel.almeida@collabora.com>,
 Gustavo Padovan <gustavo.padovan@collabora.com>,
 Daniel Stone <daniel@fooishbar.org>,
 Tomeu Vizoso <tomeu.vizoso@collabora.com>,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>, Rob Clark <robdclark@gmail.com>,
 Sumit Semwal <sumit.semwal@linaro.org>,
 =?UTF-8?Q?Christian_K=c3=b6nig?= <christian.koenig@amd.com>,
 Qiang Yu <yuq825@gmail.com>, Steven Price <steven.price@arm.com>,
 Alyssa Rosenzweig <alyssa.rosenzweig@collabora.com>,
 Rob Herring <robh@kernel.org>, Sean Paul <sean@poorly.run>,
 Dmitry Baryshkov <dmitry.baryshkov@linaro.org>,
 Abhinav Kumar <quic_abhinavk@quicinc.com>
Cc: kernel@collabora.com, linux-kernel@vger.kernel.org,
 dri-devel@lists.freedesktop.org, virtualization@lists.linux-foundation.org
Message-ID: <bd44b702-34b5-816f-9ef9-00205a4375d0@suse.de>
Subject: Re: [PATCH v10 03/11] drm/gem: Add evict() callback to
 drm_gem_object_funcs
References: <20230108210445.3948344-1-dmitry.osipenko@collabora.com>
 <20230108210445.3948344-4-dmitry.osipenko@collabora.com>
In-Reply-To: <20230108210445.3948344-4-dmitry.osipenko@collabora.com>

--------------vYWkz1BEleRqHYNcrZkuGPM3
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: base64

SGkNCg0KQW0gMDguMDEuMjMgdW0gMjI6MDQgc2NocmllYiBEbWl0cnkgT3NpcGVua286DQo+
IEFkZCBuZXcgY29tbW9uIGV2aWN0KCkgY2FsbGJhY2sgdG8gZHJtX2dlbV9vYmplY3RfZnVu
Y3MgYW5kIGNvcnJlc3BvbmRpbmcNCj4gZHJtX2dlbV9vYmplY3RfZXZpY3QoKSBoZWxwZXIu
IFRoaXMgaXMgYSBmaXJzdCBzdGVwIG9uIGEgd2F5IHRvIHByb3ZpZGluZw0KPiBjb21tb24g
R0VNLXNocmlua2VyIEFQSSBmb3IgRFJNIGRyaXZlcnMuDQo+IA0KPiBTdWdnZXN0ZWQtYnk6
IFRob21hcyBaaW1tZXJtYW5uIDx0emltbWVybWFubkBzdXNlLmRlPg0KPiBTaWduZWQtb2Zm
LWJ5OiBEbWl0cnkgT3NpcGVua28gPGRtaXRyeS5vc2lwZW5rb0Bjb2xsYWJvcmEuY29tPg0K
DQpSZXZpZXdlZC1ieTogVGhvbWFzIFppbW1lcm1hbm4gPHR6aW1tZXJtYW5uQHN1c2UuZGU+
DQoNCndpdGggbXkgY29tbWVudHMgYmVsb3cgYWRkcmVzc2VkLg0KDQo+IC0tLQ0KPiAgIGRy
aXZlcnMvZ3B1L2RybS9kcm1fZ2VtLmMgfCAxNiArKysrKysrKysrKysrKysrDQo+ICAgaW5j
bHVkZS9kcm0vZHJtX2dlbS5oICAgICB8IDEyICsrKysrKysrKysrKw0KPiAgIDIgZmlsZXMg
Y2hhbmdlZCwgMjggaW5zZXJ0aW9ucygrKQ0KPiANCj4gZGlmZiAtLWdpdCBhL2RyaXZlcnMv
Z3B1L2RybS9kcm1fZ2VtLmMgYi9kcml2ZXJzL2dwdS9kcm0vZHJtX2dlbS5jDQo+IGluZGV4
IGM2YmNhNWFjNmUwZi4uZGJiNDhmYzlkZmYzIDEwMDY0NA0KPiAtLS0gYS9kcml2ZXJzL2dw
dS9kcm0vZHJtX2dlbS5jDQo+ICsrKyBiL2RyaXZlcnMvZ3B1L2RybS9kcm1fZ2VtLmMNCj4g
QEAgLTE0NzEsMyArMTQ3MSwxOSBAQCBkcm1fZ2VtX2xydV9zY2FuKHN0cnVjdCBkcm1fZ2Vt
X2xydSAqbHJ1LA0KPiAgIAlyZXR1cm4gZnJlZWQ7DQo+ICAgfQ0KPiAgIEVYUE9SVF9TWU1C
T0woZHJtX2dlbV9scnVfc2Nhbik7DQo+ICsNCj4gKy8qKg0KPiArICogZHJtX2dlbV9vYmpl
Y3RfZXZpY3QgLSBoZWxwZXIgdG8gZXZpY3QgYmFja2luZyBwYWdlcyBmb3IgYSBHRU0gb2Jq
ZWN0DQo+ICsgKiBAb2JqOiBvYmogaW4gcXVlc3Rpb24NCj4gKyAqLw0KPiArYm9vbA0KDQpQ
bGVhc2UgdXNlIGludCBhbmQgcmV0dXJuIGFuIGVycm5vIGNvZGUuDQoNCk5vIG5ld2xpbmUg
aGVyZSwgcGxlYXNlLg0KDQo+ICtkcm1fZ2VtX29iamVjdF9ldmljdChzdHJ1Y3QgZHJtX2dl
bV9vYmplY3QgKm9iaikNCj4gK3sNCj4gKwlkbWFfcmVzdl9hc3NlcnRfaGVsZChvYmotPnJl
c3YpOw0KPiArDQo+ICsJaWYgKG9iai0+ZnVuY3MtPmV2aWN0KQ0KPiArCQlyZXR1cm4gb2Jq
LT5mdW5jcy0+ZXZpY3Qob2JqKTsNCj4gKw0KPiArCXJldHVybiBmYWxzZTsNCj4gK30NCj4g
K0VYUE9SVF9TWU1CT0woZHJtX2dlbV9vYmplY3RfZXZpY3QpOw0KPiBkaWZmIC0tZ2l0IGEv
aW5jbHVkZS9kcm0vZHJtX2dlbS5oIGIvaW5jbHVkZS9kcm0vZHJtX2dlbS5oDQo+IGluZGV4
IGYxZjAwZmMyZGJhNi4uOGU1YzIyZjI1NjkxIDEwMDY0NA0KPiAtLS0gYS9pbmNsdWRlL2Ry
bS9kcm1fZ2VtLmgNCj4gKysrIGIvaW5jbHVkZS9kcm0vZHJtX2dlbS5oDQo+IEBAIC0xNzIs
NiArMTcyLDE2IEBAIHN0cnVjdCBkcm1fZ2VtX29iamVjdF9mdW5jcyB7DQo+ICAgCSAqIFRo
aXMgaXMgb3B0aW9uYWwgYnV0IG5lY2Vzc2FyeSBmb3IgbW1hcCBzdXBwb3J0Lg0KPiAgIAkg
Ki8NCj4gICAJY29uc3Qgc3RydWN0IHZtX29wZXJhdGlvbnNfc3RydWN0ICp2bV9vcHM7DQo+
ICsNCj4gKwkvKioNCj4gKwkgKiBAZXZpY3Q6DQo+ICsJICoNCj4gKwkgKiBFdmljdHMgZ2Vt
IG9iamVjdCBvdXQgZnJvbSBtZW1vcnkuIFVzZWQgYnkgdGhlIGRybV9nZW1fb2JqZWN0X2V2
aWN0KCkNCj4gKwkgKiBoZWxwZXIuIFJldHVybnMgdHJ1ZSBvbiBzdWNjZXNzLCBmYWxzZSBv
dGhlcndpc2UuDQo+ICsJICoNCj4gKwkgKiBUaGlzIGNhbGxiYWNrIGlzIG9wdGlvbmFsLg0K
PiArCSAqLw0KPiArCWJvb2wgKCpldmljdCkoc3RydWN0IGRybV9nZW1fb2JqZWN0ICpvYmop
Ow0KDQpUaGlzIHNob3VsZCBiZSBkZWNsYXJlZCBiZXR3ZWVuIG1tYXAgYW5kIGV2aWN0Lg0K
DQpBZ2FpbiwgcGxlYXNlIHVzZSBpbnQgYW5kIHJldHVybiBhbiBlcnJubyBjb2RlLg0KDQo+
ICAgfTsNCj4gICANCj4gICAvKioNCj4gQEAgLTQ4MSw0ICs0OTEsNiBAQCB1bnNpZ25lZCBs
b25nIGRybV9nZW1fbHJ1X3NjYW4oc3RydWN0IGRybV9nZW1fbHJ1ICpscnUsDQo+ICAgCQkJ
ICAgICAgIHVuc2lnbmVkIGxvbmcgKnJlbWFpbmluZywNCj4gICAJCQkgICAgICAgYm9vbCAo
KnNocmluaykoc3RydWN0IGRybV9nZW1fb2JqZWN0ICpvYmopKTsNCj4gICANCj4gK2Jvb2wg
ZHJtX2dlbV9vYmplY3RfZXZpY3Qoc3RydWN0IGRybV9nZW1fb2JqZWN0ICpvYmopOw0KDQpk
cm1fZ2VtX2V2aWN0KCkgc2hvdWxkIGJlIHRoZSBjb3JyZWN0IG5hbWU7IGxpa2UgZHJtX2dl
bV92bWFwKCkgYW5kIA0KZHJtX2dlbV9waW4oKSwgZXRjLg0KDQpCZXN0IHJlZ2FyZHMNClRo
b21hcw0KDQo+ICsNCj4gICAjZW5kaWYgLyogX19EUk1fR0VNX0hfXyAqLw0KDQotLSANClRo
b21hcyBaaW1tZXJtYW5uDQpHcmFwaGljcyBEcml2ZXIgRGV2ZWxvcGVyDQpTVVNFIFNvZnR3
YXJlIFNvbHV0aW9ucyBHZXJtYW55IEdtYkgNCk1heGZlbGRzdHIuIDUsIDkwNDA5IE7DvHJu
YmVyZywgR2VybWFueQ0KKEhSQiAzNjgwOSwgQUcgTsO8cm5iZXJnKQ0KR2VzY2jDpGZ0c2bD
vGhyZXI6IEl2byBUb3Rldg0K

--------------vYWkz1BEleRqHYNcrZkuGPM3--

--------------XgxlqJUeJZ17gdNZZniu83tv
Content-Type: application/pgp-signature; name="OpenPGP_signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="OpenPGP_signature"

-----BEGIN PGP SIGNATURE-----

wsF5BAABCAAjFiEExndm/fpuMUdwYFFolh/E3EQov+AFAmPvcdUFAwAAAAAACgkQlh/E3EQov+Cw
bw/8Dcmr9ufV3Ln2EKd7jQSorGRz4kFZFVHwfHvZ4KQPJ1eUbZU5e5XdNrBvN7EDjZhBFLMhoStb
JTp8BZm9eq4DLp4uJLDXdKqeqj1Q004RIll7Z3wVHM26tGN7uIjM4SqnWi0NZc43IhJ6AuxRMQZE
Piq1wMD+JtYJhTmuSn3QkS34Q/YlFlUnsPwVxnXBQW5/78u2F0WH9PXes6hBdTF96HL8CTqCBK10
5P93U048jeouDF7HbBpj5IWaw006ZZAIW6MOzQoXV4eXOqXpCbzP62ySwh9Nu/nWBAZ8qPtDsAlg
nuuL1NeziySRR1uTqpVtFNAFJGi3LsVVLiFOrMHoQ8fWtkvpPYg/GPwYzKK+/U8H3HNF2g/pzSb9
eL0V4CWJgW+PAnH1sFe0xl24+igCoasX658j7E7EIoXV+6ZfP3bqc/320fEewEz1cc7YvngvsCSO
3WQRyvXOTczS35LntWqHNXdoevJWK7zjC72v/nrku67xDJQIdmFH1SlASeQvseafvPslcwzDaLdt
YVTSw4UmF34GXzTNq333LmC98aLg33uKLN+h95QihgLo+ytENdh+YJn8w9xSrfM4FPWLSHVJ0Qy5
4uGOejKID3mLOYtNufOAL0GUT9xrZ6jfaLD5XRaq+pNa5QKrYQWED9R/6Lq3iyRbjgmpcqgzJEYU
vZA=
=hjd0
-----END PGP SIGNATURE-----

--------------XgxlqJUeJZ17gdNZZniu83tv--

--===============2427011307348285726==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
--===============2427011307348285726==--
