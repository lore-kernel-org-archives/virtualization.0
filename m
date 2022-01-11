Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 53F20C433F5
	for <virtualization@archiver.kernel.org>; Tue, 11 Jan 2022 04:38:10 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp2.osuosl.org (Postfix) with ESMTP id 09CC6408DC;
	Tue, 11 Jan 2022 04:38:10 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
	by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id ctnsU7O8Cg9w; Tue, 11 Jan 2022 04:38:09 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp2.osuosl.org (Postfix) with ESMTPS id F2197408A8;
	Tue, 11 Jan 2022 04:38:06 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id C4B6BC0030;
	Tue, 11 Jan 2022 04:38:06 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [IPv6:2605:bc80:3010::133])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 49419C001E
 for <virtualization@lists.linux-foundation.org>;
 Tue, 11 Jan 2022 04:38:05 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id 2DDA1408C4
 for <virtualization@lists.linux-foundation.org>;
 Tue, 11 Jan 2022 04:38:05 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id OfDbvi-b6N2Y
 for <virtualization@lists.linux-foundation.org>;
 Tue, 11 Jan 2022 04:38:03 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.133.124])
 by smtp2.osuosl.org (Postfix) with ESMTPS id C664F40577
 for <virtualization@lists.linux-foundation.org>;
 Tue, 11 Jan 2022 04:38:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1641875882;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=T6Za2ptl35SuGhC5n7POzBQa3m4oQeyjIDBWh6B2yXY=;
 b=eTsWs8cqQJzVnw44/P8YaKk4TvQ7IzRI22rEl+DGWKDt2uPqLEZ0miiwWPl4YM7TroCQCQ
 TR+zRH789oN4SYSmRCU7iQxRouEcTdolzyz5eByEwyocgfq6hUHEtMCx0WYCimBsUnJQCQ
 2d0fY6HvuOjahNCg+FFnPbUBd/fBrME=
Received: from mail-lf1-f69.google.com (mail-lf1-f69.google.com
 [209.85.167.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-412-EsqHSM7rP52u_YZLOlmGSQ-1; Mon, 10 Jan 2022 23:38:01 -0500
X-MC-Unique: EsqHSM7rP52u_YZLOlmGSQ-1
Received: by mail-lf1-f69.google.com with SMTP id
 bq6-20020a056512150600b0041bf41f5437so8092753lfb.17
 for <virtualization@lists.linux-foundation.org>;
 Mon, 10 Jan 2022 20:38:01 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc:content-transfer-encoding;
 bh=T6Za2ptl35SuGhC5n7POzBQa3m4oQeyjIDBWh6B2yXY=;
 b=tpCFlRW5dyheSlc8mdAw6baH0udwlfLFNuhLc9toDbZTHddXNeSQYI/zobDf6y/rm7
 l726mzFGSLTNxcGXC5b0Zw2MY37+WG1fXTcf5TmipWUOF7YQo1E5fUfMbH3cTFk2gFy8
 Km2n8Yn5L+CcrskKTsi3uqVE5cXOeRmKKpLyP1mFJE16CAxyfWl+r7ggKik68wbHZod0
 8dd5YhLvXTwNw/vP8CZw1oNEoLAdmPi5uoOfm58/CbwJJ7hjPztcsjz0FpNVoEFiW2oO
 Syn6vi3qJcALQyQ0pMdwVxoEnHDosmy9Fom0AsmfAF0KMESEvb8gT5ofohQf6VnPxqB0
 OR2g==
X-Gm-Message-State: AOAM530fd9JwzrNklpnWzNT1lMPcCRsFGwOV7pex8gM8G0ksDCMKtK6I
 XOx603dM/uQ7ph8SeUB0/pi26Edm+y5tS+xZdsa1V2cNsRv8sYFtUEI5I9tWc6y7uv86qEG73rR
 Mb7LMSoZAdoUJGXSeoNeWiJAJZo/if7/ve5ps+V1nD0eQLfjWx6woPMkprQ==
X-Received: by 2002:a19:f705:: with SMTP id z5mr2078440lfe.580.1641875880244; 
 Mon, 10 Jan 2022 20:38:00 -0800 (PST)
X-Google-Smtp-Source: ABdhPJzEScSQ+NLDyZQJEdPRRrnW7ysvazimsnd2b8anK6GfyRsmAv1dN+TCIzjoRFHjKYZ3/I3SXe1ryD4NhgKHJTk=
X-Received: by 2002:a19:f705:: with SMTP id z5mr2078429lfe.580.1641875880070; 
 Mon, 10 Jan 2022 20:38:00 -0800 (PST)
MIME-Version: 1.0
References: <tencent_7A45E1E967F13AE14B061269@qq.com>
In-Reply-To: <tencent_7A45E1E967F13AE14B061269@qq.com>
From: Jason Wang <jasowang@redhat.com>
Date: Tue, 11 Jan 2022 12:37:49 +0800
Message-ID: <CACGkMEvPnsDHn_gUdq2g2_Xzzqp8KVVhpaApnssYT9NT=mgm1A@mail.gmail.com>
Subject: Re: [PATCH] virtio_vdpa: Support surprise removal of virtio vdpa
 device
To: =?UTF-8?B?5p2O5Lic5Y2H?= <lidongsheng@dayudpu.com>
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=jasowang@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Cc: virtualization <virtualization@lists.linux-foundation.org>,
 linux-kernel <linux-kernel@vger.kernel.org>, mst <mst@redhat.com>
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

T24gVHVlLCBKYW4gMTEsIDIwMjIgYXQgMTE6MzggQU0g5p2O5Lic5Y2HIDxsaWRvbmdzaGVuZ0Bk
YXl1ZHB1LmNvbT4gd3JvdGU6Cj4KPiBXaGVuIHZpcnRpbyB2ZHBhIGRldmljZSByZW1vdmVkLCB0
aGUgYWJub3JtYWwgZGFtYWdlIG9mIHRoZSBkZXZpY2UgY2Fubm90IGJlCj4gcGVyY2VpdmVkIG5v
cm1hbGx5LCB3aGljaCB3aWxsIGNhdXNlIHByb2JsZW1zIHNpbWlsYXIgdG86Cj4KPiA0M2JiNDBj
NWI5MjYKPgo+IEhlbmNlLCBhZGQgdGhlIGFiaWxpdHkgdG8gYWJvcnQgdGhlIGNvbW1hbmQgb24g
c3VycHJpc2UgcmVtb3ZhbAo+Cj4gU2lnbmVkLW9mZi1ieTogZG9uZ3NoZW5nIGxpIDxsaWRvbmdz
aGVuZ0BkYXl1ZHB1LmNvbT4KCkFja2VkLWJ5OiBKYXNvbiBXYW5nIDxqYXNvd2FuZ0ByZWRoYXQu
Y29tPgoKPiAtLS0KPiAgZHJpdmVycy92aXJ0aW8vdmlydGlvX3ZkcGEuYyB8IDEgKwo+ICAxIGZp
bGUgY2hhbmdlZCwgMSBpbnNlcnRpb24oKykKPgo+IGRpZmYgLS1naXQgYS9kcml2ZXJzL3ZpcnRp
by92aXJ0aW9fdmRwYS5jIGIvZHJpdmVycy92aXJ0aW8vdmlydGlvX3ZkcGEuYwo+IGluZGV4IDRh
OWRkYjQ0YjJhNy4uZmQ5MzA0MDlkMTkwIDEwMDY0NAo+IC0tLSBhL2RyaXZlcnMvdmlydGlvL3Zp
cnRpb192ZHBhLmMKPiArKysgYi9kcml2ZXJzL3ZpcnRpby92aXJ0aW9fdmRwYS5jCj4gQEAgLTM3
NCw2ICszNzQsNyBAQCBzdGF0aWMgdm9pZCB2aXJ0aW9fdmRwYV9yZW1vdmUoc3RydWN0IHZkcGFf
ZGV2aWNlICp2ZHBhKQo+ICB7Cj4gICBzdHJ1Y3QgdmlydGlvX3ZkcGFfZGV2aWNlICp2ZF9kZXYg
PSB2ZHBhX2dldF9kcnZkYXRhKHZkcGEpOwo+Cj4gKyB2aXJ0aW9fYnJlYWtfZGV2aWNlKHZkX2Rl
di0+dmRldik7Cj4gICB1bnJlZ2lzdGVyX3ZpcnRpb19kZXZpY2UoJnZkX2Rldi0+dmRldik7Cj4g
IH0KPgo+IC0tCj4gMi4xNy4xCgpfX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fXwpWaXJ0dWFsaXphdGlvbiBtYWlsaW5nIGxpc3QKVmlydHVhbGl6YXRpb25AbGlz
dHMubGludXgtZm91bmRhdGlvbi5vcmcKaHR0cHM6Ly9saXN0cy5saW51eGZvdW5kYXRpb24ub3Jn
L21haWxtYW4vbGlzdGluZm8vdmlydHVhbGl6YXRpb24=
