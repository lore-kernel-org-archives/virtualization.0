Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 45543E81810
	for <virtualization@archiver.kernel.org>; Tue, 26 Sep 2023 02:33:02 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 9EDB7418F0;
	Tue, 26 Sep 2023 02:33:01 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org 9EDB7418F0
Authentication-Results: smtp4.osuosl.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=XkjQzBQk
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
	by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id oXEGsSPrDg8J; Tue, 26 Sep 2023 02:33:00 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp4.osuosl.org (Postfix) with ESMTPS id B698A41740;
	Tue, 26 Sep 2023 02:32:59 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org B698A41740
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 8B676C0071;
	Tue, 26 Sep 2023 02:32:59 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 20305C0032
 for <virtualization@lists.linux-foundation.org>;
 Tue, 26 Sep 2023 02:32:58 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id D6786418F0
 for <virtualization@lists.linux-foundation.org>;
 Tue, 26 Sep 2023 02:32:57 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org D6786418F0
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id K0A_ci2RT6Jw
 for <virtualization@lists.linux-foundation.org>;
 Tue, 26 Sep 2023 02:32:56 +0000 (UTC)
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.129.124])
 by smtp4.osuosl.org (Postfix) with ESMTPS id 9770941740
 for <virtualization@lists.linux-foundation.org>;
 Tue, 26 Sep 2023 02:32:56 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org 9770941740
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1695695575;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=x0JluPBGhmVM8tVgilHr9/e0vzuVc6qwOToBxrpulzw=;
 b=XkjQzBQkQQe9LqJNfWtMiRCMddyWu3j8MaubNDNgP7J0vIO3dLG9fUVL4q++i94wGvMHbz
 paozykxSJEDMIKwBdsGDqHQz+H2wcm74VC+G3xEb/BLDf2oId2B3IvUO2/CiceNW6A+oq8
 VC0T4HUhiZbrDK5w9fd4K8NDlBds75k=
Received: from mail-lf1-f71.google.com (mail-lf1-f71.google.com
 [209.85.167.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-59-LGHCCPY7NKKJbElqKFSBZA-1; Mon, 25 Sep 2023 22:32:53 -0400
X-MC-Unique: LGHCCPY7NKKJbElqKFSBZA-1
Received: by mail-lf1-f71.google.com with SMTP id
 2adb3069b0e04-504319087d9so10237171e87.1
 for <virtualization@lists.linux-foundation.org>;
 Mon, 25 Sep 2023 19:32:52 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1695695571; x=1696300371;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=x0JluPBGhmVM8tVgilHr9/e0vzuVc6qwOToBxrpulzw=;
 b=JWJwiUnEo1Q+y28UtamRg95rV34nNrdNTeRuaAXqTXAxIWBZgrjeEtGBScjQgSJKa5
 q7oGkf8y/oX5ZT66pj+kWPduNVaNVSe45mTby8UwBIAQgdVHgwLI4meca8mD1KbbzD+2
 qn+oJ8/bXGZCOr+uiacK566cQZrAt9IBjZ3PZXh9WTNiewEs16I+PJQl1ZvNxIyZB8lO
 En9bEn3Zd7Sea7ncAznjelMyN00Na8pXvXBKrxhjBoaPstWwUyaW/Soy+xCdxRH8J5AD
 zV/ttpB0/h/hZOZF/wWoE9Kpm5XPYKapjkYnNFTGvUm9ddHqIdfmjNU9MmiG3AEIn6Xb
 ZGEg==
X-Gm-Message-State: AOJu0YzZr1xHTGFxYiaIyBNpHfHuDnkCmxfrG9Jfgxi05ylCWU2MpFhA
 pFh0uk2/kSnD7D/cn1NrCNcHvJkUuLoP7mSa8kCbG1B+4J19dz/ObsML8sGDD4YqPDjGjEFXdXO
 PWnHRx6aeCQdneNOsx9geQtRO5+2D/yIfVU9ZnmJaAGTNqVP9cSmR1oANmQ==
X-Received: by 2002:a19:8c13:0:b0:503:9eb:d277 with SMTP id
 o19-20020a198c13000000b0050309ebd277mr6080324lfd.49.1695695571772; 
 Mon, 25 Sep 2023 19:32:51 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IE98wMaflBrXS+gHoxgs9l/TJJU2TyupUMywrdMyEJRf1bCQcDZI9jAcScVJR/3wSInoaBGHXT/cPoSMhPJERc=
X-Received: by 2002:a19:8c13:0:b0:503:9eb:d277 with SMTP id
 o19-20020a198c13000000b0050309ebd277mr6080308lfd.49.1695695571442; Mon, 25
 Sep 2023 19:32:51 -0700 (PDT)
MIME-Version: 1.0
References: <20230921125348-mutt-send-email-mst@kernel.org>
 <20230921170709.GS13733@nvidia.com>
 <20230921131035-mutt-send-email-mst@kernel.org>
 <20230921174450.GT13733@nvidia.com>
 <20230921135426-mutt-send-email-mst@kernel.org>
 <20230921181637.GU13733@nvidia.com>
 <20230921152802-mutt-send-email-mst@kernel.org>
 <20230921195345.GZ13733@nvidia.com>
 <20230921155834-mutt-send-email-mst@kernel.org>
 <CACGkMEvD+cTyRtax7_7TBNECQcGPcsziK+jCBgZcLJuETbyjYw@mail.gmail.com>
 <20230922122246.GN13733@nvidia.com>
 <PH0PR12MB548127753F25C45B7EFF203DDCFFA@PH0PR12MB5481.namprd12.prod.outlook.com>
 <CACGkMEuX5HJVBOw9E+skr=K=QzH3oyHK8gk-r0hAvi6Wm7OA7Q@mail.gmail.com>
 <PH0PR12MB5481ED78F7467EEB0740847EDCFCA@PH0PR12MB5481.namprd12.prod.outlook.com>
In-Reply-To: <PH0PR12MB5481ED78F7467EEB0740847EDCFCA@PH0PR12MB5481.namprd12.prod.outlook.com>
From: Jason Wang <jasowang@redhat.com>
Date: Tue, 26 Sep 2023 10:32:39 +0800
Message-ID: <CACGkMEv9_+6sYp1JZpCZr19csg0jO-jLVhuygWqm+s9mWr3Lew@mail.gmail.com>
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

T24gTW9uLCBTZXAgMjUsIDIwMjMgYXQgNDoyNuKAr1BNIFBhcmF2IFBhbmRpdCA8cGFyYXZAbnZp
ZGlhLmNvbT4gd3JvdGU6Cj4KPgo+Cj4gPiBGcm9tOiBKYXNvbiBXYW5nIDxqYXNvd2FuZ0ByZWRo
YXQuY29tPgo+ID4gU2VudDogTW9uZGF5LCBTZXB0ZW1iZXIgMjUsIDIwMjMgODowMCBBTQo+ID4K
PiA+IE9uIEZyaSwgU2VwIDIyLCAyMDIzIGF0IDg6MjXigK9QTSBQYXJhdiBQYW5kaXQgPHBhcmF2
QG52aWRpYS5jb20+IHdyb3RlOgo+ID4gPgo+ID4gPgo+ID4gPiA+IEZyb206IEphc29uIEd1bnRo
b3JwZSA8amdnQG52aWRpYS5jb20+Cj4gPiA+ID4gU2VudDogRnJpZGF5LCBTZXB0ZW1iZXIgMjIs
IDIwMjMgNTo1MyBQTQo+ID4gPgo+ID4gPgo+ID4gPiA+ID4gQW5kIHdoYXQncyBtb3JlLCB1c2lu
ZyBNTUlPIEJBUjAgdGhlbiBpdCBjYW4gd29yayBmb3IgbGVnYWN5Lgo+ID4gPiA+Cj4gPiA+ID4g
T2g/IEhvdz8gT3VyIHRlYW0gZGlkbid0IHRoaW5rIHNvLgo+ID4gPgo+ID4gPiBJdCBkb2VzIG5v
dC4gSXQgd2FzIGFscmVhZHkgZGlzY3Vzc2VkLgo+ID4gPiBUaGUgZGV2aWNlIHJlc2V0IGluIGxl
Z2FjeSBpcyBub3Qgc3luY2hyb25vdXMuCj4gPgo+ID4gSG93IGRvIHlvdSBrbm93IHRoaXM/Cj4g
Pgo+IE5vdCBzdXJlIHRoZSBtb3RpdmF0aW9uIG9mIHNhbWUgZGlzY3Vzc2lvbiBkb25lIGluIHRo
ZSBPQVNJUyB3aXRoIHlvdSBhbmQgb3RoZXJzIGluIHBhc3QuCgpUaGF0IGlzIGV4YWN0bHkgdGhl
IHNhbWUgcG9pbnQuCgpJdCdzIHRvbyBsYXRlIHRvIGRlZmluZSB0aGUgbGVnYWN5IGJlaGF2aW91
ciBhY2N1cmF0ZWx5IGluIHRoZSBzcGVjIHNvCnBlb3BsZSB3aWxsIGJlIGxvc3QgaW4gdGhlIGxl
Z2FjeSBtYXplIGVhc2lseS4KCj4KPiBBbnl3YXlzLCBwbGVhc2UgZmluZCB0aGUgYW5zd2VyIGJl
bG93Lgo+Cj4gQWJvdXQgcmVzZXQsCj4gVGhlIGxlZ2FjeSBkZXZpY2Ugc3BlY2lmaWNhdGlvbiBo
YXMgbm90IGVuZm9yY2VkIGJlbG93IGNpdGVkIDEuMCBkcml2ZXIgcmVxdWlyZW1lbnQgb2YgMS4w
Lgo+Cj4gIlRoZSBkcml2ZXIgU0hPVUxEIGNvbnNpZGVyIGEgZHJpdmVyLWluaXRpYXRlZCByZXNl
dCBjb21wbGV0ZSB3aGVuIGl0IHJlYWRzIGRldmljZSBzdGF0dXMgYXMgMC4iCgpXZSBhcmUgdGFs
a2luZyBhYm91dCBob3cgdG8gbWFrZSBkZXZpY2VzIHdvcmsgZm9yIGxlZ2FjeSBkcml2ZXJzLiBT
bwppdCBoYXMgbm90aGluZyByZWxhdGVkIHRvIDEuMC4KCj4KPiBbMV0gaHR0cHM6Ly9vemxhYnMu
b3JnL35ydXN0eS92aXJ0aW8tc3BlYy92aXJ0aW8tMC45LjUucGRmCj4KPiA+ID4gVGhlIGRyaXZl
cnMgZG8gbm90IHdhaXQgZm9yIHJlc2V0IHRvIGNvbXBsZXRlOyBpdCB3YXMgd3JpdHRlbiBmb3Ig
dGhlIHN3Cj4gPiBiYWNrZW5kLgo+ID4KPiA+IERvIHlvdSBzZWUgdGhlcmUncyBhIGZsdXNoIGFm
dGVyIHJlc2V0IGluIHRoZSBsZWdhY3kgZHJpdmVyPwo+ID4KPiBZZXMuIGl0IG9ubHkgZmx1c2hl
cyB0aGUgd3JpdGUgYnkgcmVhZGluZyBpdC4gVGhlIGRyaXZlciBkb2VzIG5vdCBnZXQgX3dhaXRf
IGZvciB0aGUgcmVzZXQgdG8gY29tcGxldGUgd2l0aGluIHRoZSBkZXZpY2UgbGlrZSBhYm92ZS4K
Ckl0J3MgdGhlIGltcGxlbWVudGF0aW9uIGRldGFpbHMgaW4gbGVnYWN5LiBUaGUgZGV2aWNlIG5l
ZWRzIHRvIG1ha2UKc3VyZSAocmVzZXQpIHRoZSBkcml2ZXIgY2FuIHdvcmsgKGlzIGRvbmUgYmVm
b3JlIGdldF9zdGF0dXMgcmV0dXJuKS4KClRoYXQncyBhbGwuCgpfX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fXwpWaXJ0dWFsaXphdGlvbiBtYWlsaW5nIGxpc3QK
VmlydHVhbGl6YXRpb25AbGlzdHMubGludXgtZm91bmRhdGlvbi5vcmcKaHR0cHM6Ly9saXN0cy5s
aW51eGZvdW5kYXRpb24ub3JnL21haWxtYW4vbGlzdGluZm8vdmlydHVhbGl6YXRpb24=
