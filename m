Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2DEBCC433EF
	for <virtualization@archiver.kernel.org>; Wed, 18 May 2022 08:32:13 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp2.osuosl.org (Postfix) with ESMTP id DAD1B40223;
	Wed, 18 May 2022 08:32:12 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
	by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id hbUKa0C16R2f; Wed, 18 May 2022 08:32:12 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp2.osuosl.org (Postfix) with ESMTPS id 5CD3340120;
	Wed, 18 May 2022 08:32:11 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 3032FC0032;
	Wed, 18 May 2022 08:32:11 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [IPv6:2605:bc80:3010::137])
 by lists.linuxfoundation.org (Postfix) with ESMTP id D0805C002D
 for <virtualization@lists.linux-foundation.org>;
 Wed, 18 May 2022 08:32:09 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id B112E40925
 for <virtualization@lists.linux-foundation.org>;
 Wed, 18 May 2022 08:32:09 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp4.osuosl.org (amavisd-new);
 dkim=pass (1024-bit key) header.d=redhat.com
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id GbzR2zDrITWH
 for <virtualization@lists.linux-foundation.org>;
 Wed, 18 May 2022 08:32:05 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.129.124])
 by smtp4.osuosl.org (Postfix) with ESMTPS id B01FA408EC
 for <virtualization@lists.linux-foundation.org>;
 Wed, 18 May 2022 08:32:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1652862724;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=0jcGs9bDiU1uI+bDhW5+cG8MAg3hulcxmBzqkx9/FBY=;
 b=dCUeSVKCIdqQx1nIAAI+X71m41+7FHR7zuVI/N+Kf36YEZifgcfbhH6QUJn9y3wcgH82sa
 mBlOiDZfoScjsAK3CJzA9TlAfGnHXYLFi06DRfmZ7XDXL7rMqxdHiR5yilURdPgZG874k9
 7aPqllyKj3/HK+tl05M2YKDnyY34iSc=
Received: from mail-pl1-f197.google.com (mail-pl1-f197.google.com
 [209.85.214.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-13-Jd6Z3MNOP_-cL2wnFgrL2Q-1; Wed, 18 May 2022 04:32:03 -0400
X-MC-Unique: Jd6Z3MNOP_-cL2wnFgrL2Q-1
Received: by mail-pl1-f197.google.com with SMTP id
 b21-20020a170902d41500b0015906c1ea31so613735ple.20
 for <virtualization@lists.linux-foundation.org>;
 Wed, 18 May 2022 01:32:02 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
 :content-language:to:cc:references:from:in-reply-to
 :content-transfer-encoding;
 bh=0jcGs9bDiU1uI+bDhW5+cG8MAg3hulcxmBzqkx9/FBY=;
 b=MVIiFftrXhxggyFo5sMxZhvAHi6QuoKnFbo9B6aST9dMyg3WHWqsrrnJ4eIfVVME1E
 2dan2tDgSWT2dPTqPOzuu5yeRvu9q4f5WhTG8XYLbs4wg8fXmzrvuQ/ph5XUAR4XaC3C
 VsDDAbLx4Bgf62RHsuZ3Z7hWvDg1IEOGpBr3ANulsYvlgb8jOniS0zOfIS0m313Ig6Db
 DjVGmC89EvtQ4Zl6+TP1pK2JwwVehA1KQaqzNu0mh2xokdzoZ3QzNb1TxPFIIQF+gs0l
 G5AZbkVikwxitojzXY6F4v4Kwt/xBMpHgV2TlAARkP9HM7sF1LScGfAgIeqsWFjeVOCr
 kheA==
X-Gm-Message-State: AOAM533GRuXpKqIQvFUe4GiHs7mfYIjNAGJdjtfHKWIV4XUwrjEGVCCa
 FzAfuW4Rtgt4aMg0VT8mAVhRY0/oTPgRGpI0sK1yc/7Hu+5GfqV+vi/zZDbfz6IWT0ptjFFoHms
 wwlys+N2awzlX8XhBVB3jvFEg84ocKt9Di1LGmbIf1A==
X-Received: by 2002:a65:6c12:0:b0:3db:a518:ff1b with SMTP id
 y18-20020a656c12000000b003dba518ff1bmr20113862pgu.315.1652862721986; 
 Wed, 18 May 2022 01:32:01 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJzJfQ2Qwzjdmo96ZzVx/twLJQSX5YnY7cJyEjPMCuWEYLA+j/GgchJdvsjS0UbJ1IuuRKh9Ig==
X-Received: by 2002:a65:6c12:0:b0:3db:a518:ff1b with SMTP id
 y18-20020a656c12000000b003dba518ff1bmr20113847pgu.315.1652862721719; 
 Wed, 18 May 2022 01:32:01 -0700 (PDT)
Received: from [10.72.13.144] ([209.132.188.80])
 by smtp.gmail.com with ESMTPSA id
 g13-20020a62f94d000000b00518119900e9sm1270112pfm.53.2022.05.18.01.31.58
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 18 May 2022 01:32:01 -0700 (PDT)
Message-ID: <28a689dc-a9de-ca1f-6b9f-26c735e96781@redhat.com>
Date: Wed, 18 May 2022 16:31:32 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:91.0)
 Gecko/20100101 Thunderbird/91.9.0
Subject: Re: [PATCH v2 2/3] vdpa: Add a device object for vdpa management
 device
To: Parav Pandit <parav@nvidia.com>,
 "gregkh@linuxfoundation.org" <gregkh@linuxfoundation.org>
References: <20220516060342.106-1-xieyongji@bytedance.com>
 <20220516060342.106-2-xieyongji@bytedance.com>
 <PH0PR12MB54813F96E346D591FBE238C1DCCF9@PH0PR12MB5481.namprd12.prod.outlook.com>
 <CACycT3sRc4bk+3oq7FLzpBMCG_XRN7tOaeEAtNg69o3h8c3=EA@mail.gmail.com>
 <PH0PR12MB5481AD3C1517331EAC4EE078DCCE9@PH0PR12MB5481.namprd12.prod.outlook.com>
 <YoOpBaWcaoujWqO7@kroah.com>
 <PH0PR12MB54819F4E48BE36460BC89457DCCE9@PH0PR12MB5481.namprd12.prod.outlook.com>
From: Jason Wang <jasowang@redhat.com>
In-Reply-To: <PH0PR12MB54819F4E48BE36460BC89457DCCE9@PH0PR12MB5481.namprd12.prod.outlook.com>
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=jasowang@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Language: en-US
Cc: Yongji Xie <xieyongji@bytedance.com>,
 "lingshan.zhu@intel.com" <lingshan.zhu@intel.com>,
 "virtualization@lists.linux-foundation.org"
 <virtualization@lists.linux-foundation.org>, Eli Cohen <elic@nvidia.com>,
 "mst@redhat.com" <mst@redhat.com>
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

CuWcqCAyMDIyLzUvMTggMDc6MDMsIFBhcmF2IFBhbmRpdCDlhpnpgZM6Cj4+PiBBbmQgcmVnYXJk
aW5nIHZkdXNlX2Rldl9yZWxlYXNlKCkgYW5kIGV4aXN0aW5nIGVtcHR5IHJlbGVhc2UgZnVuY3Rp
b24sCj4+IHRoZXkgY2FuIGJlIGR5bmFtaWNhbGx5IGFsbG9jYXRlZC4KPj4+IFRoaXMgaXMgYmVj
YXVzZSB0aGV5IGFyZSByZWFsbHkgdGhlIHN0cnVjdCBkZXZpY2UuCj4+IEkgZG8gbm90IHVuZGVy
c3RhbmQgdGhpcyBzdGF0ZW1lbnQsIHNvcnJ5Lgo+IEl0IHdhcyBiYWQgc2VudGVuY2UsIG15IGJh
ZC4KPgo+IFdoYXQgSSB3YW50ZWQgdG8gc2F5IGlzLCBwcm9iYWJseSBiZXR0ZXIgZXhwbGFpbmVk
IHdpdGggcmVhbCBwYXRjaCBiZWxvdy4KPiBJbiBjb250ZXh0IG9mIFsxXSwgc3RydWN0IHZkdXNl
X21nbXRkZXYgZW1wdHkgcmVsZWFzZSBmdW5jdGlvbiBjYW4gYmUgYXZvaWRlZCBieSBiZWxvdyBp
bmxpbmUgcGF0Y2ggWzJdLgo+Cj4gWzFdaHR0cHM6Ly93d3cuc3Bpbmljcy5uZXQvbGlzdHMvbGlu
dXgtdmlydHVhbGl6YXRpb24vbXNnNTYzNzEuaHRtbAo+Cj4gWzJdIHBhdGNoOgoKCk9rLCBpZiB3
ZSBnbyB0aGlzIHdheSAobG9va3MgbW9yZSBsaWtlIG1kZXZfcGFyZW50KS4gSSB0aGluayB3ZSBu
ZWVkIGF0IApsZWFzdCByZW5hbWUgdGhlIHZkcGFfbWdtdF9kZXZpY2UsIG1heWJlIHZkcGFfcGFy
ZW50IChsaWtlIG1kZXZfcGFyZW50KT8KClRoYW5rcwoKCj4KPiAgRnJvbSBmODdkNTU3ZmU5Mzlh
MTYzMjQ3M2RkMTE1MjZhODczMDFhZGJhYjhkIE1vbiBTZXAgMTcgMDA6MDA6MDAgMjAwMQo+IEZy
b206IFBhcmF2IFBhbmRpdDxwYXJhdkBudmlkaWEuY29tPgo+IERhdGU6IFdlZCwgMTggTWF5IDIw
MjIgMDE6MjI6MjEgKzAzMDAKPiBTdWJqZWN0OiBbUEFUQ0hdIHZkdXNlOiBUaWUgdmR1c2UgbWdt
dGRldiBhbmQgaXRzIGRldmljZQo+Cj4gdmR1c2UgbWFuYWdlbWVudCBkZXZpY2UgaXMgbm90IGJh
Y2tlZCBieSBhbnkgcmVhbCBkZXZpY2Ugc3VjaCBhcyBQQ0kuIEhlbmNlIGl0Cj4gZG9lc24ndCBo
YXZlIGFueSBwYXJlbnQgZGV2aWNlIGxpbmtlZCB0byBpdC4KPgo+IEtlcm5lbCBkcml2ZXIgbW9k
ZWwgaW4gWzFdIHN1Z2dlc3RzIGF2b2lkaW5nIGFuIGVtcHR5IGRldmljZSByZWxlYXNlIGNhbGxi
YWNrLgo+Cj4gSGVuY2UgdGllIHRoZSBtZ210ZGV2aWNlIG9iamVjdCdzIGxpZmUgY3ljbGUgdG8g
YW4gYWxsb2NhdGUgZHVtbXkgc3RydWN0Cj4gZGV2aWNlIGluc3RlYWQgb2YgaGF2aW5nIGl0IHN0
YXRpYy4KPgo+IFsxXWh0dHBzOi8vZ2l0Lmtlcm5lbC5vcmcvcHViL3NjbS9saW51eC9rZXJuZWwv
Z2l0L3RvcnZhbGRzL2xpbnV4LmdpdC90cmVlL0RvY3VtZW50YXRpb24vY29yZS1hcGkva29iamVj
dC5yc3Q/aD12NS4xOC1yYzcjbjI4NAo+Cj4gU2lnbmVkLW9mZi1ieTogUGFyYXYgUGFuZGl0PHBh
cmF2QG52aWRpYS5jb20+Cj4gLS0tCj4gICBkcml2ZXJzL3ZkcGEvdmRwYV91c2VyL3ZkdXNlX2Rl
di5jIHwgNjAgKysrKysrKysrKysrKysrKysrLS0tLS0tLS0tLS0tCj4gICAxIGZpbGUgY2hhbmdl
ZCwgMzcgaW5zZXJ0aW9ucygrKSwgMjMgZGVsZXRpb25zKC0pCj4KPiBkaWZmIC0tZ2l0IGEvZHJp
dmVycy92ZHBhL3ZkcGFfdXNlci92ZHVzZV9kZXYuYyBiL2RyaXZlcnMvdmRwYS92ZHBhX3VzZXIv
dmR1c2VfZGV2LmMKPiBpbmRleCBmODVkMWEwOGVkODcuLmViZTI3MjU3NWZiOCAxMDA2NDQKPiAt
LS0gYS9kcml2ZXJzL3ZkcGEvdmRwYV91c2VyL3ZkdXNlX2Rldi5jCj4gKysrIGIvZHJpdmVycy92
ZHBhL3ZkcGFfdXNlci92ZHVzZV9kZXYuYwo+IEBAIC0xNDc1LDE2ICsxNDc1LDEyIEBAIHN0YXRp
YyBjaGFyICp2ZHVzZV9kZXZub2RlKHN0cnVjdCBkZXZpY2UgKmRldiwgdW1vZGVfdCAqbW9kZSkK
PiAgIAlyZXR1cm4ga2FzcHJpbnRmKEdGUF9LRVJORUwsICJ2ZHVzZS8lcyIsIGRldl9uYW1lKGRl
dikpOwo+ICAgfQo+ICAgCj4gLXN0YXRpYyB2b2lkIHZkdXNlX21nbXRkZXZfcmVsZWFzZShzdHJ1
Y3QgZGV2aWNlICpkZXYpCj4gLXsKPiAtfQo+IC0KPiAtc3RhdGljIHN0cnVjdCBkZXZpY2UgdmR1
c2VfbWdtdGRldiA9IHsKPiAtCS5pbml0X25hbWUgPSAidmR1c2UiLAo+IC0JLnJlbGVhc2UgPSB2
ZHVzZV9tZ210ZGV2X3JlbGVhc2UsCj4gK3N0cnVjdCB2ZHVzZV9tZ210X2RldiB7Cj4gKwlzdHJ1
Y3QgdmRwYV9tZ210X2RldiBtZ210X2RldjsKPiArCXN0cnVjdCBkZXZpY2UgZGV2Owo+ICAgfTsK
PiAgIAo+IC1zdGF0aWMgc3RydWN0IHZkcGFfbWdtdF9kZXYgbWdtdF9kZXY7Cj4gK3N0YXRpYyBz
dHJ1Y3QgdmR1c2VfbWdtdF9kZXYgKnZkdXNlX21nbXQ7Cj4gICAKPiAgIHN0YXRpYyBpbnQgdmR1
c2VfZGV2X2luaXRfdmRwYShzdHJ1Y3QgdmR1c2VfZGV2ICpkZXYsIGNvbnN0IGNoYXIgKm5hbWUp
Cj4gICB7Cj4gQEAgLTE1MDksNyArMTUwNSw3IEBAIHN0YXRpYyBpbnQgdmR1c2VfZGV2X2luaXRf
dmRwYShzdHJ1Y3QgdmR1c2VfZGV2ICpkZXYsIGNvbnN0IGNoYXIgKm5hbWUpCj4gICAJfQo+ICAg
CXNldF9kbWFfb3BzKCZ2ZGV2LT52ZHBhLmRldiwgJnZkdXNlX2Rldl9kbWFfb3BzKTsKPiAgIAl2
ZGV2LT52ZHBhLmRtYV9kZXYgPSAmdmRldi0+dmRwYS5kZXY7Cj4gLQl2ZGV2LT52ZHBhLm1kZXYg
PSAmbWdtdF9kZXY7Cj4gKwl2ZGV2LT52ZHBhLm1kZXYgPSAmdmR1c2VfbWdtdC0+bWdtdF9kZXY7
Cj4gICAKPiAgIAlyZXR1cm4gMDsKPiAgIH0KPiBAQCAtMTU1NSwzNCArMTU1MSw1MiBAQCBzdGF0
aWMgc3RydWN0IHZpcnRpb19kZXZpY2VfaWQgaWRfdGFibGVbXSA9IHsKPiAgIAl7IDAgfSwKPiAg
IH07Cj4gICAKPiAtc3RhdGljIHN0cnVjdCB2ZHBhX21nbXRfZGV2IG1nbXRfZGV2ID0gewo+IC0J
LmRldmljZSA9ICZ2ZHVzZV9tZ210ZGV2LAo+IC0JLmlkX3RhYmxlID0gaWRfdGFibGUsCj4gLQku
b3BzID0gJnZkcGFfZGV2X21nbXRkZXZfb3BzLAo+IC19Owo+ICtzdGF0aWMgdm9pZCB2ZHVzZV9t
Z210ZGV2X3JlbGVhc2Uoc3RydWN0IGRldmljZSAqZGV2KQo+ICt7Cj4gKwlzdHJ1Y3QgdmR1c2Vf
bWdtdF9kZXYgKm1nbXRfZGV2Owo+ICsKPiArCW1nbXRfZGV2ID0gY29udGFpbmVyX29mKGRldiwg
c3RydWN0IHZkdXNlX21nbXRfZGV2LCBkZXYpOwo+ICsJa2ZyZWUobWdtdF9kZXYpOwo+ICt9Cj4g
ICAKPiAgIHN0YXRpYyBpbnQgdmR1c2VfbWdtdGRldl9pbml0KHZvaWQpCj4gICB7Cj4gICAJaW50
IHJldDsKPiAgIAo+IC0JcmV0ID0gZGV2aWNlX3JlZ2lzdGVyKCZ2ZHVzZV9tZ210ZGV2KTsKPiAt
CWlmIChyZXQpCj4gKwl2ZHVzZV9tZ210ID0ga3phbGxvYyhzaXplb2YoKnZkdXNlX21nbXQpLCBH
RlBfS0VSTkVMKTsKPiArCWlmICghdmR1c2VfbWdtdCkKPiArCQlyZXR1cm4gLUVOT01FTTsKPiAr
Cj4gKwlyZXQgPSBkZXZfc2V0X25hbWUoJnZkdXNlX21nbXQtPmRldiwgInZkdXNlLWxhIik7Cj4g
KwlpZiAocmV0KSB7Cj4gKwkJa2ZyZWUodmR1c2VfbWdtdCk7Cj4gICAJCXJldHVybiByZXQ7Cj4g
Kwl9Cj4gICAKPiAtCXJldCA9IHZkcGFfbWdtdGRldl9yZWdpc3RlcigmbWdtdF9kZXYpOwo+ICsJ
dmR1c2VfbWdtdC0+ZGV2LnJlbGVhc2UgPSB2ZHVzZV9tZ210ZGV2X3JlbGVhc2U7Cj4gKwo+ICsJ
cmV0ID0gZGV2aWNlX3JlZ2lzdGVyKCZ2ZHVzZV9tZ210LT5kZXYpOwo+ICAgCWlmIChyZXQpCj4g
LQkJZ290byBlcnI7Cj4gKwkJZ290byBkZXZfcmVnX2VycjsKPiAgIAo+IC0JcmV0dXJuIDA7Cj4g
LWVycjoKPiAtCWRldmljZV91bnJlZ2lzdGVyKCZ2ZHVzZV9tZ210ZGV2KTsKPiArCXZkdXNlX21n
bXQtPm1nbXRfZGV2LmlkX3RhYmxlID0gaWRfdGFibGU7Cj4gKwl2ZHVzZV9tZ210LT5tZ210X2Rl
di5vcHMgPSAmdmRwYV9kZXZfbWdtdGRldl9vcHM7Cj4gKwl2ZHVzZV9tZ210LT5tZ210X2Rldi5k
ZXZpY2UgPSAmdmR1c2VfbWdtdC0+ZGV2Owo+ICsJcmV0ID0gdmRwYV9tZ210ZGV2X3JlZ2lzdGVy
KCZ2ZHVzZV9tZ210LT5tZ210X2Rldik7Cj4gKwlpZiAocmV0KQo+ICsJCWRldmljZV91bnJlZ2lz
dGVyKCZ2ZHVzZV9tZ210LT5kZXYpOwo+ICsKPiArCXJldHVybiByZXQ7Cj4gKwo+ICtkZXZfcmVn
X2VycjoKPiArCXB1dF9kZXZpY2UoJnZkdXNlX21nbXQtPmRldik7Cj4gICAJcmV0dXJuIHJldDsK
PiAgIH0KPiAgIAo+ICAgc3RhdGljIHZvaWQgdmR1c2VfbWdtdGRldl9leGl0KHZvaWQpCj4gICB7
Cj4gLQl2ZHBhX21nbXRkZXZfdW5yZWdpc3RlcigmbWdtdF9kZXYpOwo+IC0JZGV2aWNlX3VucmVn
aXN0ZXIoJnZkdXNlX21nbXRkZXYpOwo+ICsJdmRwYV9tZ210ZGV2X3VucmVnaXN0ZXIoJnZkdXNl
X21nbXQtPm1nbXRfZGV2KTsKPiArCWRldmljZV91bnJlZ2lzdGVyKCZ2ZHVzZV9tZ210LT5kZXYp
Owo+ICAgfQo+ICAgCj4gICBzdGF0aWMgaW50IHZkdXNlX2luaXQodm9pZCkKPiAtLSAyLjI2LjIK
Cl9fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fClZpcnR1YWxp
emF0aW9uIG1haWxpbmcgbGlzdApWaXJ0dWFsaXphdGlvbkBsaXN0cy5saW51eC1mb3VuZGF0aW9u
Lm9yZwpodHRwczovL2xpc3RzLmxpbnV4Zm91bmRhdGlvbi5vcmcvbWFpbG1hbi9saXN0aW5mby92
aXJ0dWFsaXphdGlvbg==
