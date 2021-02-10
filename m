Return-Path: <SRS0=QvMg=HM=lists.linux-foundation.org=virtualization-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.3 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 50291C433E0
	for <virtualization@archiver.kernel.org>; Wed, 10 Feb 2021 04:17:35 +0000 (UTC)
Received: from hemlock.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B6E9564E0B
	for <virtualization@archiver.kernel.org>; Wed, 10 Feb 2021 04:17:34 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B6E9564E0B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=virtualization-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by hemlock.osuosl.org (Postfix) with ESMTP id 7B845871D1;
	Wed, 10 Feb 2021 04:17:34 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from hemlock.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id ElvsqNkXFQ6Z; Wed, 10 Feb 2021 04:17:34 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by hemlock.osuosl.org (Postfix) with ESMTP id E90F587182;
	Wed, 10 Feb 2021 04:17:33 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id AD834C0174;
	Wed, 10 Feb 2021 04:17:33 +0000 (UTC)
Received: from fraxinus.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by lists.linuxfoundation.org (Postfix) with ESMTP id D08F3C013A
 for <virtualization@lists.linux-foundation.org>;
 Wed, 10 Feb 2021 04:17:32 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by fraxinus.osuosl.org (Postfix) with ESMTP id BB0098584A
 for <virtualization@lists.linux-foundation.org>;
 Wed, 10 Feb 2021 04:17:32 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from fraxinus.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id BA3YYI4OKqHJ
 for <virtualization@lists.linux-foundation.org>;
 Wed, 10 Feb 2021 04:17:31 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [63.128.21.124])
 by fraxinus.osuosl.org (Postfix) with ESMTPS id 7CBE584F35
 for <virtualization@lists.linux-foundation.org>;
 Wed, 10 Feb 2021 04:17:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1612930650;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=XogBkdyBYNnsPgb8O5lpSxrAmm+YqRAreRdEUUxEYQU=;
 b=P2E9fjzhnglo7hkI6CbXBoJdcxazXaQAoQOEIEipaKDZC7AZUP+Q3ErTiUU0DDJVIaDKMc
 hjC+SF0V5nfUQH/dUpjeYU2dX5kF8XaKvi0Z6GpAqEG18Q91CjlYteNpE28Tk0BjWDgmwH
 yG55LXwcy0yifutVRd5NNdS4x/ZG17k=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-282-_S6FvGMlO3GKG8vrmWID7g-1; Tue, 09 Feb 2021 23:17:28 -0500
X-MC-Unique: _S6FvGMlO3GKG8vrmWID7g-1
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com
 [10.5.11.23])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 2BD30192AB78;
 Wed, 10 Feb 2021 04:17:27 +0000 (UTC)
Received: from [10.72.12.223] (ovpn-12-223.pek2.redhat.com [10.72.12.223])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 3EC7519C66;
 Wed, 10 Feb 2021 04:17:20 +0000 (UTC)
Subject: Re: [PATCH] vdpa/mlx5: fix param validation in mlx5_vdpa_get_config()
To: Stefano Garzarella <sgarzare@redhat.com>, Eli Cohen <elic@nvidia.com>
References: <20210208161741.104939-1-sgarzare@redhat.com>
 <20210209054302.GA210455@mtl-vdi-166.wap.labs.mlnx>
 <20210209090014.xolf5kxri3xdmacz@steredhat>
From: Jason Wang <jasowang@redhat.com>
Message-ID: <cdd75885-3610-8685-14f3-5467a8ef1501@redhat.com>
Date: Wed, 10 Feb 2021 12:17:19 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <20210209090014.xolf5kxri3xdmacz@steredhat>
Content-Language: en-US
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
Cc: "Michael S. Tsirkin" <mst@redhat.com>, linux-kernel@vger.kernel.org,
 virtualization@lists.linux-foundation.org
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

Ck9uIDIwMjEvMi85IOS4i+WNiDU6MDAsIFN0ZWZhbm8gR2FyemFyZWxsYSB3cm90ZToKPiBPbiBU
dWUsIEZlYiAwOSwgMjAyMSBhdCAwNzo0MzowMkFNICswMjAwLCBFbGkgQ29oZW4gd3JvdGU6Cj4+
IE9uIE1vbiwgRmViIDA4LCAyMDIxIGF0IDA1OjE3OjQxUE0gKzAxMDAsIFN0ZWZhbm8gR2FyemFy
ZWxsYSB3cm90ZToKPj4+IEl0J3MgbGVnYWwgdG8gaGF2ZSAnb2Zmc2V0ICsgbGVuJyBlcXVhbCB0
bwo+Pj4gc2l6ZW9mKHN0cnVjdCB2aXJ0aW9fbmV0X2NvbmZpZyksIHNpbmNlICduZGV2LT5jb25m
aWcnIGlzIGEKPj4+ICdzdHJ1Y3QgdmlydGlvX25ldF9jb25maWcnLCBzbyB3ZSBjYW4gc2FmZWx5
IGNvcHkgaXRzIGNvbnRlbnQgdW5kZXIKPj4+IHRoaXMgY29uZGl0aW9uLgo+Pj4KPj4+IEZpeGVz
OiAxYTg2YjM3N2FhMjEgKCJ2ZHBhL21seDU6IEFkZCBWRFBBIGRyaXZlciBmb3Igc3VwcG9ydGVk
IG1seDUgCj4+PiBkZXZpY2VzIikKPj4+IENjOiBzdGFibGVAdmdlci5rZXJuZWwub3JnCj4+PiBT
aWduZWQtb2ZmLWJ5OiBTdGVmYW5vIEdhcnphcmVsbGEgPHNnYXJ6YXJlQHJlZGhhdC5jb20+Cj4+
Cj4+IEFja2VkLWJ5OiBFbGkgQ29oZW4gPGVsaWNAbnZpZGlhLmNvbT4KPj4KPj4gQlRXLCBzYW1l
IGVycm9yIGluIHZkcGFfc2ltIHlvdSBtYXkgd2FudCB0byBmaXguCj4+Cj4KPiBDb21taXQgNjVi
NzA5NTg2ZTIyICgidmRwYV9zaW06IGFkZCBnZXRfY29uZmlnIGNhbGxiYWNrIGluIAo+IHZkcGFz
aW1fZGV2X2F0dHIiKSB1bmludGVudGlvbmFsbHkgc29sdmVkIGl0Lgo+Cj4gU2luY2UgaXQncyBh
IHNpbXVsYXRvciwgbWF5YmUgd2UgY2FuIGF2b2lkIHNvbHZpbmcgaXQgaW4gdGhlIHN0YWJsZSAK
PiBicmFuY2hlcy4gT3IgZG9lcyBpdCBtYXR0ZXI/CgoKSSB0aGluayBub3QsIHNpbmNlIHRoZSBt
b2R1bGUgZGVwZW5kcyBvbiBSVU5USU1FX1RFU1RJTkdfTUVOVS4KClRoYW5rcwoKCgoKPgo+IFRo
YW5rcywKPiBTdGVmYW5vIAoKX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX18KVmlydHVhbGl6YXRpb24gbWFpbGluZyBsaXN0ClZpcnR1YWxpemF0aW9uQGxpc3Rz
LmxpbnV4LWZvdW5kYXRpb24ub3JnCmh0dHBzOi8vbGlzdHMubGludXhmb3VuZGF0aW9uLm9yZy9t
YWlsbWFuL2xpc3RpbmZvL3ZpcnR1YWxpemF0aW9u
