Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 81094C4332F
	for <virtualization@archiver.kernel.org>; Thu,  2 Nov 2023 08:15:45 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id F2171705EF;
	Thu,  2 Nov 2023 08:15:44 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org F2171705EF
Authentication-Results: smtp3.osuosl.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=Qurb6IIp
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
	by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id OHBDFMw8Ntbr; Thu,  2 Nov 2023 08:15:41 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp3.osuosl.org (Postfix) with ESMTPS id 6F59D705F0;
	Thu,  2 Nov 2023 08:15:40 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 6F59D705F0
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 3CAA9C0072;
	Thu,  2 Nov 2023 08:15:40 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 30905C0032
 for <virtualization@lists.linux-foundation.org>;
 Thu,  2 Nov 2023 08:15:39 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id F0F1640A49
 for <virtualization@lists.linux-foundation.org>;
 Thu,  2 Nov 2023 08:15:38 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org F0F1640A49
Authentication-Results: smtp2.osuosl.org;
 dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com
 header.a=rsa-sha256 header.s=mimecast20190719 header.b=Qurb6IIp
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id TrWUi4CkGjnL
 for <virtualization@lists.linux-foundation.org>;
 Thu,  2 Nov 2023 08:15:35 +0000 (UTC)
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.129.124])
 by smtp2.osuosl.org (Postfix) with ESMTPS id 0DDCA40A47
 for <virtualization@lists.linux-foundation.org>;
 Thu,  2 Nov 2023 08:15:34 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org 0DDCA40A47
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1698912933;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=PFKsEKzMqdTXmNEgyPABTN8mI4iPSC4G65mkKZOmYsc=;
 b=Qurb6IIpPV7lvITwE/zzyDr3q1CpRqEFwnY9hh6vaP7qixdxYmVieKiYL7FHDErIhShAbJ
 UJ2iH5Kj0jaFZgb6DTi3cf9toSFesozFxxlssABpXKDD210eapa+3ZA+NHFO+LyyuGD0x/
 MccIGHPlistvdAAr4F/7bLfX+E9y69s=
Received: from mail-lf1-f72.google.com (mail-lf1-f72.google.com
 [209.85.167.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-633-UCU-n4_iM5S1dSwTADQFkQ-1; Thu, 02 Nov 2023 04:15:32 -0400
X-MC-Unique: UCU-n4_iM5S1dSwTADQFkQ-1
Received: by mail-lf1-f72.google.com with SMTP id
 2adb3069b0e04-507cb169766so556853e87.0
 for <virtualization@lists.linux-foundation.org>;
 Thu, 02 Nov 2023 01:15:32 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1698912931; x=1699517731;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=PFKsEKzMqdTXmNEgyPABTN8mI4iPSC4G65mkKZOmYsc=;
 b=h/fM/LXGf9PEiXMINrMENgEk6HhrC8oGFc2IOF190TfNwYzB/gW5P5RUVk3TxRNBrg
 GjZcKgOev2Sp9rjCgCwC7ZhCVEr6uTCsHV6Yx4+cAJu92h9jG5Gu2aSCxnejf87qO6WG
 BhGlkelIAqMdfbONgDquBNmek754Im9v7eWsROBP5OfWrdSM2cxspyLppiEg073V99jL
 iJXTFyckh5YK0HytoV4AFhKw1xg7kYtzWswn5t0RXtPqBZGuma1/4pxneXMLExGpgQ9G
 EowOAEnwg1WsUkfp/0p0lJZqxsuKuy0LQvDAKBu/3MSBwwwFvabhRx5oydP6RnMzkbZk
 rqTQ==
X-Gm-Message-State: AOJu0YxP8cikseFY34X+q4iVg2tpznQtWOBdT+9vGxQT0GmSd8D4Vq2J
 dse2WvADYbGuLpic2Z1YfPlxHbn369iEx4r55LlDOFA0kynHRGIGWP1R7aFwjYEcdvWbvjMfKKJ
 LgOBd5yg2ARniJ7jOd1mt0ib9DvSRX5fTav4rqQLfP+niZxHPXtw8ty/ZuQ==
X-Received: by 2002:ac2:55a2:0:b0:507:cb61:2054 with SMTP id
 y2-20020ac255a2000000b00507cb612054mr13495811lfg.49.1698912931100; 
 Thu, 02 Nov 2023 01:15:31 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHu2lBr+3T/yTKhgfdnjCHFVsV0eOqpx+dZym2wOWoCb8h510cr3//uegK3kk4tjv5jBm3SajFxi+kqSt7qldg=
X-Received: by 2002:ac2:55a2:0:b0:507:cb61:2054 with SMTP id
 y2-20020ac255a2000000b00507cb612054mr13495793lfg.49.1698912930773; Thu, 02
 Nov 2023 01:15:30 -0700 (PDT)
MIME-Version: 1.0
References: <1698854083-136016-1-git-send-email-steven.sistare@oracle.com>
 <CAJaqyWfpgQcYbvRgYkvVAq5SiFVVJdWF9PLfOnvd7ipGcjYghA@mail.gmail.com>
In-Reply-To: <CAJaqyWfpgQcYbvRgYkvVAq5SiFVVJdWF9PLfOnvd7ipGcjYghA@mail.gmail.com>
From: Jason Wang <jasowang@redhat.com>
Date: Thu, 2 Nov 2023 16:15:18 +0800
Message-ID: <CACGkMEsNcuQNt+9od6D+O_RbxKcpG8U14zBSibRYz91SXiwZ7A@mail.gmail.com>
Subject: Re: [PATCH V2] vdpa/mlx5: preserve CVQ vringh index
To: Eugenio Perez Martin <eperezma@redhat.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Cc: Xuan Zhuo <xuanzhuo@linux.alibaba.com>,
 "Michael S. Tsirkin" <mst@redhat.com>, linux-kernel@vger.kernel.org,
 virtualization@lists.linux-foundation.org,
 Steve Sistare <steven.sistare@oracle.com>, Eli Cohen <elic@nvidia.com>
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

T24gVGh1LCBOb3YgMiwgMjAyMyBhdCAzOjEw4oCvUE0gRXVnZW5pbyBQZXJleiBNYXJ0aW4gPGVw
ZXJlem1hQHJlZGhhdC5jb20+IHdyb3RlOgo+Cj4gT24gV2VkLCBOb3YgMSwgMjAyMyBhdCA0OjU1
4oCvUE0gU3RldmUgU2lzdGFyZSA8c3RldmVuLnNpc3RhcmVAb3JhY2xlLmNvbT4gd3JvdGU6Cj4g
Pgo+ID4gbWx4NV92ZHBhIGRvZXMgbm90IHByZXNlcnZlIHVzZXJsYW5kJ3MgdmlldyBvZiB2cmlu
ZyBiYXNlIGZvciB0aGUgY29udHJvbAo+ID4gcXVldWUgaW4gdGhlIGZvbGxvd2luZyBzZXF1ZW5j
ZToKPiA+Cj4gPiBpb2N0bCBWSE9TVF9TRVRfVlJJTkdfQkFTRQo+ID4gaW9jdGwgVkhPU1RfVkRQ
QV9TRVRfU1RBVFVTIFZJUlRJT19DT05GSUdfU19EUklWRVJfT0sKPiA+ICAgbWx4NV92ZHBhX3Nl
dF9zdGF0dXMoKQo+ID4gICAgIHNldHVwX2N2cV92cmluZygpCj4gPiAgICAgICB2cmluZ2hfaW5p
dF9pb3RsYigpCj4gPiAgICAgICAgIHZyaW5naF9pbml0X2tlcm4oKQo+ID4gICAgICAgICAgIHZy
aC0+bGFzdF9hdmFpbF9pZHggPSAwOwo+ID4gaW9jdGwgVkhPU1RfR0VUX1ZSSU5HX0JBU0UKPiA+
Cj4gPiBUbyBmaXgsIHJlc3RvcmUgdGhlIHZhbHVlIG9mIGN2cS0+dnJpbmcubGFzdF9hdmFpbF9p
ZHggYWZ0ZXIgY2FsbGluZwo+ID4gdnJpbmdoX2luaXRfaW90bGIuCj4gPgo+Cj4gRml4ZXMgdGFn
IG1pc3Npbmc/CgorMQoKPgo+IEFwYXJ0IGZyb20gdGhhdCwKPgo+IEFja2VkLWJ5OiBFdWdlbmlv
IFDDqXJleiA8ZXBlcmV6bWFAcmVkaGF0LmNvbT4KCldpdGggdGhlIGZpeCB0YWcgYWRkZWQuCgpB
Y2tlZC1ieTogSmFzb24gV2FuZyA8amFzb3dhbmdAcmVkaGF0LmNvbT4KClRoYW5rcwoKPgo+ID4g
U2lnbmVkLW9mZi1ieTogU3RldmUgU2lzdGFyZSA8c3RldmVuLnNpc3RhcmVAb3JhY2xlLmNvbT4K
PiA+IC0tLQo+ID4gIGRyaXZlcnMvdmRwYS9tbHg1L25ldC9tbHg1X3ZuZXQuYyB8IDcgKysrKysr
LQo+ID4gIDEgZmlsZSBjaGFuZ2VkLCA2IGluc2VydGlvbnMoKyksIDEgZGVsZXRpb24oLSkKPiA+
Cj4gPiBkaWZmIC0tZ2l0IGEvZHJpdmVycy92ZHBhL21seDUvbmV0L21seDVfdm5ldC5jIGIvZHJp
dmVycy92ZHBhL21seDUvbmV0L21seDVfdm5ldC5jCj4gPiBpbmRleCA5NDY0ODhiODk4OWYuLmNh
OTcyYWYzYzg5YSAxMDA2NDQKPiA+IC0tLSBhL2RyaXZlcnMvdmRwYS9tbHg1L25ldC9tbHg1X3Zu
ZXQuYwo+ID4gKysrIGIvZHJpdmVycy92ZHBhL21seDUvbmV0L21seDVfdm5ldC5jCj4gPiBAQCAt
Mjc5NSwxMyArMjc5NSwxOCBAQCBzdGF0aWMgaW50IHNldHVwX2N2cV92cmluZyhzdHJ1Y3QgbWx4
NV92ZHBhX2RldiAqbXZkZXYpCj4gPiAgICAgICAgIHN0cnVjdCBtbHg1X2NvbnRyb2xfdnEgKmN2
cSA9ICZtdmRldi0+Y3ZxOwo+ID4gICAgICAgICBpbnQgZXJyID0gMDsKPiA+Cj4gPiAtICAgICAg
IGlmIChtdmRldi0+YWN0dWFsX2ZlYXR1cmVzICYgQklUX1VMTChWSVJUSU9fTkVUX0ZfQ1RSTF9W
USkpCj4gPiArICAgICAgIGlmIChtdmRldi0+YWN0dWFsX2ZlYXR1cmVzICYgQklUX1VMTChWSVJU
SU9fTkVUX0ZfQ1RSTF9WUSkpIHsKPiA+ICsgICAgICAgICAgICAgICB1MTYgaWR4ID0gY3ZxLT52
cmluZy5sYXN0X2F2YWlsX2lkeDsKPiA+ICsKPiA+ICAgICAgICAgICAgICAgICBlcnIgPSB2cmlu
Z2hfaW5pdF9pb3RsYigmY3ZxLT52cmluZywgbXZkZXYtPmFjdHVhbF9mZWF0dXJlcywKPiA+ICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICBNTFg1X0NWUV9NQVhfRU5ULCBm
YWxzZSwKPiA+ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAoc3RydWN0
IHZyaW5nX2Rlc2MgKikodWludHB0cl90KWN2cS0+ZGVzY19hZGRyLAo+ID4gICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgIChzdHJ1Y3QgdnJpbmdfYXZhaWwgKikodWludHB0
cl90KWN2cS0+ZHJpdmVyX2FkZHIsCj4gPiAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgKHN0cnVjdCB2cmluZ191c2VkICopKHVpbnRwdHJfdCljdnEtPmRldmljZV9hZGRy
KTsKPiA+Cj4gPiArICAgICAgICAgICAgICAgaWYgKCFlcnIpCj4gPiArICAgICAgICAgICAgICAg
ICAgICAgICBjdnEtPnZyaW5nLmxhc3RfYXZhaWxfaWR4ID0gY3ZxLT52cmluZy5sYXN0X3VzZWRf
aWR4ID0gaWR4Owo+ID4gKyAgICAgICB9Cj4gPiAgICAgICAgIHJldHVybiBlcnI7Cj4gPiAgfQo+
ID4KPiA+IC0tCj4gPiAyLjM5LjMKPiA+Cj4KCl9fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fClZpcnR1YWxpemF0aW9uIG1haWxpbmcgbGlzdApWaXJ0dWFsaXph
dGlvbkBsaXN0cy5saW51eC1mb3VuZGF0aW9uLm9yZwpodHRwczovL2xpc3RzLmxpbnV4Zm91bmRh
dGlvbi5vcmcvbWFpbG1hbi9saXN0aW5mby92aXJ0dWFsaXphdGlvbg==
