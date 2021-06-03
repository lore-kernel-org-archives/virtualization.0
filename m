Return-Path: <SRS0=cU2J=K5=lists.linux-foundation.org=virtualization-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.7 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 06CB1C47082
	for <virtualization@archiver.kernel.org>; Thu,  3 Jun 2021 07:00:29 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 9AF046124B
	for <virtualization@archiver.kernel.org>; Thu,  3 Jun 2021 07:00:28 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9AF046124B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=virtualization-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 5BC6D405B4;
	Thu,  3 Jun 2021 07:00:28 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
	by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id cKX-cW1XPS55; Thu,  3 Jun 2021 07:00:27 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp4.osuosl.org (Postfix) with ESMTP id 80F044059A;
	Thu,  3 Jun 2021 07:00:26 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 588FCC000E;
	Thu,  3 Jun 2021 07:00:26 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [IPv6:2605:bc80:3010::137])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 0A991C0001
 for <virtualization@lists.linux-foundation.org>;
 Thu,  3 Jun 2021 07:00:25 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id F25254059B
 for <virtualization@lists.linux-foundation.org>;
 Thu,  3 Jun 2021 07:00:24 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id 9ZnouTy-DDcp
 for <virtualization@lists.linux-foundation.org>;
 Thu,  3 Jun 2021 07:00:24 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.133.124])
 by smtp4.osuosl.org (Postfix) with ESMTPS id D95E24059A
 for <virtualization@lists.linux-foundation.org>;
 Thu,  3 Jun 2021 07:00:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1622703622;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=PueWFJYsB4q2dbMbGSJGobObFbdsaUmedr2PiYlLS3o=;
 b=drF1TK0WLDTSbDPYDGEfc/2pvEl59xc/D0ey/xmv750Snefy2O8kR3ie9d738+YDUwIV9l
 ILCa3WzFvKvekZUI7wTMj6GJDXCt74GlbssDrJJkY04sOsi47MI8MiRGYYVFcRH6RA9WRq
 fNz9MBB+UXKNzdf5L5rAjJYnjChkitw=
Received: from mail-pl1-f197.google.com (mail-pl1-f197.google.com
 [209.85.214.197]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-40-RYHxF2EsPZKSfv55NdABNg-1; Thu, 03 Jun 2021 03:00:20 -0400
X-MC-Unique: RYHxF2EsPZKSfv55NdABNg-1
Received: by mail-pl1-f197.google.com with SMTP id
 u1-20020a1709027141b02901040cac08fdso2237659plm.12
 for <virtualization@lists.linux-foundation.org>;
 Thu, 03 Jun 2021 00:00:20 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-transfer-encoding
 :content-language;
 bh=PueWFJYsB4q2dbMbGSJGobObFbdsaUmedr2PiYlLS3o=;
 b=JxRCJaSDuwkNWvubkLIsWby1xvqctm6ymJSFUk59LkCPqHtM5e7Or8RsYY1zTm3oze
 mnJswR9dFZLlqa84jeYAL70jcHVo5b89Ps/3OX+Kz82BBnzPNh9aF6ycXKlHyYoiikDc
 LDYBgE8k5PU5AsWNaeZ4r7OFm3RMeP2ILipSXmIN3PqqbWH+r0NqsujBc74yc1hHKj97
 NETXjIp0MF6WrAHUetwvwcw8mY/+sPsHAgl5CtaKioXL2zgA5tUHUwV+bPXl3NTM2gZg
 sKpHBRL9mpnNYFnrSyT4dzpwGZjg9ehuaBOADdnLfhCzZkQ6TVkkeQOhwaVp+/of+lnu
 Ag0A==
X-Gm-Message-State: AOAM532pVwj5LNwmomMReMxQYC5iGZaKjHiz+IqjlWDWGEtgfrWm90R3
 88/yKtRCi12t0CDNHz5CXhhGlqZmkwTcmHWEJFMVI5j20SIpkVRKjzijDMY+SRFKSXnjOKhGyue
 UtE/X5w7Wccrz+rpNb6i0Qf86csKmNthra+xTex/YAg==
X-Received: by 2002:a17:90a:ff94:: with SMTP id
 hf20mr9823052pjb.6.1622703619411; 
 Thu, 03 Jun 2021 00:00:19 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJwuFat3ur7ckvX8vpf934U3+NTqjjQzslUJJI4ns7h5rf5mia5EcivLXOiFvCSKUi6MFLcDMA==
X-Received: by 2002:a17:90a:ff94:: with SMTP id
 hf20mr9823035pjb.6.1622703619247; 
 Thu, 03 Jun 2021 00:00:19 -0700 (PDT)
Received: from wangxiaodeMacBook-Air.local ([209.132.188.80])
 by smtp.gmail.com with ESMTPSA id 19sm1128554pfn.43.2021.06.03.00.00.17
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 03 Jun 2021 00:00:18 -0700 (PDT)
Subject: Re: [PATCH] vdpa/mlx5: Clear vq ready indication upon device reset
To: Eli Cohen <elic@nvidia.com>, mst@redhat.com,
 virtualization@lists.linux-foundation.org, linux-kernel@vger.kernel.org
References: <20210602085924.62777-1-elic@nvidia.com>
From: Jason Wang <jasowang@redhat.com>
Message-ID: <6e4f9e1b-2c67-fae6-6edd-1982d0f48e22@redhat.com>
Date: Thu, 3 Jun 2021 15:00:15 +0800
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:78.0)
 Gecko/20100101 Thunderbird/78.10.2
MIME-Version: 1.0
In-Reply-To: <20210602085924.62777-1-elic@nvidia.com>
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=jasowang@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Language: en-US
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
Content-Type: text/plain; charset="gbk"; Format="flowed"
Errors-To: virtualization-bounces@lists.linux-foundation.org
Sender: "Virtualization" <virtualization-bounces@lists.linux-foundation.org>

CtTaIDIwMjEvNi8yIM/Czuc0OjU5LCBFbGkgQ29oZW4g0LS1wDoKPiBBZnRlciBkZXZpY2UgcmVz
ZXQsIHRoZSB2aXJ0cXVldWVzIGFyZSBub3QgcmVhZHkgc28gY2xlYXIgdGhlIHJlYWR5Cj4gZmll
bGQuCj4KPiBGYWlsaW5nIHRvIGRvIHNvIGNhbiByZXN1bHQgaW4gdmlydGlvX3ZkcGEgZmFpbGlu
ZyB0byBsb2FkIGlmIHRoZSBkZXZpY2UKPiB3YXMgcHJldmlvdXNseSB1c2VkIGJ5IHZob3N0X3Zk
cGEgYW5kIHRoZSBvbGQgdmFsdWVzIGFyZSByZWFkeS4KPiB2aXJ0aW9fdmRwYSBleHBlY3RzIHRv
IGZpbmQgVlFzIGluICJub3QgcmVhZHkiIHN0YXRlLgo+Cj4gRml4ZXM6IDFhODZiMzc3YWEyMSAo
InZkcGEvbWx4NTogQWRkIFZEUEEgZHJpdmVyIGZvciBzdXBwb3J0ZWQgbWx4NSBkZXZpY2VzIikK
PiBTaWduZWQtb2ZmLWJ5OiBFbGkgQ29oZW4gPGVsaWNAbnZpZGlhLmNvbT4KCgpBY2tlZC1ieTog
SmFzb24gV2FuZyA8amFzb3dhbmdAcmVkaGF0LmNvbT4KCgo+IC0tLQo+ICAgZHJpdmVycy92ZHBh
L21seDUvbmV0L21seDVfdm5ldC5jIHwgMSArCj4gICAxIGZpbGUgY2hhbmdlZCwgMSBpbnNlcnRp
b24oKykKPgo+IGRpZmYgLS1naXQgYS9kcml2ZXJzL3ZkcGEvbWx4NS9uZXQvbWx4NV92bmV0LmMg
Yi9kcml2ZXJzL3ZkcGEvbWx4NS9uZXQvbWx4NV92bmV0LmMKPiBpbmRleCAwMmEwNTQ5MjIwNGMu
LmU4YmMwODQyYjQ0YyAxMDA2NDQKPiAtLS0gYS9kcml2ZXJzL3ZkcGEvbWx4NS9uZXQvbWx4NV92
bmV0LmMKPiArKysgYi9kcml2ZXJzL3ZkcGEvbWx4NS9uZXQvbWx4NV92bmV0LmMKPiBAQCAtODYy
LDYgKzg2Miw3IEBAIHN0YXRpYyB2b2lkIGRlc3Ryb3lfdmlydHF1ZXVlKHN0cnVjdCBtbHg1X3Zk
cGFfbmV0ICpuZGV2LCBzdHJ1Y3QgbWx4NV92ZHBhX3ZpcnRxCj4gICAJCXJldHVybjsKPiAgIAl9
Cj4gICAJdW1lbXNfZGVzdHJveShuZGV2LCBtdnEpOwo+ICsJbXZxLT5yZWFkeSA9IGZhbHNlOwo+
ICAgfQo+ICAgCj4gICBzdGF0aWMgdTMyIGdldF9ycXBuKHN0cnVjdCBtbHg1X3ZkcGFfdmlydHF1
ZXVlICptdnEsIGJvb2wgZncpCgpfX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fXwpWaXJ0dWFsaXphdGlvbiBtYWlsaW5nIGxpc3QKVmlydHVhbGl6YXRpb25AbGlz
dHMubGludXgtZm91bmRhdGlvbi5vcmcKaHR0cHM6Ly9saXN0cy5saW51eGZvdW5kYXRpb24ub3Jn
L21haWxtYW4vbGlzdGluZm8vdmlydHVhbGl6YXRpb24=
