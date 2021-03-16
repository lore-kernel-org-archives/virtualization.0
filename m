Return-Path: <SRS0=cXtE=IO=lists.linux-foundation.org=virtualization-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.1 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2428AC433DB
	for <virtualization@archiver.kernel.org>; Tue, 16 Mar 2021 06:09:46 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id ADA226502A
	for <virtualization@archiver.kernel.org>; Tue, 16 Mar 2021 06:09:45 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org ADA226502A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=virtualization-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 6F62C839E4;
	Tue, 16 Mar 2021 06:09:45 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
	by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id Y0Tem6XeDtpL; Tue, 16 Mar 2021 06:09:44 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp1.osuosl.org (Postfix) with ESMTP id 2C4FC838D3;
	Tue, 16 Mar 2021 06:09:44 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 05554C000C;
	Tue, 16 Mar 2021 06:09:44 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by lists.linuxfoundation.org (Postfix) with ESMTP id E6C80C000A
 for <virtualization@lists.linux-foundation.org>;
 Tue, 16 Mar 2021 06:09:42 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id E27856061C
 for <virtualization@lists.linux-foundation.org>;
 Tue, 16 Mar 2021 06:09:42 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp3.osuosl.org (amavisd-new);
 dkim=pass (1024-bit key) header.d=redhat.com
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id aGUm2VHMMWRn
 for <virtualization@lists.linux-foundation.org>;
 Tue, 16 Mar 2021 06:09:42 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.133.124])
 by smtp3.osuosl.org (Postfix) with ESMTPS id 38B4F605BE
 for <virtualization@lists.linux-foundation.org>;
 Tue, 16 Mar 2021 06:09:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1615874981;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=pym55gQ5cNu+m40IVzvuuLtEXKTOXlfin1TVj3jHUAM=;
 b=LMKFoMtUP7noZH4ZL43Wfy+HOOp3k9dlsqZVB96FA87Sf4MYFJVVCwCOrV6ewjINwP0w1B
 c+FD85E0m0VVvkKs0Xc9XKqoNGM3tFJ60Nm2Tkq7RtkGGSb95CnxNJ3PgWBeGQk72M7L5w
 HhMVDbhQ55NYUxTcf+vCIe5wq9jIR90=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-224-oVU6UxoqPiG4oDKOgese7g-1; Tue, 16 Mar 2021 02:09:37 -0400
X-MC-Unique: oVU6UxoqPiG4oDKOgese7g-1
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com
 [10.5.11.22])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 544FF100C618;
 Tue, 16 Mar 2021 06:09:36 +0000 (UTC)
Received: from wangxiaodeMacBook-Air.local (ovpn-12-216.pek2.redhat.com
 [10.72.12.216])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 196C010016DB;
 Tue, 16 Mar 2021 06:09:28 +0000 (UTC)
Subject: Re: [PATCH V4 2/7] vDPA/ifcvf: enable Intel C5000X-PL virtio-net for
 vDPA
To: Zhu Lingshan <lingshan.zhu@intel.com>, mst@redhat.com, lulu@redhat.com,
 leonro@nvidia.com
References: <20210315074501.15868-1-lingshan.zhu@intel.com>
 <20210315074501.15868-3-lingshan.zhu@intel.com>
From: Jason Wang <jasowang@redhat.com>
Message-ID: <840ce79d-3fb8-2d61-3b65-2a834d65ba54@redhat.com>
Date: Tue, 16 Mar 2021 14:09:27 +0800
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.16; rv:78.0)
 Gecko/20100101 Thunderbird/78.8.1
MIME-Version: 1.0
In-Reply-To: <20210315074501.15868-3-lingshan.zhu@intel.com>
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
Cc: netdev@vger.kernel.org, linux-kernel@vger.kernel.org, kvm@vger.kernel.org,
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
Content-Type: text/plain; charset="gbk"; Format="flowed"
Errors-To: virtualization-bounces@lists.linux-foundation.org
Sender: "Virtualization" <virtualization-bounces@lists.linux-foundation.org>

CtTaIDIwMjEvMy8xNSDPws7nMzo0NCwgWmh1IExpbmdzaGFuINC0tcA6Cj4gVGhpcyBjb21taXQg
ZW5hYmxlZCBJbnRlbCBGUEdBIFNtYXJ0TklDIEM1MDAwWC1QTCB2aXJ0aW8tbmV0Cj4gZm9yIHZE
UEEKPgo+IFNpZ25lZC1vZmYtYnk6IFpodSBMaW5nc2hhbiA8bGluZ3NoYW4uemh1QGludGVsLmNv
bT4KCgpBY2tlZC1ieTogSmFzb24gV2FuZyA8amFzb3dhbmdAcmVkaGF0LmNvbT4KCgo+IC0tLQo+
ICAgZHJpdmVycy92ZHBhL2lmY3ZmL2lmY3ZmX2Jhc2UuaCB8IDUgKysrKysKPiAgIGRyaXZlcnMv
dmRwYS9pZmN2Zi9pZmN2Zl9tYWluLmMgfCA1ICsrKysrCj4gICAyIGZpbGVzIGNoYW5nZWQsIDEw
IGluc2VydGlvbnMoKykKPgo+IGRpZmYgLS1naXQgYS9kcml2ZXJzL3ZkcGEvaWZjdmYvaWZjdmZf
YmFzZS5oIGIvZHJpdmVycy92ZHBhL2lmY3ZmL2lmY3ZmX2Jhc2UuaAo+IGluZGV4IDY0Njk2ZDYz
ZmUwNy4uNzVkOWE4MDUyMDM5IDEwMDY0NAo+IC0tLSBhL2RyaXZlcnMvdmRwYS9pZmN2Zi9pZmN2
Zl9iYXNlLmgKPiArKysgYi9kcml2ZXJzL3ZkcGEvaWZjdmYvaWZjdmZfYmFzZS5oCj4gQEAgLTIz
LDYgKzIzLDExIEBACj4gICAjZGVmaW5lIElGQ1ZGX1NVQlNZU19WRU5ET1JfSUQJMHg4MDg2Cj4g
ICAjZGVmaW5lIElGQ1ZGX1NVQlNZU19ERVZJQ0VfSUQJMHgwMDFBCj4gICAKPiArI2RlZmluZSBD
NTAwMFhfUExfVkVORE9SX0lECQkweDFBRjQKPiArI2RlZmluZSBDNTAwMFhfUExfREVWSUNFX0lE
CQkweDEwMDAKPiArI2RlZmluZSBDNTAwMFhfUExfU1VCU1lTX1ZFTkRPUl9JRAkweDgwODYKPiAr
I2RlZmluZSBDNTAwMFhfUExfU1VCU1lTX0RFVklDRV9JRAkweDAwMDEKPiArCj4gICAjZGVmaW5l
IElGQ1ZGX1NVUFBPUlRFRF9GRUFUVVJFUyBcCj4gICAJCSgoMVVMTCA8PCBWSVJUSU9fTkVUX0Zf
TUFDKQkJCXwgXAo+ICAgCQkgKDFVTEwgPDwgVklSVElPX0ZfQU5ZX0xBWU9VVCkJCQl8IFwKPiBk
aWZmIC0tZ2l0IGEvZHJpdmVycy92ZHBhL2lmY3ZmL2lmY3ZmX21haW4uYyBiL2RyaXZlcnMvdmRw
YS9pZmN2Zi9pZmN2Zl9tYWluLmMKPiBpbmRleCBlNTAxZWUwN2RlMTcuLjI2YTJkYWI3Y2E2NiAx
MDA2NDQKPiAtLS0gYS9kcml2ZXJzL3ZkcGEvaWZjdmYvaWZjdmZfbWFpbi5jCj4gKysrIGIvZHJp
dmVycy92ZHBhL2lmY3ZmL2lmY3ZmX21haW4uYwo+IEBAIC00ODQsNiArNDg0LDExIEBAIHN0YXRp
YyBzdHJ1Y3QgcGNpX2RldmljZV9pZCBpZmN2Zl9wY2lfaWRzW10gPSB7Cj4gICAJCUlGQ1ZGX0RF
VklDRV9JRCwKPiAgIAkJSUZDVkZfU1VCU1lTX1ZFTkRPUl9JRCwKPiAgIAkJSUZDVkZfU1VCU1lT
X0RFVklDRV9JRCkgfSwKPiArCXsgUENJX0RFVklDRV9TVUIoQzUwMDBYX1BMX1ZFTkRPUl9JRCwK
PiArCQkJIEM1MDAwWF9QTF9ERVZJQ0VfSUQsCj4gKwkJCSBDNTAwMFhfUExfU1VCU1lTX1ZFTkRP
Ul9JRCwKPiArCQkJIEM1MDAwWF9QTF9TVUJTWVNfREVWSUNFX0lEKSB9LAo+ICsKPiAgIAl7IDAg
fSwKPiAgIH07Cj4gICBNT0RVTEVfREVWSUNFX1RBQkxFKHBjaSwgaWZjdmZfcGNpX2lkcyk7Cgpf
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fXwpWaXJ0dWFsaXph
dGlvbiBtYWlsaW5nIGxpc3QKVmlydHVhbGl6YXRpb25AbGlzdHMubGludXgtZm91bmRhdGlvbi5v
cmcKaHR0cHM6Ly9saXN0cy5saW51eGZvdW5kYXRpb24ub3JnL21haWxtYW4vbGlzdGluZm8vdmly
dHVhbGl6YXRpb24=
