Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EE7E7C74A44
	for <virtualization@archiver.kernel.org>; Tue, 14 Mar 2023 04:33:23 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 7211460E28;
	Tue, 14 Mar 2023 04:33:23 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 7211460E28
Authentication-Results: smtp3.osuosl.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=CNUyLTcS
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
	by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id x5b0hOOeUz1K; Tue, 14 Mar 2023 04:33:21 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp3.osuosl.org (Postfix) with ESMTPS id C5FB560BF2;
	Tue, 14 Mar 2023 04:33:20 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org C5FB560BF2
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id AD0ACC0035;
	Tue, 14 Mar 2023 04:33:20 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by lists.linuxfoundation.org (Postfix) with ESMTP id E9672C0032
 for <virtualization@lists.linux-foundation.org>;
 Tue, 14 Mar 2023 04:33:18 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id B502241605
 for <virtualization@lists.linux-foundation.org>;
 Tue, 14 Mar 2023 04:33:18 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org B502241605
Authentication-Results: smtp4.osuosl.org;
 dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com
 header.a=rsa-sha256 header.s=mimecast20190719 header.b=CNUyLTcS
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id GlC2Cm7wWyVr
 for <virtualization@lists.linux-foundation.org>;
 Tue, 14 Mar 2023 04:33:16 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org BFCD6409DD
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.129.124])
 by smtp4.osuosl.org (Postfix) with ESMTPS id BFCD6409DD
 for <virtualization@lists.linux-foundation.org>;
 Tue, 14 Mar 2023 04:33:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1678768393;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=kEdhfwL90AUu3NuNHPCy7zf5EE+hHaimS5EMw3qgAHw=;
 b=CNUyLTcS1gEAB/faYJIbv9hNuZYTjIZQHZ2omMAoCJH8mhk33csLjIiZBxlojwtbFjh4Xa
 IB6JvrsoOa/KrQwe7AnczB87L1DVUsR/eCIWv/pt1z1evWz9ZbeWqCqGqEpgKE/nLm6Yn8
 M1FrzCXUiKPL5O3w3KKjbY2/m3DAm74=
Received: from mail-ed1-f72.google.com (mail-ed1-f72.google.com
 [209.85.208.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-227-oGgaHOIfMEeuP0UuFTZeBA-1; Tue, 14 Mar 2023 00:33:12 -0400
X-MC-Unique: oGgaHOIfMEeuP0UuFTZeBA-1
Received: by mail-ed1-f72.google.com with SMTP id
 dn8-20020a05640222e800b004bd35dd76a9so20120742edb.13
 for <virtualization@lists.linux-foundation.org>;
 Mon, 13 Mar 2023 21:33:12 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112; t=1678768391;
 h=in-reply-to:content-transfer-encoding:content-disposition
 :mime-version:references:message-id:subject:cc:to:from:date
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=kEdhfwL90AUu3NuNHPCy7zf5EE+hHaimS5EMw3qgAHw=;
 b=IqCGNUMmB1H7RaIkq76mV2s+o11ekJ2D5Fc+QhRQEVqxz8lggbURdEs8KS2npugevk
 nDdubYgfLnVJT7vmJLFddE1cY3IsmkIaLQnpjIosF98dagBt2sH/ZF0uPjwvWLfzFZdm
 5Vfg2WHtkzTeBTzpz3QoQo9KkS/S6d01jgWbYhDLydKooqNR7yM3u/rb3TeSEJ3dZw2J
 U8917/RUi/ghHHMSbzLeLsW+47IsINoczIso4hnenkGtGBipu2fUQpaPEFJQKFutPqqm
 0ecaPBCOMRo87BvJeET5UO5mPaKuVa6NXP52ZYKZ1C3rwdpr3smxwcg65i/858QMY15L
 EMDg==
X-Gm-Message-State: AO0yUKX41CJWg9wgGSma++nHmNZYKYP2ay/a8Xp2sF08+zcivXxz8P2o
 0s+oq8b3BdL8Fs6b0YiHTjtZOLd+0U+b+6kK2Nsi9KgL8VBQ349MfVFtS9yT2v2AX5WVWahokOd
 ohBUt6HuIYMZq4Om/A4lzSiNK/uGA3jOGOYTbWVzZBQ==
X-Received: by 2002:a17:906:24d3:b0:8b1:3225:66f0 with SMTP id
 f19-20020a17090624d300b008b1322566f0mr977713ejb.68.1678768391161; 
 Mon, 13 Mar 2023 21:33:11 -0700 (PDT)
X-Google-Smtp-Source: AK7set/yE/nKLy0rZ6wG1N+TiqzX+97gbx6phE971UmBLjlowOJ/8XNxYmajjbYa+GqhAcoppJl43Q==
X-Received: by 2002:a17:906:24d3:b0:8b1:3225:66f0 with SMTP id
 f19-20020a17090624d300b008b1322566f0mr977700ejb.68.1678768390856; 
 Mon, 13 Mar 2023 21:33:10 -0700 (PDT)
Received: from redhat.com ([2a02:14f:1f7:4129:3ef9:ea05:f0ca:6b81])
 by smtp.gmail.com with ESMTPSA id
 r9-20020a50c009000000b004c13fe8fabfsm416166edb.84.2023.03.13.21.33.08
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 13 Mar 2023 21:33:10 -0700 (PDT)
Date: Tue, 14 Mar 2023 00:33:06 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Parav Pandit <parav@mellanox.com>
Subject: Re: [PATCH 1/2] vdpa/mlx5: Make VIRTIO_NET_F_MRG_RXBUF off by default
Message-ID: <20230314002939-mutt-send-email-mst@kernel.org>
References: <20230312083920.2300028-1-elic@nvidia.com>
 <20230312083920.2300028-2-elic@nvidia.com>
 <20230312045717-mutt-send-email-mst@kernel.org>
 <f01c7204-5629-297e-47b6-06e58bd3f543@nvidia.com>
 <20230312054559-mutt-send-email-mst@kernel.org>
 <PH0PR12MB54816C24BAA322567BED21A0DCB89@PH0PR12MB5481.namprd12.prod.outlook.com>
 <f269688b-8392-406c-e070-369b25acc252@oracle.com>
 <PH0PR12MB5481A0629C479A030C8A8EDEDCBE9@PH0PR12MB5481.namprd12.prod.outlook.com>
 <20230313233638-mutt-send-email-mst@kernel.org>
 <PH0PR12MB54816DE6E7A0594D38019305DCBE9@PH0PR12MB5481.namprd12.prod.outlook.com>
MIME-Version: 1.0
In-Reply-To: <PH0PR12MB54816DE6E7A0594D38019305DCBE9@PH0PR12MB5481.namprd12.prod.outlook.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Disposition: inline
Cc: "perezma@redhat.com" <perezma@redhat.com>,
 "virtualization@lists.linux-foundation.org"
 <virtualization@lists.linux-foundation.org>,
 Eugenio Perez Martin <eperezma@redhat.com>, Eli Cohen <elic@nvidia.com>
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

T24gVHVlLCBNYXIgMTQsIDIwMjMgYXQgMDM6NDc6NDNBTSArMDAwMCwgUGFyYXYgUGFuZGl0IHdy
b3RlOgo+IAo+ID4gRnJvbTogTWljaGFlbCBTLiBUc2lya2luIDxtc3RAcmVkaGF0LmNvbT4KPiA+
IFNlbnQ6IE1vbmRheSwgTWFyY2ggMTMsIDIwMjMgMTE6MzggUE0KPiA+IAo+ID4gT24gVHVlLCBN
YXIgMTQsIDIwMjMgYXQgMDI6MDU6NTBBTSArMDAwMCwgUGFyYXYgUGFuZGl0IHdyb3RlOgo+ID4g
Pgo+ID4gPiA+IEZyb206IFNpLVdlaSBMaXUgPHNpLXdlaS5saXVAb3JhY2xlLmNvbT4KPiA+ID4g
PiBTZW50OiBNb25kYXksIE1hcmNoIDEzLCAyMDIzIDY6MTkgUE0KPiA+ID4KPiA+ID4gPiBBY3R1
YWxseSB0aGVyZSdzIG5vIHN1Y2ggYnVyZGVuIG9yIHJlcXVpcmVtZW50IHRvIG1haW50YWluIGJh
Y2t3YXJkCj4gPiA+ID4gY29tcGF0aWJpbGl0eSBmb3IgdGhlIGRlZmF1bHQgJ3ZkcGEgZGV2IGFk
ZCcgYmVoYXZpb3IgaWYgZGVkaWNhdGVkCj4gPiA+ID4gZGV2aWNlX2ZlYXR1cmVzIGlzIG5vdCBz
cGVjaWZpZWQuIEhpc3RvcmljYWxseSB0aGUgZGVmYXVsdCB2ZHBhCj4gPiA+ID4gY3JlYXRpb24g
b24gbWx4NSBldmVyIGdvdCBjaGFuZ2VkIGZyb20gc2luZ2xlIHF1ZXVlIHRvIDggcXVldWUgcGFp
cnMKPiA+ID4gPiB3aGVuIFZJUlRJT19ORVRfRl9NUSBmZWF0dXJlIHdhcyBmaXJzdCBpbnRyb2R1
Y2VkIHRvIG1seDVfdmRwYSwgdGhlbgo+ID4gPiA+IHRoZSBkZWZhdWx0IHN3aXRjaGVkIGJhY2sg
dG8gMSBkYXRhIHF1ZXVlIHBhaXIgYWdhaW4gd2hlbiBtYXhfdnFwCj4gPiBhdHRyaWJ1dGUgd2Fz
IGFkZGVkIHRvIHRoZSB2ZHBhIHRvb2wuCj4gPiA+ID4gRXNzZW50aWFsbHksIGV2ZXJ5IGFkZGl0
aW9uIG9mIG5ldyBmZWF0dXJlIHRvIG1seDVfdmRwYSwgZS5nLgo+ID4gPiA+IENUUkxfVlEsIENU
UkxfVkxBTiwgYW5kIGV0IGFsLCBlZmZlY3RpdmVseSBjaGFuZ2VkIHRoZSBkZWZhdWx0ICJ2ZHBh
Cj4gPiA+ID4gZGV2IGFkZCIgYmVoYXZpb3Igbm90IGp1c3Qgb25seSBvbmNlOiB0aGUgYmFja3dh
cmQgY29tcGF0aWJpbGl0eQo+ID4gPiA+IGd1YXJhbnRlZSBpcyBzaW1wbHkganVzdCBub3QgdGhl
cmUgYW5kIGV2ZXIuCj4gPiA+IFRoaXMgcmVxdWlyZXMgdGhhdCBldmVyeSBjaGFuZ2UgaW4gdGhl
IGRldmljZSBhdHRyaWJ1dGVzIHdpbGwgY2hhbmdlIHRoZQo+ID4gYmVoYXZpb3IgZm9yIHZkcGEg
ZGV2IGFkZC4KPiA+ID4gVGhlIE9SIG9wZXJhdGlvbiBvZiB0aGUgdXNlciBzdXBwbGllZCBmZWF0
dXJlIGJpdHMgd2l0aCBkZXZpY2UgZGVmYXVsdHMKPiA+IGZlYXR1cmUgYml0IGRvZXNu4oCZdCBs
b29rIGdvb2QgdG8gbWUuCj4gPiA+IEl0IGJyaW5ncyB1bmNlcnRhaW4gYmVoYXZpb3IuCj4gPiA+
Cj4gPiA+IFRoZSByaWdodCBiZWhhdmlvciBzaG91bGQgYmUsIGlmIHVzZXIgc3VwcGxpZWQgdGhl
IGZlYXR1cmUgYml0cywgaXQgc2hvdWxkCj4gPiBzdXBwbHkgYWxsIGRlc2lyZWQgYml0cy4KPiA+
IAo+ID4gSSB0aGluayB1IG1lYW4gYWxsIHRoYXQgZGV2aWNlIGFsc28gc3VwcG9ydHMuCj4gPgo+
IElmIHVzZXIgc3VwcGxpZWQgZmVhdHVyZSBiaXRzIGFuZCBkZXZpY2UgZG9lc27igJl0IHN1cHBv
cnQgc29tZSBvZiB0aGUgZmVhdHVyZSBiaXRzIC0+IGFkZCBjb21tYW5kIGZhaWxzLgo+IElmIHVz
ZXIgc3VwcGxpZWQgZmVhdHVyZSBiaXRzLCB0aGFuIHVzZSBvbmx5IHRoZSBmZWF0dXJlIGJpdHMu
IERvIG5vdCBPUiB1c2VyIHN1cHBsaWVkIGZlYXR1cmUgYml0cyB3aXRoIGRldmljZSBzdXBwb3J0
ZWQgZmVhdHVyZSBiaXRzLgo+IEZvciBleGFtcGxlLAo+IFVzZXIgYXNrZWQgdG8gc2V0LAo+IEZf
Q09ORklHX01UVQo+IEZfQ09ORklHX01BQwo+IEZfUEFDS0VECj4gSW4gdGhhdCBkZXZpY2Ugc2hv
dWxkIG9ubHkgdXNlIGFib3ZlIDMgZmVhdHVyZXMuIChiZWNhdXNlIHVzZXIgaXMgdGhlIG1hc3Rl
cikuCj4gCj4gSXQgc2hvdWxkIG5vdCBPUiB1c2VyIHN1cHBsaWVkIGZlYXR1cmUgYml0cyB3aXRo
IGRldmljZSBkZWZhdWx0cyBmZWF0dXJlIGJpdHMuCj4gIAo+ID4gPiBJZiB1c2VyIGRvZXNu4oCZ
dCBzdXBwbHkgZmVhdHVyZSBiaXRzLCB1c2UgdGhlIGRldmljZSBkZWZhdWx0cy4KPiAKPiBJZiB1
c2VyIGRvZXNu4oCZdCBzdXBwbHkgYW55IGZlYXR1cmUgZml0cywgdGhhdCBtZWFucyB1c2VyIHdh
bnRzIHRvIHJ1biB3aXRoIHNvbWUgZGV2aWNlIGRlZmF1bHRzLgo+IEluIHRoYXQgY2FzZSBpdHMg
ZmluZSB0byBydW4gd2l0aCBkZXZpY2UgZGVmYXVsdHMuCgpCdXQgdGhpcyBpcyBub3Qgd2hhdCB0
aGlzIHBhdGNoIGRvZXM/Cgo+ID4gPiBCdXQgbm90IHRvIG1peCBib3RoIGZlYXR1cmUgYml0cy4K
PiA+IAo+ID4gQ2FuJ3Qgc2F5IEkgdW5kZXJzdGFuZCB3aGF0IHRoaXMgbWVhbnMuIFdoYXQgZG9l
cyAiYm90aCIgbWVhbiBoZXJlPwo+IAo+IE1peCBCb3RoIG1lYW5zLCB0byBwZXJmb3JtIE9SIG9w
ZXJhdGlvbiBvbiB1c2VyIHN1cHBsaWVkIGZlYXR1cmUgYml0cyB3aXRoIGRldmljZSBkZWZhdWx0
cy4KCl9fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fClZpcnR1
YWxpemF0aW9uIG1haWxpbmcgbGlzdApWaXJ0dWFsaXphdGlvbkBsaXN0cy5saW51eC1mb3VuZGF0
aW9uLm9yZwpodHRwczovL2xpc3RzLmxpbnV4Zm91bmRhdGlvbi5vcmcvbWFpbG1hbi9saXN0aW5m
by92aXJ0dWFsaXphdGlvbg==
