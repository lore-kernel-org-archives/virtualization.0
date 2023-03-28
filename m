Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D34A4C76196
	for <virtualization@archiver.kernel.org>; Tue, 28 Mar 2023 06:12:15 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp2.osuosl.org (Postfix) with ESMTP id 5CFD840CAB;
	Tue, 28 Mar 2023 06:12:15 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org 5CFD840CAB
Authentication-Results: smtp2.osuosl.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=C9vDs2g2
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
	by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id 5tDb7wrl8G18; Tue, 28 Mar 2023 06:12:14 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp2.osuosl.org (Postfix) with ESMTPS id A5A504011C;
	Tue, 28 Mar 2023 06:12:13 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org A5A504011C
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 62E71C0036;
	Tue, 28 Mar 2023 06:12:13 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [IPv6:2605:bc80:3010::133])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 41DABC002F
 for <virtualization@lists.linux-foundation.org>;
 Tue, 28 Mar 2023 06:12:11 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id 07C8E40CA4
 for <virtualization@lists.linux-foundation.org>;
 Tue, 28 Mar 2023 06:12:11 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org 07C8E40CA4
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id 8GEn2gRdX1th
 for <virtualization@lists.linux-foundation.org>;
 Tue, 28 Mar 2023 06:12:10 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org D4D414011C
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.129.124])
 by smtp2.osuosl.org (Postfix) with ESMTPS id D4D414011C
 for <virtualization@lists.linux-foundation.org>;
 Tue, 28 Mar 2023 06:12:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1679983928;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=UNYsS8oHSFCBVyHN2UTLJCCtfI7eARSYYdIRY7lOzMs=;
 b=C9vDs2g2CcO28QXTsV/sPeioZJIcRC/zmVyppA3u+rXANX724Rb9qGa78B4CkcYgDmWIeL
 LdVlLGdVuJzAs55r86VcDq7dXAs1UnI9k5zVqrHfZ3nPCANObvRQvpOoA7u8/TbVOdINLH
 lMYmM0ya1avsvWyHZjSuEYT3TrGvong=
Received: from mail-pl1-f200.google.com (mail-pl1-f200.google.com
 [209.85.214.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-377-sEVnzSjQMre276YoVctK_Q-1; Tue, 28 Mar 2023 02:12:07 -0400
X-MC-Unique: sEVnzSjQMre276YoVctK_Q-1
Received: by mail-pl1-f200.google.com with SMTP id
 q9-20020a170902dac900b001a18ceff5ebso7053391plx.4
 for <virtualization@lists.linux-foundation.org>;
 Mon, 27 Mar 2023 23:12:07 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112; t=1679983926;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=UNYsS8oHSFCBVyHN2UTLJCCtfI7eARSYYdIRY7lOzMs=;
 b=BCJFn5v6lAtWgrUBirNUl3Asi+0kNY69W1v8JeP3yXMG1mgvRcI7LZ3Ycwnfx500W1
 TvR4Atlq1nN8zKwLymdqvqlDV13DL/vxFSWZr8Yi/X4vawD2TKgKRCAe77/KJrI+QbdS
 +2GdK50iAS8XlUx8uOq6nXRZj5sTXhimNdaf2Gsr+KPJNx25lPEhsJV92ySCqOEt6+rq
 6L4TtXUYARRBhVSgm3shDpLGm3m3peZ5OGU8Tqon0M/85iY2ElK+GXPf09f1bKQLuCNX
 4lQo1xSAU1zrdWsdYBer2HMML3J5sHabr1q9Q//OP6lhIFGH7Uam3VbAI4fkQt35ABKn
 af0Q==
X-Gm-Message-State: AO0yUKWIqbrsG7IKByYi8wD6gDzvQBws+fKJblpGiX5opOgXV2bm1UcF
 5yUFfJfUZKXF4XEBWG6lGwEWToTjFLi6MEDyxKgAa2qhCb3ptjV9ainKswjcBVIbKgZfSXGPjJJ
 SJ2cpkopLJchbpxRXDvSQ5Z/1dNM47tCjhTxYQ7+Oxw==
X-Received: by 2002:a05:6a20:7a90:b0:d9:bf06:cd85 with SMTP id
 u16-20020a056a207a9000b000d9bf06cd85mr13027289pzh.25.1679983926206; 
 Mon, 27 Mar 2023 23:12:06 -0700 (PDT)
X-Google-Smtp-Source: AK7set9b73dlMpd/8UZwVEk4ZbGlEc2YwAOKpta3/KFIcfRmaz1cHfe5wKsj8Lc0+L6lCJaJP4bu6A==
X-Received: by 2002:a05:6a20:7a90:b0:d9:bf06:cd85 with SMTP id
 u16-20020a056a207a9000b000d9bf06cd85mr13027276pzh.25.1679983925877; 
 Mon, 27 Mar 2023 23:12:05 -0700 (PDT)
Received: from [10.72.13.204] ([209.132.188.80])
 by smtp.gmail.com with ESMTPSA id
 k12-20020a6568cc000000b005136d5a2b26sm1436311pgt.60.2023.03.27.23.12.03
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 27 Mar 2023 23:12:05 -0700 (PDT)
Message-ID: <de2efe1a-1868-2552-7a1a-4aed398dfb98@redhat.com>
Date: Tue, 28 Mar 2023 14:12:00 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.9.0
Subject: Re: [PATCH v4 03/11] virtio-vdpa: Support interrupt affinity
 spreading mechanism
To: "Michael S. Tsirkin" <mst@redhat.com>
References: <20230323053043.35-1-xieyongji@bytedance.com>
 <20230323053043.35-4-xieyongji@bytedance.com>
 <CACGkMEtH0=vr6JQrqWFZqf4p8bcgeKCr4ipqdBc9nv-st3Pfiw@mail.gmail.com>
 <20230324051153-mutt-send-email-mst@kernel.org>
From: Jason Wang <jasowang@redhat.com>
In-Reply-To: <20230324051153-mutt-send-email-mst@kernel.org>
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Language: en-US
Cc: Xie Yongji <xieyongji@bytedance.com>, tglx@linutronix.de, hch@lst.de,
 linux-kernel@vger.kernel.org, virtualization@lists.linux-foundation.org
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

CuWcqCAyMDIzLzMvMjQgMTc6MTIsIE1pY2hhZWwgUy4gVHNpcmtpbiDlhpnpgZM6Cj4gT24gRnJp
LCBNYXIgMjQsIDIwMjMgYXQgMDI6Mjc6NTJQTSArMDgwMCwgSmFzb24gV2FuZyB3cm90ZToKPj4g
T24gVGh1LCBNYXIgMjMsIDIwMjMgYXQgMTozMeKAr1BNIFhpZSBZb25namkgPHhpZXlvbmdqaUBi
eXRlZGFuY2UuY29tPiB3cm90ZToKPj4+IFRvIHN1cHBvcnQgaW50ZXJydXB0IGFmZmluaXR5IHNw
cmVhZGluZyBtZWNoYW5pc20sCj4+PiB0aGlzIG1ha2VzIHVzZSBvZiBncm91cF9jcHVzX2V2ZW5s
eSgpIHRvIGNyZWF0ZQo+Pj4gYW4gaXJxIGNhbGxiYWNrIGFmZmluaXR5IG1hc2sgZm9yIGVhY2gg
dmlydHF1ZXVlCj4+PiBvZiB2ZHBhIGRldmljZS4gVGhlbiB3ZSB3aWxsIHVuaWZ5IHNldF92cV9h
ZmZpbml0eQo+Pj4gY2FsbGJhY2sgdG8gcGFzcyB0aGUgYWZmaW5pdHkgdG8gdGhlIHZkcGEgZGV2
aWNlIGRyaXZlci4KPj4+Cj4+PiBTaWduZWQtb2ZmLWJ5OiBYaWUgWW9uZ2ppIDx4aWV5b25namlA
Ynl0ZWRhbmNlLmNvbT4KPj4gVGhpbmtpbmcgaGFyZCBvZiBhbGwgdGhlIGxvZ2ljcywgSSB0aGlu
ayBJJ3ZlIGZvdW5kIHNvbWV0aGluZyBpbnRlcmVzdGluZy4KPj4KPj4gQ29tbWl0IGFkNzE0NzNk
OWM0MzcgKCJ2aXJ0aW9fYmxrOiB1c2UgdmlydGlvIElSUSBhZmZpbml0eSIpIHRyaWVzIHRvCj4+
IHBhc3MgaXJxX2FmZmluaXR5IHRvIHRyYW5zcG9ydCBzcGVjaWZpYyBmaW5kX3ZxcygpLiAgVGhp
cyBzZWVtcyBhCj4+IGxheWVyIHZpb2xhdGlvbiBzaW5jZSBkcml2ZXIgaGFzIG5vIGtub3dsZWRn
ZSBvZgo+Pgo+PiAxKSB3aGV0aGVyIG9yIG5vdCB0aGUgY2FsbGJhY2sgaXMgYmFzZWQgb24gYW4g
SVJRCj4+IDIpIHdoZXRoZXIgb3Igbm90IHRoZSBkZXZpY2UgaXMgYSBQQ0kgb3Igbm90ICh0aGUg
ZGV0YWlscyBhcmUgaGlkZWQgYnkKPj4gdGhlIHRyYW5zcG9ydCBkcml2ZXIpCj4+IDMpIGhvdyBt
YW55IHZlY3RvcnMgY291bGQgYmUgdXNlZCBieSBhIGRldmljZQo+Pgo+PiBUaGlzIG1lYW5zIHRo
ZSBkcml2ZXIgY2FuJ3QgYWN0dWFsbHkgcGFzcyBhIHJlYWwgYWZmaW5pdHkgbWFza3Mgc28gdGhl
Cj4+IGNvbW1pdCBwYXNzZXMgYSB6ZXJvIGlycSBhZmZpbml0eSBzdHJ1Y3R1cmUgYXMgYSBoaW50
IGluIGZhY3QsIHNvIHRoZQo+PiBQQ0kgbGF5ZXIgY2FuIGJ1aWxkIGEgZGVmYXVsdCBhZmZpbml0
eSBiYXNlZCB0aGF0IGdyb3VwcyBjcHVzIGV2ZW5seQo+PiBiYXNlZCBvbiB0aGUgbnVtYmVyIG9m
IE1TSS1YIHZlY3RvcnMgKHRoZSBjb3JlIGxvZ2ljIGlzIHRoZQo+PiBncm91cF9jcHVzX2V2ZW5s
eSkuIEkgdGhpbmsgd2Ugc2hvdWxkIGZpeCB0aGlzIGJ5IHJlcGxhY2luZyB0aGUKPj4gaXJxX2Fm
ZmluaXR5IHN0cnVjdHVyZSB3aXRoCj4+Cj4+IDEpIGEgYm9vbGVhbiBsaWtlIGF1dG9fY2Jfc3By
ZWFkaW5nCj4+Cj4+IG9yCj4+Cj4+IDIpIHF1ZXVlIHRvIGNwdSBtYXBwaW5nCj4+Cj4+IFNvIGVh
Y2ggdHJhbnNwb3J0IGNhbiBkbyBpdHMgb3duIGxvZ2ljIGJhc2VkIG9uIHRoYXQuIFRoZW4gdmly
dGlvLXZEUEEKPj4gY2FuIHBhc3MgdGhhdCBwb2xpY3kgdG8gVkRVU0Ugd2hlcmUgd2Ugb25seSBu
ZWVkIGEgZ3JvdXBfY3B1c19ldmVubHkoKQo+PiBhbmQgYXZvaWQgZHVwbGljYXRpbmcgaXJxX2Ny
ZWF0ZV9hZmZpbml0eV9tYXNrcygpPwo+Pgo+PiBUaGFua3MKPiBJIGRvbid0IHJlYWxseSB1bmRl
cnN0YW5kIHdoYXQgeW91IHByb3Bvc2UuIENhcmUgdG8gcG9zdCBhIHBhdGNoPwoKCkkgbWVhbnQg
dG8gYXZvaWQgcGFzc2luZyBpcnFfYWZmaW5pdHkgc3RydWN0dXJlIGluIGZpbmRfdnFzIGJ1dCBh
biBhcnJheSAKb2YgYm9vbGVhbiB0ZWxsaW5nIHVzIHdoZXRoZXIgb3Igbm90IHRoZSB2cSByZXF1
aXJlcyBhIGF1dG9tYXRpYyAKc3ByZWFkaW5nIG9mIGNhbGxiYWNrcy4gQnV0IGl0IHNlZW1zIGxl
c3MgZmxleGlibGUuCgoKPiBBbHNvIGRvZXMgaXQgaGF2ZSB0byBibG9jayB0aGlzIHBhdGNoc2V0
IG9yIGNhbiBpdCBiZSBkb25lIG9uIHRvcD8KCgpXZSBjYW4gbGVhdmUgaXQgaW4gdGhlIGZ1dHVy
ZS4KClNvCgpBY2tlZC1ieTogSmFzb24gV2FuZyA8amFzb3dhbmdAcmVkaGF0LmNvbT4KClRoYW5r
cwoKCj4KPj4+IC0tLQo+Pj4gICBkcml2ZXJzL3ZpcnRpby92aXJ0aW9fdmRwYS5jIHwgNjggKysr
KysrKysrKysrKysrKysrKysrKysrKysrKysrKysrKysrCj4+PiAgIDEgZmlsZSBjaGFuZ2VkLCA2
OCBpbnNlcnRpb25zKCspCj4+Pgo+Pj4gZGlmZiAtLWdpdCBhL2RyaXZlcnMvdmlydGlvL3ZpcnRp
b192ZHBhLmMgYi9kcml2ZXJzL3ZpcnRpby92aXJ0aW9fdmRwYS5jCj4+PiBpbmRleCBmNzI2OTZi
NGMxYzIuLmYzODI2ZjQyYjcwNCAxMDA2NDQKPj4+IC0tLSBhL2RyaXZlcnMvdmlydGlvL3ZpcnRp
b192ZHBhLmMKPj4+ICsrKyBiL2RyaXZlcnMvdmlydGlvL3ZpcnRpb192ZHBhLmMKPj4+IEBAIC0x
Myw2ICsxMyw3IEBACj4+PiAgICNpbmNsdWRlIDxsaW51eC9rZXJuZWwuaD4KPj4+ICAgI2luY2x1
ZGUgPGxpbnV4L3NsYWIuaD4KPj4+ICAgI2luY2x1ZGUgPGxpbnV4L3V1aWQuaD4KPj4+ICsjaW5j
bHVkZSA8bGludXgvZ3JvdXBfY3B1cy5oPgo+Pj4gICAjaW5jbHVkZSA8bGludXgvdmlydGlvLmg+
Cj4+PiAgICNpbmNsdWRlIDxsaW51eC92ZHBhLmg+Cj4+PiAgICNpbmNsdWRlIDxsaW51eC92aXJ0
aW9fY29uZmlnLmg+Cj4+PiBAQCAtMjcyLDYgKzI3Myw2NiBAQCBzdGF0aWMgdm9pZCB2aXJ0aW9f
dmRwYV9kZWxfdnFzKHN0cnVjdCB2aXJ0aW9fZGV2aWNlICp2ZGV2KQo+Pj4gICAgICAgICAgICAg
ICAgICB2aXJ0aW9fdmRwYV9kZWxfdnEodnEpOwo+Pj4gICB9Cj4+Pgo+Pj4gK3N0YXRpYyB2b2lk
IGRlZmF1bHRfY2FsY19zZXRzKHN0cnVjdCBpcnFfYWZmaW5pdHkgKmFmZmQsIHVuc2lnbmVkIGlu
dCBhZmZ2ZWNzKQo+Pj4gK3sKPj4+ICsgICAgICAgYWZmZC0+bnJfc2V0cyA9IDE7Cj4+PiArICAg
ICAgIGFmZmQtPnNldF9zaXplWzBdID0gYWZmdmVjczsKPj4+ICt9Cj4+PiArCj4+PiArc3RhdGlj
IHN0cnVjdCBjcHVtYXNrICoKPj4+ICtjcmVhdGVfYWZmaW5pdHlfbWFza3ModW5zaWduZWQgaW50
IG52ZWNzLCBzdHJ1Y3QgaXJxX2FmZmluaXR5ICphZmZkKQo+Pj4gK3sKPj4+ICsgICAgICAgdW5z
aWduZWQgaW50IGFmZnZlY3MgPSAwLCBjdXJ2ZWMsIHVzZWR2ZWNzLCBpOwo+Pj4gKyAgICAgICBz
dHJ1Y3QgY3B1bWFzayAqbWFza3MgPSBOVUxMOwo+Pj4gKwo+Pj4gKyAgICAgICBpZiAobnZlY3Mg
PiBhZmZkLT5wcmVfdmVjdG9ycyArIGFmZmQtPnBvc3RfdmVjdG9ycykKPj4+ICsgICAgICAgICAg
ICAgICBhZmZ2ZWNzID0gbnZlY3MgLSBhZmZkLT5wcmVfdmVjdG9ycyAtIGFmZmQtPnBvc3RfdmVj
dG9yczsKPj4+ICsKPj4+ICsgICAgICAgaWYgKCFhZmZkLT5jYWxjX3NldHMpCj4+PiArICAgICAg
ICAgICAgICAgYWZmZC0+Y2FsY19zZXRzID0gZGVmYXVsdF9jYWxjX3NldHM7Cj4+PiArCj4+PiAr
ICAgICAgIGFmZmQtPmNhbGNfc2V0cyhhZmZkLCBhZmZ2ZWNzKTsKPj4+ICsKPj4+ICsgICAgICAg
aWYgKCFhZmZ2ZWNzKQo+Pj4gKyAgICAgICAgICAgICAgIHJldHVybiBOVUxMOwo+Pj4gKwo+Pj4g
KyAgICAgICBtYXNrcyA9IGtjYWxsb2MobnZlY3MsIHNpemVvZigqbWFza3MpLCBHRlBfS0VSTkVM
KTsKPj4+ICsgICAgICAgaWYgKCFtYXNrcykKPj4+ICsgICAgICAgICAgICAgICByZXR1cm4gTlVM
TDsKPj4+ICsKPj4+ICsgICAgICAgLyogRmlsbCBvdXQgdmVjdG9ycyBhdCB0aGUgYmVnaW5uaW5n
IHRoYXQgZG9uJ3QgbmVlZCBhZmZpbml0eSAqLwo+Pj4gKyAgICAgICBmb3IgKGN1cnZlYyA9IDA7
IGN1cnZlYyA8IGFmZmQtPnByZV92ZWN0b3JzOyBjdXJ2ZWMrKykKPj4+ICsgICAgICAgICAgICAg
ICBjcHVtYXNrX3NldGFsbCgmbWFza3NbY3VydmVjXSk7Cj4+PiArCj4+PiArICAgICAgIGZvciAo
aSA9IDAsIHVzZWR2ZWNzID0gMDsgaSA8IGFmZmQtPm5yX3NldHM7IGkrKykgewo+Pj4gKyAgICAg
ICAgICAgICAgIHVuc2lnbmVkIGludCB0aGlzX3ZlY3MgPSBhZmZkLT5zZXRfc2l6ZVtpXTsKPj4+
ICsgICAgICAgICAgICAgICBpbnQgajsKPj4+ICsgICAgICAgICAgICAgICBzdHJ1Y3QgY3B1bWFz
ayAqcmVzdWx0ID0gZ3JvdXBfY3B1c19ldmVubHkodGhpc192ZWNzKTsKPj4+ICsKPj4+ICsgICAg
ICAgICAgICAgICBpZiAoIXJlc3VsdCkgewo+Pj4gKyAgICAgICAgICAgICAgICAgICAgICAga2Zy
ZWUobWFza3MpOwo+Pj4gKyAgICAgICAgICAgICAgICAgICAgICAgcmV0dXJuIE5VTEw7Cj4+PiAr
ICAgICAgICAgICAgICAgfQo+Pj4gKwo+Pj4gKyAgICAgICAgICAgICAgIGZvciAoaiA9IDA7IGog
PCB0aGlzX3ZlY3M7IGorKykKPj4+ICsgICAgICAgICAgICAgICAgICAgICAgIGNwdW1hc2tfY29w
eSgmbWFza3NbY3VydmVjICsgal0sICZyZXN1bHRbal0pOwo+Pj4gKyAgICAgICAgICAgICAgIGtm
cmVlKHJlc3VsdCk7Cj4+PiArCj4+PiArICAgICAgICAgICAgICAgY3VydmVjICs9IHRoaXNfdmVj
czsKPj4+ICsgICAgICAgICAgICAgICB1c2VkdmVjcyArPSB0aGlzX3ZlY3M7Cj4+PiArICAgICAg
IH0KPj4+ICsKPj4+ICsgICAgICAgLyogRmlsbCBvdXQgdmVjdG9ycyBhdCB0aGUgZW5kIHRoYXQg
ZG9uJ3QgbmVlZCBhZmZpbml0eSAqLwo+Pj4gKyAgICAgICBpZiAodXNlZHZlY3MgPj0gYWZmdmVj
cykKPj4+ICsgICAgICAgICAgICAgICBjdXJ2ZWMgPSBhZmZkLT5wcmVfdmVjdG9ycyArIGFmZnZl
Y3M7Cj4+PiArICAgICAgIGVsc2UKPj4+ICsgICAgICAgICAgICAgICBjdXJ2ZWMgPSBhZmZkLT5w
cmVfdmVjdG9ycyArIHVzZWR2ZWNzOwo+Pj4gKyAgICAgICBmb3IgKDsgY3VydmVjIDwgbnZlY3M7
IGN1cnZlYysrKQo+Pj4gKyAgICAgICAgICAgICAgIGNwdW1hc2tfc2V0YWxsKCZtYXNrc1tjdXJ2
ZWNdKTsKPj4+ICsKPj4+ICsgICAgICAgcmV0dXJuIG1hc2tzOwo+Pj4gK30KPj4+ICsKPj4+ICAg
c3RhdGljIGludCB2aXJ0aW9fdmRwYV9maW5kX3ZxcyhzdHJ1Y3QgdmlydGlvX2RldmljZSAqdmRl
diwgdW5zaWduZWQgaW50IG52cXMsCj4+PiAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICBzdHJ1Y3QgdmlydHF1ZXVlICp2cXNbXSwKPj4+ICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgIHZxX2NhbGxiYWNrX3QgKmNhbGxiYWNrc1tdLAo+Pj4gQEAgLTI4Miw5ICszNDMsMTUg
QEAgc3RhdGljIGludCB2aXJ0aW9fdmRwYV9maW5kX3ZxcyhzdHJ1Y3QgdmlydGlvX2RldmljZSAq
dmRldiwgdW5zaWduZWQgaW50IG52cXMsCj4+PiAgICAgICAgICBzdHJ1Y3QgdmlydGlvX3ZkcGFf
ZGV2aWNlICp2ZF9kZXYgPSB0b192aXJ0aW9fdmRwYV9kZXZpY2UodmRldik7Cj4+PiAgICAgICAg
ICBzdHJ1Y3QgdmRwYV9kZXZpY2UgKnZkcGEgPSB2ZF9nZXRfdmRwYSh2ZGV2KTsKPj4+ICAgICAg
ICAgIGNvbnN0IHN0cnVjdCB2ZHBhX2NvbmZpZ19vcHMgKm9wcyA9IHZkcGEtPmNvbmZpZzsKPj4+
ICsgICAgICAgc3RydWN0IGlycV9hZmZpbml0eSBkZWZhdWx0X2FmZmQgPSB7IDAgfTsKPj4+ICsg
ICAgICAgc3RydWN0IGNwdW1hc2sgKm1hc2tzOwo+Pj4gICAgICAgICAgc3RydWN0IHZkcGFfY2Fs
bGJhY2sgY2I7Cj4+PiAgICAgICAgICBpbnQgaSwgZXJyLCBxdWV1ZV9pZHggPSAwOwo+Pj4KPj4+
ICsgICAgICAgbWFza3MgPSBjcmVhdGVfYWZmaW5pdHlfbWFza3MobnZxcywgZGVzYyA/IGRlc2Mg
OiAmZGVmYXVsdF9hZmZkKTsKPj4+ICsgICAgICAgaWYgKCFtYXNrcykKPj4+ICsgICAgICAgICAg
ICAgICByZXR1cm4gLUVOT01FTTsKPj4+ICsKPj4+ICAgICAgICAgIGZvciAoaSA9IDA7IGkgPCBu
dnFzOyArK2kpIHsKPj4+ICAgICAgICAgICAgICAgICAgaWYgKCFuYW1lc1tpXSkgewo+Pj4gICAg
ICAgICAgICAgICAgICAgICAgICAgIHZxc1tpXSA9IE5VTEw7Cj4+PiBAQCAtMjk4LDYgKzM2NSw3
IEBAIHN0YXRpYyBpbnQgdmlydGlvX3ZkcGFfZmluZF92cXMoc3RydWN0IHZpcnRpb19kZXZpY2Ug
KnZkZXYsIHVuc2lnbmVkIGludCBudnFzLAo+Pj4gICAgICAgICAgICAgICAgICAgICAgICAgIGVy
ciA9IFBUUl9FUlIodnFzW2ldKTsKPj4+ICAgICAgICAgICAgICAgICAgICAgICAgICBnb3RvIGVy
cl9zZXR1cF92cTsKPj4+ICAgICAgICAgICAgICAgICAgfQo+Pj4gKyAgICAgICAgICAgICAgIG9w
cy0+c2V0X3ZxX2FmZmluaXR5KHZkcGEsIGksICZtYXNrc1tpXSk7Cj4+PiAgICAgICAgICB9Cj4+
Pgo+Pj4gICAgICAgICAgY2IuY2FsbGJhY2sgPSB2aXJ0aW9fdmRwYV9jb25maWdfY2I7Cj4+PiAt
LQo+Pj4gMi4yMC4xCj4+PgoKX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX18KVmlydHVhbGl6YXRpb24gbWFpbGluZyBsaXN0ClZpcnR1YWxpemF0aW9uQGxpc3Rz
LmxpbnV4LWZvdW5kYXRpb24ub3JnCmh0dHBzOi8vbGlzdHMubGludXhmb3VuZGF0aW9uLm9yZy9t
YWlsbWFuL2xpc3RpbmZvL3ZpcnR1YWxpemF0aW9u
