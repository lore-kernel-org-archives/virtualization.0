Return-Path: <SRS0=r7vL=NO=lists.linux-foundation.org=virtualization-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.1 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 68634C4320A
	for <virtualization@archiver.kernel.org>; Mon, 23 Aug 2021 06:57:02 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 211446101C
	for <virtualization@archiver.kernel.org>; Mon, 23 Aug 2021 06:57:02 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org 211446101C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 9E41280CFA;
	Mon, 23 Aug 2021 06:57:01 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
	by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id WfOqd8eFebQ6; Mon, 23 Aug 2021 06:56:57 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp1.osuosl.org (Postfix) with ESMTPS id 306DC80D28;
	Mon, 23 Aug 2021 06:56:57 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id C58A1C0020;
	Mon, 23 Aug 2021 06:56:56 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [IPv6:2605:bc80:3010::133])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 2120DC000E
 for <virtualization@lists.linux-foundation.org>;
 Mon, 23 Aug 2021 06:56:56 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id 00A9340144
 for <virtualization@lists.linux-foundation.org>;
 Mon, 23 Aug 2021 06:56:56 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp2.osuosl.org (amavisd-new);
 dkim=pass (1024-bit key) header.d=redhat.com
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id 0ULmLlcp9RLc
 for <virtualization@lists.linux-foundation.org>;
 Mon, 23 Aug 2021 06:56:53 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.133.124])
 by smtp2.osuosl.org (Postfix) with ESMTPS id 0D21E400D4
 for <virtualization@lists.linux-foundation.org>;
 Mon, 23 Aug 2021 06:56:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1629701812;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=O6CVC1MYmQ2Yd0dGkq2W7I4r7P5G0FEqZECeGZvY4DU=;
 b=ivHYSENKO6HZIyOLob2IbG/weMwW+tBpxmdKUnlbw8ROVd75guWglThWwybBjc5D2GqxIT
 xOrUKDNPk325Yl7BJyNPac9vRK1Tsy23TrgRZI2O4x6e9EMudrYWpGbrL01jpu7/FE/opR
 g+PPyqPNh0S4+FlHbb7xZULH/ba75fg=
Received: from mail-pg1-f199.google.com (mail-pg1-f199.google.com
 [209.85.215.199]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-482-vKuPFbkZP8mfPItDwwZobQ-1; Mon, 23 Aug 2021 02:56:48 -0400
X-MC-Unique: vKuPFbkZP8mfPItDwwZobQ-1
Received: by mail-pg1-f199.google.com with SMTP id
 r21-20020a63d9150000b029023ccd23c20cso9832468pgg.19
 for <virtualization@lists.linux-foundation.org>;
 Sun, 22 Aug 2021 23:56:48 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-transfer-encoding
 :content-language;
 bh=O6CVC1MYmQ2Yd0dGkq2W7I4r7P5G0FEqZECeGZvY4DU=;
 b=buq0zE52k6fSRpstjFftSB22RqqJg03H2wts2bX+m0dwD1cGfeazY9VitC2exAmKWa
 HUNviXFVjfWnkoXD754C8mLjk0WeJwc0I0Jvp4KzrbILUgYtuS7DD35V1+kwNIWGOMH5
 DRLqYYc197L0dSs7gNnBLBD4a3XOsPul3eg1+4VVKmB11vxktecDwjFv1bcqyD7xzQPd
 PmzCzD+haHyI828BSxhtvttQJS4eGXaOQl6UcXm84jJDuAjKh+aTp32Wjha3eC6OqAyb
 EGUY0n2AG8MjvPa5VkOVVwRNQ6dlOOrpI0tgGHFJKRYqfNoRbPZAEs/fMcRSRAlDzw7z
 goiw==
X-Gm-Message-State: AOAM530wXTjLbUIIoX8LA6VSTkAg7ZR9u0wmbquTTFOfoiq4dIp9NmYz
 r8NihRTSnrhAJth8aQsr94EGOFk33N0cXF7FanW4oRUwtJaQ7jObhoQI1RhS6VW7WJy01SYnL8A
 H8rAZb4MU8VGu9xOqxtOJe2UjqkL4wblcHiLeIUNtdA==
X-Received: by 2002:aa7:9ddc:0:b0:3e1:5fc1:1d20 with SMTP id
 g28-20020aa79ddc000000b003e15fc11d20mr32664044pfq.48.1629701807255; 
 Sun, 22 Aug 2021 23:56:47 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJxeDlxuu1bqct4xksqs7isW8FxpMxOH+GNhpdYUwjloBQhDlJbitQ/vFhNd4D+BhyIvDS4Fgg==
X-Received: by 2002:aa7:9ddc:0:b0:3e1:5fc1:1d20 with SMTP id
 g28-20020aa79ddc000000b003e15fc11d20mr32664016pfq.48.1629701807013; 
 Sun, 22 Aug 2021 23:56:47 -0700 (PDT)
Received: from wangxiaodeMacBook-Air.local ([209.132.188.80])
 by smtp.gmail.com with ESMTPSA id n30sm14807096pfv.87.2021.08.22.23.56.38
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Sun, 22 Aug 2021 23:56:46 -0700 (PDT)
Subject: Re: [PATCH v11 11/12] vduse: Introduce VDUSE - vDPA Device in
 Userspace
To: Xie Yongji <xieyongji@bytedance.com>, mst@redhat.com,
 stefanha@redhat.com, sgarzare@redhat.com, parav@nvidia.com,
 hch@infradead.org, christian.brauner@canonical.com, rdunlap@infradead.org,
 willy@infradead.org, viro@zeniv.linux.org.uk, axboe@kernel.dk,
 bcrl@kvack.org, corbet@lwn.net, mika.penttila@nextfour.com,
 dan.carpenter@oracle.com, joro@8bytes.org, gregkh@linuxfoundation.org,
 zhe.he@windriver.com, xiaodong.liu@intel.com, joe@perches.com,
 robin.murphy@arm.com
References: <20210818120642.165-1-xieyongji@bytedance.com>
 <20210818120642.165-12-xieyongji@bytedance.com>
From: Jason Wang <jasowang@redhat.com>
Message-ID: <cfc11f6b-764b-7a52-2c4a-6fa22e6c1585@redhat.com>
Date: Mon, 23 Aug 2021 14:56:33 +0800
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:78.0)
 Gecko/20100101 Thunderbird/78.13.0
MIME-Version: 1.0
In-Reply-To: <20210818120642.165-12-xieyongji@bytedance.com>
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

CtTaIDIwMjEvOC8xOCDPws7nODowNiwgWGllIFlvbmdqaSDQtLXAOgo+IFRoaXMgVkRVU0UgZHJp
dmVyIGVuYWJsZXMgaW1wbGVtZW50aW5nIHNvZnR3YXJlLWVtdWxhdGVkIHZEUEEKPiBkZXZpY2Vz
IGluIHVzZXJzcGFjZS4gVGhlIHZEUEEgZGV2aWNlIGlzIGNyZWF0ZWQgYnkKPiBpb2N0bChWRFVT
RV9DUkVBVEVfREVWKSBvbiAvZGV2L3ZkdXNlL2NvbnRyb2wuIFRoZW4gYSBjaGFyIGRldmljZQo+
IGludGVyZmFjZSAoL2Rldi92ZHVzZS8kTkFNRSkgaXMgZXhwb3J0ZWQgdG8gdXNlcnNwYWNlIGZv
ciBkZXZpY2UKPiBlbXVsYXRpb24uCj4KPiBJbiBvcmRlciB0byBtYWtlIHRoZSBkZXZpY2UgZW11
bGF0aW9uIG1vcmUgc2VjdXJlLCB0aGUgZGV2aWNlJ3MKPiBjb250cm9sIHBhdGggaXMgaGFuZGxl
ZCBpbiBrZXJuZWwuIEEgbWVzc2FnZSBtZWNobmlzbSBpcyBpbnRyb2R1Y2VkCj4gdG8gZm9yd2Fy
ZCBzb21lIGRhdGFwbGFuZSByZWxhdGVkIGNvbnRyb2wgbWVzc2FnZXMgdG8gdXNlcnNwYWNlLgo+
Cj4gQW5kIGluIHRoZSBkYXRhIHBhdGgsIHRoZSBETUEgYnVmZmVyIHdpbGwgYmUgbWFwcGVkIGlu
dG8gdXNlcnNwYWNlCj4gYWRkcmVzcyBzcGFjZSB0aHJvdWdoIGRpZmZlcmVudCB3YXlzIGRlcGVu
ZGluZyBvbiB0aGUgdkRQQSBidXMgdG8KPiB3aGljaCB0aGUgdkRQQSBkZXZpY2UgaXMgYXR0YWNo
ZWQuIEluIHZpcnRpby12ZHBhIGNhc2UsIHRoZSBNTVUtYmFzZWQKPiBzb2Z0d2FyZSBJT1RMQiBp
cyB1c2VkIHRvIGFjaGlldmUgdGhhdC4gQW5kIGluIHZob3N0LXZkcGEgY2FzZSwgdGhlCj4gRE1B
IGJ1ZmZlciBpcyByZXNpZGUgaW4gYSB1c2Vyc3BhY2UgbWVtb3J5IHJlZ2lvbiB3aGljaCBjYW4g
YmUgc2hhcmVkCj4gdG8gdGhlIFZEVVNFIHVzZXJzcGFjZSBwcm9jZXNzcyB2aWEgdHJhbnNmZXJy
aW5nIHRoZSBzaG1mZC4KPgo+IEZvciBtb3JlIGRldGFpbHMgb24gVkRVU0UgZGVzaWduIGFuZCB1
c2FnZSwgcGxlYXNlIHNlZSB0aGUgZm9sbG93LW9uCj4gRG9jdW1lbnRhdGlvbiBjb21taXQuCj4K
PiBTaWduZWQtb2ZmLWJ5OiBYaWUgWW9uZ2ppIDx4aWV5b25namlAYnl0ZWRhbmNlLmNvbT4KCgpB
Y2tlZC1ieTogSmFzb24gV2FuZyA8amFzb3dhbmdAcmVkaGF0LmNvbT4KCgpfX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fXwpWaXJ0dWFsaXphdGlvbiBtYWlsaW5n
IGxpc3QKVmlydHVhbGl6YXRpb25AbGlzdHMubGludXgtZm91bmRhdGlvbi5vcmcKaHR0cHM6Ly9s
aXN0cy5saW51eGZvdW5kYXRpb24ub3JnL21haWxtYW4vbGlzdGluZm8vdmlydHVhbGl6YXRpb24=
