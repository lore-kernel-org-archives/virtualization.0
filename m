Return-Path: <SRS0=Cwtm=K6=lists.linux-foundation.org=virtualization-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.7 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F2467C47096
	for <virtualization@archiver.kernel.org>; Fri,  4 Jun 2021 02:21:06 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A4E54613B4
	for <virtualization@archiver.kernel.org>; Fri,  4 Jun 2021 02:21:06 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A4E54613B4
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=virtualization-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 72C536F946;
	Fri,  4 Jun 2021 02:21:06 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
	by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id g79HFhe-mbeP; Fri,  4 Jun 2021 02:21:05 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp3.osuosl.org (Postfix) with ESMTP id 216926F945;
	Fri,  4 Jun 2021 02:21:05 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 12BA8C000D;
	Fri,  4 Jun 2021 02:21:05 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by lists.linuxfoundation.org (Postfix) with ESMTP id C8EF6C0001
 for <virtualization@lists.linux-foundation.org>;
 Fri,  4 Jun 2021 02:21:03 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id AA7236F944
 for <virtualization@lists.linux-foundation.org>;
 Fri,  4 Jun 2021 02:21:03 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id HWkRa7NwC9A0
 for <virtualization@lists.linux-foundation.org>;
 Fri,  4 Jun 2021 02:21:01 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [216.205.24.124])
 by smtp3.osuosl.org (Postfix) with ESMTPS id 0B9406F941
 for <virtualization@lists.linux-foundation.org>;
 Fri,  4 Jun 2021 02:21:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1622773259;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=sDGv4Dsoaj8jObcKvFWN7acvR7gAGphvCAjFAd+6RyQ=;
 b=Bk+whL6gOCtjukr266TsNJCwuzyhjCs8b3VD4z/L/Y4Hb7Lgz0AStr/h/ELXkv5haQTDJa
 L5onyqxJ6+VNLmCP05JiKlR0z3sPnR8fLFhEaU4P9l3RhBiqKUr1uLH17NWjNFKc/YhuqP
 IONJqlJQGb7fTteJT5zqi9wGfa//7g8=
Received: from mail-pl1-f198.google.com (mail-pl1-f198.google.com
 [209.85.214.198]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-561-0iyO6HHOMTOhZscNhX7sPw-1; Thu, 03 Jun 2021 22:20:57 -0400
X-MC-Unique: 0iyO6HHOMTOhZscNhX7sPw-1
Received: by mail-pl1-f198.google.com with SMTP id
 p7-20020a170902e747b02900ef00d14127so2700135plf.23
 for <virtualization@lists.linux-foundation.org>;
 Thu, 03 Jun 2021 19:20:57 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-transfer-encoding
 :content-language;
 bh=sDGv4Dsoaj8jObcKvFWN7acvR7gAGphvCAjFAd+6RyQ=;
 b=HCsMY21OwvUTyi1bSRzGbKF9LCNWC4GmQDEwthqGAZv5Q0Li5KcApg7wQPPHcq6bgp
 TLVsZAGMubKnqdPglk07Mhgn8nXlan02CWv4kZdMmQLSsD07htj1MBdsOrng6kiHVrAI
 KKQjOT0IVbcxPG0f8yUXkpKQjBeA2wUlhh9o5jQajfYjGGyoAmIg38pCvIJ0pUsikddc
 Q9Su9nA+9kCVKaePi9UCsst98CxGvFO0hnW35cmUMK4EXbQ797GrMujA70lGuVDa80bn
 SG8mRJyzKm7lz1piFemyCbtuZGXoiw01SMZnyoV6OY7/8ALPm3/o9cFYL5H4SRs1/c06
 1UFA==
X-Gm-Message-State: AOAM530CBQWuVQscghGjUGUn1zYb+f4MxVlFSrgTwOETND1t9mMo2+a3
 ocpw31eFBKn3WKINCW1c3m63/3UKYr9bawqFbduFUILmehlT1OzMXB/ZElq+fwn8+2+3Nun3VmD
 qwVQpro9znm8hAs0CS16zy1T/FF8/iTsHiDlGBqKXWw==
X-Received: by 2002:aa7:838b:0:b029:2ea:3332:dd8a with SMTP id
 u11-20020aa7838b0000b02902ea3332dd8amr2148781pfm.74.1622773256422; 
 Thu, 03 Jun 2021 19:20:56 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJwjTyiNdr0vKw5aLMjZR3pSm0SArLP4gxhX2YoZbSOpAlakHJNckWN9VSGFZvB4i3+IOypGbA==
X-Received: by 2002:aa7:838b:0:b029:2ea:3332:dd8a with SMTP id
 u11-20020aa7838b0000b02902ea3332dd8amr2148764pfm.74.1622773256185; 
 Thu, 03 Jun 2021 19:20:56 -0700 (PDT)
Received: from wangxiaodeMacBook-Air.local ([209.132.188.80])
 by smtp.gmail.com with ESMTPSA id y4sm294909pfg.112.2021.06.03.19.20.52
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 03 Jun 2021 19:20:55 -0700 (PDT)
Subject: Re: [PATCH v1 1/8] virtio: Force only split mode with protected guest
To: Andy Lutomirski <luto@kernel.org>, Andi Kleen <ak@linux.intel.com>,
 mst@redhat.com
References: <20210603004133.4079390-1-ak@linux.intel.com>
 <20210603004133.4079390-2-ak@linux.intel.com>
 <cc5c8265-83f7-aeb1-bc30-3367fe68bc97@kernel.org>
From: Jason Wang <jasowang@redhat.com>
Message-ID: <80df3032-3775-b2c1-f3e6-91eb459df620@redhat.com>
Date: Fri, 4 Jun 2021 10:20:47 +0800
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:78.0)
 Gecko/20100101 Thunderbird/78.10.2
MIME-Version: 1.0
In-Reply-To: <cc5c8265-83f7-aeb1-bc30-3367fe68bc97@kernel.org>
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

CuWcqCAyMDIxLzYvNCDkuIrljYgxOjMzLCBBbmR5IEx1dG9taXJza2kg5YaZ6YGTOgo+IE9uIDYv
Mi8yMSA1OjQxIFBNLCBBbmRpIEtsZWVuIHdyb3RlOgo+PiBPbmx5IGFsbG93IHNwbGl0IG1vZGUg
d2hlbiBpbiBhIHByb3RlY3RlZCBndWVzdC4gRm9sbG93b24KPj4gcGF0Y2hlcyBoYXJkZW4gdGhl
IHNwbGl0IG1vZGUgY29kZSBwYXRocywgYW5kIHdlIGRvbid0IHdhbnQKPj4gYW4gbWFsaWNpb3Vz
IGhvc3QgdG8gZm9yY2UgYW55dGhpbmcgZWxzZS4gQWxzbyBkaXNhbGxvdwo+PiBpbmRpcmVjdCBt
b2RlIGZvciBzaW1pbGFyIHJlYXNvbnMuCj4gSSByZWFkIHRoaXMgYXMgInRoZSB2aXJ0aW8gZHJp
dmVyIGlzIGJ1Z2d5LiAgTGV0J3MgZGlzYWJsZSBtb3N0IG9mIHRoZQo+IGJ1Z2d5IGNvZGUgaW4g
b25lIHNwZWNpYWwgY2FzZSBpbiB3aGljaCB3ZSBuZWVkIGEgZHJpdmVyIHdpdGhvdXQgYnVncy4K
PiBJbiBhbGwgdGhlIG90aGVyIGNhc2VzIChlLmcuIGhhcmR3YXJlIHZpcnRpbyBkZXZpY2UgY29u
bmVjdGVkIG92ZXIKPiBVU0ItQyksIGRyaXZlciBidWdzIGFyZSBzdGlsbCBhbGxvd2VkLiIKPgo+
IENhbiB3ZSBqdXN0IGZpeCB0aGUgZHJpdmVyIHdpdGhvdXQgc3BlY2lhbCBjYXNlcz8KCgpJIHRo
aW5rIHdlIGNhbiwgdGhpcyBpcyB3aGF0IHRoaXMgc2VyaWVzIHRyaWVzIHRvIGRvOgoKaHR0cHM6
Ly93d3cuc3Bpbmljcy5uZXQvbGlzdHMva3ZtL21zZzI0MTgyNS5odG1sCgpJdCB0cmllcyB0byBm
aXggd2l0aG91dCBhIHNwZWNpYWwgY2FyaW5nIGZvciBhbnkgc3BlY2lmaWMgZmVhdHVyZXMuCgpU
aGFua3MKCgoKPgo+IC0tQW5keQo+CgpfX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fXwpWaXJ0dWFsaXphdGlvbiBtYWlsaW5nIGxpc3QKVmlydHVhbGl6YXRpb25A
bGlzdHMubGludXgtZm91bmRhdGlvbi5vcmcKaHR0cHM6Ly9saXN0cy5saW51eGZvdW5kYXRpb24u
b3JnL21haWxtYW4vbGlzdGluZm8vdmlydHVhbGl6YXRpb24=
