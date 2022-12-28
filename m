Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D6781C4332F
	for <virtualization@archiver.kernel.org>; Wed, 28 Dec 2022 07:20:32 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 6FD5A81406;
	Wed, 28 Dec 2022 07:20:32 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 6FD5A81406
Authentication-Results: smtp1.osuosl.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=isPvgBnu
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
	by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id cVU7E2lrhmaO; Wed, 28 Dec 2022 07:20:31 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp1.osuosl.org (Postfix) with ESMTPS id CADF081407;
	Wed, 28 Dec 2022 07:20:30 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org CADF081407
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id A1974C0035;
	Wed, 28 Dec 2022 07:20:30 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [IPv6:2605:bc80:3010::137])
 by lists.linuxfoundation.org (Postfix) with ESMTP id A67D3C002D
 for <virtualization@lists.linux-foundation.org>;
 Wed, 28 Dec 2022 07:20:29 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id 795414091B
 for <virtualization@lists.linux-foundation.org>;
 Wed, 28 Dec 2022 07:20:29 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org 795414091B
Authentication-Results: smtp4.osuosl.org;
 dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com
 header.a=rsa-sha256 header.s=mimecast20190719 header.b=isPvgBnu
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id arWNj93Ooa1L
 for <virtualization@lists.linux-foundation.org>;
 Wed, 28 Dec 2022 07:20:28 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org 29A5D4067C
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.133.124])
 by smtp4.osuosl.org (Postfix) with ESMTPS id 29A5D4067C
 for <virtualization@lists.linux-foundation.org>;
 Wed, 28 Dec 2022 07:20:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1672212027;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=7p/vayyP8zWaxjPZEqa7TOM9QZB/OUBM2psrPg6s4TY=;
 b=isPvgBnuBOUkrBro/Un5AHn3knnHFSQpmXL79Hjlm6Qn/kl7ZQ5sEXNp5gOigWXwajVIjE
 2smz1eouKoRcflUL817bexGMqdMcDPLkCcL/XFNR/KUA2zRhkUYR6DKOvfCGl33tIYAiXu
 FJaAdxDJyZAM3KOAXAm4DBrg+cdjHMM=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-296-06_tTHv6MxCJ3ZLZcT8uLw-1; Wed, 28 Dec 2022 02:20:24 -0500
X-MC-Unique: 06_tTHv6MxCJ3ZLZcT8uLw-1
Received: by mail-wm1-f70.google.com with SMTP id
 p34-20020a05600c1da200b003d990064285so1587102wms.8
 for <virtualization@lists.linux-foundation.org>;
 Tue, 27 Dec 2022 23:20:24 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=in-reply-to:content-transfer-encoding:content-disposition
 :mime-version:references:message-id:subject:cc:to:from:date
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=7p/vayyP8zWaxjPZEqa7TOM9QZB/OUBM2psrPg6s4TY=;
 b=NejpXHDE7obfHWaA18NJHSx6vkDI75/Gc5Ryz/mTNrabN/9FaoGBkBf9p6MdG6lJoR
 xDVwC0V5pYhRhUxD15HXpg96dzKKPIE2OTQgmHMG2HKxht4EWnFelFyeN2sSpx5wzGjD
 v1T7i/+8842+ddsb0+LiKKlVwqI0cm9LNxz4raRXfFKbwHiVS/jkye2Msw5kGjattFek
 WpvJtxVX2qnYoNJmwBUdbJVXf1jcMnYcknHoVBjrY9ipCYBjVnxmZN4FowqhnA2yAgdw
 mWbscszWuAuL0qukczui3OrNzFHbA7hagfPt3IgG3RvgiJgL9FHuhGmT+1+TUTwfECuo
 FN1w==
X-Gm-Message-State: AFqh2koK+HHByEbArWM+7C0s4IaNXSIr/gCiduiTE0MtJDuc9y8iFbSB
 Pk0/3dPnaoHwCXcTt17Mxtlxq6sJNcB23pvgD1S3lTwUUfCj1YtAgbFqkwwItU3tYK7YfWYfXC9
 cuAPgjeURXT0U+7VNCo2WNhjp76KPZTet/JQrDcAFPg==
X-Received: by 2002:a7b:cbd4:0:b0:3d3:3d51:7d44 with SMTP id
 n20-20020a7bcbd4000000b003d33d517d44mr17093100wmi.33.1672212023509; 
 Tue, 27 Dec 2022 23:20:23 -0800 (PST)
X-Google-Smtp-Source: AMrXdXtANV2jcLiF8FOUgRwAbdZCJlTx1cmFHZF/EGV/YNCYif1iFoN8Etw6/Ex+BxcMNQN/2wrnfg==
X-Received: by 2002:a7b:cbd4:0:b0:3d3:3d51:7d44 with SMTP id
 n20-20020a7bcbd4000000b003d33d517d44mr17093090wmi.33.1672212023191; 
 Tue, 27 Dec 2022 23:20:23 -0800 (PST)
Received: from redhat.com ([2.52.151.85]) by smtp.gmail.com with ESMTPSA id
 k31-20020a05600c1c9f00b003d22528decesm26573211wms.43.2022.12.27.23.20.21
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 27 Dec 2022 23:20:22 -0800 (PST)
Date: Wed, 28 Dec 2022 02:20:19 -0500
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Shunsuke Mie <mie@igel.co.jp>
Subject: Re: [RFC PATCH 4/9] vringh: unify the APIs for all accessors
Message-ID: <20221228021354-mutt-send-email-mst@kernel.org>
References: <20221227022528.609839-1-mie@igel.co.jp>
 <20221227022528.609839-5-mie@igel.co.jp>
 <20221227020007-mutt-send-email-mst@kernel.org>
 <CANXvt5pRy-i7=_ikNkZPp2HcRmWZYNJYpjO_ieBJJVc90nds+A@mail.gmail.com>
 <CANXvt5qUUOqB1CVgAk5KyL9sV+NsnJSKhatvdV12jH5=kBjjJw@mail.gmail.com>
 <20221227075332-mutt-send-email-mst@kernel.org>
 <CANXvt5qTbGi7p5Y7eVSjyHJ7MLjiMgGKyAM-LEkJZXvhtSh7vw@mail.gmail.com>
MIME-Version: 1.0
In-Reply-To: <CANXvt5qTbGi7p5Y7eVSjyHJ7MLjiMgGKyAM-LEkJZXvhtSh7vw@mail.gmail.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Disposition: inline
Cc: kvm@vger.kernel.org, netdev@vger.kernel.org,
 Rusty Russell <rusty@rustcorp.com.au>, linux-kernel@vger.kernel.org,
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
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Errors-To: virtualization-bounces@lists.linux-foundation.org
Sender: "Virtualization" <virtualization-bounces@lists.linux-foundation.org>

T24gV2VkLCBEZWMgMjgsIDIwMjIgYXQgMTE6MjQ6MTBBTSArMDkwMCwgU2h1bnN1a2UgTWllIHdy
b3RlOgo+IDIwMjLlubQxMuaciDI35pelKOeBqykgMjM6MzcgTWljaGFlbCBTLiBUc2lya2luIDxt
c3RAcmVkaGF0LmNvbT46Cj4gPgo+ID4gT24gVHVlLCBEZWMgMjcsIDIwMjIgYXQgMDc6MjI6MzZQ
TSArMDkwMCwgU2h1bnN1a2UgTWllIHdyb3RlOgo+ID4gPiAyMDIy5bm0MTLmnIgyN+aXpSjngasp
IDE2OjQ5IFNodW5zdWtlIE1pZSA8bWllQGlnZWwuY28uanA+Ogo+ID4gPiA+Cj4gPiA+ID4gMjAy
MuW5tDEy5pyIMjfml6Uo54GrKSAxNjowNCBNaWNoYWVsIFMuIFRzaXJraW4gPG1zdEByZWRoYXQu
Y29tPjoKPiA+ID4gPiA+Cj4gPiA+ID4gPiBPbiBUdWUsIERlYyAyNywgMjAyMiBhdCAxMToyNToy
NkFNICswOTAwLCBTaHVuc3VrZSBNaWUgd3JvdGU6Cj4gPiA+ID4gPiA+IEVhY2ggdnJpbmdoIG1l
bW9yeSBhY2Nlc3NvcnMgdGhhdCBhcmUgZm9yIHVzZXIsIGtlcm4gYW5kIGlvdGxiIGhhcyBvd24K
PiA+ID4gPiA+ID4gaW50ZXJmYWNlcyB0aGF0IGNhbGxzIGNvbW1vbiBjb2RlLiBCdXQgc29tZSBj
b2RlcyBhcmUgZHVwbGljYXRlZCBhbmQgdGhhdAo+ID4gPiA+ID4gPiBiZWNvbWVzIGxvc3MgZXh0
ZW5kYWJpbGl0eS4KPiA+ID4gPiA+ID4KPiA+ID4gPiA+ID4gSW50cm9kdWNlIGEgc3RydWN0IHZy
aW5naF9vcHMgYW5kIHByb3ZpZGUgYSBjb21tb24gQVBJcyBmb3IgYWxsIGFjY2Vzc29ycy4KPiA+
ID4gPiA+ID4gSXQgY2FuIGJlZSBlYXNpbHkgZXh0ZW5kZWQgdnJpbmdoIGNvZGUgZm9yIG5ldyBt
ZW1vcnkgYWNjZXNzb3IgYW5kCj4gPiA+ID4gPiA+IHNpbXBsaWZpZWQgYSBjYWxsZXIgY29kZS4K
PiA+ID4gPiA+ID4KPiA+ID4gPiA+ID4gU2lnbmVkLW9mZi1ieTogU2h1bnN1a2UgTWllIDxtaWVA
aWdlbC5jby5qcD4KPiA+ID4gPiA+ID4gLS0tCj4gPiA+ID4gPiA+ICBkcml2ZXJzL3Zob3N0L3Zy
aW5naC5jIHwgNjY3ICsrKysrKysrKysrLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tCj4g
PiA+ID4gPiA+ICBpbmNsdWRlL2xpbnV4L3ZyaW5naC5oIHwgMTAwICsrKy0tLQo+ID4gPiA+ID4g
PiAgMiBmaWxlcyBjaGFuZ2VkLCAyMjUgaW5zZXJ0aW9ucygrKSwgNTQyIGRlbGV0aW9ucygtKQo+
ID4gPiA+ID4gPgo+ID4gPiA+ID4gPiBkaWZmIC0tZ2l0IGEvZHJpdmVycy92aG9zdC92cmluZ2gu
YyBiL2RyaXZlcnMvdmhvc3QvdnJpbmdoLmMKPiA+ID4gPiA+ID4gaW5kZXggYWEzY2QyN2QyMzg0
Li5lYmZkMzY0NGExYTMgMTAwNjQ0Cj4gPiA+ID4gPiA+IC0tLSBhL2RyaXZlcnMvdmhvc3QvdnJp
bmdoLmMKPiA+ID4gPiA+ID4gKysrIGIvZHJpdmVycy92aG9zdC92cmluZ2guYwo+ID4gPiA+ID4g
PiBAQCAtMzUsMTUgKzM1LDEyIEBAIHN0YXRpYyBfX3ByaW50ZigxLDIpIF9fY29sZCB2b2lkIHZy
aW5naF9iYWQoY29uc3QgY2hhciAqZm10LCAuLi4pCj4gPiA+ID4gPiA+ICB9Cj4gPiA+ID4gPiA+
Cj4gPiA+ID4gPiA+ICAvKiBSZXR1cm5zIHZyaW5nLT5udW0gaWYgZW1wdHksIC12ZSBvbiBlcnJv
ci4gKi8KPiA+ID4gPiA+ID4gLXN0YXRpYyBpbmxpbmUgaW50IF9fdnJpbmdoX2dldF9oZWFkKGNv
bnN0IHN0cnVjdCB2cmluZ2ggKnZyaCwKPiA+ID4gPiA+ID4gLSAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgIGludCAoKmdldHUxNikoY29uc3Qgc3RydWN0IHZyaW5naCAqdnJoLAo+ID4g
PiA+ID4gPiAtICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICB1
MTYgKnZhbCwgY29uc3QgX192aXJ0aW8xNiAqcCksCj4gPiA+ID4gPiA+IC0gICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICB1MTYgKmxhc3RfYXZhaWxfaWR4KQo+ID4gPiA+ID4gPiArc3Rh
dGljIGlubGluZSBpbnQgX192cmluZ2hfZ2V0X2hlYWQoY29uc3Qgc3RydWN0IHZyaW5naCAqdnJo
LCB1MTYgKmxhc3RfYXZhaWxfaWR4KQo+ID4gPiA+ID4gPiAgewo+ID4gPiA+ID4gPiAgICAgICB1
MTYgYXZhaWxfaWR4LCBpLCBoZWFkOwo+ID4gPiA+ID4gPiAgICAgICBpbnQgZXJyOwo+ID4gPiA+
ID4gPgo+ID4gPiA+ID4gPiAtICAgICBlcnIgPSBnZXR1MTYodnJoLCAmYXZhaWxfaWR4LCAmdnJo
LT52cmluZy5hdmFpbC0+aWR4KTsKPiA+ID4gPiA+ID4gKyAgICAgZXJyID0gdnJoLT5vcHMuZ2V0
dTE2KHZyaCwgJmF2YWlsX2lkeCwgJnZyaC0+dnJpbmcuYXZhaWwtPmlkeCk7Cj4gPiA+ID4gPiA+
ICAgICAgIGlmIChlcnIpIHsKPiA+ID4gPiA+ID4gICAgICAgICAgICAgICB2cmluZ2hfYmFkKCJG
YWlsZWQgdG8gYWNjZXNzIGF2YWlsIGlkeCBhdCAlcCIsCj4gPiA+ID4gPiA+ICAgICAgICAgICAg
ICAgICAgICAgICAgICAmdnJoLT52cmluZy5hdmFpbC0+aWR4KTsKPiA+ID4gPiA+Cj4gPiA+ID4g
PiBJIGxpa2UgdGhhdCB0aGlzIHBhdGNoIHJlbW92ZXMgbW9yZSBsaW5lcyBvZiBjb2RlIHRoYW4g
aXQgYWRkcy4KPiA+ID4gPiA+Cj4gPiA+ID4gPiBIb3dldmVyIG9uZSBvZiB0aGUgZGVzaWduIHBv
aW50cyBvZiB2cmluZ2ggYWJzdHJhY3Rpb25zIGlzIHRoYXQgdGhleSB3ZXJlCj4gPiA+ID4gPiBj
YXJlZnVsbHkgd3JpdHRlbiB0byBiZSB2ZXJ5IGxvdyBvdmVyaGVhZC4KPiA+ID4gPiA+IFRoaXMg
aXMgd2h5IHdlIGFyZSBwYXNzaW5nIGZ1bmN0aW9uIHBvaW50ZXJzIHRvIGlubGluZSBmdW5jdGlv
bnMgLQo+ID4gPiA+ID4gY29tcGlsZXIgY2FuIG9wdGltaXplIHRoYXQgb3V0Lgo+ID4gPiA+ID4K
PiA+ID4gPiA+IEkgdGhpbmsgdGhhdCBpbnRyb2R1Y2luZyBvcHMgaW5kaXJlY3QgZnVuY3Rpb25z
IGNhbGxzIGhlcmUgaXMgZ29pbmcgdG8gYnJlYWsKPiA+ID4gPiA+IHRoZXNlIGFzc3VtcHRpb25z
IGFuZCBodXJ0IHBlcmZvcm1hbmNlLgo+ID4gPiA+ID4gVW5sZXNzIGNvbXBpbGVyIGNhbiBzb21l
aG93IGZpZ3VyZSBpdCBvdXQgYW5kIG9wdGltaXplPwo+ID4gPiA+ID4gSSBkb24ndCBzZWUgaG93
IGl0J3MgcG9zc2libGUgd2l0aCBvcHMgcG9pbnRlciBpbiBtZW1vcnkKPiA+ID4gPiA+IGJ1dCBt
YXliZSBJJ20gd3JvbmcuCj4gPiA+ID4gSSB0aGluayB5b3VyIGNvbmNlcm4gaXMgY29ycmVjdC4g
SSBoYXZlIHRvIHVuZGVyc3RhbmQgdGhlIGNvbXBpbGVyCj4gPiA+ID4gb3B0aW1pemF0aW9uIGFu
ZCByZWRlc2lnbiB0aGlzIGFwcHJvYWNoIElmIGl0IGlzIG5lZWRlZC4KPiA+ID4gPiA+IFdhcyBh
bnkgZWZmb3J0IHRha2VuIHRvIHRlc3QgZWZmZWN0IG9mIHRoZXNlIHBhdGNoZXMgb24gcGVyZm9y
bWFuY2U/Cj4gPiA+ID4gSSBqdXN0IHRlc3RlZCB2cmluZ2hfdGVzdCBhbmQgYWxyZWFkeSBmYWNl
ZCBsaXR0bGUgcGVyZm9ybWFuY2UgcmVkdWN0aW9uLgo+ID4gPiA+IEkgaGF2ZSB0byBpbnZlc3Rp
Z2F0ZSB0aGF0LCBhcyB5b3Ugc2FpZC4KPiA+ID4gSSBhdHRlbXB0ZWQgdG8gdGVzdCB3aXRoIHBl
cmYuIEkgZm91bmQgdGhhdCB0aGUgcGVyZm9ybWFuY2Ugb2YgcGF0Y2hlZCBjb2RlCj4gPiA+IGlz
IGFsbW9zdCB0aGUgc2FtZSBhcyB0aGUgdXBzdHJlYW0gb25lLiBIb3dldmVyLCBJIGhhdmUgdG8g
aW52ZXN0aWdhdGUgd2F5Cj4gPiA+IHRoaXMgcGF0Y2ggbGVhZHMgdG8gdGhpcyByZXN1bHQsIGFs
c28gdGhlIHByb2ZpbGluZyBzaG91bGQgYmUgcnVuIG9uCj4gPiA+IG1vcmUgcG93ZXJmdWwKPiA+
ID4gbWFjaGluZXMgdG9vLgo+ID4gPgo+ID4gPiBlbnZpcm9ubWVudDoKPiA+ID4gJCBncmVwICdt
b2RlbCBuYW1lJyAvcHJvYy9jcHVpbmZvCj4gPiA+IG1vZGVsIG5hbWUgICAgICA6IEludGVsKFIp
IENvcmUoVE0pIGkzLTcwMjBVIENQVSBAIDIuMzBHSHoKPiA+ID4gbW9kZWwgbmFtZSAgICAgIDog
SW50ZWwoUikgQ29yZShUTSkgaTMtNzAyMFUgQ1BVIEAgMi4zMEdIego+ID4gPiBtb2RlbCBuYW1l
ICAgICAgOiBJbnRlbChSKSBDb3JlKFRNKSBpMy03MDIwVSBDUFUgQCAyLjMwR0h6Cj4gPiA+IG1v
ZGVsIG5hbWUgICAgICA6IEludGVsKFIpIENvcmUoVE0pIGkzLTcwMjBVIENQVSBAIDIuMzBHSHoK
PiA+ID4KPiA+ID4gcmVzdWx0czoKPiA+ID4gKiBmb3IgcGF0Y2hlZCBjb2RlCj4gPiA+ICBQZXJm
b3JtYW5jZSBjb3VudGVyIHN0YXRzIGZvciAnbmljZSAtbiAtMjAgLi92cmluZ2hfdGVzdF9wYXRj
aGVkCj4gPiA+IC0tcGFyYWxsZWwgLS1ldmVudGlkeCAtLWZhc3QtdnJpbmdoIC0taW5kaXJlY3Qg
LS12aXJ0aW8tMScgKDIwIHJ1bnMpOgo+ID4gPgo+ID4gPiAgICAgICAgICAgMywwMjguMDUgbXNl
YyB0YXNrLWNsb2NrICAgICAgICAgICAgICAgICMgICAgMC45OTUgQ1BVcwo+ID4gPiB1dGlsaXpl
ZCAgICAgICAgICAgICggKy0gIDAuMTIlICkKPiA+ID4gICAgICAgICAgICAgNzgsMTUwICAgICAg
Y29udGV4dC1zd2l0Y2hlcyAgICAgICAgICAjICAgMjUuNjkxIEsvc2VjCj4gPiA+ICAgICAgICAg
ICAgICAgICggKy0gIDAuMDAlICkKPiA+ID4gICAgICAgICAgICAgICAgICA1ICAgICAgY3B1LW1p
Z3JhdGlvbnMgICAgICAgICAgICAjICAgIDEuNjQ0IC9zZWMKPiA+ID4gICAgICAgICAgICAgICAg
KCArLSAgMy4zMyUgKQo+ID4gPiAgICAgICAgICAgICAgICAxOTAgICAgICBwYWdlLWZhdWx0cyAg
ICAgICAgICAgICAgICMgICA2Mi40NjEgL3NlYwo+ID4gPiAgICAgICAgICAgICAgICAoICstICAw
LjQxJSApCj4gPiA+ICAgICAgNiw5MTksMDI1LDIyMiAgICAgIGN5Y2xlcyAgICAgICAgICAgICAg
ICAgICAgIyAgICAyLjI3NSBHSHoKPiA+ID4gICAgICAgICAgICAgICAgKCArLSAgMC4xMyUgKQo+
ID4gPiAgICAgIDgsOTkwLDIyMCwxNjAgICAgICBpbnN0cnVjdGlvbnMgICAgICAgICAgICAgICMg
ICAgMS4yOSAgaW5zbiBwZXIKPiA+ID4gY3ljbGUgICAgICAgICAgICggKy0gIDAuMDQlICkKPiA+
ID4gICAgICAxLDc4OCwzMjYsNzg2ICAgICAgYnJhbmNoZXMgICAgICAgICAgICAgICAgICAjICA1
ODcuODk5IE0vc2VjCj4gPiA+ICAgICAgICAgICAgICAgICggKy0gIDAuMDUlICkKPiA+ID4gICAg
ICAgICAgNCw1NTcsMzk4ICAgICAgYnJhbmNoLW1pc3NlcyAgICAgICAgICAgICAjICAgIDAuMjUl
IG9mIGFsbAo+ID4gPiBicmFuY2hlcyAgICAgICAgICAoICstICAwLjQzJSApCj4gPiA+Cj4gPiA+
ICAgICAgICAgICAgMy4wNDM1OSArLSAwLjAwMzc4IHNlY29uZHMgdGltZSBlbGFwc2VkICAoICst
ICAwLjEyJSApCj4gPiA+Cj4gPiA+ICogZm9yIHVwc3RyZWFtIGNvZGUKPiA+ID4gIFBlcmZvcm1h
bmNlIGNvdW50ZXIgc3RhdHMgZm9yICduaWNlIC1uIC0yMCAuL3ZyaW5naF90ZXN0X2Jhc2UKPiA+
ID4gLS1wYXJhbGxlbCAtLWV2ZW50aWR4IC0tZmFzdC12cmluZ2ggLS1pbmRpcmVjdCAtLXZpcnRp
by0xJyAoMTAgcnVucyk6Cj4gPiA+Cj4gPiA+ICAgICAgICAgICAzLDA1OC40MSBtc2VjIHRhc2st
Y2xvY2sgICAgICAgICAgICAgICAgIyAgICAwLjk5OSBDUFVzCj4gPiA+IHV0aWxpemVkICAgICAg
ICAgICAgKCArLSAgMC4xNCUgKQo+ID4gPiAgICAgICAgICAgICA3OCwxNDkgICAgICBjb250ZXh0
LXN3aXRjaGVzICAgICAgICAgICMgICAyNS41NDUgSy9zZWMKPiA+ID4gICAgICAgICAgICAgICAg
KCArLSAgMC4wMCUgKQo+ID4gPiAgICAgICAgICAgICAgICAgIDUgICAgICBjcHUtbWlncmF0aW9u
cyAgICAgICAgICAgICMgICAgMS42MzQgL3NlYwo+ID4gPiAgICAgICAgICAgICAgICAoICstICAy
LjY3JSApCj4gPiA+ICAgICAgICAgICAgICAgIDE5NCAgICAgIHBhZ2UtZmF1bHRzICAgICAgICAg
ICAgICAgIyAgIDYzLjQxNCAvc2VjCj4gPiA+ICAgICAgICAgICAgICAgICggKy0gIDAuNDMlICkK
PiA+ID4gICAgICA2LDk4OCw3MTMsOTYzICAgICAgY3ljbGVzICAgICAgICAgICAgICAgICAgICAj
ICAgIDIuMjg0IEdIego+ID4gPiAgICAgICAgICAgICAgICAoICstICAwLjE0JSApCj4gPiA+ICAg
ICAgOCw1MTIsNTMzLDI2OSAgICAgIGluc3RydWN0aW9ucyAgICAgICAgICAgICAgIyAgICAxLjIy
ICBpbnNuIHBlcgo+ID4gPiBjeWNsZSAgICAgICAgICAgKCArLSAgMC4wNCUgKQo+ID4gPiAgICAg
IDEsNjM4LDM3NSwzNzEgICAgICBicmFuY2hlcyAgICAgICAgICAgICAgICAgICMgIDUzNS41NDkg
TS9zZWMKPiA+ID4gICAgICAgICAgICAgICAgKCArLSAgMC4wNSUgKQo+ID4gPiAgICAgICAgICA0
LDQyOCw4NjYgICAgICBicmFuY2gtbWlzc2VzICAgICAgICAgICAgICMgICAgMC4yNyUgb2YgYWxs
Cj4gPiA+IGJyYW5jaGVzICAgICAgICAgICggKy0gMjIuNTclICkKPiA+ID4KPiA+ID4gICAgICAg
ICAgICAzLjA2MDg1ICstIDAuMDA0MjAgc2Vjb25kcyB0aW1lIGVsYXBzZWQgICggKy0gIDAuMTQl
ICkKPiA+Cj4gPgo+ID4gSG93IHlvdSBjb21waWxlZCBpdCBhbHNvIG1hdHRlcnMuIEFUTSB3ZSBk
b24ndCBlbmFibGUgcmV0cG9saW5lcwo+ID4gYW5kIGl0IGRpZCBub3QgbWF0dGVyIHNpbmNlIHdl
IGRpZG4ndCBoYXZlIGluZGlyZWN0IGNhbGxzLAo+ID4gYnV0IHdlIHNob3VsZC4gRGlkbid0IHll
dCBpbnZlc3RpZ2F0ZSBob3cgdG8gZG8gdGhhdCBmb3IgdmlydGlvIHRvb2xzLgo+IEkgdGhpbmsg
dGhlIHJldHBvbGluZXMgY2VydGFpbmx5IGFmZmVjdCBwZXJmb3JtYW5jZS4gVGhhbmsgeW91IGZv
ciBwb2ludGluZwo+IGl0IG91dC4gSSdkIGxpa2UgdG8gc3RhcnQgdGhlIGludmVzdGlnYXRpb24g
dGhhdCBob3cgdG8gYXBwbHkgdGhlCj4gcmV0cG9saW5lcyB0byB0aGUKPiB2aXJ0aW8gdG9vbHMu
Cj4gPiA+ID4gVGhhbmsgeW91IGZvciB5b3VyIGNvbW1lbnRzLgo+ID4gPiA+ID4gVGhhbmtzIQo+
ID4gPiA+ID4KPiA+ID4gPiA+Cj4gPiA+ID4gQmVzdCwKPiA+ID4gPiBTaHVuc3VrZS4KClRoaXMg
aXNuJ3QgYWxsIHRoYXQgdHJpdmlhbCBpZiB3ZSB3YW50IHRoaXMgYXQgcnVudGltZS4KQnV0IGNv
bXBpbGUgdGltZSBpcyBraW5kIG9mIGVhc3kuClNlZSBEb2N1bWVudGF0aW9uL2FkbWluLWd1aWRl
L2h3LXZ1bG4vc3BlY3RyZS5yc3QKCgoKLS0gCk1TVAoKX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX18KVmlydHVhbGl6YXRpb24gbWFpbGluZyBsaXN0ClZpcnR1
YWxpemF0aW9uQGxpc3RzLmxpbnV4LWZvdW5kYXRpb24ub3JnCmh0dHBzOi8vbGlzdHMubGludXhm
b3VuZGF0aW9uLm9yZy9tYWlsbWFuL2xpc3RpbmZvL3ZpcnR1YWxpemF0aW9u
