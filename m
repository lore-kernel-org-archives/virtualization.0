Return-Path: <SRS0=LnXi=IA=lists.linux-foundation.org=virtualization-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.1 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D5FDCC433DB
	for <virtualization@archiver.kernel.org>; Tue,  2 Mar 2021 06:44:29 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 5926861601
	for <virtualization@archiver.kernel.org>; Tue,  2 Mar 2021 06:44:29 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5926861601
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=virtualization-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id EAB3B83D91;
	Tue,  2 Mar 2021 06:44:28 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
	by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id 0kitPgxAaLAN; Tue,  2 Mar 2021 06:44:28 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp1.osuosl.org (Postfix) with ESMTP id 80DC983C76;
	Tue,  2 Mar 2021 06:44:27 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 56A88C000B;
	Tue,  2 Mar 2021 06:44:27 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by lists.linuxfoundation.org (Postfix) with ESMTP id CFD60C0001
 for <virtualization@lists.linux-foundation.org>;
 Tue,  2 Mar 2021 06:44:25 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id B5D5343015
 for <virtualization@lists.linux-foundation.org>;
 Tue,  2 Mar 2021 06:44:25 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp2.osuosl.org (amavisd-new);
 dkim=pass (1024-bit key) header.d=redhat.com
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id C0lMY3fSLsyC
 for <virtualization@lists.linux-foundation.org>;
 Tue,  2 Mar 2021 06:44:24 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [63.128.21.124])
 by smtp2.osuosl.org (Postfix) with ESMTPS id CA5B242FDF
 for <virtualization@lists.linux-foundation.org>;
 Tue,  2 Mar 2021 06:44:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1614667463;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=qGyarxAsRNm8uMESl4edL1CyhRJbWc98p5w3NIlaIWI=;
 b=bXfyjLJvFWWFh0rGjJIfwifGUohULnoWJoo/IwecEC0S++DvFig14TZWsTceCc8QqcLGdV
 sMTK3P2EOLGz/6bTLIMyWWaTH73vb60atQqOpdC2VFgYK1NzahF+rbbYPIFz7mja8ua7mi
 H5TyG1+L1C9Ed+fiBzfJqmZPHDza8z0=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-186-iq46B30zMAK1-c24fAjiyQ-1; Tue, 02 Mar 2021 01:44:19 -0500
X-MC-Unique: iq46B30zMAK1-c24fAjiyQ-1
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com
 [10.5.11.15])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id DC05018B6141;
 Tue,  2 Mar 2021 06:44:16 +0000 (UTC)
Received: from wangxiaodeMacBook-Air.local (ovpn-12-133.pek2.redhat.com
 [10.72.12.133])
 by smtp.corp.redhat.com (Postfix) with ESMTP id BD9AE5D766;
 Tue,  2 Mar 2021 06:44:03 +0000 (UTC)
Subject: Re: [RFC v4 01/11] eventfd: Increase the recursion depth of
 eventfd_signal()
To: Xie Yongji <xieyongji@bytedance.com>, mst@redhat.com,
 stefanha@redhat.com, sgarzare@redhat.com, parav@nvidia.com,
 bob.liu@oracle.com, hch@infradead.org, rdunlap@infradead.org,
 willy@infradead.org, viro@zeniv.linux.org.uk, axboe@kernel.dk,
 bcrl@kvack.org, corbet@lwn.net
References: <20210223115048.435-1-xieyongji@bytedance.com>
 <20210223115048.435-2-xieyongji@bytedance.com>
From: Jason Wang <jasowang@redhat.com>
Message-ID: <22e96bd6-0113-ef01-376e-0776d7bdbcd8@redhat.com>
Date: Tue, 2 Mar 2021 14:44:02 +0800
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.16; rv:78.0)
 Gecko/20100101 Thunderbird/78.8.0
MIME-Version: 1.0
In-Reply-To: <20210223115048.435-2-xieyongji@bytedance.com>
Content-Language: en-GB
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
Cc: linux-aio@kvack.org, netdev@vger.kernel.org, linux-fsdevel@vger.kernel.org,
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

Ck9uIDIwMjEvMi8yMyA3OjUwIOS4i+WNiCwgWGllIFlvbmdqaSB3cm90ZToKPiBJbmNyZWFzZSB0
aGUgcmVjdXJzaW9uIGRlcHRoIG9mIGV2ZW50ZmRfc2lnbmFsKCkgdG8gMS4gVGhpcwo+IGlzIHRo
ZSBtYXhpbXVtIHJlY3Vyc2lvbiBkZXB0aCB3ZSBoYXZlIGZvdW5kIHNvIGZhci4KPgo+IFNpZ25l
ZC1vZmYtYnk6IFhpZSBZb25namkgPHhpZXlvbmdqaUBieXRlZGFuY2UuY29tPgoKCkFja2VkLWJ5
OiBKYXNvbiBXYW5nIDxqYXNvd2FuZ0ByZWRoYXQuY29tPgoKSXQgbWlnaHQgYmUgdXNlZnVsIHRv
IGV4cGxhaW4gaG93L3doZW4gd2UgY2FuIHJlYWNoIGZvciB0aGlzIGNvbmRpdGlvbi4KClRoYW5r
cwoKCj4gLS0tCj4gICBmcy9ldmVudGZkLmMgICAgICAgICAgICB8IDIgKy0KPiAgIGluY2x1ZGUv
bGludXgvZXZlbnRmZC5oIHwgNSArKysrLQo+ICAgMiBmaWxlcyBjaGFuZ2VkLCA1IGluc2VydGlv
bnMoKyksIDIgZGVsZXRpb25zKC0pCj4KPiBkaWZmIC0tZ2l0IGEvZnMvZXZlbnRmZC5jIGIvZnMv
ZXZlbnRmZC5jCj4gaW5kZXggZTI2NWI2ZGQ0ZjM0Li5jYzdjZDFkYmVkZDMgMTAwNjQ0Cj4gLS0t
IGEvZnMvZXZlbnRmZC5jCj4gKysrIGIvZnMvZXZlbnRmZC5jCj4gQEAgLTcxLDcgKzcxLDcgQEAg
X191NjQgZXZlbnRmZF9zaWduYWwoc3RydWN0IGV2ZW50ZmRfY3R4ICpjdHgsIF9fdTY0IG4pCj4g
ICAJICogaXQgcmV0dXJucyB0cnVlLCB0aGUgZXZlbnRmZF9zaWduYWwoKSBjYWxsIHNob3VsZCBi
ZSBkZWZlcnJlZCB0byBhCj4gICAJICogc2FmZSBjb250ZXh0Lgo+ICAgCSAqLwo+IC0JaWYgKFdB
Uk5fT05fT05DRSh0aGlzX2NwdV9yZWFkKGV2ZW50ZmRfd2FrZV9jb3VudCkpKQo+ICsJaWYgKFdB
Uk5fT05fT05DRSh0aGlzX2NwdV9yZWFkKGV2ZW50ZmRfd2FrZV9jb3VudCkgPiBFRkRfV0FLRV9E
RVBUSCkpCj4gICAJCXJldHVybiAwOwo+ICAgCj4gICAJc3Bpbl9sb2NrX2lycXNhdmUoJmN0eC0+
d3FoLmxvY2ssIGZsYWdzKTsKPiBkaWZmIC0tZ2l0IGEvaW5jbHVkZS9saW51eC9ldmVudGZkLmgg
Yi9pbmNsdWRlL2xpbnV4L2V2ZW50ZmQuaAo+IGluZGV4IGZhMGE1MjRiYWVkMC4uODg2ZDk5Y2Qz
OGVmIDEwMDY0NAo+IC0tLSBhL2luY2x1ZGUvbGludXgvZXZlbnRmZC5oCj4gKysrIGIvaW5jbHVk
ZS9saW51eC9ldmVudGZkLmgKPiBAQCAtMjksNiArMjksOSBAQAo+ICAgI2RlZmluZSBFRkRfU0hB
UkVEX0ZDTlRMX0ZMQUdTIChPX0NMT0VYRUMgfCBPX05PTkJMT0NLKQo+ICAgI2RlZmluZSBFRkRf
RkxBR1NfU0VUIChFRkRfU0hBUkVEX0ZDTlRMX0ZMQUdTIHwgRUZEX1NFTUFQSE9SRSkKPiAgIAo+
ICsvKiBNYXhpbXVtIHJlY3Vyc2lvbiBkZXB0aCAqLwo+ICsjZGVmaW5lIEVGRF9XQUtFX0RFUFRI
IDEKPiArCj4gICBzdHJ1Y3QgZXZlbnRmZF9jdHg7Cj4gICBzdHJ1Y3QgZmlsZTsKPiAgIAo+IEBA
IC00Nyw3ICs1MCw3IEBAIERFQ0xBUkVfUEVSX0NQVShpbnQsIGV2ZW50ZmRfd2FrZV9jb3VudCk7
Cj4gICAKPiAgIHN0YXRpYyBpbmxpbmUgYm9vbCBldmVudGZkX3NpZ25hbF9jb3VudCh2b2lkKQo+
ICAgewo+IC0JcmV0dXJuIHRoaXNfY3B1X3JlYWQoZXZlbnRmZF93YWtlX2NvdW50KTsKPiArCXJl
dHVybiB0aGlzX2NwdV9yZWFkKGV2ZW50ZmRfd2FrZV9jb3VudCkgPiBFRkRfV0FLRV9ERVBUSDsK
PiAgIH0KPiAgIAo+ICAgI2Vsc2UgLyogQ09ORklHX0VWRU5URkQgKi8KCl9fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fClZpcnR1YWxpemF0aW9uIG1haWxpbmcg
bGlzdApWaXJ0dWFsaXphdGlvbkBsaXN0cy5saW51eC1mb3VuZGF0aW9uLm9yZwpodHRwczovL2xp
c3RzLmxpbnV4Zm91bmRhdGlvbi5vcmcvbWFpbG1hbi9saXN0aW5mby92aXJ0dWFsaXphdGlvbg==
