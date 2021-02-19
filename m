Return-Path: <SRS0=x/cL=HV=lists.linux-foundation.org=virtualization-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-20.1 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4E0FAC433DB
	for <virtualization@archiver.kernel.org>; Fri, 19 Feb 2021 03:16:15 +0000 (UTC)
Received: from fraxinus.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id BDC3364EBD
	for <virtualization@archiver.kernel.org>; Fri, 19 Feb 2021 03:16:14 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BDC3364EBD
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=virtualization-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by fraxinus.osuosl.org (Postfix) with ESMTP id 6D20A86B25;
	Fri, 19 Feb 2021 03:16:14 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from fraxinus.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id 6PTLEfOrSOex; Fri, 19 Feb 2021 03:16:11 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by fraxinus.osuosl.org (Postfix) with ESMTP id 6665286B85;
	Fri, 19 Feb 2021 03:16:09 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 4489EC000E;
	Fri, 19 Feb 2021 03:16:09 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 797C5C000D
 for <virtualization@lists.linux-foundation.org>;
 Fri, 19 Feb 2021 03:16:07 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id 5EAB9606A0
 for <virtualization@lists.linux-foundation.org>;
 Fri, 19 Feb 2021 03:16:07 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id 7q4ytqAybsn4
 for <virtualization@lists.linux-foundation.org>;
 Fri, 19 Feb 2021 03:16:06 +0000 (UTC)
Received: by smtp3.osuosl.org (Postfix, from userid 1001)
 id 4BB8B606B0; Fri, 19 Feb 2021 03:16:06 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [63.128.21.124])
 by smtp3.osuosl.org (Postfix) with ESMTPS id 29F026065E
 for <virtualization@lists.linux-foundation.org>;
 Fri, 19 Feb 2021 03:16:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1613704562;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=sVu2OFs31PBcQyFakp4hGxXg+SBFI9kvRMMBU49pcRw=;
 b=hrAJmTPr1m9VYfKv8JvhYstkgsOQS1BvTWgWHv7Jzm7bgoEYhbupwetPKg+3PHcQbKeqpR
 xgHasESw6IkG2KPISOK+iTp7l3hlFxKvUwtKSi5oE6MdLJeEpopTXDb+xr8p6U/HQZobe9
 OpP2wAVlduKdBZBz6U5GDU2Ya1l6uMs=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-422-a9ATk73mMH6BAhc6FVw66g-1; Thu, 18 Feb 2021 22:15:58 -0500
X-MC-Unique: a9ATk73mMH6BAhc6FVw66g-1
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com
 [10.5.11.13])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id DDA2418449E0;
 Fri, 19 Feb 2021 03:15:57 +0000 (UTC)
Received: from wangxiaodeMacBook-Air.local (ovpn-12-188.pek2.redhat.com
 [10.72.12.188])
 by smtp.corp.redhat.com (Postfix) with ESMTP id B34D86F98F;
 Fri, 19 Feb 2021 03:15:49 +0000 (UTC)
Subject: Re: [PATCH v2] virtio-blk: support per-device queue depth
To: Joseph Qi <joseph.qi@linux.alibaba.com>,
 "Michael S. Tsirkin" <mst@redhat.com>
References: <1611307306-71067-1-git-send-email-joseph.qi@linux.alibaba.com>
 <20210126111338.GB250425@stefanha-x1.localdomain>
 <09e02c76-f801-81ef-d6b9-9514ac39a3a1@linux.alibaba.com>
 <d545c35a-bf57-65d1-8369-9d99b59bea11@linux.alibaba.com>
From: Jason Wang <jasowang@redhat.com>
Message-ID: <fe81fadb-d891-9d27-25bf-8331d4d69b72@redhat.com>
Date: Fri, 19 Feb 2021 11:15:48 +0800
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.16; rv:78.0)
 Gecko/20100101 Thunderbird/78.7.1
MIME-Version: 1.0
In-Reply-To: <d545c35a-bf57-65d1-8369-9d99b59bea11@linux.alibaba.com>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=jasowang@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Language: en-GB
Cc: Paolo Bonzini <pbonzini@redhat.com>, Stefan Hajnoczi <stefanha@redhat.com>,
 virtualization@lists.linux-foundation.org
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

Ck9uIDIwMjEvMi8xOSAxMTowNiDkuIrljYgsIEpvc2VwaCBRaSB3cm90ZToKPiBIaSBNaWNoYWVs
LAo+IENvdWxkIHlvdSB0YWtlIHRoaXMgbm93PwoKCkl0IGhhcyBiZWVuIG1lcmdlZDoKCmh0dHBz
Oi8vZ2l0Lmtlcm5lbC5vcmcvcHViL3NjbS9saW51eC9rZXJuZWwvZ2l0L21zdC92aG9zdC5naXQv
Y29tbWl0Lz9oPXZob3N0JmlkPThjNmRhYTc5ZTUyN2EwNWFkYjZmNWQ0MmNiZWQyZmUzNmM2YjNl
ODMKClRoYW5rcwoKCj4KPiBUaGFua3MsCj4gSm9zZXBoCj4KPiBPbiAyLzEvMjEgMTA6MTcgQU0s
IEpvc2VwaCBRaSB3cm90ZToKPj4gUGluZy4uLgo+Pgo+PiBPbiAxLzI2LzIxIDc6MTMgUE0sIFN0
ZWZhbiBIYWpub2N6aSB3cm90ZToKPj4+IE9uIEZyaSwgSmFuIDIyLCAyMDIxIGF0IDA1OjIxOjQ2
UE0gKzA4MDAsIEpvc2VwaCBRaSB3cm90ZToKPj4+PiBtb2R1bGUgcGFyYW1ldGVyICd2aXJ0Ymxr
X3F1ZXVlX2RlcHRoJyB3YXMgZmlyc3RseSBpbnRyb2R1Y2VkIGZvcgo+Pj4+IHRlc3RpbmcvYmVu
Y2htYXJraW5nIHB1cnBvc2VzIGRlc2NyaWJlZCBpbiBjb21taXQgZmM0MzI0YjQ1OTdjCj4+Pj4g
KCJ2aXJ0aW8tYmxrOiBiYXNlIHF1ZXVlLWRlcHRoIG9uIHZpcnRxdWV1ZSByaW5nc2l6ZSBvciBt
b2R1bGUgcGFyYW0iKS4KPj4+PiBBbmQgY3VycmVudGx5ICd2aXJ0YmxrX3F1ZXVlX2RlcHRoJyBp
cyB1c2VkIGFzIGEgc2F2ZWQgdmFsdWUgZm9yIHRoZQo+Pj4+IGZpcnN0IHByb2JlZCBkZXZpY2Uu
Cj4+Pj4gU2luY2Ugd2UgaGF2ZSBkaWZmZXJlbnQgdmlydGlvLWJsayBkZXZpY2VzIHdoaWNoIGhh
dmUgZGlmZmVyZW50Cj4+Pj4gY2FwYWJpbGl0aWVzLCBpdCByZXF1aXJlcyB0aGF0IHdlIHN1cHBv
cnQgcGVyLWRldmljZSBxdWV1ZSBkZXB0aCBpbnN0ZWFkCj4+Pj4gb2YgcGVyLW1vZHVsZS4gU28g
ZGVmYXVsdGx5IHVzZSB2cSBmcmVlIGVsZW1lbnRzIGlmIG1vZHVsZSBwYXJhbWV0ZXIKPj4+PiAn
dmlydGJsa19xdWV1ZV9kZXB0aCcgaXMgbm90IHNldC4KPj4+Pgo+Pj4+IFNpZ25lZC1vZmYtYnk6
IEpvc2VwaCBRaSA8am9zZXBoLnFpQGxpbnV4LmFsaWJhYmEuY29tPgo+Pj4+IEFja2VkLWJ5OiBK
YXNvbiBXYW5nIDxqYXNvd2FuZ0ByZWRoYXQuY29tPgo+Pj4+IC0tLQo+Pj4+ICAgZHJpdmVycy9i
bG9jay92aXJ0aW9fYmxrLmMgfCAxMSArKysrKysrLS0tLQo+Pj4+ICAgMSBmaWxlIGNoYW5nZWQs
IDcgaW5zZXJ0aW9ucygrKSwgNCBkZWxldGlvbnMoLSkKCj4+PiBSZXZpZXdlZC1ieTogU3RlZmFu
IEhham5vY3ppIDxzdGVmYW5oYUByZWRoYXQuY29tPgo+Pj4KCl9fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fClZpcnR1YWxpemF0aW9uIG1haWxpbmcgbGlzdApW
aXJ0dWFsaXphdGlvbkBsaXN0cy5saW51eC1mb3VuZGF0aW9uLm9yZwpodHRwczovL2xpc3RzLmxp
bnV4Zm91bmRhdGlvbi5vcmcvbWFpbG1hbi9saXN0aW5mby92aXJ0dWFsaXphdGlvbg==
