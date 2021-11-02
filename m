Return-Path: <SRS0=IhT0=PV=lists.linux-foundation.org=virtualization-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3C8CDC433EF
	for <virtualization@archiver.kernel.org>; Tue,  2 Nov 2021 06:35:27 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C8EB3604D2
	for <virtualization@archiver.kernel.org>; Tue,  2 Nov 2021 06:35:26 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org C8EB3604D2
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by smtp2.osuosl.org (Postfix) with ESMTP id 73DC340205;
	Tue,  2 Nov 2021 06:35:26 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
	by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id GPEDG8lVewX1; Tue,  2 Nov 2021 06:35:25 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp2.osuosl.org (Postfix) with ESMTPS id 9A94B401B7;
	Tue,  2 Nov 2021 06:35:24 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 6F21CC0019;
	Tue,  2 Nov 2021 06:35:24 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 1FA20C000E
 for <virtualization@lists.linux-foundation.org>;
 Tue,  2 Nov 2021 06:35:23 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id F21A7606F1
 for <virtualization@lists.linux-foundation.org>;
 Tue,  2 Nov 2021 06:35:22 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp3.osuosl.org (amavisd-new);
 dkim=pass (1024-bit key) header.d=redhat.com
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id pIilEcrXJejN
 for <virtualization@lists.linux-foundation.org>;
 Tue,  2 Nov 2021 06:35:22 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.133.124])
 by smtp3.osuosl.org (Postfix) with ESMTPS id EF53A6067B
 for <virtualization@lists.linux-foundation.org>;
 Tue,  2 Nov 2021 06:35:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1635834920;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=4e5jEhEQuanPUBKoekX0+VcpuIKOOFsqGpOTOqFUkMM=;
 b=fusI9whRz3QxAmLLSIN0dRXmgEtToOn6CZXD3gDMn7q0Ty8Z8a/4qWTOpQXbhORVMN6oQK
 clSolWXtIh46JSI6O7xBb5vd7jcxxyyrAOtcooH8NTKR1nyxcNJ91UGaeH3ItQdZmAQpqi
 re6pdGiQ194ieo2KI7fCPrF9stkjdtI=
Received: from mail-pf1-f199.google.com (mail-pf1-f199.google.com
 [209.85.210.199]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-304-Kd6XxHQNP6qBtht3TsHeXg-1; Tue, 02 Nov 2021 02:35:20 -0400
X-MC-Unique: Kd6XxHQNP6qBtht3TsHeXg-1
Received: by mail-pf1-f199.google.com with SMTP id
 f18-20020aa79d92000000b0048118561271so2312873pfq.21
 for <virtualization@lists.linux-foundation.org>;
 Mon, 01 Nov 2021 23:35:19 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-transfer-encoding
 :content-language;
 bh=4e5jEhEQuanPUBKoekX0+VcpuIKOOFsqGpOTOqFUkMM=;
 b=5IWjNDq1LyQHiWtZdeAKDkgg2B4Xjn+5LRvOzziOC97ncCSYO/zP3EEiMrbWKLuPEo
 dH9F3sLy3cJmvns2Fc99NiFSckauN5OSyHSTW/MdgiWFqhP7TgIbQ3N2yDP4MfLnSW9S
 +NNnfPK2sBmPRpsdhok57M62vFZpmPeqc+ArnmHQAnLpg9+a/oKBtCO9PXD2Jhpom7LH
 Dv8rxm+k6wYxpHIBlcCJMTCfFyJ/nSNPfwN+ydBMeQkF/taSRYgqC7yz8ARip2gtY0bC
 GSZlB3jtv8S/LSOIrlVOnQ3OuujPl0BPha7VkhD1caDTsGC+kU5tbzTMCO5sAMjld+E5
 nRaw==
X-Gm-Message-State: AOAM5320KvdBPNlzD1szQfkouAGvU9f9M0tQB1D4KnKLOf4L87Xc6NgW
 1XJaWI2amc8xF5GqWOIqhypokRFqOc3Js45PMNp6EO9Q+Kskjt7Oba5s5ntK5aKnVVGDQH8psfX
 bX3Y3uKqkpeTE5iLje1OGwytEmbzmq3awbifVFD1JakEFQTcg22pfXYfMruyftNpqf3iHuaFlMt
 nNlNFauEU8gHHihsor/A==
X-Received: by 2002:a63:484c:: with SMTP id x12mr12604198pgk.220.1635834918439; 
 Mon, 01 Nov 2021 23:35:18 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJw1CpV/2EpS/e5nRLRk5cw0GVfgWPgQ4l1ZAtG77yfP9dNZTYAGAmmn1TSjbUPpUxycrBELkw==
X-Received: by 2002:a63:484c:: with SMTP id x12mr12604158pgk.220.1635834918018; 
 Mon, 01 Nov 2021 23:35:18 -0700 (PDT)
Received: from wangxiaodeMacBook-Air.local ([209.132.188.80])
 by smtp.gmail.com with ESMTPSA id y9sm1303706pjj.6.2021.11.01.23.35.12
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 01 Nov 2021 23:35:17 -0700 (PDT)
Subject: Re: [RFC PATCH v5 23/26] util: Add iova_tree_alloc
To: =?UTF-8?Q?Eugenio_P=c3=a9rez?= <eperezma@redhat.com>, qemu-devel@nongnu.org
References: <20211029183525.1776416-1-eperezma@redhat.com>
 <20211029183525.1776416-24-eperezma@redhat.com>
From: Jason Wang <jasowang@redhat.com>
Message-ID: <86873f67-a2d0-7d4f-a2cf-8c4f32d9bd7f@redhat.com>
Date: Tue, 2 Nov 2021 14:35:06 +0800
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:78.0)
 Gecko/20100101 Thunderbird/78.14.0
MIME-Version: 1.0
In-Reply-To: <20211029183525.1776416-24-eperezma@redhat.com>
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

CuWcqCAyMDIxLzEwLzMwIOS4iuWNiDI6MzUsIEV1Z2VuaW8gUMOpcmV6IOWGmemBkzoKPiBUaGlz
IGlvdmEgdHJlZSBmdW5jdGlvbiBhbGxvd3MgaXQgdG8gbG9vayBmb3IgYSBob2xlIGluIGFsbG9j
YXRlZAo+IHJlZ2lvbnMgYW5kIHJldHVybiBhIHRvdGFsbHkgbmV3IHRyYW5zbGF0aW9uIGZvciBh
IGdpdmVuIHRyYW5zbGF0ZWQKPiBhZGRyZXNzLgo+Cj4gSXQncyB1c2FnZSBpcyBtYWlubHkgdG8g
YWxsb3cgZGV2aWNlcyB0byBhY2Nlc3MgcWVtdSBhZGRyZXNzIHNwYWNlLAo+IHJlbWFwcGluZyBn
dWVzdCdzIG9uZSBpbnRvIGEgbmV3IGlvdmEgc3BhY2Ugd2hlcmUgcWVtdSBjYW4gYWRkIGNodW5r
cyBvZgo+IGFkZHJlc3Nlcy4KPgo+IFNpZ25lZC1vZmYtYnk6IEV1Z2VuaW8gUMOpcmV6IDxlcGVy
ZXptYUByZWRoYXQuY29tPgo+IC0tLQo+ICAgaW5jbHVkZS9xZW11L2lvdmEtdHJlZS5oIHwgIDE3
ICsrKysrCj4gICB1dGlsL2lvdmEtdHJlZS5jICAgICAgICAgfCAxMzkgKysrKysrKysrKysrKysr
KysrKysrKysrKysrKysrKysrKysrKysrCj4gICAyIGZpbGVzIGNoYW5nZWQsIDE1NiBpbnNlcnRp
b25zKCspCj4KPiBkaWZmIC0tZ2l0IGEvaW5jbHVkZS9xZW11L2lvdmEtdHJlZS5oIGIvaW5jbHVk
ZS9xZW11L2lvdmEtdHJlZS5oCj4gaW5kZXggODI0OWVkZDc2NC4uMzNmOWIyZTEzZiAxMDA2NDQK
PiAtLS0gYS9pbmNsdWRlL3FlbXUvaW92YS10cmVlLmgKPiArKysgYi9pbmNsdWRlL3FlbXUvaW92
YS10cmVlLmgKPiBAQCAtMjksNiArMjksNyBAQAo+ICAgI2RlZmluZSAgSU9WQV9PSyAgICAgICAg
ICAgKDApCj4gICAjZGVmaW5lICBJT1ZBX0VSUl9JTlZBTElEICAoLTEpIC8qIEludmFsaWQgcGFy
YW1ldGVycyAqLwo+ICAgI2RlZmluZSAgSU9WQV9FUlJfT1ZFUkxBUCAgKC0yKSAvKiBJT1ZBIHJh
bmdlIG92ZXJsYXBwZWQgKi8KPiArI2RlZmluZSAgSU9WQV9FUlJfTk9NRU0gICAgKC0zKSAvKiBD
YW5ub3QgYWxsb2NhdGUgKi8KCgpJIHRoaW5rIHdlIG5lZWQgYSBiZXR0ZXIgbmFtZSBvdGhlciB0
aGFuICJOT01FTSIsIHNpbmNlIGl0J3MgYWN0dWFsbHkgCm1lYW5zIHRoZXJlJ3Mgbm8gc3VmZmlj
aWVudCBob2xlIGZvciB0aGUgcmFuZ2U/CgoKPiAgIAo+ICAgdHlwZWRlZiBzdHJ1Y3QgSU9WQVRy
ZWUgSU9WQVRyZWU7Cj4gICB0eXBlZGVmIHN0cnVjdCBETUFNYXAgewo+IEBAIC0xMTksNiArMTIw
LDIyIEBAIGNvbnN0IERNQU1hcCAqaW92YV90cmVlX2ZpbmRfYWRkcmVzcyhjb25zdCBJT1ZBVHJl
ZSAqdHJlZSwgaHdhZGRyIGlvdmEpOwo+ICAgICovCj4gICB2b2lkIGlvdmFfdHJlZV9mb3JlYWNo
KElPVkFUcmVlICp0cmVlLCBpb3ZhX3RyZWVfaXRlcmF0b3IgaXRlcmF0b3IpOwo+ICAgCj4gKy8q
Kgo+ICsgKiBpb3ZhX3RyZWVfYWxsb2M6Cj4gKyAqCj4gKyAqIEB0cmVlOiB0aGUgaW92YSB0cmVl
IHRvIGFsbG9jYXRlIGZyb20KPiArICogQG1hcDogdGhlIG5ldyBtYXAgKGFzIHRyYW5zbGF0ZWQg
YWRkciAmIHNpemUpIHRvIGFsbG9jYXRlIGluIGlvdmEgcmVnaW9uCj4gKyAqIEBpb3ZhX2JlZ2lu
OiB0aGUgbWluaW11bSBhZGRyZXNzIG9mIHRoZSBhbGxvY2F0aW9uCj4gKyAqIEBpb3ZhX2VuZDog
dGhlIG1heGltdW0gYWRkcmVzc2FibGUgZGlyZWN0aW9uIG9mIHRoZSBhbGxvY2F0aW9uCj4gKyAq
Cj4gKyAqIEFsbG9jYXRlcyBhIG5ldyByZWdpb24gb2YgYSBnaXZlbiBzaXplLCBiZXR3ZWVuIGlv
dmFfbWluIGFuZCBpb3ZhX21heC4KPiArICoKPiArICogUmV0dXJuOiBTYW1lIGFzIGlvdmFfdHJl
ZV9pbnNlcnQsIGJ1dCBjYW5ub3Qgb3ZlcmxhcCBhbmQgY2FuIGJlIG91dCBvZgo+ICsgKiBmcmVl
IGNvbnRpZ3VvdXMgcmFuZ2UuIENhbGxlciBjYW4gZ2V0IHRoZSBhc3NpZ25lZCBpb3ZhIGluIG1h
cC0+aW92YS4KPiArICovCj4gK2ludCBpb3ZhX3RyZWVfYWxsb2MoSU9WQVRyZWUgKnRyZWUsIERN
QU1hcCAqbWFwLCBod2FkZHIgaW92YV9iZWdpbiwKPiArICAgICAgICAgICAgICAgICAgICBod2Fk
ZHIgaW92YV9lbmQpOwo+ICsKCgoiaW92YV90cmVlX2FsbG9jX21hcCIgc2VlbXMgYmV0dGVyLgoK
Cj4gICAvKioKPiAgICAqIGlvdmFfdHJlZV9kZXN0cm95Ogo+ICAgICoKPiBkaWZmIC0tZ2l0IGEv
dXRpbC9pb3ZhLXRyZWUuYyBiL3V0aWwvaW92YS10cmVlLmMKPiBpbmRleCAyM2VhMzViN2E0Li4y
N2M5MjFjNGUyIDEwMDY0NAo+IC0tLSBhL3V0aWwvaW92YS10cmVlLmMKPiArKysgYi91dGlsL2lv
dmEtdHJlZS5jCj4gQEAgLTE2LDYgKzE2LDM2IEBAIHN0cnVjdCBJT1ZBVHJlZSB7Cj4gICAgICAg
R1RyZWUgKnRyZWU7Cj4gICB9Owo+ICAgCj4gKy8qIEFyZ3MgdG8gcGFzcyB0byBpb3ZhX3RyZWVf
YWxsb2MgZm9yZWFjaCBmdW5jdGlvbi4gKi8KPiArc3RydWN0IElPVkFUcmVlQWxsb2NBcmdzIHsK
PiArICAgIC8qIFNpemUgb2YgdGhlIGRlc2lyZWQgYWxsb2NhdGlvbiAqLwo+ICsgICAgc2l6ZV90
IG5ld19zaXplOwo+ICsKPiArICAgIC8qIFRoZSBtaW5pbXVtIGFkZHJlc3MgYWxsb3dlZCBpbiB0
aGUgYWxsb2NhdGlvbiAqLwo+ICsgICAgaHdhZGRyIGlvdmFfYmVnaW47Cj4gKwo+ICsgICAgLyog
VGhlIGxhc3QgYWRkcmVzc2FibGUgYWxsb3dlZCBpbiB0aGUgYWxsb2NhdGlvbiAqLwo+ICsgICAg
aHdhZGRyIGlvdmFfbGFzdDsKPiArCj4gKyAgICAvKiBQcmV2aW91c2x5LXRvLWxhc3QgaXRlcmF0
ZWQgbWFwLCBjYW4gYmUgTlVMTCBpbiB0aGUgZmlyc3Qgbm9kZSAqLwo+ICsgICAgY29uc3QgRE1B
TWFwICpob2xlX2xlZnQ7Cj4gKwo+ICsgICAgLyogTGFzdCBpdGVyYXRlZCBtYXAgKi8KPiArICAg
IGNvbnN0IERNQU1hcCAqaG9sZV9yaWdodDsKCgpBbnkgcmVhc29uIHdlIGNhbiBtb3ZlIHRob3Nl
IHRvIElPVkFUcmVlIHN0cnVjdHVyZSwgaXQgY2FuIHNpbXBsaWZ5IGEgCmxvdCBvZiB0aGluZ3Mu
CgoKPiArfTsKPiArCj4gKy8qKgo+ICsgKiBJdGVyYXRlIGFyZ3MgdG8gdG5lIG5leHQgaG9sZQo+
ICsgKgo+ICsgKiBAYXJncyAgVGhlIGFsbG9jIGFyZ3VtZW50cwo+ICsgKiBAbmV4dCAgVGhlIG5l
eHQgbWFwcGluZyBpbiB0aGUgdHJlZS4gQ2FuIGJlIE5VTEwgdG8gc2lnbmFsIHRoZSBsYXN0IG9u
ZQo+ICsgKi8KPiArc3RhdGljIHZvaWQgaW92YV90cmVlX2FsbG9jX2FyZ3NfaXRlcmF0ZShzdHJ1
Y3QgSU9WQVRyZWVBbGxvY0FyZ3MgKmFyZ3MsCj4gKyAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgY29uc3QgRE1BTWFwICpuZXh0KSB7Cj4gKyAgICBhcmdzLT5ob2xlX2xl
ZnQgPSBhcmdzLT5ob2xlX3JpZ2h0Owo+ICsgICAgYXJncy0+aG9sZV9yaWdodCA9IG5leHQ7Cj4g
K30KPiArCj4gICBzdGF0aWMgaW50IGlvdmFfdHJlZV9jb21wYXJlKGdjb25zdHBvaW50ZXIgYSwg
Z2NvbnN0cG9pbnRlciBiLCBncG9pbnRlciBkYXRhKQo+ICAgewo+ICAgICAgIGNvbnN0IERNQU1h
cCAqbTEgPSBhLCAqbTIgPSBiOwo+IEBAIC0xMDcsNiArMTM3LDExNSBAQCBpbnQgaW92YV90cmVl
X3JlbW92ZShJT1ZBVHJlZSAqdHJlZSwgY29uc3QgRE1BTWFwICptYXApCj4gICAgICAgcmV0dXJu
IElPVkFfT0s7Cj4gICB9Cj4gICAKPiArLyoqCj4gKyAqIFRyeSB0byBhY2NvbW9kYXRlIGEgbWFw
IG9mIHNpemUgcmV0LT5zaXplIGluIGEgaG9sZSBiZXR3ZWVuCj4gKyAqIG1heChlbmQoaG9sZV9s
ZWZ0KSwgaW92YV9zdGFydCkuCj4gKyAqCj4gKyAqIEBhcmdzIEFyZ3VtZW50cyB0byBhbGxvY2F0
aW9uCj4gKyAqLwo+ICtzdGF0aWMgYm9vbCBpb3ZhX3RyZWVfYWxsb2NfbWFwX2luX2hvbGUoY29u
c3Qgc3RydWN0IElPVkFUcmVlQWxsb2NBcmdzICphcmdzKQo+ICt7Cj4gKyAgICBjb25zdCBETUFN
YXAgKmxlZnQgPSBhcmdzLT5ob2xlX2xlZnQsICpyaWdodCA9IGFyZ3MtPmhvbGVfcmlnaHQ7Cj4g
KyAgICB1aW50NjRfdCBob2xlX3N0YXJ0LCBob2xlX2xhc3Q7Cj4gKwo+ICsgICAgaWYgKHJpZ2h0
ICYmIHJpZ2h0LT5pb3ZhICsgcmlnaHQtPnNpemUgPCBhcmdzLT5pb3ZhX2JlZ2luKSB7Cj4gKyAg
ICAgICAgcmV0dXJuIGZhbHNlOwo+ICsgICAgfQo+ICsKPiArICAgIGlmIChsZWZ0ICYmIGxlZnQt
PmlvdmEgPiBhcmdzLT5pb3ZhX2xhc3QpIHsKPiArICAgICAgICByZXR1cm4gZmFsc2U7Cj4gKyAg
ICB9Cj4gKwo+ICsgICAgaG9sZV9zdGFydCA9IE1BWChsZWZ0ID8gbGVmdC0+aW92YSArIGxlZnQt
PnNpemUgKyAxIDogMCwgYXJncy0+aW92YV9iZWdpbik7Cj4gKyAgICBob2xlX2xhc3QgPSBNSU4o
cmlnaHQgPyByaWdodC0+aW92YSA6IEhXQUREUl9NQVgsIGFyZ3MtPmlvdmFfbGFzdCk7Cj4gKwo+
ICsgICAgaWYgKGhvbGVfbGFzdCAtIGhvbGVfc3RhcnQgPiBhcmdzLT5uZXdfc2l6ZSkgewo+ICsg
ICAgICAgIC8qIFdlIGZvdW5kIGEgdmFsaWQgaG9sZS4gKi8KPiArICAgICAgICByZXR1cm4gdHJ1
ZTsKPiArICAgIH0KPiArCj4gKyAgICAvKiBLZWVwIGl0ZXJhdGluZyAqLwo+ICsgICAgcmV0dXJu
IGZhbHNlOwo+ICt9Cj4gKwo+ICsvKioKPiArICogRm9yZWFjaCBkbWEgbm9kZSBpbiB0aGUgdHJl
ZSwgY29tcGFyZSBpZiB0aGVyZSBpcyBhIGhvbGUgd2l0IGl0cyBwcmV2aW91cwo+ICsgKiBub2Rl
IChvciBtaW5pbXVtIGlvdmEgYWRkcmVzcyBhbGxvd2VkKSBhbmQgdGhlIG5vZGUuCj4gKyAqCj4g
KyAqIEBrZXkgICBOb2RlIGl0ZXJhdGluZwo+ICsgKiBAdmFsdWUgTm9kZSBpdGVyYXRpbmcKPiAr
ICogQHBhcmdzIFN0cnVjdCB0byBjb21tdW5pY2F0ZSB3aXRoIHRoZSBvdXRzaWRlIHdvcmxkCj4g
KyAqCj4gKyAqIFJldHVybjogZmFsc2UgdG8ga2VlcCBpdGVyYXRpbmcsIHRydWUgaWYgbmVlZHMg
YnJlYWsuCj4gKyAqLwo+ICtzdGF0aWMgZ2Jvb2xlYW4gaW92YV90cmVlX2FsbG9jX3RyYXZlcnNl
KGdwb2ludGVyIGtleSwgZ3BvaW50ZXIgdmFsdWUsCj4gKyAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgZ3BvaW50ZXIgcGFyZ3MpCj4gK3sKPiArICAgIHN0cnVjdCBJT1ZB
VHJlZUFsbG9jQXJncyAqYXJncyA9IHBhcmdzOwo+ICsgICAgRE1BTWFwICpub2RlID0gdmFsdWU7
Cj4gKwo+ICsgICAgYXNzZXJ0KGtleSA9PSB2YWx1ZSk7Cj4gKwo+ICsgICAgaW92YV90cmVlX2Fs
bG9jX2FyZ3NfaXRlcmF0ZShhcmdzLCBub2RlKTsKPiArICAgIGlmIChhcmdzLT5ob2xlX2xlZnQg
JiYgYXJncy0+aG9sZV9sZWZ0LT5pb3ZhID4gYXJncy0+aW92YV9sYXN0KSB7Cj4gKyAgICAgICAg
cmV0dXJuIHRydWU7Cj4gKyAgICB9Cj4gKwo+ICsgICAgaWYgKGlvdmFfdHJlZV9hbGxvY19tYXBf
aW5faG9sZShhcmdzKSkgewo+ICsgICAgICAgIHJldHVybiB0cnVlOwo+ICsgICAgfQo+ICsKPiAr
ICAgIHJldHVybiBmYWxzZTsKPiArfQo+ICsKPiAraW50IGlvdmFfdHJlZV9hbGxvYyhJT1ZBVHJl
ZSAqdHJlZSwgRE1BTWFwICptYXAsIGh3YWRkciBpb3ZhX2JlZ2luLAo+ICsgICAgICAgICAgICAg
ICAgICAgIGh3YWRkciBpb3ZhX2xhc3QpCj4gK3sKPiArICAgIHN0cnVjdCBJT1ZBVHJlZUFsbG9j
QXJncyBhcmdzID0gewo+ICsgICAgICAgIC5uZXdfc2l6ZSA9IG1hcC0+c2l6ZSwKPiArICAgICAg
ICAuaW92YV9iZWdpbiA9IGlvdmFfYmVnaW4sCj4gKyAgICAgICAgLmlvdmFfbGFzdCA9IGlvdmFf
bGFzdCwKPiArICAgIH07Cj4gKwo+ICsgICAgaWYgKGlvdmFfYmVnaW4gPT0gMCkgewo+ICsgICAg
ICAgIC8qIFNvbWUgZGV2aWNlcyBkb2VzIG5vdCBsaWtlIGFkZHIgMCAqLwo+ICsgICAgICAgIGlv
dmFfYmVnaW4gKz0gcWVtdV9yZWFsX2hvc3RfcGFnZV9zaXplOwo+ICsgICAgfQo+ICsKPiArICAg
IGFzc2VydChpb3ZhX2JlZ2luIDwgaW92YV9sYXN0KTsKPiArCj4gKyAgICAvKgo+ICsgICAgICog
RmluZCBhIHZhbGlkIGhvbGUgZm9yIHRoZSBtYXBwaW5nCj4gKyAgICAgKgo+ICsgICAgICogQXNz
dW1pbmcgbG93IGlvdmFfYmVnaW4sIHNvIG5vIG5lZWQgdG8gZG8gYSBiaW5hcnkgc2VhcmNoIHRv
Cj4gKyAgICAgKiBsb2NhdGUgdGhlIGZpcnN0IG5vZGUuCj4gKyAgICAgKgo+ICsgICAgICogVE9E
TzogV2UgY2FuIGltcHJvdmUgdGhlIHNlYXJjaCBzcGVlZCBpZiB3ZSBzYXZlIHRoZSBiZWdpbm5p
bmcgYW5kIHRoZQo+ICsgICAgICogZW5kIG9mIGhvbGVzLCBzbyB3ZSBkb24ndCBpdGVyYXRlIG92
ZXIgdGhlIHByZXZpb3VzIHNhdmVkIG9uZXMuCj4gKyAgICAgKgo+ICsgICAgICogVE9ETzogUmVw
bGFjZSBhbGwgdGhpcyB3aXRoIGdfdHJlZV9ub2RlX2ZpcnN0L25leHQvbGFzdCB3aGVuIGF2YWls
YWJsZQo+ICsgICAgICogKGZyb20gZ2xpYiBzaW5jZSAyLjY4KS4gVG8gZG8gaXQgd2l0aCBnX3Ry
ZWVfZm9yZWFjaCBjb21wbGljYXRlcyB0aGUKPiArICAgICAqIGNvZGUgYSBsb3QuCgoKVG8gc2F5
IHRoZSB0cnV0aCwgdGhlIGNvZGVzIGluIGlvdmFfdHJlZV9hbGxvY190cmF2ZXJzZSgpIGlzIGhh
cmQgdG8gYmUgCnJldmlld2VkLiBJIHRoaW5rIGl0IHdvdWxkIGJlIGVhc3kgdG8gdXNlIGZpcnN0
L25leHQvbGFzdC4gV2hhdCB3ZSAKcmVhbGx5IG5lZWQgaXMgdG8gY2FsY3VsYXRlIHRoZSBob2xl
IGJldHdlZW4gdHdvIHJhbmdlcyB3aXRoIGhhbmRtYWRlIApmaXJzdCwgbGFzdC4KClRoYW5rcwoK
Cj4gKyAgICAgKgo+ICsgICAgICovCj4gKyAgICBnX3RyZWVfZm9yZWFjaCh0cmVlLT50cmVlLCBp
b3ZhX3RyZWVfYWxsb2NfdHJhdmVyc2UsICZhcmdzKTsKPiArICAgIGlmICghaW92YV90cmVlX2Fs
bG9jX21hcF9pbl9ob2xlKCZhcmdzKSkgewo+ICsgICAgICAgIC8qCj4gKyAgICAgICAgICogMm5k
IHRyeTogTGFzdCBpdGVyYXRpb24gbGVmdCBhcmdzLT5yaWdodCBhcyB0aGUgbGFzdCBETUFNYXAu
IEJ1dAo+ICsgICAgICAgICAqIChyaWdodCwgZW5kKSBob2xlIG5lZWRzIHRvIGJlIGNoZWNrZWQg
dG9vCj4gKyAgICAgICAgICovCj4gKyAgICAgICAgaW92YV90cmVlX2FsbG9jX2FyZ3NfaXRlcmF0
ZSgmYXJncywgTlVMTCk7Cj4gKyAgICAgICAgaWYgKCFpb3ZhX3RyZWVfYWxsb2NfbWFwX2luX2hv
bGUoJmFyZ3MpKSB7Cj4gKyAgICAgICAgICAgIHJldHVybiBJT1ZBX0VSUl9OT01FTTsKPiArICAg
ICAgICB9Cj4gKyAgICB9Cj4gKwo+ICsgICAgbWFwLT5pb3ZhID0gTUFYKGlvdmFfYmVnaW4sCj4g
KyAgICAgICAgICAgICAgICAgICAgYXJncy5ob2xlX2xlZnQgPwo+ICsgICAgICAgICAgICAgICAg
ICAgIGFyZ3MuaG9sZV9sZWZ0LT5pb3ZhICsgYXJncy5ob2xlX2xlZnQtPnNpemUgKyAxIDogMCk7
Cj4gKyAgICByZXR1cm4gaW92YV90cmVlX2luc2VydCh0cmVlLCBtYXApOwo+ICt9Cj4gKwo+ICAg
dm9pZCBpb3ZhX3RyZWVfZGVzdHJveShJT1ZBVHJlZSAqdHJlZSkKPiAgIHsKPiAgICAgICBnX3Ry
ZWVfZGVzdHJveSh0cmVlLT50cmVlKTsKCl9fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fClZpcnR1YWxpemF0aW9uIG1haWxpbmcgbGlzdApWaXJ0dWFsaXphdGlv
bkBsaXN0cy5saW51eC1mb3VuZGF0aW9uLm9yZwpodHRwczovL2xpc3RzLmxpbnV4Zm91bmRhdGlv
bi5vcmcvbWFpbG1hbi9saXN0aW5mby92aXJ0dWFsaXphdGlvbg==
