Return-Path: <SRS0=ZIIO=PN=lists.linux-foundation.org=virtualization-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 96624C433F5
	for <virtualization@archiver.kernel.org>; Mon, 25 Oct 2021 07:05:23 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 367F060F6F
	for <virtualization@archiver.kernel.org>; Mon, 25 Oct 2021 07:05:23 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org 367F060F6F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id E936F4036B;
	Mon, 25 Oct 2021 07:05:22 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
	by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id LU8nze57GZiJ; Mon, 25 Oct 2021 07:05:22 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp4.osuosl.org (Postfix) with ESMTPS id 8CDD940389;
	Mon, 25 Oct 2021 07:05:21 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 5F11AC0012;
	Mon, 25 Oct 2021 07:05:21 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [IPv6:2605:bc80:3010::138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 988A1C000E
 for <virtualization@lists.linux-foundation.org>;
 Mon, 25 Oct 2021 07:05:19 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id 7FDD980E00
 for <virtualization@lists.linux-foundation.org>;
 Mon, 25 Oct 2021 07:05:19 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp1.osuosl.org (amavisd-new);
 dkim=pass (1024-bit key) header.d=redhat.com
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id v6dgpDc6Ol7i
 for <virtualization@lists.linux-foundation.org>;
 Mon, 25 Oct 2021 07:05:18 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [216.205.24.124])
 by smtp1.osuosl.org (Postfix) with ESMTPS id B385C80DFC
 for <virtualization@lists.linux-foundation.org>;
 Mon, 25 Oct 2021 07:05:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1635145517;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=ZvhL7fVsKX8fea/Gx79fW0fdxI2SRkrG2IPhlvbI4u0=;
 b=QvLoyMypUp0vlZYsGz6Yf+U2823O4qKiwkqGYntV+tyR6EHu52TiTTweeAQkrSuPdNznoG
 ZCPP46ct8ojfrAxuSGYo872zjcjhfo1oKlygQIint1C4WYv9hZEqApFvXYg8Ja6DupR+Gk
 fsSK8BjNGWAzC2FM/Vo4a7t5T686pE8=
Received: from mail-pf1-f198.google.com (mail-pf1-f198.google.com
 [209.85.210.198]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-449-3sSi2riFP0icD3tvxYTs_A-1; Mon, 25 Oct 2021 03:05:15 -0400
X-MC-Unique: 3sSi2riFP0icD3tvxYTs_A-1
Received: by mail-pf1-f198.google.com with SMTP id
 m26-20020a62a21a000000b0041361973ba7so5940945pff.15
 for <virtualization@lists.linux-foundation.org>;
 Mon, 25 Oct 2021 00:05:15 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-transfer-encoding
 :content-language;
 bh=ZvhL7fVsKX8fea/Gx79fW0fdxI2SRkrG2IPhlvbI4u0=;
 b=4wm4JZo4sAqQTHaNQ6XNbXyqCmxDb2l/Ptp5UmsZKfeXVlbWC+yKqwLBq1rzlIm8Gy
 m3CGmRiqXnlti/ThTzw89fr5jaLL8lJcrRo5T9mdKz6NalAl0/vYul8DfUpY9IboVTp4
 W8170IvIf+Xqfm2xUI96ZeSYdumqW3kuNSjb99YYCStijF46lOXmPgcLfhkyvKddKRwb
 CSjr6ZVCx7vYxX3Dtj3oZRoOVCCWdoNb1y1MdUgRmtYXiTmh570yBtU++1kyu63crMNc
 unR9TYEK9P04jTSp4xXGhSJbJF865Kew1/VUwa3+R8+LEw7EoyDNj2YCGgx9gc6cYBev
 j8sw==
X-Gm-Message-State: AOAM533BS/4NO3RlPD9mvf423wVpUsUa/3h7mpt8MvI6eUNYaqII4iWp
 4tRUWkCXTYB9sru2pl4XIUxzGE/6Y8d+PzChFIg8lkMSQMlua/NK2ZAd4bGB9cMGMdoka4DrKHJ
 uW/MPwhewRfuP75d1mxyRth+fvqIDsnB5lft3G0Mp9A==
X-Received: by 2002:a17:902:db04:b0:13e:f118:54de with SMTP id
 m4-20020a170902db0400b0013ef11854demr15366479plx.44.1635145514495; 
 Mon, 25 Oct 2021 00:05:14 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJw2qzXb1uTx8Fw91VFvfqFWLJ8khAyYdn3zIhS0I9sLiUfUTxPKm/VNw0jQUBNTfaIAA0123g==
X-Received: by 2002:a17:902:db04:b0:13e:f118:54de with SMTP id
 m4-20020a170902db0400b0013ef11854demr15366450plx.44.1635145514160; 
 Mon, 25 Oct 2021 00:05:14 -0700 (PDT)
Received: from wangxiaodeMacBook-Air.local ([209.132.188.80])
 by smtp.gmail.com with ESMTPSA id g17sm14024635pfv.21.2021.10.25.00.05.12
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 25 Oct 2021 00:05:13 -0700 (PDT)
Subject: Re: [PATCH linux-next v4 6/8] vdpa/mlx5: Fix clearing of
 VIRTIO_NET_F_MAC feature bit
To: Parav Pandit <parav@nvidia.com>, virtualization@lists.linux-foundation.org
References: <20211021163509.6978-1-parav@nvidia.com>
 <20211021163509.6978-7-parav@nvidia.com>
From: Jason Wang <jasowang@redhat.com>
Message-ID: <53c1e41b-cac2-2419-9bd9-e40163e98dad@redhat.com>
Date: Mon, 25 Oct 2021 15:05:10 +0800
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:78.0)
 Gecko/20100101 Thunderbird/78.14.0
MIME-Version: 1.0
In-Reply-To: <20211021163509.6978-7-parav@nvidia.com>
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=jasowang@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Language: en-US
Cc: elic@nvidia.com, mst@redhat.com
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

CuWcqCAyMDIxLzEwLzIyIOS4iuWNiDEyOjM1LCBQYXJhdiBQYW5kaXQg5YaZ6YGTOgo+IENpdGVk
IHBhdGNoIGluIHRoZSBmaXhlcyB0YWcgY2xlYXJzIHRoZSBmZWF0dXJlcyBiaXQgZHVyaW5nIHJl
c2V0Lgo+IG1seDUgdmRwYSBkZXZpY2UgZmVhdHVyZSBiaXRzIGFyZSBzdGF0aWMgZGVjaWRlZCBi
eSBkZXZpY2UgY2FwYWJpbGl0aWVzLgoKClRoaXMgaXMgbm90IHdoYXQgSSByZWFkIGF0IGxlYXN0
IGZyb20gbWx4NV92ZHBhX2dldF9mZWF0dXJlczoKCnN0YXRpYyB1NjQgbWx4NV92ZHBhX2dldF9m
ZWF0dXJlcyhzdHJ1Y3QgdmRwYV9kZXZpY2UgKnZkZXYpCnsKIMKgwqDCoMKgwqDCoMKgIHN0cnVj
dCBtbHg1X3ZkcGFfZGV2ICptdmRldiA9IHRvX212ZGV2KHZkZXYpOwogwqDCoMKgwqDCoMKgwqAg
c3RydWN0IG1seDVfdmRwYV9uZXQgKm5kZXYgPSB0b19tbHg1X3ZkcGFfbmRldihtdmRldik7CiDC
oMKgwqDCoMKgwqDCoCB1MTYgZGV2X2ZlYXR1cmVzOwoKIMKgwqDCoMKgwqDCoMKgIGRldl9mZWF0
dXJlcyA9IE1MWDVfQ0FQX0RFVl9WRFBBX0VNVUxBVElPTihtdmRldi0+bWRldiwgCmRldmljZV9m
ZWF0dXJlc19iaXRzX21hc2spOwogwqDCoMKgwqDCoMKgwqAgbmRldi0+bXZkZXYubWx4X2ZlYXR1
cmVzIHw9IG1seF90b192cml0aW9fZmVhdHVyZXMoZGV2X2ZlYXR1cmVzKTsKIMKgwqDCoMKgwqDC
oMKgIGlmIChNTFg1X0NBUF9ERVZfVkRQQV9FTVVMQVRJT04obXZkZXYtPm1kZXYsIHZpcnRpb192
ZXJzaW9uXzFfMCkpCiDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqAgbmRldi0+bXZkZXYu
bWx4X2ZlYXR1cmVzIHw9IEJJVF9VTEwoVklSVElPX0ZfVkVSU0lPTl8xKTsKIMKgwqDCoMKgwqDC
oMKgIG5kZXYtPm12ZGV2Lm1seF9mZWF0dXJlcyB8PSBCSVRfVUxMKFZJUlRJT19GX0FDQ0VTU19Q
TEFURk9STSk7CiDCoMKgwqDCoMKgwqDCoCBuZGV2LT5tdmRldi5tbHhfZmVhdHVyZXMgfD0gQklU
X1VMTChWSVJUSU9fTkVUX0ZfQ1RSTF9WUSk7CiDCoMKgwqDCoMKgwqDCoCBuZGV2LT5tdmRldi5t
bHhfZmVhdHVyZXMgfD0gQklUX1VMTChWSVJUSU9fTkVUX0ZfQ1RSTF9NQUNfQUREUik7CiDCoMKg
wqDCoMKgwqDCoCBuZGV2LT5tdmRldi5tbHhfZmVhdHVyZXMgfD0gQklUX1VMTChWSVJUSU9fTkVU
X0ZfTVEpOwoKIMKgwqDCoMKgwqDCoMKgIHByaW50X2ZlYXR1cmVzKG12ZGV2LCBuZGV2LT5tdmRl
di5tbHhfZmVhdHVyZXMsIGZhbHNlKTsKIMKgwqDCoMKgwqDCoMKgIHJldHVybiBuZGV2LT5tdmRl
di5tbHhfZmVhdHVyZXM7Cn0KCgpUaGFua3MKCgo+Cj4gQ2xlYXJpbmcgZmVhdHVyZXMgYml0IGNs
ZWFyZWQgdGhlIFZJUlRJT19ORVRfRl9NQUMuIER1ZSB0byB0aGlzIE1BQyBhZGRyZXNzCj4gcHJv
dmlkZWQgYnkgdGhlIGRldmljZSBpcyBub3QgaG9ub3JlZC4KPgo+IEZpeCBpdCBieSBub3QgY2xl
YXJpbmcgdGhlIHN0YXRpYyBmZWF0dXJlIGJpdHMgZHVyaW5nIHJlc2V0Lgo+Cj4gRml4ZXM6IDA2
ODYwODJkYmY3YSAoInZkcGE6IEFkZCByZXNldCBjYWxsYmFjayBpbiB2ZHBhX2NvbmZpZ19vcHMi
KQo+IFNpZ25lZC1vZmYtYnk6IFBhcmF2IFBhbmRpdCA8cGFyYXZAbnZpZGlhLmNvbT4KPiBSZXZp
ZXdlZC1ieTogRWxpIENvaGVuIDxlbGljQG52aWRpYS5jb20+Cj4gLS0tCj4gICBkcml2ZXJzL3Zk
cGEvbWx4NS9uZXQvbWx4NV92bmV0LmMgfCAxIC0KPiAgIDEgZmlsZSBjaGFuZ2VkLCAxIGRlbGV0
aW9uKC0pCj4KPiBkaWZmIC0tZ2l0IGEvZHJpdmVycy92ZHBhL21seDUvbmV0L21seDVfdm5ldC5j
IGIvZHJpdmVycy92ZHBhL21seDUvbmV0L21seDVfdm5ldC5jCj4gaW5kZXggY2EwNWY2OTA1NGI2
Li4wYTJiNzk4ODcwODUgMTAwNjQ0Cj4gLS0tIGEvZHJpdmVycy92ZHBhL21seDUvbmV0L21seDVf
dm5ldC5jCj4gKysrIGIvZHJpdmVycy92ZHBhL21seDUvbmV0L21seDVfdm5ldC5jCj4gQEAgLTIx
OTIsNyArMjE5Miw2IEBAIHN0YXRpYyBpbnQgbWx4NV92ZHBhX3Jlc2V0KHN0cnVjdCB2ZHBhX2Rl
dmljZSAqdmRldikKPiAgIAljbGVhcl92cXNfcmVhZHkobmRldik7Cj4gICAJbWx4NV92ZHBhX2Rl
c3Ryb3lfbXIoJm5kZXYtPm12ZGV2KTsKPiAgIAluZGV2LT5tdmRldi5zdGF0dXMgPSAwOwo+IC0J
bmRldi0+bXZkZXYubWx4X2ZlYXR1cmVzID0gMDsKPiAgIAltZW1zZXQobmRldi0+ZXZlbnRfY2Jz
LCAwLCBzaXplb2YobmRldi0+ZXZlbnRfY2JzKSk7Cj4gICAJbmRldi0+bXZkZXYuYWN0dWFsX2Zl
YXR1cmVzID0gMDsKPiAgIAkrK212ZGV2LT5nZW5lcmF0aW9uOwoKX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX18KVmlydHVhbGl6YXRpb24gbWFpbGluZyBsaXN0
ClZpcnR1YWxpemF0aW9uQGxpc3RzLmxpbnV4LWZvdW5kYXRpb24ub3JnCmh0dHBzOi8vbGlzdHMu
bGludXhmb3VuZGF0aW9uLm9yZy9tYWlsbWFuL2xpc3RpbmZvL3ZpcnR1YWxpemF0aW9u
