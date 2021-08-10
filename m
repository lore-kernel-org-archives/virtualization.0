Return-Path: <SRS0=EG+p=NB=lists.linux-foundation.org=virtualization-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.1 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 20AF1C4338F
	for <virtualization@archiver.kernel.org>; Tue, 10 Aug 2021 03:56:26 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A6364601FF
	for <virtualization@archiver.kernel.org>; Tue, 10 Aug 2021 03:56:25 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org A6364601FF
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by smtp2.osuosl.org (Postfix) with ESMTP id 639354015B;
	Tue, 10 Aug 2021 03:56:25 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
	by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id iwgHJ8xI5PFg; Tue, 10 Aug 2021 03:56:21 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp2.osuosl.org (Postfix) with ESMTPS id E233C4024C;
	Tue, 10 Aug 2021 03:56:20 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id ABF3CC001A;
	Tue, 10 Aug 2021 03:56:20 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [IPv6:2605:bc80:3010::133])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 437E1C000E
 for <virtualization@lists.linux-foundation.org>;
 Tue, 10 Aug 2021 03:56:20 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id 37F584024C
 for <virtualization@lists.linux-foundation.org>;
 Tue, 10 Aug 2021 03:56:20 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id GauwnkxPca8R
 for <virtualization@lists.linux-foundation.org>;
 Tue, 10 Aug 2021 03:56:19 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.133.124])
 by smtp2.osuosl.org (Postfix) with ESMTPS id 758BC4015B
 for <virtualization@lists.linux-foundation.org>;
 Tue, 10 Aug 2021 03:56:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1628567778;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=IEPclYv6qwZXqBipfKsFDAsr607SQnI2IjuvFAjcOTQ=;
 b=PIfm1gHzNC7qfxHKeeAKWxOkfSE3ZerZZw9utTIzS0ux6gJv6cfLHRMzC9b50BilS3pFmL
 wL+dpixoQDHYj+9AHB19ePdthruEUvlct44K2LPoasL+WzcKrEMN8pyxluFhykq9We0jqu
 pyllXKRMVS/x5rRYwC1hCiSxyYLuOQA=
Received: from mail-pj1-f71.google.com (mail-pj1-f71.google.com
 [209.85.216.71]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-512-4nJQeYtbN_CHpV_iwOszFg-1; Mon, 09 Aug 2021 23:56:17 -0400
X-MC-Unique: 4nJQeYtbN_CHpV_iwOszFg-1
Received: by mail-pj1-f71.google.com with SMTP id
 61-20020a17090a09c3b029017897f47801so1183816pjo.8
 for <virtualization@lists.linux-foundation.org>;
 Mon, 09 Aug 2021 20:56:16 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-transfer-encoding
 :content-language;
 bh=IEPclYv6qwZXqBipfKsFDAsr607SQnI2IjuvFAjcOTQ=;
 b=Ajm4fAtLKbc77FXuRGILsLiInr1/LU3G2xFMDu6/g/lTNLh4LxZYiKOJtkx2bluDov
 TNYfb/idGuwi6gclAy8c1TaohUCZeQlZ330m0Wu3LpfYppSSFjiMXDDtYSvAlwbOqZ0f
 INL9fqaeFPey3zO8VNmhI740wRi7IkfcuTDNuVFlWqCgXiugf7/dklMRTPV94I+HJxf4
 /INT1qLFkY8KqGPTOhCJgN7d+g0x6j96vx9N0hDO6+24LrU4MECOd+P9fIuvTlQNWfPA
 UdSpTgHZDk/g3WvShqQGmWZm02gMQhJ5FNbAyAaJkxe0XFJ3W31gWb+wRDOHMfb9RA3s
 NvXA==
X-Gm-Message-State: AOAM530E+1Htzt+5L5AVGJImwBQ8/Y+SbrU73bMQyeF5NTtkeLx4orZQ
 5M0iHDtQqsvRfeH1LR3F/we0u0JJvOBBuOeYF1ieQLdjD1JM7AxRzAKAdL9nGmv7xEY2M/paqfI
 XPKtyi184guMaOacaN2ym+R+vEc+/Enc0DMfOhAXGaQ==
X-Received: by 2002:a63:510f:: with SMTP id f15mr364966pgb.222.1628567775327; 
 Mon, 09 Aug 2021 20:56:15 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJzes3mqIGycKkxenRDmxnh+igytIMSuSEM2ir8A1rVCQcRFvePQCAdDfzTJgmHwC4A9mo4i9A==
X-Received: by 2002:a63:510f:: with SMTP id f15mr364950pgb.222.1628567775123; 
 Mon, 09 Aug 2021 20:56:15 -0700 (PDT)
Received: from wangxiaodeMacBook-Air.local ([209.132.188.80])
 by smtp.gmail.com with ESMTPSA id z13sm976777pjd.44.2021.08.09.20.56.12
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 09 Aug 2021 20:56:14 -0700 (PDT)
Subject: Re: [Patch v1 1/3] vdpa/mlx5: Remove redundant header file inclusion
To: Eli Cohen <elic@nvidia.com>, mst@redhat.com,
 virtualization@lists.linux-foundation.org
References: <20210809140800.97835-1-elic@nvidia.com>
 <20210809140800.97835-2-elic@nvidia.com>
From: Jason Wang <jasowang@redhat.com>
Message-ID: <8dcfc990-f02c-22db-5c9c-67b4ae28f16a@redhat.com>
Date: Tue, 10 Aug 2021 11:56:10 +0800
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:78.0)
 Gecko/20100101 Thunderbird/78.12.0
MIME-Version: 1.0
In-Reply-To: <20210809140800.97835-2-elic@nvidia.com>
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=jasowang@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Language: en-US
Cc: eperezma@redhat.com
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

CtTaIDIwMjEvOC85IM/CzucxMDowNywgRWxpIENvaGVuINC0tcA6Cj4gbGludXgvaWZfdmxhbi5o
IGlzIG5vdCByZXF1aXJlZC4KPiBSZW1vdmUgaXQuCj4KPiBTaWduZWQtb2ZmLWJ5OiBFbGkgQ29o
ZW4gPGVsaWNAbnZpZGlhLmNvbT4KCgpBY2tlZC1ieTogSmFzb24gV2FuZyA8amFzb3dhbmdAcmVk
aGF0LmNvbT4KCgo+IC0tLQo+ICAgZHJpdmVycy92ZHBhL21seDUvY29yZS9tbHg1X3ZkcGEuaCB8
IDEgLQo+ICAgMSBmaWxlIGNoYW5nZWQsIDEgZGVsZXRpb24oLSkKPgo+IGRpZmYgLS1naXQgYS9k
cml2ZXJzL3ZkcGEvbWx4NS9jb3JlL21seDVfdmRwYS5oIGIvZHJpdmVycy92ZHBhL21seDUvY29y
ZS9tbHg1X3ZkcGEuaAo+IGluZGV4IDAwMDJiMjEzNmI0OC4uOGQwYTZmMmNiM2YwIDEwMDY0NAo+
IC0tLSBhL2RyaXZlcnMvdmRwYS9tbHg1L2NvcmUvbWx4NV92ZHBhLmgKPiArKysgYi9kcml2ZXJz
L3ZkcGEvbWx4NS9jb3JlL21seDVfdmRwYS5oCj4gQEAgLTUsNyArNSw2IEBACj4gICAjZGVmaW5l
IF9fTUxYNV9WRFBBX0hfXwo+ICAgCj4gICAjaW5jbHVkZSA8bGludXgvZXRoZXJkZXZpY2UuaD4K
PiAtI2luY2x1ZGUgPGxpbnV4L2lmX3ZsYW4uaD4KPiAgICNpbmNsdWRlIDxsaW51eC92ZHBhLmg+
Cj4gICAjaW5jbHVkZSA8bGludXgvbWx4NS9kcml2ZXIuaD4KPiAgIAoKX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18KVmlydHVhbGl6YXRpb24gbWFpbGluZyBs
aXN0ClZpcnR1YWxpemF0aW9uQGxpc3RzLmxpbnV4LWZvdW5kYXRpb24ub3JnCmh0dHBzOi8vbGlz
dHMubGludXhmb3VuZGF0aW9uLm9yZy9tYWlsbWFuL2xpc3RpbmZvL3ZpcnR1YWxpemF0aW9u
