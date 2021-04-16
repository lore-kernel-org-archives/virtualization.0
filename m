Return-Path: <SRS0=5KLU=JN=lists.linux-foundation.org=virtualization-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.1 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,URIBL_RED,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DFD87C433B4
	for <virtualization@archiver.kernel.org>; Fri, 16 Apr 2021 02:42:47 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 8A9E56117A
	for <virtualization@archiver.kernel.org>; Fri, 16 Apr 2021 02:42:47 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8A9E56117A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=virtualization-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 5259760DB2;
	Fri, 16 Apr 2021 02:42:47 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
	by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id Xm254a-e5CGG; Fri, 16 Apr 2021 02:42:42 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp3.osuosl.org (Postfix) with ESMTP id 5E75D60DBD;
	Fri, 16 Apr 2021 02:42:41 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 3D56DC0011;
	Fri, 16 Apr 2021 02:42:41 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id C5672C000A
 for <virtualization@lists.linux-foundation.org>;
 Fri, 16 Apr 2021 02:42:39 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id A526D84789
 for <virtualization@lists.linux-foundation.org>;
 Fri, 16 Apr 2021 02:42:39 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp1.osuosl.org (amavisd-new);
 dkim=pass (1024-bit key) header.d=redhat.com
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id YBjJGepbz_rC
 for <virtualization@lists.linux-foundation.org>;
 Fri, 16 Apr 2021 02:42:39 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.133.124])
 by smtp1.osuosl.org (Postfix) with ESMTPS id EDA9484787
 for <virtualization@lists.linux-foundation.org>;
 Fri, 16 Apr 2021 02:42:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1618540957;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=fPDZgRdsoyzDR3CPovAl7+np7+vcLjCamzZ8odna6zk=;
 b=hFzNIoisUH2B5PIyRkYertlSIaWQVAudRtiT8J9FCE+DRmGKLJArizUWqrsWVv1eHjwAgB
 UTM4ALsHyLmryh0AWoRxsscFje6AxsGzoy9uCrDMiSdKQIejB3mcLkkyjcg2FrcVXPsxD+
 +GakoaViVB32zOWpyxHcf+jEFsd9JEo=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-408-V08dCSCANvSRHYC3WoMSdw-1; Thu, 15 Apr 2021 22:42:33 -0400
X-MC-Unique: V08dCSCANvSRHYC3WoMSdw-1
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com
 [10.5.11.12])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id E91D981744F;
 Fri, 16 Apr 2021 02:42:32 +0000 (UTC)
Received: from wangxiaodeMacBook-Air.local (ovpn-13-140.pek2.redhat.com
 [10.72.13.140])
 by smtp.corp.redhat.com (Postfix) with ESMTP id B67FA610A8;
 Fri, 16 Apr 2021 02:42:24 +0000 (UTC)
Subject: Re: [PATCH 2/4] vhost-scsi: remove extra flushes
To: Mike Christie <michael.christie@oracle.com>, stefanha@redhat.com,
 pbonzini@redhat.com, mst@redhat.com,
 virtualization@lists.linux-foundation.org, chaitanya.kulkarni@wdc.com
References: <20210415172752.5734-1-michael.christie@oracle.com>
 <20210415172752.5734-3-michael.christie@oracle.com>
From: Jason Wang <jasowang@redhat.com>
Message-ID: <5eac312a-740a-d435-6b4d-bdd187239882@redhat.com>
Date: Fri, 16 Apr 2021 10:42:22 +0800
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:78.0)
 Gecko/20100101 Thunderbird/78.9.1
MIME-Version: 1.0
In-Reply-To: <20210415172752.5734-3-michael.christie@oracle.com>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=jasowang@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
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
Content-Type: text/plain; charset="gbk"; Format="flowed"
Errors-To: virtualization-bounces@lists.linux-foundation.org
Sender: "Virtualization" <virtualization-bounces@lists.linux-foundation.org>

CtTaIDIwMjEvNC8xNiDJz87nMToyNywgTWlrZSBDaHJpc3RpZSDQtLXAOgo+IFRoZSB2aG9zdCB3
b3JrIGZsdXNoIGZ1bmN0aW9uIHdhcyBmbHVzaGluZyB0aGUgZW50aXJlIHdvcmsgcXVldWUsIHNv
Cj4gdGhlcmUgaXMgbm8gbmVlZCBmb3IgdGhlIGRvdWJsZSB2aG9zdF93b3JrX2Rldl9mbHVzaCBj
YWxscyBpbgo+IHZob3N0X3Njc2lfZmx1c2guCj4KPiBBbmQgd2UgZG8gbm90IG5lZWQgdG8gY2Fs
bCB2aG9zdF9wb2xsX2ZsdXNoIGZvciBlYWNoIHBvbGxlciBiZWNhdXNlCj4gdGhhdCBjYWxsIGFs
c28gZW5kcyB1cCBmbHVzaGluZyB0aGUgc2FtZSB3b3JrIHF1ZXVlIHRocmVhZCB0aGUKPiB2aG9z
dF93b3JrX2Rldl9mbHVzaCBjYWxsIGZsdXNoZWQuCj4KPiBTaWduZWQtb2ZmLWJ5OiBNaWtlIENo
cmlzdGllIDxtaWNoYWVsLmNocmlzdGllQG9yYWNsZS5jb20+Cj4gUmV2aWV3ZWQtYnk6IFN0ZWZh
biBIYWpub2N6aSA8c3RlZmFuaGFAcmVkaGF0LmNvbT4KPiAtLS0KCgpBY2tlZC1ieTogSmFzb24g
V2FuZyA8amFzb3dhbmdAcmVkaGF0LmNvbT4KCgo+ICAgZHJpdmVycy92aG9zdC9zY3NpLmMgfCA4
IC0tLS0tLS0tCj4gICAxIGZpbGUgY2hhbmdlZCwgOCBkZWxldGlvbnMoLSkKPgo+IGRpZmYgLS1n
aXQgYS9kcml2ZXJzL3Zob3N0L3Njc2kuYyBiL2RyaXZlcnMvdmhvc3Qvc2NzaS5jCj4gaW5kZXgg
MGZkNTk2ZGExODM0Li5iM2U2ZmU5YjE3NjcgMTAwNjQ0Cj4gLS0tIGEvZHJpdmVycy92aG9zdC9z
Y3NpLmMKPiArKysgYi9kcml2ZXJzL3Zob3N0L3Njc2kuYwo+IEBAIC0xNDMwLDExICsxNDMwLDYg
QEAgc3RhdGljIHZvaWQgdmhvc3Rfc2NzaV9oYW5kbGVfa2ljayhzdHJ1Y3Qgdmhvc3Rfd29yayAq
d29yaykKPiAgIAl2aG9zdF9zY3NpX2hhbmRsZV92cSh2cywgdnEpOwo+ICAgfQo+ICAgCj4gLXN0
YXRpYyB2b2lkIHZob3N0X3Njc2lfZmx1c2hfdnEoc3RydWN0IHZob3N0X3Njc2kgKnZzLCBpbnQg
aW5kZXgpCj4gLXsKPiAtCXZob3N0X3BvbGxfZmx1c2goJnZzLT52cXNbaW5kZXhdLnZxLnBvbGwp
Owo+IC19Cj4gLQo+ICAgLyogQ2FsbGVycyBtdXN0IGhvbGQgZGV2IG11dGV4ICovCj4gICBzdGF0
aWMgdm9pZCB2aG9zdF9zY3NpX2ZsdXNoKHN0cnVjdCB2aG9zdF9zY3NpICp2cykKPiAgIHsKPiBA
QCAtMTQ1Myw5ICsxNDQ4LDYgQEAgc3RhdGljIHZvaWQgdmhvc3Rfc2NzaV9mbHVzaChzdHJ1Y3Qg
dmhvc3Rfc2NzaSAqdnMpCj4gICAJCWtyZWZfcHV0KCZvbGRfaW5mbGlnaHRbaV0tPmtyZWYsIHZo
b3N0X3Njc2lfZG9uZV9pbmZsaWdodCk7Cj4gICAKPiAgIAkvKiBGbHVzaCBib3RoIHRoZSB2aG9z
dCBwb2xsIGFuZCB2aG9zdCB3b3JrICovCj4gLQlmb3IgKGkgPSAwOyBpIDwgVkhPU1RfU0NTSV9N
QVhfVlE7IGkrKykKPiAtCQl2aG9zdF9zY3NpX2ZsdXNoX3ZxKHZzLCBpKTsKPiAtCXZob3N0X3dv
cmtfZGV2X2ZsdXNoKCZ2cy0+ZGV2KTsKPiAgIAl2aG9zdF93b3JrX2Rldl9mbHVzaCgmdnMtPmRl
dik7Cj4gICAKPiAgIAkvKiBXYWl0IGZvciBhbGwgcmVxcyBpc3N1ZWQgYmVmb3JlIHRoZSBmbHVz
aCB0byBiZSBmaW5pc2hlZCAqLwoKX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX18KVmlydHVhbGl6YXRpb24gbWFpbGluZyBsaXN0ClZpcnR1YWxpemF0aW9uQGxp
c3RzLmxpbnV4LWZvdW5kYXRpb24ub3JnCmh0dHBzOi8vbGlzdHMubGludXhmb3VuZGF0aW9uLm9y
Zy9tYWlsbWFuL2xpc3RpbmZvL3ZpcnR1YWxpemF0aW9u
