Return-Path: <SRS0=JO0H=FL=lists.linux-foundation.org=virtualization-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.1 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 02466C433FE
	for <virtualization@archiver.kernel.org>; Mon,  7 Dec 2020 05:17:55 +0000 (UTC)
Received: from hemlock.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 630B3221FF
	for <virtualization@archiver.kernel.org>; Mon,  7 Dec 2020 05:17:54 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 630B3221FF
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=virtualization-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by hemlock.osuosl.org (Postfix) with ESMTP id 0941D87809;
	Mon,  7 Dec 2020 05:17:54 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from hemlock.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id xQbeGU95LwcR; Mon,  7 Dec 2020 05:17:53 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by hemlock.osuosl.org (Postfix) with ESMTP id 6A20A877FD;
	Mon,  7 Dec 2020 05:17:53 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 59710C0FA7;
	Mon,  7 Dec 2020 05:17:53 +0000 (UTC)
Received: from whitealder.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 36755C013B
 for <virtualization@lists.linux-foundation.org>;
 Mon,  7 Dec 2020 05:17:52 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by whitealder.osuosl.org (Postfix) with ESMTP id 1D37E86E81
 for <virtualization@lists.linux-foundation.org>;
 Mon,  7 Dec 2020 05:17:52 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from whitealder.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id wGRKrnU62oJN
 for <virtualization@lists.linux-foundation.org>;
 Mon,  7 Dec 2020 05:17:51 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [63.128.21.124])
 by whitealder.osuosl.org (Postfix) with ESMTPS id 3E25987789
 for <virtualization@lists.linux-foundation.org>;
 Mon,  7 Dec 2020 05:17:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1607318269;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=4NEmPb1vJdnm+1yHtk70TIfP0G6eCyJYhuhh3SVbKYs=;
 b=QcHsliStAPyrfP5n+aAYJ9NsgFTopiU8XjWL8kSm1p/t1s0fl3Mby8F7NgUPRvv0mx+yb/
 2GBMYfZ8y0aYwqTRiXFxDn53w45qpJwwPGLj/ehRJqvyrFWbby7FcJcIxwWblccKKcge7b
 gGYD7OdEoXhTno8lUSu8a6qQjgqWq1c=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-286-YHvFQFlePI672EkIO4xVIg-1; Mon, 07 Dec 2020 00:17:47 -0500
X-MC-Unique: YHvFQFlePI672EkIO4xVIg-1
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com
 [10.5.11.22])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 43ED7100C602;
 Mon,  7 Dec 2020 05:17:46 +0000 (UTC)
Received: from [10.72.13.171] (ovpn-13-171.pek2.redhat.com [10.72.13.171])
 by smtp.corp.redhat.com (Postfix) with ESMTP id B77D810016FA;
 Mon,  7 Dec 2020 05:17:36 +0000 (UTC)
Subject: Re: [PATCH] vhost scsi: fix error return code in
 vhost_scsi_set_endpoint()
To: Zhang Changzhong <zhangchangzhong@huawei.com>,
 "Michael S. Tsirkin" <mst@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>,
 Stefan Hajnoczi <stefanha@redhat.com>,
 Mike Christie <michael.christie@oracle.com>,
 Maurizio Lombardi <mlombard@redhat.com>
References: <1607071411-33484-1-git-send-email-zhangchangzhong@huawei.com>
From: Jason Wang <jasowang@redhat.com>
Message-ID: <754d3d21-1dfa-6675-5014-2e8fb102c363@redhat.com>
Date: Mon, 7 Dec 2020 13:17:35 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <1607071411-33484-1-git-send-email-zhangchangzhong@huawei.com>
Content-Language: en-US
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
Cc: netdev@vger.kernel.org, linux-kernel@vger.kernel.org, kvm@vger.kernel.org,
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

Ck9uIDIwMjAvMTIvNCDkuIvljYg0OjQzLCBaaGFuZyBDaGFuZ3pob25nIHdyb3RlOgo+IEZpeCB0
byByZXR1cm4gYSBuZWdhdGl2ZSBlcnJvciBjb2RlIGZyb20gdGhlIGVycm9yIGhhbmRsaW5nCj4g
Y2FzZSBpbnN0ZWFkIG9mIDAsIGFzIGRvbmUgZWxzZXdoZXJlIGluIHRoaXMgZnVuY3Rpb24uCj4K
PiBGaXhlczogMjViOThiNjRlMjg0ICgidmhvc3Qgc2NzaTogYWxsb2MgY21kcyBwZXIgdnEgaW5z
dGVhZCBvZiBzZXNzaW9uIikKPiBSZXBvcnRlZC1ieTogSHVsayBSb2JvdCA8aHVsa2NpQGh1YXdl
aS5jb20+Cj4gU2lnbmVkLW9mZi1ieTogWmhhbmcgQ2hhbmd6aG9uZyA8emhhbmdjaGFuZ3pob25n
QGh1YXdlaS5jb20+Cj4gLS0tCj4gICBkcml2ZXJzL3Zob3N0L3Njc2kuYyB8IDMgKystCj4gICAx
IGZpbGUgY2hhbmdlZCwgMiBpbnNlcnRpb25zKCspLCAxIGRlbGV0aW9uKC0pCj4KPiBkaWZmIC0t
Z2l0IGEvZHJpdmVycy92aG9zdC9zY3NpLmMgYi9kcml2ZXJzL3Zob3N0L3Njc2kuYwo+IGluZGV4
IDZmZjhhNTA5Ni4uNGNlOWYwMCAxMDA2NDQKPiAtLS0gYS9kcml2ZXJzL3Zob3N0L3Njc2kuYwo+
ICsrKyBiL2RyaXZlcnMvdmhvc3Qvc2NzaS5jCj4gQEAgLTE2NDMsNyArMTY0Myw4IEBAIHZob3N0
X3Njc2lfc2V0X2VuZHBvaW50KHN0cnVjdCB2aG9zdF9zY3NpICp2cywKPiAgIAkJCWlmICghdmhv
c3RfdnFfaXNfc2V0dXAodnEpKQo+ICAgCQkJCWNvbnRpbnVlOwo+ICAgCj4gLQkJCWlmICh2aG9z
dF9zY3NpX3NldHVwX3ZxX2NtZHModnEsIHZxLT5udW0pKQo+ICsJCQlyZXQgPSB2aG9zdF9zY3Np
X3NldHVwX3ZxX2NtZHModnEsIHZxLT5udW0pOwo+ICsJCQlpZiAocmV0KQo+ICAgCQkJCWdvdG8g
ZGVzdHJveV92cV9jbWRzOwo+ICAgCQl9Cj4gICAKCgpBY2tlZC1ieTogSmFzb24gV2FuZyA8amFz
b3dhbmdAcmVkaGF0LmNvbT4KCgpfX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fXwpWaXJ0dWFsaXphdGlvbiBtYWlsaW5nIGxpc3QKVmlydHVhbGl6YXRpb25AbGlz
dHMubGludXgtZm91bmRhdGlvbi5vcmcKaHR0cHM6Ly9saXN0cy5saW51eGZvdW5kYXRpb24ub3Jn
L21haWxtYW4vbGlzdGluZm8vdmlydHVhbGl6YXRpb24=
