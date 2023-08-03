Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B260FEB64DD
	for <virtualization@archiver.kernel.org>; Thu,  3 Aug 2023 15:12:24 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 20CAC80EE8;
	Thu,  3 Aug 2023 15:12:24 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 20CAC80EE8
Authentication-Results: smtp1.osuosl.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=Y8FZaIeb
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
	by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id fW2Sk51_u8YW; Thu,  3 Aug 2023 15:12:22 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp1.osuosl.org (Postfix) with ESMTPS id 41BDB81F42;
	Thu,  3 Aug 2023 15:12:22 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 41BDB81F42
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 0BD85C0072;
	Thu,  3 Aug 2023 15:12:22 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [IPv6:2605:bc80:3010::138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id D3408C0032
 for <virtualization@lists.linux-foundation.org>;
 Thu,  3 Aug 2023 15:12:20 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id A078D80EE8
 for <virtualization@lists.linux-foundation.org>;
 Thu,  3 Aug 2023 15:12:20 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org A078D80EE8
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id VRUhWCyxGxwX
 for <virtualization@lists.linux-foundation.org>;
 Thu,  3 Aug 2023 15:12:19 +0000 (UTC)
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.133.124])
 by smtp1.osuosl.org (Postfix) with ESMTPS id 49D1E8200D
 for <virtualization@lists.linux-foundation.org>;
 Thu,  3 Aug 2023 15:12:18 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 49D1E8200D
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1691075537;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=alsHbM1v/nfjzdcfXP8ctyTsH1REwc9fdwebIn1r7Ck=;
 b=Y8FZaIebb/IVbLMakFIH5dmhtr81LWbufXfLv7TG/mzjnaKbhemr42OzWfgitni/tvg8qE
 TjWeq4p8y77ip+lycyc6G9uvRzo4jsUlreKkn9oJkESzTBueiTJlTfFFWv7Y6djIIhoEs8
 uk5S06pm2PszJvGjBQgSwHjLC84W/vA=
Received: from mail-ed1-f69.google.com (mail-ed1-f69.google.com
 [209.85.208.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-168--NjbMD4EOiuveIEUlufVYg-1; Thu, 03 Aug 2023 11:12:15 -0400
X-MC-Unique: -NjbMD4EOiuveIEUlufVYg-1
Received: by mail-ed1-f69.google.com with SMTP id
 4fb4d7f45d1cf-52256d84ab1so738321a12.3
 for <virtualization@lists.linux-foundation.org>;
 Thu, 03 Aug 2023 08:12:15 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1691075534; x=1691680334;
 h=in-reply-to:content-transfer-encoding:content-disposition
 :mime-version:references:message-id:subject:cc:to:from:date
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=alsHbM1v/nfjzdcfXP8ctyTsH1REwc9fdwebIn1r7Ck=;
 b=L0HDyXgCJfjzzg6vEMRIlPUAVC9+n8lo64WxKmwZwGdYaeYuTeDsffoZTpyvMrRV4R
 84wuwNGwT73ySvs0XYvdUoebNUabnizU6LrQXjQMVApIhDY9ZXtdt9HYmhSJLDYytV27
 LOD2WDORaoBSkt2fL6eY/9faZLHHKm3ali6lKG6hD63g3TQ1s2NeGS7pREEgI8po5vuN
 Nw6LG/CW+VHswmQDHu/f/5Qs1ZoUxKMvoQrvAOP+05dwUMNQGUJGn2CHag5Gxp+6X5BQ
 IT4XK0epya7ouDdOiBCXOWwIzdVYxbZSJlWugieoqFyn7iVku18y+8nlgEOQ2AvT4JvO
 ak0g==
X-Gm-Message-State: ABy/qLYeYTF7MwCFsyKqcTOIjUadRdtqqbzzJZdU8Z5VQgIFpJMoz/yP
 o1kqHZG/S/bFxwll2+4pofUdMDaC4jg8QWevVZX9MLHwpjSf+ZxYRtrIoag/09PIRaH/yBkbP9G
 tgbxNfK55JUJ+GWBx68k+t3Mrvqms2eIlYtVghDNRaw==
X-Received: by 2002:aa7:d382:0:b0:522:56d8:49c0 with SMTP id
 x2-20020aa7d382000000b0052256d849c0mr8093420edq.37.1691075534425; 
 Thu, 03 Aug 2023 08:12:14 -0700 (PDT)
X-Google-Smtp-Source: APBJJlFIMKKLxzUcAdGlurEifhhbkaXBhtuMzh7ZujHmOmhYOygd1xi7DZoVwWCISdNd6zi4b2EPMg==
X-Received: by 2002:aa7:d382:0:b0:522:56d8:49c0 with SMTP id
 x2-20020aa7d382000000b0052256d849c0mr8093399edq.37.1691075534052; 
 Thu, 03 Aug 2023 08:12:14 -0700 (PDT)
Received: from redhat.com ([2.52.12.104]) by smtp.gmail.com with ESMTPSA id
 bf19-20020a0564021a5300b0051ded17b30bsm10280982edb.40.2023.08.03.08.12.12
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 03 Aug 2023 08:12:13 -0700 (PDT)
Date: Thu, 3 Aug 2023 11:12:10 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Dragos Tatulea <dtatulea@nvidia.com>
Subject: Re: [PATCH] vdpa/mlx5: Fix crash on shutdown for when no ndev exists
Message-ID: <20230803111154-mutt-send-email-mst@kernel.org>
References: <20230726152258-mutt-send-email-mst@kernel.org>
 <3ae9e8919a9316d06d7bb507698c820ac6194f45.camel@nvidia.com>
 <20230727122633-mutt-send-email-mst@kernel.org>
 <b97484f15824c86f5cee4fe673794f17419bcb1b.camel@nvidia.com>
 <20230731050200-mutt-send-email-mst@kernel.org>
 <CACGkMEtiwNjq4pMVY-Yvgo3+DihMP5zO+q+HH-xAF+Xu_=gbHg@mail.gmail.com>
 <39c3be5dd59e67e7b5dd301100e96aa9428bc332.camel@nvidia.com>
 <CACGkMEueOXgjbr9Q0Tw5Bv-=YH9+5UR9jxttrf6hN-VRK9KtMg@mail.gmail.com>
 <4375036868b636fa9c5a03e7fa9c4d7cdefefc5f.camel@nvidia.com>
 <5eba7bc2d3f253be4b0b998dc8a7a3efc7fe08d9.camel@nvidia.com>
MIME-Version: 1.0
In-Reply-To: <5eba7bc2d3f253be4b0b998dc8a7a3efc7fe08d9.camel@nvidia.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Disposition: inline
Cc: "xuanzhuo@linux.alibaba.com" <xuanzhuo@linux.alibaba.com>,
 "bhe@redhat.com" <bhe@redhat.com>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
 "stable@vger.kernel.org" <stable@vger.kernel.org>,
 "virtualization@lists.linux-foundation.org"
 <virtualization@lists.linux-foundation.org>,
 "ruyang@redhat.com" <ruyang@redhat.com>,
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

T24gVGh1LCBBdWcgMDMsIDIwMjMgYXQgMDM6MDI6NTlQTSArMDAwMCwgRHJhZ29zIFRhdHVsZWEg
d3JvdGU6Cj4gT24gV2VkLCAyMDIzLTA4LTAyIGF0IDA5OjU2ICswMjAwLCBEcmFnb3MgVGF0dWxl
YSB3cm90ZToKPiA+IE9uIFdlZCwgMjAyMy0wOC0wMiBhdCAxMDo1MSArMDgwMCwgSmFzb24gV2Fu
ZyB3cm90ZToKPiA+ID4gT24gVHVlLCBBdWcgMSwgMjAyMyBhdCA0OjE34oCvUE0gRHJhZ29zIFRh
dHVsZWEgPGR0YXR1bGVhQG52aWRpYS5jb20+IHdyb3RlOgo+ID4gPiA+IAo+ID4gPiA+IE9uIFR1
ZSwgMjAyMy0wOC0wMSBhdCAxMTo1OSArMDgwMCwgSmFzb24gV2FuZyB3cm90ZToKPiA+ID4gPiA+
IE9uIE1vbiwgSnVsIDMxLCAyMDIzIGF0IDU6MDjigK9QTSBNaWNoYWVsIFMuIFRzaXJraW4gPG1z
dEByZWRoYXQuY29tPgo+ID4gPiA+ID4gd3JvdGU6Cj4gPiA+ID4gPiA+IAo+ID4gPiA+ID4gPiBP
biBNb24sIEp1bCAzMSwgMjAyMyBhdCAwNzoxNTozMUFNICswMDAwLCBEcmFnb3MgVGF0dWxlYSB3
cm90ZToKPiA+ID4gPiA+ID4gPiBPbiBUaHUsIDIwMjMtMDctMjcgYXQgMTI6MjggLTA0MDAsIE1p
Y2hhZWwgUy4gVHNpcmtpbiB3cm90ZToKPiA+ID4gPiA+ID4gPiA+IE9uIFRodSwgSnVsIDI3LCAy
MDIzIGF0IDA0OjAyOjE2UE0gKzAwMDAsIERyYWdvcyBUYXR1bGVhIHdyb3RlOgo+ID4gPiA+ID4g
PiA+ID4gPiBPbiBXZWQsIDIwMjMtMDctMjYgYXQgMTU6MjYgLTA0MDAsIE1pY2hhZWwgUy4gVHNp
cmtpbiB3cm90ZToKPiA+ID4gPiA+ID4gPiA+ID4gPiBPbiBXZWQsIEp1bCAyNiwgMjAyMyBhdCAx
MDowNzozOFBNICswMzAwLCBEcmFnb3MgVGF0dWxlYQo+ID4gPiA+ID4gPiA+ID4gPiA+IHdyb3Rl
Ogo+ID4gPiA+ID4gPiA+ID4gPiA+ID4gVGhlIG5kZXYgd2FzIGFjY2Vzc2VkIG9uIHNodXRkb3du
IHdpdGhvdXQgYSBjaGVjayBpZiBpdAo+ID4gPiA+ID4gPiA+ID4gPiA+ID4gYWN0dWFsbHkKPiA+
ID4gPiA+ID4gPiA+ID4gPiA+IGV4aXN0cy4KPiA+ID4gPiA+ID4gPiA+ID4gPiA+IFRoaXMgdHJp
Z2dlcmVkIHRoZSBjcmFzaCBwYXN0ZWQgYmVsb3cuIFRoaXMgcGF0Y2ggc2ltcGx5Cj4gPiA+ID4g
PiA+ID4gPiA+ID4gPiBhZGRzCj4gPiA+ID4gPiA+ID4gPiA+ID4gPiBhCj4gPiA+ID4gPiA+ID4g
PiA+ID4gPiBjaGVjawo+ID4gPiA+ID4gPiA+ID4gPiA+ID4gYmVmb3JlIHVzaW5nIG5kZXYuCj4g
PiA+ID4gPiA+ID4gPiA+ID4gPiAKPiA+ID4gPiA+ID4gPiA+ID4gPiA+IMKgQlVHOiBrZXJuZWwg
TlVMTCBwb2ludGVyIGRlcmVmZXJlbmNlLCBhZGRyZXNzOgo+ID4gPiA+ID4gPiA+ID4gPiA+ID4g
MDAwMDAwMDAwMDAwMDMwMAo+ID4gPiA+ID4gPiA+ID4gPiA+ID4gwqAjUEY6IHN1cGVydmlzb3Ig
cmVhZCBhY2Nlc3MgaW4ga2VybmVsIG1vZGUKPiA+ID4gPiA+ID4gPiA+ID4gPiA+IMKgI1BGOiBl
cnJvcl9jb2RlKDB4MDAwMCkgLSBub3QtcHJlc2VudCBwYWdlCj4gPiA+ID4gPiA+ID4gPiA+ID4g
PiDCoFBHRCAwIFA0RCAwCj4gPiA+ID4gPiA+ID4gPiA+ID4gPiDCoE9vcHM6IDAwMDAgWyMxXSBT
TVAKPiA+ID4gPiA+ID4gPiA+ID4gPiA+IMKgQ1BVOiAwIFBJRDogMSBDb21tOiBzeXN0ZW1kLXNo
dXRkb3cgTm90IHRhaW50ZWQgNi41LjAtCj4gPiA+ID4gPiA+ID4gPiA+ID4gPiByYzJfZm9yX3Vw
c3RyZWFtX21pbl9kZWJ1Z18yMDIzXzA3XzE3XzE1XzA1ICMxCj4gPiA+ID4gPiA+ID4gPiA+ID4g
PiDCoEhhcmR3YXJlIG5hbWU6IFFFTVUgU3RhbmRhcmQgUEMgKFEzNSArIElDSDksIDIwMDkpLCBC
SU9TCj4gPiA+ID4gPiA+ID4gPiA+ID4gPiByZWwtCj4gPiA+ID4gPiA+ID4gPiA+ID4gPiAxLjEz
LjAtMC0KPiA+ID4gPiA+ID4gPiA+ID4gPiA+IGdmMjFiNWE0YWViMDItcHJlYnVpbHQucWVtdS5v
cmcgMDQvMDEvMjAxNAo+ID4gPiA+ID4gPiA+ID4gPiA+ID4gwqBSSVA6IDAwMTA6bWx4NXZfc2h1
dGRvd24rMHhlLzB4NTAgW21seDVfdmRwYV0KPiA+ID4gPiA+ID4gPiA+ID4gPiA+IMKgUlNQOiAw
MDE4OmZmZmY4ODgxMDAzYmZkYzAgRUZMQUdTOiAwMDAxMDI4Ngo+ID4gPiA+ID4gPiA+ID4gPiA+
ID4gwqBSQVg6IGZmZmY4ODgxMDNiZWZiYTAgUkJYOiBmZmZmODg4MTA5ZDI4MDA4IFJDWDoKPiA+
ID4gPiA+ID4gPiA+ID4gPiA+IDAwMDAwMDAwMDAwMDAwMTcKPiA+ID4gPiA+ID4gPiA+ID4gPiA+
IMKgUkRYOiAwMDAwMDAwMDAwMDAwMDAxIFJTSTogMDAwMDAwMDAwMDAwMDIxMiBSREk6Cj4gPiA+
ID4gPiA+ID4gPiA+ID4gPiBmZmZmODg4MTA5ZDI4MDAwCj4gPiA+ID4gPiA+ID4gPiA+ID4gPiDC
oFJCUDogMDAwMDAwMDAwMDAwMDAwMCBSMDg6IDAwMDAwMDBkM2EzYTM4ODIgUjA5Ogo+ID4gPiA+
ID4gPiA+ID4gPiA+ID4gMDAwMDAwMDAwMDAwMDAwMQo+ID4gPiA+ID4gPiA+ID4gPiA+ID4gwqBS
MTA6IDAwMDAwMDAwMDAwMDAwMDAgUjExOiAwMDAwMDAwMDAwMDAwMDAwIFIxMjoKPiA+ID4gPiA+
ID4gPiA+ID4gPiA+IGZmZmY4ODgxMDlkMjgwMDAKPiA+ID4gPiA+ID4gPiA+ID4gPiA+IMKgUjEz
OiBmZmZmODg4MTA5ZDI4MDgwIFIxNDogMDAwMDAwMDBmZWUxZGVhZCBSMTU6Cj4gPiA+ID4gPiA+
ID4gPiA+ID4gPiAwMDAwMDAwMDAwMDAwMDAwCj4gPiA+ID4gPiA+ID4gPiA+ID4gPiDCoEZTOsKg
IDAwMDA3ZjQ5NjllMGJlNDAoMDAwMCkgR1M6ZmZmZjg4ODUyYzgwMDAwMCgwMDAwKQo+ID4gPiA+
ID4gPiA+ID4gPiA+ID4ga25sR1M6MDAwMDAwMDAwMDAwMDAwMAo+ID4gPiA+ID4gPiA+ID4gPiA+
ID4gwqBDUzrCoCAwMDEwIERTOiAwMDAwIEVTOiAwMDAwIENSMDogMDAwMDAwMDA4MDA1MDAzMwo+
ID4gPiA+ID4gPiA+ID4gPiA+ID4gwqBDUjI6IDAwMDAwMDAwMDAwMDAzMDAgQ1IzOiAwMDAwMDAw
MTA1MWNkMDA2IENSNDoKPiA+ID4gPiA+ID4gPiA+ID4gPiA+IDAwMDAwMDAwMDAzNzBlYjAKPiA+
ID4gPiA+ID4gPiA+ID4gPiA+IMKgRFIwOiAwMDAwMDAwMDAwMDAwMDAwIERSMTogMDAwMDAwMDAw
MDAwMDAwMCBEUjI6Cj4gPiA+ID4gPiA+ID4gPiA+ID4gPiAwMDAwMDAwMDAwMDAwMDAwCj4gPiA+
ID4gPiA+ID4gPiA+ID4gPiDCoERSMzogMDAwMDAwMDAwMDAwMDAwMCBEUjY6IDAwMDAwMDAwZmZm
ZTBmZjAgRFI3Ogo+ID4gPiA+ID4gPiA+ID4gPiA+ID4gMDAwMDAwMDAwMDAwMDQwMAo+ID4gPiA+
ID4gPiA+ID4gPiA+ID4gwqBDYWxsIFRyYWNlOgo+ID4gPiA+ID4gPiA+ID4gPiA+ID4gwqAgPFRB
U0s+Cj4gPiA+ID4gPiA+ID4gPiA+ID4gPiDCoCA/IF9fZGllKzB4MjAvMHg2MAo+ID4gPiA+ID4g
PiA+ID4gPiA+ID4gwqAgPyBwYWdlX2ZhdWx0X29vcHMrMHgxNGMvMHgzYzAKPiA+ID4gPiA+ID4g
PiA+ID4gPiA+IMKgID8gZXhjX3BhZ2VfZmF1bHQrMHg3NS8weDE0MAo+ID4gPiA+ID4gPiA+ID4g
PiA+ID4gwqAgPyBhc21fZXhjX3BhZ2VfZmF1bHQrMHgyMi8weDMwCj4gPiA+ID4gPiA+ID4gPiA+
ID4gPiDCoCA/IG1seDV2X3NodXRkb3duKzB4ZS8weDUwIFttbHg1X3ZkcGFdCj4gPiA+ID4gPiA+
ID4gPiA+ID4gPiDCoCBkZXZpY2Vfc2h1dGRvd24rMHgxM2UvMHgxZTAKPiA+ID4gPiA+ID4gPiA+
ID4gPiA+IMKgIGtlcm5lbF9yZXN0YXJ0KzB4MzYvMHg5MAo+ID4gPiA+ID4gPiA+ID4gPiA+ID4g
wqAgX19kb19zeXNfcmVib290KzB4MTQxLzB4MjEwCj4gPiA+ID4gPiA+ID4gPiA+ID4gPiDCoCA/
IHZmc193cml0ZXYrMHhjZC8weDE0MAo+ID4gPiA+ID4gPiA+ID4gPiA+ID4gwqAgPyBoYW5kbGVf
bW1fZmF1bHQrMHgxNjEvMHgyNjAKPiA+ID4gPiA+ID4gPiA+ID4gPiA+IMKgID8gZG9fd3JpdGV2
KzB4NmIvMHgxMTAKPiA+ID4gPiA+ID4gPiA+ID4gPiA+IMKgIGRvX3N5c2NhbGxfNjQrMHgzZC8w
eDkwCj4gPiA+ID4gPiA+ID4gPiA+ID4gPiDCoCBlbnRyeV9TWVNDQUxMXzY0X2FmdGVyX2h3ZnJh
bWUrMHg0Ni8weGIwCj4gPiA+ID4gPiA+ID4gPiA+ID4gPiDCoFJJUDogMDAzMzoweDdmNDk2OTkw
ZmI1Ngo+ID4gPiA+ID4gPiA+ID4gPiA+ID4gwqBSU1A6IDAwMmI6MDAwMDdmZmZjN2JkZGU4OCBF
RkxBR1M6IDAwMDAwMjA2IE9SSUdfUkFYOgo+ID4gPiA+ID4gPiA+ID4gPiA+ID4gMDAwMDAwMDAw
MDAwMDBhOQo+ID4gPiA+ID4gPiA+ID4gPiA+ID4gwqBSQVg6IGZmZmZmZmZmZmZmZmZmZGEgUkJY
OiAwMDAwMDAwMDAwMDAwMDAwIFJDWDoKPiA+ID4gPiA+ID4gPiA+ID4gPiA+IDAwMDA3ZjQ5Njk5
MGZiNTYKPiA+ID4gPiA+ID4gPiA+ID4gPiA+IMKgUkRYOiAwMDAwMDAwMDAxMjM0NTY3IFJTSTog
MDAwMDAwMDAyODEyMTk2OSBSREk6Cj4gPiA+ID4gPiA+ID4gPiA+ID4gPiBmZmZmZmZmZmZlZTFk
ZWFkCj4gPiA+ID4gPiA+ID4gPiA+ID4gPiDCoFJCUDogMDAwMDdmZmZjN2JkZTFkMCBSMDg6IDAw
MDAwMDAwMDAwMDAwMDAgUjA5Ogo+ID4gPiA+ID4gPiA+ID4gPiA+ID4gMDAwMDAwMDAwMDAwMDAw
MAo+ID4gPiA+ID4gPiA+ID4gPiA+ID4gwqBSMTA6IDAwMDAwMDAwMDAwMDAwMDAgUjExOiAwMDAw
MDAwMDAwMDAwMjA2IFIxMjoKPiA+ID4gPiA+ID4gPiA+ID4gPiA+IDAwMDAwMDAwMDAwMDAwMDAK
PiA+ID4gPiA+ID4gPiA+ID4gPiA+IMKgUjEzOiAwMDAwN2ZmZmM3YmRkZjEwIFIxNDogMDAwMDAw
MDAwMDAwMDAwMCBSMTU6Cj4gPiA+ID4gPiA+ID4gPiA+ID4gPiAwMDAwN2ZmZmM3YmRlMmI4Cj4g
PiA+ID4gPiA+ID4gPiA+ID4gPiDCoCA8L1RBU0s+Cj4gPiA+ID4gPiA+ID4gPiA+ID4gPiDCoENS
MjogMDAwMDAwMDAwMDAwMDMwMAo+ID4gPiA+ID4gPiA+ID4gPiA+ID4gwqAtLS1bIGVuZCB0cmFj
ZSAwMDAwMDAwMDAwMDAwMDAwIF0tLS0KPiA+ID4gPiA+ID4gPiA+ID4gPiA+IAo+ID4gPiA+ID4g
PiA+ID4gPiA+ID4gRml4ZXM6IGJjOWEyYjNlNjg2ZSAoInZkcGEvbWx4NTogU3VwcG9ydCBpbnRl
cnJ1cHQKPiA+ID4gPiA+ID4gPiA+ID4gPiA+IGJ5cGFzc2luZyIpCj4gPiA+ID4gPiA+ID4gPiA+
ID4gPiBTaWduZWQtb2ZmLWJ5OiBEcmFnb3MgVGF0dWxlYSA8ZHRhdHVsZWFAbnZpZGlhLmNvbT4K
PiA+ID4gPiA+ID4gPiA+ID4gPiA+IC0tLQo+ID4gPiA+ID4gPiA+ID4gPiA+ID4gwqBkcml2ZXJz
L3ZkcGEvbWx4NS9uZXQvbWx4NV92bmV0LmMgfCAzICsrLQo+ID4gPiA+ID4gPiA+ID4gPiA+ID4g
wqAxIGZpbGUgY2hhbmdlZCwgMiBpbnNlcnRpb25zKCspLCAxIGRlbGV0aW9uKC0pCj4gPiA+ID4g
PiA+ID4gPiA+ID4gPiAKPiA+ID4gPiA+ID4gPiA+ID4gPiA+IGRpZmYgLS1naXQgYS9kcml2ZXJz
L3ZkcGEvbWx4NS9uZXQvbWx4NV92bmV0LmMKPiA+ID4gPiA+ID4gPiA+ID4gPiA+IGIvZHJpdmVy
cy92ZHBhL21seDUvbmV0L21seDVfdm5ldC5jCj4gPiA+ID4gPiA+ID4gPiA+ID4gPiBpbmRleCA5
MTM4ZWYyZmIyYzguLmUyZTdlYmQ3MTc5OCAxMDA2NDQKPiA+ID4gPiA+ID4gPiA+ID4gPiA+IC0t
LSBhL2RyaXZlcnMvdmRwYS9tbHg1L25ldC9tbHg1X3ZuZXQuYwo+ID4gPiA+ID4gPiA+ID4gPiA+
ID4gKysrIGIvZHJpdmVycy92ZHBhL21seDUvbmV0L21seDVfdm5ldC5jCj4gPiA+ID4gPiA+ID4g
PiA+ID4gPiBAQCAtMzU1Niw3ICszNTU2LDggQEAgc3RhdGljIHZvaWQgbWx4NXZfc2h1dGRvd24o
c3RydWN0Cj4gPiA+ID4gPiA+ID4gPiA+ID4gPiBhdXhpbGlhcnlfZGV2aWNlCj4gPiA+ID4gPiA+
ID4gPiA+ID4gPiAqYXV4ZGV2KQo+ID4gPiA+ID4gPiA+ID4gPiA+ID4gwqDCoMKgwqDCoMKgwqAg
bWd0ZGV2ID0gYXV4aWxpYXJ5X2dldF9kcnZkYXRhKGF1eGRldik7Cj4gPiA+ID4gPiA+ID4gPiA+
ID4gPiDCoMKgwqDCoMKgwqDCoCBuZGV2ID0gbWd0ZGV2LT5uZGV2Owo+ID4gPiA+ID4gPiA+ID4g
PiA+ID4gCj4gPiA+ID4gPiA+ID4gPiA+ID4gPiAtwqDCoMKgwqDCoMKgIGZyZWVfaXJxcyhuZGV2
KTsKPiA+ID4gPiA+ID4gPiA+ID4gPiA+ICvCoMKgwqDCoMKgwqAgaWYgKG5kZXYpCj4gPiA+ID4g
PiA+ID4gPiA+ID4gPiArwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoCBmcmVlX2lycXMobmRl
dik7Cj4gPiA+ID4gPiA+ID4gPiA+ID4gPiDCoH0KPiA+ID4gPiA+ID4gPiA+ID4gPiA+IAo+ID4g
PiA+ID4gPiA+ID4gPiA+IAo+ID4gPiA+ID4gPiA+ID4gPiA+IHNvbWV0aGluZyBJIGRvbid0IGdl
dDoKPiA+ID4gPiA+ID4gPiA+ID4gPiBpcnFzIGFyZSBhbGxvY2F0ZWQgaW4gbWx4NV92ZHBhX2Rl
dl9hZGQKPiA+ID4gPiA+ID4gPiA+ID4gPiB3aHkgYXJlIHRoZXkgbm90IGZyZWVkIGluIG1seDVf
dmRwYV9kZXZfZGVsPwo+ID4gPiA+ID4gPiA+ID4gPiA+IAo+ID4gPiA+ID4gPiA+ID4gPiBUaGF0
IGlzIGEgZ29vZCBwb2ludC4gSSB3aWxsIHRyeSB0byBmaW5kIG91dC4gSSBhbHNvIGRvbid0IGdl
dAo+ID4gPiA+ID4gPiA+ID4gPiB3aHkKPiA+ID4gPiA+ID4gPiA+ID4gZnJlZV9pcnEKPiA+ID4g
PiA+ID4gPiA+ID4gaXMKPiA+ID4gPiA+ID4gPiA+ID4gY2FsbGVkIGluIHRoZSB2ZHBhIGRldiAu
ZnJlZSBvcCBpbnN0ZWFkIG9mIG1seDVfdmRwYV9kZXZfZGVsLgo+ID4gPiA+ID4gPiA+ID4gPiBN
YXliZSBJCj4gPiA+ID4gPiA+ID4gPiA+IGNhbgo+ID4gPiA+ID4gPiA+ID4gPiBjaGFuZ2UKPiA+
ID4gPiA+ID4gPiA+ID4gdGhhdCBpbiBhIGRpZmZlcmVudCByZWZhY3RvcmluZy4KPiA+ID4gPiA+
ID4gPiA+IAo+ID4gPiA+ID4gPiA+ID4gYXMgaXQgaXMgSSBoYXZlIG5vIGlkZWEgd2hldGhlciBl
LmcuIG5kZXYgY2FuIGNoYW5nZQo+ID4gPiA+ID4gPiA+ID4gYmV0d2VlbiB0aGVzZSB0d28gY2Fs
bCBzaXRlcy4gdGhhdCB3b3VsZCBtYWtlIHRoZSBjaGVjawo+ID4gPiA+ID4gPiA+ID4gcG9pbnRs
ZXNzLgo+ID4gPiA+ID4gPiA+ID4gCj4gPiA+ID4gPiA+ID4gPiA+ID4gdGhpcyBpcyB3aGF0J3Mg
Y3JlYXRpbmcgYWxsIHRoaXMgbWVzcy4KPiA+ID4gPiA+ID4gPiA+ID4gPiAKPiA+ID4gPiA+ID4g
PiA+ID4gPiAKPiA+ID4gPiA+ID4gPiA+ID4gTm90IHF1aXRlOiBtbHg1X3ZkcGFfZGV2X2RlbCAo
d2hpY2ggaXMgYSAuZGV2X2RlbCBvZiBmb3Igc3RydWN0Cj4gPiA+ID4gPiA+ID4gPiA+IHZkcGFf
bWdtdGRldl9vcHMpIGRvZXNuJ3QgZ2V0IGNhbGxlZCBvbiBzaHV0ZG93bi4gQXQgbGVhc3QKPiA+
ID4gPiA+ID4gPiA+ID4gdGhhdCdzCj4gPiA+ID4gPiA+ID4gPiA+IHdoYXQKPiA+ID4gPiA+ID4g
PiA+ID4gSQo+ID4gPiA+ID4gPiA+ID4gPiBzZWUuIE9yCj4gPiA+ID4gPiA+ID4gPiA+IGFtIEkg
bWlzc2luZyBzb21ldGhpbmc/Cj4gPiA+ID4gPiA+ID4gPiAKPiA+ID4gPiA+ID4gPiA+IGFuZCB3
aHkgZG8gd2UgY2FyZSB3aGV0aGVyIGlycXMgYXJlIGZyZWVkIG9uIHNodXRkb3duPwo+ID4gPiA+
ID4gPiA+ID4gCj4gPiA+ID4gPiA+ID4gSGFkIHRvIGFzayBhcm91bmQgYSBiaXQgdG8gZmluZCBv
dXQgdGhlIGFuc3dlcjogdGhlcmUgY2FuIGJlIGlzc3Vlcwo+ID4gPiA+ID4gPiA+IHdpdGgKPiA+
ID4gPiA+ID4gPiBrZXhlYwo+ID4gPiA+ID4gPiA+IElSUSBhbGxvY2F0aW9uIG9uIHNvbWUgcGxh
dGZvcm1zLiBJdCBpcyBkb2N1bWVudGVkIGhlcmUgWzBdIGZvcgo+ID4gPiA+ID4gPiA+IG1seDVf
Y29yZS4KPiA+ID4gPiA+ID4gPiAKPiA+ID4gPiA+ID4gPiBodHRwczovL2dpdC5rZXJuZWwub3Jn
L3B1Yi9zY20vbGludXgva2VybmVsL2dpdC90b3J2YWxkcy9saW51eC5naXQvdHJlZS9kcml2ZXJz
L25ldC9ldGhlcm5ldC9tZWxsYW5veC9tbHg1L2NvcmUvbWFpbi5jI24yMTI5Cj4gPiA+ID4gPiA+
ID4gCj4gPiA+ID4gPiA+ID4gVGhhbmtzLAo+ID4gPiA+ID4gPiA+IERyYWdvcwo+ID4gPiA+ID4g
PiAKPiA+ID4gPiA+ID4gSXQncyBxdWl0ZSB3ZWlyZC4KPiA+ID4gPiA+ID4gwqDCoMKgwqDCoMKg
wqDCoCAqIFNvbWUgcGxhdGZvcm1zIHJlcXVpcmluZyBmcmVlaW5nIHRoZSBJUlEncyBpbiB0aGUg
c2h1dGRvd24KPiA+ID4gPiA+ID4gwqDCoMKgwqDCoMKgwqDCoCAqIGZsb3cuIElmIHRoZXkgYXJl
bid0IGZyZWVkIHRoZXkgY2FuJ3QgYmUgYWxsb2NhdGVkIGFmdGVyCj4gPiA+ID4gPiA+IMKgwqDC
oMKgwqDCoMKgwqAgKiBrZXhlYy4gVGhlcmUgaXMgbm8gbmVlZCB0byBjbGVhbnVwIHRoZSBtbHg1
X2NvcmUgc29mdHdhcmUKPiA+ID4gPiA+ID4gwqDCoMKgwqDCoMKgwqDCoCAqIGNvbnRleHRzLgo+
ID4gPiA+ID4gPiAKPiA+ID4gPiA+ID4gYnV0IG1vc3QgZHJpdmVycyBkb24ndCBoYXZlIGEgc2h1
dGRvd24gY2FsbGJhY2sgaG93IGRvIHRoZXkgd29yayB0aGVuPwo+ID4gPiA+ID4gPiBkbyB5b3Ug
a25vdyB3aGljaCBwbGF0Zm9ybXMgdGhlc2UgYXJlPwo+ID4gPiA+ID4gCj4gPiA+ID4gSSBkb24n
dC4geDg2XzY0IGlzIG5vdCBvbmUgb2YgdGhlbSB0aG91Z2guIEkgd2lsbCBkbyBzb21lIG1vcmUg
ZGlnZ2luZyAuLi4KPiA+ID4gPiAKPiA+IFR1cm5zIG91dCB0aGF0IHRoaXMgZml4IChyZWxlYXNp
bmcgdGhlIGlycXMgb24gLnNodXRkb3duIG9uIG1seDVfY29yZSkgd2FzCj4gPiByZXF1aXJlZCBm
b3IgUFBDIGFyY2ggYnV0IG9ubHkgZm9yIGNlcnRhaW4gbWFpbmZyYW1lIHN5c3RlbXMuIFRoYXQn
cyBhbGwgdGhlCj4gPiBpbmZvIEkgY291bGQgZmluZC4KPiA+IAo+IEkgd2lsbCBzZW5kIGEgdjIg
Zm9yIHRoaXMgcGF0Y2ggdGhhdCByZW1vdmVzIHRoZSBzaHV0ZG93biBvcC4gVGhlIGlycXMgd2ls
bCBiZQo+IHJlbGVhc2VkIGJ5IHRoZSBtbHg1X2NvcmUgc2h1dGRvd24gaGFuZGxlciB3aGljaCBp
cyByZXNwb25zaWJsZSBmb3IgdGhlIFZGLgo+IAo+IFRoYW5rcywKPiBEcmFnb3MKCkNlcnRhaW5s
eSBzZWVtcyBjbGVhbmVyLiBUaGFua3MhCgo+ID4gPiA+ID4gVGhlcmUgdXNlZCB0byBiZSBienMg
dGhhdCByZXF1aXJlcyB2aXJ0aW8gZHJpdmVycyB0byBhZGQgYSBzaHV0ZG93biB0bwo+ID4gPiA+
ID4gZml4IGtleGVjOgo+ID4gPiA+ID4gCj4gPiA+ID4gPiBodHRwczovL2J1Z3ppbGxhLnJlZGhh
dC5jb20vc2hvd19idWcuY2dpP2lkPTIxMDg0MDYKPiA+ID4gPiA+IAo+ID4gPiA+IEkgZG9uJ3Qg
aGF2ZSBhY2Nlc3MgdG8gdGhpcy4gV2hhdCBpcyBpdCBhYm91dD8KPiA+ID4gCj4gPiA+IFRoaXMg
YnVnIG1pZ2h0IGJlIG1vcmUgYWNjdXJhdGU6Cj4gPiA+IAo+ID4gPiBodHRwczovL2J1Z3ppbGxh
LnJlZGhhdC5jb20vc2hvd19idWcuY2dpP2lkPTE4MjA1MjEKPiA+ID4gCj4gPiA+IEl0J3MgYWJv
dXQgdGhlIGtleGVjIGd1eXMgKGNjZWQgcmVsZXZhbnQgcGVvcGxlKSB3YW50aW5nIHRvIGFkZCBh
Cj4gPiA+IHNodXRkb3duIG1ldGhvZCBmb3IgdmlyaXRvIHRvIGZpeCBwb3RlbnRpYWwga2V4ZWMg
aXNzdWVzLgo+ID4gPiAKPiA+ID4gVGhhbmtzCj4gPiA+IAo+ID4gPiA+IAo+ID4gPiA+IFRoYW5r
cywKPiA+ID4gPiBEcmFnb3MKPiA+ID4gPiA+IFRoYW5rcwo+ID4gPiA+ID4gCj4gPiA+ID4gPiA+
IAo+ID4gPiA+ID4gPiBJIGRvbid0IHJlYWxseSBrbm93IG11Y2ggYWJvdXQgd2h5IHNodXRkb3du
IGNhbGxiYWNrIGlzIGV2ZW4KPiA+ID4gPiA+ID4gbmVjZXNzYXJ5Lgo+ID4gPiA+ID4gPiBJIGd1
ZXNzIHRoaXMgaXMgdG8gZGV0ZWN0IHNodXRkb3duIGFuZCBkbyBhIGZhc3RlciBjbGVhbnVwIHRo
YW4KPiA+ID4gPiA+ID4gdGhlIHNsb3csIGdyYWNlZnVsIHJlbW92YWwsIGp1c3QgY2xlYW5pbmcg
aGFyZHdhcmUgcmVzb3VyY2VzPwo+ID4gPiA+ID4gPiAKPiA+IC5zaHV0ZG93biBjb3VsZCBiZSBy
ZW1vdmVkIGluIG1seDVfdmRwYS4gQnV0IEkgbm90aWNlIHRoYXQgbWx4NV9jb3JlJ3MKPiA+IC5z
aHV0ZG93bgo+ID4ga2lja3MgaW4gZnJvbSBwY2lfZGV2aWNlX3NodXRkb3duIHRvIGNsZWFuIHRo
ZSBpcnFzLiBTbyB0aGUgaXJxcyB3aWxsIHN0aWxsIGJlCj4gPiBmcmVlZCBidXQgYXMgYSBzaWRl
IGVmZmVjdC4gV2hpY2ggaXMgbm90IGdvb2QuCj4gPiAKPiA+IFRoYW5rcywKPiA+IERyYWdvcwo+
IAoKX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18KVmlydHVh
bGl6YXRpb24gbWFpbGluZyBsaXN0ClZpcnR1YWxpemF0aW9uQGxpc3RzLmxpbnV4LWZvdW5kYXRp
b24ub3JnCmh0dHBzOi8vbGlzdHMubGludXhmb3VuZGF0aW9uLm9yZy9tYWlsbWFuL2xpc3RpbmZv
L3ZpcnR1YWxpemF0aW9u
