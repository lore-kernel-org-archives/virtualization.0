Return-Path: <SRS0=zQmE=GX=lists.linux-foundation.org=virtualization-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 73D39C433DB
	for <virtualization@archiver.kernel.org>; Wed, 20 Jan 2021 11:10:08 +0000 (UTC)
Received: from whitealder.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id CF6B722227
	for <virtualization@archiver.kernel.org>; Wed, 20 Jan 2021 11:10:07 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CF6B722227
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=virtualization-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by whitealder.osuosl.org (Postfix) with ESMTP id 4542786292;
	Wed, 20 Jan 2021 11:10:07 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from whitealder.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id LktizxoqD3Vg; Wed, 20 Jan 2021 11:10:06 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by whitealder.osuosl.org (Postfix) with ESMTP id 17678862F4;
	Wed, 20 Jan 2021 11:10:06 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 0CD69C088B;
	Wed, 20 Jan 2021 11:10:06 +0000 (UTC)
Received: from whitealder.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id AF6E0C013A
 for <virtualization@lists.linux-foundation.org>;
 Wed, 20 Jan 2021 11:10:04 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by whitealder.osuosl.org (Postfix) with ESMTP id A1F3E862F4
 for <virtualization@lists.linux-foundation.org>;
 Wed, 20 Jan 2021 11:10:04 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from whitealder.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id WxRiKvx1-+aw
 for <virtualization@lists.linux-foundation.org>;
 Wed, 20 Jan 2021 11:10:03 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [63.128.21.124])
 by whitealder.osuosl.org (Postfix) with ESMTPS id 313CD86292
 for <virtualization@lists.linux-foundation.org>;
 Wed, 20 Jan 2021 11:10:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1611141002;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=yTm6KgxVEtqRp5BOUW1oggSfQz0/KqIRI5Ikpu2SIkI=;
 b=S8xfywf53WZo0WLVpnOqV4om+E33QENfRPR4eh+7G57dDwl7Cf2zE/YojQWjCz5WjcbC86
 hEwAW7ZetRMQaQs4X5x9g17R51qTiUTSfhGQID2dzLmeXlxwEyGzQE4Cp9GmZxMVgmkABb
 RNZ4/yUwKmbm7qmMH6BVqprRdxURFgk=
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-16-8ll9kXxeOVOWuSLvIe6K7g-1; Wed, 20 Jan 2021 06:08:38 -0500
X-MC-Unique: 8ll9kXxeOVOWuSLvIe6K7g-1
Received: by mail-wr1-f72.google.com with SMTP id e12so11288927wrp.10
 for <virtualization@lists.linux-foundation.org>;
 Wed, 20 Jan 2021 03:08:37 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:content-transfer-encoding
 :in-reply-to;
 bh=yTm6KgxVEtqRp5BOUW1oggSfQz0/KqIRI5Ikpu2SIkI=;
 b=hqYpVXJyIjbcnK9XlUUR/LNU8I+OIiuDGv6UR7DfZSmaZ8QrlOTiIYRrQDiGsxYsfS
 pFYEtzhM38O/vBnxfp73mRFVQCSFKAQTf25Ik3tHquAQNEuzd3k0HTWXcNFCjuKC6K+D
 CHFmF0Ody4t2L7bzmcaBO5belFwiv7SIqemcRULipWFqAWm9ZvYLhAKOA/G3YvHaKz76
 POhILD7YR6jcbKfYQJiLIuSUofWI15ILH3xYoAach9EPHpa6p+YqRdKwk6jHWOA95DYg
 hTpbyACCIRo1XaKJsIHAFUKf1UdaoIU9+7yQiXgNO6kQrWsCgN1rOt/ibo3W6h7XKMtn
 HyGw==
X-Gm-Message-State: AOAM532Pcth8aXyOoxWydQkP46eYfFmGql8FaAs4UWmHfxr9ai0TIpHf
 L3k/gGMrkNVSoGuB8nhVoFCXf4QxT0aXpzE0JSrYVB5Hz10gCUt5UxnZOj+x9wF++qbXZNHvibi
 zQhW9LcXoB3PO+zHQnF2COJ8ke0qJoZwal2UxZPQyEg==
X-Received: by 2002:a05:600c:4e8e:: with SMTP id
 f14mr3838222wmq.139.1611140916797; 
 Wed, 20 Jan 2021 03:08:36 -0800 (PST)
X-Google-Smtp-Source: ABdhPJwzq+LHVW7iOIInxldWRs5h39ePpUe0nK/vVbhibAJ1v8IIbA+WZfiKJq98JGzyhbZvEFHziw==
X-Received: by 2002:a05:600c:4e8e:: with SMTP id
 f14mr3838181wmq.139.1611140916380; 
 Wed, 20 Jan 2021 03:08:36 -0800 (PST)
Received: from steredhat (host-79-34-249-199.business.telecomitalia.it.
 [79.34.249.199])
 by smtp.gmail.com with ESMTPSA id p9sm1619051wrj.11.2021.01.20.03.08.34
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 20 Jan 2021 03:08:35 -0800 (PST)
Date: Wed, 20 Jan 2021 12:08:32 +0100
From: Stefano Garzarella <sgarzare@redhat.com>
To: Jason Wang <jasowang@redhat.com>, Xie Yongji <xieyongji@bytedance.com>
Subject: Re: [RFC v3 03/11] vdpa: Remove the restriction that only supports
 virtio-net devices
Message-ID: <20210120110832.oijcmywq7pf7psg3@steredhat>
References: <20210119045920.447-1-xieyongji@bytedance.com>
 <20210119045920.447-4-xieyongji@bytedance.com>
 <310d7793-e4ff-fba3-f358-418cb64c7988@redhat.com>
MIME-Version: 1.0
In-Reply-To: <310d7793-e4ff-fba3-f358-418cb64c7988@redhat.com>
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=sgarzare@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Disposition: inline
Cc: axboe@kernel.dk, corbet@lwn.net, kvm@vger.kernel.org, mst@redhat.com,
 linux-aio@kvack.org, netdev@vger.kernel.org, rdunlap@infradead.org,
 willy@infradead.org, virtualization@lists.linux-foundation.org,
 hch@infradead.org, bob.liu@oracle.com, bcrl@kvack.org, viro@zeniv.linux.org.uk,
 stefanha@redhat.com, linux-fsdevel@vger.kernel.org
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

T24gV2VkLCBKYW4gMjAsIDIwMjEgYXQgMTE6NDY6MzhBTSArMDgwMCwgSmFzb24gV2FuZyB3cm90
ZToKPgo+T24gMjAyMS8xLzE5IOS4i+WNiDEyOjU5LCBYaWUgWW9uZ2ppIHdyb3RlOgo+PldpdGgg
VkRVU0UsIHdlIHNob3VsZCBiZSBhYmxlIHRvIHN1cHBvcnQgYWxsIGtpbmRzIG9mIHZpcnRpbyBk
ZXZpY2VzLgo+Pgo+PlNpZ25lZC1vZmYtYnk6IFhpZSBZb25namkgPHhpZXlvbmdqaUBieXRlZGFu
Y2UuY29tPgo+Pi0tLQo+PiAgZHJpdmVycy92aG9zdC92ZHBhLmMgfCAyOSArKystLS0tLS0tLS0t
LS0tLS0tLS0tLS0tLS0tLQo+PiAgMSBmaWxlIGNoYW5nZWQsIDMgaW5zZXJ0aW9ucygrKSwgMjYg
ZGVsZXRpb25zKC0pCj4+Cj4+ZGlmZiAtLWdpdCBhL2RyaXZlcnMvdmhvc3QvdmRwYS5jIGIvZHJp
dmVycy92aG9zdC92ZHBhLmMKPj5pbmRleCAyOWVkNDE3M2YwNGUuLjQ0OGJlNzg3NWI2ZCAxMDA2
NDQKPj4tLS0gYS9kcml2ZXJzL3Zob3N0L3ZkcGEuYwo+PisrKyBiL2RyaXZlcnMvdmhvc3QvdmRw
YS5jCj4+QEAgLTIyLDYgKzIyLDcgQEAKPj4gICNpbmNsdWRlIDxsaW51eC9ub3NwZWMuaD4KPj4g
ICNpbmNsdWRlIDxsaW51eC92aG9zdC5oPgo+PiAgI2luY2x1ZGUgPGxpbnV4L3ZpcnRpb19uZXQu
aD4KPj4rI2luY2x1ZGUgPGxpbnV4L3ZpcnRpb19ibGsuaD4KPj4gICNpbmNsdWRlICJ2aG9zdC5o
Igo+PkBAIC0xODUsMjYgKzE4Niw2IEBAIHN0YXRpYyBsb25nIHZob3N0X3ZkcGFfc2V0X3N0YXR1
cyhzdHJ1Y3Qgdmhvc3RfdmRwYSAqdiwgdTggX191c2VyICpzdGF0dXNwKQo+PiAgCXJldHVybiAw
Owo+PiAgfQo+Pi1zdGF0aWMgaW50IHZob3N0X3ZkcGFfY29uZmlnX3ZhbGlkYXRlKHN0cnVjdCB2
aG9zdF92ZHBhICp2LAo+Pi0JCQkJICAgICAgc3RydWN0IHZob3N0X3ZkcGFfY29uZmlnICpjKQo+
Pi17Cj4+LQlsb25nIHNpemUgPSAwOwo+Pi0KPj4tCXN3aXRjaCAodi0+dmlydGlvX2lkKSB7Cj4+
LQljYXNlIFZJUlRJT19JRF9ORVQ6Cj4+LQkJc2l6ZSA9IHNpemVvZihzdHJ1Y3QgdmlydGlvX25l
dF9jb25maWcpOwo+Pi0JCWJyZWFrOwo+Pi0JfQo+Pi0KPj4tCWlmIChjLT5sZW4gPT0gMCkKPj4t
CQlyZXR1cm4gLUVJTlZBTDsKPj4tCj4+LQlpZiAoYy0+bGVuID4gc2l6ZSAtIGMtPm9mZikKPj4t
CQlyZXR1cm4gLUUyQklHOwo+Pi0KPj4tCXJldHVybiAwOwo+Pi19Cj4KPgo+SSB0aGluayB3ZSBz
aG91bGQgdXNlIGEgc2VwYXJhdGUgcGF0Y2ggZm9yIHRoaXMuCgpGb3IgdGhlIHZkcGEtYmxrIHNp
bXVsYXRvciBJIGhhZCB0aGUgc2FtZSBpc3N1ZXMgYW5kIEknbSBhZGRpbmcgYSAKLmdldF9jb25m
aWdfc2l6ZSgpIGNhbGxiYWNrIHRvIHZkcGEgZGV2aWNlcy4KCkRvIHlvdSB0aGluayBtYWtlIHNl
bnNlIG9yIGlzIGJldHRlciB0byByZW1vdmUgdGhpcyBjaGVjayBpbiB2aG9zdC92ZHBhLCAKZGVs
ZWdhdGluZyB0aGUgYm91bmRhcmllcyBjaGVja3MgdG8gZ2V0X2NvbmZpZy9zZXRfY29uZmlnIGNh
bGxiYWNrcy4KClRoYW5rcywKU3RlZmFubwoKX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX18KVmlydHVhbGl6YXRpb24gbWFpbGluZyBsaXN0ClZpcnR1YWxpemF0
aW9uQGxpc3RzLmxpbnV4LWZvdW5kYXRpb24ub3JnCmh0dHBzOi8vbGlzdHMubGludXhmb3VuZGF0
aW9uLm9yZy9tYWlsbWFuL2xpc3RpbmZvL3ZpcnR1YWxpemF0aW9u
