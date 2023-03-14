Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D9A6BC74A44
	for <virtualization@archiver.kernel.org>; Tue, 14 Mar 2023 05:28:04 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 29285415D0;
	Tue, 14 Mar 2023 05:28:04 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org 29285415D0
Authentication-Results: smtp4.osuosl.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=M3DUhjrP
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
	by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id JKrOZP61UirG; Tue, 14 Mar 2023 05:28:02 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp4.osuosl.org (Postfix) with ESMTPS id 1D9BC413D3;
	Tue, 14 Mar 2023 05:28:02 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org 1D9BC413D3
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id DC418C0035;
	Tue, 14 Mar 2023 05:28:01 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [IPv6:2605:bc80:3010::136])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 0E8C6C0032
 for <virtualization@lists.linux-foundation.org>;
 Tue, 14 Mar 2023 05:28:01 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id C95D8608F5
 for <virtualization@lists.linux-foundation.org>;
 Tue, 14 Mar 2023 05:28:00 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org C95D8608F5
Authentication-Results: smtp3.osuosl.org;
 dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com
 header.a=rsa-sha256 header.s=mimecast20190719 header.b=M3DUhjrP
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id Yx-xE8sOqE6s
 for <virtualization@lists.linux-foundation.org>;
 Tue, 14 Mar 2023 05:27:59 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 7B5DF606BF
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.133.124])
 by smtp3.osuosl.org (Postfix) with ESMTPS id 7B5DF606BF
 for <virtualization@lists.linux-foundation.org>;
 Tue, 14 Mar 2023 05:27:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1678771678;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=74YVjMeZYJ/+4qW5PTolxDEnVNnarX5wmoCeaFRiDfA=;
 b=M3DUhjrPmM0BpOcRrlkM8CMeUFe3cFfPjK/ync8W60eqD3juOdmP+5C4Dr4Ig4Yz+PEjz4
 PVaV7bMWhxzVQ72+Nowp25qwSvjqIXdoNttAWTz6lLV3bSY9cMwgtieg4+r+32d9BhEtZz
 Cm74TAW/1ANZOoYVac9ihm9itPzOgGg=
Received: from mail-oi1-f197.google.com (mail-oi1-f197.google.com
 [209.85.167.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-288-ydz_FydOPr-aygSsDYqtmQ-1; Tue, 14 Mar 2023 01:27:56 -0400
X-MC-Unique: ydz_FydOPr-aygSsDYqtmQ-1
Received: by mail-oi1-f197.google.com with SMTP id
 be41-20020a05680821a900b0038464ba0c1eso6380532oib.3
 for <virtualization@lists.linux-foundation.org>;
 Mon, 13 Mar 2023 22:27:56 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112; t=1678771675;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=74YVjMeZYJ/+4qW5PTolxDEnVNnarX5wmoCeaFRiDfA=;
 b=3756z2xu8/AHVXZzcVd3FQCi6pGCr14rz8VlXNUcCHTSHXc7vm5MnoV12EcrE0TPBW
 ahXAYywlcLLirr508tEgKacFmN+Bnz6t/GsWtRMDQbkTNQS76Q6dHDvKQlRYflIaij9s
 PJkQE2+4X42gM44MZhVJBYFeeKxnmh9abM3rzsLPqU7Y58maHBRLOdzshzAAme5wbWGH
 CuZPQfgkEB44rfGQ+ESZsBXmC61gzcEozVvFlgzf3sdwaDiG1+Q13XNq9DQ/GTvh2fD5
 duIy7D4NXQ9dnndXYWA+YO81AtTyYvp+GwAhv7XTPzvtyg2LkpfGaJSciL4ib2XXxvkx
 UT3Q==
X-Gm-Message-State: AO0yUKVIifZY7e2m7FJpOkT7fWnLZPL0WfhNZ/ho4rX61U6O1ntSvrps
 ilOifNjH9zwzVG2d0YWb+yy+m/kvObINZkdwx8kBiVkDlXAC72SKQFP6ZYbnzZmOVX2/eJ9Jdf6
 JWejyYKrny8pmwOy67oB8iJ4AfI94D0pB1WFcEiqiN//ffKgcP24Sh6E3Xw==
X-Received: by 2002:a05:6870:649f:b0:177:9f9c:dc5 with SMTP id
 cz31-20020a056870649f00b001779f9c0dc5mr3166808oab.9.1678771675401; 
 Mon, 13 Mar 2023 22:27:55 -0700 (PDT)
X-Google-Smtp-Source: AK7set9QOJ7ciYFjVW3GiuDKQSvMWlshd6BM1hnDFL4Rhm/47+qNQ38RbqdkPnlBDKyx4GeN0ylotbZjEz8cf6SNE9I=
X-Received: by 2002:a05:6870:649f:b0:177:9f9c:dc5 with SMTP id
 cz31-20020a056870649f00b001779f9c0dc5mr3166800oab.9.1678771675172; Mon, 13
 Mar 2023 22:27:55 -0700 (PDT)
MIME-Version: 1.0
References: <20230302113421.174582-1-sgarzare@redhat.com>
 <20230302113421.174582-6-sgarzare@redhat.com>
In-Reply-To: <20230302113421.174582-6-sgarzare@redhat.com>
From: Jason Wang <jasowang@redhat.com>
Date: Tue, 14 Mar 2023 13:27:44 +0800
Message-ID: <CACGkMEvhpkOH-YAHdt4EGC2qQT0iNw7mhVA9nWuf7bd0yLrchQ@mail.gmail.com>
Subject: Re: [PATCH v2 5/8] vdpa_sim: make devices agnostic for work management
To: Stefano Garzarella <sgarzare@redhat.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Cc: Andrey Zhadchenko <andrey.zhadchenko@virtuozzo.com>, kvm@vger.kernel.org,
 "Michael S. Tsirkin" <mst@redhat.com>, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org, virtualization@lists.linux-foundation.org,
 eperezma@redhat.com, stefanha@redhat.com
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

T24gVGh1LCBNYXIgMiwgMjAyMyBhdCA3OjM14oCvUE0gU3RlZmFubyBHYXJ6YXJlbGxhIDxzZ2Fy
emFyZUByZWRoYXQuY29tPiB3cm90ZToKPgo+IExldCdzIG1vdmUgd29yayBtYW5hZ2VtZW50IGlu
c2lkZSB0aGUgdmRwYV9zaW0gY29yZS4KPiBUaGlzIHdheSB3ZSBjYW4gZWFzaWx5IGNoYW5nZSBo
b3cgd2UgbWFuYWdlIHRoZSB3b3Jrcywgd2l0aG91dAo+IGhhdmluZyB0byBjaGFuZ2UgdGhlIGRl
dmljZXMgZWFjaCB0aW1lLgo+Cj4gU2lnbmVkLW9mZi1ieTogU3RlZmFubyBHYXJ6YXJlbGxhIDxz
Z2FyemFyZUByZWRoYXQuY29tPgoKQWNrZWQtYnk6IEphc29uIFdhbmcgPGphc293YW5nQHJlZGhh
dC5jb20+CgpUaGFua3MKCj4gLS0tCj4gIGRyaXZlcnMvdmRwYS92ZHBhX3NpbS92ZHBhX3NpbS5o
ICAgICB8ICAzICsrLQo+ICBkcml2ZXJzL3ZkcGEvdmRwYV9zaW0vdmRwYV9zaW0uYyAgICAgfCAx
NyArKysrKysrKysrKysrKystLQo+ICBkcml2ZXJzL3ZkcGEvdmRwYV9zaW0vdmRwYV9zaW1fYmxr
LmMgfCAgNiArKy0tLS0KPiAgZHJpdmVycy92ZHBhL3ZkcGFfc2ltL3ZkcGFfc2ltX25ldC5jIHwg
IDYgKystLS0tCj4gIDQgZmlsZXMgY2hhbmdlZCwgMjEgaW5zZXJ0aW9ucygrKSwgMTEgZGVsZXRp
b25zKC0pCj4KPiBkaWZmIC0tZ2l0IGEvZHJpdmVycy92ZHBhL3ZkcGFfc2ltL3ZkcGFfc2ltLmgg
Yi9kcml2ZXJzL3ZkcGEvdmRwYV9zaW0vdmRwYV9zaW0uaAo+IGluZGV4IDE0NDg1ODYzNmMxMC4u
YWNlZTIwZmFhZjZhIDEwMDY0NAo+IC0tLSBhL2RyaXZlcnMvdmRwYS92ZHBhX3NpbS92ZHBhX3Np
bS5oCj4gKysrIGIvZHJpdmVycy92ZHBhL3ZkcGFfc2ltL3ZkcGFfc2ltLmgKPiBAQCAtNDUsNyAr
NDUsNyBAQCBzdHJ1Y3QgdmRwYXNpbV9kZXZfYXR0ciB7Cj4gICAgICAgICB1MzIgbmdyb3VwczsK
PiAgICAgICAgIHUzMiBuYXM7Cj4KPiAtICAgICAgIHdvcmtfZnVuY190IHdvcmtfZm47Cj4gKyAg
ICAgICB2b2lkICgqd29ya19mbikoc3RydWN0IHZkcGFzaW0gKnZkcGFzaW0pOwo+ICAgICAgICAg
dm9pZCAoKmdldF9jb25maWcpKHN0cnVjdCB2ZHBhc2ltICp2ZHBhc2ltLCB2b2lkICpjb25maWcp
Owo+ICAgICAgICAgdm9pZCAoKnNldF9jb25maWcpKHN0cnVjdCB2ZHBhc2ltICp2ZHBhc2ltLCBj
b25zdCB2b2lkICpjb25maWcpOwo+ICAgICAgICAgaW50ICgqZ2V0X3N0YXRzKShzdHJ1Y3QgdmRw
YXNpbSAqdmRwYXNpbSwgdTE2IGlkeCwKPiBAQCAtNzgsNiArNzgsNyBAQCBzdHJ1Y3QgdmRwYXNp
bSB7Cj4KPiAgc3RydWN0IHZkcGFzaW0gKnZkcGFzaW1fY3JlYXRlKHN0cnVjdCB2ZHBhc2ltX2Rl
dl9hdHRyICphdHRyLAo+ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICBjb25zdCBzdHJ1
Y3QgdmRwYV9kZXZfc2V0X2NvbmZpZyAqY29uZmlnKTsKPiArdm9pZCB2ZHBhc2ltX3NjaGVkdWxl
X3dvcmsoc3RydWN0IHZkcGFzaW0gKnZkcGFzaW0pOwo+Cj4gIC8qIFRPRE86IGNyb3NzLWVuZGlh
biBzdXBwb3J0ICovCj4gIHN0YXRpYyBpbmxpbmUgYm9vbCB2ZHBhc2ltX2lzX2xpdHRsZV9lbmRp
YW4oc3RydWN0IHZkcGFzaW0gKnZkcGFzaW0pCj4gZGlmZiAtLWdpdCBhL2RyaXZlcnMvdmRwYS92
ZHBhX3NpbS92ZHBhX3NpbS5jIGIvZHJpdmVycy92ZHBhL3ZkcGFfc2ltL3ZkcGFfc2ltLmMKPiBp
bmRleCA0ODFlYjE1NjY1OGIuLmE2ZWU4MzBlZmMzOCAxMDA2NDQKPiAtLS0gYS9kcml2ZXJzL3Zk
cGEvdmRwYV9zaW0vdmRwYV9zaW0uYwo+ICsrKyBiL2RyaXZlcnMvdmRwYS92ZHBhX3NpbS92ZHBh
X3NpbS5jCj4gQEAgLTExNiw2ICsxMTYsMTMgQEAgc3RhdGljIHZvaWQgdmRwYXNpbV9kb19yZXNl
dChzdHJ1Y3QgdmRwYXNpbSAqdmRwYXNpbSkKPiAgc3RhdGljIGNvbnN0IHN0cnVjdCB2ZHBhX2Nv
bmZpZ19vcHMgdmRwYXNpbV9jb25maWdfb3BzOwo+ICBzdGF0aWMgY29uc3Qgc3RydWN0IHZkcGFf
Y29uZmlnX29wcyB2ZHBhc2ltX2JhdGNoX2NvbmZpZ19vcHM7Cj4KPiArc3RhdGljIHZvaWQgdmRw
YXNpbV93b3JrX2ZuKHN0cnVjdCB3b3JrX3N0cnVjdCAqd29yaykKPiArewo+ICsgICAgICAgc3Ry
dWN0IHZkcGFzaW0gKnZkcGFzaW0gPSBjb250YWluZXJfb2Yod29yaywgc3RydWN0IHZkcGFzaW0s
IHdvcmspOwo+ICsKPiArICAgICAgIHZkcGFzaW0tPmRldl9hdHRyLndvcmtfZm4odmRwYXNpbSk7
Cj4gK30KPiArCj4gIHN0cnVjdCB2ZHBhc2ltICp2ZHBhc2ltX2NyZWF0ZShzdHJ1Y3QgdmRwYXNp
bV9kZXZfYXR0ciAqZGV2X2F0dHIsCj4gICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgIGNv
bnN0IHN0cnVjdCB2ZHBhX2Rldl9zZXRfY29uZmlnICpjb25maWcpCj4gIHsKPiBAQCAtMTUyLDcg
KzE1OSw3IEBAIHN0cnVjdCB2ZHBhc2ltICp2ZHBhc2ltX2NyZWF0ZShzdHJ1Y3QgdmRwYXNpbV9k
ZXZfYXR0ciAqZGV2X2F0dHIsCj4KPiAgICAgICAgIHZkcGFzaW0gPSB2ZHBhX3RvX3NpbSh2ZHBh
KTsKPiAgICAgICAgIHZkcGFzaW0tPmRldl9hdHRyID0gKmRldl9hdHRyOwo+IC0gICAgICAgSU5J
VF9XT1JLKCZ2ZHBhc2ltLT53b3JrLCBkZXZfYXR0ci0+d29ya19mbik7Cj4gKyAgICAgICBJTklU
X1dPUksoJnZkcGFzaW0tPndvcmssIHZkcGFzaW1fd29ya19mbik7Cj4gICAgICAgICBzcGluX2xv
Y2tfaW5pdCgmdmRwYXNpbS0+bG9jayk7Cj4gICAgICAgICBzcGluX2xvY2tfaW5pdCgmdmRwYXNp
bS0+aW9tbXVfbG9jayk7Cj4KPiBAQCAtMjAzLDYgKzIxMCwxMiBAQCBzdHJ1Y3QgdmRwYXNpbSAq
dmRwYXNpbV9jcmVhdGUoc3RydWN0IHZkcGFzaW1fZGV2X2F0dHIgKmRldl9hdHRyLAo+ICB9Cj4g
IEVYUE9SVF9TWU1CT0xfR1BMKHZkcGFzaW1fY3JlYXRlKTsKPgo+ICt2b2lkIHZkcGFzaW1fc2No
ZWR1bGVfd29yayhzdHJ1Y3QgdmRwYXNpbSAqdmRwYXNpbSkKPiArewo+ICsgICAgICAgc2NoZWR1
bGVfd29yaygmdmRwYXNpbS0+d29yayk7Cj4gK30KPiArRVhQT1JUX1NZTUJPTF9HUEwodmRwYXNp
bV9zY2hlZHVsZV93b3JrKTsKPiArCj4gIHN0YXRpYyBpbnQgdmRwYXNpbV9zZXRfdnFfYWRkcmVz
cyhzdHJ1Y3QgdmRwYV9kZXZpY2UgKnZkcGEsIHUxNiBpZHgsCj4gICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgIHU2NCBkZXNjX2FyZWEsIHU2NCBkcml2ZXJfYXJlYSwKPiAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgdTY0IGRldmljZV9hcmVhKQo+IEBAIC0yMzcsNyAr
MjUwLDcgQEAgc3RhdGljIHZvaWQgdmRwYXNpbV9raWNrX3ZxKHN0cnVjdCB2ZHBhX2RldmljZSAq
dmRwYSwgdTE2IGlkeCkKPiAgICAgICAgIH0KPgo+ICAgICAgICAgaWYgKHZxLT5yZWFkeSkKPiAt
ICAgICAgICAgICAgICAgc2NoZWR1bGVfd29yaygmdmRwYXNpbS0+d29yayk7Cj4gKyAgICAgICAg
ICAgICAgIHZkcGFzaW1fc2NoZWR1bGVfd29yayh2ZHBhc2ltKTsKPiAgfQo+Cj4gIHN0YXRpYyB2
b2lkIHZkcGFzaW1fc2V0X3ZxX2NiKHN0cnVjdCB2ZHBhX2RldmljZSAqdmRwYSwgdTE2IGlkeCwK
PiBkaWZmIC0tZ2l0IGEvZHJpdmVycy92ZHBhL3ZkcGFfc2ltL3ZkcGFfc2ltX2Jsay5jIGIvZHJp
dmVycy92ZHBhL3ZkcGFfc2ltL3ZkcGFfc2ltX2Jsay5jCj4gaW5kZXggNTExNzk1OWJlZDhhLi5l
YjQ4OTdjODU0MWUgMTAwNjQ0Cj4gLS0tIGEvZHJpdmVycy92ZHBhL3ZkcGFfc2ltL3ZkcGFfc2lt
X2Jsay5jCj4gKysrIGIvZHJpdmVycy92ZHBhL3ZkcGFfc2ltL3ZkcGFfc2ltX2Jsay5jCj4gQEAg
LTExLDcgKzExLDYgQEAKPiAgI2luY2x1ZGUgPGxpbnV4L21vZHVsZS5oPgo+ICAjaW5jbHVkZSA8
bGludXgvZGV2aWNlLmg+Cj4gICNpbmNsdWRlIDxsaW51eC9rZXJuZWwuaD4KPiAtI2luY2x1ZGUg
PGxpbnV4L3NjaGVkLmg+Cj4gICNpbmNsdWRlIDxsaW51eC9ibGtkZXYuaD4KPiAgI2luY2x1ZGUg
PGxpbnV4L3ZyaW5naC5oPgo+ICAjaW5jbHVkZSA8bGludXgvdmRwYS5oPgo+IEBAIC0yODYsOSAr
Mjg1LDggQEAgc3RhdGljIGJvb2wgdmRwYXNpbV9ibGtfaGFuZGxlX3JlcShzdHJ1Y3QgdmRwYXNp
bSAqdmRwYXNpbSwKPiAgICAgICAgIHJldHVybiBoYW5kbGVkOwo+ICB9Cj4KPiAtc3RhdGljIHZv
aWQgdmRwYXNpbV9ibGtfd29yayhzdHJ1Y3Qgd29ya19zdHJ1Y3QgKndvcmspCj4gK3N0YXRpYyB2
b2lkIHZkcGFzaW1fYmxrX3dvcmsoc3RydWN0IHZkcGFzaW0gKnZkcGFzaW0pCj4gIHsKPiAtICAg
ICAgIHN0cnVjdCB2ZHBhc2ltICp2ZHBhc2ltID0gY29udGFpbmVyX29mKHdvcmssIHN0cnVjdCB2
ZHBhc2ltLCB3b3JrKTsKPiAgICAgICAgIGJvb2wgcmVzY2hlZHVsZSA9IGZhbHNlOwo+ICAgICAg
ICAgaW50IGk7Cj4KPiBAQCAtMzI2LDcgKzMyNCw3IEBAIHN0YXRpYyB2b2lkIHZkcGFzaW1fYmxr
X3dvcmsoc3RydWN0IHdvcmtfc3RydWN0ICp3b3JrKQo+ICAgICAgICAgc3Bpbl91bmxvY2soJnZk
cGFzaW0tPmxvY2spOwo+Cj4gICAgICAgICBpZiAocmVzY2hlZHVsZSkKPiAtICAgICAgICAgICAg
ICAgc2NoZWR1bGVfd29yaygmdmRwYXNpbS0+d29yayk7Cj4gKyAgICAgICAgICAgICAgIHZkcGFz
aW1fc2NoZWR1bGVfd29yayh2ZHBhc2ltKTsKPiAgfQo+Cj4gIHN0YXRpYyB2b2lkIHZkcGFzaW1f
YmxrX2dldF9jb25maWcoc3RydWN0IHZkcGFzaW0gKnZkcGFzaW0sIHZvaWQgKmNvbmZpZykKPiBk
aWZmIC0tZ2l0IGEvZHJpdmVycy92ZHBhL3ZkcGFfc2ltL3ZkcGFfc2ltX25ldC5jIGIvZHJpdmVy
cy92ZHBhL3ZkcGFfc2ltL3ZkcGFfc2ltX25ldC5jCj4gaW5kZXggODYyZjQwNTM2MmRlLi5lNjFh
OWVjYmZhZmUgMTAwNjQ0Cj4gLS0tIGEvZHJpdmVycy92ZHBhL3ZkcGFfc2ltL3ZkcGFfc2ltX25l
dC5jCj4gKysrIGIvZHJpdmVycy92ZHBhL3ZkcGFfc2ltL3ZkcGFfc2ltX25ldC5jCj4gQEAgLTEx
LDcgKzExLDYgQEAKPiAgI2luY2x1ZGUgPGxpbnV4L21vZHVsZS5oPgo+ICAjaW5jbHVkZSA8bGlu
dXgvZGV2aWNlLmg+Cj4gICNpbmNsdWRlIDxsaW51eC9rZXJuZWwuaD4KPiAtI2luY2x1ZGUgPGxp
bnV4L3NjaGVkLmg+Cj4gICNpbmNsdWRlIDxsaW51eC9ldGhlcmRldmljZS5oPgo+ICAjaW5jbHVk
ZSA8bGludXgvdnJpbmdoLmg+Cj4gICNpbmNsdWRlIDxsaW51eC92ZHBhLmg+Cj4gQEAgLTE5Miw5
ICsxOTEsOCBAQCBzdGF0aWMgdm9pZCB2ZHBhc2ltX2hhbmRsZV9jdnEoc3RydWN0IHZkcGFzaW0g
KnZkcGFzaW0pCj4gICAgICAgICB1NjRfc3RhdHNfdXBkYXRlX2VuZCgmbmV0LT5jcV9zdGF0cy5z
eW5jcCk7Cj4gIH0KPgo+IC1zdGF0aWMgdm9pZCB2ZHBhc2ltX25ldF93b3JrKHN0cnVjdCB3b3Jr
X3N0cnVjdCAqd29yaykKPiArc3RhdGljIHZvaWQgdmRwYXNpbV9uZXRfd29yayhzdHJ1Y3QgdmRw
YXNpbSAqdmRwYXNpbSkKPiAgewo+IC0gICAgICAgc3RydWN0IHZkcGFzaW0gKnZkcGFzaW0gPSBj
b250YWluZXJfb2Yod29yaywgc3RydWN0IHZkcGFzaW0sIHdvcmspOwo+ICAgICAgICAgc3RydWN0
IHZkcGFzaW1fdmlydHF1ZXVlICp0eHEgPSAmdmRwYXNpbS0+dnFzWzFdOwo+ICAgICAgICAgc3Ry
dWN0IHZkcGFzaW1fdmlydHF1ZXVlICpyeHEgPSAmdmRwYXNpbS0+dnFzWzBdOwo+ICAgICAgICAg
c3RydWN0IHZkcGFzaW1fbmV0ICpuZXQgPSBzaW1fdG9fbmV0KHZkcGFzaW0pOwo+IEBAIC0yNjAs
NyArMjU4LDcgQEAgc3RhdGljIHZvaWQgdmRwYXNpbV9uZXRfd29yayhzdHJ1Y3Qgd29ya19zdHJ1
Y3QgKndvcmspCj4gICAgICAgICAgICAgICAgIHZkcGFzaW1fbmV0X2NvbXBsZXRlKHJ4cSwgd3Jp
dGUpOwo+Cj4gICAgICAgICAgICAgICAgIGlmICh0eF9wa3RzID4gNCkgewo+IC0gICAgICAgICAg
ICAgICAgICAgICAgIHNjaGVkdWxlX3dvcmsoJnZkcGFzaW0tPndvcmspOwo+ICsgICAgICAgICAg
ICAgICAgICAgICAgIHZkcGFzaW1fc2NoZWR1bGVfd29yayh2ZHBhc2ltKTsKPiAgICAgICAgICAg
ICAgICAgICAgICAgICBnb3RvIG91dDsKPiAgICAgICAgICAgICAgICAgfQo+ICAgICAgICAgfQo+
IC0tCj4gMi4zOS4yCj4KCl9fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fClZpcnR1YWxpemF0aW9uIG1haWxpbmcgbGlzdApWaXJ0dWFsaXphdGlvbkBsaXN0cy5s
aW51eC1mb3VuZGF0aW9uLm9yZwpodHRwczovL2xpc3RzLmxpbnV4Zm91bmRhdGlvbi5vcmcvbWFp
bG1hbi9saXN0aW5mby92aXJ0dWFsaXphdGlvbg==
