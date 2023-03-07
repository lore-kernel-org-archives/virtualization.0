Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 69E58C678DB
	for <virtualization@archiver.kernel.org>; Tue,  7 Mar 2023 06:48:29 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id EA7EF60F82;
	Tue,  7 Mar 2023 06:48:28 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org EA7EF60F82
Authentication-Results: smtp3.osuosl.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=UW78k9r5
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
	by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id ub42qHCU8C6y; Tue,  7 Mar 2023 06:48:27 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp3.osuosl.org (Postfix) with ESMTPS id 3D6AD60017;
	Tue,  7 Mar 2023 06:48:27 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 3D6AD60017
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 1217BC0035;
	Tue,  7 Mar 2023 06:48:27 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [IPv6:2605:bc80:3010::138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 60BD7C0032
 for <virtualization@lists.linux-foundation.org>;
 Tue,  7 Mar 2023 06:48:26 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id 350F281297
 for <virtualization@lists.linux-foundation.org>;
 Tue,  7 Mar 2023 06:48:26 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 350F281297
Authentication-Results: smtp1.osuosl.org;
 dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com
 header.a=rsa-sha256 header.s=mimecast20190719 header.b=UW78k9r5
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id biEOYPBcYOVM
 for <virtualization@lists.linux-foundation.org>;
 Tue,  7 Mar 2023 06:48:25 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 2879C8128C
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.129.124])
 by smtp1.osuosl.org (Postfix) with ESMTPS id 2879C8128C
 for <virtualization@lists.linux-foundation.org>;
 Tue,  7 Mar 2023 06:48:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1678171704;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=R3M1AL7gGt3kJiG4+gSZXGyHp5vbuknmiuJBLx39/J8=;
 b=UW78k9r5uVI+mKruCPum0KS8FrkyzPzZnZuIKpGNrDSRO/GMubtTO6JRQOzXyuFjXSh08Q
 QScxhwsJ4Y65LWYTGEcCnsZ9Hs4IAv1TXwJ4ZvK1U6aPZStsdtj6vI4FzI6AlOmdytAAWh
 cTWeWMpsA0uRUcmClDpuDzZdLvqfOSo=
Received: from mail-oo1-f69.google.com (mail-oo1-f69.google.com
 [209.85.161.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-157-Hbe3efdZMF25_pW2sxPwzw-1; Tue, 07 Mar 2023 01:48:20 -0500
X-MC-Unique: Hbe3efdZMF25_pW2sxPwzw-1
Received: by mail-oo1-f69.google.com with SMTP id
 c9-20020a4a4f09000000b005178610a793so3675803oob.3
 for <virtualization@lists.linux-foundation.org>;
 Mon, 06 Mar 2023 22:48:20 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112; t=1678171700;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=R3M1AL7gGt3kJiG4+gSZXGyHp5vbuknmiuJBLx39/J8=;
 b=sTIv7loMSIH+vcd6ueIuUt1p5zigxhI26WMqXcxpoBVcJ6LXeUGDfSA3GU8X1Hrgd4
 guIo7Ks9EhZ0+SEFcsEhup+06iqUJI4o5EOZpjTgvDwdEkLYO5xuYUDFFvBc2N0Q15m6
 kG2nX4fXgHQprtB9PEps/WFEgd9aJT5XGC0gfwOTrJrU0dkNx23L8foCZjBAMEZ8ZAeB
 qjw5mr018hDQM/u74KZjYGJO4iJF8r2i+iaC4IetnOydqCkFTuywwcRFxnajNymeFhkd
 olpkiNuA0of1xhVqo6KlUoOoUXytTfE1Fz/ab8nL3aBZ+ssniilriNokkLavAImL5vbB
 Za+Q==
X-Gm-Message-State: AO0yUKWgaVayaXDBYOEtvyFaKBEFTr+yVlgYD8wHZptnvg58I+36xe3Z
 mVcVnswmrDGUe9tV1JTrs4QMSrfINaweBJTku3av4bZeOq47FTgnSluw8RnPeVeCR3FMsX6A9LA
 77gPGkq0qVzgEs0j7nrjUQVoF2sBJEQlhy6cNx+1PDEocPc5Q/YwqmSYAyA==
X-Received: by 2002:a4a:928d:0:b0:51a:ac8f:b6f9 with SMTP id
 i13-20020a4a928d000000b0051aac8fb6f9mr4684091ooh.1.1678171700140; 
 Mon, 06 Mar 2023 22:48:20 -0800 (PST)
X-Google-Smtp-Source: AK7set/i6lz3SO48I0zqOqq1M5y/nEDvYw4GjBBFJf8XBLTK9DyWX6AqMQ5gGaoE0ZScm6+KeNY1SCsUEuP+cPYswoA=
X-Received: by 2002:a4a:928d:0:b0:51a:ac8f:b6f9 with SMTP id
 i13-20020a4a928d000000b0051aac8fb6f9mr4684064ooh.1.1678171699855; Mon, 06 Mar
 2023 22:48:19 -0800 (PST)
MIME-Version: 1.0
References: <20230224155438.112797-1-eperezma@redhat.com>
 <20230224155438.112797-13-eperezma@redhat.com>
 <2367dcff-e8c3-c3ca-378a-e9e67e10710a@redhat.com>
 <CACGkMEs13RdzLfU8nZwHT0YsZ_hXy47or4t9jkHCoJ1EVa3q9w@mail.gmail.com>
 <CAJaqyWcUMwchHZ66=o+aayVvsAT78iOnWo0g3jbg4A1TiAupfQ@mail.gmail.com>
 <69983de5-7cb7-02a1-8869-0977ff2928b2@redhat.com>
 <CAJaqyWfoTO26=aeWbWBBqM-kJpa+4ZtWNxwp2nFmZ9L14BoPqA@mail.gmail.com>
 <CACGkMEv-2-wj8xhimgX_iwOP1cuTsVKYgp2UTat6Xyg5QTURmw@mail.gmail.com>
 <CAJaqyWdHZJ7ty57=V=CAg_8hB-DQ4K77QPJpJux39nEFPY0+DQ@mail.gmail.com>
In-Reply-To: <CAJaqyWdHZJ7ty57=V=CAg_8hB-DQ4K77QPJpJux39nEFPY0+DQ@mail.gmail.com>
From: Jason Wang <jasowang@redhat.com>
Date: Tue, 7 Mar 2023 14:48:08 +0800
Message-ID: <CACGkMEv=LJqkWnEvDT+2gewJpnxvaSuN49K99Ou=rk5dY5wFXQ@mail.gmail.com>
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

T24gTW9uLCBNYXIgNiwgMjAyMyBhdCA3OjMz4oCvUE0gRXVnZW5pbyBQZXJleiBNYXJ0aW4gPGVw
ZXJlem1hQHJlZGhhdC5jb20+IHdyb3RlOgo+Cj4gT24gTW9uLCBNYXIgNiwgMjAyMyBhdCA0OjQy
4oCvQU0gSmFzb24gV2FuZyA8amFzb3dhbmdAcmVkaGF0LmNvbT4gd3JvdGU6Cj4gPgo+ID4gT24g
RnJpLCBNYXIgMywgMjAyMyBhdCA0OjU44oCvUE0gRXVnZW5pbyBQZXJleiBNYXJ0aW4gPGVwZXJl
em1hQHJlZGhhdC5jb20+IHdyb3RlOgo+ID4gPgo+ID4gPiBPbiBGcmksIE1hciAzLCAyMDIzIGF0
IDQ6NDggQU0gSmFzb24gV2FuZyA8amFzb3dhbmdAcmVkaGF0LmNvbT4gd3JvdGU6Cj4gPiA+ID4K
PiA+ID4gPgo+ID4gPiA+IOWcqCAyMDIzLzMvMiAwMzozMiwgRXVnZW5pbyBQZXJleiBNYXJ0aW4g
5YaZ6YGTOgo+ID4gPiA+ID4gT24gTW9uLCBGZWIgMjcsIDIwMjMgYXQgOToyMCBBTSBKYXNvbiBX
YW5nIDxqYXNvd2FuZ0ByZWRoYXQuY29tPiB3cm90ZToKPiA+ID4gPiA+PiBPbiBNb24sIEZlYiAy
NywgMjAyMyBhdCA0OjE14oCvUE0gSmFzb24gV2FuZyA8amFzb3dhbmdAcmVkaGF0LmNvbT4gd3Jv
dGU6Cj4gPiA+ID4gPj4+Cj4gPiA+ID4gPj4+IOWcqCAyMDIzLzIvMjQgMjM6NTQsIEV1Z2VuaW8g
UMOpcmV6IOWGmemBkzoKPiA+ID4gPiA+Pj4+IEEgdmRwYSBuZXQgZGV2aWNlIG11c3QgaW5pdGlh
bGl6ZSB3aXRoIFNWUSBpbiBvcmRlciB0byBiZSBtaWdyYXRhYmxlIGF0Cj4gPiA+ID4gPj4+PiB0
aGlzIG1vbWVudCwgYW5kIGluaXRpYWxpemF0aW9uIGNvZGUgdmVyaWZpZXMgc29tZSBjb25kaXRp
b25zLiAgSWYgdGhlCj4gPiA+ID4gPj4+PiBkZXZpY2UgaXMgbm90IGluaXRpYWxpemVkIHdpdGgg
dGhlIHgtc3ZxIHBhcmFtZXRlciwgaXQgd2lsbCBub3QgZXhwb3NlCj4gPiA+ID4gPj4+PiBfRl9M
T0cgc28gdGhlIHZob3N0IHN1YnN5c3RlbSB3aWxsIGJsb2NrIFZNIG1pZ3JhdGlvbiBmcm9tIGl0
cwo+ID4gPiA+ID4+Pj4gaW5pdGlhbGl6YXRpb24uCj4gPiA+ID4gPj4+Pgo+ID4gPiA+ID4+Pj4g
TmV4dCBwYXRjaGVzIGNoYW5nZSB0aGlzLCBzbyB3ZSBuZWVkIHRvIHZlcmlmeSBtaWdyYXRpb24g
Y29uZGl0aW9ucwo+ID4gPiA+ID4+Pj4gZGlmZmVyZW50bHkuCj4gPiA+ID4gPj4+Pgo+ID4gPiA+
ID4+Pj4gUUVNVSBvbmx5IHN1cHBvcnRzIGEgc3Vic2V0IG9mIG5ldCBmZWF0dXJlcyBpbiBTVlEs
IGFuZCBpdCBjYW5ub3QKPiA+ID4gPiA+Pj4+IG1pZ3JhdGUgc3RhdGUgdGhhdCBjYW5ub3QgdHJh
Y2sgb3IgcmVzdG9yZSBpbiB0aGUgZGVzdGluYXRpb24uICBBZGQgYQo+ID4gPiA+ID4+Pj4gbWln
cmF0aW9uIGJsb2NrZXIgaWYgdGhlIGRldmljZSBvZmZlciBhbiB1bnN1cHBvcnRlZCBmZWF0dXJl
Lgo+ID4gPiA+ID4+Pj4KPiA+ID4gPiA+Pj4+IFNpZ25lZC1vZmYtYnk6IEV1Z2VuaW8gUMOpcmV6
IDxlcGVyZXptYUByZWRoYXQuY29tPgo+ID4gPiA+ID4+Pj4gLS0tCj4gPiA+ID4gPj4+PiB2Mzog
YWRkIG1pcmdhdGlvbiBibG9ja2VyIHByb3Blcmx5IHNvIHZob3N0X2RldiBjYW4gaGFuZGxlIGl0
Lgo+ID4gPiA+ID4+Pj4gLS0tCj4gPiA+ID4gPj4+PiAgICBuZXQvdmhvc3QtdmRwYS5jIHwgMTIg
KysrKysrKystLS0tCj4gPiA+ID4gPj4+PiAgICAxIGZpbGUgY2hhbmdlZCwgOCBpbnNlcnRpb25z
KCspLCA0IGRlbGV0aW9ucygtKQo+ID4gPiA+ID4+Pj4KPiA+ID4gPiA+Pj4+IGRpZmYgLS1naXQg
YS9uZXQvdmhvc3QtdmRwYS5jIGIvbmV0L3Zob3N0LXZkcGEuYwo+ID4gPiA+ID4+Pj4gaW5kZXgg
NGY5ODNkZjAwMC4uMDk0ZGMxYzJkMCAxMDA2NDQKPiA+ID4gPiA+Pj4+IC0tLSBhL25ldC92aG9z
dC12ZHBhLmMKPiA+ID4gPiA+Pj4+ICsrKyBiL25ldC92aG9zdC12ZHBhLmMKPiA+ID4gPiA+Pj4+
IEBAIC03OTUsNyArNzk1LDggQEAgc3RhdGljIE5ldENsaWVudFN0YXRlICpuZXRfdmhvc3RfdmRw
YV9pbml0KE5ldENsaWVudFN0YXRlICpwZWVyLAo+ID4gPiA+ID4+Pj4gICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgaW50IG52cXMsCj4gPiA+ID4gPj4+PiAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICBib29sIGlzX2RhdGFwYXRoLAo+ID4g
PiA+ID4+Pj4gICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgYm9vbCBz
dnEsCj4gPiA+ID4gPj4+PiAtICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
c3RydWN0IHZob3N0X3ZkcGFfaW92YV9yYW5nZSBpb3ZhX3JhbmdlKQo+ID4gPiA+ID4+Pj4gKyAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgIHN0cnVjdCB2aG9zdF92ZHBhX2lv
dmFfcmFuZ2UgaW92YV9yYW5nZSwKPiA+ID4gPiA+Pj4+ICsgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICB1aW50NjRfdCBmZWF0dXJlcykKPiA+ID4gPiA+Pj4+ICAgIHsKPiA+
ID4gPiA+Pj4+ICAgICAgICBOZXRDbGllbnRTdGF0ZSAqbmMgPSBOVUxMOwo+ID4gPiA+ID4+Pj4g
ICAgICAgIFZob3N0VkRQQVN0YXRlICpzOwo+ID4gPiA+ID4+Pj4gQEAgLTgxOCw3ICs4MTksMTAg
QEAgc3RhdGljIE5ldENsaWVudFN0YXRlICpuZXRfdmhvc3RfdmRwYV9pbml0KE5ldENsaWVudFN0
YXRlICpwZWVyLAo+ID4gPiA+ID4+Pj4gICAgICAgIHMtPnZob3N0X3ZkcGEuc2hhZG93X3Zxc19l
bmFibGVkID0gc3ZxOwo+ID4gPiA+ID4+Pj4gICAgICAgIHMtPnZob3N0X3ZkcGEuaW92YV9yYW5n
ZSA9IGlvdmFfcmFuZ2U7Cj4gPiA+ID4gPj4+PiAgICAgICAgcy0+dmhvc3RfdmRwYS5zaGFkb3df
ZGF0YSA9IHN2cTsKPiA+ID4gPiA+Pj4+IC0gICAgaWYgKCFpc19kYXRhcGF0aCkgewo+ID4gPiA+
ID4+Pj4gKyAgICBpZiAocXVldWVfcGFpcl9pbmRleCA9PSAwKSB7Cj4gPiA+ID4gPj4+PiArICAg
ICAgICB2aG9zdF92ZHBhX25ldF92YWxpZF9zdnFfZmVhdHVyZXMoZmVhdHVyZXMsCj4gPiA+ID4g
Pj4+PiArICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgJnMtPnZob3N0
X3ZkcGEubWlncmF0aW9uX2Jsb2NrZXIpOwo+ID4gPiA+ID4+Pgo+ID4gPiA+ID4+PiBTaW5jZSB3
ZSBkbyB2YWxpZGF0aW9uIGF0IGluaXRpYWxpemF0aW9uLCBpcyB0aGlzIG5lY2Vzc2FyeSB0byB2
YWxpZAo+ID4gPiA+ID4+PiBvbmNlIGFnYWluIGluIG90aGVyIHBsYWNlcz8KPiA+ID4gPiA+PiBP
aywgYWZ0ZXIgcmVhZGluZyBwYXRjaCAxMywgSSB0aGluayB0aGUgcXVlc3Rpb24gaXM6Cj4gPiA+
ID4gPj4KPiA+ID4gPiA+PiBUaGUgdmFsaWRhdGlvbiBzZWVtcyB0byBiZSBpbmRlcGVuZGVudCB0
byBuZXQsIGNhbiB3ZSB2YWxpZCBpdCBvbmNlCj4gPiA+ID4gPj4gZHVyaW5nIHZob3N0X3ZkcGFf
aW5pdCgpPwo+ID4gPiA+ID4+Cj4gPiA+ID4gPiB2aG9zdF92ZHBhX25ldF92YWxpZF9zdnFfZmVh
dHVyZXMgYWxzbyBjaGVja3MgZm9yIG5ldCBmZWF0dXJlcy4gSW4KPiA+ID4gPiA+IHBhcnRpY3Vs
YXIsIGFsbCB0aGUgbm9uIHRyYW5zcG9ydCBmZWF0dXJlcyBtdXN0IGJlIGluCj4gPiA+ID4gPiB2
ZHBhX3N2cV9kZXZpY2VfZmVhdHVyZXMuCj4gPiA+ID4gPgo+ID4gPiA+ID4gVGhpcyBpcyBob3cg
d2UgcHJvdGVjdCB0aGF0IHRoZSBkZXZpY2UgLyBndWVzdCB3aWxsIG5ldmVyIG5lZ290aWF0ZQo+
ID4gPiA+ID4gdGhpbmdzIGxpa2UgVkxBTiBmaWx0ZXJpbmcgc3VwcG9ydCwgYXMgU1ZRIHN0aWxs
IGRvZXMgbm90IGtub3cgaG93IHRvCj4gPiA+ID4gPiByZXN0b3JlIGF0IHRoZSBkZXN0aW5hdGlv
bi4KPiA+ID4gPiA+Cj4gPiA+ID4gPiBJbiB0aGUgVkxBTiBmaWx0ZXJpbmcgY2FzZSBDVlEgaXMg
bmVlZGVkIHRvIHJlc3RvcmUgVkxBTiwgc28gaXQgaXMKPiA+ID4gPiA+IGNvdmVyZWQgYnkgcGF0
Y2ggMTEvMTUuIEJ1dCBvdGhlciBmdXR1cmUgZmVhdHVyZXMgbWF5IG5lZWQgc3VwcG9ydCBmb3IK
PiA+ID4gPiA+IHJlc3RvcmluZyBpdCBpbiB0aGUgZGVzdGluYXRpb24uCj4gPiA+ID4KPiA+ID4g
Pgo+ID4gPiA+IEkgd29uZGVyIGhvdyBoYXJkIHRvIGhhdmUgYSBnZW5lcmFsIHZhbGlkYXRpb24g
Y29kZSBsZXQgbmV0IHNwZWNpZmljCj4gPiA+ID4gY29kZSB0byBhZHZlcnRpc2UgYSBibGFja2xp
c3QgdG8gYXZvaWQgY29kZSBkdXBsaWNhdGlvbi4KPiA+ID4gPgo+ID4gPgo+ID4gPiBBIGJsYWNr
bGlzdCBkb2VzIG5vdCB3b3JrIGhlcmUsIGJlY2F1c2UgSSBkb24ndCBrbm93IGlmIFNWUSBuZWVk
cwo+ID4gPiBjaGFuZ2VzIGZvciBmdXR1cmUgZmVhdHVyZSBiaXRzIHRoYXQgYXJlIHN0aWxsIG5v
dCBpbiAvIHByb3Bvc2VkIHRvCj4gPiA+IHRoZSBzdGFuZGFyZC4KPiA+Cj4gPiBDb3VsZCB5b3Ug
Z2l2ZSBtZSBhbiBleGFtcGxlIGZvciB0aGlzPwo+ID4KPgo+IE1heWJlIEknbSBub3QgdW5kZXJz
dGFuZGluZyB5b3VyIGJsYWNrbGlzdCBwcm9wb3NhbC4gSSdtIGdvaW5nIHRvCj4gZXhwbGFpbiBt
eSB0aG91Z2h0cyBvbiBpdCB3aXRoIGEgZmV3IGV4YW1wbGVzLgo+Cj4gU1ZRIHdhcyBtZXJnZWQg
aW4gcWVtdSBiZWZvcmUgVklSVElPX0ZfUklOR19SRVNFVCwgYW5kIHRoZXJlIGFyZSBzb21lCj4g
cHJvcG9zYWxzIGxpa2UgVklSVElPX05FVF9GX05PVEZfQ09BTCBvciBWSVJUSU9fRl9QQVJUSUFM
X09SREVSIGluIHRoZQo+IHZpcnRpby1jb21tZW50IGxpc3QuCj4KPiBJZiB3ZSBoYWQgZ29uZSB3
aXRoIHRoZSBibGFja2xpc3QgYXBwcm9hY2ggYmFjayB0aGVuLCB0aGUgYmxhY2tsaXN0Cj4gd291
bGQgY29udGFpbiBhbGwgdGhlIGZlYXR1cmVzIG9mIFZpcnRpbyBzdGFuZGFyZCBidXQgdGhlIG9u
ZSB3ZSBkbwo+IHN1cHBvcnQgaW4gU1ZRLCBpc24ndCBpdD8gVGhlbiwgVklSVElPX0ZfUklOR19S
RVNFVCB3b3VsZCBnZXQgbWVyZ2VkLAo+IGFuZCBTVlEgd291bGQgY2xhaW0gaXQgc3VwcG9ydHMg
aXQsIGJ1dCBpdCBpcyBub3QgdHJ1ZS4KClRvIHNvbHZlIHRoaXMsIHRoZSBnZW5lcmFsIFNWUSBj
b2RlIGNhbiBoYXZlIGEgd2hpdGVsaXN0IGZvciB0cmFuc3BvcnQgZmVhdHVyZXM/Cgo+Cj4gVGhl
IHNhbWUgY2FuIGhhcHBlbiB3aXRoIHRoZSBvdGhlciB0d28gZmVhdHVyZXMuCj4gVklSVElPX05F
VF9GX05PVEZfQ09BTCB3aWxsIGJlIHJlcXVpcmVkIHRvIG1pZ3JhdGUgY29hbGVzY2VuY2UKPiBw
YXJhbWV0ZXJzLCBidXQgaXQgaXMgbm90IHN1cHBvcnRlZCBmb3IgdGhlIG1vbWVudC4gX0ZfUEFS
VElBTF9PUkRFUgo+IHdpbGwgYWxzbyByZXF1aXJlIGNoYW5nZXMgdG8gaHcvdmlydGlvL3Zob3N0
LXNoYWRvdy12aXJ0cXVldWUuYyBjb2RlLAo+IHNpbmNlIFNWUSBpdCdzIHRoZSAiZHJpdmVyIiBp
biBjaGFyZ2Ugb2YgdGhlIFNWUSB2cmluZy4KPgo+IE1vc3Qgb2YgdGhlIGNoYW5nZXMgd2lsbCBv
bmx5IHJlcXVpcmUgc21hbGwgY2hhbmdlcyB0byBzdXBwb3J0IHNlbmRpbmcKPiB0aGUgQ1ZRIG1l
c3NhZ2UgaW4gdGhlIGRlc3RpbmF0aW9uIGFuZCB0byB0cmFjayB0aGUgc3RhdGUgY2hhbmdlCj4g
cGFyc2luZyBDVlEsIG9yIG5vIGNoYW5nZXMgYXQgYWxsIChsaWtlIGZvciBzdXBwb3J0aW5nCj4g
VklSVElPX05FVF9GX1NQRUVEX0RVUExFWCkuIEJ1dCBTVlEgY2Fubm90IGNsYWltIGl0IHN1cHBv
cnRzIGl0Cj4gYW55d2F5Lgo+Cj4gVGhlIG9ubHkgYWx0ZXJuYXRpdmUgSSBjYW4gdGhpbmsgb2Yg
aXMgdG8gYWN0dWFsbHkgYmxvY2sgbmV3IHByb3Bvc2Fscwo+IChsaWtlIHBhc3QgVklSVElPX0Zf
UklOR19SRVNFVCkgdW50aWwgdGhleSBlaXRoZXIgZG8gdGhlIGNoYW5nZXMgb24KPiBTVlEgdG9v
IG9yIGFkZCBhIGJsYWNrbGlzdCBpdGVtLiBJIHRoaW5rIGl0IGlzIHRvbyBpbnRydXNpdmUuCj4g
RXNwZWNpYWxseSBvbiB0aGlzIHN0YWdlIG9mIFNWUSB3aGVyZSBub3QgZXZlbiBhbGwgUUVNVSBm
ZWF0dXJlcyBhcmUKPiBzdXBwb3J0ZWQuIE1heWJlIHdlIGNhbiByZWV2YWx1YXRlIGl0IGluIFEz
IG9yIFE0IGZvciBleGFtcGxlPwoKWWVzLCB0aGUgY2hhbmdlIGlzIG5vdCBhIG11c3QganVzdCB3
YW50IHRvIHNlZSBpZiB3ZSBjYW4gc2ltcGx5IGRvIGFueXRoaW5nLgoKPgo+Cj4gPiA+Cj4gPiA+
IFJlZ2FyZGluZyB0aGUgY29kZSBkdXBsaWNhdGlvbiwgZG8geW91IG1lYW4gdG8gdmFsaWRhdGUg
dHJhbnNwb3J0Cj4gPiA+IGZlYXR1cmVzIGFuZCBuZXQgc3BlY2lmaWMgZmVhdHVyZXMgaW4gb25l
IHNob3QsIGluc3RlYWQgb2YgaGF2aW5nIGEKPiA+ID4gZGVkaWNhdGVkIGZ1bmN0aW9uIGZvciBT
VlEgdHJhbnNwb3J0Pwo+ID4KPiA+IE5vcGUuCj4gPgo+Cj4gUGxlYXNlIGV4cGFuZCwgbWF5YmUg
SSBjYW4gZG8gc29tZXRoaW5nIHRvIHNvbHZlIGl0IDopLgoKU3VyZSwgSSBqdXN0IHdhbnQgdG8g
bWFrZSBzdXJlIHdlIGFyZSB0YWxraW5nIGFib3V0IHRoZSBzYW1lIHRoaW5nCmJlZm9yZSBJIGNh
biBleHBhbmQgOikKClRoYW5rcwoKPgo+IFRoYW5rcyEKPgoKX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX18KVmlydHVhbGl6YXRpb24gbWFpbGluZyBsaXN0ClZp
cnR1YWxpemF0aW9uQGxpc3RzLmxpbnV4LWZvdW5kYXRpb24ub3JnCmh0dHBzOi8vbGlzdHMubGlu
dXhmb3VuZGF0aW9uLm9yZy9tYWlsbWFuL2xpc3RpbmZvL3ZpcnR1YWxpemF0aW9u
