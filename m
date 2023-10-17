Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 012FFCDB474
	for <virtualization@archiver.kernel.org>; Tue, 17 Oct 2023 05:28:08 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 55AF581FBA;
	Tue, 17 Oct 2023 05:28:08 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 55AF581FBA
Authentication-Results: smtp1.osuosl.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=SK60ydOw
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
	by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id jpBUwvAt3v8B; Tue, 17 Oct 2023 05:28:07 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp1.osuosl.org (Postfix) with ESMTPS id 845CD81FAB;
	Tue, 17 Oct 2023 05:28:06 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 845CD81FAB
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 6343EC0072;
	Tue, 17 Oct 2023 05:28:06 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [IPv6:2605:bc80:3010::136])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 5ADB5C0032
 for <virtualization@lists.linux-foundation.org>;
 Tue, 17 Oct 2023 05:28:04 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id 2DA6860838
 for <virtualization@lists.linux-foundation.org>;
 Tue, 17 Oct 2023 05:28:04 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 2DA6860838
Authentication-Results: smtp3.osuosl.org;
 dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com
 header.a=rsa-sha256 header.s=mimecast20190719 header.b=SK60ydOw
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id KSUBd9k4j6Wu
 for <virtualization@lists.linux-foundation.org>;
 Tue, 17 Oct 2023 05:28:03 +0000 (UTC)
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.129.124])
 by smtp3.osuosl.org (Postfix) with ESMTPS id EAFCE60810
 for <virtualization@lists.linux-foundation.org>;
 Tue, 17 Oct 2023 05:28:02 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org EAFCE60810
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1697520481;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=hB1Ys3pyVtLC66WyqHQkYZDV0fWNI3xEcGaEBbTojWA=;
 b=SK60ydOw4PBP3YXHapeOXFeFBcv5icG4COwZ82vdpLWyqtFHGMFppmIejQ/SGybxzMiVYo
 nitkA8TdIgzyQldK5Vr5/q/0h93uPuMppXHxEbx4dwnr6bCbboVT0ioAVi9bN6n9qoVUfc
 6rJPJDGEU5Cgka97KlZoyisYWqnEIVA=
Received: from mail-lf1-f70.google.com (mail-lf1-f70.google.com
 [209.85.167.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-537-OW3KLF6WM-CK05gPZGdthQ-1; Tue, 17 Oct 2023 01:28:00 -0400
X-MC-Unique: OW3KLF6WM-CK05gPZGdthQ-1
Received: by mail-lf1-f70.google.com with SMTP id
 2adb3069b0e04-5043353efbdso4895338e87.0
 for <virtualization@lists.linux-foundation.org>;
 Mon, 16 Oct 2023 22:28:00 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1697520479; x=1698125279;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=hB1Ys3pyVtLC66WyqHQkYZDV0fWNI3xEcGaEBbTojWA=;
 b=BVoK0BgjZTIMuO17np5vIoGVqOOqqfNK1PZX+6QCRDtHmvpvexUIgkIOmMMI8RNE6k
 r+kuLQqrRavFO4SFp8l3kCPAfX1BIbjKy000bcfbwRo4v5x52F46/DgPpra0kf/AtLTu
 fDMJ4WAwOcpBYhBuQcyHynBY51tVrs1R0thV4LVF194uqPSJz9CwOKKfVjpx+1Yj9Hj9
 sTKlxluM/WYVgi9EvfTSrLjfO0188/Hof22PchyfwZwf+ApIYIQu/xctCzV1UY3Pv7ny
 kkWnMAbisFYk/cx1A/51QSh4N2uvTuIZ9APfgl/S9yrzzsJGFzNuYLXeEREhpPHKmJ4a
 I52A==
X-Gm-Message-State: AOJu0YylQXv9+kmsokKWg4N62r9wzC1Pnoih9y/Gs9kF0hMZTQjIkd/6
 LOw+FZb2/hfJojZKTYIUpZENH/3OhWLuYFJ1S6bzyq3L+abu1UFXytxMXPwY5shwBFORp8hXuQ7
 /YXfmaFMpIcFxxeLQuaPOhGT2tNHGCBdSuwMLRjOIAAvhaq2hEuoqCpvPkQ==
X-Received: by 2002:a05:6512:3ba9:b0:507:9701:2700 with SMTP id
 g41-20020a0565123ba900b0050797012700mr1114151lfv.20.1697520478986; 
 Mon, 16 Oct 2023 22:27:58 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFvAfxdQ+kiLfQtT6f7u3IqD6TS5IKXJFBeQ799Eef64sPKZxV6ivtMPGYp4y2Xt9AEpnuEQAc3PEglkp45by8=
X-Received: by 2002:a05:6512:3ba9:b0:507:9701:2700 with SMTP id
 g41-20020a0565123ba900b0050797012700mr1114144lfv.20.1697520478648; Mon, 16
 Oct 2023 22:27:58 -0700 (PDT)
MIME-Version: 1.0
References: <20231016120033.26933-1-xuanzhuo@linux.alibaba.com>
 <CACGkMEs4u-4ch2UAK14hNfKeORjqMu4BX7=46OfaXpvxW+VT7w@mail.gmail.com>
 <1697511725.2037013-1-xuanzhuo@linux.alibaba.com>
 <CACGkMEskfXDo+bnx5hbGU3JRwOgBRwOC-bYDdFYSmEO2jjgPnA@mail.gmail.com>
 <1697512950.0813534-1-xuanzhuo@linux.alibaba.com>
 <CACGkMEtppjoX_WAM+vjzkMKaMQQ0iZL=C_xS4RObuoLbm0udUw@mail.gmail.com>
In-Reply-To: <CACGkMEtppjoX_WAM+vjzkMKaMQQ0iZL=C_xS4RObuoLbm0udUw@mail.gmail.com>
From: Jason Wang <jasowang@redhat.com>
Date: Tue, 17 Oct 2023 13:27:47 +0800
Message-ID: <CACGkMEvWAhH3uj2DEo=m7qWg3-pQjE-EtEBvTT8JXzqZ+RYEXQ@mail.gmail.com>
Subject: Re: [PATCH net-next v1 00/19] virtio-net: support AF_XDP zero copy
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

T24gVHVlLCBPY3QgMTcsIDIwMjMgYXQgMTE6MjjigK9BTSBKYXNvbiBXYW5nIDxqYXNvd2FuZ0By
ZWRoYXQuY29tPiB3cm90ZToKPgo+IE9uIFR1ZSwgT2N0IDE3LCAyMDIzIGF0IDExOjI24oCvQU0g
WHVhbiBaaHVvIDx4dWFuemh1b0BsaW51eC5hbGliYWJhLmNvbT4gd3JvdGU6Cj4gPgo+ID4gT24g
VHVlLCAxNyBPY3QgMjAyMyAxMToyMDo0MSArMDgwMCwgSmFzb24gV2FuZyA8amFzb3dhbmdAcmVk
aGF0LmNvbT4gd3JvdGU6Cj4gPiA+IE9uIFR1ZSwgT2N0IDE3LCAyMDIzIGF0IDExOjEx4oCvQU0g
WHVhbiBaaHVvIDx4dWFuemh1b0BsaW51eC5hbGliYWJhLmNvbT4gd3JvdGU6Cj4gPiA+ID4KPiA+
ID4gPiBPbiBUdWUsIDE3IE9jdCAyMDIzIDEwOjUzOjQ0ICswODAwLCBKYXNvbiBXYW5nIDxqYXNv
d2FuZ0ByZWRoYXQuY29tPiB3cm90ZToKPiA+ID4gPiA+IE9uIE1vbiwgT2N0IDE2LCAyMDIzIGF0
IDg6MDDigK9QTSBYdWFuIFpodW8gPHh1YW56aHVvQGxpbnV4LmFsaWJhYmEuY29tPiB3cm90ZToK
PiA+ID4gPiA+ID4KPiA+ID4gPiA+ID4gIyMgQUZfWERQCj4gPiA+ID4gPiA+Cj4gPiA+ID4gPiA+
IFhEUCBzb2NrZXQoQUZfWERQKSBpcyBhbiBleGNlbGxlbnQgYnlwYXNzIGtlcm5lbCBuZXR3b3Jr
IGZyYW1ld29yay4gVGhlIHplcm8KPiA+ID4gPiA+ID4gY29weSBmZWF0dXJlIG9mIHhzayAoWERQ
IHNvY2tldCkgbmVlZHMgdG8gYmUgc3VwcG9ydGVkIGJ5IHRoZSBkcml2ZXIuIFRoZQo+ID4gPiA+
ID4gPiBwZXJmb3JtYW5jZSBvZiB6ZXJvIGNvcHkgaXMgdmVyeSBnb29kLiBtbHg1IGFuZCBpbnRl
bCBpeGdiZSBhbHJlYWR5IHN1cHBvcnQKPiA+ID4gPiA+ID4gdGhpcyBmZWF0dXJlLCBUaGlzIHBh
dGNoIHNldCBhbGxvd3MgdmlydGlvLW5ldCB0byBzdXBwb3J0IHhzaydzIHplcm9jb3B5IHhtaXQK
PiA+ID4gPiA+ID4gZmVhdHVyZS4KPiA+ID4gPiA+ID4KPiA+ID4gPiA+ID4gQXQgcHJlc2VudCwg
d2UgaGF2ZSBjb21wbGV0ZWQgc29tZSBwcmVwYXJhdGlvbjoKPiA+ID4gPiA+ID4KPiA+ID4gPiA+
ID4gMS4gdnEtcmVzZXQgKHZpcnRpbyBzcGVjIGFuZCBrZXJuZWwgY29kZSkKPiA+ID4gPiA+ID4g
Mi4gdmlydGlvLWNvcmUgcHJlbWFwcGVkIGRtYQo+ID4gPiA+ID4gPiAzLiB2aXJ0aW8tbmV0IHhk
cCByZWZhY3Rvcgo+ID4gPiA+ID4gPgo+ID4gPiA+ID4gPiBTbyBpdCBpcyB0aW1lIGZvciBWaXJ0
aW8tTmV0IHRvIGNvbXBsZXRlIHRoZSBzdXBwb3J0IGZvciB0aGUgWERQIFNvY2tldAo+ID4gPiA+
ID4gPiBaZXJvY29weS4KPiA+ID4gPiA+ID4KPiA+ID4gPiA+ID4gVmlydGlvLW5ldCBjYW4gbm90
IGluY3JlYXNlIHRoZSBxdWV1ZSBudW0gYXQgd2lsbCwgc28geHNrIHNoYXJlcyB0aGUgcXVldWUg
d2l0aAo+ID4gPiA+ID4gPiBrZXJuZWwuCj4gPiA+ID4gPiA+Cj4gPiA+ID4gPiA+IE9uIHRoZSBv
dGhlciBoYW5kLCBWaXJ0aW8tTmV0IGRvZXMgbm90IHN1cHBvcnQgZ2VuZXJhdGUgaW50ZXJydXB0
IGZyb20gZHJpdmVyCj4gPiA+ID4gPiA+IG1hbnVhbGx5LCBzbyB3aGVuIHdlIHdha2V1cCB0eCB4
bWl0LCB3ZSB1c2VkIHNvbWUgdGlwcy4gSWYgdGhlIENQVSBydW4gYnkgVFgKPiA+ID4gPiA+ID4g
TkFQSSBsYXN0IHRpbWUgaXMgb3RoZXIgQ1BVcywgdXNlIElQSSB0byB3YWtlIHVwIE5BUEkgb24g
dGhlIHJlbW90ZSBDUFUuIElmIGl0Cj4gPiA+ID4gPiA+IGlzIGFsc28gdGhlIGxvY2FsIENQVSwg
dGhlbiB3ZSB3YWtlIHVwIG5hcGkgZGlyZWN0bHkuCj4gPiA+ID4gPiA+Cj4gPiA+ID4gPiA+IFRo
aXMgcGF0Y2ggc2V0IGluY2x1ZGVzIHNvbWUgcmVmYWN0b3IgdG8gdGhlIHZpcnRpby1uZXQgdG8g
bGV0IHRoYXQgdG8gc3VwcG9ydAo+ID4gPiA+ID4gPiBBRl9YRFAuCj4gPiA+ID4gPiA+Cj4gPiA+
ID4gPiA+ICMjIHBlcmZvcm1hbmNlCj4gPiA+ID4gPiA+Cj4gPiA+ID4gPiA+IEVOVjogUWVtdSB3
aXRoIHZob3N0LXVzZXIocG9sbGluZyBtb2RlKS4KPiA+ID4gPiA+ID4KPiA+ID4gPiA+ID4gU29j
a3BlcmY6IGh0dHBzOi8vZ2l0aHViLmNvbS9NZWxsYW5veC9zb2NrcGVyZgo+ID4gPiA+ID4gPiBJ
IHVzZSB0aGlzIHRvb2wgdG8gc2VuZCB1ZHAgcGFja2V0IGJ5IGtlcm5lbCBzeXNjYWxsLgo+ID4g
PiA+ID4gPgo+ID4gPiA+ID4gPiB4bWl0IGNvbW1hbmQ6IHNvY2twZXJmIHRwIC1pIDEwLjAuMy4x
IC10IDEwMDAKPiA+ID4gPiA+ID4KPiA+ID4gPiA+ID4gSSB3cml0ZSBhIHRvb2wgdGhhdCBzZW5k
cyB1ZHAgcGFja2V0cyBvciByZWN2cyB1ZHAgcGFja2V0cyBieSBBRl9YRFAuCj4gPiA+ID4gPiA+
Cj4gPiA+ID4gPiA+ICAgICAgICAgICAgICAgICAgIHwgR3Vlc3QgQVBQIENQVSB8R3Vlc3QgU29m
dGlycSBDUFUgfCBVRFAgUFBTCj4gPiA+ID4gPiA+IC0tLS0tLS0tLS0tLS0tLS0tLXwtLS0tLS0t
LS0tLS0tLS18LS0tLS0tLS0tLS0tLS0tLS0tfC0tLS0tLS0tLS0tLQo+ID4gPiA+ID4gPiB4bWl0
IGJ5IHN5c2NhbGwgICB8ICAgMTAwJSAgICAgICAgfCAgICAgICAgICAgICAgICAgIHwgICA2NzYs
OTE1Cj4gPiA+ID4gPiA+IHhtaXQgYnkgeHNrICAgICAgIHwgICA1OS4xJSAgICAgICB8ICAgMTAw
JSAgICAgICAgICAgfCA1LDQ0NywxNjgKPiA+ID4gPiA+ID4gcmVjdiBieSBzeXNjYWxsICAgfCAg
IDYwJSAgICAgICAgIHwgICAxMDAlICAgICAgICAgICB8ICAgOTMyLDI4OAo+ID4gPiA+ID4gPiBy
ZWN2IGJ5IHhzayAgICAgICB8ICAgMzUuNyUgICAgICAgfCAgIDEwMCUgICAgICAgICAgIHwgMywz
NDMsMTY4Cj4gPiA+ID4gPgo+ID4gPiA+ID4gQW55IGNoYW5jZSB3ZSBjYW4gZ2V0IGEgdGVzdHBt
ZCByZXN1bHQgKHdoaWNoIEkgZ3Vlc3Mgc2hvdWxkIGJlIGJldHRlcgo+ID4gPiA+ID4gdGhhbiBQ
UFMgYWJvdmUpPwo+ID4gPiA+Cj4gPiA+ID4gRG8geW91IG1lYW4gdGVzdHBtZCArIERQREsgKyBB
Rl9YRFA/Cj4gPiA+Cj4gPiA+IFllcy4KPiA+ID4KPiA+ID4gPgo+ID4gPiA+IFllcy4gVGhpcyBp
cyBwcm9iYWJseSBiZXR0ZXIgYmVjYXVzZSBteSB0b29sIGRvZXMgbW9yZSB3b3JrLiBUaGF0IGlz
IG5vdCBhCj4gPiA+ID4gY29tcGxldGUgdGVzdGluZyB0b29sIHVzZWQgYnkgb3VyIGJ1c2luZXNz
Lgo+ID4gPgo+ID4gPiBQcm9iYWJseSwgYnV0IGl0IHdvdWxkIGJlIGFwcGVhbGluZyBmb3Igb3Ro
ZXJzLiBFc3BlY2lhbGx5IGNvbnNpZGVyaW5nCj4gPiA+IERQREsgc3VwcG9ydHMgQUZfWERQIFBN
RCBub3cuCj4gPgo+ID4gT0suCj4gPgo+ID4gTGV0IG1lIHRyeS4KPiA+Cj4gPiBCdXQgY291bGQg
eW91IHN0YXJ0IHRvIHJldmlldyBmaXJzdGx5Pwo+Cj4gWWVzLCBpdCdzIGluIG15IHRvZG8gbGlz
dC4KClNwZWFraW5nIHRvbyBmYXN0LCBJIHRoaW5rIGlmIGl0IGRvZXNuJ3QgdGFrZSB0b28gbG9u
ZyB0aW1lLCBJIHdvdWxkCndhaXQgZm9yIHRoZSByZXN1bHQgZmlyc3QgYXMgbmV0ZGltIHNlcmll
cy4gT25lIHJlYXNvbiBpcyB0aGF0IEkKcmVtZW1iZXIgY2xhaW1zIHRvIGJlIG9ubHkgMTAlIHRv
IDIwJSBsb3NzIGNvbXBhcmluZyB0byB3aXJlIHNwZWVkLCBzbwpJJ2QgZXhwZWN0IGl0IHNob3Vs
ZCBiZSBtdWNoIGZhc3Rlci4gSSB2YWd1ZWx5IHJlbWVtYmVyLCBldmVuIGEgdmhvc3QKY2FuIGdp
dmVzIHVzIG1vcmUgdGhhbiAzTSBQUFMgaWYgd2UgZGlzYWJsZSBTTUFQLCBzbyB0aGUgbnVtYmVy
cyBoZXJlCmFyZSBub3QgYXMgaW1wcmVzc2l2ZSBhcyBleHBlY3RlZC4KClRoYW5rcwoKPgo+ID4K
PiA+Cj4gPiA+Cj4gPiA+ID4KPiA+ID4gPiBXaGF0IEkgbm90aWNlZCBpcyB0aGF0IHRoZSBob3Rz
cG90IGlzIHRoZSBkcml2ZXIgd3JpdGluZyB2aXJ0aW8gZGVzYy4gQmVjYXVzZQo+ID4gPiA+IHRo
ZSBkZXZpY2UgaXMgaW4gYnVzeSBtb2RlLiBTbyB0aGVyZSBpcyByYWNlIGJldHdlZW4gZHJpdmVy
IGFuZCBkZXZpY2UuCj4gPiA+ID4gU28gSSBtb2RpZmllZCB0aGUgdmlydGlvIGNvcmUgYW5kIGxh
emlseSB1cGRhdGVkIGF2YWlsIGlkeC4gVGhlbiBwcHMgY2FuIHJlYWNoCj4gPiA+ID4gMTAsMDAw
LDAwMC4KPiA+ID4KPiA+ID4gQ2FyZSB0byBwb3N0IGEgZHJhZnQgZm9yIHRoaXM/Cj4gPgo+ID4g
WUVTLCBJIGlzIHRoaW5raW5nIGZvciB0aGlzLgo+ID4gQnV0IG1heWJlIHRoYXQgaXMganVzdCB3
b3JrIGZvciBzcGxpdC4gVGhlIHBhY2tlZCBtb2RlIGhhcyBzb21lIHRyb3VibGVzLgo+Cj4gT2su
Cj4KPiBUaGFua3MKPgo+ID4KPiA+IFRoYW5rcy4KPiA+Cj4gPiA+Cj4gPiA+IFRoYW5rcwo+ID4g
Pgo+ID4gPiA+Cj4gPiA+ID4gVGhhbmtzLgo+ID4gPiA+Cj4gPiA+ID4gPgo+ID4gPiA+ID4gVGhh
bmtzCj4gPiA+ID4gPgo+ID4gPiA+ID4gPgo+ID4gPiA+ID4gPiAjIyBtYWludGFpbgo+ID4gPiA+
ID4gPgo+ID4gPiA+ID4gPiBJIGFtIGN1cnJlbnRseSBhIHJldmlld2VyIGZvciB2aXJ0aW8tbmV0
LiBJIGNvbW1pdCB0byBtYWludGFpbiBBRl9YRFAgc3VwcG9ydCBpbgo+ID4gPiA+ID4gPiB2aXJ0
aW8tbmV0Lgo+ID4gPiA+ID4gPgo+ID4gPiA+ID4gPiBQbGVhc2UgcmV2aWV3Lgo+ID4gPiA+ID4g
Pgo+ID4gPiA+ID4gPiBUaGFua3MuCj4gPiA+ID4gPiA+Cj4gPiA+ID4gPiA+IHYxOgo+ID4gPiA+
ID4gPiAgICAgMS4gcmVtb3ZlIHR3byB2aXJ0aW8gY29tbWl0cy4gUHVzaCB0aGlzIHBhdGNoc2V0
IHRvIG5ldC1uZXh0Cj4gPiA+ID4gPiA+ICAgICAyLiBzcXVhc2ggInZpcnRpb19uZXQ6IHZpcnRu
ZXRfcG9sbF90eCBzdXBwb3J0IHJlc2NoZWR1bGVkIiB0byB4c2s6IHN1cHBvcnQgdHgKPiA+ID4g
PiA+ID4gICAgIDMuIGZpeCBzb21lIHdhcm5pbmdzCj4gPiA+ID4gPiA+Cj4gPiA+ID4gPiA+IFh1
YW4gWmh1byAoMTkpOgo+ID4gPiA+ID4gPiAgIHZpcnRpb19uZXQ6IHJlbmFtZSBmcmVlX29sZF94
bWl0X3NrYnMgdG8gZnJlZV9vbGRfeG1pdAo+ID4gPiA+ID4gPiAgIHZpcnRpb19uZXQ6IHVuaWZ5
IHRoZSBjb2RlIGZvciByZWN5Y2xpbmcgdGhlIHhtaXQgcHRyCj4gPiA+ID4gPiA+ICAgdmlydGlv
X25ldDogaW5kZXBlbmRlbnQgZGlyZWN0b3J5Cj4gPiA+ID4gPiA+ICAgdmlydGlvX25ldDogbW92
ZSB0byB2aXJ0aW9fbmV0LmgKPiA+ID4gPiA+ID4gICB2aXJ0aW9fbmV0OiBhZGQgcHJlZml4IHZp
cnRuZXQgdG8gYWxsIHN0cnVjdC9hcGkgaW5zaWRlIHZpcnRpb19uZXQuaAo+ID4gPiA+ID4gPiAg
IHZpcnRpb19uZXQ6IHNlcGFyYXRlIHZpcnRuZXRfcnhfcmVzaXplKCkKPiA+ID4gPiA+ID4gICB2
aXJ0aW9fbmV0OiBzZXBhcmF0ZSB2aXJ0bmV0X3R4X3Jlc2l6ZSgpCj4gPiA+ID4gPiA+ICAgdmly
dGlvX25ldDogc3Egc3VwcG9ydCBwcmVtYXBwZWQgbW9kZQo+ID4gPiA+ID4gPiAgIHZpcnRpb19u
ZXQ6IHhzazogYmluZC91bmJpbmQgeHNrCj4gPiA+ID4gPiA+ICAgdmlydGlvX25ldDogeHNrOiBw
cmV2ZW50IGRpc2FibGUgdHggbmFwaQo+ID4gPiA+ID4gPiAgIHZpcnRpb19uZXQ6IHhzazogdHg6
IHN1cHBvcnQgdHgKPiA+ID4gPiA+ID4gICB2aXJ0aW9fbmV0OiB4c2s6IHR4OiBzdXBwb3J0IHdh
a2V1cAo+ID4gPiA+ID4gPiAgIHZpcnRpb19uZXQ6IHhzazogdHg6IHZpcnRuZXRfZnJlZV9vbGRf
eG1pdCgpIGRpc3Rpbmd1aXNoZXMgeHNrIGJ1ZmZlcgo+ID4gPiA+ID4gPiAgIHZpcnRpb19uZXQ6
IHhzazogdHg6IHZpcnRuZXRfc3FfZnJlZV91bnVzZWRfYnVmKCkgY2hlY2sgeHNrIGJ1ZmZlcgo+
ID4gPiA+ID4gPiAgIHZpcnRpb19uZXQ6IHhzazogcng6IGludHJvZHVjZSBhZGRfcmVjdmJ1Zl94
c2soKQo+ID4gPiA+ID4gPiAgIHZpcnRpb19uZXQ6IHhzazogcng6IGludHJvZHVjZSByZWNlaXZl
X3hzaygpIHRvIHJlY3YgeHNrIGJ1ZmZlcgo+ID4gPiA+ID4gPiAgIHZpcnRpb19uZXQ6IHhzazog
cng6IHZpcnRuZXRfcnFfZnJlZV91bnVzZWRfYnVmKCkgY2hlY2sgeHNrIGJ1ZmZlcgo+ID4gPiA+
ID4gPiAgIHZpcnRpb19uZXQ6IHVwZGF0ZSB0eCB0aW1lb3V0IHJlY29yZAo+ID4gPiA+ID4gPiAg
IHZpcnRpb19uZXQ6IHhkcF9mZWF0dXJlcyBhZGQgTkVUREVWX1hEUF9BQ1RfWFNLX1pFUk9DT1BZ
Cj4gPiA+ID4gPiA+Cj4gPiA+ID4gPiA+ICBNQUlOVEFJTkVSUyAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgIHwgICAyICstCj4gPiA+ID4gPiA+ICBkcml2ZXJzL25ldC9LY29uZmlnICAg
ICAgICAgICAgICAgICAgICAgICAgIHwgICA4ICstCj4gPiA+ID4gPiA+ICBkcml2ZXJzL25ldC9N
YWtlZmlsZSAgICAgICAgICAgICAgICAgICAgICAgIHwgICAyICstCj4gPiA+ID4gPiA+ICBkcml2
ZXJzL25ldC92aXJ0aW8vS2NvbmZpZyAgICAgICAgICAgICAgICAgIHwgIDEzICsKPiA+ID4gPiA+
ID4gIGRyaXZlcnMvbmV0L3ZpcnRpby9NYWtlZmlsZSAgICAgICAgICAgICAgICAgfCAgIDggKwo+
ID4gPiA+ID4gPiAgZHJpdmVycy9uZXQve3ZpcnRpb19uZXQuYyA9PiB2aXJ0aW8vbWFpbi5jfSB8
IDY1MiArKysrKysrKystLS0tLS0tLS0tLQo+ID4gPiA+ID4gPiAgZHJpdmVycy9uZXQvdmlydGlv
L3ZpcnRpb19uZXQuaCAgICAgICAgICAgICB8IDM1OSArKysrKysrKysrKwo+ID4gPiA+ID4gPiAg
ZHJpdmVycy9uZXQvdmlydGlvL3hzay5jICAgICAgICAgICAgICAgICAgICB8IDU0NSArKysrKysr
KysrKysrKysrCj4gPiA+ID4gPiA+ICBkcml2ZXJzL25ldC92aXJ0aW8veHNrLmggICAgICAgICAg
ICAgICAgICAgIHwgIDMyICsKPiA+ID4gPiA+ID4gIDkgZmlsZXMgY2hhbmdlZCwgMTI0NyBpbnNl
cnRpb25zKCspLCAzNzQgZGVsZXRpb25zKC0pCj4gPiA+ID4gPiA+ICBjcmVhdGUgbW9kZSAxMDA2
NDQgZHJpdmVycy9uZXQvdmlydGlvL0tjb25maWcKPiA+ID4gPiA+ID4gIGNyZWF0ZSBtb2RlIDEw
MDY0NCBkcml2ZXJzL25ldC92aXJ0aW8vTWFrZWZpbGUKPiA+ID4gPiA+ID4gIHJlbmFtZSBkcml2
ZXJzL25ldC97dmlydGlvX25ldC5jID0+IHZpcnRpby9tYWluLmN9ICg5MSUpCj4gPiA+ID4gPiA+
ICBjcmVhdGUgbW9kZSAxMDA2NDQgZHJpdmVycy9uZXQvdmlydGlvL3ZpcnRpb19uZXQuaAo+ID4g
PiA+ID4gPiAgY3JlYXRlIG1vZGUgMTAwNjQ0IGRyaXZlcnMvbmV0L3ZpcnRpby94c2suYwo+ID4g
PiA+ID4gPiAgY3JlYXRlIG1vZGUgMTAwNjQ0IGRyaXZlcnMvbmV0L3ZpcnRpby94c2suaAo+ID4g
PiA+ID4gPgo+ID4gPiA+ID4gPiAtLQo+ID4gPiA+ID4gPiAyLjMyLjAuMy5nMDExOTVjZjlmCj4g
PiA+ID4gPiA+Cj4gPiA+ID4gPgo+ID4gPiA+Cj4gPiA+Cj4gPgoKX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX18KVmlydHVhbGl6YXRpb24gbWFpbGluZyBsaXN0
ClZpcnR1YWxpemF0aW9uQGxpc3RzLmxpbnV4LWZvdW5kYXRpb24ub3JnCmh0dHBzOi8vbGlzdHMu
bGludXhmb3VuZGF0aW9uLm9yZy9tYWlsbWFuL2xpc3RpbmZvL3ZpcnR1YWxpemF0aW9u
