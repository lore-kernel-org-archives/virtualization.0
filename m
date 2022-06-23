Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2AE05C43334
	for <virtualization@archiver.kernel.org>; Thu, 23 Jun 2022 03:50:43 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id BAB0261340;
	Thu, 23 Jun 2022 03:50:42 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org BAB0261340
Authentication-Results: smtp3.osuosl.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=Z9IcwVaL
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
	by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id mUEs-BHZixrz; Thu, 23 Jun 2022 03:50:41 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp3.osuosl.org (Postfix) with ESMTPS id 1EE766133E;
	Thu, 23 Jun 2022 03:50:41 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 1EE766133E
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id C6C50C0032;
	Thu, 23 Jun 2022 03:50:40 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [IPv6:2605:bc80:3010::138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 28888C002D
 for <virtualization@lists.linux-foundation.org>;
 Thu, 23 Jun 2022 03:50:39 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id 02CD084608
 for <virtualization@lists.linux-foundation.org>;
 Thu, 23 Jun 2022 03:50:39 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 02CD084608
Authentication-Results: smtp1.osuosl.org;
 dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com
 header.a=rsa-sha256 header.s=mimecast20190719 header.b=Z9IcwVaL
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id XVWpnQc82_aD
 for <virtualization@lists.linux-foundation.org>;
 Thu, 23 Jun 2022 03:50:38 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 4820584605
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.133.124])
 by smtp1.osuosl.org (Postfix) with ESMTPS id 4820584605
 for <virtualization@lists.linux-foundation.org>;
 Thu, 23 Jun 2022 03:50:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1655956236;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=SS9ZQeVISzK//7xTKb4KEM9pFFxxfL9dDdxuN/WOdIc=;
 b=Z9IcwVaL9ZuJQLF1/2u16cJYAydlf7k2XHXbqANu8Wo+6NTd8RZ/JCe1t4bJWHLL9aAWjp
 GMTgD6dLj508514GcZhoZx5T1kJS8v3CjO0hVwMUQk4D0Aa00j3vDPxnfaSt2ILaW7X5+/
 +o03QfeM5pqQ3H6c5/hIsC1h+EDpDs0=
Received: from mail-lf1-f70.google.com (mail-lf1-f70.google.com
 [209.85.167.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-594-jkZJ9w4_MzS7HG-wrT3i8w-1; Wed, 22 Jun 2022 23:50:35 -0400
X-MC-Unique: jkZJ9w4_MzS7HG-wrT3i8w-1
Received: by mail-lf1-f70.google.com with SMTP id
 j3-20020a05651231c300b0047dbea7b031so9372040lfe.19
 for <virtualization@lists.linux-foundation.org>;
 Wed, 22 Jun 2022 20:50:35 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc:content-transfer-encoding;
 bh=SS9ZQeVISzK//7xTKb4KEM9pFFxxfL9dDdxuN/WOdIc=;
 b=6Z4MK26WhtdDcbEwjzvXsOYmUgWoJ/eUYzvtXstCyUSBVceYQqvj3WzpySKQMTZPfD
 Z0hfHVEFP+C8DsZ4hRk0cnsE7jrygvCtyB/81WqrREWcs7+aFm/I9znf4H6OXEQSvGum
 JOFFyem7NMANaF4/ZW/XN0/6NIzB0dXzA8x01Pyt+wYDXQ9jfDEHTd7dL2exAtBY67DW
 vwBoDsP3suhhbF2/Wa1MmXj4xJccmCDqC+zf8IP7oSSVhgEeA8wRnnjR7cH1gcPXmadq
 tysSiHH62ph5yH1l95YklTD3ZXrgxlrxcvqhuwA5qfubQJyHHJ+r3Qg4Fk3ErM5fEn5a
 vpeQ==
X-Gm-Message-State: AJIora+U+ktGd1malJ2+dRZJtQcxYWkXgFC7sFXWCyw5QDsySAYBTyxI
 9EADYGKhN+ZYE4FtDmpm1qwgYkWdLr1G6vBO7PTEQG224CHzIirb47e49WE7ceMpqWZWcItHeXB
 R1cOWhXOXIG2rhadfnu6vqmE9/OnCXaljbP5BjICEd53FH7lJ9NI46wNrRQ==
X-Received: by 2002:a05:6512:13a5:b0:47d:c1d9:dea8 with SMTP id
 p37-20020a05651213a500b0047dc1d9dea8mr4191413lfa.442.1655956233910; 
 Wed, 22 Jun 2022 20:50:33 -0700 (PDT)
X-Google-Smtp-Source: AGRyM1uJxrXj31U9449urMcIxVr7ouushJMsv4RghnzNimWrXWCJynHAMroZ8HhfAW1QET/wi7Px5SnUH4BMCrzV/Pg=
X-Received: by 2002:a05:6512:13a5:b0:47d:c1d9:dea8 with SMTP id
 p37-20020a05651213a500b0047dc1d9dea8mr4191404lfa.442.1655956233710; Wed, 22
 Jun 2022 20:50:33 -0700 (PDT)
MIME-Version: 1.0
References: <20220621160859.196646-1-sgarzare@redhat.com>
 <20220621160859.196646-3-sgarzare@redhat.com>
In-Reply-To: <20220621160859.196646-3-sgarzare@redhat.com>
From: Jason Wang <jasowang@redhat.com>
Date: Thu, 23 Jun 2022 11:50:22 +0800
Message-ID: <CACGkMEsk-O=dVwKoEHRY-nL3XEQktPWiBot2NfOUYNdkoL-s=Q@mail.gmail.com>
Subject: Re: [PATCH 2/3] vdpa_sim_blk: limit the number of request handled per
 batch
To: Stefano Garzarella <sgarzare@redhat.com>
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=jasowang@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Cc: =?UTF-8?Q?Eugenio_P=C3=A9rez?= <eperezma@redhat.com>,
 "Michael S. Tsirkin" <mst@redhat.com>,
 linux-kernel <linux-kernel@vger.kernel.org>,
 virtualization <virtualization@lists.linux-foundation.org>
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

T24gV2VkLCBKdW4gMjIsIDIwMjIgYXQgMTI6MDkgQU0gU3RlZmFubyBHYXJ6YXJlbGxhIDxzZ2Fy
emFyZUByZWRoYXQuY29tPiB3cm90ZToKPgo+IExpbWl0IHRoZSBudW1iZXIgb2YgcmVxdWVzdHMg
KDQgcGVyIHF1ZXVlIGFzIGZvciB2ZHBhX3NpbV9uZXQpIGhhbmRsZWQKPiBpbiBhIGJhdGNoIHRv
IHByZXZlbnQgdGhlIHdvcmtlciBmcm9tIHVzaW5nIHRoZSBDUFUgZm9yIHRvbyBsb25nLgo+Cj4g
U3VnZ2VzdGVkLWJ5OiBFdWdlbmlvIFDDqXJleiA8ZXBlcmV6bWFAcmVkaGF0LmNvbT4KPiBTaWdu
ZWQtb2ZmLWJ5OiBTdGVmYW5vIEdhcnphcmVsbGEgPHNnYXJ6YXJlQHJlZGhhdC5jb20+Cj4gLS0t
Cj4gIGRyaXZlcnMvdmRwYS92ZHBhX3NpbS92ZHBhX3NpbV9ibGsuYyB8IDE1ICsrKysrKysrKysr
KysrLQo+ICAxIGZpbGUgY2hhbmdlZCwgMTQgaW5zZXJ0aW9ucygrKSwgMSBkZWxldGlvbigtKQo+
Cj4gZGlmZiAtLWdpdCBhL2RyaXZlcnMvdmRwYS92ZHBhX3NpbS92ZHBhX3NpbV9ibGsuYyBiL2Ry
aXZlcnMvdmRwYS92ZHBhX3NpbS92ZHBhX3NpbV9ibGsuYwo+IGluZGV4IGE4M2E1Yzc2ZjYyMC4u
YWM4NjQ3ODg0NWI2IDEwMDY0NAo+IC0tLSBhL2RyaXZlcnMvdmRwYS92ZHBhX3NpbS92ZHBhX3Np
bV9ibGsuYwo+ICsrKyBiL2RyaXZlcnMvdmRwYS92ZHBhX3NpbS92ZHBhX3NpbV9ibGsuYwo+IEBA
IC0xOTcsNiArMTk3LDcgQEAgc3RhdGljIGJvb2wgdmRwYXNpbV9ibGtfaGFuZGxlX3JlcShzdHJ1
Y3QgdmRwYXNpbSAqdmRwYXNpbSwKPiAgc3RhdGljIHZvaWQgdmRwYXNpbV9ibGtfd29yayhzdHJ1
Y3Qgd29ya19zdHJ1Y3QgKndvcmspCj4gIHsKPiAgICAgICAgIHN0cnVjdCB2ZHBhc2ltICp2ZHBh
c2ltID0gY29udGFpbmVyX29mKHdvcmssIHN0cnVjdCB2ZHBhc2ltLCB3b3JrKTsKPiArICAgICAg
IGJvb2wgcmVzY2hlZHVsZSA9IGZhbHNlOwo+ICAgICAgICAgaW50IGk7Cj4KPiAgICAgICAgIHNw
aW5fbG9jaygmdmRwYXNpbS0+bG9jayk7Cj4gQEAgLTIwNiwxMSArMjA3LDE1IEBAIHN0YXRpYyB2
b2lkIHZkcGFzaW1fYmxrX3dvcmsoc3RydWN0IHdvcmtfc3RydWN0ICp3b3JrKQo+Cj4gICAgICAg
ICBmb3IgKGkgPSAwOyBpIDwgVkRQQVNJTV9CTEtfVlFfTlVNOyBpKyspIHsKPiAgICAgICAgICAg
ICAgICAgc3RydWN0IHZkcGFzaW1fdmlydHF1ZXVlICp2cSA9ICZ2ZHBhc2ltLT52cXNbaV07Cj4g
KyAgICAgICAgICAgICAgIGJvb2wgdnFfd29yayA9IHRydWU7Cj4gKyAgICAgICAgICAgICAgIGlu
dCByZXFzID0gMDsKPgo+ICAgICAgICAgICAgICAgICBpZiAoIXZxLT5yZWFkeSkKPiAgICAgICAg
ICAgICAgICAgICAgICAgICBjb250aW51ZTsKPgo+IC0gICAgICAgICAgICAgICB3aGlsZSAodmRw
YXNpbV9ibGtfaGFuZGxlX3JlcSh2ZHBhc2ltLCB2cSkpIHsKPiArICAgICAgICAgICAgICAgd2hp
bGUgKHZxX3dvcmspIHsKPiArICAgICAgICAgICAgICAgICAgICAgICB2cV93b3JrID0gdmRwYXNp
bV9ibGtfaGFuZGxlX3JlcSh2ZHBhc2ltLCB2cSk7Cj4gKwoKSXMgaXQgYmV0dGVyIHRvIGNoZWNr
IGFuZCBleGl0IHRoZSBsb29wIGVhcmx5IGhlcmU/CgpUaGFua3MKCj4gICAgICAgICAgICAgICAg
ICAgICAgICAgLyogTWFrZSBzdXJlIHVzZWQgaXMgdmlzaWJsZSBiZWZvcmUgcmFzaW5nIHRoZSBp
bnRlcnJ1cHQuICovCj4gICAgICAgICAgICAgICAgICAgICAgICAgc21wX3dtYigpOwo+Cj4gQEAg
LTIxOCwxMCArMjIzLDE4IEBAIHN0YXRpYyB2b2lkIHZkcGFzaW1fYmxrX3dvcmsoc3RydWN0IHdv
cmtfc3RydWN0ICp3b3JrKQo+ICAgICAgICAgICAgICAgICAgICAgICAgIGlmICh2cmluZ2hfbmVl
ZF9ub3RpZnlfaW90bGIoJnZxLT52cmluZykgPiAwKQo+ICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgdnJpbmdoX25vdGlmeSgmdnEtPnZyaW5nKTsKPiAgICAgICAgICAgICAgICAgICAg
ICAgICBsb2NhbF9iaF9lbmFibGUoKTsKPiArCj4gKyAgICAgICAgICAgICAgICAgICAgICAgaWYg
KCsrcmVxcyA+IDQpIHsKPiArICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgIHZxX3dvcmsg
PSBmYWxzZTsKPiArICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgIHJlc2NoZWR1bGUgPSB0
cnVlOwo+ICsgICAgICAgICAgICAgICAgICAgICAgIH0KPiAgICAgICAgICAgICAgICAgfQo+ICAg
ICAgICAgfQo+ICBvdXQ6Cj4gICAgICAgICBzcGluX3VubG9jaygmdmRwYXNpbS0+bG9jayk7Cj4g
Kwo+ICsgICAgICAgaWYgKHJlc2NoZWR1bGUpCj4gKyAgICAgICAgICAgICAgIHNjaGVkdWxlX3dv
cmsoJnZkcGFzaW0tPndvcmspOwo+ICB9Cj4KPiAgc3RhdGljIHZvaWQgdmRwYXNpbV9ibGtfZ2V0
X2NvbmZpZyhzdHJ1Y3QgdmRwYXNpbSAqdmRwYXNpbSwgdm9pZCAqY29uZmlnKQo+IC0tCj4gMi4z
Ni4xCj4KCl9fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fClZp
cnR1YWxpemF0aW9uIG1haWxpbmcgbGlzdApWaXJ0dWFsaXphdGlvbkBsaXN0cy5saW51eC1mb3Vu
ZGF0aW9uLm9yZwpodHRwczovL2xpc3RzLmxpbnV4Zm91bmRhdGlvbi5vcmcvbWFpbG1hbi9saXN0
aW5mby92aXJ0dWFsaXphdGlvbg==
