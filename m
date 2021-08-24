Return-Path: <SRS0=e+fm=NP=lists.linux-foundation.org=virtualization-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.4 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C7301C4338F
	for <virtualization@archiver.kernel.org>; Tue, 24 Aug 2021 09:08:31 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 5D92E61374
	for <virtualization@archiver.kernel.org>; Tue, 24 Aug 2021 09:08:31 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org 5D92E61374
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 1F1B4403D9;
	Tue, 24 Aug 2021 09:08:31 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
	by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id pLmeHFDQMZ-l; Tue, 24 Aug 2021 09:08:27 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp4.osuosl.org (Postfix) with ESMTPS id AA3DD404B1;
	Tue, 24 Aug 2021 09:08:26 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 86D8DC001A;
	Tue, 24 Aug 2021 09:08:26 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by lists.linuxfoundation.org (Postfix) with ESMTP id D2586C000E
 for <virtualization@lists.linux-foundation.org>;
 Tue, 24 Aug 2021 09:08:24 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id ADDB840123
 for <virtualization@lists.linux-foundation.org>;
 Tue, 24 Aug 2021 09:08:24 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp2.osuosl.org (amavisd-new);
 dkim=pass (1024-bit key) header.d=redhat.com
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id 5ziXkvKdVCDm
 for <virtualization@lists.linux-foundation.org>;
 Tue, 24 Aug 2021 09:08:22 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [216.205.24.124])
 by smtp2.osuosl.org (Postfix) with ESMTPS id 80B3A400BA
 for <virtualization@lists.linux-foundation.org>;
 Tue, 24 Aug 2021 09:08:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1629796101;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=2+0MFqdpTpecVjFHik3Je6oBwdWzzeAg6ebEZ8A8dsM=;
 b=FZnhjwYC90WPS+0kxRo96tBk+8Su7ZoLm4YvwYY/pAT32zoPdeln7YQG42gcDwd+VM0S77
 iKFQMklE2sXRoOCGR38P8RA6j3+0RPm+VDYCDlRuAu6fpoqjY8R47Ug/9hvzx0D0sk5PNe
 QvxfNEXFxebs+mj7QBV3IFQjsRwAL9k=
Received: from mail-pl1-f200.google.com (mail-pl1-f200.google.com
 [209.85.214.200]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-475-wyy4kdEkNhCkuer4UhhxLA-1; Tue, 24 Aug 2021 05:08:18 -0400
X-MC-Unique: wyy4kdEkNhCkuer4UhhxLA-1
Received: by mail-pl1-f200.google.com with SMTP id
 e10-20020a17090301ca00b0012dd6a04c04so5380579plh.10
 for <virtualization@lists.linux-foundation.org>;
 Tue, 24 Aug 2021 02:08:18 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-transfer-encoding
 :content-language;
 bh=2+0MFqdpTpecVjFHik3Je6oBwdWzzeAg6ebEZ8A8dsM=;
 b=qqIgDuLb6hbY5mtvl2vQhrKMiHEBumi/62pqWde770AB0TempvxZV7OHdb/WixNzXs
 euDLpGUZEnxKZZyyL3OfpfqMtK88PtPE/q22mY9CHKxkiVP442i4EneISDE5gKGS4wiE
 Mgw/PJ5j6qQ6VjMFqaUUGO5nNqqf1iasz9vrpurpPVn15rpt4VCVPm1sneuQIJnoi/wB
 sAXbSPsr3+P2CDI3h7VXG+dtMwTjQuvJACKHmez7pN0LCEXvDT5bzZnYrpAx4EZf74i1
 zg6SyksvWVS5jQ4x5tZyguGsq3UzxBTrRJOUCwzxnoOzWG/uu0FB+gusqtzNxdMD4bbs
 mMMQ==
X-Gm-Message-State: AOAM532+uhfrICKWQiC31nojb1z/9hf/VPsLe0Dvbtjb2ZdqTogf8uWf
 ub7BdepMjQj3B8PJuhzWpjTIOfhve1wX043nxl88uJvyubCDToW2M8iX4QUq/wWuTA+00kafIXL
 r9BHXhYs2rdmclucbDOfh56vhoAvzQscp9UDA6xTJhQ==
X-Received: by 2002:a17:902:b586:b0:134:8e25:809c with SMTP id
 a6-20020a170902b58600b001348e25809cmr7970053pls.20.1629796096974; 
 Tue, 24 Aug 2021 02:08:16 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJzIePtPZ6QO+nNYTJ/EJmV6fKYevulFsuJdG4+5QoZkmS1HSIGb1/Fnq1s1Z890X2cOcaY0SQ==
X-Received: by 2002:a17:902:b586:b0:134:8e25:809c with SMTP id
 a6-20020a170902b58600b001348e25809cmr7970028pls.20.1629796096667; 
 Tue, 24 Aug 2021 02:08:16 -0700 (PDT)
Received: from wangxiaodeMacBook-Air.local ([209.132.188.80])
 by smtp.gmail.com with ESMTPSA id u22sm18178311pfi.143.2021.08.24.02.08.14
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 24 Aug 2021 02:08:16 -0700 (PDT)
Subject: Re: [PATCH v4 1/6] vdpa/mlx5: Remove redundant header file inclusion
To: Eli Cohen <elic@nvidia.com>, mst@redhat.com,
 virtualization@lists.linux-foundation.org
References: <20210823052123.14909-1-elic@nvidia.com>
 <20210823052123.14909-2-elic@nvidia.com>
From: Jason Wang <jasowang@redhat.com>
Message-ID: <62864706-fb2c-b973-ab3d-8dfcc4adaf27@redhat.com>
Date: Tue, 24 Aug 2021 17:08:12 +0800
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:78.0)
 Gecko/20100101 Thunderbird/78.13.0
MIME-Version: 1.0
In-Reply-To: <20210823052123.14909-2-elic@nvidia.com>
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

CtTaIDIwMjEvOC8yMyDPws7nMToyMSwgRWxpIENvaGVuINC0tcA6Cj4gbGludXgvaWZfdmxhbi5o
IGlzIG5vdCByZXF1aXJlZC4KPiBSZW1vdmUgaXQuCj4KPiBTaWduZWQtb2ZmLWJ5OiBFbGkgQ29o
ZW4gPGVsaWNAbnZpZGlhLmNvbT4KCgpBY2tlZC1ieTogSmFzb24gV2FuZyA8amFzb3dhbmdAcmVk
aGF0LmNvbT4KCihidHcsIHNvbWUgb2YgbXkgYWNrcyBmb3IgcHJldmlvdXMgdmVyc2lvbiB3ZXJl
IGxvc3QpLgoKCj4gLS0tCj4gICBkcml2ZXJzL3ZkcGEvbWx4NS9jb3JlL21seDVfdmRwYS5oIHwg
MSAtCj4gICAxIGZpbGUgY2hhbmdlZCwgMSBkZWxldGlvbigtKQo+Cj4gZGlmZiAtLWdpdCBhL2Ry
aXZlcnMvdmRwYS9tbHg1L2NvcmUvbWx4NV92ZHBhLmggYi9kcml2ZXJzL3ZkcGEvbWx4NS9jb3Jl
L21seDVfdmRwYS5oCj4gaW5kZXggMDAwMmIyMTM2YjQ4Li44ZDBhNmYyY2IzZjAgMTAwNjQ0Cj4g
LS0tIGEvZHJpdmVycy92ZHBhL21seDUvY29yZS9tbHg1X3ZkcGEuaAo+ICsrKyBiL2RyaXZlcnMv
dmRwYS9tbHg1L2NvcmUvbWx4NV92ZHBhLmgKPiBAQCAtNSw3ICs1LDYgQEAKPiAgICNkZWZpbmUg
X19NTFg1X1ZEUEFfSF9fCj4gICAKPiAgICNpbmNsdWRlIDxsaW51eC9ldGhlcmRldmljZS5oPgo+
IC0jaW5jbHVkZSA8bGludXgvaWZfdmxhbi5oPgo+ICAgI2luY2x1ZGUgPGxpbnV4L3ZkcGEuaD4K
PiAgICNpbmNsdWRlIDxsaW51eC9tbHg1L2RyaXZlci5oPgo+ICAgCgpfX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fXwpWaXJ0dWFsaXphdGlvbiBtYWlsaW5nIGxp
c3QKVmlydHVhbGl6YXRpb25AbGlzdHMubGludXgtZm91bmRhdGlvbi5vcmcKaHR0cHM6Ly9saXN0
cy5saW51eGZvdW5kYXRpb24ub3JnL21haWxtYW4vbGlzdGluZm8vdmlydHVhbGl6YXRpb24=
