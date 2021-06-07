Return-Path: <SRS0=jANb=LB=lists.linux-foundation.org=virtualization-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.1 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7475FC4743D
	for <virtualization@archiver.kernel.org>; Mon,  7 Jun 2021 02:24:03 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id EC61A61164
	for <virtualization@archiver.kernel.org>; Mon,  7 Jun 2021 02:24:02 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org EC61A61164
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=virtualization-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id AA57A605A0;
	Mon,  7 Jun 2021 02:24:02 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
	by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id 2WMJHh9P850F; Mon,  7 Jun 2021 02:23:59 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp3.osuosl.org (Postfix) with ESMTP id 60D47605AD;
	Mon,  7 Jun 2021 02:23:58 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 27D0CC000E;
	Mon,  7 Jun 2021 02:23:58 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 7411BC0001
 for <virtualization@lists.linux-foundation.org>;
 Mon,  7 Jun 2021 02:23:56 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id 4E62C40015
 for <virtualization@lists.linux-foundation.org>;
 Mon,  7 Jun 2021 02:23:56 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp2.osuosl.org (amavisd-new);
 dkim=pass (1024-bit key) header.d=redhat.com
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id fjMPoG7Plgqr
 for <virtualization@lists.linux-foundation.org>;
 Mon,  7 Jun 2021 02:23:52 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [216.205.24.124])
 by smtp2.osuosl.org (Postfix) with ESMTPS id 716E8401D6
 for <virtualization@lists.linux-foundation.org>;
 Mon,  7 Jun 2021 02:23:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1623032631;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=gKXQKEfV2Z4yTGR8/n9HJ/fY1JTpc1iMUdaLmNCWqcU=;
 b=ThkXph0C7ImxLiVfE+goXo9YZ7a3RgKsuovrDLyiMCAr+XQoF/JpRkLpe+m/+oZll8s1Md
 GsmYgDLv6T+nxoL6pBxUyONhb/+rsmjK/kp+mhROq2s91k/pjiQ3yS+NesjequUB3Gkc/6
 7roZmdghGTzMyi2qiOCdtpXsFWSXczo=
Received: from mail-pl1-f199.google.com (mail-pl1-f199.google.com
 [209.85.214.199]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-147-FFbcH266NMa52O08kTfqdw-1; Sun, 06 Jun 2021 22:23:47 -0400
X-MC-Unique: FFbcH266NMa52O08kTfqdw-1
Received: by mail-pl1-f199.google.com with SMTP id
 p11-20020a1709028a8bb029010f3d701dfaso3754092plo.5
 for <virtualization@lists.linux-foundation.org>;
 Sun, 06 Jun 2021 19:23:47 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-transfer-encoding
 :content-language;
 bh=gKXQKEfV2Z4yTGR8/n9HJ/fY1JTpc1iMUdaLmNCWqcU=;
 b=Pie6dKt2APrUN1p21cVVMpK8NNkd+qQJgAxmLpRTQ2WAd2Q0VTkKucIMKZ3LMyjRdP
 Kmcv/axzTklUJpL7T8ROQLrpH8iaSN+enD7Oq4wQEFGouqo4OgzLN2si0fV9VWIuMISY
 fhXpDrnSd9c43z8EAYT7K0I0VBWfiRgpynzYX8RKAP7uWlbYgQ4dJac+TD4pN4lvFCbV
 AlO4k8ulbARA+PGQseh2HyxARSV5yoL/sXmbJSeJykMB0BN2JhPKLa+dwLJTMDYD9ei6
 OCjEj38+GNvu81yDSA5kfSpWkPTxj8SApPeg1Fy5RzWErWn9oXRatO/F5lb3Swoa/HeE
 pV+g==
X-Gm-Message-State: AOAM532aEABizeqqxUGjdRwEbAODnH2SodIqUx/9mCQpMqwT1DI+5X2Y
 9J+azgc28YN1Z3LBB8Kcp2zekcfO+aBpjkUu7XgkoIBZxc+9W51VGMLhzebnClHz0E4ToK0VaVW
 ojBGXCRQZGV6qcSgoZnYqyErxr0JZuLaphdxhRiikZA==
X-Received: by 2002:a17:902:a5c4:b029:111:18bd:8b9a with SMTP id
 t4-20020a170902a5c4b029011118bd8b9amr7788415plq.80.1623032626537; 
 Sun, 06 Jun 2021 19:23:46 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJz4hl64MAtqUwyJpFoEpAwj72OAst9tSIBLMe3jlFWSYqIDArB4IxgsQ4l52vekWbHlXbl3CQ==
X-Received: by 2002:a17:902:a5c4:b029:111:18bd:8b9a with SMTP id
 t4-20020a170902a5c4b029011118bd8b9amr7788408plq.80.1623032626311; 
 Sun, 06 Jun 2021 19:23:46 -0700 (PDT)
Received: from wangxiaodeMacBook-Air.local ([209.132.188.80])
 by smtp.gmail.com with ESMTPSA id p1sm2741244pfn.212.2021.06.06.19.23.43
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Sun, 06 Jun 2021 19:23:45 -0700 (PDT)
Subject: Re: [PATCH] vdpa: fix error code in vp_vdpa_probe()
To: Dan Carpenter <dan.carpenter@oracle.com>,
 "Michael S. Tsirkin" <mst@redhat.com>
References: <YLtyYE8TinOl3IhO@mwanda>
From: Jason Wang <jasowang@redhat.com>
Message-ID: <696c510d-b9af-60a4-e517-b2f749a10f41@redhat.com>
Date: Mon, 7 Jun 2021 10:23:38 +0800
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:78.0)
 Gecko/20100101 Thunderbird/78.11.0
MIME-Version: 1.0
In-Reply-To: <YLtyYE8TinOl3IhO@mwanda>
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=jasowang@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Language: en-US
Cc: Eli Cohen <elic@nvidia.com>, virtualization@lists.linux-foundation.org,
 kernel-janitors@vger.kernel.org
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

CtTaIDIwMjEvNi81IM/Czuc4OjQ3LCBEYW4gQ2FycGVudGVyINC0tcA6Cj4gUmV0dXJuIC1FTk9N
RU0gaWYgdnBfbW9kZXJuX21hcF92cV9ub3RpZnkoKSBmYWlscy4gIEN1cnJlbnRseSBpdAo+IHJl
dHVybnMgc3VjY2Vzcy4KPgo+IEZpeGVzOiAxMWQ4ZmZlZDAwYjIgKCJ2cF92ZHBhOiBzd2l0Y2gg
dG8gdXNlIHZwX21vZGVybl9tYXBfdnFfbm90aWZ5KCkiKQo+IFNpZ25lZC1vZmYtYnk6IERhbiBD
YXJwZW50ZXIgPGRhbi5jYXJwZW50ZXJAb3JhY2xlLmNvbT4KPiAtLS0KPiAgIGRyaXZlcnMvdmRw
YS92aXJ0aW9fcGNpL3ZwX3ZkcGEuYyB8IDEgKwo+ICAgMSBmaWxlIGNoYW5nZWQsIDEgaW5zZXJ0
aW9uKCspCgoKQWNrZWQtYnk6IEphc29uIFdhbmcgPGphc293YW5nQHJlZGhhdC5jb20+CgpUaGFu
a3MKCgo+Cj4gZGlmZiAtLWdpdCBhL2RyaXZlcnMvdmRwYS92aXJ0aW9fcGNpL3ZwX3ZkcGEuYyBi
L2RyaXZlcnMvdmRwYS92aXJ0aW9fcGNpL3ZwX3ZkcGEuYwo+IGluZGV4IGM3NmViYjUzMTIxMi4u
ZTVkOTJkYjcyOGQzIDEwMDY0NAo+IC0tLSBhL2RyaXZlcnMvdmRwYS92aXJ0aW9fcGNpL3ZwX3Zk
cGEuYwo+ICsrKyBiL2RyaXZlcnMvdmRwYS92aXJ0aW9fcGNpL3ZwX3ZkcGEuYwo+IEBAIC00NDIs
NiArNDQyLDcgQEAgc3RhdGljIGludCB2cF92ZHBhX3Byb2JlKHN0cnVjdCBwY2lfZGV2ICpwZGV2
LCBjb25zdCBzdHJ1Y3QgcGNpX2RldmljZV9pZCAqaWQpCj4gICAJCQl2cF9tb2Rlcm5fbWFwX3Zx
X25vdGlmeShtZGV2LCBpLAo+ICAgCQkJCQkJJnZwX3ZkcGEtPnZyaW5nW2ldLm5vdGlmeV9wYSk7
Cj4gICAJCWlmICghdnBfdmRwYS0+dnJpbmdbaV0ubm90aWZ5KSB7Cj4gKwkJCXJldCA9IC1FTk9N
RU07Cj4gICAJCQlkZXZfd2FybigmcGRldi0+ZGV2LCAiRmFpbCB0byBtYXAgdnEgbm90aWZ5ICVk
XG4iLCBpKTsKPiAgIAkJCWdvdG8gZXJyOwo+ICAgCQl9CgpfX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fXwpWaXJ0dWFsaXphdGlvbiBtYWlsaW5nIGxpc3QKVmly
dHVhbGl6YXRpb25AbGlzdHMubGludXgtZm91bmRhdGlvbi5vcmcKaHR0cHM6Ly9saXN0cy5saW51
eGZvdW5kYXRpb24ub3JnL21haWxtYW4vbGlzdGluZm8vdmlydHVhbGl6YXRpb24=
