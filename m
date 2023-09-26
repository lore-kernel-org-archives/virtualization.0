Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A073BE81813
	for <virtualization@archiver.kernel.org>; Tue, 26 Sep 2023 02:47:18 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 14FEF61208;
	Tue, 26 Sep 2023 02:47:18 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 14FEF61208
Authentication-Results: smtp3.osuosl.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=HznCwDUX
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
	by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id zFkfKTKrGL5L; Tue, 26 Sep 2023 02:47:17 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp3.osuosl.org (Postfix) with ESMTPS id 88C6D60BEA;
	Tue, 26 Sep 2023 02:47:16 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 88C6D60BEA
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 698A1C0071;
	Tue, 26 Sep 2023 02:47:16 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [IPv6:2605:bc80:3010::137])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 8B869C0032
 for <virtualization@lists.linux-foundation.org>;
 Tue, 26 Sep 2023 02:47:15 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id 63FE64190F
 for <virtualization@lists.linux-foundation.org>;
 Tue, 26 Sep 2023 02:47:15 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org 63FE64190F
Authentication-Results: smtp4.osuosl.org;
 dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com
 header.a=rsa-sha256 header.s=mimecast20190719 header.b=HznCwDUX
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id p4ik9h_ChsCk
 for <virtualization@lists.linux-foundation.org>;
 Tue, 26 Sep 2023 02:47:14 +0000 (UTC)
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.129.124])
 by smtp4.osuosl.org (Postfix) with ESMTPS id 073F1418F9
 for <virtualization@lists.linux-foundation.org>;
 Tue, 26 Sep 2023 02:47:13 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org 073F1418F9
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1695696432;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=PbkEy7nXr1l5VA1EBNnZyo/vTZ0cPvoDisYtJVR0B78=;
 b=HznCwDUXPKeM6/BiOTfTOn64ohKQXB+Y9JYcWx9zWTK/2KB05PY0Zrph0k7Bcl1bOoguW8
 GoQhiRGwZo3j9xO/TCkTMrF2D5Tl5qjGLarmeQ4FeQ6/HDcPHRCeQdX5IsQl703CNnwJgU
 EsWGiyva3o9z+DVdY7tqvAOZ6S7e5VE=
Received: from mail-lf1-f71.google.com (mail-lf1-f71.google.com
 [209.85.167.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-655-XR8br9e8PYWLpbtx-A4fCQ-1; Mon, 25 Sep 2023 22:47:08 -0400
X-MC-Unique: XR8br9e8PYWLpbtx-A4fCQ-1
Received: by mail-lf1-f71.google.com with SMTP id
 2adb3069b0e04-50433ca6d81so9595559e87.3
 for <virtualization@lists.linux-foundation.org>;
 Mon, 25 Sep 2023 19:47:07 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1695696425; x=1696301225;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=PbkEy7nXr1l5VA1EBNnZyo/vTZ0cPvoDisYtJVR0B78=;
 b=lXRIVHZSK9kyFbS5zN/RR9u35FBbKAUAiXNx4k5MDFb3ZXYQVXO4OPoDXpaVy0SXkH
 RTTYt2lrWTuOIPBr++HqFKlrxMm4Tmk5ZFV7unId/Nqpn9GqLMSfPOFyDxbbiissKaaM
 HRNVVPPkHrWSwrfJ7wjmcJdEZ3ksEO7a/EifFBzlLwAuzVWkOiKfvgJQOZBKJqQqSspx
 TXYxMvHbl95il2JkW2gMTte1gIcWMOBOcbfSfR0ONwW8QU26SA/P0SUjyZKe+16DSI33
 YFvbNgnob0vwusELDPQ466bow7QhzrGonh20s+F0dFoBxfeSKIf5Qb79TKs6zwSyiMgO
 m4YQ==
X-Gm-Message-State: AOJu0YxheTUn+gQJ5xbYPB4LgpUOErIeObFr0jeL/+HEv441NQFpGp8C
 XMCklHxACDCVrdGYPwZolexE1SuATiSoN7aSZsz7AdpiRzIGurfl2riSZoSZKKsrGg9mAXuFmZy
 zxxik69+lcbQqLBSTgS32k7C92qP1I+agjr60FMk/e+XzJJ0BB2ViH5+uvw==
X-Received: by 2002:a05:6512:3daa:b0:503:1adf:b4d5 with SMTP id
 k42-20020a0565123daa00b005031adfb4d5mr8558590lfv.52.1695696425636; 
 Mon, 25 Sep 2023 19:47:05 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHCEVaBqO/+URj99AR2MxQjceBS7mj2Mlw1O/b53LZJbHeEMTYn3ctrlVFyFihUW9jZ0zcY9enbbfrCL1KLUJg=
X-Received: by 2002:a05:6512:3daa:b0:503:1adf:b4d5 with SMTP id
 k42-20020a0565123daa00b005031adfb4d5mr8558574lfv.52.1695696425334; Mon, 25
 Sep 2023 19:47:05 -0700 (PDT)
MIME-Version: 1.0
References: <20230923170540.1447301-1-lulu@redhat.com>
In-Reply-To: <20230923170540.1447301-1-lulu@redhat.com>
From: Jason Wang <jasowang@redhat.com>
Date: Tue, 26 Sep 2023 10:46:54 +0800
Message-ID: <CACGkMEvx5V8+-LZa8-G4VCXYiJVm0DL8pu_Ao0rvPtK48-FTDQ@mail.gmail.com>
Subject: Re: [RFC 0/7] vdpa: Add support for iommufd
To: Cindy Lu <lulu@redhat.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Cc: yi.l.liu@intel.com, mst@redhat.com, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org, virtualization@lists.linux-foundation.org,
 jgg@nvidia.com
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

T24gU3VuLCBTZXAgMjQsIDIwMjMgYXQgMTowNeKAr0FNIENpbmR5IEx1IDxsdWx1QHJlZGhhdC5j
b20+IHdyb3RlOgo+Cj4gSGkgQWxsCj4gUmVhbGx5IGFwb2xvZ2l6ZSBmb3IgdGhlIGRlbGF5LCB0
aGlzIGlzIHRoZSBkcmFmdCBSRkMgZm9yCj4gaW9tbXVmZCBzdXBwb3J0IGZvciB2ZHBhLCBUaGlz
IGNvZGUgcHJvdmlkZXMgdGhlIGJhc2ljIGZ1bmN0aW9uCj4gZm9yIGlvbW11ZmQgc3VwcG9ydAo+
Cj4gVGhlIGNvZGUgd2FzIHRlc3RlZCBhbmQgcGFzc2VkIGluIGRldmljZSB2ZHBhX3NpbV9uZXQK
PiBUaGUgcWVtdSBjb2RlIGlzCj4gaHR0cHM6Ly9naXRsYWIuY29tL2x1bHU2L2dpdGxhYnFlbXV0
bXAvLS90cmVlL2lvbW11ZmRSRkMKPiBUaGUga2VybmVsIGNvZGUgaXMKPiBodHRwczovL2dpdGxh
Yi5jb20vbHVsdTYvdmhvc3QvLS90cmVlL2lvbW11ZmRSRkMKPgo+IFRvRG8KPiAxLiB0aGlzIGNv
ZGUgaXMgb3V0IG9mIGRhdGUgYW5kIG5lZWRzIHRvIGNsZWFuIGFuZCByZWJhc2Ugb24gdGhlIGxh
dGVzdCBjb2RlCj4gMi4gdGhpcyBjb2RlIGhhcyBzb21lIHdvcmthcm91bmQsIEkgU2tpcCB0aGUg
Y2hlY2sgZm9yCj4gaW9tbXVfZ3JvdXAgYW5kIENBQ0hFX0NPSEVSRU5DWSwgYWxzbyBzb21lIG1p
c2MgaXNzdWVzIGxpa2UgbmVlZCB0byBhZGQKPiBtdXRleCBmb3IgaW9tbWZkIG9wZXJhdGlvbnMK
PiAzLiBvbmx5IHRlc3QgaW4gZW11bGF0ZWQgZGV2aWNlLCBvdGhlciBtb2RlcyBub3QgdGVzdGVk
IHlldAo+Cj4gQWZ0ZXIgYWRkcmVzc2VkIHRoZXNlIHByb2JsZW1zIEkgd2lsbCBzZW5kIG91dCBh
IG5ldyB2ZXJzaW9uIGZvciBSRkMuIEkgd2lsbAo+IHByb3ZpZGUgdGhlIGNvZGUgaW4gMyB3ZWVr
cwoKU29tZXRoaW5nIG1vcmUgbmVlZHMgdG8gYmUgZG9uZSBhZnRlciBhIHF1aWNrIGdsYW5jZSBh
dCB0aGUgY29kZXMuCgoxKSBUaGUgc3VwcG9ydCBmb3IgZGV2aWNlIHdpdGggcGxhdGZvcm0gSU9N
TVUgc3VwcG9ydAoyKSBUaGUgc3VwcG9ydCBmb3IgbXVsdGlwbGUgQVNlcyBwZXIgZGV2aWNlCgou
Li4KClRoYW5rcwoKPgo+IFRoYW5rcwo+IENpbmR5Cj4gU2lnbmVkLW9mZi1ieTogQ2luZHkgTHUg
PGx1bHVAcmVkaGF0LmNvbT4KPiBUaGUgdGVzdCBzdGVwIGlzCj4gMS4gY3JlYXRlIHZkcGFfc2lt
IGRldmljZQo+IC4uLgo+IHZkcGEgZGV2IGFkZCBuYW1lIHZkcGExNSBtZ210ZGV2IHZkcGFzaW1f
bmV0Cj4gLi4uCj4gMi4gbG9hZCB0aGUgVk0gd2l0aCB0aGUgY29tbWFuZAo+ICAgLW9iamVjdCBp
b21tdWZkLGlkPWlvbW11ZmQwIFwKPiAgIC1kZXZpY2UgdmlydGlvLW5ldC1wY2ksbmV0ZGV2PXZo
b3N0LXZkcGExLGRpc2FibGUtbGVnYWN5PW9uLGRpc2FibGUtbW9kZXJuPW9mZlwKPiAgIC1uZXRk
ZXYgdHlwZT12aG9zdC12ZHBhLHZob3N0ZGV2PS9kZXYvdmhvc3QtdmRwYS0wLGlkPXZob3N0LXZk
cGExLGlvbW11ZmQ9aW9tbXVmZDBcCj4KPiAzLiBpbiBndWVzdCBWTSB5b3UgY2FuIGZpbmQgdGhl
IHZkcGFfc2ltIHBvcnQgd29ya3Mgd2VsbC4KPiBbcm9vdEB1YnVudHVuZXcgfl0jIGlmY29uZmln
IGV0aDAKPiBldGgwOiBmbGFncz00MTYzPFVQLEJST0FEQ0FTVCxSVU5OSU5HLE1VTFRJQ0FTVD4g
IG10dSAxNTAwCj4gICAgICAgICBpbmV0NiBmZTgwOjo1MDU0OmZmOmZlMTI6MzQ1NiAgcHJlZml4
bGVuIDY0ICBzY29wZWlkIDB4MjA8bGluaz4KPiAgICAgICAgIGV0aGVyIDUyOjU0OjAwOjEyOjM0
OjU2ICB0eHF1ZXVlbGVuIDEwMDAgIChFdGhlcm5ldCkKPiAgICAgICAgIFJYIHBhY2tldHMgNTMg
IGJ5dGVzIDkxMDggKDguOCBLaUIpCj4gICAgICAgICBSWCBlcnJvcnMgMCAgZHJvcHBlZCAwICBv
dmVycnVucyAwICBmcmFtZSAwCj4gICAgICAgICBUWCBwYWNrZXRzIDUzICBieXRlcyA5MTA4ICg4
LjggS2lCKQo+ICAgICAgICAgVFggZXJyb3JzIDAgIGRyb3BwZWQgMCBvdmVycnVucyAwICBjYXJy
aWVyIDAgIGNvbGxpc2lvbnMgMAo+Cj4gW3Jvb3RAdWJ1bnR1bmV3IH5dIyAuL3Rlc3Quc2ggZXRo
MAo+IFsgIDE3Mi44MTUyNzldIHBrdGdlbjogUGFja2V0IEdlbmVyYXRvciBmb3IgcGFja2V0IHBl
cmZvcm1hbmNlIHRlc3RpbmcuIFZlcnNpb246IDIuNzUKPiBBZGRpbmcgcXVldWUgMCBvZiBldGgw
Cj4gQ29uZmlndXJpbmcgZGV2aWNlcyBldGgwQDAKPiBSdW5uaW5nLi4uIGN0cmxeQyB0byBzdG9w
Cj4KPiBbcm9vdEB1YnVudHVuZXcgfl0jIGlmY29uZmlnIGV0aDAKPiBldGgwOiBmbGFncz00MTYz
PFVQLEJST0FEQ0FTVCxSVU5OSU5HLE1VTFRJQ0FTVD4gIG10dSAxNTAwCj4gICAgICAgICBpbmV0
NiBmZTgwOjo1MDU0OmZmOmZlMTI6MzQ1NiAgcHJlZml4bGVuIDY0ICBzY29wZWlkIDB4MjA8bGlu
az4KPiAgICAgICAgIGV0aGVyIDUyOjU0OjAwOjEyOjM0OjU2ICB0eHF1ZXVlbGVuIDEwMDAgIChF
dGhlcm5ldCkKPiAgICAgICAgIFJYIHBhY2tldHMgMTgzNDU1ICBieXRlcyAxMTc0ODUzMyAoMTEu
MiBNaUIpCj4gICAgICAgICBSWCBlcnJvcnMgMCAgZHJvcHBlZCAwICBvdmVycnVucyAwICBmcmFt
ZSAwCj4gICAgICAgICBUWCBwYWNrZXRzIDE4MzQ3MyAgYnl0ZXMgMTE3NDk2ODUgKDExLjIgTWlC
KQo+ICAgICAgICAgVFggZXJyb3JzIDAgIGRyb3BwZWQgMCBvdmVycnVucyAwICBjYXJyaWVyIDAg
IGNvbGxpc2lvbnMgMAo+Cj4gQ2luZHkgTHUgKDcpOgo+ICAgdmhvc3QvaW9tbXVmZDogQWRkIHRo
ZSBmdW5jdGlvbnMgc3VwcG9ydCBpb21tdWZkCj4gICBLY29uZmlnOiBBZGQgdGhlIG5ldyBmaWxl
IHZob3N0L2lvbW11ZmQKPiAgIHZob3N0OiBBZGQgMyBuZXcgdWFwaSB0byBzdXBwb3J0IGlvbW11
ZmQKPiAgIHZkcGE6IGNoYW5nZSB0aGUgbWFwL3VubWFwIHByb2Nlc3MgdG8gc3VwcG9ydCBpb21t
dWZkCj4gICB2ZHBhOiBBZGQgbmV3IHZkcGFfY29uZmlnX29wcwo+ICAgdmRwYV9zaW0gOkFkZCBz
dXBwb3J0IGZvciBpb21tdWZkCj4gICBpb21tdWZkOiBTa2lwIHRoZSBDQUNIRV9DT0hFUkVOQ1kg
YW5kIGlvbW11IGdyb3VwIGNoZWNrCj4KPiAgZHJpdmVycy9pb21tdS9pb21tdWZkL2RldmljZS5j
ICAgfCAgIDYgKy0KPiAgZHJpdmVycy92ZHBhL3ZkcGFfc2ltL3ZkcGFfc2ltLmMgfCAgIDggKysK
PiAgZHJpdmVycy92aG9zdC9LY29uZmlnICAgICAgICAgICAgfCAgIDEgKwo+ICBkcml2ZXJzL3Zo
b3N0L01ha2VmaWxlICAgICAgICAgICB8ICAgMSArCj4gIGRyaXZlcnMvdmhvc3QvaW9tbXVmZC5j
ICAgICAgICAgIHwgMTUxICsrKysrKysrKysrKysrKysrKysrKysrCj4gIGRyaXZlcnMvdmhvc3Qv
dmRwYS5jICAgICAgICAgICAgIHwgMjAxICsrKysrKysrKysrKysrKysrKysrKysrKysrKysrKysK
PiAgZHJpdmVycy92aG9zdC92aG9zdC5oICAgICAgICAgICAgfCAgMjEgKysrKwo+ICBpbmNsdWRl
L2xpbnV4L3ZkcGEuaCAgICAgICAgICAgICB8ICAzNCArKysrKy0KPiAgaW5jbHVkZS91YXBpL2xp
bnV4L3Zob3N0LmggICAgICAgfCAgNzEgKysrKysrKysrKysKPiAgOSBmaWxlcyBjaGFuZ2VkLCA0
OTAgaW5zZXJ0aW9ucygrKSwgNCBkZWxldGlvbnMoLSkKPiAgY3JlYXRlIG1vZGUgMTAwNjQ0IGRy
aXZlcnMvdmhvc3QvaW9tbXVmZC5jCj4KPiAtLQo+IDIuMzQuMwo+CgpfX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fXwpWaXJ0dWFsaXphdGlvbiBtYWlsaW5nIGxp
c3QKVmlydHVhbGl6YXRpb25AbGlzdHMubGludXgtZm91bmRhdGlvbi5vcmcKaHR0cHM6Ly9saXN0
cy5saW51eGZvdW5kYXRpb24ub3JnL21haWxtYW4vbGlzdGluZm8vdmlydHVhbGl6YXRpb24=
