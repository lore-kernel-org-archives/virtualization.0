Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D693CE95A8E
	for <virtualization@archiver.kernel.org>; Sun,  8 Oct 2023 04:53:40 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 558306104B;
	Sun,  8 Oct 2023 04:53:40 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 558306104B
Authentication-Results: smtp3.osuosl.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=DEELYKyb
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
	by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id 51-Fcawp_S4Z; Sun,  8 Oct 2023 04:53:38 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp3.osuosl.org (Postfix) with ESMTPS id 32EEC60A82;
	Sun,  8 Oct 2023 04:53:38 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 32EEC60A82
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 0A490C0071;
	Sun,  8 Oct 2023 04:53:38 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [IPv6:2605:bc80:3010::137])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 2F887C0032
 for <virtualization@lists.linux-foundation.org>;
 Sun,  8 Oct 2023 04:53:37 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id 096DE41862
 for <virtualization@lists.linux-foundation.org>;
 Sun,  8 Oct 2023 04:53:37 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org 096DE41862
Authentication-Results: smtp4.osuosl.org;
 dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com
 header.a=rsa-sha256 header.s=mimecast20190719 header.b=DEELYKyb
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id Ve9ajamNfw9r
 for <virtualization@lists.linux-foundation.org>;
 Sun,  8 Oct 2023 04:53:36 +0000 (UTC)
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.133.124])
 by smtp4.osuosl.org (Postfix) with ESMTPS id C0E1141857
 for <virtualization@lists.linux-foundation.org>;
 Sun,  8 Oct 2023 04:53:35 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org C0E1141857
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1696740814;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=S1HJ6vv1pBVf5AB5L3VKI3WzniTIFfMuA6xvDuFUoaw=;
 b=DEELYKybU53AReOif20uz1K+ysScYr1wjNcziexsadG2INxvmB6wJlaLbCEbUhRAA+j/9T
 1NK++PBcsuSJ2RDmpXDSYjd1TCdwJ1FXjubLp66yaYnB9tRbfU/tXgpZzJygbi/amOV/oc
 8NkjLSc7CyYb0RQEViH0vc5+tTHNj6E=
Received: from mail-lf1-f69.google.com (mail-lf1-f69.google.com
 [209.85.167.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-686-YTlsXkNSPcy_aUv6xN8_zw-1; Sun, 08 Oct 2023 00:53:32 -0400
X-MC-Unique: YTlsXkNSPcy_aUv6xN8_zw-1
Received: by mail-lf1-f69.google.com with SMTP id
 2adb3069b0e04-50338ca1663so3364523e87.0
 for <virtualization@lists.linux-foundation.org>;
 Sat, 07 Oct 2023 21:53:31 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1696740810; x=1697345610;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=S1HJ6vv1pBVf5AB5L3VKI3WzniTIFfMuA6xvDuFUoaw=;
 b=Q2KQJUyX8t2POy3u8BtkVBDiAcp3YFPD4JZgMnqhm3pvFL5/gZRxavh4mgEbp2jnBw
 4YZ2GrTRDsuAtxkG0ErXLdNcDQ0bydXZ6lr5wYfwcBtIwomdSUdxzIp0wv/2Khl7XWlx
 FRS4L7xjuQFD8FbuzDPU1QVVkZNK6+sxrWwttQc5oaYKpO/eC5uk3NMcbFn6/cAfXCqZ
 FGb6OWrInodDELy3BrllU+N4NPH/ElW4G0qUIa9Bn+UC1hgNP0ukceVsrtDuEw5O/6fw
 R8AMU/QutFzxRdqLLX0ilhh66vDoc5eG89mAJay/Ufm8vSmjgpGCBAt7orZ1gfb8JrKA
 la7A==
X-Gm-Message-State: AOJu0YxupZD8Ajx0NLpd8zKF4e52Z1RoY6aq8xK7eERlnNW98i7PEEZG
 IkLIGluQCin8Q69hvsV19Od6LWmC4cPIZ+RHHCyTIGnbAlbnX7ZfjBYAv0a7SgJ0AzQWZLHNzam
 K3Yl/LGc/SIbX410I3S9WK/4NBbv9kjVjTe8+fr/leP39XrqUkrIOp407JQ==
X-Received: by 2002:a05:6512:2017:b0:503:19bc:efb with SMTP id
 a23-20020a056512201700b0050319bc0efbmr9800260lfb.29.1696740810521; 
 Sat, 07 Oct 2023 21:53:30 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHhCGfnVmse6ZZuQQWAmYfgT7YAlMeenDBKY01p6eCrBmjMIn7mjAZeYKlmo1VJDR/G2Nc1dmlcz7Aaz3comfo=
X-Received: by 2002:a05:6512:2017:b0:503:19bc:efb with SMTP id
 a23-20020a056512201700b0050319bc0efbmr9800243lfb.29.1696740810133; Sat, 07
 Oct 2023 21:53:30 -0700 (PDT)
MIME-Version: 1.0
References: <20230927055246.121544-1-xuanzhuo@linux.alibaba.com>
In-Reply-To: <20230927055246.121544-1-xuanzhuo@linux.alibaba.com>
From: Jason Wang <jasowang@redhat.com>
Date: Sun, 8 Oct 2023 12:53:19 +0800
Message-ID: <CACGkMEvubQojB-SxFvqV1D1LPiL2PL+oMP1G29t6702JYdVdXQ@mail.gmail.com>
Subject: Re: [PATCH vhost] virtio_net: fix the missing of the dma cpu sync
To: Xuan Zhuo <xuanzhuo@linux.alibaba.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Cc: "Michael S. Tsirkin" <mst@redhat.com>, netdev@vger.kernel.org,
 virtualization@lists.linux-foundation.org, Eric Dumazet <edumazet@google.com>,
 Michael Roth <michael.roth@amd.com>, Jakub Kicinski <kuba@kernel.org>,
 Paolo Abeni <pabeni@redhat.com>, "David S. Miller" <davem@davemloft.net>
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

T24gV2VkLCBTZXAgMjcsIDIwMjMgYXQgMTo1M+KAr1BNIFh1YW4gWmh1byA8eHVhbnpodW9AbGlu
dXguYWxpYmFiYS5jb20+IHdyb3RlOgo+Cj4gQ29tbWl0IDI5NTUyNWUyOWE1YiAoInZpcnRpb19u
ZXQ6IG1lcmdlIGRtYSBvcGVyYXRpb25zIHdoZW4gZmlsbGluZwo+IG1lcmdlYWJsZSBidWZmZXJz
IikgdW5tYXBzIHRoZSBidWZmZXIgd2l0aCBETUFfQVRUUl9TS0lQX0NQVV9TWU5DIHdoZW4KPiB0
aGUgZG1hLT5yZWYgaXMgemVyby4gV2UgZG8gdGhhdCB3aXRoIERNQV9BVFRSX1NLSVBfQ1BVX1NZ
TkMsIGJlY2F1c2Ugd2UKPiBkbyBub3Qgd2FudCB0byBkbyB0aGUgc3luYyBmb3IgdGhlIGVudGly
ZSBwYWdlX2ZyYWcuIEJ1dCB0aGF0IG1pc3NlcyB0aGUKPiBzeW5jIGZvciB0aGUgY3VycmVudCBh
cmVhLgo+Cj4gVGhpcyBwYXRjaCBkb2VzIGNwdSBzeW5jIHJlZ2FyZGxlc3Mgb2Ygd2hldGhlciB0
aGUgcmVmIGlzIHplcm8gb3Igbm90Lgo+Cj4gRml4ZXM6IDI5NTUyNWUyOWE1YiAoInZpcnRpb19u
ZXQ6IG1lcmdlIGRtYSBvcGVyYXRpb25zIHdoZW4gZmlsbGluZyBtZXJnZWFibGUgYnVmZmVycyIp
Cj4gUmVwb3J0ZWQtYnk6IE1pY2hhZWwgUm90aCA8bWljaGFlbC5yb3RoQGFtZC5jb20+Cj4gQ2xv
c2VzOiBodHRwOi8vbG9yZS5rZXJuZWwub3JnL2FsbC8yMDIzMDkyNjEzMDQ1MS5heGdvZGFhNnR2
d3FzM3V0QGFtZC5jb20KPiBTaWduZWQtb2ZmLWJ5OiBYdWFuIFpodW8gPHh1YW56aHVvQGxpbnV4
LmFsaWJhYmEuY29tPgoKQWNrZWQtYnk6IEphc29uIFdhbmcgPGphc293YW5nQHJlZGhhdC5jb20+
CgpUaGFua3MKCj4gLS0tCj4gIGRyaXZlcnMvbmV0L3ZpcnRpb19uZXQuYyB8IDE0ICsrKysrKyst
LS0tLS0tCj4gIDEgZmlsZSBjaGFuZ2VkLCA3IGluc2VydGlvbnMoKyksIDcgZGVsZXRpb25zKC0p
Cj4KPiBkaWZmIC0tZ2l0IGEvZHJpdmVycy9uZXQvdmlydGlvX25ldC5jIGIvZHJpdmVycy9uZXQv
dmlydGlvX25ldC5jCj4gaW5kZXggOThkYzliNDlkNTZiLi45ZWNlMjdkYzUxNDQgMTAwNjQ0Cj4g
LS0tIGEvZHJpdmVycy9uZXQvdmlydGlvX25ldC5jCj4gKysrIGIvZHJpdmVycy9uZXQvdmlydGlv
X25ldC5jCj4gQEAgLTU4OSwxNiArNTg5LDE2IEBAIHN0YXRpYyB2b2lkIHZpcnRuZXRfcnFfdW5t
YXAoc3RydWN0IHJlY2VpdmVfcXVldWUgKnJxLCB2b2lkICpidWYsIHUzMiBsZW4pCj4KPiAgICAg
ICAgIC0tZG1hLT5yZWY7Cj4KPiAtICAgICAgIGlmIChkbWEtPnJlZikgewo+IC0gICAgICAgICAg
ICAgICBpZiAoZG1hLT5uZWVkX3N5bmMgJiYgbGVuKSB7Cj4gLSAgICAgICAgICAgICAgICAgICAg
ICAgb2Zmc2V0ID0gYnVmIC0gKGhlYWQgKyBzaXplb2YoKmRtYSkpOwo+ICsgICAgICAgaWYgKGRt
YS0+bmVlZF9zeW5jICYmIGxlbikgewo+ICsgICAgICAgICAgICAgICBvZmZzZXQgPSBidWYgLSAo
aGVhZCArIHNpemVvZigqZG1hKSk7Cj4KPiAtICAgICAgICAgICAgICAgICAgICAgICB2aXJ0cXVl
dWVfZG1hX3N5bmNfc2luZ2xlX3JhbmdlX2Zvcl9jcHUocnEtPnZxLCBkbWEtPmFkZHIsIG9mZnNl
dCwKPiAtICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgbGVuLCBETUFfRlJPTV9ERVZJQ0UpOwo+IC0gICAgICAgICAgICAgICB9Cj4g
KyAgICAgICAgICAgICAgIHZpcnRxdWV1ZV9kbWFfc3luY19zaW5nbGVfcmFuZ2VfZm9yX2NwdShy
cS0+dnEsIGRtYS0+YWRkciwKPiArICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgIG9mZnNldCwgbGVuLAo+ICsgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgRE1BX0ZST01fREVWSUNFKTsKPiArICAg
ICAgIH0KPgo+ICsgICAgICAgaWYgKGRtYS0+cmVmKQo+ICAgICAgICAgICAgICAgICByZXR1cm47
Cj4gLSAgICAgICB9Cj4KPiAgICAgICAgIHZpcnRxdWV1ZV9kbWFfdW5tYXBfc2luZ2xlX2F0dHJz
KHJxLT52cSwgZG1hLT5hZGRyLCBkbWEtPmxlbiwKPiAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgIERNQV9GUk9NX0RFVklDRSwgRE1BX0FUVFJfU0tJUF9DUFVfU1lOQyk7
Cj4gLS0KPiAyLjMyLjAuMy5nMDExOTVjZjlmCj4KPgoKX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX18KVmlydHVhbGl6YXRpb24gbWFpbGluZyBsaXN0ClZpcnR1
YWxpemF0aW9uQGxpc3RzLmxpbnV4LWZvdW5kYXRpb24ub3JnCmh0dHBzOi8vbGlzdHMubGludXhm
b3VuZGF0aW9uLm9yZy9tYWlsbWFuL2xpc3RpbmZvL3ZpcnR1YWxpemF0aW9u
