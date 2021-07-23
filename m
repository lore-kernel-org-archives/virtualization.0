Return-Path: <SRS0=XE2Y=MP=lists.linux-foundation.org=virtualization-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 85EBEC4338F
	for <virtualization@archiver.kernel.org>; Fri, 23 Jul 2021 02:38:04 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 3124E60EBE
	for <virtualization@archiver.kernel.org>; Fri, 23 Jul 2021 02:38:04 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org 3124E60EBE
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id E102D607B1;
	Fri, 23 Jul 2021 02:38:03 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
	by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id nCCfTUHWemL2; Fri, 23 Jul 2021 02:38:03 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp3.osuosl.org (Postfix) with ESMTPS id A627D60687;
	Fri, 23 Jul 2021 02:38:02 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 7CE20C0010;
	Fri, 23 Jul 2021 02:38:02 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 9AA07C000E
 for <virtualization@lists.linux-foundation.org>;
 Fri, 23 Jul 2021 02:38:00 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id 8FF90400C5
 for <virtualization@lists.linux-foundation.org>;
 Fri, 23 Jul 2021 02:38:00 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp2.osuosl.org (amavisd-new);
 dkim=pass (1024-bit key) header.d=redhat.com
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id MbXaO3FVdTUo
 for <virtualization@lists.linux-foundation.org>;
 Fri, 23 Jul 2021 02:37:59 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [216.205.24.124])
 by smtp2.osuosl.org (Postfix) with ESMTPS id 8A45F40004
 for <virtualization@lists.linux-foundation.org>;
 Fri, 23 Jul 2021 02:37:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1627007878;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=1rAHkowzhRTNODmA2xzrXs4xnS5a/p+YbDc7CuCoR4k=;
 b=XvttFXO9Q0nApEEwLVSKsUaAn9aci1d5WDGY9qcM4UtoEJa8YQBJNCtztfiZPf0FtVwejT
 Zvk+CnytGv38lDj/B2a2b9sdIJCR0GE7a/sPiZhsHbSOG6Yf29Sl2HWyNoqnEn3t1acWp1
 zZBIO819Zm9OLnUAqc6GDVPYd4NfoJY=
Received: from mail-pj1-f70.google.com (mail-pj1-f70.google.com
 [209.85.216.70]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-9-Ar5qqnbrP3qQxBOEfXEXHQ-1; Thu, 22 Jul 2021 22:37:57 -0400
X-MC-Unique: Ar5qqnbrP3qQxBOEfXEXHQ-1
Received: by mail-pj1-f70.google.com with SMTP id
 b4-20020a17090a8004b02901703601b0afso4816028pjn.9
 for <virtualization@lists.linux-foundation.org>;
 Thu, 22 Jul 2021 19:37:56 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-transfer-encoding
 :content-language;
 bh=1rAHkowzhRTNODmA2xzrXs4xnS5a/p+YbDc7CuCoR4k=;
 b=mudRCiyQjxF13MgygbOe7cdQCxeTzhlTQD86oHpOHz/ElPidkPyruWfBIZ5AuKXZnM
 PaxRXwJpMHVEzPqwmm77oXGtoaxREyP3B1mcR+0kizTobp/cuIeHmya4ym9ph1yYU7Zf
 0z6tZaZcVgtFhA3L2F4FNNN8lnyVnoJ7DlUqCEY6NzpibOdMGxeug4BDE0zMVE3+ugpu
 qYnmZ6af5lU03lF0AbjuWBQ1J6uBL9y+NnHSMCGZQofQlYs0WaSy+AHrPbMFaYr0+fmE
 2A9ux48c39GUH6FHLFMxxO7fB+j+dZ1yedel1DVcHYO18rIVgYCXa4nPzqpkTiNNnznu
 Aoow==
X-Gm-Message-State: AOAM533hxpnTxj2AFj+K5eVFABZtXCyDO3NXRMZA9zjZc4bGEmKnwJZt
 yzoHwzJ2lHX7COZqbM8sXdF57O+YHpO6B4U+ZJiIPqpBjJY0rZ9viqZir92zs+CatY2kCqL2weQ
 YOjjlStrWB464S/kbt/v2rU4baTb4oTs1LOzAlhSnVTRkA4HS8fUXv2zcltgWVyPBzk2gWf8DBZ
 SxgEjbrBx9vESnr11/jA==
X-Received: by 2002:a17:903:2451:b029:12b:3feb:a3ce with SMTP id
 l17-20020a1709032451b029012b3feba3cemr2096443pls.83.1627007875824; 
 Thu, 22 Jul 2021 19:37:55 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJwx3QmxybqnGUbIjcCLRn8qW229KUMR/WGbymHZ72BTCoYtOX0SbHBOwwnPeK2gxrDUe0zdiw==
X-Received: by 2002:a17:903:2451:b029:12b:3feb:a3ce with SMTP id
 l17-20020a1709032451b029012b3feba3cemr2096414pls.83.1627007875411; 
 Thu, 22 Jul 2021 19:37:55 -0700 (PDT)
Received: from wangxiaodeMacBook-Air.local ([209.132.188.80])
 by smtp.gmail.com with ESMTPSA id d2sm32177260pfa.84.2021.07.22.19.37.52
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 22 Jul 2021 19:37:54 -0700 (PDT)
Subject: Re: PROBLEM: virtio_net LRO kernel panics
To: Ivan <ivan@prestigetransportation.com>,
 Tonghao Zhang <xiangxia.m.yue@gmail.com>
References: <CACFia2dwacaVVYD+1uG=CDGaJqdCOSBvZ5FcXp04caecaWAY3w@mail.gmail.com>
 <CAMDZJNXthLpAPHn62gA1qSmfLOoDFcFGdgnNwW6yA+wjn0FjgQ@mail.gmail.com>
 <CACFia2fDZHUZB5wJ7LK8M2sv_+W58rHw0NzzrwPPoX9=s7yPdQ@mail.gmail.com>
From: Jason Wang <jasowang@redhat.com>
Message-ID: <9547a9e5-738c-2009-a2af-66173d305c2d@redhat.com>
Date: Fri, 23 Jul 2021 10:37:47 +0800
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:78.0)
 Gecko/20100101 Thunderbird/78.12.0
MIME-Version: 1.0
In-Reply-To: <CACFia2fDZHUZB5wJ7LK8M2sv_+W58rHw0NzzrwPPoX9=s7yPdQ@mail.gmail.com>
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=jasowang@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Language: en-US
Cc: Willem de Bruijn <willemb@google.com>,
 virtualization@lists.linux-foundation.org,
 "David S. Miller" <davem@davemloft.net>, "Michael S. Tsirkin" <mst@redhat.com>
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

CuWcqCAyMDIxLzcvMjMg5LiK5Y2IOTo0MCwgSXZhbiDlhpnpgZM6Cj4gT24gVGh1LCBKdWwgMjIs
IDIwMjEgYXQgODoyOCBQTSBUb25naGFvIFpoYW5nPHhpYW5neGlhLm0ueXVlQGdtYWlsLmNvbT4g
IHdyb3RlOgo+PiB3aGF0IGlzIHlvdXIga2VybmVsIHZlcnNpb24sIGFuZCBmZWF0dXJlcyBvZiB5
b3VyIG5ldGRldmljZQo+IEN1cnJlbnRseSwgNS4xMy40LiAgQnV0IEkgYWxzbyB0ZXN0ZWQgd2l0
aCBrZXJuZWxzIGJhY2sgdG8gNS4xMCwgYW5kCj4gaXQgYWx3YXlzIHBhbmljcy4gIEkgYWxzbyBk
b3dubG9hZGVkIHRoZSBzdG9jayBnZW5lcmljIGtlcm5lbCBmcm9tCj4gU2xhY2t3YXJlLCBhbmQg
aXQgdG9vIHBhbmlja2VkLgo+Cj4gMCByb290QE51UmFpZDp+IyBldGh0b29sIC1rIGV0aDAKPiBG
ZWF0dXJlcyBmb3IgZXRoMDoKPiByeC1jaGVja3N1bW1pbmc6IG9uIFtmaXhlZF0KPiB0eC1jaGVj
a3N1bW1pbmc6IG9uCj4gICAgICAgICAgdHgtY2hlY2tzdW0taXB2NDogb2ZmIFtmaXhlZF0KPiAg
ICAgICAgICB0eC1jaGVja3N1bS1pcC1nZW5lcmljOiBvbgo+ICAgICAgICAgIHR4LWNoZWNrc3Vt
LWlwdjY6IG9mZiBbZml4ZWRdCj4gICAgICAgICAgdHgtY2hlY2tzdW0tZmNvZS1jcmM6IG9mZiBb
Zml4ZWRdCj4gICAgICAgICAgdHgtY2hlY2tzdW0tc2N0cDogb2ZmIFtmaXhlZF0KPiBzY2F0dGVy
LWdhdGhlcjogb24KPiAgICAgICAgICB0eC1zY2F0dGVyLWdhdGhlcjogb24KPiAgICAgICAgICB0
eC1zY2F0dGVyLWdhdGhlci1mcmFnbGlzdDogb2ZmIFtmaXhlZF0KPiB0Y3Atc2VnbWVudGF0aW9u
LW9mZmxvYWQ6IG9uCj4gICAgICAgICAgdHgtdGNwLXNlZ21lbnRhdGlvbjogb24KPiAgICAgICAg
ICB0eC10Y3AtZWNuLXNlZ21lbnRhdGlvbjogb2ZmIFtmaXhlZF0KPiAgICAgICAgICB0eC10Y3At
bWFuZ2xlaWQtc2VnbWVudGF0aW9uOiBvZmYKPiAgICAgICAgICB0eC10Y3A2LXNlZ21lbnRhdGlv
bjogb24KPiBnZW5lcmljLXNlZ21lbnRhdGlvbi1vZmZsb2FkOiBvbgo+IGdlbmVyaWMtcmVjZWl2
ZS1vZmZsb2FkOiBvbgo+IGxhcmdlLXJlY2VpdmUtb2ZmbG9hZDogb24gW2ZpeGVkXQoKCkRvZXMg
aXQgd29yayBpZiB5b3UgdHVybiBvZmYgbHJvIGJlZm9yZSBlbmFibGluZyB0aGUgZm9yd2FyZGlu
Zz8KCkJ0dywgdXNpbmcgTFJPIGZvciB2aXJ0aW8tbmV0IGlzIHN1c3BpY2lvdXMsIGl0J3MgYWN0
dWFsbHkgdGhlIEdTTyBpbiAKdGhlIFJYIHBhdGNoIG5vdCBMUk8uCgpUaGFua3MKCl9fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fClZpcnR1YWxpemF0aW9uIG1h
aWxpbmcgbGlzdApWaXJ0dWFsaXphdGlvbkBsaXN0cy5saW51eC1mb3VuZGF0aW9uLm9yZwpodHRw
czovL2xpc3RzLmxpbnV4Zm91bmRhdGlvbi5vcmcvbWFpbG1hbi9saXN0aW5mby92aXJ0dWFsaXph
dGlvbg==
