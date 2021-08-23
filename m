Return-Path: <SRS0=r7vL=NO=lists.linux-foundation.org=virtualization-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-17.1 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B9F28C4320A
	for <virtualization@archiver.kernel.org>; Mon, 23 Aug 2021 06:32:27 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 745E861245
	for <virtualization@archiver.kernel.org>; Mon, 23 Aug 2021 06:32:27 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org 745E861245
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 4B4EC60720;
	Mon, 23 Aug 2021 06:32:27 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
	by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id 2jv_iAL7HPxo; Mon, 23 Aug 2021 06:32:23 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp3.osuosl.org (Postfix) with ESMTPS id E1D0360727;
	Mon, 23 Aug 2021 06:32:22 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id A889EC001A;
	Mon, 23 Aug 2021 06:32:22 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [IPv6:2605:bc80:3010::133])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 93FFCC001F
 for <virtualization@lists.linux-foundation.org>;
 Mon, 23 Aug 2021 06:32:21 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id 56F2A400FE
 for <virtualization@lists.linux-foundation.org>;
 Mon, 23 Aug 2021 06:32:20 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp2.osuosl.org (amavisd-new);
 dkim=pass (1024-bit key) header.d=redhat.com
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id bb7f6MEsd72d
 for <virtualization@lists.linux-foundation.org>;
 Mon, 23 Aug 2021 06:32:19 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.133.124])
 by smtp2.osuosl.org (Postfix) with ESMTPS id 9CEBC40144
 for <virtualization@lists.linux-foundation.org>;
 Mon, 23 Aug 2021 06:32:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1629700338;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=F427DPlADbCH/M2u7fz/h7ndiMrb6AVw4qTHSvYRC+w=;
 b=BzWq88deqTYWILQmL0+Ttb67zemEJFD42XlakLf3hhPwYJ+SRUJBcdShqpOUjFGhwPm3qo
 aMBYFNx/F4hRw6mPlfSvp0Xc5UZ+WjXxw/L7lnFECkBRGiAHla+g396IVZ1FTCfHmHkm+z
 +EMaumoF9/LA8UTZx++nYFDScVW+F8E=
Received: from mail-pf1-f198.google.com (mail-pf1-f198.google.com
 [209.85.210.198]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-114-yKSoCsGvMcGZD9n9WUdVrw-1; Mon, 23 Aug 2021 02:32:15 -0400
X-MC-Unique: yKSoCsGvMcGZD9n9WUdVrw-1
Received: by mail-pf1-f198.google.com with SMTP id
 h14-20020a62b40e0000b02903131bc4a1acso8148394pfn.4
 for <virtualization@lists.linux-foundation.org>;
 Sun, 22 Aug 2021 23:32:14 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-transfer-encoding
 :content-language;
 bh=F427DPlADbCH/M2u7fz/h7ndiMrb6AVw4qTHSvYRC+w=;
 b=fSKDCVTZ9hlhq2DJVH6FDTLDmENBAXbeG/TDvYFYomnvBnsnuw57THCXJO1PrNBljj
 DMLFwGGZTYowNm3jsuOxbT7Ih1rp4bt3TATkiwUk9w5bQvDEj/2DQK1urLWCYXey3Ab9
 0w+daK0SKK/pRd0m5hfZK+eHqpCTIXGuz8fEa0xaEtEdAP4uqYAqHP4bcNxNJ8iqlhyX
 LpoDC1qe4qo8rHjyi6UuPUQgYzazT4T+synVAgQViuBfDaTb44boDw0qTZB3fNuxH+ox
 yVzzmdOWjONLfVAZw1M2B38ZlMANdf6pLsq3AI/HQvOcXXhNKPEa3FlQybDZ/FJCpvkZ
 zM8A==
X-Gm-Message-State: AOAM532MPKjTUeD1+2BCc0nSB1mKSgDSBJhA/YWBZT5XrBFsMlNuk9R0
 p38lvhkGT4HX16Hq+qVpnsyNTvd+B+lWSG8dl1nCu8WtHdLjRhd+f6Yle5/Uyu8YEDPcbDD6lnv
 Ungzcui0sMMejAtFHOQk4wF6eQpLwytqd76hkSboTLA==
X-Received: by 2002:a65:40c4:: with SMTP id u4mr30729302pgp.186.1629700333957; 
 Sun, 22 Aug 2021 23:32:13 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJyMdGRZ8bEDFR6mhq5hnskFTgOQcLb0mODJnisTe/klfXgBImg93E0Jn9mD7e+X41rM+h1P3A==
X-Received: by 2002:a65:40c4:: with SMTP id u4mr30729265pgp.186.1629700333764; 
 Sun, 22 Aug 2021 23:32:13 -0700 (PDT)
Received: from wangxiaodeMacBook-Air.local ([209.132.188.80])
 by smtp.gmail.com with ESMTPSA id d7sm17831032pgu.78.2021.08.22.23.32.06
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Sun, 22 Aug 2021 23:32:13 -0700 (PDT)
Subject: Re: [PATCH v11 05/12] vhost-vdpa: Handle the failure of vdpa_reset()
To: Xie Yongji <xieyongji@bytedance.com>, mst@redhat.com,
 stefanha@redhat.com, sgarzare@redhat.com, parav@nvidia.com,
 hch@infradead.org, christian.brauner@canonical.com, rdunlap@infradead.org,
 willy@infradead.org, viro@zeniv.linux.org.uk, axboe@kernel.dk,
 bcrl@kvack.org, corbet@lwn.net, mika.penttila@nextfour.com,
 dan.carpenter@oracle.com, joro@8bytes.org, gregkh@linuxfoundation.org,
 zhe.he@windriver.com, xiaodong.liu@intel.com, joe@perches.com,
 robin.murphy@arm.com
References: <20210818120642.165-1-xieyongji@bytedance.com>
 <20210818120642.165-6-xieyongji@bytedance.com>
From: Jason Wang <jasowang@redhat.com>
Message-ID: <a9283bf7-bf24-b092-e79d-37c5c4f9e087@redhat.com>
Date: Mon, 23 Aug 2021 14:32:04 +0800
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:78.0)
 Gecko/20100101 Thunderbird/78.13.0
MIME-Version: 1.0
In-Reply-To: <20210818120642.165-6-xieyongji@bytedance.com>
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

CtTaIDIwMjEvOC8xOCDPws7nODowNiwgWGllIFlvbmdqaSDQtLXAOgo+IFRoZSB2ZHBhX3Jlc2V0
KCkgbWF5IGZhaWwgbm93LiBUaGlzIGFkZHMgY2hlY2sgdG8gaXRzIHJldHVybgo+IHZhbHVlIGFu
ZCBmYWlsIHRoZSB2aG9zdF92ZHBhX29wZW4oKS4KPgo+IFNpZ25lZC1vZmYtYnk6IFhpZSBZb25n
amkgPHhpZXlvbmdqaUBieXRlZGFuY2UuY29tPgoKCkFja2VkLWJ5OiBKYXNvbiBXYW5nIDxqYXNv
d2FuZ0ByZWRoYXQuY29tPgoKCj4gLS0tCj4gICBkcml2ZXJzL3Zob3N0L3ZkcGEuYyB8IDkgKysr
KysrLS0tCj4gICAxIGZpbGUgY2hhbmdlZCwgNiBpbnNlcnRpb25zKCspLCAzIGRlbGV0aW9ucygt
KQo+Cj4gZGlmZiAtLWdpdCBhL2RyaXZlcnMvdmhvc3QvdmRwYS5jIGIvZHJpdmVycy92aG9zdC92
ZHBhLmMKPiBpbmRleCBiMWM5MWI0ZGIwYmEuLmQ5OWQ3NWFkMzBjYyAxMDA2NDQKPiAtLS0gYS9k
cml2ZXJzL3Zob3N0L3ZkcGEuYwo+ICsrKyBiL2RyaXZlcnMvdmhvc3QvdmRwYS5jCj4gQEAgLTEx
NiwxMiArMTE2LDEzIEBAIHN0YXRpYyB2b2lkIHZob3N0X3ZkcGFfdW5zZXR1cF92cV9pcnEoc3Ry
dWN0IHZob3N0X3ZkcGEgKnYsIHUxNiBxaWQpCj4gICAJaXJxX2J5cGFzc191bnJlZ2lzdGVyX3By
b2R1Y2VyKCZ2cS0+Y2FsbF9jdHgucHJvZHVjZXIpOwo+ICAgfQo+ICAgCj4gLXN0YXRpYyB2b2lk
IHZob3N0X3ZkcGFfcmVzZXQoc3RydWN0IHZob3N0X3ZkcGEgKnYpCj4gK3N0YXRpYyBpbnQgdmhv
c3RfdmRwYV9yZXNldChzdHJ1Y3Qgdmhvc3RfdmRwYSAqdikKPiAgIHsKPiAgIAlzdHJ1Y3QgdmRw
YV9kZXZpY2UgKnZkcGEgPSB2LT52ZHBhOwo+ICAgCj4gLQl2ZHBhX3Jlc2V0KHZkcGEpOwo+ICAg
CXYtPmluX2JhdGNoID0gMDsKPiArCj4gKwlyZXR1cm4gdmRwYV9yZXNldCh2ZHBhKTsKPiAgIH0K
PiAgIAo+ICAgc3RhdGljIGxvbmcgdmhvc3RfdmRwYV9nZXRfZGV2aWNlX2lkKHN0cnVjdCB2aG9z
dF92ZHBhICp2LCB1OCBfX3VzZXIgKmFyZ3ApCj4gQEAgLTg2OCw3ICs4NjksOSBAQCBzdGF0aWMg
aW50IHZob3N0X3ZkcGFfb3BlbihzdHJ1Y3QgaW5vZGUgKmlub2RlLCBzdHJ1Y3QgZmlsZSAqZmls
ZXApCj4gICAJCXJldHVybiAtRUJVU1k7Cj4gICAKPiAgIAludnFzID0gdi0+bnZxczsKPiAtCXZo
b3N0X3ZkcGFfcmVzZXQodik7Cj4gKwlyID0gdmhvc3RfdmRwYV9yZXNldCh2KTsKPiArCWlmIChy
KQo+ICsJCWdvdG8gZXJyOwo+ICAgCj4gICAJdnFzID0ga21hbGxvY19hcnJheShudnFzLCBzaXpl
b2YoKnZxcyksIEdGUF9LRVJORUwpOwo+ICAgCWlmICghdnFzKSB7CgpfX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fXwpWaXJ0dWFsaXphdGlvbiBtYWlsaW5nIGxp
c3QKVmlydHVhbGl6YXRpb25AbGlzdHMubGludXgtZm91bmRhdGlvbi5vcmcKaHR0cHM6Ly9saXN0
cy5saW51eGZvdW5kYXRpb24ub3JnL21haWxtYW4vbGlzdGluZm8vdmlydHVhbGl6YXRpb24=
