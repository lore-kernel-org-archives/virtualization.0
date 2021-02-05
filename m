Return-Path: <SRS0=ITlz=HH=lists.linux-foundation.org=virtualization-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 71D95C433E0
	for <virtualization@archiver.kernel.org>; Fri,  5 Feb 2021 09:17:03 +0000 (UTC)
Received: from silver.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E139A64F4A
	for <virtualization@archiver.kernel.org>; Fri,  5 Feb 2021 09:17:02 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E139A64F4A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=virtualization-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by silver.osuosl.org (Postfix) with ESMTP id 746022E0FE;
	Fri,  5 Feb 2021 09:17:02 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from silver.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id 8vD6cljtDb6c; Fri,  5 Feb 2021 09:17:01 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by silver.osuosl.org (Postfix) with ESMTP id 34181203E8;
	Fri,  5 Feb 2021 09:17:01 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 19792C08A1;
	Fri,  5 Feb 2021 09:17:01 +0000 (UTC)
Received: from whitealder.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id ECFF0C013A
 for <virtualization@lists.linux-foundation.org>;
 Fri,  5 Feb 2021 09:16:59 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by whitealder.osuosl.org (Postfix) with ESMTP id D860687108
 for <virtualization@lists.linux-foundation.org>;
 Fri,  5 Feb 2021 09:16:59 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from whitealder.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id 8YlB4qIHgEmY
 for <virtualization@lists.linux-foundation.org>;
 Fri,  5 Feb 2021 09:16:58 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [63.128.21.124])
 by whitealder.osuosl.org (Postfix) with ESMTPS id 67B6D87106
 for <virtualization@lists.linux-foundation.org>;
 Fri,  5 Feb 2021 09:16:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1612516617;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=57F239YtV0oHbCCj5J8DpWnEViN3tCKhKGovQyK+Lic=;
 b=ZzTPajMUgqW5xYX//MobQ/+xEIQNbQ2VWZ4IwSZwkV+jq4KgbNoxSxrjcDVb6MAHjcndBh
 LNzb2pK8TnuLb8Zoh6mDAvxIFK2jvmgzNfufEz3vQnKwOJRckHwnlhApVml1GDZ55OUqgx
 98tAqUUdJb9gDzGrl7bTVFDBzTwhsKI=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-102-LBeTqnURO7OXUXDAzftoPg-1; Fri, 05 Feb 2021 04:16:55 -0500
X-MC-Unique: LBeTqnURO7OXUXDAzftoPg-1
Received: by mail-wm1-f69.google.com with SMTP id h25so2776116wmb.6
 for <virtualization@lists.linux-foundation.org>;
 Fri, 05 Feb 2021 01:16:55 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:content-transfer-encoding
 :in-reply-to;
 bh=57F239YtV0oHbCCj5J8DpWnEViN3tCKhKGovQyK+Lic=;
 b=A6Yiv4cHG4MB6904w94fL3c4p2zZS3x8C/4wnUfa3aeuYmVYiCGjtUOq/XYhhXYL52
 PhjQ6jJIJJozCu/VfShJFLLZXW+btUDxDq9NahDr6Ls799cwxovzNLLCLyhe/HH/dOpQ
 o1nznYAEdcoMYshJx1JUYKdR8Pvqk5PdHGeegd57BeFrcPpSnaxEmvb1XP1AbST5jc+2
 AWNqouxhKW/LvffRibZ7P35BCZMcwP3g1XrAVPwhjJDdqUUhOlZQ+khRF7T5pcvHEFon
 Zu8dM/GIlk8tM31UP1vDFRAg3ZwK4pJEM8tDC7eDBJjCZJ7PeD3z/LeD3Hh+lEANZTHf
 vQWg==
X-Gm-Message-State: AOAM530mchRYvxA/b1S/uxviIRieIIgP6vUmkecrh7CoPZAwbGBh9SBS
 uVUSZ+9rhorpkifFApY4bjGFRo09/Lz/wQG53SHlOT9MpbBoUmjKTOproZ4CIu9cK9GOHqD0+Ge
 +MQ3yCk/vDJrYi2lqbEPIigQkDF1doog+YNVZ5gihnQ==
X-Received: by 2002:adf:d84a:: with SMTP id k10mr3934397wrl.156.1612516614250; 
 Fri, 05 Feb 2021 01:16:54 -0800 (PST)
X-Google-Smtp-Source: ABdhPJxm4rfj82uV3tGDph5pyyVq3oRWewQ+gBUMQfr86xZKT355ALHumrHiplodlmOUoLsCMMAfbw==
X-Received: by 2002:adf:d84a:: with SMTP id k10mr3934381wrl.156.1612516614060; 
 Fri, 05 Feb 2021 01:16:54 -0800 (PST)
Received: from steredhat (host-79-34-249-199.business.telecomitalia.it.
 [79.34.249.199])
 by smtp.gmail.com with ESMTPSA id g14sm12104482wru.45.2021.02.05.01.16.52
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 05 Feb 2021 01:16:53 -0800 (PST)
Date: Fri, 5 Feb 2021 10:16:51 +0100
From: Stefano Garzarella <sgarzare@redhat.com>
To: Jason Wang <jasowang@redhat.com>, "Michael S. Tsirkin" <mst@redhat.com>
Subject: Re: [PATCH v3 09/13] vhost/vdpa: remove vhost_vdpa_config_validate()
Message-ID: <20210205091651.xfcdyuvwwzew2ufo@steredhat>
References: <20210204172230.85853-1-sgarzare@redhat.com>
 <20210204172230.85853-10-sgarzare@redhat.com>
 <6919d2d4-cc8e-2b67-2385-35803de5e38b@redhat.com>
MIME-Version: 1.0
In-Reply-To: <6919d2d4-cc8e-2b67-2385-35803de5e38b@redhat.com>
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=sgarzare@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Disposition: inline
Cc: Laurent Vivier <lvivier@redhat.com>, Max Gurtovoy <mgurtovoy@nvidia.com>,
 kvm@vger.kernel.org, linux-kernel@vger.kernel.org,
 virtualization@lists.linux-foundation.org,
 Xie Yongji <xieyongji@bytedance.com>, Stefan Hajnoczi <stefanha@redhat.com>
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

T24gRnJpLCBGZWIgMDUsIDIwMjEgYXQgMTE6Mjc6MzJBTSArMDgwMCwgSmFzb24gV2FuZyB3cm90
ZToKPgo+T24gMjAyMS8yLzUg5LiK5Y2IMToyMiwgU3RlZmFubyBHYXJ6YXJlbGxhIHdyb3RlOgo+
PmdldF9jb25maWcoKSBhbmQgc2V0X2NvbmZpZygpIGNhbGxiYWNrcyBpbiB0aGUgJ3N0cnVjdCB2
ZHBhX2NvbmZpZ19vcHMnCj4+dXN1YWxseSBhbHJlYWR5IHZhbGlkYXRlZCB0aGUgaW5wdXRzLiBB
bHNvIG5vdyB0aGV5IGNhbiByZXR1cm4gYW4gZXJyb3IsCj4+c28gd2UgZG9uJ3QgbmVlZCB0byB2
YWxpZGF0ZSB0aGVtIGhlcmUgYW55bW9yZS4KPj4KPj5MZXQncyB1c2UgdGhlIHJldHVybiB2YWx1
ZSBvZiB0aGVzZSBjYWxsYmFja3MgYW5kIHJldHVybiBpdCBpbiBjYXNlIG9mCj4+ZXJyb3IgaW4g
dmhvc3RfdmRwYV9nZXRfY29uZmlnKCkgYW5kIHZob3N0X3ZkcGFfc2V0X2NvbmZpZygpLgo+Pgo+
Pk9yaWdpbmFsbHktYnk6IFhpZSBZb25namkgPHhpZXlvbmdqaUBieXRlZGFuY2UuY29tPgo+PlNp
Z25lZC1vZmYtYnk6IFN0ZWZhbm8gR2FyemFyZWxsYSA8c2dhcnphcmVAcmVkaGF0LmNvbT4KPj4t
LS0KPj4gIGRyaXZlcnMvdmhvc3QvdmRwYS5jIHwgNDEgKysrKysrKysrKysrKy0tLS0tLS0tLS0t
LS0tLS0tLS0tLS0tLS0tLS0KPj4gIDEgZmlsZSBjaGFuZ2VkLCAxMyBpbnNlcnRpb25zKCspLCAy
OCBkZWxldGlvbnMoLSkKPj4KPj5kaWZmIC0tZ2l0IGEvZHJpdmVycy92aG9zdC92ZHBhLmMgYi9k
cml2ZXJzL3Zob3N0L3ZkcGEuYwo+PmluZGV4IGVmNjg4YzhjMGUwZS4uZDYxZTc3OTAwMGE4IDEw
MDY0NAo+Pi0tLSBhL2RyaXZlcnMvdmhvc3QvdmRwYS5jCj4+KysrIGIvZHJpdmVycy92aG9zdC92
ZHBhLmMKPj5AQCAtMTg1LDUxICsxODUsMzUgQEAgc3RhdGljIGxvbmcgdmhvc3RfdmRwYV9zZXRf
c3RhdHVzKHN0cnVjdCB2aG9zdF92ZHBhICp2LCB1OCBfX3VzZXIgKnN0YXR1c3ApCj4+ICAJcmV0
dXJuIDA7Cj4+ICB9Cj4+LXN0YXRpYyBpbnQgdmhvc3RfdmRwYV9jb25maWdfdmFsaWRhdGUoc3Ry
dWN0IHZob3N0X3ZkcGEgKnYsCj4+LQkJCQkgICAgICBzdHJ1Y3Qgdmhvc3RfdmRwYV9jb25maWcg
KmMpCj4+LXsKPj4tCWxvbmcgc2l6ZSA9IDA7Cj4+LQo+Pi0Jc3dpdGNoICh2LT52aXJ0aW9faWQp
IHsKPj4tCWNhc2UgVklSVElPX0lEX05FVDoKPj4tCQlzaXplID0gc2l6ZW9mKHN0cnVjdCB2aXJ0
aW9fbmV0X2NvbmZpZyk7Cj4+LQkJYnJlYWs7Cj4+LQl9Cj4+LQo+Pi0JaWYgKGMtPmxlbiA9PSAw
KQo+Pi0JCXJldHVybiAtRUlOVkFMOwo+Pi0KPj4tCWlmIChjLT5sZW4gPiBzaXplIC0gYy0+b2Zm
KQo+Pi0JCXJldHVybiAtRTJCSUc7Cj4+LQo+Pi0JcmV0dXJuIDA7Cj4+LX0KPj4tCj4+ICBzdGF0
aWMgbG9uZyB2aG9zdF92ZHBhX2dldF9jb25maWcoc3RydWN0IHZob3N0X3ZkcGEgKnYsCj4+ICAJ
CQkJICBzdHJ1Y3Qgdmhvc3RfdmRwYV9jb25maWcgX191c2VyICpjKQo+PiAgewo+PiAgCXN0cnVj
dCB2ZHBhX2RldmljZSAqdmRwYSA9IHYtPnZkcGE7Cj4+ICAJc3RydWN0IHZob3N0X3ZkcGFfY29u
ZmlnIGNvbmZpZzsKPj4gIAl1bnNpZ25lZCBsb25nIHNpemUgPSBvZmZzZXRvZihzdHJ1Y3Qgdmhv
c3RfdmRwYV9jb25maWcsIGJ1Zik7Cj4+Kwlsb25nIHJldDsKPj4gIAl1OCAqYnVmOwo+PiAgCWlm
IChjb3B5X2Zyb21fdXNlcigmY29uZmlnLCBjLCBzaXplKSkKPj4gIAkJcmV0dXJuIC1FRkFVTFQ7
Cj4+LQlpZiAodmhvc3RfdmRwYV9jb25maWdfdmFsaWRhdGUodiwgJmNvbmZpZykpCj4+KwlpZiAo
Y29uZmlnLmxlbiA9PSAwKQo+PiAgCQlyZXR1cm4gLUVJTlZBTDsKPj4gIAlidWYgPSBrdnphbGxv
Yyhjb25maWcubGVuLCBHRlBfS0VSTkVMKTsKPgo+Cj5UaGVuIGl0IG1lYW5zIHVzZXJzYXBjZSBj
YW4gYWxsb2NhdGUgYSB2ZXJ5IGxhcmdlIG1lbW9yeS4KCkdvb2QgcG9pbnQuCgo+Cj5SZXRoaW5r
IGFib3V0IHRoaXMsIHdlIHNob3VsZCBsaW1pdCB0aGUgc2l6ZSBoZXJlIChlLmcgUEFHRV9TSVpF
KSBvciAKPmZldGNoIHRoZSBjb25maWcgc2l6ZSBmaXJzdCAoZWl0aGVyIHRocm91Z2ggYSBjb25m
aWcgb3BzIGFzIHlvdSAKPnN1Z2dlc3RlZCBvciBhIHZhcmlhYmxlIGluIHRoZSB2ZHBhIGRldmlj
ZSB0aGF0IGlzIGluaXRpYWxpemVkIGR1cmluZyAKPmRldmljZSBjcmVhdGlvbikuCgpNYXliZSBQ
QUdFX1NJWkUgaXMgb2theSBhcyBhIGxpbWl0LgoKSWYgaW5zdGVhZCB3ZSB3YW50IHRvIGZldGNo
IHRoZSBjb25maWcgc2l6ZSwgdGhlbiBiZXR0ZXIgYSBjb25maWcgb3BzIGluIApteSBvcGluaW9u
LCB0byBhdm9pZCBhZGRpbmcgYSBuZXcgcGFyYW1ldGVyIHRvIF9fdmRwYV9hbGxvY19kZXZpY2Uo
KS4KCkkgdm90ZSBmb3IgUEFHRV9TSVpFLCBidXQgaXQgaXNuJ3QgYSBzdHJvbmcgb3Bpbmlvbi4K
CldoYXQgZG8geW91IGFuZCBATWljaGFlbCBzdWdnZXN0PwoKVGhhbmtzLApTdGVmYW5vCgpfX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fXwpWaXJ0dWFsaXphdGlv
biBtYWlsaW5nIGxpc3QKVmlydHVhbGl6YXRpb25AbGlzdHMubGludXgtZm91bmRhdGlvbi5vcmcK
aHR0cHM6Ly9saXN0cy5saW51eGZvdW5kYXRpb24ub3JnL21haWxtYW4vbGlzdGluZm8vdmlydHVh
bGl6YXRpb24=
