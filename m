Return-Path: <SRS0=kU6l=GH=lists.linux-foundation.org=virtualization-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1DCAEC433DB
	for <virtualization@archiver.kernel.org>; Mon,  4 Jan 2021 03:28:28 +0000 (UTC)
Received: from fraxinus.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 753A720DD4
	for <virtualization@archiver.kernel.org>; Mon,  4 Jan 2021 03:28:27 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 753A720DD4
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=virtualization-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by fraxinus.osuosl.org (Postfix) with ESMTP id 21D068578B;
	Mon,  4 Jan 2021 03:28:27 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from fraxinus.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id 0tffk6apurhH; Mon,  4 Jan 2021 03:28:24 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by fraxinus.osuosl.org (Postfix) with ESMTP id 6F0F585773;
	Mon,  4 Jan 2021 03:28:24 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 5954CC0893;
	Mon,  4 Jan 2021 03:28:24 +0000 (UTC)
Received: from whitealder.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 014ECC013A
 for <virtualization@lists.linux-foundation.org>;
 Mon,  4 Jan 2021 03:28:22 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by whitealder.osuosl.org (Postfix) with ESMTP id DC20F8680C
 for <virtualization@lists.linux-foundation.org>;
 Mon,  4 Jan 2021 03:28:22 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from whitealder.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id iIGhlB7XG8Mn
 for <virtualization@lists.linux-foundation.org>;
 Mon,  4 Jan 2021 03:28:22 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [63.128.21.124])
 by whitealder.osuosl.org (Postfix) with ESMTPS id E690586803
 for <virtualization@lists.linux-foundation.org>;
 Mon,  4 Jan 2021 03:28:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1609730900;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=GJJfwwJvIQfLkVSCQiPAwQXYX1m/CER5+zYYRij6ymg=;
 b=hLh+cqyad8loNSR6nMgFQPaoXKXvxzud1jZt4v+AqGAGiTHhKIBsUBxMe9NKHEUUECCh7q
 6vdQEXVx5baa1XmuMpKfjeazICibwMNO3gO5jbBJp4DoTndQWBdcVKVWaUZyjv3MxA1r0I
 T/6VVjwAtovUanV/Y2L1F5644UQ9PFU=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-578-F31XkmCWPxag_wRJA-zYGg-1; Sun, 03 Jan 2021 22:28:19 -0500
X-MC-Unique: F31XkmCWPxag_wRJA-zYGg-1
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com
 [10.5.11.11])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 1D7D2107ACE3;
 Mon,  4 Jan 2021 03:28:18 +0000 (UTC)
Received: from [10.72.13.221] (ovpn-13-221.pek2.redhat.com [10.72.13.221])
 by smtp.corp.redhat.com (Postfix) with ESMTP id D24801346D;
 Mon,  4 Jan 2021 03:28:06 +0000 (UTC)
Subject: Re: [PATCH V2 19/19] vdpa: introduce virtio pci driver
To: Stefano Garzarella <sgarzare@redhat.com>
References: <20201204040353.21679-1-jasowang@redhat.com>
 <20201204040353.21679-20-jasowang@redhat.com>
 <20201204152043.ewqlwviaf33wwiyx@steredhat>
From: Jason Wang <jasowang@redhat.com>
Message-ID: <a17bd160-eda2-af4f-e465-23d29ca0580a@redhat.com>
Date: Mon, 4 Jan 2021 11:28:05 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <20201204152043.ewqlwviaf33wwiyx@steredhat>
Content-Language: en-US
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
Cc: shahafs@mellanox.com, virtualization@lists.linux-foundation.org,
 linux-kernel@vger.kernel.org, mst@redhat.com
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

Ck9uIDIwMjAvMTIvNCDkuIvljYgxMToyMCwgU3RlZmFubyBHYXJ6YXJlbGxhIHdyb3RlOgo+PiAr
I2RlZmluZSBWUF9WRFBBX1FVRVVFX01BWCAyNTYKPj4gKyNkZWZpbmUgVlBfVkRQQV9EUklWRVJf
TkFNRSAidnBfdmRwYSIKPj4gKwo+PiArc3RydWN0IHZwX3ZyaW5nIHsKPj4gK8KgwqDCoCB2b2lk
IF9faW9tZW0gKm5vdGlmeTsKPj4gK8KgwqDCoCBjaGFyIG1zaXhfbmFtZVsyNTZdOwo+Cj4gQ2Fu
IHdlIHVzZSBhIG1hY3JvIGZvciB0aGUgbXNpeF9uYW1lIHNpemUsIHNpbmNlIHdlIHVzZSAyNTYg
aW4gCj4gbXVsdGlwbGUgcGxhY2VzPwoKClllcywgd2lsbCBzd2l0Y2ggdG8gdXNlIGEgbWFjcm8u
CgoKPgo+PiArwqDCoMKgIHN0cnVjdCB2ZHBhX2NhbGxiYWNrIGNiOwo+PiArwqDCoMKgIGludCBp
cnE7Cj4+ICt9Owo+PiArCj4+ICtzdHJ1Y3QgdnBfdmRwYSB7Cj4+ICvCoMKgwqAgc3RydWN0IHZk
cGFfZGV2aWNlIHZkcGE7Cj4+ICvCoMKgwqAgc3RydWN0IHZpcnRpb19wY2lfbW9kZXJuX2Rldmlj
ZSBtZGV2Owo+PiArwqDCoMKgIHN0cnVjdCB2cF92cmluZyAqdnJpbmc7Cj4+ICvCoMKgwqAgc3Ry
dWN0IHZkcGFfY2FsbGJhY2sgY2I7Cj4gwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDC
oMKgwqDCoMKgwqDCoMKgwqDCoMKgwqAgXgo+IEl0IGlzIG5vdCByZWxldmFudCwgYnV0ICdjb25m
aWdfY2InIGlzIG1heWJlIGNsZWFyZXIgdG8gcmVhZC4KPgoKV2lsbCBjaGFuZ2UgdG8gY29uZmln
X2NiLgoKCj4gVGhlIHJlc3QgbG9va3MgZ29vZC4KCgpUaGFua3MKCgo+Cj4gVGhhbmtzLAo+IFN0
ZWZhbm8gCgpfX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fXwpW
aXJ0dWFsaXphdGlvbiBtYWlsaW5nIGxpc3QKVmlydHVhbGl6YXRpb25AbGlzdHMubGludXgtZm91
bmRhdGlvbi5vcmcKaHR0cHM6Ly9saXN0cy5saW51eGZvdW5kYXRpb24ub3JnL21haWxtYW4vbGlz
dGluZm8vdmlydHVhbGl6YXRpb24=
