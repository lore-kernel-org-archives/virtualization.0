Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 17CD0C64EC4
	for <virtualization@archiver.kernel.org>; Fri,  3 Mar 2023 03:48:38 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 92DFB60AEB;
	Fri,  3 Mar 2023 03:48:38 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 92DFB60AEB
Authentication-Results: smtp3.osuosl.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=BAPHK7gW
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
	by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id pwUaOyb2buFa; Fri,  3 Mar 2023 03:48:37 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp3.osuosl.org (Postfix) with ESMTPS id 0339260AE5;
	Fri,  3 Mar 2023 03:48:36 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 0339260AE5
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id BECC4C0035;
	Fri,  3 Mar 2023 03:48:36 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by lists.linuxfoundation.org (Postfix) with ESMTP id E0DEFC0032
 for <virtualization@lists.linux-foundation.org>;
 Fri,  3 Mar 2023 03:48:34 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id C1A1740519
 for <virtualization@lists.linux-foundation.org>;
 Fri,  3 Mar 2023 03:48:34 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org C1A1740519
Authentication-Results: smtp2.osuosl.org;
 dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com
 header.a=rsa-sha256 header.s=mimecast20190719 header.b=BAPHK7gW
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id I08m5R_LhFD0
 for <virtualization@lists.linux-foundation.org>;
 Fri,  3 Mar 2023 03:48:34 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org E7A5B400E4
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.129.124])
 by smtp2.osuosl.org (Postfix) with ESMTPS id E7A5B400E4
 for <virtualization@lists.linux-foundation.org>;
 Fri,  3 Mar 2023 03:48:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1677815312;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=TPoRGCO9F+Mb1fqiwYhnTqHxbVsWXc4MVsuC2U9dcQ8=;
 b=BAPHK7gWo5CppmIe5YEko4DzTKBx2FNBCREpSpFka95f3JIqa3sf/RD31CwGXsHFw0H4aH
 Dw32xIJb1OvwHgj0A44Hj/WhaKT1UoYUiMX1J7b9ewLn3rAfJJtvO7FBS79TH//C7Xx4pq
 Y9wsU96mWMrJcKxEm3jFFnEiis66q+g=
Received: from mail-pg1-f200.google.com (mail-pg1-f200.google.com
 [209.85.215.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-35-OjP5okNkMwCTNxEORGOwhQ-1; Thu, 02 Mar 2023 22:48:31 -0500
X-MC-Unique: OjP5okNkMwCTNxEORGOwhQ-1
Received: by mail-pg1-f200.google.com with SMTP id
 d34-20020a630e22000000b005039e28b68cso308228pgl.13
 for <virtualization@lists.linux-foundation.org>;
 Thu, 02 Mar 2023 19:48:31 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112; t=1677815310;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=TPoRGCO9F+Mb1fqiwYhnTqHxbVsWXc4MVsuC2U9dcQ8=;
 b=TtXemk/JoBwZLUInrv7/nF4e2lgmqKMXn5sRlXJ9aPBtrIwv0AkogIvONF9SDtgGbh
 /+/sm0AbAQTitVb8l3Sf29FPLV2LW8jfK4kaIK9AniYwP43AeKhTZKZ7ynEUc2asal9T
 lb03NFYgQ2ZtUKmuN6u3ZawYKTtiuMr1QIhBYIs+EIQ+Az95CECtnYg6yFbjr0j+4TYa
 l6FXPMlx99DQbgcDalG3N9C/6X/Pj9V8wRWWzuTMlc9YlTXbqfNUufkJkfYnSyToBPCm
 4EkHlBkFdU5EJnbndj81kEz2wCmZqwyB3rCyaAlMbwj4gKBtV/bc834LuzuNPoJ8T/18
 v2ww==
X-Gm-Message-State: AO0yUKWbOD4ApjfRUGx3ou/sohaiMxPyjWi2vXA+x9tTDzMYyEbFb+IK
 SCM5OXPHDtk5fztaA6M6N3fhivHtmtmj8wb0zbcjcbfmPV6vldN5mMUx7/CK0s5GvdhWopMmuQG
 sscP/5lv4d5woC9k512+vALA1gCebE1HrrGdges7yXA==
X-Received: by 2002:a62:1758:0:b0:5dd:3f84:7d7d with SMTP id
 85-20020a621758000000b005dd3f847d7dmr843019pfx.15.1677815310316; 
 Thu, 02 Mar 2023 19:48:30 -0800 (PST)
X-Google-Smtp-Source: AK7set8XQryonWDRBifVPxSrRhnUPMqUr1YcNpRc1DjbG/IUoSnjOSIx2F9wtlc+qhs2t6bkLVqhxw==
X-Received: by 2002:a62:1758:0:b0:5dd:3f84:7d7d with SMTP id
 85-20020a621758000000b005dd3f847d7dmr842989pfx.15.1677815310031; 
 Thu, 02 Mar 2023 19:48:30 -0800 (PST)
Received: from [10.72.13.180] ([43.228.180.230])
 by smtp.gmail.com with ESMTPSA id
 m21-20020aa78a15000000b00571cdbd0771sm447069pfa.102.2023.03.02.19.48.24
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 02 Mar 2023 19:48:29 -0800 (PST)
Message-ID: <69983de5-7cb7-02a1-8869-0977ff2928b2@redhat.com>
Date: Fri, 3 Mar 2023 11:48:22 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.8.0
Subject: Re: [PATCH v4 12/15] vdpa: block migration if device has unsupported
 features
To: Eugenio Perez Martin <eperezma@redhat.com>
References: <20230224155438.112797-1-eperezma@redhat.com>
 <20230224155438.112797-13-eperezma@redhat.com>
 <2367dcff-e8c3-c3ca-378a-e9e67e10710a@redhat.com>
 <CACGkMEs13RdzLfU8nZwHT0YsZ_hXy47or4t9jkHCoJ1EVa3q9w@mail.gmail.com>
 <CAJaqyWcUMwchHZ66=o+aayVvsAT78iOnWo0g3jbg4A1TiAupfQ@mail.gmail.com>
From: Jason Wang <jasowang@redhat.com>
In-Reply-To: <CAJaqyWcUMwchHZ66=o+aayVvsAT78iOnWo0g3jbg4A1TiAupfQ@mail.gmail.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Language: en-US
Cc: Laurent Vivier <lvivier@redhat.com>, Parav Pandit <parav@mellanox.com>,
 Cindy Lu <lulu@redhat.com>, "Michael S. Tsirkin" <mst@redhat.com>,
 qemu-devel@nongnu.org, Gautam Dawar <gdawar@xilinx.com>,
 virtualization@lists.linux-foundation.org,
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

CuWcqCAyMDIzLzMvMiAwMzozMiwgRXVnZW5pbyBQZXJleiBNYXJ0aW4g5YaZ6YGTOgo+IE9uIE1v
biwgRmViIDI3LCAyMDIzIGF0IDk6MjAgQU0gSmFzb24gV2FuZyA8amFzb3dhbmdAcmVkaGF0LmNv
bT4gd3JvdGU6Cj4+IE9uIE1vbiwgRmViIDI3LCAyMDIzIGF0IDQ6MTXigK9QTSBKYXNvbiBXYW5n
IDxqYXNvd2FuZ0ByZWRoYXQuY29tPiB3cm90ZToKPj4+Cj4+PiDlnKggMjAyMy8yLzI0IDIzOjU0
LCBFdWdlbmlvIFDDqXJleiDlhpnpgZM6Cj4+Pj4gQSB2ZHBhIG5ldCBkZXZpY2UgbXVzdCBpbml0
aWFsaXplIHdpdGggU1ZRIGluIG9yZGVyIHRvIGJlIG1pZ3JhdGFibGUgYXQKPj4+PiB0aGlzIG1v
bWVudCwgYW5kIGluaXRpYWxpemF0aW9uIGNvZGUgdmVyaWZpZXMgc29tZSBjb25kaXRpb25zLiAg
SWYgdGhlCj4+Pj4gZGV2aWNlIGlzIG5vdCBpbml0aWFsaXplZCB3aXRoIHRoZSB4LXN2cSBwYXJh
bWV0ZXIsIGl0IHdpbGwgbm90IGV4cG9zZQo+Pj4+IF9GX0xPRyBzbyB0aGUgdmhvc3Qgc3Vic3lz
dGVtIHdpbGwgYmxvY2sgVk0gbWlncmF0aW9uIGZyb20gaXRzCj4+Pj4gaW5pdGlhbGl6YXRpb24u
Cj4+Pj4KPj4+PiBOZXh0IHBhdGNoZXMgY2hhbmdlIHRoaXMsIHNvIHdlIG5lZWQgdG8gdmVyaWZ5
IG1pZ3JhdGlvbiBjb25kaXRpb25zCj4+Pj4gZGlmZmVyZW50bHkuCj4+Pj4KPj4+PiBRRU1VIG9u
bHkgc3VwcG9ydHMgYSBzdWJzZXQgb2YgbmV0IGZlYXR1cmVzIGluIFNWUSwgYW5kIGl0IGNhbm5v
dAo+Pj4+IG1pZ3JhdGUgc3RhdGUgdGhhdCBjYW5ub3QgdHJhY2sgb3IgcmVzdG9yZSBpbiB0aGUg
ZGVzdGluYXRpb24uICBBZGQgYQo+Pj4+IG1pZ3JhdGlvbiBibG9ja2VyIGlmIHRoZSBkZXZpY2Ug
b2ZmZXIgYW4gdW5zdXBwb3J0ZWQgZmVhdHVyZS4KPj4+Pgo+Pj4+IFNpZ25lZC1vZmYtYnk6IEV1
Z2VuaW8gUMOpcmV6IDxlcGVyZXptYUByZWRoYXQuY29tPgo+Pj4+IC0tLQo+Pj4+IHYzOiBhZGQg
bWlyZ2F0aW9uIGJsb2NrZXIgcHJvcGVybHkgc28gdmhvc3RfZGV2IGNhbiBoYW5kbGUgaXQuCj4+
Pj4gLS0tCj4+Pj4gICAgbmV0L3Zob3N0LXZkcGEuYyB8IDEyICsrKysrKysrLS0tLQo+Pj4+ICAg
IDEgZmlsZSBjaGFuZ2VkLCA4IGluc2VydGlvbnMoKyksIDQgZGVsZXRpb25zKC0pCj4+Pj4KPj4+
PiBkaWZmIC0tZ2l0IGEvbmV0L3Zob3N0LXZkcGEuYyBiL25ldC92aG9zdC12ZHBhLmMKPj4+PiBp
bmRleCA0Zjk4M2RmMDAwLi4wOTRkYzFjMmQwIDEwMDY0NAo+Pj4+IC0tLSBhL25ldC92aG9zdC12
ZHBhLmMKPj4+PiArKysgYi9uZXQvdmhvc3QtdmRwYS5jCj4+Pj4gQEAgLTc5NSw3ICs3OTUsOCBA
QCBzdGF0aWMgTmV0Q2xpZW50U3RhdGUgKm5ldF92aG9zdF92ZHBhX2luaXQoTmV0Q2xpZW50U3Rh
dGUgKnBlZXIsCj4+Pj4gICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
aW50IG52cXMsCj4+Pj4gICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
Ym9vbCBpc19kYXRhcGF0aCwKPj4+PiAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICBib29sIHN2cSwKPj4+PiAtICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgc3RydWN0IHZob3N0X3ZkcGFfaW92YV9yYW5nZSBpb3ZhX3JhbmdlKQo+Pj4+ICsgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICBzdHJ1Y3Qgdmhvc3RfdmRwYV9pb3Zh
X3JhbmdlIGlvdmFfcmFuZ2UsCj4+Pj4gKyAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgIHVpbnQ2NF90IGZlYXR1cmVzKQo+Pj4+ICAgIHsKPj4+PiAgICAgICAgTmV0Q2xpZW50
U3RhdGUgKm5jID0gTlVMTDsKPj4+PiAgICAgICAgVmhvc3RWRFBBU3RhdGUgKnM7Cj4+Pj4gQEAg
LTgxOCw3ICs4MTksMTAgQEAgc3RhdGljIE5ldENsaWVudFN0YXRlICpuZXRfdmhvc3RfdmRwYV9p
bml0KE5ldENsaWVudFN0YXRlICpwZWVyLAo+Pj4+ICAgICAgICBzLT52aG9zdF92ZHBhLnNoYWRv
d192cXNfZW5hYmxlZCA9IHN2cTsKPj4+PiAgICAgICAgcy0+dmhvc3RfdmRwYS5pb3ZhX3Jhbmdl
ID0gaW92YV9yYW5nZTsKPj4+PiAgICAgICAgcy0+dmhvc3RfdmRwYS5zaGFkb3dfZGF0YSA9IHN2
cTsKPj4+PiAtICAgIGlmICghaXNfZGF0YXBhdGgpIHsKPj4+PiArICAgIGlmIChxdWV1ZV9wYWly
X2luZGV4ID09IDApIHsKPj4+PiArICAgICAgICB2aG9zdF92ZHBhX25ldF92YWxpZF9zdnFfZmVh
dHVyZXMoZmVhdHVyZXMsCj4+Pj4gKyAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICZzLT52aG9zdF92ZHBhLm1pZ3JhdGlvbl9ibG9ja2VyKTsKPj4+Cj4+PiBTaW5jZSB3
ZSBkbyB2YWxpZGF0aW9uIGF0IGluaXRpYWxpemF0aW9uLCBpcyB0aGlzIG5lY2Vzc2FyeSB0byB2
YWxpZAo+Pj4gb25jZSBhZ2FpbiBpbiBvdGhlciBwbGFjZXM/Cj4+IE9rLCBhZnRlciByZWFkaW5n
IHBhdGNoIDEzLCBJIHRoaW5rIHRoZSBxdWVzdGlvbiBpczoKPj4KPj4gVGhlIHZhbGlkYXRpb24g
c2VlbXMgdG8gYmUgaW5kZXBlbmRlbnQgdG8gbmV0LCBjYW4gd2UgdmFsaWQgaXQgb25jZQo+PiBk
dXJpbmcgdmhvc3RfdmRwYV9pbml0KCk/Cj4+Cj4gdmhvc3RfdmRwYV9uZXRfdmFsaWRfc3ZxX2Zl
YXR1cmVzIGFsc28gY2hlY2tzIGZvciBuZXQgZmVhdHVyZXMuIEluCj4gcGFydGljdWxhciwgYWxs
IHRoZSBub24gdHJhbnNwb3J0IGZlYXR1cmVzIG11c3QgYmUgaW4KPiB2ZHBhX3N2cV9kZXZpY2Vf
ZmVhdHVyZXMuCj4KPiBUaGlzIGlzIGhvdyB3ZSBwcm90ZWN0IHRoYXQgdGhlIGRldmljZSAvIGd1
ZXN0IHdpbGwgbmV2ZXIgbmVnb3RpYXRlCj4gdGhpbmdzIGxpa2UgVkxBTiBmaWx0ZXJpbmcgc3Vw
cG9ydCwgYXMgU1ZRIHN0aWxsIGRvZXMgbm90IGtub3cgaG93IHRvCj4gcmVzdG9yZSBhdCB0aGUg
ZGVzdGluYXRpb24uCj4KPiBJbiB0aGUgVkxBTiBmaWx0ZXJpbmcgY2FzZSBDVlEgaXMgbmVlZGVk
IHRvIHJlc3RvcmUgVkxBTiwgc28gaXQgaXMKPiBjb3ZlcmVkIGJ5IHBhdGNoIDExLzE1LiBCdXQg
b3RoZXIgZnV0dXJlIGZlYXR1cmVzIG1heSBuZWVkIHN1cHBvcnQgZm9yCj4gcmVzdG9yaW5nIGl0
IGluIHRoZSBkZXN0aW5hdGlvbi4KCgpJIHdvbmRlciBob3cgaGFyZCB0byBoYXZlIGEgZ2VuZXJh
bCB2YWxpZGF0aW9uIGNvZGUgbGV0IG5ldCBzcGVjaWZpYyAKY29kZSB0byBhZHZlcnRpc2UgYSBi
bGFja2xpc3QgdG8gYXZvaWQgY29kZSBkdXBsaWNhdGlvbi4KClRoYW5rcwoKCj4KPiBUaGFua3Mh
Cj4KPj4gVGhhbmtzCj4+Cj4+PiBUaGFua3MKPj4+Cj4+Pgo+Pj4+ICsgICAgfSBlbHNlIGlmICgh
aXNfZGF0YXBhdGgpIHsKPj4+PiAgICAgICAgICAgIHMtPmN2cV9jbWRfb3V0X2J1ZmZlciA9IHFl
bXVfbWVtYWxpZ24ocWVtdV9yZWFsX2hvc3RfcGFnZV9zaXplKCksCj4+Pj4gICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICB2aG9zdF92ZHBhX25ldF9jdnFfY21k
X3BhZ2VfbGVuKCkpOwo+Pj4+ICAgICAgICAgICAgbWVtc2V0KHMtPmN2cV9jbWRfb3V0X2J1ZmZl
ciwgMCwgdmhvc3RfdmRwYV9uZXRfY3ZxX2NtZF9wYWdlX2xlbigpKTsKPj4+PiBAQCAtOTU2LDcg
Kzk2MCw3IEBAIGludCBuZXRfaW5pdF92aG9zdF92ZHBhKGNvbnN0IE5ldGRldiAqbmV0ZGV2LCBj
b25zdCBjaGFyICpuYW1lLAo+Pj4+ICAgICAgICBmb3IgKGkgPSAwOyBpIDwgcXVldWVfcGFpcnM7
IGkrKykgewo+Pj4+ICAgICAgICAgICAgbmNzW2ldID0gbmV0X3Zob3N0X3ZkcGFfaW5pdChwZWVy
LCBUWVBFX1ZIT1NUX1ZEUEEsIG5hbWUsCj4+Pj4gICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgIHZkcGFfZGV2aWNlX2ZkLCBpLCAyLCB0cnVlLCBvcHRzLT54X3N2cSwKPj4+
PiAtICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgIGlvdmFfcmFuZ2UpOwo+Pj4+
ICsgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgaW92YV9yYW5nZSwgZmVhdHVy
ZXMpOwo+Pj4+ICAgICAgICAgICAgaWYgKCFuY3NbaV0pCj4+Pj4gICAgICAgICAgICAgICAgZ290
byBlcnI7Cj4+Pj4gICAgICAgIH0KPj4+PiBAQCAtOTY0LDcgKzk2OCw3IEBAIGludCBuZXRfaW5p
dF92aG9zdF92ZHBhKGNvbnN0IE5ldGRldiAqbmV0ZGV2LCBjb25zdCBjaGFyICpuYW1lLAo+Pj4+
ICAgICAgICBpZiAoaGFzX2N2cSkgewo+Pj4+ICAgICAgICAgICAgbmMgPSBuZXRfdmhvc3RfdmRw
YV9pbml0KHBlZXIsIFRZUEVfVkhPU1RfVkRQQSwgbmFtZSwKPj4+PiAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICB2ZHBhX2RldmljZV9mZCwgaSwgMSwgZmFsc2UsCj4+Pj4gLSAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgIG9wdHMtPnhfc3ZxLCBpb3ZhX3JhbmdlKTsK
Pj4+PiArICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgb3B0cy0+eF9zdnEsIGlvdmFf
cmFuZ2UsIGZlYXR1cmVzKTsKPj4+PiAgICAgICAgICAgIGlmICghbmMpCj4+Pj4gICAgICAgICAg
ICAgICAgZ290byBlcnI7Cj4+Pj4gICAgICAgIH0KCl9fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fClZpcnR1YWxpemF0aW9uIG1haWxpbmcgbGlzdApWaXJ0dWFs
aXphdGlvbkBsaXN0cy5saW51eC1mb3VuZGF0aW9uLm9yZwpodHRwczovL2xpc3RzLmxpbnV4Zm91
bmRhdGlvbi5vcmcvbWFpbG1hbi9saXN0aW5mby92aXJ0dWFsaXphdGlvbg==
