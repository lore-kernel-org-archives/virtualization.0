Return-Path: <SRS0=EG+p=NB=lists.linux-foundation.org=virtualization-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.1 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 55FCCC4338F
	for <virtualization@archiver.kernel.org>; Tue, 10 Aug 2021 06:59:57 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id ED05C61019
	for <virtualization@archiver.kernel.org>; Tue, 10 Aug 2021 06:59:56 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org ED05C61019
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id BCDD882A5D;
	Tue, 10 Aug 2021 06:59:56 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
	by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id FdHLpVPUxe18; Tue, 10 Aug 2021 06:59:53 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp1.osuosl.org (Postfix) with ESMTPS id 6065381DB2;
	Tue, 10 Aug 2021 06:59:52 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 32A3BC0010;
	Tue, 10 Aug 2021 06:59:52 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 2B935C000E
 for <virtualization@lists.linux-foundation.org>;
 Tue, 10 Aug 2021 06:59:51 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id 218F060620
 for <virtualization@lists.linux-foundation.org>;
 Tue, 10 Aug 2021 06:59:51 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp3.osuosl.org (amavisd-new);
 dkim=pass (1024-bit key) header.d=redhat.com
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id 68fdO7v_YMbi
 for <virtualization@lists.linux-foundation.org>;
 Tue, 10 Aug 2021 06:59:50 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [216.205.24.124])
 by smtp3.osuosl.org (Postfix) with ESMTPS id 1F35D6061B
 for <virtualization@lists.linux-foundation.org>;
 Tue, 10 Aug 2021 06:59:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1628578788;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=Cffq7OlH6V/Z8AE+xnVC0ZiIhRDeVUhtuJhpMuTZxX0=;
 b=IVZbmluvWu4JJPvdImiMu3yE4XyTVZi5F/EdBCh005ymNougw3T/XlcH+RG30A/Aq4rbP9
 V0LgdL/pai/HrKy19wAuR9nqeSmc+aLLuvrEUHeexBHm/QP+ZelNTRciYzDNi4Tiu3eAuA
 GviKVpyh1jQRwd2d9QIFIiUB5etopGc=
Received: from mail-pl1-f197.google.com (mail-pl1-f197.google.com
 [209.85.214.197]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-323-evXDuYw6MXKtVJd1Q1lRFQ-1; Tue, 10 Aug 2021 02:59:47 -0400
X-MC-Unique: evXDuYw6MXKtVJd1Q1lRFQ-1
Received: by mail-pl1-f197.google.com with SMTP id
 s3-20020a1709029883b029012b41197000so1527974plp.16
 for <virtualization@lists.linux-foundation.org>;
 Mon, 09 Aug 2021 23:59:47 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-transfer-encoding
 :content-language;
 bh=Cffq7OlH6V/Z8AE+xnVC0ZiIhRDeVUhtuJhpMuTZxX0=;
 b=aKdVcxmvcp40UxL48Xmksz3lEYjK5clP5gUyxpfMxSkqKdHQMGqbwH96sC/9Y9GqOX
 /WEZUWI0LHs3ps5ZVTWogcabn/ucuz/Dp7x45WWWBGXhvxOdcbuZNKvBsY+GQWD/MZeL
 8oL6mGuPBQsWGJteB0Y5TJBM2UWhZT7qYC1IYb8ip22jfwy1y7E+2Z8D2TRub6fwCbJx
 WpJCDePuiYp3K8BJT/Y0XrN2ZIu1gX2T/hh3u5EgtwEr/n6zaKK8p6sYPqgqxuA+e5/S
 HRqYh01JrWaUm3GMo655VL4tqG25S4IGVzLNFVxfS+pSjQml6refKPOX+QzB0+IiAqpO
 mqrQ==
X-Gm-Message-State: AOAM5329MN4VmE1yh4T6ziH6wRE3n2vxYkKk/g3XsHMZvej1WgjWEIL9
 U8xVRNJJ5tqxQaJ0818KlLMw6mdqaK1MjzeNnvwaqJOi70enVjJRCi3B3RVMA/7GyPtm+VGyQEu
 FDnooyl2TgxxnXWET/t3I/zxSBox8qD1vIvUWrRqmzw==
X-Received: by 2002:a17:90b:34a:: with SMTP id
 fh10mr29351076pjb.134.1628578786185; 
 Mon, 09 Aug 2021 23:59:46 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJyyrbs/YDU3MNI8hVXqMW422VJSPmpjHIL4mjB5dm/5UNU1I3yH/ewcl/R9s/ijTMhy9D8SBg==
X-Received: by 2002:a17:90b:34a:: with SMTP id
 fh10mr29351059pjb.134.1628578785896; 
 Mon, 09 Aug 2021 23:59:45 -0700 (PDT)
Received: from wangxiaodeMacBook-Air.local ([209.132.188.80])
 by smtp.gmail.com with ESMTPSA id p3sm1722059pjt.0.2021.08.09.23.59.43
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 09 Aug 2021 23:59:45 -0700 (PDT)
Subject: Re: [PATCH v5] virtio-blk: Add validation for block size in config
 space
To: Yongji Xie <xieyongji@bytedance.com>
References: <20210809101609.148-1-xieyongji@bytedance.com>
 <08366773-76b5-be73-7e32-d9ce6f6799bf@redhat.com>
 <CACycT3tPR30RU8XmWbDA=Hp-A6BBifd-q_aqrmU-9VK=OaRJRg@mail.gmail.com>
From: Jason Wang <jasowang@redhat.com>
Message-ID: <46c513b4-6644-d4b0-84f4-32df34b6d7b8@redhat.com>
Date: Tue, 10 Aug 2021 14:59:41 +0800
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:78.0)
 Gecko/20100101 Thunderbird/78.12.0
MIME-Version: 1.0
In-Reply-To: <CACycT3tPR30RU8XmWbDA=Hp-A6BBifd-q_aqrmU-9VK=OaRJRg@mail.gmail.com>
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=jasowang@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Language: en-US
Cc: linux-block@vger.kernel.org,
 virtualization <virtualization@lists.linux-foundation.org>,
 linux-kernel <linux-kernel@vger.kernel.org>,
 Stefan Hajnoczi <stefanha@redhat.com>, "Michael S. Tsirkin" <mst@redhat.com>
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

CuWcqCAyMDIxLzgvMTAg5LiL5Y2IMTI6NTksIFlvbmdqaSBYaWUg5YaZ6YGTOgo+IE9uIFR1ZSwg
QXVnIDEwLCAyMDIxIGF0IDExOjA1IEFNIEphc29uIFdhbmcgPGphc293YW5nQHJlZGhhdC5jb20+
IHdyb3RlOgo+Pgo+PiDlnKggMjAyMS84Lzkg5LiL5Y2INjoxNiwgWGllIFlvbmdqaSDlhpnpgZM6
Cj4+PiBBbiB1bnRydXN0ZWQgZGV2aWNlIG1pZ2h0IHByZXNlbnRzIGFuIGludmFsaWQgYmxvY2sg
c2l6ZQo+Pj4gaW4gY29uZmlndXJhdGlvbiBzcGFjZS4gVGhpcyB0cmllcyB0byBhZGQgdmFsaWRh
dGlvbiBmb3IgaXQKPj4+IGluIHRoZSB2YWxpZGF0ZSBjYWxsYmFjayBhbmQgY2xlYXIgdGhlIFZJ
UlRJT19CTEtfRl9CTEtfU0laRQo+Pj4gZmVhdHVyZSBiaXQgaWYgdGhlIHZhbHVlIGlzIG91dCBv
ZiB0aGUgc3VwcG9ydGVkIHJhbmdlLgo+Pj4KPj4+IEFuZCB3ZSBhbHNvIGRvdWJsZSBjaGVjayB0
aGUgdmFsdWUgaW4gdmlydGJsa19wcm9iZSgpIGluCj4+PiBjYXNlIHRoYXQgaXQncyBjaGFuZ2Vk
IGFmdGVyIHRoZSB2YWxpZGF0aW9uLgo+Pj4KPj4+IFNpZ25lZC1vZmYtYnk6IFhpZSBZb25namkg
PHhpZXlvbmdqaUBieXRlZGFuY2UuY29tPgo+Pj4gLS0tCj4+PiAgICBkcml2ZXJzL2Jsb2NrL3Zp
cnRpb19ibGsuYyB8IDM5ICsrKysrKysrKysrKysrKysrKysrKysrKysrKysrKysrKy0tLS0tLQo+
Pj4gICAgMSBmaWxlIGNoYW5nZWQsIDMzIGluc2VydGlvbnMoKyksIDYgZGVsZXRpb25zKC0pCj4+
Pgo+Pj4gZGlmZiAtLWdpdCBhL2RyaXZlcnMvYmxvY2svdmlydGlvX2Jsay5jIGIvZHJpdmVycy9i
bG9jay92aXJ0aW9fYmxrLmMKPj4+IGluZGV4IDRiNDlkZjJkZmQyMy4uYWZiMzdhYWMwOWU4IDEw
MDY0NAo+Pj4gLS0tIGEvZHJpdmVycy9ibG9jay92aXJ0aW9fYmxrLmMKPj4+ICsrKyBiL2RyaXZl
cnMvYmxvY2svdmlydGlvX2Jsay5jCj4+PiBAQCAtNjkyLDYgKzY5MiwyOCBAQCBzdGF0aWMgY29u
c3Qgc3RydWN0IGJsa19tcV9vcHMgdmlydGlvX21xX29wcyA9IHsKPj4+ICAgIHN0YXRpYyB1bnNp
Z25lZCBpbnQgdmlydGJsa19xdWV1ZV9kZXB0aDsKPj4+ICAgIG1vZHVsZV9wYXJhbV9uYW1lZChx
dWV1ZV9kZXB0aCwgdmlydGJsa19xdWV1ZV9kZXB0aCwgdWludCwgMDQ0NCk7Cj4+Pgo+Pj4gK3N0
YXRpYyBpbnQgdmlydGJsa192YWxpZGF0ZShzdHJ1Y3QgdmlydGlvX2RldmljZSAqdmRldikKPj4+
ICt7Cj4+PiArICAgICB1MzIgYmxrX3NpemU7Cj4+PiArCj4+PiArICAgICBpZiAoIXZkZXYtPmNv
bmZpZy0+Z2V0KSB7Cj4+PiArICAgICAgICAgICAgIGRldl9lcnIoJnZkZXYtPmRldiwgIiVzIGZh
aWx1cmU6IGNvbmZpZyBhY2Nlc3MgZGlzYWJsZWRcbiIsCj4+PiArICAgICAgICAgICAgICAgICAg
ICAgX19mdW5jX18pOwo+Pj4gKyAgICAgICAgICAgICByZXR1cm4gLUVJTlZBTDsKPj4+ICsgICAg
IH0KPj4+ICsKPj4+ICsgICAgIGlmICghdmlydGlvX2hhc19mZWF0dXJlKHZkZXYsIFZJUlRJT19C
TEtfRl9CTEtfU0laRSkpCj4+PiArICAgICAgICAgICAgIHJldHVybiAwOwo+Pj4gKwo+Pj4gKyAg
ICAgYmxrX3NpemUgPSB2aXJ0aW9fY3JlYWQzMih2ZGV2LAo+Pj4gKyAgICAgICAgICAgICAgICAg
ICAgIG9mZnNldG9mKHN0cnVjdCB2aXJ0aW9fYmxrX2NvbmZpZywgYmxrX3NpemUpKTsKPj4+ICsK
Pj4+ICsgICAgIGlmIChibGtfc2l6ZSA8IFNFQ1RPUl9TSVpFIHx8IGJsa19zaXplID4gUEFHRV9T
SVpFKQo+Pj4gKyAgICAgICAgICAgICBfX3ZpcnRpb19jbGVhcl9iaXQodmRldiwgVklSVElPX0JM
S19GX0JMS19TSVpFKTsKPj4KPj4gSSB3b25kZXIgaWYgaXQncyBiZXR0ZXIgdG8ganVzdCBmYWls
IGhlcmUgYXMgd2hhdCB3ZSBkaWQgZm9yIHByb2JlKCkuCj4+Cj4gTG9va3MgbGlrZSB3ZSBkb24n
dCBuZWVkIHRvIGRvIHRoYXQgc2luY2Ugd2UgYWxyZWFkeSBjbGVhciB0aGUKPiBWSVJUSU9fQkxL
X0ZfQkxLX1NJWkUgdG8gdGVsbCB0aGUgZGV2aWNlIHRoYXQgd2UgZG9uJ3QgdXNlIHRoZSBibG9j
awo+IHNpemUgaW4gY29uZmlndXJhdGlvbiBzcGFjZS4gSnVzdCBsaWtlIHdoYXQgd2UgZGlkIGlu
Cj4gdmlydG5ldF92YWxpZGF0ZSgpLgo+Cj4gVGhhbmtzLAo+IFlvbmdqaQoKCk9rLCBzbwoKQWNr
ZWQtYnk6IEphc29uIFdhbmcgPGphc293YW5nQHJlZGhhdC5jb20+CgoKCj4KCl9fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fClZpcnR1YWxpemF0aW9uIG1haWxp
bmcgbGlzdApWaXJ0dWFsaXphdGlvbkBsaXN0cy5saW51eC1mb3VuZGF0aW9uLm9yZwpodHRwczov
L2xpc3RzLmxpbnV4Zm91bmRhdGlvbi5vcmcvbWFpbG1hbi9saXN0aW5mby92aXJ0dWFsaXphdGlv
bg==
