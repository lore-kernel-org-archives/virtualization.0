Return-Path: <SRS0=2ixu=F5=lists.linux-foundation.org=virtualization-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7E1D4C433E0
	for <virtualization@archiver.kernel.org>; Fri, 25 Dec 2020 06:15:29 +0000 (UTC)
Received: from whitealder.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 05A1221D7A
	for <virtualization@archiver.kernel.org>; Fri, 25 Dec 2020 06:15:28 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 05A1221D7A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=virtualization-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by whitealder.osuosl.org (Postfix) with ESMTP id 92A2986AF8;
	Fri, 25 Dec 2020 06:15:28 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from whitealder.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id 4SGTVQZJlkUP; Fri, 25 Dec 2020 06:15:28 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by whitealder.osuosl.org (Postfix) with ESMTP id ECDDA869E4;
	Fri, 25 Dec 2020 06:15:27 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id B87ACC1825;
	Fri, 25 Dec 2020 06:15:27 +0000 (UTC)
Received: from whitealder.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id A9A32C0893
 for <virtualization@lists.linux-foundation.org>;
 Fri, 25 Dec 2020 06:15:26 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by whitealder.osuosl.org (Postfix) with ESMTP id 9D95D86ADA
 for <virtualization@lists.linux-foundation.org>;
 Fri, 25 Dec 2020 06:15:26 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from whitealder.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id fMksvRDQ2N-3
 for <virtualization@lists.linux-foundation.org>;
 Fri, 25 Dec 2020 06:15:25 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [63.128.21.124])
 by whitealder.osuosl.org (Postfix) with ESMTPS id A3CF6869E4
 for <virtualization@lists.linux-foundation.org>;
 Fri, 25 Dec 2020 06:15:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1608876924;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=w7tJ3BxFC3bqQCGNgX0REDThHWaozRXz9C3kfzP9GPY=;
 b=UdjbbPv3aSnuWvSxXvUEgBoIK0azMfoBnEyeEIWc5927SeRP8qQOfyJitceA9n9AwVJI+4
 MEhfSQrR+cP9ftXT57VqfZ9Msie8N4fPc4AI2wo67hPNvsyAPy6xZEM2eksVEb1k067sve
 GNnO06XUZZBqLsc9wBKlFZzV2jYSSNw=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-258-SkLE0mm2NW-nxfCujw0HdA-1; Fri, 25 Dec 2020 01:15:21 -0500
X-MC-Unique: SkLE0mm2NW-nxfCujw0HdA-1
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com
 [10.5.11.11])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 0CC4D10054FF;
 Fri, 25 Dec 2020 06:15:19 +0000 (UTC)
Received: from [10.72.12.166] (ovpn-12-166.pek2.redhat.com [10.72.12.166])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 3D4BA6F816;
 Fri, 25 Dec 2020 06:15:11 +0000 (UTC)
Subject: Re: [PATCH net v4 2/2] vhost_net: fix tx queue stuck when sendmsg
 fails
To: wangyunjian <wangyunjian@huawei.com>
References: <1608776746-4040-1-git-send-email-wangyunjian@huawei.com>
 <c854850b-43ab-c98d-a4d8-36ad7cd6364c@redhat.com>
 <34EFBCA9F01B0748BEB6B629CE643AE60DB8ED23@DGGEMM533-MBX.china.huawei.com>
 <823a1558-70fb-386d-fd28-d0c9bdbe9dac@redhat.com>
 <34EFBCA9F01B0748BEB6B629CE643AE60DB8EE1C@DGGEMM533-MBX.china.huawei.com>
From: Jason Wang <jasowang@redhat.com>
Message-ID: <c4587112-cd05-aeec-3307-8fd813060dd8@redhat.com>
Date: Fri, 25 Dec 2020 14:15:10 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <34EFBCA9F01B0748BEB6B629CE643AE60DB8EE1C@DGGEMM533-MBX.china.huawei.com>
Content-Language: en-US
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
Cc: "willemdebruijn.kernel@gmail.com" <willemdebruijn.kernel@gmail.com>,
 "mst@redhat.com" <mst@redhat.com>,
 "netdev@vger.kernel.org" <netdev@vger.kernel.org>,
 "Lilijun \(Jerry\)" <jerry.lilijun@huawei.com>,
 "virtualization@lists.linux-foundation.org"
 <virtualization@lists.linux-foundation.org>, xudingke <xudingke@huawei.com>,
 "huangbin \(J\)" <brian.huangbin@huawei.com>,
 chenchanghu <chenchanghu@huawei.com>
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

Ck9uIDIwMjAvMTIvMjQg5LiL5Y2INTowOSwgd2FuZ3l1bmppYW4gd3JvdGU6Cj4+IC1FQUdBSU4g
YW5kIC1FTk9CRlMgYXJlIGZpbmUuIEJ1dCBJIGRvbid0IHNlZSBob3cgLUVOT01FTSBjYW4gYmUg
cmV0dXJuZWQuCj4gVGhlIHR1bl9idWlsZF9za2IoKSBhbmQgdHVuX25hcGlfYWxsb2NfZnJhZ3Mo
KSByZXR1cm4gLUVOT01FTSB3aGVuIG1lbW9yeQo+IGFsbG9jYXRpb24gZmFpbHMuCj4KPiBUaGFu
a3MKPgoKWW91J3JlIHJpZ2h0LiBTbyBJIHRoaW5rIHdlIG5lZWQgY2hlY2sgdGhlbSBhbGwuCgpJ
biB0aGUgZnV0dXJlLCB3ZSBuZWVkIHRoaW5rIG9mIGEgYmV0dGVyIHdheS4gSSBmZWVsIHN1Y2gg
Y2hlY2sgaXMga2luZCAKb2YgZnJhZ2lsZSBzaW5jZSBwZW9wbGUgbWF5IG1vZGlmeSBjb3JlIHNv
Y2sgY29kZXMgd2l0aG91dCBoYXZpbmcgYSBsb29rIAphdCB3aGF0IHZob3N0IGRvZXMuCgpUaGFu
a3MKCl9fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fClZpcnR1
YWxpemF0aW9uIG1haWxpbmcgbGlzdApWaXJ0dWFsaXphdGlvbkBsaXN0cy5saW51eC1mb3VuZGF0
aW9uLm9yZwpodHRwczovL2xpc3RzLmxpbnV4Zm91bmRhdGlvbi5vcmcvbWFpbG1hbi9saXN0aW5m
by92aXJ0dWFsaXphdGlvbg==
