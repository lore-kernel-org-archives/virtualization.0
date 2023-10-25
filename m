Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C671AC0032E
	for <virtualization@archiver.kernel.org>; Wed, 25 Oct 2023 05:50:53 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 4B444707E2;
	Wed, 25 Oct 2023 05:50:53 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 4B444707E2
Authentication-Results: smtp3.osuosl.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=DqjJxEOT
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
	by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id ht1jz2H2ERAw; Wed, 25 Oct 2023 05:50:52 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp3.osuosl.org (Postfix) with ESMTPS id C536D6FCC8;
	Wed, 25 Oct 2023 05:50:51 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org C536D6FCC8
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 9B6E5C0039;
	Wed, 25 Oct 2023 05:50:51 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [IPv6:2605:bc80:3010::137])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 334E7C0032
 for <virtualization@lists.linux-foundation.org>;
 Wed, 25 Oct 2023 05:50:50 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id 0E4FA45F1D
 for <virtualization@lists.linux-foundation.org>;
 Wed, 25 Oct 2023 05:50:50 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org 0E4FA45F1D
Authentication-Results: smtp4.osuosl.org;
 dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com
 header.a=rsa-sha256 header.s=mimecast20190719 header.b=DqjJxEOT
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id wPDbrGBTmWwH
 for <virtualization@lists.linux-foundation.org>;
 Wed, 25 Oct 2023 05:50:49 +0000 (UTC)
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.133.124])
 by smtp4.osuosl.org (Postfix) with ESMTPS id 3BC2B43881
 for <virtualization@lists.linux-foundation.org>;
 Wed, 25 Oct 2023 05:50:49 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org 3BC2B43881
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1698213048;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=3KN+e0aKFNbM4E73v4YilopHI48/pLEXBGl/D/hXMGQ=;
 b=DqjJxEOTSpuDX6dSiZovjOKXN+2jlZq5Vt6utqIN3nlygSTYrE1JdHIe5YfCSUWB0XcDMN
 cYvV8ZTOt2mUv8qdCBefTU4Sv4HkAs4eXoSSpRA/7r5oT1i9ZzLxYs9Lo18oFMSbxe3jTK
 YDLSfd0npQW8Z2JQniKUIOOGmjXmpzo=
Received: from mail-lf1-f69.google.com (mail-lf1-f69.google.com
 [209.85.167.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-252-sXSpNaBuOUaLxGfAWVNuxg-1; Wed, 25 Oct 2023 01:50:46 -0400
X-MC-Unique: sXSpNaBuOUaLxGfAWVNuxg-1
Received: by mail-lf1-f69.google.com with SMTP id
 2adb3069b0e04-507b8ac8007so5444480e87.0
 for <virtualization@lists.linux-foundation.org>;
 Tue, 24 Oct 2023 22:50:46 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1698213045; x=1698817845;
 h=in-reply-to:content-transfer-encoding:content-disposition
 :mime-version:references:message-id:subject:cc:to:from:date
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=3KN+e0aKFNbM4E73v4YilopHI48/pLEXBGl/D/hXMGQ=;
 b=KoQ+4JzMBlkZ4X+GqJnxVdfw7UngJMQOjn40KAK242QlZUQvVtpHxpbz789nPJIQaI
 l90c2WSD17POMHIj0yPj0c+5jJLd4EGAizv+i8DtGaWNtg0CgInqV2vdE7DHmkFAxA0R
 Ly9sUJVyjir9iLQp/8cVXSlIvXV8nT8X11cfA8lmvIUv+kYFx268s0Xp5qIVZ3t+Uxgr
 LVE7iByoyxLChRXn/Y1soQxP7g0+Kh4knuxAhIC8UTDSAqJ6iSZs/MwFi175+XGNrKgP
 0lPR4A7487619UnHxUjBC8ixU8ibLhXd/VdghhenQnaz0+0DUPwRwybXAbkNf7ef7Mhs
 Tb7w==
X-Gm-Message-State: AOJu0YyETRne81jjlGTYxavP5W3WejdJjqQ5aHxD2EXxKYjXPPghJwth
 Y16fv4c6yKSRxnrlUbx3YiVudoOFmNuWpdv+FLPmdmvJx8WB414CEvWyDXtiwAF2nmBttXXyXRP
 8bawFmyTUCU6zCmLn8IWnRArWhBcafjqEkSYi2y7iDQ==
X-Received: by 2002:a05:6512:3b24:b0:507:aaab:528c with SMTP id
 f36-20020a0565123b2400b00507aaab528cmr11969639lfv.69.1698213044999; 
 Tue, 24 Oct 2023 22:50:44 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHiaNI7qJmDAB2WipmOi0kcNvRZGBxrxZ2hGGyvWUwDJK/OYH7pxYf0DotRVB2vb5H3kAEqTg==
X-Received: by 2002:a05:6512:3b24:b0:507:aaab:528c with SMTP id
 f36-20020a0565123b2400b00507aaab528cmr11969627lfv.69.1698213044625; 
 Tue, 24 Oct 2023 22:50:44 -0700 (PDT)
Received: from redhat.com ([2a02:14f:1f1:7547:f72e:6bd0:1eb2:d4b5])
 by smtp.gmail.com with ESMTPSA id
 g14-20020a05600c310e00b0040813e14b49sm18483798wmo.30.2023.10.24.22.50.41
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 24 Oct 2023 22:50:43 -0700 (PDT)
Date: Wed, 25 Oct 2023 01:50:38 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Jason Wang <jasowang@redhat.com>
Subject: Re: [PATCH net-next 5/5] virtio-net: support tx netdim
Message-ID: <20231025015010-mutt-send-email-mst@kernel.org>
References: <cover.1697093455.git.hengqi@linux.alibaba.com>
 <ef5d159875745040e406473bd5c03e9875742ff5.1697093455.git.hengqi@linux.alibaba.com>
 <CACGkMEuX+kJ8G2CitnACVgx_OSsdbtedD+dvXJ_REFdwzx56Vg@mail.gmail.com>
MIME-Version: 1.0
In-Reply-To: <CACGkMEuX+kJ8G2CitnACVgx_OSsdbtedD+dvXJ_REFdwzx56Vg@mail.gmail.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Disposition: inline
Cc: Xuan Zhuo <xuanzhuo@linux.alibaba.com>, "Liu, Yujie" <yujie.liu@intel.com>,
 Jesper Dangaard Brouer <hawk@kernel.org>, netdev@vger.kernel.org,
 John Fastabend <john.fastabend@gmail.com>, Alexei Starovoitov <ast@kernel.org>,
 virtualization@lists.linux-foundation.org, Eric Dumazet <edumazet@google.com>,
 Heng Qi <hengqi@linux.alibaba.com>, Simon Horman <horms@kernel.org>,
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
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

T24gV2VkLCBPY3QgMjUsIDIwMjMgYXQgMTE6MzU6NDNBTSArMDgwMCwgSmFzb24gV2FuZyB3cm90
ZToKPiBPbiBUaHUsIE9jdCAxMiwgMjAyMyBhdCAzOjQ04oCvUE0gSGVuZyBRaSA8aGVuZ3FpQGxp
bnV4LmFsaWJhYmEuY29tPiB3cm90ZToKPiA+Cj4gPiBTaW1pbGFyIHRvIHJ4IG5ldGRpbSwgdGhp
cyBwYXRjaCBzdXBwb3J0cyBhZGFwdGl2ZSB0eAo+ID4gY29hbGVzY2luZyBtb2RlcmF0aW9uIGZv
ciB0aGUgdmlydGlvLW5ldC4KPiA+Cj4gPiBTaWduZWQtb2ZmLWJ5OiBIZW5nIFFpIDxoZW5ncWlA
bGludXguYWxpYmFiYS5jb20+Cj4gPiAtLS0KPiA+ICBkcml2ZXJzL25ldC92aXJ0aW9fbmV0LmMg
fCAxNDMgKysrKysrKysrKysrKysrKysrKysrKysrKysrKysrKystLS0tLS0tCj4gPiAgMSBmaWxl
IGNoYW5nZWQsIDExOSBpbnNlcnRpb25zKCspLCAyNCBkZWxldGlvbnMoLSkKPiA+Cj4gPiBkaWZm
IC0tZ2l0IGEvZHJpdmVycy9uZXQvdmlydGlvX25ldC5jIGIvZHJpdmVycy9uZXQvdmlydGlvX25l
dC5jCj4gPiBpbmRleCA2YWQyODkwYTc5MDkuLjFjNjgwY2IwOWQ0OCAxMDA2NDQKPiA+IC0tLSBh
L2RyaXZlcnMvbmV0L3ZpcnRpb19uZXQuYwo+ID4gKysrIGIvZHJpdmVycy9uZXQvdmlydGlvX25l
dC5jCj4gPiBAQCAtMTU0LDYgKzE1NCwxNSBAQCBzdHJ1Y3Qgc2VuZF9xdWV1ZSB7Cj4gPgo+ID4g
ICAgICAgICBzdHJ1Y3QgdmlydG5ldF9zcV9zdGF0cyBzdGF0czsKPiA+Cj4gPiArICAgICAgIC8q
IFRoZSBudW1iZXIgb2YgdHggbm90aWZpY2F0aW9ucyAqLwo+ID4gKyAgICAgICB1MTYgY2FsbHM7
Cj4gPiArCj4gPiArICAgICAgIC8qIElzIGR5bmFtaWMgaW50ZXJydXB0IG1vZGVyYXRpb24gZW5h
YmxlZD8gKi8KPiA+ICsgICAgICAgYm9vbCBkaW1fZW5hYmxlZDsKPiA+ICsKPiA+ICsgICAgICAg
LyogRHluYW1pYyBJbnRlcnJ1cHQgTW9kZXJhdGlvbiAqLwo+ID4gKyAgICAgICBzdHJ1Y3QgZGlt
IGRpbTsKPiA+ICsKPiA+ICAgICAgICAgc3RydWN0IHZpcnRuZXRfaW50ZXJydXB0X2NvYWxlc2Nl
IGludHJfY29hbDsKPiA+Cj4gPiAgICAgICAgIHN0cnVjdCBuYXBpX3N0cnVjdCBuYXBpOwo+ID4g
QEAgLTMxNyw4ICszMjYsOSBAQCBzdHJ1Y3QgdmlydG5ldF9pbmZvIHsKPiA+ICAgICAgICAgdTgg
ZHVwbGV4Owo+ID4gICAgICAgICB1MzIgc3BlZWQ7Cj4gPgo+ID4gLSAgICAgICAvKiBJcyByeCBk
eW5hbWljIGludGVycnVwdCBtb2RlcmF0aW9uIGVuYWJsZWQ/ICovCj4gPiArICAgICAgIC8qIElz
IGR5bmFtaWMgaW50ZXJydXB0IG1vZGVyYXRpb24gZW5hYmxlZD8gKi8KPiA+ICAgICAgICAgYm9v
bCByeF9kaW1fZW5hYmxlZDsKPiA+ICsgICAgICAgYm9vbCB0eF9kaW1fZW5hYmxlZDsKPiA+Cj4g
PiAgICAgICAgIC8qIEludGVycnVwdCBjb2FsZXNjaW5nIHNldHRpbmdzICovCj4gPiAgICAgICAg
IHN0cnVjdCB2aXJ0bmV0X2ludGVycnVwdF9jb2FsZXNjZSBpbnRyX2NvYWxfdHg7Cj4gPiBAQCAt
NDY0LDE5ICs0NzQsNDAgQEAgc3RhdGljIGJvb2wgdmlydHF1ZXVlX25hcGlfY29tcGxldGUoc3Ry
dWN0IG5hcGlfc3RydWN0ICpuYXBpLAo+ID4gICAgICAgICByZXR1cm4gZmFsc2U7Cj4gPiAgfQo+
ID4KPiA+ICtzdGF0aWMgdm9pZCB2aXJ0bmV0X3R4X2RpbV93b3JrKHN0cnVjdCB3b3JrX3N0cnVj
dCAqd29yayk7Cj4gPiArCj4gPiArc3RhdGljIHZvaWQgdmlydG5ldF90eF9kaW1fdXBkYXRlKHN0
cnVjdCB2aXJ0bmV0X2luZm8gKnZpLCBzdHJ1Y3Qgc2VuZF9xdWV1ZSAqc3EpCj4gPiArewo+ID4g
KyAgICAgICBzdHJ1Y3QgdmlydG5ldF9zcV9zdGF0cyAqc3RhdHMgPSAmc3EtPnN0YXRzOwo+ID4g
KyAgICAgICBzdHJ1Y3QgZGltX3NhbXBsZSBjdXJfc2FtcGxlID0ge307Cj4gPiArCj4gPiArICAg
ICAgIHU2NF9zdGF0c191cGRhdGVfYmVnaW4oJnNxLT5zdGF0cy5zeW5jcCk7Cj4gPiArICAgICAg
IGRpbV91cGRhdGVfc2FtcGxlKHNxLT5jYWxscywgc3RhdHMtPnBhY2tldHMsCj4gPiArICAgICAg
ICAgICAgICAgICAgICAgICAgIHN0YXRzLT5ieXRlcywgJmN1cl9zYW1wbGUpOwo+ID4gKyAgICAg
ICB1NjRfc3RhdHNfdXBkYXRlX2VuZCgmc3EtPnN0YXRzLnN5bmNwKTsKPiA+ICsKPiA+ICsgICAg
ICAgbmV0X2RpbSgmc3EtPmRpbSwgY3VyX3NhbXBsZSk7Cj4gPiArfQo+ID4gKwo+ID4gIHN0YXRp
YyB2b2lkIHNrYl94bWl0X2RvbmUoc3RydWN0IHZpcnRxdWV1ZSAqdnEpCj4gPiAgewo+ID4gICAg
ICAgICBzdHJ1Y3QgdmlydG5ldF9pbmZvICp2aSA9IHZxLT52ZGV2LT5wcml2Owo+ID4gLSAgICAg
ICBzdHJ1Y3QgbmFwaV9zdHJ1Y3QgKm5hcGkgPSAmdmktPnNxW3ZxMnR4cSh2cSldLm5hcGk7Cj4g
PiArICAgICAgIHN0cnVjdCBzZW5kX3F1ZXVlICpzcSA9ICZ2aS0+c3FbdnEydHhxKHZxKV07Cj4g
PiArICAgICAgIHN0cnVjdCBuYXBpX3N0cnVjdCAqbmFwaSA9ICZzcS0+bmFwaTsKPiA+ICsKPiA+
ICsgICAgICAgc3EtPmNhbGxzKys7Cj4gCj4gSSB3b25kZXIgd2hhdCdzIHRoZSBpbXBhY3Qgb2Yg
dGhpcyBjb3VudGVycyBmb3IgbmV0ZGltLiBBcyB3ZSBoYXZlIGEKPiBtb2RlIG9mIG9ycGhhbiBz
a2IgaW4geG1pdC4KPiAKPiBXZSBuZWVkIHRvIHRlc3QgdG8gc2VlLgo+IAo+IFRoYW5rcwoKQWdy
ZWVkLCBwZXJmb3JtYW5jZSBwYXRjaGVzIHNob3VsZCBjb21lIHdpdGggcGVyZm9ybWFuY2UgcmVz
dWx0cy4KCi0tIApNU1QKCl9fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fClZpcnR1YWxpemF0aW9uIG1haWxpbmcgbGlzdApWaXJ0dWFsaXphdGlvbkBsaXN0cy5s
aW51eC1mb3VuZGF0aW9uLm9yZwpodHRwczovL2xpc3RzLmxpbnV4Zm91bmRhdGlvbi5vcmcvbWFp
bG1hbi9saXN0aW5mby92aXJ0dWFsaXphdGlvbg==
