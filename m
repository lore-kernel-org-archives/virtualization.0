Return-Path: <SRS0=4MNw=EI=lists.linux-foundation.org=virtualization-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.1 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5680DC388F9
	for <virtualization@archiver.kernel.org>; Mon,  2 Nov 2020 06:50:04 +0000 (UTC)
Received: from whitealder.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D8A1A223B0
	for <virtualization@archiver.kernel.org>; Mon,  2 Nov 2020 06:50:03 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="HOI99UmV"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D8A1A223B0
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=virtualization-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by whitealder.osuosl.org (Postfix) with ESMTP id 76CE786A81;
	Mon,  2 Nov 2020 06:50:03 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from whitealder.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id 2qA1JiiI6P5s; Mon,  2 Nov 2020 06:50:02 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by whitealder.osuosl.org (Postfix) with ESMTP id 1B77486A27;
	Mon,  2 Nov 2020 06:50:02 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id F2074C088B;
	Mon,  2 Nov 2020 06:50:01 +0000 (UTC)
Received: from whitealder.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id D0CD2C0051
 for <virtualization@lists.linux-foundation.org>;
 Mon,  2 Nov 2020 06:50:00 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by whitealder.osuosl.org (Postfix) with ESMTP id BF477869C7
 for <virtualization@lists.linux-foundation.org>;
 Mon,  2 Nov 2020 06:50:00 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from whitealder.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id z7nhVoX9tsrM
 for <virtualization@lists.linux-foundation.org>;
 Mon,  2 Nov 2020 06:49:58 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [216.205.24.124])
 by whitealder.osuosl.org (Postfix) with ESMTPS id 770CC8699B
 for <virtualization@lists.linux-foundation.org>;
 Mon,  2 Nov 2020 06:49:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1604299796;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=C7K4jgC+Vx55SiPAes+d1icJNBJZqTlzcr28+KO7H0E=;
 b=HOI99UmVGDJMA/n8e/OayKgPbTG3tsS0K4yPM5FHNMGdddkMGN0b8elGdPFZEH1/EweF8c
 ZtBNRUmbIwMpOPbiZAEwjQA0DHR3+aQRX2VxW93ehEst+wsnfAUCejK1wSa+3IJwpvQ2v5
 dlMIPjkRyuYhbhDm+g4p7FZUFdHy2rA=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-33-IFKll4nFNgq9855A5-ewGg-1; Mon, 02 Nov 2020 01:49:53 -0500
X-MC-Unique: IFKll4nFNgq9855A5-ewGg-1
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com
 [10.5.11.15])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 2B0D21006C88;
 Mon,  2 Nov 2020 06:49:52 +0000 (UTC)
Received: from [10.72.13.42] (ovpn-13-42.pek2.redhat.com [10.72.13.42])
 by smtp.corp.redhat.com (Postfix) with ESMTP id AF6A355761;
 Mon,  2 Nov 2020 06:49:43 +0000 (UTC)
Subject: Re: [PATCH 07/17] vhost scsi: support delayed IO vq creation
From: Jason Wang <jasowang@redhat.com>
To: "Michael S. Tsirkin" <mst@redhat.com>,
 Mike Christie <michael.christie@oracle.com>
References: <1603326903-27052-1-git-send-email-michael.christie@oracle.com>
 <1603326903-27052-8-git-send-email-michael.christie@oracle.com>
 <9e97ea2a-bc57-d4aa-4711-35dba20b3b9e@redhat.com>
 <49c2fc29-348c-06db-4823-392f7476d318@oracle.com>
 <20201030044402-mutt-send-email-mst@kernel.org>
 <688e46b6-77f1-1629-0c93-e3a27d582da5@redhat.com>
Message-ID: <cf74844c-bfa6-e66c-fc3a-07dfd7af3092@redhat.com>
Date: Mon, 2 Nov 2020 14:49:42 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <688e46b6-77f1-1629-0c93-e3a27d582da5@redhat.com>
Content-Language: en-US
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
Cc: martin.petersen@oracle.com, linux-scsi@vger.kernel.org,
 virtualization@lists.linux-foundation.org, target-devel@vger.kernel.org,
 stefanha@redhat.com, pbonzini@redhat.com
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

Ck9uIDIwMjAvMTEvMiDkuIvljYgyOjM2LCBKYXNvbiBXYW5nIHdyb3RlOgo+Pgo+PiBUaGUgbmVl
ZCB0byBzaGFyZSBldmVudC9jb250cm9sIHZxcyBiZXR3ZWVuIGRldmljZXMgaXMgYSBwcm9ibGVt
IHRob3VnaCwKPj4gYW5kIHNlbmRpbmcgbG90cyBvZiBpb2N0bHMgb24gdGhpbmdzIGxpa2UgcmVz
ZXQgaXMgYWxzbyBub3QgdGhhdCAKPj4gZWxlZ2FudC4KPj4gSmFzb24sIGRpZCB5b3UgaGF2ZSBh
IGdvb2Qgc29sdXRpb24gaW4gbWluZD8KPgo+Cj4gTm9wZSwgSSdtIG5vdCBmYW1pbGlhciB3aXRo
IFNDU0kgc28gSSBkb24ndCBldmVuIGtub3cgc2hhcmluZyBldnQvY3ZxIAo+IGlzIHBvc3NpYmxl
LiBDb25zaWRlciBWSE9TVF9TQ1NJX01BWF9WUSBpcyBhbHJlYWR5IDEyOCBwZXIgZGV2aWNlLiAK
PiBNaWtlJ3MgcHJvcG9zYWwgc2VlbXMgdG8gYmUgYmV0dGVyLgo+Cj4gVGhhbmtzIAoKCkJ0dywg
aXQgbG9va3MgdG8gbWUgdmhvc3Rfc2NzaV9kb19ldnRfd29yaygpIGhhcyB0aGUgYXNzdW1wdGlv
biBvZiBpb3ZlYyAKbGF5b3V0IHdoaWNoIG5lZWRzIHRvIGJlIGZpeGVkLgoKVGhhbmtzCgpfX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fXwpWaXJ0dWFsaXphdGlv
biBtYWlsaW5nIGxpc3QKVmlydHVhbGl6YXRpb25AbGlzdHMubGludXgtZm91bmRhdGlvbi5vcmcK
aHR0cHM6Ly9saXN0cy5saW51eGZvdW5kYXRpb24ub3JnL21haWxtYW4vbGlzdGluZm8vdmlydHVh
bGl6YXRpb24=
