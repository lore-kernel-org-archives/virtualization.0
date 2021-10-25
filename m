Return-Path: <SRS0=ZIIO=PN=lists.linux-foundation.org=virtualization-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7A1B5C433EF
	for <virtualization@archiver.kernel.org>; Mon, 25 Oct 2021 04:41:00 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 11B7860F02
	for <virtualization@archiver.kernel.org>; Mon, 25 Oct 2021 04:40:59 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org 11B7860F02
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id BF099401A6;
	Mon, 25 Oct 2021 04:40:59 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
	by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id VQZM-prsIdhh; Mon, 25 Oct 2021 04:40:55 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp4.osuosl.org (Postfix) with ESMTPS id 48BD2401D1;
	Mon, 25 Oct 2021 04:40:55 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 1D549C0012;
	Mon, 25 Oct 2021 04:40:55 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [IPv6:2605:bc80:3010::133])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 63E72C000E
 for <virtualization@lists.linux-foundation.org>;
 Mon, 25 Oct 2021 04:40:53 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id 50E7E400D4
 for <virtualization@lists.linux-foundation.org>;
 Mon, 25 Oct 2021 04:40:53 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp2.osuosl.org (amavisd-new);
 dkim=pass (1024-bit key) header.d=redhat.com
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id 9yZntu4JL3vc
 for <virtualization@lists.linux-foundation.org>;
 Mon, 25 Oct 2021 04:40:51 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [216.205.24.124])
 by smtp2.osuosl.org (Postfix) with ESMTPS id 22F8D40018
 for <virtualization@lists.linux-foundation.org>;
 Mon, 25 Oct 2021 04:40:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1635136849;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=qjVkI2n3SJI7/K1hvcMeCrmtPAeZ25MHOyouz4fZPTU=;
 b=AnQBh1rHiPyYXO3G0UJMW9+lCwnHase4CcX6U/q1CjMw1mgwmtMNOCsMmZOk/459MgTA6H
 MvQDBMpiYmBU8M8HSRXEfcyjWTes9XYS76SXS2qb9xhu4825ssG85sia37mc8931dDEpJ8
 M+T5a65VS6LL045epvE+Vcgya2odxrQ=
Received: from mail-pj1-f72.google.com (mail-pj1-f72.google.com
 [209.85.216.72]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-515-jOyT57hyPVyfhmE6ulNwqQ-1; Mon, 25 Oct 2021 00:40:47 -0400
X-MC-Unique: jOyT57hyPVyfhmE6ulNwqQ-1
Received: by mail-pj1-f72.google.com with SMTP id
 n2-20020a17090a2fc200b001a1bafb59bfso6399161pjm.1
 for <virtualization@lists.linux-foundation.org>;
 Sun, 24 Oct 2021 21:40:47 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:subject:to:references:cc:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-transfer-encoding
 :content-language;
 bh=qjVkI2n3SJI7/K1hvcMeCrmtPAeZ25MHOyouz4fZPTU=;
 b=oBFcIyyEkWk24Zz6RNA9aFkSVaAMyD8vn6Ye+IoohEq1M8Ezoo1zxQOhc9QcB19JRF
 HADVfehlSx/GYJu2YatRNJTz8w6dLimNNC5HCIuhW6OOSwjgJGAXIxZu1Rb/qNOsqQrJ
 +9R2mZOaFwpRAeBm4qq7iusBRrsUgtGrjUVtwPZA4mWuYg081M7sioT2naX2WPnoykvY
 PcoLrvudMb0pGQMaB9GeDvrvccVFq1ciDSzDtuuqF7fqiq281meMl0FE5MZ+rNDtQFdy
 7IaP6Rp+QbG73kGNnIHST/z8n/raCkkV4Zd5RIl2+QNLIkFXR/VduVzL4IJBTCGWa9B/
 54NA==
X-Gm-Message-State: AOAM533LCJvYbr/mmqi2YAOdV+gL+J5ZQzge10agYCGTWEIKjJdK3zII
 93i+/aBYb38qeY/EnZJ3n+L8S0tlGnCN/sG2Vf0sdtunrNF6sFnGaTPgK2MaLbYqA/9fzlEYYyC
 ZK+9l9mPbQbdJvGTLEXjKeDqTkFaN/jLvuF+H8LX/AA==
X-Received: by 2002:a63:2cd8:: with SMTP id
 s207mr11892029pgs.312.1635136846586; 
 Sun, 24 Oct 2021 21:40:46 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJwZeEFK9SQBPkqktqdkxLVnXjd/GU7BwVf+RIB0w3wF8hhCTJhCmVTYt8kaWufvLG9n5sDgxQ==
X-Received: by 2002:a63:2cd8:: with SMTP id
 s207mr11892007pgs.312.1635136846244; 
 Sun, 24 Oct 2021 21:40:46 -0700 (PDT)
Received: from wangxiaodeMacBook-Air.local ([209.132.188.80])
 by smtp.gmail.com with ESMTPSA id 11sm16756319pfl.41.2021.10.24.21.40.43
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Sun, 24 Oct 2021 21:40:45 -0700 (PDT)
Subject: Re: [PATCH v6 8/8] eni_vdpa: add vDPA driver for Alibaba ENI
To: Wu Zongyong <wuzongyong@linux.alibaba.com>
References: <cover.1634281805.git.wuzongyong@linux.alibaba.com>
 <cover.1634870456.git.wuzongyong@linux.alibaba.com>
 <6496b76a64303a3e23ea19e3e279644608de36fb.1634870456.git.wuzongyong@linux.alibaba.com>
 <CACGkMEvi7505ZOSLP6gMMvhC=Zfdt=nPK4WEYe7=VVbq3GmxCQ@mail.gmail.com>
 <20211025032146.GC3684@L-PF27918B-1352.localdomain>
From: Jason Wang <jasowang@redhat.com>
Message-ID: <51e9be5b-4bb2-b82b-a152-ffc37803410c@redhat.com>
Date: Mon, 25 Oct 2021 12:40:41 +0800
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:78.0)
 Gecko/20100101 Thunderbird/78.14.0
MIME-Version: 1.0
In-Reply-To: <20211025032146.GC3684@L-PF27918B-1352.localdomain>
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=jasowang@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Language: en-US
Cc: wei.yang1@linux.alibaba.com, mst <mst@redhat.com>,
 linux-kernel <linux-kernel@vger.kernel.org>,
 virtualization <virtualization@lists.linux-foundation.org>
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

CuWcqCAyMDIxLzEwLzI1IOS4iuWNiDExOjIxLCBXdSBab25neW9uZyDlhpnpgZM6Cj4gT24gTW9u
LCBPY3QgMjUsIDIwMjEgYXQgMTA6Mjc6MzFBTSArMDgwMCwgSmFzb24gV2FuZyB3cm90ZToKPj4g
T24gRnJpLCBPY3QgMjIsIDIwMjEgYXQgMTA6NDQgQU0gV3UgWm9uZ3lvbmcKPj4gPHd1em9uZ3lv
bmdAbGludXguYWxpYmFiYS5jb20+IHdyb3RlOgo+Pj4gVGhpcyBwYXRjaCBhZGRzIGEgbmV3IHZE
UEEgZHJpdmVyIGZvciBBbGliYWJhIEVOSShFbGFzdGljIE5ldHdvcmsKPj4+IEludGVyZmFjZSkg
d2hpY2ggaXMgYnVpbGQgdXBvbiB2aXJ0aW8gMC45LjUgc3BlY2lmaWNhdGlvbi4KPj4+IEFuZCB0
aGlzIGRyaXZlciBkb2Vzbid0IHN1cHBvcnQgdG8gcnVuIG9uIEJFIGhvc3QuCj4+Pgo+Pj4gU2ln
bmVkLW9mZi1ieTogV3UgWm9uZ3lvbmcgPHd1em9uZ3lvbmdAbGludXguYWxpYmFiYS5jb20+Cj4+
PiAtLS0KPj4+ICAgZHJpdmVycy92ZHBhL0tjb25maWcgICAgICAgICAgICB8ICAgOCArCj4+PiAg
IGRyaXZlcnMvdmRwYS9NYWtlZmlsZSAgICAgICAgICAgfCAgIDEgKwo+Pj4gICBkcml2ZXJzL3Zk
cGEvYWxpYmFiYS9NYWtlZmlsZSAgIHwgICAzICsKPj4+ICAgZHJpdmVycy92ZHBhL2FsaWJhYmEv
ZW5pX3ZkcGEuYyB8IDU1MyArKysrKysrKysrKysrKysrKysrKysrKysrKysrKysrKwo+Pj4gICA0
IGZpbGVzIGNoYW5nZWQsIDU2NSBpbnNlcnRpb25zKCspCj4+PiAgIGNyZWF0ZSBtb2RlIDEwMDY0
NCBkcml2ZXJzL3ZkcGEvYWxpYmFiYS9NYWtlZmlsZQo+Pj4gICBjcmVhdGUgbW9kZSAxMDA2NDQg
ZHJpdmVycy92ZHBhL2FsaWJhYmEvZW5pX3ZkcGEuYwo+Pj4KPj4+IGRpZmYgLS1naXQgYS9kcml2
ZXJzL3ZkcGEvS2NvbmZpZyBiL2RyaXZlcnMvdmRwYS9LY29uZmlnCj4+PiBpbmRleCAzZDkxOTgy
ZDgzNzEuLmMwMjMyYTIxNDhhNyAxMDA2NDQKPj4+IC0tLSBhL2RyaXZlcnMvdmRwYS9LY29uZmln
Cj4+PiArKysgYi9kcml2ZXJzL3ZkcGEvS2NvbmZpZwo+Pj4gQEAgLTc4LDQgKzc4LDEyIEBAIGNv
bmZpZyBWUF9WRFBBCj4+PiAgICAgICAgICBoZWxwCj4+PiAgICAgICAgICAgIFRoaXMga2VybmVs
IG1vZHVsZSBicmlkZ2VzIHZpcnRpbyBQQ0kgZGV2aWNlIHRvIHZEUEEgYnVzLgo+Pj4KPj4+ICtj
b25maWcgQUxJQkFCQV9FTklfVkRQQQo+Pj4gKyAgICAgICB0cmlzdGF0ZSAidkRQQSBkcml2ZXIg
Zm9yIEFsaWJhYmEgRU5JIgo+Pj4gKyAgICAgICBzZWxlY3QgVklSVElPX1BDSV9MRUdBQ1lfTElC
Cj4+PiArICAgICAgIGRlcGVuZHMgb24gUENJX01TSSAmJiAhQ1BVX0JJR19FTkRJQU4KPj4+ICsg
ICAgICAgaGVscAo+Pj4gKyAgICAgICAgIFZEUEEgZHJpdmVyIGZvciBBbGliYWJhIEVOSShFbGFz
dGljIE5ldHdvcmsgSW50ZXJmYWNlKSB3aGljaCBpcyBidWlsZCB1cG9uCj4+PiArICAgICAgICAg
dmlydGlvIDAuOS41IHNwZWNpZmljYXRpb24uCj4+PiArCj4+PiAgIGVuZGlmICMgVkRQQQo+Pj4g
ZGlmZiAtLWdpdCBhL2RyaXZlcnMvdmRwYS9NYWtlZmlsZSBiL2RyaXZlcnMvdmRwYS9NYWtlZmls
ZQo+Pj4gaW5kZXggZjAyZWJlZDMzZjE5Li4xNTY2NTU2M2E3ZjQgMTAwNjQ0Cj4+PiAtLS0gYS9k
cml2ZXJzL3ZkcGEvTWFrZWZpbGUKPj4+ICsrKyBiL2RyaXZlcnMvdmRwYS9NYWtlZmlsZQo+Pj4g
QEAgLTUsMyArNSw0IEBAIG9iai0kKENPTkZJR19WRFBBX1VTRVIpICs9IHZkcGFfdXNlci8KPj4+
ICAgb2JqLSQoQ09ORklHX0lGQ1ZGKSAgICArPSBpZmN2Zi8KPj4+ICAgb2JqLSQoQ09ORklHX01M
WDVfVkRQQSkgKz0gbWx4NS8KPj4+ICAgb2JqLSQoQ09ORklHX1ZQX1ZEUEEpICAgICs9IHZpcnRp
b19wY2kvCj4+PiArb2JqLSQoQ09ORklHX0FMSUJBQkFfRU5JX1ZEUEEpICs9IGFsaWJhYmEvCj4+
PiBkaWZmIC0tZ2l0IGEvZHJpdmVycy92ZHBhL2FsaWJhYmEvTWFrZWZpbGUgYi9kcml2ZXJzL3Zk
cGEvYWxpYmFiYS9NYWtlZmlsZQo+Pj4gbmV3IGZpbGUgbW9kZSAxMDA2NDQKPj4+IGluZGV4IDAw
MDAwMDAwMDAwMC4uZWY0YWFlNjlmODdhCj4+PiAtLS0gL2Rldi9udWxsCj4+PiArKysgYi9kcml2
ZXJzL3ZkcGEvYWxpYmFiYS9NYWtlZmlsZQo+Pj4gQEAgLTAsMCArMSwzIEBACj4+PiArIyBTUERY
LUxpY2Vuc2UtSWRlbnRpZmllcjogR1BMLTIuMAo+Pj4gK29iai0kKENPTkZJR19BTElCQUJBX0VO
SV9WRFBBKSArPSBlbmlfdmRwYS5vCj4+PiArCj4+PiBkaWZmIC0tZ2l0IGEvZHJpdmVycy92ZHBh
L2FsaWJhYmEvZW5pX3ZkcGEuYyBiL2RyaXZlcnMvdmRwYS9hbGliYWJhL2VuaV92ZHBhLmMKPj4+
IG5ldyBmaWxlIG1vZGUgMTAwNjQ0Cj4+PiBpbmRleCAwMDAwMDAwMDAwMDAuLjZhMDlmMTU3ZDgx
MAo+Pj4gLS0tIC9kZXYvbnVsbAo+Pj4gKysrIGIvZHJpdmVycy92ZHBhL2FsaWJhYmEvZW5pX3Zk
cGEuYwo+Pj4gQEAgLTAsMCArMSw1NTMgQEAKPj4+ICsvLyBTUERYLUxpY2Vuc2UtSWRlbnRpZmll
cjogR1BMLTIuMC1vbmx5Cj4+PiArLyoKPj4+ICsgKiB2RFBBIGJyaWRnZSBkcml2ZXIgZm9yIEFs
aWJhYmEgRU5JKEVsYXN0aWMgTmV0d29yayBJbnRlcmZhY2UpCj4+PiArICoKPj4+ICsgKiBDb3B5
cmlnaHQgKGMpIDIwMjEsIEFsaWJhYmEgSW5jLiBBbGwgcmlnaHRzIHJlc2VydmVkLgo+Pj4gKyAq
IEF1dGhvcjogV3UgWm9uZ3lvbmcgPHd1em9uZ3lvbmdAbGludXguYWxpYmFiYS5jb20+Cj4+PiAr
ICoKPj4+ICsgKi8KPj4+ICsKPj4+ICsjaW5jbHVkZSAibGludXgvYml0cy5oIgo+Pj4gKyNpbmNs
dWRlIDxsaW51eC9pbnRlcnJ1cHQuaD4KPj4+ICsjaW5jbHVkZSA8bGludXgvbW9kdWxlLmg+Cj4+
PiArI2luY2x1ZGUgPGxpbnV4L3BjaS5oPgo+Pj4gKyNpbmNsdWRlIDxsaW51eC92ZHBhLmg+Cj4+
PiArI2luY2x1ZGUgPGxpbnV4L3ZpcnRpby5oPgo+Pj4gKyNpbmNsdWRlIDxsaW51eC92aXJ0aW9f
Y29uZmlnLmg+Cj4+PiArI2luY2x1ZGUgPGxpbnV4L3ZpcnRpb19yaW5nLmg+Cj4+PiArI2luY2x1
ZGUgPGxpbnV4L3ZpcnRpb19wY2kuaD4KPj4+ICsjaW5jbHVkZSA8bGludXgvdmlydGlvX3BjaV9s
ZWdhY3kuaD4KPj4+ICsjaW5jbHVkZSA8dWFwaS9saW51eC92aXJ0aW9fbmV0Lmg+Cj4+PiArCj4+
PiArI2RlZmluZSBFTklfTVNJWF9OQU1FX1NJWkUgMjU2Cj4+PiArCj4+PiArI2RlZmluZSBFTklf
RVJSKHBkZXYsIGZtdCwgLi4uKSAgICAgICAgXAo+Pj4gKyAgICAgICBkZXZfZXJyKCZwZGV2LT5k
ZXYsICIlcyJmbXQsICJlbmlfdmRwYTogIiwgIyNfX1ZBX0FSR1NfXykKPj4+ICsjZGVmaW5lIEVO
SV9EQkcocGRldiwgZm10LCAuLi4pICAgICAgICBcCj4+PiArICAgICAgIGRldl9kYmcoJnBkZXYt
PmRldiwgIiVzImZtdCwgImVuaV92ZHBhOiAiLCAjI19fVkFfQVJHU19fKQo+Pj4gKyNkZWZpbmUg
RU5JX0lORk8ocGRldiwgZm10LCAuLi4pIFwKPj4+ICsgICAgICAgZGV2X2luZm8oJnBkZXYtPmRl
diwgIiVzImZtdCwgImVuaV92ZHBhOiAiLCAjI19fVkFfQVJHU19fKQo+Pj4gKwo+Pj4gK3N0cnVj
dCBlbmlfdnJpbmcgewo+Pj4gKyAgICAgICB2b2lkIF9faW9tZW0gKm5vdGlmeTsKPj4+ICsgICAg
ICAgY2hhciBtc2l4X25hbWVbRU5JX01TSVhfTkFNRV9TSVpFXTsKPj4+ICsgICAgICAgc3RydWN0
IHZkcGFfY2FsbGJhY2sgY2I7Cj4+PiArICAgICAgIGludCBpcnE7Cj4+PiArfTsKPj4+ICsKPj4+
ICtzdHJ1Y3QgZW5pX3ZkcGEgewo+Pj4gKyAgICAgICBzdHJ1Y3QgdmRwYV9kZXZpY2UgdmRwYTsK
Pj4+ICsgICAgICAgc3RydWN0IHZpcnRpb19wY2lfbGVnYWN5X2RldmljZSBsZGV2Owo+Pj4gKyAg
ICAgICBzdHJ1Y3QgZW5pX3ZyaW5nICp2cmluZzsKPj4+ICsgICAgICAgc3RydWN0IHZkcGFfY2Fs
bGJhY2sgY29uZmlnX2NiOwo+Pj4gKyAgICAgICBjaGFyIG1zaXhfbmFtZVtFTklfTVNJWF9OQU1F
X1NJWkVdOwo+Pj4gKyAgICAgICBpbnQgY29uZmlnX2lycTsKPj4+ICsgICAgICAgaW50IHF1ZXVl
czsKPj4+ICsgICAgICAgaW50IHZlY3RvcnM7Cj4+PiArfTsKPj4+ICsKPj4+ICtzdGF0aWMgc3Ry
dWN0IGVuaV92ZHBhICp2ZHBhX3RvX2VuaShzdHJ1Y3QgdmRwYV9kZXZpY2UgKnZkcGEpCj4+PiAr
ewo+Pj4gKyAgICAgICByZXR1cm4gY29udGFpbmVyX29mKHZkcGEsIHN0cnVjdCBlbmlfdmRwYSwg
dmRwYSk7Cj4+PiArfQo+Pj4gKwo+Pj4gK3N0YXRpYyBzdHJ1Y3QgdmlydGlvX3BjaV9sZWdhY3lf
ZGV2aWNlICp2ZHBhX3RvX2xkZXYoc3RydWN0IHZkcGFfZGV2aWNlICp2ZHBhKQo+Pj4gK3sKPj4+
ICsgICAgICAgc3RydWN0IGVuaV92ZHBhICplbmlfdmRwYSA9IHZkcGFfdG9fZW5pKHZkcGEpOwo+
Pj4gKwo+Pj4gKyAgICAgICByZXR1cm4gJmVuaV92ZHBhLT5sZGV2Owo+Pj4gK30KPj4+ICsKPj4+
ICtzdGF0aWMgdTY0IGVuaV92ZHBhX2dldF9mZWF0dXJlcyhzdHJ1Y3QgdmRwYV9kZXZpY2UgKnZk
cGEpCj4+PiArewo+Pj4gKyAgICAgICBzdHJ1Y3QgdmlydGlvX3BjaV9sZWdhY3lfZGV2aWNlICps
ZGV2ID0gdmRwYV90b19sZGV2KHZkcGEpOwo+Pj4gKyAgICAgICB1NjQgZmVhdHVyZXMgPSB2cF9s
ZWdhY3lfZ2V0X2ZlYXR1cmVzKGxkZXYpOwo+Pj4gKwo+Pj4gKyAgICAgICBmZWF0dXJlcyB8PSBC
SVRfVUxMKFZJUlRJT19GX0FDQ0VTU19QTEFURk9STSk7Cj4+PiArICAgICAgIGZlYXR1cmVzIHw9
IEJJVF9VTEwoVklSVElPX0ZfT1JERVJfUExBVEZPUk0pOwo+Pj4gKwo+Pj4gKyAgICAgICByZXR1
cm4gZmVhdHVyZXM7Cj4+PiArfQo+Pj4gKwo+Pj4gK3N0YXRpYyBpbnQgZW5pX3ZkcGFfc2V0X2Zl
YXR1cmVzKHN0cnVjdCB2ZHBhX2RldmljZSAqdmRwYSwgdTY0IGZlYXR1cmVzKQo+Pj4gK3sKPj4+
ICsgICAgICAgc3RydWN0IHZpcnRpb19wY2lfbGVnYWN5X2RldmljZSAqbGRldiA9IHZkcGFfdG9f
bGRldih2ZHBhKTsKPj4+ICsKPj4+ICsgICAgICAgaWYgKCEoZmVhdHVyZXMgJiBCSVRfVUxMKFZJ
UlRJT19ORVRfRl9NUkdfUlhCVUYpKSAmJiBmZWF0dXJlcykgewo+Pj4gKyAgICAgICAgICAgICAg
IEVOSV9FUlIobGRldi0+cGNpX2RldiwKPj4+ICsgICAgICAgICAgICAgICAgICAgICAgICJWSVJU
SU9fTkVUX0ZfTVJHX1JYQlVGIGlzIG5vdCBuZWdvdGlhdGVkXG4iKTsKPj4+ICsgICAgICAgICAg
ICAgICByZXR1cm4gLUVJTlZBTDsKPj4+ICsgICAgICAgfQo+Pj4gKwo+Pj4gKyAgICAgICB2cF9s
ZWdhY3lfc2V0X2ZlYXR1cmVzKGxkZXYsICh1MzIpZmVhdHVyZXMpOwo+Pj4gKwo+Pj4gKyAgICAg
ICByZXR1cm4gMDsKPj4+ICt9Cj4+PiArCj4+IFNvIG15IGNvbW1lbnRzIGhhdmUgbm90IGJlZW4g
YWRkcmVzc2VkIHNpbmNlIHY0LiBQbGVhc2UgYWRkcmVzcyBvcgo+PiBhbnN3ZXIgdGhlIHF1ZXN0
aW9ucyBiZWZvcmUgcG9zdGluZyBhIG5ldyB2ZXJzaW9uLgo+Pgo+PiBUaGFua3MKPiBTb3JyeSwg
SSBmb3Jnb3QgdG8gcmVwbHkgdGhlIGNvbW1lbnRzIG9uIHRoaXMgcGF0Y2guCj4KPgo+Pj4gK3N0
YXRpYyB1NjQgZW5pX3ZkcGFfZ2V0X2ZlYXR1cmVzKHN0cnVjdCB2ZHBhX2RldmljZSAqdmRwYSkK
Pj4+ICt7Cj4+PiArICAgICBzdHJ1Y3QgdmlydGlvX3BjaV9sZWdhY3lfZGV2aWNlICpsZGV2ID0g
dmRwYV90b19sZGV2KHZkcGEpOwo+Pj4gKyAgICAgdTY0IGZlYXR1cmVzID0gdnBfbGVnYWN5X2dl
dF9mZWF0dXJlcyhsZGV2KTsKPj4+ICsKPj4+ICsgICAgIGZlYXR1cmVzIHw9IEJJVF9VTEwoVklS
VElPX0ZfQUNDRVNTX1BMQVRGT1JNKTsKPj4+ICsgICAgIGZlYXR1cmVzIHw9IEJJVF9VTEwoVklS
VElPX0ZfT1JERVJfUExBVEZPUk0pOwo+PiBWRVJTSU9OXzEgaXMgYWxzbyBuZWVkZWQ/Cj4+Cj4g
Tm8sIHF1ZXVlIGFsaWduIG9mIGxlZ2FjeSBkZXZpY2VzIHNob3VsZCBiZSA0MDk2LAoKCkxldCdz
IHVzZSBWSVJUSU9fUENJX1ZSSU5HX0FMSUdOIGluc3RlYWQgb2YgUEFHRV9TSVpFIGluIGdldF92
cV9hbGlnbiAKdGhlbiBzaW5jZSBQQUdFX1NJWkUgaXMgbm90IG5lY2Vzc2FyaWx5IDQwOTYuCgoK
PiAgIGJ1dCBxdWV1ZSBhbGlnbiBvZgo+IGRldmljZXMgd2l0aCBWRVJTSU9OXzEgYXJlIFNNUF9D
QUNIRV9CWVRFUyB3aGljaCBtYXkgbm90IGVxdWFscyB0bwo+IDQwOTYuCj4gSWYgd2Ugc2V0IHRo
ZSBWRVJTSU9OXzEsIEVOSSB3aWxsIG5vdCB3b3JrIGR1ZSB0byB0aGUgcXVldWUgYWxpZ24uCgoK
SW50ZXJlc3RpbmcsIHNvIEkgdGhpbmsgaXQgY2FuIG9ubHkgYmUgdXNlZCB3aXRoIGxlZ2FjeSB2
aXJ0aW8gZHJpdmVycyAKaW4gdGhlIGd1ZXN0LgoKT25lIG1ham9yIGRyYXdiYWNrcyBpcyB0aGF0
IGd1ZXN0IGNhbiBvbmx5IHNlZSAzMiBmZWF0dXJlIGJpdHMgd2hpY2ggCm1lYW5zIHdlIGNhbid0
IGFkdmVydGlzZSBWSVJUSU9fRl9BQ0NFU1NfUExBVEZPUk0gYW5kIApWSVJUSU9fRl9PUkRFUl9Q
TEFURk9STSB0byBndWVzdDoKCi8qIHZpcnRpbyBjb25maWctPmdldF9mZWF0dXJlcygpIGltcGxl
bWVudGF0aW9uICovCnN0YXRpYyB1NjQgdnBfZ2V0X2ZlYXR1cmVzKHN0cnVjdCB2aXJ0aW9fZGV2
aWNlICp2ZGV2KQp7CiDCoMKgwqDCoMKgwqDCoCBzdHJ1Y3QgdmlydGlvX3BjaV9kZXZpY2UgKnZw
X2RldiA9IHRvX3ZwX2RldmljZSh2ZGV2KTsKCiDCoMKgwqDCoMKgwqDCoCAvKiBXaGVuIHNvbWVv
bmUgbmVlZHMgbW9yZSB0aGFuIDMyIGZlYXR1cmUgYml0cywgd2UnbGwgbmVlZCB0bwogwqDCoMKg
wqDCoMKgwqDCoCAqIHN0ZWFsIGEgYml0IHRvIGluZGljYXRlIHRoYXQgdGhlIHJlc3QgYXJlIHNv
bWV3aGVyZSBlbHNlLiAqLwogwqDCoMKgwqDCoMKgwqAgcmV0dXJuIGlvcmVhZDMyKHZwX2Rldi0+
aW9hZGRyICsgVklSVElPX1BDSV9IT1NUX0ZFQVRVUkVTKTsKfQoKRm9yIFZJUlRJT19GX0FDQ0VT
U19QTEFURk9STSwgaXQgc2hvdWxkIGJlIGZpbmUuIEJ1dCBob3cgYWJvdXQgClZJUlRJT19GX09S
REVSX1BMQVRGT1JNPwoKCj4KPj4+ICsKPj4+ICsgICAgIHJldHVybiBmZWF0dXJlczsKPj4+ICt9
Cj4+PiArCj4+PiArc3RhdGljIGludCBlbmlfdmRwYV9zZXRfZmVhdHVyZXMoc3RydWN0IHZkcGFf
ZGV2aWNlICp2ZHBhLCB1NjQgZmVhdHVyZXMpCj4+PiArewo+Pj4gKyAgICAgc3RydWN0IHZpcnRp
b19wY2lfbGVnYWN5X2RldmljZSAqbGRldiA9IHZkcGFfdG9fbGRldih2ZHBhKTsKPj4+ICsKPj4+
ICsgICAgIGlmICghKGZlYXR1cmVzICYgQklUX1VMTChWSVJUSU9fTkVUX0ZfTVJHX1JYQlVGKSkg
JiYgZmVhdHVyZXMpIHsKPj4+ICsgICAgICAgICAgICAgRU5JX0VSUihsZGV2LT5wY2lfZGV2LAo+
Pj4gKyAgICAgICAgICAgICAgICAgICAgICJWSVJUSU9fTkVUX0ZfTVJHX1JYQlVGIGlzIG5vdCBu
ZWdvdGlhdGVkXG4iKTsKPj4+ICsgICAgICAgICAgICAgcmV0dXJuIC1FSU5WQUw7Cj4+IERvIHdl
IG5lZWQgdG8gbWFrZSBzdXJlIEZFQVRVUkVfT0sgaXMgbm90IHNldCBpbiB0aGlzIGNhc2Ugb3Ig
dGhlIEVOSSBjYW4gZG8KPj4gdGhpcyBmb3IgdXM/Cj4gV2h5IHdlIG5lZWQgdG8gY2hlY2sgdGhp
cz8gSSBkb24ndCBnZXQgd2hhdCB5b3Ugd29ycmllZCBhYm91dC4KCgpJIHRob3VnaHQgdGhlIHBs
YW4gaXMgdG8gYWR2ZXJ0aXNlIHRoZSBWRVJTSU9OXzEsIHNvIGZhaWxpbmcgd2hlbiAKd2l0aG91
dCBtcmdfcnhidWYgaXMgYSBtdXN0LiBCdXQgbG9va3MgbGlrZSBJIHdhcyB3cm9uZywgYW5kIHRo
ZXJlJ3Mgbm8gCm5lZWQgdG8gbWFuZGF0ZSBtcmdfcnhidWYgaW4gZnV0dXJlIHZlcnNpb25zLgoK
VGhhbmtzCgoKPgo+PiBPdGhlciBsb29rcyBnb29kLgo+Pgo+PiBUaGFua3MKCl9fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fClZpcnR1YWxpemF0aW9uIG1haWxp
bmcgbGlzdApWaXJ0dWFsaXphdGlvbkBsaXN0cy5saW51eC1mb3VuZGF0aW9uLm9yZwpodHRwczov
L2xpc3RzLmxpbnV4Zm91bmRhdGlvbi5vcmcvbWFpbG1hbi9saXN0aW5mby92aXJ0dWFsaXphdGlv
bg==
