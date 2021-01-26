Return-Path: <SRS0=+Z4V=G5=lists.linux-foundation.org=virtualization-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.1 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3077AC433E0
	for <virtualization@archiver.kernel.org>; Tue, 26 Jan 2021 08:19:47 +0000 (UTC)
Received: from hemlock.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B47A220717
	for <virtualization@archiver.kernel.org>; Tue, 26 Jan 2021 08:19:46 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B47A220717
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=virtualization-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by hemlock.osuosl.org (Postfix) with ESMTP id 2EE8887013;
	Tue, 26 Jan 2021 08:19:46 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from hemlock.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id 5fjAN9vsVP1h; Tue, 26 Jan 2021 08:19:45 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by hemlock.osuosl.org (Postfix) with ESMTP id 93E7587006;
	Tue, 26 Jan 2021 08:19:45 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 782C1C08A1;
	Tue, 26 Jan 2021 08:19:45 +0000 (UTC)
Received: from silver.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 7517DC013A
 for <virtualization@lists.linux-foundation.org>;
 Tue, 26 Jan 2021 08:19:44 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by silver.osuosl.org (Postfix) with ESMTP id 57FDA203E1
 for <virtualization@lists.linux-foundation.org>;
 Tue, 26 Jan 2021 08:19:44 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from silver.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id 3YiCagc7JF+8
 for <virtualization@lists.linux-foundation.org>;
 Tue, 26 Jan 2021 08:19:43 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [63.128.21.124])
 by silver.osuosl.org (Postfix) with ESMTPS id 4A6F420034
 for <virtualization@lists.linux-foundation.org>;
 Tue, 26 Jan 2021 08:19:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1611649182;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=dMTvjaMSAfTTa27ylw0ds1j6FG5ed6ihblNq6KfLvCg=;
 b=ZTF1WMgsz+CtLWtGBHwdewP/0YghOztQ0R33ug6ha+rNxknOHxQI3xZaVPCVxsG2ikD+gA
 ayLCTTLRnY7zby9r8DO/wXDTaFtTk9ecNK0nAMevKxjTuYvwT2e9vY4XwkxMnqP6Egsn9S
 npwuUpZkwYC4i0hsRltQP0QCL0IgSwY=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-282-THLH8a-qP6-IH6UDIF3e1g-1; Tue, 26 Jan 2021 03:19:39 -0500
X-MC-Unique: THLH8a-qP6-IH6UDIF3e1g-1
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com
 [10.5.11.12])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 67674195D563;
 Tue, 26 Jan 2021 08:19:37 +0000 (UTC)
Received: from [10.72.12.70] (ovpn-12-70.pek2.redhat.com [10.72.12.70])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 9F9E560C47;
 Tue, 26 Jan 2021 08:19:26 +0000 (UTC)
Subject: Re: [RFC v3 08/11] vduse: Introduce VDUSE - vDPA Device in Userspace
To: Xie Yongji <xieyongji@bytedance.com>, mst@redhat.com,
 stefanha@redhat.com, sgarzare@redhat.com, parav@nvidia.com,
 bob.liu@oracle.com, hch@infradead.org, rdunlap@infradead.org,
 willy@infradead.org, viro@zeniv.linux.org.uk, axboe@kernel.dk,
 bcrl@kvack.org, corbet@lwn.net
References: <20210119045920.447-1-xieyongji@bytedance.com>
 <20210119050756.600-1-xieyongji@bytedance.com>
 <20210119050756.600-2-xieyongji@bytedance.com>
From: Jason Wang <jasowang@redhat.com>
Message-ID: <1f419a24-cd53-bd73-5b8a-8ab5d976a490@redhat.com>
Date: Tue, 26 Jan 2021 16:19:25 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <20210119050756.600-2-xieyongji@bytedance.com>
Content-Language: en-US
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
Cc: linux-aio@kvack.org, netdev@vger.kernel.org, linux-fsdevel@vger.kernel.org,
 kvm@vger.kernel.org, virtualization@lists.linux-foundation.org
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

Ck9uIDIwMjEvMS8xOSDkuIvljYgxOjA3LCBYaWUgWW9uZ2ppIHdyb3RlOgo+IFRoaXMgVkRVU0Ug
ZHJpdmVyIGVuYWJsZXMgaW1wbGVtZW50aW5nIHZEUEEgZGV2aWNlcyBpbiB1c2Vyc3BhY2UuCj4g
Qm90aCBjb250cm9sIHBhdGggYW5kIGRhdGEgcGF0aCBvZiB2RFBBIGRldmljZXMgd2lsbCBiZSBh
YmxlIHRvCj4gYmUgaGFuZGxlZCBpbiB1c2Vyc3BhY2UuCj4KPiBJbiB0aGUgY29udHJvbCBwYXRo
LCB0aGUgVkRVU0UgZHJpdmVyIHdpbGwgbWFrZSB1c2Ugb2YgbWVzc2FnZQo+IG1lY2huaXNtIHRv
IGZvcndhcmQgdGhlIGNvbmZpZyBvcGVyYXRpb24gZnJvbSB2ZHBhIGJ1cyBkcml2ZXIKPiB0byB1
c2Vyc3BhY2UuIFVzZXJzcGFjZSBjYW4gdXNlIHJlYWQoKS93cml0ZSgpIHRvIHJlY2VpdmUvcmVw
bHkKPiB0aG9zZSBjb250cm9sIG1lc3NhZ2VzLgo+Cj4gSW4gdGhlIGRhdGEgcGF0aCwgVkRVU0Vf
SU9UTEJfR0VUX0ZEIGlvY3RsIHdpbGwgYmUgdXNlZCB0byBnZXQKPiB0aGUgZmlsZSBkZXNjcmlw
dG9ycyByZWZlcnJpbmcgdG8gdkRQQSBkZXZpY2UncyBpb3ZhIHJlZ2lvbnMuIFRoZW4KPiB1c2Vy
c3BhY2UgY2FuIHVzZSBtbWFwKCkgdG8gYWNjZXNzIHRob3NlIGlvdmEgcmVnaW9ucy4gQmVzaWRl
cywKPiB0aGUgZXZlbnRmZCBtZWNoYW5pc20gaXMgdXNlZCB0byB0cmlnZ2VyIGludGVycnVwdCBj
YWxsYmFja3MgYW5kCj4gcmVjZWl2ZSB2aXJ0cXVldWUga2lja3MgaW4gdXNlcnNwYWNlLgo+Cj4g
U2lnbmVkLW9mZi1ieTogWGllIFlvbmdqaTx4aWV5b25namlAYnl0ZWRhbmNlLmNvbT4KPiAtLS0K
PiAgIERvY3VtZW50YXRpb24vZHJpdmVyLWFwaS92ZHVzZS5yc3QgICAgICAgICAgICAgICAgIHwg
ICA4NSArKwo+ICAgRG9jdW1lbnRhdGlvbi91c2Vyc3BhY2UtYXBpL2lvY3RsL2lvY3RsLW51bWJl
ci5yc3QgfCAgICAxICsKPiAgIGRyaXZlcnMvdmRwYS9LY29uZmlnICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgIHwgICAgNyArCj4gICBkcml2ZXJzL3ZkcGEvTWFrZWZpbGUgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICB8ICAgIDEgKwo+ICAgZHJpdmVycy92ZHBhL3ZkcGFfdXNlci9N
YWtlZmlsZSAgICAgICAgICAgICAgICAgICAgfCAgICA1ICsKPiAgIGRyaXZlcnMvdmRwYS92ZHBh
X3VzZXIvZXZlbnRmZC5jICAgICAgICAgICAgICAgICAgIHwgIDIyMSArKysrCj4gICBkcml2ZXJz
L3ZkcGEvdmRwYV91c2VyL2V2ZW50ZmQuaCAgICAgICAgICAgICAgICAgICB8ICAgNDggKwo+ICAg
ZHJpdmVycy92ZHBhL3ZkcGFfdXNlci9pb3ZhX2RvbWFpbi5jICAgICAgICAgICAgICAgfCAgNDI2
ICsrKysrKysKPiAgIGRyaXZlcnMvdmRwYS92ZHBhX3VzZXIvaW92YV9kb21haW4uaCAgICAgICAg
ICAgICAgIHwgICA2OCArKwo+ICAgZHJpdmVycy92ZHBhL3ZkcGFfdXNlci92ZHVzZS5oICAgICAg
ICAgICAgICAgICAgICAgfCAgIDYyICsKPiAgIGRyaXZlcnMvdmRwYS92ZHBhX3VzZXIvdmR1c2Vf
ZGV2LmMgICAgICAgICAgICAgICAgIHwgMTIxNyArKysrKysrKysrKysrKysrKysrKwo+ICAgaW5j
bHVkZS91YXBpL2xpbnV4L3ZkcGEuaCAgICAgICAgICAgICAgICAgICAgICAgICAgfCAgICAxICsK
PiAgIGluY2x1ZGUvdWFwaS9saW51eC92ZHVzZS5oICAgICAgICAgICAgICAgICAgICAgICAgIHwg
IDEyNSArKwo+ICAgMTMgZmlsZXMgY2hhbmdlZCwgMjI2NyBpbnNlcnRpb25zKCspCj4gICBjcmVh
dGUgbW9kZSAxMDA2NDQgRG9jdW1lbnRhdGlvbi9kcml2ZXItYXBpL3ZkdXNlLnJzdAo+ICAgY3Jl
YXRlIG1vZGUgMTAwNjQ0IGRyaXZlcnMvdmRwYS92ZHBhX3VzZXIvTWFrZWZpbGUKPiAgIGNyZWF0
ZSBtb2RlIDEwMDY0NCBkcml2ZXJzL3ZkcGEvdmRwYV91c2VyL2V2ZW50ZmQuYwo+ICAgY3JlYXRl
IG1vZGUgMTAwNjQ0IGRyaXZlcnMvdmRwYS92ZHBhX3VzZXIvZXZlbnRmZC5oCj4gICBjcmVhdGUg
bW9kZSAxMDA2NDQgZHJpdmVycy92ZHBhL3ZkcGFfdXNlci9pb3ZhX2RvbWFpbi5jCj4gICBjcmVh
dGUgbW9kZSAxMDA2NDQgZHJpdmVycy92ZHBhL3ZkcGFfdXNlci9pb3ZhX2RvbWFpbi5oCj4gICBj
cmVhdGUgbW9kZSAxMDA2NDQgZHJpdmVycy92ZHBhL3ZkcGFfdXNlci92ZHVzZS5oCj4gICBjcmVh
dGUgbW9kZSAxMDA2NDQgZHJpdmVycy92ZHBhL3ZkcGFfdXNlci92ZHVzZV9kZXYuYwo+ICAgY3Jl
YXRlIG1vZGUgMTAwNjQ0IGluY2x1ZGUvdWFwaS9saW51eC92ZHVzZS5oCgoKQnR3LCBpZiB5b3Ug
Y291bGQgc3BsaXQgdGhpcyBpbnRvIHRocmVlIHBhcnRzOgoKMSkgaW92YSBkb21haW4KMikgdmR1
c2UgZGV2aWNlCjMpIGRvYwoKSXQgd291bGQgYmUgbW9yZSBlYXNpZXIgZm9yIHRoZSByZXZpZXdl
cnMuCgpUaGFua3MKCl9fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fClZpcnR1YWxpemF0aW9uIG1haWxpbmcgbGlzdApWaXJ0dWFsaXphdGlvbkBsaXN0cy5saW51
eC1mb3VuZGF0aW9uLm9yZwpodHRwczovL2xpc3RzLmxpbnV4Zm91bmRhdGlvbi5vcmcvbWFpbG1h
bi9saXN0aW5mby92aXJ0dWFsaXphdGlvbg==
