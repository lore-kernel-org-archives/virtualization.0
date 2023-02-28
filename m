Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 35F86C64EC7
	for <virtualization@archiver.kernel.org>; Tue, 28 Feb 2023 15:43:52 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id C0B0E81F74;
	Tue, 28 Feb 2023 15:43:51 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org C0B0E81F74
Authentication-Results: smtp1.osuosl.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20210112 header.b=WyJg6CTQ
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
	by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id mgEcRit05Bb9; Tue, 28 Feb 2023 15:43:51 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp1.osuosl.org (Postfix) with ESMTPS id 4D45F81E3A;
	Tue, 28 Feb 2023 15:43:50 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 4D45F81E3A
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id F11C7C0033;
	Tue, 28 Feb 2023 15:43:49 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [IPv6:2605:bc80:3010::133])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 61478C002B
 for <virtualization@lists.linux-foundation.org>;
 Tue, 28 Feb 2023 15:43:49 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id 3CD89401D5
 for <virtualization@lists.linux-foundation.org>;
 Tue, 28 Feb 2023 15:43:49 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org 3CD89401D5
Authentication-Results: smtp2.osuosl.org;
 dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com
 header.a=rsa-sha256 header.s=20210112 header.b=WyJg6CTQ
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id xFDm-DsaGtgu
 for <virtualization@lists.linux-foundation.org>;
 Tue, 28 Feb 2023 15:43:48 +0000 (UTC)
X-Greylist: whitelisted by SQLgrey-1.8.0
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org 7E51D400F3
Received: from mail-oo1-xc34.google.com (mail-oo1-xc34.google.com
 [IPv6:2607:f8b0:4864:20::c34])
 by smtp2.osuosl.org (Postfix) with ESMTPS id 7E51D400F3
 for <virtualization@lists.linux-foundation.org>;
 Tue, 28 Feb 2023 15:43:48 +0000 (UTC)
Received: by mail-oo1-xc34.google.com with SMTP id
 x19-20020a4a3953000000b00525191358b6so1612590oog.12
 for <virtualization@lists.linux-foundation.org>;
 Tue, 28 Feb 2023 07:43:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20210112;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=LonH6h0XflHd2ZjJoaCMQxM+eselh1rFlXJtr2TdEH0=;
 b=WyJg6CTQHizjZtwa26KfNyODiFG3bpBQVCtLC6kZa2jQ93g3cNA0st7X5zv0Q0WEyz
 DssEP8HT6EafkjajKflc8sIiiF0dUns20WwxZRwoLYoYxJDiuQntnrgON6O0bmAB78gU
 eusnG6BYYBWBbE9LMTXMKE1W0CDyQP43ruj+RGcEzoFV8LOE3zN/x9BMvVl2JZ1quO1J
 YTTCzT58vDVD0zhGKokq3aPnJ1b01i5rGPvzR8ipxkTmzyihfnBoBJxmHS8DBHDCFkJT
 en235u700aMHlAZhuPqoO8i2/Fohbbk33SHXIvLNO4mmMkLm7loqL7m1EG3wa+b8ziGD
 udpg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=LonH6h0XflHd2ZjJoaCMQxM+eselh1rFlXJtr2TdEH0=;
 b=tPZZUKaxMcKLpQw15/s5iizjFGbrmVP2//if3cuSRyu9YfWzGvUCJ01epejTsrolKx
 zglmOebIf9pLjZUjap5WfiZ6Z8MlCK0dKlglg/4VC4kLjzW8FBtnLMeesJDvqU0Slz/g
 vNPnCyb40yeCJ5pz2LayDECJwNeJbQA59QL58vcjvG4QaIe2bIXwhcQbOwG1HG9M2B68
 7ze6LFIY1lxKO+3ooyp+dKiiW6DVf/90T3pWXSaLG0+RDySeqPh9rc74ROZDtdX899PG
 3Eb0HYsUvy46j3c2JEYp9wSRdgCiWp51fdYIHpixnLe23EkKBHPINgbxfpKuzse3PJXW
 fEfQ==
X-Gm-Message-State: AO0yUKVC8zDFaVaulHns+RLBagGOwjSAgAtLwXagYx2Yy/oPBv8DRj0U
 LY0Uqxfrl+8RnZyr9/LhaNwBemu4cjpzVX0qAHE=
X-Google-Smtp-Source: AK7set8STQ1oztAalDc2bpQ9rNAMwQTUZCm2yzbWRYUjL7JbeIR+duZmjExm+N3PqFqj9f5vVh1ZzbL3mR9s5ouJdgQ=
X-Received: by 2002:a4a:840f:0:b0:525:499e:ce2f with SMTP id
 l15-20020a4a840f000000b00525499ece2fmr795883oog.1.1677599027483; Tue, 28 Feb
 2023 07:43:47 -0800 (PST)
MIME-Version: 1.0
References: <20230227173800.2809727-1-robdclark@gmail.com>
 <44e67d88-fce6-a1c1-79a9-a937e64a32bb@collabora.com>
 <CAF6AEGsT8_o+v0vzGu1nyh6Z82pj8FnGUdMFc0Lq+4OWoSjRBQ@mail.gmail.com>
 <fb70356e-4e13-1858-9e1a-e886f5918030@suse.de>
In-Reply-To: <fb70356e-4e13-1858-9e1a-e886f5918030@suse.de>
From: Rob Clark <robdclark@gmail.com>
Date: Tue, 28 Feb 2023 07:43:36 -0800
Message-ID: <CAF6AEGt2SYvppE3-QbmZNbgVgTNndT+mRUe6N-z0AS+SB6KKoQ@mail.gmail.com>
Subject: Re: [PATCH v3] drm/virtio: Add option to disable KMS support
To: Thomas Zimmermann <tzimmermann@suse.de>
Cc: Rob Clark <robdclark@chromium.org>, Ryan Neph <ryanneph@chromium.org>,
 open list <linux-kernel@vger.kernel.org>, dri-devel@lists.freedesktop.org,
 Gurchetan Singh <gurchetansingh@chromium.org>,
 Dmitry Osipenko <dmitry.osipenko@collabora.com>,
 David Airlie <airlied@redhat.com>,
 "open list:VIRTIO GPU DRIVER" <virtualization@lists.linux-foundation.org>
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

T24gVHVlLCBGZWIgMjgsIDIwMjMgYXQgNDozNCBBTSBUaG9tYXMgWmltbWVybWFubiA8dHppbW1l
cm1hbm5Ac3VzZS5kZT4gd3JvdGU6Cj4KPiBIaQo+Cj4gQW0gMjcuMDIuMjMgdW0gMTk6MTUgc2No
cmllYiBSb2IgQ2xhcms6Cj4gPiBPbiBNb24sIEZlYiAyNywgMjAyMyBhdCA5OjU3IEFNIERtaXRy
eSBPc2lwZW5rbwo+ID4gPGRtaXRyeS5vc2lwZW5rb0Bjb2xsYWJvcmEuY29tPiB3cm90ZToKPiA+
Pgo+ID4+IE9uIDIvMjcvMjMgMjA6MzgsIFJvYiBDbGFyayB3cm90ZToKPiA+PiAuLi4KPiA+Pj4g
KyAgICAgaWYgKElTX0VOQUJMRUQoQ09ORklHX0RSTV9WSVJUSU9fR1BVX0tNUykpIHsKPiA+Pj4g
KyAgICAgICAgICAgICAvKiBnZXQgZGlzcGxheSBpbmZvICovCj4gPj4+ICsgICAgICAgICAgICAg
dmlydGlvX2NyZWFkX2xlKHZnZGV2LT52ZGV2LCBzdHJ1Y3QgdmlydGlvX2dwdV9jb25maWcsCj4g
Pj4+ICsgICAgICAgICAgICAgICAgICAgICAgICAgICAgIG51bV9zY2Fub3V0cywgJm51bV9zY2Fu
b3V0cyk7Cj4gPj4+ICsgICAgICAgICAgICAgdmdkZXYtPm51bV9zY2Fub3V0cyA9IG1pbl90KHVp
bnQzMl90LCBudW1fc2Nhbm91dHMsCj4gPj4+ICsgICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgIFZJUlRJT19HUFVfTUFYX1NDQU5PVVRTKTsKPiA+Pj4gKyAgICAgICAgICAg
ICBpZiAoIXZnZGV2LT5udW1fc2Nhbm91dHMpIHsKPiA+Pj4gKyAgICAgICAgICAgICAgICAgICAg
IC8qCj4gPj4+ICsgICAgICAgICAgICAgICAgICAgICAgKiBIYXZpbmcgYW4gRURJRCBidXQgbm8g
c2Nhbm91dHMgaXMgbm9uLXNlbnNpY2FsLAo+ID4+PiArICAgICAgICAgICAgICAgICAgICAgICog
YnV0IGl0IGlzIHBlcm1pdHRlZCB0byBoYXZlIG5vIHNjYW5vdXRzIGFuZCBubwo+ID4+PiArICAg
ICAgICAgICAgICAgICAgICAgICogRURJRCAoaW4gd2hpY2ggY2FzZSBEUklWRVJfTU9ERVNFVCBh
bmQKPiA+Pj4gKyAgICAgICAgICAgICAgICAgICAgICAqIERSSVZFUl9BVE9NSUMgYXJlIG5vdCBh
ZHZlcnRpc2VkKQo+ID4+PiArICAgICAgICAgICAgICAgICAgICAgICovCj4gPj4+ICsgICAgICAg
ICAgICAgICAgICAgICBpZiAodmdkZXYtPmhhc19lZGlkKSB7Cj4gPj4+ICsgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgIERSTV9FUlJPUigibnVtX3NjYW5vdXRzIGlzIHplcm9cbiIpOwo+ID4+
PiArICAgICAgICAgICAgICAgICAgICAgICAgICAgICByZXQgPSAtRUlOVkFMOwo+ID4+PiArICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICBnb3RvIGVycl9zY2Fub3V0czsKPiA+Pj4gKyAgICAg
ICAgICAgICAgICAgICAgIH0KPiA+Pj4gKyAgICAgICAgICAgICAgICAgICAgIGRldi0+ZHJpdmVy
X2ZlYXR1cmVzICY9IH4oRFJJVkVSX01PREVTRVQgfCBEUklWRVJfQVRPTUlDKTsKPiA+Pgo+ID4+
IElmIGl0J3Mgbm93IGNvbmZpZ3VyYWJsZSBieSBob3N0LCB3aHkgZG8gd2UgbmVlZCB0aGUKPiA+
PiBDT05GSUdfRFJNX1ZJUlRJT19HUFVfS01TPwo+ID4KPiA+IEJlY2F1c2UgYSBrZXJuZWwgY29u
ZmlnIG9wdGlvbiBtYWtlcyBpdCBtb3JlIG9idmlvdXMgdGhhdAo+ID4gbW9kZXNldC9hdG9taWMg
aW9jdGxzIGFyZSBibG9ja2VkLiAgV2hpY2ggbWFrZXMgaXQgbW9yZSBvYnZpb3VzIGFib3V0Cj4g
PiB3aGVyZSBhbnkgcG90ZW50aWFsIHNlY3VyaXR5IGlzc3VlcyBhcHBseSBhbmQgd2hlcmUgZml4
ZXMgbmVlZCB0byBnZXQKPiA+IGJhY2twb3J0ZWQgdG8uICBUaGUgY29uZmlnIG9wdGlvbiBpcyB0
aGUgb25seSB0aGluZyBfSV8gd2FudCwKPiA+IGV2ZXJ5dGhpbmcgZWxzZSBpcyBqdXN0IGEgYm9u
dXMgdG8gaGVscCBvdGhlciBwZW9wbGUncyB1c2UtY2FzZXMuCj4KPiBJIGZpbmQgdGhpcyB2ZXJ5
IHZhZ3VlLiBXaGF0J3MgdGhlIHNlY3VyaXR5IHRocmVhZD8KClRoZSBtb2Rlc2V0IGlvY3RscyBh
cmUgYSBiaWcgcG90ZW50aWFsIGF0dGFjayBzdXJmYWNlIGFyZWEuICBXaGljaCBpbgp0aGUgY2Fz
ZSBvZiBDck9TIFZNIGd1ZXN0cyBzZXJ2ZXMgbm8gbGVnaXRpbWF0ZSBwdXJwb3NlLiAgKGttcyBp
cwp1bnVzZWQgaW4gdGhlIGd1ZXN0LCBpbnN0ZWFkIGd1ZXN0IHdpbmRvdyBzdXJmYWNlcyBhcmUg
cHJveGllZCB0byBob3N0CmZvciBjb21wb3NpdGlvbiBhbG9uZ3NpZGUgaG9zdCB3aW5kb3cgc3Vy
ZmFjZXMuKQoKVGhlcmUgaGF2ZSBiZWVuIGluIHRoZSBwYXN0IHBvdGVudGlhbCBzZWN1cml0eSBi
dWdzICh1c2UtYWZ0ZXItZnJlZSwKZXRjKSBmb3VuZCBpbiB0aGUga21zIGlvY3Rscy4gIFdlIHNo
b3VsZCBhc3N1bWUgdGhhdCB0aGVyZSB3aWxsIGJlCm1vcmUgaW4gdGhlIGZ1dHVyZS4gIFNvIGl0
IHNlZW1zIGxpa2Ugc2ltcGxlIGNvbW1vbiBzZW5zZSB0byB3YW50IHRvCmJsb2NrIHVudXNlZCBp
b2N0bHMuCgo+IEFuZCBpZiB0aGUgY29uZmlnIG9wdGlvbiBpcyB1c2VmdWwsIHNob3VsZG4ndCBp
dCBiZSBEUk0td2lkZT8gVGhlCj4gbW9kZXNldHRpbmcgaW9jdGwgY2FsbHMgYXJlIHNoYXJlZCBh
bW9uZyBhbGwgZHJpdmVycy4KCk1heWJlLCBpZiB0aGVyZSBpcyBhIHVzZT8gIFRoZSBzaXR1YXRp
b24gb2YgY29tcG9zaXRpbmcgZ3Vlc3Qgd2luZG93cwppbiB0aGUgaG9zdCBzZWVtcyBhIGJpdCB1
bmlxdWUgdG8gdmlydGdwdSwgd2hpY2ggaXMgd2h5IEkgd2VudCB3aXRoIGEKY29uZmlnIG9wdGlv
biBzcGVjaWZpYyB0byB2aXJ0Z3B1LgoKQlIsCi1SCgo+IEJlc3QgcmVnYXJkcwo+IFRob21hcwo+
Cj4gPgo+ID4gQlIsCj4gPiAtUgo+Cj4gLS0KPiBUaG9tYXMgWmltbWVybWFubgo+IEdyYXBoaWNz
IERyaXZlciBEZXZlbG9wZXIKPiBTVVNFIFNvZnR3YXJlIFNvbHV0aW9ucyBHZXJtYW55IEdtYkgK
PiBNYXhmZWxkc3RyLiA1LCA5MDQwOSBOw7xybmJlcmcsIEdlcm1hbnkKPiAoSFJCIDM2ODA5LCBB
RyBOw7xybmJlcmcpCj4gR2VzY2jDpGZ0c2bDvGhyZXI6IEl2byBUb3RldgpfX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fXwpWaXJ0dWFsaXphdGlvbiBtYWlsaW5n
IGxpc3QKVmlydHVhbGl6YXRpb25AbGlzdHMubGludXgtZm91bmRhdGlvbi5vcmcKaHR0cHM6Ly9s
aXN0cy5saW51eGZvdW5kYXRpb24ub3JnL21haWxtYW4vbGlzdGluZm8vdmlydHVhbGl6YXRpb24=
