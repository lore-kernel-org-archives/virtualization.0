Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0ED48C001E0
	for <virtualization@archiver.kernel.org>; Fri, 28 Jul 2023 01:42:21 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 82C51840CE;
	Fri, 28 Jul 2023 01:42:21 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 82C51840CE
Authentication-Results: smtp1.osuosl.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=UMwHKDls
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
	by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id eRCSBMZWCVB7; Fri, 28 Jul 2023 01:42:20 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp1.osuosl.org (Postfix) with ESMTPS id E3873840CC;
	Fri, 28 Jul 2023 01:42:19 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org E3873840CC
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id C4047C0071;
	Fri, 28 Jul 2023 01:42:19 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [IPv6:2605:bc80:3010::136])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 941DEC0032
 for <virtualization@lists.linux-foundation.org>;
 Fri, 28 Jul 2023 01:42:18 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id 6E752613F4
 for <virtualization@lists.linux-foundation.org>;
 Fri, 28 Jul 2023 01:42:18 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 6E752613F4
Authentication-Results: smtp3.osuosl.org;
 dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com
 header.a=rsa-sha256 header.s=mimecast20190719 header.b=UMwHKDls
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id BBSR0Bh99lSd
 for <virtualization@lists.linux-foundation.org>;
 Fri, 28 Jul 2023 01:42:17 +0000 (UTC)
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.129.124])
 by smtp3.osuosl.org (Postfix) with ESMTPS id 930B660F42
 for <virtualization@lists.linux-foundation.org>;
 Fri, 28 Jul 2023 01:42:17 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 930B660F42
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1690508536;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=+B8/dh9FxUlYlsfj6c2Az3RVvE6Mk5Zpo699JVAL0Us=;
 b=UMwHKDlslEQWY9M18GWYcrbTWsRxHTNF2bc625u8o2KoE13P6roxTkFhRYjWuTADbSDliB
 PL2B0jI/GcCzMzE9gtJoGtTCKSM2a4lj6jtNnQPE5/Ud6xBUfmagnHlHIR+iqeaD2ePO9B
 ZiLdw87d0eR8oZL/BmNbZx0RTJgK5a8=
Received: from mail-lf1-f69.google.com (mail-lf1-f69.google.com
 [209.85.167.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-663-LVLc0q4eNmWW1Qbig4taUw-1; Thu, 27 Jul 2023 21:42:12 -0400
X-MC-Unique: LVLc0q4eNmWW1Qbig4taUw-1
Received: by mail-lf1-f69.google.com with SMTP id
 2adb3069b0e04-4f76712f950so1420232e87.0
 for <virtualization@lists.linux-foundation.org>;
 Thu, 27 Jul 2023 18:42:12 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1690508531; x=1691113331;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=+B8/dh9FxUlYlsfj6c2Az3RVvE6Mk5Zpo699JVAL0Us=;
 b=HNb7sccGk5leYnEAtIKF3aBD9/Yq0OLBgA7cr5rFreoyttz67EYov5W2DB8aaciy08
 pRkveQCdZ+VHlj0a6n/Lv8A37/5qEX5VXLYoXaj9WYeLf5RNu4aFHhQzlFULG2MgJ33e
 7VULLXdxtYZcQ+qOxH4iUaczeyfK5QOZmhSV/HEZrmMYHFrQRq0W3JpEPBYa2RgyAyH2
 vhVi0ihpQxFtfDgPZrHmzbARvPV5kv8UHN97oN+NgfP8xFUu1P6TVS7PYxQKRa2S2RZN
 SmoFookg2h9GHDzuIl9x5aDxxf38gujl4gFOWZd1TqJaUbZc9xA4GdfZcsTJI6BlFpBS
 JX8Q==
X-Gm-Message-State: ABy/qLYVFvKo0xdCneiY4uqXeA1wRBhV6ALPtXQxhm7YmJPdKtYLocz0
 hhUay4iIywyIIwwD32GrDls83zBhNsHKoePpRO1RRg9iDiWPmQfSm8jAs7JJyOOC45pAvUId6LY
 NVOGv1v85slacih/I813ZQBeKq5ackdKS3MFhGU2Nimdfhqkl4NVtsDWU1g==
X-Received: by 2002:a05:6512:1591:b0:4fb:893e:8ffc with SMTP id
 bp17-20020a056512159100b004fb893e8ffcmr676874lfb.17.1690508531487; 
 Thu, 27 Jul 2023 18:42:11 -0700 (PDT)
X-Google-Smtp-Source: APBJJlHY6/ERBGZV6AEAlBJS5xI4dIRaHz1bMCv6qrVkYLdcfZ1S0GvRrifqu9u3Yc1vreyW0L0NNEbcznbuvGQrl6o=
X-Received: by 2002:a05:6512:1591:b0:4fb:893e:8ffc with SMTP id
 bp17-20020a056512159100b004fb893e8ffcmr676854lfb.17.1690508531188; Thu, 27
 Jul 2023 18:42:11 -0700 (PDT)
MIME-Version: 1.0
References: <20230725130709.58207-1-gavinl@nvidia.com>
 <20230725130709.58207-3-gavinl@nvidia.com>
 <f5823996fffad2f3c1862917772c182df74c74e7.camel@redhat.com>
In-Reply-To: <f5823996fffad2f3c1862917772c182df74c74e7.camel@redhat.com>
From: Jason Wang <jasowang@redhat.com>
Date: Fri, 28 Jul 2023 09:42:00 +0800
Message-ID: <CACGkMEs4wUh0TydcXSMR2GdBSTk+H-Tkbhn53BywEeiK9cA9Gg@mail.gmail.com>
Subject: Re: [PATCH net-next V4 2/3] virtio_net: support per queue interrupt
 coalesce command
To: Paolo Abeni <pabeni@redhat.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Cc: xuanzhuo@linux.alibaba.com, linux-kernel@vger.kernel.org, hawk@kernel.org,
 daniel@iogearbox.net, mst@redhat.com, netdev@vger.kernel.org,
 john.fastabend@gmail.com, ast@kernel.org, gavi@nvidia.com, edumazet@google.com,
 Heng Qi <hengqi@linux.alibaba.com>, jiri@nvidia.com, kuba@kernel.org,
 bpf@vger.kernel.org, virtualization@lists.linux-foundation.org,
 davem@davemloft.net, Gavin Li <gavinl@nvidia.com>
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

T24gVGh1LCBKdWwgMjcsIDIwMjMgYXQgOToyOOKAr1BNIFBhb2xvIEFiZW5pIDxwYWJlbmlAcmVk
aGF0LmNvbT4gd3JvdGU6Cj4KPiBPbiBUdWUsIDIwMjMtMDctMjUgYXQgMTY6MDcgKzAzMDAsIEdh
dmluIExpIHdyb3RlOgo+ID4gQWRkIGludGVycnVwdF9jb2FsZXNjZSBjb25maWcgaW4gc2VuZF9x
dWV1ZSBhbmQgcmVjZWl2ZV9xdWV1ZSB0byBjYWNoZSB1c2VyCj4gPiBjb25maWcuCj4gPgo+ID4g
U2VuZCBwZXIgdmlydHF1ZXVlIGludGVycnVwdCBtb2RlcmF0aW9uIGNvbmZpZyB0byB1bmRlcmx5
aW5nIGRldmljZSBpbgo+ID4gb3JkZXIgdG8gaGF2ZSBtb3JlIGVmZmljaWVudCBpbnRlcnJ1cHQg
bW9kZXJhdGlvbiBhbmQgY3B1IHV0aWxpemF0aW9uIG9mCj4gPiBndWVzdCBWTS4KPiA+Cj4gPiBB
ZGRpdGlvbmFsbHksIGFkZHJlc3MgYWxsIHRoZSBWUXMgd2hlbiB1cGRhdGluZyB0aGUgZ2xvYmFs
IGNvbmZpZ3VyYXRpb24sCj4gPiBhcyBub3cgdGhlIGluZGl2aWR1YWwgVlFzIGNvbmZpZ3VyYXRp
b24gY2FuIGRpdmVyZ2UgZnJvbSB0aGUgZ2xvYmFsCj4gPiBjb25maWd1cmF0aW9uLgo+ID4KPiA+
IFNpZ25lZC1vZmYtYnk6IEdhdmluIExpIDxnYXZpbmxAbnZpZGlhLmNvbT4KPiA+IFJldmlld2Vk
LWJ5OiBEcmFnb3MgVGF0dWxlYSA8ZHRhdHVsZWFAbnZpZGlhLmNvbT4KPiA+IFJldmlld2VkLWJ5
OiBKaXJpIFBpcmtvIDxqaXJpQG52aWRpYS5jb20+Cj4gPiBBY2tlZC1ieTogTWljaGFlbCBTLiBU
c2lya2luIDxtc3RAcmVkaGF0LmNvbT4KPgo+IEZUUiwgdGhpcyBwYXRjaCBpcyBzaWduaWZpY2Fu
dGx5IGRpZmZlcmVudCBmcm9tIHRoZSB2ZXJzaW9uIHByZXZpb3VzbHkKPiBhY2tlZC9yZXZpZXdl
ZCwgSSdtIHVuc3VyZSBpZiBhbGwgdGhlIHJldmlld2VycyBhcmUgb2sgd2l0aCB0aGUgbmV3Cj4g
b25lLgoKR29vZCBwb2ludCwgYW5kIEkgcGxhbiB0byByZXZpZXcgdGhpcyBubyBsYXRlciB0aGFu
IG5leHQgTW9uZGF5IGFuZApvZmZlciBteSBhY2sgaWYgbmVjZXNzYXJ5LiBQbGVhc2UgaG9sZCB0
aGlzIHNlcmllcyBub3cuCgpUaGFua3MKCj4KPiBbLi4uXQo+Cj4gPiAgc3RhdGljIGludCB2aXJ0
bmV0X3NldF9jb2FsZXNjZShzdHJ1Y3QgbmV0X2RldmljZSAqZGV2LAo+ID4gICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgc3RydWN0IGV0aHRvb2xfY29hbGVzY2UgKmVjLAo+ID4gICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgc3RydWN0IGtlcm5lbF9ldGh0b29sX2NvYWxlc2NlICpr
ZXJuZWxfY29hbCwKPiA+ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgIHN0cnVjdCBuZXRs
aW5rX2V4dF9hY2sgKmV4dGFjaykKPiA+ICB7Cj4gPiAgICAgICBzdHJ1Y3QgdmlydG5ldF9pbmZv
ICp2aSA9IG5ldGRldl9wcml2KGRldik7Cj4gPiAtICAgICBpbnQgcmV0LCBpLCBuYXBpX3dlaWdo
dDsKPiA+ICsgICAgIGludCByZXQsIHF1ZXVlX251bWJlciwgbmFwaV93ZWlnaHQ7Cj4gPiAgICAg
ICBib29sIHVwZGF0ZV9uYXBpID0gZmFsc2U7Cj4gPgo+ID4gICAgICAgLyogQ2FuJ3QgY2hhbmdl
IE5BUEkgd2VpZ2h0IGlmIHRoZSBsaW5rIGlzIHVwICovCj4gPiAgICAgICBuYXBpX3dlaWdodCA9
IGVjLT50eF9tYXhfY29hbGVzY2VkX2ZyYW1lcyA/IE5BUElfUE9MTF9XRUlHSFQgOiAwOwo+ID4g
LSAgICAgaWYgKG5hcGlfd2VpZ2h0IF4gdmktPnNxWzBdLm5hcGkud2VpZ2h0KSB7Cj4gPiAtICAg
ICAgICAgICAgIGlmIChkZXYtPmZsYWdzICYgSUZGX1VQKQo+ID4gLSAgICAgICAgICAgICAgICAg
ICAgIHJldHVybiAtRUJVU1k7Cj4gPiAtICAgICAgICAgICAgIGVsc2UKPiA+IC0gICAgICAgICAg
ICAgICAgICAgICB1cGRhdGVfbmFwaSA9IHRydWU7Cj4gPiArICAgICBmb3IgKHF1ZXVlX251bWJl
ciA9IDA7IHF1ZXVlX251bWJlciA8IHZpLT5tYXhfcXVldWVfcGFpcnM7IHF1ZXVlX251bWJlcisr
KSB7Cj4gPiArICAgICAgICAgICAgIHJldCA9IHZpcnRuZXRfc2hvdWxkX3VwZGF0ZV92cV93ZWln
aHQoZGV2LT5mbGFncywgbmFwaV93ZWlnaHQsCj4gPiArICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgdmktPnNxW3F1ZXVlX251bWJlcl0ubmFwaS53ZWln
aHQsCj4gPiArICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgJnVwZGF0ZV9uYXBpKTsKPiA+ICsgICAgICAgICAgICAgaWYgKHJldCkKPiA+ICsgICAgICAg
ICAgICAgICAgICAgICByZXR1cm4gcmV0Owo+ID4gKwo+ID4gKyAgICAgICAgICAgICBpZiAodXBk
YXRlX25hcGkpIHsKPiA+ICsgICAgICAgICAgICAgICAgICAgICAvKiBBbGwgcXVldWVzIHRoYXQg
YmVsb25nIHRvIFtxdWV1ZV9udW1iZXIsIHF1ZXVlX2NvdW50XSB3aWxsIGJlCj4gPiArICAgICAg
ICAgICAgICAgICAgICAgICogdXBkYXRlZCBmb3IgdGhlIHNha2Ugb2Ygc2ltcGxpY2l0eSwgd2hp
Y2ggbWlnaHQgbm90IGJlIG5lY2Vzc2FyeQo+Cj4gSXQgbG9va3MgbGlrZSB0aGUgY29tbWVudCBh
Ym92ZSBzdGlsbCByZWZlcnMgdG8gdGhlIG9sZCBjb2RlLiBTaG91bGQKPiBiZToKPiAgICAgICAg
IFtxdWV1ZV9udW1iZXIsIHZpLT5tYXhfcXVldWVfcGFpcnNdCj4KPiBPdGhlcndpc2UgTEdUTSwg
dGhhbmtzIQo+Cj4gUGFvbG8KPgoKX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX18KVmlydHVhbGl6YXRpb24gbWFpbGluZyBsaXN0ClZpcnR1YWxpemF0aW9uQGxp
c3RzLmxpbnV4LWZvdW5kYXRpb24ub3JnCmh0dHBzOi8vbGlzdHMubGludXhmb3VuZGF0aW9uLm9y
Zy9tYWlsbWFuL2xpc3RpbmZvL3ZpcnR1YWxpemF0aW9u
