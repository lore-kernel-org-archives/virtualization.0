Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A97A8C77B7D
	for <virtualization@archiver.kernel.org>; Mon, 15 May 2023 02:53:59 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id CCA81408C9;
	Mon, 15 May 2023 02:53:58 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org CCA81408C9
Authentication-Results: smtp4.osuosl.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=J6gwXGgw
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
	by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id ABeeY4hyTYRv; Mon, 15 May 2023 02:53:57 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp4.osuosl.org (Postfix) with ESMTPS id 95AFF408BB;
	Mon, 15 May 2023 02:53:56 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org 95AFF408BB
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 6101EC0036;
	Mon, 15 May 2023 02:53:56 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 2BA87C002A
 for <virtualization@lists.linux-foundation.org>;
 Mon, 15 May 2023 02:53:55 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id F2C1081AD1
 for <virtualization@lists.linux-foundation.org>;
 Mon, 15 May 2023 02:53:54 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org F2C1081AD1
Authentication-Results: smtp1.osuosl.org;
 dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com
 header.a=rsa-sha256 header.s=mimecast20190719 header.b=J6gwXGgw
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id YLG8ZR-dClYs
 for <virtualization@lists.linux-foundation.org>;
 Mon, 15 May 2023 02:53:52 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org B87F381A27
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.133.124])
 by smtp1.osuosl.org (Postfix) with ESMTPS id B87F381A27
 for <virtualization@lists.linux-foundation.org>;
 Mon, 15 May 2023 02:53:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1684119230;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=6CabpyALIbC0XiIqIpyQi+CRaEbpYdCuFNhvblzhbiM=;
 b=J6gwXGgw2xnq2ePk6ol6dBPVFrdxxmfSY1RGYkDBTR5gnYIqS5JStR9MUP0/rkxpJ4WRkG
 ZldHdptAbiDqHqaammo0CVxWVjPvBssMS86LsMBSNLm7xl4QTj89mnxK17RImob+ZTxai+
 pUKvC4aug2uhKuPT1Uy61T3Zd/AMVjw=
Received: from mail-pf1-f200.google.com (mail-pf1-f200.google.com
 [209.85.210.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-80-7Ong8J5QMk6XfQ7uYqQcrQ-1; Sun, 14 May 2023 22:53:48 -0400
X-MC-Unique: 7Ong8J5QMk6XfQ7uYqQcrQ-1
Received: by mail-pf1-f200.google.com with SMTP id
 d2e1a72fcca58-643fdc3e994so9779626b3a.2
 for <virtualization@lists.linux-foundation.org>;
 Sun, 14 May 2023 19:53:48 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1684119228; x=1686711228;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=6CabpyALIbC0XiIqIpyQi+CRaEbpYdCuFNhvblzhbiM=;
 b=XYbmTZ+Fvkk+qN/svcgVlRW/DU5DFbKAfnwED9AaYvZz3QUERMfOn+iTL9pNqTlhxJ
 DqbMLNBsaDB0J/fSVCUHoRCplFcUkaukGq9dsINjSPbly91e6kreQA2anOXzBP58juc1
 iS9BSRTBWXE35NcF4DBvbpJgZG0ZqwhaT1cO2XRvY8LtViFWW1fAMcPAKcpeUtXYJWn+
 cTcN7d7N+wpiCdvsc/f5pFDDOeF1DzBxdsW+V4/B8DwIKR4Qqj9gMYjiklGy52/fY4cp
 EFs5sY/OwrWuor3IHnXR2kXo+frt+S4dRBKqQs2QyRwMFI2pbQqQtbkoRk64G0pndKB/
 6X/Q==
X-Gm-Message-State: AC+VfDwdNWHid1LpHNc4l0FQoUmVWkp9jHEovSl9vTPKOucdrAH5yOn6
 FcO+RU3C73RLDeuL+1QdGrz0mifPvUw5oSJ0JlRsozEm2zJNypTwuuiEZuCfgVp5QTEpjLbl+uw
 kLJWUo1AM0q2O3wGfXO98ab8pEWAF4QqWRpQa3SU4/Q==
X-Received: by 2002:a05:6a00:14ce:b0:640:f313:efba with SMTP id
 w14-20020a056a0014ce00b00640f313efbamr44287683pfu.19.1684119227746; 
 Sun, 14 May 2023 19:53:47 -0700 (PDT)
X-Google-Smtp-Source: ACHHUZ4H0Vhtb1WKGWG0qToJXua++R64IEkjUvFNR/u68c6n1aFTk5roUr6tBN4mKUL/UL196m7IKQ==
X-Received: by 2002:a05:6a00:14ce:b0:640:f313:efba with SMTP id
 w14-20020a056a0014ce00b00640f313efbamr44287666pfu.19.1684119227419; 
 Sun, 14 May 2023 19:53:47 -0700 (PDT)
Received: from [10.72.13.223] ([43.228.180.230])
 by smtp.gmail.com with ESMTPSA id
 c22-20020aa78816000000b00642c5ef6050sm9479859pfo.173.2023.05.14.19.53.44
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Sun, 14 May 2023 19:53:47 -0700 (PDT)
Message-ID: <7012a65f-d265-e510-492b-5003b512ef05@redhat.com>
Date: Mon, 15 May 2023 10:53:39 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.10.0
Subject: Re: [PATCH v5 virtio 01/11] virtio: allow caller to override device
 id in vp_modern
To: Shannon Nelson <shannon.nelson@amd.com>, mst@redhat.com,
 virtualization@lists.linux-foundation.org, brett.creeley@amd.com,
 netdev@vger.kernel.org
References: <20230503181240.14009-1-shannon.nelson@amd.com>
 <20230503181240.14009-2-shannon.nelson@amd.com>
From: Jason Wang <jasowang@redhat.com>
In-Reply-To: <20230503181240.14009-2-shannon.nelson@amd.com>
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

CuWcqCAyMDIzLzUvNCAwMjoxMiwgU2hhbm5vbiBOZWxzb24g5YaZ6YGTOgo+IFRvIGFkZCBhIGJp
dCBvZiB2ZW5kb3IgZmxleGliaWxpdHkgd2l0aCB2YXJpb3VzIHZpcnRpbyBiYXNlZCBkZXZpY2Vz
LAo+IGFsbG93IHRoZSBjYWxsZXIgdG8gY2hlY2sgZm9yIGEgZGlmZmVyZW50IGRldmljZSBpZC4g
IFRoaXMgYWRkcyBhIGZ1bmN0aW9uCj4gcG9pbnRlciBmaWVsZCB0byBzdHJ1Y3QgdmlydGlvX3Bj
aV9tb2Rlcm5fZGV2aWNlIHRvIHNwZWNpZnkgYW4gb3ZlcnJpZGUKPiBkZXZpY2UgaWQgY2hlY2su
ICBJZiBkZWZpbmVkIGJ5IHRoZSBkcml2ZXIsIHRoaXMgZnVuY3Rpb24gd2lsbCBiZSBjYWxsZWQK
PiB0byBjaGVjayB0aGF0IHRoZSBQQ0kgZGV2aWNlIGlzIHRoZSB2ZW5kb3IncyBleHBlY3RlZCBk
ZXZpY2UsIGFuZCB3aWxsCj4gcmV0dXJuIHRoZSBmb3VuZCBkZXZpY2UgaWQgdG8gYmUgc3RvcmVk
IGluIG1kZXYtPmlkLmRldmljZS4gIFRoaXMgYWxsb3dzCj4gdmVuZG9ycyB3aXRoIGFsdGVybmF0
aXZlIHZlbmRvciBkZXZpY2UgaWRzIHRvIHVzZSB0aGlzIGxpYnJhcnkgb24gdGhlaXIKPiBvd24g
ZGV2aWNlIEJBUi4KPgo+IE5vdGU6IEEgbG90IG9mIHRoZSBkaWZmIGluIHRoaXMgaXMgc2ltcGx5
IGluZGVudGluZyB0aGUgZXhpc3RpbmcgY29kZQo+IGludG8gYW4gZWxzZSBibG9jay4KPgo+IFNp
Z25lZC1vZmYtYnk6IFNoYW5ub24gTmVsc29uIDxzaGFubm9uLm5lbHNvbkBhbWQuY29tPgoKCkFj
a2VkLWJ5OiBKYXNvbiBXYW5nIDxqYXNvd2FuZ0ByZWRoYXQuY29tPgoKVGhhbmtzCgoKPiAtLS0K
PiAgIGRyaXZlcnMvdmlydGlvL3ZpcnRpb19wY2lfbW9kZXJuX2Rldi5jIHwgMzAgKysrKysrKysr
KysrKysrKy0tLS0tLS0tLS0KPiAgIGluY2x1ZGUvbGludXgvdmlydGlvX3BjaV9tb2Rlcm4uaCAg
ICAgIHwgIDMgKysrCj4gICAyIGZpbGVzIGNoYW5nZWQsIDIyIGluc2VydGlvbnMoKyksIDExIGRl
bGV0aW9ucygtKQo+Cj4gZGlmZiAtLWdpdCBhL2RyaXZlcnMvdmlydGlvL3ZpcnRpb19wY2lfbW9k
ZXJuX2Rldi5jIGIvZHJpdmVycy92aXJ0aW8vdmlydGlvX3BjaV9tb2Rlcm5fZGV2LmMKPiBpbmRl
eCA4NjljYjQ2YmVmOTYuLjliMmQ2NjE0ZGU2NyAxMDA2NDQKPiAtLS0gYS9kcml2ZXJzL3ZpcnRp
by92aXJ0aW9fcGNpX21vZGVybl9kZXYuYwo+ICsrKyBiL2RyaXZlcnMvdmlydGlvL3ZpcnRpb19w
Y2lfbW9kZXJuX2Rldi5jCj4gQEAgLTIxOCwyMSArMjE4LDI5IEBAIGludCB2cF9tb2Rlcm5fcHJv
YmUoc3RydWN0IHZpcnRpb19wY2lfbW9kZXJuX2RldmljZSAqbWRldikKPiAgIAlpbnQgZXJyLCBj
b21tb24sIGlzciwgbm90aWZ5LCBkZXZpY2U7Cj4gICAJdTMyIG5vdGlmeV9sZW5ndGg7Cj4gICAJ
dTMyIG5vdGlmeV9vZmZzZXQ7Cj4gKwlpbnQgZGV2aWQ7Cj4gICAKPiAgIAljaGVja19vZmZzZXRz
KCk7Cj4gICAKPiAtCS8qIFdlIG9ubHkgb3duIGRldmljZXMgPj0gMHgxMDAwIGFuZCA8PSAweDEw
N2Y6IGxlYXZlIHRoZSByZXN0LiAqLwo+IC0JaWYgKHBjaV9kZXYtPmRldmljZSA8IDB4MTAwMCB8
fCBwY2lfZGV2LT5kZXZpY2UgPiAweDEwN2YpCj4gLQkJcmV0dXJuIC1FTk9ERVY7Cj4gLQo+IC0J
aWYgKHBjaV9kZXYtPmRldmljZSA8IDB4MTA0MCkgewo+IC0JCS8qIFRyYW5zaXRpb25hbCBkZXZp
Y2VzOiB1c2UgdGhlIFBDSSBzdWJzeXN0ZW0gZGV2aWNlIGlkIGFzCj4gLQkJICogdmlydGlvIGRl
dmljZSBpZCwgc2FtZSBhcyBsZWdhY3kgZHJpdmVyIGFsd2F5cyBkaWQuCj4gLQkJICovCj4gLQkJ
bWRldi0+aWQuZGV2aWNlID0gcGNpX2Rldi0+c3Vic3lzdGVtX2RldmljZTsKPiArCWlmIChtZGV2
LT5kZXZpY2VfaWRfY2hlY2spIHsKPiArCQlkZXZpZCA9IG1kZXYtPmRldmljZV9pZF9jaGVjayhw
Y2lfZGV2KTsKPiArCQlpZiAoZGV2aWQgPCAwKQo+ICsJCQlyZXR1cm4gZGV2aWQ7Cj4gKwkJbWRl
di0+aWQuZGV2aWNlID0gZGV2aWQ7Cj4gICAJfSBlbHNlIHsKPiAtCQkvKiBNb2Rlcm4gZGV2aWNl
czogc2ltcGx5IHVzZSBQQ0kgZGV2aWNlIGlkLCBidXQgc3RhcnQgZnJvbSAweDEwNDAuICovCj4g
LQkJbWRldi0+aWQuZGV2aWNlID0gcGNpX2Rldi0+ZGV2aWNlIC0gMHgxMDQwOwo+ICsJCS8qIFdl
IG9ubHkgb3duIGRldmljZXMgPj0gMHgxMDAwIGFuZCA8PSAweDEwN2Y6IGxlYXZlIHRoZSByZXN0
LiAqLwo+ICsJCWlmIChwY2lfZGV2LT5kZXZpY2UgPCAweDEwMDAgfHwgcGNpX2Rldi0+ZGV2aWNl
ID4gMHgxMDdmKQo+ICsJCQlyZXR1cm4gLUVOT0RFVjsKPiArCj4gKwkJaWYgKHBjaV9kZXYtPmRl
dmljZSA8IDB4MTA0MCkgewo+ICsJCQkvKiBUcmFuc2l0aW9uYWwgZGV2aWNlczogdXNlIHRoZSBQ
Q0kgc3Vic3lzdGVtIGRldmljZSBpZCBhcwo+ICsJCQkgKiB2aXJ0aW8gZGV2aWNlIGlkLCBzYW1l
IGFzIGxlZ2FjeSBkcml2ZXIgYWx3YXlzIGRpZC4KPiArCQkJICovCj4gKwkJCW1kZXYtPmlkLmRl
dmljZSA9IHBjaV9kZXYtPnN1YnN5c3RlbV9kZXZpY2U7Cj4gKwkJfSBlbHNlIHsKPiArCQkJLyog
TW9kZXJuIGRldmljZXM6IHNpbXBseSB1c2UgUENJIGRldmljZSBpZCwgYnV0IHN0YXJ0IGZyb20g
MHgxMDQwLiAqLwo+ICsJCQltZGV2LT5pZC5kZXZpY2UgPSBwY2lfZGV2LT5kZXZpY2UgLSAweDEw
NDA7Cj4gKwkJfQo+ICAgCX0KPiAgIAltZGV2LT5pZC52ZW5kb3IgPSBwY2lfZGV2LT5zdWJzeXN0
ZW1fdmVuZG9yOwo+ICAgCj4gZGlmZiAtLWdpdCBhL2luY2x1ZGUvbGludXgvdmlydGlvX3BjaV9t
b2Rlcm4uaCBiL2luY2x1ZGUvbGludXgvdmlydGlvX3BjaV9tb2Rlcm4uaAo+IGluZGV4IGM0ZWVi
NzliMDEzOS4uZTdiMWRiMWRkMGJiIDEwMDY0NAo+IC0tLSBhL2luY2x1ZGUvbGludXgvdmlydGlv
X3BjaV9tb2Rlcm4uaAo+ICsrKyBiL2luY2x1ZGUvbGludXgvdmlydGlvX3BjaV9tb2Rlcm4uaAo+
IEBAIC0zOCw2ICszOCw5IEBAIHN0cnVjdCB2aXJ0aW9fcGNpX21vZGVybl9kZXZpY2Ugewo+ICAg
CWludCBtb2Rlcm5fYmFyczsKPiAgIAo+ICAgCXN0cnVjdCB2aXJ0aW9fZGV2aWNlX2lkIGlkOwo+
ICsKPiArCS8qIG9wdGlvbmFsIGNoZWNrIGZvciB2ZW5kb3IgdmlydGlvIGRldmljZSwgcmV0dXJu
cyBkZXZfaWQgb3IgLUVSUk5PICovCj4gKwlpbnQgKCpkZXZpY2VfaWRfY2hlY2spKHN0cnVjdCBw
Y2lfZGV2ICpwZGV2KTsKPiAgIH07Cj4gICAKPiAgIC8qCgpfX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fXwpWaXJ0dWFsaXphdGlvbiBtYWlsaW5nIGxpc3QKVmly
dHVhbGl6YXRpb25AbGlzdHMubGludXgtZm91bmRhdGlvbi5vcmcKaHR0cHM6Ly9saXN0cy5saW51
eGZvdW5kYXRpb24ub3JnL21haWxtYW4vbGlzdGluZm8vdmlydHVhbGl6YXRpb24=
