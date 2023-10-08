Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 326FFE95A8E
	for <virtualization@archiver.kernel.org>; Sun,  8 Oct 2023 04:25:33 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 5CBC941904;
	Sun,  8 Oct 2023 04:25:32 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org 5CBC941904
Authentication-Results: smtp4.osuosl.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=QtbY/H+6
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
	by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id KuRUOSN8Iwtq; Sun,  8 Oct 2023 04:25:31 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp4.osuosl.org (Postfix) with ESMTPS id 4E6A2418FA;
	Sun,  8 Oct 2023 04:25:30 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org 4E6A2418FA
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 21A4FC0071;
	Sun,  8 Oct 2023 04:25:30 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [IPv6:2605:bc80:3010::136])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 8012CC0032
 for <virtualization@lists.linux-foundation.org>;
 Sun,  8 Oct 2023 04:25:29 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id 4D67160FCA
 for <virtualization@lists.linux-foundation.org>;
 Sun,  8 Oct 2023 04:25:29 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 4D67160FCA
Authentication-Results: smtp3.osuosl.org;
 dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com
 header.a=rsa-sha256 header.s=mimecast20190719 header.b=QtbY/H+6
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id lEy5uzi8GySr
 for <virtualization@lists.linux-foundation.org>;
 Sun,  8 Oct 2023 04:25:28 +0000 (UTC)
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.129.124])
 by smtp3.osuosl.org (Postfix) with ESMTPS id 621226101C
 for <virtualization@lists.linux-foundation.org>;
 Sun,  8 Oct 2023 04:25:28 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 621226101C
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1696739127;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=YgXIUrST4qjfww2McuDOJwKPPpWN2yjtSeM4PuxFqTo=;
 b=QtbY/H+6ajcAJFXUGNJzsL1Q9AhVXRS7uu6rNuhQembwJl/KMblp7gnPipJmr5JJarxTSV
 y51Yi7JED90QAheT7TdvaQe6vWoeTQLBVOT+rQCkjMwX/QSV1NWl9ekj4Uy0TwshuCJbzn
 EChDVRCx8jNyJ1XLrFAGsT1ZYie3s1A=
Received: from mail-lf1-f69.google.com (mail-lf1-f69.google.com
 [209.85.167.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-605-gZyxZ4SlOUa-izsqyoS1ow-1; Sun, 08 Oct 2023 00:25:25 -0400
X-MC-Unique: gZyxZ4SlOUa-izsqyoS1ow-1
Received: by mail-lf1-f69.google.com with SMTP id
 2adb3069b0e04-50433324cf3so3046702e87.3
 for <virtualization@lists.linux-foundation.org>;
 Sat, 07 Oct 2023 21:25:25 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1696739124; x=1697343924;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=YgXIUrST4qjfww2McuDOJwKPPpWN2yjtSeM4PuxFqTo=;
 b=sUIQTjAu1U43nf8NSIMmIMOlOxOJ9zKruCQ3ewHnYL54WZQmXeanGEO8rwVRsZO83n
 vNAPBxPnHI5GqUb8NN5HRRZqigUaxfjzuMPq2OaIR1nCWP9tlXf25L7ASG/X/XB86lbL
 zGPqL2mNqAgtw5jdfoYIZFb7PMjJxctCLDIVs/Zd7BHX1YJ3ul58MbtRf5qQv4MLwqgg
 lVdQUXDKAyu9Bm+YDnG0VD9z9oinGiFnD1lK72Aa6+3aYNnXxjLNo4BNZ48niwytyruC
 jkKvMdwzJRYOkpbBRSpnezS6z6lfcgDj5Zzyjcu2YSKPOzksST/JcXJ0XOj6nWAYs/1y
 dK/Q==
X-Gm-Message-State: AOJu0YzmvFqJMsR8rT+7qFCHHBEwubAnC5w2edsTqpnYZcqSEbRoighQ
 bluoyn4GNJg5Xj34a9o/8xtBjS4Q9Bdg9WhhjW2GMDM1iaAJDBTZF3dPrOu97PCWEAu7krMnjRd
 b/eOwS7OElK5BSOsyC5vcoqXm9OVWcfb9JlfRoJh+dOEaSJFKKrazuf83UA==
X-Received: by 2002:a05:6512:3095:b0:503:2a53:7480 with SMTP id
 z21-20020a056512309500b005032a537480mr12004276lfd.49.1696739124095; 
 Sat, 07 Oct 2023 21:25:24 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEeWdUfFWd8qTGjAfwBOTZvnBRjqA4ufN1Zw9UrNaoUwkzNiy7HyX2jFaKj/vdxr6LcsgEtXpqXrOacIWb/aS0=
X-Received: by 2002:a05:6512:3095:b0:503:2a53:7480 with SMTP id
 z21-20020a056512309500b005032a537480mr12004263lfd.49.1696739123775; Sat, 07
 Oct 2023 21:25:23 -0700 (PDT)
MIME-Version: 1.0
References: <20230912130132.561193-1-dtatulea@nvidia.com>
 <20230912130132.561193-10-dtatulea@nvidia.com>
 <CACGkMEsC_rgnKyG3stFbc-Mz2yiKGwNUYYqG64jQbNpZBtnVvg@mail.gmail.com>
 <c42db8942523afe8bbf54815f672acd9e47cfa67.camel@nvidia.com>
In-Reply-To: <c42db8942523afe8bbf54815f672acd9e47cfa67.camel@nvidia.com>
From: Jason Wang <jasowang@redhat.com>
Date: Sun, 8 Oct 2023 12:25:12 +0800
Message-ID: <CACGkMEvZESDuOiX_oOvMUh0YqCWYqvmD3Ve9YEJW3+RXXyvGew@mail.gmail.com>
Subject: Re: [PATCH 09/16] vdpa/mlx5: Allow creation/deletion of any given mr
 struct
To: Dragos Tatulea <dtatulea@nvidia.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Cc: "xuanzhuo@linux.alibaba.com" <xuanzhuo@linux.alibaba.com>,
 "kvm@vger.kernel.org" <kvm@vger.kernel.org>, "mst@redhat.com" <mst@redhat.com>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
 "virtualization@lists.linux-foundation.org"
 <virtualization@lists.linux-foundation.org>,
 "eperezma@redhat.com" <eperezma@redhat.com>,
 Saeed Mahameed <saeedm@nvidia.com>
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

T24gVHVlLCBTZXAgMjYsIDIwMjMgYXQgMzoyMeKAr1BNIERyYWdvcyBUYXR1bGVhIDxkdGF0dWxl
YUBudmlkaWEuY29tPiB3cm90ZToKPgo+IE9uIFR1ZSwgMjAyMy0wOS0yNiBhdCAxMjo0NCArMDgw
MCwgSmFzb24gV2FuZyB3cm90ZToKPiA+IE9uIFR1ZSwgU2VwIDEyLCAyMDIzIGF0IDk6MDLigK9Q
TSBEcmFnb3MgVGF0dWxlYSA8ZHRhdHVsZWFAbnZpZGlhLmNvbT4gd3JvdGU6Cj4gPiA+Cj4gPiA+
IFRoaXMgcGF0Y2ggYWRhcHRzIHRoZSBtciBjcmVhdGlvbi9kZWxldGlvbiBjb2RlIHRvIGJlIGFi
bGUgdG8gd29yayB3aXRoCj4gPiA+IGFueSBnaXZlbiBtciBzdHJ1Y3QgcG9pbnRlci4gQWxsIHRo
ZSBBUElzIGFyZSBhZGFwdGVkIHRvIHRha2UgYW4gZXh0cmEKPiA+ID4gcGFyYW1ldGVyIGZvciB0
aGUgbXIuCj4gPiA+Cj4gPiA+IG1seDVfdmRwYV9jcmVhdGUvZGVsZXRlX21yIGRvZXNuJ3QgbmVl
ZCBhIEFTSUQgcGFyYW1ldGVyIGFueW1vcmUuIFRoZQo+ID4gPiBjaGVjayBpcyBkb25lIGluIHRo
ZSBjYWxsZXIgaW5zdGVhZCAobWx4NV9zZXRfbWFwKS4KPiA+ID4KPiA+ID4gVGhpcyBjaGFuZ2Ug
aXMgbmVlZGVkIGZvciBhIGZvbGxvd3VwIHBhdGNoIHdoaWNoIHdpbGwgaW50cm9kdWNlIGFuCj4g
PiA+IGFkZGl0aW9uYWwgbXIgZm9yIHRoZSB2cSBkZXNjcmlwdG9yIGRhdGEuCj4gPiA+Cj4gPiA+
IFNpZ25lZC1vZmYtYnk6IERyYWdvcyBUYXR1bGVhIDxkdGF0dWxlYUBudmlkaWEuY29tPgo+ID4g
PiAtLS0KPiA+Cj4gPiBUaGlua2luZyBvZiB0aGlzIGRlY291cGxpbmcgSSB0aGluayBJIGhhdmUg
YSBxdWVzdGlvbi4KPiA+Cj4gPiBXZSBhZHZlcnRpc2UgMiBhZGRyZXNzIHNwYWNlcyBhbmQgMiBn
cm91cHMuIFNvIHdlIGFjdHVhbGx5IGRvbid0IGtub3cKPiA+IGZvciBleGFtcGxlIHdoaWNoIGFk
ZHJlc3Mgc3BhY2VzIHdpbGwgYmUgdXNlZCBieSBkdnEuCj4gPgo+ID4gQW5kIGFjdHVhbGx5IHdl
IGFsbG93IHRoZSB1c2VyIHNwYWNlIHRvIGRvIHNvbWV0aGluZyBsaWtlCj4gPgo+ID4gc2V0X2dy
b3VwX2FzaWQoZHZxX2dyb3VwLCAwKQo+ID4gc2V0X21hcCgwKQo+ID4gc2V0X2dyb3VwX2FzaWQo
ZHZxX2dyb3VwLCAxKQo+ID4gc2V0X21hcCgxKQo+ID4KPiA+IEkgd29uZGVyIGlmIHRoZSBkZWNv
dXBsaW5nIGxpa2UgdGhpcyBwYXRjaCBjYW4gd29yayBhbmQgd2h5Lgo+ID4KPiBUaGlzIHNjZW5h
cmlvIGNvdWxkIGluZGVlZCB3b3JrLiBFc3BlY2lhbGx5IGlmIHlvdSBsb29rIGF0IHRoZSAxMyd0
aCBwYXRjaCBbMF0KPiB3aGVyZSBodyBzdXBwb3J0IGlzIGFkZGVkLiBBcmUgeW91IHdvbmRlcmlu
ZyBpZiB0aGlzIHNob3VsZCB3b3JrIGF0IGFsbCBvciBpZiBpdAo+IHNob3VsZCBiZSBibG9ja2Vk
PwoKSXQgd291bGQgYmUgZ3JlYXQgaWYgaXQgY2FuIHdvcmsgd2l0aCB0aGUgZm9sbG93aW5nIHBh
dGNoZXMuIEJ1dCBhdApsZWFzdCBmb3IgdGhpcyBwYXRjaCwgaXQgc2VlbXMgbm90OgoKRm9yIGV4
YW1wbGUsIHdoYXQgaGFwcGVucyBpZiB3ZSBzd2l0Y2ggYmFjayB0byBncm91cCAwIGZvciBkdnE/
CgpzZXRfZ3JvdXBfYXNpZChkdnFfZ3JvdXAsIDApCnNldF9tYXAoMCkKc2V0X2dyb3VwX2FzaWQo
ZHZxX2dyb3VwLCAxKQpzZXRfbWFwKDEpCi8vIGhlcmUgd2UgZGVzdHJveSB0aGUgbXIgY3JlYXRl
ZCBmb3IgYXNpZCAwCnNldF9ncm91cF9hc2lkKGR2cV9ncm91cCwgMCkKCkJ0dywgaWYgdGhpcyBp
cyBhIG5ldyBpc3N1ZSwgSSBoYXZlbid0IGNoZWNrZWQgd2hldGhlciBvciBub3QgaXQKZXhpc3Rz
IGJlZm9yZSB0aGlzIHNlcmllcyAoaWYgeWVzLCB3ZSBjYW4gZml4IG9uIHRvcCkuCgo+Cj4gPiBJ
dCBsb29rcyB0byBtZSB0aGUgbW9zdCBlYXN5IHdheSBpcyB0byBsZXQgZWFjaCBBUyBiZSBiYWNr
ZWQgYnkgYW4gTVIuCj4gPiBUaGVuIHdlIGRvbid0IGV2ZW4gbmVlZCB0byBjYXJlIGFib3V0IHRo
ZSBkdnEsIGN2cS4KPiBUaGF0J3Mgd2hhdCB0aGlzIHBhdGNoIHNlcmllcyBkb3dlcy4KCkdvb2Qg
dG8ga25vdyB0aGlzLCBJIHdpbGwgcmV2aWV3IHRoZSBzZXJpZXMuCgpUaGFua3MKCj4KPiBUaGFu
a3MsCj4gRHJhZ29zCj4KPiBbMF1odHRwczovL2xvcmUua2VybmVsLm9yZy92aXJ0dWFsaXphdGlv
bi8yMDIzMDkxMjEzMDEzMi41NjExOTMtMTQtZHRhdHVsZWFAbnZpZGlhLmNvbS9ULyN1CgpfX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fXwpWaXJ0dWFsaXphdGlv
biBtYWlsaW5nIGxpc3QKVmlydHVhbGl6YXRpb25AbGlzdHMubGludXgtZm91bmRhdGlvbi5vcmcK
aHR0cHM6Ly9saXN0cy5saW51eGZvdW5kYXRpb24ub3JnL21haWxtYW4vbGlzdGluZm8vdmlydHVh
bGl6YXRpb24=
