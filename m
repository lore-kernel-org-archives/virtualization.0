Return-Path: <SRS0=KYCx=IQ=lists.linux-foundation.org=virtualization-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.1 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D3FD0C433E0
	for <virtualization@archiver.kernel.org>; Thu, 18 Mar 2021 03:24:31 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 63E0B64EB3
	for <virtualization@archiver.kernel.org>; Thu, 18 Mar 2021 03:24:31 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 63E0B64EB3
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=virtualization-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 1B391606A3;
	Thu, 18 Mar 2021 03:24:31 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
	by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id 9rN_dD4WAapn; Thu, 18 Mar 2021 03:24:30 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp3.osuosl.org (Postfix) with ESMTP id C98BF605CB;
	Thu, 18 Mar 2021 03:24:29 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 9BB5FC000B;
	Thu, 18 Mar 2021 03:24:29 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 84245C0001
 for <virtualization@lists.linux-foundation.org>;
 Thu, 18 Mar 2021 03:24:28 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id 7E45282D75
 for <virtualization@lists.linux-foundation.org>;
 Thu, 18 Mar 2021 03:24:28 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp1.osuosl.org (amavisd-new);
 dkim=pass (1024-bit key) header.d=redhat.com
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id G4nP7BkuFS5X
 for <virtualization@lists.linux-foundation.org>;
 Thu, 18 Mar 2021 03:24:27 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [63.128.21.124])
 by smtp1.osuosl.org (Postfix) with ESMTPS id C589A82D12
 for <virtualization@lists.linux-foundation.org>;
 Thu, 18 Mar 2021 03:24:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1616037866;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=Sk99JE96HUPSTLu/4JDMtH8mhmtCcHHNeKecLnAG+NE=;
 b=hbkEy4e4gzO0lf3fZMdx+5koTXY+AYY0cZMug/uzBGRp7FlHV84W0ZAIUbbeFAUKJ+8Mh/
 /KQc3B28+nIoBYysnNEnS8QHO1cHBpakrtKhvAtIIbWKXpkruI8wbokdb+UarGwl4CacBN
 NjVsV9LZL7M2AcS/5IZkev/BdHRMi4Y=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-444-9PzC1WQ9N_6YW8Wemxs-EQ-1; Wed, 17 Mar 2021 23:24:25 -0400
X-MC-Unique: 9PzC1WQ9N_6YW8Wemxs-EQ-1
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com
 [10.5.11.11])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 7641B81744F;
 Thu, 18 Mar 2021 03:24:23 +0000 (UTC)
Received: from wangxiaodeMacBook-Air.local (ovpn-13-131.pek2.redhat.com
 [10.72.13.131])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 192966C330;
 Thu, 18 Mar 2021 03:24:06 +0000 (UTC)
Subject: Re: [PATCH v4 10/14] vhost/vdpa: Remove the restriction that only
 supports virtio-net devices
To: Stefano Garzarella <sgarzare@redhat.com>,
 virtualization@lists.linux-foundation.org
References: <20210315163450.254396-1-sgarzare@redhat.com>
 <20210315163450.254396-11-sgarzare@redhat.com>
From: Jason Wang <jasowang@redhat.com>
Message-ID: <011fb2bf-bee5-7fb6-0abc-17ddf7026476@redhat.com>
Date: Thu, 18 Mar 2021 11:24:05 +0800
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.16; rv:78.0)
 Gecko/20100101 Thunderbird/78.8.1
MIME-Version: 1.0
In-Reply-To: <20210315163450.254396-11-sgarzare@redhat.com>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
Cc: Laurent Vivier <lvivier@redhat.com>, Max Gurtovoy <mgurtovoy@nvidia.com>,
 kvm@vger.kernel.org, "Michael S. Tsirkin" <mst@redhat.com>,
 netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
 Xie Yongji <xieyongji@bytedance.com>, Stefan Hajnoczi <stefanha@redhat.com>
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

CtTaIDIwMjEvMy8xNiDJz87nMTI6MzQsIFN0ZWZhbm8gR2FyemFyZWxsYSDQtLXAOgo+IEZyb206
IFhpZSBZb25namkgPHhpZXlvbmdqaUBieXRlZGFuY2UuY29tPgo+Cj4gU2luY2UgdGhlIGNvbmZp
ZyBjaGVja3MgYXJlIGRvbmUgYnkgdGhlIHZEUEEgZHJpdmVycywgd2UgY2FuIHJlbW92ZSB0aGUK
PiB2aXJ0aW8tbmV0IHJlc3RyaWN0aW9uIGFuZCB3ZSBzaG91bGQgYmUgYWJsZSB0byBzdXBwb3J0
IGFsbCBraW5kcyBvZgo+IHZpcnRpbyBkZXZpY2VzLgo+Cj4gPGxpbnV4L3ZpcnRpb19uZXQuaD4g
aXMgbm90IG5lZWRlZCBhbnltb3JlLCBidXQgd2UgbmVlZCB0byBpbmNsdWRlCj4gPGxpbnV4L3Ns
YWIuaD4gdG8gYXZvaWQgY29tcGlsYXRpb24gZmFpbHVyZXMuCj4KPiBTaWduZWQtb2ZmLWJ5OiBY
aWUgWW9uZ2ppIDx4aWV5b25namlAYnl0ZWRhbmNlLmNvbT4KPiBTaWduZWQtb2ZmLWJ5OiBTdGVm
YW5vIEdhcnphcmVsbGEgPHNnYXJ6YXJlQHJlZGhhdC5jb20+CgoKQWNrZWQtYnk6IEphc29uIFdh
bmcgPGphc293YW5nQHJlZGhhdC5jb20+CgoKPiAtLS0KPiAgIGRyaXZlcnMvdmhvc3QvdmRwYS5j
IHwgNiArLS0tLS0KPiAgIDEgZmlsZSBjaGFuZ2VkLCAxIGluc2VydGlvbigrKSwgNSBkZWxldGlv
bnMoLSkKPgo+IGRpZmYgLS1naXQgYS9kcml2ZXJzL3Zob3N0L3ZkcGEuYyBiL2RyaXZlcnMvdmhv
c3QvdmRwYS5jCj4gaW5kZXggN2FlNDA4MGU1N2Q4Li44NTBlZDRiNjI5NDIgMTAwNjQ0Cj4gLS0t
IGEvZHJpdmVycy92aG9zdC92ZHBhLmMKPiArKysgYi9kcml2ZXJzL3Zob3N0L3ZkcGEuYwo+IEBA
IC0xNiwxMiArMTYsMTIgQEAKPiAgICNpbmNsdWRlIDxsaW51eC9jZGV2Lmg+Cj4gICAjaW5jbHVk
ZSA8bGludXgvZGV2aWNlLmg+Cj4gICAjaW5jbHVkZSA8bGludXgvbW0uaD4KPiArI2luY2x1ZGUg
PGxpbnV4L3NsYWIuaD4KPiAgICNpbmNsdWRlIDxsaW51eC9pb21tdS5oPgo+ICAgI2luY2x1ZGUg
PGxpbnV4L3V1aWQuaD4KPiAgICNpbmNsdWRlIDxsaW51eC92ZHBhLmg+Cj4gICAjaW5jbHVkZSA8
bGludXgvbm9zcGVjLmg+Cj4gICAjaW5jbHVkZSA8bGludXgvdmhvc3QuaD4KPiAtI2luY2x1ZGUg
PGxpbnV4L3ZpcnRpb19uZXQuaD4KPiAgIAo+ICAgI2luY2x1ZGUgInZob3N0LmgiCj4gICAKPiBA
QCAtMTAxOCwxMCArMTAxOCw2IEBAIHN0YXRpYyBpbnQgdmhvc3RfdmRwYV9wcm9iZShzdHJ1Y3Qg
dmRwYV9kZXZpY2UgKnZkcGEpCj4gICAJaW50IG1pbm9yOwo+ICAgCWludCByOwo+ICAgCj4gLQkv
KiBDdXJyZW50bHksIHdlIG9ubHkgYWNjZXB0IHRoZSBuZXR3b3JrIGRldmljZXMuICovCj4gLQlp
ZiAob3BzLT5nZXRfZGV2aWNlX2lkKHZkcGEpICE9IFZJUlRJT19JRF9ORVQpCj4gLQkJcmV0dXJu
IC1FTk9UU1VQUDsKPiAtCj4gICAJdiA9IGt6YWxsb2Moc2l6ZW9mKCp2KSwgR0ZQX0tFUk5FTCB8
IF9fR0ZQX1JFVFJZX01BWUZBSUwpOwo+ICAgCWlmICghdikKPiAgIAkJcmV0dXJuIC1FTk9NRU07
CgpfX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fXwpWaXJ0dWFs
aXphdGlvbiBtYWlsaW5nIGxpc3QKVmlydHVhbGl6YXRpb25AbGlzdHMubGludXgtZm91bmRhdGlv
bi5vcmcKaHR0cHM6Ly9saXN0cy5saW51eGZvdW5kYXRpb24ub3JnL21haWxtYW4vbGlzdGluZm8v
dmlydHVhbGl6YXRpb24=
