Return-Path: <SRS0=Keeg=BP=lists.linux-foundation.org=virtualization-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2C94AC433E1
	for <virtualization@archiver.kernel.org>; Wed,  5 Aug 2020 02:16:39 +0000 (UTC)
Received: from whitealder.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id EDE8D206A2
	for <virtualization@archiver.kernel.org>; Wed,  5 Aug 2020 02:16:38 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="I3cB4OgR"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org EDE8D206A2
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=virtualization-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by whitealder.osuosl.org (Postfix) with ESMTP id AD12B85040;
	Wed,  5 Aug 2020 02:16:38 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from whitealder.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id E+JQhZMlpLPN; Wed,  5 Aug 2020 02:16:37 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by whitealder.osuosl.org (Postfix) with ESMTP id 88F3284F5C;
	Wed,  5 Aug 2020 02:16:37 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 6952FC0051;
	Wed,  5 Aug 2020 02:16:37 +0000 (UTC)
Received: from hemlock.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by lists.linuxfoundation.org (Postfix) with ESMTP id A9140C004C
 for <virtualization@lists.linux-foundation.org>;
 Wed,  5 Aug 2020 02:16:35 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by hemlock.osuosl.org (Postfix) with ESMTP id 92E2B86D7A
 for <virtualization@lists.linux-foundation.org>;
 Wed,  5 Aug 2020 02:16:35 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from hemlock.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id yblCLjFZxxnU
 for <virtualization@lists.linux-foundation.org>;
 Wed,  5 Aug 2020 02:16:35 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [63.128.21.124])
 by hemlock.osuosl.org (Postfix) with ESMTPS id CD7B686C7A
 for <virtualization@lists.linux-foundation.org>;
 Wed,  5 Aug 2020 02:16:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1596593793;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=HIaIax/zR4vv8fiWp11anUcThIo6Y4H4WRFdeKCBt5s=;
 b=I3cB4OgR0uiS7nNFOdBEW0cE/tYcnGyPOaRsLKnJ9hndFUjZfPVaRC1AHKmqAZ2ItdoVLq
 stGKp0iUzmNf9iP78zpXZSGGKC/mShH6QvEarsryGI9gOSv6pQud0KOzLU9OYuYpYSYELl
 r59PRRlSzMTXAj0qZsAJn4wjVa6YE0I=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-66-AV2FqgRGPRKYsArtpv6xzg-1; Tue, 04 Aug 2020 22:16:29 -0400
X-MC-Unique: AV2FqgRGPRKYsArtpv6xzg-1
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com
 [10.5.11.16])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 275A110059A2;
 Wed,  5 Aug 2020 02:16:28 +0000 (UTC)
Received: from [10.72.13.71] (ovpn-13-71.pek2.redhat.com [10.72.13.71])
 by smtp.corp.redhat.com (Postfix) with ESMTP id B0C3069318;
 Wed,  5 Aug 2020 02:16:18 +0000 (UTC)
Subject: Re: [PATCH V5 1/6] vhost: introduce vhost_vring_call
To: "Michael S. Tsirkin" <mst@redhat.com>
References: <20200731065533.4144-1-lingshan.zhu@intel.com>
 <20200731065533.4144-2-lingshan.zhu@intel.com>
 <5e646141-ca8d-77a5-6f41-d30710d91e6d@redhat.com>
 <d51dd4e3-7513-c771-104c-b61f9ee70f30@intel.com>
 <156b8d71-6870-c163-fdfa-35bf4701987d@redhat.com>
 <20200804052050-mutt-send-email-mst@kernel.org>
From: Jason Wang <jasowang@redhat.com>
Message-ID: <14fd2bf1-e9c1-a192-bd6c-f1ee5fd227f6@redhat.com>
Date: Wed, 5 Aug 2020 10:16:16 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <20200804052050-mutt-send-email-mst@kernel.org>
Content-Language: en-US
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.16
Cc: shahafs@mellanox.com, wanpengli@tencent.com, parav@mellanox.com,
 kvm@vger.kernel.org, netdev@vger.kernel.org, sean.j.christopherson@intel.com,
 virtualization@lists.linux-foundation.org, eli@mellanox.com,
 pbonzini@redhat.com, "Zhu, Lingshan" <lingshan.zhu@intel.com>
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

Ck9uIDIwMjAvOC80IOS4i+WNiDU6MjEsIE1pY2hhZWwgUy4gVHNpcmtpbiB3cm90ZToKPj4+Pj4g
IMKgICtzdHJ1Y3Qgdmhvc3RfdnJpbmdfY2FsbCB7Cj4+Pj4+ICvCoMKgwqAgc3RydWN0IGV2ZW50
ZmRfY3R4ICpjdHg7Cj4+Pj4+ICvCoMKgwqAgc3RydWN0IGlycV9ieXBhc3NfcHJvZHVjZXIgcHJv
ZHVjZXI7Cj4+Pj4+ICvCoMKgwqAgc3BpbmxvY2tfdCBjdHhfbG9jazsKPj4+PiBJdCdzIG5vdCBj
bGVhciB0byBtZSB3aHkgd2UgbmVlZCBjdHhfbG9jayBoZXJlLgo+Pj4+Cj4+Pj4gVGhhbmtzCj4+
PiBIaSBKYXNvbiwKPj4+Cj4+PiB3ZSB1c2UgdGhpcyBsb2NrIHRvIHByb3RlY3QgdGhlIGV2ZW50
ZmRfY3R4IGFuZCBpcnEgZnJvbSByYWNlIGNvbmRpdGlvbnMsCj4+IFdlIGRvbid0IHN1cHBvcnQg
aXJxIG5vdGlmaWNhdGlvbiBmcm9tIHZEUEEgZGV2aWNlIGRyaXZlciBpbiB0aGlzIHZlcnNpb24s
Cj4+IGRvIHdlIHN0aWxsIGhhdmUgcmFjZSBjb25kaXRpb24/Cj4+Cj4+IFRoYW5rcwo+IEphc29u
IEknbSBub3Qgc3VyZSB3aGF0IHlvdSBhcmUgdHJ5aW5nIHRvIHNheSBoZXJlLgoKCkkgbWVhbnQg
d2UgY2hhbmdlIHRoZSBBUEkgZnJvbSBWNCBzbyBkcml2ZXIgd29uJ3Qgbm90aWZ5IHVzIGlmIGly
cSBpcyAKY2hhbmdlZC4KClRoZW4gaXQgbG9va3MgdG8gbWUgdGhlcmUncyBubyBuZWVkIGZvciB0
aGUgY3R4X2xvY2ssIGV2ZXJ5aGluZyBjb3VsZCBiZSAKc3luY2hyb25pemVkIHdpdGggdnEgbXV0
ZXguCgpUaGFua3MKCj4KPgoKX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX18KVmlydHVhbGl6YXRpb24gbWFpbGluZyBsaXN0ClZpcnR1YWxpemF0aW9uQGxpc3Rz
LmxpbnV4LWZvdW5kYXRpb24ub3JnCmh0dHBzOi8vbGlzdHMubGludXhmb3VuZGF0aW9uLm9yZy9t
YWlsbWFuL2xpc3RpbmZvL3ZpcnR1YWxpemF0aW9u
