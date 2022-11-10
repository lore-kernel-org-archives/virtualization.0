Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 951BAC4332F
	for <virtualization@archiver.kernel.org>; Thu, 10 Nov 2022 01:55:09 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id F24F6606ED;
	Thu, 10 Nov 2022 01:55:08 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org F24F6606ED
Authentication-Results: smtp3.osuosl.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=g0vXSA2b
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
	by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id VbMhhJ-hSI35; Thu, 10 Nov 2022 01:55:08 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp3.osuosl.org (Postfix) with ESMTPS id 68B7C605A4;
	Thu, 10 Nov 2022 01:55:07 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 68B7C605A4
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 38920C0033;
	Thu, 10 Nov 2022 01:55:07 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 32138C002D
 for <virtualization@lists.linux-foundation.org>;
 Thu, 10 Nov 2022 01:55:06 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id 0D06480FAA
 for <virtualization@lists.linux-foundation.org>;
 Thu, 10 Nov 2022 01:55:06 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 0D06480FAA
Authentication-Results: smtp1.osuosl.org;
 dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com
 header.a=rsa-sha256 header.s=mimecast20190719 header.b=g0vXSA2b
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id x8dlfQJR50J0
 for <virtualization@lists.linux-foundation.org>;
 Thu, 10 Nov 2022 01:55:05 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 09D6080FA1
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.133.124])
 by smtp1.osuosl.org (Postfix) with ESMTPS id 09D6080FA1
 for <virtualization@lists.linux-foundation.org>;
 Thu, 10 Nov 2022 01:55:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1668045303;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=dI70iL0BpR3WdG/neQvTvAfb/6Biv3hyItBnAt35ejk=;
 b=g0vXSA2bV5KM/n7b6b5n8oZkVXqdL0d6DbMx4M/NbtmUrUsxHfLy7NFJDuRRmnLDBJO6jT
 Na+hJWZ/zYmweLsh0RGqItGhBflQYqtgTH4irXtt2KJs3FMF5ZLxIZu38IDIZTZp3h3Qb/
 mUuwEBjWPKMQLnOhMIzKf2R3TMucqf4=
Received: from mail-pj1-f69.google.com (mail-pj1-f69.google.com
 [209.85.216.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-460-tz57_XrZNjSpSFbZB0JtvQ-1; Wed, 09 Nov 2022 20:55:02 -0500
X-MC-Unique: tz57_XrZNjSpSFbZB0JtvQ-1
Received: by mail-pj1-f69.google.com with SMTP id
 m1-20020a17090a5a4100b002138550729dso346247pji.2
 for <virtualization@lists.linux-foundation.org>;
 Wed, 09 Nov 2022 17:55:02 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=dI70iL0BpR3WdG/neQvTvAfb/6Biv3hyItBnAt35ejk=;
 b=PtDKUiqJ/GxSmlQbCI5l/ePy+RGl3tfGhEo33mePJ9pzbVIPf97tIoySwv3/RAY5hg
 JVZA/TSYeMCbokDuWNAiRd1YR9e+Oen4RY8F5GOPeqSvB5DTAR7vmm2uBYMnL+9qZ98T
 YFbUXAiluWP7WPexR9DhB0lW9kjv6ZZChvIudXTiWIDufb3lYffHZYtDb+cxBSO6Jj1H
 JER2k+z2X5gv8qd6pokx6Dk9wZt6rqYQ81cqPgev/PcQ9JytMcdGDVCGrddyso3alK+t
 KI4d3sJpEAyT29xOoRFEi/QRSn/Q6n3tIijUElc/0MBRg2rEbRzlw4Z8nfJG/GbgCXx2
 r4GA==
X-Gm-Message-State: ACrzQf0sevzY8ur8KMQ5wzYcMQ5QzsWqQ+ry3YfANcUqFwAM06Ahru9W
 YG4cy8+iuIvf00BZVu09Mxt3+R5KjsmJPNAq0q+xzW1eRKOJvUoflR5LjhDfVlh66O1Q4AHKhHi
 9Zpkiok1iX1mGcZFSdmFOb0uFfzN9XrmzX+dNuDMvLQ==
X-Received: by 2002:a17:903:258b:b0:186:8bb2:de32 with SMTP id
 jb11-20020a170903258b00b001868bb2de32mr64809007plb.63.1668045301509; 
 Wed, 09 Nov 2022 17:55:01 -0800 (PST)
X-Google-Smtp-Source: AMsMyM7L3bp/Ly2+JS3NucjvMvxdD5oY6roTW+fhAXrGHKCUhf9ZkmBUxMTOWV2OHVNB8taf3AA91g==
X-Received: by 2002:a17:903:258b:b0:186:8bb2:de32 with SMTP id
 jb11-20020a170903258b00b001868bb2de32mr64808992plb.63.1668045301123; 
 Wed, 09 Nov 2022 17:55:01 -0800 (PST)
Received: from [10.72.13.160] ([43.228.180.230])
 by smtp.gmail.com with ESMTPSA id
 c195-20020a621ccc000000b00550724f8ea0sm8805766pfc.128.2022.11.09.17.54.58
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 09 Nov 2022 17:55:00 -0800 (PST)
Message-ID: <183f8215-b1da-290f-9ec6-4c4988aeabcd@redhat.com>
Date: Thu, 10 Nov 2022 09:54:55 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.4.0
Subject: Re: [PATCH] virtio: vdpa: new SolidNET DPU driver.
To: Alvaro Karsz <alvaro.karsz@solid-run.com>
References: <20221108100925.823841-1-alvaro.karsz@solid-run.com>
 <318f4b6e-bcd5-a269-b385-f0e521c2ee9a@redhat.com>
 <CAJs=3_BTL3Rdrnbykgzy5arA5xOoUGz6Y_g6yUNpZg7hfouVSw@mail.gmail.com>
From: Jason Wang <jasowang@redhat.com>
In-Reply-To: <CAJs=3_BTL3Rdrnbykgzy5arA5xOoUGz6Y_g6yUNpZg7hfouVSw@mail.gmail.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Language: en-US
Cc: Jean Delvare <jdelvare@suse.com>, "Michael S. Tsirkin" <mst@redhat.com>,
 Guenter Roeck <linux@roeck-us.net>, virtualization@lists.linux-foundation.org
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

CuWcqCAyMDIyLzExLzkgMTc6NDQsIEFsdmFybyBLYXJzeiDlhpnpgZM6Cj4gSGkgSmFzb24sCj4K
Pj4gSWYgSSB3YXMgbm90IHdyb25nLCB0aGlzIHZhbHVlIHNlZW1zIGRvZXNuJ3QgY2hhbmdlLiBJ
ZiB5ZXMsIEkgd29uZGVyIHdlCj4+IGNhbiBtb3ZlIHRoZSBraWNrX29mZnNldCBsb2dpYyB0byBz
bmV0X2FsbG9jX2RldigpPwo+Cj4gVGhlcmUgaXMgbm90IGEgcmVhbCByZWFzb24gdG8gaGF2ZSB0
aGlzIGxvZ2ljIGluIHNuZXRfc2V0X3ZxX2FkZHJlc3MsCj4gc28gaXQgY291bGQgYmUgbW92ZWQg
dG8gc25ldF9idWlsZF92cXMgKHdoaWNoIGlzIGNhbGxlZCB3aXRoaW4KPiBzbmV0X2FsbG9jX2Rl
dikuCj4KPj4gLUVPUE5PVFNVUFA/Cj4KPiBSZXR1cm5pbmcgYW4gZXJyb3IgZnJvbSB0aGUgc2V0
X3ZxX3N0YXRlIGNhbGxiYWNrIGxlYWRzIHRvIHByb2JlIGZhaWx1cmUuCj4gVGhpcyBjb2RlIGlz
IHRha2VuIGZyb20gZHJpdmVycy92aXJ0aW8vdmlydGlvX3ZkcGEuYywKPiB2aXJ0aW9fdmRwYV9z
ZXR1cF92cSBmdW5jdGlvbjoKPgo+PiAgIHN0cnVjdCB2ZHBhX3ZxX3N0YXRlIHN0YXRlID0gezB9
Owo+Pgo+PiAuLi4uLi4KPj4KPj4gZXJyID0gb3BzLT5zZXRfdnFfc3RhdGUodmRwYSwgaW5kZXgs
ICZzdGF0ZSk7Cj4+IGlmIChlcnIpCj4+ICAgICAgICAgIGdvdG8gZXJyX3ZxOwo+Cj4gSSBjb3Vs
ZCBjaGVjayBzdHJ1Y3QgdmRwYV92cV9zdGF0ZSwgYW5kIHJldHVybiAwIGlmIHN0cnVjdAo+IHZk
cGFfdnFfc3RhdGUgdmFsdWUgaXMgMCwgLUVPUE5PVFNVUFAgb3RoZXJ3aXNlLgo+IFdoYXQgZG8g
eW91IHRoaW5rPwoKClRoYXQgd291bGQgYmUgZmluZS4gKEl0IGNvdWxkIGJlIHNvbWV0aGluZyBz
aW1pbGFyIHRvIAp2cF92ZHBhX3NldF92cV9zdGF0ZV9zcGxpdCgpKS4KCgo+Cj4+IEkgZmFpbCB0
byB1bmRlcnN0YW5kIGhvdyBjYW4gdGhpcyB3b3JrLiBFLmcgYWZ0ZXIgcmVzZXQgdGhlcmUgc2hv
dWxkIGJlCj4+IG5vIGludGVyYWN0aW9uIGZyb20gdGhlIGRldmljZSBsaWtlIERNQSwgb3RoZXJ3
aXNlIHRoZXJlIGNvdWxkIGhhdmUKPj4gc2VjdXJpdHkgaW1wbGljYXRpb25zLgo+Cj4gWW91J3Jl
IHJpZ2h0LCBJJ2xsIGFkZCBhIHByb3BlciByZXNldCBjYWxsYmFjay4KPgo+PiBTaW5jZSByZWFk
IGlzIG9yZGVyZWQgd2l0aCB3cml0ZSwgYSBtb3JlIGVhc3kgd2F5IGlzIHRvIHBlcmZvcm0gYSBp
b3JlYWQKPj4gaGVyZS4KPj4gSW50ZXJlc3RpbmcsIHdoaWNoIGJhcnJpZXIgaXMgdGhpcyBwYWly
ZWQ/Cj4KPiBVc3VhbGx5IHJlYWRzIGFyZSBzbG93LCBidXQgd2UgZG9uJ3QgY2FyZSBhYm91dCBz
cGVlZCB3aGVuIHNlbmRpbmcKPiBtZXNzYWdlcyAoc2luY2Ugd2Ugb25seSBzZW5kIGEgImRlc3Ry
b3kiIG1lc3NhZ2Ugc28gZmFyLCBtZWFuaW5nIHRoYXQKPiB0aGUgcGNpIHJlbW92ZSBjYWxsYmFj
ayB3YXMgY2FsbGVkKSwgc28gdGhlIG1lbW9yeSBiYXJyaWVyIGNhbiBiZQo+IHJlcGxhY2VkIHdp
dGggYSByZWFkIG9wZXJhdGlvbi4KCgpZZXMsIGFjdHVhbGx5LCB0aGUgbWVtb3J5IGJhcnJpZXIg
Y2FuJ3QgZ3VhcmFudGVlIHRoZSB3cml0ZSBoYXMgYmVlbiAKcHJvY2Vzc2VkIGJ5IHRoZSBkZXZp
Y2UuCgoKPgo+PiBEbyB3ZSBuZWVkIHRvIGRvIGVuZGlhbiBjb252ZXJzaW9uIGhlcmUgKGNwdV90
b19sZTY0KCkpPwo+Cj4gWWVzLCBJJ2xsIGFkZCBpdC4KPgo+PiBOZWVkIHRvIHRha2UgZW5kaWFu
ZXNzIGludG8gYWNjb3VudC4KPgo+IEknbSBub3Qgc3VyZSBhYm91dCB0aGF0Lgo+IFRoZSBlbmRp
YW5uZXNzIGFwcGVhcnMgdG8gYmUgaGFuZGxlZCBieSB0aGUgY2FsbGVyLgo+IEZ1bmN0aW9uIGZy
b20gaW5jbHVkZS9saW51eC92aXJ0aW9fY29uZmlnLmgKPgo+PiBzdGF0aWMgaW5saW5lIHZvaWQg
dmlydGlvX2N3cml0ZTE2KHN0cnVjdCB2aXJ0aW9fZGV2aWNlICp2ZGV2LAo+PiAgICB1bnNpZ25l
ZCBpbnQgb2Zmc2V0LCB1MTYgdmFsKQo+PiB7Cj4+ICAgICAgX192aXJ0aW8xNiB2Owo+Pgo+Pgo+
PiAgICAgIG1pZ2h0X3NsZWVwKCk7Cj4+ICAgICAgdiA9IGNwdV90b192aXJ0aW8xNih2ZGV2LCB2
YWwpOwo+PiAgICAgIHZkZXYtPmNvbmZpZy0+c2V0KHZkZXYsIG9mZnNldCwgJnYsIHNpemVvZih2
KSk7Cj4+IH0KCgpZb3UgYXJlIHJpZ2h0LgoKCj4KPj4gc3RhdGljIGlubGluZSB2b2lkIHZpcnRp
b19jd3JpdGUzMihzdHJ1Y3QgdmlydGlvX2RldmljZSAqdmRldiwKPj4gICAgdW5zaWduZWQgaW50
IG9mZnNldCwgdTMyIHZhbCkKPj4gewo+PiAgICAgIF9fdmlydGlvMzIgdjsKPj4KPj4KPj4gICAg
ICBtaWdodF9zbGVlcCgpOwo+PiAgICAgIHYgPSBjcHVfdG9fdmlydGlvMzIodmRldiwgdmFsKTsK
Pj4gICAgICB2ZGV2LT5jb25maWctPnNldCh2ZGV2LCBvZmZzZXQsICZ2LCBzaXplb2YodikpOwo+
PiB9Cj4+Cj4KPj4gc3RhdGljIGlubGluZSB2b2lkIHZpcnRpb19jd3JpdGU2NChzdHJ1Y3Qgdmly
dGlvX2RldmljZSAqdmRldiwKPj4gICAgdW5zaWduZWQgaW50IG9mZnNldCwgdTY0IHZhbCkKPj4g
ewo+PiAgICAgIF9fdmlydGlvNjQgdjsKPj4KPj4KPj4gICAgICBtaWdodF9zbGVlcCgpOwo+PiAg
ICAgIHYgPSBjcHVfdG9fdmlydGlvNjQodmRldiwgdmFsKTsKPj4gICAgICB2ZGV2LT5jb25maWct
PnNldCh2ZGV2LCBvZmZzZXQsICZ2LCBzaXplb2YodikpOwo+PiB9Cj4KPiBJJ20gbm90IHN1cmUg
aG93IHRoZSBlbmRpYW5uZXNzIGNhbiBiZSBoYW5kbGVkIGJ5IHRoZSB2RFBBIGRyaXZlci4KPiBU
aGlzIGZ1bmN0aW9uIG1heSBiZSBjYWxsZWQgZm9yIGEgOGJpdCwgMTZiaXQsIDMyYml0IG9yIDY0
Yml0IHZhcmlhYmxlcy4KPiBJdCB0aGVvcmV0aWNhbGx5IG1heSBiZSBjYWxsZWQgdG8gY2hhbmdl
IG11bHRpcGxlIHZhcmlhYmxlcyBhdCBvbmNlLgo+IEl0IG1heSBiZSBjYWxsZWQgdG8gY2hhbmdl
IHBhcnQgb2YgYSB2YXJpYWJsZS4KPgo+Cj4+ICAgSWYgSSB3YXMgbm90IHdyb25nLCB0aGUgZGV2
aWNlIGRlcGVuZHMgb24gdGhlIHBsYXRmb3JtIElPTU1VIHRvIHdvcmsuIFNvCj4+IHVubGVzcyBk
ZXZpY2UgaGF2ZSBhIG1vcmUgc3RyaWN0IGlvdmEgcmFuZ2UgdGhhbiB3aGF0IHBsYXRmb3JtIElP
TU1VIGNhbgo+PiBwcm92aWRlLCB3ZSBjYW4gc2ltcGx5IG5vdCBhZHZlcnRpc2UgdGhpcyBhbmQg
dXNlIHRoZSBvbmUgdGhhdCBpcwo+PiBwcm92aWRlZCBieSB0aGUgSU9NTVU6Cj4+Cj4+Cj4+IHN0
YXRpYyB2b2lkIHZob3N0X3ZkcGFfc2V0X2lvdmFfcmFuZ2Uoc3RydWN0IHZob3N0X3ZkcGEgKnYp
Cj4+IHsKPj4gICAgICAgICAgIHN0cnVjdCB2ZHBhX2lvdmFfcmFuZ2UgKnJhbmdlID0gJnYtPnJh
bmdlOwo+PiAgICAgICAgICAgc3RydWN0IHZkcGFfZGV2aWNlICp2ZHBhID0gdi0+dmRwYTsKPj4g
ICAgICAgICAgIGNvbnN0IHN0cnVjdCB2ZHBhX2NvbmZpZ19vcHMgKm9wcyA9IHZkcGEtPmNvbmZp
ZzsKPj4KPj4KPj4gICAgICAgICAgIGlmIChvcHMtPmdldF9pb3ZhX3JhbmdlKSB7Cj4+ICAgICAg
ICAgICAgICAgICAgICpyYW5nZSA9IG9wcy0+Z2V0X2lvdmFfcmFuZ2UodmRwYSk7Cj4+ICAgICAg
ICAgICB9IGVsc2UgaWYgKHYtPmRvbWFpbiAmJiB2LT5kb21haW4tPmdlb21ldHJ5LmZvcmNlX2Fw
ZXJ0dXJlKSB7Cj4+ICAgICAgICAgICAgICAgICAgIHJhbmdlLT5maXJzdCA9IHYtPmRvbWFpbi0+
Z2VvbWV0cnkuYXBlcnR1cmVfc3RhcnQ7Cj4+ICAgICAgICAgICAgICAgICAgIHJhbmdlLT5sYXN0
ID0gdi0+ZG9tYWluLT5nZW9tZXRyeS5hcGVydHVyZV9lbmQ7Cj4+ICAgICAgICAgICB9IGVsc2Ug
ewo+PiAgICAgICAgICAgICAgICAgICByYW5nZS0+Zmlyc3QgPSAwOwo+PiAgICAgICAgICAgICAg
ICAgICByYW5nZS0+bGFzdCA9IFVMTE9OR19NQVg7Cj4+ICAgICAgICAgICB9Cj4+IH0KPgo+IEkn
bGwgZGVsZXRlIHRoZSBzbmV0X2dldF9pb3ZhX3JhbmdlIGZ1bmN0aW9uLgo+Cj4+IEFueSBjaGFu
Y2UgdG8gdXNlIGRldmljZSBtYW5hZ2VkIHJlZ2lvbiBoZWxwZXIgaGVyZT8gSXQgc2VlbXMgdG8K
Pj4gc2ltcGxpZnkgdGhlIGNvZGVzIChlLmcgdGhlIGNsZWFudXAgc3R1ZmZzKS4KPgo+IE9rLCBJ
J2xsIGRvIGl0Lgo+Cj4+IElzIHRoaXMgYmV0dGVyIHRvIHNheSAiY29uZmlnIGlzIG5vdCByZWFk
eSI/IEJ0dywgSSB3b25kZXIgaWYgaXQgbWFrZXMKPj4gbW9yZSBzZW5zZSB0byB3YWl0IHVudGls
IHRoZSBjb25mZyBpcyByZWFkeSB3aXRoIGEgdGltZW91dD8KPgo+IEdvb2QgaWRlYSwgSSdsbCBp
bXBsZW1lbnQgdGhlIHdhaXQgJiB0aW1lb3V0Lgo+Cj4+IEkgd29uZGVyIGlmIGl0J3Mgd29ydGgg
dG8gYm90aGVyIGNvbnNpZGVyIHdlJ3JlIHVzaW5nIGRldnJlcyB0byBtYW5hZ2UgaXJxcy4KPgo+
IFlvdSdyZSByaWdodCwgdGhpcyBpc24ndCByZXF1aXJlZCwgSSdsbCByZW1vdmUgaXQuCj4KPj4g
SXQgbG9va3MgdG8gbWUgYWxsIHRoZSBkZXZpY2VzIGNyZWF0ZWQgaGVyZSB1c2UgdGhlIHNhbWUg
ZG1hX2RldiAodGhlCj4+IFBDSSBkZXZpY2UpLCBJIHdvbmRlciBob3cgdGhlIERNQSBpcyBpc29s
YXRlZCBhbW9uZyB0aGUgdkRQQSBkZXZpY2VzCj4+IGNyZWF0ZWQgaGVyZS4KPgo+IEFsbCB2RFBB
IGRldmljZXMgaW5kZWVkIHVzZSB0aGUgc2FtZSBETUEgZGV2aWNlLCB0aGVyZSBpcyBubyBpc29s
YXRpb24KPiBiZXR3ZWVuIHRoZSBkZXZpY2VzLgo+IEknbSBub3Qgc3VyZSB3aHkgdGhlcmUgc2hv
dWxkIGJlIGlzb2xhdGlvbiBpbiB0aGlzIGNhc2UuCgoKRWFjaCB2RFBBIG5lZWRzIHRvIGJlIGFi
bGUgdG8gYXNzaWduZWQgdG8gYSB1c2Vyc3BhY2UoVk0pIGluZGVwZW5kZW50bHkgCndoZW4gYm91
bmQgdG8gdmhvc3QtdkRQQS4gSWYgdGhleSBzaGFyZSB0aGUgc2FtZSBJT01NVSBkb21haW4sIHRo
ZXJlIAp3aWxsIGJlIHNlY3VyaXR5IGlzc3Vlcy4KCgo+Cj4+IEJ0dywgdGhlIHZEUEEgaGFzIGJl
ZW4gc3dpdGNoZWQgdG8gdXNlIHZEUEEgdG9vbCB0byBjcmVhdGUgZGV2aWNlcywgaXQKPj4gaXMg
c3VnZ2VzdGVkIHRvIGltcGxlbWVudCB0aGUgbWdtdCBkZXZpY2VzIGFzIHdoYXQgb3RoZXIgcGFy
ZW50cyBkaWQuCj4+IFRoZW4gdGhlIHNuZXRfYWxsb2NfZGV2KCkgY291bGQgYmUgdXNlZCBmb3Ig
ZGV2X2FkZCgpLgo+Cj4gV2Ugd2FudCB0byBsZWF2ZSBjb250cm9sIHRvIHRoZSBEUFUgYXQgdGhl
IG1vbWVudCwgdGhlIG51bWJlci90eXBlIG9mCj4gZGV2aWNlcyBpcyBkZXRlcm1pbmVkIGJ5IHRo
ZSBEUFUncyBjb25maWcsIGFuZCBjYW4ndCBiZSBjb250cm9sbGVkCj4gZnJvbSB1c2Vyc3BhY2Uu
CgoKVGhhdCdzIGZpbmUsIGl0IG1pZ2h0IGJlIGJldHRlciB0byBzdGF0ZSB0aGlzIGluIHRoZSBj
aGFuZ2Vsb2cgb3IgYXMgYSAKY29tbWVudCBzb21ld2hlcmUgaW4gdGhlIGNvZGUuCgoKPgo+PiBU
aGVyZSBsb29rcyBsaWtlIGEgcmFjZSwgdGhlIHZEUEEgZGV2aWNlIGNvdWxkIGJlIHJlZ2lzdGVy
ZWQgdG8gdGhlIGJ1cwo+PiBhbmQgdXNlZCBieSB1c2Vyc3BhY2UgYnkgYnVzIG1hc3Rlci9kcnZk
YXRhIGlzIHNldC4KPgo+IFlvdSdyZSByaWdodCwgdGhlIHZkcGEgcmVnaXN0cmF0aW9uIHNob3Vs
ZCBiZSBkb25lIGFmdGVyIHRoZQo+IG1hc3Rlci9kcnZkYXRhIGlzIHNldC4KPgo+PiBJIHRoaW5r
IGRldnJlcyBzaG91bGQgdGFrZSBjYXJlIG9mIHRoaXMgc2luY2Ugd2UncmUgdXNpbmcKPj4gcGNp
bV9lbmFibGVfZGV2aWNlKCk/Cj4KPiBZb3UncmUgcmlnaHQsIHRoaXMgaXNuJ3QgcmVxdWlyZWQs
IEknbGwgcmVtb3ZlIGl0Lgo+Cj4+IEFjY29yZGluZyB0byB0aGUgY29kZSwgdGhpcyBzZWVtcyB0
byBiZSB0aGUgZHJpdmVyIGZlYXR1cmVzIGFuZAo+Cj4gVGhlc2UgYXJlIHRoZSBuZWdvdGlhdGVk
IGZlYXR1cmVzCj4gV2UncmUgbm90IGtlZXBpbmcgcmVjb3JkIG9mIHRoZSBkcml2ZXIgZmVhdHVy
ZXMsIHdoZW4KPiBzZXRfZHJpdmVyX2ZlYXR1cmVzIGlzIGNhbGxlZCwgd2UganVzdCBsb2dpYyBB
TkQgdGhlIGRyaXZlciBmZWF0dXJlcwo+IHdpdGggdGhlIHN1cHBvcnRlZCBmZWF0dXJlcyByZWNl
aXZlZCBmcm9tIHRoZSBEUFUuCj4gSSdsbCByZW5hbWUgaXQgdG8gYmUgJ25lZ290aWF0ZWRfZmVh
dHVyZXMiLCB0aGlzIHNlZW1zIG1vcmUgYWNjdXJhdGUuCgoKT2suCgoKPgo+PiBzdGF0aWMgaW50
IHNuZXRfc2V0X2Rydl9mZWF0dXJlcyhzdHJ1Y3QgdmRwYV9kZXZpY2UgKnZkZXYsIHU2NCBmZWF0
dXJlcykKPj4gewo+PiAgICAgIHN0cnVjdCBzbmV0ICpzbmV0ID0gdmRwYV90b19zbmV0KHZkZXYp
Owo+Pgo+Pgo+PiAgICAgIHNuZXQtPnVzZWRfZmVhdHVyZXMgPSBzbmV0LT5jZmctPmZlYXR1cmVz
ICYgZmVhdHVyZXM7Cj4+ICAgICAgcmV0dXJuIDA7Cj4+IH0KPgo+Cj4+IFRoaXMgc2VlbXMgdG8g
YmUgdW51c2VkLgo+Cj4gWW91J3JlIHJpZ2h0LCBJJ2xsIHJlbW92ZSBpdC4KPgo+Cj4gVGhhbmsg
eW91IGZvciB5b3VyIGNvbW1lbnRzLgo+IEknbGwgc2VuZCBhIG5ldyB2ZXJzaW9uIG9uY2UgSSBm
aW5pc2ggd29ya2luZyBvbiB0aGUgY29tbWVudHMuCj4KPiBBbHZhcm8KCgpUaGFua3MKCgo+Cgpf
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fXwpWaXJ0dWFsaXph
dGlvbiBtYWlsaW5nIGxpc3QKVmlydHVhbGl6YXRpb25AbGlzdHMubGludXgtZm91bmRhdGlvbi5v
cmcKaHR0cHM6Ly9saXN0cy5saW51eGZvdW5kYXRpb24ub3JnL21haWxtYW4vbGlzdGluZm8vdmly
dHVhbGl6YXRpb24=
