Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6CA52E81817
	for <virtualization@archiver.kernel.org>; Tue, 26 Sep 2023 04:37:34 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp2.osuosl.org (Postfix) with ESMTP id 0E14541771;
	Tue, 26 Sep 2023 04:37:34 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org 0E14541771
Authentication-Results: smtp2.osuosl.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=IwBy3+YG
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
	by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id EdfjR_2u011z; Tue, 26 Sep 2023 04:37:33 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp2.osuosl.org (Postfix) with ESMTPS id A483640541;
	Tue, 26 Sep 2023 04:37:32 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org A483640541
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 8185DC0071;
	Tue, 26 Sep 2023 04:37:32 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [IPv6:2605:bc80:3010::136])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 9FA4AC0032
 for <virtualization@lists.linux-foundation.org>;
 Tue, 26 Sep 2023 04:37:31 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id 6E113613C8
 for <virtualization@lists.linux-foundation.org>;
 Tue, 26 Sep 2023 04:37:31 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 6E113613C8
Authentication-Results: smtp3.osuosl.org;
 dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com
 header.a=rsa-sha256 header.s=mimecast20190719 header.b=IwBy3+YG
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id dDEF8gRBB1qj
 for <virtualization@lists.linux-foundation.org>;
 Tue, 26 Sep 2023 04:37:30 +0000 (UTC)
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.133.124])
 by smtp3.osuosl.org (Postfix) with ESMTPS id ACDA961349
 for <virtualization@lists.linux-foundation.org>;
 Tue, 26 Sep 2023 04:37:30 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org ACDA961349
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1695703049;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=sK7XhA7pNuDH69jUM+WS48wVbsIihORxbWDu0rbFBU8=;
 b=IwBy3+YGbfNllCr5X/nSg4o9GbEmSV2XYgwsLgo7jQ6L5IgRGHqC4H3EJmFMpydlFbSc9Y
 MCPGdMcqxvVSuG69Nwl5U7/peFv5zm4YwfG3BqDUlLFoSMb5+fenp1qNkjPqvEcrHqrJ8D
 L521th2CtGAtTrjJkcBqleDdGFRQjSo=
Received: from mail-lf1-f71.google.com (mail-lf1-f71.google.com
 [209.85.167.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-84-bNwT6kzIM4KXALf17eJT4A-1; Tue, 26 Sep 2023 00:37:25 -0400
X-MC-Unique: bNwT6kzIM4KXALf17eJT4A-1
Received: by mail-lf1-f71.google.com with SMTP id
 2adb3069b0e04-503317b8d26so11484840e87.1
 for <virtualization@lists.linux-foundation.org>;
 Mon, 25 Sep 2023 21:37:25 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1695703044; x=1696307844;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=sK7XhA7pNuDH69jUM+WS48wVbsIihORxbWDu0rbFBU8=;
 b=aRDI0L3ku3RGAZd6nMjgrKVKY2Z/OmVJHZaPZedzTT52rH3lk/13Rc8CWRAY/lkp90
 4YP2BrbEgUCcJoFe17FC3Dn+lCQzZFc4WJ8Jbt4hDm6Q/5joe2bHxsXwvPmlr6hdlyCr
 42wGcLyr7M53KPd71iRjKAlo/KXXZ91txc19aWTsRqYk+5ZRrF4iSgIf2qW9drOYQdmY
 7J+ODSw/Huzcgwv4d05Jx5OU8v4MIYG/Fej56FU2ZTwLyBZgh9AbK8RYSoCS15iO96LD
 qC5eVA/fhx2KRbBYExvPB5TG5YPgvjyHkrElfN3GPp6OqWcGdBUhJCWH/0Jsh84vN7C0
 nfFw==
X-Gm-Message-State: AOJu0YzCT0dy3EflZthA514q9lqSJ+CzR1lyUIfHd5q5WGjMlBwWxHip
 Abz1El+v6Y1S4M94lJq5bASDt31xNje+2rkku8So3C6zkK9uhb+OxbOwNmtRGH3trw1IMOfeHC8
 0r2+YPtJDesl4+FJmKogIutNOqwxswXu9GEXLqXPcOTCAdL2M8WcgUc4Ftg==
X-Received: by 2002:a05:6512:158d:b0:502:fdca:2ea6 with SMTP id
 bp13-20020a056512158d00b00502fdca2ea6mr8003660lfb.61.1695703044045; 
 Mon, 25 Sep 2023 21:37:24 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IF0GVHQpxV6cu/bgf78VPW3Zw2158iGo2jNqikx3gXDl/JuLt9+Gce4NkjWxjwVm9d8/MPIKXfnRlQnBPIhjd4=
X-Received: by 2002:a05:6512:158d:b0:502:fdca:2ea6 with SMTP id
 bp13-20020a056512158d00b00502fdca2ea6mr8003656lfb.61.1695703043675; Mon, 25
 Sep 2023 21:37:23 -0700 (PDT)
MIME-Version: 1.0
References: <20230921135426-mutt-send-email-mst@kernel.org>
 <20230921181637.GU13733@nvidia.com>
 <20230921152802-mutt-send-email-mst@kernel.org>
 <20230921195345.GZ13733@nvidia.com>
 <20230921155834-mutt-send-email-mst@kernel.org>
 <CACGkMEvD+cTyRtax7_7TBNECQcGPcsziK+jCBgZcLJuETbyjYw@mail.gmail.com>
 <20230922122246.GN13733@nvidia.com>
 <PH0PR12MB548127753F25C45B7EFF203DDCFFA@PH0PR12MB5481.namprd12.prod.outlook.com>
 <CACGkMEuX5HJVBOw9E+skr=K=QzH3oyHK8gk-r0hAvi6Wm7OA7Q@mail.gmail.com>
 <PH0PR12MB5481ED78F7467EEB0740847EDCFCA@PH0PR12MB5481.namprd12.prod.outlook.com>
 <20230925141713-mutt-send-email-mst@kernel.org>
 <PH0PR12MB5481AF4B2F61E96794D7ABC7DCC3A@PH0PR12MB5481.namprd12.prod.outlook.com>
In-Reply-To: <PH0PR12MB5481AF4B2F61E96794D7ABC7DCC3A@PH0PR12MB5481.namprd12.prod.outlook.com>
From: Jason Wang <jasowang@redhat.com>
Date: Tue, 26 Sep 2023 12:37:12 +0800
Message-ID: <CACGkMEsWJmsHR_iVLD_SK0iQ_tALb3+Ev6fYTRkNm8iPGQ6pXQ@mail.gmail.com>
Subject: Re: [PATCH vfio 11/11] vfio/virtio: Introduce a vfio driver over
 virtio devices
To: Parav Pandit <parav@nvidia.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Cc: "kvm@vger.kernel.org" <kvm@vger.kernel.org>,
 "Michael S. Tsirkin" <mst@redhat.com>, Maor Gottlieb <maorg@nvidia.com>,
 "virtualization@lists.linux-foundation.org"
 <virtualization@lists.linux-foundation.org>, Jason Gunthorpe <jgg@nvidia.com>,
 Jiri Pirko <jiri@nvidia.com>, Leon Romanovsky <leonro@nvidia.com>
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

T24gVHVlLCBTZXAgMjYsIDIwMjMgYXQgMTE6NDXigK9BTSBQYXJhdiBQYW5kaXQgPHBhcmF2QG52
aWRpYS5jb20+IHdyb3RlOgo+Cj4KPgo+ID4gRnJvbTogTWljaGFlbCBTLiBUc2lya2luIDxtc3RA
cmVkaGF0LmNvbT4KPiA+IFNlbnQ6IFR1ZXNkYXksIFNlcHRlbWJlciAyNiwgMjAyMyAxMjowNiBB
TQo+Cj4gPiBPbmUgY2FuIHRoaW5rYWJseSBkbyB0aGF0IHdhaXQgaW4gaGFyZHdhcmUsIHRob3Vn
aC4gSnVzdCBkZWZlciBjb21wbGV0aW9uIHVudGlsCj4gPiByZWFkIGlzIGRvbmUuCj4gPgo+IE9u
Y2UgT0FTSVMgZG9lcyBzdWNoIG5ldyBpbnRlcmZhY2UgYW5kIGlmIHNvbWUgaHcgdmVuZG9yIF9h
Y3R1YWxseV8gd2FudHMgdG8gZG8gc3VjaCBjb21wbGV4IGh3LCBtYXkgYmUgdmZpbyBkcml2ZXIg
Y2FuIGFkb3B0IHRvIGl0LgoKSXQgaXMgeW91IHRoYXQgdHJpZXMgdG8gcmV2aXZlIGxlZ2FjeSBp
biB0aGUgc3BlYy4gV2UgYWxsIGtub3cgbGVnYWN5CmlzIHRyaWNreSBidXQgd29yay4KCj4gV2hl
biB3ZSB3b3JrZWQgd2l0aCB5b3UsIHdlIGRpc2N1c3NlZCB0aGF0IHRoZXJlIHN1Y2ggaHcgZG9l
cyBub3QgaGF2ZSBlbm91Z2ggcmV0dXJucyBhbmQgaGVuY2UgdGVjaG5pY2FsIGNvbW1pdHRlZSBj
aG9vc2UgdG8gcHJvY2VlZCB3aXRoIGFkbWluIGNvbW1hbmRzLgoKSSBkb24ndCB0aGluayBteSBx
dWVzdGlvbnMgcmVnYXJkaW5nIHRoZSBsZWdhY3kgdHJhbnNwb3J0IGdldCBnb29kCmFuc3dlcnMg
YXQgdGhhdCB0aW1lLiBXaGF0J3MgbW9yZSwgd2UgYWxsIGtub3cgc3BlYyBhbGxvd3MgdG8gZml4
LAp3b3JrYXJvdW5kIG9yIGV2ZW4gZGVwcmVjYXRlIGEgZmVhdHVyZS4KClRoYW5rcwoKX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18KVmlydHVhbGl6YXRpb24g
bWFpbGluZyBsaXN0ClZpcnR1YWxpemF0aW9uQGxpc3RzLmxpbnV4LWZvdW5kYXRpb24ub3JnCmh0
dHBzOi8vbGlzdHMubGludXhmb3VuZGF0aW9uLm9yZy9tYWlsbWFuL2xpc3RpbmZvL3ZpcnR1YWxp
emF0aW9u
