Return-Path: <SRS0=yluT=M2=lists.linux-foundation.org=virtualization-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.1 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,URIBL_RED,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5BA11C4320E
	for <virtualization@archiver.kernel.org>; Tue,  3 Aug 2021 08:03:15 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id EF3D960F70
	for <virtualization@archiver.kernel.org>; Tue,  3 Aug 2021 08:03:14 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org EF3D960F70
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id A0B436FB61;
	Tue,  3 Aug 2021 08:03:14 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
	by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id kunJFRHDNP9H; Tue,  3 Aug 2021 08:03:13 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp3.osuosl.org (Postfix) with ESMTPS id 46F8D6FB5A;
	Tue,  3 Aug 2021 08:03:13 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 15CE9C001A;
	Tue,  3 Aug 2021 08:03:13 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id D41BBC000E
 for <virtualization@lists.linux-foundation.org>;
 Tue,  3 Aug 2021 08:03:11 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id B31E68274D
 for <virtualization@lists.linux-foundation.org>;
 Tue,  3 Aug 2021 08:03:11 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp1.osuosl.org (amavisd-new);
 dkim=pass (1024-bit key) header.d=redhat.com
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id aAIGQ9X3sxYu
 for <virtualization@lists.linux-foundation.org>;
 Tue,  3 Aug 2021 08:03:10 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [216.205.24.124])
 by smtp1.osuosl.org (Postfix) with ESMTPS id 7A20781ADE
 for <virtualization@lists.linux-foundation.org>;
 Tue,  3 Aug 2021 08:03:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1627977789;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=oX9W5hbn1aUW9052DFy7xT6UwniQgZiOlZ+YGM5fx0A=;
 b=drQ3y0yYcOqB4qinQnLDe/UhmYQyIbaZmxCvAItHRe1ROT8eyKIznfLS2bbr6GT6sO8IRx
 2Wzv+A+gbvBSJTQVpFhVKZp5ndX2K6o07Mh05jZua0EZiWVHXZcnbVS43DBr4zJqYXTevp
 lZYtrn7a+VFkAQ4WUZVdm8hmPx5r8To=
Received: from mail-pj1-f71.google.com (mail-pj1-f71.google.com
 [209.85.216.71]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-439-lkR5crKqNTeh5tlNQNS_aQ-1; Tue, 03 Aug 2021 04:03:08 -0400
X-MC-Unique: lkR5crKqNTeh5tlNQNS_aQ-1
Received: by mail-pj1-f71.google.com with SMTP id
 gt7-20020a17090af2c7b02901773c999dcbso18708404pjb.6
 for <virtualization@lists.linux-foundation.org>;
 Tue, 03 Aug 2021 01:03:08 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-transfer-encoding
 :content-language;
 bh=oX9W5hbn1aUW9052DFy7xT6UwniQgZiOlZ+YGM5fx0A=;
 b=X8+kB4q1LEity2SXicxrT11MWGJlQaeQhWF744oMT8k/wmdnuOvdW3fYzT8O1E0bw7
 DM9PB8elTNcfN3Ijsa/oCcCwVJeTlnoCLBftOsChy39KrCJhjcp7eXrddM9KR2y5E0V7
 bsBXdAPIg6UCRFmW1ceFmFbiw8t/tirqx5alT11pDdcqdl7SQYWSO5aqyUjpRmUD8Fdb
 7hf+xvMLmLiJRyL6orxdsRSUg50HAqqAnoeu+V93Na1n6HyDBITNkE6mx+5LCjq9EmQt
 JPhCXftkPcVUOXLUPQF4nKk1rmMQWNpUsCSd3tnUHC+jNfub3sIthAJYNVEZbeg+2ar+
 cPGw==
X-Gm-Message-State: AOAM533j0Izn+OSHX1IiP3931AWIHS2H2RDEdaCLcWTaMenzPl2XtVPo
 EUlYJEm5qwTRnIuXqHjRUT9BYM8B3gKt8HT67EkllBJc2huA24zHjKSUEDbRMcHIarLNcoudMUh
 rblpR83/pA6yhBoYY5KxjxdSG/ToFLPkD5xNMfi49gA==
X-Received: by 2002:a17:90a:784e:: with SMTP id
 y14mr5429384pjl.185.1627977787238; 
 Tue, 03 Aug 2021 01:03:07 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJzQ/4OMNA4Jyj5oD4cflZM/wOKB+qV8HVYA0Mg+fxcM5s95sTutq8PhHECERUYS65XO/92FRw==
X-Received: by 2002:a17:90a:784e:: with SMTP id
 y14mr5429356pjl.185.1627977786975; 
 Tue, 03 Aug 2021 01:03:06 -0700 (PDT)
Received: from wangxiaodeMacBook-Air.local ([209.132.188.80])
 by smtp.gmail.com with ESMTPSA id n20sm7442877pfv.212.2021.08.03.01.02.59
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 03 Aug 2021 01:03:06 -0700 (PDT)
Subject: Re: [PATCH v10 07/17] virtio: Don't set FAILED status bit on device
 index allocation failure
To: Xie Yongji <xieyongji@bytedance.com>, mst@redhat.com,
 stefanha@redhat.com, sgarzare@redhat.com, parav@nvidia.com,
 hch@infradead.org, christian.brauner@canonical.com, rdunlap@infradead.org,
 willy@infradead.org, viro@zeniv.linux.org.uk, axboe@kernel.dk,
 bcrl@kvack.org, corbet@lwn.net, mika.penttila@nextfour.com,
 dan.carpenter@oracle.com, joro@8bytes.org, gregkh@linuxfoundation.org,
 zhe.he@windriver.com, xiaodong.liu@intel.com, joe@perches.com
References: <20210729073503.187-1-xieyongji@bytedance.com>
 <20210729073503.187-8-xieyongji@bytedance.com>
From: Jason Wang <jasowang@redhat.com>
Message-ID: <487ed840-f417-e1b6-edb3-15f19969de51@redhat.com>
Date: Tue, 3 Aug 2021 16:02:57 +0800
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:78.0)
 Gecko/20100101 Thunderbird/78.12.0
MIME-Version: 1.0
In-Reply-To: <20210729073503.187-8-xieyongji@bytedance.com>
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=jasowang@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Language: en-US
Cc: kvm@vger.kernel.org, netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
 virtualization@lists.linux-foundation.org, iommu@lists.linux-foundation.org,
 songmuchun@bytedance.com, linux-fsdevel@vger.kernel.org
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

CtTaIDIwMjEvNy8yOSDPws7nMzozNCwgWGllIFlvbmdqaSDQtLXAOgo+IFdlIGRvbid0IG5lZWQg
dG8gc2V0IEZBSUxFRCBzdGF0dXMgYml0IG9uIGRldmljZSBpbmRleCBhbGxvY2F0aW9uCj4gZmFp
bHVyZSBzaW5jZSB0aGUgZGV2aWNlIGluaXRpYWxpemF0aW9uIGhhc24ndCBiZWVuIHN0YXJ0ZWQg
eWV0Lgo+IFRoaXMgZG9lc24ndCBhZmZlY3QgcnVudGltZSwgZm91bmQgaW4gY29kZSByZXZpZXcu
Cj4KPiBTaWduZWQtb2ZmLWJ5OiBYaWUgWW9uZ2ppIDx4aWV5b25namlAYnl0ZWRhbmNlLmNvbT4K
CgpEb2VzIGl0IHJlYWxseSBoYXJtPwoKVGhhbmtzCgoKPiAtLS0KPiAgIGRyaXZlcnMvdmlydGlv
L3ZpcnRpby5jIHwgMiArLQo+ICAgMSBmaWxlIGNoYW5nZWQsIDEgaW5zZXJ0aW9uKCspLCAxIGRl
bGV0aW9uKC0pCj4KPiBkaWZmIC0tZ2l0IGEvZHJpdmVycy92aXJ0aW8vdmlydGlvLmMgYi9kcml2
ZXJzL3ZpcnRpby92aXJ0aW8uYwo+IGluZGV4IDRiMTVjMDBjMGEwYS4uYTE1YmViNmI1OTNiIDEw
MDY0NAo+IC0tLSBhL2RyaXZlcnMvdmlydGlvL3ZpcnRpby5jCj4gKysrIGIvZHJpdmVycy92aXJ0
aW8vdmlydGlvLmMKPiBAQCAtMzM4LDcgKzMzOCw3IEBAIGludCByZWdpc3Rlcl92aXJ0aW9fZGV2
aWNlKHN0cnVjdCB2aXJ0aW9fZGV2aWNlICpkZXYpCj4gICAJLyogQXNzaWduIGEgdW5pcXVlIGRl
dmljZSBpbmRleCBhbmQgaGVuY2UgbmFtZS4gKi8KPiAgIAllcnIgPSBpZGFfc2ltcGxlX2dldCgm
dmlydGlvX2luZGV4X2lkYSwgMCwgMCwgR0ZQX0tFUk5FTCk7Cj4gICAJaWYgKGVyciA8IDApCj4g
LQkJZ290byBvdXQ7Cj4gKwkJcmV0dXJuIGVycjsKPiAgIAo+ICAgCWRldi0+aW5kZXggPSBlcnI7
Cj4gICAJZGV2X3NldF9uYW1lKCZkZXYtPmRldiwgInZpcnRpbyV1IiwgZGV2LT5pbmRleCk7Cgpf
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fXwpWaXJ0dWFsaXph
dGlvbiBtYWlsaW5nIGxpc3QKVmlydHVhbGl6YXRpb25AbGlzdHMubGludXgtZm91bmRhdGlvbi5v
cmcKaHR0cHM6Ly9saXN0cy5saW51eGZvdW5kYXRpb24ub3JnL21haWxtYW4vbGlzdGluZm8vdmly
dHVhbGl6YXRpb24=
