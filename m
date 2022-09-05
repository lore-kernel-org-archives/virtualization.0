Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D9095ECAAD5
	for <virtualization@archiver.kernel.org>; Mon,  5 Sep 2022 08:34:48 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 6F9A48129B;
	Mon,  5 Sep 2022 08:34:48 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 6F9A48129B
Authentication-Results: smtp1.osuosl.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=NMWoO8+u
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
	by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id h6MLzDaQznXn; Mon,  5 Sep 2022 08:34:42 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp1.osuosl.org (Postfix) with ESMTPS id 2DF0D812D8;
	Mon,  5 Sep 2022 08:34:42 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 2DF0D812D8
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id D9DCCC0033;
	Mon,  5 Sep 2022 08:34:41 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [IPv6:2605:bc80:3010::138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 09ACFC002D
 for <virtualization@lists.linux-foundation.org>;
 Mon,  5 Sep 2022 08:34:40 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id CEC0A812D8
 for <virtualization@lists.linux-foundation.org>;
 Mon,  5 Sep 2022 08:34:39 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org CEC0A812D8
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id Rp0Lt8atTXrS
 for <virtualization@lists.linux-foundation.org>;
 Mon,  5 Sep 2022 08:34:34 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 06C578129B
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.129.124])
 by smtp1.osuosl.org (Postfix) with ESMTPS id 06C578129B
 for <virtualization@lists.linux-foundation.org>;
 Mon,  5 Sep 2022 08:34:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1662366872;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=SGf0boq9ogkl73KjPD+WRhg7NzegvIYLMpx6ZLGwAI4=;
 b=NMWoO8+uz5g1MpjTSwi2yUpLh9u2oRYimRfitchFdTqT8uGYRbj6buf8twFFdNzxwFpb+O
 uZ5IiTw/SFVpltaC7NBjFZlDeRihoZ9CUfiZKPM1nM5lfxs2I0fiNlz19ogCVZE+TQ1Bgb
 sZMPAbFdYpiRiNN8jYdDcwKdocfYdGE=
Received: from mail-pl1-f198.google.com (mail-pl1-f198.google.com
 [209.85.214.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-35-EU7aJEhYP0an1NqnSSHAMg-1; Mon, 05 Sep 2022 04:34:32 -0400
X-MC-Unique: EU7aJEhYP0an1NqnSSHAMg-1
Received: by mail-pl1-f198.google.com with SMTP id
 j6-20020a170902da8600b00176a4279ba4so1957596plx.18
 for <virtualization@lists.linux-foundation.org>;
 Mon, 05 Sep 2022 01:34:31 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date;
 bh=SGf0boq9ogkl73KjPD+WRhg7NzegvIYLMpx6ZLGwAI4=;
 b=Ucv1e9CJR/hMkGZSpJO8MiJpVpc003GYiyFA2fsR1djG+yPxbQ/p25DgjVguUvn0k3
 jrBhzd5WWsiH7sgDam1kN273nWujQaiKM6LdoJ2s3bpWdsotlRdVYqUFGyeR/NRa0WeD
 QN+eTLno8po3PVvf4CnNKyC7HJBVCxGozs7IYc+Y7g9+Sgkk+38k0KFrSfrcej8Cuj4N
 gxXC33h2tBxbr0fbQLzG9396dLyYVivL/qYkPuNy7rOvNJxlL7LJWt/mQsveUNirvMeI
 9yu9ArHLLT+JiuTxgKntPckpT39lvUOD5CELz6ARP6NxJ77FEKxynHYsWy8tHwmCzQPi
 EURg==
X-Gm-Message-State: ACgBeo0+h+bQHX17z4XDmVODAZDxWUP65E11saQUB5CY7D1t+LfDtNqm
 17YyXv0mVr1TasqQtq/jJGeKcd1lcT/6a2TlBIY0J5YCicmUtl7lC2a+/pUgfmelc0X2isiV6iR
 XuVy1MehepAxv34+BI6iRQQ00SL+uONLpGJrsgvCCPA==
X-Received: by 2002:a63:2c43:0:b0:41c:66a6:4125 with SMTP id
 s64-20020a632c43000000b0041c66a64125mr41825331pgs.598.1662366870967; 
 Mon, 05 Sep 2022 01:34:30 -0700 (PDT)
X-Google-Smtp-Source: AA6agR7zWUs5WPIMt2WfASgKDey01sfXk2bK3RQOgfvc4viEMCIwYigfVAp1koWIYzRHl/tB8Rrg0A==
X-Received: by 2002:a63:2c43:0:b0:41c:66a6:4125 with SMTP id
 s64-20020a632c43000000b0041c66a64125mr41825315pgs.598.1662366870682; 
 Mon, 05 Sep 2022 01:34:30 -0700 (PDT)
Received: from [10.72.13.239] ([209.132.188.80])
 by smtp.gmail.com with ESMTPSA id
 i69-20020a628748000000b0052e987c64efsm7308169pfe.174.2022.09.05.01.34.28
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 05 Sep 2022 01:34:30 -0700 (PDT)
Message-ID: <04710aa1-5014-ff05-e961-a690490643bf@redhat.com>
Date: Mon, 5 Sep 2022 16:34:26 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:91.0)
 Gecko/20100101 Thunderbird/91.13.0
Subject: Re: [RFC 1/4] vDPA/ifcvf: add get/set_vq_endian support for vDPA
To: Zhu Lingshan <lingshan.zhu@intel.com>, mst@redhat.com
References: <20220901101601.61420-1-lingshan.zhu@intel.com>
 <20220901101601.61420-2-lingshan.zhu@intel.com>
From: Jason Wang <jasowang@redhat.com>
In-Reply-To: <20220901101601.61420-2-lingshan.zhu@intel.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Language: en-US
Cc: netdev@vger.kernel.org, kvm@vger.kernel.org,
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

CuWcqCAyMDIyLzkvMSAxODoxNSwgWmh1IExpbmdzaGFuIOWGmemBkzoKPiBUaGlzIGNvbW1pdCBp
bnRyb3VkdWNlcyBuZXcgY29uZmlnIG9wZXJhdG9pb25zIGZvciB2RFBBOgo+IHZkcGFfY29uZmln
X29wcy5nZXRfdnFfZW5kaWFuOiBzZXQgdnEgZW5kaWFuLW5lc3MKPiB2ZHBhX2NvbmZpZ19vcHMu
c2V0X3ZxX2VuZGlhbjogZ2V0IHZxIGVuZGlhbi1uZXNzCj4KPiBCZWNhdXNlIHRoZSBlbmRpYW4t
bmVzcyBpcyBhIGRldmljZSB3aWRlIGF0dHJpYnV0ZSwKPiBzbyBzZXRpbmcgYSB2cSdzIGVuZGlh
bi1uZXNzIHdpbGwgcmVzdWx0IGluIGNoYW5naW5nCj4gdGhlIGRldmljZSBlbmRpYW4tbmVzcywg
aW5jbHVkaW5nIGFsbCB2cXMgYW5kIHRoZSBjb25maWcgc3BhY2UuCj4KPiBUaGVzZSB0d28gb3Bl
cmF0aW9ucyBhcmUgaW1wbGVtZW50ZWQgaW4gaWZjdmYgaW4gdGhpcyBjb21taXQuCj4KPiBTaWdu
ZWQtb2ZmLWJ5OiBaaHUgTGluZ3NoYW4gPGxpbmdzaGFuLnpodUBpbnRlbC5jb20+Cj4gLS0tCj4g
ICBkcml2ZXJzL3ZkcGEvaWZjdmYvaWZjdmZfYmFzZS5oIHwgIDEgKwo+ICAgZHJpdmVycy92ZHBh
L2lmY3ZmL2lmY3ZmX21haW4uYyB8IDE1ICsrKysrKysrKysrKysrKwo+ICAgaW5jbHVkZS9saW51
eC92ZHBhLmggICAgICAgICAgICB8IDEzICsrKysrKysrKysrKysKPiAgIDMgZmlsZXMgY2hhbmdl
ZCwgMjkgaW5zZXJ0aW9ucygrKQo+Cj4gZGlmZiAtLWdpdCBhL2RyaXZlcnMvdmRwYS9pZmN2Zi9p
ZmN2Zl9iYXNlLmggYi9kcml2ZXJzL3ZkcGEvaWZjdmYvaWZjdmZfYmFzZS5oCj4gaW5kZXggZjU1
NjNmNjY1Y2M2Li42NDAyMzhiOTUwMzMgMTAwNjQ0Cj4gLS0tIGEvZHJpdmVycy92ZHBhL2lmY3Zm
L2lmY3ZmX2Jhc2UuaAo+ICsrKyBiL2RyaXZlcnMvdmRwYS9pZmN2Zi9pZmN2Zl9iYXNlLmgKPiBA
QCAtMTksNiArMTksNyBAQAo+ICAgI2luY2x1ZGUgPHVhcGkvbGludXgvdmlydGlvX2Jsay5oPgo+
ICAgI2luY2x1ZGUgPHVhcGkvbGludXgvdmlydGlvX2NvbmZpZy5oPgo+ICAgI2luY2x1ZGUgPHVh
cGkvbGludXgvdmlydGlvX3BjaS5oPgo+ICsjaW5jbHVkZSA8dWFwaS9saW51eC92aG9zdC5oPgo+
ICAgCj4gICAjZGVmaW5lIE4zMDAwX0RFVklDRV9JRAkJMHgxMDQxCj4gICAjZGVmaW5lIE4zMDAw
X1NVQlNZU19ERVZJQ0VfSUQJMHgwMDFBCj4gZGlmZiAtLWdpdCBhL2RyaXZlcnMvdmRwYS9pZmN2
Zi9pZmN2Zl9tYWluLmMgYi9kcml2ZXJzL3ZkcGEvaWZjdmYvaWZjdmZfbWFpbi5jCj4gaW5kZXgg
ZjljMDA0NGM2NDQyLi4yNzA2MzdkMGYzYTUgMTAwNjQ0Cj4gLS0tIGEvZHJpdmVycy92ZHBhL2lm
Y3ZmL2lmY3ZmX21haW4uYwo+ICsrKyBiL2RyaXZlcnMvdmRwYS9pZmN2Zi9pZmN2Zl9tYWluLmMK
PiBAQCAtNjg0LDYgKzY4NCwxOSBAQCBzdGF0aWMgc3RydWN0IHZkcGFfbm90aWZpY2F0aW9uX2Fy
ZWEgaWZjdmZfZ2V0X3ZxX25vdGlmaWNhdGlvbihzdHJ1Y3QgdmRwYV9kZXZpYwo+ICAgCXJldHVy
biBhcmVhOwo+ICAgfQo+ICAgCj4gK3N0YXRpYyB1OCBpZmN2Zl92ZHBhX2dldF92cV9lbmRpYW4o
c3RydWN0IHZkcGFfZGV2aWNlICp2ZHBhX2RldiwgdTE2IGlkeCkKPiArewo+ICsJcmV0dXJuIFZI
T1NUX1ZSSU5HX0xJVFRMRV9FTkRJQU47Cj4gK30KPiArCj4gK3N0YXRpYyBpbnQgaWZjdmZfdmRw
YV9zZXRfdnFfZW5kaWFuKHN0cnVjdCB2ZHBhX2RldmljZSAqdmRwYV9kZXYsIHUxNiBpZHgsIHU4
IGVuZGlhbikKPiArewo+ICsJaWYgKGVuZGlhbiAhPSBWSE9TVF9WUklOR19MSVRUTEVfRU5ESUFO
KQo+ICsJCXJldHVybiAtRUZBVUxUOwoKCkknbSB3b3JyeWluZyB0aGF0IHRoaXMgYmFzaWNhbGx5
IG1ha2UgdGhlIHByb3Bvc2VkIEFQSSBub3QgbXVjaCB1c2VmdWwuCgpGb3IgZXhhbXBsZSwgd2hh
dCB3b3VsZCB1c2Vyc3BhY2UgZG8gaWYgaXQgbWVldCB0aGlzIGZhaWx1cmU/CgpUaGFua3MKCgo+
ICsKPiArCXJldHVybiAwOwo+ICt9Cj4gKwo+ICAgLyoKPiAgICAqIElGQ1ZGIGN1cnJlbnRseSBk
b2Vzbid0IGhhdmUgb24tY2hpcCBJT01NVSwgc28gbm90Cj4gICAgKiBpbXBsZW1lbnRlZCBzZXRf
bWFwKCkvZG1hX21hcCgpL2RtYV91bm1hcCgpCj4gQEAgLTcxNSw2ICs3MjgsOCBAQCBzdGF0aWMg
Y29uc3Qgc3RydWN0IHZkcGFfY29uZmlnX29wcyBpZmNfdmRwYV9vcHMgPSB7Cj4gICAJLnNldF9j
b25maWcJPSBpZmN2Zl92ZHBhX3NldF9jb25maWcsCj4gICAJLnNldF9jb25maWdfY2IgID0gaWZj
dmZfdmRwYV9zZXRfY29uZmlnX2NiLAo+ICAgCS5nZXRfdnFfbm90aWZpY2F0aW9uID0gaWZjdmZf
Z2V0X3ZxX25vdGlmaWNhdGlvbiwKPiArCS5nZXRfdnFfZW5kaWFuCT0gaWZjdmZfdmRwYV9nZXRf
dnFfZW5kaWFuLAo+ICsJLnNldF92cV9lbmRpYW4JPSBpZmN2Zl92ZHBhX3NldF92cV9lbmRpYW4s
Cj4gICB9Owo+ICAgCj4gICBzdGF0aWMgc3RydWN0IHZpcnRpb19kZXZpY2VfaWQgaWRfdGFibGVf
bmV0W10gPSB7Cj4gZGlmZiAtLWdpdCBhL2luY2x1ZGUvbGludXgvdmRwYS5oIGIvaW5jbHVkZS9s
aW51eC92ZHBhLmgKPiBpbmRleCBkMjgyZjQ2NGQyZjEuLjVlYjgzNDUzYmE4NiAxMDA2NDQKPiAt
LS0gYS9pbmNsdWRlL2xpbnV4L3ZkcGEuaAo+ICsrKyBiL2luY2x1ZGUvbGludXgvdmRwYS5oCj4g
QEAgLTE3NCw2ICsxNzQsMTcgQEAgc3RydWN0IHZkcGFfbWFwX2ZpbGUgewo+ICAgICoJCQkJQGlk
eDogdmlydHF1ZXVlIGluZGV4Cj4gICAgKgkJCQlSZXR1cm5zIGludDogaXJxIG51bWJlciBvZiBh
IHZpcnRxdWV1ZSwKPiAgICAqCQkJCW5lZ2F0aXZlIG51bWJlciBpZiBubyBpcnEgYXNzaWduZWQu
Cj4gKyAqIEBzZXRfdnFfZW5kaWFuOgkJc2V0IGVuZGlhbi1uZXNzIGZvciBhIHZpcnRxdWV1ZQo+
ICsgKgkJCQlAdmRldjogdmRwYSBkZXZpY2UKPiArICoJCQkJQGlkeDogdmlydHF1ZXVlIGluZGV4
Cj4gKyAqCQkJCUBlbmRpYW46IHRoZSBlbmRpYW4tbmVzcyB0byBzZXQsCj4gKyAqCQkJCWNhbiBi
ZSBWSE9TVF9WUklOR19MSVRUTEVfRU5ESUFOIG9yIFZIT1NUX1ZSSU5HX0JJR19FTkRJQU4KPiAr
ICoJCQkJUmV0dXJucyBpbnRlZ2VyOiBzdWNjZXNzICgwKSBvciBlcnJvciAoPCAwKQo+ICsgKiBA
Z2V0X3ZxX2VuZGlhbjoJCWdldCB0aGUgZW5kaWFuLW5lc3Mgb2YgYSB2aXJ0cXVldWUKPiArICoJ
CQkJQHZkZXY6IHZkcGEgZGV2aWNlCj4gKyAqCQkJCUBpZHg6IHZpcnRxdWV1ZSBpbmRleAo+ICsg
KgkJCQlSZXR1cm5zIHU4LCB0aGUgZW5kaWFuLW5lc3Mgb2YgdGhlIHZpcnRxdWV1ZSwKPiArICoJ
CQkJY2FuIGJlIFZIT1NUX1ZSSU5HX0xJVFRMRV9FTkRJQU4gb3IgVkhPU1RfVlJJTkdfQklHX0VO
RElBTgo+ICAgICogQGdldF92cV9hbGlnbjoJCUdldCB0aGUgdmlydHF1ZXVlIGFsaWduIHJlcXVp
cmVtZW50Cj4gICAgKgkJCQlmb3IgdGhlIGRldmljZQo+ICAgICoJCQkJQHZkZXY6IHZkcGEgZGV2
aWNlCj4gQEAgLTMwNiw2ICszMTcsOCBAQCBzdHJ1Y3QgdmRwYV9jb25maWdfb3BzIHsKPiAgIAko
KmdldF92cV9ub3RpZmljYXRpb24pKHN0cnVjdCB2ZHBhX2RldmljZSAqdmRldiwgdTE2IGlkeCk7
Cj4gICAJLyogdnEgaXJxIGlzIG5vdCBleHBlY3RlZCB0byBiZSBjaGFuZ2VkIG9uY2UgRFJJVkVS
X09LIGlzIHNldCAqLwo+ICAgCWludCAoKmdldF92cV9pcnEpKHN0cnVjdCB2ZHBhX2RldmljZSAq
dmRldiwgdTE2IGlkeCk7Cj4gKwlpbnQgKCpzZXRfdnFfZW5kaWFuKShzdHJ1Y3QgdmRwYV9kZXZp
Y2UgKnZkZXYsIHUxNiBpZHgsIHU4IGVuZGlhbik7Cj4gKwl1OCAoKmdldF92cV9lbmRpYW4pKHN0
cnVjdCB2ZHBhX2RldmljZSAqdmRldiwgdTE2IGlkeCk7Cj4gICAKPiAgIAkvKiBEZXZpY2Ugb3Bz
ICovCj4gICAJdTMyICgqZ2V0X3ZxX2FsaWduKShzdHJ1Y3QgdmRwYV9kZXZpY2UgKnZkZXYpOwoK
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18KVmlydHVhbGl6
YXRpb24gbWFpbGluZyBsaXN0ClZpcnR1YWxpemF0aW9uQGxpc3RzLmxpbnV4LWZvdW5kYXRpb24u
b3JnCmh0dHBzOi8vbGlzdHMubGludXhmb3VuZGF0aW9uLm9yZy9tYWlsbWFuL2xpc3RpbmZvL3Zp
cnR1YWxpemF0aW9u
