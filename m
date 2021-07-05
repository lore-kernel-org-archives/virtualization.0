Return-Path: <SRS0=2LZG=L5=lists.linux-foundation.org=virtualization-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4B47CC07E98
	for <virtualization@archiver.kernel.org>; Mon,  5 Jul 2021 03:48:54 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E10D8613C2
	for <virtualization@archiver.kernel.org>; Mon,  5 Jul 2021 03:48:53 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E10D8613C2
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=virtualization-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id AA51540292;
	Mon,  5 Jul 2021 03:48:53 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
	by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id pZbKzcAAw0wn; Mon,  5 Jul 2021 03:48:52 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp4.osuosl.org (Postfix) with ESMTPS id 1023A40284;
	Mon,  5 Jul 2021 03:48:52 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id E1D92C001A;
	Mon,  5 Jul 2021 03:48:51 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [IPv6:2605:bc80:3010::137])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 5F7C3C000E
 for <virtualization@lists.linux-foundation.org>;
 Mon,  5 Jul 2021 03:48:50 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id 406F140292
 for <virtualization@lists.linux-foundation.org>;
 Mon,  5 Jul 2021 03:48:50 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id 2DlTWpZbrKg8
 for <virtualization@lists.linux-foundation.org>;
 Mon,  5 Jul 2021 03:48:49 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.133.124])
 by smtp4.osuosl.org (Postfix) with ESMTPS id 7265A40284
 for <virtualization@lists.linux-foundation.org>;
 Mon,  5 Jul 2021 03:48:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1625456928;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=25P6+qOObwDiaurdWnfUZ/5fIR3I7PXs4U3cGO2pDNQ=;
 b=ZxfKnzuUsmBJ24UVTsrzkAeYBQNnDiNzUV/bqxYppgDq1SU3RyEdzt0Se4hoHuUpnk4G1x
 Gltq3yKVXEelmzk5iBAO35A5/LKb2D4RbY1O6zdlmoHUos8D9oOYnEXkUw36XZInZOIaid
 +p05T5anyVxz+wzT9RmF1sq4ZNfyDLQ=
Received: from mail-pj1-f71.google.com (mail-pj1-f71.google.com
 [209.85.216.71]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-390-T57OEjztPACilk46oUJMRg-1; Sun, 04 Jul 2021 23:48:47 -0400
X-MC-Unique: T57OEjztPACilk46oUJMRg-1
Received: by mail-pj1-f71.google.com with SMTP id
 a1-20020a17090abe01b0290172d0fe9a9eso1882885pjs.2
 for <virtualization@lists.linux-foundation.org>;
 Sun, 04 Jul 2021 20:48:46 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-transfer-encoding
 :content-language;
 bh=25P6+qOObwDiaurdWnfUZ/5fIR3I7PXs4U3cGO2pDNQ=;
 b=k7v8YtYCL/ww1BQ/6ax81VB5Qvz9udeWHt/Lwhn7IU8Y2uAL6cbAJW8/NQqB5IWFaf
 JJYzycv3qYiMF2b3oazoqmcZl9dAxezkvjEH2bv1SoiKGoazJNbfoe9NZFlTX7i/5s9Z
 JS0v1JNaN8rMJ626IE6FwLkhgJIwJ9yuoO/QTJAxgep9nSZEYHRJEnCtbnKLLr00mq+y
 VJEm41AMxeNCjbwXp07Bww6CHeHoZWYrX5Ahqy0AQi3of4OCmgOTskc2yudlmEe5HEfm
 bjf/RDxf+qAFzb24B8US5MmhJnolRXIwoKGp7qvASHnwhbKEhKKnX92LiB/juuNEVs3X
 6R4w==
X-Gm-Message-State: AOAM531T/VyECqk0afnmGuqZdPIxNGN4FS+sZU9bcR4n9CRtTGk71yNJ
 uuwPzjkTAJzZUlScpmvKyOtZuhlDQOrJFsqGf2EgSVnqsbW8y+nZuSQdbsplcsUlcB9RVWH4HqP
 zxcX0S+qoUqpFXXyqZKCYYhx2pQHyIatJOrznP6TJTg==
X-Received: by 2002:a63:f955:: with SMTP id q21mr13651928pgk.448.1625456925971; 
 Sun, 04 Jul 2021 20:48:45 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJxh+8a0lcafys7ntL0qYOJsYQ0uxw1HqHLN2/UyNlqrNDJW0H4QdQRaegwbRorAJ1FTbNPV1A==
X-Received: by 2002:a63:f955:: with SMTP id q21mr13651917pgk.448.1625456925713; 
 Sun, 04 Jul 2021 20:48:45 -0700 (PDT)
Received: from wangxiaodeMacBook-Air.local ([209.132.188.80])
 by smtp.gmail.com with ESMTPSA id f193sm2380694pfa.185.2021.07.04.20.48.42
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Sun, 04 Jul 2021 20:48:45 -0700 (PDT)
Subject: Re: [RFC PATCH] vhost-vdpa: mark vhost device invalid to reflect vdpa
 device unregistration
To: gautam.dawar@xilinx.com
References: <20210704205205.6132-1-gdawar@xilinx.com>
From: Jason Wang <jasowang@redhat.com>
Message-ID: <3d02b8f5-0a6b-e8d1-533d-8503da3fcc4e@redhat.com>
Date: Mon, 5 Jul 2021 11:48:36 +0800
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:78.0)
 Gecko/20100101 Thunderbird/78.11.0
MIME-Version: 1.0
In-Reply-To: <20210704205205.6132-1-gdawar@xilinx.com>
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=jasowang@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Language: en-US
Cc: kvm@vger.kernel.org, "Michael S. Tsirkin" <mst@redhat.com>,
 netdev@vger.kernel.org, linux-kernel@vger.kernel.org, gdawar@xilinx.com,
 virtualization@lists.linux-foundation.org, martinh@xilinx.com,
 hanand@xilinx.com
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

CtTaIDIwMjEvNy81IMnPzuc0OjUyLCBnYXV0YW0uZGF3YXJAeGlsaW54LmNvbSDQtLXAOgo+ICAg
CXZtYS0+dm1fcGFnZV9wcm90ID0gcGdwcm90X25vbmNhY2hlZCh2bWEtPnZtX3BhZ2VfcHJvdCk7
Cj4gQEAgLTEwOTEsMTEgKzExMjIsMTMgQEAgc3RhdGljIHZvaWQgdmhvc3RfdmRwYV9yZW1vdmUo
c3RydWN0IHZkcGFfZGV2aWNlICp2ZHBhKQo+ICAgCQlvcGVuZWQgPSBhdG9taWNfY21weGNoZygm
di0+b3BlbmVkLCAwLCAxKTsKPiAgIAkJaWYgKCFvcGVuZWQpCj4gICAJCQlicmVhazsKPiAtCQl3
YWl0X2Zvcl9jb21wbGV0aW9uX3RpbWVvdXQoJnYtPmNvbXBsZXRpb24sCj4gLQkJCQkJICAgIG1z
ZWNzX3RvX2ppZmZpZXMoMTAwMCkpOwo+IC0JCWRldl93YXJuX29uY2UoJnYtPmRldiwKPiAtCQkJ
ICAgICAgIiVzIHdhaXRpbmcgZm9yL2Rldi8lcyB0byBiZSBjbG9zZWRcbiIsCj4gLQkJCSAgICAg
IF9fZnVuY19fLCBkZXZfbmFtZSgmdi0+ZGV2KSk7Cj4gKwkJaWYgKCF3YWl0X2Zvcl9jb21wbGV0
aW9uX3RpbWVvdXQoJnYtPmNvbXBsZXRpb24sCj4gKwkJCQkJICAgIG1zZWNzX3RvX2ppZmZpZXMo
MTAwMCkpKSB7Cj4gKwkJCWRldl93YXJuKCZ2LT5kZXYsCj4gKwkJCQkgIiVzL2Rldi8lcyBpbiB1
c2UsIGNvbnRpbnVlLi5cbiIsCj4gKwkJCQkgX19mdW5jX18sIGRldl9uYW1lKCZ2LT5kZXYpKTsK
PiArCQkJYnJlYWs7Cj4gKwkJfQo+ICAgCX0gd2hpbGUgKDEpOwo+ICAgCj4gICAJcHV0X2Rldmlj
ZSgmdi0+ZGV2KTsKPiArCXYtPmRldl9pbnZhbGlkID0gdHJ1ZTsKCgpCZXNpZGVzIHRoZSBtYXBw
aW5nIGhhbmRsaW5nIG1lbnRpb25lZCBieSBNaWNoYWVsLiBJIHRoaW5rIHRoaXMgY2FuIGxlYWQg
CnVzZS1hZnRlci1mcmVlLiBwdXRfZGV2aWNlIG1heSByZWxlYXNlIHRoZSBtZW1vcnkuCgpBbm90
aGVyIGZ1bmRhbWVudGFsIGlzc3VlLCB2RFBBIGlzIHRoZSBwYXJlbnQgb2Ygdmhvc3QtdkRQQSBk
ZXZpY2UuIEknbSAKbm90IHN1cmUgdGhlIGRldmljZSBjb3JlIGNhbiBhbGxvdyB0aGUgcGFyZW50
IHRvIGdvIGF3YXkgZmlyc3QuCgpUaGFua3MKCgpfX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fXwpWaXJ0dWFsaXphdGlvbiBtYWlsaW5nIGxpc3QKVmlydHVhbGl6
YXRpb25AbGlzdHMubGludXgtZm91bmRhdGlvbi5vcmcKaHR0cHM6Ly9saXN0cy5saW51eGZvdW5k
YXRpb24ub3JnL21haWxtYW4vbGlzdGluZm8vdmlydHVhbGl6YXRpb24=
