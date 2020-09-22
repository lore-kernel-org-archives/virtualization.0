Return-Path: <SRS0=wpUj=C7=lists.linux-foundation.org=virtualization-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.1 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	NICE_REPLY_A,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DCCA6C4346E
	for <virtualization@archiver.kernel.org>; Tue, 22 Sep 2020 02:02:33 +0000 (UTC)
Received: from fraxinus.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 6E51523A60
	for <virtualization@archiver.kernel.org>; Tue, 22 Sep 2020 02:02:33 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="NlernS3Y"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6E51523A60
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=virtualization-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by fraxinus.osuosl.org (Postfix) with ESMTP id 05529859D2;
	Tue, 22 Sep 2020 02:02:33 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from fraxinus.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id Rjf04EihkeDl; Tue, 22 Sep 2020 02:02:32 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by fraxinus.osuosl.org (Postfix) with ESMTP id 8A9738476C;
	Tue, 22 Sep 2020 02:02:32 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 7654BC0889;
	Tue, 22 Sep 2020 02:02:32 +0000 (UTC)
Received: from whitealder.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id BC6C6C0051
 for <virtualization@lists.linux-foundation.org>;
 Tue, 22 Sep 2020 02:02:30 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by whitealder.osuosl.org (Postfix) with ESMTP id A525A85DBB
 for <virtualization@lists.linux-foundation.org>;
 Tue, 22 Sep 2020 02:02:30 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from whitealder.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id RCIYJn1qg2Mo
 for <virtualization@lists.linux-foundation.org>;
 Tue, 22 Sep 2020 02:02:29 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [63.128.21.124])
 by whitealder.osuosl.org (Postfix) with ESMTPS id BDD1B856F4
 for <virtualization@lists.linux-foundation.org>;
 Tue, 22 Sep 2020 02:02:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1600740148;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=W1QhFiJpeL+8vBbjBr4sETQTmp+yKXR4gMOOBx8WCao=;
 b=NlernS3Y9dY3f7sHPn2yngIt23jCyozJ92tcbzm8pC9ErK1foCG6FN4hIALLkkGplrDLPg
 NbWqyvnFaqxL43LvyyJaVHHGL7mPB4NDMINGjUckbqfiHSLAPPSv1Vp5c0RpLU7Qe2ql2F
 +oDi+P+PqlyayoFLeGzbWZzupwPwmFI=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-222-SLjUKDTTPcO_OkI5t8g0kg-1; Mon, 21 Sep 2020 22:02:26 -0400
X-MC-Unique: SLjUKDTTPcO_OkI5t8g0kg-1
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com
 [10.5.11.14])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 428401005E64;
 Tue, 22 Sep 2020 02:02:25 +0000 (UTC)
Received: from [10.72.13.139] (ovpn-13-139.pek2.redhat.com [10.72.13.139])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 209CB5DA30;
 Tue, 22 Sep 2020 02:02:16 +0000 (UTC)
Subject: Re: [PATCH 2/8] vhost: add helper to check if a vq has been setup
To: Mike Christie <michael.christie@oracle.com>, martin.petersen@oracle.com,
 linux-scsi@vger.kernel.org, target-devel@vger.kernel.org, mst@redhat.com,
 pbonzini@redhat.com, stefanha@redhat.com,
 virtualization@lists.linux-foundation.org
References: <1600712588-9514-1-git-send-email-michael.christie@oracle.com>
 <1600712588-9514-3-git-send-email-michael.christie@oracle.com>
From: Jason Wang <jasowang@redhat.com>
Message-ID: <e2d16333-d5ed-4c5c-58b3-7b5d0a9da47a@redhat.com>
Date: Tue, 22 Sep 2020 10:02:15 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <1600712588-9514-3-git-send-email-michael.christie@oracle.com>
Content-Language: en-US
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
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

Ck9uIDIwMjAvOS8yMiDkuIrljYgyOjIzLCBNaWtlIENocmlzdGllIHdyb3RlOgo+IFRoaXMgYWRk
cyBhIGhlbHBlciBjaGVjayBpZiBhIHZxIGhhcyBiZWVuIHNldHVwLiBUaGUgbmV4dCBwYXRjaGVz
Cj4gd2lsbCB1c2UgdGhpcyB3aGVuIHdlIG1vdmUgdGhlIHZob3N0IHNjc2kgY21kIHByZWFsbG9j
YXRpb24gZnJvbSBwZXIKPiBzZXNzaW9uIHRvIHBlciB2cS4gSW4gdGhlIHBlciB2cSBjYXNlLCB3
ZSBvbmx5IHdhbnQgdG8gYWxsb2NhdGUgY21kcwo+IGZvciB2cXMgdGhhdCBoYXZlIGFjdHVhbGx5
IGJlZW4gc2V0dXAgYW5kIG5vdCBmb3IgYWxsIHRoZSBwb3NzaWJsZQo+IHZxcy4KPgo+IFNpZ25l
ZC1vZmYtYnk6IE1pa2UgQ2hyaXN0aWUgPG1pY2hhZWwuY2hyaXN0aWVAb3JhY2xlLmNvbT4KPiAt
LS0KPiAgIGRyaXZlcnMvdmhvc3Qvdmhvc3QuYyB8IDkgKysrKysrKysrCj4gICBkcml2ZXJzL3Zo
b3N0L3Zob3N0LmggfCAxICsKPiAgIDIgZmlsZXMgY2hhbmdlZCwgMTAgaW5zZXJ0aW9ucygrKQo+
Cj4gZGlmZiAtLWdpdCBhL2RyaXZlcnMvdmhvc3Qvdmhvc3QuYyBiL2RyaXZlcnMvdmhvc3Qvdmhv
c3QuYwo+IGluZGV4IGI0NTUxOWMuLjVkZDllYjEgMTAwNjQ0Cj4gLS0tIGEvZHJpdmVycy92aG9z
dC92aG9zdC5jCj4gKysrIGIvZHJpdmVycy92aG9zdC92aG9zdC5jCj4gQEAgLTMwNSw2ICszMDUs
MTUgQEAgc3RhdGljIHZvaWQgdmhvc3RfdnJpbmdfY2FsbF9yZXNldChzdHJ1Y3Qgdmhvc3RfdnJp
bmdfY2FsbCAqY2FsbF9jdHgpCj4gICAJc3Bpbl9sb2NrX2luaXQoJmNhbGxfY3R4LT5jdHhfbG9j
ayk7Cj4gICB9Cj4gICAKPiArYm9vbCB2aG9zdF92cV9pc19zZXR1cChzdHJ1Y3Qgdmhvc3Rfdmly
dHF1ZXVlICp2cSkKPiArewo+ICsJaWYgKHZxLT5hdmFpbCAmJiB2cS0+ZGVzYyAmJiB2cS0+dXNl
ZCAmJiB2aG9zdF92cV9hY2Nlc3Nfb2sodnEpKQo+ICsJCXJldHVybiB0cnVlOwo+ICsJZWxzZQo+
ICsJCXJldHVybiBmYWxzZTsKPiArfQo+ICtFWFBPUlRfU1lNQk9MX0dQTCh2aG9zdF92cV9pc19z
ZXR1cCk7CgoKVGhpcyBpcyBwcm9iYWJseSBvayBidXQgSSB3b25kZXIgbWF5YmUgd2Ugc2hvdWxk
IGhhdmUgc29tZXRoaW5nIGxpa2UgCndoYXQgdkRQQSBkaWQgKFZIT1NUX1NFVF9WUklOR19FTkFC
TEUpIHRvIG1hdGNoIHZpcnRpbyAxLjAgZGV2aWNlIApkZWZpbml0aW9uLgoKVGhhbmtzCgoKPiAr
Cj4gICBzdGF0aWMgdm9pZCB2aG9zdF92cV9yZXNldChzdHJ1Y3Qgdmhvc3RfZGV2ICpkZXYsCj4g
ICAJCQkgICBzdHJ1Y3Qgdmhvc3RfdmlydHF1ZXVlICp2cSkKPiAgIHsKPiBkaWZmIC0tZ2l0IGEv
ZHJpdmVycy92aG9zdC92aG9zdC5oIGIvZHJpdmVycy92aG9zdC92aG9zdC5oCj4gaW5kZXggOTAz
MmQzYy4uM2QzMGIzZCAxMDA2NDQKPiAtLS0gYS9kcml2ZXJzL3Zob3N0L3Zob3N0LmgKPiArKysg
Yi9kcml2ZXJzL3Zob3N0L3Zob3N0LmgKPiBAQCAtMTkwLDYgKzE5MCw3IEBAIGludCB2aG9zdF9n
ZXRfdnFfZGVzYyhzdHJ1Y3Qgdmhvc3RfdmlydHF1ZXVlICosCj4gICAJCSAgICAgIHN0cnVjdCB2
aG9zdF9sb2cgKmxvZywgdW5zaWduZWQgaW50ICpsb2dfbnVtKTsKPiAgIHZvaWQgdmhvc3RfZGlz
Y2FyZF92cV9kZXNjKHN0cnVjdCB2aG9zdF92aXJ0cXVldWUgKiwgaW50IG4pOwo+ICAgCj4gK2Jv
b2wgdmhvc3RfdnFfaXNfc2V0dXAoc3RydWN0IHZob3N0X3ZpcnRxdWV1ZSAqdnEpOwo+ICAgaW50
IHZob3N0X3ZxX2luaXRfYWNjZXNzKHN0cnVjdCB2aG9zdF92aXJ0cXVldWUgKik7Cj4gICBpbnQg
dmhvc3RfYWRkX3VzZWQoc3RydWN0IHZob3N0X3ZpcnRxdWV1ZSAqLCB1bnNpZ25lZCBpbnQgaGVh
ZCwgaW50IGxlbik7Cj4gICBpbnQgdmhvc3RfYWRkX3VzZWRfbihzdHJ1Y3Qgdmhvc3RfdmlydHF1
ZXVlICosIHN0cnVjdCB2cmluZ191c2VkX2VsZW0gKmhlYWRzLAoKX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX18KVmlydHVhbGl6YXRpb24gbWFpbGluZyBsaXN0
ClZpcnR1YWxpemF0aW9uQGxpc3RzLmxpbnV4LWZvdW5kYXRpb24ub3JnCmh0dHBzOi8vbGlzdHMu
bGludXhmb3VuZGF0aW9uLm9yZy9tYWlsbWFuL2xpc3RpbmZvL3ZpcnR1YWxpemF0aW9u
