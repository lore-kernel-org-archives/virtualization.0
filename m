Return-Path: <SRS0=ow7J=HD=lists.linux-foundation.org=virtualization-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.1 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 49FA5C433E0
	for <virtualization@archiver.kernel.org>; Mon,  1 Feb 2021 05:46:53 +0000 (UTC)
Received: from silver.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id CBE0E64E15
	for <virtualization@archiver.kernel.org>; Mon,  1 Feb 2021 05:46:52 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CBE0E64E15
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=virtualization-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by silver.osuosl.org (Postfix) with ESMTP id 9D06020026;
	Mon,  1 Feb 2021 05:46:52 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from silver.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id vAzpAWFTYGQQ; Mon,  1 Feb 2021 05:46:49 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by silver.osuosl.org (Postfix) with ESMTP id 7954920022;
	Mon,  1 Feb 2021 05:46:48 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 57610C0FA7;
	Mon,  1 Feb 2021 05:46:48 +0000 (UTC)
Received: from whitealder.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id E747BC013A
 for <virtualization@lists.linux-foundation.org>;
 Mon,  1 Feb 2021 05:46:46 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by whitealder.osuosl.org (Postfix) with ESMTP id C7A7E869BF
 for <virtualization@lists.linux-foundation.org>;
 Mon,  1 Feb 2021 05:46:46 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from whitealder.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id aKPjrq3DLxmT
 for <virtualization@lists.linux-foundation.org>;
 Mon,  1 Feb 2021 05:46:46 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [216.205.24.124])
 by whitealder.osuosl.org (Postfix) with ESMTPS id C23AE869BB
 for <virtualization@lists.linux-foundation.org>;
 Mon,  1 Feb 2021 05:46:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1612158404;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=f2ImvkHtiWKuR6rS+/oQGBneQ9ERdYR3AODwgtXhy8s=;
 b=Nokv0k5IBHqJaRC9TfSRKTN5sukTrWu5bRxQNPD8yEHSpY1gp8mm6mINvN8mxxhJ21Q/sH
 rUsEQF98m01qimRlkxQhCx7XQc5s2JdTu6uaHf7QsxgRGqmJlb6xbs9B4gIYPnZuhkFO+n
 mIYSCn2OCeYizjncsM2aumQaVefwLQY=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-111-YD89M8YCMyS_gQszRSShvw-1; Mon, 01 Feb 2021 00:46:42 -0500
X-MC-Unique: YD89M8YCMyS_gQszRSShvw-1
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com
 [10.5.11.16])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 412171005504;
 Mon,  1 Feb 2021 05:46:41 +0000 (UTC)
Received: from [10.72.13.120] (ovpn-13-120.pek2.redhat.com [10.72.13.120])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 72FDA5E1A8;
 Mon,  1 Feb 2021 05:46:29 +0000 (UTC)
Subject: Re: [PATCH RFC v2 05/10] vringh: add vringh_kiov_length() helper
To: Stefano Garzarella <sgarzare@redhat.com>,
 virtualization@lists.linux-foundation.org
References: <20210128144127.113245-1-sgarzare@redhat.com>
 <20210128144127.113245-6-sgarzare@redhat.com>
From: Jason Wang <jasowang@redhat.com>
Message-ID: <c4db2e0c-995f-ee03-0dee-3af2bb6e20c9@redhat.com>
Date: Mon, 1 Feb 2021 13:46:27 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <20210128144127.113245-6-sgarzare@redhat.com>
Content-Language: en-US
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.16
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

Ck9uIDIwMjEvMS8yOCDkuIvljYgxMDo0MSwgU3RlZmFubyBHYXJ6YXJlbGxhIHdyb3RlOgo+IFRo
aXMgbmV3IGhlbHBlciByZXR1cm5zIHRoZSB0b3RhbCBudW1iZXIgb2YgYnl0ZXMgY292ZXJlZCBi
eQo+IGEgdnJpbmdoX2tpb3YuCj4KPiBTdWdnZXN0ZWQtYnk6IEphc29uIFdhbmcgPGphc293YW5n
QHJlZGhhdC5jb20+Cj4gU2lnbmVkLW9mZi1ieTogU3RlZmFubyBHYXJ6YXJlbGxhIDxzZ2FyemFy
ZUByZWRoYXQuY29tPgoKCkFja2VkLWJ5OiBKYXNvbiBXYW5nIDxqYXNvd2FuZ0ByZWRoYXQuY29t
PgoKCj4gLS0tCj4gICBpbmNsdWRlL2xpbnV4L3ZyaW5naC5oIHwgMTEgKysrKysrKysrKysKPiAg
IDEgZmlsZSBjaGFuZ2VkLCAxMSBpbnNlcnRpb25zKCspCj4KPiBkaWZmIC0tZ2l0IGEvaW5jbHVk
ZS9saW51eC92cmluZ2guaCBiL2luY2x1ZGUvbGludXgvdnJpbmdoLmgKPiBpbmRleCA3NTUyMTFl
YmQxOTUuLjg0ZGI3YjhmOTEyZiAxMDA2NDQKPiAtLS0gYS9pbmNsdWRlL2xpbnV4L3ZyaW5naC5o
Cj4gKysrIGIvaW5jbHVkZS9saW51eC92cmluZ2guaAo+IEBAIC0xOTksNiArMTk5LDE3IEBAIHN0
YXRpYyBpbmxpbmUgdm9pZCB2cmluZ2hfa2lvdl9jbGVhbnVwKHN0cnVjdCB2cmluZ2hfa2lvdiAq
a2lvdikKPiAgIAlraW92LT5pb3YgPSBOVUxMOwo+ICAgfQo+ICAgCj4gK3N0YXRpYyBpbmxpbmUg
c2l6ZV90IHZyaW5naF9raW92X2xlbmd0aChzdHJ1Y3QgdnJpbmdoX2tpb3YgKmtpb3YpCj4gK3sK
PiArCXNpemVfdCBsZW4gPSAwOwo+ICsJaW50IGk7Cj4gKwo+ICsJZm9yIChpID0ga2lvdi0+aTsg
aSA8IGtpb3YtPnVzZWQ7IGkrKykKPiArCQlsZW4gKz0ga2lvdi0+aW92W2ldLmlvdl9sZW47Cj4g
Kwo+ICsJcmV0dXJuIGxlbjsKPiArfQo+ICsKPiAgIHZvaWQgdnJpbmdoX2tpb3ZfYWR2YW5jZShz
dHJ1Y3QgdnJpbmdoX2tpb3YgKmtpb3YsIHNpemVfdCBsZW4pOwo+ICAgCj4gICBpbnQgdnJpbmdo
X2dldGRlc2Nfa2VybihzdHJ1Y3QgdnJpbmdoICp2cmgsCgpfX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fXwpWaXJ0dWFsaXphdGlvbiBtYWlsaW5nIGxpc3QKVmly
dHVhbGl6YXRpb25AbGlzdHMubGludXgtZm91bmRhdGlvbi5vcmcKaHR0cHM6Ly9saXN0cy5saW51
eGZvdW5kYXRpb24ub3JnL21haWxtYW4vbGlzdGluZm8vdmlydHVhbGl6YXRpb24=
