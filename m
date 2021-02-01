Return-Path: <SRS0=ow7J=HD=lists.linux-foundation.org=virtualization-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.1 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CE20AC433DB
	for <virtualization@archiver.kernel.org>; Mon,  1 Feb 2021 06:13:10 +0000 (UTC)
Received: from fraxinus.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 2944F64E06
	for <virtualization@archiver.kernel.org>; Mon,  1 Feb 2021 06:13:10 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2944F64E06
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=virtualization-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by fraxinus.osuosl.org (Postfix) with ESMTP id C64BF860EA;
	Mon,  1 Feb 2021 06:13:09 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from fraxinus.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id LxcKo5xj1w6O; Mon,  1 Feb 2021 06:13:09 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by fraxinus.osuosl.org (Postfix) with ESMTP id 1C4BC86054;
	Mon,  1 Feb 2021 06:13:09 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id F2589C0FA7;
	Mon,  1 Feb 2021 06:13:08 +0000 (UTC)
Received: from whitealder.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 64B42C013A
 for <virtualization@lists.linux-foundation.org>;
 Mon,  1 Feb 2021 06:13:07 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by whitealder.osuosl.org (Postfix) with ESMTP id 4B1BC865A1
 for <virtualization@lists.linux-foundation.org>;
 Mon,  1 Feb 2021 06:13:07 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from whitealder.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id C0vgSryv4pMZ
 for <virtualization@lists.linux-foundation.org>;
 Mon,  1 Feb 2021 06:13:06 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [216.205.24.124])
 by whitealder.osuosl.org (Postfix) with ESMTPS id 9AA5C8657C
 for <virtualization@lists.linux-foundation.org>;
 Mon,  1 Feb 2021 06:13:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1612159985;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=Z3Bypzo/VMSTxUaDET2qnn2SqjOz9+Ise9I8Thr+bDQ=;
 b=H5PBdEbo81jbhgC2jglTidorhI5nsAGgL9eZg5B/jQM8uml4rSSFoDYSXD6aH6eUo0dP4K
 wR6cqsD2hekJERUbiEskRSI65TKVRlUjM27L74rlOaSLUveRQ7pd26wL3K3czSBvdNugyq
 PAOfrjjeX1EQnkoo01TU4xYl52Loz/k=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-371-VJTODLuqPCOtybfrL6ncYw-1; Mon, 01 Feb 2021 01:13:04 -0500
X-MC-Unique: VJTODLuqPCOtybfrL6ncYw-1
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com
 [10.5.11.11])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 802DF1006C81;
 Mon,  1 Feb 2021 06:13:02 +0000 (UTC)
Received: from [10.72.13.120] (ovpn-13-120.pek2.redhat.com [10.72.13.120])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 959AD2BFF1;
 Mon,  1 Feb 2021 06:12:48 +0000 (UTC)
Subject: Re: [RFC 05/10] vhost: Add vhost_dev_from_virtio
To: =?UTF-8?Q?Eugenio_P=c3=a9rez?= <eperezma@redhat.com>, qemu-devel@nongnu.org
References: <20210129205415.876290-1-eperezma@redhat.com>
 <20210129205415.876290-6-eperezma@redhat.com>
From: Jason Wang <jasowang@redhat.com>
Message-ID: <acf16fd6-2282-c220-e642-0868ac839b70@redhat.com>
Date: Mon, 1 Feb 2021 14:12:46 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <20210129205415.876290-6-eperezma@redhat.com>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=jasowang@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Language: en-US
Cc: Parav Pandit <parav@mellanox.com>, "Michael S. Tsirkin" <mst@redhat.com>,
 virtualization@lists.linux-foundation.org,
 Harpreet Singh Anand <hanand@xilinx.com>, Xiao W Wang <xiao.w.wang@intel.com>,
 Stefan Hajnoczi <stefanha@redhat.com>, Eli Cohen <eli@mellanox.com>,
 Eric Blake <eblake@redhat.com>, Michael Lilja <ml@napatech.com>,
 Jim Harford <jim.harford@broadcom.com>, Rob Miller <rob.miller@broadcom.com>
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

Ck9uIDIwMjEvMS8zMCDkuIrljYg0OjU0LCBFdWdlbmlvIFDDqXJleiB3cm90ZToKPiBTaWduZWQt
b2ZmLWJ5OiBFdWdlbmlvIFDDqXJleiA8ZXBlcmV6bWFAcmVkaGF0LmNvbT4KPiAtLS0KPiAgIGlu
Y2x1ZGUvaHcvdmlydGlvL3Zob3N0LmggfCAgMSArCj4gICBody92aXJ0aW8vdmhvc3QuYyAgICAg
ICAgIHwgMTcgKysrKysrKysrKysrKysrKysKPiAgIDIgZmlsZXMgY2hhbmdlZCwgMTggaW5zZXJ0
aW9ucygrKQo+Cj4gZGlmZiAtLWdpdCBhL2luY2x1ZGUvaHcvdmlydGlvL3Zob3N0LmggYi9pbmNs
dWRlL2h3L3ZpcnRpby92aG9zdC5oCj4gaW5kZXggNGE4YmM3NTQxNS4uZmNhMDc2ZTNmMCAxMDA2
NDQKPiAtLS0gYS9pbmNsdWRlL2h3L3ZpcnRpby92aG9zdC5oCj4gKysrIGIvaW5jbHVkZS9ody92
aXJ0aW8vdmhvc3QuaAo+IEBAIC0xMjMsNiArMTIzLDcgQEAgdWludDY0X3Qgdmhvc3RfZ2V0X2Zl
YXR1cmVzKHN0cnVjdCB2aG9zdF9kZXYgKmhkZXYsIGNvbnN0IGludCAqZmVhdHVyZV9iaXRzLAo+
ICAgdm9pZCB2aG9zdF9hY2tfZmVhdHVyZXMoc3RydWN0IHZob3N0X2RldiAqaGRldiwgY29uc3Qg
aW50ICpmZWF0dXJlX2JpdHMsCj4gICAgICAgICAgICAgICAgICAgICAgICAgICB1aW50NjRfdCBm
ZWF0dXJlcyk7Cj4gICBib29sIHZob3N0X2hhc19mcmVlX3Nsb3Qodm9pZCk7Cj4gK3N0cnVjdCB2
aG9zdF9kZXYgKnZob3N0X2Rldl9mcm9tX3ZpcnRpbyhjb25zdCBWaXJ0SU9EZXZpY2UgKnZkZXYp
Owo+ICAgCj4gICBpbnQgdmhvc3RfbmV0X3NldF9iYWNrZW5kKHN0cnVjdCB2aG9zdF9kZXYgKmhk
ZXYsCj4gICAgICAgICAgICAgICAgICAgICAgICAgICAgIHN0cnVjdCB2aG9zdF92cmluZ19maWxl
ICpmaWxlKTsKPiBkaWZmIC0tZ2l0IGEvaHcvdmlydGlvL3Zob3N0LmMgYi9ody92aXJ0aW8vdmhv
c3QuYwo+IGluZGV4IDI4YzdkNzgxNzIuLjg2ODNkNTA3ZjUgMTAwNjQ0Cj4gLS0tIGEvaHcvdmly
dGlvL3Zob3N0LmMKPiArKysgYi9ody92aXJ0aW8vdmhvc3QuYwo+IEBAIC02MSw2ICs2MSwyMyBA
QCBib29sIHZob3N0X2hhc19mcmVlX3Nsb3Qodm9pZCkKPiAgICAgICByZXR1cm4gc2xvdHNfbGlt
aXQgPiB1c2VkX21lbXNsb3RzOwo+ICAgfQo+ICAgCj4gKy8qCj4gKyAqIEdldCB0aGUgdmhvc3Qg
ZGV2aWNlIGFzc29jaWF0ZWQgdG8gYSBWaXJ0SU8gZGV2aWNlLgo+ICsgKi8KPiArc3RydWN0IHZo
b3N0X2RldiAqdmhvc3RfZGV2X2Zyb21fdmlydGlvKGNvbnN0IFZpcnRJT0RldmljZSAqdmRldikK
PiArewo+ICsgICAgc3RydWN0IHZob3N0X2RldiAqaGRldjsKPiArCj4gKyAgICBRTElTVF9GT1JF
QUNIKGhkZXYsICZ2aG9zdF9kZXZpY2VzLCBlbnRyeSkgewo+ICsgICAgICAgIGlmIChoZGV2LT52
ZGV2ID09IHZkZXYpIHsKPiArICAgICAgICAgICAgcmV0dXJuIGhkZXY7Cj4gKyAgICAgICAgfQo+
ICsgICAgfQo+ICsKPiArICAgIGFzc2VydChoZGV2KTsKPiArICAgIHJldHVybiBOVUxMOwo+ICt9
CgoKSSdtIG5vdCBzdXJlIHRoaXMgY2FuIHdvcmsgaW4gdGhlIGNhc2Ugb2YgbXVsdGlxdWV1ZS4g
RS5nIHZob3N0LW5ldCAKbXVsdGlxdWV1ZSBpcyBhIE46MSBtYXBwaW5nIGJldHdlZW4gdmhvc3Qg
ZGV2aWNzIGFuZCB2aXJ0aW8gZGV2aWNlcy4KClRoYW5rcwoKCj4gKwo+ICAgc3RhdGljIHZvaWQg
dmhvc3RfZGV2X3N5bmNfcmVnaW9uKHN0cnVjdCB2aG9zdF9kZXYgKmRldiwKPiAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICBNZW1vcnlSZWdpb25TZWN0aW9uICpzZWN0aW9uLAo+
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgIHVpbnQ2NF90IG1maXJzdCwgdWlu
dDY0X3QgbWxhc3QsCgpfX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fXwpWaXJ0dWFsaXphdGlvbiBtYWlsaW5nIGxpc3QKVmlydHVhbGl6YXRpb25AbGlzdHMubGlu
dXgtZm91bmRhdGlvbi5vcmcKaHR0cHM6Ly9saXN0cy5saW51eGZvdW5kYXRpb24ub3JnL21haWxt
YW4vbGlzdGluZm8vdmlydHVhbGl6YXRpb24=
