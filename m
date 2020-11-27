Return-Path: <SRS0=QmqV=FB=lists.linux-foundation.org=virtualization-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.0 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 918A1C63697
	for <virtualization@archiver.kernel.org>; Fri, 27 Nov 2020 02:51:09 +0000 (UTC)
Received: from silver.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id EE2022222A
	for <virtualization@archiver.kernel.org>; Fri, 27 Nov 2020 02:51:08 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Pnc6PvsC"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org EE2022222A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=virtualization-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by silver.osuosl.org (Postfix) with ESMTP id 798F120365;
	Fri, 27 Nov 2020 02:51:08 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from silver.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id DVTR8ea6UYLq; Fri, 27 Nov 2020 02:51:07 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by silver.osuosl.org (Postfix) with ESMTP id CEB132036B;
	Fri, 27 Nov 2020 02:51:07 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id B5686C163C;
	Fri, 27 Nov 2020 02:51:07 +0000 (UTC)
Received: from whitealder.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 164E9C0052
 for <virtualization@lists.linux-foundation.org>;
 Fri, 27 Nov 2020 02:51:07 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by whitealder.osuosl.org (Postfix) with ESMTP id F147087B12
 for <virtualization@lists.linux-foundation.org>;
 Fri, 27 Nov 2020 02:51:06 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from whitealder.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id oTEZq0n189xR
 for <virtualization@lists.linux-foundation.org>;
 Fri, 27 Nov 2020 02:51:04 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [216.205.24.124])
 by whitealder.osuosl.org (Postfix) with ESMTPS id 15D7487B07
 for <virtualization@lists.linux-foundation.org>;
 Fri, 27 Nov 2020 02:51:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1606445462;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=sDQkslNn1bs9ms9Q14yiNJoO0vMzZ4WNFafjj5jooJ8=;
 b=Pnc6PvsCCZfc810/HH2VL5TdgNgP9umRBHPuztM9Np9LhiKqRThaNgSubVJ0PPUNKBRobv
 SIFDSdz+vvoT7texCjGw065HdKmd5GocunJH8ztzmXa18vlPACqvvWopXSVIAh8oUdGpbl
 HD1zEXK+LC+mFT4zplMkYvfNb2E9OOs=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-371-VWLlNBS1NBSuh4z9sZYDlA-1; Thu, 26 Nov 2020 21:51:00 -0500
X-MC-Unique: VWLlNBS1NBSuh4z9sZYDlA-1
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com
 [10.5.11.16])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id B30209CDAF;
 Fri, 27 Nov 2020 02:50:59 +0000 (UTC)
Received: from [10.72.13.168] (ovpn-13-168.pek2.redhat.com [10.72.13.168])
 by smtp.corp.redhat.com (Postfix) with ESMTP id CD9775C1C2;
 Fri, 27 Nov 2020 02:50:54 +0000 (UTC)
Subject: Re: [PATCH V2 01/14] virtio-pci: do not access iomem via
 virtio_pci_device directly
To: "Michael S. Tsirkin" <mst@redhat.com>
References: <20201126092604.208033-1-jasowang@redhat.com>
 <20201126092604.208033-2-jasowang@redhat.com>
 <20201126084436-mutt-send-email-mst@kernel.org>
From: Jason Wang <jasowang@redhat.com>
Message-ID: <3b65ce4f-9b1d-1542-ffbb-836269e9e80e@redhat.com>
Date: Fri, 27 Nov 2020 10:50:53 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <20201126084436-mutt-send-email-mst@kernel.org>
Content-Language: en-US
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.16
Cc: shahafs@mellanox.com, linux-kernel@vger.kernel.org,
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

Ck9uIDIwMjAvMTEvMjYg5LiL5Y2IOTo0NiwgTWljaGFlbCBTLiBUc2lya2luIHdyb3RlOgo+IE9u
IFRodSwgTm92IDI2LCAyMDIwIGF0IDA1OjI1OjUxUE0gKzA4MDAsIEphc29uIFdhbmcgd3JvdGU6
Cj4+IEluc3RlYWQgb2YgYWNjZXNzaW5nIGlvbWVtIHZpYSB2aXJpdG9fcGNpX2RldmljZSBkaXJl
Y3RseS4gQWRkIGFuCj4+IGluZGlyZWN0IGxldmVsCj4gd2VsbCB0aGlzIHBhdGNoIGRvZXMgbm90
IGFkZCBhbnkgaW5kaXJlY3Rpb24gaXQncyBqdXN0IHJlZmFjdG9yaW5nLgo+IHdoaWNoIGlzIG9r
IG9mIGNvdXJzZSBsZXQncyBqdXN0IHNheSBpdCBhcyBpcy4KPgo+PiB0byBlYXNlIHRoZSBsaWZl
IG9mIHNwbGl0dGluZyBvdXQgbW9kZXJuIHZpcml0by1wY2kKPiB0eXBvCgoKV2lsbCBmaXguCgpU
aGFua3MKCgo+CgpfX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
XwpWaXJ0dWFsaXphdGlvbiBtYWlsaW5nIGxpc3QKVmlydHVhbGl6YXRpb25AbGlzdHMubGludXgt
Zm91bmRhdGlvbi5vcmcKaHR0cHM6Ly9saXN0cy5saW51eGZvdW5kYXRpb24ub3JnL21haWxtYW4v
bGlzdGluZm8vdmlydHVhbGl6YXRpb24=
