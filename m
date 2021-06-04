Return-Path: <SRS0=Cwtm=K6=lists.linux-foundation.org=virtualization-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.7 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EDC31C47082
	for <virtualization@archiver.kernel.org>; Fri,  4 Jun 2021 02:30:01 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 7E0156140D
	for <virtualization@archiver.kernel.org>; Fri,  4 Jun 2021 02:30:01 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7E0156140D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=virtualization-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 4195A406A5;
	Fri,  4 Jun 2021 02:30:01 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
	by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id hIoLVELeLdvK; Fri,  4 Jun 2021 02:30:00 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp4.osuosl.org (Postfix) with ESMTP id 9DCFF40697;
	Fri,  4 Jun 2021 02:29:59 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 7652AC0019;
	Fri,  4 Jun 2021 02:29:59 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [IPv6:2605:bc80:3010::137])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 2673AC0001
 for <virtualization@lists.linux-foundation.org>;
 Fri,  4 Jun 2021 02:29:58 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id 2132E4069A
 for <virtualization@lists.linux-foundation.org>;
 Fri,  4 Jun 2021 02:29:58 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id zAso-yKCKXHL
 for <virtualization@lists.linux-foundation.org>;
 Fri,  4 Jun 2021 02:29:57 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.133.124])
 by smtp4.osuosl.org (Postfix) with ESMTPS id 51F0B40697
 for <virtualization@lists.linux-foundation.org>;
 Fri,  4 Jun 2021 02:29:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1622773796;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=gt8hnOglaRtAhIBG091MfWOvOxMu+M8wqRg4Wjd74ow=;
 b=QnMTKsb1Pd2ABhZVIYGLDuTQIBYbja9rF4vDsQwsvj5KVip1HlqMVMOgDuTkDcBHzZPFBd
 M1igUcXdD5HBfOvPL7BvFXPcOB+fc7ecR+BsD2BGp2qdpyipjEU1StJa+Ta44lULVTe23r
 xRbQwPAaELyzLqQ4abhIiO/P/K8DYUU=
Received: from mail-pl1-f198.google.com (mail-pl1-f198.google.com
 [209.85.214.198]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-454-mkFdlQRwOHWiaprPMofYzw-1; Thu, 03 Jun 2021 22:29:54 -0400
X-MC-Unique: mkFdlQRwOHWiaprPMofYzw-1
Received: by mail-pl1-f198.google.com with SMTP id
 n14-20020a170902e54eb029010d602977ecso2311975plf.7
 for <virtualization@lists.linux-foundation.org>;
 Thu, 03 Jun 2021 19:29:54 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-transfer-encoding
 :content-language;
 bh=gt8hnOglaRtAhIBG091MfWOvOxMu+M8wqRg4Wjd74ow=;
 b=Wf4lsIoChh1vjC+qXkI4HhsLsiFcF4nJi501L9PBFzuJLvKaSw1EfgAEgzRHhEjr4s
 oB5C/2suEhmJANK9izNu4OtXE6U3SWPp0XbO2MZI2pCFy6kwQSW3BA+02HqhCtlKK2IQ
 hcFNLBOS4x9qrGJ1Sz67uQfaMQhZwB0XzME0fRDibh267/CKUZD3KNpTiH6/1w4Yix86
 mPKT6vL8kMGwdcPdEHeqNpZYPH8R02Vn6bK0UhauQOVC6Ylobs4IQvR2CrIj3f50hbua
 unXJ5tGv89F79c1O9yCTm3lJEs9XrLqyk4epFRu3kMvYM7WAY/vXaINhN55ZgPTUBy+t
 hSIQ==
X-Gm-Message-State: AOAM5338fWD2gQpTQJ7Q0th9zNm1WgfnhsgIS4+/zDhxg4x4oYr2mgEV
 NE08KhSio10nDkqOTNATfGcNlz9to5xrjf/G6K4altoIFhjeWGkUU4KFZ3TOmk0hPCoIhFDynyN
 40atAHmWPB7FR7zAcPgbJW7HF+6hj8sGm5/NGDMbqIg==
X-Received: by 2002:a17:90a:c20b:: with SMTP id
 e11mr14312027pjt.67.1622773793514; 
 Thu, 03 Jun 2021 19:29:53 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJxXfTmOi+wnH/roCuXQXvi+QWyoA9G2ErBsIgSWukz95apd75Y4VLg30EaPsmmCzT9f8zvJ3w==
X-Received: by 2002:a17:90a:c20b:: with SMTP id
 e11mr14312013pjt.67.1622773793313; 
 Thu, 03 Jun 2021 19:29:53 -0700 (PDT)
Received: from wangxiaodeMacBook-Air.local ([209.132.188.80])
 by smtp.gmail.com with ESMTPSA id s11sm325912pfm.95.2021.06.03.19.29.49
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 03 Jun 2021 19:29:52 -0700 (PDT)
Subject: Re: [PATCH v1 1/8] virtio: Force only split mode with protected guest
To: Andi Kleen <ak@linux.intel.com>, mst@redhat.com
References: <20210603004133.4079390-1-ak@linux.intel.com>
 <20210603004133.4079390-2-ak@linux.intel.com>
 <28c8302b-6833-10b4-c0eb-67456e7c4069@redhat.com>
 <09e17c7f-ce51-1a46-72c4-12223bee4e3a@linux.intel.com>
 <1c08bc42-7448-351e-78bf-fcf68d2b2561@redhat.com>
 <5a2d0d70-fa6b-f08d-f222-5c00cf5f9d44@linux.intel.com>
 <9b10bb24-eb27-510e-cf0d-7818ab9166ef@redhat.com>
 <9d6bc785-9613-a2e8-f78f-4547747a331d@linux.intel.com>
From: Jason Wang <jasowang@redhat.com>
Message-ID: <93f58cfd-be59-1ea6-e0d0-6840c14d6980@redhat.com>
Date: Fri, 4 Jun 2021 10:29:47 +0800
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:78.0)
 Gecko/20100101 Thunderbird/78.10.2
MIME-Version: 1.0
In-Reply-To: <9d6bc785-9613-a2e8-f78f-4547747a331d@linux.intel.com>
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=jasowang@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Language: en-US
Cc: sathyanarayanan.kuppuswamy@linux.intel.com, x86@kernel.org,
 linux-kernel@vger.kernel.org, virtualization@lists.linux-foundation.org,
 iommu@lists.linux-foundation.org, jpoimboe@redhat.com, robin.murphy@arm.com,
 hch@lst.de, m.szyprowski@samsung.com
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

CuWcqCAyMDIxLzYvMyDkuIvljYg5OjU1LCBBbmRpIEtsZWVuIOWGmemBkzoKPgo+PiBPaywgYnV0
IHdoYXQgSSBtZWFudCBpcyB0aGlzLCBpZiB3ZSBkb24ndCByZWFkIGZyb20gdGhlIGRlc2NyaXB0
b3IgCj4+IHJpbmcsIGFuZCB2YWxpZGF0ZSBhbGwgdGhlIG90aGVyIG1ldGFkYXRhIHN1cHBsaWVk
IGJ5IHRoZSBkZXZpY2UgCj4+ICh1c2VkIGlkIGFuZCBsZW4pLiBUaGVuIHRoZXJlIHNob3VsZCBi
ZSBubyB3YXkgZm9yIHRoZSBkZXZpY2UgdG8gCj4+IHN1cHByZXNzIHRoZSBkbWEgZmxhZ3MgdG8g
d3JpdGUgdG8gdGhlIGluZGlyZWN0IGRlc2NyaXB0b3IgdGFibGUuCj4+Cj4+IE9yIGRvIHlvdSBo
YXZlIGFuIGV4YW1wbGUgaG93IGl0IGNhbiBkbyB0aGF0Pwo+Cj4gSSBkb24ndC4gSWYgeW91IGNh
biB2YWxpZGF0ZSBldmVyeXRoaW5nIGl0J3MgcHJvYmFibHkgb2sKPgo+IFRoZSBvbmx5IGRyYXdi
YWNrIGlzIGV2ZW4gbW9yZSBjb2RlIHRvIGF1ZGl0IGFuZCB0ZXN0Lgo+Cj4gLUFuZGkKPgo+CgpP
aywgdGhlbiBJJ20gZ29pbmcgdG8gcG9zdCBhIGZvcm1hbCBzZXJpZXMsIHBsZWFzZSBoYXZlIGEg
bG9vayBhbmQgd2UgCmNhbiBzdGFydCBmcm9tIHRoZXJlLgoKVGhhbmtzCgpfX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fXwpWaXJ0dWFsaXphdGlvbiBtYWlsaW5n
IGxpc3QKVmlydHVhbGl6YXRpb25AbGlzdHMubGludXgtZm91bmRhdGlvbi5vcmcKaHR0cHM6Ly9s
aXN0cy5saW51eGZvdW5kYXRpb24ub3JnL21haWxtYW4vbGlzdGluZm8vdmlydHVhbGl6YXRpb24=
