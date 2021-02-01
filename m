Return-Path: <SRS0=ow7J=HD=lists.linux-foundation.org=virtualization-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.1 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 021DBC433E0
	for <virtualization@archiver.kernel.org>; Mon,  1 Feb 2021 06:05:01 +0000 (UTC)
Received: from fraxinus.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 625BE64E06
	for <virtualization@archiver.kernel.org>; Mon,  1 Feb 2021 06:05:00 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 625BE64E06
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=virtualization-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by fraxinus.osuosl.org (Postfix) with ESMTP id 1AE0785B9A;
	Mon,  1 Feb 2021 06:05:00 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from fraxinus.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id lJMDhwgvlOIi; Mon,  1 Feb 2021 06:04:58 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by fraxinus.osuosl.org (Postfix) with ESMTP id C55C9849BE;
	Mon,  1 Feb 2021 06:04:58 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 988A0C0FA7;
	Mon,  1 Feb 2021 06:04:58 +0000 (UTC)
Received: from whitealder.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 57CF8C013A
 for <virtualization@lists.linux-foundation.org>;
 Mon,  1 Feb 2021 06:04:57 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by whitealder.osuosl.org (Postfix) with ESMTP id 53BD986C7C
 for <virtualization@lists.linux-foundation.org>;
 Mon,  1 Feb 2021 06:04:57 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from whitealder.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id io5tDRQkrFex
 for <virtualization@lists.linux-foundation.org>;
 Mon,  1 Feb 2021 06:04:55 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [63.128.21.124])
 by whitealder.osuosl.org (Postfix) with ESMTPS id 03B8E86C5F
 for <virtualization@lists.linux-foundation.org>;
 Mon,  1 Feb 2021 06:04:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1612159493;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=3DbrYa9lTM0WfBiv6DqSHzncCEvSptL8lHmERyjThJ8=;
 b=FkaFyU/5CAWRlaapkCXSivbBj1m2gh8LH7USYw037kKn84chleWZKRsvKqZwLBciukHGBU
 l0osiQyiNa4CDvC/6H588E3YbkEEF6N7sPfBLXvstvPQsF2FxEg4SRWJOmWRWODJrB8KEk
 rsXVkRI47DO7+AQklC9eXIJGgVzhSHc=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-366-ZEaupziEMA-dvif1_vOjXQ-1; Mon, 01 Feb 2021 01:04:49 -0500
X-MC-Unique: ZEaupziEMA-dvif1_vOjXQ-1
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com
 [10.5.11.12])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 59529107ACE3;
 Mon,  1 Feb 2021 06:04:48 +0000 (UTC)
Received: from [10.72.13.120] (ovpn-13-120.pek2.redhat.com [10.72.13.120])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 9C07660C5F;
 Mon,  1 Feb 2021 06:04:39 +0000 (UTC)
Subject: Re: [PATCH RFC v2 10/10] vdpa_sim_blk: handle VIRTIO_BLK_T_GET_ID
To: Stefano Garzarella <sgarzare@redhat.com>,
 virtualization@lists.linux-foundation.org
References: <20210128144127.113245-1-sgarzare@redhat.com>
 <20210128144127.113245-11-sgarzare@redhat.com>
From: Jason Wang <jasowang@redhat.com>
Message-ID: <bcdc7dd7-856e-8aae-0683-e811081a1521@redhat.com>
Date: Mon, 1 Feb 2021 14:04:38 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <20210128144127.113245-11-sgarzare@redhat.com>
Content-Language: en-US
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
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

Ck9uIDIwMjEvMS8yOCDkuIvljYgxMDo0MSwgU3RlZmFubyBHYXJ6YXJlbGxhIHdyb3RlOgo+IEhh
bmRsZSBWSVJUSU9fQkxLX1RfR0VUX0lEIHJlcXVlc3QsIGFsd2F5cyBhbnN3ZXJpbmcgdGhlCj4g
InZkcGFfYmxrX3NpbSIgc3RyaW5nLgo+Cj4gU2lnbmVkLW9mZi1ieTogU3RlZmFubyBHYXJ6YXJl
bGxhIDxzZ2FyemFyZUByZWRoYXQuY29tPgo+IC0tLQo+IHYyOgo+IC0gbWFkZSAndmRwYXNpbV9i
bGtfaWQnIHN0YXRpYyBbSmFzb25dCgoKQWNrZWQtYnk6IEphc29uIFdhbmcgPGphc293YW5nQHJl
ZGhhdC5jb20+CgoKPiAtLS0KPiAgIGRyaXZlcnMvdmRwYS92ZHBhX3NpbS92ZHBhX3NpbV9ibGsu
YyB8IDE1ICsrKysrKysrKysrKysrKwo+ICAgMSBmaWxlIGNoYW5nZWQsIDE1IGluc2VydGlvbnMo
KykKPgo+IGRpZmYgLS1naXQgYS9kcml2ZXJzL3ZkcGEvdmRwYV9zaW0vdmRwYV9zaW1fYmxrLmMg
Yi9kcml2ZXJzL3ZkcGEvdmRwYV9zaW0vdmRwYV9zaW1fYmxrLmMKPiBpbmRleCBmYzQ3ZTgzMjAz
NTguLmEzZjhhZmFkOGQxNCAxMDA2NDQKPiAtLS0gYS9kcml2ZXJzL3ZkcGEvdmRwYV9zaW0vdmRw
YV9zaW1fYmxrLmMKPiArKysgYi9kcml2ZXJzL3ZkcGEvdmRwYV9zaW0vdmRwYV9zaW1fYmxrLmMK
PiBAQCAtMzcsNiArMzcsNyBAQAo+ICAgI2RlZmluZSBWRFBBU0lNX0JMS19WUV9OVU0JMQo+ICAg
Cj4gICBzdGF0aWMgc3RydWN0IHZkcGFzaW0gKnZkcGFzaW1fYmxrX2RldjsKPiArc3RhdGljIGNo
YXIgdmRwYXNpbV9ibGtfaWRbVklSVElPX0JMS19JRF9CWVRFU10gPSAidmRwYV9ibGtfc2ltIjsK
PiAgIAo+ICAgc3RhdGljIGJvb2wgdmRwYXNpbV9ibGtfY2hlY2tfcmFuZ2UodTY0IHN0YXJ0X3Nl
Y3Rvciwgc2l6ZV90IHJhbmdlX3NpemUpCj4gICB7Cj4gQEAgLTE1Miw2ICsxNTMsMjAgQEAgc3Rh
dGljIGJvb2wgdmRwYXNpbV9ibGtfaGFuZGxlX3JlcShzdHJ1Y3QgdmRwYXNpbSAqdmRwYXNpbSwK
PiAgIAkJfQo+ICAgCQlicmVhazsKPiAgIAo+ICsJY2FzZSBWSVJUSU9fQkxLX1RfR0VUX0lEOgo+
ICsJCWJ5dGVzID0gdnJpbmdoX2lvdl9wdXNoX2lvdGxiKCZ2cS0+dnJpbmcsICZ2cS0+aW5faW92
LAo+ICsJCQkJCSAgICAgIHZkcGFzaW1fYmxrX2lkLAo+ICsJCQkJCSAgICAgIFZJUlRJT19CTEtf
SURfQllURVMpOwo+ICsJCWlmIChieXRlcyA8IDApIHsKPiArCQkJZGV2X2VycigmdmRwYXNpbS0+
dmRwYS5kZXYsCj4gKwkJCQkidnJpbmdoX2lvdl9wdXNoX2lvdGxiKCkgZXJyb3I6ICV6ZFxuIiwg
Ynl0ZXMpOwo+ICsJCQlzdGF0dXMgPSBWSVJUSU9fQkxLX1NfSU9FUlI7Cj4gKwkJCWJyZWFrOwo+
ICsJCX0KPiArCj4gKwkJcHVzaGVkICs9IGJ5dGVzOwo+ICsJCWJyZWFrOwo+ICsKPiAgIAlkZWZh
dWx0Ogo+ICAgCQlkZXZfd2FybigmdmRwYXNpbS0+dmRwYS5kZXYsCj4gICAJCQkgIlVuc3VwcG9y
dGVkIHJlcXVlc3QgdHlwZSAlZFxuIiwgdHlwZSk7CgpfX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fXwpWaXJ0dWFsaXphdGlvbiBtYWlsaW5nIGxpc3QKVmlydHVh
bGl6YXRpb25AbGlzdHMubGludXgtZm91bmRhdGlvbi5vcmcKaHR0cHM6Ly9saXN0cy5saW51eGZv
dW5kYXRpb24ub3JnL21haWxtYW4vbGlzdGluZm8vdmlydHVhbGl6YXRpb24=
