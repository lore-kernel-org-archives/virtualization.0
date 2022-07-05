Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2E6E4C43334
	for <virtualization@archiver.kernel.org>; Tue,  5 Jul 2022 21:48:29 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id A38DC60D50;
	Tue,  5 Jul 2022 21:48:28 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org A38DC60D50
Authentication-Results: smtp3.osuosl.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20210112 header.b=VWKoc1vT
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
	by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id B3AcsHMzSy1N; Tue,  5 Jul 2022 21:48:27 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp3.osuosl.org (Postfix) with ESMTPS id 33BD660B44;
	Tue,  5 Jul 2022 21:48:27 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 33BD660B44
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 086FFC0032;
	Tue,  5 Jul 2022 21:48:27 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [IPv6:2605:bc80:3010::138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id C0266C002D
 for <virtualization@lists.linux-foundation.org>;
 Tue,  5 Jul 2022 21:48:25 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id 9480E81A3E
 for <virtualization@lists.linux-foundation.org>;
 Tue,  5 Jul 2022 21:48:25 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 9480E81A3E
Authentication-Results: smtp1.osuosl.org;
 dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com
 header.a=rsa-sha256 header.s=20210112 header.b=VWKoc1vT
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id P5aorPhTzQPr
 for <virtualization@lists.linux-foundation.org>;
 Tue,  5 Jul 2022 21:48:24 +0000 (UTC)
X-Greylist: whitelisted by SQLgrey-1.8.0
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 4038681985
Received: from mail-wm1-x32a.google.com (mail-wm1-x32a.google.com
 [IPv6:2a00:1450:4864:20::32a])
 by smtp1.osuosl.org (Postfix) with ESMTPS id 4038681985
 for <virtualization@lists.linux-foundation.org>;
 Tue,  5 Jul 2022 21:48:24 +0000 (UTC)
Received: by mail-wm1-x32a.google.com with SMTP id j7so7804889wmp.2
 for <virtualization@lists.linux-foundation.org>;
 Tue, 05 Jul 2022 14:48:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20210112;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc:content-transfer-encoding;
 bh=PU7Lk/8Sax5XmlQiaVaA1dEst+rO/Dc76xfk8EMg5rU=;
 b=VWKoc1vTC7dmodEJ7AnbFDZ5fs/4+Nq8GI6aDF//zH1sFJE8ous9N8DVmhCdNBDu7J
 TEV0OZ7bot7bTz3H4yd56ZRrkwxGIFMbiNXyMqyxTYq3VKR1u9rg6rHhTYMEXhscqSPb
 Ccm6AxwWMhv1d8/+zxJYMjbHjFhlhaXe+b5fXKLXVU2U8ZbZY80EwHbaMEMkj/MpnXbt
 Uw0LZyDNux3g8GLLZXWynLp0GUTzkeUfRCaJubH+VuWeVBLJXqR6LPAfYZV768F05DkS
 81qT5rHG43qh7gdNNw7b8ZC4JsCyyDamnVIJ9F70HPL12MxnnMZIoo1SVum0jci5LIaF
 DoNw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc:content-transfer-encoding;
 bh=PU7Lk/8Sax5XmlQiaVaA1dEst+rO/Dc76xfk8EMg5rU=;
 b=Z7HcrZRB4TWmXI2ohwvmFxm2SOytEuYpUh4GOkPP6XpcYqr1OASzVG9ohFGYblGQ1U
 JEr67MiTDWUHcmzpltb7UHcvbAiJX1t0FEuHf8KYPd31FYNMalw32zgINGu4QJsxmycg
 824rJo0DMWl+JzJNM4qOiivUlZ9St122n4C6bE+smmT8GQxdFyGmRcl8E0jqQeXOcd0a
 JWghJP/O7RzJs9S9s5+hj22ZY4kfheS7dT/oCHiuSk6XLgjBc2147V+3alzRe0EMwbMC
 J0A0StmpzqS/XB7OCcyonoGYlD8cjkZuNbxV60BhAzYfUGYuL3NacMz3UC0waZN63ZsF
 WBOQ==
X-Gm-Message-State: AJIora8X3rG1Zk4hSUgN4+FSSzbPGOtDWKIB+qH8d6k33YxQQ0auT705
 72XfQPvEBU/26qHsgXTdOn60V9o9qVQsVxd4d3U=
X-Google-Smtp-Source: AGRyM1s4DVmvwO3UYi3am/1hl7v5k+11uGFQz8SR7b/jLPUtCXxxfUROpF6gbwNkgnUr5Rze8aRIMeW9WGiopFicipE=
X-Received: by 2002:a05:600c:4f83:b0:3a1:7310:62e7 with SMTP id
 n3-20020a05600c4f8300b003a1731062e7mr36978255wmq.84.1657057702289; Tue, 05
 Jul 2022 14:48:22 -0700 (PDT)
MIME-Version: 1.0
References: <20220701090240.1896131-1-dmitry.osipenko@collabora.com>
 <20220701090240.1896131-3-dmitry.osipenko@collabora.com>
 <2bb95e80-b60a-36c0-76c8-a06833032c77@amd.com>
In-Reply-To: <2bb95e80-b60a-36c0-76c8-a06833032c77@amd.com>
From: Rob Clark <robdclark@gmail.com>
Date: Tue, 5 Jul 2022 14:48:34 -0700
Message-ID: <CAF6AEGtqPeF1DjmBKgzWK39Yi81YiNjTjDNn85TKx7uwicFTSA@mail.gmail.com>
Subject: Re: [PATCH v8 2/2] drm/gem: Don't map imported GEMs
To: =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>
Cc: dri-devel <dri-devel@lists.freedesktop.org>, kernel@collabora.com,
 Dmitry Osipenko <dmitry.osipenko@collabora.com>,
 David Airlie <airlied@linux.ie>, Thomas Zimmermann <tzimmermann@suse.de>,
 =?UTF-8?Q?Thomas_Hellstr=C3=B6m?= <thomas_os@shipmail.org>,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
 Maxime Ripard <mripard@kernel.org>,
 Gurchetan Singh <gurchetansingh@chromium.org>,
 Emil Velikov <emil.l.velikov@gmail.com>, Daniel Vetter <daniel@ffwll.ch>,
 linux-tegra@vger.kernel.org, Dmitry Osipenko <digetx@gmail.com>,
 "open list:VIRTIO GPU DRIVER" <virtualization@lists.linux-foundation.org>,
 Chia-I Wu <olvaffe@gmail.com>
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
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Errors-To: virtualization-bounces@lists.linux-foundation.org
Sender: "Virtualization" <virtualization-bounces@lists.linux-foundation.org>

T24gVHVlLCBKdWwgNSwgMjAyMiBhdCA0OjUxIEFNIENocmlzdGlhbiBLw7ZuaWcgPGNocmlzdGlh
bi5rb2VuaWdAYW1kLmNvbT4gd3JvdGU6Cj4KPiBBbSAwMS4wNy4yMiB1bSAxMTowMiBzY2hyaWVi
IERtaXRyeSBPc2lwZW5rbzoKPiA+IERyaXZlcnMgdGhhdCB1c2UgZHJtX2dlbV9tbWFwKCkgYW5k
IGRybV9nZW1fbW1hcF9vYmooKSBoZWxwZXJzIGRvbid0Cj4gPiBoYW5kbGUgaW1wb3J0ZWQgZG1h
LWJ1ZnMgcHJvcGVybHksIHdoaWNoIHJlc3VsdHMgaW4gbWFwcGluZyBvZiBzb21ldGhpbmcKPiA+
IGVsc2UgdGhhbiB0aGUgaW1wb3J0ZWQgZG1hLWJ1Zi4gT24gTlZJRElBIFRlZ3JhIHdlIGdldCBh
IGhhcmQgbG9ja3VwIHdoZW4KPiA+IHVzZXJzcGFjZSB3cml0ZXMgdG8gdGhlIG1lbW9yeSBtYXBw
aW5nIG9mIGEgZG1hLWJ1ZiB0aGF0IHdhcyBpbXBvcnRlZCBpbnRvCj4gPiBUZWdyYSdzIERSTSBH
RU0uCj4gPgo+ID4gTWFqb3JpdHkgb2YgRFJNIGRyaXZlcnMgcHJvaGliaXQgbWFwcGluZyBvZiB0
aGUgaW1wb3J0ZWQgR0VNIG9iamVjdHMuCj4gPiBNYXBwaW5nIG9mIGltcG9ydGVkIEdFTXMgcmVx
dWlyZSBzcGVjaWFsIGNhcmUgZnJvbSB1c2Vyc3BhY2Ugc2luY2UgaXQKPiA+IHNob3VsZCBzeW5j
IGRtYS1idWYgYmVjYXVzZSBtYXBwaW5nIGNvaGVyZW5jeSBvZiB0aGUgZXhwb3J0ZXIgZGV2aWNl
IG1heQo+ID4gbm90IG1hdGNoIHRoZSBEUk0gZGV2aWNlLiBMZXQncyBwcm9oaWJpdCB0aGUgbWFw
cGluZyBmb3IgYWxsIERSTSBkcml2ZXJzCj4gPiBmb3IgY29uc2lzdGVuY3kuCj4gPgo+ID4gU3Vn
Z2VzdGVkLWJ5OiBUaG9tYXMgSGVsbHN0csO2bSA8dGhvbWFzLmhlbGxzdHJvbUBsaW51eC5pbnRl
bC5jb20+Cj4gPiBTaWduZWQtb2ZmLWJ5OiBEbWl0cnkgT3NpcGVua28gPGRtaXRyeS5vc2lwZW5r
b0Bjb2xsYWJvcmEuY29tPgo+Cj4gSSdtIHByZXR0eSBzdXJlIHRoYXQgdGhpcyBpcyB0aGUgcmln
aHQgYXBwcm9hY2gsIGJ1dCBpdCdzIGNlcnRhaW5seSBtb3JlCj4gdGhhbiBwb3NzaWJsZSB0aGF0
IHNvbWVib2R5IGFidXNlZCB0aGlzIGFscmVhZHkuCgpJIHN1c3BlY3QgdGhhdCB0aGlzIGlzIGFi
dXNlZCBpZiB5b3UgcnVuIGRlcXAgY3RzIG9uIGFuZHJvaWQuLiBpZS4gYWxsCndpbnN5cyBidWZm
ZXJzIGFyZSBkbWEtYnVmIGltcG9ydHMgZnJvbSBncmFsbG9jLiAgQW5kIHRoZW4gd2hlbiB5b3UK
aGl0IHJlYWRwaXguLi4KCllvdSBtaWdodCBvbmx5IGhpdCB0aGlzIGluIHNjZW5hcmlvcyB3aXRo
IHNlcGFyYXRlIGdwdSBhbmQgZGlzcGxheSAob3IKZEdQVStpR1BVKSBiZWNhdXNlIHNlbGYtaW1w
b3J0cyBhcmUgaGFuZGxlZCBkaWZmZXJlbnRseSBpbgpkcm1fZ2VtX3ByaW1lX2ltcG9ydF9kZXYo
KS4uIGFuZCBtYXliZSBub3QgaW4gY2FzZXMgd2hlcmUgeW91IGVuZCB1cAp3aXRoIGEgYmxpdCBm
cm9tIHRpbGVkL2NvbXByZXNzZWQgdG8gbGluZWFyLi4gbWF5YmUgdGhhdCBuYXJyb3dzIHRoZQpz
Y29wZSBlbm91Z2ggdG8ganVzdCBmaXggaXQgaW4gdXNlcnNwYWNlPwoKQlIsCi1SCgo+IEFueXdh
eSBwYXRjaCBpcyBSZXZpZXdlZC1ieTogQ2hyaXN0aWFuIEvDtm5pZyA8Y2hyaXN0aWFuLmtvZW5p
Z0BhbWQuY29tPgo+IHNpbmNlIHlvdSBhcmUgcmVhbGx5IGZpeGluZyBhIG1ham9yIHN0YWJpbGl0
eSBwcm9ibGVtIGhlcmUuCj4KPiBSZWdhcmRzLAo+IENocmlzdGlhbi4KPgo+ID4gLS0tCj4gPiAg
IGRyaXZlcnMvZ3B1L2RybS9kcm1fZ2VtLmMgICAgICAgICAgICAgIHwgNCArKysrCj4gPiAgIGRy
aXZlcnMvZ3B1L2RybS9kcm1fZ2VtX3NobWVtX2hlbHBlci5jIHwgOSAtLS0tLS0tLS0KPiA+ICAg
MiBmaWxlcyBjaGFuZ2VkLCA0IGluc2VydGlvbnMoKyksIDkgZGVsZXRpb25zKC0pCj4gPgo+ID4g
ZGlmZiAtLWdpdCBhL2RyaXZlcnMvZ3B1L2RybS9kcm1fZ2VtLmMgYi9kcml2ZXJzL2dwdS9kcm0v
ZHJtX2dlbS5jCj4gPiBpbmRleCA4NmQ2NzBjNzEyODYuLmZjOWVjNDJmYTBhYiAxMDA2NDQKPiA+
IC0tLSBhL2RyaXZlcnMvZ3B1L2RybS9kcm1fZ2VtLmMKPiA+ICsrKyBiL2RyaXZlcnMvZ3B1L2Ry
bS9kcm1fZ2VtLmMKPiA+IEBAIC0xMDM0LDYgKzEwMzQsMTAgQEAgaW50IGRybV9nZW1fbW1hcF9v
Ymooc3RydWN0IGRybV9nZW1fb2JqZWN0ICpvYmosIHVuc2lnbmVkIGxvbmcgb2JqX3NpemUsCj4g
PiAgIHsKPiA+ICAgICAgIGludCByZXQ7Cj4gPgo+ID4gKyAgICAgLyogRG9uJ3QgYWxsb3cgaW1w
b3J0ZWQgb2JqZWN0cyB0byBiZSBtYXBwZWQgKi8KPiA+ICsgICAgIGlmIChvYmotPmltcG9ydF9h
dHRhY2gpCj4gPiArICAgICAgICAgICAgIHJldHVybiAtRUlOVkFMOwo+ID4gKwo+ID4gICAgICAg
LyogQ2hlY2sgZm9yIHZhbGlkIHNpemUuICovCj4gPiAgICAgICBpZiAob2JqX3NpemUgPCB2bWEt
PnZtX2VuZCAtIHZtYS0+dm1fc3RhcnQpCj4gPiAgICAgICAgICAgICAgIHJldHVybiAtRUlOVkFM
Owo+ID4gZGlmZiAtLWdpdCBhL2RyaXZlcnMvZ3B1L2RybS9kcm1fZ2VtX3NobWVtX2hlbHBlci5j
IGIvZHJpdmVycy9ncHUvZHJtL2RybV9nZW1fc2htZW1faGVscGVyLmMKPiA+IGluZGV4IDhhZDBl
MDI5OTFjYS4uNjE5MGY1MDE4OTg2IDEwMDY0NAo+ID4gLS0tIGEvZHJpdmVycy9ncHUvZHJtL2Ry
bV9nZW1fc2htZW1faGVscGVyLmMKPiA+ICsrKyBiL2RyaXZlcnMvZ3B1L2RybS9kcm1fZ2VtX3No
bWVtX2hlbHBlci5jCj4gPiBAQCAtNjA5LDE3ICs2MDksOCBAQCBFWFBPUlRfU1lNQk9MX0dQTChk
cm1fZ2VtX3NobWVtX3ZtX29wcyk7Cj4gPiAgICAqLwo+ID4gICBpbnQgZHJtX2dlbV9zaG1lbV9t
bWFwKHN0cnVjdCBkcm1fZ2VtX3NobWVtX29iamVjdCAqc2htZW0sIHN0cnVjdCB2bV9hcmVhX3N0
cnVjdCAqdm1hKQo+ID4gICB7Cj4gPiAtICAgICBzdHJ1Y3QgZHJtX2dlbV9vYmplY3QgKm9iaiA9
ICZzaG1lbS0+YmFzZTsKPiA+ICAgICAgIGludCByZXQ7Cj4gPgo+ID4gLSAgICAgaWYgKG9iai0+
aW1wb3J0X2F0dGFjaCkgewo+ID4gLSAgICAgICAgICAgICAvKiBEcm9wIHRoZSByZWZlcmVuY2Ug
ZHJtX2dlbV9tbWFwX29iaigpIGFjcXVpcmVkLiovCj4gPiAtICAgICAgICAgICAgIGRybV9nZW1f
b2JqZWN0X3B1dChvYmopOwo+ID4gLSAgICAgICAgICAgICB2bWEtPnZtX3ByaXZhdGVfZGF0YSA9
IE5VTEw7Cj4gPiAtCj4gPiAtICAgICAgICAgICAgIHJldHVybiBkbWFfYnVmX21tYXAob2JqLT5k
bWFfYnVmLCB2bWEsIDApOwo+ID4gLSAgICAgfQo+ID4gLQo+ID4gICAgICAgcmV0ID0gZHJtX2dl
bV9zaG1lbV9nZXRfcGFnZXMoc2htZW0pOwo+ID4gICAgICAgaWYgKHJldCkgewo+ID4gICAgICAg
ICAgICAgICBkcm1fZ2VtX3ZtX2Nsb3NlKHZtYSk7Cj4KX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX18KVmlydHVhbGl6YXRpb24gbWFpbGluZyBsaXN0ClZpcnR1
YWxpemF0aW9uQGxpc3RzLmxpbnV4LWZvdW5kYXRpb24ub3JnCmh0dHBzOi8vbGlzdHMubGludXhm
b3VuZGF0aW9uLm9yZy9tYWlsbWFuL2xpc3RpbmZvL3ZpcnR1YWxpemF0aW9u
