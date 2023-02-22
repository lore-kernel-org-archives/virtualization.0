Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2A1BFC61DA4
	for <virtualization@archiver.kernel.org>; Wed, 22 Feb 2023 04:05:22 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id B9FB281EE7;
	Wed, 22 Feb 2023 04:05:21 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org B9FB281EE7
Authentication-Results: smtp1.osuosl.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=I4s0VNvW
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
	by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id eZZDUQ5Bezzd; Wed, 22 Feb 2023 04:05:20 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp1.osuosl.org (Postfix) with ESMTPS id 3C5CB81ED7;
	Wed, 22 Feb 2023 04:05:20 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 3C5CB81ED7
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 10563C0033;
	Wed, 22 Feb 2023 04:05:20 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [IPv6:2605:bc80:3010::136])
 by lists.linuxfoundation.org (Postfix) with ESMTP id E7838C002B
 for <virtualization@lists.linux-foundation.org>;
 Wed, 22 Feb 2023 04:05:18 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id C8B2B60B2B
 for <virtualization@lists.linux-foundation.org>;
 Wed, 22 Feb 2023 04:05:18 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org C8B2B60B2B
Authentication-Results: smtp3.osuosl.org;
 dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com
 header.a=rsa-sha256 header.s=mimecast20190719 header.b=I4s0VNvW
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id SWo4YjRIwCCl
 for <virtualization@lists.linux-foundation.org>;
 Wed, 22 Feb 2023 04:05:18 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org F28F260B23
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.133.124])
 by smtp3.osuosl.org (Postfix) with ESMTPS id F28F260B23
 for <virtualization@lists.linux-foundation.org>;
 Wed, 22 Feb 2023 04:05:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1677038716;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=GFohn0VGV0YYVS1cn/bv1WgUnkGLLWD2wKZ4KHo94yo=;
 b=I4s0VNvWU6OWpn0ulIQkjCeLPPkVfAsR2coJlpqfp+6QuhPLPgyOXiKUvF31NyGso8lZml
 Xi039PoxnHCeI1xkHI89Nhmf3Xh8oQUlL6FnakYoj77OhEzTdbpZGcn5u4sZdjsXkjwJwz
 A0lqLpLBU+oiBSlOr3KYNL3FUhu8skg=
Received: from mail-pl1-f197.google.com (mail-pl1-f197.google.com
 [209.85.214.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-154-zi8kSAx2P1uRH8vKDzhPOA-1; Tue, 21 Feb 2023 23:05:13 -0500
X-MC-Unique: zi8kSAx2P1uRH8vKDzhPOA-1
Received: by mail-pl1-f197.google.com with SMTP id
 j18-20020a170903025200b00198aa765a9dso3301858plh.6
 for <virtualization@lists.linux-foundation.org>;
 Tue, 21 Feb 2023 20:05:12 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=GFohn0VGV0YYVS1cn/bv1WgUnkGLLWD2wKZ4KHo94yo=;
 b=f/LDOaVVnXopWazcNKTpkGQavRjckGQ11P44Wsu6G9mFsZoKwLXLLUDdCDoYkp51km
 wRI19ybRlm+X0cqXxUu224S2WPXSpSKnOrCak1lEoDRKTLxfgoWGwSBHMPUK2RWajdBi
 LDoX6fmEZpESL3DfoEV/TyiEbFja9oN9UIwifU2uuaqc9XjKS7DHbNPqvUZcOc0zd/Up
 J9ScvNZixH9epBbqwugIEgZ6FAUXB+MWuvlI3b7X1LRK0JeuoNzaC4xTnqRZJrZNJEzB
 ZY3U5tiXLfn5mKArSQO4EojCsf5B/J3lrBa/P82dJ4ZRApkEdTeV1UvD8sejB7eIXZE4
 Cnaw==
X-Gm-Message-State: AO0yUKVqLl37TowOM05kcj8s84TVg7ZnXxQojha6FnBsyWL1hadCohRB
 Ol208SWgWCOddSDaYOvW6LxxxmRQZGul2PsfpTR04SmIPV/7Juv3RXCztsqrma9OqZcDfOepj4u
 zP6MiDIVO6P5cMxbLTvfJZNAmMvEmHttXfWDsfArlwQ==
X-Received: by 2002:a05:6a00:3305:b0:5a8:d438:c72 with SMTP id
 cq5-20020a056a00330500b005a8d4380c72mr5032884pfb.5.1677038712103; 
 Tue, 21 Feb 2023 20:05:12 -0800 (PST)
X-Google-Smtp-Source: AK7set+PyoeAv7/3kKyYOvWuBMNcRY5K+ZpHxCgRE/zwGuRof86URhuuLcOQkSYeRhgU7NK/PTxX/w==
X-Received: by 2002:a05:6a00:3305:b0:5a8:d438:c72 with SMTP id
 cq5-20020a056a00330500b005a8d4380c72mr5032876pfb.5.1677038711811; 
 Tue, 21 Feb 2023 20:05:11 -0800 (PST)
Received: from [10.72.13.76] ([43.228.180.230])
 by smtp.gmail.com with ESMTPSA id
 n11-20020a62e50b000000b00586fbbdf6e4sm10221064pff.34.2023.02.21.20.05.06
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 21 Feb 2023 20:05:11 -0800 (PST)
Message-ID: <c8d6ecc3-87f6-986e-e78d-003000e8a51e@redhat.com>
Date: Wed, 22 Feb 2023 12:05:04 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.8.0
Subject: Re: [PATCH v2 11/13] vdpa: block migration if dev does not have
 _F_SUSPEND
To: =?UTF-8?Q?Eugenio_P=c3=a9rez?= <eperezma@redhat.com>, qemu-devel@nongnu.org
References: <20230208094253.702672-1-eperezma@redhat.com>
 <20230208094253.702672-12-eperezma@redhat.com>
From: Jason Wang <jasowang@redhat.com>
In-Reply-To: <20230208094253.702672-12-eperezma@redhat.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Language: en-US
Cc: Laurent Vivier <lvivier@redhat.com>, Parav Pandit <parav@mellanox.com>,
 Cindy Lu <lulu@redhat.com>, "Michael S. Tsirkin" <mst@redhat.com>,
 Gautam Dawar <gdawar@xilinx.com>, virtualization@lists.linux-foundation.org,
 Harpreet Singh Anand <hanand@xilinx.com>, Lei Yang <leiyang@redhat.com>,
 Stefan Hajnoczi <stefanha@redhat.com>, Eli Cohen <eli@mellanox.com>,
 longpeng2@huawei.com, Shannon Nelson <snelson@pensando.io>,
 Liuxiangdong <liuxiangdong5@huawei.com>
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
Content-Transfer-Encoding: base64
Content-Type: text/plain; charset="utf-8"; Format="flowed"
Errors-To: virtualization-bounces@lists.linux-foundation.org
Sender: "Virtualization" <virtualization-bounces@lists.linux-foundation.org>

CuWcqCAyMDIzLzIvOCAxNzo0MiwgRXVnZW5pbyBQw6lyZXog5YaZ6YGTOgo+IE5leHQgcGF0Y2hl
cyBlbmFibGUgZGV2aWNlcyB0byBiZSBtaWdyYXRlZCBldmVuIGlmIHZkcGEgbmV0ZGV2IGhhcyBu
b3QKPiBiZWVuIHN0YXJ0ZWQgd2l0aCB4LXN2cS4gSG93ZXZlciwgbm90IGFsbCBkZXZpY2VzIGFy
ZSBtaWdyYXRhYmxlLCBzbyB3ZQo+IG5lZWQgdG8gYmxvY2sgbWlncmF0aW9uIGlmIHdlIGRldGVj
dCB0aGF0Lgo+Cj4gQmxvY2sgdmhvc3QtdmRwYSBkZXZpY2UgbWlncmF0aW9uIGlmIGl0IGRvZXMg
bm90IG9mZmVyIF9GX1NVU1BFTkQgYW5kIGl0Cj4gaGFzIG5vdCBiZWVuIHN0YXJ0ZWQgd2l0aCB4
LXN2cS4KPgo+IFNpZ25lZC1vZmYtYnk6IEV1Z2VuaW8gUMOpcmV6IDxlcGVyZXptYUByZWRoYXQu
Y29tPgo+IC0tLQo+ICAgaHcvdmlydGlvL3Zob3N0LXZkcGEuYyB8IDIxICsrKysrKysrKysrKysr
KysrKysrKwo+ICAgMSBmaWxlIGNoYW5nZWQsIDIxIGluc2VydGlvbnMoKykKPgo+IGRpZmYgLS1n
aXQgYS9ody92aXJ0aW8vdmhvc3QtdmRwYS5jIGIvaHcvdmlydGlvL3Zob3N0LXZkcGEuYwo+IGlu
ZGV4IDg0YTZiOTY5MGIuLjlkMzBjZjliM2MgMTAwNjQ0Cj4gLS0tIGEvaHcvdmlydGlvL3Zob3N0
LXZkcGEuYwo+ICsrKyBiL2h3L3ZpcnRpby92aG9zdC12ZHBhLmMKPiBAQCAtNDQyLDYgKzQ0Miwy
NyBAQCBzdGF0aWMgaW50IHZob3N0X3ZkcGFfaW5pdChzdHJ1Y3Qgdmhvc3RfZGV2ICpkZXYsIHZv
aWQgKm9wYXF1ZSwgRXJyb3IgKiplcnJwKQo+ICAgICAgICAgICByZXR1cm4gMDsKPiAgICAgICB9
Cj4gICAKPiArICAgIC8qCj4gKyAgICAgKiBJZiBkZXYtPnNoYWRvd192cXNfZW5hYmxlZCBhdCBp
bml0aWFsaXphdGlvbiB0aGF0IG1lYW5zIHRoZSBkZXZpY2UgaGFzCj4gKyAgICAgKiBiZWVuIHN0
YXJ0ZWQgd2l0aCB4LXN2cT1vbiwgc28gZG9uJ3QgYmxvY2sgbWlncmF0aW9uCj4gKyAgICAgKi8K
PiArICAgIGlmIChkZXYtPm1pZ3JhdGlvbl9ibG9ja2VyID09IE5VTEwgJiYgIXYtPnNoYWRvd192
cXNfZW5hYmxlZCkgewo+ICsgICAgICAgIHVpbnQ2NF90IGJhY2tlbmRfZmVhdHVyZXM7Cj4gKwo+
ICsgICAgICAgIC8qIFdlIGRvbid0IGhhdmUgZGV2LT5iYWNrZW5kX2ZlYXR1cmVzIHlldCAqLwo+
ICsgICAgICAgIHJldCA9IHZob3N0X3ZkcGFfY2FsbChkZXYsIFZIT1NUX0dFVF9CQUNLRU5EX0ZF
QVRVUkVTLAo+ICsgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAmYmFja2VuZF9mZWF0dXJl
cyk7Cj4gKyAgICAgICAgaWYgKHVubGlrZWx5KHJldCkpIHsKPiArICAgICAgICAgICAgZXJyb3Jf
c2V0Z19lcnJubyhlcnJwLCAtcmV0LCAiQ291bGQgbm90IGdldCBiYWNrZW5kIGZlYXR1cmVzIik7
Cj4gKyAgICAgICAgICAgIHJldHVybiByZXQ7Cj4gKyAgICAgICAgfQo+ICsKPiArICAgICAgICBp
ZiAoIShiYWNrZW5kX2ZlYXR1cmVzICYgQklUX1VMTChWSE9TVF9CQUNLRU5EX0ZfU1VTUEVORCkp
KSB7Cj4gKyAgICAgICAgICAgIGVycm9yX3NldGcoJmRldi0+bWlncmF0aW9uX2Jsb2NrZXIsCj4g
KyAgICAgICAgICAgICAgICAidmhvc3QtdmRwYSBiYWNrZW5kIGxhY2tzIFZIT1NUX0JBQ0tFTkRf
Rl9TVVNQRU5EIGZlYXR1cmUuIik7Cj4gKyAgICAgICAgfQoKCkkgd29uZGVyIHdoeSBub3QgbGV0
IHRoZSBkZXZpY2UgdG8gZGVjaWRlPyBGb3IgbmV0d29ya2luZyBkZXZpY2UsIHdlIGNhbiAKbGl2
ZSB3aXRob3V0IHN1c3BlbmQgcHJvYmFibHkuCgpUaGFua3MKCgo+ICsgICAgfQo+ICsKPiAgICAg
ICAvKgo+ICAgICAgICAqIFNpbWlsYXIgdG8gVkZJTywgd2UgZW5kIHVwIHBpbm5pbmcgYWxsIGd1
ZXN0IG1lbW9yeSBhbmQgaGF2ZSB0bwo+ICAgICAgICAqIGRpc2FibGUgZGlzY2FyZGluZyBvZiBS
QU0uCgpfX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fXwpWaXJ0
dWFsaXphdGlvbiBtYWlsaW5nIGxpc3QKVmlydHVhbGl6YXRpb25AbGlzdHMubGludXgtZm91bmRh
dGlvbi5vcmcKaHR0cHM6Ly9saXN0cy5saW51eGZvdW5kYXRpb24ub3JnL21haWxtYW4vbGlzdGlu
Zm8vdmlydHVhbGl6YXRpb24=
