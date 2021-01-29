Return-Path: <SRS0=XmMV=HA=lists.linux-foundation.org=virtualization-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 713B7C433E0
	for <virtualization@archiver.kernel.org>; Fri, 29 Jan 2021 09:19:02 +0000 (UTC)
Received: from fraxinus.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D22CB64E16
	for <virtualization@archiver.kernel.org>; Fri, 29 Jan 2021 09:19:01 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D22CB64E16
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=virtualization-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by fraxinus.osuosl.org (Postfix) with ESMTP id 664F686A14;
	Fri, 29 Jan 2021 09:19:01 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from fraxinus.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id NrHZbdZQuyDA; Fri, 29 Jan 2021 09:19:00 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by fraxinus.osuosl.org (Postfix) with ESMTP id A81B386A02;
	Fri, 29 Jan 2021 09:19:00 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 7C322C0FA8;
	Fri, 29 Jan 2021 09:19:00 +0000 (UTC)
Received: from hemlock.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by lists.linuxfoundation.org (Postfix) with ESMTP id BDD34C08A1
 for <virtualization@lists.linux-foundation.org>;
 Fri, 29 Jan 2021 09:18:58 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by hemlock.osuosl.org (Postfix) with ESMTP id AA4F187307
 for <virtualization@lists.linux-foundation.org>;
 Fri, 29 Jan 2021 09:18:58 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from hemlock.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id BdTk+uo9MSyc
 for <virtualization@lists.linux-foundation.org>;
 Fri, 29 Jan 2021 09:18:57 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [216.205.24.124])
 by hemlock.osuosl.org (Postfix) with ESMTPS id 8540987302
 for <virtualization@lists.linux-foundation.org>;
 Fri, 29 Jan 2021 09:18:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1611911936;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=gBiMzqF4ldVHdPCVdvTe25OGWfu60cgEQJVVkz3Qdhk=;
 b=gUkd8SOwgglwhMJzzQnXTWGDPjpS3m7IJiXqgXH7C4yqseW33qirRgJ2CfdKyfSbNDDbRy
 sitie3nicoHfU60OqOOAyC7xRItc2GaCBCu2/alc8POUzqQMWcVHk9W1VjHVyP2j8uaIAs
 N4WySfz18BTjsxmeMyBKbp6yl0BAmBA=
Received: from mail-ed1-f71.google.com (mail-ed1-f71.google.com
 [209.85.208.71]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-423-tWworg6cMpurGp0UkWej5g-1; Fri, 29 Jan 2021 04:18:54 -0500
X-MC-Unique: tWworg6cMpurGp0UkWej5g-1
Received: by mail-ed1-f71.google.com with SMTP id u26so3722743edv.18
 for <virtualization@lists.linux-foundation.org>;
 Fri, 29 Jan 2021 01:18:54 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:content-transfer-encoding
 :in-reply-to;
 bh=gBiMzqF4ldVHdPCVdvTe25OGWfu60cgEQJVVkz3Qdhk=;
 b=Igum3ztvnPJZhOZFWkTPXvn8/zJ5f7PBC+p5daQMyipA+uJD6eZ4HCNZCyG7biWYPJ
 Nu1UpCgAbWbIs+8Miw0VLGCnX+ipQtEVcaO4T9hSb/ScM9PEwES54P0xprIkErp/y27v
 dXluvq+DqYl1sA5uLfjgsl6G+qCd19ijfcQ+tJYJv2yehHPesEiqshwZxE/Fvi7vmcZl
 bgJjGfYQDORCf7KlDFbYi1l60BeUdYT0VWCF6zsNYDEzTaRySb+O3bJXfQxsZMmtKYeC
 1XE1TRk15bg9gTMD4ek+VxDZvnsM/EG+lLHW+OTFE/gEktGK57MAx9WIDfNNHfCBZpNS
 Z06A==
X-Gm-Message-State: AOAM5319IzJYRHVm4kD6Ia7L8RN5AkPo4NDRvejKyAJ96NGhNE+Fmc70
 4ahJDoXjZegu6b62DN1HQdXxBWkIcdXuGtG4Ep+4s+Gkl+r8eFCIjbfvI797j66wSn+gwCBjjdb
 Vman0jM04D/j+4rXz5euim54des+W1tnDkqPdV+J36g==
X-Received: by 2002:a05:6402:2c5:: with SMTP id
 b5mr4212993edx.258.1611911933289; 
 Fri, 29 Jan 2021 01:18:53 -0800 (PST)
X-Google-Smtp-Source: ABdhPJxv70UsNPlttHGeVr2Utze3TPdP0/C2Ahli6ZoBUqAlIj5guXO9TEAHWS9puKSLQ1oETd/nlw==
X-Received: by 2002:a05:6402:2c5:: with SMTP id
 b5mr4212974edx.258.1611911933077; 
 Fri, 29 Jan 2021 01:18:53 -0800 (PST)
Received: from steredhat (host-79-34-249-199.business.telecomitalia.it.
 [79.34.249.199])
 by smtp.gmail.com with ESMTPSA id s1sm3578043ejx.25.2021.01.29.01.18.51
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 29 Jan 2021 01:18:52 -0800 (PST)
Date: Fri, 29 Jan 2021 10:18:50 +0100
From: Stefano Garzarella <sgarzare@redhat.com>
To: Jason Wang <jasowang@redhat.com>
Subject: Re: [PATCH RFC v2 02/10] vringh: add 'iotlb_lock' to synchronize
 iotlb accesses
Message-ID: <20210129091850.gatf3ih3knw2p4l4@steredhat>
References: <20210128144127.113245-1-sgarzare@redhat.com>
 <20210128144127.113245-3-sgarzare@redhat.com>
 <017f6e69-b2ec-aed0-5920-a389199e4cf9@redhat.com>
MIME-Version: 1.0
In-Reply-To: <017f6e69-b2ec-aed0-5920-a389199e4cf9@redhat.com>
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=sgarzare@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Disposition: inline
Cc: Laurent Vivier <lvivier@redhat.com>, Max Gurtovoy <mgurtovoy@nvidia.com>,
 kvm@vger.kernel.org, "Michael S. Tsirkin" <mst@redhat.com>,
 linux-kernel@vger.kernel.org, virtualization@lists.linux-foundation.org,
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

T24gRnJpLCBKYW4gMjksIDIwMjEgYXQgMDM6NDM6NDBQTSArMDgwMCwgSmFzb24gV2FuZyB3cm90
ZToKPgo+T24gMjAyMS8xLzI4IOS4i+WNiDEwOjQxLCBTdGVmYW5vIEdhcnphcmVsbGEgd3JvdGU6
Cj4+VXN1YWxseSBpb3RsYiBhY2Nlc3NlcyBhcmUgc3luY2hyb25pemVkIHdpdGggYSBzcGlubG9j
ay4KPj5MZXQncyByZXF1ZXN0IGl0IGFzIGEgbmV3IHBhcmFtZXRlciBpbiB2cmluZ2hfc2V0X2lv
dGxiKCkgYW5kCj4+aG9sZCBpdCB3aGVuIHdlIG5hdmlnYXRlIHRoZSBpb3RsYiBpbiBpb3RsYl90
cmFuc2xhdGUoKSB0byBhdm9pZAo+PnJhY2UgY29uZGl0aW9ucyB3aXRoIGFueSBuZXcgYWRkaXRp
b25zL2RlbGV0aW9ucyBvZiByYW5nZXMgZnJvbQo+PnRoZSBpb2x0Yi4KPgo+Cj5QYXRjaCBsb29r
cyBmaW5lIGJ1dCBJIHdvbmRlciBpZiB0aGlzIGlzIHRoZSBiZXN0IGFwcHJvYWNoIGNvbXBhcmlu
ZyAKPnRvIGRvIGxvY2tpbmcgYnkgdGhlIGNhbGxlci4KCkluaXRpYWxseSBJIHRyaWVkIHRvIGhv
bGQgdGhlIGxvY2sgaW4gdGhlIHZkcGFzaW1fYmxrX3dvcmsoKSwgYnV0IHNpbmNlCndlIGhhdmUg
YSBsb3Qgb2YgZGlmZmVyZW50IGZ1bmN0aW9ucyBmb3IgdnJpbmdoLCBJIG9wdGVkIHRvIHRha2Ug
dGhlIApsb2NrIGF0IHRoZSBiZWdpbm5pbmcgYW5kIHJlbGVhc2UgaXQgYXQgdGhlIGVuZC4KQWxz
byBiZWNhdXNlIHNldmVyYWwgdGltZXMgSSB3ZW50IHRvIHNlZSBpZiB0aGF0IGNhbGwgdXNlZCAK
aW90bGJfdHJhbnNsYXRlIG9yIG5vdC4KClRoaXMgY291bGQgYmUgYSBwcm9ibGVtIGZvciBleGFt
cGxlIGlmIHdlIGhhdmUgbXVsdGlwbGUgd29ya2VycyB0byAKaGFuZGxlIG11bHRpcGxlIHF1ZXVl
cy4KCkFsc28sIHNvbWUgZnVuY3Rpb25zIGFyZSBxdWl0ZSBsb25nIChlLmcuIHZyaW5naF9nZXRk
ZXNjX2lvdGxiKSBhbmQgCmhvbGRpbmcgdGhlIGxvY2sgZm9yIHRoYXQgbG9uZyBjb3VsZCByZWR1
Y2UgcGFyYWxsZWxpc20uCgpGb3IgdGhlc2UgcmVhc29ucyBJIHRob3VnaHQgaXQgd2FzIGJldHRl
ciB0byBoaWRlIGV2ZXJ5dGhpbmcgZnJvbSB0aGUgCmNhbGxlciB3aG8gZG9lc24ndCBoYXZlIHRv
IHdvcnJ5IGFib3V0IHdoaWNoIGZ1bmN0aW9uIGNhbGxzIAppb3RsYl90cmFuc2xhdGUoKSBhbmQg
dGh1cyBob2xkIHRoZSBsb2NrLgoKVGhhbmtzLApTdGVmYW5vCgo+Cj5UaGFua3MKPgo+Cj4+Cj4+
U2lnbmVkLW9mZi1ieTogU3RlZmFubyBHYXJ6YXJlbGxhIDxzZ2FyemFyZUByZWRoYXQuY29tPgo+
Pi0tLQo+PiAgaW5jbHVkZS9saW51eC92cmluZ2guaCAgICAgICAgICAgfCA2ICsrKysrLQo+PiAg
ZHJpdmVycy92ZHBhL3ZkcGFfc2ltL3ZkcGFfc2ltLmMgfCAzICsrLQo+PiAgZHJpdmVycy92aG9z
dC92cmluZ2guYyAgICAgICAgICAgfCA5ICsrKysrKysrLQo+PiAgMyBmaWxlcyBjaGFuZ2VkLCAx
NSBpbnNlcnRpb25zKCspLCAzIGRlbGV0aW9ucygtKQo+Pgo+PmRpZmYgLS1naXQgYS9pbmNsdWRl
L2xpbnV4L3ZyaW5naC5oIGIvaW5jbHVkZS9saW51eC92cmluZ2guaAo+PmluZGV4IDU5YmQ1MGY5
OTI5MS4uOWMwNzc4NjNjOGY2IDEwMDY0NAo+Pi0tLSBhL2luY2x1ZGUvbGludXgvdnJpbmdoLmgK
Pj4rKysgYi9pbmNsdWRlL2xpbnV4L3ZyaW5naC5oCj4+QEAgLTQ2LDYgKzQ2LDkgQEAgc3RydWN0
IHZyaW5naCB7Cj4+ICAJLyogSU9UTEIgZm9yIHRoaXMgdnJpbmcgKi8KPj4gIAlzdHJ1Y3Qgdmhv
c3RfaW90bGIgKmlvdGxiOwo+PisJLyogc3BpbmxvY2sgdG8gc3luY2hyb25pemUgSU9UTEIgYWNj
ZXNzZXMgKi8KPj4rCXNwaW5sb2NrX3QgKmlvdGxiX2xvY2s7Cj4+Kwo+PiAgCS8qIFRoZSBmdW5j
dGlvbiB0byBjYWxsIHRvIG5vdGlmeSB0aGUgZ3Vlc3QgYWJvdXQgYWRkZWQgYnVmZmVycyAqLwo+
PiAgCXZvaWQgKCpub3RpZnkpKHN0cnVjdCB2cmluZ2ggKik7Cj4+ICB9Owo+PkBAIC0yNTgsNyAr
MjYxLDggQEAgc3RhdGljIGlubGluZSBfX3ZpcnRpbzY0IGNwdV90b192cmluZ2g2NChjb25zdCBz
dHJ1Y3QgdnJpbmdoICp2cmgsIHU2NCB2YWwpCj4+ICAjaWYgSVNfUkVBQ0hBQkxFKENPTkZJR19W
SE9TVF9JT1RMQikKPj4tdm9pZCB2cmluZ2hfc2V0X2lvdGxiKHN0cnVjdCB2cmluZ2ggKnZyaCwg
c3RydWN0IHZob3N0X2lvdGxiICppb3RsYik7Cj4+K3ZvaWQgdnJpbmdoX3NldF9pb3RsYihzdHJ1
Y3QgdnJpbmdoICp2cmgsIHN0cnVjdCB2aG9zdF9pb3RsYiAqaW90bGIsCj4+KwkJICAgICAgc3Bp
bmxvY2tfdCAqaW90bGJfbG9jayk7Cj4+ICBpbnQgdnJpbmdoX2luaXRfaW90bGIoc3RydWN0IHZy
aW5naCAqdnJoLCB1NjQgZmVhdHVyZXMsCj4+ICAJCSAgICAgIHVuc2lnbmVkIGludCBudW0sIGJv
b2wgd2Vha19iYXJyaWVycywKPj5kaWZmIC0tZ2l0IGEvZHJpdmVycy92ZHBhL3ZkcGFfc2ltL3Zk
cGFfc2ltLmMgYi9kcml2ZXJzL3ZkcGEvdmRwYV9zaW0vdmRwYV9zaW0uYwo+PmluZGV4IDIxODNh
ODMzZmNmNC4uNTMyMzg5ODk3MTNkIDEwMDY0NAo+Pi0tLSBhL2RyaXZlcnMvdmRwYS92ZHBhX3Np
bS92ZHBhX3NpbS5jCj4+KysrIGIvZHJpdmVycy92ZHBhL3ZkcGFfc2ltL3ZkcGFfc2ltLmMKPj5A
QCAtMjg0LDcgKzI4NCw4IEBAIHN0cnVjdCB2ZHBhc2ltICp2ZHBhc2ltX2NyZWF0ZShzdHJ1Y3Qg
dmRwYXNpbV9kZXZfYXR0ciAqZGV2X2F0dHIpCj4+ICAJCWdvdG8gZXJyX2lvbW11Owo+PiAgCWZv
ciAoaSA9IDA7IGkgPCBkZXZfYXR0ci0+bnZxczsgaSsrKQo+Pi0JCXZyaW5naF9zZXRfaW90bGIo
JnZkcGFzaW0tPnZxc1tpXS52cmluZywgdmRwYXNpbS0+aW9tbXUpOwo+PisJCXZyaW5naF9zZXRf
aW90bGIoJnZkcGFzaW0tPnZxc1tpXS52cmluZywgdmRwYXNpbS0+aW9tbXUsCj4+KwkJCQkgJnZk
cGFzaW0tPmlvbW11X2xvY2spOwo+PiAgCXJldCA9IGlvdmFfY2FjaGVfZ2V0KCk7Cj4+ICAJaWYg
KHJldCkKPj5kaWZmIC0tZ2l0IGEvZHJpdmVycy92aG9zdC92cmluZ2guYyBiL2RyaXZlcnMvdmhv
c3QvdnJpbmdoLmMKPj5pbmRleCA4NWQ4NWZhYmEwNTguLmY2ODEyMjcwNTcxOSAxMDA2NDQKPj4t
LS0gYS9kcml2ZXJzL3Zob3N0L3ZyaW5naC5jCj4+KysrIGIvZHJpdmVycy92aG9zdC92cmluZ2gu
Ywo+PkBAIC0xMDc0LDYgKzEwNzQsOCBAQCBzdGF0aWMgaW50IGlvdGxiX3RyYW5zbGF0ZShjb25z
dCBzdHJ1Y3QgdnJpbmdoICp2cmgsCj4+ICAJaW50IHJldCA9IDA7Cj4+ICAJdTY0IHMgPSAwOwo+
PisJc3Bpbl9sb2NrKHZyaC0+aW90bGJfbG9jayk7Cj4+Kwo+PiAgCXdoaWxlIChsZW4gPiBzKSB7
Cj4+ICAJCXU2NCBzaXplLCBwYSwgcGZuOwo+PkBAIC0xMTAzLDYgKzExMDUsOCBAQCBzdGF0aWMg
aW50IGlvdGxiX3RyYW5zbGF0ZShjb25zdCBzdHJ1Y3QgdnJpbmdoICp2cmgsCj4+ICAJCSsrcmV0
Owo+PiAgCX0KPj4rCXNwaW5fdW5sb2NrKHZyaC0+aW90bGJfbG9jayk7Cj4+Kwo+PiAgCXJldHVy
biByZXQ7Cj4+ICB9Cj4+QEAgLTEyNjIsMTAgKzEyNjYsMTMgQEAgRVhQT1JUX1NZTUJPTCh2cmlu
Z2hfaW5pdF9pb3RsYik7Cj4+ICAgKiB2cmluZ2hfc2V0X2lvdGxiIC0gaW5pdGlhbGl6ZSBhIHZy
aW5naCBmb3IgYSByaW5nIHdpdGggSU9UTEIuCj4+ICAgKiBAdnJoOiB0aGUgdnJpbmcKPj4gICAq
IEBpb3RsYjogaW90bGIgYXNzb2NpYXRlZCB3aXRoIHRoaXMgdnJpbmcKPj4rICogQGlvdGxiX2xv
Y2s6IHNwaW5sb2NrIHRvIHN5bmNocm9uaXplIHRoZSBpb3RsYiBhY2Nlc3Nlcwo+PiAgICovCj4+
LXZvaWQgdnJpbmdoX3NldF9pb3RsYihzdHJ1Y3QgdnJpbmdoICp2cmgsIHN0cnVjdCB2aG9zdF9p
b3RsYiAqaW90bGIpCj4+K3ZvaWQgdnJpbmdoX3NldF9pb3RsYihzdHJ1Y3QgdnJpbmdoICp2cmgs
IHN0cnVjdCB2aG9zdF9pb3RsYiAqaW90bGIsCj4+KwkJICAgICAgc3BpbmxvY2tfdCAqaW90bGJf
bG9jaykKPj4gIHsKPj4gIAl2cmgtPmlvdGxiID0gaW90bGI7Cj4+Kwl2cmgtPmlvdGxiX2xvY2sg
PSBpb3RsYl9sb2NrOwo+PiAgfQo+PiAgRVhQT1JUX1NZTUJPTCh2cmluZ2hfc2V0X2lvdGxiKTsK
PgoKX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18KVmlydHVh
bGl6YXRpb24gbWFpbGluZyBsaXN0ClZpcnR1YWxpemF0aW9uQGxpc3RzLmxpbnV4LWZvdW5kYXRp
b24ub3JnCmh0dHBzOi8vbGlzdHMubGludXhmb3VuZGF0aW9uLm9yZy9tYWlsbWFuL2xpc3RpbmZv
L3ZpcnR1YWxpemF0aW9u
