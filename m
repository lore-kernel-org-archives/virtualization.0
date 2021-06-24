Return-Path: <SRS0=YcCX=LS=lists.linux-foundation.org=virtualization-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.0 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A2F13C49EA5
	for <virtualization@archiver.kernel.org>; Thu, 24 Jun 2021 08:14:17 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 44489613E7
	for <virtualization@archiver.kernel.org>; Thu, 24 Jun 2021 08:14:17 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 44489613E7
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=virtualization-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 06FDD4156D;
	Thu, 24 Jun 2021 08:14:17 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
	by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id sJZtp__IeYQ9; Thu, 24 Jun 2021 08:14:16 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp4.osuosl.org (Postfix) with ESMTPS id 8046D4157A;
	Thu, 24 Jun 2021 08:14:15 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 32F36C0010;
	Thu, 24 Jun 2021 08:14:15 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 34E02C000E
 for <virtualization@lists.linux-foundation.org>;
 Thu, 24 Jun 2021 08:14:14 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id 21A59405A7
 for <virtualization@lists.linux-foundation.org>;
 Thu, 24 Jun 2021 08:14:14 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp2.osuosl.org (amavisd-new);
 dkim=pass (1024-bit key) header.d=redhat.com
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id aREhHsVqa_Jn
 for <virtualization@lists.linux-foundation.org>;
 Thu, 24 Jun 2021 08:14:13 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [216.205.24.124])
 by smtp2.osuosl.org (Postfix) with ESMTPS id 486D6402B3
 for <virtualization@lists.linux-foundation.org>;
 Thu, 24 Jun 2021 08:14:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1624522452;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=QgEPrtgYrjYyuikepQ643R5m9hvqjjuW2YQFdqmgfAI=;
 b=QV+7Vf1bjADbDhiG+TM4uM7zGPbLLFVmHTCmCa8JNrz4YQUTPAvkO5233621FjkYO24ZUW
 Yti420ybLptWcqXtRqPUWP9zc/PDKYFpnYN0ei+Y+Y4n5n9Cf41AenOeA5oK9OMkUtVHn/
 Lp85ENJoTFLpGGz9plg0aFp/4DsRSIg=
Received: from mail-pg1-f197.google.com (mail-pg1-f197.google.com
 [209.85.215.197]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-207-MDMHjeH8OWakg8WBM3XHnQ-1; Thu, 24 Jun 2021 04:14:10 -0400
X-MC-Unique: MDMHjeH8OWakg8WBM3XHnQ-1
Received: by mail-pg1-f197.google.com with SMTP id
 m13-20020a633f0d0000b0290222ece48979so3359097pga.1
 for <virtualization@lists.linux-foundation.org>;
 Thu, 24 Jun 2021 01:14:10 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-transfer-encoding
 :content-language;
 bh=QgEPrtgYrjYyuikepQ643R5m9hvqjjuW2YQFdqmgfAI=;
 b=YYhX9PkMdOv/Uj/zFWQliOkdYDyUHtWDbrnajg39QZbgIBWYu2gKFRK+uGxDZULZUe
 VKXU257FBnOf5EmigYZDPx6agFDDHwMYb7AyxaYDUdWy/mLtSUqOZmudgOl4TTpb4sqs
 zdEROXBBdMMs85Z2z/ActSgNSKjQdcUJvXrWYZz3UJqZ1NO9PEcI+3kit8DfElQOKdr/
 RRmunzPhHYuswr8nAzlecNwMmcAqzfl3irzPrAEsMBMfEcyxt8m+DarrhMWJee9JiKX0
 /Lhob8kD0oO6Q9EJfWQuaFdOrZ56sr0OnCq2fzkA4AYAPekn6Kd4mRLoVJEDb+f+KK43
 yZbQ==
X-Gm-Message-State: AOAM533iAyhe+hFIwtchz2XIAP05jNdOdmt08QBD7SKTO70+AcQJnBtI
 G/xIeI3yT72VSB4lsGQhQFffgWQ+XiAJbDPw0FWppxIcbyNoCOhH5I0gNA12GXt8N9Uph9O7BLD
 XE7PK1fYCch/thgPVPoUq2hvO/ROOxgqoRCHtQnLtcQ==
X-Received: by 2002:a63:e04e:: with SMTP id n14mr3633698pgj.324.1624522449547; 
 Thu, 24 Jun 2021 01:14:09 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJyfl/37xGZkYh7EyP/rmRN1//BEFW+vjWFYtE33l7LAdc/0dPkEsdVgi/iD6hW3Szw3O6lBHQ==
X-Received: by 2002:a63:e04e:: with SMTP id n14mr3633666pgj.324.1624522449288; 
 Thu, 24 Jun 2021 01:14:09 -0700 (PDT)
Received: from wangxiaodeMacBook-Air.local ([209.132.188.80])
 by smtp.gmail.com with ESMTPSA id v21sm2129727pfu.77.2021.06.24.01.14.01
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 24 Jun 2021 01:14:08 -0700 (PDT)
Subject: Re: [PATCH v8 09/10] vduse: Introduce VDUSE - vDPA Device in Userspace
To: Yongji Xie <xieyongji@bytedance.com>
References: <20210615141331.407-1-xieyongji@bytedance.com>
 <20210615141331.407-10-xieyongji@bytedance.com>
 <adfb2be9-9ed9-ca37-ac37-4cd00bdff349@redhat.com>
 <CACycT3tAON+-qZev+9EqyL2XbgH5HDspOqNt3ohQLQ8GqVK=EA@mail.gmail.com>
 <1bba439f-ffc8-c20e-e8a4-ac73e890c592@redhat.com>
 <CACycT3uzMJS7vw6MVMOgY4rb=SPfT2srV+8DPdwUVeELEiJgbA@mail.gmail.com>
 <0aeb7cb7-58e5-1a95-d830-68edd7e8ec2e@redhat.com>
 <CACycT3uuooKLNnpPHewGZ=q46Fap2P4XCFirdxxn=FxK+X1ECg@mail.gmail.com>
 <e4cdee72-b6b4-d055-9aac-3beae0e5e3e1@redhat.com>
 <CACycT3u8=_D3hCtJR+d5BgeUQMce6S7c_6P3CVfvWfYhCQeXFA@mail.gmail.com>
 <d2334f66-907c-2e9c-ea4f-f912008e9be8@redhat.com>
 <CACycT3uCSLUDVpQHdrmuxSuoBDg-4n22t+N-Jm2GoNNp9JYB2w@mail.gmail.com>
From: Jason Wang <jasowang@redhat.com>
Message-ID: <48cab125-093b-2299-ff9c-3de8c7c5ed3d@redhat.com>
Date: Thu, 24 Jun 2021 16:13:56 +0800
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:78.0)
 Gecko/20100101 Thunderbird/78.11.0
MIME-Version: 1.0
In-Reply-To: <CACycT3uCSLUDVpQHdrmuxSuoBDg-4n22t+N-Jm2GoNNp9JYB2w@mail.gmail.com>
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=jasowang@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Language: en-US
Cc: kvm <kvm@vger.kernel.org>, "Michael S. Tsirkin" <mst@redhat.com>,
 virtualization <virtualization@lists.linux-foundation.org>,
 Christian Brauner <christian.brauner@canonical.com>,
 Jonathan Corbet <corbet@lwn.net>, joro@8bytes.org,
 Matthew Wilcox <willy@infradead.org>, Christoph Hellwig <hch@infradead.org>,
 Dan Carpenter <dan.carpenter@oracle.com>, Al Viro <viro@zeniv.linux.org.uk>,
 Stefan Hajnoczi <stefanha@redhat.com>, songmuchun@bytedance.com,
 Jens Axboe <axboe@kernel.dk>, Greg KH <gregkh@linuxfoundation.org>,
 Randy Dunlap <rdunlap@infradead.org>,
 linux-kernel <linux-kernel@vger.kernel.org>, iommu@lists.linux-foundation.org,
 bcrl@kvack.org, netdev@vger.kernel.org, linux-fsdevel@vger.kernel.org,
 =?UTF-8?Q?Mika_Penttil=c3=a4?= <mika.penttila@nextfour.com>
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

CuWcqCAyMDIxLzYvMjQg5LiL5Y2IMTI6NDYsIFlvbmdqaSBYaWUg5YaZ6YGTOgo+PiBTbyB3ZSBu
ZWVkIHRvIGRlYWwgd2l0aCBib3RoIEZFQVRVUkVTX09LIGFuZCByZXNldCwgYnV0IHByb2JhYmx5
IG5vdAo+PiBEUklWRVJfT0suCj4+Cj4gT0ssIEkgc2VlLiBUaGFua3MgZm9yIHRoZSBleHBsYW5h
dGlvbi4gT25lIG1vcmUgcXVlc3Rpb24gaXMgaG93IGFib3V0Cj4gY2xlYXJpbmcgdGhlIGNvcnJl
c3BvbmRpbmcgc3RhdHVzIGJpdCBpbiBnZXRfc3RhdHVzKCkgcmF0aGVyIHRoYW4KPiBtYWtpbmcg
c2V0X3N0YXR1cygpIGZhaWwuIFNpbmNlIHRoZSBzcGVjIHJlY29tbWVuZHMgdGhpcyB3YXkgZm9y
Cj4gdmFsaWRhdGlvbiB3aGljaCBpcyBkb25lIGluIHZpcnRpb19kZXZfcmVtb3ZlKCkgYW5kCj4g
dmlydGlvX2ZpbmFsaXplX2ZlYXR1cmVzKCkuCj4KPiBUaGFua3MsCj4gWW9uZ2ppCj4KCkkgdGhp
bmsgeW91IGNhbi4gT3IgaXQgd291bGQgYmUgZXZlbiBiZXR0ZXIgdGhhdCB3ZSBqdXN0IGRvbid0
IHNldCB0aGUgCmJpdCBkdXJpbmcgc2V0X3N0YXR1cygpLgoKSSBqdXN0IHJlYWxpemUgdGhhdCBp
biB2ZHBhX3Jlc2V0KCkgd2UgaGFkOgoKc3RhdGljIGlubGluZSB2b2lkIHZkcGFfcmVzZXQoc3Ry
dWN0IHZkcGFfZGV2aWNlICp2ZGV2KQp7CiDCoMKgwqDCoMKgwqDCoCBjb25zdCBzdHJ1Y3QgdmRw
YV9jb25maWdfb3BzICpvcHMgPSB2ZGV2LT5jb25maWc7CgogwqDCoMKgwqDCoMKgwqAgdmRldi0+
ZmVhdHVyZXNfdmFsaWQgPSBmYWxzZTsKIMKgwqDCoMKgwqDCoMKgIG9wcy0+c2V0X3N0YXR1cyh2
ZGV2LCAwKTsKfQoKV2UgcHJvYmFibHkgbmVlZCB0byBhZGQgdGhlIHN5bmNocm9uaXphdGlvbiBo
ZXJlLiBFLmcgcmUtcmVhZCB3aXRoIGEgCnRpbWVvdXQuCgpUaGFua3MKCl9fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fClZpcnR1YWxpemF0aW9uIG1haWxpbmcg
bGlzdApWaXJ0dWFsaXphdGlvbkBsaXN0cy5saW51eC1mb3VuZGF0aW9uLm9yZwpodHRwczovL2xp
c3RzLmxpbnV4Zm91bmRhdGlvbi5vcmcvbWFpbG1hbi9saXN0aW5mby92aXJ0dWFsaXphdGlvbg==
