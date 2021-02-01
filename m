Return-Path: <SRS0=ow7J=HD=lists.linux-foundation.org=virtualization-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.1 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CD29EC433DB
	for <virtualization@archiver.kernel.org>; Mon,  1 Feb 2021 05:43:45 +0000 (UTC)
Received: from silver.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 7399164E15
	for <virtualization@archiver.kernel.org>; Mon,  1 Feb 2021 05:43:45 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7399164E15
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=virtualization-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by silver.osuosl.org (Postfix) with ESMTP id 38D102002B;
	Mon,  1 Feb 2021 05:43:45 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from silver.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id GiyAdWyT9SN4; Mon,  1 Feb 2021 05:43:44 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by silver.osuosl.org (Postfix) with ESMTP id DF2EA20022;
	Mon,  1 Feb 2021 05:43:43 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id B9E9EC0FA7;
	Mon,  1 Feb 2021 05:43:43 +0000 (UTC)
Received: from silver.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 2AF28C013A
 for <virtualization@lists.linux-foundation.org>;
 Mon,  1 Feb 2021 05:43:42 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by silver.osuosl.org (Postfix) with ESMTP id 0D6EC20026
 for <virtualization@lists.linux-foundation.org>;
 Mon,  1 Feb 2021 05:43:42 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from silver.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id A2QJaYX-1xUd
 for <virtualization@lists.linux-foundation.org>;
 Mon,  1 Feb 2021 05:43:40 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [63.128.21.124])
 by silver.osuosl.org (Postfix) with ESMTPS id 855F820022
 for <virtualization@lists.linux-foundation.org>;
 Mon,  1 Feb 2021 05:43:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1612158219;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=5ZTIT6r9DAQKDIN9nnIQ8ksj8MiamUBCd7gKXxENqMM=;
 b=XCzlEu3hK7GvM6DDgPe8vljYPL5CEpzkg/2fqgBUbg/ZZ3nxPXRP1sUFvg74imqARFv9qN
 qDIKSHTvm7QY39Y5ESGqgcBNkvjgI9bbE2wuBHAoExoZfGNKBJLnnkCTCYr/OaSMSbfLCH
 0mx/HfiWJohroh3ccGssby0kEg3pAKo=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-452-Ovnzy_d2OluYL-XINZbruw-1; Mon, 01 Feb 2021 00:43:35 -0500
X-MC-Unique: Ovnzy_d2OluYL-XINZbruw-1
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com
 [10.5.11.23])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 13FBE18C89DE;
 Mon,  1 Feb 2021 05:43:34 +0000 (UTC)
Received: from [10.72.13.120] (ovpn-13-120.pek2.redhat.com [10.72.13.120])
 by smtp.corp.redhat.com (Postfix) with ESMTP id CC16227C42;
 Mon,  1 Feb 2021 05:43:24 +0000 (UTC)
Subject: Re: [PATCH RFC v2 04/10] vringh: implement vringh_kiov_advance()
To: Stefano Garzarella <sgarzare@redhat.com>,
 virtualization@lists.linux-foundation.org
References: <20210128144127.113245-1-sgarzare@redhat.com>
 <20210128144127.113245-5-sgarzare@redhat.com>
From: Jason Wang <jasowang@redhat.com>
Message-ID: <78247eb0-8e6e-f2fa-a693-1b0f14db61dd@redhat.com>
Date: Mon, 1 Feb 2021 13:43:23 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <20210128144127.113245-5-sgarzare@redhat.com>
Content-Language: en-US
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
Cc: Laurent Vivier <lvivier@redhat.com>, Max Gurtovoy <mgurtovoy@nvidia.com>,
 kvm@vger.kernel.org, "Michael S. Tsirkin" <mst@redhat.com>,
 linux-kernel@vger.kernel.org, Xie Yongji <xieyongji@bytedance.com>,
 Stefan Hajnoczi <stefanha@redhat.com>
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

Ck9uIDIwMjEvMS8yOCDkuIvljYgxMDo0MSwgU3RlZmFubyBHYXJ6YXJlbGxhIHdyb3RlOgo+IElu
IHNvbWUgY2FzZXMsIGl0IG1heSBiZSB1c2VmdWwgdG8gcHJvdmlkZSBhIHdheSB0byBza2lwIGEg
bnVtYmVyCj4gb2YgYnl0ZXMgaW4gYSB2cmluZ2hfa2lvdi4KPgo+IExldCdzIGltcGxlbWVudCB2
cmluZ2hfa2lvdl9hZHZhbmNlKCkgZm9yIHRoaXMgcHVycG9zZSwgcmV1c2luZyB0aGUKPiBjb2Rl
IGZyb20gdnJpbmdoX2lvdl94ZmVyKCkuCj4gV2UgcmVwbGFjZSB0aGF0IGNvZGUgY2FsbGluZyB0
aGUgbmV3IHZyaW5naF9raW92X2FkdmFuY2UoKS4KCgpBY2tlZC1ieTogSmFzb24gV2FuZyA8amFz
b3dhbmdAcmVkaGF0LmNvbT4KCkluIHRoZSBsb25nIHJ1biB3ZSBuZWVkIHRvIHN3aXRjaCB0byB1
c2UgaW92IGl0ZXJhdG9yIGxpYnJhcnkgaW5zdGVhZC4KClRoYW5rcwoKCj4KPiBTaWduZWQtb2Zm
LWJ5OiBTdGVmYW5vIEdhcnphcmVsbGEgPHNnYXJ6YXJlQHJlZGhhdC5jb20+Cj4gLS0tCj4gICBp
bmNsdWRlL2xpbnV4L3ZyaW5naC5oIHwgIDIgKysKPiAgIGRyaXZlcnMvdmhvc3QvdnJpbmdoLmMg
fCA0MSArKysrKysrKysrKysrKysrKysrKysrKysrKysrKy0tLS0tLS0tLS0tLQo+ICAgMiBmaWxl
cyBjaGFuZ2VkLCAzMSBpbnNlcnRpb25zKCspLCAxMiBkZWxldGlvbnMoLSkKPgo+IGRpZmYgLS1n
aXQgYS9pbmNsdWRlL2xpbnV4L3ZyaW5naC5oIGIvaW5jbHVkZS9saW51eC92cmluZ2guaAo+IGlu
ZGV4IDljMDc3ODYzYzhmNi4uNzU1MjExZWJkMTk1IDEwMDY0NAo+IC0tLSBhL2luY2x1ZGUvbGlu
dXgvdnJpbmdoLmgKPiArKysgYi9pbmNsdWRlL2xpbnV4L3ZyaW5naC5oCj4gQEAgLTE5OSw2ICsx
OTksOCBAQCBzdGF0aWMgaW5saW5lIHZvaWQgdnJpbmdoX2tpb3ZfY2xlYW51cChzdHJ1Y3QgdnJp
bmdoX2tpb3YgKmtpb3YpCj4gICAJa2lvdi0+aW92ID0gTlVMTDsKPiAgIH0KPiAgIAo+ICt2b2lk
IHZyaW5naF9raW92X2FkdmFuY2Uoc3RydWN0IHZyaW5naF9raW92ICpraW92LCBzaXplX3QgbGVu
KTsKPiArCj4gICBpbnQgdnJpbmdoX2dldGRlc2Nfa2VybihzdHJ1Y3QgdnJpbmdoICp2cmgsCj4g
ICAJCQlzdHJ1Y3QgdnJpbmdoX2tpb3YgKnJpb3YsCj4gICAJCQlzdHJ1Y3QgdnJpbmdoX2tpb3Yg
Kndpb3YsCj4gZGlmZiAtLWdpdCBhL2RyaXZlcnMvdmhvc3QvdnJpbmdoLmMgYi9kcml2ZXJzL3Zo
b3N0L3ZyaW5naC5jCj4gaW5kZXggYmVlNjNkNjgyMDFhLi40ZDgwMGU0ZjMxY2EgMTAwNjQ0Cj4g
LS0tIGEvZHJpdmVycy92aG9zdC92cmluZ2guYwo+ICsrKyBiL2RyaXZlcnMvdmhvc3QvdnJpbmdo
LmMKPiBAQCAtNzUsNiArNzUsMzQgQEAgc3RhdGljIGlubGluZSBpbnQgX192cmluZ2hfZ2V0X2hl
YWQoY29uc3Qgc3RydWN0IHZyaW5naCAqdnJoLAo+ICAgCXJldHVybiBoZWFkOwo+ICAgfQo+ICAg
Cj4gKy8qKgo+ICsgKiB2cmluZ2hfa2lvdl9hZHZhbmNlIC0gc2tpcCBieXRlcyBmcm9tIHZyaW5n
X2tpb3YKPiArICogQGlvdjogYW4gaW92IHBhc3NlZCB0byB2cmluZ2hfZ2V0ZGVzY18qKCkgKHVw
ZGF0ZWQgYXMgd2UgY29uc3VtZSkKPiArICogQGxlbjogdGhlIG1heGltdW0gbGVuZ3RoIHRvIGFk
dmFuY2UKPiArICovCj4gK3ZvaWQgdnJpbmdoX2tpb3ZfYWR2YW5jZShzdHJ1Y3QgdnJpbmdoX2tp
b3YgKmlvdiwgc2l6ZV90IGxlbikKPiArewo+ICsJd2hpbGUgKGxlbiAmJiBpb3YtPmkgPCBpb3Yt
PnVzZWQpIHsKPiArCQlzaXplX3QgcGFydGxlbiA9IG1pbihpb3YtPmlvdltpb3YtPmldLmlvdl9s
ZW4sIGxlbik7Cj4gKwo+ICsJCWlvdi0+Y29uc3VtZWQgKz0gcGFydGxlbjsKPiArCQlpb3YtPmlv
dltpb3YtPmldLmlvdl9sZW4gLT0gcGFydGxlbjsKPiArCQlpb3YtPmlvdltpb3YtPmldLmlvdl9i
YXNlICs9IHBhcnRsZW47Cj4gKwo+ICsJCWlmICghaW92LT5pb3ZbaW92LT5pXS5pb3ZfbGVuKSB7
Cj4gKwkJCS8qIEZpeCB1cCBvbGQgaW92IGVsZW1lbnQgdGhlbiBpbmNyZW1lbnQuICovCj4gKwkJ
CWlvdi0+aW92W2lvdi0+aV0uaW92X2xlbiA9IGlvdi0+Y29uc3VtZWQ7Cj4gKwkJCWlvdi0+aW92
W2lvdi0+aV0uaW92X2Jhc2UgLT0gaW92LT5jb25zdW1lZDsKPiArCj4gKwkJCWlvdi0+Y29uc3Vt
ZWQgPSAwOwo+ICsJCQlpb3YtPmkrKzsKPiArCQl9Cj4gKwo+ICsJCWxlbiAtPSBwYXJ0bGVuOwo+
ICsJfQo+ICt9Cj4gK0VYUE9SVF9TWU1CT0wodnJpbmdoX2tpb3ZfYWR2YW5jZSk7Cj4gKwo+ICAg
LyogQ29weSBzb21lIGJ5dGVzIHRvL2Zyb20gdGhlIGlvdmVjLiAgUmV0dXJucyBudW0gY29waWVk
LiAqLwo+ICAgc3RhdGljIGlubGluZSBzc2l6ZV90IHZyaW5naF9pb3ZfeGZlcihzdHJ1Y3QgdnJp
bmdoICp2cmgsCj4gICAJCQkJICAgICAgc3RydWN0IHZyaW5naF9raW92ICppb3YsCj4gQEAgLTk1
LDE5ICsxMjMsOCBAQCBzdGF0aWMgaW5saW5lIHNzaXplX3QgdnJpbmdoX2lvdl94ZmVyKHN0cnVj
dCB2cmluZ2ggKnZyaCwKPiAgIAkJZG9uZSArPSBwYXJ0bGVuOwo+ICAgCQlsZW4gLT0gcGFydGxl
bjsKPiAgIAkJcHRyICs9IHBhcnRsZW47Cj4gLQkJaW92LT5jb25zdW1lZCArPSBwYXJ0bGVuOwo+
IC0JCWlvdi0+aW92W2lvdi0+aV0uaW92X2xlbiAtPSBwYXJ0bGVuOwo+IC0JCWlvdi0+aW92W2lv
di0+aV0uaW92X2Jhc2UgKz0gcGFydGxlbjsKPiAgIAo+IC0JCWlmICghaW92LT5pb3ZbaW92LT5p
XS5pb3ZfbGVuKSB7Cj4gLQkJCS8qIEZpeCB1cCBvbGQgaW92IGVsZW1lbnQgdGhlbiBpbmNyZW1l
bnQuICovCj4gLQkJCWlvdi0+aW92W2lvdi0+aV0uaW92X2xlbiA9IGlvdi0+Y29uc3VtZWQ7Cj4g
LQkJCWlvdi0+aW92W2lvdi0+aV0uaW92X2Jhc2UgLT0gaW92LT5jb25zdW1lZDsKPiAtCj4gLQkJ
CQo+IC0JCQlpb3YtPmNvbnN1bWVkID0gMDsKPiAtCQkJaW92LT5pKys7Cj4gLQkJfQo+ICsJCXZy
aW5naF9raW92X2FkdmFuY2UoaW92LCBwYXJ0bGVuKTsKPiAgIAl9Cj4gICAJcmV0dXJuIGRvbmU7
Cj4gICB9CgpfX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fXwpW
aXJ0dWFsaXphdGlvbiBtYWlsaW5nIGxpc3QKVmlydHVhbGl6YXRpb25AbGlzdHMubGludXgtZm91
bmRhdGlvbi5vcmcKaHR0cHM6Ly9saXN0cy5saW51eGZvdW5kYXRpb24ub3JnL21haWxtYW4vbGlz
dGluZm8vdmlydHVhbGl6YXRpb24=
