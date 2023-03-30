Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E7F21C6FD1D
	for <virtualization@archiver.kernel.org>; Thu, 30 Mar 2023 03:48:07 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp2.osuosl.org (Postfix) with ESMTP id 65F0640138;
	Thu, 30 Mar 2023 03:48:07 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org 65F0640138
Authentication-Results: smtp2.osuosl.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=DO+TwncX
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
	by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id Ql00lrp161u8; Thu, 30 Mar 2023 03:48:06 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp2.osuosl.org (Postfix) with ESMTPS id DCAF64036F;
	Thu, 30 Mar 2023 03:48:05 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org DCAF64036F
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 9F882C0036;
	Thu, 30 Mar 2023 03:48:05 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id D7448C002F
 for <virtualization@lists.linux-foundation.org>;
 Thu, 30 Mar 2023 03:48:04 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id A5396841B5
 for <virtualization@lists.linux-foundation.org>;
 Thu, 30 Mar 2023 03:48:04 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org A5396841B5
Authentication-Results: smtp1.osuosl.org;
 dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com
 header.a=rsa-sha256 header.s=mimecast20190719 header.b=DO+TwncX
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id 1I4tBEivK1pi
 for <virtualization@lists.linux-foundation.org>;
 Thu, 30 Mar 2023 03:48:02 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 9F583841B0
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.133.124])
 by smtp1.osuosl.org (Postfix) with ESMTPS id 9F583841B0
 for <virtualization@lists.linux-foundation.org>;
 Thu, 30 Mar 2023 03:48:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1680148081;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=nW7VtO3aQJ7C082UbTbym90NR4jGXt3vrx12mYLKfv8=;
 b=DO+TwncXjvXiTrehMbM5rURXLhhDOLjbztVBzHpZEUVXaBFoC+JXOmT6sS4c6MXfOkfnxX
 d7QAfmIiyq3AHI9zwCrEg2+fYHEIpTTk52bhd4KqUxjYNnHKrNgF/RNr8gOO1Wa8pzJGWe
 6N6txSw7JVKDFmxPfRhBwwlDRZoV2cw=
Received: from mail-oi1-f197.google.com (mail-oi1-f197.google.com
 [209.85.167.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-568-j6m-WDdWOSuhNNlgii8OQg-1; Wed, 29 Mar 2023 23:47:59 -0400
X-MC-Unique: j6m-WDdWOSuhNNlgii8OQg-1
Received: by mail-oi1-f197.google.com with SMTP id
 r4-20020a056808210400b003897356756bso354939oiw.13
 for <virtualization@lists.linux-foundation.org>;
 Wed, 29 Mar 2023 20:47:59 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112; t=1680148079; x=1682740079;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=nW7VtO3aQJ7C082UbTbym90NR4jGXt3vrx12mYLKfv8=;
 b=z+orkXQD1oYmbi26r3pf7G2IDSHW0uoumPeJxJP15xXyUwWnm2Jyx3+dWxGxudhaBE
 A+H4+nBuJqeYqk0EiLE73FTE5cj9fwrK664Nf4aaKysun0uCOjWIjvo/P3gNmvpb/X06
 0YNrgOuP359ADf54OpAJxygqQcyJTRLce4+4wIcWizPncHqeHjY3U8SghzKKxN+DsrU/
 eI49axcqPbGZZAEyUL1hTDOR1I0zUc27pisUZnERfa/msXtuwZFE2wQFISVQP7QWHgXq
 5DdcNnB624vPw5iJB3lOBYiTNYhoOGcwa6wB9LVS2sU3weirIGbiQuq4F2VbjVo3qRpR
 rQFA==
X-Gm-Message-State: AAQBX9f7MK5WVN6ljKL3zY11iQ2S0RL5wdt2z74LlGwAaY7sSdK3ZKr7
 ASRoq6ZC6ASv+qXm9I1BRFPG2I4Ds0K5ixntSpSLLaZqF0H4UEQtXImdw3+I1weqz6f3i/cylA8
 RviCArkGc8pjqNgj4GE/BHnJ4+xNCu5vX5YSlpurNPfVF0qPKfR57495FGg==
X-Received: by 2002:a05:6870:96a2:b0:17e:d94f:90d9 with SMTP id
 o34-20020a05687096a200b0017ed94f90d9mr1764064oaq.3.1680148079119; 
 Wed, 29 Mar 2023 20:47:59 -0700 (PDT)
X-Google-Smtp-Source: AKy350Zxtsr9EOQh5Be9f14rCIIdxXPCfJVkEcY6HbwWaN0N1hrDSDWiuKn6ROUSWV8Gf8HCnOSZhGddJ+J0oQcbCJs=
X-Received: by 2002:a05:6870:96a2:b0:17e:d94f:90d9 with SMTP id
 o34-20020a05687096a200b0017ed94f90d9mr1764057oaq.3.1680148078944; Wed, 29 Mar
 2023 20:47:58 -0700 (PDT)
MIME-Version: 1.0
References: <20230328071835.843396-1-elic@nvidia.com>
In-Reply-To: <20230328071835.843396-1-elic@nvidia.com>
From: Jason Wang <jasowang@redhat.com>
Date: Thu, 30 Mar 2023 11:47:47 +0800
Message-ID: <CACGkMEu5EL5ysM5nnMu_OPke73p2qVR-FGoGK0n31X3ND0utnA@mail.gmail.com>
Subject: Re: [PATCH v2] vdpa/mlx5: Add and remove debugfs in setup/teardown
 driver
To: Eli Cohen <elic@nvidia.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Cc: eperezma@redhat.com, virtualization@lists.linux-foundation.org,
 parav@mellanox.com, mst@redhat.com
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

T24gVHVlLCBNYXIgMjgsIDIwMjMgYXQgMzoxOOKAr1BNIEVsaSBDb2hlbiA8ZWxpY0BudmlkaWEu
Y29tPiB3cm90ZToKPgo+IFRoZSByaWdodCBwbGFjZSB0byBhZGQgdGhlIGRlYnVnZnMgY3JlYXRl
IGlzIGluCj4gc2V0dXBfZHJpdmVyKCkgYW5kIHJlbW92ZSBpdCBpbiB0ZWFyZG93bl9kcml2ZXIo
KS4KPgo+IEN1cnJlbnQgY29kZSBhZGRzIHRoZSBkZWJ1Z2ZzIHdoZW4gY3JlYXRpbmcgdGhlIGRl
dmljZSBidXQgcmVzZXR0aW5nIGEKPiBkZXZpY2Ugd2lsbCByZW1vdmUgdGhlIGRlYnVnZnMgc3Vi
dHJlZSBhbmQgc3Vic2VxdWVudCBzZXRfZHJpdmVyIHdpbGwKPiBub3QgYmUgYWJsZSB0byBjcmVh
dGUgdGhlIGZpbGVzIHNpbmNlIHRoZSBkZWJ1Z2ZzIHBvaW50ZXIgaXMgTlVMTC4KPgo+IEZpeGVz
OiAyOTQyMjEwMDQzMjIgKCJ2ZHBhL21seDU6IEFkZCBkZWJ1Z2ZzIHN1YnRyZWUiKQo+IFNpZ25l
ZC1vZmYtYnk6IEVsaSBDb2hlbiA8ZWxpY0BudmlkaWEuY29tPgoKQWNrZWQtYnk6IEphc29uIFdh
bmcgPGphc293YW5nQHJlZGhhdC5jb20+CgpUaGFua3MKCj4KPiAtLS0KPiB2MSAtPiB2MjoKPiBG
aXggc3BlbGxpbmcgZXJyb3JzCj4KPiAgZHJpdmVycy92ZHBhL21seDUvbmV0L21seDVfdm5ldC5j
IHwgNCArKystCj4gIDEgZmlsZSBjaGFuZ2VkLCAzIGluc2VydGlvbnMoKyksIDEgZGVsZXRpb24o
LSkKPgo+IGRpZmYgLS1naXQgYS9kcml2ZXJzL3ZkcGEvbWx4NS9uZXQvbWx4NV92bmV0LmMgYi9k
cml2ZXJzL3ZkcGEvbWx4NS9uZXQvbWx4NV92bmV0LmMKPiBpbmRleCBiNzNjNTk0M2FlZmQuLmYy
NGFhN2E3YzczNSAxMDA2NDQKPiAtLS0gYS9kcml2ZXJzL3ZkcGEvbWx4NS9uZXQvbWx4NV92bmV0
LmMKPiArKysgYi9kcml2ZXJzL3ZkcGEvbWx4NS9uZXQvbWx4NV92bmV0LmMKPiBAQCAtMjUzOCw2
ICsyNTM4LDcgQEAgc3RhdGljIGludCBzZXR1cF9kcml2ZXIoc3RydWN0IG1seDVfdmRwYV9kZXYg
Km12ZGV2KQo+ICAgICAgICAgICAgICAgICBlcnIgPSAwOwo+ICAgICAgICAgICAgICAgICBnb3Rv
IG91dDsKPiAgICAgICAgIH0KPiArICAgICAgIG1seDVfdmRwYV9hZGRfZGVidWdmcyhuZGV2KTsK
PiAgICAgICAgIGVyciA9IHNldHVwX3ZpcnRxdWV1ZXMobXZkZXYpOwo+ICAgICAgICAgaWYgKGVy
cikgewo+ICAgICAgICAgICAgICAgICBtbHg1X3ZkcGFfd2FybihtdmRldiwgInNldHVwX3ZpcnRx
dWV1ZXNcbiIpOwo+IEBAIC0yNTg0LDYgKzI1ODUsOCBAQCBzdGF0aWMgdm9pZCB0ZWFyZG93bl9k
cml2ZXIoc3RydWN0IG1seDVfdmRwYV9uZXQgKm5kZXYpCj4gICAgICAgICBpZiAoIW5kZXYtPnNl
dHVwKQo+ICAgICAgICAgICAgICAgICByZXR1cm47Cj4KPiArICAgICAgIG1seDVfdmRwYV9yZW1v
dmVfZGVidWdmcyhuZGV2LT5kZWJ1Z2ZzKTsKPiArICAgICAgIG5kZXYtPmRlYnVnZnMgPSBOVUxM
Owo+ICAgICAgICAgdGVhcmRvd25fc3RlZXJpbmcobmRldik7Cj4gICAgICAgICBkZXN0cm95X3Rp
cihuZGV2KTsKPiAgICAgICAgIGRlc3Ryb3lfcnF0KG5kZXYpOwo+IEBAIC0zMzA0LDcgKzMzMDcs
NiBAQCBzdGF0aWMgaW50IG1seDVfdmRwYV9kZXZfYWRkKHN0cnVjdCB2ZHBhX21nbXRfZGV2ICp2
X21kZXYsIGNvbnN0IGNoYXIgKm5hbWUsCj4gICAgICAgICBpZiAoZXJyKQo+ICAgICAgICAgICAg
ICAgICBnb3RvIGVycl9yZWc7Cj4KPiAtICAgICAgIG1seDVfdmRwYV9hZGRfZGVidWdmcyhuZGV2
KTsKPiAgICAgICAgIG1ndGRldi0+bmRldiA9IG5kZXY7Cj4gICAgICAgICByZXR1cm4gMDsKPgo+
IC0tCj4gMi4zOC4xCj4KCl9fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fClZpcnR1YWxpemF0aW9uIG1haWxpbmcgbGlzdApWaXJ0dWFsaXphdGlvbkBsaXN0cy5s
aW51eC1mb3VuZGF0aW9uLm9yZwpodHRwczovL2xpc3RzLmxpbnV4Zm91bmRhdGlvbi5vcmcvbWFp
bG1hbi9saXN0aW5mby92aXJ0dWFsaXphdGlvbg==
