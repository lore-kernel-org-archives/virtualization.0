Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D243CCDB465
	for <virtualization@archiver.kernel.org>; Tue, 17 Oct 2023 02:54:07 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 520C840974;
	Tue, 17 Oct 2023 02:54:07 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org 520C840974
Authentication-Results: smtp4.osuosl.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=CyO+EbVP
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
	by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id hEuFaDwy47kf; Tue, 17 Oct 2023 02:54:06 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp4.osuosl.org (Postfix) with ESMTPS id A6FC240977;
	Tue, 17 Oct 2023 02:54:05 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org A6FC240977
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 77727C0039;
	Tue, 17 Oct 2023 02:54:05 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [IPv6:2605:bc80:3010::137])
 by lists.linuxfoundation.org (Postfix) with ESMTP id EBE4EC0032
 for <virtualization@lists.linux-foundation.org>;
 Tue, 17 Oct 2023 02:54:03 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id C2BBB40977
 for <virtualization@lists.linux-foundation.org>;
 Tue, 17 Oct 2023 02:54:03 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org C2BBB40977
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id yy9AOzAR6WAZ
 for <virtualization@lists.linux-foundation.org>;
 Tue, 17 Oct 2023 02:54:00 +0000 (UTC)
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.129.124])
 by smtp4.osuosl.org (Postfix) with ESMTPS id 14F2840974
 for <virtualization@lists.linux-foundation.org>;
 Tue, 17 Oct 2023 02:53:59 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org 14F2840974
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1697511239;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=pOax/otkLw7+K/DCtgB4LfXc4jtPZ2fMPJUVzKsF40o=;
 b=CyO+EbVPpZPcRcD+l/4KHWr8PsKVZtzMlO4fqy/7+5gL65juS5vZWPAbuqgpoSRTguzDGy
 yoPwuO5mBKihGofztdj0bUpVNzFo+gC2FuftusbOwurk67tEN7NBy9bUyUcmzkTvgGSQM6
 CfGFqXOP+NtzoUo2FW/Z8U9yClEjODI=
Received: from mail-lf1-f72.google.com (mail-lf1-f72.google.com
 [209.85.167.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-213-LF2ZFRYYN0WN6onbl29z4g-1; Mon, 16 Oct 2023 22:53:57 -0400
X-MC-Unique: LF2ZFRYYN0WN6onbl29z4g-1
Received: by mail-lf1-f72.google.com with SMTP id
 2adb3069b0e04-507a3ae32b2so2401577e87.2
 for <virtualization@lists.linux-foundation.org>;
 Mon, 16 Oct 2023 19:53:56 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1697511235; x=1698116035;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=pOax/otkLw7+K/DCtgB4LfXc4jtPZ2fMPJUVzKsF40o=;
 b=kMfdsY2MTuWDIBPKTW99iHn8mv0AjZqKpjOORUDuJogCxbv4DLzPDQoCa+If6kzYuG
 GCWYXHkvCRMVCsCsbOfzJThSnSN6n4a5hX6qp3AJDCONDus+R7QkixsW/zVCHJ7ahyd4
 aWPtyfOqdgmlOBRZEw5HMKugt+l5XoARuNo8BgcTx7RURJF8xxa9JOI+akUHHq2ksP1s
 kHUZKp99O1jYzAK/kL3ea4ScLf7zw9AxnuCcEWG8TWoNDfgkG7XsdhobKbsXzG7kNY6x
 tL/0kaCYUeKA/UIBErmY6ZXtfGSAuUUptr9m0GKHt8G9X+psyZy02/yYioH01ghIKo7d
 UmcQ==
X-Gm-Message-State: AOJu0YwwEi4ZY6xPBxjWedRsQeeZjD3jKPFl384EZCLPuYr0lDAcAmqN
 YbiX4nnwGzRHbpiL40C9B7iUbAUrS15dIIcOWT9AfpHc8QQcyDL120vai/iRk7/8Gaj/DmacMw6
 hg1xeEf4IhA4Ol9d/bLIeHO/jLvJQg/GFoNzZNXyfFunS5aywfd3z4s9VKg==
X-Received: by 2002:ac2:4104:0:b0:500:9d4a:8a02 with SMTP id
 b4-20020ac24104000000b005009d4a8a02mr869650lfi.62.1697511235623; 
 Mon, 16 Oct 2023 19:53:55 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IENwP83c5/JcMZ7anND6C6rpUXSsEAVfp2/WZRv8Bb2onTgn7vos7vIzvI659kgMrPrdVub0RiWlVaNJ2FtRZ8=
X-Received: by 2002:ac2:4104:0:b0:500:9d4a:8a02 with SMTP id
 b4-20020ac24104000000b005009d4a8a02mr869637lfi.62.1697511235236; Mon, 16 Oct
 2023 19:53:55 -0700 (PDT)
MIME-Version: 1.0
References: <20231016120033.26933-1-xuanzhuo@linux.alibaba.com>
In-Reply-To: <20231016120033.26933-1-xuanzhuo@linux.alibaba.com>
From: Jason Wang <jasowang@redhat.com>
Date: Tue, 17 Oct 2023 10:53:44 +0800
Message-ID: <CACGkMEs4u-4ch2UAK14hNfKeORjqMu4BX7=46OfaXpvxW+VT7w@mail.gmail.com>
Subject: Re: [PATCH net-next v1 00/19] virtio-net: support AF_XDP zero copy
To: Xuan Zhuo <xuanzhuo@linux.alibaba.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Cc: Jesper Dangaard Brouer <hawk@kernel.org>,
 Daniel Borkmann <daniel@iogearbox.net>, "Michael S. Tsirkin" <mst@redhat.com>,
 netdev@vger.kernel.org, John Fastabend <john.fastabend@gmail.com>,
 Alexei Starovoitov <ast@kernel.org>, virtualization@lists.linux-foundation.org,
 Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>,
 bpf@vger.kernel.org, Paolo Abeni <pabeni@redhat.com>,
 "David S. Miller" <davem@davemloft.net>
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

T24gTW9uLCBPY3QgMTYsIDIwMjMgYXQgODowMOKAr1BNIFh1YW4gWmh1byA8eHVhbnpodW9AbGlu
dXguYWxpYmFiYS5jb20+IHdyb3RlOgo+Cj4gIyMgQUZfWERQCj4KPiBYRFAgc29ja2V0KEFGX1hE
UCkgaXMgYW4gZXhjZWxsZW50IGJ5cGFzcyBrZXJuZWwgbmV0d29yayBmcmFtZXdvcmsuIFRoZSB6
ZXJvCj4gY29weSBmZWF0dXJlIG9mIHhzayAoWERQIHNvY2tldCkgbmVlZHMgdG8gYmUgc3VwcG9y
dGVkIGJ5IHRoZSBkcml2ZXIuIFRoZQo+IHBlcmZvcm1hbmNlIG9mIHplcm8gY29weSBpcyB2ZXJ5
IGdvb2QuIG1seDUgYW5kIGludGVsIGl4Z2JlIGFscmVhZHkgc3VwcG9ydAo+IHRoaXMgZmVhdHVy
ZSwgVGhpcyBwYXRjaCBzZXQgYWxsb3dzIHZpcnRpby1uZXQgdG8gc3VwcG9ydCB4c2sncyB6ZXJv
Y29weSB4bWl0Cj4gZmVhdHVyZS4KPgo+IEF0IHByZXNlbnQsIHdlIGhhdmUgY29tcGxldGVkIHNv
bWUgcHJlcGFyYXRpb246Cj4KPiAxLiB2cS1yZXNldCAodmlydGlvIHNwZWMgYW5kIGtlcm5lbCBj
b2RlKQo+IDIuIHZpcnRpby1jb3JlIHByZW1hcHBlZCBkbWEKPiAzLiB2aXJ0aW8tbmV0IHhkcCBy
ZWZhY3Rvcgo+Cj4gU28gaXQgaXMgdGltZSBmb3IgVmlydGlvLU5ldCB0byBjb21wbGV0ZSB0aGUg
c3VwcG9ydCBmb3IgdGhlIFhEUCBTb2NrZXQKPiBaZXJvY29weS4KPgo+IFZpcnRpby1uZXQgY2Fu
IG5vdCBpbmNyZWFzZSB0aGUgcXVldWUgbnVtIGF0IHdpbGwsIHNvIHhzayBzaGFyZXMgdGhlIHF1
ZXVlIHdpdGgKPiBrZXJuZWwuCj4KPiBPbiB0aGUgb3RoZXIgaGFuZCwgVmlydGlvLU5ldCBkb2Vz
IG5vdCBzdXBwb3J0IGdlbmVyYXRlIGludGVycnVwdCBmcm9tIGRyaXZlcgo+IG1hbnVhbGx5LCBz
byB3aGVuIHdlIHdha2V1cCB0eCB4bWl0LCB3ZSB1c2VkIHNvbWUgdGlwcy4gSWYgdGhlIENQVSBy
dW4gYnkgVFgKPiBOQVBJIGxhc3QgdGltZSBpcyBvdGhlciBDUFVzLCB1c2UgSVBJIHRvIHdha2Ug
dXAgTkFQSSBvbiB0aGUgcmVtb3RlIENQVS4gSWYgaXQKPiBpcyBhbHNvIHRoZSBsb2NhbCBDUFUs
IHRoZW4gd2Ugd2FrZSB1cCBuYXBpIGRpcmVjdGx5Lgo+Cj4gVGhpcyBwYXRjaCBzZXQgaW5jbHVk
ZXMgc29tZSByZWZhY3RvciB0byB0aGUgdmlydGlvLW5ldCB0byBsZXQgdGhhdCB0byBzdXBwb3J0
Cj4gQUZfWERQLgo+Cj4gIyMgcGVyZm9ybWFuY2UKPgo+IEVOVjogUWVtdSB3aXRoIHZob3N0LXVz
ZXIocG9sbGluZyBtb2RlKS4KPgo+IFNvY2twZXJmOiBodHRwczovL2dpdGh1Yi5jb20vTWVsbGFu
b3gvc29ja3BlcmYKPiBJIHVzZSB0aGlzIHRvb2wgdG8gc2VuZCB1ZHAgcGFja2V0IGJ5IGtlcm5l
bCBzeXNjYWxsLgo+Cj4geG1pdCBjb21tYW5kOiBzb2NrcGVyZiB0cCAtaSAxMC4wLjMuMSAtdCAx
MDAwCj4KPiBJIHdyaXRlIGEgdG9vbCB0aGF0IHNlbmRzIHVkcCBwYWNrZXRzIG9yIHJlY3ZzIHVk
cCBwYWNrZXRzIGJ5IEFGX1hEUC4KPgo+ICAgICAgICAgICAgICAgICAgIHwgR3Vlc3QgQVBQIENQ
VSB8R3Vlc3QgU29mdGlycSBDUFUgfCBVRFAgUFBTCj4gLS0tLS0tLS0tLS0tLS0tLS0tfC0tLS0t
LS0tLS0tLS0tLXwtLS0tLS0tLS0tLS0tLS0tLS18LS0tLS0tLS0tLS0tCj4geG1pdCBieSBzeXNj
YWxsICAgfCAgIDEwMCUgICAgICAgIHwgICAgICAgICAgICAgICAgICB8ICAgNjc2LDkxNQo+IHht
aXQgYnkgeHNrICAgICAgIHwgICA1OS4xJSAgICAgICB8ICAgMTAwJSAgICAgICAgICAgfCA1LDQ0
NywxNjgKPiByZWN2IGJ5IHN5c2NhbGwgICB8ICAgNjAlICAgICAgICAgfCAgIDEwMCUgICAgICAg
ICAgIHwgICA5MzIsMjg4Cj4gcmVjdiBieSB4c2sgICAgICAgfCAgIDM1LjclICAgICAgIHwgICAx
MDAlICAgICAgICAgICB8IDMsMzQzLDE2OAoKQW55IGNoYW5jZSB3ZSBjYW4gZ2V0IGEgdGVzdHBt
ZCByZXN1bHQgKHdoaWNoIEkgZ3Vlc3Mgc2hvdWxkIGJlIGJldHRlcgp0aGFuIFBQUyBhYm92ZSk/
CgpUaGFua3MKCj4KPiAjIyBtYWludGFpbgo+Cj4gSSBhbSBjdXJyZW50bHkgYSByZXZpZXdlciBm
b3IgdmlydGlvLW5ldC4gSSBjb21taXQgdG8gbWFpbnRhaW4gQUZfWERQIHN1cHBvcnQgaW4KPiB2
aXJ0aW8tbmV0Lgo+Cj4gUGxlYXNlIHJldmlldy4KPgo+IFRoYW5rcy4KPgo+IHYxOgo+ICAgICAx
LiByZW1vdmUgdHdvIHZpcnRpbyBjb21taXRzLiBQdXNoIHRoaXMgcGF0Y2hzZXQgdG8gbmV0LW5l
eHQKPiAgICAgMi4gc3F1YXNoICJ2aXJ0aW9fbmV0OiB2aXJ0bmV0X3BvbGxfdHggc3VwcG9ydCBy
ZXNjaGVkdWxlZCIgdG8geHNrOiBzdXBwb3J0IHR4Cj4gICAgIDMuIGZpeCBzb21lIHdhcm5pbmdz
Cj4KPiBYdWFuIFpodW8gKDE5KToKPiAgIHZpcnRpb19uZXQ6IHJlbmFtZSBmcmVlX29sZF94bWl0
X3NrYnMgdG8gZnJlZV9vbGRfeG1pdAo+ICAgdmlydGlvX25ldDogdW5pZnkgdGhlIGNvZGUgZm9y
IHJlY3ljbGluZyB0aGUgeG1pdCBwdHIKPiAgIHZpcnRpb19uZXQ6IGluZGVwZW5kZW50IGRpcmVj
dG9yeQo+ICAgdmlydGlvX25ldDogbW92ZSB0byB2aXJ0aW9fbmV0LmgKPiAgIHZpcnRpb19uZXQ6
IGFkZCBwcmVmaXggdmlydG5ldCB0byBhbGwgc3RydWN0L2FwaSBpbnNpZGUgdmlydGlvX25ldC5o
Cj4gICB2aXJ0aW9fbmV0OiBzZXBhcmF0ZSB2aXJ0bmV0X3J4X3Jlc2l6ZSgpCj4gICB2aXJ0aW9f
bmV0OiBzZXBhcmF0ZSB2aXJ0bmV0X3R4X3Jlc2l6ZSgpCj4gICB2aXJ0aW9fbmV0OiBzcSBzdXBw
b3J0IHByZW1hcHBlZCBtb2RlCj4gICB2aXJ0aW9fbmV0OiB4c2s6IGJpbmQvdW5iaW5kIHhzawo+
ICAgdmlydGlvX25ldDogeHNrOiBwcmV2ZW50IGRpc2FibGUgdHggbmFwaQo+ICAgdmlydGlvX25l
dDogeHNrOiB0eDogc3VwcG9ydCB0eAo+ICAgdmlydGlvX25ldDogeHNrOiB0eDogc3VwcG9ydCB3
YWtldXAKPiAgIHZpcnRpb19uZXQ6IHhzazogdHg6IHZpcnRuZXRfZnJlZV9vbGRfeG1pdCgpIGRp
c3Rpbmd1aXNoZXMgeHNrIGJ1ZmZlcgo+ICAgdmlydGlvX25ldDogeHNrOiB0eDogdmlydG5ldF9z
cV9mcmVlX3VudXNlZF9idWYoKSBjaGVjayB4c2sgYnVmZmVyCj4gICB2aXJ0aW9fbmV0OiB4c2s6
IHJ4OiBpbnRyb2R1Y2UgYWRkX3JlY3ZidWZfeHNrKCkKPiAgIHZpcnRpb19uZXQ6IHhzazogcng6
IGludHJvZHVjZSByZWNlaXZlX3hzaygpIHRvIHJlY3YgeHNrIGJ1ZmZlcgo+ICAgdmlydGlvX25l
dDogeHNrOiByeDogdmlydG5ldF9ycV9mcmVlX3VudXNlZF9idWYoKSBjaGVjayB4c2sgYnVmZmVy
Cj4gICB2aXJ0aW9fbmV0OiB1cGRhdGUgdHggdGltZW91dCByZWNvcmQKPiAgIHZpcnRpb19uZXQ6
IHhkcF9mZWF0dXJlcyBhZGQgTkVUREVWX1hEUF9BQ1RfWFNLX1pFUk9DT1BZCj4KPiAgTUFJTlRB
SU5FUlMgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICB8ICAgMiArLQo+ICBkcml2ZXJz
L25ldC9LY29uZmlnICAgICAgICAgICAgICAgICAgICAgICAgIHwgICA4ICstCj4gIGRyaXZlcnMv
bmV0L01ha2VmaWxlICAgICAgICAgICAgICAgICAgICAgICAgfCAgIDIgKy0KPiAgZHJpdmVycy9u
ZXQvdmlydGlvL0tjb25maWcgICAgICAgICAgICAgICAgICB8ICAxMyArCj4gIGRyaXZlcnMvbmV0
L3ZpcnRpby9NYWtlZmlsZSAgICAgICAgICAgICAgICAgfCAgIDggKwo+ICBkcml2ZXJzL25ldC97
dmlydGlvX25ldC5jID0+IHZpcnRpby9tYWluLmN9IHwgNjUyICsrKysrKysrKy0tLS0tLS0tLS0t
Cj4gIGRyaXZlcnMvbmV0L3ZpcnRpby92aXJ0aW9fbmV0LmggICAgICAgICAgICAgfCAzNTkgKysr
KysrKysrKysKPiAgZHJpdmVycy9uZXQvdmlydGlvL3hzay5jICAgICAgICAgICAgICAgICAgICB8
IDU0NSArKysrKysrKysrKysrKysrCj4gIGRyaXZlcnMvbmV0L3ZpcnRpby94c2suaCAgICAgICAg
ICAgICAgICAgICAgfCAgMzIgKwo+ICA5IGZpbGVzIGNoYW5nZWQsIDEyNDcgaW5zZXJ0aW9ucygr
KSwgMzc0IGRlbGV0aW9ucygtKQo+ICBjcmVhdGUgbW9kZSAxMDA2NDQgZHJpdmVycy9uZXQvdmly
dGlvL0tjb25maWcKPiAgY3JlYXRlIG1vZGUgMTAwNjQ0IGRyaXZlcnMvbmV0L3ZpcnRpby9NYWtl
ZmlsZQo+ICByZW5hbWUgZHJpdmVycy9uZXQve3ZpcnRpb19uZXQuYyA9PiB2aXJ0aW8vbWFpbi5j
fSAoOTElKQo+ICBjcmVhdGUgbW9kZSAxMDA2NDQgZHJpdmVycy9uZXQvdmlydGlvL3ZpcnRpb19u
ZXQuaAo+ICBjcmVhdGUgbW9kZSAxMDA2NDQgZHJpdmVycy9uZXQvdmlydGlvL3hzay5jCj4gIGNy
ZWF0ZSBtb2RlIDEwMDY0NCBkcml2ZXJzL25ldC92aXJ0aW8veHNrLmgKPgo+IC0tCj4gMi4zMi4w
LjMuZzAxMTk1Y2Y5Zgo+CgpfX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fXwpWaXJ0dWFsaXphdGlvbiBtYWlsaW5nIGxpc3QKVmlydHVhbGl6YXRpb25AbGlzdHMu
bGludXgtZm91bmRhdGlvbi5vcmcKaHR0cHM6Ly9saXN0cy5saW51eGZvdW5kYXRpb24ub3JnL21h
aWxtYW4vbGlzdGluZm8vdmlydHVhbGl6YXRpb24=
