Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3DE6CC001B0
	for <virtualization@archiver.kernel.org>; Fri, 11 Aug 2023 09:55:07 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id D662041D94;
	Fri, 11 Aug 2023 09:55:06 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org D662041D94
Authentication-Results: smtp4.osuosl.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=YR+OGfu7
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
	by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id qfUAjepA9uBB; Fri, 11 Aug 2023 09:55:05 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp4.osuosl.org (Postfix) with ESMTPS id D523141B6F;
	Fri, 11 Aug 2023 09:55:04 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org D523141B6F
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id BCFA5C0072;
	Fri, 11 Aug 2023 09:55:04 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [IPv6:2605:bc80:3010::138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 872F7C0032
 for <virtualization@lists.linux-foundation.org>;
 Fri, 11 Aug 2023 09:55:03 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id 552AD82109
 for <virtualization@lists.linux-foundation.org>;
 Fri, 11 Aug 2023 09:55:03 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 552AD82109
Authentication-Results: smtp1.osuosl.org;
 dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com
 header.a=rsa-sha256 header.s=mimecast20190719 header.b=YR+OGfu7
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id ClpJgp30W2-0
 for <virtualization@lists.linux-foundation.org>;
 Fri, 11 Aug 2023 09:55:02 +0000 (UTC)
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.133.124])
 by smtp1.osuosl.org (Postfix) with ESMTPS id 52141820C5
 for <virtualization@lists.linux-foundation.org>;
 Fri, 11 Aug 2023 09:55:02 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 52141820C5
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1691747701;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=e4w/UdxHd9bXvs+scQBiH0YPOUtQ/8Mf3TySBUJ90ac=;
 b=YR+OGfu7LPbwGF5PoYrRPZgwNxMmPM4imKc6TGvXJVq1N3jRRFJDrZY7MV6vd9cMuOdpKg
 nNVGkAVJOTgR4zVRePXsaltQtHPxhElSVUOYVLLblRCme2p4STR5+jym/6LfT1gwY0GT3C
 9qq+Sl33G3iaPbvtMMBBT/M3QA96abw=
Received: from mail-lj1-f200.google.com (mail-lj1-f200.google.com
 [209.85.208.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-460-TIwkAo8bOXGefTyMjKzXEw-1; Fri, 11 Aug 2023 05:54:59 -0400
X-MC-Unique: TIwkAo8bOXGefTyMjKzXEw-1
Received: by mail-lj1-f200.google.com with SMTP id
 38308e7fff4ca-2b9bee2d344so19935081fa.1
 for <virtualization@lists.linux-foundation.org>;
 Fri, 11 Aug 2023 02:54:59 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1691747698; x=1692352498;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=e4w/UdxHd9bXvs+scQBiH0YPOUtQ/8Mf3TySBUJ90ac=;
 b=avjvPYi8iiFsyrPS8IuRvKBvNFE1w9tjYxxi5JkCjiRbEExC9VmBUszeJr/cyNHur3
 ln9QpjEpPPzdmHV2NUBzP4lm6f/I0Pksl0QeDIA2dLSVWPsSeWJOvNmHV3oHXnFAOK9N
 2EnO/0ev8/9rXJHtCdkcCJz2r/80yPpNtWHK9XjvWq05R5kmDlFJWNMPGc60yRwUgu51
 CDwxCZrKywCdivs8gYaMZMk2ZCtg6GXtIZfK5fGh/yiHjxJz52nAeRHxwos9XJI4UIVV
 BuhiNyoS1iS9nSWVqpM3OcRoYsrJwp4RnHuPbJzsrqRntqOaMrbLAljsUvtBSxQ9eYli
 ttkA==
X-Gm-Message-State: AOJu0YzElBpvcZJVZqZiM46UBiXA3zWsbutjPQDS66wxZS5Y7vr7/Q6p
 FZDnAMTQ+XQ+xiWs7ruZG5jX4zR2mOVGEa1bW17s9NRYueNTl33bRtmbT3IDM6To2V+HTVsyVjk
 Ei/k6HzpnYVzzr401QplXc1RapvXnKOZIJd9jc9qQetomFbUwBslrsZYrVA==
X-Received: by 2002:a2e:9955:0:b0:2b6:eeb3:da94 with SMTP id
 r21-20020a2e9955000000b002b6eeb3da94mr1215397ljj.22.1691747698324; 
 Fri, 11 Aug 2023 02:54:58 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGFkjHeNeCsm6RtiCB/JqtxFZPK7LK6iU2F5MkwYXHYcozkIdCHurq8TdUOp1KyIIQiCvfsLzHbUPqfqHUNr2w=
X-Received: by 2002:a2e:9955:0:b0:2b6:eeb3:da94 with SMTP id
 r21-20020a2e9955000000b002b6eeb3da94mr1215385ljj.22.1691747697950; Fri, 11
 Aug 2023 02:54:57 -0700 (PDT)
MIME-Version: 1.0
References: <20230811091539.1359865-1-jasowang@redhat.com>
 <20230811052435-mutt-send-email-mst@kernel.org>
 <CACGkMEuO+smLSY+dRvDOar=pq6MpOv3U9z6gX=xRUkHg494MFw@mail.gmail.com>
 <20230811054736-mutt-send-email-mst@kernel.org>
In-Reply-To: <20230811054736-mutt-send-email-mst@kernel.org>
From: Jason Wang <jasowang@redhat.com>
Date: Fri, 11 Aug 2023 17:54:46 +0800
Message-ID: <CACGkMEtt3awOjh=XP=95EJ_8KOJD-wmi0qj9WgVfYT3whcVPfg@mail.gmail.com>
Subject: Re: [PATCH] virtio_vdpa: build affinity masks conditionally
To: "Michael S. Tsirkin" <mst@redhat.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Cc: xuanzhuo@linux.alibaba.com, xieyongji@bytedance.com,
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
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Errors-To: virtualization-bounces@lists.linux-foundation.org
Sender: "Virtualization" <virtualization-bounces@lists.linux-foundation.org>

T24gRnJpLCBBdWcgMTEsIDIwMjMgYXQgNTo0OOKAr1BNIE1pY2hhZWwgUy4gVHNpcmtpbiA8bXN0
QHJlZGhhdC5jb20+IHdyb3RlOgo+Cj4gT24gRnJpLCBBdWcgMTEsIDIwMjMgYXQgMDU6NDE6NDRQ
TSArMDgwMCwgSmFzb24gV2FuZyB3cm90ZToKPiA+IE9uIEZyaSwgQXVnIDExLCAyMDIzIGF0IDU6
MjXigK9QTSBNaWNoYWVsIFMuIFRzaXJraW4gPG1zdEByZWRoYXQuY29tPiB3cm90ZToKPiA+ID4K
PiA+ID4gT24gRnJpLCBBdWcgMTEsIDIwMjMgYXQgMDU6MTU6MzlBTSAtMDQwMCwgSmFzb24gV2Fu
ZyB3cm90ZToKPiA+ID4gPiBXZSB0cnkgdG8gYnVpbGQgYWZmaW5pdHkgbWFzayB2aWEgY3JlYXRl
X2FmZmluaXR5X21hc2tzKCkKPiA+ID4gPiB1bmNvbmRpdGlvbmFsbHkgd2hpY2ggbWF5IGxlYWQg
c2V2ZXJhbCBpc3N1ZXM6Cj4gPiA+ID4KPiA+ID4gPiAtIHRoZSBhZmZpbml0eSBtYXNrIGlzIG5v
dCB1c2VkIGZvciBwYXJlbnQgd2l0aG91dCBhZmZpbml0eSBzdXBwb3J0Cj4gPiA+ID4gICAob25s
eSBWRFVTRSBzdXBwb3J0IHRoZSBhZmZpbml0eSBub3cpCj4gPiA+ID4gLSB0aGUgbG9naWMgb2Yg
Y3JlYXRlX2FmZmluaXR5X21hc2tzKCkgbWlnaHQgbm90IHdvcmsgZm9yIGRldmljZXMKPiA+ID4g
PiAgIG90aGVyIHRoYW4gYmxvY2suIEZvciBleGFtcGxlIGl0J3Mgbm90IHJhcmUgaW4gdGhlIG5l
dHdvcmtpbmcgZGV2aWNlCj4gPiA+ID4gICB3aGVyZSB0aGUgbnVtYmVyIG9mIHF1ZXVlcyBjb3Vs
ZCBleGNlZWQgdGhlIG51bWJlciBvZiBDUFVzLiBTdWNoCj4gPiA+ID4gICBjYXNlIGJyZWFrcyB0
aGUgY3VycmVudCBhZmZpbml0eSBsb2dpYyB3aGljaCBpcyBiYXNlZCBvbgo+ID4gPiA+ICAgZ3Jv
dXBfY3B1c19ldmVubHkoKSB3aG8gYXNzdW1lcyB0aGUgbnVtYmVyIG9mIENQVXMgYXJlIG5vdCBs
ZXNzIHRoYW4KPiA+ID4gPiAgIHRoZSBudW1iZXIgb2YgZ3JvdXBzLiBUaGlzIGNhbiB0cmlnZ2Vy
IGEgd2FybmluZ1sxXToKPiA+ID4gPgo+ID4gPiA+ICAgICAgIGlmIChyZXQgPj0gMCkKPiA+ID4g
PiAgICAgICAgICAgICAgIFdBUk5fT04obnJfcHJlc2VudCArIG5yX290aGVycyA8IG51bWdycHMp
Owo+ID4gPiA+Cj4gPiA+ID4gRml4aW5nIHRoaXMgYnkgb25seSBidWlsZCB0aGUgYWZmaW5pdHkg
bWFza3Mgb25seSB3aGVuCj4gPiA+ID4KPiA+ID4gPiAtIERyaXZlciBwYXNzZXMgYWZmaW5pdHkg
ZGVzY3JpcHRvciwgZHJpdmVyIGxpa2UgdmlydGlvLWJsayBjYW4gbWFrZQo+ID4gPiA+ICAgc3Vy
ZSB0byBsaW1pdCB0aGUgbnVtYmVyIG9mIHF1ZXVlcyB3aGVuIGl0IGV4Y2VlZHMgdGhlIG51bWJl
ciBvZiBDUFVzCj4gPiA+ID4gLSBQYXJlbnQgc3VwcG9ydCBhZmZpbml0eSBzZXR0aW5nIGNvbmZp
ZyBvcHMKPiA+ID4gPgo+ID4gPiA+IFRoaXMgaGVscCB0byBhdm9pZCB0aGUgd2FybmluZy4gTW9y
ZSBvcHRpbWl6YXRpb25zIGNvdWxkIGJlIGRvbmUgb24KPiA+ID4gPiB0b3AuCj4gPiA+ID4KPiA+
ID4gPiBbMV0KPiA+ID4gPiBbICA2ODIuMTQ2NjU1XSBXQVJOSU5HOiBDUFU6IDYgUElEOiAxNTUw
IGF0IGxpYi9ncm91cF9jcHVzLmM6NDAwIGdyb3VwX2NwdXNfZXZlbmx5KzB4MWFhLzB4MWMwCj4g
PiA+ID4gWyAgNjgyLjE0NjY2OF0gQ1BVOiA2IFBJRDogMTU1MCBDb21tOiB2ZHBhIE5vdCB0YWlu
dGVkIDYuNS4wLXJjNWphc29uKyAjNzkKPiA+ID4gPiBbICA2ODIuMTQ2NjcxXSBIYXJkd2FyZSBu
YW1lOiBRRU1VIFN0YW5kYXJkIFBDIChpNDQwRlggKyBQSUlYLCAxOTk2KSwgQklPUyByZWwtMS4x
Ni4yLTAtZ2VhMWI3YTA3MzM5MC1wcmVidWlsdC5xZW11Lm9yZyAwNC8wMS8yMDE0Cj4gPiA+ID4g
WyAgNjgyLjE0NjY3M10gUklQOiAwMDEwOmdyb3VwX2NwdXNfZXZlbmx5KzB4MWFhLzB4MWMwCj4g
PiA+ID4gWyAgNjgyLjE0NjY3Nl0gQ29kZTogNGMgODkgZTAgNWIgNWQgNDEgNWMgNDEgNWQgNDEg
NWUgYzMgY2MgY2MgY2MgY2MgZTggMWIgYzQgNzQgZmYgNDggODkgZWYgZTggMTMgYWMgOTggZmYg
NGMgODkgZTcgNDUgMzEgZTQgZTggMDggYWMgOTggZmYgZWIgYzIgPDBmPiAwYiBlYiBiNiBlOCBm
ZCAwNSBjMyAwMCA0NSAzMSBlNCBlYiBlNSBjYyBjYyBjYyBjYyBjYyBjYyBjYyBjYwo+ID4gPiA+
IFsgIDY4Mi4xNDY2NzldIFJTUDogMDAxODpmZmZmYzkwMDAyMTVmNDk4IEVGTEFHUzogMDAwMTAy
OTMKPiA+ID4gPiBbICA2ODIuMTQ2NjgyXSBSQVg6IDAwMDAwMDAwMDAwMWYxZTAgUkJYOiAwMDAw
MDAwMDAwMDAwMDQxIFJDWDogMDAwMDAwMDAwMDAwMDAwMAo+ID4gPiA+IFsgIDY4Mi4xNDY2ODRd
IFJEWDogZmZmZjg4ODEwOTkyMjA1OCBSU0k6IDAwMDAwMDAwMDAwMDAwNDEgUkRJOiAwMDAwMDAw
MDAwMDAwMDMwCj4gPiA+ID4gWyAgNjgyLjE0NjY4Nl0gUkJQOiBmZmZmODg4MTA5OTIyMDU4IFIw
ODogZmZmZmM5MDAwMjE1ZjQ5OCBSMDk6IGZmZmZjOTAwMDIxNWY0YTAKPiA+ID4gPiBbICA2ODIu
MTQ2Njg3XSBSMTA6IDAwMDAwMDAwMDAwMTk4ZDAgUjExOiAwMDAwMDAwMDAwMDAwMDMwIFIxMjog
ZmZmZjg4ODEwN2UwMjgwMAo+ID4gPiA+IFsgIDY4Mi4xNDY2ODldIFIxMzogMDAwMDAwMDAwMDAw
MDAzMCBSMTQ6IDAwMDAwMDAwMDAwMDAwMzAgUjE1OiAwMDAwMDAwMDAwMDAwMDQxCj4gPiA+ID4g
WyAgNjgyLjE0NjY5Ml0gRlM6ICAwMDAwN2ZlZjUyMzE1NzQwKDAwMDApIEdTOmZmZmY4ODgyMzcz
ODAwMDAoMDAwMCkga25sR1M6MDAwMDAwMDAwMDAwMDAwMAo+ID4gPiA+IFsgIDY4Mi4xNDY2OTVd
IENTOiAgMDAxMCBEUzogMDAwMCBFUzogMDAwMCBDUjA6IDAwMDAwMDAwODAwNTAwMzMKPiA+ID4g
PiBbICA2ODIuMTQ2Njk2XSBDUjI6IDAwMDA3ZmVmNTI1MDkwMDAgQ1IzOiAwMDAwMDAwMTEwZGJj
MDA0IENSNDogMDAwMDAwMDAwMDM3MGVlMAo+ID4gPiA+IFsgIDY4Mi4xNDY2OThdIERSMDogMDAw
MDAwMDAwMDAwMDAwMCBEUjE6IDAwMDAwMDAwMDAwMDAwMDAgRFIyOiAwMDAwMDAwMDAwMDAwMDAw
Cj4gPiA+ID4gWyAgNjgyLjE0NjcwMF0gRFIzOiAwMDAwMDAwMDAwMDAwMDAwIERSNjogMDAwMDAw
MDBmZmZlMGZmMCBEUjc6IDAwMDAwMDAwMDAwMDA0MDAKPiA+ID4gPiBbICA2ODIuMTQ2NzAxXSBD
YWxsIFRyYWNlOgo+ID4gPiA+IFsgIDY4Mi4xNDY3MDNdICA8VEFTSz4KPiA+ID4gPiBbICA2ODIu
MTQ2NzA1XSAgPyBfX3dhcm4rMHg3Yi8weDEzMAo+ID4gPiA+IFsgIDY4Mi4xNDY3MDldICA/IGdy
b3VwX2NwdXNfZXZlbmx5KzB4MWFhLzB4MWMwCj4gPiA+ID4gWyAgNjgyLjE0NjcxMl0gID8gcmVw
b3J0X2J1ZysweDFjOC8weDFlMAo+ID4gPiA+IFsgIDY4Mi4xNDY3MTddICA/IGhhbmRsZV9idWcr
MHgzYy8weDcwCj4gPiA+ID4gWyAgNjgyLjE0NjcyMV0gID8gZXhjX2ludmFsaWRfb3ArMHgxNC8w
eDcwCj4gPiA+ID4gWyAgNjgyLjE0NjcyM10gID8gYXNtX2V4Y19pbnZhbGlkX29wKzB4MTYvMHgy
MAo+ID4gPiA+IFsgIDY4Mi4xNDY3MjddICA/IGdyb3VwX2NwdXNfZXZlbmx5KzB4MWFhLzB4MWMw
Cj4gPiA+ID4gWyAgNjgyLjE0NjcyOV0gID8gZ3JvdXBfY3B1c19ldmVubHkrMHgxNWMvMHgxYzAK
PiA+ID4gPiBbICA2ODIuMTQ2NzMxXSAgY3JlYXRlX2FmZmluaXR5X21hc2tzKzB4YWYvMHgxYTAK
PiA+ID4gPiBbICA2ODIuMTQ2NzM1XSAgdmlydGlvX3ZkcGFfZmluZF92cXMrMHg4My8weDFkMAo+
ID4gPiA+IFsgIDY4Mi4xNDY3MzhdICA/IF9fcGZ4X2RlZmF1bHRfY2FsY19zZXRzKzB4MTAvMHgx
MAo+ID4gPiA+IFsgIDY4Mi4xNDY3NDJdICB2aXJ0bmV0X2ZpbmRfdnFzKzB4MWYwLzB4MzcwCj4g
PiA+ID4gWyAgNjgyLjE0Njc0N10gIHZpcnRuZXRfcHJvYmUrMHg1MDEvMHhjZDAKPiA+ID4gPiBb
ICA2ODIuMTQ2NzQ5XSAgPyB2cF9tb2Rlcm5fZ2V0X3N0YXR1cysweDEyLzB4MjAKPiA+ID4gPiBb
ICA2ODIuMTQ2NzUxXSAgPyBnZXRfY2FwX2FkZHIuaXNyYS4wKzB4MTAvMHhjMAo+ID4gPiA+IFsg
IDY4Mi4xNDY3NTRdICB2aXJ0aW9fZGV2X3Byb2JlKzB4MWFmLzB4MjYwCj4gPiA+ID4gWyAgNjgy
LjE0Njc1OV0gIHJlYWxseV9wcm9iZSsweDFhNS8weDQxMAo+ID4gPiA+Cj4gPiA+ID4gRml4ZXM6
IDNkYWQ1NjgyM2I1MyAoInZpcnRpby12ZHBhOiBTdXBwb3J0IGludGVycnVwdCBhZmZpbml0eSBz
cHJlYWRpbmcgbWVjaGFuaXNtIikKPiA+ID4gPiBTaWduZWQtb2ZmLWJ5OiBKYXNvbiBXYW5nIDxq
YXNvd2FuZ0ByZWRoYXQuY29tPgo+ID4gPgo+ID4gPiBUaGlzIHdvbid0IGZpeCB0aGUgY2FzZSB3
aGVyZSBibG9jayBoYXMgbW9yZSBxdWV1ZXMgdGhhbiBDUFVzIHRob3VnaCwKPiA+ID4gd2lsbCBp
dD8KPiA+Cj4gPiBCbG9jayB3aWxsIGxpbWl0IHRoZSBudW1iZXIgb2YgcXVldWVzIGR1cmluZyBp
bml0X3ZxKCk6Cj4gPgo+ID4gICAgICAgICBudW1fdnFzID0gbWluX3QodW5zaWduZWQgaW50LAo+
ID4gICAgICAgICAgICAgICAgICAgICAgICAgbWluX25vdF96ZXJvKG51bV9yZXF1ZXN0X3F1ZXVl
cywgbnJfY3B1X2lkcyksCj4gPiAgICAgICAgICAgICAgICAgICAgICAgICBudW1fdnFzKTsKPiA+
Cj4gPgo+ID4gVGhhbmtzCj4KPiBHb29kIHBvaW50LiBUaGlzIGRvZXNuJ3QgcGxheSB3ZWxsIHdp
dGggY3B1IGhvdHBsdWcgYnV0IHRoYXQgaXMgbm90IG5ldy4KClllcy4KClRoYW5rcwoKPgo+ID4g
Pgo+ID4gPiA+IC0tLQo+ID4gPiA+ICBkcml2ZXJzL3ZpcnRpby92aXJ0aW9fdmRwYS5jIHwgMTcg
KysrKysrKysrKystLS0tLS0KPiA+ID4gPiAgMSBmaWxlIGNoYW5nZWQsIDExIGluc2VydGlvbnMo
KyksIDYgZGVsZXRpb25zKC0pCj4gPiA+ID4KPiA+ID4gPiBkaWZmIC0tZ2l0IGEvZHJpdmVycy92
aXJ0aW8vdmlydGlvX3ZkcGEuYyBiL2RyaXZlcnMvdmlydGlvL3ZpcnRpb192ZHBhLmMKPiA+ID4g
PiBpbmRleCA5NjExNjFkYTU5MDAuLjA2Y2U2ZDhjMmUwMCAxMDA2NDQKPiA+ID4gPiAtLS0gYS9k
cml2ZXJzL3ZpcnRpby92aXJ0aW9fdmRwYS5jCj4gPiA+ID4gKysrIGIvZHJpdmVycy92aXJ0aW8v
dmlydGlvX3ZkcGEuYwo+ID4gPiA+IEBAIC0zNjYsMTEgKzM2NiwxNCBAQCBzdGF0aWMgaW50IHZp
cnRpb192ZHBhX2ZpbmRfdnFzKHN0cnVjdCB2aXJ0aW9fZGV2aWNlICp2ZGV2LCB1bnNpZ25lZCBp
bnQgbnZxcywKPiA+ID4gPiAgICAgICBzdHJ1Y3QgaXJxX2FmZmluaXR5IGRlZmF1bHRfYWZmZCA9
IHsgMCB9Owo+ID4gPiA+ICAgICAgIHN0cnVjdCBjcHVtYXNrICptYXNrczsKPiA+ID4gPiAgICAg
ICBzdHJ1Y3QgdmRwYV9jYWxsYmFjayBjYjsKPiA+ID4gPiArICAgICBib29sIGhhc19hZmZpbml0
eSA9IGRlc2MgJiYgb3BzLT5zZXRfdnFfYWZmaW5pdHk7Cj4gPiA+ID4gICAgICAgaW50IGksIGVy
ciwgcXVldWVfaWR4ID0gMDsKPiA+ID4gPgo+ID4gPiA+IC0gICAgIG1hc2tzID0gY3JlYXRlX2Fm
ZmluaXR5X21hc2tzKG52cXMsIGRlc2MgPyBkZXNjIDogJmRlZmF1bHRfYWZmZCk7Cj4gPiA+ID4g
LSAgICAgaWYgKCFtYXNrcykKPiA+ID4gPiAtICAgICAgICAgICAgIHJldHVybiAtRU5PTUVNOwo+
ID4gPiA+ICsgICAgIGlmIChoYXNfYWZmaW5pdHkpIHsKPiA+ID4gPiArICAgICAgICAgICAgIG1h
c2tzID0gY3JlYXRlX2FmZmluaXR5X21hc2tzKG52cXMsIGRlc2MgPyBkZXNjIDogJmRlZmF1bHRf
YWZmZCk7Cj4gPiA+ID4gKyAgICAgICAgICAgICBpZiAoIW1hc2tzKQo+ID4gPiA+ICsgICAgICAg
ICAgICAgICAgICAgICByZXR1cm4gLUVOT01FTTsKPiA+ID4gPiArICAgICB9Cj4gPiA+ID4KPiA+
ID4gPiAgICAgICBmb3IgKGkgPSAwOyBpIDwgbnZxczsgKytpKSB7Cj4gPiA+ID4gICAgICAgICAg
ICAgICBpZiAoIW5hbWVzW2ldKSB7Cj4gPiA+ID4gQEAgLTM4NiwyMCArMzg5LDIyIEBAIHN0YXRp
YyBpbnQgdmlydGlvX3ZkcGFfZmluZF92cXMoc3RydWN0IHZpcnRpb19kZXZpY2UgKnZkZXYsIHVu
c2lnbmVkIGludCBudnFzLAo+ID4gPiA+ICAgICAgICAgICAgICAgICAgICAgICBnb3RvIGVycl9z
ZXR1cF92cTsKPiA+ID4gPiAgICAgICAgICAgICAgIH0KPiA+ID4gPgo+ID4gPiA+IC0gICAgICAg
ICAgICAgaWYgKG9wcy0+c2V0X3ZxX2FmZmluaXR5KQo+ID4gPiA+ICsgICAgICAgICAgICAgaWYg
KGhhc19hZmZpbml0eSkKPiA+ID4gPiAgICAgICAgICAgICAgICAgICAgICAgb3BzLT5zZXRfdnFf
YWZmaW5pdHkodmRwYSwgaSwgJm1hc2tzW2ldKTsKPiA+ID4gPiAgICAgICB9Cj4gPiA+ID4KPiA+
ID4gPiAgICAgICBjYi5jYWxsYmFjayA9IHZpcnRpb192ZHBhX2NvbmZpZ19jYjsKPiA+ID4gPiAg
ICAgICBjYi5wcml2YXRlID0gdmRfZGV2Owo+ID4gPiA+ICAgICAgIG9wcy0+c2V0X2NvbmZpZ19j
Yih2ZHBhLCAmY2IpOwo+ID4gPiA+IC0gICAgIGtmcmVlKG1hc2tzKTsKPiA+ID4gPiArICAgICBp
ZiAoaGFzX2FmZmluaXR5KQo+ID4gPiA+ICsgICAgICAgICAgICAga2ZyZWUobWFza3MpOwo+ID4g
PiA+Cj4gPiA+ID4gICAgICAgcmV0dXJuIDA7Cj4gPiA+ID4KPiA+ID4gPiAgZXJyX3NldHVwX3Zx
Ogo+ID4gPiA+ICAgICAgIHZpcnRpb192ZHBhX2RlbF92cXModmRldik7Cj4gPiA+ID4gLSAgICAg
a2ZyZWUobWFza3MpOwo+ID4gPiA+ICsgICAgIGlmIChoYXNfYWZmaW5pdHkpCj4gPiA+ID4gKyAg
ICAgICAgICAgICBrZnJlZShtYXNrcyk7Cj4gPiA+ID4gICAgICAgcmV0dXJuIGVycjsKPiA+ID4g
PiAgfQo+ID4gPiA+Cj4gPiA+ID4gLS0KPiA+ID4gPiAyLjM5LjMKPiA+ID4KPgoKX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18KVmlydHVhbGl6YXRpb24gbWFp
bGluZyBsaXN0ClZpcnR1YWxpemF0aW9uQGxpc3RzLmxpbnV4LWZvdW5kYXRpb24ub3JnCmh0dHBz
Oi8vbGlzdHMubGludXhmb3VuZGF0aW9uLm9yZy9tYWlsbWFuL2xpc3RpbmZvL3ZpcnR1YWxpemF0
aW9u
