Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AC586C00144
	for <virtualization@archiver.kernel.org>; Mon,  1 Aug 2022 04:34:13 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 1F82481919;
	Mon,  1 Aug 2022 04:34:13 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 1F82481919
Authentication-Results: smtp1.osuosl.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=WHMSITtJ
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
	by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id z-5qwZNDKD7H; Mon,  1 Aug 2022 04:34:08 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp1.osuosl.org (Postfix) with ESMTPS id 1AA94818C0;
	Mon,  1 Aug 2022 04:34:08 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 1AA94818C0
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id E15C6C0032;
	Mon,  1 Aug 2022 04:34:07 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 4B9E5C002D
 for <virtualization@lists.linux-foundation.org>;
 Mon,  1 Aug 2022 04:34:07 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id 2B2F6401F2
 for <virtualization@lists.linux-foundation.org>;
 Mon,  1 Aug 2022 04:34:07 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org 2B2F6401F2
Authentication-Results: smtp2.osuosl.org;
 dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com
 header.a=rsa-sha256 header.s=mimecast20190719 header.b=WHMSITtJ
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id QjQYqog2JP66
 for <virtualization@lists.linux-foundation.org>;
 Mon,  1 Aug 2022 04:34:05 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org A5142401C2
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.133.124])
 by smtp2.osuosl.org (Postfix) with ESMTPS id A5142401C2
 for <virtualization@lists.linux-foundation.org>;
 Mon,  1 Aug 2022 04:34:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1659328443;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=W4HPbiBG2eCU8mgNI8fe5+OkFApeI6GLNgJKBXRoiEA=;
 b=WHMSITtJW8A2Dd1hkh5yuOmZpDhXabg9BrJilx9fBfTE4k5yaTG2/MHQc6MTYWKDHJ42Hw
 MmQiWEesqBs0ZuqbvBbeZeDWpYjR3dJZ8ln7mhAhfRI/RulI2RXN91kbQjriq/QyqgXNk2
 zeYdIPE/PaqsPoMJsuUBaoUO2C5EF1M=
Received: from mail-pl1-f198.google.com (mail-pl1-f198.google.com
 [209.85.214.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-246-FgphKwiTO3Wkj5wJ2H7H9A-1; Mon, 01 Aug 2022 00:34:02 -0400
X-MC-Unique: FgphKwiTO3Wkj5wJ2H7H9A-1
Received: by mail-pl1-f198.google.com with SMTP id
 a6-20020a170902ecc600b0016ec9c32304so3606921plh.10
 for <virtualization@lists.linux-foundation.org>;
 Sun, 31 Jul 2022 21:34:02 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
 :content-language:to:cc:references:from:in-reply-to
 :content-transfer-encoding;
 bh=W4HPbiBG2eCU8mgNI8fe5+OkFApeI6GLNgJKBXRoiEA=;
 b=Fw4Pz8t29IoxPrCMpyviQFRhpScTW+RLyUG0h1DcUBC122BSjoqR/7mT8wx9HoKhGB
 7bs2e0zpT61QJ2f0owfZKq7cFo0ym7p+LUYla9j+T/HwzWkzRweUHYJ5cXdAm9nRy1uo
 Wm+WVCVzGK9vHJdopGv6Q0jGhrB9IjgH2wJ0znDMeKJje8BCO9Z8VLtcjxvEdFB7w1vJ
 lwj6rzNGwunJU6CffP9TS3Ty70fkpLffX8PplsOeE+B5KmwAMxYz+j7jES5bbcF/zSuP
 0j1z5sL6Jxr6fvoDn/qG50Ft8Og0AHMmNFmucoO9tOjzT7UBcepCRG3n3puxVS2tnaNT
 PXQQ==
X-Gm-Message-State: ACgBeo0/kbGGlX8rgV+e3I7SgLngT4Mp9ZWT9EbebgsZOZKoVxN/FWGe
 /YY+YDnhgJsa/23MaMg9kY8kvEK69VWHve6lnbG/hu70IL4XzDCcnkHNoep8f44HpcFaJkRd2Z7
 9LbunWAwENFcpiwj6+dRgIjuKIB985+2yqmWppsfGAA==
X-Received: by 2002:a17:90b:4a12:b0:1ef:fd9e:a02e with SMTP id
 kk18-20020a17090b4a1200b001effd9ea02emr17977116pjb.216.1659328441643; 
 Sun, 31 Jul 2022 21:34:01 -0700 (PDT)
X-Google-Smtp-Source: AA6agR42MPMDMFpVNU9QZD9ItBP7KwR1+Z1iLRfR68affTWCSxG4XkUZGwpZFsJ11pb6X4yz0AI0qw==
X-Received: by 2002:a17:90b:4a12:b0:1ef:fd9e:a02e with SMTP id
 kk18-20020a17090b4a1200b001effd9ea02emr17977104pjb.216.1659328441351; 
 Sun, 31 Jul 2022 21:34:01 -0700 (PDT)
Received: from [10.72.13.139] ([209.132.188.80])
 by smtp.gmail.com with ESMTPSA id
 i1-20020a1709026ac100b0016bee668a5asm8257019plt.161.2022.07.31.21.33.47
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Sun, 31 Jul 2022 21:33:53 -0700 (PDT)
Message-ID: <555d9757-0989-5a57-c3c5-dfb741f23564@redhat.com>
Date: Mon, 1 Aug 2022 12:33:44 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:91.0)
 Gecko/20100101 Thunderbird/91.11.0
Subject: Re: [PATCH V3 6/6] vDPA: fix 'cast to restricted le16' warnings in
 vdpa.c
To: "Michael S. Tsirkin" <mst@redhat.com>,
 "Zhu, Lingshan" <lingshan.zhu@intel.com>
References: <20220701132826.8132-1-lingshan.zhu@intel.com>
 <20220701132826.8132-7-lingshan.zhu@intel.com>
 <20220729045039-mutt-send-email-mst@kernel.org>
 <7ce4da7f-80aa-14d6-8200-c7f928f32b48@intel.com>
 <20220729051119-mutt-send-email-mst@kernel.org>
 <50b4e7ba-3e49-24b7-5c23-d8a76c61c924@intel.com>
 <20220729052149-mutt-send-email-mst@kernel.org>
 <05bf4c84-28dd-4956-4719-3a5361d151d8@intel.com>
 <20220729053615-mutt-send-email-mst@kernel.org>
From: Jason Wang <jasowang@redhat.com>
In-Reply-To: <20220729053615-mutt-send-email-mst@kernel.org>
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=jasowang@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Language: en-US
Cc: netdev@vger.kernel.org, xieyongji@bytedance.com, gautam.dawar@amd.com,
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
Content-Transfer-Encoding: base64
Content-Type: text/plain; charset="utf-8"; Format="flowed"
Errors-To: virtualization-bounces@lists.linux-foundation.org
Sender: "Virtualization" <virtualization-bounces@lists.linux-foundation.org>

CuWcqCAyMDIyLzcvMjkgMTc6MzksIE1pY2hhZWwgUy4gVHNpcmtpbiDlhpnpgZM6Cj4gT24gRnJp
LCBKdWwgMjksIDIwMjIgYXQgMDU6MzU6MDlQTSArMDgwMCwgWmh1LCBMaW5nc2hhbiB3cm90ZToK
Pj4KPj4gT24gNy8yOS8yMDIyIDU6MjMgUE0sIE1pY2hhZWwgUy4gVHNpcmtpbiB3cm90ZToKPj4+
IE9uIEZyaSwgSnVsIDI5LCAyMDIyIGF0IDA1OjIwOjE3UE0gKzA4MDAsIFpodSwgTGluZ3NoYW4g
d3JvdGU6Cj4+Pj4gT24gNy8yOS8yMDIyIDU6MTcgUE0sIE1pY2hhZWwgUy4gVHNpcmtpbiB3cm90
ZToKPj4+Pj4gT24gRnJpLCBKdWwgMjksIDIwMjIgYXQgMDU6MDc6MTFQTSArMDgwMCwgWmh1LCBM
aW5nc2hhbiB3cm90ZToKPj4+Pj4+IE9uIDcvMjkvMjAyMiA0OjUzIFBNLCBNaWNoYWVsIFMuIFRz
aXJraW4gd3JvdGU6Cj4+Pj4+Pj4gT24gRnJpLCBKdWwgMDEsIDIwMjIgYXQgMDk6Mjg6MjZQTSAr
MDgwMCwgWmh1IExpbmdzaGFuIHdyb3RlOgo+Pj4+Pj4+PiBUaGlzIGNvbW1pdCBmaXhlcyBzcGFy
cyB3YXJuaW5nczogY2FzdCB0byByZXN0cmljdGVkIF9fbGUxNgo+Pj4+Pj4+PiBpbiBmdW5jdGlv
biB2ZHBhX2Rldl9uZXRfY29uZmlnX2ZpbGwoKSBhbmQKPj4+Pj4+Pj4gdmRwYV9maWxsX3N0YXRz
X3JlYygpCj4+Pj4+Pj4+Cj4+Pj4+Pj4+IFNpZ25lZC1vZmYtYnk6IFpodSBMaW5nc2hhbiA8bGlu
Z3NoYW4uemh1QGludGVsLmNvbT4KPj4+Pj4+Pj4gLS0tCj4+Pj4+Pj4+ICAgICAgZHJpdmVycy92
ZHBhL3ZkcGEuYyB8IDYgKysrLS0tCj4+Pj4+Pj4+ICAgICAgMSBmaWxlIGNoYW5nZWQsIDMgaW5z
ZXJ0aW9ucygrKSwgMyBkZWxldGlvbnMoLSkKPj4+Pj4+Pj4KPj4+Pj4+Pj4gZGlmZiAtLWdpdCBh
L2RyaXZlcnMvdmRwYS92ZHBhLmMgYi9kcml2ZXJzL3ZkcGEvdmRwYS5jCj4+Pj4+Pj4+IGluZGV4
IDg0NmRkMzdmMzU0OS4uZWQ0OWZlNDZhNzllIDEwMDY0NAo+Pj4+Pj4+PiAtLS0gYS9kcml2ZXJz
L3ZkcGEvdmRwYS5jCj4+Pj4+Pj4+ICsrKyBiL2RyaXZlcnMvdmRwYS92ZHBhLmMKPj4+Pj4+Pj4g
QEAgLTgyNSwxMSArODI1LDExIEBAIHN0YXRpYyBpbnQgdmRwYV9kZXZfbmV0X2NvbmZpZ19maWxs
KHN0cnVjdCB2ZHBhX2RldmljZSAqdmRldiwgc3RydWN0IHNrX2J1ZmYgKm1zCj4+Pj4+Pj4+ICAg
ICAgCQkgICAgY29uZmlnLm1hYykpCj4+Pj4+Pj4+ICAgICAgCQlyZXR1cm4gLUVNU0dTSVpFOwo+
Pj4+Pj4+PiAtCXZhbF91MTYgPSBsZTE2X3RvX2NwdShjb25maWcuc3RhdHVzKTsKPj4+Pj4+Pj4g
Kwl2YWxfdTE2ID0gX192aXJ0aW8xNl90b19jcHUodHJ1ZSwgY29uZmlnLnN0YXR1cyk7Cj4+Pj4+
Pj4+ICAgICAgCWlmIChubGFfcHV0X3UxNihtc2csIFZEUEFfQVRUUl9ERVZfTkVUX1NUQVRVUywg
dmFsX3UxNikpCj4+Pj4+Pj4+ICAgICAgCQlyZXR1cm4gLUVNU0dTSVpFOwo+Pj4+Pj4+PiAtCXZh
bF91MTYgPSBsZTE2X3RvX2NwdShjb25maWcubXR1KTsKPj4+Pj4+Pj4gKwl2YWxfdTE2ID0gX192
aXJ0aW8xNl90b19jcHUodHJ1ZSwgY29uZmlnLm10dSk7Cj4+Pj4+Pj4+ICAgICAgCWlmIChubGFf
cHV0X3UxNihtc2csIFZEUEFfQVRUUl9ERVZfTkVUX0NGR19NVFUsIHZhbF91MTYpKQo+Pj4+Pj4+
PiAgICAgIAkJcmV0dXJuIC1FTVNHU0laRTsKPj4+Pj4+PiBXcm9uZyBvbiBCRSBwbGF0Zm9ybXMg
d2l0aCBsZWdhY3kgaW50ZXJmYWNlLCBpc24ndCBpdD8KPj4+Pj4+PiBXZSBnZW5lcmFsbHkgZG9u
J3QgaGFuZGxlIGxlZ2FjeSBwcm9wZXJseSBpbiBWRFBBIHNvIGl0J3MKPj4+Pj4+PiBub3QgYSBo
dWdlIGRlYWwsIGJ1dCBtYXliZSBhZGQgYSBjb21tZW50IGF0IGxlYXN0Pwo+Pj4+Pj4gU3VyZSwg
SSBjYW4gYWRkIGEgY29tbWVudCBoZXJlOiB0aGlzIGlzIGZvciBtb2Rlcm4gZGV2aWNlcyBvbmx5
Lgo+Pj4+Pj4KPj4+Pj4+IFRoYW5rcywKPj4+Pj4+IFpodSBMaW5nc2hhbgo+Pj4+PiBIbW0uIHdo
YXQgInRoaXMiIGlzIGZvciBtb2Rlcm4gZGV2aWNlcyBvbmx5IGhlcmU/Cj4+Pj4gdGhpcyBjYXN0
LCBmb3IgTEUgbW9kZXJuIGRldmljZXMuCj4+PiBJIHRoaW5rIHN0YXR1cyBleGlzdGVkIGluIGxl
Z2FjeSBmb3Igc3VyZSwgYW5kIGl0J3MgcG9zc2libGUgdGhhdAo+Pj4gc29tZSBsZWdhY3kgZGV2
aWNlcyBiYWNrcG9ydGVkIG10dSBhbmQgbWF4X3ZpcnRxdWV1ZV9wYWlycyBvdGhlcndpc2UKPj4+
IHdlIHdvdWxkIGhhdmUgdGhlc2UgZmllbGRzIGFzIF9fbGUgbm90IGFzIF9fdmlydGlvLCByaWdo
dD8KPj4geWVzLCB0aGF0J3MgdGhlIHJlYXNvbiB3aHkgaXQgaXMgdmlydGlvXzE2IHRoYW4ganVz
dCBsZTE2Lgo+Pgo+PiBJIG1heSBmaW5kIGEgYmV0dGVyIHNvbHV0aW9uIHRvIGRldGVjdCB3aGV0
aGVyIGl0IGlzIExFLCBvciBCRSB3aXRob3V0IGEKPj4gdmlydGlvX2RldiBzdHJ1Y3R1cmUuCj4+
IENoZWNrIHdoZXRoZXIgdmRwYV9kZXZpY2UtPmdldF9kZXZpY2VfZmVhdHVyZXMoKSBoYXMgVklS
VElPX0ZfVkVSSVNPTl8xLiBJZgo+PiB0aGUgZGV2aWNlIG9mZmVycyBfRl9WRVJTSU9OXzEsIHRo
ZW4gaXQgaXMgYSBMRSBkZXZpY2UsCj4+IG9yIGl0IGlzIGEgQkUgZGV2aWNlLCB0aGVuIHdlIHVz
ZSBfX3ZpcnRpbzE2X3RvX2NwdShmYWxzZSwgY29uZmlnLnN0YXR1cykuCj4+Cj4+IERvZXMgdGhp
cyBsb29rIGdvb2Q/Cj4gTm8gc2luY2UgdGhlIHF1ZXN0aW9uIGlzIGNhbiBiZSBhIGxlZ2FjeSBk
cml2ZXIgd2l0aCBhIHRyYW5zaXRpb25hbAo+IGRldmljZS4gIEkgZG9uJ3QgaGF2ZSBhIGdvb2Qg
aWRlYSB5ZXQuIHZob3N0IGhhcyBWSE9TVF9TRVRfVlJJTkdfRU5ESUFOCj4gYW5kIG1heWJlIHdl
IG5lZWQgc29tZXRoaW5nIGxpa2UgdGhpcyBmb3IgY29uZmlnIGFzIHdlbGw/CgoKTm90IHN1cmUs
IGFuZCBldmVuIGlmIHdlIGhhZCB0aGlzLCB0aGUgcXVlcnkgY291bGQgaGFwcGVuIGJlZm9yZSAK
VkhPU1RfU0VUX1ZSSU5HX0VORElBTi4KCkFjdHVhbGx5LCB0aGUgcGF0Y2ggc2hvdWxkIGJlIGZp
bmUgaXRzZWxmLCBzaW5jZSB0aGUgaXNzdWUgZXhpc3QgZXZlbiAKYmVmb3JlIHRoZSBwYXRjaCAo
d2hpY2ggYXNzdW1lcyBhIGxlKS4KClRoYW5rcwoKCj4KPj4+Pj4+Pj4gQEAgLTkxMSw3ICs5MTEs
NyBAQCBzdGF0aWMgaW50IHZkcGFfZmlsbF9zdGF0c19yZWMoc3RydWN0IHZkcGFfZGV2aWNlICp2
ZGV2LCBzdHJ1Y3Qgc2tfYnVmZiAqbXNnLAo+Pj4+Pj4+PiAgICAgIAl9Cj4+Pj4+Pj4+ICAgICAg
CXZkcGFfZ2V0X2NvbmZpZ191bmxvY2tlZCh2ZGV2LCAwLCAmY29uZmlnLCBzaXplb2YoY29uZmln
KSk7Cj4+Pj4+Pj4+IC0JbWF4X3ZxcCA9IGxlMTZfdG9fY3B1KGNvbmZpZy5tYXhfdmlydHF1ZXVl
X3BhaXJzKTsKPj4+Pj4+Pj4gKwltYXhfdnFwID0gX192aXJ0aW8xNl90b19jcHUodHJ1ZSwgY29u
ZmlnLm1heF92aXJ0cXVldWVfcGFpcnMpOwo+Pj4+Pj4+PiAgICAgIAlpZiAobmxhX3B1dF91MTYo
bXNnLCBWRFBBX0FUVFJfREVWX05FVF9DRkdfTUFYX1ZRUCwgbWF4X3ZxcCkpCj4+Pj4+Pj4+ICAg
ICAgCQlyZXR1cm4gLUVNU0dTSVpFOwo+Pj4+Pj4+PiAtLSAKPj4+Pj4+Pj4gMi4zMS4xCgpfX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fXwpWaXJ0dWFsaXphdGlv
biBtYWlsaW5nIGxpc3QKVmlydHVhbGl6YXRpb25AbGlzdHMubGludXgtZm91bmRhdGlvbi5vcmcK
aHR0cHM6Ly9saXN0cy5saW51eGZvdW5kYXRpb24ub3JnL21haWxtYW4vbGlzdGluZm8vdmlydHVh
bGl6YXRpb24=
