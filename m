Return-Path: <SRS0=cXtE=IO=lists.linux-foundation.org=virtualization-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.1 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CFB49C433E0
	for <virtualization@archiver.kernel.org>; Tue, 16 Mar 2021 07:30:06 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 4A92F64FA7
	for <virtualization@archiver.kernel.org>; Tue, 16 Mar 2021 07:30:06 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4A92F64FA7
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=virtualization-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id E196F4BB06;
	Tue, 16 Mar 2021 07:30:05 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
	by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id 8OwTO_kMSVDr; Tue, 16 Mar 2021 07:30:04 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp4.osuosl.org (Postfix) with ESMTP id 4A42B4B158;
	Tue, 16 Mar 2021 07:30:04 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 1E179C000B;
	Tue, 16 Mar 2021 07:30:04 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [IPv6:2605:bc80:3010::133])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 0E3B3C000A
 for <virtualization@lists.linux-foundation.org>;
 Tue, 16 Mar 2021 07:30:03 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id EC15243011
 for <virtualization@lists.linux-foundation.org>;
 Tue, 16 Mar 2021 07:30:02 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp2.osuosl.org (amavisd-new);
 dkim=pass (1024-bit key) header.d=redhat.com
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id FA7Gwd4N0adG
 for <virtualization@lists.linux-foundation.org>;
 Tue, 16 Mar 2021 07:30:02 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [63.128.21.124])
 by smtp2.osuosl.org (Postfix) with ESMTPS id E82BF4300E
 for <virtualization@lists.linux-foundation.org>;
 Tue, 16 Mar 2021 07:30:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1615879800;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=sSlyGJ1kAW5aOpVvL6vcX8nwCsLGVy3lGUt4Uz5kIss=;
 b=GX+fM0LCJ8k9VMZRBtXY9aNl8lBLC7GfivIGEuqkLgu43323MuQ190SwoJLLiYeCap82jb
 Sp4Fxjpn8vJJUtRXrWHaKtG4Tv8IGzOKgIGUFViiAMwUKfHk0sWDxVJTj0vBSpqgQtbM4Q
 DbCreCkTfkMnM3nT3eGKHjdpI5hjsq8=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-512-gJ_iu-ZXM6aCy1JGv5LJFg-1; Tue, 16 Mar 2021 03:29:59 -0400
X-MC-Unique: gJ_iu-ZXM6aCy1JGv5LJFg-1
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com
 [10.5.11.14])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 74A6B1074664;
 Tue, 16 Mar 2021 07:29:57 +0000 (UTC)
Received: from wangxiaodeMacBook-Air.local (ovpn-12-216.pek2.redhat.com
 [10.72.12.216])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 5176E5D9D3;
 Tue, 16 Mar 2021 07:29:48 +0000 (UTC)
Subject: Re: [RFC v2 10/13] vhost: add vhost_kernel_set_vring_enable
To: =?UTF-8?Q?Eugenio_P=c3=a9rez?= <eperezma@redhat.com>, qemu-devel@nongnu.org
References: <20210315194842.277740-1-eperezma@redhat.com>
 <20210315194842.277740-11-eperezma@redhat.com>
From: Jason Wang <jasowang@redhat.com>
Message-ID: <98916095-ac78-7deb-5086-ee0adf39dcf5@redhat.com>
Date: Tue, 16 Mar 2021 15:29:45 +0800
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.16; rv:78.0)
 Gecko/20100101 Thunderbird/78.8.1
MIME-Version: 1.0
In-Reply-To: <20210315194842.277740-11-eperezma@redhat.com>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=jasowang@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Cc: Parav Pandit <parav@mellanox.com>, "Michael S. Tsirkin" <mst@redhat.com>,
 Guru Prasad <guru.prasad@broadcom.com>,
 virtualization@lists.linux-foundation.org,
 Harpreet Singh Anand <hanand@xilinx.com>, Xiao W Wang <xiao.w.wang@intel.com>,
 Eli Cohen <eli@mellanox.com>, Eric Blake <eblake@redhat.com>,
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
Content-Transfer-Encoding: base64
Content-Type: text/plain; charset="utf-8"; Format="flowed"
Errors-To: virtualization-bounces@lists.linux-foundation.org
Sender: "Virtualization" <virtualization-bounces@lists.linux-foundation.org>

CuWcqCAyMDIxLzMvMTYg5LiK5Y2IMzo0OCwgRXVnZW5pbyBQw6lyZXog5YaZ6YGTOgo+IFRoaXMg
bWV0aG9kIGlzIGFscmVhZHkgcHJlc2VudCBpbiB2aG9zdC11c2VyLiBUaGlzIGNvbW1pdCBhZGFw
dHMgaXQgdG8KPiB2aG9zdC1uZXQsIHNvIFNWUSBjYW4gdXNlLgo+Cj4gdmhvc3Rfa2VybmVsX3Nl
dF9lbmFibGUgc3RvcHMgdGhlIGRldmljZSwgc28gcWVtdSBjYW4gYXNrIGZvciBpdHMgc3RhdHVz
Cj4gKG5leHQgYXZhaWxhYmxlIGlkeCB0aGUgZGV2aWNlIHdhcyBnb2luZyB0byBjb25zdW1lKS4g
V2hlbiBTVlEgc3RhcnRzIGl0Cj4gY2FuIHJlc3VtZSBjb25zdW1pbmcgdGhlIGd1ZXN0J3MgZHJp
dmVyIHJpbmcsIHdpdGhvdXQgbm90aWNlIGZyb20gdGhlCj4gbGF0dGVyLiBOb3Qgc3RvcHBpbmcg
dGhlIGRldmljZSBiZWZvcmUgb2YgdGhlIHN3YXBwaW5nIGNvdWxkIGltcGx5IHRoYXQKPiBpdCBw
cm9jZXNzIG1vcmUgYnVmZmVycyB0aGFuIHJlcG9ydGVkLCB3aGF0IHdvdWxkIGR1cGxpY2F0ZSB0
aGUgZGV2aWNlCj4gYWN0aW9uLgoKCk5vdGUgdGhhdCBpdCBtaWdodCBub3QgYmUgdGhlIGNhc2Ug
b2YgdkRQQSAodmlydGlvKSBvciBhdCBsZWFzdCB2aXJ0aW8gCm5lZWRzIHNvbWUgZXh0ZW5zaW9u
IHRvIGFjaGlldmUgc29tZXRoaW5nIHNpbWlsYXIgbGlrZSB0aGlzLiBPbmUgZXhhbXBsZSAKaXMg
dmlydGlvLXBjaSB3aGljaCBmb3JiaWRzIDAgdG8gYmUgd3JvdGUgdG8gcXVldWVfZW5hYmxlLgoK
VGhpcyBpcyBhbm90aGVyIHJlYXNvbiB0byBzdGFydCBmcm9tIHZob3N0LXZEUEEuCgoKPgo+IFNp
Z25lZC1vZmYtYnk6IEV1Z2VuaW8gUMOpcmV6IDxlcGVyZXptYUByZWRoYXQuY29tPgo+IC0tLQo+
ICAgaHcvdmlydGlvL3Zob3N0LWJhY2tlbmQuYyB8IDI5ICsrKysrKysrKysrKysrKysrKysrKysr
KysrKysrCj4gICAxIGZpbGUgY2hhbmdlZCwgMjkgaW5zZXJ0aW9ucygrKQo+Cj4gZGlmZiAtLWdp
dCBhL2h3L3ZpcnRpby92aG9zdC1iYWNrZW5kLmMgYi9ody92aXJ0aW8vdmhvc3QtYmFja2VuZC5j
Cj4gaW5kZXggMzFiMzNiZGUzNy4uMWFjNWM1NzRhOSAxMDA2NDQKPiAtLS0gYS9ody92aXJ0aW8v
dmhvc3QtYmFja2VuZC5jCj4gKysrIGIvaHcvdmlydGlvL3Zob3N0LWJhY2tlbmQuYwo+IEBAIC0y
MDEsNiArMjAxLDM0IEBAIHN0YXRpYyBpbnQgdmhvc3Rfa2VybmVsX2dldF92cV9pbmRleChzdHJ1
Y3Qgdmhvc3RfZGV2ICpkZXYsIGludCBpZHgpCj4gICAgICAgcmV0dXJuIGlkeCAtIGRldi0+dnFf
aW5kZXg7Cj4gICB9Cj4gICAKPiArc3RhdGljIGludCB2aG9zdF9rZXJuZWxfc2V0X3ZxX2VuYWJs
ZShzdHJ1Y3Qgdmhvc3RfZGV2ICpkZXYsIHVuc2lnbmVkIGlkeCwKPiArICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICBib29sIGVuYWJsZSkKPiArewo+ICsgICAgc3RydWN0IHZo
b3N0X3ZyaW5nX2ZpbGUgZmlsZSA9IHsKPiArICAgICAgICAuaW5kZXggPSBpZHgsCj4gKyAgICB9
Owo+ICsKPiArICAgIGlmICghZW5hYmxlKSB7Cj4gKyAgICAgICAgZmlsZS5mZCA9IC0xOyAvKiBQ
YXNzIC0xIHRvIHVuYmluZCBmcm9tIGZpbGUuICovCj4gKyAgICB9IGVsc2Ugewo+ICsgICAgICAg
IHN0cnVjdCB2aG9zdF9uZXQgKnZuX2RldiA9IGNvbnRhaW5lcl9vZihkZXYsIHN0cnVjdCB2aG9z
dF9uZXQsIGRldik7Cj4gKyAgICAgICAgZmlsZS5mZCA9IHZuX2Rldi0+YmFja2VuZDsKCgpUaGlz
IGNhbiBvbmx5IHdvcmsgd2l0aCB2aG9zdC1uZXQgZGV2aWNlcyBidXQgbm90IHZzb2NrL3Njc2kg
ZXRjLgoKVGhhbmtzCgoKPiArICAgIH0KPiArCj4gKyAgICByZXR1cm4gdmhvc3Rfa2VybmVsX25l
dF9zZXRfYmFja2VuZChkZXYsICZmaWxlKTsKPiArfQo+ICsKPiArc3RhdGljIGludCB2aG9zdF9r
ZXJuZWxfc2V0X3ZyaW5nX2VuYWJsZShzdHJ1Y3Qgdmhvc3RfZGV2ICpkZXYsIGludCBlbmFibGUp
Cj4gK3sKPiArICAgIGludCBpOwo+ICsKPiArICAgIGZvciAoaSA9IDA7IGkgPCBkZXYtPm52cXM7
ICsraSkgewo+ICsgICAgICAgIHZob3N0X2tlcm5lbF9zZXRfdnFfZW5hYmxlKGRldiwgaSwgZW5h
YmxlKTsKPiArICAgIH0KPiArCj4gKyAgICByZXR1cm4gMDsKPiArfQo+ICsKPiAgICNpZmRlZiBD
T05GSUdfVkhPU1RfVlNPQ0sKPiAgIHN0YXRpYyBpbnQgdmhvc3Rfa2VybmVsX3Zzb2NrX3NldF9n
dWVzdF9jaWQoc3RydWN0IHZob3N0X2RldiAqZGV2LAo+ICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICB1aW50NjRfdCBndWVzdF9jaWQpCj4gQEAgLTMxNyw2ICsz
NDUsNyBAQCBzdGF0aWMgY29uc3QgVmhvc3RPcHMga2VybmVsX29wcyA9IHsKPiAgICAgICAgICAg
LnZob3N0X3NldF9vd25lciA9IHZob3N0X2tlcm5lbF9zZXRfb3duZXIsCj4gICAgICAgICAgIC52
aG9zdF9yZXNldF9kZXZpY2UgPSB2aG9zdF9rZXJuZWxfcmVzZXRfZGV2aWNlLAo+ICAgICAgICAg
ICAudmhvc3RfZ2V0X3ZxX2luZGV4ID0gdmhvc3Rfa2VybmVsX2dldF92cV9pbmRleCwKPiArICAg
ICAgICAudmhvc3Rfc2V0X3ZyaW5nX2VuYWJsZSA9IHZob3N0X2tlcm5lbF9zZXRfdnJpbmdfZW5h
YmxlLAo+ICAgI2lmZGVmIENPTkZJR19WSE9TVF9WU09DSwo+ICAgICAgICAgICAudmhvc3RfdnNv
Y2tfc2V0X2d1ZXN0X2NpZCA9IHZob3N0X2tlcm5lbF92c29ja19zZXRfZ3Vlc3RfY2lkLAo+ICAg
ICAgICAgICAudmhvc3RfdnNvY2tfc2V0X3J1bm5pbmcgPSB2aG9zdF9rZXJuZWxfdnNvY2tfc2V0
X3J1bm5pbmcsCgpfX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
XwpWaXJ0dWFsaXphdGlvbiBtYWlsaW5nIGxpc3QKVmlydHVhbGl6YXRpb25AbGlzdHMubGludXgt
Zm91bmRhdGlvbi5vcmcKaHR0cHM6Ly9saXN0cy5saW51eGZvdW5kYXRpb24ub3JnL21haWxtYW4v
bGlzdGluZm8vdmlydHVhbGl6YXRpb24=
