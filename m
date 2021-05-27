Return-Path: <SRS0=l/A6=KW=lists.linux-foundation.org=virtualization-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.1 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1A49FC4707F
	for <virtualization@archiver.kernel.org>; Thu, 27 May 2021 04:13:17 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B038E613B0
	for <virtualization@archiver.kernel.org>; Thu, 27 May 2021 04:13:16 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B038E613B0
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=virtualization-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 5948183BBE;
	Thu, 27 May 2021 04:13:16 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
	by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id aVbU0haC4LtX; Thu, 27 May 2021 04:13:15 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp1.osuosl.org (Postfix) with ESMTP id 12AD783B75;
	Thu, 27 May 2021 04:13:15 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id E9E91C000D;
	Thu, 27 May 2021 04:13:14 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [IPv6:2605:bc80:3010::136])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 6B8F2C0001
 for <virtualization@lists.linux-foundation.org>;
 Thu, 27 May 2021 04:13:14 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id 51762605D8
 for <virtualization@lists.linux-foundation.org>;
 Thu, 27 May 2021 04:13:14 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp3.osuosl.org (amavisd-new);
 dkim=pass (1024-bit key) header.d=redhat.com
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id wNANx2x5RVmA
 for <virtualization@lists.linux-foundation.org>;
 Thu, 27 May 2021 04:13:13 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.133.124])
 by smtp3.osuosl.org (Postfix) with ESMTPS id A77C16069C
 for <virtualization@lists.linux-foundation.org>;
 Thu, 27 May 2021 04:13:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1622088792;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=q3igEycLd8J73C7Vxb8Ui44QuvOprk+cULPfcPtYoIg=;
 b=QFdc+ari0AIkQho7ZuWviXnT6YLKKHox7vh4d/LpQ7EaRavPHH0nekqPuTcJEIztGRMmuV
 SXATnMWMK4sDVnHvVXgpJFQAe5RByazoRNWWOxzVEagnHCOwcAZ50xNFfv6JE+m4SO29u9
 t/U+pFUY8xRs4sIZ3hoWB37rjK81GuE=
Received: from mail-pl1-f200.google.com (mail-pl1-f200.google.com
 [209.85.214.200]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-386-TjWx-bssMuWyeKDRf6QczQ-1; Thu, 27 May 2021 00:13:08 -0400
X-MC-Unique: TjWx-bssMuWyeKDRf6QczQ-1
Received: by mail-pl1-f200.google.com with SMTP id
 m12-20020a170902f20cb02900ef9c8577c4so1659925plc.19
 for <virtualization@lists.linux-foundation.org>;
 Wed, 26 May 2021 21:13:08 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-transfer-encoding
 :content-language;
 bh=q3igEycLd8J73C7Vxb8Ui44QuvOprk+cULPfcPtYoIg=;
 b=ZxwxR4h6qdN7IFRQjg2arhPRg4yr0z3Uw2bKn0eQUY4OaRuo0oF9fFBjCqAx6yI6Ex
 nn1gzuhK/p9UluiH8Zjce0fFpWEzXDkqw+lPykTiF2fDrnIgj/FyXcmOUvdqAopFg1rA
 ND+nUbK7f73XLmSBOBjEI10No1MEWst3E5t3JKIiNX1/LnbEi3EFcX5FtozTuDywC2bP
 jUNTtiRG3K537z3Q3sbPIR8GzzttycZ9rfOgIhf9T/9nhtOjMCKXxfiiF4egmm8Tu3KJ
 jr2RFYKiaY0FZ9m+vuYEj4jKhyzl1qNoAPuZKHa99d46QCMptQd2ahU38BuOtPqSisXU
 fcjQ==
X-Gm-Message-State: AOAM533p3tsslMfS2DJ2wfYr1L+979aBDCd42I/oR7Xb4rnkNSLgDKyP
 ZhiXcIrOi5d9Yrl3YD3JxO8RTAzB01RAwIs7KJWywPxMEKo61YI+qRyj+Y8AeFo5jXJPkIVBHOb
 ewKmpCKyy0wjeuA0vK3N0GzRC1GgYAtrDLf/DacjLtA==
X-Received: by 2002:a63:3c0e:: with SMTP id j14mr1842308pga.427.1622088787571; 
 Wed, 26 May 2021 21:13:07 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJzNWCYMnMC1HxMoP07R/3S3m3jilU3dNCIEmruTMAtVdxqR2yiJbYdkUNhO/NZQxyTwe/4ddA==
X-Received: by 2002:a63:3c0e:: with SMTP id j14mr1842274pga.427.1622088787269; 
 Wed, 26 May 2021 21:13:07 -0700 (PDT)
Received: from wangxiaodeMacBook-Air.local ([209.132.188.80])
 by smtp.gmail.com with ESMTPSA id c134sm622801pfb.135.2021.05.26.21.13.00
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 26 May 2021 21:13:06 -0700 (PDT)
Subject: Re: [PATCH v7 11/12] vduse: Introduce VDUSE - vDPA Device in Userspace
To: Xie Yongji <xieyongji@bytedance.com>, mst@redhat.com,
 stefanha@redhat.com, sgarzare@redhat.com, parav@nvidia.com,
 hch@infradead.org, christian.brauner@canonical.com, rdunlap@infradead.org,
 willy@infradead.org, viro@zeniv.linux.org.uk, axboe@kernel.dk,
 bcrl@kvack.org, corbet@lwn.net, mika.penttila@nextfour.com,
 dan.carpenter@oracle.com, joro@8bytes.org
References: <20210517095513.850-1-xieyongji@bytedance.com>
 <20210517095513.850-12-xieyongji@bytedance.com>
From: Jason Wang <jasowang@redhat.com>
Message-ID: <3740c7eb-e457-07f3-5048-917c8606275d@redhat.com>
Date: Thu, 27 May 2021 12:12:58 +0800
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:78.0)
 Gecko/20100101 Thunderbird/78.10.2
MIME-Version: 1.0
In-Reply-To: <20210517095513.850-12-xieyongji@bytedance.com>
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=jasowang@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Language: en-US
Cc: kvm@vger.kernel.org, netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
 virtualization@lists.linux-foundation.org, iommu@lists.linux-foundation.org,
 linux-fsdevel@vger.kernel.org
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

CtTaIDIwMjEvNS8xNyDPws7nNTo1NSwgWGllIFlvbmdqaSDQtLXAOgo+ICsKPiArc3RhdGljIGlu
dCB2ZHVzZV9kZXZfbXNnX3N5bmMoc3RydWN0IHZkdXNlX2RldiAqZGV2LAo+ICsJCQkgICAgICBz
dHJ1Y3QgdmR1c2VfZGV2X21zZyAqbXNnKQo+ICt7Cj4gKwlpbml0X3dhaXRxdWV1ZV9oZWFkKCZt
c2ctPndhaXRxKTsKPiArCXNwaW5fbG9jaygmZGV2LT5tc2dfbG9jayk7Cj4gKwl2ZHVzZV9lbnF1
ZXVlX21zZygmZGV2LT5zZW5kX2xpc3QsIG1zZyk7Cj4gKwl3YWtlX3VwKCZkZXYtPndhaXRxKTsK
PiArCXNwaW5fdW5sb2NrKCZkZXYtPm1zZ19sb2NrKTsKPiArCXdhaXRfZXZlbnRfa2lsbGFibGUo
bXNnLT53YWl0cSwgbXNnLT5jb21wbGV0ZWQpOwoKCldoYXQgaGFwcGVucyBpZiB0aGUgdXNlcnNw
YWNlKG1hbGljb3VzKSBkb2Vzbid0IGdpdmUgYSByZXNwb25zZSBmb3JldmVyPwoKSXQgbG9va3Mg
bGlrZSBhIERPUy4gSWYgeWVzLCB3ZSBuZWVkIHRvIGNvbnNpZGVyIGEgd2F5IHRvIGZpeCB0aGF0
LgoKVGhhbmtzCgoKPiArCXNwaW5fbG9jaygmZGV2LT5tc2dfbG9jayk7Cj4gKwlpZiAoIW1zZy0+
Y29tcGxldGVkKSB7Cj4gKwkJbGlzdF9kZWwoJm1zZy0+bGlzdCk7Cj4gKwkJbXNnLT5yZXNwLnJl
c3VsdCA9IFZEVVNFX1JFUVVFU1RfRkFJTEVEOwo+ICsJfQo+ICsJc3Bpbl91bmxvY2soJmRldi0+
bXNnX2xvY2spOwo+ICsKPiArCXJldHVybiAobXNnLT5yZXNwLnJlc3VsdCA9PSBWRFVTRV9SRVFV
RVNUX09LKSA/IDAgOiAtMTsKPiArfQoKX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX18KVmlydHVhbGl6YXRpb24gbWFpbGluZyBsaXN0ClZpcnR1YWxpemF0aW9u
QGxpc3RzLmxpbnV4LWZvdW5kYXRpb24ub3JnCmh0dHBzOi8vbGlzdHMubGludXhmb3VuZGF0aW9u
Lm9yZy9tYWlsbWFuL2xpc3RpbmZvL3ZpcnR1YWxpemF0aW9u
