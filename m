Return-Path: <SRS0=RIAz=EB=lists.linux-foundation.org=virtualization-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.1 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AF154C388F9
	for <virtualization@archiver.kernel.org>; Mon, 26 Oct 2020 03:52:05 +0000 (UTC)
Received: from hemlock.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 18E9B20829
	for <virtualization@archiver.kernel.org>; Mon, 26 Oct 2020 03:52:04 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="fMVhCsJf"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 18E9B20829
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=virtualization-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by hemlock.osuosl.org (Postfix) with ESMTP id 8889A87153;
	Mon, 26 Oct 2020 03:52:04 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from hemlock.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id IRJD+TteKcdk; Mon, 26 Oct 2020 03:52:03 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by hemlock.osuosl.org (Postfix) with ESMTP id 419BF87131;
	Mon, 26 Oct 2020 03:52:03 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 27913C088B;
	Mon, 26 Oct 2020 03:52:03 +0000 (UTC)
Received: from silver.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 3406AC0051
 for <virtualization@lists.linux-foundation.org>;
 Mon, 26 Oct 2020 03:52:01 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by silver.osuosl.org (Postfix) with ESMTP id 1A1FF2A128
 for <virtualization@lists.linux-foundation.org>;
 Mon, 26 Oct 2020 03:52:01 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from silver.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id 4hN0Pdi9zCV3
 for <virtualization@lists.linux-foundation.org>;
 Mon, 26 Oct 2020 03:51:59 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [63.128.21.124])
 by silver.osuosl.org (Postfix) with ESMTPS id B37FE20363
 for <virtualization@lists.linux-foundation.org>;
 Mon, 26 Oct 2020 03:51:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1603684318;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=B96VQp5HaByKyaBby/4vR2lYXsuofffHkRFppaIEY0Y=;
 b=fMVhCsJf/sxaU5ZC+fdwsXxLF9K7o35Do1iGlm/IAeKmvZ3U6G2Gn6BR0LJIm1R1sMH0J/
 pBMEzR8UBVMXVQyxC50BVoL/leZj/c7xt58Sut6LFB9MmHCqA7L5ldYfWFDzWGjHCQU/tF
 W9aYqFvb2OTpWNHaf2DIW0KKnfG3dvY=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-526-3oe9CLd_Ni6fMvt4f2OxRw-1; Sun, 25 Oct 2020 23:51:54 -0400
X-MC-Unique: 3oe9CLd_Ni6fMvt4f2OxRw-1
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com
 [10.5.11.15])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 273658049CF;
 Mon, 26 Oct 2020 03:51:53 +0000 (UTC)
Received: from [10.72.13.201] (ovpn-13-201.pek2.redhat.com [10.72.13.201])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 1062D55781;
 Mon, 26 Oct 2020 03:51:38 +0000 (UTC)
Subject: Re: [PATCH 07/17] vhost scsi: support delayed IO vq creation
To: Mike Christie <michael.christie@oracle.com>, martin.petersen@oracle.com,
 linux-scsi@vger.kernel.org, target-devel@vger.kernel.org, mst@redhat.com,
 pbonzini@redhat.com, stefanha@redhat.com,
 virtualization@lists.linux-foundation.org
References: <1603326903-27052-1-git-send-email-michael.christie@oracle.com>
 <1603326903-27052-8-git-send-email-michael.christie@oracle.com>
From: Jason Wang <jasowang@redhat.com>
Message-ID: <9e97ea2a-bc57-d4aa-4711-35dba20b3b9e@redhat.com>
Date: Mon, 26 Oct 2020 11:51:26 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <1603326903-27052-8-git-send-email-michael.christie@oracle.com>
Content-Language: en-US
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
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

Ck9uIDIwMjAvMTAvMjIg5LiK5Y2IODozNCwgTWlrZSBDaHJpc3RpZSB3cm90ZToKPiBFYWNoIHZo
b3N0LXNjc2kgZGV2aWNlIHdpbGwgbmVlZCBhIGV2dCBhbmQgY3RsIHF1ZXVlLCBidXQgdGhlIG51
bWJlcgo+IG9mIElPIHF1ZXVlcyBkZXBlbmRzIG9uIHdoYXRldmVyIHRoZSB1c2VyIGhhcyBjb25m
aWd1cmVkIGluIHVzZXJzcGFjZS4KPiBUaGlzIHBhdGNoIGhhcyB2aG9zdC1zY3NpIGNyZWF0ZSB0
aGUgZXZ0LCBjdGwgYW5kIG9uZSBJTyB2cSBhdCBkZXZpY2UKPiBvcGVuIHRpbWUuIFdlIHRoZW4g
Y3JlYXRlIHRoZSBvdGhlciBJTyB2cXMgd2hlbiB1c2Vyc3BhY2Ugc3RhcnRzIHRvCj4gc2V0IHRo
ZW0gdXAuIFdlIHN0aWxsIHdhc3RlIHNvbWUgbWVtIG9uIHRoZSB2cSBhbmQgc2NzaSB2cSBzdHJ1
Y3RzLAo+IGJ1dCB3ZSBkb24ndCB3YXN0ZSBtZW0gb24gaW92ZWMgcmVsYXRlZCBhcnJheXMgYW5k
IGZvciBsYXRlciBwYXRjaGVzCj4gd2Uga25vdyB3aGljaCBxdWV1ZXMgYXJlIHVzZWQgYnkgdGhl
IGRldi0+bnZxcyB2YWx1ZS4KPgo+IFNpZ25lZC1vZmYtYnk6IE1pa2UgQ2hyaXN0aWUgPG1pY2hh
ZWwuY2hyaXN0aWVAb3JhY2xlLmNvbT4KPiAtLS0KPiAgIGRyaXZlcnMvdmhvc3Qvc2NzaS5jIHwg
MTkgKysrKysrKysrKysrKysrLS0tLQo+ICAgMSBmaWxlIGNoYW5nZWQsIDE1IGluc2VydGlvbnMo
KyksIDQgZGVsZXRpb25zKC0pCgoKTm90IGZhbWlsaWFyIHdpdGggU0NTSS4gQnV0IEkgd29uZGVy
IGlmIGl0IGNvdWxkIGJlaGF2ZSBsaWtlIHZob3N0LW5ldC4KCkUuZyB1c2Vyc3BhY2Ugc2hvdWxk
IGtub3duIHRoZSBudW1iZXIgb2YgdmlydHF1ZXVlcyBzbyBpdCBjYW4ganVzdCBvcGVuIAphbmQg
Y2xvc2UgbXVsdGlwbGUgdmhvc3Qtc2NzaSBmaWxlIGRlc2NyaXB0b3JzLgoKVGhhbmtzCgpfX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fXwpWaXJ0dWFsaXphdGlv
biBtYWlsaW5nIGxpc3QKVmlydHVhbGl6YXRpb25AbGlzdHMubGludXgtZm91bmRhdGlvbi5vcmcK
aHR0cHM6Ly9saXN0cy5saW51eGZvdW5kYXRpb24ub3JnL21haWxtYW4vbGlzdGluZm8vdmlydHVh
bGl6YXRpb24=
