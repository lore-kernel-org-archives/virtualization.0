Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3390ECDB47E
	for <virtualization@archiver.kernel.org>; Thu, 19 Oct 2023 02:53:55 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id A3CEA6FA53;
	Thu, 19 Oct 2023 02:53:54 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org A3CEA6FA53
Authentication-Results: smtp3.osuosl.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=HB2+MA84
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
	by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id T7KdS2m78Prz; Thu, 19 Oct 2023 02:53:53 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp3.osuosl.org (Postfix) with ESMTPS id AEF5060F13;
	Thu, 19 Oct 2023 02:53:52 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org AEF5060F13
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 8EB5EC0071;
	Thu, 19 Oct 2023 02:53:52 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [IPv6:2605:bc80:3010::136])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 79702C0032
 for <virtualization@lists.linux-foundation.org>;
 Thu, 19 Oct 2023 02:53:51 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id 550786F74D
 for <virtualization@lists.linux-foundation.org>;
 Thu, 19 Oct 2023 02:53:51 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 550786F74D
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id rbWIjXUPSVJm
 for <virtualization@lists.linux-foundation.org>;
 Thu, 19 Oct 2023 02:53:49 +0000 (UTC)
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.129.124])
 by smtp3.osuosl.org (Postfix) with ESMTPS id 6FFC860F13
 for <virtualization@lists.linux-foundation.org>;
 Thu, 19 Oct 2023 02:53:48 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 6FFC860F13
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1697684027;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=YbD/Q6ufbnNB3XAdhgE8oF7W+MQMG5bePwJCf8IlXBE=;
 b=HB2+MA840cNrlIgoDzdFtQcmHN2NpnWx10zm4ysKaWpixdRUzxBknY5EhSPeOxACwkZJdw
 x2r8r/7aewWgIQ+7T0zyW8OhtGsC9x1fTU7NzJl+YTSUWLpAXVW2MfpZBQLDU2mCaymXmO
 dEvm4ttg0KQ+t+1u4l1DqoIZ5p47rbo=
Received: from mail-lj1-f198.google.com (mail-lj1-f198.google.com
 [209.85.208.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-283-b0FmOTEjPoua7PXtzRWH4A-1; Wed, 18 Oct 2023 22:53:45 -0400
X-MC-Unique: b0FmOTEjPoua7PXtzRWH4A-1
Received: by mail-lj1-f198.google.com with SMTP id
 38308e7fff4ca-2b6ff15946fso70931741fa.2
 for <virtualization@lists.linux-foundation.org>;
 Wed, 18 Oct 2023 19:53:44 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1697684023; x=1698288823;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=YbD/Q6ufbnNB3XAdhgE8oF7W+MQMG5bePwJCf8IlXBE=;
 b=v7C/EzfR/0oi880juyTtr2H6hNTbtcsjFtgISgpPxkUnR24OfmmOqBkf+MrRw2x8em
 5KvgNR4VP2MLZeX0nNb38B6rOnwXZHGc669V4tNFQeJXPqbP2deHV9hc7CVkh5Wd5vDQ
 g48yB1ZkA8yea7OZxReeQmr6NqKFBbZKH4YgEHoegjNbHJpVq3ZC/58aHA/9ze33Br68
 cCQ/7XZ21QwTTMFTn0CRtxMe4qLwVqwtHexHQFzGSpKWN21dJvQGnMg1wIiPTK3ZfEiT
 nwK2Az3DYsw5M+VO5OnJvltgkitXnBN2UD67OzCxyO4kzcUEl8BNEnCupGXC4COQe1Nj
 d5+Q==
X-Gm-Message-State: AOJu0YyEXE8UC++XET/KDWjfwd/dhZkynjgWc3PDP7UcmHsUZXl2qWYE
 PYfrAMGmzJc94er5EscLHbUNDR45eQlgCfyXv3GDGCvwUeb+mRC4OqN6iELP3WzoFRqJAqceSmC
 yd0rO0M9kGqdwVWeLLHkledG+7uGeUfDc7EyJq+W+JJAiK85lfRXZhPDlKw==
X-Received: by 2002:ac2:4c08:0:b0:503:1913:ed8e with SMTP id
 t8-20020ac24c08000000b005031913ed8emr421716lfq.61.1697684023490; 
 Wed, 18 Oct 2023 19:53:43 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFc85HsbiaIk2VZkqptEI+PmzYF3FWWNi9G2ZmlHLHpwyPIJ1ic9T6Flkrq70D3hKlk1SxLp6WajJwV6MuFuxc=
X-Received: by 2002:ac2:4c08:0:b0:503:1913:ed8e with SMTP id
 t8-20020ac24c08000000b005031913ed8emr421711lfq.61.1697684023116; Wed, 18 Oct
 2023 19:53:43 -0700 (PDT)
MIME-Version: 1.0
References: <1696928580-7520-1-git-send-email-si-wei.liu@oracle.com>
 <1696928580-7520-3-git-send-email-si-wei.liu@oracle.com>
 <CACGkMEtkcyC54M_8A63uBEYjJP+EinLzTk3gP8CQ_rWs0Omt-Q@mail.gmail.com>
 <1bd79050-8eb5-49f6-9e58-6c7eb3fcab3e@oracle.com>
 <CACGkMEt_zvBM=ysbXZJEC1sdbCk=BpcWvtjeuP_L2WH4ke1dWQ@mail.gmail.com>
 <CAJaqyWf0AhsS6kaGUMVCosDjuRoeCAqO3OTVC=veqjV3jCqUjQ@mail.gmail.com>
 <8f8c0c28-59a4-489b-9276-fc3b5cfa8faa@oracle.com>
 <CACGkMEs0W1joaNh0-a27Nekxn8V8CmGgr99p+r60dA6sQeys5g@mail.gmail.com>
 <c9c819b9-4a63-4bb4-a977-881f6e653ed8@oracle.com>
 <CACGkMEuX8-T6BhbiqkTfF3NBoxS35zQ=k6Th=h0G5sDz4DV93Q@mail.gmail.com>
 <CACGkMEtZ_oEydqsvJh0-eaDh4q_KHq9fLPg1uy-W1m7K_g+1-w@mail.gmail.com>
 <d2b52f01-3d00-46ad-b58e-e23fd8a49e87@oracle.com>
In-Reply-To: <d2b52f01-3d00-46ad-b58e-e23fd8a49e87@oracle.com>
From: Jason Wang <jasowang@redhat.com>
Date: Thu, 19 Oct 2023 10:53:31 +0800
Message-ID: <CACGkMEvebhMo5dfcyq2MFhBvFVNbwrqVofJXaBe9Vmn1O4qVjA@mail.gmail.com>
Subject: Re: [PATCH 2/4] vhost-vdpa: reset vendor specific mapping to initial
 state in .release
To: Si-Wei Liu <si-wei.liu@oracle.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Cc: xuanzhuo@linux.alibaba.com, mst@redhat.com, linux-kernel@vger.kernel.org,
 virtualization@lists.linux-foundation.org,
 Eugenio Perez Martin <eperezma@redhat.com>
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

T24gV2VkLCBPY3QgMTgsIDIwMjMgYXQgNDo0OeKAr1BNIFNpLVdlaSBMaXUgPHNpLXdlaS5saXVA
b3JhY2xlLmNvbT4gd3JvdGU6Cj4KPgo+Cj4gT24gMTAvMTgvMjAyMyAxMjowMCBBTSwgSmFzb24g
V2FuZyB3cm90ZToKPiA+PiBVbmZvcnR1bmF0ZWx5LCBpdCdzIGEgbXVzdCB0byBzdGljayB0byBB
QkkuIEkgYWdyZWUgaXQncyBhIG1lc3MgYnV0IHdlCj4gPj4gZG9uJ3QgaGF2ZSBhIGJldHRlciBj
aG9pY2UuIE9yIHdlIGNhbiBmYWlsIHRoZSBwcm9iZSBpZiB1c2Vyc3BhY2UKPiA+PiBkb2Vzbid0
IGFjayB0aGlzIGZlYXR1cmUuCj4gPiBBbnRvaGVyIGlkZWEgd2UgY2FuIGp1c3QgZG8gdGhlIGZv
bGxvd2luZyBpbiB2aG9zdF92ZHBhIHJlc2V0Pwo+ID4KPiA+IGNvbmZpZy0+cmVzZXQoKQo+ID4g
aWYgKElPVExCX1BFUlNJU1QgaXMgbm90IHNldCkgewo+ID4gICAgICBjb25maWctPnJlc2V0X21h
cCgpCj4gPiB9Cj4gPgo+ID4gVGhlbiB3ZSBkb24ndCBoYXZlIHRoZSBidXJkZW4gdG8gbWFpbnRh
aW4gdGhlbSBpbiB0aGUgcGFyZW50Pwo+ID4KPiA+IFRoYW5rcwo+IFBsZWFzZSBzZWUgbXkgZWFy
bGllciByZXNwb25zZSBpbiB0aGUgb3RoZXIgZW1haWwsIHRoYW5rcy4KPgo+IC0tLS0tLS0tLS0t
LS0tLS0lPC0tLS0tLS0tLS0tLS0tLS0lPC0tLS0tLS0tLS0tLS0tLS0KPgo+IEZpcnN0LCB0aGUg
aWRlYWwgZml4IHdvdWxkIGJlIHRvIGxlYXZlIHRoaXMgcmVzZXRfdmVuZG9yX21hcHBpbmdzKCkK
PiBlbXVsYXRpb24gY29kZSBvbiB0aGUgaW5kaXZpZHVhbCBkcml2ZXIgaXRzZWxmLCB3aGljaCBh
bHJlYWR5IGhhcyB0aGUKPiBicm9rZW4gYmVoYXZpb3IuCgpTbyB0aGUgcG9pbnQgaXMsIG5vdCBh
Ym91dCB3aGV0aGVyIHRoZSBleGlzdGluZyBiZWhhdmlvciBpcyAiYnJva2VuIgpvciBub3QuIEl0
J3MgYWJvdXQgd2hldGhlciB3ZSBjb3VsZCBzdGljayB0byB0aGUgb2xkIGJlaGF2aW91ciB3aXRo
b3V0CnRvbyBtdWNoIGNvc3QuIEFuZCBJIGJlbGlldmUgd2UgY291bGQuCgpBbmQganVzdCB0byBj
bGFyaWZ5IGhlcmUsIHJlc2V0X3ZlbmRvcl9tYXBwaW5ncygpID0gY29uZmlnLT5yZXNldF9tYXAo
KQoKPiBCdXQgdG9kYXkgdGhlcmUncyBubyBiYWNrZW5kIGZlYXR1cmUgbmVnb3RpYXRpb24KPiBi
ZXR3ZWVuIHZob3N0LXZkcGEgYW5kIHRoZSBwYXJlbnQgZHJpdmVyLiBEbyB3ZSB3YW50IHRvIHNl
bmQgZG93biB0aGUKPiBhY2tlZF9iYWNrZW5kX2ZlYXR1cmVzIHRvIHBhcmVudCBkcml2ZXJzPwoK
VGhlcmUncyBubyBuZWVkIHRvIGRvIHRoYXQgd2l0aCB0aGUgYWJvdmUgY29kZSwgb3IgYW55dGhp
bmcgSSBtaXNzZWQgaGVyZT8KCmNvbmZpZy0+cmVzZXQoKQppZiAoSU9UTEJfUEVSU0lTVCBpcyBu
b3Qgc2V0KSB7CiAgICAgIGNvbmZpZy0+cmVzZXRfbWFwKCkKfQoKPgo+IFNlY29uZCwgSU9UTEJf
UEVSU0lTVCBpcyBuZWVkZWQgYnV0IG5vdCBzdWZmaWNpZW50LiBEdWUgdG8gbGFjayBvZgo+IGJh
Y2tlbmQgZmVhdHVyZSBuZWdvdGlhdGlvbiBpbiBwYXJlbnQgZHJpdmVyLCBpZiB2aG9zdC12ZHBh
IGhhcyB0bwo+IHByb3ZpZGUgdGhlIG9sZC1iZWhhdmlvdXIgZW11bGF0aW9uIGZvciBjb21wYXRp
YmlsaXR5IG9uIGRyaXZlcidzCj4gYmVoYWxmLCBpdCBuZWVkcyB0byBiZSBkb25lIHBlci1kcml2
ZXIgYmFzaXMuIFRoZXJlIGNvdWxkIGJlIGdvb2QKPiBvbi1jaGlwIG9yIHZlbmRvciBJT01NVSBp
bXBsZW1lbnRhdGlvbiB3aGljaCBkb2Vzbid0IGNsZWFyIHRoZSBJT1RMQiBpbgo+IC5yZXNldCwg
YW5kIHZlbmRvciBzcGVjaWZpYyBJT01NVSBkb2Vzbid0IGhhdmUgdG8gcHJvdmlkZSAucmVzZXRf
bWFwLAoKVGhlbiB3ZSBqdXN0IGRvbid0IG9mZmVyIElPVExCX1BSRVNJU1QsIGlzbid0IHRoaXMg
YnkgZGVzaWduPwoKPiB3ZQo+IHNob3VsZCBhbGxvdyB0aGVzZSBnb29kIGRyaXZlciBpbXBsZW1l
bnRhdGlvbnMgcmF0aGVyIHRoYW4KPiB1bmNvbmRpdGlvbmFsbHkgc3RpY2sgdG8gc29tZSBzcGVj
aWZpYyBwcm9ibGVtYXRpYyBiZWhhdmlvciBmb3IgZXZlcnkKPiBvdGhlciBnb29kIGRyaXZlci4K
ClRoZW4geW91IGNhbiBmb3JjZSByZXNldF9tYXAoKSB3aXRoIHNldF9tYXAoKSB0aGF0IGlzIHdo
YXQgSSBzdWdnZXN0CmluIGFub3RoZXIgdGhyZWFkLCBubz8KCj4gVGhlbiB3ZSBuZWVkIGEgc2V0
IG9mIGRldmljZSBmbGFncyAoYmFja2VuZF9mZWF0dXJlcwo+IGJpdCBhZ2Fpbj8pIHRvIGluZGlj
YXRlIHRoZSBzcGVjaWZpYyBkcml2ZXIgbmVlZHMgdXBwZXIgbGF5ZXIncyBoZWxwIG9uCj4gb2xk
LWJlaGF2aW91ciBlbXVsYXRpb24uCj4KPiBMYXN0IGJ1dCBub3QgbGVhc3QsIEknbSBub3Qgc3Vy
ZSBob3cgdG8gcHJvcGVybHkgZW11bGF0ZQo+IHJlc2V0X3ZlbmRvcl9tYXBwaW5ncygpIGZyb20g
dmhvc3QtdmRwYSBsYXllci4gSWYgYSB2ZW5kb3IgZHJpdmVyIGhhcyBubwo+IC5yZXNldF9tYXAg
b3AgaW1wbGVtZW50ZWQsIG9yIGlmIC5yZXNldF9tYXAgaGFzIGEgc2xpZ2h0bHkgZGlmZmVyZW50
Cj4gaW1wbGVtZW50YXRpb24gdGhhbiB3aGF0IGl0IHVzZWQgdG8gcmVzZXQgdGhlIGlvdGxiIGlu
IHRoZSAucmVzZXQgb3AsCgpTZWUgYWJvdmUsIGZvciByZXNldF92ZW5kb3JfbWFwcGluZ3MoKSBJ
IG1lYW50IGNvbmZpZy0+cmVzZXRfbWFwKCkgZXhhY3RseS4KClRoYW5rcwoKPiB0aGVuIHRoaXMg
ZWl0aGVyIGJlY29tZXMgZWZmZWN0aXZlbHkgZGVhZCBjb2RlIGlmIG5vIG9uZSBlbmRzIHVwIHVz
aW5nLAo+IG9yIHRoZSB2aG9zdC12ZHBhIGVtdWxhdGlvbiBpcyBoZWxwbGVzcyBhbmQgbGltaXRl
ZCBpbiBzY29wZSwgdW5hYmxlIHRvCj4gY292ZXIgYWxsIHRoZSBjYXNlcy4KPgo+IC0tLS0tLS0t
LS0tLS0tLS0lPC0tLS0tLS0tLS0tLS0tLS0lPC0tLS0tLS0tLS0tLS0tLS0KPgoKX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18KVmlydHVhbGl6YXRpb24gbWFp
bGluZyBsaXN0ClZpcnR1YWxpemF0aW9uQGxpc3RzLmxpbnV4LWZvdW5kYXRpb24ub3JnCmh0dHBz
Oi8vbGlzdHMubGludXhmb3VuZGF0aW9uLm9yZy9tYWlsbWFuL2xpc3RpbmZvL3ZpcnR1YWxpemF0
aW9u
