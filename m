Return-Path: <SRS0=k93m=FM=lists.linux-foundation.org=virtualization-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.0 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BF57DC433FE
	for <virtualization@archiver.kernel.org>; Tue,  8 Dec 2020 02:33:07 +0000 (UTC)
Received: from whitealder.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 5AC5A23998
	for <virtualization@archiver.kernel.org>; Tue,  8 Dec 2020 02:33:07 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5AC5A23998
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=virtualization-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by whitealder.osuosl.org (Postfix) with ESMTP id EBCF587F9E;
	Tue,  8 Dec 2020 02:33:06 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from whitealder.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id hbN47f3WVd-p; Tue,  8 Dec 2020 02:33:06 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by whitealder.osuosl.org (Postfix) with ESMTP id 6773C87F51;
	Tue,  8 Dec 2020 02:33:06 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 427E3C0FA7;
	Tue,  8 Dec 2020 02:33:06 +0000 (UTC)
Received: from fraxinus.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 765C3C013B
 for <virtualization@lists.linux-foundation.org>;
 Tue,  8 Dec 2020 02:33:05 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by fraxinus.osuosl.org (Postfix) with ESMTP id 5CBF987B1A
 for <virtualization@lists.linux-foundation.org>;
 Tue,  8 Dec 2020 02:33:05 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from fraxinus.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id UpJZzu50MlpQ
 for <virtualization@lists.linux-foundation.org>;
 Tue,  8 Dec 2020 02:33:04 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [216.205.24.124])
 by fraxinus.osuosl.org (Postfix) with ESMTPS id 954A287B19
 for <virtualization@lists.linux-foundation.org>;
 Tue,  8 Dec 2020 02:33:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1607394783;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=qNCslX/aJdULLs2YcRnurqpiDn+uw7yYttpMGsTr7kY=;
 b=ZdT2FTcjDyaVJnpk0RNPIkk2embOblSg/DEpwfGTBy2sF5ehsZYP9+MO3Ob9Gd1t75cSSg
 08r59HREt+joX57SVt1pQtak9a7tS8zwYVCB8SOy9kUOnY9Yi9d84NaeCH2tDbD//UMT43
 cPQEY3QBr7lHRsaoFWH+qix6Nay84Ts=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-75-yFZtmgQkOti-9eI7GR5opw-1; Mon, 07 Dec 2020 21:33:01 -0500
X-MC-Unique: yFZtmgQkOti-9eI7GR5opw-1
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com
 [10.5.11.16])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 19A22AFA80;
 Tue,  8 Dec 2020 02:33:00 +0000 (UTC)
Received: from [10.72.12.91] (ovpn-12-91.pek2.redhat.com [10.72.12.91])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 20E8B5C22A;
 Tue,  8 Dec 2020 02:32:52 +0000 (UTC)
Subject: Re: [PATCH net-next] tun: fix ubuf refcount incorrectly on error path
To: wangyunjian <wangyunjian@huawei.com>, "mst@redhat.com" <mst@redhat.com>
References: <1606982459-41752-1-git-send-email-wangyunjian@huawei.com>
 <094f1828-9a73-033e-b1ca-43b73588d22b@redhat.com>
 <34EFBCA9F01B0748BEB6B629CE643AE60DB4E07B@dggemm513-mbx.china.huawei.com>
 <e972e42b-4344-31dc-eb4c-d963adb08a5c@redhat.com>
 <34EFBCA9F01B0748BEB6B629CE643AE60DB5CD27@DGGEMM533-MBX.china.huawei.com>
From: Jason Wang <jasowang@redhat.com>
Message-ID: <b70d75f3-d717-4cd6-4966-299916a223c3@redhat.com>
Date: Tue, 8 Dec 2020 10:32:51 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <34EFBCA9F01B0748BEB6B629CE643AE60DB5CD27@DGGEMM533-MBX.china.huawei.com>
Content-Language: en-US
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.16
Cc: "netdev@vger.kernel.org" <netdev@vger.kernel.org>,
 "Lilijun \(Jerry\)" <jerry.lilijun@huawei.com>, xudingke <xudingke@huawei.com>,
 "virtualization@lists.linux-foundation.org"
 <virtualization@lists.linux-foundation.org>
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

Ck9uIDIwMjAvMTIvNyDkuIvljYg5OjM4LCB3YW5neXVuamlhbiB3cm90ZToKPiBJIHRoaW5rIHRo
ZSBuZXdseSBhZGRlZCBjb2RlIGlzIGVhc3kgdG8gbWlzcyB0aGlzIHByb2JsZW0sIHNvIEkgd2Fu
dCB0bwo+IGNvcHkgdWJ1Zl9pbmZvIHVudGlsIHdlJ3JlIHN1cmUgdGhlcmUncyBubyBlcnJvcnMu
Cj4KPiBUaGFua3MsCj4gWXVuamlhbgoKCkJ1dCBpc24ndCB0aGlzIGFjdHVhbGx5IGEgZGlzYWJs
aW5nIG9mIHplcm9jb3B5PwoKVGhhbmtzCgoKX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX18KVmlydHVhbGl6YXRpb24gbWFpbGluZyBsaXN0ClZpcnR1YWxpemF0
aW9uQGxpc3RzLmxpbnV4LWZvdW5kYXRpb24ub3JnCmh0dHBzOi8vbGlzdHMubGludXhmb3VuZGF0
aW9uLm9yZy9tYWlsbWFuL2xpc3RpbmZvL3ZpcnR1YWxpemF0aW9u
