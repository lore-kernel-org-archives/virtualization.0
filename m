Return-Path: <SRS0=ow7J=HD=lists.linux-foundation.org=virtualization-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.1 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 63B1BC433E0
	for <virtualization@archiver.kernel.org>; Mon,  1 Feb 2021 06:11:04 +0000 (UTC)
Received: from hemlock.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B856264E2F
	for <virtualization@archiver.kernel.org>; Mon,  1 Feb 2021 06:11:03 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B856264E2F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=virtualization-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by hemlock.osuosl.org (Postfix) with ESMTP id 623EB86F63;
	Mon,  1 Feb 2021 06:11:03 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from hemlock.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id JOlQWEH2gf-r; Mon,  1 Feb 2021 06:11:00 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by hemlock.osuosl.org (Postfix) with ESMTP id 9B0BF86F5F;
	Mon,  1 Feb 2021 06:11:00 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 7CCF6C0FA7;
	Mon,  1 Feb 2021 06:11:00 +0000 (UTC)
Received: from whitealder.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 29B2FC013A
 for <virtualization@lists.linux-foundation.org>;
 Mon,  1 Feb 2021 06:10:59 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by whitealder.osuosl.org (Postfix) with ESMTP id 0DD4D865A1
 for <virtualization@lists.linux-foundation.org>;
 Mon,  1 Feb 2021 06:10:59 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from whitealder.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id ctixh-Zh8LO2
 for <virtualization@lists.linux-foundation.org>;
 Mon,  1 Feb 2021 06:10:58 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [216.205.24.124])
 by whitealder.osuosl.org (Postfix) with ESMTPS id 5D21D8657C
 for <virtualization@lists.linux-foundation.org>;
 Mon,  1 Feb 2021 06:10:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1612159857;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=Fmf3/F4bar93epA9jgT+XZRxFS/bi7T0OzcismX32KQ=;
 b=HdiGMX5/+V7mnEJqMaWRxziFggGQvT63+TIoDl7g028JhBxGBq52G1xXYkD4x+YvmgzhCS
 kX525T+bhxkW+yhA6sJURc7Z75UckYUOsmCCJbsXa7/BZd9ohtD6YdC0zzjtN45C+6qnL+
 Ee3dhWH9nSs5+Rt1vz0jTKOEAkrsDlc=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-43-Ndapx0jlNLWAIfVCrybtsA-1; Mon, 01 Feb 2021 01:10:55 -0500
X-MC-Unique: Ndapx0jlNLWAIfVCrybtsA-1
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com
 [10.5.11.14])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id A8BB0190D344;
 Mon,  1 Feb 2021 06:10:53 +0000 (UTC)
Received: from [10.72.13.120] (ovpn-13-120.pek2.redhat.com [10.72.13.120])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 9874E5D9DC;
 Mon,  1 Feb 2021 06:10:41 +0000 (UTC)
Subject: Re: [RFC 03/10] virtio: Add virtio_queue_get_idx
To: =?UTF-8?Q?Eugenio_P=c3=a9rez?= <eperezma@redhat.com>, qemu-devel@nongnu.org
References: <20210129205415.876290-1-eperezma@redhat.com>
 <20210129205415.876290-4-eperezma@redhat.com>
From: Jason Wang <jasowang@redhat.com>
Message-ID: <f440260b-d970-548f-8d0d-5e3deb403773@redhat.com>
Date: Mon, 1 Feb 2021 14:10:39 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <20210129205415.876290-4-eperezma@redhat.com>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
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
Y2x1ZGUvaHcvdmlydGlvL3ZpcnRpby5oIHwgMiArKwo+ICAgaHcvdmlydGlvL3ZpcnRpby5jICAg
ICAgICAgfCA1ICsrKysrCj4gICAyIGZpbGVzIGNoYW5nZWQsIDcgaW5zZXJ0aW9ucygrKQo+Cj4g
ZGlmZiAtLWdpdCBhL2luY2x1ZGUvaHcvdmlydGlvL3ZpcnRpby5oIGIvaW5jbHVkZS9ody92aXJ0
aW8vdmlydGlvLmgKPiBpbmRleCA5OTg4YzZkNWM5Li45MDEzYzAzNDI0IDEwMDY0NAo+IC0tLSBh
L2luY2x1ZGUvaHcvdmlydGlvL3ZpcnRpby5oCj4gKysrIGIvaW5jbHVkZS9ody92aXJ0aW8vdmly
dGlvLmgKPiBAQCAtMzk5LDYgKzM5OSw4IEBAIHN0YXRpYyBpbmxpbmUgYm9vbCB2aXJ0aW9fZGV2
aWNlX2Rpc2FibGVkKFZpcnRJT0RldmljZSAqdmRldikKPiAgICAgICByZXR1cm4gdW5saWtlbHko
dmRldi0+ZGlzYWJsZWQgfHwgdmRldi0+YnJva2VuKTsKPiAgIH0KPiAgIAo+ICt1bnNpZ25lZCB2
aXJ0aW9fcXVldWVfZ2V0X2lkeChjb25zdCBWaXJ0SU9EZXZpY2UgKnZkZXYsIGNvbnN0IFZpcnRR
dWV1ZSAqdnEpOwo+ICsKPiAgIGJvb2wgdmlydGlvX2xlZ2FjeV9hbGxvd2VkKFZpcnRJT0Rldmlj
ZSAqdmRldik7Cj4gICBib29sIHZpcnRpb19sZWdhY3lfY2hlY2tfZGlzYWJsZWQoVmlydElPRGV2
aWNlICp2ZGV2KTsKPiAgIAo+IGRpZmYgLS1naXQgYS9ody92aXJ0aW8vdmlydGlvLmMgYi9ody92
aXJ0aW8vdmlydGlvLmMKPiBpbmRleCBlYmI3ODBmYjQyLi4zZDE0YjBlZjc0IDEwMDY0NAo+IC0t
LSBhL2h3L3ZpcnRpby92aXJ0aW8uYwo+ICsrKyBiL2h3L3ZpcnRpby92aXJ0aW8uYwo+IEBAIC01
MDAsNiArNTAwLDExIEBAIHZvaWQgdmlydGlvX3F1ZXVlX3NldF9ub3RpZmljYXRpb24oVmlydFF1
ZXVlICp2cSwgaW50IGVuYWJsZSkKPiAgICAgICB9Cj4gICB9Cj4gICAKPiArdW5zaWduZWQgdmly
dGlvX3F1ZXVlX2dldF9pZHgoY29uc3QgVmlydElPRGV2aWNlICp2ZGV2LCBjb25zdCBWaXJ0UXVl
dWUgKnZxKQo+ICt7Cj4gKyAgICByZXR1cm4gdnEgLSB2ZGV2LT52cTsKPiArfQoKCkl0IGxvb2tz
IHRvIG1lIHdlIGhhZCBhIGRlZGljYXRlZCBpbmRleCBzdG9yZWQgaW4gVmlydFF1ZXVlOiAKdnEt
PnF1ZXVlX2luZGV4LgoKVGhhbmtzCgoKPiArCj4gICBpbnQgdmlydGlvX3F1ZXVlX3JlYWR5KFZp
cnRRdWV1ZSAqdnEpCj4gICB7Cj4gICAgICAgcmV0dXJuIHZxLT52cmluZy5hdmFpbCAhPSAwOwoK
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18KVmlydHVhbGl6
YXRpb24gbWFpbGluZyBsaXN0ClZpcnR1YWxpemF0aW9uQGxpc3RzLmxpbnV4LWZvdW5kYXRpb24u
b3JnCmh0dHBzOi8vbGlzdHMubGludXhmb3VuZGF0aW9uLm9yZy9tYWlsbWFuL2xpc3RpbmZvL3Zp
cnR1YWxpemF0aW9u
