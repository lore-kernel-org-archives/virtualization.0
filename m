Return-Path: <SRS0=IhT0=PV=lists.linux-foundation.org=virtualization-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C8681C433EF
	for <virtualization@archiver.kernel.org>; Tue,  2 Nov 2021 07:55:07 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 7AA8060E74
	for <virtualization@archiver.kernel.org>; Tue,  2 Nov 2021 07:55:07 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org 7AA8060E74
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by smtp2.osuosl.org (Postfix) with ESMTP id 2CA9E40132;
	Tue,  2 Nov 2021 07:55:07 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
	by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id H7smrfI1_5KH; Tue,  2 Nov 2021 07:55:06 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp2.osuosl.org (Postfix) with ESMTPS id 8685E400C7;
	Tue,  2 Nov 2021 07:55:05 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 5B05FC0012;
	Tue,  2 Nov 2021 07:55:05 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [IPv6:2605:bc80:3010::133])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 1DBB6C000E
 for <virtualization@lists.linux-foundation.org>;
 Tue,  2 Nov 2021 07:55:04 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id 0399B400E5
 for <virtualization@lists.linux-foundation.org>;
 Tue,  2 Nov 2021 07:55:04 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id 806jAnIvnOib
 for <virtualization@lists.linux-foundation.org>;
 Tue,  2 Nov 2021 07:55:02 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [216.205.24.124])
 by smtp2.osuosl.org (Postfix) with ESMTPS id 8E23F400C7
 for <virtualization@lists.linux-foundation.org>;
 Tue,  2 Nov 2021 07:55:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1635839701;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=5dlWu44/wY/7R1GeV/yrdXYNnB699JZ1xCGL0sCgZIY=;
 b=eR+m8lHLU6wJQAr2KTyswsIGXkZYDn0wpgjT18echQWXZA2iEAhCVkzINK2pPhW0+uZLBG
 cngexBSELWMvh3zJYfQ5kXIqKovU0bxCEKs70GP/gGjkWg5G59N1jJ3w994MZEwkGFP7Y1
 e9ETLeN2hxo4mxbiVmE/LsRBO73fjk0=
Received: from mail-pl1-f199.google.com (mail-pl1-f199.google.com
 [209.85.214.199]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-261-WpNN_HG9NESEM9BhzTT3pQ-1; Tue, 02 Nov 2021 03:55:00 -0400
X-MC-Unique: WpNN_HG9NESEM9BhzTT3pQ-1
Received: by mail-pl1-f199.google.com with SMTP id
 n9-20020a170902968900b0013f23b51142so7485269plp.8
 for <virtualization@lists.linux-foundation.org>;
 Tue, 02 Nov 2021 00:55:00 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-transfer-encoding
 :content-language;
 bh=5dlWu44/wY/7R1GeV/yrdXYNnB699JZ1xCGL0sCgZIY=;
 b=7Pme59DEk7XZwCj2sFK+PgsZcn8TlKQcc5b1OEgVcMS2KHPdYfy/LDwoqXJAFN0kkh
 4zDH+3mABkxVS5iB1PRaMlAw3L+nYaRsnQCPul3ZxcxtZV2rqGHEqwLKfcM/IBlTydfE
 lx69eH4Pt7vZL8hbQpjbsJ7jePQsujUXN7uQaM8b2x/ByXvYBzjPRq7BWTtUUeV6hk9l
 G/o4efth+cqBBKDASC0I39y5EYrTlCNpjjPZfF76S+H7ALa6SysvMsaSk7MCROvxjNfF
 Y/Kke/zCdPcYlx/nsOnjf+aAEjO+yRhJbIp87q2Lo/ZtQHg/MuQ/32rF/jyBFXfvorGg
 VBBA==
X-Gm-Message-State: AOAM533+BfSCXjIV5vz22jJVxMhGzQC9HDLnCgiKohnqDp0nlJIVm2op
 3aoCsxVlUyS9SiLdNcJ5fA1pdMuyV73l7jbiQU5LeJ9TflVLlfzb5Ks6sdRQWPnFk+ZaSYjbAXz
 7IddkPX8ol6cQ9hQbSwDB2qyw3tLCPmCax6nZ5m2oak8H7uvyo703bHNjkPletaygirq6FYbiAv
 E1LLHftWnqZH3MHrDnqA==
X-Received: by 2002:a17:903:11cc:b0:13f:ecf7:22c7 with SMTP id
 q12-20020a17090311cc00b0013fecf722c7mr29823489plh.5.1635839698830; 
 Tue, 02 Nov 2021 00:54:58 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJxjHFb0sYWJHLAh7vaXNdPQn3vAoW8ioepjvOCX7WyMnSqbu8OV+ZwDymvzWRt6CoM8wdWJLw==
X-Received: by 2002:a17:903:11cc:b0:13f:ecf7:22c7 with SMTP id
 q12-20020a17090311cc00b0013fecf722c7mr29823445plh.5.1635839698454; 
 Tue, 02 Nov 2021 00:54:58 -0700 (PDT)
Received: from wangxiaodeMacBook-Air.local ([209.132.188.80])
 by smtp.gmail.com with ESMTPSA id o22sm19355137pfu.50.2021.11.02.00.54.52
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 02 Nov 2021 00:54:58 -0700 (PDT)
Subject: Re: [RFC PATCH v5 11/26] vhost: Handle host notifiers in SVQ
To: =?UTF-8?Q?Eugenio_P=c3=a9rez?= <eperezma@redhat.com>, qemu-devel@nongnu.org
References: <20211029183525.1776416-1-eperezma@redhat.com>
 <20211029183525.1776416-12-eperezma@redhat.com>
From: Jason Wang <jasowang@redhat.com>
Message-ID: <74dbf70f-96a7-6fe3-dbc5-28a7b7989109@redhat.com>
Date: Tue, 2 Nov 2021 15:54:49 +0800
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:78.0)
 Gecko/20100101 Thunderbird/78.14.0
MIME-Version: 1.0
In-Reply-To: <20211029183525.1776416-12-eperezma@redhat.com>
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=jasowang@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Language: en-US
Cc: Laurent Vivier <lvivier@redhat.com>, Parav Pandit <parav@mellanox.com>,
 "Michael S. Tsirkin" <mst@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Stefan Hajnoczi <stefanha@redhat.com>, Markus Armbruster <armbru@redhat.com>,
 Harpreet Singh Anand <hanand@xilinx.com>, Xiao W Wang <xiao.w.wang@intel.com>,
 Eli Cohen <eli@mellanox.com>, Paolo Bonzini <pbonzini@redhat.com>,
 Eric Blake <eblake@redhat.com>, virtualization@lists.linux-foundation.org,
 Eduardo Habkost <ehabkost@redhat.com>
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

CuWcqCAyMDIxLzEwLzMwIOS4iuWNiDI6MzUsIEV1Z2VuaW8gUMOpcmV6IOWGmemBkzoKPiBJZiBk
ZXZpY2Ugc3VwcG9ydHMgaG9zdCBub3RpZmllcnMsIHRoaXMgbWFrZXMgb25lIGp1bXAgbGVzcyAo
a2VybmVsKSB0bwo+IGRlbGl2ZXIgU1ZRIG5vdGlmaWNhdGlvbnMgdG8gaXQuCj4KPiBTaWduZWQt
b2ZmLWJ5OiBFdWdlbmlvIFDDqXJleiA8ZXBlcmV6bWFAcmVkaGF0LmNvbT4KPiAtLS0KPiAgIGh3
L3ZpcnRpby92aG9zdC1zaGFkb3ctdmlydHF1ZXVlLmggfCAgMiArKwo+ICAgaHcvdmlydGlvL3Zo
b3N0LXNoYWRvdy12aXJ0cXVldWUuYyB8IDIzICsrKysrKysrKysrKysrKysrKysrKystCj4gICAy
IGZpbGVzIGNoYW5nZWQsIDI0IGluc2VydGlvbnMoKyksIDEgZGVsZXRpb24oLSkKPgo+IGRpZmYg
LS1naXQgYS9ody92aXJ0aW8vdmhvc3Qtc2hhZG93LXZpcnRxdWV1ZS5oIGIvaHcvdmlydGlvL3Zo
b3N0LXNoYWRvdy12aXJ0cXVldWUuaAo+IGluZGV4IDMwYWI5NjQzYjkuLmViMGE1NGY5NTQgMTAw
NjQ0Cj4gLS0tIGEvaHcvdmlydGlvL3Zob3N0LXNoYWRvdy12aXJ0cXVldWUuaAo+ICsrKyBiL2h3
L3ZpcnRpby92aG9zdC1zaGFkb3ctdmlydHF1ZXVlLmgKPiBAQCAtMTgsNiArMTgsOCBAQCB0eXBl
ZGVmIHN0cnVjdCBWaG9zdFNoYWRvd1ZpcnRxdWV1ZSBWaG9zdFNoYWRvd1ZpcnRxdWV1ZTsKPiAg
IHZvaWQgdmhvc3Rfc3ZxX3NldF9zdnFfa2lja19mZChWaG9zdFNoYWRvd1ZpcnRxdWV1ZSAqc3Zx
LCBpbnQgc3ZxX2tpY2tfZmQpOwo+ICAgY29uc3QgRXZlbnROb3RpZmllciAqdmhvc3Rfc3ZxX2dl
dF9kZXZfa2lja19ub3RpZmllcigKPiAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICBjb25zdCBWaG9zdFNoYWRvd1ZpcnRxdWV1ZSAqc3ZxKTsKPiArdm9pZCB2
aG9zdF9zdnFfc2V0X2hvc3RfbXJfbm90aWZpZXIoVmhvc3RTaGFkb3dWaXJ0cXVldWUgKnN2cSwg
dm9pZCAqYWRkcik7Cj4gKwo+ICAgdm9pZCB2aG9zdF9zdnFfc3RhcnQoc3RydWN0IHZob3N0X2Rl
diAqZGV2LCB1bnNpZ25lZCBpZHgsCj4gICAgICAgICAgICAgICAgICAgICAgICBWaG9zdFNoYWRv
d1ZpcnRxdWV1ZSAqc3ZxLCBpbnQgc3ZxX2tpY2tfZmQpOwo+ICAgdm9pZCB2aG9zdF9zdnFfc3Rv
cChzdHJ1Y3Qgdmhvc3RfZGV2ICpkZXYsIHVuc2lnbmVkIGlkeCwKPiBkaWZmIC0tZ2l0IGEvaHcv
dmlydGlvL3Zob3N0LXNoYWRvdy12aXJ0cXVldWUuYyBiL2h3L3ZpcnRpby92aG9zdC1zaGFkb3ct
dmlydHF1ZXVlLmMKPiBpbmRleCBmZGE2MGQxMWRiLi5lM2RjYzAzOWI2IDEwMDY0NAo+IC0tLSBh
L2h3L3ZpcnRpby92aG9zdC1zaGFkb3ctdmlydHF1ZXVlLmMKPiArKysgYi9ody92aXJ0aW8vdmhv
c3Qtc2hhZG93LXZpcnRxdWV1ZS5jCj4gQEAgLTI5LDYgKzI5LDEyIEBAIHR5cGVkZWYgc3RydWN0
IFZob3N0U2hhZG93VmlydHF1ZXVlIHsKPiAgICAgICAgKiBTbyBzaGFkb3cgdmlydHF1ZXVlIG11
c3Qgbm90IGNsZWFuIGl0LCBvciB3ZSB3b3VsZCBsb3NlIFZpcnRRdWV1ZSBvbmUuCj4gICAgICAg
ICovCj4gICAgICAgRXZlbnROb3RpZmllciBzdnFfa2ljazsKPiArCj4gKyAgICAvKiBEZXZpY2Un
cyBob3N0IG5vdGlmaWVyIG1lbW9yeSByZWdpb24uIE5VTEwgbWVhbnMgbm8gcmVnaW9uICovCj4g
KyAgICB2b2lkICpob3N0X25vdGlmaWVyX21yOwo+ICsKPiArICAgIC8qIFZpcnRpbyBxdWV1ZSBz
aGFkb3dpbmcgKi8KPiArICAgIFZpcnRRdWV1ZSAqdnE7Cj4gICB9IFZob3N0U2hhZG93VmlydHF1
ZXVlOwo+ICAgCj4gICAvKioKPiBAQCAtNTAsNyArNTYsMjAgQEAgc3RhdGljIHZvaWQgdmhvc3Rf
aGFuZGxlX2d1ZXN0X2tpY2soRXZlbnROb3RpZmllciAqbikKPiAgICAgICAgICAgcmV0dXJuOwo+
ICAgICAgIH0KPiAgIAo+IC0gICAgZXZlbnRfbm90aWZpZXJfc2V0KCZzdnEtPmhkZXZfa2ljayk7
Cj4gKyAgICBpZiAoc3ZxLT5ob3N0X25vdGlmaWVyX21yKSB7Cj4gKyAgICAgICAgdWludDE2X3Qg
Km1yID0gc3ZxLT5ob3N0X25vdGlmaWVyX21yOwo+ICsgICAgICAgICptciA9IHZpcnRpb19nZXRf
cXVldWVfaW5kZXgoc3ZxLT52cSk7CgoKRG8gd2UgbmVlZCBiYXJyaWVycyBhcm91bmQgdGhlIHBv
c3NpYmxlIE1NSU8gaGVyZT8KClRvIGF2b2lkIHRob3NlIGNvbXBsaWNhdGVkIHN0dWZmLCBJJ2Qg
cmF0aGVyIHNpbXBseSBnbyB3aXRoIGV2ZW50ZmQgcGF0aC4KCk5vdGUgbW1pbyBhbmQgZXZlbnRm
ZCBhcmUgbm90IG11dHVhbGx5IGV4Y2x1c2l2ZS4KClRoYW5rcwoKCj4gKyAgICB9IGVsc2Ugewo+
ICsgICAgICAgIGV2ZW50X25vdGlmaWVyX3NldCgmc3ZxLT5oZGV2X2tpY2spOwo+ICsgICAgfQo+
ICt9Cj4gKwo+ICsvKgo+ICsgKiBTZXQgdGhlIGRldmljZSdzIG1lbW9yeSByZWdpb24gbm90aWZp
ZXIuIGFkZHIgPSBOVUxMIGNsZWFyIGl0Lgo+ICsgKi8KPiArdm9pZCB2aG9zdF9zdnFfc2V0X2hv
c3RfbXJfbm90aWZpZXIoVmhvc3RTaGFkb3dWaXJ0cXVldWUgKnN2cSwgdm9pZCAqYWRkcikKPiAr
ewo+ICsgICAgc3ZxLT5ob3N0X25vdGlmaWVyX21yID0gYWRkcjsKPiAgIH0KPiAgIAo+ICAgLyoq
Cj4gQEAgLTEzNCw2ICsxNTMsNyBAQCB2b2lkIHZob3N0X3N2cV9zdG9wKHN0cnVjdCB2aG9zdF9k
ZXYgKmRldiwgdW5zaWduZWQgaWR4LAo+ICAgICovCj4gICBWaG9zdFNoYWRvd1ZpcnRxdWV1ZSAq
dmhvc3Rfc3ZxX25ldyhzdHJ1Y3Qgdmhvc3RfZGV2ICpkZXYsIGludCBpZHgpCj4gICB7Cj4gKyAg
ICBpbnQgdnFfaWR4ID0gZGV2LT52cV9pbmRleCArIGlkeDsKPiAgICAgICBnX2F1dG9mcmVlIFZo
b3N0U2hhZG93VmlydHF1ZXVlICpzdnEgPSBnX25ldzAoVmhvc3RTaGFkb3dWaXJ0cXVldWUsIDEp
Owo+ICAgICAgIGludCByOwo+ICAgCj4gQEAgLTE1MSw2ICsxNzEsNyBAQCBWaG9zdFNoYWRvd1Zp
cnRxdWV1ZSAqdmhvc3Rfc3ZxX25ldyhzdHJ1Y3Qgdmhvc3RfZGV2ICpkZXYsIGludCBpZHgpCj4g
ICAgICAgICAgIGdvdG8gZXJyX2luaXRfaGRldl9jYWxsOwo+ICAgICAgIH0KPiAgIAo+ICsgICAg
c3ZxLT52cSA9IHZpcnRpb19nZXRfcXVldWUoZGV2LT52ZGV2LCB2cV9pZHgpOwo+ICAgICAgIHJl
dHVybiBnX3N0ZWFsX3BvaW50ZXIoJnN2cSk7Cj4gICAKPiAgIGVycl9pbml0X2hkZXZfY2FsbDoK
Cl9fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fClZpcnR1YWxp
emF0aW9uIG1haWxpbmcgbGlzdApWaXJ0dWFsaXphdGlvbkBsaXN0cy5saW51eC1mb3VuZGF0aW9u
Lm9yZwpodHRwczovL2xpc3RzLmxpbnV4Zm91bmRhdGlvbi5vcmcvbWFpbG1hbi9saXN0aW5mby92
aXJ0dWFsaXphdGlvbg==
