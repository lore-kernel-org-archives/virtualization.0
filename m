Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2E63EC77B7D
	for <virtualization@archiver.kernel.org>; Mon, 15 May 2023 02:56:45 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id C2CF183EA9;
	Mon, 15 May 2023 02:56:44 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org C2CF183EA9
Authentication-Results: smtp1.osuosl.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=QfdsJ2sk
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
	by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id SYQ5Nc5v-IFA; Mon, 15 May 2023 02:56:43 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp1.osuosl.org (Postfix) with ESMTPS id 30D4B83D25;
	Mon, 15 May 2023 02:56:43 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 30D4B83D25
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 1496FC0036;
	Mon, 15 May 2023 02:56:43 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [IPv6:2605:bc80:3010::138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 2B605C002A
 for <virtualization@lists.linux-foundation.org>;
 Mon, 15 May 2023 02:56:41 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id E4E1D83D28
 for <virtualization@lists.linux-foundation.org>;
 Mon, 15 May 2023 02:56:40 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org E4E1D83D28
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id kYdfE5sITJPc
 for <virtualization@lists.linux-foundation.org>;
 Mon, 15 May 2023 02:56:40 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 25BFE83D25
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.133.124])
 by smtp1.osuosl.org (Postfix) with ESMTPS id 25BFE83D25
 for <virtualization@lists.linux-foundation.org>;
 Mon, 15 May 2023 02:56:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1684119399;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=bUzbYHlUKg4/PI7O371dyR3ua40/pcwitfUhWTzjBSs=;
 b=QfdsJ2skDgsosM0UcoZBmzImBsuPts4/MqeVGEEfamLpliCUWjCtPYjHZGF5cPo8gIhoaJ
 I10IgERsXxC+ndWrX/4wawkOspDJvtKvODifxaQSnMzug+65rCrB0nXRkG6RnMkPbvFf6U
 mDs9X4lEEx5peiLSOc90DgR0Q6o/P2E=
Received: from mail-pf1-f199.google.com (mail-pf1-f199.google.com
 [209.85.210.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-480-IoTmVN5xOIO_PiXmz31mGA-1; Sun, 14 May 2023 22:56:37 -0400
X-MC-Unique: IoTmVN5xOIO_PiXmz31mGA-1
Received: by mail-pf1-f199.google.com with SMTP id
 d2e1a72fcca58-643a1fed384so6462186b3a.3
 for <virtualization@lists.linux-foundation.org>;
 Sun, 14 May 2023 19:56:37 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1684119396; x=1686711396;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=bUzbYHlUKg4/PI7O371dyR3ua40/pcwitfUhWTzjBSs=;
 b=Oeec1+/cNwoGrLDd0bwUJfpGpytriFdeVUfakDDoki6WPc3ArOydatzwC7UeAjj0SJ
 YtucjUeM+8/ib1cI/yG+9bzqpwUxrk8t6KhMn+GIK2+0BUPAnQU0z7MZWq+fWE8s1eNI
 9/FL1aA/+MSbKnGBUThmluKyNiMvCJt2rj+fE9uXBCtbLUK/ZG6x/9lc/nUbeFc6Vav9
 23HOzCmsfer4rkEui5SyRjkAUd8K34xwpnJ58vKBJ2m2rDQOvuDfMQwwxXsV0s3Wnoaz
 8PSZkjI5+9xy/JEDVwBEL5YT3gMZfgxkQxqyUnwAwaoyJ0++1cmzlhkgyYmpM4DvXtw3
 1L9A==
X-Gm-Message-State: AC+VfDzRBXBhawv43IU5PSD2lFQtT9Pjk99d/OmEh+B2zvNVIXfeLJAU
 MDgJ+u1nmICCOXgn3zEvsXHOAp6SBCMA71rQ8dB6DHZW4RdawIHQz9ezY8hH4nIzIOkw1DDGUEl
 fgzb6EhJhkt7tu9AjkdqE3Zvf+Py2j9gYyJAEqAXEFg==
X-Received: by 2002:a05:6a00:98a:b0:643:85a0:57fe with SMTP id
 u10-20020a056a00098a00b0064385a057femr50531311pfg.2.1684119396286; 
 Sun, 14 May 2023 19:56:36 -0700 (PDT)
X-Google-Smtp-Source: ACHHUZ4hQEUIlMZ5h7tntqMDRWtxGUwHc/2UUFSzmrkm/+4lnJ71Lh5riU0+mDR8KDLtSS3qVIgQyA==
X-Received: by 2002:a05:6a00:98a:b0:643:85a0:57fe with SMTP id
 u10-20020a056a00098a00b0064385a057femr50531294pfg.2.1684119395925; 
 Sun, 14 May 2023 19:56:35 -0700 (PDT)
Received: from [10.72.13.223] ([43.228.180.230])
 by smtp.gmail.com with ESMTPSA id
 e11-20020a62ee0b000000b00642ea56f06dsm10636893pfi.26.2023.05.14.19.56.33
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Sun, 14 May 2023 19:56:35 -0700 (PDT)
Message-ID: <372f2dd4-74ae-1bd1-6f54-3bb3f9b05451@redhat.com>
Date: Mon, 15 May 2023 10:56:23 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.10.0
Subject: Re: [PATCH v5 virtio 04/11] pds_vdpa: move enum from common to adminq
 header
To: Shannon Nelson <shannon.nelson@amd.com>, mst@redhat.com,
 virtualization@lists.linux-foundation.org, brett.creeley@amd.com,
 netdev@vger.kernel.org
References: <20230503181240.14009-1-shannon.nelson@amd.com>
 <20230503181240.14009-5-shannon.nelson@amd.com>
From: Jason Wang <jasowang@redhat.com>
In-Reply-To: <20230503181240.14009-5-shannon.nelson@amd.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Language: en-US
Cc: simon.horman@corigine.com, drivers@pensando.io
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

CuWcqCAyMDIzLzUvNCAwMjoxMiwgU2hhbm5vbiBOZWxzb24g5YaZ6YGTOgo+IFRoZSBwZHNfY29y
ZV9sb2dpY2FsX3F0eXBlIGVudW0gYW5kIElGTkFNU0laIGFyZSBub3QgbmVlZGVkCj4gaW4gdGhl
IGNvbW1vbiBQRFMgaGVhZGVyLCBvbmx5IG5lZWRlZCB3aGVuIHdvcmtpbmcgd2l0aCB0aGUKPiBh
ZG1pbnEsIHNvIG1vdmUgdGhlbSB0byB0aGUgYWRtaW5xIGhlYWRlci4KPgo+IE5vdGU6IFRoaXMg
cGF0Y2ggbWlnaHQgY29uZmxpY3Qgd2l0aCBwZHNfdmZpbyBwYXRjaGVzIHRoYXQgYXJlCj4gICAg
ICAgIGluIHJldmlldywgZGVwZW5kaW5nIG9uIHdoaWNoIHBhdGNoc2V0IGdldHMgcHVsbGVkIGZp
cnN0Lgo+Cj4gU2lnbmVkLW9mZi1ieTogU2hhbm5vbiBOZWxzb24gPHNoYW5ub24ubmVsc29uQGFt
ZC5jb20+CgoKQWNrZWQtYnk6IEphc29uIFdhbmcgPGphc293YW5nQHJlZGhhdC5jb20+CgpUaGFu
a3MKCgo+IC0tLQo+ICAgaW5jbHVkZS9saW51eC9wZHMvcGRzX2FkbWlucS5oIHwgMjEgKysrKysr
KysrKysrKysrKysrKysrCj4gICBpbmNsdWRlL2xpbnV4L3Bkcy9wZHNfY29tbW9uLmggfCAyMSAt
LS0tLS0tLS0tLS0tLS0tLS0tLS0KPiAgIDIgZmlsZXMgY2hhbmdlZCwgMjEgaW5zZXJ0aW9ucygr
KSwgMjEgZGVsZXRpb25zKC0pCj4KPiBkaWZmIC0tZ2l0IGEvaW5jbHVkZS9saW51eC9wZHMvcGRz
X2FkbWlucS5oIGIvaW5jbHVkZS9saW51eC9wZHMvcGRzX2FkbWlucS5oCj4gaW5kZXggOThhNjBj
ZTg3YjkyLi42MWIwYTg2MzRlMWEgMTAwNjQ0Cj4gLS0tIGEvaW5jbHVkZS9saW51eC9wZHMvcGRz
X2FkbWlucS5oCj4gKysrIGIvaW5jbHVkZS9saW51eC9wZHMvcGRzX2FkbWlucS5oCj4gQEAgLTIy
Miw2ICsyMjIsMjcgQEAgZW51bSBwZHNfY29yZV9saWZfdHlwZSB7Cj4gICAJUERTX0NPUkVfTElG
X1RZUEVfREVGQVVMVCA9IDAsCj4gICB9Owo+ICAgCj4gKyNkZWZpbmUgUERTX0NPUkVfSUZOQU1T
SVoJCTE2Cj4gKwo+ICsvKioKPiArICogZW51bSBwZHNfY29yZV9sb2dpY2FsX3F0eXBlIC0gTG9n
aWNhbCBRdWV1ZSBUeXBlcwo+ICsgKiBAUERTX0NPUkVfUVRZUEVfQURNSU5ROiAgICBBZG1pbmlz
dHJhdGl2ZSBRdWV1ZQo+ICsgKiBAUERTX0NPUkVfUVRZUEVfTk9USUZZUTogICBOb3RpZnkgUXVl
dWUKPiArICogQFBEU19DT1JFX1FUWVBFX1JYUTogICAgICAgUmVjZWl2ZSBRdWV1ZQo+ICsgKiBA
UERTX0NPUkVfUVRZUEVfVFhROiAgICAgICBUcmFuc21pdCBRdWV1ZQo+ICsgKiBAUERTX0NPUkVf
UVRZUEVfRVE6ICAgICAgICBFdmVudCBRdWV1ZQo+ICsgKiBAUERTX0NPUkVfUVRZUEVfTUFYOiAg
ICAgICBNYXggcXVldWUgdHlwZSBzdXBwb3J0ZWQKPiArICovCj4gK2VudW0gcGRzX2NvcmVfbG9n
aWNhbF9xdHlwZSB7Cj4gKwlQRFNfQ09SRV9RVFlQRV9BRE1JTlEgID0gMCwKPiArCVBEU19DT1JF
X1FUWVBFX05PVElGWVEgPSAxLAo+ICsJUERTX0NPUkVfUVRZUEVfUlhRICAgICA9IDIsCj4gKwlQ
RFNfQ09SRV9RVFlQRV9UWFEgICAgID0gMywKPiArCVBEU19DT1JFX1FUWVBFX0VRICAgICAgPSA0
LAo+ICsKPiArCVBEU19DT1JFX1FUWVBFX01BWCAgICAgPSAxNiAgIC8qIGRvbid0IGNoYW5nZSAt
IHVzZWQgaW4gc3RydWN0IHNpemUgKi8KPiArfTsKPiArCj4gICAvKioKPiAgICAqIHVuaW9uIHBk
c19jb3JlX2xpZl9jb25maWcgLSBMSUYgY29uZmlndXJhdGlvbgo+ICAgICogQHN0YXRlOgkgICAg
TElGIHN0YXRlIChlbnVtIHBkc19jb3JlX2xpZl9zdGF0ZSkKPiBkaWZmIC0tZ2l0IGEvaW5jbHVk
ZS9saW51eC9wZHMvcGRzX2NvbW1vbi5oIGIvaW5jbHVkZS9saW51eC9wZHMvcGRzX2NvbW1vbi5o
Cj4gaW5kZXggMmEwZDE2NjljZmQwLi40MzVjOGU4MTYxYzIgMTAwNjQ0Cj4gLS0tIGEvaW5jbHVk
ZS9saW51eC9wZHMvcGRzX2NvbW1vbi5oCj4gKysrIGIvaW5jbHVkZS9saW51eC9wZHMvcGRzX2Nv
bW1vbi5oCj4gQEAgLTQxLDI3ICs0MSw2IEBAIGVudW0gcGRzX2NvcmVfdmlmX3R5cGVzIHsKPiAg
IAo+ICAgI2RlZmluZSBQRFNfVkRQQV9ERVZfTkFNRQlQRFNfQ09SRV9EUlZfTkFNRSAiLiIgUERT
X0RFVl9UWVBFX1ZEUEFfU1RSCj4gICAKPiAtI2RlZmluZSBQRFNfQ09SRV9JRk5BTVNJWgkJMTYK
PiAtCj4gLS8qKgo+IC0gKiBlbnVtIHBkc19jb3JlX2xvZ2ljYWxfcXR5cGUgLSBMb2dpY2FsIFF1
ZXVlIFR5cGVzCj4gLSAqIEBQRFNfQ09SRV9RVFlQRV9BRE1JTlE6ICAgIEFkbWluaXN0cmF0aXZl
IFF1ZXVlCj4gLSAqIEBQRFNfQ09SRV9RVFlQRV9OT1RJRllROiAgIE5vdGlmeSBRdWV1ZQo+IC0g
KiBAUERTX0NPUkVfUVRZUEVfUlhROiAgICAgICBSZWNlaXZlIFF1ZXVlCj4gLSAqIEBQRFNfQ09S
RV9RVFlQRV9UWFE6ICAgICAgIFRyYW5zbWl0IFF1ZXVlCj4gLSAqIEBQRFNfQ09SRV9RVFlQRV9F
UTogICAgICAgIEV2ZW50IFF1ZXVlCj4gLSAqIEBQRFNfQ09SRV9RVFlQRV9NQVg6ICAgICAgIE1h
eCBxdWV1ZSB0eXBlIHN1cHBvcnRlZAo+IC0gKi8KPiAtZW51bSBwZHNfY29yZV9sb2dpY2FsX3F0
eXBlIHsKPiAtCVBEU19DT1JFX1FUWVBFX0FETUlOUSAgPSAwLAo+IC0JUERTX0NPUkVfUVRZUEVf
Tk9USUZZUSA9IDEsCj4gLQlQRFNfQ09SRV9RVFlQRV9SWFEgICAgID0gMiwKPiAtCVBEU19DT1JF
X1FUWVBFX1RYUSAgICAgPSAzLAo+IC0JUERTX0NPUkVfUVRZUEVfRVEgICAgICA9IDQsCj4gLQo+
IC0JUERTX0NPUkVfUVRZUEVfTUFYICAgICA9IDE2ICAgLyogZG9uJ3QgY2hhbmdlIC0gdXNlZCBp
biBzdHJ1Y3Qgc2l6ZSAqLwo+IC19Owo+IC0KPiAgIGludCBwZHNjX3JlZ2lzdGVyX25vdGlmeShz
dHJ1Y3Qgbm90aWZpZXJfYmxvY2sgKm5iKTsKPiAgIHZvaWQgcGRzY191bnJlZ2lzdGVyX25vdGlm
eShzdHJ1Y3Qgbm90aWZpZXJfYmxvY2sgKm5iKTsKPiAgIHZvaWQgKnBkc2NfZ2V0X3BmX3N0cnVj
dChzdHJ1Y3QgcGNpX2RldiAqdmZfcGRldik7CgpfX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fXwpWaXJ0dWFsaXphdGlvbiBtYWlsaW5nIGxpc3QKVmlydHVhbGl6
YXRpb25AbGlzdHMubGludXgtZm91bmRhdGlvbi5vcmcKaHR0cHM6Ly9saXN0cy5saW51eGZvdW5k
YXRpb24ub3JnL21haWxtYW4vbGlzdGluZm8vdmlydHVhbGl6YXRpb24=
