Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 346F3C678DB
	for <virtualization@archiver.kernel.org>; Mon,  6 Mar 2023 03:42:25 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id A23AB410EC;
	Mon,  6 Mar 2023 03:42:24 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org A23AB410EC
Authentication-Results: smtp4.osuosl.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=C5/ytxYi
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
	by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id Qh8WxYI814QT; Mon,  6 Mar 2023 03:42:23 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp4.osuosl.org (Postfix) with ESMTPS id 9F58B410E8;
	Mon,  6 Mar 2023 03:42:22 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org 9F58B410E8
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 71600C0071;
	Mon,  6 Mar 2023 03:42:22 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id A4A7DC0032
 for <virtualization@lists.linux-foundation.org>;
 Mon,  6 Mar 2023 03:42:21 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id 785A28198D
 for <virtualization@lists.linux-foundation.org>;
 Mon,  6 Mar 2023 03:42:21 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 785A28198D
Authentication-Results: smtp1.osuosl.org;
 dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com
 header.a=rsa-sha256 header.s=mimecast20190719 header.b=C5/ytxYi
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id M0K5b9gwaKn0
 for <virtualization@lists.linux-foundation.org>;
 Mon,  6 Mar 2023 03:42:17 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org A87FA80AF5
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.129.124])
 by smtp1.osuosl.org (Postfix) with ESMTPS id A87FA80AF5
 for <virtualization@lists.linux-foundation.org>;
 Mon,  6 Mar 2023 03:42:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1678074136;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=0hxxGEYuqu+9cX3KfGvjhtuGLmd4p9IkeAR52tZdX0E=;
 b=C5/ytxYiMetBz6gA1ruokWuqR6bKfFACz+bkVrT+H2wDKn5ssSbcX6Vg3N8AinySNy3Tio
 p8VqQvY/qFSbjWz7q9CO++/HUTwN+025xeDMM6B/YGmBbRcrv5J+OjvXaeNd+kRU9gtCUT
 ZvW6K4QSmA6hWw9fFRWRjA/Fd+Gwf6I=
Received: from mail-oo1-f69.google.com (mail-oo1-f69.google.com
 [209.85.161.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-73-t1BsSG5BPIC3FMonqnlozQ-1; Sun, 05 Mar 2023 22:42:15 -0500
X-MC-Unique: t1BsSG5BPIC3FMonqnlozQ-1
Received: by mail-oo1-f69.google.com with SMTP id
 l11-20020a4aa78b000000b005254a9621e1so2424477oom.8
 for <virtualization@lists.linux-foundation.org>;
 Sun, 05 Mar 2023 19:42:15 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112; t=1678074134;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=0hxxGEYuqu+9cX3KfGvjhtuGLmd4p9IkeAR52tZdX0E=;
 b=JcYWc0srJQXFPkHJpF7xHliU1r27DjgFa4N047QNSMxyNSWnk7C/kknUTpfWZwXpNI
 8I1N7zfW9sGsPjtT3kAryKjLF8Yevfd+CINWOUh8ah93lu66nBNuJqGNE4z/VEwbOQOJ
 RvXBW/GRo8e3K8/PwZw7Rf6X9d8/jN8c/+D0rl7YyCboe9VoU2h/BsE88X5dktyY4EIn
 njaJs26q873ukgFWv84O9JCxRibql9m9Q6f9rCvWzFxci9pfq2l3PG4n/TGjgD9HH5Rw
 1WTSaVGy6jQlcRKpgsubXjjlP/Ao6aOibriGaXkJID0I+o/rc2REdnn46+wGBLGSTe7t
 dCXQ==
X-Gm-Message-State: AO0yUKWSAR6TUqN7bHPeDcLhQ/Pg9gxmpg/xxXm0yYHy4N17DqG82uxE
 oRHauh4d2caPxYzA3pKLUp9WSzH7Xw8EIuJUBoHbtsyW/LMzjW/djYTGiL19zEowO8ph/iOI3KZ
 U/+VRIEC9XV1eT5XDcfaK/3FpRZTFdmc/5DzLVc0n6es7rQq1lw+JkaiK8g==
X-Received: by 2002:a05:6870:5b31:b0:176:2b47:b31d with SMTP id
 ds49-20020a0568705b3100b001762b47b31dmr3222276oab.9.1678074134690; 
 Sun, 05 Mar 2023 19:42:14 -0800 (PST)
X-Google-Smtp-Source: AK7set+4QXSD+ua72ymuyKgl4lurKjK5AaRc8kiE/b60QioVMM/lFsKqh3RDfE4+SoLG6cs1aeT+iqdgNRuATsIvtvE=
X-Received: by 2002:a05:6870:5b31:b0:176:2b47:b31d with SMTP id
 ds49-20020a0568705b3100b001762b47b31dmr3222254oab.9.1678074134422; Sun, 05
 Mar 2023 19:42:14 -0800 (PST)
MIME-Version: 1.0
References: <20230224155438.112797-1-eperezma@redhat.com>
 <20230224155438.112797-13-eperezma@redhat.com>
 <2367dcff-e8c3-c3ca-378a-e9e67e10710a@redhat.com>
 <CACGkMEs13RdzLfU8nZwHT0YsZ_hXy47or4t9jkHCoJ1EVa3q9w@mail.gmail.com>
 <CAJaqyWcUMwchHZ66=o+aayVvsAT78iOnWo0g3jbg4A1TiAupfQ@mail.gmail.com>
 <69983de5-7cb7-02a1-8869-0977ff2928b2@redhat.com>
 <CAJaqyWfoTO26=aeWbWBBqM-kJpa+4ZtWNxwp2nFmZ9L14BoPqA@mail.gmail.com>
In-Reply-To: <CAJaqyWfoTO26=aeWbWBBqM-kJpa+4ZtWNxwp2nFmZ9L14BoPqA@mail.gmail.com>
From: Jason Wang <jasowang@redhat.com>
Date: Mon, 6 Mar 2023 11:42:03 +0800
Message-ID: <CACGkMEv-2-wj8xhimgX_iwOP1cuTsVKYgp2UTat6Xyg5QTURmw@mail.gmail.com>
Subject: Re: [PATCH v4 12/15] vdpa: block migration if device has unsupported
 features
To: Eugenio Perez Martin <eperezma@redhat.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
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
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Errors-To: virtualization-bounces@lists.linux-foundation.org
Sender: "Virtualization" <virtualization-bounces@lists.linux-foundation.org>

T24gRnJpLCBNYXIgMywgMjAyMyBhdCA0OjU44oCvUE0gRXVnZW5pbyBQZXJleiBNYXJ0aW4gPGVw
ZXJlem1hQHJlZGhhdC5jb20+IHdyb3RlOgo+Cj4gT24gRnJpLCBNYXIgMywgMjAyMyBhdCA0OjQ4
IEFNIEphc29uIFdhbmcgPGphc293YW5nQHJlZGhhdC5jb20+IHdyb3RlOgo+ID4KPiA+Cj4gPiDl
nKggMjAyMy8zLzIgMDM6MzIsIEV1Z2VuaW8gUGVyZXogTWFydGluIOWGmemBkzoKPiA+ID4gT24g
TW9uLCBGZWIgMjcsIDIwMjMgYXQgOToyMCBBTSBKYXNvbiBXYW5nIDxqYXNvd2FuZ0ByZWRoYXQu
Y29tPiB3cm90ZToKPiA+ID4+IE9uIE1vbiwgRmViIDI3LCAyMDIzIGF0IDQ6MTXigK9QTSBKYXNv
biBXYW5nIDxqYXNvd2FuZ0ByZWRoYXQuY29tPiB3cm90ZToKPiA+ID4+Pgo+ID4gPj4+IOWcqCAy
MDIzLzIvMjQgMjM6NTQsIEV1Z2VuaW8gUMOpcmV6IOWGmemBkzoKPiA+ID4+Pj4gQSB2ZHBhIG5l
dCBkZXZpY2UgbXVzdCBpbml0aWFsaXplIHdpdGggU1ZRIGluIG9yZGVyIHRvIGJlIG1pZ3JhdGFi
bGUgYXQKPiA+ID4+Pj4gdGhpcyBtb21lbnQsIGFuZCBpbml0aWFsaXphdGlvbiBjb2RlIHZlcmlm
aWVzIHNvbWUgY29uZGl0aW9ucy4gIElmIHRoZQo+ID4gPj4+PiBkZXZpY2UgaXMgbm90IGluaXRp
YWxpemVkIHdpdGggdGhlIHgtc3ZxIHBhcmFtZXRlciwgaXQgd2lsbCBub3QgZXhwb3NlCj4gPiA+
Pj4+IF9GX0xPRyBzbyB0aGUgdmhvc3Qgc3Vic3lzdGVtIHdpbGwgYmxvY2sgVk0gbWlncmF0aW9u
IGZyb20gaXRzCj4gPiA+Pj4+IGluaXRpYWxpemF0aW9uLgo+ID4gPj4+Pgo+ID4gPj4+PiBOZXh0
IHBhdGNoZXMgY2hhbmdlIHRoaXMsIHNvIHdlIG5lZWQgdG8gdmVyaWZ5IG1pZ3JhdGlvbiBjb25k
aXRpb25zCj4gPiA+Pj4+IGRpZmZlcmVudGx5Lgo+ID4gPj4+Pgo+ID4gPj4+PiBRRU1VIG9ubHkg
c3VwcG9ydHMgYSBzdWJzZXQgb2YgbmV0IGZlYXR1cmVzIGluIFNWUSwgYW5kIGl0IGNhbm5vdAo+
ID4gPj4+PiBtaWdyYXRlIHN0YXRlIHRoYXQgY2Fubm90IHRyYWNrIG9yIHJlc3RvcmUgaW4gdGhl
IGRlc3RpbmF0aW9uLiAgQWRkIGEKPiA+ID4+Pj4gbWlncmF0aW9uIGJsb2NrZXIgaWYgdGhlIGRl
dmljZSBvZmZlciBhbiB1bnN1cHBvcnRlZCBmZWF0dXJlLgo+ID4gPj4+Pgo+ID4gPj4+PiBTaWdu
ZWQtb2ZmLWJ5OiBFdWdlbmlvIFDDqXJleiA8ZXBlcmV6bWFAcmVkaGF0LmNvbT4KPiA+ID4+Pj4g
LS0tCj4gPiA+Pj4+IHYzOiBhZGQgbWlyZ2F0aW9uIGJsb2NrZXIgcHJvcGVybHkgc28gdmhvc3Rf
ZGV2IGNhbiBoYW5kbGUgaXQuCj4gPiA+Pj4+IC0tLQo+ID4gPj4+PiAgICBuZXQvdmhvc3QtdmRw
YS5jIHwgMTIgKysrKysrKystLS0tCj4gPiA+Pj4+ICAgIDEgZmlsZSBjaGFuZ2VkLCA4IGluc2Vy
dGlvbnMoKyksIDQgZGVsZXRpb25zKC0pCj4gPiA+Pj4+Cj4gPiA+Pj4+IGRpZmYgLS1naXQgYS9u
ZXQvdmhvc3QtdmRwYS5jIGIvbmV0L3Zob3N0LXZkcGEuYwo+ID4gPj4+PiBpbmRleCA0Zjk4M2Rm
MDAwLi4wOTRkYzFjMmQwIDEwMDY0NAo+ID4gPj4+PiAtLS0gYS9uZXQvdmhvc3QtdmRwYS5jCj4g
PiA+Pj4+ICsrKyBiL25ldC92aG9zdC12ZHBhLmMKPiA+ID4+Pj4gQEAgLTc5NSw3ICs3OTUsOCBA
QCBzdGF0aWMgTmV0Q2xpZW50U3RhdGUgKm5ldF92aG9zdF92ZHBhX2luaXQoTmV0Q2xpZW50U3Rh
dGUgKnBlZXIsCj4gPiA+Pj4+ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgIGludCBudnFzLAo+ID4gPj4+PiAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICBib29sIGlzX2RhdGFwYXRoLAo+ID4gPj4+PiAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICBib29sIHN2cSwKPiA+ID4+Pj4gLSAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgIHN0cnVjdCB2aG9zdF92ZHBhX2lvdmFfcmFuZ2UgaW92YV9y
YW5nZSkKPiA+ID4+Pj4gKyAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgIHN0
cnVjdCB2aG9zdF92ZHBhX2lvdmFfcmFuZ2UgaW92YV9yYW5nZSwKPiA+ID4+Pj4gKyAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgIHVpbnQ2NF90IGZlYXR1cmVzKQo+ID4gPj4+
PiAgICB7Cj4gPiA+Pj4+ICAgICAgICBOZXRDbGllbnRTdGF0ZSAqbmMgPSBOVUxMOwo+ID4gPj4+
PiAgICAgICAgVmhvc3RWRFBBU3RhdGUgKnM7Cj4gPiA+Pj4+IEBAIC04MTgsNyArODE5LDEwIEBA
IHN0YXRpYyBOZXRDbGllbnRTdGF0ZSAqbmV0X3Zob3N0X3ZkcGFfaW5pdChOZXRDbGllbnRTdGF0
ZSAqcGVlciwKPiA+ID4+Pj4gICAgICAgIHMtPnZob3N0X3ZkcGEuc2hhZG93X3Zxc19lbmFibGVk
ID0gc3ZxOwo+ID4gPj4+PiAgICAgICAgcy0+dmhvc3RfdmRwYS5pb3ZhX3JhbmdlID0gaW92YV9y
YW5nZTsKPiA+ID4+Pj4gICAgICAgIHMtPnZob3N0X3ZkcGEuc2hhZG93X2RhdGEgPSBzdnE7Cj4g
PiA+Pj4+IC0gICAgaWYgKCFpc19kYXRhcGF0aCkgewo+ID4gPj4+PiArICAgIGlmIChxdWV1ZV9w
YWlyX2luZGV4ID09IDApIHsKPiA+ID4+Pj4gKyAgICAgICAgdmhvc3RfdmRwYV9uZXRfdmFsaWRf
c3ZxX2ZlYXR1cmVzKGZlYXR1cmVzLAo+ID4gPj4+PiArICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgJnMtPnZob3N0X3ZkcGEubWlncmF0aW9uX2Jsb2NrZXIpOwo+ID4g
Pj4+Cj4gPiA+Pj4gU2luY2Ugd2UgZG8gdmFsaWRhdGlvbiBhdCBpbml0aWFsaXphdGlvbiwgaXMg
dGhpcyBuZWNlc3NhcnkgdG8gdmFsaWQKPiA+ID4+PiBvbmNlIGFnYWluIGluIG90aGVyIHBsYWNl
cz8KPiA+ID4+IE9rLCBhZnRlciByZWFkaW5nIHBhdGNoIDEzLCBJIHRoaW5rIHRoZSBxdWVzdGlv
biBpczoKPiA+ID4+Cj4gPiA+PiBUaGUgdmFsaWRhdGlvbiBzZWVtcyB0byBiZSBpbmRlcGVuZGVu
dCB0byBuZXQsIGNhbiB3ZSB2YWxpZCBpdCBvbmNlCj4gPiA+PiBkdXJpbmcgdmhvc3RfdmRwYV9p
bml0KCk/Cj4gPiA+Pgo+ID4gPiB2aG9zdF92ZHBhX25ldF92YWxpZF9zdnFfZmVhdHVyZXMgYWxz
byBjaGVja3MgZm9yIG5ldCBmZWF0dXJlcy4gSW4KPiA+ID4gcGFydGljdWxhciwgYWxsIHRoZSBu
b24gdHJhbnNwb3J0IGZlYXR1cmVzIG11c3QgYmUgaW4KPiA+ID4gdmRwYV9zdnFfZGV2aWNlX2Zl
YXR1cmVzLgo+ID4gPgo+ID4gPiBUaGlzIGlzIGhvdyB3ZSBwcm90ZWN0IHRoYXQgdGhlIGRldmlj
ZSAvIGd1ZXN0IHdpbGwgbmV2ZXIgbmVnb3RpYXRlCj4gPiA+IHRoaW5ncyBsaWtlIFZMQU4gZmls
dGVyaW5nIHN1cHBvcnQsIGFzIFNWUSBzdGlsbCBkb2VzIG5vdCBrbm93IGhvdyB0bwo+ID4gPiBy
ZXN0b3JlIGF0IHRoZSBkZXN0aW5hdGlvbi4KPiA+ID4KPiA+ID4gSW4gdGhlIFZMQU4gZmlsdGVy
aW5nIGNhc2UgQ1ZRIGlzIG5lZWRlZCB0byByZXN0b3JlIFZMQU4sIHNvIGl0IGlzCj4gPiA+IGNv
dmVyZWQgYnkgcGF0Y2ggMTEvMTUuIEJ1dCBvdGhlciBmdXR1cmUgZmVhdHVyZXMgbWF5IG5lZWQg
c3VwcG9ydCBmb3IKPiA+ID4gcmVzdG9yaW5nIGl0IGluIHRoZSBkZXN0aW5hdGlvbi4KPiA+Cj4g
Pgo+ID4gSSB3b25kZXIgaG93IGhhcmQgdG8gaGF2ZSBhIGdlbmVyYWwgdmFsaWRhdGlvbiBjb2Rl
IGxldCBuZXQgc3BlY2lmaWMKPiA+IGNvZGUgdG8gYWR2ZXJ0aXNlIGEgYmxhY2tsaXN0IHRvIGF2
b2lkIGNvZGUgZHVwbGljYXRpb24uCj4gPgo+Cj4gQSBibGFja2xpc3QgZG9lcyBub3Qgd29yayBo
ZXJlLCBiZWNhdXNlIEkgZG9uJ3Qga25vdyBpZiBTVlEgbmVlZHMKPiBjaGFuZ2VzIGZvciBmdXR1
cmUgZmVhdHVyZSBiaXRzIHRoYXQgYXJlIHN0aWxsIG5vdCBpbiAvIHByb3Bvc2VkIHRvCj4gdGhl
IHN0YW5kYXJkLgoKQ291bGQgeW91IGdpdmUgbWUgYW4gZXhhbXBsZSBmb3IgdGhpcz8KCj4KPiBS
ZWdhcmRpbmcgdGhlIGNvZGUgZHVwbGljYXRpb24sIGRvIHlvdSBtZWFuIHRvIHZhbGlkYXRlIHRy
YW5zcG9ydAo+IGZlYXR1cmVzIGFuZCBuZXQgc3BlY2lmaWMgZmVhdHVyZXMgaW4gb25lIHNob3Qs
IGluc3RlYWQgb2YgaGF2aW5nIGEKPiBkZWRpY2F0ZWQgZnVuY3Rpb24gZm9yIFNWUSB0cmFuc3Bv
cnQ/CgpOb3BlLgoKVGhhbmtzCgo+Cj4gVGhhbmtzIQo+Cj4gPiBUaGFua3MKPiA+Cj4gPgo+ID4g
Pgo+ID4gPiBUaGFua3MhCj4gPiA+Cj4gPiA+PiBUaGFua3MKPiA+ID4+Cj4gPiA+Pj4gVGhhbmtz
Cj4gPiA+Pj4KPiA+ID4+Pgo+ID4gPj4+PiArICAgIH0gZWxzZSBpZiAoIWlzX2RhdGFwYXRoKSB7
Cj4gPiA+Pj4+ICAgICAgICAgICAgcy0+Y3ZxX2NtZF9vdXRfYnVmZmVyID0gcWVtdV9tZW1hbGln
bihxZW11X3JlYWxfaG9zdF9wYWdlX3NpemUoKSwKPiA+ID4+Pj4gICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICB2aG9zdF92ZHBhX25ldF9jdnFfY21kX3BhZ2Vf
bGVuKCkpOwo+ID4gPj4+PiAgICAgICAgICAgIG1lbXNldChzLT5jdnFfY21kX291dF9idWZmZXIs
IDAsIHZob3N0X3ZkcGFfbmV0X2N2cV9jbWRfcGFnZV9sZW4oKSk7Cj4gPiA+Pj4+IEBAIC05NTYs
NyArOTYwLDcgQEAgaW50IG5ldF9pbml0X3Zob3N0X3ZkcGEoY29uc3QgTmV0ZGV2ICpuZXRkZXYs
IGNvbnN0IGNoYXIgKm5hbWUsCj4gPiA+Pj4+ICAgICAgICBmb3IgKGkgPSAwOyBpIDwgcXVldWVf
cGFpcnM7IGkrKykgewo+ID4gPj4+PiAgICAgICAgICAgIG5jc1tpXSA9IG5ldF92aG9zdF92ZHBh
X2luaXQocGVlciwgVFlQRV9WSE9TVF9WRFBBLCBuYW1lLAo+ID4gPj4+PiAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgdmRwYV9kZXZpY2VfZmQsIGksIDIsIHRydWUsIG9w
dHMtPnhfc3ZxLAo+ID4gPj4+PiAtICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
IGlvdmFfcmFuZ2UpOwo+ID4gPj4+PiArICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgIGlvdmFfcmFuZ2UsIGZlYXR1cmVzKTsKPiA+ID4+Pj4gICAgICAgICAgICBpZiAoIW5jc1tp
XSkKPiA+ID4+Pj4gICAgICAgICAgICAgICAgZ290byBlcnI7Cj4gPiA+Pj4+ICAgICAgICB9Cj4g
PiA+Pj4+IEBAIC05NjQsNyArOTY4LDcgQEAgaW50IG5ldF9pbml0X3Zob3N0X3ZkcGEoY29uc3Qg
TmV0ZGV2ICpuZXRkZXYsIGNvbnN0IGNoYXIgKm5hbWUsCj4gPiA+Pj4+ICAgICAgICBpZiAoaGFz
X2N2cSkgewo+ID4gPj4+PiAgICAgICAgICAgIG5jID0gbmV0X3Zob3N0X3ZkcGFfaW5pdChwZWVy
LCBUWVBFX1ZIT1NUX1ZEUEEsIG5hbWUsCj4gPiA+Pj4+ICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgIHZkcGFfZGV2aWNlX2ZkLCBpLCAxLCBmYWxzZSwKPiA+ID4+Pj4gLSAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgIG9wdHMtPnhfc3ZxLCBpb3ZhX3JhbmdlKTsKPiA+
ID4+Pj4gKyAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgIG9wdHMtPnhfc3ZxLCBpb3Zh
X3JhbmdlLCBmZWF0dXJlcyk7Cj4gPiA+Pj4+ICAgICAgICAgICAgaWYgKCFuYykKPiA+ID4+Pj4g
ICAgICAgICAgICAgICAgZ290byBlcnI7Cj4gPiA+Pj4+ICAgICAgICB9Cj4gPgo+CgpfX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fXwpWaXJ0dWFsaXphdGlvbiBt
YWlsaW5nIGxpc3QKVmlydHVhbGl6YXRpb25AbGlzdHMubGludXgtZm91bmRhdGlvbi5vcmcKaHR0
cHM6Ly9saXN0cy5saW51eGZvdW5kYXRpb24ub3JnL21haWxtYW4vbGlzdGluZm8vdmlydHVhbGl6
YXRpb24=
