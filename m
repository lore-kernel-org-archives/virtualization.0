Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7FC7EC001E0
	for <virtualization@archiver.kernel.org>; Wed,  2 Aug 2023 02:51:44 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id E529760AF8;
	Wed,  2 Aug 2023 02:51:43 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org E529760AF8
Authentication-Results: smtp3.osuosl.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=Ui1hKEkZ
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
	by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id hDSwNgDv0Zah; Wed,  2 Aug 2023 02:51:42 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp3.osuosl.org (Postfix) with ESMTPS id 3772E60739;
	Wed,  2 Aug 2023 02:51:42 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 3772E60739
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 069E5C0071;
	Wed,  2 Aug 2023 02:51:42 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [IPv6:2605:bc80:3010::133])
 by lists.linuxfoundation.org (Postfix) with ESMTP id E7B7AC0032
 for <virtualization@lists.linux-foundation.org>;
 Wed,  2 Aug 2023 02:51:40 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id B91A240445
 for <virtualization@lists.linux-foundation.org>;
 Wed,  2 Aug 2023 02:51:40 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org B91A240445
Authentication-Results: smtp2.osuosl.org;
 dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com
 header.a=rsa-sha256 header.s=mimecast20190719 header.b=Ui1hKEkZ
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id 0DZjqIyujyHb
 for <virtualization@lists.linux-foundation.org>;
 Wed,  2 Aug 2023 02:51:39 +0000 (UTC)
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.129.124])
 by smtp2.osuosl.org (Postfix) with ESMTPS id 671BD40121
 for <virtualization@lists.linux-foundation.org>;
 Wed,  2 Aug 2023 02:51:39 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org 671BD40121
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1690944698;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=gnB8l46sLYgDywYxEJydmMqQZMbbUuJEWlWKa6HccxY=;
 b=Ui1hKEkZSP8HwcrDBopu7HtVP/cJiIfvZUjXtrULIFEp8xUNrZb+6N0ra5zBLQ1yBI+dD7
 C2TYPn1A2vkc/7I9RSIKSpUG4KnEnS2igS53jy+VY0LGarEIeieklmuwC0ZoRrEFGh71OU
 FGsMNAg1B2lhX2daastBw5c3FKh9SVY=
Received: from mail-lj1-f197.google.com (mail-lj1-f197.google.com
 [209.85.208.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-573-Lj_H3I73PfqozmzCaD62eg-1; Tue, 01 Aug 2023 22:51:36 -0400
X-MC-Unique: Lj_H3I73PfqozmzCaD62eg-1
Received: by mail-lj1-f197.google.com with SMTP id
 38308e7fff4ca-2b9ba719605so68642411fa.0
 for <virtualization@lists.linux-foundation.org>;
 Tue, 01 Aug 2023 19:51:36 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1690944694; x=1691549494;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=gnB8l46sLYgDywYxEJydmMqQZMbbUuJEWlWKa6HccxY=;
 b=aAkSVim/Sy9Z8MSGe2Trr3l9Kq8oNeHOqSQCeBNB7Z4uB7nMQX1nZQmy7f82lQt//L
 3HJwBGi3pulxhcGj3KKqLk8FbrGuXKGCxGVTjY0DRg1RgXOermw+3AH6ikbTfUv5eMXS
 1JriJn5DfdeMTM2vvUjxePs+3/QZuvE2B2WxNdWAMKdXnOR6aCl/V2jBNwcd5F7PsrcW
 Lohnb8mNpx1uUjz6wVm/jMLgNAncqnsvQUxUPmHShG3sCz/NuF89MK+64bIChhj7hhtm
 2lWshsCp9/CVvldKaiZ4Zc5e4YfhSfzzmwsgPlTqmg+ZymjYrmE8t5VwM/2O+gk/RGyr
 Shhg==
X-Gm-Message-State: ABy/qLYKOU4bg6rL+cdocXOFMQi16QNClZa6oB5AJqmVEe+O7QuG5s9I
 EMqMfpNs7jqz0/5mGyg1610nEDOZs0SvLWdanFdFsvvTVoYQL4C4G/MoNQnYZixflkmV3Y97dhZ
 v4kEBRrZCNwNJiWncN3NRYKJ6Rrc7ApKVrlqn5n+VQOcqmsuweWagB3F8VQ==
X-Received: by 2002:a2e:93d7:0:b0:2b9:48f1:b193 with SMTP id
 p23-20020a2e93d7000000b002b948f1b193mr3591047ljh.46.1690944694451; 
 Tue, 01 Aug 2023 19:51:34 -0700 (PDT)
X-Google-Smtp-Source: APBJJlGcsCsrj00r7RkBkqUnPfn4ZD12lA23g1iJmQi+QyRcoOo888/DfI6dipdzX+66ZNI4sSHRvzrgpwua7urDFeo=
X-Received: by 2002:a2e:93d7:0:b0:2b9:48f1:b193 with SMTP id
 p23-20020a2e93d7000000b002b948f1b193mr3591035ljh.46.1690944694091; Tue, 01
 Aug 2023 19:51:34 -0700 (PDT)
MIME-Version: 1.0
References: <20230726190744.14143-1-dtatulea@nvidia.com>
 <20230726152258-mutt-send-email-mst@kernel.org>
 <3ae9e8919a9316d06d7bb507698c820ac6194f45.camel@nvidia.com>
 <20230727122633-mutt-send-email-mst@kernel.org>
 <b97484f15824c86f5cee4fe673794f17419bcb1b.camel@nvidia.com>
 <20230731050200-mutt-send-email-mst@kernel.org>
 <CACGkMEtiwNjq4pMVY-Yvgo3+DihMP5zO+q+HH-xAF+Xu_=gbHg@mail.gmail.com>
 <39c3be5dd59e67e7b5dd301100e96aa9428bc332.camel@nvidia.com>
In-Reply-To: <39c3be5dd59e67e7b5dd301100e96aa9428bc332.camel@nvidia.com>
From: Jason Wang <jasowang@redhat.com>
Date: Wed, 2 Aug 2023 10:51:22 +0800
Message-ID: <CACGkMEueOXgjbr9Q0Tw5Bv-=YH9+5UR9jxttrf6hN-VRK9KtMg@mail.gmail.com>
Subject: Re: [PATCH] vdpa/mlx5: Fix crash on shutdown for when no ndev exists
To: Dragos Tatulea <dtatulea@nvidia.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Cc: "xuanzhuo@linux.alibaba.com" <xuanzhuo@linux.alibaba.com>,
 bhe <bhe@redhat.com>, "mst@redhat.com" <mst@redhat.com>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
 "stable@vger.kernel.org" <stable@vger.kernel.org>,
 "virtualization@lists.linux-foundation.org"
 <virtualization@lists.linux-foundation.org>, ruyang <ruyang@redhat.com>,
 eperezma <eperezma@redhat.com>, Saeed Mahameed <saeedm@nvidia.com>
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

T24gVHVlLCBBdWcgMSwgMjAyMyBhdCA0OjE34oCvUE0gRHJhZ29zIFRhdHVsZWEgPGR0YXR1bGVh
QG52aWRpYS5jb20+IHdyb3RlOgo+Cj4gT24gVHVlLCAyMDIzLTA4LTAxIGF0IDExOjU5ICswODAw
LCBKYXNvbiBXYW5nIHdyb3RlOgo+ID4gT24gTW9uLCBKdWwgMzEsIDIwMjMgYXQgNTowOOKAr1BN
IE1pY2hhZWwgUy4gVHNpcmtpbiA8bXN0QHJlZGhhdC5jb20+IHdyb3RlOgo+ID4gPgo+ID4gPiBP
biBNb24sIEp1bCAzMSwgMjAyMyBhdCAwNzoxNTozMUFNICswMDAwLCBEcmFnb3MgVGF0dWxlYSB3
cm90ZToKPiA+ID4gPiBPbiBUaHUsIDIwMjMtMDctMjcgYXQgMTI6MjggLTA0MDAsIE1pY2hhZWwg
Uy4gVHNpcmtpbiB3cm90ZToKPiA+ID4gPiA+IE9uIFRodSwgSnVsIDI3LCAyMDIzIGF0IDA0OjAy
OjE2UE0gKzAwMDAsIERyYWdvcyBUYXR1bGVhIHdyb3RlOgo+ID4gPiA+ID4gPiBPbiBXZWQsIDIw
MjMtMDctMjYgYXQgMTU6MjYgLTA0MDAsIE1pY2hhZWwgUy4gVHNpcmtpbiB3cm90ZToKPiA+ID4g
PiA+ID4gPiBPbiBXZWQsIEp1bCAyNiwgMjAyMyBhdCAxMDowNzozOFBNICswMzAwLCBEcmFnb3Mg
VGF0dWxlYSB3cm90ZToKPiA+ID4gPiA+ID4gPiA+IFRoZSBuZGV2IHdhcyBhY2Nlc3NlZCBvbiBz
aHV0ZG93biB3aXRob3V0IGEgY2hlY2sgaWYgaXQgYWN0dWFsbHkKPiA+ID4gPiA+ID4gPiA+IGV4
aXN0cy4KPiA+ID4gPiA+ID4gPiA+IFRoaXMgdHJpZ2dlcmVkIHRoZSBjcmFzaCBwYXN0ZWQgYmVs
b3cuIFRoaXMgcGF0Y2ggc2ltcGx5IGFkZHMgYQo+ID4gPiA+ID4gPiA+ID4gY2hlY2sKPiA+ID4g
PiA+ID4gPiA+IGJlZm9yZSB1c2luZyBuZGV2Lgo+ID4gPiA+ID4gPiA+ID4KPiA+ID4gPiA+ID4g
PiA+ICBCVUc6IGtlcm5lbCBOVUxMIHBvaW50ZXIgZGVyZWZlcmVuY2UsIGFkZHJlc3M6IDAwMDAw
MDAwMDAwMDAzMDAKPiA+ID4gPiA+ID4gPiA+ICAjUEY6IHN1cGVydmlzb3IgcmVhZCBhY2Nlc3Mg
aW4ga2VybmVsIG1vZGUKPiA+ID4gPiA+ID4gPiA+ICAjUEY6IGVycm9yX2NvZGUoMHgwMDAwKSAt
IG5vdC1wcmVzZW50IHBhZ2UKPiA+ID4gPiA+ID4gPiA+ICBQR0QgMCBQNEQgMAo+ID4gPiA+ID4g
PiA+ID4gIE9vcHM6IDAwMDAgWyMxXSBTTVAKPiA+ID4gPiA+ID4gPiA+ICBDUFU6IDAgUElEOiAx
IENvbW06IHN5c3RlbWQtc2h1dGRvdyBOb3QgdGFpbnRlZCA2LjUuMC0KPiA+ID4gPiA+ID4gPiA+
IHJjMl9mb3JfdXBzdHJlYW1fbWluX2RlYnVnXzIwMjNfMDdfMTdfMTVfMDUgIzEKPiA+ID4gPiA+
ID4gPiA+ICBIYXJkd2FyZSBuYW1lOiBRRU1VIFN0YW5kYXJkIFBDIChRMzUgKyBJQ0g5LCAyMDA5
KSwgQklPUyByZWwtCj4gPiA+ID4gPiA+ID4gPiAxLjEzLjAtMC0KPiA+ID4gPiA+ID4gPiA+IGdm
MjFiNWE0YWViMDItcHJlYnVpbHQucWVtdS5vcmcgMDQvMDEvMjAxNAo+ID4gPiA+ID4gPiA+ID4g
IFJJUDogMDAxMDptbHg1dl9zaHV0ZG93bisweGUvMHg1MCBbbWx4NV92ZHBhXQo+ID4gPiA+ID4g
PiA+ID4gIFJTUDogMDAxODpmZmZmODg4MTAwM2JmZGMwIEVGTEFHUzogMDAwMTAyODYKPiA+ID4g
PiA+ID4gPiA+ICBSQVg6IGZmZmY4ODgxMDNiZWZiYTAgUkJYOiBmZmZmODg4MTA5ZDI4MDA4IFJD
WDogMDAwMDAwMDAwMDAwMDAxNwo+ID4gPiA+ID4gPiA+ID4gIFJEWDogMDAwMDAwMDAwMDAwMDAw
MSBSU0k6IDAwMDAwMDAwMDAwMDAyMTIgUkRJOiBmZmZmODg4MTA5ZDI4MDAwCj4gPiA+ID4gPiA+
ID4gPiAgUkJQOiAwMDAwMDAwMDAwMDAwMDAwIFIwODogMDAwMDAwMGQzYTNhMzg4MiBSMDk6IDAw
MDAwMDAwMDAwMDAwMDEKPiA+ID4gPiA+ID4gPiA+ICBSMTA6IDAwMDAwMDAwMDAwMDAwMDAgUjEx
OiAwMDAwMDAwMDAwMDAwMDAwIFIxMjogZmZmZjg4ODEwOWQyODAwMAo+ID4gPiA+ID4gPiA+ID4g
IFIxMzogZmZmZjg4ODEwOWQyODA4MCBSMTQ6IDAwMDAwMDAwZmVlMWRlYWQgUjE1OiAwMDAwMDAw
MDAwMDAwMDAwCj4gPiA+ID4gPiA+ID4gPiAgRlM6ICAwMDAwN2Y0OTY5ZTBiZTQwKDAwMDApIEdT
OmZmZmY4ODg1MmM4MDAwMDAoMDAwMCkKPiA+ID4gPiA+ID4gPiA+IGtubEdTOjAwMDAwMDAwMDAw
MDAwMDAKPiA+ID4gPiA+ID4gPiA+ICBDUzogIDAwMTAgRFM6IDAwMDAgRVM6IDAwMDAgQ1IwOiAw
MDAwMDAwMDgwMDUwMDMzCj4gPiA+ID4gPiA+ID4gPiAgQ1IyOiAwMDAwMDAwMDAwMDAwMzAwIENS
MzogMDAwMDAwMDEwNTFjZDAwNiBDUjQ6IDAwMDAwMDAwMDAzNzBlYjAKPiA+ID4gPiA+ID4gPiA+
ICBEUjA6IDAwMDAwMDAwMDAwMDAwMDAgRFIxOiAwMDAwMDAwMDAwMDAwMDAwIERSMjogMDAwMDAw
MDAwMDAwMDAwMAo+ID4gPiA+ID4gPiA+ID4gIERSMzogMDAwMDAwMDAwMDAwMDAwMCBEUjY6IDAw
MDAwMDAwZmZmZTBmZjAgRFI3OiAwMDAwMDAwMDAwMDAwNDAwCj4gPiA+ID4gPiA+ID4gPiAgQ2Fs
bCBUcmFjZToKPiA+ID4gPiA+ID4gPiA+ICAgPFRBU0s+Cj4gPiA+ID4gPiA+ID4gPiAgID8gX19k
aWUrMHgyMC8weDYwCj4gPiA+ID4gPiA+ID4gPiAgID8gcGFnZV9mYXVsdF9vb3BzKzB4MTRjLzB4
M2MwCj4gPiA+ID4gPiA+ID4gPiAgID8gZXhjX3BhZ2VfZmF1bHQrMHg3NS8weDE0MAo+ID4gPiA+
ID4gPiA+ID4gICA/IGFzbV9leGNfcGFnZV9mYXVsdCsweDIyLzB4MzAKPiA+ID4gPiA+ID4gPiA+
ICAgPyBtbHg1dl9zaHV0ZG93bisweGUvMHg1MCBbbWx4NV92ZHBhXQo+ID4gPiA+ID4gPiA+ID4g
ICBkZXZpY2Vfc2h1dGRvd24rMHgxM2UvMHgxZTAKPiA+ID4gPiA+ID4gPiA+ICAga2VybmVsX3Jl
c3RhcnQrMHgzNi8weDkwCj4gPiA+ID4gPiA+ID4gPiAgIF9fZG9fc3lzX3JlYm9vdCsweDE0MS8w
eDIxMAo+ID4gPiA+ID4gPiA+ID4gICA/IHZmc193cml0ZXYrMHhjZC8weDE0MAo+ID4gPiA+ID4g
PiA+ID4gICA/IGhhbmRsZV9tbV9mYXVsdCsweDE2MS8weDI2MAo+ID4gPiA+ID4gPiA+ID4gICA/
IGRvX3dyaXRldisweDZiLzB4MTEwCj4gPiA+ID4gPiA+ID4gPiAgIGRvX3N5c2NhbGxfNjQrMHgz
ZC8weDkwCj4gPiA+ID4gPiA+ID4gPiAgIGVudHJ5X1NZU0NBTExfNjRfYWZ0ZXJfaHdmcmFtZSsw
eDQ2LzB4YjAKPiA+ID4gPiA+ID4gPiA+ICBSSVA6IDAwMzM6MHg3ZjQ5Njk5MGZiNTYKPiA+ID4g
PiA+ID4gPiA+ICBSU1A6IDAwMmI6MDAwMDdmZmZjN2JkZGU4OCBFRkxBR1M6IDAwMDAwMjA2IE9S
SUdfUkFYOgo+ID4gPiA+ID4gPiA+ID4gMDAwMDAwMDAwMDAwMDBhOQo+ID4gPiA+ID4gPiA+ID4g
IFJBWDogZmZmZmZmZmZmZmZmZmZkYSBSQlg6IDAwMDAwMDAwMDAwMDAwMDAgUkNYOiAwMDAwN2Y0
OTY5OTBmYjU2Cj4gPiA+ID4gPiA+ID4gPiAgUkRYOiAwMDAwMDAwMDAxMjM0NTY3IFJTSTogMDAw
MDAwMDAyODEyMTk2OSBSREk6IGZmZmZmZmZmZmVlMWRlYWQKPiA+ID4gPiA+ID4gPiA+ICBSQlA6
IDAwMDA3ZmZmYzdiZGUxZDAgUjA4OiAwMDAwMDAwMDAwMDAwMDAwIFIwOTogMDAwMDAwMDAwMDAw
MDAwMAo+ID4gPiA+ID4gPiA+ID4gIFIxMDogMDAwMDAwMDAwMDAwMDAwMCBSMTE6IDAwMDAwMDAw
MDAwMDAyMDYgUjEyOiAwMDAwMDAwMDAwMDAwMDAwCj4gPiA+ID4gPiA+ID4gPiAgUjEzOiAwMDAw
N2ZmZmM3YmRkZjEwIFIxNDogMDAwMDAwMDAwMDAwMDAwMCBSMTU6IDAwMDA3ZmZmYzdiZGUyYjgK
PiA+ID4gPiA+ID4gPiA+ICAgPC9UQVNLPgo+ID4gPiA+ID4gPiA+ID4gIENSMjogMDAwMDAwMDAw
MDAwMDMwMAo+ID4gPiA+ID4gPiA+ID4gIC0tLVsgZW5kIHRyYWNlIDAwMDAwMDAwMDAwMDAwMDAg
XS0tLQo+ID4gPiA+ID4gPiA+ID4KPiA+ID4gPiA+ID4gPiA+IEZpeGVzOiBiYzlhMmIzZTY4NmUg
KCJ2ZHBhL21seDU6IFN1cHBvcnQgaW50ZXJydXB0IGJ5cGFzc2luZyIpCj4gPiA+ID4gPiA+ID4g
PiBTaWduZWQtb2ZmLWJ5OiBEcmFnb3MgVGF0dWxlYSA8ZHRhdHVsZWFAbnZpZGlhLmNvbT4KPiA+
ID4gPiA+ID4gPiA+IC0tLQo+ID4gPiA+ID4gPiA+ID4gIGRyaXZlcnMvdmRwYS9tbHg1L25ldC9t
bHg1X3ZuZXQuYyB8IDMgKystCj4gPiA+ID4gPiA+ID4gPiAgMSBmaWxlIGNoYW5nZWQsIDIgaW5z
ZXJ0aW9ucygrKSwgMSBkZWxldGlvbigtKQo+ID4gPiA+ID4gPiA+ID4KPiA+ID4gPiA+ID4gPiA+
IGRpZmYgLS1naXQgYS9kcml2ZXJzL3ZkcGEvbWx4NS9uZXQvbWx4NV92bmV0LmMKPiA+ID4gPiA+
ID4gPiA+IGIvZHJpdmVycy92ZHBhL21seDUvbmV0L21seDVfdm5ldC5jCj4gPiA+ID4gPiA+ID4g
PiBpbmRleCA5MTM4ZWYyZmIyYzguLmUyZTdlYmQ3MTc5OCAxMDA2NDQKPiA+ID4gPiA+ID4gPiA+
IC0tLSBhL2RyaXZlcnMvdmRwYS9tbHg1L25ldC9tbHg1X3ZuZXQuYwo+ID4gPiA+ID4gPiA+ID4g
KysrIGIvZHJpdmVycy92ZHBhL21seDUvbmV0L21seDVfdm5ldC5jCj4gPiA+ID4gPiA+ID4gPiBA
QCAtMzU1Niw3ICszNTU2LDggQEAgc3RhdGljIHZvaWQgbWx4NXZfc2h1dGRvd24oc3RydWN0Cj4g
PiA+ID4gPiA+ID4gPiBhdXhpbGlhcnlfZGV2aWNlCj4gPiA+ID4gPiA+ID4gPiAqYXV4ZGV2KQo+
ID4gPiA+ID4gPiA+ID4gICAgICAgICBtZ3RkZXYgPSBhdXhpbGlhcnlfZ2V0X2RydmRhdGEoYXV4
ZGV2KTsKPiA+ID4gPiA+ID4gPiA+ICAgICAgICAgbmRldiA9IG1ndGRldi0+bmRldjsKPiA+ID4g
PiA+ID4gPiA+Cj4gPiA+ID4gPiA+ID4gPiAtICAgICAgIGZyZWVfaXJxcyhuZGV2KTsKPiA+ID4g
PiA+ID4gPiA+ICsgICAgICAgaWYgKG5kZXYpCj4gPiA+ID4gPiA+ID4gPiArICAgICAgICAgICAg
ICAgZnJlZV9pcnFzKG5kZXYpOwo+ID4gPiA+ID4gPiA+ID4gIH0KPiA+ID4gPiA+ID4gPiA+Cj4g
PiA+ID4gPiA+ID4KPiA+ID4gPiA+ID4gPiBzb21ldGhpbmcgSSBkb24ndCBnZXQ6Cj4gPiA+ID4g
PiA+ID4gaXJxcyBhcmUgYWxsb2NhdGVkIGluIG1seDVfdmRwYV9kZXZfYWRkCj4gPiA+ID4gPiA+
ID4gd2h5IGFyZSB0aGV5IG5vdCBmcmVlZCBpbiBtbHg1X3ZkcGFfZGV2X2RlbD8KPiA+ID4gPiA+
ID4gPgo+ID4gPiA+ID4gPiBUaGF0IGlzIGEgZ29vZCBwb2ludC4gSSB3aWxsIHRyeSB0byBmaW5k
IG91dC4gSSBhbHNvIGRvbid0IGdldCB3aHkKPiA+ID4gPiA+ID4gZnJlZV9pcnEKPiA+ID4gPiA+
ID4gaXMKPiA+ID4gPiA+ID4gY2FsbGVkIGluIHRoZSB2ZHBhIGRldiAuZnJlZSBvcCBpbnN0ZWFk
IG9mIG1seDVfdmRwYV9kZXZfZGVsLiBNYXliZSBJCj4gPiA+ID4gPiA+IGNhbgo+ID4gPiA+ID4g
PiBjaGFuZ2UKPiA+ID4gPiA+ID4gdGhhdCBpbiBhIGRpZmZlcmVudCByZWZhY3RvcmluZy4KPiA+
ID4gPiA+Cj4gPiA+ID4gPiBhcyBpdCBpcyBJIGhhdmUgbm8gaWRlYSB3aGV0aGVyIGUuZy4gbmRl
diBjYW4gY2hhbmdlCj4gPiA+ID4gPiBiZXR3ZWVuIHRoZXNlIHR3byBjYWxsIHNpdGVzLiB0aGF0
IHdvdWxkIG1ha2UgdGhlIGNoZWNrCj4gPiA+ID4gPiBwb2ludGxlc3MuCj4gPiA+ID4gPgo+ID4g
PiA+ID4gPiA+IHRoaXMgaXMgd2hhdCdzIGNyZWF0aW5nIGFsbCB0aGlzIG1lc3MuCj4gPiA+ID4g
PiA+ID4KPiA+ID4gPiA+ID4gPgo+ID4gPiA+ID4gPiBOb3QgcXVpdGU6IG1seDVfdmRwYV9kZXZf
ZGVsICh3aGljaCBpcyBhIC5kZXZfZGVsIG9mIGZvciBzdHJ1Y3QKPiA+ID4gPiA+ID4gdmRwYV9t
Z210ZGV2X29wcykgZG9lc24ndCBnZXQgY2FsbGVkIG9uIHNodXRkb3duLiBBdCBsZWFzdCB0aGF0
J3Mgd2hhdAo+ID4gPiA+ID4gPiBJCj4gPiA+ID4gPiA+IHNlZS4gT3IKPiA+ID4gPiA+ID4gYW0g
SSBtaXNzaW5nIHNvbWV0aGluZz8KPiA+ID4gPiA+Cj4gPiA+ID4gPiBhbmQgd2h5IGRvIHdlIGNh
cmUgd2hldGhlciBpcnFzIGFyZSBmcmVlZCBvbiBzaHV0ZG93bj8KPiA+ID4gPiA+Cj4gPiA+ID4g
SGFkIHRvIGFzayBhcm91bmQgYSBiaXQgdG8gZmluZCBvdXQgdGhlIGFuc3dlcjogdGhlcmUgY2Fu
IGJlIGlzc3VlcyB3aXRoCj4gPiA+ID4ga2V4ZWMKPiA+ID4gPiBJUlEgYWxsb2NhdGlvbiBvbiBz
b21lIHBsYXRmb3Jtcy4gSXQgaXMgZG9jdW1lbnRlZCBoZXJlIFswXSBmb3IgbWx4NV9jb3JlLgo+
ID4gPiA+Cj4gPiA+ID4gaHR0cHM6Ly9naXQua2VybmVsLm9yZy9wdWIvc2NtL2xpbnV4L2tlcm5l
bC9naXQvdG9ydmFsZHMvbGludXguZ2l0L3RyZWUvZHJpdmVycy9uZXQvZXRoZXJuZXQvbWVsbGFu
b3gvbWx4NS9jb3JlL21haW4uYyNuMjEyOQo+ID4gPiA+Cj4gPiA+ID4gVGhhbmtzLAo+ID4gPiA+
IERyYWdvcwo+ID4gPgo+ID4gPiBJdCdzIHF1aXRlIHdlaXJkLgo+ID4gPiAgICAgICAgICAqIFNv
bWUgcGxhdGZvcm1zIHJlcXVpcmluZyBmcmVlaW5nIHRoZSBJUlEncyBpbiB0aGUgc2h1dGRvd24K
PiA+ID4gICAgICAgICAgKiBmbG93LiBJZiB0aGV5IGFyZW4ndCBmcmVlZCB0aGV5IGNhbid0IGJl
IGFsbG9jYXRlZCBhZnRlcgo+ID4gPiAgICAgICAgICAqIGtleGVjLiBUaGVyZSBpcyBubyBuZWVk
IHRvIGNsZWFudXAgdGhlIG1seDVfY29yZSBzb2Z0d2FyZQo+ID4gPiAgICAgICAgICAqIGNvbnRl
eHRzLgo+ID4gPgo+ID4gPiBidXQgbW9zdCBkcml2ZXJzIGRvbid0IGhhdmUgYSBzaHV0ZG93biBj
YWxsYmFjayBob3cgZG8gdGhleSB3b3JrIHRoZW4/Cj4gPiA+IGRvIHlvdSBrbm93IHdoaWNoIHBs
YXRmb3JtcyB0aGVzZSBhcmU/Cj4gPgo+IEkgZG9uJ3QuIHg4Nl82NCBpcyBub3Qgb25lIG9mIHRo
ZW0gdGhvdWdoLiBJIHdpbGwgZG8gc29tZSBtb3JlIGRpZ2dpbmcgLi4uCj4KPiA+IFRoZXJlIHVz
ZWQgdG8gYmUgYnpzIHRoYXQgcmVxdWlyZXMgdmlydGlvIGRyaXZlcnMgdG8gYWRkIGEgc2h1dGRv
d24gdG8KPiA+IGZpeCBrZXhlYzoKPiA+Cj4gPiBodHRwczovL2J1Z3ppbGxhLnJlZGhhdC5jb20v
c2hvd19idWcuY2dpP2lkPTIxMDg0MDYKPiA+Cj4gSSBkb24ndCBoYXZlIGFjY2VzcyB0byB0aGlz
LiBXaGF0IGlzIGl0IGFib3V0PwoKVGhpcyBidWcgbWlnaHQgYmUgbW9yZSBhY2N1cmF0ZToKCmh0
dHBzOi8vYnVnemlsbGEucmVkaGF0LmNvbS9zaG93X2J1Zy5jZ2k/aWQ9MTgyMDUyMQoKSXQncyBh
Ym91dCB0aGUga2V4ZWMgZ3V5cyAoY2NlZCByZWxldmFudCBwZW9wbGUpIHdhbnRpbmcgdG8gYWRk
IGEKc2h1dGRvd24gbWV0aG9kIGZvciB2aXJpdG8gdG8gZml4IHBvdGVudGlhbCBrZXhlYyBpc3N1
ZXMuCgpUaGFua3MKCj4KPiBUaGFua3MsCj4gRHJhZ29zCj4gPiBUaGFua3MKPiA+Cj4gPiA+Cj4g
PiA+IEkgZG9uJ3QgcmVhbGx5IGtub3cgbXVjaCBhYm91dCB3aHkgc2h1dGRvd24gY2FsbGJhY2sg
aXMgZXZlbiBuZWNlc3NhcnkuCj4gPiA+IEkgZ3Vlc3MgdGhpcyBpcyB0byBkZXRlY3Qgc2h1dGRv
d24gYW5kIGRvIGEgZmFzdGVyIGNsZWFudXAgdGhhbgo+ID4gPiB0aGUgc2xvdywgZ3JhY2VmdWwg
cmVtb3ZhbCwganVzdCBjbGVhbmluZyBoYXJkd2FyZSByZXNvdXJjZXM/Cj4gPiA+Cj4gPiA+Cj4g
PiA+IC0tCj4gPiA+IE1TVAo+ID4gPgo+ID4KPgoKX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX18KVmlydHVhbGl6YXRpb24gbWFpbGluZyBsaXN0ClZpcnR1YWxp
emF0aW9uQGxpc3RzLmxpbnV4LWZvdW5kYXRpb24ub3JnCmh0dHBzOi8vbGlzdHMubGludXhmb3Vu
ZGF0aW9uLm9yZy9tYWlsbWFuL2xpc3RpbmZvL3ZpcnR1YWxpemF0aW9u
