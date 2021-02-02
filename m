Return-Path: <SRS0=DeSX=HE=lists.linux-foundation.org=virtualization-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.2 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D5CC2C433E0
	for <virtualization@archiver.kernel.org>; Tue,  2 Feb 2021 15:38:51 +0000 (UTC)
Received: from whitealder.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 7619A64F64
	for <virtualization@archiver.kernel.org>; Tue,  2 Feb 2021 15:38:51 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7619A64F64
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=virtualization-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by whitealder.osuosl.org (Postfix) with ESMTP id 4EF7E84F6F;
	Tue,  2 Feb 2021 15:38:51 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from whitealder.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id PUUmbSsWINfR; Tue,  2 Feb 2021 15:38:50 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by whitealder.osuosl.org (Postfix) with ESMTP id 2E78384FE6;
	Tue,  2 Feb 2021 15:38:50 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 15F20C0174;
	Tue,  2 Feb 2021 15:38:50 +0000 (UTC)
Received: from silver.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 472F0C013A
 for <virtualization@lists.linux-foundation.org>;
 Tue,  2 Feb 2021 15:38:49 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by silver.osuosl.org (Postfix) with ESMTP id 28B4020433
 for <virtualization@lists.linux-foundation.org>;
 Tue,  2 Feb 2021 15:38:49 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from silver.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id 5Sfh-b0NzQFq
 for <virtualization@lists.linux-foundation.org>;
 Tue,  2 Feb 2021 15:38:48 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [216.205.24.124])
 by silver.osuosl.org (Postfix) with ESMTPS id 3A4C5203C4
 for <virtualization@lists.linux-foundation.org>;
 Tue,  2 Feb 2021 15:38:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1612280327;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=/91RGQPkdsH61MPGcn8nrqsfZFX35ZsXexa1fyd3QRw=;
 b=fsn5Se0hSJ5ROD0oUn9i/v4ddjwpUW2nnFpgYlIMzbxYBgTxALmHFUzhBo3j2blA7nrSXY
 DuRthOYuaZtlnrtA0QVpU14WAEvWii8WvDEDeoPZEmhUhrVtdZBficd6KINWZaDITWv6wx
 J5up2wQT0keYOxkFVGVExgxPm6xNzr8=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-387-_Hi5P4vSPHKnnGsVZ1csNg-1; Tue, 02 Feb 2021 10:38:43 -0500
X-MC-Unique: _Hi5P4vSPHKnnGsVZ1csNg-1
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com
 [10.5.11.13])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id AB71F835E24;
 Tue,  2 Feb 2021 15:38:41 +0000 (UTC)
Received: from [10.3.112.103] (ovpn-112-103.phx2.redhat.com [10.3.112.103])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 74DB660CE7;
 Tue,  2 Feb 2021 15:38:34 +0000 (UTC)
Subject: Re: [RFC 08/10] vhost: Add x-vhost-enable-shadow-vq qmp
To: =?UTF-8?Q?Eugenio_P=c3=a9rez?= <eperezma@redhat.com>, qemu-devel@nongnu.org
References: <20210129205415.876290-1-eperezma@redhat.com>
 <20210129205415.876290-9-eperezma@redhat.com>
From: Eric Blake <eblake@redhat.com>
Organization: Red Hat, Inc.
Message-ID: <4ab76cf6-401b-97de-6154-2e025cb1ebc6@redhat.com>
Date: Tue, 2 Feb 2021 09:38:33 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.7.0
MIME-Version: 1.0
In-Reply-To: <20210129205415.876290-9-eperezma@redhat.com>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=eblake@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Language: en-US
Cc: Parav Pandit <parav@mellanox.com>, "Michael S. Tsirkin" <mst@redhat.com>,
 virtualization@lists.linux-foundation.org,
 Harpreet Singh Anand <hanand@xilinx.com>, Xiao W Wang <xiao.w.wang@intel.com>,
 Stefan Hajnoczi <stefanha@redhat.com>, Eli Cohen <eli@mellanox.com>,
 Michael Lilja <ml@napatech.com>, Jim Harford <jim.harford@broadcom.com>,
 Rob Miller <rob.miller@broadcom.com>
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
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Errors-To: virtualization-bounces@lists.linux-foundation.org
Sender: "Virtualization" <virtualization-bounces@lists.linux-foundation.org>

T24gMS8yOS8yMSAyOjU0IFBNLCBFdWdlbmlvIFDDqXJleiB3cm90ZToKPiBDb21tYW5kIHRvIGVu
YWJsZSBzaGFkb3cgdmlydHF1ZXVlIGxvb2tzIGxpa2U6Cj4gCj4geyAiZXhlY3V0ZSI6ICJ4LXZo
b3N0LWVuYWJsZS1zaGFkb3ctdnEiLCAiYXJndW1lbnRzIjogeyAibmFtZSI6ICJkZXYwIiwgImVu
YWJsZSI6IHRydWUgfSB9Cj4gCj4gU2lnbmVkLW9mZi1ieTogRXVnZW5pbyBQw6lyZXogPGVwZXJl
em1hQHJlZGhhdC5jb20+Cj4gLS0tCj4gIHFhcGkvbmV0Lmpzb24gICAgIHwgMjMgKysrKysrKysr
KysrKysrKysrKysrKysKPiAgaHcvdmlydGlvL3Zob3N0LmMgfCAgNiArKysrKysKPiAgMiBmaWxl
cyBjaGFuZ2VkLCAyOSBpbnNlcnRpb25zKCspCj4gCj4gZGlmZiAtLWdpdCBhL3FhcGkvbmV0Lmpz
b24gYi9xYXBpL25ldC5qc29uCj4gaW5kZXggYzMxNzQ4Yzg3Zi4uNjE3MGQ2OTc5OCAxMDA2NDQK
PiAtLS0gYS9xYXBpL25ldC5qc29uCj4gKysrIGIvcWFwaS9uZXQuanNvbgo+IEBAIC03Nyw2ICs3
NywyOSBAQAo+ICAjIwo+ICB7ICdjb21tYW5kJzogJ25ldGRldl9kZWwnLCAnZGF0YSc6IHsnaWQn
OiAnc3RyJ30gfQo+ICAKPiArIyMKPiArIyBAeC12aG9zdC1lbmFibGUtc2hhZG93LXZxOgoKVGhp
cyBzcGVsbGluZyBpcyB0aGUgcHJlZmVycmVkIGZvcm0uLi5bMV0KCj4gKyMKPiArIyBVc2Ugdmhv
c3Qgc2hhZG93IHZpcnRxdWV1ZS4KPiArIwo+ICsjIEBuYW1lOiB0aGUgZGV2aWNlIG5hbWUgb2Yg
dGhlIHZpcnR1YWwgbmV0d29yayBhZGFwdGVyCj4gKyMKPiArIyBAZW5hYmxlOiB0cnVlIHRvIHVz
ZSBoZSBhbHRlcm5hdGUgc2hhZG93IFZRIG5vdGlmaWNhdGlvbiBwYXRoCj4gKyMKPiArIyBSZXR1
cm5zOiBFcnJvciBpZiBmYWlsdXJlLCBvciAnbm8gZXJyb3InIGZvciBzdWNjZXNzCgpUaGlzIGxp
bmUuLi5bMl0KCj4gKyMKPiArIyBTaW5jZTogNS4zCgpUaGUgbmV4dCByZWxlYXNlIGlzIDYuMCwg
bm90IDUuMy4KCj4gKyMKPiArIyBFeGFtcGxlOgo+ICsjCj4gKyMgLT4geyAiZXhlY3V0ZSI6ICJ4
LXZob3N0X2VuYWJsZV9zaGFkb3dfdnEiLCAiYXJndW1lbnRzIjogeyJlbmFibGUiOiB0cnVlfSB9
CgpbMV0uLi5idXQgZG9lc24ndCBtYXRjaCB0aGUgZXhhbXBsZS4KCj4gKyMgPC0geyAicmV0dXJu
IjogeyAiZW5hYmxlZCIgOiB0cnVlIH0gfQoKWzJdLi4uZG9lc24ndCBtYXRjaCB0aGlzIGNvbW1l
bnQuICBJJ2QganVzdCBkcm9wIHRoZSBsaW5lLCBzaW5jZSB0aGVyZQppcyBubyBleHBsaWNpdCBy
ZXR1cm4gbGlzdGVkLgoKPiArIwo+ICsjIwo+ICt7ICdjb21tYW5kJzogJ3gtdmhvc3QtZW5hYmxl
LXNoYWRvdy12cScsCj4gKyAgJ2RhdGEnOiB7J25hbWUnOiAnc3RyJywgJ2VuYWJsZSc6ICdib29s
J30sCj4gKyAgJ2lmJzogJ2RlZmluZWQoQ09ORklHX1ZIT1NUX0tFUk5FTCknIH0KPiArCj4gICMj
Cj4gICMgQE5ldExlZ2FjeU5pY09wdGlvbnM6Cj4gICMKPiBkaWZmIC0tZ2l0IGEvaHcvdmlydGlv
L3Zob3N0LmMgYi9ody92aXJ0aW8vdmhvc3QuYwo+IGluZGV4IDA0MGY2OGZmMmUuLjQyODM2ZTQ1
ZjMgMTAwNjQ0Cj4gLS0tIGEvaHcvdmlydGlvL3Zob3N0LmMKPiArKysgYi9ody92aXJ0aW8vdmhv
c3QuYwo+IEBAIC0xNSw2ICsxNSw3IEBACj4gIAo+ICAjaW5jbHVkZSAicWVtdS9vc2RlcC5oIgo+
ICAjaW5jbHVkZSAicWFwaS9lcnJvci5oIgo+ICsjaW5jbHVkZSAicWFwaS9xYXBpLWNvbW1hbmRz
LW5ldC5oIgo+ICAjaW5jbHVkZSAiaHcvdmlydGlvL3Zob3N0LmgiCj4gICNpbmNsdWRlICJxZW11
L2F0b21pYy5oIgo+ICAjaW5jbHVkZSAicWVtdS9yYW5nZS5oIgo+IEBAIC0xODQxLDMgKzE4NDIs
OCBAQCBpbnQgdmhvc3RfbmV0X3NldF9iYWNrZW5kKHN0cnVjdCB2aG9zdF9kZXYgKmhkZXYsCj4g
IAo+ICAgICAgcmV0dXJuIC0xOwo+ICB9Cj4gKwo+ICt2b2lkIHFtcF94X3Zob3N0X2VuYWJsZV9z
aGFkb3dfdnEoY29uc3QgY2hhciAqbmFtZSwgYm9vbCBlbmFibGUsIEVycm9yICoqZXJycCkKPiAr
ewo+ICsgICAgZXJyb3Jfc2V0ZyhlcnJwLCAiU2hhZG93IHZpcnRxdWV1ZSBzdGlsbCBub3QgaW1w
bGVtZW50ZWQuIik7CgplcnJvcl9zZXRnKCkgc2hvdWxkIG5vdCBiZSBwYXNzZWQgYSB0cmFpbGlu
ZyAnLicuCgotLSAKRXJpYyBCbGFrZSwgUHJpbmNpcGFsIFNvZnR3YXJlIEVuZ2luZWVyClJlZCBI
YXQsIEluYy4gICAgICAgICAgICsxLTkxOS0zMDEtMzIyNgpWaXJ0dWFsaXphdGlvbjogIHFlbXUu
b3JnIHwgbGlidmlydC5vcmcKCl9fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fClZpcnR1YWxpemF0aW9uIG1haWxpbmcgbGlzdApWaXJ0dWFsaXphdGlvbkBsaXN0
cy5saW51eC1mb3VuZGF0aW9uLm9yZwpodHRwczovL2xpc3RzLmxpbnV4Zm91bmRhdGlvbi5vcmcv
bWFpbG1hbi9saXN0aW5mby92aXJ0dWFsaXphdGlvbg==
