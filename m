Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 130E1C433F5
	for <virtualization@archiver.kernel.org>; Wed, 23 Feb 2022 02:41:22 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp2.osuosl.org (Postfix) with ESMTP id 9386A4063E;
	Wed, 23 Feb 2022 02:41:22 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
	by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id robErj9qiNUy; Wed, 23 Feb 2022 02:41:21 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp2.osuosl.org (Postfix) with ESMTPS id E3F62405B9;
	Wed, 23 Feb 2022 02:41:20 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id C94EAC001A;
	Wed, 23 Feb 2022 02:41:20 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 4E0D7C0011
 for <virtualization@lists.linux-foundation.org>;
 Wed, 23 Feb 2022 02:41:20 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id 499F240260
 for <virtualization@lists.linux-foundation.org>;
 Wed, 23 Feb 2022 02:41:20 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id NQy1RQT0BqRk
 for <virtualization@lists.linux-foundation.org>;
 Wed, 23 Feb 2022 02:41:19 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.133.124])
 by smtp2.osuosl.org (Postfix) with ESMTPS id 01CD4405B9
 for <virtualization@lists.linux-foundation.org>;
 Wed, 23 Feb 2022 02:41:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1645584077;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=Hjy7Un93ddn3YdZp0ReQB/jlX92qX6nA7numS+cTWRI=;
 b=UI0EScUJF4mrAK1b/QCFHhg5XmCREz8mP+H0JKQnK9F6BwsS8pL3yGUd0HPr00zw7CidG+
 ZRWeN/kJ1uofsgv++sLs+4p8J2HtmVfxgEgeAnXk/Hv+NwEWPVOTL1z/N9IIEP1zUur7yh
 M4DEap/IYnRttkUNiv8DwDP/8i2GElQ=
Received: from mail-pf1-f199.google.com (mail-pf1-f199.google.com
 [209.85.210.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-80-LfQm5DpbN16F2S-3pl64wA-1; Tue, 22 Feb 2022 21:41:15 -0500
X-MC-Unique: LfQm5DpbN16F2S-3pl64wA-1
Received: by mail-pf1-f199.google.com with SMTP id
 62-20020a621541000000b004f110fdb1aeso5273201pfv.13
 for <virtualization@lists.linux-foundation.org>;
 Tue, 22 Feb 2022 18:41:15 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
 :content-language:to:cc:references:from:in-reply-to
 :content-transfer-encoding;
 bh=Hjy7Un93ddn3YdZp0ReQB/jlX92qX6nA7numS+cTWRI=;
 b=C5xJ2DrfXEkKn/2Yyh8zmwOlHGXVLTHRkk9J/x5dHrsm8SVVY660apy22ZcHafnMDj
 cuSlBI+MGAi4vC3bTVWKR1gru0GZTHm+yP4LeX/ALdPvo7zTtZh+OpoToSi9UGJ+7AKQ
 5lVjCQ2TGtjz2fAwlHIHi/sog/Xx4mQyxIwTbKBeqi03lUe2cLjHjdBuBMMPrjQZUfs7
 wqDfZiEBjLBHMbmlVviIUzoFAlBDGzUBSAilFsFfzLEuzn5XYEc4g6U3jwCtoThRkhzU
 c4HfzKMkqXxz8lNkb5Y4L0XWZbTjQbg2aZvTwiHEVBUWFBl5VdhIX6aoBVT/1Gvp4ZsM
 +kUw==
X-Gm-Message-State: AOAM530FxbYyxhLhdHBjZ1IFBbKTutT8K1m7X50AFCMOanq4Mm20eldC
 SlIpjuXSAjoo5qYnSn9vEtHrmagaQDZteqpv8gIkNrfVdl3lOzcTZbAQWU5J3bZykK109+MzXik
 B5PvMxupSvwyEX+oH9FeJVNDCguDbDHZCaTUs8aFWjg==
X-Received: by 2002:a17:903:1207:b0:14d:537b:40f6 with SMTP id
 l7-20020a170903120700b0014d537b40f6mr26333856plh.50.1645584074845; 
 Tue, 22 Feb 2022 18:41:14 -0800 (PST)
X-Google-Smtp-Source: ABdhPJw3m8OfQlE8qpZRwBoRdwLxXFQNqUzMfgjbz12Pu+TuO2YXG4wlpnzdIFa//7xI/EZ84ulMmg==
X-Received: by 2002:a17:903:1207:b0:14d:537b:40f6 with SMTP id
 l7-20020a170903120700b0014d537b40f6mr26333833plh.50.1645584074490; 
 Tue, 22 Feb 2022 18:41:14 -0800 (PST)
Received: from [10.72.13.161] ([209.132.188.80])
 by smtp.gmail.com with ESMTPSA id h13sm16801484pfv.198.2022.02.22.18.41.10
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 22 Feb 2022 18:41:14 -0800 (PST)
Message-ID: <82834889-b780-b091-a9f7-b5de849011c5@redhat.com>
Date: Wed, 23 Feb 2022 10:41:05 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:91.0)
 Gecko/20100101 Thunderbird/91.6.0
Subject: Re: [PATCH v1 1/6] virtio: rename vring_unmap_state_packed() to
 vring_unmap_extra_packed()
To: Xuan Zhuo <xuanzhuo@linux.alibaba.com>,
 virtualization@lists.linux-foundation.org
References: <20220210085124.15466-1-xuanzhuo@linux.alibaba.com>
 <20220210085124.15466-2-xuanzhuo@linux.alibaba.com>
From: Jason Wang <jasowang@redhat.com>
In-Reply-To: <20220210085124.15466-2-xuanzhuo@linux.alibaba.com>
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=jasowang@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Language: en-US
Cc: "Michael S. Tsirkin" <mst@redhat.com>
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

CuWcqCAyMDIyLzIvMTAg5LiL5Y2INDo1MSwgWHVhbiBaaHVvIOWGmemBkzoKPiBUaGUgYWN0dWFs
IHBhcmFtZXRlciBoYW5kbGVkIGJ5IHZyaW5nX3VubWFwX3N0YXRlX3BhY2tlZCgpIGlzIHRoYXQK
PiB2cmluZ19kZXNjX2V4dHJhLCBzbyB0aGlzIGZ1bmN0aW9uIHNob3VsZCB1c2UgImV4dHJhIiBp
bnN0ZWFkIG9mICJzdGF0ZSIuCj4KPiBTaWduZWQtb2ZmLWJ5OiBYdWFuIFpodW8gPHh1YW56aHVv
QGxpbnV4LmFsaWJhYmEuY29tPgoKCkFja2VkLWJ5OiBKYXNvbiBXYW5nIDxqYXNvd2FuZ0ByZWRo
YXQuY29tPgoKCj4gLS0tCj4gICBkcml2ZXJzL3ZpcnRpby92aXJ0aW9fcmluZy5jIHwgMTcgKysr
KysrKystLS0tLS0tLS0KPiAgIDEgZmlsZSBjaGFuZ2VkLCA4IGluc2VydGlvbnMoKyksIDkgZGVs
ZXRpb25zKC0pCj4KPiBkaWZmIC0tZ2l0IGEvZHJpdmVycy92aXJ0aW8vdmlydGlvX3JpbmcuYyBi
L2RyaXZlcnMvdmlydGlvL3ZpcnRpb19yaW5nLmMKPiBpbmRleCA5NjJmMTQ3N2IxZmEuLjdjZjNh
ZTA1NzgzMyAxMDA2NDQKPiAtLS0gYS9kcml2ZXJzL3ZpcnRpby92aXJ0aW9fcmluZy5jCj4gKysr
IGIvZHJpdmVycy92aXJ0aW8vdmlydGlvX3JpbmcuYwo+IEBAIC05ODQsMjQgKzk4NCwyNCBAQCBz
dGF0aWMgc3RydWN0IHZpcnRxdWV1ZSAqdnJpbmdfY3JlYXRlX3ZpcnRxdWV1ZV9zcGxpdCgKPiAg
ICAqIFBhY2tlZCByaW5nIHNwZWNpZmljIGZ1bmN0aW9ucyAtICpfcGFja2VkKCkuCj4gICAgKi8K
PiAgIAo+IC1zdGF0aWMgdm9pZCB2cmluZ191bm1hcF9zdGF0ZV9wYWNrZWQoY29uc3Qgc3RydWN0
IHZyaW5nX3ZpcnRxdWV1ZSAqdnEsCj4gLQkJCQkgICAgIHN0cnVjdCB2cmluZ19kZXNjX2V4dHJh
ICpzdGF0ZSkKPiArc3RhdGljIHZvaWQgdnJpbmdfdW5tYXBfZXh0cmFfcGFja2VkKGNvbnN0IHN0
cnVjdCB2cmluZ192aXJ0cXVldWUgKnZxLAo+ICsJCQkJICAgICBzdHJ1Y3QgdnJpbmdfZGVzY19l
eHRyYSAqZXh0cmEpCj4gICB7Cj4gICAJdTE2IGZsYWdzOwo+ICAgCj4gICAJaWYgKCF2cS0+dXNl
X2RtYV9hcGkpCj4gICAJCXJldHVybjsKPiAgIAo+IC0JZmxhZ3MgPSBzdGF0ZS0+ZmxhZ3M7Cj4g
KwlmbGFncyA9IGV4dHJhLT5mbGFnczsKPiAgIAo+ICAgCWlmIChmbGFncyAmIFZSSU5HX0RFU0Nf
Rl9JTkRJUkVDVCkgewo+ICAgCQlkbWFfdW5tYXBfc2luZ2xlKHZyaW5nX2RtYV9kZXYodnEpLAo+
IC0JCQkJIHN0YXRlLT5hZGRyLCBzdGF0ZS0+bGVuLAo+ICsJCQkJIGV4dHJhLT5hZGRyLCBleHRy
YS0+bGVuLAo+ICAgCQkJCSAoZmxhZ3MgJiBWUklOR19ERVNDX0ZfV1JJVEUpID8KPiAgIAkJCQkg
RE1BX0ZST01fREVWSUNFIDogRE1BX1RPX0RFVklDRSk7Cj4gICAJfSBlbHNlIHsKPiAgIAkJZG1h
X3VubWFwX3BhZ2UodnJpbmdfZG1hX2Rldih2cSksCj4gLQkJCSAgICAgICBzdGF0ZS0+YWRkciwg
c3RhdGUtPmxlbiwKPiArCQkJICAgICAgIGV4dHJhLT5hZGRyLCBleHRyYS0+bGVuLAo+ICAgCQkJ
ICAgICAgIChmbGFncyAmIFZSSU5HX0RFU0NfRl9XUklURSkgPwo+ICAgCQkJICAgICAgIERNQV9G
Uk9NX0RFVklDRSA6IERNQV9UT19ERVZJQ0UpOwo+ICAgCX0KPiBAQCAtMTMwMyw4ICsxMzAzLDcg
QEAgc3RhdGljIGlubGluZSBpbnQgdmlydHF1ZXVlX2FkZF9wYWNrZWQoc3RydWN0IHZpcnRxdWV1
ZSAqX3ZxLAo+ICAgCWZvciAobiA9IDA7IG4gPCB0b3RhbF9zZzsgbisrKSB7Cj4gICAJCWlmIChp
ID09IGVycl9pZHgpCj4gICAJCQlicmVhazsKPiAtCQl2cmluZ191bm1hcF9zdGF0ZV9wYWNrZWQo
dnEsCj4gLQkJCQkJICZ2cS0+cGFja2VkLmRlc2NfZXh0cmFbY3Vycl0pOwo+ICsJCXZyaW5nX3Vu
bWFwX2V4dHJhX3BhY2tlZCh2cSwgJnZxLT5wYWNrZWQuZGVzY19leHRyYVtjdXJyXSk7Cj4gICAJ
CWN1cnIgPSB2cS0+cGFja2VkLmRlc2NfZXh0cmFbY3Vycl0ubmV4dDsKPiAgIAkJaSsrOwo+ICAg
CQlpZiAoaSA+PSB2cS0+cGFja2VkLnZyaW5nLm51bSkKPiBAQCAtMTM4Myw4ICsxMzgyLDggQEAg
c3RhdGljIHZvaWQgZGV0YWNoX2J1Zl9wYWNrZWQoc3RydWN0IHZyaW5nX3ZpcnRxdWV1ZSAqdnEs
Cj4gICAJaWYgKHVubGlrZWx5KHZxLT51c2VfZG1hX2FwaSkpIHsKPiAgIAkJY3VyciA9IGlkOwo+
ICAgCQlmb3IgKGkgPSAwOyBpIDwgc3RhdGUtPm51bTsgaSsrKSB7Cj4gLQkJCXZyaW5nX3VubWFw
X3N0YXRlX3BhY2tlZCh2cSwKPiAtCQkJCSZ2cS0+cGFja2VkLmRlc2NfZXh0cmFbY3Vycl0pOwo+
ICsJCQl2cmluZ191bm1hcF9leHRyYV9wYWNrZWQodnEsCj4gKwkJCQkJCSAmdnEtPnBhY2tlZC5k
ZXNjX2V4dHJhW2N1cnJdKTsKPiAgIAkJCWN1cnIgPSB2cS0+cGFja2VkLmRlc2NfZXh0cmFbY3Vy
cl0ubmV4dDsKPiAgIAkJfQo+ICAgCX0KCl9fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fClZpcnR1YWxpemF0aW9uIG1haWxpbmcgbGlzdApWaXJ0dWFsaXphdGlv
bkBsaXN0cy5saW51eC1mb3VuZGF0aW9uLm9yZwpodHRwczovL2xpc3RzLmxpbnV4Zm91bmRhdGlv
bi5vcmcvbWFpbG1hbi9saXN0aW5mby92aXJ0dWFsaXphdGlvbg==
