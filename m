Return-Path: <SRS0=cU2J=K5=lists.linux-foundation.org=virtualization-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.7 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C0F5EC47083
	for <virtualization@archiver.kernel.org>; Thu,  3 Jun 2021 01:36:20 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 78AF2613DC
	for <virtualization@archiver.kernel.org>; Thu,  3 Jun 2021 01:36:20 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 78AF2613DC
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=virtualization-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by smtp2.osuosl.org (Postfix) with ESMTP id 45B43404D5;
	Thu,  3 Jun 2021 01:36:20 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
	by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id HY5z0DinzlYG; Thu,  3 Jun 2021 01:36:19 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp2.osuosl.org (Postfix) with ESMTP id DC30D400DA;
	Thu,  3 Jun 2021 01:36:18 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id C23A2C000D;
	Thu,  3 Jun 2021 01:36:18 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [IPv6:2605:bc80:3010::136])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 75177C0001
 for <virtualization@lists.linux-foundation.org>;
 Thu,  3 Jun 2021 01:36:17 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id 63CAC60AF6
 for <virtualization@lists.linux-foundation.org>;
 Thu,  3 Jun 2021 01:36:17 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp3.osuosl.org (amavisd-new);
 dkim=pass (1024-bit key) header.d=redhat.com
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id DLsPKwtLLyhI
 for <virtualization@lists.linux-foundation.org>;
 Thu,  3 Jun 2021 01:36:16 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [216.205.24.124])
 by smtp3.osuosl.org (Postfix) with ESMTPS id 9D9BE60AE4
 for <virtualization@lists.linux-foundation.org>;
 Thu,  3 Jun 2021 01:36:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1622684175;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=Y5CzXftv1cNQGBT4N8klgWnhnGPgyo6sbkOZKNeq8SY=;
 b=IPazvPNw/fT0J6Ge/rottnO8CJ5lPkTnZykFr0piPSzA7qKLyzb92sBhp4CV/mkWr8p60R
 HcgqBSbUATwFS5D0oCFQIKUM+nbZ/is3u6pQdfiUWJymdikS/nQ4a1OxkGi9E6w/eWHAhN
 p81jpOd/tsezym6iec5Lq2kHoeCxAmM=
Received: from mail-pj1-f71.google.com (mail-pj1-f71.google.com
 [209.85.216.71]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-555-pLWKDebFOOynW21xBrztpw-1; Wed, 02 Jun 2021 21:36:12 -0400
X-MC-Unique: pLWKDebFOOynW21xBrztpw-1
Received: by mail-pj1-f71.google.com with SMTP id
 i8-20020a17090a7188b029015f9564a698so4403978pjk.8
 for <virtualization@lists.linux-foundation.org>;
 Wed, 02 Jun 2021 18:36:12 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-transfer-encoding
 :content-language;
 bh=Y5CzXftv1cNQGBT4N8klgWnhnGPgyo6sbkOZKNeq8SY=;
 b=QZe3K3fOEjMzi1HrSY3wEL1dr7PDmCL3DK4bzqSE4Y6H8GvCCsGnKpRBOowwvBVDCq
 8e1dGJ38Dyom6mMu2Juqxo6wpsj7/OBYrn3wFdTlBo+nf+oKerGl/JKCf9WH8eoqO02I
 ThblWCtYC7A4tSB6k3dYoG+PNxpabrQnGvutmy5fjjniDIf2Z9cnl8bWZanOtG9KCog5
 8DkSKW2TA9VjNqk9OaW5Nm/LBMPu+Si7hjLmQrE/haeKU+M+6W8ITeUCUPuJQeaHWLl5
 I0mMCk31n78Flp9GsQCmpkft41CliY+1/GnRbSyLEt2CA8KNHSzSmv9jSdmizkyzWEgK
 Zq9Q==
X-Gm-Message-State: AOAM532O+r22cJtCd0Y/B0iU4+oyh1T/7dw4UnsKuFwJIKYjb1dt1RYC
 brvbH0WYSJp/J65393+E2c0Ry3evg2kIdcdl8C+HRa5DmoeXmpsUuTjg1cJZyvDw/rp2a7JtcYU
 58tnDzSNOILQnW5wDKF7ZIV+ZFBs4eAIDz/YyT7KMYQ==
X-Received: by 2002:a17:90b:3b92:: with SMTP id
 pc18mr33749644pjb.218.1622684171119; 
 Wed, 02 Jun 2021 18:36:11 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJxRpBImN36GsRv2cKXRVos9rLBUchXt7Oj2wQqMjyXkFNlqv8d2KeJUVTG2Ydk3LiFXcEUIXw==
X-Received: by 2002:a17:90b:3b92:: with SMTP id
 pc18mr33749621pjb.218.1622684170787; 
 Wed, 02 Jun 2021 18:36:10 -0700 (PDT)
Received: from wangxiaodeMacBook-Air.local ([209.132.188.80])
 by smtp.gmail.com with ESMTPSA id u24sm125140pfn.31.2021.06.02.18.36.06
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 02 Jun 2021 18:36:10 -0700 (PDT)
Subject: Re: [PATCH v1 1/8] virtio: Force only split mode with protected guest
To: Andi Kleen <ak@linux.intel.com>, mst@redhat.com
References: <20210603004133.4079390-1-ak@linux.intel.com>
 <20210603004133.4079390-2-ak@linux.intel.com>
From: Jason Wang <jasowang@redhat.com>
Message-ID: <28c8302b-6833-10b4-c0eb-67456e7c4069@redhat.com>
Date: Thu, 3 Jun 2021 09:36:05 +0800
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:78.0)
 Gecko/20100101 Thunderbird/78.10.2
MIME-Version: 1.0
In-Reply-To: <20210603004133.4079390-2-ak@linux.intel.com>
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=jasowang@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Language: en-US
Cc: sathyanarayanan.kuppuswamy@linux.intel.com, x86@kernel.org,
 linux-kernel@vger.kernel.org, virtualization@lists.linux-foundation.org,
 iommu@lists.linux-foundation.org, jpoimboe@redhat.com, robin.murphy@arm.com,
 hch@lst.de, m.szyprowski@samsung.com
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
Content-Type: text/plain; charset="gbk"; Format="flowed"
Errors-To: virtualization-bounces@lists.linux-foundation.org
Sender: "Virtualization" <virtualization-bounces@lists.linux-foundation.org>

CtTaIDIwMjEvNi8zIMnPzuc4OjQxLCBBbmRpIEtsZWVuINC0tcA6Cj4gV2hlbiBydW5uaW5nIHVu
ZGVyIFREWCB0aGUgdmlydGlvIGhvc3QgaXMgdW50cnVzdGVkLiBUaGUgYnVsawo+IG9mIHRoZSBr
ZXJuZWwgbWVtb3J5IGlzIGVuY3J5cHRlZCBhbmQgcHJvdGVjdGVkLCBidXQgdGhlIHZpcnRpbwo+
IHJpbmcgaXMgaW4gc3BlY2lhbCBzaGFyZWQgbWVtb3J5IHRoYXQgaXMgc2hhcmVkIHdpdGggdGhl
Cj4gdW50cnVzdGVkIGhvc3QuCj4KPiBUaGlzIG1lYW5zIHZpcnRpbyBuZWVkcyB0byBiZSBoYXJk
ZW5lZCBhZ2FpbnN0IGFueSBhdHRhY2tzIGZyb20KPiB0aGUgaG9zdCB0aHJvdWdoIHRoZSByaW5n
LiBPZiBjb3Vyc2UgaXQncyBpbXBvc3NpYmxlIHRvIHByZXZlbnQgRE9TCj4gKHRoZSBob3N0IGNh
biBjaG9zZSBhdCBhbnkgdGltZSB0byBzdG9wIGRvaW5nIElPKSwgYnV0IHRoZXJlCj4gc2hvdWxk
IGJlIG5vIGJ1ZmZlciBvdmVycnVucyBvciBzaW1pbGFyIHRoYXQgbWlnaHQgZ2l2ZSBhY2Nlc3Mg
dG8KPiBhbnkgcHJpdmF0ZSBtZW1vcnkgaW4gdGhlIGd1ZXN0Lgo+Cj4gdmlydGlvIGhhcyBhIGxv
dCBvZiBtb2RlcywgbW9zdCBhcmUgZGlmZmljdWx0IHRvIGhhcmRlbi4KPgo+IFRoZSBiZXN0IGZv
ciBoYXJkZW5pbmcgc2VlbXMgdG8gYmUgc3BsaXQgbW9kZSB3aXRob3V0IGluZGlyZWN0Cj4gZGVz
Y3JpcHRvcnMuIFRoaXMgYWxzbyBzaW1wbGlmaWVzIHRoZSBoYXJkZW5pbmcgam9iIGJlY2F1c2UK
PiBpdCdzIG9ubHkgYSBzaW5nbGUgY29kZSBwYXRoLgo+Cj4gT25seSBhbGxvdyBzcGxpdCBtb2Rl
IHdoZW4gaW4gYSBwcm90ZWN0ZWQgZ3Vlc3QuIEZvbGxvd29uCj4gcGF0Y2hlcyBoYXJkZW4gdGhl
IHNwbGl0IG1vZGUgY29kZSBwYXRocywgYW5kIHdlIGRvbid0IHdhbnQKPiBhbiBtYWxpY2lvdXMg
aG9zdCB0byBmb3JjZSBhbnl0aGluZyBlbHNlLiBBbHNvIGRpc2FsbG93Cj4gaW5kaXJlY3QgbW9k
ZSBmb3Igc2ltaWxhciByZWFzb25zLgo+Cj4gU2lnbmVkLW9mZi1ieTogQW5kaSBLbGVlbiA8YWtA
bGludXguaW50ZWwuY29tPgo+IC0tLQo+ICAgZHJpdmVycy92aXJ0aW8vdmlydGlvX3JpbmcuYyB8
IDEyICsrKysrKysrKysrKwo+ICAgMSBmaWxlIGNoYW5nZWQsIDEyIGluc2VydGlvbnMoKykKPgo+
IGRpZmYgLS1naXQgYS9kcml2ZXJzL3ZpcnRpby92aXJ0aW9fcmluZy5jIGIvZHJpdmVycy92aXJ0
aW8vdmlydGlvX3JpbmcuYwo+IGluZGV4IDcxZTE2YjUzZTljMS4uZjM1NjI5ZmE0N2IxIDEwMDY0
NAo+IC0tLSBhL2RyaXZlcnMvdmlydGlvL3ZpcnRpb19yaW5nLmMKPiArKysgYi9kcml2ZXJzL3Zp
cnRpby92aXJ0aW9fcmluZy5jCj4gQEAgLTExLDYgKzExLDcgQEAKPiAgICNpbmNsdWRlIDxsaW51
eC9tb2R1bGUuaD4KPiAgICNpbmNsdWRlIDxsaW51eC9ocnRpbWVyLmg+Cj4gICAjaW5jbHVkZSA8
bGludXgvZG1hLW1hcHBpbmcuaD4KPiArI2luY2x1ZGUgPGxpbnV4L3Byb3RlY3RlZF9ndWVzdC5o
Pgo+ICAgI2luY2x1ZGUgPHhlbi94ZW4uaD4KPiAgIAo+ICAgI2lmZGVmIERFQlVHCj4gQEAgLTIy
MjEsOCArMjIyMiwxNiBAQCB2b2lkIHZyaW5nX3RyYW5zcG9ydF9mZWF0dXJlcyhzdHJ1Y3Qgdmly
dGlvX2RldmljZSAqdmRldikKPiAgIAl1bnNpZ25lZCBpbnQgaTsKPiAgIAo+ICAgCWZvciAoaSA9
IFZJUlRJT19UUkFOU1BPUlRfRl9TVEFSVDsgaSA8IFZJUlRJT19UUkFOU1BPUlRfRl9FTkQ7IGkr
Kykgewo+ICsKPiArCQkvKgo+ICsJCSAqIEluIHByb3RlY3RlZCBndWVzdCBtb2RlIGRpc2FsbG93
IHBhY2tlZCBvciBpbmRpcmVjdAo+ICsJCSAqIGJlY2F1c2UgdGhleSBhaW4ndCBoYXJkZW5lZC4K
PiArCQkgKi8KPiArCj4gICAJCXN3aXRjaCAoaSkgewo+ICAgCQljYXNlIFZJUlRJT19SSU5HX0Zf
SU5ESVJFQ1RfREVTQzoKPiArCQkJaWYgKHByb3RlY3RlZF9ndWVzdF9oYXMoVk1fTUVNX0VOQ1JZ
UFQpKQo+ICsJCQkJZ290byBjbGVhcjsKCgpTbyB3ZSB3aWxsIHNlZSBodWdlIHBlcmZvcm1hbmNl
IHJlZ3Jlc3Npb24gd2l0aG91dCBpbmRpcmVjdCBkZXNjcmlwdG9yLiAKV2UgbmVlZCB0byBjb25z
aWRlciB0byBhZGRyZXNzIHRoaXMuCgpUaGFua3MKCgo+ICAgCQkJYnJlYWs7Cj4gICAJCWNhc2Ug
VklSVElPX1JJTkdfRl9FVkVOVF9JRFg6Cj4gICAJCQlicmVhazsKPiBAQCAtMjIzMSw5ICsyMjQw
LDEyIEBAIHZvaWQgdnJpbmdfdHJhbnNwb3J0X2ZlYXR1cmVzKHN0cnVjdCB2aXJ0aW9fZGV2aWNl
ICp2ZGV2KQo+ICAgCQljYXNlIFZJUlRJT19GX0FDQ0VTU19QTEFURk9STToKPiAgIAkJCWJyZWFr
Owo+ICAgCQljYXNlIFZJUlRJT19GX1JJTkdfUEFDS0VEOgo+ICsJCQlpZiAocHJvdGVjdGVkX2d1
ZXN0X2hhcyhWTV9NRU1fRU5DUllQVCkpCj4gKwkJCQlnb3RvIGNsZWFyOwo+ICAgCQkJYnJlYWs7
Cj4gICAJCWNhc2UgVklSVElPX0ZfT1JERVJfUExBVEZPUk06Cj4gICAJCQlicmVhazsKPiArCQlj
bGVhcjoKPiAgIAkJZGVmYXVsdDoKPiAgIAkJCS8qIFdlIGRvbid0IHVuZGVyc3RhbmQgdGhpcyBi
aXQuICovCj4gICAJCQlfX3ZpcnRpb19jbGVhcl9iaXQodmRldiwgaSk7CgpfX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fXwpWaXJ0dWFsaXphdGlvbiBtYWlsaW5n
IGxpc3QKVmlydHVhbGl6YXRpb25AbGlzdHMubGludXgtZm91bmRhdGlvbi5vcmcKaHR0cHM6Ly9s
aXN0cy5saW51eGZvdW5kYXRpb24ub3JnL21haWxtYW4vbGlzdGluZm8vdmlydHVhbGl6YXRpb24=
