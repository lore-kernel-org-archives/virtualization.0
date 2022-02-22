Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 24E6DC433F5
	for <virtualization@archiver.kernel.org>; Tue, 22 Feb 2022 13:22:17 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id ACD6A81445;
	Tue, 22 Feb 2022 13:22:16 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
	by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id 4sd95JhEZSDM; Tue, 22 Feb 2022 13:22:15 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp1.osuosl.org (Postfix) with ESMTPS id 3985481406;
	Tue, 22 Feb 2022 13:22:15 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 1A3ACC0021;
	Tue, 22 Feb 2022 13:22:15 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [IPv6:2605:bc80:3010::138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id D7187C0011
 for <virtualization@lists.linux-foundation.org>;
 Tue, 22 Feb 2022 13:22:13 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id C09958140D
 for <virtualization@lists.linux-foundation.org>;
 Tue, 22 Feb 2022 13:22:13 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id l97h63eGnjp8
 for <virtualization@lists.linux-foundation.org>;
 Tue, 22 Feb 2022 13:22:13 +0000 (UTC)
X-Greylist: whitelisted by SQLgrey-1.8.0
Received: from mail-oi1-x22d.google.com (mail-oi1-x22d.google.com
 [IPv6:2607:f8b0:4864:20::22d])
 by smtp1.osuosl.org (Postfix) with ESMTPS id 0D98781406
 for <virtualization@lists.linux-foundation.org>;
 Tue, 22 Feb 2022 13:22:12 +0000 (UTC)
Received: by mail-oi1-x22d.google.com with SMTP id ay7so14390646oib.8
 for <virtualization@lists.linux-foundation.org>;
 Tue, 22 Feb 2022 05:22:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=daynix-com.20210112.gappssmtp.com; s=20210112;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc:content-transfer-encoding;
 bh=FbEG8VNWfAxsexRWaVP+3+Z7bPItdQUVdT+PMVmJerk=;
 b=2DUgPhrNuz1pS7heHL7qiS+n14t06NuqIh9c+513mbJEMnRr0OZ4lyybjX20n8UJEp
 a7Otk6bK+LBdmRFHp84bRyxoTSQcNmQh9Up3pSzs4Dw/BKXmxxBR65GZMecOuGndDUa6
 T1QnzTo9IIOycIaK2usIpIIE77OYOA0b2l9g0INDbWuDDhNBwK33DKdxV6U99cAZ7d1u
 8qaWgQZLxZ22uOAKdKlFq289oeahwbOmPITKaif7LWlbbBhfyO5+V2ZNJK5IZ/k3tyI7
 pex0KZ7fnoG/SNzr+RnxRr/+NjXqk6EA7DJlYfwduD2LGk3hHQ3hGU//k9w/ECUS77CA
 Prnw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc:content-transfer-encoding;
 bh=FbEG8VNWfAxsexRWaVP+3+Z7bPItdQUVdT+PMVmJerk=;
 b=ohhkpfOc49zCa4/PKIvEyQ8EKodnbl/KwQjrQhIV+9tZPblJiSM/vK60igrG5kgfG3
 BxI8wRBFplme3Opy/2Y/2ce+hxq6iSYJEiYn6TA+isNRMplBrJjtcu5aj5tFzEdDfBSZ
 DdQSEZ1ylV8BseviqgfLzuA+/lOuVr/rUU0P7jB7g9VDNVBH7NsLFchIX0mjlk540V2k
 /HBn+Hs2VIkr+vs7whaOQcovKILttYwWG6Z97oy4Fg86DB7ibwVEs2FnR2S18mtiT/H6
 h1MO/A/pDdOOH00DWqiYDIKIatZL4SY7MauBKoW388C/OVguCPavZxhF3WeI+BETLqvZ
 Fd2g==
X-Gm-Message-State: AOAM531XkSowqDb8VWnuRvbmokputjild85fTdgQ3Zvk/Zesb1pvEvCg
 CFe+E+43UPbbDvK3eqsH5TPhYtbEkFjJGt1eV93Pvg==
X-Google-Smtp-Source: ABdhPJyOrHlBwgGx5qZTXhnCehHekXCBaR6rENqCa6E8lAtJ/4gDv9e9nBODLwxy3eXzpO5VbNRSxYON80doqy+Yi68=
X-Received: by 2002:a05:6808:2128:b0:2d3:3ce1:6e12 with SMTP id
 r40-20020a056808212800b002d33ce16e12mr1891947oiw.279.1645536132034; Tue, 22
 Feb 2022 05:22:12 -0800 (PST)
MIME-Version: 1.0
References: <20220125084702.3636253-1-andrew@daynix.com>
 <20220125084702.3636253-3-andrew@daynix.com>
 <5ac96035-2448-2a25-5bc9-677a7eb0a271@redhat.com>
In-Reply-To: <5ac96035-2448-2a25-5bc9-677a7eb0a271@redhat.com>
From: Andrew Melnichenko <andrew@daynix.com>
Date: Tue, 22 Feb 2022 15:22:00 +0200
Message-ID: <CABcq3pH-md7oTLZYTGvnhi0uhYcZifdWn_D2bAZVafT5d+YZcg@mail.gmail.com>
Subject: Re: [RFC PATCH 2/5] driver/net/tun: Added features for USO.
To: Jason Wang <jasowang@redhat.com>
Cc: "Michael S. Tsirkin" <mst@redhat.com>,
 Network Development <netdev@vger.kernel.org>,
 LKML <linux-kernel@vger.kernel.org>,
 virtualization <virtualization@lists.linux-foundation.org>,
 Yuri Benditovich <yuri.benditovich@daynix.com>,
 Yan Vugenfirer <yan@daynix.com>, Jakub Kicinski <kuba@kernel.org>,
 "David S. Miller" <davem@davemloft.net>
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

T24gV2VkLCBGZWIgOSwgMjAyMiBhdCA2OjM5IEFNIEphc29uIFdhbmcgPGphc293YW5nQHJlZGhh
dC5jb20+IHdyb3RlOgo+Cj4KPiDlnKggMjAyMi8xLzI1IOS4i+WNiDQ6NDYsIEFuZHJldyBNZWxu
eWNoZW5rbyDlhpnpgZM6Cj4gPiBBZGRlZCBzdXBwb3J0IGZvciBVU080IGFuZCBVU082LCBhbHNv
IGFkZGVkIGNvZGUgZm9yIG5ldyBpb2N0bCBUVU5HRVRTVVBQT1JURURPRkZMT0FEUy4KPiA+IEZv
ciBub3csIHRvICJlbmFibGUiIFVTTywgaXQncyByZXF1aXJlZCB0byBzZXQgYm90aCBVU080IGFu
ZCBVU082IHNpbXVsdGFuZW91c2x5Lgo+ID4gVVNPIGVuYWJsZXMgTkVUSUZfRl9HU09fVURQX0w0
Lgo+ID4KPiA+IFNpZ25lZC1vZmYtYnk6IEFuZHJldyBNZWxueWNoZW5rbyA8YW5kcmV3QGRheW5p
eC5jb20+Cj4gPiAtLS0KPiA+ICAgZHJpdmVycy9uZXQvdGFwLmMgfCAxOCArKysrKysrKysrKysr
KysrLS0KPiA+ICAgZHJpdmVycy9uZXQvdHVuLmMgfCAxNSArKysrKysrKysrKysrKy0KPiA+ICAg
MiBmaWxlcyBjaGFuZ2VkLCAzMCBpbnNlcnRpb25zKCspLCAzIGRlbGV0aW9ucygtKQo+ID4KPiA+
IGRpZmYgLS1naXQgYS9kcml2ZXJzL25ldC90YXAuYyBiL2RyaXZlcnMvbmV0L3RhcC5jCj4gPiBp
bmRleCA4ZTNhMjhiYTZiMjguLjgyZDc0MmJhNzhiMSAxMDA2NDQKPiA+IC0tLSBhL2RyaXZlcnMv
bmV0L3RhcC5jCj4gPiArKysgYi9kcml2ZXJzL25ldC90YXAuYwo+ID4gQEAgLTk0MCw2ICs5NDAs
MTAgQEAgc3RhdGljIGludCBzZXRfb2ZmbG9hZChzdHJ1Y3QgdGFwX3F1ZXVlICpxLCB1bnNpZ25l
ZCBsb25nIGFyZykKPiA+ICAgICAgICAgICAgICAgICAgICAgICBpZiAoYXJnICYgVFVOX0ZfVFNP
NikKPiA+ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgIGZlYXR1cmVfbWFzayB8PSBORVRJ
Rl9GX1RTTzY7Cj4gPiAgICAgICAgICAgICAgIH0KPiA+ICsKPiA+ICsgICAgICAgICAgICAgLyog
VE9ETzogZm9yIG5vdyBVU080IGFuZCBVU082IHNob3VsZCB3b3JrIHNpbXVsdGFuZW91c2x5ICov
Cj4gPiArICAgICAgICAgICAgIGlmIChhcmcgJiAoVFVOX0ZfVVNPNCB8IFRVTl9GX1VTTzYpID09
IChUVU5fRl9VU080IHwgVFVOX0ZfVVNPNikpCj4gPiArICAgICAgICAgICAgICAgICAgICAgZmVh
dHVyZXMgfD0gTkVUSUZfRl9HU09fVURQX0w0Owo+Cj4KPiBJZiBrZXJuZWwgZG9lc24ndCB3YW50
IHRvIHNwbGl0IHRoZSBHU09fVURQIGZlYXR1cmVzLCBJIHdvbmRlciBob3cgbXVjaAo+IHZhbHVl
IHRvIGtlZXAgc2VwYXJhdGVkIGZlYXR1cmVzIGZvciBUVU4gYW5kIHZpcnRpby4KPgo+IFRoYW5r
cwo+CgpJdCdzIGltcG9ydGFudCBmb3IgV2luZG93cyBndWVzdHMgdGhhdCBtYXkgcmVxdWVzdCBV
U08gcmVjZWl2ZSBvbmx5CmZvciBJUHY0IG9yIElQdjYuCk9yIHRoZXJlIGlzIHBvc3NpYmxlIHRv
IGltcGxlbWVudCBvbmUgZmVhdHVyZSBhbmQgY2hhbmdlIGl0cwoibWVhbmluZ3MiIHdoZW4gInNw
bGl0IiBoYXBwZW5zLgpJIHRoaW5rIGl0J3MgYSBnb29kIGlkZWEgdG8gaW1wbGVtZW50IGFuIGlu
dGVyZmFjZSBmb3IgaVVTTzQvVVNPNiBhbmQKZG8gaXQgcmlnaHQgYXdheS4KCj4KPiA+ICAgICAg
IH0KPiA+Cj4gPiAgICAgICAvKiB0dW4vdGFwIGRyaXZlciBpbnZlcnRzIHRoZSB1c2FnZSBmb3Ig
VFNPIG9mZmxvYWRzLCB3aGVyZQo+ID4gQEAgLTk1MCw3ICs5NTQsOCBAQCBzdGF0aWMgaW50IHNl
dF9vZmZsb2FkKHN0cnVjdCB0YXBfcXVldWUgKnEsIHVuc2lnbmVkIGxvbmcgYXJnKQo+ID4gICAg
ICAgICogV2hlbiB1c2VyIHNwYWNlIHR1cm5zIG9mZiBUU08sIHdlIHR1cm4gb2ZmIEdTTy9MUk8g
c28gdGhhdAo+ID4gICAgICAgICogdXNlci1zcGFjZSB3aWxsIG5vdCByZWNlaXZlIFRTTyBmcmFt
ZXMuCj4gPiAgICAgICAgKi8KPiA+IC0gICAgIGlmIChmZWF0dXJlX21hc2sgJiAoTkVUSUZfRl9U
U08gfCBORVRJRl9GX1RTTzYpKQo+ID4gKyAgICAgaWYgKGZlYXR1cmVfbWFzayAmIChORVRJRl9G
X1RTTyB8IE5FVElGX0ZfVFNPNikgfHwKPiA+ICsgICAgICAgICBmZWF0dXJlX21hc2sgJiAoVFVO
X0ZfVVNPNCB8IFRVTl9GX1VTTzYpID09IChUVU5fRl9VU080IHwgVFVOX0ZfVVNPNikpCj4gPiAg
ICAgICAgICAgICAgIGZlYXR1cmVzIHw9IFJYX09GRkxPQURTOwo+ID4gICAgICAgZWxzZQo+ID4g
ICAgICAgICAgICAgICBmZWF0dXJlcyAmPSB+UlhfT0ZGTE9BRFM7Cj4gPiBAQCAtOTc5LDYgKzk4
NCw3IEBAIHN0YXRpYyBsb25nIHRhcF9pb2N0bChzdHJ1Y3QgZmlsZSAqZmlsZSwgdW5zaWduZWQg
aW50IGNtZCwKPiA+ICAgICAgIHVuc2lnbmVkIHNob3J0IHU7Cj4gPiAgICAgICBpbnQgX191c2Vy
ICpzcCA9IGFyZ3A7Cj4gPiAgICAgICBzdHJ1Y3Qgc29ja2FkZHIgc2E7Cj4gPiArICAgICB1bnNp
Z25lZCBpbnQgc3VwcG9ydGVkX29mZmxvYWRzOwo+ID4gICAgICAgaW50IHM7Cj4gPiAgICAgICBp
bnQgcmV0Owo+ID4KPiA+IEBAIC0xMDc0LDcgKzEwODAsOCBAQCBzdGF0aWMgbG9uZyB0YXBfaW9j
dGwoc3RydWN0IGZpbGUgKmZpbGUsIHVuc2lnbmVkIGludCBjbWQsCj4gPiAgICAgICBjYXNlIFRV
TlNFVE9GRkxPQUQ6Cj4gPiAgICAgICAgICAgICAgIC8qIGxldCB0aGUgdXNlciBjaGVjayBmb3Ig
ZnV0dXJlIGZsYWdzICovCj4gPiAgICAgICAgICAgICAgIGlmIChhcmcgJiB+KFRVTl9GX0NTVU0g
fCBUVU5fRl9UU080IHwgVFVOX0ZfVFNPNiB8Cj4gPiAtICAgICAgICAgICAgICAgICAgICAgICAg
IFRVTl9GX1RTT19FQ04gfCBUVU5fRl9VRk8pKQo+ID4gKyAgICAgICAgICAgICAgICAgICAgICAg
ICBUVU5fRl9UU09fRUNOIHwgVFVOX0ZfVUZPIHwKPiA+ICsgICAgICAgICAgICAgICAgICAgICAg
ICAgVFVOX0ZfVVNPNCB8IFRVTl9GX1VTTzYpKQo+ID4gICAgICAgICAgICAgICAgICAgICAgIHJl
dHVybiAtRUlOVkFMOwo+ID4KPiA+ICAgICAgICAgICAgICAgcnRubF9sb2NrKCk7Cj4gPiBAQCAt
MTA4Miw2ICsxMDg5LDEzIEBAIHN0YXRpYyBsb25nIHRhcF9pb2N0bChzdHJ1Y3QgZmlsZSAqZmls
ZSwgdW5zaWduZWQgaW50IGNtZCwKPiA+ICAgICAgICAgICAgICAgcnRubF91bmxvY2soKTsKPiA+
ICAgICAgICAgICAgICAgcmV0dXJuIHJldDsKPiA+Cj4gPiArICAgICBjYXNlIFRVTkdFVFNVUFBP
UlRFRE9GRkxPQURTOgo+ID4gKyAgICAgICAgICAgICBzdXBwb3J0ZWRfb2ZmbG9hZHMgPSBUVU5f
Rl9DU1VNIHwgVFVOX0ZfVFNPNCB8IFRVTl9GX1RTTzYgfAo+ID4gKyAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgIFRVTl9GX1RTT19FQ04gfCBUVU5fRl9VRk8gfCBU
VU5fRl9VU080IHwgVFVOX0ZfVVNPNjsKPiA+ICsgICAgICAgICAgICAgaWYgKGNvcHlfdG9fdXNl
cigmYXJnLCAmc3VwcG9ydGVkX29mZmxvYWRzLCBzaXplb2Yoc3VwcG9ydGVkX29mZmxvYWRzKSkp
Cj4gPiArICAgICAgICAgICAgICAgICAgICAgcmV0dXJuIC1FRkFVTFQ7Cj4gPiArICAgICAgICAg
ICAgIHJldHVybiAwOwo+ID4gKwo+ID4gICAgICAgY2FzZSBTSU9DR0lGSFdBRERSOgo+ID4gICAg
ICAgICAgICAgICBydG5sX2xvY2soKTsKPiA+ICAgICAgICAgICAgICAgdGFwID0gdGFwX2dldF90
YXBfZGV2KHEpOwo+ID4gZGlmZiAtLWdpdCBhL2RyaXZlcnMvbmV0L3R1bi5jIGIvZHJpdmVycy9u
ZXQvdHVuLmMKPiA+IGluZGV4IGZlZDg1NDQ3NzAxYS4uNGYyMTA1ZDFlNmYxIDEwMDY0NAo+ID4g
LS0tIGEvZHJpdmVycy9uZXQvdHVuLmMKPiA+ICsrKyBiL2RyaXZlcnMvbmV0L3R1bi5jCj4gPiBA
QCAtMTg1LDcgKzE4NSw3IEBAIHN0cnVjdCB0dW5fc3RydWN0IHsKPiA+ICAgICAgIHN0cnVjdCBu
ZXRfZGV2aWNlICAgICAgICpkZXY7Cj4gPiAgICAgICBuZXRkZXZfZmVhdHVyZXNfdCAgICAgICBz
ZXRfZmVhdHVyZXM7Cj4gPiAgICNkZWZpbmUgVFVOX1VTRVJfRkVBVFVSRVMgKE5FVElGX0ZfSFdf
Q1NVTXxORVRJRl9GX1RTT19FQ058TkVUSUZfRl9UU098IFwKPiA+IC0gICAgICAgICAgICAgICAg
ICAgICAgIE5FVElGX0ZfVFNPNikKPiA+ICsgICAgICAgICAgICAgICAgICAgICAgIE5FVElGX0Zf
VFNPNiB8IE5FVElGX0ZfR1NPX1VEUF9MNCkKPiA+Cj4gPiAgICAgICBpbnQgICAgICAgICAgICAg
ICAgICAgICBhbGlnbjsKPiA+ICAgICAgIGludCAgICAgICAgICAgICAgICAgICAgIHZuZXRfaGRy
X3N6Owo+ID4gQEAgLTI4MjEsNiArMjgyMSwxMiBAQCBzdGF0aWMgaW50IHNldF9vZmZsb2FkKHN0
cnVjdCB0dW5fc3RydWN0ICp0dW4sIHVuc2lnbmVkIGxvbmcgYXJnKQo+ID4gICAgICAgICAgICAg
ICB9Cj4gPgo+ID4gICAgICAgICAgICAgICBhcmcgJj0gflRVTl9GX1VGTzsKPiA+ICsKPiA+ICsg
ICAgICAgICAgICAgLyogVE9ETzogZm9yIG5vdyBVU080IGFuZCBVU082IHNob3VsZCB3b3JrIHNp
bXVsdGFuZW91c2x5ICovCj4gPiArICAgICAgICAgICAgIGlmIChhcmcgJiBUVU5fRl9VU080ICYm
IGFyZyAmIFRVTl9GX1VTTzYpIHsKPiA+ICsgICAgICAgICAgICAgICAgICAgICBmZWF0dXJlcyB8
PSBORVRJRl9GX0dTT19VRFBfTDQ7Cj4gPiArICAgICAgICAgICAgICAgICAgICAgYXJnICY9IH4o
VFVOX0ZfVVNPNCB8IFRVTl9GX1VTTzYpOwo+ID4gKyAgICAgICAgICAgICB9Cj4gPiAgICAgICB9
Cj4gPgo+ID4gICAgICAgLyogVGhpcyBnaXZlcyB0aGUgdXNlciBhIHdheSB0byB0ZXN0IGZvciBu
ZXcgZmVhdHVyZXMgaW4gZnV0dXJlIGJ5Cj4gPiBAQCAtMjk5MSw2ICsyOTk3LDcgQEAgc3RhdGlj
IGxvbmcgX190dW5fY2hyX2lvY3RsKHN0cnVjdCBmaWxlICpmaWxlLCB1bnNpZ25lZCBpbnQgY21k
LAo+ID4gICAgICAgaW50IHNuZGJ1ZjsKPiA+ICAgICAgIGludCB2bmV0X2hkcl9zejsKPiA+ICAg
ICAgIGludCBsZTsKPiA+ICsgICAgIHVuc2lnbmVkIGludCBzdXBwb3J0ZWRfb2ZmbG9hZHM7Cj4g
PiAgICAgICBpbnQgcmV0Owo+ID4gICAgICAgYm9vbCBkb19ub3RpZnkgPSBmYWxzZTsKPiA+Cj4g
PiBAQCAtMzE1NCw2ICszMTYxLDEyIEBAIHN0YXRpYyBsb25nIF9fdHVuX2Nocl9pb2N0bChzdHJ1
Y3QgZmlsZSAqZmlsZSwgdW5zaWduZWQgaW50IGNtZCwKPiA+ICAgICAgIGNhc2UgVFVOU0VUT0ZG
TE9BRDoKPiA+ICAgICAgICAgICAgICAgcmV0ID0gc2V0X29mZmxvYWQodHVuLCBhcmcpOwo+ID4g
ICAgICAgICAgICAgICBicmVhazsKPiA+ICsgICAgIGNhc2UgVFVOR0VUU1VQUE9SVEVET0ZGTE9B
RFM6Cj4gPiArICAgICAgICAgICAgIHN1cHBvcnRlZF9vZmZsb2FkcyA9IFRVTl9GX0NTVU0gfCBU
VU5fRl9UU080IHwgVFVOX0ZfVFNPNiB8Cj4gPiArICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICBUVU5fRl9UU09fRUNOIHwgVFVOX0ZfVUZPIHwgVFVOX0ZfVVNPNCB8IFRVTl9GX1VTTzY7Cj4g
PiArICAgICAgICAgICAgIGlmIChjb3B5X3RvX3VzZXIoJmFyZywgJnN1cHBvcnRlZF9vZmZsb2Fk
cywgc2l6ZW9mKHN1cHBvcnRlZF9vZmZsb2FkcykpKQo+ID4gKyAgICAgICAgICAgICAgICAgICAg
IHJldCA9IC1FRkFVTFQ7Cj4gPiArICAgICAgICAgICAgIGJyZWFrOwo+ID4KPiA+ICAgICAgIGNh
c2UgVFVOU0VUVFhGSUxURVI6Cj4gPiAgICAgICAgICAgICAgIC8qIENhbiBiZSBzZXQgb25seSBm
b3IgVEFQcyAqLwo+Cl9fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fClZpcnR1YWxpemF0aW9uIG1haWxpbmcgbGlzdApWaXJ0dWFsaXphdGlvbkBsaXN0cy5saW51
eC1mb3VuZGF0aW9uLm9yZwpodHRwczovL2xpc3RzLmxpbnV4Zm91bmRhdGlvbi5vcmcvbWFpbG1h
bi9saXN0aW5mby92aXJ0dWFsaXphdGlvbg==
