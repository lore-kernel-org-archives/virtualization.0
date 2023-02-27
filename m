Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 06DB9C64ED6
	for <virtualization@archiver.kernel.org>; Mon, 27 Feb 2023 07:22:42 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 8F707813C0;
	Mon, 27 Feb 2023 07:22:42 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 8F707813C0
Authentication-Results: smtp1.osuosl.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=J0eng4Gb
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
	by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id kwJTKdRrvOU4; Mon, 27 Feb 2023 07:22:40 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp1.osuosl.org (Postfix) with ESMTPS id 0CB82813BC;
	Mon, 27 Feb 2023 07:22:40 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 0CB82813BC
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id D80EEC0032;
	Mon, 27 Feb 2023 07:22:39 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 94DC4C002B
 for <virtualization@lists.linux-foundation.org>;
 Mon, 27 Feb 2023 07:22:38 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id 6AD534017B
 for <virtualization@lists.linux-foundation.org>;
 Mon, 27 Feb 2023 07:22:38 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org 6AD534017B
Authentication-Results: smtp2.osuosl.org;
 dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com
 header.a=rsa-sha256 header.s=mimecast20190719 header.b=J0eng4Gb
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id Q46rFbW884wx
 for <virtualization@lists.linux-foundation.org>;
 Mon, 27 Feb 2023 07:22:35 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org 75C4F400B8
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.129.124])
 by smtp2.osuosl.org (Postfix) with ESMTPS id 75C4F400B8
 for <virtualization@lists.linux-foundation.org>;
 Mon, 27 Feb 2023 07:22:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1677482553;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=HcPvEo+F2OZU0bbI4Y5XSo6Zcw491v3lgydd9/bPwkk=;
 b=J0eng4GbBPmKMNL3fmeRwNriyF06NbuSw3doyO+q4mlVBU9tfUcb/EQRKsNtydgRaaAmDm
 i28C4k/sa2azdIPr2LlJfHlbkj7lGKEBS4V4tEOT3gkjwN/c+iPjKKwnjdJsboAhu+2oIF
 cp2sjMliG6pKgBU+JMjJsvzt2MX2eJc=
Received: from mail-pf1-f198.google.com (mail-pf1-f198.google.com
 [209.85.210.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-121-I4AJisMEPTuH11pdDcu8jA-1; Mon, 27 Feb 2023 02:22:32 -0500
X-MC-Unique: I4AJisMEPTuH11pdDcu8jA-1
Received: by mail-pf1-f198.google.com with SMTP id
 bw25-20020a056a00409900b005a9d0e66a7aso2965097pfb.5
 for <virtualization@lists.linux-foundation.org>;
 Sun, 26 Feb 2023 23:22:32 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=HcPvEo+F2OZU0bbI4Y5XSo6Zcw491v3lgydd9/bPwkk=;
 b=yAwVvzHmrJnGdwVVTb3AAxwb/DeTd4YcuQwq0k9AeKw+NkhzmbNtTEEh+2mVr1DSZb
 cbBKj7EuUtoHCSpyqKEY8/hMbUoa5HicwpF4IuOLmuL7dfutoO3cyWIn1zIX29PdatzC
 YJGs6KlynaE3K15LJB5mbGPbWPUfBvmLOIr+m0bXzjLSrDrQl4MX2Z0zbzKS0VPQAXEi
 woo1aKtW/MaQJwExHtdJ0xKuNKFIhd9zf2qq1DV3XddjdtwnQX6dt6R3qZgT9ovse0bA
 HKJ2+caJfPBu1xiMR6qZzJQjT1lRJnc1ktVlGzqspz4cmN0uMyYwIfQLqg6ib1KQo8yC
 nJrg==
X-Gm-Message-State: AO0yUKWOQquswL+tcouuifWCFlIr5p9OQUnZH7Xrd6asWLlOy+MGUYLw
 FzwJeNedvXo8OOXIFz5zZABcSzjMGC3wKR/kiICR5Mtl3GxsOB2zYwNDdiLM7n4NaRMRsy+ZfBV
 syfOIs1YA6nV/zRCs7WENkqyLyWpEBPRFaJEAHwi7Uw==
X-Received: by 2002:a17:903:187:b0:196:5d8d:2d6f with SMTP id
 z7-20020a170903018700b001965d8d2d6fmr29505939plg.13.1677482551248; 
 Sun, 26 Feb 2023 23:22:31 -0800 (PST)
X-Google-Smtp-Source: AK7set/Tmd92FMXAhkDaaSorEurrM+gRfdGftBJymrqm93w00a3QMRpI/+lsWUCJ/ovEvblV3HKfPw==
X-Received: by 2002:a17:903:187:b0:196:5d8d:2d6f with SMTP id
 z7-20020a170903018700b001965d8d2d6fmr29505908plg.13.1677482550942; 
 Sun, 26 Feb 2023 23:22:30 -0800 (PST)
Received: from [10.72.13.83] ([209.132.188.80])
 by smtp.gmail.com with ESMTPSA id
 bd4-20020a170902830400b0019a9751096asm3793685plb.305.2023.02.26.23.22.24
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Sun, 26 Feb 2023 23:22:30 -0800 (PST)
Message-ID: <163ea0b7-1814-3ab6-2f8a-ee594914f6bc@redhat.com>
Date: Mon, 27 Feb 2023 15:22:20 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.8.0
Subject: Re: [PATCH v4 05/15] vdpa: move vhost reset after get vring base
To: =?UTF-8?Q?Eugenio_P=c3=a9rez?= <eperezma@redhat.com>, qemu-devel@nongnu.org
References: <20230224155438.112797-1-eperezma@redhat.com>
 <20230224155438.112797-6-eperezma@redhat.com>
From: Jason Wang <jasowang@redhat.com>
In-Reply-To: <20230224155438.112797-6-eperezma@redhat.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Language: en-US
Cc: Laurent Vivier <lvivier@redhat.com>, Parav Pandit <parav@mellanox.com>,
 Cindy Lu <lulu@redhat.com>, "Michael S. Tsirkin" <mst@redhat.com>,
 Gautam Dawar <gdawar@xilinx.com>, virtualization@lists.linux-foundation.org,
 Harpreet Singh Anand <hanand@xilinx.com>, Lei Yang <leiyang@redhat.com>,
 Stefan Hajnoczi <stefanha@redhat.com>, Eli Cohen <eli@mellanox.com>,
 longpeng2@huawei.com, Shannon Nelson <snelson@pensando.io>,
 Liuxiangdong <liuxiangdong5@huawei.com>
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

CuWcqCAyMDIzLzIvMjQgMjM6NTQsIEV1Z2VuaW8gUMOpcmV6IOWGmemBkzoKPiBUaGUgZnVuY3Rp
b24gdmhvc3QuYzp2aG9zdF9kZXZfc3RvcCBjYWxscyB2aG9zdCBvcGVyYXRpb24KPiB2aG9zdF9k
ZXZfc3RhcnQoZmFsc2UpLiBJbiB0aGUgY2FzZSBvZiB2ZHBhIGl0IHRvdGFsbHkgcmVzZXQgYW5k
IHdpcGVzCj4gdGhlIGRldmljZSwgbWFraW5nIHRoZSBmZXRjaGluZyBvZiB0aGUgdnJpbmcgYmFz
ZSAodmlydHF1ZXVlIHN0YXRlKSB0b3RhbGx5Cj4gdXNlbGVzcy4KCgpBcyBkaXNjdXNzZWQgYmVm
b3JlLCBzaG91bGQgd2UgZG8gc29tZXRoaW5nIHJldmVyc2U6IGluIAp2aG9zdF92ZHBhX2Rldl9z
dGFydGVkKCkgc2luY2Ugd2hhdCBwcm9wb3NlZCBpbiB0aGUgcGF0Y2ggZG9lc24ndCBzb2x2ZSAK
dGhlIGlzc3VlIChpbmRleCBjb3VsZCBiZSBtb3ZlZCBhZnRlciB0aGUgZ2V0X3ZyaW5nX2Jhc2Uo
KSkKCjEpIGlmIF9GX1NVU1BFTkQgaXMgbmVnb3RpYXRlZCwgc3VzcGVuZCBpbnN0ZWFkIG9mIHJl
c2V0CgoyKSBpZiBfRl9TVVNQRU5EIGlzIG5vdCBuZWdvdGlhdGVkLCByZXNldCBhbmQgZmFpbCAK
dmhvc3RfZ2V0X3ZyaW5nX2Jhc2UoKSB0byBhbGxvdyBncmFjZWZ1bCBmYWxsYmFjaz8KClRoYW5r
cwoKCj4KPiBUaGUga2VybmVsIGJhY2tlbmQgZG9lcyBub3QgdXNlIHZob3N0X2Rldl9zdGFydCB2
aG9zdCBvcCBjYWxsYmFjaywgYnV0Cj4gdmhvc3QtdXNlciBkby4gQSBwYXRjaCB0byBtYWtlIHZo
b3N0X3VzZXJfZGV2X3N0YXJ0IG1vcmUgc2ltaWxhciB0byB2ZHBhCj4gaXMgZGVzaXJhYmxlLCBi
dXQgaXQgY2FuIGJlIGFkZGVkIG9uIHRvcC4KPgo+IFNpZ25lZC1vZmYtYnk6IEV1Z2VuaW8gUMOp
cmV6IDxlcGVyZXptYUByZWRoYXQuY29tPgo+IC0tLQo+ICAgaW5jbHVkZS9ody92aXJ0aW8vdmhv
c3QtYmFja2VuZC5oIHwgIDQgKysrKwo+ICAgaHcvdmlydGlvL3Zob3N0LXZkcGEuYyAgICAgICAg
ICAgIHwgMjIgKysrKysrKysrKysrKysrKy0tLS0tLQo+ICAgaHcvdmlydGlvL3Zob3N0LmMgICAg
ICAgICAgICAgICAgIHwgIDMgKysrCj4gICAzIGZpbGVzIGNoYW5nZWQsIDIzIGluc2VydGlvbnMo
KyksIDYgZGVsZXRpb25zKC0pCj4KPiBkaWZmIC0tZ2l0IGEvaW5jbHVkZS9ody92aXJ0aW8vdmhv
c3QtYmFja2VuZC5oIGIvaW5jbHVkZS9ody92aXJ0aW8vdmhvc3QtYmFja2VuZC5oCj4gaW5kZXgg
YzVhYjQ5MDUxZS4uZWMzZmJhZTU4ZCAxMDA2NDQKPiAtLS0gYS9pbmNsdWRlL2h3L3ZpcnRpby92
aG9zdC1iYWNrZW5kLmgKPiArKysgYi9pbmNsdWRlL2h3L3ZpcnRpby92aG9zdC1iYWNrZW5kLmgK
PiBAQCAtMTMwLDYgKzEzMCw5IEBAIHR5cGVkZWYgYm9vbCAoKnZob3N0X2ZvcmNlX2lvbW11X29w
KShzdHJ1Y3Qgdmhvc3RfZGV2ICpkZXYpOwo+ICAgCj4gICB0eXBlZGVmIGludCAoKnZob3N0X3Nl
dF9jb25maWdfY2FsbF9vcCkoc3RydWN0IHZob3N0X2RldiAqZGV2LAo+ICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgaW50IGZkKTsKPiArCj4gK3R5cGVkZWYgdm9pZCAo
KnZob3N0X3Jlc2V0X3N0YXR1c19vcCkoc3RydWN0IHZob3N0X2RldiAqZGV2KTsKPiArCj4gICB0
eXBlZGVmIHN0cnVjdCBWaG9zdE9wcyB7Cj4gICAgICAgVmhvc3RCYWNrZW5kVHlwZSBiYWNrZW5k
X3R5cGU7Cj4gICAgICAgdmhvc3RfYmFja2VuZF9pbml0IHZob3N0X2JhY2tlbmRfaW5pdDsKPiBA
QCAtMTc3LDYgKzE4MCw3IEBAIHR5cGVkZWYgc3RydWN0IFZob3N0T3BzIHsKPiAgICAgICB2aG9z
dF9nZXRfZGV2aWNlX2lkX29wIHZob3N0X2dldF9kZXZpY2VfaWQ7Cj4gICAgICAgdmhvc3RfZm9y
Y2VfaW9tbXVfb3Agdmhvc3RfZm9yY2VfaW9tbXU7Cj4gICAgICAgdmhvc3Rfc2V0X2NvbmZpZ19j
YWxsX29wIHZob3N0X3NldF9jb25maWdfY2FsbDsKPiArICAgIHZob3N0X3Jlc2V0X3N0YXR1c19v
cCB2aG9zdF9yZXNldF9zdGF0dXM7Cj4gICB9IFZob3N0T3BzOwo+ICAgCj4gICBpbnQgdmhvc3Rf
YmFja2VuZF91cGRhdGVfZGV2aWNlX2lvdGxiKHN0cnVjdCB2aG9zdF9kZXYgKmRldiwKPiBkaWZm
IC0tZ2l0IGEvaHcvdmlydGlvL3Zob3N0LXZkcGEuYyBiL2h3L3ZpcnRpby92aG9zdC12ZHBhLmMK
PiBpbmRleCA0ZmFjMTQ0MTY5Li44Y2M5Yzk4ZGI5IDEwMDY0NAo+IC0tLSBhL2h3L3ZpcnRpby92
aG9zdC12ZHBhLmMKPiArKysgYi9ody92aXJ0aW8vdmhvc3QtdmRwYS5jCj4gQEAgLTExMzQsMTQg
KzExMzQsMjMgQEAgc3RhdGljIGludCB2aG9zdF92ZHBhX2Rldl9zdGFydChzdHJ1Y3Qgdmhvc3Rf
ZGV2ICpkZXYsIGJvb2wgc3RhcnRlZCkKPiAgICAgICBpZiAoc3RhcnRlZCkgewo+ICAgICAgICAg
ICBtZW1vcnlfbGlzdGVuZXJfcmVnaXN0ZXIoJnYtPmxpc3RlbmVyLCAmYWRkcmVzc19zcGFjZV9t
ZW1vcnkpOwo+ICAgICAgICAgICByZXR1cm4gdmhvc3RfdmRwYV9hZGRfc3RhdHVzKGRldiwgVklS
VElPX0NPTkZJR19TX0RSSVZFUl9PSyk7Cj4gLSAgICB9IGVsc2Ugewo+IC0gICAgICAgIHZob3N0
X3ZkcGFfcmVzZXRfZGV2aWNlKGRldik7Cj4gLSAgICAgICAgdmhvc3RfdmRwYV9hZGRfc3RhdHVz
KGRldiwgVklSVElPX0NPTkZJR19TX0FDS05PV0xFREdFIHwKPiAtICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICBWSVJUSU9fQ09ORklHX1NfRFJJVkVSKTsKPiAtICAgICAgICBtZW1v
cnlfbGlzdGVuZXJfdW5yZWdpc3Rlcigmdi0+bGlzdGVuZXIpOwo+ICsgICAgfQo+ICAgCj4gLSAg
ICAgICAgcmV0dXJuIDA7Cj4gKyAgICByZXR1cm4gMDsKPiArfQo+ICsKPiArc3RhdGljIHZvaWQg
dmhvc3RfdmRwYV9yZXNldF9zdGF0dXMoc3RydWN0IHZob3N0X2RldiAqZGV2KQo+ICt7Cj4gKyAg
ICBzdHJ1Y3Qgdmhvc3RfdmRwYSAqdiA9IGRldi0+b3BhcXVlOwo+ICsKPiArICAgIGlmIChkZXYt
PnZxX2luZGV4ICsgZGV2LT5udnFzICE9IGRldi0+dnFfaW5kZXhfZW5kKSB7Cj4gKyAgICAgICAg
cmV0dXJuOwo+ICAgICAgIH0KPiArCj4gKyAgICB2aG9zdF92ZHBhX3Jlc2V0X2RldmljZShkZXYp
Owo+ICsgICAgdmhvc3RfdmRwYV9hZGRfc3RhdHVzKGRldiwgVklSVElPX0NPTkZJR19TX0FDS05P
V0xFREdFIHwKPiArICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgIFZJUlRJT19DT05GSUdf
U19EUklWRVIpOwo+ICsgICAgbWVtb3J5X2xpc3RlbmVyX3VucmVnaXN0ZXIoJnYtPmxpc3RlbmVy
KTsKPiAgIH0KPiAgIAo+ICAgc3RhdGljIGludCB2aG9zdF92ZHBhX3NldF9sb2dfYmFzZShzdHJ1
Y3Qgdmhvc3RfZGV2ICpkZXYsIHVpbnQ2NF90IGJhc2UsCj4gQEAgLTEzMjgsNCArMTMzNyw1IEBA
IGNvbnN0IFZob3N0T3BzIHZkcGFfb3BzID0gewo+ICAgICAgICAgICAudmhvc3RfdnFfZ2V0X2Fk
ZHIgPSB2aG9zdF92ZHBhX3ZxX2dldF9hZGRyLAo+ICAgICAgICAgICAudmhvc3RfZm9yY2VfaW9t
bXUgPSB2aG9zdF92ZHBhX2ZvcmNlX2lvbW11LAo+ICAgICAgICAgICAudmhvc3Rfc2V0X2NvbmZp
Z19jYWxsID0gdmhvc3RfdmRwYV9zZXRfY29uZmlnX2NhbGwsCj4gKyAgICAgICAgLnZob3N0X3Jl
c2V0X3N0YXR1cyA9IHZob3N0X3ZkcGFfcmVzZXRfc3RhdHVzLAo+ICAgfTsKPiBkaWZmIC0tZ2l0
IGEvaHcvdmlydGlvL3Zob3N0LmMgYi9ody92aXJ0aW8vdmhvc3QuYwo+IGluZGV4IGViOGM0YzM3
OGMuLmEyNjYzOTY1NzYgMTAwNjQ0Cj4gLS0tIGEvaHcvdmlydGlvL3Zob3N0LmMKPiArKysgYi9o
dy92aXJ0aW8vdmhvc3QuYwo+IEBAIC0yMDQ5LDYgKzIwNDksOSBAQCB2b2lkIHZob3N0X2Rldl9z
dG9wKHN0cnVjdCB2aG9zdF9kZXYgKmhkZXYsIFZpcnRJT0RldmljZSAqdmRldiwgYm9vbCB2cmlu
Z3MpCj4gICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgIGhkZXYtPnZxcyArIGksCj4gICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgIGhkZXYtPnZxX2luZGV4ICsgaSk7Cj4gICAgICAg
fQo+ICsgICAgaWYgKGhkZXYtPnZob3N0X29wcy0+dmhvc3RfcmVzZXRfc3RhdHVzKSB7Cj4gKyAg
ICAgICAgaGRldi0+dmhvc3Rfb3BzLT52aG9zdF9yZXNldF9zdGF0dXMoaGRldik7Cj4gKyAgICB9
Cj4gICAKPiAgICAgICBpZiAodmhvc3RfZGV2X2hhc19pb21tdShoZGV2KSkgewo+ICAgICAgICAg
ICBpZiAoaGRldi0+dmhvc3Rfb3BzLT52aG9zdF9zZXRfaW90bGJfY2FsbGJhY2spIHsKCl9fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fClZpcnR1YWxpemF0aW9u
IG1haWxpbmcgbGlzdApWaXJ0dWFsaXphdGlvbkBsaXN0cy5saW51eC1mb3VuZGF0aW9uLm9yZwpo
dHRwczovL2xpc3RzLmxpbnV4Zm91bmRhdGlvbi5vcmcvbWFpbG1hbi9saXN0aW5mby92aXJ0dWFs
aXphdGlvbg==
