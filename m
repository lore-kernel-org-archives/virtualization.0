Return-Path: <SRS0=I+ly=HU=lists.linux-foundation.org=virtualization-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 32AA4C433DB
	for <virtualization@archiver.kernel.org>; Thu, 18 Feb 2021 06:37:38 +0000 (UTC)
Received: from hemlock.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A0F5664E3E
	for <virtualization@archiver.kernel.org>; Thu, 18 Feb 2021 06:37:37 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A0F5664E3E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=virtualization-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by hemlock.osuosl.org (Postfix) with ESMTP id 47959871A7;
	Thu, 18 Feb 2021 06:37:37 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from hemlock.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id uWOJ2u+d7UYX; Thu, 18 Feb 2021 06:37:36 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by hemlock.osuosl.org (Postfix) with ESMTP id A100887178;
	Thu, 18 Feb 2021 06:37:36 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 7DE93C000F;
	Thu, 18 Feb 2021 06:37:36 +0000 (UTC)
Received: from fraxinus.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by lists.linuxfoundation.org (Postfix) with ESMTP id E4670C000D
 for <virtualization@lists.linux-foundation.org>;
 Thu, 18 Feb 2021 06:37:34 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by fraxinus.osuosl.org (Postfix) with ESMTP id E07CC845C5
 for <virtualization@lists.linux-foundation.org>;
 Thu, 18 Feb 2021 06:37:34 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from fraxinus.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id zrPfPdQ-J6il
 for <virtualization@lists.linux-foundation.org>;
 Thu, 18 Feb 2021 06:37:34 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [63.128.21.124])
 by fraxinus.osuosl.org (Postfix) with ESMTPS id 19558845A3
 for <virtualization@lists.linux-foundation.org>;
 Thu, 18 Feb 2021 06:37:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1613630253;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=qZsYPo7lFIHJSBW+k62y1pF0Q5iGGVk8F/Ofi1wgySA=;
 b=R9sV0u/7BcjYlWNU9pZ4Qh92aKAC2DKuJu8d7V6y8H8McpXY/LN/xE6fngxqoyZHxqfvMK
 mt/StuqO+gQidPxXcOu0Gy6ZQ1swb5ogDKVRn9KFvw+2d5mkpduj6xj5ogHZseZhaG15VL
 dRKBZtymVFO8MWx0gLP23eA/TrS/FnE=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-392-uvGEjrB0MqiW0qrg2HcOWQ-1; Thu, 18 Feb 2021 01:37:29 -0500
X-MC-Unique: uvGEjrB0MqiW0qrg2HcOWQ-1
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com
 [10.5.11.11])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 0DBF3801976;
 Thu, 18 Feb 2021 06:37:28 +0000 (UTC)
Received: from [10.72.13.28] (ovpn-13-28.pek2.redhat.com [10.72.13.28])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 987C6722CF;
 Thu, 18 Feb 2021 06:37:19 +0000 (UTC)
Subject: Re: [PATCH v2 3/3] vdpa/mlx5: defer clear_virtqueues to until
 DRIVER_OK
To: Si-Wei Liu <si-wei.liu@oracle.com>, Eli Cohen <elic@nvidia.com>,
 "Michael S. Tsirkin" <mst@redhat.com>
References: <1612993680-29454-1-git-send-email-si-wei.liu@oracle.com>
 <1612993680-29454-4-git-send-email-si-wei.liu@oracle.com>
 <20210211073314.GB100783@mtl-vdi-166.wap.labs.mlnx>
 <20210216152148.GA99540@mtl-vdi-166.wap.labs.mlnx>
 <88ecbbb6-a339-a5cd-82b7-387225a45d36@oracle.com>
From: Jason Wang <jasowang@redhat.com>
Message-ID: <27c7858e-67a4-9f22-37e3-f527f1dd85a6@redhat.com>
Date: Thu, 18 Feb 2021 14:37:10 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <88ecbbb6-a339-a5cd-82b7-387225a45d36@oracle.com>
Content-Language: en-US
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
Cc: netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
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

Ck9uIDIwMjEvMi8xOCDkuIrljYg1OjU1LCBTaS1XZWkgTGl1IHdyb3RlOgo+Cj4KPiBPbiAyLzE2
LzIwMjEgNzoyMSBBTSwgRWxpIENvaGVuIHdyb3RlOgo+PiBPbiBUaHUsIEZlYiAxMSwgMjAyMSBh
dCAwOTozMzoxNEFNICswMjAwLCBFbGkgQ29oZW4gd3JvdGU6Cj4+PiBPbiBXZWQsIEZlYiAxMCwg
MjAyMSBhdCAwMTo0ODowMFBNIC0wODAwLCBTaS1XZWkgTGl1IHdyb3RlOgo+Pj4+IFdoaWxlIHZp
cnRxIGlzIHN0b3BwZWQswqAgZ2V0X3ZxX3N0YXRlKCkgaXMgc3VwcG9zZWQgdG8KPj4+PiBiZcKg
IGNhbGxlZCB0b8KgIGdldMKgIHN5bmMnZWTCoCB3aXRowqAgdGhlIGxhdGVzdCBpbnRlcm5hbAo+
Pj4+IGF2YWlsX2luZGV4IGZyb20gZGV2aWNlLiBUaGUgc2F2ZWQgYXZhaWxfaW5kZXggaXMgdXNl
ZAo+Pj4+IHRvIHJlc3RhdGXCoCB0aGUgdmlydHHCoCBvbmNlIGRldmljZSBpcyBzdGFydGVkLsKg
IENvbW1pdAo+Pj4+IGIzNWNjZWJlM2VmNyBpbnRyb2R1Y2VkIHRoZSBjbGVhcl92aXJ0cXVldWVz
KCkgcm91dGluZQo+Pj4+IHRvwqAgcmVzZXTCoCB0aGUgc2F2ZWTCoCBhdmFpbF9pbmRleCzCoCBo
b3dldmVyLCB0aGUgaW5kZXgKPj4+PiBnZXRzIGNsZWFyZWQgYSBiaXQgZWFybGllciBiZWZvcmUg
Z2V0X3ZxX3N0YXRlKCkgdHJpZXMKPj4+PiB0byByZWFkIGl0LiBUaGlzIHdvdWxkIGNhdXNlIGNv
bnNpc3RlbmN5IHByb2JsZW1zIHdoZW4KPj4+PiB2aXJ0cSBpcyByZXN0YXJ0ZWQsIGUuZy4gdGhy
b3VnaCBhIHNlcmllcyBvZiBsaW5rIGRvd24KPj4+PiBhbmQgbGluayB1cCBldmVudHMuIFdlwqAg
Y291bGTCoCBkZWZlcsKgIHRoZcKgIGNsZWFyaW5nIG9mCj4+Pj4gYXZhaWxfaW5kZXjCoCB0b8Kg
IHVudGlswqAgdGhlwqAgZGV2aWNlwqAgaXMgdG8gYmUgc3RhcnRlZCwKPj4+PiBpLmUuIHVudGls
wqAgVklSVElPX0NPTkZJR19TX0RSSVZFUl9PS8KgIGlzIHNldCBhZ2FpbiBpbgo+Pj4+IHNldF9z
dGF0dXMoKS4KPj4+Pgo+Pj4+IEZpeGVzOiBiMzVjY2ViZTNlZjcgKCJ2ZHBhL21seDU6IFJlc3Rv
cmUgdGhlIGhhcmR3YXJlIHVzZWQgaW5kZXggCj4+Pj4gYWZ0ZXIgY2hhbmdlIG1hcCIpCj4+Pj4g
U2lnbmVkLW9mZi1ieTogU2ktV2VpIExpdSA8c2ktd2VpLmxpdUBvcmFjbGUuY29tPgo+Pj4+IEFj
a2VkLWJ5OiBKYXNvbiBXYW5nIDxqYXNvd2FuZ0ByZWRoYXQuY29tPgo+Pj4gQWNrZWQtYnk6IEVs
aSBDb2hlbiA8ZWxpY0BudmlkaWEuY29tPgo+Pj4KPj4gSSB0YWtlIGl0IGJhY2suIEkgdGhpbmsg
d2UgZG9uJ3QgbmVlZCB0byBjbGVhciB0aGUgaW5kZXhlcyBhdCBhbGwuIEluCj4+IGNhc2Ugd2Ug
bmVlZCB0byByZXN0b3JlIGluZGV4ZXMgd2UnbGwgZ2V0IHRoZSByaWdodCB2YWx1ZXMgdGhyb3Vn
aAo+PiBzZXRfdnFfc3RhdGUoKS4gSWYgd2Ugc3VzcGVuZCB0aGUgdmlydHF1ZXVlIGR1ZSB0byBW
TSBiZWluZyBzdXNwZW5kZWQsCj4+IHFlbXUgd2lsbCBxdWVyeSBmaXJzdCBhbmQgd2lsbCBwcm92
aWRlIHRoZSB0aGUgcXVlcmllZCB2YWx1ZS4gSW4gY2FzZSBvZgo+PiBWTSByZWJvb3QsIGl0IHdp
bGwgcHJvdmlkZSAwIGluIHNldF92cV9zdGF0ZSgpLgo+Pgo+PiBJIGFtIHNlbmRpbmcgYSBwYXRj
aCB0aGF0IGFkZHJlc3NlcyBib3RoIHJlYm9vdCBhbmQgc3VzcGVuZC4KPiBXaXRoIHNldF92cV9z
dGF0ZSgpIHJlcHVycG9zZWQgdG8gcmVzdG9yaW5nIHVzZWRfaW5kZXggSSdtIGZpbmUgd2l0aCAK
PiB0aGlzIGFwcHJvYWNoLgo+Cj4gRG8gSSBoYXZlIHRvIHJlcG9zdCBhIHYzIG9mIHRoaXMgc2Vy
aWVzIHdoaWxlIGRyb3BwaW5nIHRoZSAzcmQgcGF0Y2g/Cj4KPiAtU2l3ZWkgCgoKWWVzLCBwbGVh
c2UuCgpUaGFua3MKCgpfX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fXwpWaXJ0dWFsaXphdGlvbiBtYWlsaW5nIGxpc3QKVmlydHVhbGl6YXRpb25AbGlzdHMubGlu
dXgtZm91bmRhdGlvbi5vcmcKaHR0cHM6Ly9saXN0cy5saW51eGZvdW5kYXRpb24ub3JnL21haWxt
YW4vbGlzdGluZm8vdmlydHVhbGl6YXRpb24=
