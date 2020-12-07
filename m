Return-Path: <SRS0=JO0H=FL=lists.linux-foundation.org=virtualization-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.1 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 62BA0C433FE
	for <virtualization@archiver.kernel.org>; Mon,  7 Dec 2020 05:30:26 +0000 (UTC)
Received: from silver.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D24A2227C3
	for <virtualization@archiver.kernel.org>; Mon,  7 Dec 2020 05:30:25 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D24A2227C3
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=virtualization-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by silver.osuosl.org (Postfix) with ESMTP id 40BE52BC43;
	Mon,  7 Dec 2020 05:30:25 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from silver.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id 3OyPMMHyPPwd; Mon,  7 Dec 2020 05:30:24 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by silver.osuosl.org (Postfix) with ESMTP id 9E0E52E1A6;
	Mon,  7 Dec 2020 05:30:24 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 7CB33C0FA7;
	Mon,  7 Dec 2020 05:30:24 +0000 (UTC)
Received: from silver.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by lists.linuxfoundation.org (Postfix) with ESMTP id B0CC4C013B
 for <virtualization@lists.linux-foundation.org>;
 Mon,  7 Dec 2020 05:30:23 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by silver.osuosl.org (Postfix) with ESMTP id 9CF692E1A6
 for <virtualization@lists.linux-foundation.org>;
 Mon,  7 Dec 2020 05:30:23 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from silver.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id OWOX63T3rkCP
 for <virtualization@lists.linux-foundation.org>;
 Mon,  7 Dec 2020 05:30:22 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [63.128.21.124])
 by silver.osuosl.org (Postfix) with ESMTPS id A2BA22BC43
 for <virtualization@lists.linux-foundation.org>;
 Mon,  7 Dec 2020 05:30:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1607319021;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=pLCSsW2WyIt+KlApOoAFf7MXLlpWsBt0oMrOXDYlAl8=;
 b=dv3adhlC/jzYPkDICH5TcP/ON4Z/rcBzS6QFTR/KdWUhoc3gXOv4iy2+R34fb5S8Ak+SrD
 Q6YFxBqs+/tRZA0pvBMUBAfk23IIMa3mLf7wbNnPgPLCG/WoS8ZtOi9UH1oL4BU+XtClIc
 3ITk3+gP4ZBABzOzDZzdJyshmqeTN80=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-580-ntKxMNUnNEeKEVNGn6I3XA-1; Mon, 07 Dec 2020 00:30:19 -0500
X-MC-Unique: ntKxMNUnNEeKEVNGn6I3XA-1
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com
 [10.5.11.12])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 18E73100C600;
 Mon,  7 Dec 2020 05:30:18 +0000 (UTC)
Received: from [10.72.13.171] (ovpn-13-171.pek2.redhat.com [10.72.13.171])
 by smtp.corp.redhat.com (Postfix) with ESMTP id C6E0C60BE2;
 Mon,  7 Dec 2020 05:30:06 +0000 (UTC)
Subject: Re: [PATCH v3 14/19] vdpa_sim: add set_config callback in
 vdpasim_dev_attr
To: Stefano Garzarella <sgarzare@redhat.com>,
 virtualization@lists.linux-foundation.org
References: <20201203170511.216407-1-sgarzare@redhat.com>
 <20201203170511.216407-15-sgarzare@redhat.com>
From: Jason Wang <jasowang@redhat.com>
Message-ID: <d3bc9f2f-52c2-b770-40ff-76a31209c967@redhat.com>
Date: Mon, 7 Dec 2020 13:30:05 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <20201203170511.216407-15-sgarzare@redhat.com>
Content-Language: en-US
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
Cc: Laurent Vivier <lvivier@redhat.com>, Max Gurtovoy <mgurtovoy@nvidia.com>,
 "Michael S. Tsirkin" <mst@redhat.com>, linux-kernel@vger.kernel.org,
 Shahaf Shuler <shahafs@nvidia.com>, Stefan Hajnoczi <stefanha@redhat.com>,
 Eli Cohen <elic@nvidia.com>, Oren Duer <oren@nvidia.com>
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

Ck9uIDIwMjAvMTIvNCDkuIrljYgxOjA1LCBTdGVmYW5vIEdhcnphcmVsbGEgd3JvdGU6Cj4gVGhl
IHNldF9jb25maWcgY2FsbGJhY2sgY2FuIGJlIHVzZWQgYnkgdGhlIGRldmljZSB0byBwYXJzZSB0
aGUKPiBjb25maWcgc3RydWN0dXJlIG1vZGlmaWVkIGJ5IHRoZSBkcml2ZXIuCj4KPiBUaGUgY2Fs
bGJhY2sgd2lsbCBiZSBpbnZva2VkLCBpZiBzZXQsIGluIHZkcGFzaW1fc2V0X2NvbmZpZygpIGFm
dGVyCj4gY29weWluZyBieXRlcyBmcm9tIGNhbGxlciBidWZmZXIgaW50byB2ZHBhc2ltLT5jb25m
aWcgYnVmZmVyLgo+Cj4gU2lnbmVkLW9mZi1ieTogU3RlZmFubyBHYXJ6YXJlbGxhIDxzZ2FyemFy
ZUByZWRoYXQuY29tPgoKCkFja2VkLWJ5OiBKYXNvbiBXYW5nIDxqYXNvd2FuZ0ByZWRoYXQuY29t
PgoKCj4gLS0tCj4gICBkcml2ZXJzL3ZkcGEvdmRwYV9zaW0vdmRwYV9zaW0uYyB8IDExICsrKysr
KysrKystCj4gICAxIGZpbGUgY2hhbmdlZCwgMTAgaW5zZXJ0aW9ucygrKSwgMSBkZWxldGlvbigt
KQo+Cj4gZGlmZiAtLWdpdCBhL2RyaXZlcnMvdmRwYS92ZHBhX3NpbS92ZHBhX3NpbS5jIGIvZHJp
dmVycy92ZHBhL3ZkcGFfc2ltL3ZkcGFfc2ltLmMKPiBpbmRleCBmOTM1YWRlMDgwNmIuLjAzYTg3
MTdmODBlYSAxMDA2NDQKPiAtLS0gYS9kcml2ZXJzL3ZkcGEvdmRwYV9zaW0vdmRwYV9zaW0uYwo+
ICsrKyBiL2RyaXZlcnMvdmRwYS92ZHBhX3NpbS92ZHBhX3NpbS5jCj4gQEAgLTcwLDYgKzcwLDcg
QEAgc3RydWN0IHZkcGFzaW1fZGV2X2F0dHIgewo+ICAgCj4gICAJd29ya19mdW5jX3Qgd29ya19m
bjsKPiAgIAl2b2lkICgqZ2V0X2NvbmZpZykoc3RydWN0IHZkcGFzaW0gKnZkcGFzaW0sIHZvaWQg
KmNvbmZpZyk7Cj4gKwl2b2lkICgqc2V0X2NvbmZpZykoc3RydWN0IHZkcGFzaW0gKnZkcGFzaW0s
IGNvbnN0IHZvaWQgKmNvbmZpZyk7Cj4gICB9Owo+ICAgCj4gICAvKiBTdGF0ZSBvZiBlYWNoIHZk
cGFzaW0gZGV2aWNlICovCj4gQEAgLTU5OCw3ICs1OTksMTUgQEAgc3RhdGljIHZvaWQgdmRwYXNp
bV9nZXRfY29uZmlnKHN0cnVjdCB2ZHBhX2RldmljZSAqdmRwYSwgdW5zaWduZWQgaW50IG9mZnNl
dCwKPiAgIHN0YXRpYyB2b2lkIHZkcGFzaW1fc2V0X2NvbmZpZyhzdHJ1Y3QgdmRwYV9kZXZpY2Ug
KnZkcGEsIHVuc2lnbmVkIGludCBvZmZzZXQsCj4gICAJCQkgICAgIGNvbnN0IHZvaWQgKmJ1Ziwg
dW5zaWduZWQgaW50IGxlbikKPiAgIHsKPiAtCS8qIE5vIHdyaXRhYmxlIGNvbmZpZyBzdXBwb3J0
dGVkIGJ5IHZkcGFzaW0gKi8KPiArCXN0cnVjdCB2ZHBhc2ltICp2ZHBhc2ltID0gdmRwYV90b19z
aW0odmRwYSk7Cj4gKwo+ICsJaWYgKG9mZnNldCArIGxlbiA+IHZkcGFzaW0tPmRldl9hdHRyLmNv
bmZpZ19zaXplKQo+ICsJCXJldHVybjsKPiArCj4gKwltZW1jcHkodmRwYXNpbS0+Y29uZmlnICsg
b2Zmc2V0LCBidWYsIGxlbik7Cj4gKwo+ICsJaWYgKHZkcGFzaW0tPmRldl9hdHRyLnNldF9jb25m
aWcpCj4gKwkJdmRwYXNpbS0+ZGV2X2F0dHIuc2V0X2NvbmZpZyh2ZHBhc2ltLCB2ZHBhc2ltLT5j
b25maWcpOwo+ICAgfQo+ICAgCj4gICBzdGF0aWMgdTMyIHZkcGFzaW1fZ2V0X2dlbmVyYXRpb24o
c3RydWN0IHZkcGFfZGV2aWNlICp2ZHBhKQoKX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX18KVmlydHVhbGl6YXRpb24gbWFpbGluZyBsaXN0ClZpcnR1YWxpemF0
aW9uQGxpc3RzLmxpbnV4LWZvdW5kYXRpb24ub3JnCmh0dHBzOi8vbGlzdHMubGludXhmb3VuZGF0
aW9uLm9yZy9tYWlsbWFuL2xpc3RpbmZvL3ZpcnR1YWxpemF0aW9u
