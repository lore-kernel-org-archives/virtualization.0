Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2BDCEC4332F
	for <virtualization@archiver.kernel.org>; Tue, 20 Dec 2022 06:50:46 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id B4462813E3;
	Tue, 20 Dec 2022 06:50:45 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org B4462813E3
Authentication-Results: smtp1.osuosl.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=FP9DX+b2
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
	by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id a0vtFyeqrl7e; Tue, 20 Dec 2022 06:50:44 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp1.osuosl.org (Postfix) with ESMTPS id C2E16813CB;
	Tue, 20 Dec 2022 06:50:43 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org C2E16813CB
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 5E673C0035;
	Tue, 20 Dec 2022 06:50:43 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [IPv6:2605:bc80:3010::133])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 0213CC002D
 for <virtualization@lists.linux-foundation.org>;
 Tue, 20 Dec 2022 06:50:41 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id 8D70A40134
 for <virtualization@lists.linux-foundation.org>;
 Tue, 20 Dec 2022 06:50:41 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org 8D70A40134
Authentication-Results: smtp2.osuosl.org;
 dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com
 header.a=rsa-sha256 header.s=mimecast20190719 header.b=FP9DX+b2
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id e6K4E8LY-mUA
 for <virtualization@lists.linux-foundation.org>;
 Tue, 20 Dec 2022 06:50:40 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org BCC8740133
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.133.124])
 by smtp2.osuosl.org (Postfix) with ESMTPS id BCC8740133
 for <virtualization@lists.linux-foundation.org>;
 Tue, 20 Dec 2022 06:50:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1671519039;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=zwDr1m1CSjW3QmkbeKM/ZutVDebLKvNg+n0oKeti2Eg=;
 b=FP9DX+b2dOmt/grlHUbg2NRQYAdY23M0I5+Qk3bNVWvq9rpOl8mInHz63anXP6CBR9JhPC
 IMMgN6k3K7xS+StbXJLt4Sqi22cKEuuM+G3Ap7zqhjuyDNJ2ET4tqOGhn/DIXKc4khRWap
 +ZcpTOxQh9afyHZjpj/UJBPKuGHmjjU=
Received: from mail-pg1-f197.google.com (mail-pg1-f197.google.com
 [209.85.215.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-130-ekg3wgk2NJWvz7_yuxeLNQ-1; Tue, 20 Dec 2022 01:50:35 -0500
X-MC-Unique: ekg3wgk2NJWvz7_yuxeLNQ-1
Received: by mail-pg1-f197.google.com with SMTP id
 g1-20020a636b01000000b00479222d9875so6788887pgc.12
 for <virtualization@lists.linux-foundation.org>;
 Mon, 19 Dec 2022 22:50:35 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=zwDr1m1CSjW3QmkbeKM/ZutVDebLKvNg+n0oKeti2Eg=;
 b=m6BqJlx731bYQazD92a8KuIiD+TR/IdWVOsHFKMAArnyA8LQg4DepPxLcwPtYn5vcd
 T/LoE1taOl18dYZ93vtavartSgz89vPyiZ0sDix/DNZQOhuMUOU6VTMl/scBsNddw2d2
 QyjnqlqEmPsMWheNaJQRiwUD95hsmoIEISHgXVSg8DgUa/61XRVo5lyHdUXNRSUcEjqy
 rixazSsxmfDhEuzBKiMzQKyKUdifPZtAlJyiVa4a/+dl+TzQPBXbJamWfgbhjVU/AE5B
 dxABprKlmNbrJew47EirPNX3oPNuLf4NkCAF7S2O55zTPXe6s+X2Pl3lF8RQT4DgrPpH
 y2pg==
X-Gm-Message-State: ANoB5pmVCQ2MfTSunUQYcQzHXiSUc5wM7HPDNLSLQGhhXvgVyPeLyN4K
 vebaIoRs0TjF/g2qKJ+E0JwhmxYxYlk/l3E5jktMslFm24E3iYHcTo9QgEPTI2qyBNtsDUdFXOf
 pLgj0sTbP2uwddKR+SKU4g/cRpuwyI98D5B6GJi8ebg==
X-Received: by 2002:a05:6a20:1324:b0:ad:f2bf:bc50 with SMTP id
 g36-20020a056a20132400b000adf2bfbc50mr24198118pzh.13.1671519034423; 
 Mon, 19 Dec 2022 22:50:34 -0800 (PST)
X-Google-Smtp-Source: AA0mqf4lksCrEkh9cfPPZGSqkkcNl1O26INCsTnVEy3yl+IJ3fMl0eg6JDIrUDrpoRUzQTGDttYOcQ==
X-Received: by 2002:a05:6a20:1324:b0:ad:f2bf:bc50 with SMTP id
 g36-20020a056a20132400b000adf2bfbc50mr24198103pzh.13.1671519034114; 
 Mon, 19 Dec 2022 22:50:34 -0800 (PST)
Received: from [10.72.12.177] ([43.228.180.230])
 by smtp.gmail.com with ESMTPSA id
 b4-20020a62cf04000000b005764c8f8f15sm7821518pfg.73.2022.12.19.22.50.31
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 19 Dec 2022 22:50:33 -0800 (PST)
Message-ID: <96d85666-106b-a43e-6115-b9959b4e3e66@redhat.com>
Date: Tue, 20 Dec 2022 14:50:26 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.6.0
Subject: Re: [PATCH 3/3 v6] virtio: vdpa: new SolidNET DPU driver.
To: Alvaro Karsz <alvaro.karsz@solid-run.com>,
 virtualization@lists.linux-foundation.org, linux-pci@vger.kernel.org
References: <20221219083511.73205-1-alvaro.karsz@solid-run.com>
 <20221219083511.73205-4-alvaro.karsz@solid-run.com>
From: Jason Wang <jasowang@redhat.com>
In-Reply-To: <20221219083511.73205-4-alvaro.karsz@solid-run.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Language: en-US
Cc: bhelgaas@google.com, Jean Delvare <jdelvare@suse.com>,
 Guenter Roeck <linux@roeck-us.net>, "Michael S. Tsirkin" <mst@redhat.com>
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
Content-Transfer-Encoding: base64
Content-Type: text/plain; charset="utf-8"; Format="flowed"
Errors-To: virtualization-bounces@lists.linux-foundation.org
Sender: "Virtualization" <virtualization-bounces@lists.linux-foundation.org>

CuWcqCAyMDIyLzEyLzE5IDE2OjM1LCBBbHZhcm8gS2Fyc3og5YaZ6YGTOgo+IFRoaXMgY29tbWl0
IGluY2x1ZGVzOgo+ICAgMSkgVGhlIGRyaXZlciB0byBtYW5hZ2UgdGhlIGNvbnRyb2xwbGFuZSBv
dmVyIHZEUEEgYnVzLgo+ICAgMikgQSBIVyBtb25pdG9yIGRldmljZSB0byByZWFkIGhlYWx0aCB2
YWx1ZXMgZnJvbSB0aGUgRFBVLgo+Cj4gU2lnbmVkLW9mZi1ieTogQWx2YXJvIEthcnN6IDxhbHZh
cm8ua2Fyc3pAc29saWQtcnVuLmNvbT4KPiAtLQo+IHYyOgo+IAktIEF1dG8gZGV0ZWN0IHRoZSBC
QVIgdXNlZCBmb3IgY29tbXVuaWNhdGlvbi4KPiAJLSBXaGVuIHdhaXRpbmcgZm9yIHRoZSBEUFUg
dG8gd3JpdGUgYSBjb25maWcsIHdhaXQgZm9yIDVzZWNzCj4gCSAgYmVmb3JlIGdpdmluZyB1cCBv
biB0aGUgZGV2aWNlLgo+IAktIFJldHVybiBFT1BOT1RTVVBQIGVycm9yIGNvZGUgaW4gdkRQQSBz
ZXRfdnFfc3RhdGUgY2FsbGJhY2sgaWYKPiAJICB0aGUgdnEgc3RhdGUgaXMgbm90IHRoZSBzYW1l
IGFzIHRoZSBpbml0aWFsIG9uZS4KPiAJLSBJbXBsZW1lbnQgYSB2RFBBIHJlc2V0IGNhbGxiYWNr
Lgo+IAktIFdhaXQgZm9yIGFuIEFDSyB3aGVuIHNlbmRpbmcgYSBtZXNzYWdlIHRvIHRoZSBEUFUu
Cj4gCS0gQWRkIGVuZGlhbm5lc3MgY29tbWVudHMgb24gNjRiaXQgcmVhZC93cml0ZSBmdW5jdGlv
bnMuCj4gCS0gUmVtb3ZlIHRoZSBnZXRfaW92YV9yYW5nZSBhbmQgZnJlZSB2RFBBIGNhbGxiYWNr
cy4KPiAJLSBVc2FnZSBvZiBtYW5hZ2VkIGRldmljZSBmdW5jdGlvbnMgdG8gaW9yZW1hcCBhIHJl
Z2lvbi4KPiAJLSBDYWxsIHBjaV9zZXRfZHJ2ZGF0YSBhbmQgcGNpX3NldF9tYXN0ZXIgYmVmb3Jl
Cj4gCSAgdmRwYV9yZWdpc3Rlcl9kZXZpY2UuCj4gCS0gQ3JlYXRlIERNQSBpc29sYXRpb24gYmV0
d2VlbiB0aGUgdkRQQSBkZXZpY2VzIGJ5IHVzaW5nIHRoZQo+IAkgIGNoaXAgU1ItSU9WIGZlYXR1
cmUuCj4gCSAgRXZlcnkgdkRQQSBkZXZpY2UgZ2V0cyBhIFBDSWUgVkYgd2l0aCBpdHMgb3duIERN
QSBkZXZpY2UuCj4KPiB2MzoKPiAJLSBWYWxpZGF0ZSB2RFBBIGNvbmZpZyBsZW5ndGggd2hpbGUg
cmVjZWl2aW5nIHRoZSBEUFUncyBjb25maWcsCj4gCSAgbm90IHdoaWxlIHRyeWluZyB0byB3cml0
ZSB0aGUgdkRQQSBjb25maWcgdG8gdGhlIERQVS4KPiAJLSBSZXF1ZXN0IElSUXMgd2hlbiB2RFBB
IHN0YXR1cyBpcyBzZXQgdG8KPiAJICBWSVJUSU9fQ09ORklHX1NfRFJJVkVSX09LLgo+IAktIFJl
bW92ZSBzbmV0X3Jlc2V0X2RldigpIGZyb20gdGhlIFBDSSByZW1vdmUgZnVuY3Rpb24gZm9yIGEg
VkYuCj4gdjQ6Cj4gCS0gR2V0IFNvbGlkUnVuIHZlbmRvciBJRCBmcm9tIHBjaV9pZHMKPiB2NToK
PiAJLSBSZW1vdmUgInNlbGVjdCBIV01PTiIgZnJvbSBLY29uZmlnLgo+IAkgIFVzYWdlIG9mICJk
ZXBlbmRzIG9uIEhXTU9OIHx8IEhXTU9OPW4iIGluc3RlYWQgYW5kIHVzYWdlIG9mCj4gCSAgSVNf
RU5BQkxFRChDT05GSUdfSFdNT04pIHdoZW4gY2FsbGluZyB0byBzbmV0IGh3bW9uIGZ1bmN0aW9u
cy4KPiAJICBzbmV0X2h3bW9uLmMgaXMgY29tcGlsZWQgb25seSBpZiBDT05GSUdfSFdNT04gaXMg
ZGVmaW5lZC4KPiAJLSBSZW1vdmUgdGhlICAjaW5jbHVkZSA8bGludXgvaHdtb24tc3lzZnMuaD4g
ZnJvbSBzbmV0X2h3bW9uLmMuCj4gCS0gUmVtb3ZlIHRoZSB1bm5lY2Vzc2FyeSAobG9uZykgY2Fz
dGluZyBmcm9tIHNuZXRfaHdtb25fcmVhZF9yZWcuCj4gCS0gUmVtb3ZlIHRoZSAiX2h3bW9uIiBl
bmRpbmcgZnJvbSB0aGUgaHdtb24gbmFtZS4KPiAJLSBVc2FnZSBvZiBJU19FUlIgbWFjcm8gdG8g
Y2hlY2sgaWYgZGV2bV9od21vbl9kZXZpY2VfcmVnaXN0ZXJfd2l0aF9pbmZvCj4gCSAgZmFpbGVk
Lgo+IAktIFJlcGxhY2Ugc2NoZWR1bGUoKSB3aXRoIHVzbGVlcF9yYW5nZSgpIGluIHRoZSAiaG90
IGxvb3AiIGluCj4gCSAgcHNuZXRfZGV0ZWN0X2Jhci4KPiAJLSBSZW1vdmUgdGhlIGxvZ2dpbmcg
b2YgbWVtb3J5IGFsbG9jYXRpb24gZmFpbHVyZXMuCj4gCS0gQWRkIHBhcmVudGhlc2lzIHRvIGFy
Z3VtZW50cyBpbiBTTkVUXyogbWFjcm9zLgo+IAktIFByZWZlciBzaXplb2YoKnZhcmlhYmxlKSBp
bnN0ZWFkIG9mIHNpemVvZihzdHJ1Y3QgeCkgd2hlbiBhbGxvY2F0aW5nCj4gCSAgbWVtb3J5Lgo+
IHY2Ogo+IAktIFNORVRfV1JOIC0+IFNORVRfV0FSTi4KPiAtLS0KPiAgIE1BSU5UQUlORVJTICAg
ICAgICAgICAgICAgICAgICAgICAgfCAgICA0ICsKPiAgIGRyaXZlcnMvdmRwYS9LY29uZmlnICAg
ICAgICAgICAgICAgfCAgIDEwICsKPiAgIGRyaXZlcnMvdmRwYS9NYWtlZmlsZSAgICAgICAgICAg
ICAgfCAgICAxICsKPiAgIGRyaXZlcnMvdmRwYS9zb2xpZHJ1bi9NYWtlZmlsZSAgICAgfCAgICA2
ICsKPiAgIGRyaXZlcnMvdmRwYS9zb2xpZHJ1bi9zbmV0X2h3bW9uLmMgfCAgMTg4ICsrKysrCj4g
ICBkcml2ZXJzL3ZkcGEvc29saWRydW4vc25ldF9tYWluLmMgIHwgMTExMSArKysrKysrKysrKysr
KysrKysrKysrKysrKysrCj4gICBkcml2ZXJzL3ZkcGEvc29saWRydW4vc25ldF92ZHBhLmggIHwg
IDE5NiArKysrKwo+ICAgNyBmaWxlcyBjaGFuZ2VkLCAxNTE2IGluc2VydGlvbnMoKykKPiAgIGNy
ZWF0ZSBtb2RlIDEwMDY0NCBkcml2ZXJzL3ZkcGEvc29saWRydW4vTWFrZWZpbGUKPiAgIGNyZWF0
ZSBtb2RlIDEwMDY0NCBkcml2ZXJzL3ZkcGEvc29saWRydW4vc25ldF9od21vbi5jCj4gICBjcmVh
dGUgbW9kZSAxMDA2NDQgZHJpdmVycy92ZHBhL3NvbGlkcnVuL3NuZXRfbWFpbi5jCj4gICBjcmVh
dGUgbW9kZSAxMDA2NDQgZHJpdmVycy92ZHBhL3NvbGlkcnVuL3NuZXRfdmRwYS5oCj4KPiBkaWZm
IC0tZ2l0IGEvTUFJTlRBSU5FUlMgYi9NQUlOVEFJTkVSUwo+IGluZGV4IGE2MDhmMTlkYTNhLi43
ZjRkOWRjYjc2MCAxMDA2NDQKPiAtLS0gYS9NQUlOVEFJTkVSUwo+ICsrKyBiL01BSU5UQUlORVJT
Cj4gQEAgLTIxOTU1LDYgKzIxOTU1LDEwIEBAIElGQ1ZGIFZJUlRJTyBEQVRBIFBBVEggQUNDRUxF
UkFUT1IKPiAgIFI6CVpodSBMaW5nc2hhbiA8bGluZ3NoYW4uemh1QGludGVsLmNvbT4KPiAgIEY6
CWRyaXZlcnMvdmRwYS9pZmN2Zi8KPiAgIAo+ICtTTkVUIERQVSBWSVJUSU8gREFUQSBQQVRIIEFD
Q0VMRVJBVE9SCj4gK1I6CUFsdmFybyBLYXJzeiA8YWx2YXJvLmthcnN6QHNvbGlkLXJ1bi5jb20+
Cj4gK0Y6CWRyaXZlcnMvdmRwYS9zb2xpZHJ1bi8KPiArCj4gICBWSVJUSU8gQkFMTE9PTgo+ICAg
TToJIk1pY2hhZWwgUy4gVHNpcmtpbiIgPG1zdEByZWRoYXQuY29tPgo+ICAgTToJRGF2aWQgSGls
ZGVuYnJhbmQgPGRhdmlkQHJlZGhhdC5jb20+Cj4gZGlmZiAtLWdpdCBhL2RyaXZlcnMvdmRwYS9L
Y29uZmlnIGIvZHJpdmVycy92ZHBhL0tjb25maWcKPiBpbmRleCA1MGY0NWQwMzc2MS4uNzk2MjVj
N2NjNDYgMTAwNjQ0Cj4gLS0tIGEvZHJpdmVycy92ZHBhL0tjb25maWcKPiArKysgYi9kcml2ZXJz
L3ZkcGEvS2NvbmZpZwo+IEBAIC04Niw0ICs4NiwxNCBAQCBjb25maWcgQUxJQkFCQV9FTklfVkRQ
QQo+ICAgCSAgVkRQQSBkcml2ZXIgZm9yIEFsaWJhYmEgRU5JIChFbGFzdGljIE5ldHdvcmsgSW50
ZXJmYWNlKSB3aGljaCBpcyBidWlsdCB1cG9uCj4gICAJICB2aXJ0aW8gMC45LjUgc3BlY2lmaWNh
dGlvbi4KPiAgIAo+ICsgY29uZmlnIFNORVRfVkRQQQo+ICsJdHJpc3RhdGUgIlNvbGlkUnVuJ3Mg
dkRQQSBkcml2ZXIgZm9yIFNvbGlkTkVUIgo+ICsJZGVwZW5kcyBvbiBQQ0lfTVNJICYmIFBDSV9J
T1YgJiYgKEhXTU9OIHx8IEhXTU9OPW4pCgoKU28gSSB0aGluayB3ZSBhY3R1YWxseSBkb24ndCBu
ZWVkIHRvIGRlcGVuZCBvbiBIV01PTiBoZXJlPwoKaHdtb24uYyBpcyBvbmx5IGNvbXBsaWVkIHdo
ZW4gSFdNT04gaXMgZW5hYmxlZCBhbmQgd2UgdXNlIElTX0VOQUJMRUQgdG8gCmV4Y2x1ZGUgdGhl
IGh3bW9uIHNwZWNpZmljIGRvZXMuCgpPdGhlciBsb29rcyBnb29kIHRvIG1lLgoKVGhhbmtzCgpf
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fXwpWaXJ0dWFsaXph
dGlvbiBtYWlsaW5nIGxpc3QKVmlydHVhbGl6YXRpb25AbGlzdHMubGludXgtZm91bmRhdGlvbi5v
cmcKaHR0cHM6Ly9saXN0cy5saW51eGZvdW5kYXRpb24ub3JnL21haWxtYW4vbGlzdGluZm8vdmly
dHVhbGl6YXRpb24=
