Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8408AE7D0C3
	for <virtualization@archiver.kernel.org>; Fri, 22 Sep 2023 03:12:04 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp2.osuosl.org (Postfix) with ESMTP id 24D4A40154;
	Fri, 22 Sep 2023 03:12:04 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org 24D4A40154
Authentication-Results: smtp2.osuosl.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=R5beuRy1
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
	by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id 4t1DvH7LtT5K; Fri, 22 Sep 2023 03:12:03 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp2.osuosl.org (Postfix) with ESMTPS id B511A40278;
	Fri, 22 Sep 2023 03:12:02 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org B511A40278
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 84870C0071;
	Fri, 22 Sep 2023 03:12:02 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by lists.linuxfoundation.org (Postfix) with ESMTP id EBDC1C0032
 for <virtualization@lists.linux-foundation.org>;
 Fri, 22 Sep 2023 03:12:01 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id B8FE440278
 for <virtualization@lists.linux-foundation.org>;
 Fri, 22 Sep 2023 03:12:01 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org B8FE440278
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id oP88flgOIfj0
 for <virtualization@lists.linux-foundation.org>;
 Fri, 22 Sep 2023 03:11:59 +0000 (UTC)
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.133.124])
 by smtp2.osuosl.org (Postfix) with ESMTPS id E648F40154
 for <virtualization@lists.linux-foundation.org>;
 Fri, 22 Sep 2023 03:11:58 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org E648F40154
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1695352317;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=GGvCxDRGdBW7AEbyfXuG9iI8Crk1BrmovItky/Bus/E=;
 b=R5beuRy150zZKnOaVjNcyoAccvsdE0os2VPFTz7xoXCCKDvZUWXc4IGZv2RKhld7Qo1s4o
 54jR8GEIn3tlzBwy/koyH0MIU1lXKYOkBGbcvFjPwmech5rIWBU83/EbV2NZEIHq3EiUu6
 sUsKkcXIbuVdytxviTdikzchgV4e2nE=
Received: from mail-lf1-f69.google.com (mail-lf1-f69.google.com
 [209.85.167.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-274-o4LJwiIoOMehGandRo2OTg-1; Thu, 21 Sep 2023 23:11:53 -0400
X-MC-Unique: o4LJwiIoOMehGandRo2OTg-1
Received: by mail-lf1-f69.google.com with SMTP id
 2adb3069b0e04-50335ee6011so2084605e87.0
 for <virtualization@lists.linux-foundation.org>;
 Thu, 21 Sep 2023 20:11:53 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1695352312; x=1695957112;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=GGvCxDRGdBW7AEbyfXuG9iI8Crk1BrmovItky/Bus/E=;
 b=UroRov3iQ1r7UjWscUtltSt897sn32LWJaaZypzf3xI3hrWoOrEg5xmjoN6pxg0ahM
 F0IXogjnBq2lyQ7s3UGYWdCi+FK919YExhMye6oHXmu87b3DGphyC5BLzshLTdulUCMs
 rxLq16Uig6mFVJtBevVQlaRrbguVtQTy5kxAV7HQXk2zZobiI2JZJ/LWBPJDdcWtmSgi
 pJr2kmgxDC7LNM3l4GE5PAfbrUUj9GM7OLgudBZDZGv41lXDZG5k62C1phJeNRdn6GWh
 yw+nPIY35pilQVEthwBecPKL+fTtfT2d1TEwrq/LwMnml9TM1iTlKQQNZofWW37hthCT
 qOkQ==
X-Gm-Message-State: AOJu0YxCOLRPypT1mMceI9Fao8uaTOPJbS2vsm2Sfja1WFBUJXBno4Jx
 h4wOYVaiv52PQEDLYFQtzwkhzyzhGJl2lLnTwYmkZ/nA4Sz/lexZOPUfUIM7WudNCNlx92pMc0Y
 J7XNW8apJwFJdSKYr0nCDybWfP5W4L2BkaRSPjcvl+Dq8axGWdgAAgoC4Sg==
X-Received: by 2002:a19:384b:0:b0:4fd:c715:5667 with SMTP id
 d11-20020a19384b000000b004fdc7155667mr5363831lfj.20.1695352312411; 
 Thu, 21 Sep 2023 20:11:52 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFkymRIIEUVWlRbuHxN0yBKASxkd+Z2oy0DIa8UmIa3FFJ/1HeC5Ha4S/ar47CxuUyt7WovwFgE/wDkT4t/Ycg=
X-Received: by 2002:a19:384b:0:b0:4fd:c715:5667 with SMTP id
 d11-20020a19384b000000b004fdc7155667mr5363817lfj.20.1695352312093; Thu, 21
 Sep 2023 20:11:52 -0700 (PDT)
MIME-Version: 1.0
References: <20230919074915.103110-1-hengqi@linux.alibaba.com>
 <20230919074915.103110-3-hengqi@linux.alibaba.com>
In-Reply-To: <20230919074915.103110-3-hengqi@linux.alibaba.com>
From: Jason Wang <jasowang@redhat.com>
Date: Fri, 22 Sep 2023 11:11:41 +0800
Message-ID: <CACGkMEuSFMSx5GXzw+MFnF7yqaEG3mKpRt1Ohd3aTJDsv6rsGg@mail.gmail.com>
Subject: Re: [PATCH net 2/6] virtio-net: fix mismatch of getting tx-frames
To: Heng Qi <hengqi@linux.alibaba.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Cc: Xuan Zhuo <xuanzhuo@linux.alibaba.com>,
 Jesper Dangaard Brouer <hawk@kernel.org>,
 Daniel Borkmann <daniel@iogearbox.net>, "Michael S . Tsirkin" <mst@redhat.com>,
 netdev@vger.kernel.org, John Fastabend <john.fastabend@gmail.com>,
 Alexei Starovoitov <ast@kernel.org>, virtualization@lists.linux-foundation.org,
 Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>,
 Paolo Abeni <pabeni@redhat.com>, "David S . Miller" <davem@davemloft.net>,
 Gavin Li <gavinl@nvidia.com>
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

T24gVHVlLCBTZXAgMTksIDIwMjMgYXQgMzo0OeKAr1BNIEhlbmcgUWkgPGhlbmdxaUBsaW51eC5h
bGliYWJhLmNvbT4gd3JvdGU6Cj4KPiBTaW5jZSB2aXJ0aW8tbmV0IGFsbG93cyBzd2l0Y2hpbmcg
bmFwaV90eCBmb3IgcGVyIHR4cSwgd2UgaGF2ZSB0bwo+IGdldCB0aGUgc3BlY2lmaWMgdHhxJ3Mg
cmVzdWx0IG5vdy4KPgo+IEZpeGVzOiAzOTRiZDg3NzY0YjYgKCJ2aXJ0aW9fbmV0OiBzdXBwb3J0
IHBlciBxdWV1ZSBpbnRlcnJ1cHQgY29hbGVzY2UgY29tbWFuZCIpCj4gQ2M6IEdhdmluIExpIDxn
YXZpbmxAbnZpZGlhLmNvbT4KPiBTaWduZWQtb2ZmLWJ5OiBIZW5nIFFpIDxoZW5ncWlAbGludXgu
YWxpYmFiYS5jb20+CgpBY2tlZC1ieTogSmFzb24gV2FuZyA8amFzb3dhbmdAcmVkaGF0LmNvbT4K
ClRoYW5rcwoKPiAtLS0KPiAgZHJpdmVycy9uZXQvdmlydGlvX25ldC5jIHwgMiArLQo+ICAxIGZp
bGUgY2hhbmdlZCwgMSBpbnNlcnRpb24oKyksIDEgZGVsZXRpb24oLSkKPgo+IGRpZmYgLS1naXQg
YS9kcml2ZXJzL25ldC92aXJ0aW9fbmV0LmMgYi9kcml2ZXJzL25ldC92aXJ0aW9fbmV0LmMKPiBp
bmRleCBmZDViYzhkNTllZGEuLjgwZDM1YTg2NDc5MCAxMDA2NDQKPiAtLS0gYS9kcml2ZXJzL25l
dC92aXJ0aW9fbmV0LmMKPiArKysgYi9kcml2ZXJzL25ldC92aXJ0aW9fbmV0LmMKPiBAQCAtMzQ1
Myw3ICszNDUzLDcgQEAgc3RhdGljIGludCB2aXJ0bmV0X2dldF9wZXJfcXVldWVfY29hbGVzY2Uo
c3RydWN0IG5ldF9kZXZpY2UgKmRldiwKPiAgICAgICAgIH0gZWxzZSB7Cj4gICAgICAgICAgICAg
ICAgIGVjLT5yeF9tYXhfY29hbGVzY2VkX2ZyYW1lcyA9IDE7Cj4KPiAtICAgICAgICAgICAgICAg
aWYgKHZpLT5zcVswXS5uYXBpLndlaWdodCkKPiArICAgICAgICAgICAgICAgaWYgKHZpLT5zcVtx
dWV1ZV0ubmFwaS53ZWlnaHQpCj4gICAgICAgICAgICAgICAgICAgICAgICAgZWMtPnR4X21heF9j
b2FsZXNjZWRfZnJhbWVzID0gMTsKPiAgICAgICAgIH0KPgo+IC0tCj4gMi4xOS4xLjYuZ2I0ODU3
MTBiCj4KCl9fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fClZp
cnR1YWxpemF0aW9uIG1haWxpbmcgbGlzdApWaXJ0dWFsaXphdGlvbkBsaXN0cy5saW51eC1mb3Vu
ZGF0aW9uLm9yZwpodHRwczovL2xpc3RzLmxpbnV4Zm91bmRhdGlvbi5vcmcvbWFpbG1hbi9saXN0
aW5mby92aXJ0dWFsaXphdGlvbg==
