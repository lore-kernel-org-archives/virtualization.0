Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1A0DAC77B73
	for <virtualization@archiver.kernel.org>; Sun, 23 Apr 2023 05:28:26 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp2.osuosl.org (Postfix) with ESMTP id 90DB140179;
	Sun, 23 Apr 2023 05:28:26 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org 90DB140179
Authentication-Results: smtp2.osuosl.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=AG/Act3V
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
	by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id MJnaDPkQQ05L; Sun, 23 Apr 2023 05:28:25 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp2.osuosl.org (Postfix) with ESMTPS id CAE1E40018;
	Sun, 23 Apr 2023 05:28:24 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org CAE1E40018
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id ABDC1C0036;
	Sun, 23 Apr 2023 05:28:24 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by lists.linuxfoundation.org (Postfix) with ESMTP id C89E5C002A
 for <virtualization@lists.linux-foundation.org>;
 Sun, 23 Apr 2023 05:28:23 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id 9D5166066D
 for <virtualization@lists.linux-foundation.org>;
 Sun, 23 Apr 2023 05:28:23 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 9D5166066D
Authentication-Results: smtp3.osuosl.org;
 dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com
 header.a=rsa-sha256 header.s=mimecast20190719 header.b=AG/Act3V
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id vF9Xa9mt9E98
 for <virtualization@lists.linux-foundation.org>;
 Sun, 23 Apr 2023 05:28:22 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 2D57D60648
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.129.124])
 by smtp3.osuosl.org (Postfix) with ESMTPS id 2D57D60648
 for <virtualization@lists.linux-foundation.org>;
 Sun, 23 Apr 2023 05:28:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1682227700;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=g4+/LxDmpBQ0pUK+KoI7uHx6YYMFfdNIsiVOFUa1ydk=;
 b=AG/Act3VX4b/8qTFXfbAia+xXXF3Jo6dOKcd2p8cJgYw2ycwa1cmtVlfzb5gme0wQqlJoZ
 AT/he0i6YKizJIjvH2k+hUuU++EhmAHbqC/BhT6xxr+ZtTjxOqTk0HxpWAlOq1TMev5Sh3
 fp+CQ+3oR4U+ciAgn9mQ+Tlv8845rL4=
Received: from mail-oi1-f197.google.com (mail-oi1-f197.google.com
 [209.85.167.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-21-0Tu_F-MfPqm2OSRqpLHWQg-1; Sun, 23 Apr 2023 01:28:19 -0400
X-MC-Unique: 0Tu_F-MfPqm2OSRqpLHWQg-1
Received: by mail-oi1-f197.google.com with SMTP id
 5614622812f47-38e28907a40so2417921b6e.2
 for <virtualization@lists.linux-foundation.org>;
 Sat, 22 Apr 2023 22:28:19 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1682227698; x=1684819698;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=g4+/LxDmpBQ0pUK+KoI7uHx6YYMFfdNIsiVOFUa1ydk=;
 b=KYD0JAcOn/h0wjxt+EaOhX8zPXOIS1cE26Ez2axIrZl0G7pbXF2vz5nblC1v+MIwBa
 q88L+NyT5ljaymXRcif4f7rrO0vsx01EWCA516ld555/oqWHVG+mBLPgbKmLSTfTDdru
 ttQj5eF+Q7LrSbO7ddmwkDiTqWtSBcw3HOUmCiOT5oCfIyqmUa37tfRsy/VHgaWdyahT
 zwj4t58v+jaaJfZBM+Rjyp3+u63J/ylxwJN7bNiDMt3MwpKOEfY9LpWYiy/W2S5FdlHJ
 sa8n9FZqidyhS5KyTv1NzcSQpBsnVT9+UC5f8bxXjOr3QpttXhp0FZbJ0UMUU6qF223k
 10mw==
X-Gm-Message-State: AAQBX9ezOXnv6XAPc1QOS4RQwL9OoQXHRvlc6s8eQZzKaGpAv7/15TH/
 HjwAj7bxFvkskltwJStoOiqkKLRJ+Nx9kwPqmGydE5ziP9/h75XWVM2KjkqHub/kAXqaBd+ynHT
 YBza4e2ylNyio3wiqcYDuAzEKDWOv+xSll9JmC9ppqh0lGXQMoVTe4CQOBw==
X-Received: by 2002:a05:6808:151:b0:38e:46ed:7738 with SMTP id
 h17-20020a056808015100b0038e46ed7738mr5386374oie.0.1682227698617; 
 Sat, 22 Apr 2023 22:28:18 -0700 (PDT)
X-Google-Smtp-Source: AKy350aPhNVA73PjfigKtvHV5ftX0Ze6uWwJu4CU2+VZckf4SiE7FpHbuum5CFDMlxXxdB+424F0ae0G3Ble9WPwOOk=
X-Received: by 2002:a05:6808:151:b0:38e:46ed:7738 with SMTP id
 h17-20020a056808015100b0038e46ed7738mr5386363oie.0.1682227698356; Sat, 22 Apr
 2023 22:28:18 -0700 (PDT)
MIME-Version: 1.0
References: <20230418065327.72281-1-xuanzhuo@linux.alibaba.com>
 <20230418065327.72281-6-xuanzhuo@linux.alibaba.com>
 <20230421025931-mutt-send-email-mst@kernel.org>
 <1682061840.4864874-1-xuanzhuo@linux.alibaba.com>
 <20230421075119-mutt-send-email-mst@kernel.org>
 <1682215068.3012342-2-xuanzhuo@linux.alibaba.com>
In-Reply-To: <1682215068.3012342-2-xuanzhuo@linux.alibaba.com>
From: Jason Wang <jasowang@redhat.com>
Date: Sun, 23 Apr 2023 13:28:07 +0800
Message-ID: <CACGkMEs866j3pwWp6S-tJrMa0b0z5r7TmDO6iRKYO_n1FXTXGg@mail.gmail.com>
Subject: Re: [PATCH net-next v2 05/14] virtio_net: introduce xdp res enums
To: Xuan Zhuo <xuanzhuo@linux.alibaba.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Cc: Jesper Dangaard Brouer <hawk@kernel.org>,
 Daniel Borkmann <daniel@iogearbox.net>, "Michael S. Tsirkin" <mst@redhat.com>,
 netdev@vger.kernel.org, John Fastabend <john.fastabend@gmail.com>,
 Alexei Starovoitov <ast@kernel.org>, virtualization@lists.linux-foundation.org,
 Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>,
 bpf@vger.kernel.org, Paolo Abeni <pabeni@redhat.com>,
 "David S. Miller" <davem@davemloft.net>
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

T24gU3VuLCBBcHIgMjMsIDIwMjMgYXQgMTA6MDXigK9BTSBYdWFuIFpodW8gPHh1YW56aHVvQGxp
bnV4LmFsaWJhYmEuY29tPiB3cm90ZToKPgo+IE9uIEZyaSwgMjEgQXByIDIwMjMgMDc6NTQ6MTEg
LTA0MDAsICJNaWNoYWVsIFMuIFRzaXJraW4iIDxtc3RAcmVkaGF0LmNvbT4gd3JvdGU6Cj4gPiBP
biBGcmksIEFwciAyMSwgMjAyMyBhdCAwMzoyNDowMFBNICswODAwLCBYdWFuIFpodW8gd3JvdGU6
Cj4gPiA+IE9uIEZyaSwgMjEgQXByIDIwMjMgMDM6MDA6MTUgLTA0MDAsICJNaWNoYWVsIFMuIFRz
aXJraW4iIDxtc3RAcmVkaGF0LmNvbT4gd3JvdGU6Cj4gPiA+ID4gT24gVHVlLCBBcHIgMTgsIDIw
MjMgYXQgMDI6NTM6MThQTSArMDgwMCwgWHVhbiBaaHVvIHdyb3RlOgo+ID4gPiA+ID4gdmlydG5l
dF94ZHBfaGFuZGxlcigpIGlzIHRvIHByb2Nlc3MgYWxsIHRoZSBsb2dpYyByZWxhdGVkIHRvIFhE
UC4gVGhlCj4gPiA+ID4gPiBjYWxsZXIgb25seSBuZWVkcyB0byBjYXJlIGFib3V0IGhvdyB0byBk
ZWFsIHdpdGggdGhlIGJ1Zi4gU28gdGhpcyBjb21taXQKPiA+ID4gPiA+IGludHJvZHVjZXMgbmV3
IGVudW1zOgo+ID4gPiA+ID4KPiA+ID4gPiA+IDEuIFZJUlRORVRfWERQX1JFU19QQVNTOiBtYWtl
IHNrYiBieSB0aGUgYnVmCj4gPiA+ID4gPiAyLiBWSVJUTkVUX1hEUF9SRVNfRFJPUDogeGRwIHJl
dHVybiBkcm9wIGFjdGlvbiBvciBzb21lIGVycm9yLCBjYWxsZXIKPiA+ID4gPiA+ICAgIHNob3Vs
ZCByZWxlYXNlIHRoZSBidWYKPiA+ID4gPiA+IDMuIFZJUlRORVRfWERQX1JFU19DT05TVU1FRDog
eGRwIGNvbnN1bWVkIHRoZSBidWYsIHRoZSBjYWxsZXIgZG9lc25vdCB0bwo+ID4gPiA+ID4gICAg
ZG8gYW55dGhpbmcKPiA+ID4gPiA+Cj4gPiA+ID4gPiBTaWduZWQtb2ZmLWJ5OiBYdWFuIFpodW8g
PHh1YW56aHVvQGxpbnV4LmFsaWJhYmEuY29tPgo+ID4gPiA+Cj4gPiA+ID4KPiA+ID4gPiBJIGFt
IG5vdCBleGNpdGVkIGFib3V0IHVzaW5nIHZpcnRpbyBzcGVjaWZpYyBlbnVtcyB0aGVuIHRyYW5z
bGF0aW5nCj4gPiA+ID4gdG8gc3RhbmRhcmQgb25lcy4KPiA+ID4KPiA+ID4KPiA+ID4gTXkgZmF1
bHQsIG15IGV4cHJlc3Npb24gaXMgbm90IHZlcnkgY29tcGxldGUuCj4gPiA+Cj4gPiA+IFRoaXMg
aXMgbm90IGEgcmVwbGFjZW1lbnQsIGJ1dCBqdXN0IHdhbnQgdG8gc2F5LCB0aGVyZSBhcmUgb25s
eSB0aHJlZSBjYXNlcyBvZgo+ID4gPiB2aXJ0bmV0X3hkcF9oYW5kbGVyLiBDYWxsZXIgb25seSBu
ZWVkcyB0byBoYW5kbGUgdGhpcyB0aHJlZSBjYXNlcy4gSW5zdGVhZAo+ID4gPiBvZiBwYXlpbmcg
YXR0ZW50aW9uIHRvIHRoZSBkZXRhaWxlZCByZXR1cm4gcmVzdWx0cyBvZiBYRFAuCj4gPiA+Cj4g
PiA+IEluIGFkZGl0aW9uLCB2aXJ0bmV0X3hkcF9oYW5kbGVyIHJldHVybnMgWERQX1RYLCBidXQg
aW4gZmFjdCwgdGhlIHdvcmsgb2YgWERQX1RYCj4gPiA+IGlzIGFscmVhZHkgZG9uZSBpbiBWaXJ0
bmV0X3hkcF9oYW5kbGVyLiBDYWxsZXIgZG9lcyBub3QgbmVlZCB0byBkbyBhbnl0aGluZyBmb3IK
PiA+ID4gWERQX1RYLCBnaXZpbmcgcGVvcGxlIGEgZmVlbGluZywgWERQX1RYIGRvZXMgbm90IG5l
ZWQgdG8gYmUgcHJvY2Vzc2VkLiBJIHRoaW5rCj4gPiA+IGl0IGlzIG5vdCBnb29kLgo+ID4gPgo+
ID4gPiBUaGFua3MuCj4gPgo+ID4gSSBkb24ndCByZWFsbHkgZ2V0IGl0LCBzb3JyeS4gSWYgaXQn
cyBwb3NzaWJsZSB0byBzdGljayB0bwo+ID4gWERQIHJldHVybiBjb2RlcywgdGhhdCBpcyBwcmVm
ZXJhYmxlLgo+Cj4gQWx0aG91Z2gsIEkgc3RpbGwgdGhpbmsgdGhhdCBpdCB3b3VsZCBiZSBiZXR0
ZXIgdG8gdXNlIFZJUlRORVRfWERQX1JFU18qLCBhbmQKPiBvdGhlciBkcml2ZXJzIGRpZCB0aGUg
c2FtZSB0aGluZy4gSWYgeW91IHN0aWxsIGluc2lzdCwgSSBjYW4gcmVtb3ZlIHRoaXMgY29tbWl0
Lgo+CgpJIHNlY29uZCBmb3Igc3RpY2tpbmcgdG8gWERQIHJldHVybiBjb2Rlcy4KCihTaW5jZSBJ
IGRpZG4ndCByZWFsbHkgZ2V0IHdoYXQncyB3cm9uZyB3aXRoIHRoYXQpLgoKVGhhbmtzCgo+IElu
IGFkZGl0aW9uLCBJIHRoaW5rIHNxdWFzaGluZyB0aGlzIHBhdGNoIHRvIHRoZSBwcmV2aW91cyBw
YXRjaCBtYXkgYmUgbW9yZQo+IHN1aXRhYmxlLiBKdXN0IGxpa2UgSSBkb25lIGluIGxhc3QgcGF0
Y2hzZXQuIEBKYXNvbgo+Cj4gQmVjYXVzZSB3aGF0IEkgd2FudCB0byBleHByZXNzIGlzIHRoYXQg
dmlydG5ldF94ZHBfaGFuZGxlcigpIGhhcyBvbmx5IHRocmVlCj4ga2luZHMgb2YgcmV0dXJucywg
Y2FsbGVyIGRvZXMgbm90IG5lZWQgdG8gcGF5IGF0dGVudGlvbiB0byB0aGUgZGV0YWlscyBvZiBY
RFAKPiByZXR1cm5zLgo+Cj4gVGhhbmtzLgo+Cj4KPiA+Cj4gPiA+Cj4gPiA+Cj4gPiA+ID4KPiA+
ID4gPiA+IC0tLQo+ID4gPiA+ID4gIGRyaXZlcnMvbmV0L3ZpcnRpb19uZXQuYyB8IDQyICsrKysr
KysrKysrKysrKysrKysrKysrKysrLS0tLS0tLS0tLS0tLS0KPiA+ID4gPiA+ICAxIGZpbGUgY2hh
bmdlZCwgMjcgaW5zZXJ0aW9ucygrKSwgMTUgZGVsZXRpb25zKC0pCj4gPiA+ID4gPgo+ID4gPiA+
ID4gZGlmZiAtLWdpdCBhL2RyaXZlcnMvbmV0L3ZpcnRpb19uZXQuYyBiL2RyaXZlcnMvbmV0L3Zp
cnRpb19uZXQuYwo+ID4gPiA+ID4gaW5kZXggMGZhNjRjMzE0ZWE3Li40ZGZkYzIxMWQzNTUgMTAw
NjQ0Cj4gPiA+ID4gPiAtLS0gYS9kcml2ZXJzL25ldC92aXJ0aW9fbmV0LmMKPiA+ID4gPiA+ICsr
KyBiL2RyaXZlcnMvbmV0L3ZpcnRpb19uZXQuYwo+ID4gPiA+ID4gQEAgLTMwMSw2ICszMDEsMTUg
QEAgc3RydWN0IHBhZGRlZF92bmV0X2hkciB7Cj4gPiA+ID4gPiAgICAgICAgIGNoYXIgcGFkZGlu
Z1sxMl07Cj4gPiA+ID4gPiAgfTsKPiA+ID4gPiA+Cj4gPiA+ID4gPiArZW51bSB7Cj4gPiA+ID4g
PiArICAgICAgIC8qIHhkcCBwYXNzICovCj4gPiA+ID4gPiArICAgICAgIFZJUlRORVRfWERQX1JF
U19QQVNTLAo+ID4gPiA+ID4gKyAgICAgICAvKiBkcm9wIHBhY2tldC4gdGhlIGNhbGxlciBuZWVk
cyB0byByZWxlYXNlIHRoZSBwYWdlLiAqLwo+ID4gPiA+ID4gKyAgICAgICBWSVJUTkVUX1hEUF9S
RVNfRFJPUCwKPiA+ID4gPiA+ICsgICAgICAgLyogcGFja2V0IGlzIGNvbnN1bWVkIGJ5IHhkcC4g
dGhlIGNhbGxlciBuZWVkcyB0byBkbyBub3RoaW5nLiAqLwo+ID4gPiA+ID4gKyAgICAgICBWSVJU
TkVUX1hEUF9SRVNfQ09OU1VNRUQsCj4gPiA+ID4gPiArfTsKPiA+ID4gPiA+ICsKPiA+ID4gPiA+
ICBzdGF0aWMgdm9pZCB2aXJ0bmV0X3JxX2ZyZWVfdW51c2VkX2J1ZihzdHJ1Y3QgdmlydHF1ZXVl
ICp2cSwgdm9pZCAqYnVmKTsKPiA+ID4gPiA+ICBzdGF0aWMgdm9pZCB2aXJ0bmV0X3NxX2ZyZWVf
dW51c2VkX2J1ZihzdHJ1Y3QgdmlydHF1ZXVlICp2cSwgdm9pZCAqYnVmKTsKPiA+ID4gPiA+Cj4g
PiA+ID4gPiBAQCAtODAzLDE0ICs4MTIsMTQgQEAgc3RhdGljIGludCB2aXJ0bmV0X3hkcF9oYW5k
bGVyKHN0cnVjdCBicGZfcHJvZyAqeGRwX3Byb2csIHN0cnVjdCB4ZHBfYnVmZiAqeGRwLAo+ID4g
PiA+ID4KPiA+ID4gPiA+ICAgICAgICAgc3dpdGNoIChhY3QpIHsKPiA+ID4gPiA+ICAgICAgICAg
Y2FzZSBYRFBfUEFTUzoKPiA+ID4gPiA+IC0gICAgICAgICAgICAgICByZXR1cm4gYWN0Owo+ID4g
PiA+ID4gKyAgICAgICAgICAgICAgIHJldHVybiBWSVJUTkVUX1hEUF9SRVNfUEFTUzsKPiA+ID4g
PiA+Cj4gPiA+ID4gPiAgICAgICAgIGNhc2UgWERQX1RYOgo+ID4gPiA+ID4gICAgICAgICAgICAg
ICAgIHN0YXRzLT54ZHBfdHgrKzsKPiA+ID4gPiA+ICAgICAgICAgICAgICAgICB4ZHBmID0geGRw
X2NvbnZlcnRfYnVmZl90b19mcmFtZSh4ZHApOwo+ID4gPiA+ID4gICAgICAgICAgICAgICAgIGlm
ICh1bmxpa2VseSgheGRwZikpIHsKPiA+ID4gPiA+ICAgICAgICAgICAgICAgICAgICAgICAgIG5l
dGRldl9kYmcoZGV2LCAiY29udmVydCBidWZmIHRvIGZyYW1lIGZhaWxlZCBmb3IgeGRwXG4iKTsK
PiA+ID4gPiA+IC0gICAgICAgICAgICAgICAgICAgICAgIHJldHVybiBYRFBfRFJPUDsKPiA+ID4g
PiA+ICsgICAgICAgICAgICAgICAgICAgICAgIHJldHVybiBWSVJUTkVUX1hEUF9SRVNfRFJPUDsK
PiA+ID4gPiA+ICAgICAgICAgICAgICAgICB9Cj4gPiA+ID4gPgo+ID4gPiA+ID4gICAgICAgICAg
ICAgICAgIGVyciA9IHZpcnRuZXRfeGRwX3htaXQoZGV2LCAxLCAmeGRwZiwgMCk7Cj4gPiA+ID4g
PiBAQCAtODE4LDE5ICs4MjcsMjAgQEAgc3RhdGljIGludCB2aXJ0bmV0X3hkcF9oYW5kbGVyKHN0
cnVjdCBicGZfcHJvZyAqeGRwX3Byb2csIHN0cnVjdCB4ZHBfYnVmZiAqeGRwLAo+ID4gPiA+ID4g
ICAgICAgICAgICAgICAgICAgICAgICAgeGRwX3JldHVybl9mcmFtZV9yeF9uYXBpKHhkcGYpOwo+
ID4gPiA+ID4gICAgICAgICAgICAgICAgIH0gZWxzZSBpZiAodW5saWtlbHkoZXJyIDwgMCkpIHsK
PiA+ID4gPiA+ICAgICAgICAgICAgICAgICAgICAgICAgIHRyYWNlX3hkcF9leGNlcHRpb24oZGV2
LCB4ZHBfcHJvZywgYWN0KTsKPiA+ID4gPiA+IC0gICAgICAgICAgICAgICAgICAgICAgIHJldHVy
biBYRFBfRFJPUDsKPiA+ID4gPiA+ICsgICAgICAgICAgICAgICAgICAgICAgIHJldHVybiBWSVJU
TkVUX1hEUF9SRVNfRFJPUDsKPiA+ID4gPiA+ICAgICAgICAgICAgICAgICB9Cj4gPiA+ID4gPiAr
Cj4gPiA+ID4gPiAgICAgICAgICAgICAgICAgKnhkcF94bWl0IHw9IFZJUlRJT19YRFBfVFg7Cj4g
PiA+ID4gPiAtICAgICAgICAgICAgICAgcmV0dXJuIGFjdDsKPiA+ID4gPiA+ICsgICAgICAgICAg
ICAgICByZXR1cm4gVklSVE5FVF9YRFBfUkVTX0NPTlNVTUVEOwo+ID4gPiA+ID4KPiA+ID4gPiA+
ICAgICAgICAgY2FzZSBYRFBfUkVESVJFQ1Q6Cj4gPiA+ID4gPiAgICAgICAgICAgICAgICAgc3Rh
dHMtPnhkcF9yZWRpcmVjdHMrKzsKPiA+ID4gPiA+ICAgICAgICAgICAgICAgICBlcnIgPSB4ZHBf
ZG9fcmVkaXJlY3QoZGV2LCB4ZHAsIHhkcF9wcm9nKTsKPiA+ID4gPiA+ICAgICAgICAgICAgICAg
ICBpZiAoZXJyKQo+ID4gPiA+ID4gLSAgICAgICAgICAgICAgICAgICAgICAgcmV0dXJuIFhEUF9E
Uk9QOwo+ID4gPiA+ID4gKyAgICAgICAgICAgICAgICAgICAgICAgcmV0dXJuIFZJUlRORVRfWERQ
X1JFU19EUk9QOwo+ID4gPiA+ID4KPiA+ID4gPiA+ICAgICAgICAgICAgICAgICAqeGRwX3htaXQg
fD0gVklSVElPX1hEUF9SRURJUjsKPiA+ID4gPiA+IC0gICAgICAgICAgICAgICByZXR1cm4gYWN0
Owo+ID4gPiA+ID4gKyAgICAgICAgICAgICAgIHJldHVybiBWSVJUTkVUX1hEUF9SRVNfQ09OU1VN
RUQ7Cj4gPiA+ID4gPgo+ID4gPiA+ID4gICAgICAgICBkZWZhdWx0Ogo+ID4gPiA+ID4gICAgICAg
ICAgICAgICAgIGJwZl93YXJuX2ludmFsaWRfeGRwX2FjdGlvbihkZXYsIHhkcF9wcm9nLCBhY3Qp
Owo+ID4gPiA+ID4gQEAgLTgzOSw3ICs4NDksNyBAQCBzdGF0aWMgaW50IHZpcnRuZXRfeGRwX2hh
bmRsZXIoc3RydWN0IGJwZl9wcm9nICp4ZHBfcHJvZywgc3RydWN0IHhkcF9idWZmICp4ZHAsCj4g
PiA+ID4gPiAgICAgICAgICAgICAgICAgdHJhY2VfeGRwX2V4Y2VwdGlvbihkZXYsIHhkcF9wcm9n
LCBhY3QpOwo+ID4gPiA+ID4gICAgICAgICAgICAgICAgIGZhbGx0aHJvdWdoOwo+ID4gPiA+ID4g
ICAgICAgICBjYXNlIFhEUF9EUk9QOgo+ID4gPiA+ID4gLSAgICAgICAgICAgICAgIHJldHVybiBY
RFBfRFJPUDsKPiA+ID4gPiA+ICsgICAgICAgICAgICAgICByZXR1cm4gVklSVE5FVF9YRFBfUkVT
X0RST1A7Cj4gPiA+ID4gPiAgICAgICAgIH0KPiA+ID4gPiA+ICB9Cj4gPiA+ID4gPgo+ID4gPiA+
ID4gQEAgLTk4NywxNyArOTk3LDE4IEBAIHN0YXRpYyBzdHJ1Y3Qgc2tfYnVmZiAqcmVjZWl2ZV9z
bWFsbChzdHJ1Y3QgbmV0X2RldmljZSAqZGV2LAo+ID4gPiA+ID4gICAgICAgICAgICAgICAgIGFj
dCA9IHZpcnRuZXRfeGRwX2hhbmRsZXIoeGRwX3Byb2csICZ4ZHAsIGRldiwgeGRwX3htaXQsIHN0
YXRzKTsKPiA+ID4gPiA+Cj4gPiA+ID4gPiAgICAgICAgICAgICAgICAgc3dpdGNoIChhY3QpIHsK
PiA+ID4gPiA+IC0gICAgICAgICAgICAgICBjYXNlIFhEUF9QQVNTOgo+ID4gPiA+ID4gKyAgICAg
ICAgICAgICAgIGNhc2UgVklSVE5FVF9YRFBfUkVTX1BBU1M6Cj4gPiA+ID4gPiAgICAgICAgICAg
ICAgICAgICAgICAgICAvKiBSZWNhbGN1bGF0ZSBsZW5ndGggaW4gY2FzZSBicGYgcHJvZ3JhbSBj
aGFuZ2VkIGl0ICovCj4gPiA+ID4gPiAgICAgICAgICAgICAgICAgICAgICAgICBkZWx0YSA9IG9y
aWdfZGF0YSAtIHhkcC5kYXRhOwo+ID4gPiA+ID4gICAgICAgICAgICAgICAgICAgICAgICAgbGVu
ID0geGRwLmRhdGFfZW5kIC0geGRwLmRhdGE7Cj4gPiA+ID4gPiAgICAgICAgICAgICAgICAgICAg
ICAgICBtZXRhc2l6ZSA9IHhkcC5kYXRhIC0geGRwLmRhdGFfbWV0YTsKPiA+ID4gPiA+ICAgICAg
ICAgICAgICAgICAgICAgICAgIGJyZWFrOwo+ID4gPiA+ID4gLSAgICAgICAgICAgICAgIGNhc2Ug
WERQX1RYOgo+ID4gPiA+ID4gLSAgICAgICAgICAgICAgIGNhc2UgWERQX1JFRElSRUNUOgo+ID4g
PiA+ID4gKwo+ID4gPiA+ID4gKyAgICAgICAgICAgICAgIGNhc2UgVklSVE5FVF9YRFBfUkVTX0NP
TlNVTUVEOgo+ID4gPiA+ID4gICAgICAgICAgICAgICAgICAgICAgICAgcmN1X3JlYWRfdW5sb2Nr
KCk7Cj4gPiA+ID4gPiAgICAgICAgICAgICAgICAgICAgICAgICBnb3RvIHhkcF94bWl0Owo+ID4g
PiA+ID4gLSAgICAgICAgICAgICAgIGRlZmF1bHQ6Cj4gPiA+ID4gPiArCj4gPiA+ID4gPiArICAg
ICAgICAgICAgICAgY2FzZSBWSVJUTkVUX1hEUF9SRVNfRFJPUDoKPiA+ID4gPiA+ICAgICAgICAg
ICAgICAgICAgICAgICAgIGdvdG8gZXJyX3hkcDsKPiA+ID4gPiA+ICAgICAgICAgICAgICAgICB9
Cj4gPiA+ID4gPiAgICAgICAgIH0KPiA+ID4gPiA+IEBAIC0xMzI0LDE4ICsxMzM1LDE5IEBAIHN0
YXRpYyBzdHJ1Y3Qgc2tfYnVmZiAqcmVjZWl2ZV9tZXJnZWFibGUoc3RydWN0IG5ldF9kZXZpY2Ug
KmRldiwKPiA+ID4gPiA+ICAgICAgICAgICAgICAgICBhY3QgPSB2aXJ0bmV0X3hkcF9oYW5kbGVy
KHhkcF9wcm9nLCAmeGRwLCBkZXYsIHhkcF94bWl0LCBzdGF0cyk7Cj4gPiA+ID4gPgo+ID4gPiA+
ID4gICAgICAgICAgICAgICAgIHN3aXRjaCAoYWN0KSB7Cj4gPiA+ID4gPiAtICAgICAgICAgICAg
ICAgY2FzZSBYRFBfUEFTUzoKPiA+ID4gPiA+ICsgICAgICAgICAgICAgICBjYXNlIFZJUlRORVRf
WERQX1JFU19QQVNTOgo+ID4gPiA+ID4gICAgICAgICAgICAgICAgICAgICAgICAgaGVhZF9za2Ig
PSBidWlsZF9za2JfZnJvbV94ZHBfYnVmZihkZXYsIHZpLCAmeGRwLCB4ZHBfZnJhZ3NfdHJ1ZXN6
KTsKPiA+ID4gPiA+ICAgICAgICAgICAgICAgICAgICAgICAgIGlmICh1bmxpa2VseSghaGVhZF9z
a2IpKQo+ID4gPiA+ID4gICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICBnb3RvIGVycl94
ZHBfZnJhZ3M7Cj4gPiA+ID4gPgo+ID4gPiA+ID4gICAgICAgICAgICAgICAgICAgICAgICAgcmN1
X3JlYWRfdW5sb2NrKCk7Cj4gPiA+ID4gPiAgICAgICAgICAgICAgICAgICAgICAgICByZXR1cm4g
aGVhZF9za2I7Cj4gPiA+ID4gPiAtICAgICAgICAgICAgICAgY2FzZSBYRFBfVFg6Cj4gPiA+ID4g
PiAtICAgICAgICAgICAgICAgY2FzZSBYRFBfUkVESVJFQ1Q6Cj4gPiA+ID4gPiArCj4gPiA+ID4g
PiArICAgICAgICAgICAgICAgY2FzZSBWSVJUTkVUX1hEUF9SRVNfQ09OU1VNRUQ6Cj4gPiA+ID4g
PiAgICAgICAgICAgICAgICAgICAgICAgICByY3VfcmVhZF91bmxvY2soKTsKPiA+ID4gPiA+ICAg
ICAgICAgICAgICAgICAgICAgICAgIGdvdG8geGRwX3htaXQ7Cj4gPiA+ID4gPiAtICAgICAgICAg
ICAgICAgZGVmYXVsdDoKPiA+ID4gPiA+ICsKPiA+ID4gPiA+ICsgICAgICAgICAgICAgICBjYXNl
IFZJUlRORVRfWERQX1JFU19EUk9QOgo+ID4gPiA+ID4gICAgICAgICAgICAgICAgICAgICAgICAg
YnJlYWs7Cj4gPiA+ID4gPiAgICAgICAgICAgICAgICAgfQo+ID4gPiA+ID4gIGVycl94ZHBfZnJh
Z3M6Cj4gPiA+ID4gPiAtLQo+ID4gPiA+ID4gMi4zMi4wLjMuZzAxMTk1Y2Y5Zgo+ID4gPiA+Cj4g
Pgo+CgpfX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fXwpWaXJ0
dWFsaXphdGlvbiBtYWlsaW5nIGxpc3QKVmlydHVhbGl6YXRpb25AbGlzdHMubGludXgtZm91bmRh
dGlvbi5vcmcKaHR0cHM6Ly9saXN0cy5saW51eGZvdW5kYXRpb24ub3JnL21haWxtYW4vbGlzdGlu
Zm8vdmlydHVhbGl6YXRpb24=
