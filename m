Return-Path: <SRS0=LSNt=OE=lists.linux-foundation.org=virtualization-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.0 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D6FE4C433EF
	for <virtualization@archiver.kernel.org>; Tue, 14 Sep 2021 02:50:23 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 7A5DB610F9
	for <virtualization@archiver.kernel.org>; Tue, 14 Sep 2021 02:50:23 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org 7A5DB610F9
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 42E68607BF;
	Tue, 14 Sep 2021 02:50:23 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
	by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id ORJqQmrCsMl4; Tue, 14 Sep 2021 02:50:22 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp3.osuosl.org (Postfix) with ESMTPS id D28F160690;
	Tue, 14 Sep 2021 02:50:21 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id A6158C0011;
	Tue, 14 Sep 2021 02:50:21 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 79F61C000D
 for <virtualization@lists.linux-foundation.org>;
 Tue, 14 Sep 2021 02:50:20 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id 6E85F607B5
 for <virtualization@lists.linux-foundation.org>;
 Tue, 14 Sep 2021 02:50:20 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id PjR9LK4eqFgs
 for <virtualization@lists.linux-foundation.org>;
 Tue, 14 Sep 2021 02:50:19 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.133.124])
 by smtp3.osuosl.org (Postfix) with ESMTPS id A0FEA60690
 for <virtualization@lists.linux-foundation.org>;
 Tue, 14 Sep 2021 02:50:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1631587818;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=5Z4WlMnYOyHOSH+4kEx86uVtPCIPHAH4x7UGSngJSTE=;
 b=LfhJxOBKOo4yXuldRrHIsuu5617fbtj1ceMgGDHFJZaFM4uufqzPsoa/tZJRjcLoqZ9NsX
 WI1vhcdME61fNo3hGX5l/lTB3EHP+9QO2oKxnpt2rAwMYO25pzW756wRF4mg6PEMOIx0Bx
 4/jLKOAr8vU+tv6tp0nKDGhwPD/wBA0=
Received: from mail-pj1-f72.google.com (mail-pj1-f72.google.com
 [209.85.216.72]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-14-nnueGRFuPGCy1ltj0TsDyw-1; Mon, 13 Sep 2021 22:50:17 -0400
X-MC-Unique: nnueGRFuPGCy1ltj0TsDyw-1
Received: by mail-pj1-f72.google.com with SMTP id
 s13-20020a17090a760d00b001996da9681dso1239191pjk.9
 for <virtualization@lists.linux-foundation.org>;
 Mon, 13 Sep 2021 19:50:17 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-transfer-encoding
 :content-language;
 bh=5Z4WlMnYOyHOSH+4kEx86uVtPCIPHAH4x7UGSngJSTE=;
 b=BUJXlx4BUehxcPl9WiNOtUYYuuS0PdL0Ch5KEWF7WN50QoZfffXEBXwqceaeydTljk
 6HPdstHMGKnmm54Al5z3zsShQ91kpNrhk4pt4mOBg1l1CUfofkaY1T8ZFoeC18a4vpoH
 oRlXtLY4lwR95TMQNcY0lwikCvuOlOnpzCZBdl/yKhDP0p7sEScRwO8XmSLanoBfCCPo
 O57VaOP31zCcv8QId8X2gcKCjmbvA/ZX0GJ4QkPB0sMVIgu14dhlQbfHguV6DIPNIy3p
 PFHa48fRXaxkaqos4Hgka5K8qzXfu1jb1PoryMDqUjRi+rPm6LcC3kq4SB28Z6JdFcSW
 9seQ==
X-Gm-Message-State: AOAM530rVdHgq9KEWtRIDTQ+vvEBCriH6DP8ZfsXT/aGt9oPXjmJE8pa
 H3zRuO4ufyQEacos22+Elp4e7YzBbeMvHRkIYc8juMTwZLfmND5EEYBMtYWqaCl16pzjlvzzZ/l
 8dQj061HTo/DRH1eD4Tk3WPQ3wsqT0AZGMYgAjNa6pQ==
X-Received: by 2002:a17:90b:4b4b:: with SMTP id
 mi11mr2950166pjb.41.1631587815899; 
 Mon, 13 Sep 2021 19:50:15 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJwaZk3eUn5jFr9FI6lgplmOjTDOf4oWYe0qRP9KxwgXpc8j2j/7kSjDP/1mlEOCALECN1KCfQ==
X-Received: by 2002:a17:90b:4b4b:: with SMTP id
 mi11mr2950140pjb.41.1631587815526; 
 Mon, 13 Sep 2021 19:50:15 -0700 (PDT)
Received: from wangxiaodeMacBook-Air.local ([209.132.188.80])
 by smtp.gmail.com with ESMTPSA id v17sm8091760pff.6.2021.09.13.19.50.11
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 13 Sep 2021 19:50:15 -0700 (PDT)
Subject: Re: [PATCH 7/9] virtio-pci: harden INTX interrupts
To: Thomas Gleixner <tglx@linutronix.de>, mst@redhat.com
References: <20210913055353.35219-1-jasowang@redhat.com>
 <20210913055353.35219-8-jasowang@redhat.com> <875yv4f99j.ffs@tglx>
From: Jason Wang <jasowang@redhat.com>
Message-ID: <dae944d8-a658-cb52-2c4b-076c6a41c458@redhat.com>
Date: Tue, 14 Sep 2021 10:50:06 +0800
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:78.0)
 Gecko/20100101 Thunderbird/78.14.0
MIME-Version: 1.0
In-Reply-To: <875yv4f99j.ffs@tglx>
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=jasowang@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Language: en-US
Cc: "Paul E. McKenney" <paulmck@kernel.org>, david.kaplan@amd.com,
 konrad.wilk@oracle.com, Peter Zijlstra <peterz@infradead.org>,
 Boqun Feng <boqun.feng@gmail.com>, f.hetzelt@tu-berlin.de,
 linux-kernel@vger.kernel.org, virtualization@lists.linux-foundation.org,
 Will Deacon <will@kernel.org>
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

CtTaIDIwMjEvOS8xNCDJz87nNTozNiwgVGhvbWFzIEdsZWl4bmVyINC0tcA6Cj4gSmFzb24sCj4K
PiBPbiBNb24sIFNlcCAxMyAyMDIxIGF0IDEzOjUzLCBKYXNvbiBXYW5nIHdyb3RlOgo+PiBUaGlz
IHBhdGNoIHRyaWVzIHRvIG1ha2Ugc3VyZSB0aGUgdmlydGlvIGludGVycnVwdCBoYW5kbGVyIGZv
ciBJTlRYCj4+IHdvbid0IGJlIGNhbGxlZCBhZnRlciBhIHJlc2V0IGFuZCBiZWZvcmUgdmlydGlv
X2RldmljZV9yZWFkeSgpLiBXZQo+PiBjYW4ndCB1c2UgSVJRRl9OT19BVVRPRU4gc2luY2Ugd2Un
cmUgdXNpbmcgc2hhcmVkIGludGVycnVwdAo+PiAoSVJRRl9TSEFSRUQpLiBTbyB0aGlzIHBhdGNo
IHRyYWNrcyB0aGUgSU5UWCBlbmFibGluZyBzdGF0dXMgaW4gYSBuZXcKPj4gaW50eF9zb2Z0X2Vu
YWJsZWQgdmFyaWFibGUgYW5kIHRvZ2dsZSBpdCBkdXJpbmcgaW4KPj4gdnBfZGlzYWJsZS9lbmFi
bGVfdmVjdG9ycygpLiBUaGUgSU5UWCBpbnRlcnJ1cHQgaGFuZGxlciB3aWxsIGNoZWNrCj4+IGlu
dHhfc29mdF9lbmFibGVkIGJlZm9yZSBwcm9jZXNzaW5nIHRoZSBhY3R1YWwgaW50ZXJydXB0Lgo+
IEFoLCB0aGVyZSBpdCBpcyA6KQo+Cj4gQ2MnZWQgb3VyIG1lbW9yeSBvcmRlcmluZyB3aXphcmRz
IGFzIEkgbWlnaHQgYmUgd3JvbmcgYXMgdXN1YWwuCj4KPj4gLQlpZiAodnBfZGV2LT5pbnR4X2Vu
YWJsZWQpCj4+ICsJaWYgKHZwX2Rldi0+aW50eF9lbmFibGVkKSB7Cj4+ICsJCXZwX2Rldi0+aW50
eF9zb2Z0X2VuYWJsZWQgPSBmYWxzZTsKPj4gKwkJLyogZW5zdXJlIHRoZSB2cF9pbnRlcnJ1cHQg
c2VlIHRoaXMgaW50eF9zb2Z0X2VuYWJsZWQgdmFsdWUgKi8KPj4gKwkJc21wX3dtYigpOwo+PiAg
IAkJc3luY2hyb25pemVfaXJxKHZwX2Rldi0+cGNpX2Rldi0+aXJxKTsKPiBBcyB5b3UgYXJlIHN5
bmNocm9uaXppbmcgdGhlIGludGVycnVwdCBoZXJlIGFueXdheSwgd2hhdCBpcyB0aGUgdmFsdWUg
b2YKPiB0aGUgYmFycmllcj8KPgo+ICAgCQl2cF9kZXYtPmludHhfc29mdF9lbmFibGVkID0gZmFs
c2U7Cj4gICAgCQlzeW5jaHJvbml6ZV9pcnEodnBfZGV2LT5wY2lfZGV2LT5pcnEpOwo+Cj4gaXMg
c3VmZmljaWVudCBiZWNhdXNlIG9mOgo+Cj4gc3luY2hyb25pemVfaXJxKCkKPiAgICAgZG8gewo+
ICAgICAJcmF3X3NwaW5fbG9jayhkZXNjLT5sb2NrKTsKPiAgICAgICAgICBpbl9wcm9ncmVzcyA9
IGNoZWNrX2lucHJvZ3Jlc3MoZGVzYyk7Cj4gICAgIAlyYXdfc3Bpbl91bmxvY2soZGVzYy0+bG9j
ayk7Cj4gICAgIH0gd2hpbGUgKGluX3Byb2dyZXNzKTsKPgo+IHJhd19zcGluX2xvY2soKSBoYXMg
QUNRVUlSRSBzZW1hbnRpY3Mgc28gdGhlIHN0b3JlIHRvIGludHhfc29mdF9lbmFibGVkCj4gY2Fu
IGNvbXBsZXRlIGFmdGVyIGxvY2sgaGFzIGJlZW4gYWNxdWlyZWQgd2hpY2ggaXMgdW5pbnRlcmVz
dGluZy4KPgo+IHJhd19zcGluX3VubG9jaygpIGhhcyBSRUxFQVNFIHNlbWFudGljcyBzbyB0aGUg
c3RvcmUgdG8gaW50eF9zb2Z0X2VuYWJsZWQKPiBoYXMgdG8gYmUgY29tcGxldGVkIGJlZm9yZSB0
aGUgdW5sb2NrIGNvbXBsZXRlcy4KPgo+IFNvIGlmIHRoZSBpbnRlcnJ1cHQgaXMgb24gdGhlIGZs
aWdodCB0aGVuIGl0IG1pZ2h0IG9yIG1pZ2h0IG5vdCBzZWUKPiBpbnR4X3NvZnRfZW5hYmxlZCA9
PSBmYWxzZS4gQnV0IHRoYXQncyB0cnVlIGZvciB5b3VyIGJhcnJpZXIgY29uc3RydWN0Cj4gYXMg
d2VsbC4KPgo+IFRoZSBpbXBvcnRhbnQgcGFydCBpcyB0aGF0IGFueSBpbnRlcnJ1cHQgZm9yIHRo
aXMgbGluZSBhcnJpdmluZyBhZnRlcgo+IHN5bmNocm9uaXplX2lycSgpIGhhcyBjb21wbGV0ZWQg
aXMgZ3VhcmFudGVlZCB0byBzZWUgaW50eF9zb2Z0X2VuYWJsZWQKPiA9PSBmYWxzZS4KPgo+IFRo
YXQgaXMgd2hhdCB5b3Ugd2FudCB0byBhY2hpZXZlLCByaWdodD8KCgpSaWdodC4KCgo+Cj4+ICAg
CWZvciAoaSA9IDA7IGkgPCB2cF9kZXYtPm1zaXhfdmVjdG9yczsgKytpKQo+PiAgIAkJZGlzYWJs
ZV9pcnEocGNpX2lycV92ZWN0b3IodnBfZGV2LT5wY2lfZGV2LCBpKSk7Cj4+IEBAIC00Myw4ICs0
NywxMiBAQCB2b2lkIHZwX2VuYWJsZV92ZWN0b3JzKHN0cnVjdCB2aXJ0aW9fZGV2aWNlICp2ZGV2
KQo+PiAgIAlzdHJ1Y3QgdmlydGlvX3BjaV9kZXZpY2UgKnZwX2RldiA9IHRvX3ZwX2RldmljZSh2
ZGV2KTsKPj4gICAJaW50IGk7Cj4+ICAgCj4+IC0JaWYgKHZwX2Rldi0+aW50eF9lbmFibGVkKQo+
PiArCWlmICh2cF9kZXYtPmludHhfZW5hYmxlZCkgewo+PiArCQl2cF9kZXYtPmludHhfc29mdF9l
bmFibGVkID0gdHJ1ZTsKPj4gKwkJLyogZW5zdXJlIHRoZSB2cF9pbnRlcnJ1cHQgc2VlIHRoaXMg
aW50eF9zb2Z0X2VuYWJsZWQgdmFsdWUgKi8KPj4gKwkJc21wX3dtYigpOwo+IEZvciB0aGUgZW5h
YmxlIGNhc2UgdGhlIGJhcnJpZXIgaXMgcG9pbnRsZXNzIHZzLiBpbnR4X3NvZnRfZW5hYmxlZAo+
Cj4gQ1BVIDAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgQ1BVIDEK
Pgo+IGludGVycnVwdCAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgIHZwX2Vu
YWJsZV92ZWN0b3JzKCkKPiAgICB2cF9pbnRlcnJ1cHQoKQo+ICAgICAgaWYgKCF2cF9kZXYtPmlu
dHhfc29mdF9lbmFibGVkKQo+ICAgICAgICAgcmV0dXJuIElSUV9OT05FOwo+ICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgIHZwX2Rldi0+aW50eF9zb2Z0
X2VuYWJsZWQgPSB0cnVlOwo+Cj4gSU9XLCB0aGUgY29uY3VycmVudCBpbnRlcnJ1cHQgbWlnaHQg
b3IgbWlnaHQgbm90IHNlZSB0aGUgc3RvcmUuIFRoYXQncwo+IG5vdCBhIHByb2JsZW0gZm9yIGxl
Z2FjeSBQQ0kgaW50ZXJydXB0cy4gSWYgaXQgZGlkIG5vdCBzZWUgdGhlIHN0b3JlIGFuZAo+IHRo
ZSBpbnRlcnJ1cHQgb3JpZ2luYXRlZCBmcm9tIHRoYXQgZGV2aWNlIHRoZW4gaXQgd2lsbCBhY2Nv
dW50IGl0IGFzIG9uZQo+IHNwdXJpb3VzIGludGVycnVwdCB3aGljaCB3aWxsIGdldCByYWlzZWQg
YWdhaW4gYmVjYXVzZSB0aG9zZSBpbnRlcnJ1cHRzCj4gYXJlIGxldmVsIHRyaWdnZXJlZCBhbmQg
bm90aGluZyBhY2tub3dsZWRnZWQgaXQgYXQgdGhlIGRldmljZSBsZXZlbC4KCgpJIHNlZS4KCgo+
Cj4gTm93LCB3aGF0J3MgbW9yZSBpbnRlcmVzdGluZyBpcyB0aGF0IGlzIGhhcyB0byBiZSBndWFy
YW50ZWVkIHRoYXQgdGhlCj4gaW50ZXJydXB0IHdoaWNoIG9ic2VydmVzCj4KPiAgICAgICAgICB2
cF9kZXYtPmludHhfc29mdF9lbmFibGVkID09IHRydWUKPgo+IGFsc28gb2JzZXJ2ZXMgYWxsIHBy
ZWNlZWRpbmcgc3RvcmVzLCBpLmUuIHRob3NlIHdoaWNoIG1ha2UgdGhlIGludGVycnVwdAo+IGhh
bmRsZXIgY2FwYWJsZSBvZiBoYW5kbGluZyB0aGUgaW50ZXJydXB0Lgo+Cj4gVGhhdCdzIHRoZSBy
ZWFsIHByb2JsZW0gYW5kIGZvciB0aGF0IHlvdXIgYmFycmllciBpcyBhdCB0aGUgd3JvbmcgcGxh
Y2UKPiBiZWNhdXNlIHlvdSB3YW50IHRvIG1ha2Ugc3VyZSB0aGF0IHRob3NlIHN0b3JlcyBhcmUg
dmlzaWJsZSBiZWZvcmUgdGhlCj4gc3RvcmUgdG8gaW50eF9zb2Z0X2VuYWJsZWQgYmVjb21lcyB2
aXNpYmxlLCBpLmUuIHRoaXMgc2hvdWxkIGJlOgo+Cj4KPiAgICAgICAgICAvKiBFbnN1cmUgdGhh
dCBhbGwgcHJlY2VlZGluZyBzdG9yZXMgYXJlIHZpc2libGUgYmVmb3JlIGludHhfc29mdF9lbmFi
bGVkICovCj4gCXNtcF93bWIoKTsKPiAJdnBfZGV2LT5pbnR4X3NvZnRfZW5hYmxlZCA9IHRydWU7
CgoKWWVzLCBJIHNlZS4KCgo+Cj4gTm93IE1pY2hlYWwgaXMgbm90IHJlYWxseSBlbnRodXNpYXRp
YyBhYm91dCB0aGUgYmFycmllciBpbiB0aGUgaW50ZXJydXB0Cj4gaGFuZGxlciBob3RwYXRoLCB3
aGljaCBpcyB1bmRlcnN0YW5kYWJsZS4KPgo+IEFzIHRoZSBkZXZpY2Ugc3RhcnR1cCBpcyBub3Qg
cmVhbGx5IGhhcHBlbmluZyBvZnRlbiBpdCdzIHNlbnNpYmxlIHRvIGRvCj4gdGhlIGZvbGxvd2lu
Zwo+Cj4gICAgICAgICAgZGlzYWJsZV9pcnEoKTsKPiAgICAgICAgICB2cF9kZXYtPmludHhfc29m
dF9lbmFibGVkID0gdHJ1ZTsKPiAgICAgICAgICBlbmFibGVfaXJxKCk7Cj4KPiBiZWNhdXNlOgo+
Cj4gICAgICAgICAgZGlzYWJsZV9pcnEoKQo+ICAgICAgICAgICAgc3luY2hyb25pemVfaXJxKCkK
Pgo+IGFjdHMgYXMgYSBiYXJyaWVyIGZvciB0aGUgcHJlY2VlZGluZyBzdG9yZXM6Cj4KPiAgICAg
ICAgICBkaXNhYmxlX2lycSgpCj4gICAgIAkgIHJhd19zcGluX2xvY2soZGVzYy0+bG9jayk7Cj4g
ICAgICAgICAgICBfX2Rpc2FibGVfaXJxKGRlc2MpOwo+ICAgICAJICByYXdfc3Bpbl91bmxvY2so
ZGVzYy0+bG9jayk7Cj4KPiAgICAgICAgICAgIHN5bmNocm9uaXplX2lycSgpCj4gICAgICAgICAg
ICAgIGRvIHsKPiAgICAgCSAgICAgIHJhd19zcGluX2xvY2soZGVzYy0+bG9jayk7Cj4gICAgICAg
ICAgICAgICAgaW5fcHJvZ3Jlc3MgPSBjaGVja19pbnByb2dyZXNzKGRlc2MpOwo+ICAgICAJICAg
ICAgcmF3X3NwaW5fdW5sb2NrKGRlc2MtPmxvY2spOwo+ICAgICAgICAgICAgICB9IHdoaWxlIChp
bl9wcm9ncmVzcyk7Cj4KPiAgICAgICAgICBpbnR4X3NvZnRfZW5hYmxlZCA9IHRydWU7Cj4KPiAg
ICAgICAgICBlbmFibGVfaXJxKCk7Cj4KPiBJbiB0aGlzIGNhc2Ugc3luY2hyb25pemVfaXJxKCkg
cHJldmVudHMgdGhlIHN1YnNlcXVlbnQgc3RvcmUgdG8KPiBpbnR4X3NvZnRfZW5hYmxlZCB0byBs
ZWFrIGludG8gdGhlIF9fZGlzYWJsZV9pcnEoZGVzYykgc2VjdGlvbiB3aGljaCBpbgo+IHR1cm4g
bWFrZXMgaXQgaW1wb3NzaWJsZSBmb3IgYW4gaW50ZXJydXB0IGhhbmRsZXIgdG8gb2JzZXJ2ZQo+
IGludHhfc29mdF9lbmFibGVkID09IHRydWUgYmVmb3JlIHRoZSBwcmVyZXF1aXNpdGVzIHdoaWNo
IHByZWNlZWQgdGhlCj4gY2FsbCB0byBkaXNhYmxlX2lycSgpIGFyZSB2aXNpYmxlLgo+Cj4gT2Yg
Y291cnNlIHRoZSBtZW1vcnkgb3JkZXJpbmcgd2l6YXJkcyBtaWdodCBkaXNhZ3JlZSwgYnV0IGlm
IHRoZXkgZG8sCj4gdGhlbiB3ZSBoYXZlIGEgbWFzc2l2ZSBjaGFzZSBvZiBvcmRlcmluZyBwcm9i
bGVtcyB2cy4gc2ltaWxhciBjb25zdHJ1Y3RzCj4gYWxsIG92ZXIgdGhlIHRyZWUgYWhlYWQgb2Yg
dXMuCj4KPiAgRnJvbSB0aGUgaW50ZXJydXB0IHBlcnNwZWN0aXZlIHRoZSBzZXF1ZW5jZToKPgo+
ICAgICAgICAgIGRpc2FibGVfaXJxKCk7Cj4gICAgICAgICAgdnBfZGV2LT5pbnR4X3NvZnRfZW5h
YmxlZCA9IHRydWU7Cj4gICAgICAgICAgZW5hYmxlX2lycSgpOwo+Cj4gaXMgcGVyZmVjdGx5IGZp
bmUgYXMgd2VsbC4gQW55IGludGVycnVwdCBhcnJpdmluZyBkdXJpbmcgdGhlIGRpc2FibGVkCj4g
c2VjdGlvbiB3aWxsIGJlIHJlcmFpc2VkIG9uIGVuYWJsZV9pcnEoKSBpbiBoYXJkd2FyZSBiZWNh
dXNlIGl0J3MgYQo+IGxldmVsIGludGVycnVwdC4gQW55IHJlc3VsdGluZyBmYWlsdXJlIGlzIGVp
dGhlciBhIGhhcmR3YXJlIG9yIGEKPiBoeXBlcnZpc29yIGJ1Zy4KCgpUaGFua3MgYSBsb3QgZm9y
IHRoZSBkZXRhaWwgY2xhcmlmaWNhdGlvbnMuIFdpbGwgc3dpdGNoIHRvIHVzZSAKZGlzYWJsZV9p
cnEoKS9lbmFibGVfaXJxKCkgaWYgbm8gb2JqZWN0aW9uIGZyb20gbWVtb3J5IG9yZGVyaW5nIHdp
emFyZHMuCgoKPgo+IFRoYW5rcywKPgo+ICAgICAgICAgIHRnbHgKPgoKX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18KVmlydHVhbGl6YXRpb24gbWFpbGluZyBs
aXN0ClZpcnR1YWxpemF0aW9uQGxpc3RzLmxpbnV4LWZvdW5kYXRpb24ub3JnCmh0dHBzOi8vbGlz
dHMubGludXhmb3VuZGF0aW9uLm9yZy9tYWlsbWFuL2xpc3RpbmZvL3ZpcnR1YWxpemF0aW9u
