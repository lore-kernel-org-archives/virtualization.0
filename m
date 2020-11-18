Return-Path: <SRS0=HWuT=EY=lists.linux-foundation.org=virtualization-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6ADF2C5519F
	for <virtualization@archiver.kernel.org>; Wed, 18 Nov 2020 06:08:36 +0000 (UTC)
Received: from whitealder.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C5AB82468F
	for <virtualization@archiver.kernel.org>; Wed, 18 Nov 2020 06:08:35 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="HjdidHs3"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C5AB82468F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=virtualization-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by whitealder.osuosl.org (Postfix) with ESMTP id 2425D867BB;
	Wed, 18 Nov 2020 06:08:35 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from whitealder.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id jvgcaCIdh4l9; Wed, 18 Nov 2020 06:08:34 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by whitealder.osuosl.org (Postfix) with ESMTP id 9FA8E867B5;
	Wed, 18 Nov 2020 06:08:34 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 7A35EC0891;
	Wed, 18 Nov 2020 06:08:34 +0000 (UTC)
Received: from whitealder.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id A3918C07FF
 for <virtualization@lists.linux-foundation.org>;
 Wed, 18 Nov 2020 06:08:33 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by whitealder.osuosl.org (Postfix) with ESMTP id 895C5867BB
 for <virtualization@lists.linux-foundation.org>;
 Wed, 18 Nov 2020 06:08:33 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from whitealder.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id DRNZMkjAHH8Z
 for <virtualization@lists.linux-foundation.org>;
 Wed, 18 Nov 2020 06:08:32 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [63.128.21.124])
 by whitealder.osuosl.org (Postfix) with ESMTPS id AC7F0867B5
 for <virtualization@lists.linux-foundation.org>;
 Wed, 18 Nov 2020 06:08:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1605679711;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=Sz/m+8Uq0tqcNbVPs1/yM0jQdLFpgRv+8LG/piLjalw=;
 b=HjdidHs3zgma6Y1nUQIfoSUYqwQLo8mUNQBL3NgoGvN5xdzbaGeYJMD5pEZsbC/vtsp9OU
 Zm8pjjQHCtxSNUyNEPvjKL3RES9GmxXNR1Bw9R/29hYFtlolWqAwSfTn3IJUJ3yZluaiJw
 DmynXdKO3DQ3to3wvY5eY5PsYAqwbfE=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-512-eUvEClr4PgO9a3DPlib2SQ-1; Wed, 18 Nov 2020 01:08:26 -0500
X-MC-Unique: eUvEClr4PgO9a3DPlib2SQ-1
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com
 [10.5.11.23])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id E287764082;
 Wed, 18 Nov 2020 06:08:24 +0000 (UTC)
Received: from [10.72.13.172] (ovpn-13-172.pek2.redhat.com [10.72.13.172])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 72A7D19C59;
 Wed, 18 Nov 2020 06:08:19 +0000 (UTC)
Subject: Re: [PATCH net] vhost_vdpa: Return -EFUALT if copy_from_user() fails
From: Jason Wang <jasowang@redhat.com>
To: "Michael S. Tsirkin" <mst@redhat.com>,
 Dan Carpenter <dan.carpenter@oracle.com>
References: <20201023120853.GI282278@mwanda>
 <20201023113326-mutt-send-email-mst@kernel.org>
 <4485cc8d-ac69-c725-8493-eda120e29c41@redhat.com>
Message-ID: <e7242333-b364-c2d8-53f5-1f688fc4d0b5@redhat.com>
Date: Wed, 18 Nov 2020 14:08:17 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <4485cc8d-ac69-c725-8493-eda120e29c41@redhat.com>
Content-Language: en-US
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
Cc: netdev@vger.kernel.org, kuba@kernel.org, kernel-janitors@vger.kernel.org,
 kvm@vger.kernel.org, virtualization@lists.linux-foundation.org
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

Ck9uIDIwMjAvMTAvMjYg5LiK5Y2IMTA6NTksIEphc29uIFdhbmcgd3JvdGU6Cj4KPiBPbiAyMDIw
LzEwLzIzIOS4i+WNiDExOjM0LCBNaWNoYWVsIFMuIFRzaXJraW4gd3JvdGU6Cj4+IE9uIEZyaSwg
T2N0IDIzLCAyMDIwIGF0IDAzOjA4OjUzUE0gKzAzMDAsIERhbiBDYXJwZW50ZXIgd3JvdGU6Cj4+
PiBUaGUgY29weV90by9mcm9tX3VzZXIoKSBmdW5jdGlvbnMgcmV0dXJuIHRoZSBudW1iZXIgb2Yg
Ynl0ZXMgd2hpY2ggd2UKPj4+IHdlcmVuJ3QgYWJsZSB0byBjb3B5IGJ1dCB0aGUgaW9jdGwgc2hv
dWxkIHJldHVybiAtRUZBVUxUIGlmIHRoZXkgZmFpbC4KPj4+Cj4+PiBGaXhlczogYTEyN2M1YmJi
NmE4ICgidmhvc3QtdmRwYTogZml4IGJhY2tlbmQgZmVhdHVyZSBpb2N0bHMiKQo+Pj4gU2lnbmVk
LW9mZi1ieTogRGFuIENhcnBlbnRlciA8ZGFuLmNhcnBlbnRlckBvcmFjbGUuY29tPgo+PiBBY2tl
ZC1ieTogTWljaGFlbCBTLiBUc2lya2luIDxtc3RAcmVkaGF0LmNvbT4KPj4gTmVlZGVkIGZvciBz
dGFibGUgSSBndWVzcy4KPgo+Cj4gQWdyZWUuCj4KPiBBY2tlZC1ieTogSmFzb24gV2FuZyA8amFz
b3dhbmdAcmVkaGF0LmNvbT4KCgpIaSBNaWNoYWVsLgoKSSBkb24ndCBzZWUgdGhpcyBpbiB5b3Vy
IHRyZWUsIHBsZWFzZSBjb25zaWRlciB0byBtZXJnZS4KClRoYW5rcwoKCgpfX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fXwpWaXJ0dWFsaXphdGlvbiBtYWlsaW5n
IGxpc3QKVmlydHVhbGl6YXRpb25AbGlzdHMubGludXgtZm91bmRhdGlvbi5vcmcKaHR0cHM6Ly9s
aXN0cy5saW51eGZvdW5kYXRpb24ub3JnL21haWxtYW4vbGlzdGluZm8vdmlydHVhbGl6YXRpb24=
