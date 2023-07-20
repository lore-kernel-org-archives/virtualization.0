Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6B4C3EB64DD
	for <virtualization@archiver.kernel.org>; Thu, 20 Jul 2023 17:14:55 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp2.osuosl.org (Postfix) with ESMTP id DA67D416EB;
	Thu, 20 Jul 2023 17:14:54 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org DA67D416EB
Authentication-Results: smtp2.osuosl.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=eclkqvDz
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
	by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id JxOT5ixEV3NB; Thu, 20 Jul 2023 17:14:54 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp2.osuosl.org (Postfix) with ESMTPS id 6DDB6416C4;
	Thu, 20 Jul 2023 17:14:53 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org 6DDB6416C4
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 44A9EC0072;
	Thu, 20 Jul 2023 17:14:53 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [IPv6:2605:bc80:3010::137])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 16CFEC0032
 for <virtualization@lists.linux-foundation.org>;
 Thu, 20 Jul 2023 17:14:52 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id E00D441B68
 for <virtualization@lists.linux-foundation.org>;
 Thu, 20 Jul 2023 17:14:51 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org E00D441B68
Authentication-Results: smtp4.osuosl.org;
 dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com
 header.a=rsa-sha256 header.s=mimecast20190719 header.b=eclkqvDz
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id xsSW4xHEsvEL
 for <virtualization@lists.linux-foundation.org>;
 Thu, 20 Jul 2023 17:14:50 +0000 (UTC)
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.129.124])
 by smtp4.osuosl.org (Postfix) with ESMTPS id BBB2341DDD
 for <virtualization@lists.linux-foundation.org>;
 Thu, 20 Jul 2023 17:14:50 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org BBB2341DDD
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1689873289;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=6dS9MqSSp9voaLhT32kd9eEdqfQVkZ98uR/QeW4LDZE=;
 b=eclkqvDz9q1qaMjKkGyQvso4GQILYgQD8P5j+y3kPAFGC5t1RXENR/0mivS2AlUiEUgQ4V
 ML5tFNqJfCCxMBcMowl3Z0vdQz9cDw39Ypujkw4+5Fgx8PdzeRqvwali4fWa0lKY72l8Dy
 0RpZOF34ObRvhXkwZashvIq63u0WUUk=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-439-N-_tOsdcO_eB8VJYo-38fg-1; Thu, 20 Jul 2023 13:14:47 -0400
X-MC-Unique: N-_tOsdcO_eB8VJYo-38fg-1
Received: by mail-wm1-f72.google.com with SMTP id
 5b1f17b1804b1-3fd0fa4d08cso5738045e9.1
 for <virtualization@lists.linux-foundation.org>;
 Thu, 20 Jul 2023 10:14:47 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1689873286; x=1690478086;
 h=in-reply-to:content-transfer-encoding:content-disposition
 :mime-version:references:message-id:subject:cc:to:from:date
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=6dS9MqSSp9voaLhT32kd9eEdqfQVkZ98uR/QeW4LDZE=;
 b=Gg5lDeQcHoaF+sSqijK8vzMbZhm6WIj3V7OduXWr1wx/zM8lYgB7/8pZ2KGvrluAoz
 XZH4974g9PV1D4gbnaSVhSScHpIHkiCz5G/035FzoPBNo2hAWB/p0dmn3AHFKIbe9Ur7
 BaSE6NDAq27bSSfPjttzyJ45tS9w+3Amo3VSICAYf2U02T8cOwbdX64kVFtXlWBN1+5Q
 IG9xCHwPfMeC3wmdArCeCMJoh6OR5uWyIDUItIr6Wm03Bratkd8G/VEc64rRs87g//i/
 IapcBsp7NFna60qZkzEkoe60HsqAkUmg6Ivp9ogy88FlyOEl1PinpO78LLkhuOQf1Ryn
 1W0Q==
X-Gm-Message-State: ABy/qLaitWt7D1FuVa92rJC9cYZHbogDVaPApftMmXQWSWjCI3LhZr9h
 kFO7Vsv3ppbFXxMTYdwTFscCP9Kr3H0FZqhWB4CdMtZo2Nr/coCCuJ4wmEvlrR4ulbBeVMmQGVR
 b1Xki4dauNy6lr2OSNO9g9CxhlJpFcp2Q3suq9LQg8A==
X-Received: by 2002:a1c:4c13:0:b0:3fb:b1bf:7df3 with SMTP id
 z19-20020a1c4c13000000b003fbb1bf7df3mr2199607wmf.16.1689873286308; 
 Thu, 20 Jul 2023 10:14:46 -0700 (PDT)
X-Google-Smtp-Source: APBJJlFAgJO3NxYviKlK+X6t6HgIiN+C/pcRVYIxatfLo7cgnANyyz1Ib3buESEGZUGAVckH6rGlPA==
X-Received: by 2002:a1c:4c13:0:b0:3fb:b1bf:7df3 with SMTP id
 z19-20020a1c4c13000000b003fbb1bf7df3mr2199588wmf.16.1689873285921; 
 Thu, 20 Jul 2023 10:14:45 -0700 (PDT)
Received: from redhat.com ([2.52.16.41]) by smtp.gmail.com with ESMTPSA id
 m24-20020a056000181800b003143ac73fd0sm1892991wrh.1.2023.07.20.10.14.44
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 20 Jul 2023 10:14:45 -0700 (PDT)
Date: Thu, 20 Jul 2023 13:14:41 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Jason Wang <jasowang@redhat.com>
Subject: Re: [PATCH v1] virtio-pci: Fix legacy device flag setting error in
 probe
Message-ID: <20230720131423-mutt-send-email-mst@kernel.org>
References: <20230719154550.79536-1-feliu@nvidia.com>
 <CACGkMEv1b698NcpZHxpDoNokWH0gEs07D2eYSAjsiF1efhxORw@mail.gmail.com>
MIME-Version: 1.0
In-Reply-To: <CACGkMEv1b698NcpZHxpDoNokWH0gEs07D2eYSAjsiF1efhxORw@mail.gmail.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Disposition: inline
Cc: Xuan Zhuo <xuanzhuo@linux.alibaba.com>, linux-kernel@vger.kernel.org,
 virtualization@lists.linux-foundation.org, Jiri Pirko <jiri@nvidia.com>,
 Bodong Wang <bodong@nvidia.com>
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

T24gVGh1LCBKdWwgMjAsIDIwMjMgYXQgMTA6Mjc6MDRBTSArMDgwMCwgSmFzb24gV2FuZyB3cm90
ZToKPiBPbiBXZWQsIEp1bCAxOSwgMjAyMyBhdCAxMTo0NuKAr1BNIEZlbmcgTGl1IDxmZWxpdUBu
dmlkaWEuY29tPiB3cm90ZToKPiA+Cj4gPiBUaGUgJ2lzX2xlZ2FjeScgZmxhZyBpcyB1c2VkIHRv
IGRpZmZlcmVudGlhdGUgYmV0d2VlbiBsZWdhY3kgdnMgbW9kZXJuCj4gPiBkZXZpY2UuIEN1cnJl
bnRseSwgaXQgaXMgYmFzZWQgb24gdGhlIHZhbHVlIG9mIHZwX2Rldi0+bGRldi5pb2FkZHIuCj4g
PiBIb3dldmVyLCBkdWUgdG8gdGhlIHNoYXJlZCBtZW1vcnkgb2YgdGhlIHVuaW9uIGJldHdlZW4g
c3RydWN0Cj4gPiB2aXJ0aW9fcGNpX2xlZ2FjeV9kZXZpY2UgYW5kIHN0cnVjdCB2aXJ0aW9fcGNp
X21vZGVybl9kZXZpY2UsIHdoZW4KPiA+IHZpcnRpb19wY2lfbW9kZXJuX3Byb2JlIG1vZGlmaWVz
IHRoZSBjb250ZW50IG9mIHN0cnVjdAo+ID4gdmlydGlvX3BjaV9tb2Rlcm5fZGV2aWNlLCBpdCBh
ZmZlY3RzIHRoZSBjb250ZW50IG9mIHN0cnVjdAo+ID4gdmlydGlvX3BjaV9sZWdhY3lfZGV2aWNl
LCBhbmQgbGRldi5pb2FkZHIgaXMgbm8gbG9uZ2VyIHplcm8sIGNhdXNpbmcKPiA+IHRoZSAnaXNf
bGVnYWN5JyBmbGFnIHRvIGJlIHNldCBhcyB0cnVlLiBUbyByZXNvbHZlIGlzc3VlLCB3aGVuIGxl
Z2FjeQo+ID4gZGV2aWNlIGlzIHByb2JlZCwgbWFyayAnaXNfbGVnYWN5JyBhcyB0cnVlLCB3aGVu
IG1vZGVybiBkZXZpY2UgaXMKPiA+IHByb2JlZCwga2VlcCAnaXNfbGVnYWN5JyBhcyBmYWxzZS4K
PiA+Cj4gPiBGaXhlczogNGYwZmMyMjUzNGUzICgidmlydGlvX3BjaTogT3B0aW1pemUgdmlydGlv
X3BjaV9kZXZpY2Ugc3RydWN0dXJlIHNpemUiKQo+ID4gU2lnbmVkLW9mZi1ieTogRmVuZyBMaXUg
PGZlbGl1QG52aWRpYS5jb20+Cj4gPiBSZXZpZXdlZC1ieTogUGFyYXYgUGFuZGl0IDxwYXJhdkBu
dmlkaWEuY29tPgo+ID4gUmV2aWV3ZWQtYnk6IEppcmkgUGlya28gPGppcmlAbnZpZGlhLmNvbT4K
PiA+IC0tLQo+ID4gIGRyaXZlcnMvdmlydGlvL3ZpcnRpb19wY2lfY29tbW9uLmMgfCAyIC0tCj4g
PiAgZHJpdmVycy92aXJ0aW8vdmlydGlvX3BjaV9sZWdhY3kuYyB8IDEgKwo+ID4gIDIgZmlsZXMg
Y2hhbmdlZCwgMSBpbnNlcnRpb24oKyksIDIgZGVsZXRpb25zKC0pCj4gPgo+ID4gZGlmZiAtLWdp
dCBhL2RyaXZlcnMvdmlydGlvL3ZpcnRpb19wY2lfY29tbW9uLmMgYi9kcml2ZXJzL3ZpcnRpby92
aXJ0aW9fcGNpX2NvbW1vbi5jCj4gPiBpbmRleCBhNmM4NmY5MTZkYmQuLmMyNTI0YTcyMDdjZiAx
MDA2NDQKPiA+IC0tLSBhL2RyaXZlcnMvdmlydGlvL3ZpcnRpb19wY2lfY29tbW9uLmMKPiA+ICsr
KyBiL2RyaXZlcnMvdmlydGlvL3ZpcnRpb19wY2lfY29tbW9uLmMKPiA+IEBAIC01NTcsOCArNTU3
LDYgQEAgc3RhdGljIGludCB2aXJ0aW9fcGNpX3Byb2JlKHN0cnVjdCBwY2lfZGV2ICpwY2lfZGV2
LAo+ID4KPiA+ICAgICAgICAgcGNpX3NldF9tYXN0ZXIocGNpX2Rldik7Cj4gPgo+ID4gLSAgICAg
ICB2cF9kZXYtPmlzX2xlZ2FjeSA9IHZwX2Rldi0+bGRldi5pb2FkZHIgPyB0cnVlIDogZmFsc2U7
Cj4gPiAtCj4gPiAgICAgICAgIHJjID0gcmVnaXN0ZXJfdmlydGlvX2RldmljZSgmdnBfZGV2LT52
ZGV2KTsKPiA+ICAgICAgICAgcmVnX2RldiA9IHZwX2RldjsKPiA+ICAgICAgICAgaWYgKHJjKQo+
ID4gZGlmZiAtLWdpdCBhL2RyaXZlcnMvdmlydGlvL3ZpcnRpb19wY2lfbGVnYWN5LmMgYi9kcml2
ZXJzL3ZpcnRpby92aXJ0aW9fcGNpX2xlZ2FjeS5jCj4gPiBpbmRleCAyMjU3ZjFiM2Q4YWUuLmQ5
Y2JiMDJiMzVhMSAxMDA2NDQKPiA+IC0tLSBhL2RyaXZlcnMvdmlydGlvL3ZpcnRpb19wY2lfbGVn
YWN5LmMKPiA+ICsrKyBiL2RyaXZlcnMvdmlydGlvL3ZpcnRpb19wY2lfbGVnYWN5LmMKPiA+IEBA
IC0yMjMsNiArMjIzLDcgQEAgaW50IHZpcnRpb19wY2lfbGVnYWN5X3Byb2JlKHN0cnVjdCB2aXJ0
aW9fcGNpX2RldmljZSAqdnBfZGV2KQo+ID4gICAgICAgICB2cF9kZXYtPmNvbmZpZ192ZWN0b3Ig
PSB2cF9jb25maWdfdmVjdG9yOwo+ID4gICAgICAgICB2cF9kZXYtPnNldHVwX3ZxID0gc2V0dXBf
dnE7Cj4gPiAgICAgICAgIHZwX2Rldi0+ZGVsX3ZxID0gZGVsX3ZxOwo+ID4gKyAgICAgICB2cF9k
ZXYtPmlzX2xlZ2FjeSA9IHRydWU7Cj4gCj4gVGhpcyBzZWVtcyBicmVhayBmb3JjZV9sZWdhY3kg
Zm9yIG1vZGVybiBkZXZpY2U6Cj4gCj4gICAgICAgICBpZiAoZm9yY2VfbGVnYWN5KSB7Cj4gICAg
ICAgICAgICAgICAgIHJjID0gdmlydGlvX3BjaV9sZWdhY3lfcHJvYmUodnBfZGV2KTsKPiAgICAg
ICAgICAgICAgICAgLyogQWxzbyB0cnkgbW9kZXJuIG1vZGUgaWYgd2UgY2FuJ3QgbWFwIEJBUjAg
KG5vIElPIHNwYWNlKS4gKi8KPiAgICAgICAgICAgICAgICAgaWYgKHJjID09IC1FTk9ERVYgfHwg
cmMgPT0gLUVOT01FTSkKPiAgICAgICAgICAgICAgICAgICAgICAgICByYyA9IHZpcnRpb19wY2lf
bW9kZXJuX3Byb2JlKHZwX2Rldik7Cj4gCj4gVGhhbmtzCgpkb24ndCBzZWUgdGhlIGJyZWFrYWdl
IGhlcmUgLSBjYW4geW91IGV4cGxhaW4gYSBiaXQgbW9yZT8KCj4gPgo+ID4gICAgICAgICByZXR1
cm4gMDsKPiA+ICB9Cj4gPiAtLQo+ID4gMi4zNy4xIChBcHBsZSBHaXQtMTM3LjEpCj4gPgoKX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18KVmlydHVhbGl6YXRp
b24gbWFpbGluZyBsaXN0ClZpcnR1YWxpemF0aW9uQGxpc3RzLmxpbnV4LWZvdW5kYXRpb24ub3Jn
Cmh0dHBzOi8vbGlzdHMubGludXhmb3VuZGF0aW9uLm9yZy9tYWlsbWFuL2xpc3RpbmZvL3ZpcnR1
YWxpemF0aW9u
