Return-Path: <SRS0=+b5l=LW=lists.linux-foundation.org=virtualization-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3EF72C2B9F4
	for <virtualization@archiver.kernel.org>; Mon, 28 Jun 2021 04:40:32 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D261061C62
	for <virtualization@archiver.kernel.org>; Mon, 28 Jun 2021 04:40:31 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D261061C62
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=virtualization-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by smtp2.osuosl.org (Postfix) with ESMTP id 75167403B4;
	Mon, 28 Jun 2021 04:40:31 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
	by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id 454tyy7B4DG7; Mon, 28 Jun 2021 04:40:30 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp2.osuosl.org (Postfix) with ESMTPS id 0FD4D40381;
	Mon, 28 Jun 2021 04:40:30 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id BF0DFC0010;
	Mon, 28 Jun 2021 04:40:29 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by lists.linuxfoundation.org (Postfix) with ESMTP id BE8ACC000E
 for <virtualization@lists.linux-foundation.org>;
 Mon, 28 Jun 2021 04:40:28 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id A3F9340329
 for <virtualization@lists.linux-foundation.org>;
 Mon, 28 Jun 2021 04:40:28 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp4.osuosl.org (amavisd-new);
 dkim=pass (1024-bit key) header.d=redhat.com
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id LI16TUzeCl1j
 for <virtualization@lists.linux-foundation.org>;
 Mon, 28 Jun 2021 04:40:27 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.133.124])
 by smtp4.osuosl.org (Postfix) with ESMTPS id BF252402C1
 for <virtualization@lists.linux-foundation.org>;
 Mon, 28 Jun 2021 04:40:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1624855226;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=AHA+LCiynBinIcwBex84PZFjkFyKiA5ldfw47X4q5zo=;
 b=SwIuU0ThdsKVzw+Wdvc13PlXhlwRx4gzFsXX40sU7JVxUQtG4rfJFfMwr/HIZzVS5X/GoV
 wHKhfKLkxMWUsnL+H1U5CNyp4tHJZrFosmpzz8FAh0aLq+LP9h2vPkgH8hrexsIfp/ruY4
 tt599xN7jBTMwtheLokkCRzQ9PBj2f4=
Received: from mail-pl1-f197.google.com (mail-pl1-f197.google.com
 [209.85.214.197]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-42-Mt5XiMdWOV-q-CdsBgcNQw-1; Mon, 28 Jun 2021 00:40:24 -0400
X-MC-Unique: Mt5XiMdWOV-q-CdsBgcNQw-1
Received: by mail-pl1-f197.google.com with SMTP id
 r3-20020a1709030143b0290128d5ef2b6cso591207plc.7
 for <virtualization@lists.linux-foundation.org>;
 Sun, 27 Jun 2021 21:40:24 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-transfer-encoding
 :content-language;
 bh=AHA+LCiynBinIcwBex84PZFjkFyKiA5ldfw47X4q5zo=;
 b=tD41HUpuxrVxHFutxkr9iGs0TL01ytm50eY9ka7UVyE9BwktqBgxgTx9Rsskxv7yt5
 Cp0zJlifDa5+Mk91GeeTJ/Xf4csmpj2KdA1pnPfPkpYmEVm9mNgkLic8I5Z4VeU6pP6T
 bskijKCsQZL8UXI8AHDTiYxgN5lYFc8wIX9f1o3y2qjtc6LMjPn6Oz22urEiue2++K68
 JYrtOq1xIRVqb/1VHIA6pCianaV2T6uu5KW+tY8SeUypG5MarIZ+qt65DMdl/3ECqufc
 ziNFPBqfAK5nGBQDRVGc8l7YsYX39l2BfyRurr8vEe54Srlu0LOLDkcKm9A4H1HnJQBz
 b4+Q==
X-Gm-Message-State: AOAM5308/+VZMpbBE8DLeQ0kzQ5IdZ3iGCu4NVATYFk/obguXyH6Mkh3
 Tzz+wjS+g9ztEvRkaU96DaKOzu7O9EhHl+2ezN+XGaNP5fio1RGxKej826I+vWCvMMT2sLWBARc
 1jfXcIv4ynRpCcIAu0dXY1y8eiOnFdnUW2jYr371RRw==
X-Received: by 2002:a17:90a:73ca:: with SMTP id
 n10mr35061294pjk.16.1624855223854; 
 Sun, 27 Jun 2021 21:40:23 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJwo0o1s5KBYLlDLTqUhWl2FmmtFdw3BbxmCq5oGFB7ob0lz6rjRGdc+HVA7kjdSm4QccHUIRQ==
X-Received: by 2002:a17:90a:73ca:: with SMTP id
 n10mr35061255pjk.16.1624855223625; 
 Sun, 27 Jun 2021 21:40:23 -0700 (PDT)
Received: from wangxiaodeMacBook-Air.local ([209.132.188.80])
 by smtp.gmail.com with ESMTPSA id x143sm12654203pfc.6.2021.06.27.21.40.15
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Sun, 27 Jun 2021 21:40:23 -0700 (PDT)
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
 <48cab125-093b-2299-ff9c-3de8c7c5ed3d@redhat.com>
 <CACycT3tS=10kcUCNGYm=dUZsK+vrHzDvB3FSwAzuJCu3t+QuUQ@mail.gmail.com>
 <b10b3916-74d4-3171-db92-be0afb479a1c@redhat.com>
 <CACycT3vpMFbc9Fzuo9oksMaA-pVb1dEVTEgjNoft16voryPSWQ@mail.gmail.com>
From: Jason Wang <jasowang@redhat.com>
Message-ID: <d7e42109-0ba6-3e1a-c42a-898b6f33c089@redhat.com>
Date: Mon, 28 Jun 2021 12:40:14 +0800
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:78.0)
 Gecko/20100101 Thunderbird/78.11.0
MIME-Version: 1.0
In-Reply-To: <CACycT3vpMFbc9Fzuo9oksMaA-pVb1dEVTEgjNoft16voryPSWQ@mail.gmail.com>
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

CuWcqCAyMDIxLzYvMjUg5LiL5Y2IMTI6MTksIFlvbmdqaSBYaWUg5YaZ6YGTOgo+PiAyYikgZm9y
IHNldF9zdGF0dXMoKTogc2ltcGx5IHJlbGF5IHRoZSBtZXNzYWdlIHRvIHVzZXJzcGFjZSwgcmVw
bHkgaXMgbm8KPj4gbmVlZGVkLiBVc2Vyc3BhY2Ugd2lsbCB1c2UgYSBjb21tYW5kIHRvIHVwZGF0
ZSB0aGUgc3RhdHVzIHdoZW4gdGhlCj4+IGRhdGFwYXRoIGlzIHN0b3AuIFRoZSB0aGUgc3RhdHVz
IGNvdWxkIGJlIGZldGNoZWQgdmlhIGdldF9zdGF0cygpLgo+Pgo+PiAyYiBsb29rcyBtb3JlIHNw
ZWMgY29tcGxhaW50Lgo+Pgo+IExvb2tzIGdvb2QgdG8gbWUuIEFuZCBJIHRoaW5rIHdlIGNhbiB1
c2UgdGhlIHJlcGx5IG9mIHRoZSBtZXNzYWdlIHRvCj4gdXBkYXRlIHRoZSBzdGF0dXMgaW5zdGVh
ZCBvZiBpbnRyb2R1Y2luZyBhIG5ldyBjb21tYW5kLgo+CgpKdXN0IG5vdGljZSB0aGlzIHBhcnQg
aW4gdmlydGlvX2ZpbmFsaXplX2ZlYXR1cmVzKCk6CgogwqDCoMKgwqDCoMKgwqAgdmlydGlvX2Fk
ZF9zdGF0dXMoZGV2LCBWSVJUSU9fQ09ORklHX1NfRkVBVFVSRVNfT0spOwogwqDCoMKgwqDCoMKg
wqAgc3RhdHVzID0gZGV2LT5jb25maWctPmdldF9zdGF0dXMoZGV2KTsKIMKgwqDCoMKgwqDCoMKg
IGlmICghKHN0YXR1cyAmIFZJUlRJT19DT05GSUdfU19GRUFUVVJFU19PSykpIHsKClNvIHdlIG5v
IHJlcGx5IGRvZXNuJ3Qgd29yayBmb3IgRkVBVFVSRVNfT0suCgpTbyBteSB1bmRlcnN0YW5kaW5n
IGlzOgoKMSkgV2UgbXVzdCBub3QgdXNlIG5vcmVwbHkgZm9yIHNldF9zdGF0dXMoKQoyKSBXZSBj
YW4gdXNlIG5vcmVwbHkgZm9yIGdldF9zdGF0dXMoKSwgYnV0IGl0IHJlcXVpcmVzIGEgbmV3IGlv
Y3RsIHRvIAp1cGRhdGUgdGhlIHN0YXR1cy4KClNvIGl0IGxvb2tzIHRvIG1lIHdlIG5lZWQgc3lu
Y2hyb25pemUgZm9yIGJvdGggZ2V0X3N0YXR1cygpIGFuZCAKc2V0X3N0YXR1cygpLgoKVGhhbmtz
CgoKX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18KVmlydHVh
bGl6YXRpb24gbWFpbGluZyBsaXN0ClZpcnR1YWxpemF0aW9uQGxpc3RzLmxpbnV4LWZvdW5kYXRp
b24ub3JnCmh0dHBzOi8vbGlzdHMubGludXhmb3VuZGF0aW9uLm9yZy9tYWlsbWFuL2xpc3RpbmZv
L3ZpcnR1YWxpemF0aW9u
