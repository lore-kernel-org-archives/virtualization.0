Return-Path: <SRS0=59V0=JE=lists.linux-foundation.org=virtualization-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 78C96C433B4
	for <virtualization@archiver.kernel.org>; Wed,  7 Apr 2021 13:38:42 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 06D6761246
	for <virtualization@archiver.kernel.org>; Wed,  7 Apr 2021 13:38:41 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 06D6761246
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=virtualization-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id A885760C20;
	Wed,  7 Apr 2021 13:38:41 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
	by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id FzPFUxTrlDsA; Wed,  7 Apr 2021 13:38:40 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp3.osuosl.org (Postfix) with ESMTP id 357606060E;
	Wed,  7 Apr 2021 13:38:40 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 13B34C000C;
	Wed,  7 Apr 2021 13:38:40 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 303B5C000A
 for <virtualization@lists.linux-foundation.org>;
 Wed,  7 Apr 2021 13:38:39 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id 1E94D403A7
 for <virtualization@lists.linux-foundation.org>;
 Wed,  7 Apr 2021 13:38:39 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp4.osuosl.org (amavisd-new);
 dkim=pass (1024-bit key) header.d=redhat.com
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id T48J9PfTfj7d
 for <virtualization@lists.linux-foundation.org>;
 Wed,  7 Apr 2021 13:38:35 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.133.124])
 by smtp4.osuosl.org (Postfix) with ESMTPS id 45E44403AC
 for <virtualization@lists.linux-foundation.org>;
 Wed,  7 Apr 2021 13:38:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1617802714;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=dWwxHoy/yDJ/WZrKrBZ8PE81AojcOOvWYhj/YXMxJZA=;
 b=XZXbHyItmxJgodWbxxBtqJmXYqxC2HqU9nmHIKkOqwLNkO6zvQFgc85CB6rwq4mBU8douB
 6X21huDuLDZ8m7twC6tnWLF/MdacmZ4samLqLWJbSomvzfS+ClCxv+WxqolpnXJ0NXOA29
 LbEgTrGh6/m/ae/JU1qmoUN9+cMLWNg=
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-294-QJTiZPa_M4uX4mIC_tO77A-1; Wed, 07 Apr 2021 09:38:28 -0400
X-MC-Unique: QJTiZPa_M4uX4mIC_tO77A-1
Received: by mail-wr1-f72.google.com with SMTP id z6so11755381wrh.11
 for <virtualization@lists.linux-foundation.org>;
 Wed, 07 Apr 2021 06:38:28 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:content-transfer-encoding
 :in-reply-to;
 bh=dWwxHoy/yDJ/WZrKrBZ8PE81AojcOOvWYhj/YXMxJZA=;
 b=XiSo5ocyoKQVZ5l4yiHN/mxl7LDojJzBPwqgnxLfBtH/th0biforHd14N3BcHsvj8v
 +sNb+fsxjAeAqfpI72wYUzXp8TE2uHF6AFreok+Auj5lgKXZJ47sOIqCoYM2Rb2wYN9J
 YMPBdo4AOY6wVG6H3t4wwaXQzhaD8rKr/hYigbl4bxA2L0Tuf3MIlW3nqV3+mRp1WVij
 Kno94569XSn3o2NhNxokGz36vcbHBV4dzRe8MZL9B6T+9LkJmjG8L9WvinCdxjDbzE4g
 Z65Z9LB5zG2Q6ezNesrRI6QOX/ZT/4iQBhlbolVjtqO/uVh7Q7ivqejng0czqRSaNs1w
 auxw==
X-Gm-Message-State: AOAM530kGJ2SygTkzKu4sSgPDIbCAIp7uCGH8sUOxGYksQp9UYB+Nhch
 SBQIJRbRog77DicSe6uFAFZEU0teTxfXxPmlAtGzGqlqEItSaAxOAUeuHDD7LV4asA++b7SsVFL
 Wm+SE49hs2kf9bcOw5TK+n8b3srJn9p+W6UzcheF1pQ==
X-Received: by 2002:a5d:6384:: with SMTP id p4mr4523841wru.368.1617802706937; 
 Wed, 07 Apr 2021 06:38:26 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJy+On5TH/oMf3w4Pouz4PCvCxnqgRkOy5zSgTe2zuf6Qk489NfRV4WONwwYNc4INddZQ3MR1w==
X-Received: by 2002:a5d:6384:: with SMTP id p4mr4523817wru.368.1617802706676; 
 Wed, 07 Apr 2021 06:38:26 -0700 (PDT)
Received: from redhat.com ([2a10:800e:f0d3:0:b69b:9fb8:3947:5636])
 by smtp.gmail.com with ESMTPSA id u12sm15066095wro.51.2021.04.07.06.38.24
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 07 Apr 2021 06:38:25 -0700 (PDT)
Date: Wed, 7 Apr 2021 09:38:22 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Eli Cohen <elic@nvidia.com>
Subject: Re: [PATCH linux-next v2 13/14] vdpa/mlx5: Fix suspend/resume index
 restoration
Message-ID: <20210407093755-mutt-send-email-mst@kernel.org>
References: <20210406170457.98481-1-parav@nvidia.com>
 <20210406170457.98481-14-parav@nvidia.com>
 <a172fae0-068a-2d0b-c5c4-e15998f2a67d@redhat.com>
 <20210407101612.GB207753@mtl-vdi-166.wap.labs.mlnx>
MIME-Version: 1.0
In-Reply-To: <20210407101612.GB207753@mtl-vdi-166.wap.labs.mlnx>
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=mst@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Disposition: inline
Cc: virtualization@lists.linux-foundation.org
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
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Errors-To: virtualization-bounces@lists.linux-foundation.org
Sender: "Virtualization" <virtualization-bounces@lists.linux-foundation.org>

T24gV2VkLCBBcHIgMDcsIDIwMjEgYXQgMDE6MTY6MTJQTSArMDMwMCwgRWxpIENvaGVuIHdyb3Rl
Ogo+IE9uIFdlZCwgQXByIDA3LCAyMDIxIGF0IDAzOjI1OjAwUE0gKzA4MDAsIEphc29uIFdhbmcg
d3JvdGU6Cj4gPiAKPiA+IOWcqCAyMDIxLzQvNyDkuIrljYgxOjA0LCBQYXJhdiBQYW5kaXQg5YaZ
6YGTOgo+ID4gPiBGcm9tOiBFbGkgQ29oZW4gPGVsaWNAbnZpZGlhLmNvbT4KPiA+ID4gCj4gPiA+
IFdoZW4gd2Ugc3VzcGVuZCB0aGUgVk0sIHRoZSBWRFBBIGludGVyZmFjZSB3aWxsIGJlIHJlc2V0
LiBXaGVuIHRoZSBWTSBpcwo+ID4gPiByZXN1bWVkIGFnYWluLCBjbGVhcl92aXJ0cXVldWVzKCkg
d2lsbCBjbGVhciB0aGUgYXZhaWxhYmxlIGFuZCB1c2VkCj4gPiA+IGluZGljZXMgcmVzdWx0aW5n
IGluIGhhcmR3YXJlIHZpcnF0cXVldWUgb2JqZWN0cyBiZWNvbWluZyBvdXQgb2Ygc3luYy4KPiA+
ID4gV2UgY2FuIGF2b2lkIHRoaXMgZnVuY3Rpb24gYWxsdG9nZXRoZXIgc2luY2UgcWVtdSB3aWxs
IGNsZWFyIHRoZW0gaWYKPiA+ID4gcmVxdWlyZWQsIGUuZy4gd2hlbiB0aGUgVk0gd2VudCB0aHJv
dWdoIGEgcmVib290Lgo+ID4gPiAKPiA+ID4gTW9yZW92ZXIsIHNpbmNlIHRoZSBodyBhdmFpbGFi
bGUgYW5kIHVzZWQgaW5kaWNlcyBzaG91bGQgYWx3YXlzIGJlCj4gPiA+IGlkZW50aWNhbCBvbiBx
dWVyeSBhbmQgc2hvdWxkIGJlIHJlc3RvcmVkIHRvIHRoZSBzYW1lIHZhbHVlIHNhbWUgdmFsdWUK
PiA+ID4gZm9yIHZpcnRxdWV1ZXMgdGhhdCBjb21wbGV0ZSBpbiBvcmRlciwgd2Ugc2V0IHRoZSBz
aW5nbGUgdmFsdWUgcHJvdmlkZWQKPiA+ID4gYnkgc2V0X3ZxX3N0YXRlKCkuIEluIGdldF92cV9z
dGF0ZSgpIHdlIHJldHVybiB0aGUgdmFsdWUgb2YgaGFyZHdhcmUKPiA+ID4gdXNlZCBpbmRleC4K
PiA+ID4gCj4gPiA+IEZpeGVzOiBiMzVjY2ViZTNlZjcgKCJ2ZHBhL21seDU6IFJlc3RvcmUgdGhl
IGhhcmR3YXJlIHVzZWQgaW5kZXggYWZ0ZXIgY2hhbmdlIG1hcCIpCj4gPiA+IEZpeGVzOiAxYTg2
YjM3N2FhMjEgKCJ2ZHBhL21seDU6IEFkZCBWRFBBIGRyaXZlciBmb3Igc3VwcG9ydGVkIG1seDUg
ZGV2aWNlcyIpCj4gPiA+IFNpZ25lZC1vZmYtYnk6IEVsaSBDb2hlbiA8ZWxpY0BudmlkaWEuY29t
Pgo+ID4gPiAtLS0KPiA+ID4gICBkcml2ZXJzL3ZkcGEvbWx4NS9uZXQvbWx4NV92bmV0LmMgfCAx
NyArKysrLS0tLS0tLS0tLS0tLQo+ID4gPiAgIDEgZmlsZSBjaGFuZ2VkLCA0IGluc2VydGlvbnMo
KyksIDEzIGRlbGV0aW9ucygtKQo+ID4gPiAKPiA+ID4gZGlmZiAtLWdpdCBhL2RyaXZlcnMvdmRw
YS9tbHg1L25ldC9tbHg1X3ZuZXQuYyBiL2RyaXZlcnMvdmRwYS9tbHg1L25ldC9tbHg1X3ZuZXQu
Ywo+ID4gPiBpbmRleCA1NmQ0NjNkMmJlODUuLmE2ZTZkNDRiOWNhNSAxMDA2NDQKPiA+ID4gLS0t
IGEvZHJpdmVycy92ZHBhL21seDUvbmV0L21seDVfdm5ldC5jCj4gPiA+ICsrKyBiL2RyaXZlcnMv
dmRwYS9tbHg1L25ldC9tbHg1X3ZuZXQuYwo+ID4gPiBAQCAtMTE3MCw2ICsxMTcwLDcgQEAgc3Rh
dGljIHZvaWQgc3VzcGVuZF92cShzdHJ1Y3QgbWx4NV92ZHBhX25ldCAqbmRldiwgc3RydWN0IG1s
eDVfdmRwYV92aXJ0cXVldWUgKm0KPiA+ID4gICAJCXJldHVybjsKPiA+ID4gICAJfQo+ID4gPiAg
IAltdnEtPmF2YWlsX2lkeCA9IGF0dHIuYXZhaWxhYmxlX2luZGV4Owo+ID4gPiArCW12cS0+dXNl
ZF9pZHggPSBhdHRyLnVzZWRfaW5kZXg7Cj4gPiA+ICAgfQo+ID4gPiAgIHN0YXRpYyB2b2lkIHN1
c3BlbmRfdnFzKHN0cnVjdCBtbHg1X3ZkcGFfbmV0ICpuZGV2KQo+ID4gPiBAQCAtMTQ2Niw2ICsx
NDY3LDcgQEAgc3RhdGljIGludCBtbHg1X3ZkcGFfc2V0X3ZxX3N0YXRlKHN0cnVjdCB2ZHBhX2Rl
dmljZSAqdmRldiwgdTE2IGlkeCwKPiA+ID4gICAJCXJldHVybiAtRUlOVkFMOwo+ID4gPiAgIAl9
Cj4gPiA+ICsJbXZxLT51c2VkX2lkeCA9IHN0YXRlLT5hdmFpbF9pbmRleDsKPiA+ID4gICAJbXZx
LT5hdmFpbF9pZHggPSBzdGF0ZS0+YXZhaWxfaW5kZXg7Cj4gPiA+ICAgCXJldHVybiAwOwo+ID4g
PiAgIH0KPiA+ID4gQEAgLTE0ODMsNyArMTQ4NSw3IEBAIHN0YXRpYyBpbnQgbWx4NV92ZHBhX2dl
dF92cV9zdGF0ZShzdHJ1Y3QgdmRwYV9kZXZpY2UgKnZkZXYsIHUxNiBpZHgsIHN0cnVjdCB2ZHBh
Cj4gPiA+ICAgCSAqIHRoYXQgY2FyZXMgYWJvdXQgZW11bGF0aW5nIHRoZSBpbmRleCBhZnRlciB2
cSBpcyBzdG9wcGVkLgo+ID4gPiAgIAkgKi8KPiA+ID4gICAJaWYgKCFtdnEtPmluaXRpYWxpemVk
KSB7Cj4gPiA+IC0JCXN0YXRlLT5hdmFpbF9pbmRleCA9IG12cS0+YXZhaWxfaWR4Owo+ID4gPiAr
CQlzdGF0ZS0+YXZhaWxfaW5kZXggPSBtdnEtPnVzZWRfaWR4Owo+ID4gCj4gPiAKPiA+IEV2ZW4g
aWYgdGhlIGhhcmR3YXJlIGF2YWlsIGlkeCBpcyBhbHdheXMgZXF1YWwgdG8gdXNlZCBpZHguIEkg
d291bGQgc3RpbGwKPiA+IGtlZXAgdXNpbmcgdGhlIGF2YWlsX2lkeCwgdGhpcyBtYWtlcyBpdCBl
YXNpZXIgdG8gYmUgcmV2aWV3ZWQgc2luY2UgaXQgaXMKPiA+IGNvbnNpc3RlbnQgdG8gZS5nIGtl
cm5lbCB2aG9zdCBiYWtjZW5kIGltcGxlbWVudGF0aW9ucy4gKFRoZSBsYXN0X2F2YWlsX2lkeAo+
ID4gaW4gdmhvc3RfdmlydHF1ZXVlKS4KPiA+IAo+IAo+IFRoZSBwcm9ibGVtIGlzIHRoYXQgdGhl
cmUgaXMgYSBidWcgaW4gdGhlIGZpcm13YXJlIHN1Y2ggdGhhdCBmb3IgUlgKPiB2aXJ0cXVldWVz
IGZpcm13YXJlIHJldHVybnMgYSB3cm9uZyB2YWx1ZSBpbiB0aGUgYXZhaWxfaWR4LiBUaGUgY29y
cmVjdAo+IHZhbHVlIGlzIHJlcG9ydGVkIGluIHVzZWRfaWR4LiBUaGF0J3Mgd2h5IHdlIG5lZWQg
dG8gdGFrZSB0aGUgdmFsdWUgZnJvbQo+IHVzZWRfaWR4LgoKTWF5YmUgYWRkIGEgY29kZSBjb21t
ZW50IGhlcmUgc28gcGVvcGxlIGNhbiBmaWd1cmUgaXQgb3V0PwoKPiA+IFRoYW5rcwo+ID4gCj4g
PiAKPiA+ID4gICAJCXJldHVybiAwOwo+ID4gPiAgIAl9Cj4gPiA+IEBAIC0xNDkyLDcgKzE0OTQs
NyBAQCBzdGF0aWMgaW50IG1seDVfdmRwYV9nZXRfdnFfc3RhdGUoc3RydWN0IHZkcGFfZGV2aWNl
ICp2ZGV2LCB1MTYgaWR4LCBzdHJ1Y3QgdmRwYQo+ID4gPiAgIAkJbWx4NV92ZHBhX3dhcm4obXZk
ZXYsICJmYWlsZWQgdG8gcXVlcnkgdmlydHF1ZXVlXG4iKTsKPiA+ID4gICAJCXJldHVybiBlcnI7
Cj4gPiA+ICAgCX0KPiA+ID4gLQlzdGF0ZS0+YXZhaWxfaW5kZXggPSBhdHRyLmF2YWlsYWJsZV9p
bmRleDsKPiA+ID4gKwlzdGF0ZS0+YXZhaWxfaW5kZXggPSBhdHRyLnVzZWRfaW5kZXg7Cj4gPiA+
ICAgCXJldHVybiAwOwo+ID4gPiAgIH0KPiA+ID4gQEAgLTE1NzIsMTYgKzE1NzQsNiBAQCBzdGF0
aWMgdm9pZCB0ZWFyZG93bl92aXJ0cXVldWVzKHN0cnVjdCBtbHg1X3ZkcGFfbmV0ICpuZGV2KQo+
ID4gPiAgIAl9Cj4gPiA+ICAgfQo+ID4gPiAtc3RhdGljIHZvaWQgY2xlYXJfdmlydHF1ZXVlcyhz
dHJ1Y3QgbWx4NV92ZHBhX25ldCAqbmRldikKPiA+ID4gLXsKPiA+ID4gLQlpbnQgaTsKPiA+ID4g
LQo+ID4gPiAtCWZvciAoaSA9IG5kZXYtPm12ZGV2Lm1heF92cXMgLSAxOyBpID49IDA7IGktLSkg
ewo+ID4gPiAtCQluZGV2LT52cXNbaV0uYXZhaWxfaWR4ID0gMDsKPiA+ID4gLQkJbmRldi0+dnFz
W2ldLnVzZWRfaWR4ID0gMDsKPiA+ID4gLQl9Cj4gPiA+IC19Cj4gPiA+IC0KPiA+ID4gICAvKiBU
T0RPOiBjcm9zcy1lbmRpYW4gc3VwcG9ydCAqLwo+ID4gPiAgIHN0YXRpYyBpbmxpbmUgYm9vbCBt
bHg1X3ZkcGFfaXNfbGl0dGxlX2VuZGlhbihzdHJ1Y3QgbWx4NV92ZHBhX2RldiAqbXZkZXYpCj4g
PiA+ICAgewo+ID4gPiBAQCAtMTgyMiw3ICsxODE0LDYgQEAgc3RhdGljIHZvaWQgbWx4NV92ZHBh
X3NldF9zdGF0dXMoc3RydWN0IHZkcGFfZGV2aWNlICp2ZGV2LCB1OCBzdGF0dXMpCj4gPiA+ICAg
CWlmICghc3RhdHVzKSB7Cj4gPiA+ICAgCQltbHg1X3ZkcGFfaW5mbyhtdmRldiwgInBlcmZvcm1p
bmcgZGV2aWNlIHJlc2V0XG4iKTsKPiA+ID4gICAJCXRlYXJkb3duX2RyaXZlcihuZGV2KTsKPiA+
ID4gLQkJY2xlYXJfdmlydHF1ZXVlcyhuZGV2KTsKPiA+ID4gICAJCW1seDVfdmRwYV9kZXN0cm95
X21yKCZuZGV2LT5tdmRldik7Cj4gPiA+ICAgCQluZGV2LT5tdmRldi5zdGF0dXMgPSAwOwo+ID4g
PiAgIAkJKyttdmRldi0+Z2VuZXJhdGlvbjsKPiA+IAoKX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX18KVmlydHVhbGl6YXRpb24gbWFpbGluZyBsaXN0ClZpcnR1
YWxpemF0aW9uQGxpc3RzLmxpbnV4LWZvdW5kYXRpb24ub3JnCmh0dHBzOi8vbGlzdHMubGludXhm
b3VuZGF0aW9uLm9yZy9tYWlsbWFuL2xpc3RpbmZvL3ZpcnR1YWxpemF0aW9u
