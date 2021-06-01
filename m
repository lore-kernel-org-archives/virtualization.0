Return-Path: <SRS0=ZGfu=K3=lists.linux-foundation.org=virtualization-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.7 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 22E96C4708F
	for <virtualization@archiver.kernel.org>; Tue,  1 Jun 2021 05:06:12 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C72CF61378
	for <virtualization@archiver.kernel.org>; Tue,  1 Jun 2021 05:06:11 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C72CF61378
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=virtualization-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by smtp2.osuosl.org (Postfix) with ESMTP id 9691240439;
	Tue,  1 Jun 2021 05:06:11 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
	by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id jmhrRiWpVjgA; Tue,  1 Jun 2021 05:06:10 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp2.osuosl.org (Postfix) with ESMTP id 2F9B5404A5;
	Tue,  1 Jun 2021 05:06:10 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 00827C0024;
	Tue,  1 Jun 2021 05:06:09 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [IPv6:2605:bc80:3010::133])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 323B4C000D
 for <virtualization@lists.linux-foundation.org>;
 Tue,  1 Jun 2021 05:06:09 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id 267AB40439
 for <virtualization@lists.linux-foundation.org>;
 Tue,  1 Jun 2021 05:03:48 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id 3ahDzsKpXXvG
 for <virtualization@lists.linux-foundation.org>;
 Tue,  1 Jun 2021 05:03:47 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.133.124])
 by smtp2.osuosl.org (Postfix) with ESMTPS id 6D804404AD
 for <virtualization@lists.linux-foundation.org>;
 Tue,  1 Jun 2021 05:03:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1622523826;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=G4xPXgmRao4zlx3pSRsI1OzlbqWv379yzh8jVfWIHn8=;
 b=WJxMDbMxCe6upgAX6wGoQsCkAa/VFgZ8laf7/NCDPpS8bhasnBBtxP8hoR90M4pXdijCxw
 lzijo34+hntL6EgW1sdU1/cSvfIbr8TKtAg/hsHdk7+xZG0Ok/oWVDv6Boy9AbaeC8PgkZ
 8pR3xWRSnjdwHkULsdY8ZCmxgquL7YY=
Received: from mail-pj1-f69.google.com (mail-pj1-f69.google.com
 [209.85.216.69]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-340-JFq9cwUcN9y4Q19QyQNKTw-1; Tue, 01 Jun 2021 01:03:45 -0400
X-MC-Unique: JFq9cwUcN9y4Q19QyQNKTw-1
Received: by mail-pj1-f69.google.com with SMTP id
 b23-20020a17090ae397b0290163949acb4dso874766pjz.9
 for <virtualization@lists.linux-foundation.org>;
 Mon, 31 May 2021 22:03:44 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-transfer-encoding
 :content-language;
 bh=G4xPXgmRao4zlx3pSRsI1OzlbqWv379yzh8jVfWIHn8=;
 b=NlH33eX0vSyEl7WKyxDn5zowgB9ya+nJz5LZ5azceZ1frrgIn0b9vyIQm49W2xKHBY
 nbgKEwX5tYndyE0rEMnqTDnbW9cpRiT9Y3DCrBTSIZ0ZB5xnud4lJ7k0YMXq16W5jzmK
 WpZw4wuJrU9KzZlDYMPvwQe5Vbj2DjDNB7Fwhsx8IKzQPqut1C5z57/1bywLpnS4DstW
 24/9tuMCXNv8pFr+0xqm3y/ayq0i4csrVXDa0ytrE28hQptWjNfexIhVUtFBhyWCbIgJ
 ywTb/wmcCs5+tkA6D6lmrawwH3GgrSzfgMrtmzleXRK6rCTrm6bRgQZkEoyUaCukdDl0
 C0SQ==
X-Gm-Message-State: AOAM531Cc016d49VnS0brPqJM0JMWegWbB/5TDV86Exp7fyQPZ4Cqbo9
 Af1yTy9biCgOuDxtCITZYiUqIPGKNHlM16OlGQstZlvaZQzVZoqK4EWoQ8x3w82kNhXbLMFH2o+
 URW4ek+dRoQCkJVvzEAGNIQilatKLz9ntY40BcR6+jw==
X-Received: by 2002:a17:902:a40f:b029:fe:fee9:92fe with SMTP id
 p15-20020a170902a40fb02900fefee992femr22714896plq.26.1622523824035; 
 Mon, 31 May 2021 22:03:44 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJxLVOUMSb6U/UchT8myrtUaWkyYyY5luHhLO64YPIyhDNndX7GsRByxJqGUxTQndQBf5UjwoA==
X-Received: by 2002:a17:902:a40f:b029:fe:fee9:92fe with SMTP id
 p15-20020a170902a40fb02900fefee992femr22714873plq.26.1622523823808; 
 Mon, 31 May 2021 22:03:43 -0700 (PDT)
Received: from wangxiaodeMacBook-Air.local ([209.132.188.80])
 by smtp.gmail.com with ESMTPSA id n17sm1545604pfv.125.2021.05.31.22.03.41
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 31 May 2021 22:03:43 -0700 (PDT)
Subject: Re: [PATCH 2/3] vdpa/mlx5: Only return vq ready if vq is initialized
To: Eli Cohen <elic@nvidia.com>
References: <20210531160448.31537-1-elic@nvidia.com>
 <0fbd8484-9e8b-d7cc-4996-74306e6e2867@redhat.com>
 <20210601041351.GC203469@mtl-vdi-166.wap.labs.mlnx>
From: Jason Wang <jasowang@redhat.com>
Message-ID: <67b26a20-b418-4893-a42f-f03852c2123e@redhat.com>
Date: Tue, 1 Jun 2021 13:03:36 +0800
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:78.0)
 Gecko/20100101 Thunderbird/78.10.2
MIME-Version: 1.0
In-Reply-To: <20210601041351.GC203469@mtl-vdi-166.wap.labs.mlnx>
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=jasowang@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Language: en-US
Cc: virtualization@lists.linux-foundation.org, linux-kernel@vger.kernel.org,
 mst@redhat.com
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

CuWcqCAyMDIxLzYvMSDkuIvljYgxMjoxMywgRWxpIENvaGVuIOWGmemBkzoKPiBPbiBUdWUsIEp1
biAwMSwgMjAyMSBhdCAxMDoxODowNEFNICswODAwLCBKYXNvbiBXYW5nIHdyb3RlOgo+PiDlnKgg
MjAyMS82LzEg5LiK5Y2IMTI6MDQsIEVsaSBDb2hlbiDlhpnpgZM6Cj4+PiBPbmx5IHJldHVybiB0
aGUgdmFsdWUgb2YgdGhlIHJlYWR5IGZpZWxkIGlmIHRoZSBWUSBpcyBpbml0aWFsaXplZCBpbgo+
Pj4gd2hpY2ggY2FzZSB0aGUgdmFsdWUgb2YgdGhlIGZpZWxkIGlzIHZhbGlkLgo+Pj4KPj4+IEZh
aWxpbmcgdG8gZG8gc28gY2FuIHJlc3VsdCBpbiB2aXJ0aW9fdmRwYSBmYWlsaW5nIHRvIGxvYWQg
aWYgdGhlIGRldmljZQo+Pj4gd2FzIHByZXZpb3VzbHkgdXNlZCBieSB2aG9zdF92ZHBhIGFuZCB0
aGUgb2xkIHZhbHVlcyBhcmUgcmVhZHkuCj4+PiB2aXJ0aW9fdmRwYSBleHBlY3RzIHRvIGZpbmQg
VlFzIGluICJub3QgcmVhZHkiIHN0YXRlLgo+Pj4KPj4+IEZpeGVzOiAxYTg2YjM3N2FhMjEgKCJ2
ZHBhL21seDU6IEFkZCBWRFBBIGRyaXZlciBmb3Igc3VwcG9ydGVkIG1seDUgZGV2aWNlcyIpCj4+
PiBTaWduZWQtb2ZmLWJ5OiBFbGkgQ29oZW4gPGVsaWNAbnZpZGlhLmNvbT4KPj4+IC0tLQo+Pj4g
ICAgZHJpdmVycy92ZHBhL21seDUvbmV0L21seDVfdm5ldC5jIHwgMiArLQo+Pj4gICAgMSBmaWxl
IGNoYW5nZWQsIDEgaW5zZXJ0aW9uKCspLCAxIGRlbGV0aW9uKC0pCj4+Pgo+Pj4gZGlmZiAtLWdp
dCBhL2RyaXZlcnMvdmRwYS9tbHg1L25ldC9tbHg1X3ZuZXQuYyBiL2RyaXZlcnMvdmRwYS9tbHg1
L25ldC9tbHg1X3ZuZXQuYwo+Pj4gaW5kZXggMDJhMDU0OTIyMDRjLi5mNmI2ODBkMmFiMWMgMTAw
NjQ0Cj4+PiAtLS0gYS9kcml2ZXJzL3ZkcGEvbWx4NS9uZXQvbWx4NV92bmV0LmMKPj4+ICsrKyBi
L2RyaXZlcnMvdmRwYS9tbHg1L25ldC9tbHg1X3ZuZXQuYwo+Pj4gQEAgLTE0MDcsNyArMTQwNyw3
IEBAIHN0YXRpYyBib29sIG1seDVfdmRwYV9nZXRfdnFfcmVhZHkoc3RydWN0IHZkcGFfZGV2aWNl
ICp2ZGV2LCB1MTYgaWR4KQo+Pj4gICAgCXN0cnVjdCBtbHg1X3ZkcGFfbmV0ICpuZGV2ID0gdG9f
bWx4NV92ZHBhX25kZXYobXZkZXYpOwo+Pj4gICAgCXN0cnVjdCBtbHg1X3ZkcGFfdmlydHF1ZXVl
ICptdnEgPSAmbmRldi0+dnFzW2lkeF07Cj4+PiAtCXJldHVybiBtdnEtPnJlYWR5Owo+Pj4gKwly
ZXR1cm4gbXZxLT5pbml0aWFsaXplZCAmJiBtdnEtPnJlYWR5Owo+Pgo+PiBJIHRoaW5rIHRoZSBt
b3JlIHN1aXRhYmxlIGZpeCBpcyB0byByZXNldCBtdnEtPnJlYWR5IGR1cmluZyByZXNldC4gVGhl
Cj4+IHZxX3JlYWR5IHNob3VsZCBmb2xsb3cgdGhlIHF1ZXVlX2VuYWJsZSBzZW1hbnRpYyBpbiB2
aXJ0aW8tcGNpOgo+Pgo+PiAiCj4+IFRoZSBkZXZpY2UgTVVTVCBwcmVzZW50IGEgMCBpbiBxdWV1
ZV9lbmFibGUgb24gcmVzZXQuCj4+ICIKPiBUaGlua2luZyBhZ2FpbiwgSSB0aGluayB3ZSBzaG91
bGQgY2FsbCBzZXRfdnFfcmVhZHkoKSBmcm9tCj4gcWVtdS92aXJ0aW9fdmRwYSBldGMuIGFmdGVy
IHJlc2V0IHRvIGV4cGxpY2l0bHkgc2V0IHJlYWR5IHRvIGZhbHNlLgoKClRoaXMgaXMgbm90IHdo
YXQgSSByZWFkIGZyb20gdGhlIHNwZWMgYW5kIGhvdyB0aGUgY3VycmVudCBkcml2ZXIgYmVoYXZl
LgoKQW5kIEkgZG9uJ3Qgc2VlIHdoeSB3ZSBuZWVkIHRvIHN0aWNrIHRvIDEgYWZ0ZXIgdGhlIHJl
c2V0LgoKCj4KPiBUaGUgcmVhZHkgaW5kaWNhdGlvbiBpcyBub3QgbmVjZXNzYWlyaWx5IGEgcmVm
bGVjdGlvbiBvZiB0aGUgaGFyZHdhcmUKPiBxdWV1ZToKPgo+ICJWaXJ0dWFsIHF1ZXVlIHJlYWR5
IGJpdAo+IFdyaXRpbmcgb25lICgweDEpIHRvIHRoaXMgcmVnaXN0ZXIgbm90aWZpZXMgdGhlIGRl
dmljZSB0aGF0IGl0IGNhbgo+IGV4ZWN1dGUgcmVxdWVzdHMgZnJvbSB0aGlzIHZpcnR1YWwgcXVl
dWUuIFJlYWRpbmcgZnJvbSB0aGlzIHJlZ2lzdGVyCj4gcmV0dXJucyB0aGUgbGFzdCB2YWx1ZSB3
cml0dGVuIHRvIGl0LiBCb3RoIHJlYWQgYW5kIHdyaXRlIGFjY2Vzc2VzIGFwcGx5Cj4gdG8gdGhl
IHF1ZXVlIHNlbGVjdGVkIGJ5IHdyaXRpbmcgdG8gUXVldWVTZWwuIgoKCk15IHVuZGVyc3RhbmRp
bmcgdGhhdCB0aGlzIGFwcGxpZXMgaWYgbm90IHJlc2V0IGluIHRoZSBtaWRkbGUuIFdlIGNhbiAK
Y2xhcmlmeSB0aGlzIGluIHRoZSBzcGVjIGlmIG5lZWRlZC4KClRoYW5rcwoKCj4KPgo+PiBUaGFu
a3MKPj4KPj4KPj4+ICAgIH0KPj4+ICAgIHN0YXRpYyBpbnQgbWx4NV92ZHBhX3NldF92cV9zdGF0
ZShzdHJ1Y3QgdmRwYV9kZXZpY2UgKnZkZXYsIHUxNiBpZHgsCgpfX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fXwpWaXJ0dWFsaXphdGlvbiBtYWlsaW5nIGxpc3QK
VmlydHVhbGl6YXRpb25AbGlzdHMubGludXgtZm91bmRhdGlvbi5vcmcKaHR0cHM6Ly9saXN0cy5s
aW51eGZvdW5kYXRpb24ub3JnL21haWxtYW4vbGlzdGluZm8vdmlydHVhbGl6YXRpb24=
