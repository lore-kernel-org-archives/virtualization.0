Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E4372C6FA82
	for <virtualization@archiver.kernel.org>; Fri, 23 Sep 2022 05:17:22 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 059B9417D7;
	Fri, 23 Sep 2022 05:17:22 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org 059B9417D7
Authentication-Results: smtp4.osuosl.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=fuYGvlli
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
	by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id U_oiVIN66ZRL; Fri, 23 Sep 2022 05:17:20 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp4.osuosl.org (Postfix) with ESMTPS id 06837410D6;
	Fri, 23 Sep 2022 05:17:19 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org 06837410D6
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id D28E9C0033;
	Fri, 23 Sep 2022 05:17:19 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 297A6C002D
 for <virtualization@lists.linux-foundation.org>;
 Fri, 23 Sep 2022 05:17:19 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id E510883E1D
 for <virtualization@lists.linux-foundation.org>;
 Fri, 23 Sep 2022 05:17:18 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org E510883E1D
Authentication-Results: smtp1.osuosl.org;
 dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com
 header.a=rsa-sha256 header.s=mimecast20190719 header.b=fuYGvlli
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id M6nFYkVaoRwu
 for <virtualization@lists.linux-foundation.org>;
 Fri, 23 Sep 2022 05:17:15 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 2BFC782E9D
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.133.124])
 by smtp1.osuosl.org (Postfix) with ESMTPS id 2BFC782E9D
 for <virtualization@lists.linux-foundation.org>;
 Fri, 23 Sep 2022 05:17:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1663910233;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=Tromwnn4H5CG/xgspUfwLWCH6VqqZXFFZnt+Lhbj+LE=;
 b=fuYGvlli60c3Lko7CdpQ7WY9BBGxBLTRNLoQ9slJET01FhmL17qr++ZYu/FFpY9uYv35wR
 hlPQCAbXMvAFebNHvMutx/uHYfWPIXT37xhybZnu6NIbySyXsGeFw/PUdFWhT3s9+Z49yy
 zDac+tmYCJHADQ4GbFKqXrLkjinsFVQ=
Received: from mail-oo1-f71.google.com (mail-oo1-f71.google.com
 [209.85.161.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-374-eS89PNUTMViEM1WdRpW5-g-1; Fri, 23 Sep 2022 01:17:12 -0400
X-MC-Unique: eS89PNUTMViEM1WdRpW5-g-1
Received: by mail-oo1-f71.google.com with SMTP id
 x22-20020a4a3956000000b004748ff8c4b4so4857584oog.13
 for <virtualization@lists.linux-foundation.org>;
 Thu, 22 Sep 2022 22:17:12 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date;
 bh=Tromwnn4H5CG/xgspUfwLWCH6VqqZXFFZnt+Lhbj+LE=;
 b=tzIIeR9Whdo/4zD2UMv3vX/4JA/deGjzTFIhFduCppaY/d2CRrykaqFFeOflPupTEL
 GzNXZ0mxa0pJLgEqR8Lvec92vQDWHbSqFN9X0vHWn2kIauaONZxRNu3AnxoXRC0fI1E1
 JcwP4lKmuOfkExfortDF7+YpWtBvJzUXDNh7DOjzYKwsKKnOFYDPtT58TvjgGp9SOZ7u
 QI0jDnVQx6GP4r/3KmjB/kwErOjX6n5kTM7rF97zm7Zjd22k5gcZEkSm9xRr+56nTCMk
 vcrTVZYF9tdLKx8UOTlfpdLecDLCHq6ymXxQjEiiZ3MCh8qGjzzNuVRjx+5OBplO+7c/
 rnWA==
X-Gm-Message-State: ACrzQf2anhVXciP3+1F2KINV6NPOZdBjNSexNyzuTPw/GC7V7rXQAai/
 pLA81XlZb5cB+nAvEGcfkQTU0dxXVAn+YBQ0ckFARCmAu6xzzU9MmpJZ4MYuULhPyls2/IOQWkt
 fGfisQMySdMjqLAHGKJnHyJyGIrC6MN2mJmoavVFOj4WPQiT8V6erGDrFOQ==
X-Received: by 2002:a05:6830:1550:b0:659:68f7:492b with SMTP id
 l16-20020a056830155000b0065968f7492bmr3225690otp.237.1663910232040; 
 Thu, 22 Sep 2022 22:17:12 -0700 (PDT)
X-Google-Smtp-Source: AMsMyM7rqmR7CDCxNdCVWxCcSmAujgIWKX4iC9I+MjL+LgKULI2fq5aXkfUc6KOXpHKtFo4IUWWphtIx2JeUxMq/Sg8=
X-Received: by 2002:a05:6830:1550:b0:659:68f7:492b with SMTP id
 l16-20020a056830155000b0065968f7492bmr3225685otp.237.1663910231806; Thu, 22
 Sep 2022 22:17:11 -0700 (PDT)
MIME-Version: 1.0
References: <20220923035228.2145-1-angus.chen@jaguarmicro.com>
 <CACGkMEvuJTiPZa9XZwrv-Cbj-E1ZW+eFD8AWrz0Ww_pqpgECiQ@mail.gmail.com>
 <c33e4352-2b6a-1af4-3f7e-9bd8f3a2213d@intel.com>
 <CACGkMEv-z+8_9AqpfienCHT2iFDPeBhUApCO=+j2o7C=u4RF6A@mail.gmail.com>
 <13aa1249-3675-1092-74b6-8fbbc48d98d0@intel.com>
In-Reply-To: <13aa1249-3675-1092-74b6-8fbbc48d98d0@intel.com>
From: Jason Wang <jasowang@redhat.com>
Date: Fri, 23 Sep 2022 13:17:00 +0800
Message-ID: <CACGkMEvw-rR41O_HUwYYq3woYmUx-J3FFfPvy3NfLeb1YvPsbg@mail.gmail.com>
Subject: Re: [PATCH v1] vdpa/ifcvf: avoid waste ioremap area of vdpa hot
 migration
To: "Zhu, Lingshan" <lingshan.zhu@intel.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Cc: mst <mst@redhat.com>,
 virtualization <virtualization@lists.linux-foundation.org>,
 Angus Chen <angus.chen@jaguarmicro.com>
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

T24gRnJpLCBTZXAgMjMsIDIwMjIgYXQgMTI6MjIgUE0gWmh1LCBMaW5nc2hhbiA8bGluZ3NoYW4u
emh1QGludGVsLmNvbT4gd3JvdGU6Cj4KPgo+Cj4gT24gOS8yMy8yMDIyIDEyOjE4IFBNLCBKYXNv
biBXYW5nIHdyb3RlOgo+ID4gT24gRnJpLCBTZXAgMjMsIDIwMjIgYXQgMTI6MTUgUE0gWmh1LCBM
aW5nc2hhbiA8bGluZ3NoYW4uemh1QGludGVsLmNvbT4gd3JvdGU6Cj4gPj4KPiA+Pgo+ID4+IE9u
IDkvMjMvMjAyMiAxMjowOSBQTSwgSmFzb24gV2FuZyB3cm90ZToKPiA+Pj4gT24gRnJpLCBTZXAg
MjMsIDIwMjIgYXQgMTE6NTMgQU0gQW5ndXMgQ2hlbiA8YW5ndXMuY2hlbkBqYWd1YXJtaWNyby5j
b20+IHdyb3RlOgo+ID4+Pj4gVGhlIGFycmF5IGNhcGFjaXR5IHNob3VsZCBiZSBxdWV1ZXBhaXIs
Cj4gPj4+IElmIHRoaXMgaXMgdHJ1ZSwgd2UgbmVlZCBhIGJldHRlciBuYW1lIGZvciB0aGUgaWZj
dmZfdnJpbmdfbG1fY2ZnIHN0cnVjdHVyZS4KPiA+PiBOb3QgdHJ1ZSBBRkFJSy4gQW5kIHdlIGFy
ZSByZS1kZXNpZ25pbmcgdGhpcyBjYXAuCj4gPj4KPiA+PiBUaGFua3MKPiA+PiBaaHUgTGluZ3No
YW4KPiA+IE9rLCBidXQgSSB0aGluayB3ZSBzdGlsbCBuZWVkIHRvIGtlZXAgdGhpcyBmb3IgYmFj
a3dhcmQgY29tcGF0aWJpbGl0eQo+ID4gYW5kIG5lZWQgdG8gZGlmZmVyIHRoZSBnZW5lcmF0aW9u
cyB2aWEgc29tZSBJbnRlbCBzcGVjaWZpYyByZWdpc3RlcnMuCj4gVGhpcyBjYXAgbmV2ZXIgd29y
ayBhcyBleHBlY3RlZCwgYWN0dWFsbHkgbm90IHdvcmtpbmcgc28gZmFy77yMeW91IHNlZSB3ZQo+
IGp1c3QgaW5pdGlhbGl6ZSB0aGUgY2FwLCBidXQgbmV2ZXIgdXNlIGl0LgoKVGhlbiBJJ2Qgc3Vn
Z2VzdCByZW1vdmluZyB0aG9zZSBjb2RlcyB0byByZWR1Y2UgY29uZnVzaW9uIGluIHRoZSBmdXR1
cmUuCgpUaGFua3MKCj4gU28gd2UgYXJlIHJlLWRlc2lnbmluZyB0aGlzIGFuZCBsZXQgaXQgb25s
eSB3b3JrIGZvciBuZXcgSFcuCj4KPiBUaGFua3MKPiA+Cj4gPiBUaGFua3MKPiA+Cj4gPj4+IFRo
YW5rcwo+ID4+Pgo+ID4+Pj4gYW5kIHRoZSBxdWV1ZXBhaXJzIHNob3VsZAo+ID4+Pj4gYmUgaGFs
ZiBvZiBJRkNWRl9NQVhfUVVFVUVTIHdpdGhvdXQgY29udHJvbCBxdWV1ZSwKPiA+Pj4+IG9yIHNo
b3VsZCBiZSAoSUZDVkZfTUFYX1FVRVVFUysxKS8yIHdpdGggdGhlIGNvbnRyb2wgcXVldWUuCj4g
Pj4+PiBTbyB0aGUgZGVmaW5pdGlvbiBvZiBpZmN2Zl9sbV9jZmcgd2FzdGUgc29tZSBtZW1vcnks
Cj4gPj4+PiBhbmQgaXQgd2lsbCB3YXN0ZSBzb21lIGlvcmVtYXAgYXJlYSBhbHNvLgo+ID4+Pj4K
PiA+Pj4+IEZpeGVzOiAyZGRhZTc3M2M5M2IgKCJ2RFBBL2lmY3ZmOiBkZXRlY3QgYW5kIHVzZSB0
aGUgb25ib2FyZCBudW1iZXIgb2YgcXVldWVzIGRpcmVjdGx5IikKPiA+Pj4+IFNpZ25lZC1vZmYt
Ynk6IEFuZ3VzIENoZW4gPGFuZ3VzLmNoZW5AamFndWFybWljcm8uY29tPgo+ID4+Pj4gLS0tCj4g
Pj4+PiAgICBkcml2ZXJzL3ZkcGEvaWZjdmYvaWZjdmZfYmFzZS5oIHwgMiArLQo+ID4+Pj4gICAg
MSBmaWxlIGNoYW5nZWQsIDEgaW5zZXJ0aW9uKCspLCAxIGRlbGV0aW9uKC0pCj4gPj4+Pgo+ID4+
Pj4gZGlmZiAtLWdpdCBhL2RyaXZlcnMvdmRwYS9pZmN2Zi9pZmN2Zl9iYXNlLmggYi9kcml2ZXJz
L3ZkcGEvaWZjdmYvaWZjdmZfYmFzZS5oCj4gPj4+PiBpbmRleCBmNTU2M2Y2NjVjYzYuLjU2M2Mw
NGY5YjdhYyAxMDA2NDQKPiA+Pj4+IC0tLSBhL2RyaXZlcnMvdmRwYS9pZmN2Zi9pZmN2Zl9iYXNl
LmgKPiA+Pj4+ICsrKyBiL2RyaXZlcnMvdmRwYS9pZmN2Zi9pZmN2Zl9iYXNlLmgKPiA+Pj4+IEBA
IC0xMDQsNyArMTA0LDcgQEAgc3RydWN0IGlmY3ZmX3ZyaW5nX2xtX2NmZyB7Cj4gPj4+Pgo+ID4+
Pj4gICAgc3RydWN0IGlmY3ZmX2xtX2NmZyB7Cj4gPj4+PiAgICAgICAgICAgdTggcmVzZXJ2ZWRb
SUZDVkZfTE1fUklOR19TVEFURV9PRkZTRVRdOwo+ID4+Pj4gLSAgICAgICBzdHJ1Y3QgaWZjdmZf
dnJpbmdfbG1fY2ZnIHZyaW5nX2xtX2NmZ1tJRkNWRl9NQVhfUVVFVUVTXTsKPiA+Pj4+ICsgICAg
ICAgc3RydWN0IGlmY3ZmX3ZyaW5nX2xtX2NmZyB2cmluZ19sbV9jZmdbKElGQ1ZGX01BWF9RVUVV
RVMrMSkvMl07Cj4gPj4+PiAgICB9Owo+ID4+Pj4KPiA+Pj4+ICAgIHN0cnVjdCBpZmN2Zl92ZHBh
X21nbXRfZGV2IHsKPiA+Pj4+IC0tCj4gPj4+PiAyLjE3LjEKPiA+Pj4+Cj4KCl9fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fClZpcnR1YWxpemF0aW9uIG1haWxp
bmcgbGlzdApWaXJ0dWFsaXphdGlvbkBsaXN0cy5saW51eC1mb3VuZGF0aW9uLm9yZwpodHRwczov
L2xpc3RzLmxpbnV4Zm91bmRhdGlvbi5vcmcvbWFpbG1hbi9saXN0aW5mby92aXJ0dWFsaXphdGlv
bg==
