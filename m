Return-Path: <SRS0=5J/L=HZ=lists.linux-foundation.org=virtualization-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.1 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 500E9C433E0
	for <virtualization@archiver.kernel.org>; Tue, 23 Feb 2021 04:43:11 +0000 (UTC)
Received: from hemlock.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A8C3C64DF5
	for <virtualization@archiver.kernel.org>; Tue, 23 Feb 2021 04:43:10 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A8C3C64DF5
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=virtualization-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by hemlock.osuosl.org (Postfix) with ESMTP id 4A12587098;
	Tue, 23 Feb 2021 04:43:10 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from hemlock.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id Q2r5ssVb6wlN; Tue, 23 Feb 2021 04:43:09 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by hemlock.osuosl.org (Postfix) with ESMTP id 75F9287013;
	Tue, 23 Feb 2021 04:43:09 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 54AB7C000B;
	Tue, 23 Feb 2021 04:43:09 +0000 (UTC)
Received: from fraxinus.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 7E4CBC0001
 for <virtualization@lists.linux-foundation.org>;
 Tue, 23 Feb 2021 04:43:07 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by fraxinus.osuosl.org (Postfix) with ESMTP id 64EB58592F
 for <virtualization@lists.linux-foundation.org>;
 Tue, 23 Feb 2021 04:43:07 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from fraxinus.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id TPFNVzzYqBDO
 for <virtualization@lists.linux-foundation.org>;
 Tue, 23 Feb 2021 04:43:06 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [216.205.24.124])
 by fraxinus.osuosl.org (Postfix) with ESMTPS id 9A0C2857CB
 for <virtualization@lists.linux-foundation.org>;
 Tue, 23 Feb 2021 04:43:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1614055385;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=e0J97bzVjIpsRLIgd/hFe3gZbEpCcSAfwCuxBPtQIBY=;
 b=OmntfOgoeG2VitRSO+jKADpd/UNdvwUOCWr7hujdmjf7X0Z0fo/YloRyT4FWtIiJAuLQaH
 TFCizFLE8a7nhEdIeAoRUWqiwjt1qpXfb6TBnDLljG0OvC3xFzkDrjYmQinqNzBKWufdaU
 63XPEuVDs6//1HMFcOfxjL+Q3DET43M=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-53-aY87UsH6P-OyCHS52naCTA-1; Mon, 22 Feb 2021 23:43:02 -0500
X-MC-Unique: aY87UsH6P-OyCHS52naCTA-1
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com
 [10.5.11.23])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 7007980196C;
 Tue, 23 Feb 2021 04:43:01 +0000 (UTC)
Received: from [10.72.13.6] (ovpn-13-6.pek2.redhat.com [10.72.13.6])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 7E09A19C78;
 Tue, 23 Feb 2021 04:42:56 +0000 (UTC)
Subject: Re: [PATCH] vhost vdpa: fix the irq check for invoking
 irq_bypass_unregister_producer
To: Gautam Dawar <gdawar.xilinx@gmail.com>, mst@redhat.com,
 gdawar@xilinx.com, hanand@xilinx.com, martinh@xilinx.com,
 virtualization@lists.linux-foundation.org
References: <CAJ-rMYrf8ZBAHaxd51q2c5GVLEfpwgE26RpmGrr=pg7syeSfNw@mail.gmail.com>
From: Jason Wang <jasowang@redhat.com>
Message-ID: <d1ee6ed2-ccc7-c4aa-02c9-ad1b28818ed2@redhat.com>
Date: Tue, 23 Feb 2021 12:42:55 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <CAJ-rMYrf8ZBAHaxd51q2c5GVLEfpwgE26RpmGrr=pg7syeSfNw@mail.gmail.com>
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=jasowang@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Language: en-US
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

Ck9uIDIwMjEvMi8yMiDkuIvljYg1OjEzLCBHYXV0YW0gRGF3YXIgd3JvdGU6Cj4gV2hlbiBxZW11
IHdpdGggdmhvc3QtdmRwYSBuZXRkZXZpY2UgaXMgcnVuIGZvciB0aGUgZmlyc3QgdGltZSwgaXQg
Cj4gd29ya3Mgd2VsbC4KPiBCdXQgYWZ0ZXIgdGhlIFZNIGlzIHBvd2VyZWQgb2ZmLCB0aGUgbmV4
dCBxZW11IHJ1biBjYXVzZXMga2VybmVsIHBhbmljIAo+IGR1ZSB0bwo+IGEgTlVMTCBwb2ludGVy
IGRlcmVmZXJlbmNlIGluIGlycV9ieXBhc3NfcmVnaXN0ZXJfcHJvZHVjZXIoKS4KPgo+IFdoZW4g
dGhlIFZNIGlzIHBvd2VyZWQgb2ZmLCB2aG9zdF92ZHBhX2NsZWFuX2lycSgpIG1pc3NlcyBvbiBj
YWxsaW5nCj4gaXJxX2J5cGFzc191bnJlZ2lzdGVyX3Byb2R1Y2VyKCkgZm9yIGlycSAwIGJlY2F1
c2Ugb2YgdGhlIGV4aXN0aW5nIGNoZWNrLgo+Cj4gVGhpcyBsZWF2ZXMgc3RhbGUgcHJvZHVjZXIg
bm9kZXMsIHdoaWNoIGFyZSByZXNldCBpbiAKPiB2aG9zdF92cmluZ19jYWxsX3Jlc2V0KCkKPiB3
aGVuIHZob3N0X2Rldl9pbml0KCkgaXMgaW52b2tlZCBkdXJpbmcgdGhlIHNlY29uZCBxZW11IHJ1
bi4KPgo+IEFzIHRoZSBub2RlIG1lbWJlciBvZiBzdHJ1Y3QgaXJxX2J5cGFzc19wcm9kdWNlciBp
cyBhbHNvIGluaXRpYWxpemVkCj4gdG8gemVybywgdHJhdmVyc2FsIG9uIHRoZSBwcm9kdWNlcnMg
bGlzdCBjYXVzZXMgY3Jhc2ggZHVlIHRvIE5VTEwgcG9pbnRlcgo+IGRlcmVmZXJlbmNlLgo+Cj4g
QnVnemlsbGE6IGh0dHBzOi8vYnVnemlsbGEua2VybmVsLm9yZy9zaG93X2J1Zy5jZ2k/aWQ9MjEx
NzExCj4gU2lnbmVkLW9mZi1ieTogR2F1dGFtIERhd2FyIDxnZGF3YXJAeGlsaW54LmNvbSA8bWFp
bHRvOmdkYXdhckB4aWxpbnguY29tPj4KPgo+Cj4gZGlmZiAtLWdpdCBhL2RyaXZlcnMvdmhvc3Qv
dmRwYS5jIGIvZHJpdmVycy92aG9zdC92ZHBhLmMKPiBpbmRleCA2MmE5YmIwZWZjNTUuLmQxYzNh
MzNjNjIzOSAxMDA2NDQKPiAtLS0gYS9kcml2ZXJzL3Zob3N0L3ZkcGEuYwo+ICsrKyBiL2RyaXZl
cnMvdmhvc3QvdmRwYS5jCj4gQEAgLTg0OSw3ICs4NDksNyBAQCBzdGF0aWMgdm9pZCB2aG9zdF92
ZHBhX2NsZWFuX2lycShzdHJ1Y3Qgdmhvc3RfdmRwYSAqdikKPgo+IMKgIMKgIMKgIMKgIGZvciAo
aSA9IDA7IGkgPCB2LT5udnFzOyBpKyspIHsKPiDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCB2cSA9
ICZ2LT52cXNbaV07Cj4gLSDCoCDCoCDCoCDCoCDCoCDCoCDCoCBpZiAodnEtPmNhbGxfY3R4LnBy
b2R1Y2VyLmlycSkKPiArIMKgIMKgIMKgIMKgIMKgIMKgIMKgIGlmICh2cS0+Y2FsbF9jdHgucHJv
ZHVjZXIuaXJxID49IDApCj4gaXJxX2J5cGFzc191bnJlZ2lzdGVyX3Byb2R1Y2VyKCZ2cS0+Y2Fs
bF9jdHgucHJvZHVjZXIpOwoKClNpbmNlIGl0J3MgaW1wb3NzaWJsZSB0byBoYXZlIGFuIGlycSA8
IDAgKCBzZWUgCnZob3N0X3ZkYXBfc2V0dXBfdnFfaXJxKCkpLCBJIHRoaW5rIHdlIGNhbiBzaW1w
bHkgcmVtb3ZlIHRoZSBjaGVjayBhYm92ZS4KClRoZW4gd2UgY2FuIGNhbGwgdmhvc3RfdmRwYV91
bnNldHVwX3ZxX2lycSgpIGhlcmUgdG8gYXZvaWQgdGVtcG9yYXJ5IAp2YXJpYWJsZSBsaWtlIHZx
LgoKVGhhbmtzCgoKPiDCoCDCoCDCoCDCoCB9Cj4gwqB9CgpfX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fXwpWaXJ0dWFsaXphdGlvbiBtYWlsaW5nIGxpc3QKVmly
dHVhbGl6YXRpb25AbGlzdHMubGludXgtZm91bmRhdGlvbi5vcmcKaHR0cHM6Ly9saXN0cy5saW51
eGZvdW5kYXRpb24ub3JnL21haWxtYW4vbGlzdGluZm8vdmlydHVhbGl6YXRpb24=
