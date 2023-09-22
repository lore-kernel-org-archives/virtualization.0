Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EF3B7E7D0C3
	for <virtualization@archiver.kernel.org>; Fri, 22 Sep 2023 03:01:43 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 61C2C60BDC;
	Fri, 22 Sep 2023 03:01:43 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 61C2C60BDC
Authentication-Results: smtp3.osuosl.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=CNE0mT1k
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
	by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id IrGUGRXB899Q; Fri, 22 Sep 2023 03:01:42 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp3.osuosl.org (Postfix) with ESMTPS id 93A5D6100B;
	Fri, 22 Sep 2023 03:01:41 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 93A5D6100B
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 63EA2C0071;
	Fri, 22 Sep 2023 03:01:41 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 73AADC0032
 for <virtualization@lists.linux-foundation.org>;
 Fri, 22 Sep 2023 03:01:40 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id 3A59D40278
 for <virtualization@lists.linux-foundation.org>;
 Fri, 22 Sep 2023 03:01:40 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org 3A59D40278
Authentication-Results: smtp2.osuosl.org;
 dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com
 header.a=rsa-sha256 header.s=mimecast20190719 header.b=CNE0mT1k
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id O6jPnb-_XkeJ
 for <virtualization@lists.linux-foundation.org>;
 Fri, 22 Sep 2023 03:01:39 +0000 (UTC)
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.133.124])
 by smtp2.osuosl.org (Postfix) with ESMTPS id 273CA40154
 for <virtualization@lists.linux-foundation.org>;
 Fri, 22 Sep 2023 03:01:38 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org 273CA40154
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1695351698;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=rew5kkS2gk0Kx6de5ikcwTNfnxislnRtj601jvpsqnA=;
 b=CNE0mT1kr9+EP4TbH9rPxwmkg2E6PkUjdt/oz88E8V1HaDdfakqTT0E8kRXxDTzjIBYQyw
 N43OSVBM2KqU0FCCJl8mg7aEhy0y+HWiLFZk1eRQQCgEPSYRepoUtjYt4DLwq0QkMw4NQC
 cA+CTexd238J1rgq/yHaoDrXprOsMXM=
Received: from mail-lf1-f71.google.com (mail-lf1-f71.google.com
 [209.85.167.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-288--f-VEW8yPk2eFHIvfVK2hg-1; Thu, 21 Sep 2023 23:01:36 -0400
X-MC-Unique: -f-VEW8yPk2eFHIvfVK2hg-1
Received: by mail-lf1-f71.google.com with SMTP id
 2adb3069b0e04-50431a28da1so1374001e87.3
 for <virtualization@lists.linux-foundation.org>;
 Thu, 21 Sep 2023 20:01:36 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1695351695; x=1695956495;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=rew5kkS2gk0Kx6de5ikcwTNfnxislnRtj601jvpsqnA=;
 b=FLsBjMVxLxh5TwyuzNsXSiTyzr6+2hF22ZvSmqr5d0YGxPch+oVKOexotOjOW0m9NF
 NliVchLtSaNOXMrd1ALakj2KMG84uUASijXbjG5v2GIXxSjiLvS0+kKgqQ/NV7SMRtrn
 fGTqxvEgmzLkZYbvzg7m7x2PY2QJ6b1QASzkx5vCZd1en0xFEcpW6m/91tGykw03g9PA
 JQUKiE0K+VbUTg3+ChSfI8/BliuoEoiMv3Xy76G6zzNeoRVoPzB8sg1aoRhTbT3sjw1U
 LcwKAkg1b2E2Pjzu+hn41G6TdZL5cisiuFsc4LtVxn/KAZkCMwNZFmCesDB9lN8hlQ17
 MM2g==
X-Gm-Message-State: AOJu0YzALkth2l48gc8ajLgi87AH5W2Oo+bvM/SqUCP8EIwlMXds2a1X
 KrZYRIekvJCddim8Bkogj9pEj/3J32JsxRzQ6WFdiVEc/xQhX/LfVf/h3OVrHPhvBQN12hvQQDF
 Xi2Kan199QqKUwAwtTBHmyFhyCPVGbKmifHbS4ifHM3d7IaoXDa1MiDiKtg==
X-Received: by 2002:a05:6512:3090:b0:501:ba04:f34b with SMTP id
 z16-20020a056512309000b00501ba04f34bmr7095488lfd.44.1695351694897; 
 Thu, 21 Sep 2023 20:01:34 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHyvZ5y9Tm2MtSv8GTK4mxYG5xXps1elO4+woLhmW0ZWQZ2GwsvhOqLLLs/lJEJ7dUOoRtymPTUuyJnZVDusEg=
X-Received: by 2002:a05:6512:3090:b0:501:ba04:f34b with SMTP id
 z16-20020a056512309000b00501ba04f34bmr7095472lfd.44.1695351694550; Thu, 21
 Sep 2023 20:01:34 -0700 (PDT)
MIME-Version: 1.0
References: <20230921124040.145386-1-yishaih@nvidia.com>
 <20230921124040.145386-12-yishaih@nvidia.com>
 <20230921090844-mutt-send-email-mst@kernel.org>
 <20230921141125.GM13733@nvidia.com>
 <20230921101509-mutt-send-email-mst@kernel.org>
 <20230921164139.GP13733@nvidia.com>
 <20230921124331-mutt-send-email-mst@kernel.org>
 <20230921183926.GV13733@nvidia.com>
 <20230921150448-mutt-send-email-mst@kernel.org>
 <20230921194946.GX13733@nvidia.com>
In-Reply-To: <20230921194946.GX13733@nvidia.com>
From: Jason Wang <jasowang@redhat.com>
Date: Fri, 22 Sep 2023 11:01:23 +0800
Message-ID: <CACGkMEvMP05yTNGE5dBA2-M0qX-GXFcdGho7_T5NR6kAEq9FNg@mail.gmail.com>
Subject: Re: [PATCH vfio 11/11] vfio/virtio: Introduce a vfio driver over
 virtio devices
To: Jason Gunthorpe <jgg@nvidia.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Cc: kvm@vger.kernel.org, "Michael S. Tsirkin" <mst@redhat.com>,
 maorg@nvidia.com, virtualization@lists.linux-foundation.org, jiri@nvidia.com,
 leonro@nvidia.com
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

T24gRnJpLCBTZXAgMjIsIDIwMjMgYXQgMzo0OeKAr0FNIEphc29uIEd1bnRob3JwZSA8amdnQG52
aWRpYS5jb20+IHdyb3RlOgo+Cj4gT24gVGh1LCBTZXAgMjEsIDIwMjMgYXQgMDM6MTM6MTBQTSAt
MDQwMCwgTWljaGFlbCBTLiBUc2lya2luIHdyb3RlOgo+ID4gT24gVGh1LCBTZXAgMjEsIDIwMjMg
YXQgMDM6Mzk6MjZQTSAtMDMwMCwgSmFzb24gR3VudGhvcnBlIHdyb3RlOgo+ID4gPiBPbiBUaHUs
IFNlcCAyMSwgMjAyMyBhdCAxMjo1MzowNFBNIC0wNDAwLCBNaWNoYWVsIFMuIFRzaXJraW4gd3Jv
dGU6Cj4gPiA+ID4gPiB2ZHBhIGlzIG5vdCB2ZmlvLCBJIGRvbid0IGtub3cgaG93IHlvdSBjYW4g
c3VnZ2VzdCB2ZHBhIGlzIGEKPiA+ID4gPiA+IHJlcGxhY2VtZW50IGZvciBhIHZmaW8gZHJpdmVy
LiBUaGV5IGFyZSBjb21wbGV0ZWx5IGRpZmZlcmVudAo+ID4gPiA+ID4gdGhpbmdzLgo+ID4gPiA+
ID4gRWFjaCBzaWRlIGhhcyBpdHMgb3duIHN0cmVuZ3RocywgYW5kIHZmaW8gZXNwZWNpYWxseSBp
cyBhY2NlbGVyYXRpbmcKPiA+ID4gPiA+IGluIGl0cyBjYXBhYmlsaXR5IGluIHdheSB0aGF0IHZw
ZGEgaXMgbm90LiBlZyBpZiBhbiBpb21tdWZkIGNvbnZlcnNpb24KPiA+ID4gPiA+IGhhZCBiZWVu
IGRvbmUgYnkgbm93IGZvciB2ZHBhIEkgbWlnaHQgYmUgbW9yZSBzeW1wYXRoZXRpYy4KPiA+ID4g
Pgo+ID4gPiA+IFllYSwgSSBhZ3JlZSBpb21tdWZkIGlzIGEgYmlnIHByb2JsZW0gd2l0aCB2ZHBh
IHJpZ2h0IG5vdy4gQ2luZHkgd2FzCj4gPiA+ID4gc2ljayBhbmQgSSBkaWRuJ3Qga25vdyBhbmQg
a2VwdCBhc3N1bWluZyBzaGUncyB3b3JraW5nIG9uIHRoaXMuIEkgZG9uJ3QKPiA+ID4gPiB0aGlu
ayBpdCdzIGEgaHVnZSBhbW91bnQgb2Ygd29yayB0aG91Z2guICBJJ2xsIHRha2UgYSBsb29rLgo+
ID4gPiA+IElzIHRoZXJlIGFueXRoaW5nIGVsc2UgdGhvdWdoPyBEbyB0ZWxsLgo+ID4gPgo+ID4g
PiBDb25maWRlbnRpYWwgY29tcHV0ZSB3aWxsIG5ldmVyIHdvcmsgd2l0aCBWRFBBJ3MgYXBwcm9h
Y2guCj4gPgo+ID4gSSBkb24ndCBzZWUgaG93IHdoYXQgdGhpcyBwYXRjaHNldCBpcyBkb2luZyBp
cyBkaWZmZXJlbnQKPiA+IHdydCB0byBDb25maWRlbnRpYWwgY29tcHV0ZSAtIHlvdSB0cmFwIElP
IGFjY2Vzc2VzIGFuZCBlbXVsYXRlLgo+ID4gQ2FyZSB0byBlbGFib3JhdGU/Cj4KPiBUaGlzIHBh
dGNoIHNlcmllcyBpc24ndCBhYm91dCBjb25maWRlbnRpYWwgY29tcHV0ZSwgeW91IGFza2VkIGFi
b3V0Cj4gdGhlIGZ1dHVyZS4gVkZJTyB3aWxsIHN1cHBvcnQgY29uZmlkZW50aWFsIGNvbXB1dGUg
aW4gdGhlIGZ1dHVyZSwgVkRQQQo+IHdpbGwgbm90Lgo+Cj4gPiA+ID4gVGhlcmUgYXJlIGEgYnVu
Y2ggb2YgdGhpbmdzIHRoYXQgSSB0aGluayBhcmUgaW1wb3J0YW50IGZvciB2aXJ0aW8KPiA+ID4g
PiB0aGF0IGFyZSBjb21wbGV0ZWx5IG91dCBvZiBzY29wZSBmb3IgdmZpbywgc3VjaCBhcyBtaWdy
YXRpbmcKPiA+ID4gPiBjcm9zcy12ZW5kb3IuCj4gPiA+Cj4gPiA+IFZGSU8gc3VwcG9ydHMgbWln
cmF0aW9uLCBpZiB5b3Ugd2FudCB0byBoYXZlIGNyb3NzLXZlbmRvciBtaWdyYXRpb24KPiA+ID4g
dGhlbiBtYWtlIGEgc3RhbmRhcmQgdGhhdCBkZXNjcmliZXMgdGhlIFZGSU8gbWlncmF0aW9uIGRh
dGEgZm9ybWF0IGZvcgo+ID4gPiB2aXJ0aW8gZGV2aWNlcy4KPiA+Cj4gPiBUaGlzIGhhcyBub3Ro
aW5nIHRvIGRvIHdpdGggZGF0YSBmb3JtYXRzIC0geW91IG5lZWQgdHdvIGRldmljZXMgdG8KPiA+
IGJlaGF2ZSBpZGVudGljYWxseS4gV2hpY2ggaXMgd2hhdCBWRFBBIGlzIGFib3V0IHJlYWxseS4K
Pgo+IFdlJ3ZlIGJlZW4gbG9va2luZyBhdCBWRklPIGxpdmUgbWlncmF0aW9uIGV4dGVuc2l2ZWx5
LiBEZXZpY2UKPiBtZWRpYXRpb24sIGxpa2UgVkRQQSBkb2VzLCBpcyBvbmUgbGVnaXRpbWF0ZSBh
cHByb2FjaCBmb3IgbGl2ZQo+IG1pZ3JhdGlvbi4gSXQgc3VpdGVzIGEgY2VydGFpbiB0eXBlIG9m
IGhldGVyb2dlbmVvdXMgZW52aXJvbm1lbnQgd2VsbC4KPgo+IEJ1dCwgaXQgaXMgZXF1YWxseSBs
ZWdpdGltYXRlIHRvIG1ha2UgdGhlIGRldmljZXMgYmVoYXZlIHRoZSBzYW1lIGFuZAo+IGhhdmUg
dGhlbSBwcm9jZXNzIGEgY29tbW9uIG1pZ3JhdGlvbiBkYXRhLgo+Cj4gVGhpcyBjYW4gaGFwcGVu
IGluIHB1YmxpYyB3aXRoIHN0YW5kYXJkcywgb3IgaXQgY2FuIGhhcHBlbiBpbiBwcml2YXRlCj4g
d2l0aGluIGEgY2xvdWQgb3BlcmF0b3IncyAicHJpdmF0ZS1zdGFuZGFyZCIgZW52aXJvbm1lbnQu
Cj4KPiBUbyBkYXRlLCBpbiBtb3N0IG9mIG15IGRpc2N1c3Npb25zLCBJIGhhdmUgbm90IHNlZW4g
YSBzdHJvbmcgYXBwZXRpdGUKPiBmb3Igc3VjaCBwdWJsaWMgc3RhbmRhcmRzLiBJbiBwYXJ0IGR1
ZSB0byB0aGUgY29tcGxleGl0eS4KPgo+IFJlZ2FyZGxlcywgaXQgaXMgbm90IHRoZSBrZXJuZWwg
Y29tbXVuaXRpZXMgam9iIHRvIGluc2lzdCBvbiBvbmUKPiBhcHByb2FjaCBvciB0aGUgb3RoZXIu
Cj4KPiA+ID4gWW91IGFyZSBhc2tpbmcgdXMgdG8gaW52ZXN0IGluIHRoZSBjb21wbGV4aXR5IG9m
IFZEUEEgdGhyb3VnaCBvdXQKPiA+ID4gKGtlZXAgaXQgd29ya2luZywga2VlcCBpdCBzZWN1cmUs
IGludmVzdCB0aW1lIGluIGRlcGxveWluZyBhbmQKPiA+ID4gZGVidWdnaW5nIGluIHRoZSBmaWVs
ZCkKPiA+ID4KPiA+ID4gV2hlbiBpdCBkb2Vzbid0IHByb3ZpZGUgKkFOWSogdmFsdWUgdG8gdGhl
IHNvbHV0aW9uLgo+ID4KPiA+IFRoZXJlJ3Mgbm8gInRoZSBzb2x1dGlvbiIKPgo+IE5vbnNlbnNl
Lgo+Cj4gPiB0aGlzIHNvdW5kcyBsaWtlIGEgdmVuZG9yIG9ubHkgY2FyaW5nIGFib3V0IHNvbHV0
aW9ucyB0aGF0IGludm9sdmUKPiA+IHRoYXQgdmVuZG9yJ3MgaGFyZHdhcmUgZXhjbHVzaXZlbHks
IGEgbGl0dGxlLgo+Cj4gTm90IHJlYWxseS4KPgo+IFVuZGVyc3RhbmQgdGhlIERQVSBwcm92aWRl
ciBpcyBub3QgdGhlIHZlbmRvciBoZXJlLiBUaGUgRFBVIHByb3ZpZGVyCj4gZ2l2ZXMgYSBjbG91
ZCBvcGVyYXRvciBhIFNESyB0byBidWlsZCB0aGVzZSB0aGluZ3MuIFRoZSBvcGVyYXRvciBpcwo+
IHRoZSB2ZW5kb3IgZnJvbSB5b3VyIHBlcnNwZWN0aXZlLgo+Cj4gSW4gbWFueSBjYXNlcyBsaXZl
IG1pZ3JhdGlvbiBuZXZlciBsZWF2ZXMgdGhlIG9wZXJhdG9yJ3MgY29uZmluZXMgaW4KPiB0aGUg
Zmlyc3QgcGxhY2UuCj4KPiBFdmVuIHdoZW4gaXQgZG9lcywgdGhlcmUgaXMgbm8gcmVhbCB1c2Ug
Y2FzZSB0byBsaXZlIG1pZ3JhdGUgYQo+IHZpcnRpby1uZXQgZnVuY3Rpb24gZnJvbSwgc2F5LCBB
V1MgdG8gR0NQLgoKSXQgY2FuIGhhcHBlbiBpbnNpZGUgYSBzaW5nbGUgY2xvdWQgdmVuZG9yLiBG
b3Igc29tZSByZWFzb25zLCBEUFUgbXVzdApiZSBwdXJjaGFzZWQgZnJvbSBkaWZmZXJlbnQgdmVu
ZG9ycy4gQW5kIHZEUEEgaGFzIGJlZW4gdXNlZCBpbiB0aGF0CmNhc2UuCgpJJ3ZlIGFza2VkIHRo
ZW0gdG8gcHJlc2VudCB0aGlzIHByb2JhYmx5IHNvbWV3aGVyZSBsaWtlIEtWTSBGb3J1bS4KCj4K
PiBZb3UgYXJlIHB1c2hpbmcgZm9yIGEgbG90IG9mIGNvbXBsZXhpdHkgYW5kIHNvZnR3YXJlIHRo
YXQgc29sdmVzIGEKPiBwcm9ibGVtIHBlb3BsZSBpbiB0aGlzIHNwYWNlIGRvbid0IGFjdHVhbGx5
IGhhdmUuCj4KPiBBcyBJIHNhaWQsIFZEUEEgaXMgZmluZSBmb3IgdGhlIHNjZW5hcmlvcyBpdCBh
ZGRyZXNzZXMuIEl0IGlzIGFuCj4gYWx0ZXJuYXRpdmUsIG5vdCBhIHJlcGxhY2VtZW50LCBmb3Ig
VkZJTy4KCldlIG5ldmVyIHRyeSB0byByZXBsYWNlIFZGSU8uIEkgZG9uJ3Qgc2VlIGFueSBwcm9i
bGVtIGJ5IGp1c3QgdXNpbmcKdGhlIGN1cnJlbnQgVkZJTyB0byBhc3NpZ24gYSB2aXJ0aW8tcGNp
IGRldmljZSB0byB0aGUgZ3Vlc3QuCgpUaGUgcHJvYmxlbSBpcyB0aGUgbWVkaWF0aW9uIChvciB3
aGF0IHlvdSBjYWxsZWQgcmVsYXlpbmcpIGxheWVyCnlvdSd2ZSBpbnZlbnRlZC4KClRoYW5rcwoK
Pgo+IEphc29uCj4KCl9fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fClZpcnR1YWxpemF0aW9uIG1haWxpbmcgbGlzdApWaXJ0dWFsaXphdGlvbkBsaXN0cy5saW51
eC1mb3VuZGF0aW9uLm9yZwpodHRwczovL2xpc3RzLmxpbnV4Zm91bmRhdGlvbi5vcmcvbWFpbG1h
bi9saXN0aW5mby92aXJ0dWFsaXphdGlvbg==
