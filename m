Return-Path: <SRS0=EgWE=L6=lists.linux-foundation.org=virtualization-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.1 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 39E8AC07E99
	for <virtualization@archiver.kernel.org>; Tue,  6 Jul 2021 02:31:14 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id BA5E56128E
	for <virtualization@archiver.kernel.org>; Tue,  6 Jul 2021 02:31:13 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BA5E56128E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=virtualization-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 807B26075E;
	Tue,  6 Jul 2021 02:31:13 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
	by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id 7akqdaYO13kR; Tue,  6 Jul 2021 02:31:12 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp3.osuosl.org (Postfix) with ESMTPS id 077F36078C;
	Tue,  6 Jul 2021 02:31:12 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id CEC29C0010;
	Tue,  6 Jul 2021 02:31:11 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [IPv6:2605:bc80:3010::137])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 9E30BC000E
 for <virtualization@lists.linux-foundation.org>;
 Tue,  6 Jul 2021 02:31:10 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id 79BEA40490
 for <virtualization@lists.linux-foundation.org>;
 Tue,  6 Jul 2021 02:31:10 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp4.osuosl.org (amavisd-new);
 dkim=pass (1024-bit key) header.d=redhat.com
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id ov7atJMa8KC1
 for <virtualization@lists.linux-foundation.org>;
 Tue,  6 Jul 2021 02:31:08 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [216.205.24.124])
 by smtp4.osuosl.org (Postfix) with ESMTPS id AB7554041E
 for <virtualization@lists.linux-foundation.org>;
 Tue,  6 Jul 2021 02:31:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1625538666;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=+t7xgkqb9EDjx9o5Ws18UiODNH1rDl4lfk/LxQtMlSA=;
 b=R6lFr8rKtG4II2DzsSdSjXYfLMAGBbeOl99kxPgfTR1QOZx2DQftmSAyhI/nbDUQ3pKVGb
 x+r5wppcTnDpPVk7sRy1xpVY/ICSNraJZENasgx7d2EeRERyYrca5bWtjEqgHkG1nkv2qY
 rtygTiRSJdyy91EkAP+/64W7HjRMjPM=
Received: from mail-pj1-f71.google.com (mail-pj1-f71.google.com
 [209.85.216.71]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-325-BDQY0HnjPhGnL6ZRjtw2vg-1; Mon, 05 Jul 2021 22:31:05 -0400
X-MC-Unique: BDQY0HnjPhGnL6ZRjtw2vg-1
Received: by mail-pj1-f71.google.com with SMTP id
 t5-20020a17090a4485b029016f7fcb8a3dso828994pjg.2
 for <virtualization@lists.linux-foundation.org>;
 Mon, 05 Jul 2021 19:31:04 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-transfer-encoding
 :content-language;
 bh=+t7xgkqb9EDjx9o5Ws18UiODNH1rDl4lfk/LxQtMlSA=;
 b=JSNMoE5x2XUAUYlVkHlPTSVyDd0bsO8KeMmEUSa3fnDnLxTjuKaUKGDCFa0Bw/S1bE
 fJV3bkL8nAypv6aDZHm4dsBtapQxct7GT13IKGMwIJemF4+QUq0krgZHAeAkybp5CQMq
 TqzFrBrfZb7roClMZjrMkgu8aZuq8c9kn3EpSmPhlVCFHV2W2YJtLLhbt2udzJ1UuuhG
 rALJpfSBCn+LB8euu//BNiDFG/t/351i5MetD7IC7DaDW256HsFQyzZHBPdCYOFIQQgm
 7f/4HJt9WhiUGL3bBQOtcDRhzIb6V/PGWfxO713HqZE7Zs4CyrB9DALrr6W1ByKsNFqT
 S2Yw==
X-Gm-Message-State: AOAM533JAmYSeWgbb+7GXban9ofx4jEVOqcASYW/P1MYPHyLUrQe4vEP
 lcru9AN7eOlYt6zAFPEfDh4KYbpIBcGvPyKVTEx1NHqH9IF80pNn4qzLog+4GZKBYi2qIyOPmIO
 lM8QGul6wBCg8aS7FmDMUWrhxagmuHo7Z55vgGvHjRw==
X-Received: by 2002:a17:90b:124f:: with SMTP id
 gx15mr2053891pjb.8.1625538664038; 
 Mon, 05 Jul 2021 19:31:04 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJzGJ3C4PIS2j1yjac50lMKMZ06m91aoC+A1GrgZ9KMYDd3ldGiJnB8VFZ5kPGCmj4zRcWEfnQ==
X-Received: by 2002:a17:90b:124f:: with SMTP id
 gx15mr2053875pjb.8.1625538663867; 
 Mon, 05 Jul 2021 19:31:03 -0700 (PDT)
Received: from wangxiaodeMacBook-Air.local ([209.132.188.80])
 by smtp.gmail.com with ESMTPSA id d25sm13862589pgn.42.2021.07.05.19.31.00
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 05 Jul 2021 19:31:03 -0700 (PDT)
Subject: Re: [PATCH 2/2] vdpa: vp_vdpa: don't use hard-coded maximum virtqueue
 size
To: "Michael S. Tsirkin" <mst@redhat.com>
References: <20210705071910.31965-1-jasowang@redhat.com>
 <20210705071910.31965-2-jasowang@redhat.com>
 <20210705032602-mutt-send-email-mst@kernel.org>
 <02139c5f-92c5-eda6-8d2d-8e1b6ac70f3e@redhat.com>
 <20210705065534-mutt-send-email-mst@kernel.org>
From: Jason Wang <jasowang@redhat.com>
Message-ID: <e0744583-fcdc-07d0-a414-31d660089e2b@redhat.com>
Date: Tue, 6 Jul 2021 10:30:59 +0800
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:78.0)
 Gecko/20100101 Thunderbird/78.11.0
MIME-Version: 1.0
In-Reply-To: <20210705065534-mutt-send-email-mst@kernel.org>
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=jasowang@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Language: en-US
Cc: kvm@vger.kernel.org, netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
 virtualization@lists.linux-foundation.org, xieyongji@bytedance.com,
 stefanha@redhat.com
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

CuWcqCAyMDIxLzcvNiDkuIrljYgxOjU5LCBNaWNoYWVsIFMuIFRzaXJraW4g5YaZ6YGTOgo+IE9u
IE1vbiwgSnVsIDA1LCAyMDIxIGF0IDAzOjI5OjQ3UE0gKzA4MDAsIEphc29uIFdhbmcgd3JvdGU6
Cj4+IOWcqCAyMDIxLzcvNSDkuIvljYgzOjI2LCBNaWNoYWVsIFMuIFRzaXJraW4g5YaZ6YGTOgo+
Pj4gT24gTW9uLCBKdWwgMDUsIDIwMjEgYXQgMDM6MTk6MTBQTSArMDgwMCwgSmFzb24gV2FuZyB3
cm90ZToKPj4+PiBUaGlzIHBhdGNoIHN3aXRjaCB0byByZWFkIHZpcnRxdWV1ZSBzaXplIGZyb20g
dGhlIGNhcGFiaWxpdHkgaW5zdGVhZAo+Pj4+IG9mIGRlcGVuZGluZyBvbiB0aGUgaGFyZGNvZGVk
IHZhbHVlLiBUaGlzIGFsbG93cyB0aGUgcGVyIHZpcnRxdWV1ZQo+Pj4+IHNpemUgY291bGQgYmUg
YWR2ZXJ0aXNlZC4KPj4+Pgo+Pj4+IFNpZ25lZC1vZmYtYnk6IEphc29uIFdhbmcgPGphc293YW5n
QHJlZGhhdC5jb20+Cj4+PiBTbyBsZXQncyBhZGQgYW4gaW9jdGwgZm9yIHRoaXM/IEl0J3MgcmVh
bGx5IGEgYnVnIHdlIGRvbid0Li4KPj4KPj4gQXMgZXhwbGFpbmVkIGluIHBhdGNoIDEuIFFlbXUg
ZG9lc24ndCB1c2UgVkhPU1RfVkRQQV9HRVRfVlJJTkdfTlVNIGFjdHVhbGx5Lgo+PiBJbnN0ZWFk
IGl0IGNoZWNrcyB0aGUgcmVzdWx0IFZIT1NUX1ZEUEFfU0VUX1ZSSU5HX05VTS4KPj4KPj4gU28g
SSBjaGFuZ2UgVkhPU1RfVkRQQV9HRVRfVlJJTkdfTlVNIHRvIHJldHVybiB0aGUgbWluaW1hbCBz
aXplIG9mIGFsbCB0aGUKPj4gdmlydHF1ZXVlcy4KPj4KPj4gSWYgeW91IHdpc2ggd2UgY2FuIGFk
ZCBhIFZIT1NUX1ZEUEFfR0VUX1ZSSU5HX05VTTIsIGJ1dCBJJ20gbm90IHN1cmUgaXQgd2lsbAo+
PiBoYXZlIGEgdXNlciBvciBub3QuCj4+Cj4+IFRoYW5rcwo+IFF1ZXN0aW9uIGlzIGhvdyBkbyB3
ZSBrbm93IHJldHVybmluZyB0aGUgbWluaW1hbCBhbmQgbm90IGUuZy4gdGhlIG1heAo+IHNpemUg
aXMgdGhlIHJpZ2h0IHRoaW5nIHRvIGRvPwoKCkZvciB0aGUgbmV3IGlvY3RsLCBpdCB3aWxsIHJl
dHVybiB0aGUgbWF4IHF1ZXVlIHNpemUgcGVyIHZxLgoKSXQncyBwcm9iYWJseSB0b28gbGF0ZSB0
byBmaXggdGhlIG9sZCBvbmUsIHNvIGl0J3Mgb25seSBzYWZlIHRvIHJldHVybiAKdGhlIG1pbmlt
YWwgb25lLgoKQWN0dWFsbHksIG1vc3Qgb2YgdGhlIHZEUEEgcGFyZW50cyBzaG91bGQgYmUgZmlu
ZSBleGNlcHQgZm9yIHRoZSAKdnBfdmRwYS4gV2hlbiBydW5uaW5nIGluIGEgbmVzdGVkIGVudmly
b25tZW50LCBRZW11IG9ubHkgYWR2ZXJ0aXNlIGN2cSAKd2l0aCA2NCBlbnRyaWVzLgoKVGhhbmtz
CgoKPgo+Cj4+Pj4gLS0tCj4+Pj4gICAgZHJpdmVycy92ZHBhL3ZpcnRpb19wY2kvdnBfdmRwYS5j
IHwgNiArKysrLS0KPj4+PiAgICAxIGZpbGUgY2hhbmdlZCwgNCBpbnNlcnRpb25zKCspLCAyIGRl
bGV0aW9ucygtKQo+Pj4+Cj4+Pj4gZGlmZiAtLWdpdCBhL2RyaXZlcnMvdmRwYS92aXJ0aW9fcGNp
L3ZwX3ZkcGEuYyBiL2RyaXZlcnMvdmRwYS92aXJ0aW9fcGNpL3ZwX3ZkcGEuYwo+Pj4+IGluZGV4
IDI5MjY2NDFmYjU4Ni4uMTk4ZjcwNzZlNGQ5IDEwMDY0NAo+Pj4+IC0tLSBhL2RyaXZlcnMvdmRw
YS92aXJ0aW9fcGNpL3ZwX3ZkcGEuYwo+Pj4+ICsrKyBiL2RyaXZlcnMvdmRwYS92aXJ0aW9fcGNp
L3ZwX3ZkcGEuYwo+Pj4+IEBAIC0xOCw3ICsxOCw2IEBACj4+Pj4gICAgI2luY2x1ZGUgPGxpbnV4
L3ZpcnRpb19wY2kuaD4KPj4+PiAgICAjaW5jbHVkZSA8bGludXgvdmlydGlvX3BjaV9tb2Rlcm4u
aD4KPj4+PiAtI2RlZmluZSBWUF9WRFBBX1FVRVVFX01BWCAyNTYKPj4+PiAgICAjZGVmaW5lIFZQ
X1ZEUEFfRFJJVkVSX05BTUUgInZwX3ZkcGEiCj4+Pj4gICAgI2RlZmluZSBWUF9WRFBBX05BTUVf
U0laRSAyNTYKPj4+PiBAQCAtMTk3LDcgKzE5NiwxMCBAQCBzdGF0aWMgdm9pZCB2cF92ZHBhX3Nl
dF9zdGF0dXMoc3RydWN0IHZkcGFfZGV2aWNlICp2ZHBhLCB1OCBzdGF0dXMpCj4+Pj4gICAgc3Rh
dGljIHUxNiB2cF92ZHBhX2dldF92cV9udW1fbWF4KHN0cnVjdCB2ZHBhX2RldmljZSAqdmRwYSwg
dTE2IHFpZCkKPj4+PiAgICB7Cj4+Pj4gLQlyZXR1cm4gVlBfVkRQQV9RVUVVRV9NQVg7Cj4+Pj4g
KwlzdHJ1Y3QgdnBfdmRwYSAqdnBfdmRwYSA9IHZkcGFfdG9fdnAodmRwYSk7Cj4+Pj4gKwlzdHJ1
Y3QgdmlydGlvX3BjaV9tb2Rlcm5fZGV2aWNlICptZGV2ID0gJnZwX3ZkcGEtPm1kZXY7Cj4+Pj4g
Kwo+Pj4+ICsJcmV0dXJuIHZwX21vZGVybl9nZXRfcXVldWVfc2l6ZShtZGV2LCBxaWQpOwo+Pj4+
ICAgIH0KPj4+PiAgICBzdGF0aWMgaW50IHZwX3ZkcGFfZ2V0X3ZxX3N0YXRlKHN0cnVjdCB2ZHBh
X2RldmljZSAqdmRwYSwgdTE2IHFpZCwKPj4+PiAtLSAKPj4+PiAyLjI1LjEKCl9fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fClZpcnR1YWxpemF0aW9uIG1haWxp
bmcgbGlzdApWaXJ0dWFsaXphdGlvbkBsaXN0cy5saW51eC1mb3VuZGF0aW9uLm9yZwpodHRwczov
L2xpc3RzLmxpbnV4Zm91bmRhdGlvbi5vcmcvbWFpbG1hbi9saXN0aW5mby92aXJ0dWFsaXphdGlv
bg==
