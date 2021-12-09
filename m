Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id ACA21C433EF
	for <virtualization@archiver.kernel.org>; Thu,  9 Dec 2021 11:53:07 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 32322831EF;
	Thu,  9 Dec 2021 11:53:07 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
	by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id BK3UZ6fvXdds; Thu,  9 Dec 2021 11:53:06 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp1.osuosl.org (Postfix) with ESMTPS id 9C8CC82404;
	Thu,  9 Dec 2021 11:53:05 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 7C181C001E;
	Thu,  9 Dec 2021 11:53:05 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id B176BC0012
 for <virtualization@lists.linux-foundation.org>;
 Thu,  9 Dec 2021 11:53:03 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id 9F9F3831EF
 for <virtualization@lists.linux-foundation.org>;
 Thu,  9 Dec 2021 11:53:03 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id Ya6yoGccRGA1
 for <virtualization@lists.linux-foundation.org>;
 Thu,  9 Dec 2021 11:53:03 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.129.124])
 by smtp1.osuosl.org (Postfix) with ESMTPS id E5BF382404
 for <virtualization@lists.linux-foundation.org>;
 Thu,  9 Dec 2021 11:53:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1639050781;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=0TYqDLKrFKQnJiMTqk3TD0EmAaxYdybXmgiw3V7bkHY=;
 b=OkrJUO5OdJI1FR2fHV1Sv8ol/37xao4mUqjFh3bab677tWLT6AHPLvyY0yybkFemlMCFtV
 /Q9Y2k8giQRUcLeRnQwaBLsZC/WNh3hzK9gE2vGIIxw4G33qTccm/oUywG7rai+r0ZigYp
 Ip7M1Ub3NYbA1FC5wpU0kxB2AphH81M=
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-1-XChCncyOPcSeoqIOr_e_2Q-1; Thu, 09 Dec 2021 06:52:58 -0500
X-MC-Unique: XChCncyOPcSeoqIOr_e_2Q-1
Received: by mail-wr1-f72.google.com with SMTP id
 d7-20020a5d6447000000b00186a113463dso1319827wrw.10
 for <virtualization@lists.linux-foundation.org>;
 Thu, 09 Dec 2021 03:52:58 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
 :content-language:to:cc:references:from:organization:in-reply-to
 :content-transfer-encoding;
 bh=0TYqDLKrFKQnJiMTqk3TD0EmAaxYdybXmgiw3V7bkHY=;
 b=pMahGPADvhT2U7k6wlQiTPEKJLh3n2Dq0+1uHdwPVB7PB43tEg9SlJWfM1xZQ6Psa2
 2OQT5AmiBSdiPnvbDlQkdcPDFnq2vjlf5/EjWfrb/uP/X8+sYu22JimmeZg4k5BZljJE
 h3ZQXgEc8JfMa0hSkRDQL7D2TQm4vFTE6NJAdoko0DcCyuJPOoUYZWW/uoE08X+0cN+w
 BCbbxzx11+n7JbhH7PMIyj6gSN9XUuDrM8wJ/dXaA8GSvweuQrCt01exdlx0qQwPdwWj
 IaHssbIpn36Xb7kl6rPribyEBedywXsfIVqp3zI0GcWBDiRQZ4ArzHg6Rfmc+iAkrPH4
 xOWg==
X-Gm-Message-State: AOAM530HyM7tmE01uS+xMON53kQXQcOTtZgI25lDbc2K9pwp/1ENIVbf
 xUErRu28EbxROyl2q4Ds6aeWAVldr+ljMmVSTCEqRt14TeDG5IcsRz4HIMrymCgdbJ/jFRTveww
 FD13XRFpJ0A5WSCUnRymsZVant1XsyqpxpVlKcTiK3g==
X-Received: by 2002:a1c:448b:: with SMTP id r133mr6687578wma.85.1639050777617; 
 Thu, 09 Dec 2021 03:52:57 -0800 (PST)
X-Google-Smtp-Source: ABdhPJyL2rego16YzHim2g10utaFg2hLXRfWqlX4AYNOsaFkm/biENlPxtMps3emSdCNW89UHAze0A==
X-Received: by 2002:a1c:448b:: with SMTP id r133mr6687533wma.85.1639050777348; 
 Thu, 09 Dec 2021 03:52:57 -0800 (PST)
Received: from [192.168.3.132] (p4ff23ded.dip0.t-ipconnect.de. [79.242.61.237])
 by smtp.gmail.com with ESMTPSA id b6sm8982964wmq.45.2021.12.09.03.52.56
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 09 Dec 2021 03:52:56 -0800 (PST)
Message-ID: <858b3185-6770-6c46-5efb-53698c913eec@redhat.com>
Date: Thu, 9 Dec 2021 12:52:56 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.2.0
Subject: Re: [PATCH v1 2/2] virtio-mem: prepare fake page onlining code for
 granularity smaller than MAX_ORDER - 1
To: Eric Ren <renzhengeek@gmail.com>, linux-kernel@vger.kernel.org
References: <20211126134209.17332-1-david@redhat.com>
 <20211126134209.17332-3-david@redhat.com>
 <a4e2099d-b543-e2e3-f189-0cdfcc38420e@gmail.com>
From: David Hildenbrand <david@redhat.com>
Organization: Red Hat
In-Reply-To: <a4e2099d-b543-e2e3-f189-0cdfcc38420e@gmail.com>
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=david@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Language: en-US
Cc: Pankaj Gupta <pankaj.gupta.linux@gmail.com>, Gavin Shan <gshan@redhat.com>,
 Wei Yang <richard.weiyang@linux.alibaba.com>,
 "Michael S. Tsirkin" <mst@redhat.com>,
 virtualization@lists.linux-foundation.org, linux-mm@kvack.org,
 Sebastien Boeuf <sebastien.boeuf@intel.com>, Zi Yan <ziy@nvidia.com>,
 Hui Zhu <teawater@gmail.com>
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

SGkgRXJpYywKCnRoYW5rcyBmb3IgdGhlIHJldmlldyEKCj4+ICAgCQlpZiAoUGFnZURpcnR5KHBh
Z2UpKSB7Cj4+IC0JCQl2aXJ0aW9fbWVtX2NsZWFyX2Zha2Vfb2ZmbGluZShwZm4gKyBpLCBtYXhf
bnJfcGFnZXMsCj4+IC0JCQkJCQkgICAgICBmYWxzZSk7Cj4+IC0JCQlnZW5lcmljX29ubGluZV9w
YWdlKHBhZ2UsIE1BWF9PUkRFUiAtIDEpOwo+PiArCQkJdmlydGlvX21lbV9jbGVhcl9mYWtlX29m
ZmxpbmUocGZuICsgaSwgMSA8PCBvcmRlciwgZmFsc2UpOwo+PiArCQkJZ2VuZXJpY19vbmxpbmVf
cGFnZShwYWdlLCBvcmRlcik7Cj4+ICAgCQl9IGVsc2Ugewo+PiAtCQkJdmlydGlvX21lbV9jbGVh
cl9mYWtlX29mZmxpbmUocGZuICsgaSwgbWF4X25yX3BhZ2VzLAo+PiAtCQkJCQkJICAgICAgdHJ1
ZSk7Cj4+IC0JCQlmcmVlX2NvbnRpZ19yYW5nZShwZm4gKyBpLCBtYXhfbnJfcGFnZXMpOwo+PiAt
CQkJYWRqdXN0X21hbmFnZWRfcGFnZV9jb3VudChwYWdlLCBtYXhfbnJfcGFnZXMpOwo+PiArCQkJ
dmlydGlvX21lbV9jbGVhcl9mYWtlX29mZmxpbmUocGZuICsgaSwgMSA8PCBvcmRlciwgdHJ1ZSk7
Cj4+ICsJCQlmcmVlX2NvbnRpZ19yYW5nZShwZm4gKyBpLCAxIDw8IG9yZGVyKTsKPj4gKwkJCWFk
anVzdF9tYW5hZ2VkX3BhZ2VfY291bnQocGFnZSwgMSA8PCBvcmRlcik7Cj4gSW4gdGhlIGxvb3As
IHBmbiArIGksIDEgPDwgb3JkZXIgYXJlIHJlcGVhdGVkbHkgY2FsY3VsYXRlZC4gMSA8PCBvcmRl
ciAKPiBpcyBhIHN0ZXAgc2l6ZSwgcGZuICsgacKgIGlzIGVhY2ggc3RlcCBwb3NpdGlvbi4KPiBC
ZXR0ZXIgdG8gZmlndXJlIHRoZSBudW1lciBvbmNlIGVhY2ggaXRlcj8KClRoZSBjb21waWxlciBi
ZXR0ZXIgYmUgc21hcnQgZW5vdWdoIHRvIGNhbGN1bGF0ZSBzdWNoIGNvbnN0YW50cyBvbmNlIDop
Cgo+IAo+IExHVEwuCj4gTEdUTS4KPiBSZXZpZXdlZC1ieTogRXJpYyBSZW4gPHJlbnpoZW5nZWVr
QGdtYWlsLmNvbT4KClRoYW5rcyEKCgotLSAKVGhhbmtzLAoKRGF2aWQgLyBkaGlsZGVuYgoKX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18KVmlydHVhbGl6YXRp
b24gbWFpbGluZyBsaXN0ClZpcnR1YWxpemF0aW9uQGxpc3RzLmxpbnV4LWZvdW5kYXRpb24ub3Jn
Cmh0dHBzOi8vbGlzdHMubGludXhmb3VuZGF0aW9uLm9yZy9tYWlsbWFuL2xpc3RpbmZvL3ZpcnR1
YWxpemF0aW9u
