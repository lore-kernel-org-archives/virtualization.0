Return-Path: <SRS0=HAf6=MG=lists.linux-foundation.org=virtualization-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.4 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 283F9C07E95
	for <virtualization@archiver.kernel.org>; Wed, 14 Jul 2021 02:54:31 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id DC2FB6138C
	for <virtualization@archiver.kernel.org>; Wed, 14 Jul 2021 02:54:30 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DC2FB6138C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=virtualization-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id ADDC683B89;
	Wed, 14 Jul 2021 02:54:30 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
	by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id K5OO_Ds6rfsv; Wed, 14 Jul 2021 02:54:30 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp1.osuosl.org (Postfix) with ESMTPS id 63B1C83B7C;
	Wed, 14 Jul 2021 02:54:29 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 3D765C0010;
	Wed, 14 Jul 2021 02:54:29 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [IPv6:2605:bc80:3010::137])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 9D176C000E
 for <virtualization@lists.linux-foundation.org>;
 Wed, 14 Jul 2021 02:54:27 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id 7D659406AD
 for <virtualization@lists.linux-foundation.org>;
 Wed, 14 Jul 2021 02:54:27 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp4.osuosl.org (amavisd-new);
 dkim=pass (1024-bit key) header.d=redhat.com
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id XOamPKeDqZhY
 for <virtualization@lists.linux-foundation.org>;
 Wed, 14 Jul 2021 02:54:26 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [216.205.24.124])
 by smtp4.osuosl.org (Postfix) with ESMTPS id B832E406A3
 for <virtualization@lists.linux-foundation.org>;
 Wed, 14 Jul 2021 02:54:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1626231265;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=L8YuQd5Ts4JNGV6wtOAvCK5EPGDYCcnR+6g/ZGfnDJI=;
 b=NuVZ2xln6HCWxCW0uksrTj54DZs46wAP1NciUu1U8S311pUVU0y14mL74QtZFBmIDev2d8
 VoNq6AMESBPzf72nHKkWlqQj6JmRY6+mX+fNPXa3LfVlUIbW5AedFcOhtnQeqvmUGwPnmc
 XSFfl2bXKFPV0uMlAGfotrWH5wjtQoc=
Received: from mail-pf1-f197.google.com (mail-pf1-f197.google.com
 [209.85.210.197]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-593-9GKsp4jPOsi3rWjyS2gmCA-1; Tue, 13 Jul 2021 22:54:22 -0400
X-MC-Unique: 9GKsp4jPOsi3rWjyS2gmCA-1
Received: by mail-pf1-f197.google.com with SMTP id
 s187-20020a625ec40000b02903288ce43fc0so552528pfb.7
 for <virtualization@lists.linux-foundation.org>;
 Tue, 13 Jul 2021 19:54:22 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-transfer-encoding
 :content-language;
 bh=L8YuQd5Ts4JNGV6wtOAvCK5EPGDYCcnR+6g/ZGfnDJI=;
 b=nY6YzrWyDmc+Ll6bfpSmwL4cuH6Fu1LiUlGIzxo30b+ViWYMcwj0qgqP7SCvWd2QFQ
 aQ7BntQIdYllIJk1pAg5AoSkAf0w45QuPco2JMDHR4JjInYi26nY2qSr110ALpOtOyAu
 Q5HL7neYyarZRFxLsSJRek4J3ZvgnOIRE98d+5AFGvDKFG3I1C0pbQolaf0+op/LugIy
 A6p0AakIrvYwC6JpNGCqbyRS+IwNZ8GJEiuIV8a0JYsRVasfYAxiMZ2i9AIXXMeukWmp
 WqKHSOUOfIoaBOs17/VjoctIlWdjuEenT3gLmH0zQl8nf7hVOPRcibkh6OQg1c0rA4Vq
 oZtQ==
X-Gm-Message-State: AOAM531BYwW0IUiwYvo6ECiYKXLSfGTqpCloZVlmTN5N5ZXuX5oseN41
 Tr5D/APCMnDIiXPvNk1iBwRVmzKcfZZLAhXjpu7ZGp/5PEiRl6akUwpf6I1sVcg5Inq6TV47Chp
 pSooeE08sDBrfjOXTb5WntZuiDStxNiPsGcXDlzQrCA==
X-Received: by 2002:aa7:93cd:0:b029:328:9d89:a790 with SMTP id
 y13-20020aa793cd0000b02903289d89a790mr7769420pff.71.1626231261375; 
 Tue, 13 Jul 2021 19:54:21 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJyVcvRFQIHUh/wToTzbSqcRq399rxXFtmmAr5rDXhIuYW/QN+SkST9rmMlarwJcwx/uWSDVUw==
X-Received: by 2002:aa7:93cd:0:b029:328:9d89:a790 with SMTP id
 y13-20020aa793cd0000b02903289d89a790mr7769384pff.71.1626231260928; 
 Tue, 13 Jul 2021 19:54:20 -0700 (PDT)
Received: from wangxiaodeMacBook-Air.local ([209.132.188.80])
 by smtp.gmail.com with ESMTPSA id v11sm494452pjs.13.2021.07.13.19.54.13
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 13 Jul 2021 19:54:20 -0700 (PDT)
Subject: Re: [PATCH v9 16/17] vduse: Introduce VDUSE - vDPA Device in Userspace
To: Dan Carpenter <dan.carpenter@oracle.com>,
 Xie Yongji <xieyongji@bytedance.com>
References: <20210713084656.232-1-xieyongji@bytedance.com>
 <20210713084656.232-17-xieyongji@bytedance.com> <20210713132741.GM1954@kadam>
From: Jason Wang <jasowang@redhat.com>
Message-ID: <c42979dd-331f-4af5-fda6-18d80f22be2d@redhat.com>
Date: Wed, 14 Jul 2021 10:54:08 +0800
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:78.0)
 Gecko/20100101 Thunderbird/78.11.0
MIME-Version: 1.0
In-Reply-To: <20210713132741.GM1954@kadam>
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=jasowang@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Language: en-US
Cc: kvm@vger.kernel.org, mst@redhat.com,
 virtualization@lists.linux-foundation.org, christian.brauner@canonical.com,
 corbet@lwn.net, joro@8bytes.org, willy@infradead.org, hch@infradead.org,
 xiaodong.liu@intel.com, viro@zeniv.linux.org.uk, stefanha@redhat.com,
 songmuchun@bytedance.com, axboe@kernel.dk, zhe.he@windriver.com,
 gregkh@linuxfoundation.org, rdunlap@infradead.org,
 linux-kernel@vger.kernel.org, iommu@lists.linux-foundation.org, bcrl@kvack.org,
 netdev@vger.kernel.org, linux-fsdevel@vger.kernel.org,
 mika.penttila@nextfour.com
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

CtTaIDIwMjEvNy8xMyDPws7nOToyNywgRGFuIENhcnBlbnRlciDQtLXAOgo+IE9uIFR1ZSwgSnVs
IDEzLCAyMDIxIGF0IDA0OjQ2OjU1UE0gKzA4MDAsIFhpZSBZb25namkgd3JvdGU6Cj4+ICtzdGF0
aWMgaW50IHZkdXNlX2Rldl9pbml0X3ZkcGEoc3RydWN0IHZkdXNlX2RldiAqZGV2LCBjb25zdCBj
aGFyICpuYW1lKQo+PiArewo+PiArCXN0cnVjdCB2ZHVzZV92ZHBhICp2ZGV2Owo+PiArCWludCBy
ZXQ7Cj4+ICsKPj4gKwlpZiAoZGV2LT52ZGV2KQo+PiArCQlyZXR1cm4gLUVFWElTVDsKPj4gKwo+
PiArCXZkZXYgPSB2ZHBhX2FsbG9jX2RldmljZShzdHJ1Y3QgdmR1c2VfdmRwYSwgdmRwYSwgZGV2
LT5kZXYsCj4+ICsJCQkJICZ2ZHVzZV92ZHBhX2NvbmZpZ19vcHMsIG5hbWUsIHRydWUpOwo+PiAr
CWlmICghdmRldikKPj4gKwkJcmV0dXJuIC1FTk9NRU07Cj4gVGhpcyBzaG91bGQgYmUgYW4gSVNf
RVJSKCkgY2hlY2sgaW5zdGVhZCBvZiBhIE5VTEwgY2hlY2suCgoKWWVzLgoKCj4KPiBUaGUgdmRw
YV9hbGxvY19kZXZpY2UoKSBtYWNybyBpcyBkb2luZyBzb21ldGhpbmcgdmVyeSBjb21wbGljYXRl
ZCBidXQKPiBJJ20gbm90IHN1cmUgd2hhdC4gIEl0IGNhbGxzIGNvbnRhaW5lcl9vZigpIGFuZCB0
aGF0IGxvb2tzIGJ1Z2d5IHVudGlsCj4geW91IHNwb3QgdGhlIEJVSUxEX0JVR19PTl9aRVJPKCkg
Y29tcGlsZSB0aW1lIGFzc2VydCB3aGljaCBlbnN1cmVzIHRoYXQKPiB0aGUgY29udGFpbmVyX29m
KCkgaXMgYSBuby1vcC4KPgo+IE9ubHkgb25lIG9mIHRoZSBjYWxsZXJzIGNoZWNrcyBmb3IgZXJy
b3IgcG9pbnRlcnMgY29ycmVjdGx5IHNvIG1heWJlCj4gaXQncyB0b28gY29tcGxpY2F0ZWQgb3Ig
bWF5YmUgdGhlcmUgc2hvdWxkIGJlIGJldHRlciBkb2N1bWVudGF0aW9uLgoKCldlIG5lZWQgYmV0
dGVyIGRvY3VtZW50YXRpb24gZm9yIHRoaXMgbWFjcm8gYW5kIGZpeCBhbGwgdGhlIGJ1Z2d5IGNh
bGxlcnMuCgpZb25nIEppLCB3YW50IHRvIGRvIHRoYXQ/CgpUaGFua3MKCgo+Cj4gcmVnYXJkcywK
PiBkYW4gY2FycGVudGVyCj4KCl9fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fClZpcnR1YWxpemF0aW9uIG1haWxpbmcgbGlzdApWaXJ0dWFsaXphdGlvbkBsaXN0
cy5saW51eC1mb3VuZGF0aW9uLm9yZwpodHRwczovL2xpc3RzLmxpbnV4Zm91bmRhdGlvbi5vcmcv
bWFpbG1hbi9saXN0aW5mby92aXJ0dWFsaXphdGlvbg==
