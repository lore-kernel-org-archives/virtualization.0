Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EA4C4C74A44
	for <virtualization@archiver.kernel.org>; Tue, 14 Mar 2023 03:38:20 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp2.osuosl.org (Postfix) with ESMTP id 61CE14038E;
	Tue, 14 Mar 2023 03:38:20 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org 61CE14038E
Authentication-Results: smtp2.osuosl.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=G9TW5kmk
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
	by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id ww2GNEywKOsS; Tue, 14 Mar 2023 03:38:19 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp2.osuosl.org (Postfix) with ESMTPS id DACC24012E;
	Tue, 14 Mar 2023 03:38:18 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org DACC24012E
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id B67D7C0071;
	Tue, 14 Mar 2023 03:38:18 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 6A13EC0032
 for <virtualization@lists.linux-foundation.org>;
 Tue, 14 Mar 2023 03:38:17 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id 3D17241819
 for <virtualization@lists.linux-foundation.org>;
 Tue, 14 Mar 2023 03:38:17 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org 3D17241819
Authentication-Results: smtp4.osuosl.org;
 dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com
 header.a=rsa-sha256 header.s=mimecast20190719 header.b=G9TW5kmk
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id bu04mD0insqs
 for <virtualization@lists.linux-foundation.org>;
 Tue, 14 Mar 2023 03:38:16 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org F06C34179F
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.129.124])
 by smtp4.osuosl.org (Postfix) with ESMTPS id F06C34179F
 for <virtualization@lists.linux-foundation.org>;
 Tue, 14 Mar 2023 03:38:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1678765093;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=3lgR+9pg51PcqO0OjSshdqW0tesb5i3tq92xkS85FOc=;
 b=G9TW5kmkV52hJdGCpXI9N5EF24Dj6VmlLZ67agq3LjVE1iNlePPTDEjjgEH4vajZ7khpbz
 MgSfutQxyJABE0w0u+q4mszgjRI5wxzuCZrWIE2JLNwxQeFp25TxXaRNgWl8BRkwlr9ZsU
 SHUgEzfFJ6T0r9Dr7rC571Q62/ktw+Y=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-117-JoUEVgHDOqKNj8BvflGUtg-1; Mon, 13 Mar 2023 23:38:12 -0400
X-MC-Unique: JoUEVgHDOqKNj8BvflGUtg-1
Received: by mail-wm1-f69.google.com with SMTP id
 m28-20020a05600c3b1c00b003e7d4662b83so8776523wms.0
 for <virtualization@lists.linux-foundation.org>;
 Mon, 13 Mar 2023 20:38:11 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112; t=1678765091;
 h=in-reply-to:content-transfer-encoding:content-disposition
 :mime-version:references:message-id:subject:cc:to:from:date
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=3lgR+9pg51PcqO0OjSshdqW0tesb5i3tq92xkS85FOc=;
 b=m1YHndkezp+ZkcKniExby/uq4V7sjt5rB7bN5OoWzhHScQKcgLYmF1upzW/hU06gyv
 Rhv/GZhMhtxb2/YETzR1HcEHLAKk55ANDOnAdRBfs+KXAvnKL1fCrxR/eJ3PI8HxE2gX
 Km4D31jJv5iee13Uvj3se1u66iVtiG1A1PoU4SFdr+70vDz7zOUesR2WX+o+ukAI0aql
 SreY5z682T0NYIJ3Mik2P3eFVHDdFE2so3ZByWhKgpkHp+Lw0blere28KFfvP1OR1xxB
 7JzrS2zbddU08Z3wrVFNPbWke5lkal7rT2fp6PMOlHBLkFVfSIw0h06S/dpUsLJmNWvF
 RZjg==
X-Gm-Message-State: AO0yUKUooKFcU74FQ1YvYCTaY/NBdGTThzbu1OAxzwX9e1zo7P028BmL
 46rdM+1SQa1PDSxrrTX13eCP0/y9nrwrfZAPCm0jJp7ILcXOER2S38zdKTdGVb8110Z3/gK5vEk
 eT3h0OSGGedlnGtr+g9UB49Aa8EQBDxgOr3agYNOYnA==
X-Received: by 2002:a05:600c:a04:b0:3eb:3971:a2aa with SMTP id
 z4-20020a05600c0a0400b003eb3971a2aamr13304077wmp.25.1678765091048; 
 Mon, 13 Mar 2023 20:38:11 -0700 (PDT)
X-Google-Smtp-Source: AK7set9YOwFkH0K8PhhmX9oWsD+Q/2vRFBlN4oZHwYSx/LM2OCfwKmV379cRnA+z0yP0KTPuDBTVMg==
X-Received: by 2002:a05:600c:a04:b0:3eb:3971:a2aa with SMTP id
 z4-20020a05600c0a0400b003eb3971a2aamr13304064wmp.25.1678765090761; 
 Mon, 13 Mar 2023 20:38:10 -0700 (PDT)
Received: from redhat.com ([2.52.26.7]) by smtp.gmail.com with ESMTPSA id
 z10-20020a05600c220a00b003ed2433aa4asm1341211wml.41.2023.03.13.20.38.08
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 13 Mar 2023 20:38:10 -0700 (PDT)
Date: Mon, 13 Mar 2023 23:37:59 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Parav Pandit <parav@mellanox.com>
Subject: Re: [PATCH 1/2] vdpa/mlx5: Make VIRTIO_NET_F_MRG_RXBUF off by default
Message-ID: <20230313233638-mutt-send-email-mst@kernel.org>
References: <20230312083920.2300028-1-elic@nvidia.com>
 <20230312083920.2300028-2-elic@nvidia.com>
 <20230312045717-mutt-send-email-mst@kernel.org>
 <f01c7204-5629-297e-47b6-06e58bd3f543@nvidia.com>
 <20230312054559-mutt-send-email-mst@kernel.org>
 <PH0PR12MB54816C24BAA322567BED21A0DCB89@PH0PR12MB5481.namprd12.prod.outlook.com>
 <f269688b-8392-406c-e070-369b25acc252@oracle.com>
 <PH0PR12MB5481A0629C479A030C8A8EDEDCBE9@PH0PR12MB5481.namprd12.prod.outlook.com>
MIME-Version: 1.0
In-Reply-To: <PH0PR12MB5481A0629C479A030C8A8EDEDCBE9@PH0PR12MB5481.namprd12.prod.outlook.com>
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

T24gVHVlLCBNYXIgMTQsIDIwMjMgYXQgMDI6MDU6NTBBTSArMDAwMCwgUGFyYXYgUGFuZGl0IHdy
b3RlOgo+IAo+ID4gRnJvbTogU2ktV2VpIExpdSA8c2ktd2VpLmxpdUBvcmFjbGUuY29tPgo+ID4g
U2VudDogTW9uZGF5LCBNYXJjaCAxMywgMjAyMyA2OjE5IFBNCj4gCj4gPiBBY3R1YWxseSB0aGVy
ZSdzIG5vIHN1Y2ggYnVyZGVuIG9yIHJlcXVpcmVtZW50IHRvIG1haW50YWluIGJhY2t3YXJkCj4g
PiBjb21wYXRpYmlsaXR5IGZvciB0aGUgZGVmYXVsdCAndmRwYSBkZXYgYWRkJyBiZWhhdmlvciBp
ZiBkZWRpY2F0ZWQKPiA+IGRldmljZV9mZWF0dXJlcyBpcyBub3Qgc3BlY2lmaWVkLiBIaXN0b3Jp
Y2FsbHkgdGhlIGRlZmF1bHQgdmRwYSBjcmVhdGlvbiBvbiBtbHg1Cj4gPiBldmVyIGdvdCBjaGFu
Z2VkIGZyb20gc2luZ2xlIHF1ZXVlIHRvIDggcXVldWUgcGFpcnMgd2hlbiBWSVJUSU9fTkVUX0Zf
TVEKPiA+IGZlYXR1cmUgd2FzIGZpcnN0IGludHJvZHVjZWQgdG8gbWx4NV92ZHBhLCB0aGVuIHRo
ZSBkZWZhdWx0IHN3aXRjaGVkIGJhY2sgdG8gMQo+ID4gZGF0YSBxdWV1ZSBwYWlyIGFnYWluIHdo
ZW4gbWF4X3ZxcCBhdHRyaWJ1dGUgd2FzIGFkZGVkIHRvIHRoZSB2ZHBhIHRvb2wuCj4gPiBFc3Nl
bnRpYWxseSwgZXZlcnkgYWRkaXRpb24gb2YgbmV3IGZlYXR1cmUgdG8gbWx4NV92ZHBhLCBlLmcu
IENUUkxfVlEsCj4gPiBDVFJMX1ZMQU4sIGFuZCBldCBhbCwgZWZmZWN0aXZlbHkgY2hhbmdlZCB0
aGUgZGVmYXVsdCAidmRwYSBkZXYgYWRkIiBiZWhhdmlvcgo+ID4gbm90IGp1c3Qgb25seSBvbmNl
OiB0aGUgYmFja3dhcmQgY29tcGF0aWJpbGl0eSBndWFyYW50ZWUgaXMgc2ltcGx5IGp1c3Qgbm90
Cj4gPiB0aGVyZSBhbmQgZXZlci4KPiBUaGlzIHJlcXVpcmVzIHRoYXQgZXZlcnkgY2hhbmdlIGlu
IHRoZSBkZXZpY2UgYXR0cmlidXRlcyB3aWxsIGNoYW5nZSB0aGUgYmVoYXZpb3IgZm9yIHZkcGEg
ZGV2IGFkZC4KPiBUaGUgT1Igb3BlcmF0aW9uIG9mIHRoZSB1c2VyIHN1cHBsaWVkIGZlYXR1cmUg
Yml0cyB3aXRoIGRldmljZSBkZWZhdWx0cyBmZWF0dXJlIGJpdCBkb2VzbuKAmXQgbG9vayBnb29k
IHRvIG1lLgo+IEl0IGJyaW5ncyB1bmNlcnRhaW4gYmVoYXZpb3IuCj4gCj4gVGhlIHJpZ2h0IGJl
aGF2aW9yIHNob3VsZCBiZSwgaWYgdXNlciBzdXBwbGllZCB0aGUgZmVhdHVyZSBiaXRzLCBpdCBz
aG91bGQgc3VwcGx5IGFsbCBkZXNpcmVkIGJpdHMuCgpJIHRoaW5rIHUgbWVhbiBhbGwgdGhhdCBk
ZXZpY2UgYWxzbyBzdXBwb3J0cy4KCj4gSWYgdXNlciBkb2VzbuKAmXQgc3VwcGx5IGZlYXR1cmUg
Yml0cywgdXNlIHRoZSBkZXZpY2UgZGVmYXVsdHMuCj4gQnV0IG5vdCB0byBtaXggYm90aCBmZWF0
dXJlIGJpdHMuCgpDYW4ndCBzYXkgSSB1bmRlcnN0YW5kIHdoYXQgdGhpcyBtZWFucy4gV2hhdCBk
b2VzICJib3RoIiBtZWFuIGhlcmU/CgotLSAKTVNUCgpfX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fXwpWaXJ0dWFsaXphdGlvbiBtYWlsaW5nIGxpc3QKVmlydHVh
bGl6YXRpb25AbGlzdHMubGludXgtZm91bmRhdGlvbi5vcmcKaHR0cHM6Ly9saXN0cy5saW51eGZv
dW5kYXRpb24ub3JnL21haWxtYW4vbGlzdGluZm8vdmlydHVhbGl6YXRpb24=
