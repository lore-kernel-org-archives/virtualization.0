Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AF916C433EF
	for <virtualization@archiver.kernel.org>; Wed, 27 Apr 2022 04:04:11 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 4E17260AF1;
	Wed, 27 Apr 2022 04:04:11 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
	by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id Ao_D5YzZJNzz; Wed, 27 Apr 2022 04:04:10 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp3.osuosl.org (Postfix) with ESMTPS id E852F6061B;
	Wed, 27 Apr 2022 04:04:09 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id AFA72C0039;
	Wed, 27 Apr 2022 04:04:09 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [IPv6:2605:bc80:3010::133])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 76C9FC002D
 for <virtualization@lists.linux-foundation.org>;
 Wed, 27 Apr 2022 04:04:08 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id 647414023D
 for <virtualization@lists.linux-foundation.org>;
 Wed, 27 Apr 2022 04:04:08 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp2.osuosl.org (amavisd-new);
 dkim=pass (1024-bit key) header.d=redhat.com
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id SHh948bo66lZ
 for <virtualization@lists.linux-foundation.org>;
 Wed, 27 Apr 2022 04:04:07 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.133.124])
 by smtp2.osuosl.org (Postfix) with ESMTPS id 8C46A40241
 for <virtualization@lists.linux-foundation.org>;
 Wed, 27 Apr 2022 04:04:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1651032246;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=OH86V8owPQ8N+aMjzBoR2fcN3m/CqaWBYAhno71vU5g=;
 b=AdP13XCqZ8f7M/ccDFKgr1gXvmyAgfi5mYJ7W4z2cvAwP7phbbr9RBXukiozT2NXClTzji
 ykVLSSbvn9tr9mUkqiAvKw0zdxv/vn3icdiQmvEKVEvNoEmiBaPC4xhEMmHPV5t08Hq2BR
 jSqEvClPxb1BGJj+AJ94QvfQyp3KGsY=
Received: from mail-pj1-f69.google.com (mail-pj1-f69.google.com
 [209.85.216.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-572-tQIws81hPfK9aabWPTG1Iw-1; Wed, 27 Apr 2022 00:04:05 -0400
X-MC-Unique: tQIws81hPfK9aabWPTG1Iw-1
Received: by mail-pj1-f69.google.com with SMTP id
 q91-20020a17090a756400b001d951f4846cso2677985pjk.8
 for <virtualization@lists.linux-foundation.org>;
 Tue, 26 Apr 2022 21:04:04 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
 :content-language:to:cc:references:from:in-reply-to
 :content-transfer-encoding;
 bh=OH86V8owPQ8N+aMjzBoR2fcN3m/CqaWBYAhno71vU5g=;
 b=0Dk4VeI3qUw1pJwBGkBD8HTpEtKBy7g+AQYCYzOj+M1QETdUj+XVkHkS4NwVcFGc1x
 +eliQ4IwcpME/pCmTTUq9NfxeAk4fi4JXaIhUhC5jSdWmNYEb4gu06DXbz8t7MAFvxEH
 aEScW9gb/dTGMqkaQxf+2R+iGde0L1YA6c4nvADuYqud+wCZDgKp+XKVssR0G2A9ymsq
 FMHyOFk9IvU1fmYwfJOuoK3CwVjlKocm7wZB24CPvlRC0GyVVyc5rOMzbrkXKK9jqWwh
 HpaDjuOx8V0pUKD7RFv927bvkriPISdV8tWYOKz0tyh13EpCnnUl0CYkEmpxTqkpiLLU
 slRQ==
X-Gm-Message-State: AOAM530tqgE4rTXiMdHzY26+E3RhlPLJERSby23W9eqinkAEAK5NEHae
 91gyg4c+Njm9RHAhLw4QxKy/lKpusFuAAzwvrO0zHM1v3KFnNbivksrm3QhEGmLS7gJbru52742
 bcseGR6ej7wZvYhD6P3mu6vfPBTfJz3IN2lxjTeKt9g==
X-Received: by 2002:a17:902:7897:b0:15d:318d:706b with SMTP id
 q23-20020a170902789700b0015d318d706bmr7975410pll.16.1651032243638; 
 Tue, 26 Apr 2022 21:04:03 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJy/GVt4L0b3NsfyKmTgh5DsBLXHJFRjd28qfTAKnNcKsAPZ1TXoZmkTwbFM+AWJr7AUoaFRfQ==
X-Received: by 2002:a17:902:7897:b0:15d:318d:706b with SMTP id
 q23-20020a170902789700b0015d318d706bmr7975394pll.16.1651032243379; 
 Tue, 26 Apr 2022 21:04:03 -0700 (PDT)
Received: from [10.72.12.60] ([209.132.188.80])
 by smtp.gmail.com with ESMTPSA id
 t63-20020a625f42000000b0050a7eaff8c9sm16925270pfb.189.2022.04.26.21.04.01
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 26 Apr 2022 21:04:02 -0700 (PDT)
Message-ID: <46c9f96a-8fcf-fae8-5fd7-53557d59c324@redhat.com>
Date: Wed, 27 Apr 2022 12:03:59 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:91.0)
 Gecko/20100101 Thunderbird/91.8.1
Subject: Re: [PATCH v2 1/2] vdpa: add the check for id_table in struct
 vdpa_mgmt_dev
To: Cindy Lu <lulu@redhat.com>
References: <20220425062735.172576-1-lulu@redhat.com>
 <CACGkMEuMZJRw1TBfY5pTkSAD5MnGvUCu5Eqi=bWD5yc1-hc9YQ@mail.gmail.com>
 <CACLfguUOoeiWrq_2s6NrNB4HwaAbeBYy2TGo0mhO-xswy9G7yw@mail.gmail.com>
From: Jason Wang <jasowang@redhat.com>
In-Reply-To: <CACLfguUOoeiWrq_2s6NrNB4HwaAbeBYy2TGo0mhO-xswy9G7yw@mail.gmail.com>
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=jasowang@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Language: en-US
Cc: virtualization <virtualization@lists.linux-foundation.org>,
 linux-kernel <linux-kernel@vger.kernel.org>, mst <mst@redhat.com>
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

CuWcqCAyMDIyLzQvMjcgMTA6MDEsIENpbmR5IEx1IOWGmemBkzoKPiBPbiBNb24sIEFwciAyNSwg
MjAyMiBhdCA1OjAwIFBNIEphc29uIFdhbmcgPGphc293YW5nQHJlZGhhdC5jb20+IHdyb3RlOgo+
PiBPbiBNb24sIEFwciAyNSwgMjAyMiBhdCAyOjI3IFBNIENpbmR5IEx1IDxsdWx1QHJlZGhhdC5j
b20+IHdyb3RlOgo+Pj4gVG8gc3VwcG9ydCB0aGUgZHluYW1pYyBpZHMgaW4gdnBfdmRwYSwgd2Ug
bmVlZCB0byBhZGQgdGhlIGNoZWNrIGZvcgo+Pj4gaWQgdGFibGUuIElmIHRoZSBpZCB0YWJsZSBp
cyBOVUxMLCB3aWxsIG5vdCBzZXQgdGhlIGRldmljZSB0eXBlCj4+Pgo+Pj4gU2lnbmVkLW9mZi1i
eTogQ2luZHkgTHUgPGx1bHVAcmVkaGF0LmNvbT4KPj4+IC0tLQo+Pj4gICBkcml2ZXJzL3ZkcGEv
dmRwYS5jIHwgMTEgKysrKysrKy0tLS0KPj4+ICAgMSBmaWxlIGNoYW5nZWQsIDcgaW5zZXJ0aW9u
cygrKSwgNCBkZWxldGlvbnMoLSkKPj4+Cj4+PiBkaWZmIC0tZ2l0IGEvZHJpdmVycy92ZHBhL3Zk
cGEuYyBiL2RyaXZlcnMvdmRwYS92ZHBhLmMKPj4+IGluZGV4IDFlYTUyNTQzM2E1Yy4uMDllZGQ5
MmNlZGUwIDEwMDY0NAo+Pj4gLS0tIGEvZHJpdmVycy92ZHBhL3ZkcGEuYwo+Pj4gKysrIGIvZHJp
dmVycy92ZHBhL3ZkcGEuYwo+Pj4gQEAgLTQ5MiwxMCArNDkyLDEzIEBAIHN0YXRpYyBpbnQgdmRw
YV9tZ210ZGV2X2ZpbGwoY29uc3Qgc3RydWN0IHZkcGFfbWdtdF9kZXYgKm1kZXYsIHN0cnVjdCBz
a19idWZmICptCj4+PiAgICAgICAgICBpZiAoZXJyKQo+Pj4gICAgICAgICAgICAgICAgICBnb3Rv
IG1zZ19lcnI7Cj4+Pgo+Pj4gLSAgICAgICB3aGlsZSAobWRldi0+aWRfdGFibGVbaV0uZGV2aWNl
KSB7Cj4+PiAtICAgICAgICAgICAgICAgaWYgKG1kZXYtPmlkX3RhYmxlW2ldLmRldmljZSA8PSA2
MykKPj4+IC0gICAgICAgICAgICAgICAgICAgICAgIHN1cHBvcnRlZF9jbGFzc2VzIHw9IEJJVF9V
TEwobWRldi0+aWRfdGFibGVbaV0uZGV2aWNlKTsKPj4+IC0gICAgICAgICAgICAgICBpKys7Cj4+
PiArICAgICAgIGlmIChtZGV2LT5pZF90YWJsZSAhPSBOVUxMKSB7Cj4+PiArICAgICAgICAgICAg
ICAgd2hpbGUgKG1kZXYtPmlkX3RhYmxlW2ldLmRldmljZSkgewo+Pj4gKyAgICAgICAgICAgICAg
ICAgICAgICAgaWYgKG1kZXYtPmlkX3RhYmxlW2ldLmRldmljZSA8PSA2MykKPj4+ICsgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgc3VwcG9ydGVkX2NsYXNzZXMgfD0KPj4+ICsgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICBCSVRfVUxMKG1kZXYtPmlkX3RhYmxlW2ld
LmRldmljZSk7Cj4+PiArICAgICAgICAgICAgICAgICAgICAgICBpKys7Cj4+PiArICAgICAgICAg
ICAgICAgfQo+Pj4gICAgICAgICAgfQo+PiBUaGlzIHdpbGwgY2F1c2UgMCB0byBiZSBhZHZlcnRp
c2VkIGFzIHRoZSBzdXBwb3J0ZWQgY2xhc3Nlcy4KPj4KPj4gSSB3b25kZXIgaWYgd2UgY2FuIHNp
bXBseSB1c2UgVklSVElPX0RFVl9BTllfSUQgaGVyZSAoYW5kIG5lZWQgdG8KPj4gZXhwb3J0IGl0
IHRvIHZpYSB1QVBJIHByb2JhYmx5KS4KPj4KPj4gVGhhbmtzCj4+Cj4gbGlrZSB0aGUgYmVsb3cg
b25lPyBub3Qgc3VyZSBpZiB0aGlzIG9rIHRvIHVzZSBsaWtlIHRoaXM/Cj4gc3RhdGljIHN0cnVj
dCB2aXJ0aW9fZGV2aWNlX2lkIHZwX3ZkcGFfaWRfdGFibGVbXSA9IHsKPiB7IFZJUlRJT19ERVZf
QU5ZX0lELCBWSVJUSU9fREVWX0FOWV9JRCB9LAo+IHsgMCB9LAo+IH07CgoKU29tZXRoaW5nIGxp
a2UgdGhpcy4KClRoYW5rcwoKCj4KPgo+Pj4gICAgICAgICAgaWYgKG5sYV9wdXRfdTY0XzY0Yml0
KG1zZywgVkRQQV9BVFRSX01HTVRERVZfU1VQUE9SVEVEX0NMQVNTRVMsCj4+PiAtLQo+Pj4gMi4z
NC4xCj4+PgoKX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18K
VmlydHVhbGl6YXRpb24gbWFpbGluZyBsaXN0ClZpcnR1YWxpemF0aW9uQGxpc3RzLmxpbnV4LWZv
dW5kYXRpb24ub3JnCmh0dHBzOi8vbGlzdHMubGludXhmb3VuZGF0aW9uLm9yZy9tYWlsbWFuL2xp
c3RpbmZvL3ZpcnR1YWxpemF0aW9u
