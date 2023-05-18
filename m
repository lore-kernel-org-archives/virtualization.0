Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 53977C7EE24
	for <virtualization@archiver.kernel.org>; Thu, 18 May 2023 06:52:13 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp2.osuosl.org (Postfix) with ESMTP id DFD4242A3C;
	Thu, 18 May 2023 06:52:12 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org DFD4242A3C
Authentication-Results: smtp2.osuosl.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=NhHzciYX
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
	by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id lAUW4RlL6Rio; Thu, 18 May 2023 06:52:12 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp2.osuosl.org (Postfix) with ESMTPS id 5A2E440436;
	Thu, 18 May 2023 06:52:11 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org 5A2E440436
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 2BD29C0036;
	Thu, 18 May 2023 06:52:11 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [IPv6:2605:bc80:3010::136])
 by lists.linuxfoundation.org (Postfix) with ESMTP id BEC64C002A
 for <virtualization@lists.linux-foundation.org>;
 Thu, 18 May 2023 06:52:09 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id 987F960E79
 for <virtualization@lists.linux-foundation.org>;
 Thu, 18 May 2023 06:52:09 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 987F960E79
Authentication-Results: smtp3.osuosl.org;
 dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com
 header.a=rsa-sha256 header.s=mimecast20190719 header.b=NhHzciYX
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id 9-KstTcueXid
 for <virtualization@lists.linux-foundation.org>;
 Thu, 18 May 2023 06:52:09 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org E1EDC613FE
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.133.124])
 by smtp3.osuosl.org (Postfix) with ESMTPS id E1EDC613FE
 for <virtualization@lists.linux-foundation.org>;
 Thu, 18 May 2023 06:52:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1684392727;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=vdf/PDvvMehE9xmjWReR6Sm7sVjjaKm8i6AkbQarD6A=;
 b=NhHzciYXMhGwXt2GPqQlM6OuB98Hbj/oab6Pj6yyFjjzLGQ7xHk0f/lrxcsOnJn5ytxVte
 gPruUpau1ZQBNBVpcIx4KqxmQ9RMMehRt2CfzgHifMP3gpHuQml6JUduRNwQjMmxFZ9Q65
 AdXbfVN0eugBh3N09O32y0cbh7TiGh4=
Received: from mail-lf1-f71.google.com (mail-lf1-f71.google.com
 [209.85.167.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-78-kWjI7wG4N2GXyNpHHQbBQA-1; Thu, 18 May 2023 02:52:05 -0400
X-MC-Unique: kWjI7wG4N2GXyNpHHQbBQA-1
Received: by mail-lf1-f71.google.com with SMTP id
 2adb3069b0e04-4f19bffbc23so1167300e87.1
 for <virtualization@lists.linux-foundation.org>;
 Wed, 17 May 2023 23:52:05 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1684392724; x=1686984724;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=vdf/PDvvMehE9xmjWReR6Sm7sVjjaKm8i6AkbQarD6A=;
 b=leaFTvZioNJVXrW/DMjPRue9c3CMVyzgSGHrEcgWfA3VDa+7N98wZdNRESoKMhwP1B
 TF6jxNqsUnBmerT/7Ycxv1ETQzRsQ+wyN65SFrjb3eVTOf86e+wsBvd+L2ac24DwZ6xM
 uwLD4UTSdhxFwzqBReBeVqlJyNhTH27hC7bB15QKt2+a+N2qv5kEu4YnfyM4glwNvR2a
 RBqrJ4ka1pUzZNjLpU+Bhh19c170jVJYTPoLA5l4OcIZ9O1Nc5HKuJNrwBWn1CyM0F/d
 rMS/grwkzJwqas+ifoQWwOhIQ3exnDXh6FFjQ1v93cECfUnzI9ai9dSZspK7EU5EgQgI
 OX1w==
X-Gm-Message-State: AC+VfDzr4sleRViIuIxI7YuANomaE0rQNvgyHNjUdkmPQycxeOhaCt7W
 0sO8VUc8KElTRWMmWX66p3CRQjmQCNWVfUALK1MjNdBD/rWi1BY0QASv2J0u4ZdqjlblygqTCgE
 +ycCnZBWxU0+owUqKwOlgGzJKUMe2/8vOHmDtYbbBsjSrkvz/6JDq8FbZ1Q==
X-Received: by 2002:ac2:5e8e:0:b0:4ef:ec33:9155 with SMTP id
 b14-20020ac25e8e000000b004efec339155mr993607lfq.28.1684392724196; 
 Wed, 17 May 2023 23:52:04 -0700 (PDT)
X-Google-Smtp-Source: ACHHUZ6rc2xa4GvBpsnblzB6wce0KFodAZrnm+6EnAtnHJ2jtxMM2S9OzZm68PauYH7XLr0KvvUanDTmsbmuy3RVbRM=
X-Received: by 2002:ac2:5e8e:0:b0:4ef:ec33:9155 with SMTP id
 b14-20020ac25e8e000000b004efec339155mr993598lfq.28.1684392723919; Wed, 17 May
 2023 23:52:03 -0700 (PDT)
MIME-Version: 1.0
References: <20230517022249.20790-1-xuanzhuo@linux.alibaba.com>
 <20230517022249.20790-5-xuanzhuo@linux.alibaba.com>
In-Reply-To: <20230517022249.20790-5-xuanzhuo@linux.alibaba.com>
From: Jason Wang <jasowang@redhat.com>
Date: Thu, 18 May 2023 14:51:52 +0800
Message-ID: <CACGkMEuj-bRhh2fH7B=zuCAagkhPT0v1uXGmWkjNDy8-NFpkvg@mail.gmail.com>
Subject: Re: [PATCH vhost v9 04/12] virtio_ring: virtqueue_add() support
 premapped
To: Xuan Zhuo <xuanzhuo@linux.alibaba.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Cc: Christoph Hellwig <hch@infradead.org>,
 "Michael S. Tsirkin" <mst@redhat.com>,
 virtualization@lists.linux-foundation.org
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

T24gV2VkLCBNYXkgMTcsIDIwMjMgYXQgMTA6MjPigK9BTSBYdWFuIFpodW8gPHh1YW56aHVvQGxp
bnV4LmFsaWJhYmEuY29tPiB3cm90ZToKPgo+IHZpcnR1cXVlX2FkZCgpIGFkZHMgcGFyYW1ldGVy
IHByZW1hcHBlZC4KCkkgd29uZGVyIGlmIHRoaXMgcGF0Y2ggaXMgb3ZlciBzaW1wbGlmaWVkLiBN
YXliZSBpdCBjYW4gYmUgc3F1YXNoZWQKd2l0aCB0aGUgcGF0Y2ggdGhhdCBpbXBsZW1lbnRzIHRo
ZSBwcmVtYXBwZWQgbG9naWMuCgpUaGFua3MKCgo+Cj4gU2lnbmVkLW9mZi1ieTogWHVhbiBaaHVv
IDx4dWFuemh1b0BsaW51eC5hbGliYWJhLmNvbT4KPiAtLS0KPiAgZHJpdmVycy92aXJ0aW8vdmly
dGlvX3JpbmcuYyB8IDkgKysrKystLS0tCj4gIDEgZmlsZSBjaGFuZ2VkLCA1IGluc2VydGlvbnMo
KyksIDQgZGVsZXRpb25zKC0pCj4KPiBkaWZmIC0tZ2l0IGEvZHJpdmVycy92aXJ0aW8vdmlydGlv
X3JpbmcuYyBiL2RyaXZlcnMvdmlydGlvL3ZpcnRpb19yaW5nLmMKPiBpbmRleCAxZmZhYjFlYjQw
YzAuLmUyZmM1MGMwNWJlYyAxMDA2NDQKPiAtLS0gYS9kcml2ZXJzL3ZpcnRpby92aXJ0aW9fcmlu
Zy5jCj4gKysrIGIvZHJpdmVycy92aXJ0aW8vdmlydGlvX3JpbmcuYwo+IEBAIC0yMTM1LDYgKzIx
MzUsNyBAQCBzdGF0aWMgaW5saW5lIGludCB2aXJ0cXVldWVfYWRkKHN0cnVjdCB2aXJ0cXVldWUg
Kl92cSwKPiAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgIHVuc2lnbmVkIGludCBpbl9z
Z3MsCj4gICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICB2b2lkICpkYXRhLAo+ICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgdm9pZCAqY3R4LAo+ICsgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgYm9vbCBwcmVtYXBwZWQsCj4gICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICBnZnBfdCBnZnApCj4gIHsKPiAgICAgICAgIHN0cnVjdCB2cmluZ192aXJ0cXVldWUg
KnZxID0gdG9fdnZxKF92cSk7Cj4gQEAgLTIxNzYsNyArMjE3Nyw3IEBAIGludCB2aXJ0cXVldWVf
YWRkX3NncyhzdHJ1Y3QgdmlydHF1ZXVlICpfdnEsCj4gICAgICAgICAgICAgICAgICAgICAgICAg
dG90YWxfc2crKzsKPiAgICAgICAgIH0KPiAgICAgICAgIHJldHVybiB2aXJ0cXVldWVfYWRkKF92
cSwgc2dzLCB0b3RhbF9zZywgb3V0X3NncywgaW5fc2dzLAo+IC0gICAgICAgICAgICAgICAgICAg
ICAgICAgICAgZGF0YSwgTlVMTCwgZ2ZwKTsKPiArICAgICAgICAgICAgICAgICAgICAgICAgICAg
IGRhdGEsIE5VTEwsIGZhbHNlLCBnZnApOwo+ICB9Cj4gIEVYUE9SVF9TWU1CT0xfR1BMKHZpcnRx
dWV1ZV9hZGRfc2dzKTsKPgo+IEBAIC0yMTk4LDcgKzIxOTksNyBAQCBpbnQgdmlydHF1ZXVlX2Fk
ZF9vdXRidWYoc3RydWN0IHZpcnRxdWV1ZSAqdnEsCj4gICAgICAgICAgICAgICAgICAgICAgICAg
IHZvaWQgKmRhdGEsCj4gICAgICAgICAgICAgICAgICAgICAgICAgIGdmcF90IGdmcCkKPiAgewo+
IC0gICAgICAgcmV0dXJuIHZpcnRxdWV1ZV9hZGQodnEsICZzZywgbnVtLCAxLCAwLCBkYXRhLCBO
VUxMLCBnZnApOwo+ICsgICAgICAgcmV0dXJuIHZpcnRxdWV1ZV9hZGQodnEsICZzZywgbnVtLCAx
LCAwLCBkYXRhLCBOVUxMLCBmYWxzZSwgZ2ZwKTsKPiAgfQo+ICBFWFBPUlRfU1lNQk9MX0dQTCh2
aXJ0cXVldWVfYWRkX291dGJ1Zik7Cj4KPiBAQCAtMjIyMCw3ICsyMjIxLDcgQEAgaW50IHZpcnRx
dWV1ZV9hZGRfaW5idWYoc3RydWN0IHZpcnRxdWV1ZSAqdnEsCj4gICAgICAgICAgICAgICAgICAg
ICAgICAgdm9pZCAqZGF0YSwKPiAgICAgICAgICAgICAgICAgICAgICAgICBnZnBfdCBnZnApCj4g
IHsKPiAtICAgICAgIHJldHVybiB2aXJ0cXVldWVfYWRkKHZxLCAmc2csIG51bSwgMCwgMSwgZGF0
YSwgTlVMTCwgZ2ZwKTsKPiArICAgICAgIHJldHVybiB2aXJ0cXVldWVfYWRkKHZxLCAmc2csIG51
bSwgMCwgMSwgZGF0YSwgTlVMTCwgZmFsc2UsIGdmcCk7Cj4gIH0KPiAgRVhQT1JUX1NZTUJPTF9H
UEwodmlydHF1ZXVlX2FkZF9pbmJ1Zik7Cj4KPiBAQCAtMjI0NCw3ICsyMjQ1LDcgQEAgaW50IHZp
cnRxdWV1ZV9hZGRfaW5idWZfY3R4KHN0cnVjdCB2aXJ0cXVldWUgKnZxLAo+ICAgICAgICAgICAg
ICAgICAgICAgICAgIHZvaWQgKmN0eCwKPiAgICAgICAgICAgICAgICAgICAgICAgICBnZnBfdCBn
ZnApCj4gIHsKPiAtICAgICAgIHJldHVybiB2aXJ0cXVldWVfYWRkKHZxLCAmc2csIG51bSwgMCwg
MSwgZGF0YSwgY3R4LCBnZnApOwo+ICsgICAgICAgcmV0dXJuIHZpcnRxdWV1ZV9hZGQodnEsICZz
ZywgbnVtLCAwLCAxLCBkYXRhLCBjdHgsIGZhbHNlLCBnZnApOwo+ICB9Cj4gIEVYUE9SVF9TWU1C
T0xfR1BMKHZpcnRxdWV1ZV9hZGRfaW5idWZfY3R4KTsKPgo+IC0tCj4gMi4zMi4wLjMuZzAxMTk1
Y2Y5Zgo+CgpfX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fXwpW
aXJ0dWFsaXphdGlvbiBtYWlsaW5nIGxpc3QKVmlydHVhbGl6YXRpb25AbGlzdHMubGludXgtZm91
bmRhdGlvbi5vcmcKaHR0cHM6Ly9saXN0cy5saW51eGZvdW5kYXRpb24ub3JnL21haWxtYW4vbGlz
dGluZm8vdmlydHVhbGl6YXRpb24=
