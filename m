Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0B3A4EB64DD
	for <virtualization@archiver.kernel.org>; Tue,  1 Aug 2023 03:59:33 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 6746C60067;
	Tue,  1 Aug 2023 03:59:33 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 6746C60067
Authentication-Results: smtp3.osuosl.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=iyvJGwjU
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
	by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id ovNh_ErfdiSH; Tue,  1 Aug 2023 03:59:31 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp3.osuosl.org (Postfix) with ESMTPS id 2BB4760FE0;
	Tue,  1 Aug 2023 03:59:31 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 2BB4760FE0
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id DE546C0071;
	Tue,  1 Aug 2023 03:59:30 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [IPv6:2605:bc80:3010::136])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 07258C0032
 for <virtualization@lists.linux-foundation.org>;
 Tue,  1 Aug 2023 03:59:30 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id D014160B9B
 for <virtualization@lists.linux-foundation.org>;
 Tue,  1 Aug 2023 03:59:29 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org D014160B9B
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id N194d73UQLsA
 for <virtualization@lists.linux-foundation.org>;
 Tue,  1 Aug 2023 03:59:26 +0000 (UTC)
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.133.124])
 by smtp3.osuosl.org (Postfix) with ESMTPS id B66CC60C02
 for <virtualization@lists.linux-foundation.org>;
 Tue,  1 Aug 2023 03:59:26 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org B66CC60C02
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1690862365;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=Dza8jMKV3xIyM3BPcCMbgn0dYv6gyaAqEL73HkVbBbk=;
 b=iyvJGwjUxdLKu4ZzYHV+wwWLzqh2l54F6gmnYGzgrTE2tM3q24F2EzRdBZVAB587vfpTbd
 igLHQopPyKxtPmYOIl1Xbn43xRbt6wMbRXnYH4LaYWgzSScx0tuLrgMSy2+aTNoPIRY2rl
 3u1Yr226P4W07O79Mjd8kvtOazJnjrk=
Received: from mail-lj1-f200.google.com (mail-lj1-f200.google.com
 [209.85.208.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-14-Y05u8dvMOMe8aDrU_26qmg-1; Mon, 31 Jul 2023 23:59:18 -0400
X-MC-Unique: Y05u8dvMOMe8aDrU_26qmg-1
Received: by mail-lj1-f200.google.com with SMTP id
 38308e7fff4ca-2b9cd6a555aso31132301fa.3
 for <virtualization@lists.linux-foundation.org>;
 Mon, 31 Jul 2023 20:59:18 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1690862357; x=1691467157;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=Dza8jMKV3xIyM3BPcCMbgn0dYv6gyaAqEL73HkVbBbk=;
 b=Yx0pcz73wF6bZ0MKWX+iNWUFmrKrI/JKoLr1GNahtrP99FH7erh273EZbRQH35pQjZ
 H9gZ/fCWIO88wliCb7VLgqkuVbx4GzXB4xm6ieFyEldd3qgO5DN8pL3xq86ebOmgRIZF
 HMpkCqj0eAgsJbkiYWUPYKiPT4YE6cJQzHgZlxtw+CqgZJTraUDNzggqI6BS0jggqwBZ
 yznRcpLa7sVO9D/lFlrIlfsyxMnq1onr95DqScXfp1MbqNlHqz0YzQ1rPcDUhgZWrspn
 iVkuKvzYgUwOWJvD4thrKs2hbCF2ylhy3vZ4fBEW1iF911Lhm2MYiVxJib7e7vvSlVXr
 3mdg==
X-Gm-Message-State: ABy/qLarqTIFUFDFFNkx1srtQGNy1z/FILXknDi0oYu+r1C8vounzQQ7
 BCgZb5/0KaC8v4GtkAEDVG9ow3Sl06jrzSJrgz2x71biFubUZ7jmhdcHyU0ARQvyZv/60Hc+jVm
 wbxFB7qzI/uXo2e0E8fQM+w/s/rbVtTKLaqO4yjJbSM1db/b2/rWEofQU8Q==
X-Received: by 2002:a2e:9c99:0:b0:2b9:e701:ac4d with SMTP id
 x25-20020a2e9c99000000b002b9e701ac4dmr1276626lji.26.1690862357106; 
 Mon, 31 Jul 2023 20:59:17 -0700 (PDT)
X-Google-Smtp-Source: APBJJlEFYjkfcpcJ+FsF8cYNmEuD0SEymHjz9fsPALtE1qxeEQO3oQKofSOLXC/PzAQa5+yxtXSWAuIcgIWW0MYQ+DM=
X-Received: by 2002:a2e:9c99:0:b0:2b9:e701:ac4d with SMTP id
 x25-20020a2e9c99000000b002b9e701ac4dmr1276619lji.26.1690862356799; Mon, 31
 Jul 2023 20:59:16 -0700 (PDT)
MIME-Version: 1.0
References: <20230726190744.14143-1-dtatulea@nvidia.com>
 <20230726152258-mutt-send-email-mst@kernel.org>
 <3ae9e8919a9316d06d7bb507698c820ac6194f45.camel@nvidia.com>
 <20230727122633-mutt-send-email-mst@kernel.org>
 <b97484f15824c86f5cee4fe673794f17419bcb1b.camel@nvidia.com>
 <20230731050200-mutt-send-email-mst@kernel.org>
In-Reply-To: <20230731050200-mutt-send-email-mst@kernel.org>
From: Jason Wang <jasowang@redhat.com>
Date: Tue, 1 Aug 2023 11:59:05 +0800
Message-ID: <CACGkMEtiwNjq4pMVY-Yvgo3+DihMP5zO+q+HH-xAF+Xu_=gbHg@mail.gmail.com>
Subject: Re: [PATCH] vdpa/mlx5: Fix crash on shutdown for when no ndev exists
To: "Michael S. Tsirkin" <mst@redhat.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Cc: "xuanzhuo@linux.alibaba.com" <xuanzhuo@linux.alibaba.com>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
 "stable@vger.kernel.org" <stable@vger.kernel.org>,
 "virtualization@lists.linux-foundation.org"
 <virtualization@lists.linux-foundation.org>,
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

T24gTW9uLCBKdWwgMzEsIDIwMjMgYXQgNTowOOKAr1BNIE1pY2hhZWwgUy4gVHNpcmtpbiA8bXN0
QHJlZGhhdC5jb20+IHdyb3RlOgo+Cj4gT24gTW9uLCBKdWwgMzEsIDIwMjMgYXQgMDc6MTU6MzFB
TSArMDAwMCwgRHJhZ29zIFRhdHVsZWEgd3JvdGU6Cj4gPiBPbiBUaHUsIDIwMjMtMDctMjcgYXQg
MTI6MjggLTA0MDAsIE1pY2hhZWwgUy4gVHNpcmtpbiB3cm90ZToKPiA+ID4gT24gVGh1LCBKdWwg
MjcsIDIwMjMgYXQgMDQ6MDI6MTZQTSArMDAwMCwgRHJhZ29zIFRhdHVsZWEgd3JvdGU6Cj4gPiA+
ID4gT24gV2VkLCAyMDIzLTA3LTI2IGF0IDE1OjI2IC0wNDAwLCBNaWNoYWVsIFMuIFRzaXJraW4g
d3JvdGU6Cj4gPiA+ID4gPiBPbiBXZWQsIEp1bCAyNiwgMjAyMyBhdCAxMDowNzozOFBNICswMzAw
LCBEcmFnb3MgVGF0dWxlYSB3cm90ZToKPiA+ID4gPiA+ID4gVGhlIG5kZXYgd2FzIGFjY2Vzc2Vk
IG9uIHNodXRkb3duIHdpdGhvdXQgYSBjaGVjayBpZiBpdCBhY3R1YWxseSBleGlzdHMuCj4gPiA+
ID4gPiA+IFRoaXMgdHJpZ2dlcmVkIHRoZSBjcmFzaCBwYXN0ZWQgYmVsb3cuIFRoaXMgcGF0Y2gg
c2ltcGx5IGFkZHMgYSBjaGVjawo+ID4gPiA+ID4gPiBiZWZvcmUgdXNpbmcgbmRldi4KPiA+ID4g
PiA+ID4KPiA+ID4gPiA+ID4gIEJVRzoga2VybmVsIE5VTEwgcG9pbnRlciBkZXJlZmVyZW5jZSwg
YWRkcmVzczogMDAwMDAwMDAwMDAwMDMwMAo+ID4gPiA+ID4gPiAgI1BGOiBzdXBlcnZpc29yIHJl
YWQgYWNjZXNzIGluIGtlcm5lbCBtb2RlCj4gPiA+ID4gPiA+ICAjUEY6IGVycm9yX2NvZGUoMHgw
MDAwKSAtIG5vdC1wcmVzZW50IHBhZ2UKPiA+ID4gPiA+ID4gIFBHRCAwIFA0RCAwCj4gPiA+ID4g
PiA+ICBPb3BzOiAwMDAwIFsjMV0gU01QCj4gPiA+ID4gPiA+ICBDUFU6IDAgUElEOiAxIENvbW06
IHN5c3RlbWQtc2h1dGRvdyBOb3QgdGFpbnRlZCA2LjUuMC0KPiA+ID4gPiA+ID4gcmMyX2Zvcl91
cHN0cmVhbV9taW5fZGVidWdfMjAyM18wN18xN18xNV8wNSAjMQo+ID4gPiA+ID4gPiAgSGFyZHdh
cmUgbmFtZTogUUVNVSBTdGFuZGFyZCBQQyAoUTM1ICsgSUNIOSwgMjAwOSksIEJJT1MgcmVsLTEu
MTMuMC0wLQo+ID4gPiA+ID4gPiBnZjIxYjVhNGFlYjAyLXByZWJ1aWx0LnFlbXUub3JnIDA0LzAx
LzIwMTQKPiA+ID4gPiA+ID4gIFJJUDogMDAxMDptbHg1dl9zaHV0ZG93bisweGUvMHg1MCBbbWx4
NV92ZHBhXQo+ID4gPiA+ID4gPiAgUlNQOiAwMDE4OmZmZmY4ODgxMDAzYmZkYzAgRUZMQUdTOiAw
MDAxMDI4Ngo+ID4gPiA+ID4gPiAgUkFYOiBmZmZmODg4MTAzYmVmYmEwIFJCWDogZmZmZjg4ODEw
OWQyODAwOCBSQ1g6IDAwMDAwMDAwMDAwMDAwMTcKPiA+ID4gPiA+ID4gIFJEWDogMDAwMDAwMDAw
MDAwMDAwMSBSU0k6IDAwMDAwMDAwMDAwMDAyMTIgUkRJOiBmZmZmODg4MTA5ZDI4MDAwCj4gPiA+
ID4gPiA+ICBSQlA6IDAwMDAwMDAwMDAwMDAwMDAgUjA4OiAwMDAwMDAwZDNhM2EzODgyIFIwOTog
MDAwMDAwMDAwMDAwMDAwMQo+ID4gPiA+ID4gPiAgUjEwOiAwMDAwMDAwMDAwMDAwMDAwIFIxMTog
MDAwMDAwMDAwMDAwMDAwMCBSMTI6IGZmZmY4ODgxMDlkMjgwMDAKPiA+ID4gPiA+ID4gIFIxMzog
ZmZmZjg4ODEwOWQyODA4MCBSMTQ6IDAwMDAwMDAwZmVlMWRlYWQgUjE1OiAwMDAwMDAwMDAwMDAw
MDAwCj4gPiA+ID4gPiA+ICBGUzogIDAwMDA3ZjQ5NjllMGJlNDAoMDAwMCkgR1M6ZmZmZjg4ODUy
YzgwMDAwMCgwMDAwKQo+ID4gPiA+ID4gPiBrbmxHUzowMDAwMDAwMDAwMDAwMDAwCj4gPiA+ID4g
PiA+ICBDUzogIDAwMTAgRFM6IDAwMDAgRVM6IDAwMDAgQ1IwOiAwMDAwMDAwMDgwMDUwMDMzCj4g
PiA+ID4gPiA+ICBDUjI6IDAwMDAwMDAwMDAwMDAzMDAgQ1IzOiAwMDAwMDAwMTA1MWNkMDA2IENS
NDogMDAwMDAwMDAwMDM3MGViMAo+ID4gPiA+ID4gPiAgRFIwOiAwMDAwMDAwMDAwMDAwMDAwIERS
MTogMDAwMDAwMDAwMDAwMDAwMCBEUjI6IDAwMDAwMDAwMDAwMDAwMDAKPiA+ID4gPiA+ID4gIERS
MzogMDAwMDAwMDAwMDAwMDAwMCBEUjY6IDAwMDAwMDAwZmZmZTBmZjAgRFI3OiAwMDAwMDAwMDAw
MDAwNDAwCj4gPiA+ID4gPiA+ICBDYWxsIFRyYWNlOgo+ID4gPiA+ID4gPiAgIDxUQVNLPgo+ID4g
PiA+ID4gPiAgID8gX19kaWUrMHgyMC8weDYwCj4gPiA+ID4gPiA+ICAgPyBwYWdlX2ZhdWx0X29v
cHMrMHgxNGMvMHgzYzAKPiA+ID4gPiA+ID4gICA/IGV4Y19wYWdlX2ZhdWx0KzB4NzUvMHgxNDAK
PiA+ID4gPiA+ID4gICA/IGFzbV9leGNfcGFnZV9mYXVsdCsweDIyLzB4MzAKPiA+ID4gPiA+ID4g
ICA/IG1seDV2X3NodXRkb3duKzB4ZS8weDUwIFttbHg1X3ZkcGFdCj4gPiA+ID4gPiA+ICAgZGV2
aWNlX3NodXRkb3duKzB4MTNlLzB4MWUwCj4gPiA+ID4gPiA+ICAga2VybmVsX3Jlc3RhcnQrMHgz
Ni8weDkwCj4gPiA+ID4gPiA+ICAgX19kb19zeXNfcmVib290KzB4MTQxLzB4MjEwCj4gPiA+ID4g
PiA+ICAgPyB2ZnNfd3JpdGV2KzB4Y2QvMHgxNDAKPiA+ID4gPiA+ID4gICA/IGhhbmRsZV9tbV9m
YXVsdCsweDE2MS8weDI2MAo+ID4gPiA+ID4gPiAgID8gZG9fd3JpdGV2KzB4NmIvMHgxMTAKPiA+
ID4gPiA+ID4gICBkb19zeXNjYWxsXzY0KzB4M2QvMHg5MAo+ID4gPiA+ID4gPiAgIGVudHJ5X1NZ
U0NBTExfNjRfYWZ0ZXJfaHdmcmFtZSsweDQ2LzB4YjAKPiA+ID4gPiA+ID4gIFJJUDogMDAzMzow
eDdmNDk2OTkwZmI1Ngo+ID4gPiA+ID4gPiAgUlNQOiAwMDJiOjAwMDA3ZmZmYzdiZGRlODggRUZM
QUdTOiAwMDAwMDIwNiBPUklHX1JBWDogMDAwMDAwMDAwMDAwMDBhOQo+ID4gPiA+ID4gPiAgUkFY
OiBmZmZmZmZmZmZmZmZmZmRhIFJCWDogMDAwMDAwMDAwMDAwMDAwMCBSQ1g6IDAwMDA3ZjQ5Njk5
MGZiNTYKPiA+ID4gPiA+ID4gIFJEWDogMDAwMDAwMDAwMTIzNDU2NyBSU0k6IDAwMDAwMDAwMjgx
MjE5NjkgUkRJOiBmZmZmZmZmZmZlZTFkZWFkCj4gPiA+ID4gPiA+ICBSQlA6IDAwMDA3ZmZmYzdi
ZGUxZDAgUjA4OiAwMDAwMDAwMDAwMDAwMDAwIFIwOTogMDAwMDAwMDAwMDAwMDAwMAo+ID4gPiA+
ID4gPiAgUjEwOiAwMDAwMDAwMDAwMDAwMDAwIFIxMTogMDAwMDAwMDAwMDAwMDIwNiBSMTI6IDAw
MDAwMDAwMDAwMDAwMDAKPiA+ID4gPiA+ID4gIFIxMzogMDAwMDdmZmZjN2JkZGYxMCBSMTQ6IDAw
MDAwMDAwMDAwMDAwMDAgUjE1OiAwMDAwN2ZmZmM3YmRlMmI4Cj4gPiA+ID4gPiA+ICAgPC9UQVNL
Pgo+ID4gPiA+ID4gPiAgQ1IyOiAwMDAwMDAwMDAwMDAwMzAwCj4gPiA+ID4gPiA+ICAtLS1bIGVu
ZCB0cmFjZSAwMDAwMDAwMDAwMDAwMDAwIF0tLS0KPiA+ID4gPiA+ID4KPiA+ID4gPiA+ID4gRml4
ZXM6IGJjOWEyYjNlNjg2ZSAoInZkcGEvbWx4NTogU3VwcG9ydCBpbnRlcnJ1cHQgYnlwYXNzaW5n
IikKPiA+ID4gPiA+ID4gU2lnbmVkLW9mZi1ieTogRHJhZ29zIFRhdHVsZWEgPGR0YXR1bGVhQG52
aWRpYS5jb20+Cj4gPiA+ID4gPiA+IC0tLQo+ID4gPiA+ID4gPiAgZHJpdmVycy92ZHBhL21seDUv
bmV0L21seDVfdm5ldC5jIHwgMyArKy0KPiA+ID4gPiA+ID4gIDEgZmlsZSBjaGFuZ2VkLCAyIGlu
c2VydGlvbnMoKyksIDEgZGVsZXRpb24oLSkKPiA+ID4gPiA+ID4KPiA+ID4gPiA+ID4gZGlmZiAt
LWdpdCBhL2RyaXZlcnMvdmRwYS9tbHg1L25ldC9tbHg1X3ZuZXQuYwo+ID4gPiA+ID4gPiBiL2Ry
aXZlcnMvdmRwYS9tbHg1L25ldC9tbHg1X3ZuZXQuYwo+ID4gPiA+ID4gPiBpbmRleCA5MTM4ZWYy
ZmIyYzguLmUyZTdlYmQ3MTc5OCAxMDA2NDQKPiA+ID4gPiA+ID4gLS0tIGEvZHJpdmVycy92ZHBh
L21seDUvbmV0L21seDVfdm5ldC5jCj4gPiA+ID4gPiA+ICsrKyBiL2RyaXZlcnMvdmRwYS9tbHg1
L25ldC9tbHg1X3ZuZXQuYwo+ID4gPiA+ID4gPiBAQCAtMzU1Niw3ICszNTU2LDggQEAgc3RhdGlj
IHZvaWQgbWx4NXZfc2h1dGRvd24oc3RydWN0IGF1eGlsaWFyeV9kZXZpY2UKPiA+ID4gPiA+ID4g
KmF1eGRldikKPiA+ID4gPiA+ID4gICAgICAgICBtZ3RkZXYgPSBhdXhpbGlhcnlfZ2V0X2RydmRh
dGEoYXV4ZGV2KTsKPiA+ID4gPiA+ID4gICAgICAgICBuZGV2ID0gbWd0ZGV2LT5uZGV2Owo+ID4g
PiA+ID4gPgo+ID4gPiA+ID4gPiAtICAgICAgIGZyZWVfaXJxcyhuZGV2KTsKPiA+ID4gPiA+ID4g
KyAgICAgICBpZiAobmRldikKPiA+ID4gPiA+ID4gKyAgICAgICAgICAgICAgIGZyZWVfaXJxcyhu
ZGV2KTsKPiA+ID4gPiA+ID4gIH0KPiA+ID4gPiA+ID4KPiA+ID4gPiA+Cj4gPiA+ID4gPiBzb21l
dGhpbmcgSSBkb24ndCBnZXQ6Cj4gPiA+ID4gPiBpcnFzIGFyZSBhbGxvY2F0ZWQgaW4gbWx4NV92
ZHBhX2Rldl9hZGQKPiA+ID4gPiA+IHdoeSBhcmUgdGhleSBub3QgZnJlZWQgaW4gbWx4NV92ZHBh
X2Rldl9kZWw/Cj4gPiA+ID4gPgo+ID4gPiA+IFRoYXQgaXMgYSBnb29kIHBvaW50LiBJIHdpbGwg
dHJ5IHRvIGZpbmQgb3V0LiBJIGFsc28gZG9uJ3QgZ2V0IHdoeSBmcmVlX2lycQo+ID4gPiA+IGlz
Cj4gPiA+ID4gY2FsbGVkIGluIHRoZSB2ZHBhIGRldiAuZnJlZSBvcCBpbnN0ZWFkIG9mIG1seDVf
dmRwYV9kZXZfZGVsLiBNYXliZSBJIGNhbgo+ID4gPiA+IGNoYW5nZQo+ID4gPiA+IHRoYXQgaW4g
YSBkaWZmZXJlbnQgcmVmYWN0b3JpbmcuCj4gPiA+Cj4gPiA+IGFzIGl0IGlzIEkgaGF2ZSBubyBp
ZGVhIHdoZXRoZXIgZS5nLiBuZGV2IGNhbiBjaGFuZ2UKPiA+ID4gYmV0d2VlbiB0aGVzZSB0d28g
Y2FsbCBzaXRlcy4gdGhhdCB3b3VsZCBtYWtlIHRoZSBjaGVjawo+ID4gPiBwb2ludGxlc3MuCj4g
PiA+Cj4gPiA+ID4gPiB0aGlzIGlzIHdoYXQncyBjcmVhdGluZyBhbGwgdGhpcyBtZXNzLgo+ID4g
PiA+ID4KPiA+ID4gPiA+Cj4gPiA+ID4gTm90IHF1aXRlOiBtbHg1X3ZkcGFfZGV2X2RlbCAod2hp
Y2ggaXMgYSAuZGV2X2RlbCBvZiBmb3Igc3RydWN0Cj4gPiA+ID4gdmRwYV9tZ210ZGV2X29wcykg
ZG9lc24ndCBnZXQgY2FsbGVkIG9uIHNodXRkb3duLiBBdCBsZWFzdCB0aGF0J3Mgd2hhdCBJCj4g
PiA+ID4gc2VlLiBPcgo+ID4gPiA+IGFtIEkgbWlzc2luZyBzb21ldGhpbmc/Cj4gPiA+Cj4gPiA+
IGFuZCB3aHkgZG8gd2UgY2FyZSB3aGV0aGVyIGlycXMgYXJlIGZyZWVkIG9uIHNodXRkb3duPwo+
ID4gPgo+ID4gSGFkIHRvIGFzayBhcm91bmQgYSBiaXQgdG8gZmluZCBvdXQgdGhlIGFuc3dlcjog
dGhlcmUgY2FuIGJlIGlzc3VlcyB3aXRoIGtleGVjCj4gPiBJUlEgYWxsb2NhdGlvbiBvbiBzb21l
IHBsYXRmb3Jtcy4gSXQgaXMgZG9jdW1lbnRlZCBoZXJlIFswXSBmb3IgbWx4NV9jb3JlLgo+ID4K
PiA+IGh0dHBzOi8vZ2l0Lmtlcm5lbC5vcmcvcHViL3NjbS9saW51eC9rZXJuZWwvZ2l0L3RvcnZh
bGRzL2xpbnV4LmdpdC90cmVlL2RyaXZlcnMvbmV0L2V0aGVybmV0L21lbGxhbm94L21seDUvY29y
ZS9tYWluLmMjbjIxMjkKPiA+Cj4gPiBUaGFua3MsCj4gPiBEcmFnb3MKPgo+IEl0J3MgcXVpdGUg
d2VpcmQuCj4gICAgICAgICAgKiBTb21lIHBsYXRmb3JtcyByZXF1aXJpbmcgZnJlZWluZyB0aGUg
SVJRJ3MgaW4gdGhlIHNodXRkb3duCj4gICAgICAgICAgKiBmbG93LiBJZiB0aGV5IGFyZW4ndCBm
cmVlZCB0aGV5IGNhbid0IGJlIGFsbG9jYXRlZCBhZnRlcgo+ICAgICAgICAgICoga2V4ZWMuIFRo
ZXJlIGlzIG5vIG5lZWQgdG8gY2xlYW51cCB0aGUgbWx4NV9jb3JlIHNvZnR3YXJlCj4gICAgICAg
ICAgKiBjb250ZXh0cy4KPgo+IGJ1dCBtb3N0IGRyaXZlcnMgZG9uJ3QgaGF2ZSBhIHNodXRkb3du
IGNhbGxiYWNrIGhvdyBkbyB0aGV5IHdvcmsgdGhlbj8KPiBkbyB5b3Uga25vdyB3aGljaCBwbGF0
Zm9ybXMgdGhlc2UgYXJlPwoKVGhlcmUgdXNlZCB0byBiZSBienMgdGhhdCByZXF1aXJlcyB2aXJ0
aW8gZHJpdmVycyB0byBhZGQgYSBzaHV0ZG93biB0bwpmaXgga2V4ZWM6CgpodHRwczovL2J1Z3pp
bGxhLnJlZGhhdC5jb20vc2hvd19idWcuY2dpP2lkPTIxMDg0MDYKClRoYW5rcwoKPgo+IEkgZG9u
J3QgcmVhbGx5IGtub3cgbXVjaCBhYm91dCB3aHkgc2h1dGRvd24gY2FsbGJhY2sgaXMgZXZlbiBu
ZWNlc3NhcnkuCj4gSSBndWVzcyB0aGlzIGlzIHRvIGRldGVjdCBzaHV0ZG93biBhbmQgZG8gYSBm
YXN0ZXIgY2xlYW51cCB0aGFuCj4gdGhlIHNsb3csIGdyYWNlZnVsIHJlbW92YWwsIGp1c3QgY2xl
YW5pbmcgaGFyZHdhcmUgcmVzb3VyY2VzPwo+Cj4KPiAtLQo+IE1TVAo+CgpfX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fXwpWaXJ0dWFsaXphdGlvbiBtYWlsaW5n
IGxpc3QKVmlydHVhbGl6YXRpb25AbGlzdHMubGludXgtZm91bmRhdGlvbi5vcmcKaHR0cHM6Ly9s
aXN0cy5saW51eGZvdW5kYXRpb24ub3JnL21haWxtYW4vbGlzdGluZm8vdmlydHVhbGl6YXRpb24=
