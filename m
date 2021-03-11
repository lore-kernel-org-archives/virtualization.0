Return-Path: <SRS0=WRLV=IJ=lists.linux-foundation.org=virtualization-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.1 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EF7C8C433E0
	for <virtualization@archiver.kernel.org>; Thu, 11 Mar 2021 03:23:19 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 50D2464FA1
	for <virtualization@archiver.kernel.org>; Thu, 11 Mar 2021 03:23:19 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 50D2464FA1
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=virtualization-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id F3B4D60675;
	Thu, 11 Mar 2021 03:23:18 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
	by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id fD1zJa7xdFLr; Thu, 11 Mar 2021 03:23:18 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp3.osuosl.org (Postfix) with ESMTP id 94AD6605FD;
	Thu, 11 Mar 2021 03:23:17 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 65661C000B;
	Thu, 11 Mar 2021 03:23:17 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [IPv6:2605:bc80:3010::136])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 141B7C0001
 for <virtualization@lists.linux-foundation.org>;
 Thu, 11 Mar 2021 03:23:16 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id E13B660654
 for <virtualization@lists.linux-foundation.org>;
 Thu, 11 Mar 2021 03:23:15 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id 2gQbfd7cc5z8
 for <virtualization@lists.linux-foundation.org>;
 Thu, 11 Mar 2021 03:23:15 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [216.205.24.124])
 by smtp3.osuosl.org (Postfix) with ESMTPS id 3AE9A605FD
 for <virtualization@lists.linux-foundation.org>;
 Thu, 11 Mar 2021 03:23:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1615432994;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=Ub6/EcBH4E/sCu55924OCkZmHzGxaR27DdB+w8cXwRQ=;
 b=C7vSLr9BxtQd6//EjkdTdMOavclgMUtJ2N5kgImEX5Tj98g+d+zAKq0Ip//35hB4b3bKAw
 uhQ0G7CfEW6wkyePRu3BJP0l2Jx7IxXq1PXjv8vY0M3nlZvqmuLUa8xembXJGqaAJLZQ4V
 HEqmnaLcsvSDDouCQtaWotWgCJ8KPQI=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-497-yd4R6GCRP2SgM5WkG-ef4g-1; Wed, 10 Mar 2021 22:23:10 -0500
X-MC-Unique: yd4R6GCRP2SgM5WkG-ef4g-1
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com
 [10.5.11.22])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 1669C801817;
 Thu, 11 Mar 2021 03:23:09 +0000 (UTC)
Received: from wangxiaodeMacBook-Air.local (ovpn-13-9.pek2.redhat.com
 [10.72.13.9])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 1E96D10023AC;
 Thu, 11 Mar 2021 03:23:01 +0000 (UTC)
Subject: Re: [PATCH V3 1/6] vDPA/ifcvf: get_vendor_id returns a device
 specific vendor id
To: Zhu Lingshan <lingshan.zhu@intel.com>, mst@redhat.com, lulu@redhat.com,
 leonro@nvidia.com
References: <20210310090052.4762-1-lingshan.zhu@intel.com>
 <20210310090052.4762-2-lingshan.zhu@intel.com>
From: Jason Wang <jasowang@redhat.com>
Message-ID: <ff5fc8f9-f886-bd2a-60cc-771c628c6c4b@redhat.com>
Date: Thu, 11 Mar 2021 11:23:00 +0800
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.16; rv:78.0)
 Gecko/20100101 Thunderbird/78.8.0
MIME-Version: 1.0
In-Reply-To: <20210310090052.4762-2-lingshan.zhu@intel.com>
Content-Language: en-GB
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
Content-Type: text/plain; charset="utf-8"; Format="flowed"
Errors-To: virtualization-bounces@lists.linux-foundation.org
Sender: "Virtualization" <virtualization-bounces@lists.linux-foundation.org>

Ck9uIDIwMjEvMy8xMCA1OjAwIOS4i+WNiCwgWmh1IExpbmdzaGFuIHdyb3RlOgo+IEluIHRoaXMg
Y29tbWl0LCBpZmN2Zl9nZXRfdmVuZG9yX2lkKCkgd2lsbCByZXR1cm4KPiBhIGRldmljZSBzcGVj
aWZpYyB2ZW5kb3IgaWQgb2YgdGhlIHByb2JlZCBwY2kgZGV2aWNlCj4gdGhhbiBhIGhhcmQgY29k
ZS4KPgo+IFNpZ25lZC1vZmYtYnk6IFpodSBMaW5nc2hhbiA8bGluZ3NoYW4uemh1QGludGVsLmNv
bT4KPiAtLS0KPiAgIGRyaXZlcnMvdmRwYS9pZmN2Zi9pZmN2Zl9tYWluLmMgfCA1ICsrKystCj4g
ICAxIGZpbGUgY2hhbmdlZCwgNCBpbnNlcnRpb25zKCspLCAxIGRlbGV0aW9uKC0pCj4KPiBkaWZm
IC0tZ2l0IGEvZHJpdmVycy92ZHBhL2lmY3ZmL2lmY3ZmX21haW4uYyBiL2RyaXZlcnMvdmRwYS9p
ZmN2Zi9pZmN2Zl9tYWluLmMKPiBpbmRleCBmYTFhZjMwMWNmNTUuLmU1MDFlZTA3ZGUxNyAxMDA2
NDQKPiAtLS0gYS9kcml2ZXJzL3ZkcGEvaWZjdmYvaWZjdmZfbWFpbi5jCj4gKysrIGIvZHJpdmVy
cy92ZHBhL2lmY3ZmL2lmY3ZmX21haW4uYwo+IEBAIC0zMjQsNyArMzI0LDEwIEBAIHN0YXRpYyB1
MzIgaWZjdmZfdmRwYV9nZXRfZGV2aWNlX2lkKHN0cnVjdCB2ZHBhX2RldmljZSAqdmRwYV9kZXYp
Cj4gICAKPiAgIHN0YXRpYyB1MzIgaWZjdmZfdmRwYV9nZXRfdmVuZG9yX2lkKHN0cnVjdCB2ZHBh
X2RldmljZSAqdmRwYV9kZXYpCj4gICB7Cj4gLQlyZXR1cm4gSUZDVkZfU1VCU1lTX1ZFTkRPUl9J
RDsKPiArCXN0cnVjdCBpZmN2Zl9hZGFwdGVyICphZGFwdGVyID0gdmRwYV90b19hZGFwdGVyKHZk
cGFfZGV2KTsKPiArCXN0cnVjdCBwY2lfZGV2ICpwZGV2ID0gYWRhcHRlci0+cGRldjsKPiArCj4g
KwlyZXR1cm4gcGRldi0+c3Vic3lzdGVtX3ZlbmRvcjsKPiAgIH0KCgpXaGlsZSBhdCB0aGlzLCBJ
IHdvbmRlciBpZiB3ZSBjYW4gZG8gc29tZXRoaW5nIHNpbWlsYXIgaW4gCmdldF9kZXZpY2VfaWQo
KSBpZiBpdCBjb3VsZCBiZSBzaW1wbGUgZGVkdWNlZCBmcm9tIHNvbWUgc2ltcGxlIG1hdGggZnJv
bSAKdGhlIHBjaSBkZXZpY2UgaWQ/CgpUaGFua3MKCgo+ICAgCj4gICBzdGF0aWMgdTMyIGlmY3Zm
X3ZkcGFfZ2V0X3ZxX2FsaWduKHN0cnVjdCB2ZHBhX2RldmljZSAqdmRwYV9kZXYpCgpfX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fXwpWaXJ0dWFsaXphdGlvbiBt
YWlsaW5nIGxpc3QKVmlydHVhbGl6YXRpb25AbGlzdHMubGludXgtZm91bmRhdGlvbi5vcmcKaHR0
cHM6Ly9saXN0cy5saW51eGZvdW5kYXRpb24ub3JnL21haWxtYW4vbGlzdGluZm8vdmlydHVhbGl6
YXRpb24=
