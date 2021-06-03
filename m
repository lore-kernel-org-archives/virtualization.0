Return-Path: <SRS0=cU2J=K5=lists.linux-foundation.org=virtualization-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.7 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5E680C47082
	for <virtualization@archiver.kernel.org>; Thu,  3 Jun 2021 07:37:40 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 0DB74610E7
	for <virtualization@archiver.kernel.org>; Thu,  3 Jun 2021 07:37:40 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0DB74610E7
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=virtualization-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by smtp2.osuosl.org (Postfix) with ESMTP id C98F9402CD;
	Thu,  3 Jun 2021 07:37:39 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
	by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id p2-9RJGmEXe3; Thu,  3 Jun 2021 07:37:38 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp2.osuosl.org (Postfix) with ESMTP id 56E074050C;
	Thu,  3 Jun 2021 07:37:38 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 38A3EC000E;
	Thu,  3 Jun 2021 07:37:38 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 60D97C0001
 for <virtualization@lists.linux-foundation.org>;
 Thu,  3 Jun 2021 07:37:36 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id 4687083E20
 for <virtualization@lists.linux-foundation.org>;
 Thu,  3 Jun 2021 07:37:36 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp1.osuosl.org (amavisd-new);
 dkim=pass (1024-bit key) header.d=redhat.com
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id Yj4v1Rva-HWw
 for <virtualization@lists.linux-foundation.org>;
 Thu,  3 Jun 2021 07:37:35 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.133.124])
 by smtp1.osuosl.org (Postfix) with ESMTPS id EB62D83DE0
 for <virtualization@lists.linux-foundation.org>;
 Thu,  3 Jun 2021 07:37:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1622705853;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=pn+lH6sffLfQFOlhNqIHBoOQtQXxd+QKLAWzZG0wEls=;
 b=jNLHu0GfIUerSFeF4wboz6siqDqNoK2jruC9s+rULYR1YGk/iDpbY7a+oNADGY/Giou6yn
 PTM6wFgpiFMlHPyxc3Mc9PKhbAVgN8oNT7WvMHh9YAjWeuz32xLQylEq9iygFat0hRXcO6
 a0MdK91Tgup3QRY+OuZHC/sc4+E1Q6c=
Received: from mail-pf1-f199.google.com (mail-pf1-f199.google.com
 [209.85.210.199]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-10-L3SzfGZKPh-okbfH4wU1RA-1; Thu, 03 Jun 2021 03:37:32 -0400
X-MC-Unique: L3SzfGZKPh-okbfH4wU1RA-1
Received: by mail-pf1-f199.google.com with SMTP id
 j19-20020a62b6130000b02902e93e6ca980so3042743pff.10
 for <virtualization@lists.linux-foundation.org>;
 Thu, 03 Jun 2021 00:37:32 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-transfer-encoding
 :content-language;
 bh=pn+lH6sffLfQFOlhNqIHBoOQtQXxd+QKLAWzZG0wEls=;
 b=PRhO3G/OCnWZvuiuaGJJvGaflatQLwzscscOlHjSbKrtWO2njIAILs+COaQVdEFWKC
 1BbktL1oRRFvgwSMVCosbo0gDJXB0BtQpNahKiJlK/4OI+zaMsLWoXj+qkLXUCJcoP9i
 8Urc5zusrK0kdtA6K0ndpo/e2CBo0kI1EoR/1dCowOYWmoVB1E2hshfNU9Pwa+ikFaol
 Mwbl6VrtwFnPBN0kaObF7xT6LGFLVShkx/vyJgXG2aGFuA1HZ/23mwy5R2D/tQtsF2ji
 4LV0leYhUUXkpkVJD5axtIakTXoWA7O7NVZdw29GRlRSWHVxaktb6NbhB+T0l8/2+mDJ
 DsuQ==
X-Gm-Message-State: AOAM531AHzchayoX6Fi8VFbfb8ox8YW3Z0Fa6AQb6ds4E3KHO0NDMQsG
 6c42SZ30lbbXPCTbEgqQJgTqUD+DbxyMjYlcONleK3fhK839hEkjSRI/4KyOPTD9egQZ1hBuvJx
 VjKrvouHm2PItDtkbI6fV7zKgYrHfgwCzfUs16Of4pQ==
X-Received: by 2002:a17:90a:390d:: with SMTP id
 y13mr35351557pjb.52.1622705851185; 
 Thu, 03 Jun 2021 00:37:31 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJyTqWD/nEiY9eQgpWpCRmj0CbNPmYM6Y2ORnmD/a5cBt9X5O5wta2GGPKhK8EoVnMkzO6bZ9Q==
X-Received: by 2002:a17:90a:390d:: with SMTP id
 y13mr35351532pjb.52.1622705850859; 
 Thu, 03 Jun 2021 00:37:30 -0700 (PDT)
Received: from wangxiaodeMacBook-Air.local ([209.132.188.80])
 by smtp.gmail.com with ESMTPSA id s15sm1404541pjr.18.2021.06.03.00.37.28
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 03 Jun 2021 00:37:30 -0700 (PDT)
Subject: Re: [PATCH] vdpa/mlx5: Clear vq ready indication upon device reset
To: Eli Cohen <elic@nvidia.com>
References: <20210602085924.62777-1-elic@nvidia.com>
 <6e4f9e1b-2c67-fae6-6edd-1982d0f48e22@redhat.com>
 <782562f2-6903-68cb-d753-ac90aea854e4@redhat.com>
 <20210603073046.GA58414@mtl-vdi-166.wap.labs.mlnx>
From: Jason Wang <jasowang@redhat.com>
Message-ID: <af2561a4-7b46-3c0c-2956-f5dd37577b8d@redhat.com>
Date: Thu, 3 Jun 2021 15:37:23 +0800
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:78.0)
 Gecko/20100101 Thunderbird/78.10.2
MIME-Version: 1.0
In-Reply-To: <20210603073046.GA58414@mtl-vdi-166.wap.labs.mlnx>
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=jasowang@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Language: en-US
Cc: virtualization@lists.linux-foundation.org, linux-kernel@vger.kernel.org,
 mst@redhat.com
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

CuWcqCAyMDIxLzYvMyDkuIvljYgzOjMwLCBFbGkgQ29oZW4g5YaZ6YGTOgo+IE9uIFRodSwgSnVu
IDAzLCAyMDIxIGF0IDAzOjA2OjMxUE0gKzA4MDAsIEphc29uIFdhbmcgd3JvdGU6Cj4+IOWcqCAy
MDIxLzYvMyDkuIvljYgzOjAwLCBKYXNvbiBXYW5nIOWGmemBkzoKPj4+IOWcqCAyMDIxLzYvMiDk
uIvljYg0OjU5LCBFbGkgQ29oZW4g5YaZ6YGTOgo+Pj4+IEFmdGVyIGRldmljZSByZXNldCwgdGhl
IHZpcnRxdWV1ZXMgYXJlIG5vdCByZWFkeSBzbyBjbGVhciB0aGUgcmVhZHkKPj4+PiBmaWVsZC4K
Pj4+Pgo+Pj4+IEZhaWxpbmcgdG8gZG8gc28gY2FuIHJlc3VsdCBpbiB2aXJ0aW9fdmRwYSBmYWls
aW5nIHRvIGxvYWQgaWYgdGhlIGRldmljZQo+Pj4+IHdhcyBwcmV2aW91c2x5IHVzZWQgYnkgdmhv
c3RfdmRwYSBhbmQgdGhlIG9sZCB2YWx1ZXMgYXJlIHJlYWR5Lgo+Pj4+IHZpcnRpb192ZHBhIGV4
cGVjdHMgdG8gZmluZCBWUXMgaW4gIm5vdCByZWFkeSIgc3RhdGUuCj4+Pj4KPj4+PiBGaXhlczog
MWE4NmIzNzdhYTIxICgidmRwYS9tbHg1OiBBZGQgVkRQQSBkcml2ZXIgZm9yIHN1cHBvcnRlZCBt
bHg1Cj4+Pj4gZGV2aWNlcyIpCj4+Pj4gU2lnbmVkLW9mZi1ieTogRWxpIENvaGVuIDxlbGljQG52
aWRpYS5jb20+Cj4+Pgo+Pj4gQWNrZWQtYnk6IEphc29uIFdhbmcgPGphc293YW5nQHJlZGhhdC5j
b20+Cj4+Cj4+IEEgc2Vjb25kIHRob3VnaHQuCj4+Cj4+IGRlc3Ryb3lfdmlydHF1ZXVlKCkgY291
bGQgYmUgY2FsbGVkIG1hbnkgcGxhY2VzLgo+Pgo+PiBPbmUgb2YgdGhlbSBpcyB0aGUgbWx4NV92
ZHBhX2NoYW5nZV9tYXAoKSwgaWYgdGhpcyBpcyBjYXNlLCB0aGlzIGxvb2tzCj4+IHdyb25nLgo+
IFJpZ2h0LCBhbHRob3VnaCBtb3N0IGxpa2VseSBWUXMgYmVjb21lIHJlYWR5IG9ubHkgYWZ0ZXIg
YWxsIG1hcCBjaGFuZ2VzCj4gb2NjdXIgYmVjdWFzZSBJIGRpZCBub3QgZW5jb3VudGVyIGFueSBp
c3N1ZSB3aGlsZSB0ZXN0aW5nLgoKClllcywgYnV0IGl0J3Mgbm90IGd1YXJhbnRlZWQgdGhhdCB0
aGUgbWFwIHdvbid0IGJlIGNoYW5nZWQuIFVzZXJzcGFjZSAKY2FuIHVwZGF0ZSB0aGUgbWFwcGlu
ZyB3aGVuIG5ldyBtZW1vcnkgaXMgcGx1Z2dlZCBpbnRvIHRoZSBndWVzdCBmb3IgCmV4YW1wbGUu
CgoKPj4gSXQgbG9va3MgdG8gbWUgaXQncyBzaW1wbGVyIHRvIGRvIHRoaXMgaW4gY2xlYXJfdmly
dHF1ZXVlcygpIHdoaWNoIGNhbiBvbmx5Cj4+IGJlIGNhbGxlZCBkdXJpbmcgcmVzZXQuCj4gVGhl
cmUgaXMgbm8gY2xlYXJfdmlydHF1ZXVlcygpIGZ1bmN0aW9uLiBZb3UgcHJvYmFibHkgbWVhbiB0
byBpbnNlcnQgYQo+IGNhbGwgaW4gbWx4NV92ZHBhX3NldF9zdGF0dXMoKSBpbiBjYXNlIGl0IHBl
cmZvcm1zIHJlc2V0LiBUaGlzIGZ1bmN0aW9uCj4gd2lsbCBnbyBvdmVyIGFsbCB2aXJ0cXVldWVz
IGFuZCBjbGVhciB0aGVpciByZWFkeSBmbGFnLgoKClJpZ2h0LgoKCj4KPiBBbHRlcm5hdGl2ZWx5
IHdlIGNhbiBhZGQgYm9vbGVhbiBhcmd1bWVudCB0byB0ZWFyZG93bl9kcml2ZXIoKSB0aGF0Cj4g
c2lnbmlmaWVzIGlmIHdlIGFyZSBpbiByZXNldCBmbG93IGFuZCBpbiB0aGlzIGNhc2Ugd2UgY2xl
YXIgcmVhZHkuCgoKWWVzLCBidXQgZG9pbmcgaW4gc2V0X3N0YXR1cygpIHNlZW1zIGVhc2llci4K
ClRoYW5rcwoKCj4KPj4gVGhhbmtzCj4+Cj4+Cj4+Pgo+Pj4+IC0tLQo+Pj4+ICDCoCBkcml2ZXJz
L3ZkcGEvbWx4NS9uZXQvbWx4NV92bmV0LmMgfCAxICsKPj4+PiAgwqAgMSBmaWxlIGNoYW5nZWQs
IDEgaW5zZXJ0aW9uKCspCj4+Pj4KPj4+PiBkaWZmIC0tZ2l0IGEvZHJpdmVycy92ZHBhL21seDUv
bmV0L21seDVfdm5ldC5jCj4+Pj4gYi9kcml2ZXJzL3ZkcGEvbWx4NS9uZXQvbWx4NV92bmV0LmMK
Pj4+PiBpbmRleCAwMmEwNTQ5MjIwNGMuLmU4YmMwODQyYjQ0YyAxMDA2NDQKPj4+PiAtLS0gYS9k
cml2ZXJzL3ZkcGEvbWx4NS9uZXQvbWx4NV92bmV0LmMKPj4+PiArKysgYi9kcml2ZXJzL3ZkcGEv
bWx4NS9uZXQvbWx4NV92bmV0LmMKPj4+PiBAQCAtODYyLDYgKzg2Miw3IEBAIHN0YXRpYyB2b2lk
IGRlc3Ryb3lfdmlydHF1ZXVlKHN0cnVjdAo+Pj4+IG1seDVfdmRwYV9uZXQgKm5kZXYsIHN0cnVj
dCBtbHg1X3ZkcGFfdmlydHEKPj4+PiAgwqDCoMKgwqDCoMKgwqDCoMKgIHJldHVybjsKPj4+PiAg
wqDCoMKgwqDCoCB9Cj4+Pj4gIMKgwqDCoMKgwqAgdW1lbXNfZGVzdHJveShuZGV2LCBtdnEpOwo+
Pj4+ICvCoMKgwqAgbXZxLT5yZWFkeSA9IGZhbHNlOwo+Pj4+ICDCoCB9Cj4+Pj4gIMKgIMKgIHN0
YXRpYyB1MzIgZ2V0X3JxcG4oc3RydWN0IG1seDVfdmRwYV92aXJ0cXVldWUgKm12cSwgYm9vbCBm
dykKCl9fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fClZpcnR1
YWxpemF0aW9uIG1haWxpbmcgbGlzdApWaXJ0dWFsaXphdGlvbkBsaXN0cy5saW51eC1mb3VuZGF0
aW9uLm9yZwpodHRwczovL2xpc3RzLmxpbnV4Zm91bmRhdGlvbi5vcmcvbWFpbG1hbi9saXN0aW5m
by92aXJ0dWFsaXphdGlvbg==
