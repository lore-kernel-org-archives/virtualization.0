Return-Path: <SRS0=DeSX=HE=lists.linux-foundation.org=virtualization-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.1 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2CB0EC433DB
	for <virtualization@archiver.kernel.org>; Tue,  2 Feb 2021 03:32:04 +0000 (UTC)
Received: from fraxinus.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 9F3D964ECB
	for <virtualization@archiver.kernel.org>; Tue,  2 Feb 2021 03:32:03 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9F3D964ECB
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=virtualization-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by fraxinus.osuosl.org (Postfix) with ESMTP id 0F54585623;
	Tue,  2 Feb 2021 03:32:03 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from fraxinus.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id NP64QgyaH_S4; Tue,  2 Feb 2021 03:32:00 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by fraxinus.osuosl.org (Postfix) with ESMTP id 50A3C844EC;
	Tue,  2 Feb 2021 03:32:00 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 31797C0174;
	Tue,  2 Feb 2021 03:32:00 +0000 (UTC)
Received: from hemlock.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by lists.linuxfoundation.org (Postfix) with ESMTP id CB270C013A
 for <virtualization@lists.linux-foundation.org>;
 Tue,  2 Feb 2021 03:31:58 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by hemlock.osuosl.org (Postfix) with ESMTP id B2B468703C
 for <virtualization@lists.linux-foundation.org>;
 Tue,  2 Feb 2021 03:31:58 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from hemlock.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id VMrbw-PJyHYq
 for <virtualization@lists.linux-foundation.org>;
 Tue,  2 Feb 2021 03:31:57 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [63.128.21.124])
 by hemlock.osuosl.org (Postfix) with ESMTPS id 7A07B86F96
 for <virtualization@lists.linux-foundation.org>;
 Tue,  2 Feb 2021 03:31:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1612236716;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=gQIaC/6N6XguIN/SznE2uYlZJ2wGKyYc7ztmCAQIQxU=;
 b=gMhZp7Rds1TTKJ01mdlhIyyy7dkh4xiFb39kSvFrqr75Rpk52oxuZVOhYJWXjQ6w0egl3M
 dziHh9drDkFGIGCbiMFmE/i9GKeoPAUanzLKZzY3NBnVfV4SV1G9dqTqBvTB1sgvLauhdu
 wlXMDtoPI537aFl1TyzsYb0sRmuZVn8=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-526-Fk8lPo25OsiKYCXn-FbwMw-1; Mon, 01 Feb 2021 22:31:52 -0500
X-MC-Unique: Fk8lPo25OsiKYCXn-FbwMw-1
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com
 [10.5.11.13])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 727641005504;
 Tue,  2 Feb 2021 03:31:50 +0000 (UTC)
Received: from [10.72.13.250] (ovpn-13-250.pek2.redhat.com [10.72.13.250])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 18E1E6EF4F;
 Tue,  2 Feb 2021 03:31:39 +0000 (UTC)
Subject: Re: [RFC 05/10] vhost: Add vhost_dev_from_virtio
To: Eugenio Perez Martin <eperezma@redhat.com>
References: <20210129205415.876290-1-eperezma@redhat.com>
 <20210129205415.876290-6-eperezma@redhat.com>
 <acf16fd6-2282-c220-e642-0868ac839b70@redhat.com>
 <CAJaqyWeRK_i3MMZVgXJUwUNfLaq_h80jChZfQ3sRmWAcQnGLkQ@mail.gmail.com>
From: Jason Wang <jasowang@redhat.com>
Message-ID: <a526b3ac-91d9-28e6-5ffc-2308aab4fbd6@redhat.com>
Date: Tue, 2 Feb 2021 11:31:38 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <CAJaqyWeRK_i3MMZVgXJUwUNfLaq_h80jChZfQ3sRmWAcQnGLkQ@mail.gmail.com>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=jasowang@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Language: en-US
Cc: Parav Pandit <parav@mellanox.com>, "Michael S. Tsirkin" <mst@redhat.com>,
 qemu-level <qemu-devel@nongnu.org>, Harpreet Singh Anand <hanand@xilinx.com>,
 Xiao W Wang <xiao.w.wang@intel.com>, Stefan Hajnoczi <stefanha@redhat.com>,
 Eli Cohen <eli@mellanox.com>, virtualization@lists.linux-foundation.org,
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

Ck9uIDIwMjEvMi8xIOS4i+WNiDQ6MjgsIEV1Z2VuaW8gUGVyZXogTWFydGluIHdyb3RlOgo+IE9u
IE1vbiwgRmViIDEsIDIwMjEgYXQgNzoxMyBBTSBKYXNvbiBXYW5nIDxqYXNvd2FuZ0ByZWRoYXQu
Y29tPiB3cm90ZToKPj4KPj4gT24gMjAyMS8xLzMwIOS4iuWNiDQ6NTQsIEV1Z2VuaW8gUMOpcmV6
IHdyb3RlOgo+Pj4gU2lnbmVkLW9mZi1ieTogRXVnZW5pbyBQw6lyZXogPGVwZXJlem1hQHJlZGhh
dC5jb20+Cj4+PiAtLS0KPj4+ICAgIGluY2x1ZGUvaHcvdmlydGlvL3Zob3N0LmggfCAgMSArCj4+
PiAgICBody92aXJ0aW8vdmhvc3QuYyAgICAgICAgIHwgMTcgKysrKysrKysrKysrKysrKysKPj4+
ICAgIDIgZmlsZXMgY2hhbmdlZCwgMTggaW5zZXJ0aW9ucygrKQo+Pj4KPj4+IGRpZmYgLS1naXQg
YS9pbmNsdWRlL2h3L3ZpcnRpby92aG9zdC5oIGIvaW5jbHVkZS9ody92aXJ0aW8vdmhvc3QuaAo+
Pj4gaW5kZXggNGE4YmM3NTQxNS4uZmNhMDc2ZTNmMCAxMDA2NDQKPj4+IC0tLSBhL2luY2x1ZGUv
aHcvdmlydGlvL3Zob3N0LmgKPj4+ICsrKyBiL2luY2x1ZGUvaHcvdmlydGlvL3Zob3N0LmgKPj4+
IEBAIC0xMjMsNiArMTIzLDcgQEAgdWludDY0X3Qgdmhvc3RfZ2V0X2ZlYXR1cmVzKHN0cnVjdCB2
aG9zdF9kZXYgKmhkZXYsIGNvbnN0IGludCAqZmVhdHVyZV9iaXRzLAo+Pj4gICAgdm9pZCB2aG9z
dF9hY2tfZmVhdHVyZXMoc3RydWN0IHZob3N0X2RldiAqaGRldiwgY29uc3QgaW50ICpmZWF0dXJl
X2JpdHMsCj4+PiAgICAgICAgICAgICAgICAgICAgICAgICAgICB1aW50NjRfdCBmZWF0dXJlcyk7
Cj4+PiAgICBib29sIHZob3N0X2hhc19mcmVlX3Nsb3Qodm9pZCk7Cj4+PiArc3RydWN0IHZob3N0
X2RldiAqdmhvc3RfZGV2X2Zyb21fdmlydGlvKGNvbnN0IFZpcnRJT0RldmljZSAqdmRldik7Cj4+
Pgo+Pj4gICAgaW50IHZob3N0X25ldF9zZXRfYmFja2VuZChzdHJ1Y3Qgdmhvc3RfZGV2ICpoZGV2
LAo+Pj4gICAgICAgICAgICAgICAgICAgICAgICAgICAgICBzdHJ1Y3Qgdmhvc3RfdnJpbmdfZmls
ZSAqZmlsZSk7Cj4+PiBkaWZmIC0tZ2l0IGEvaHcvdmlydGlvL3Zob3N0LmMgYi9ody92aXJ0aW8v
dmhvc3QuYwo+Pj4gaW5kZXggMjhjN2Q3ODE3Mi4uODY4M2Q1MDdmNSAxMDA2NDQKPj4+IC0tLSBh
L2h3L3ZpcnRpby92aG9zdC5jCj4+PiArKysgYi9ody92aXJ0aW8vdmhvc3QuYwo+Pj4gQEAgLTYx
LDYgKzYxLDIzIEBAIGJvb2wgdmhvc3RfaGFzX2ZyZWVfc2xvdCh2b2lkKQo+Pj4gICAgICAgIHJl
dHVybiBzbG90c19saW1pdCA+IHVzZWRfbWVtc2xvdHM7Cj4+PiAgICB9Cj4+Pgo+Pj4gKy8qCj4+
PiArICogR2V0IHRoZSB2aG9zdCBkZXZpY2UgYXNzb2NpYXRlZCB0byBhIFZpcnRJTyBkZXZpY2Uu
Cj4+PiArICovCj4+PiArc3RydWN0IHZob3N0X2RldiAqdmhvc3RfZGV2X2Zyb21fdmlydGlvKGNv
bnN0IFZpcnRJT0RldmljZSAqdmRldikKPj4+ICt7Cj4+PiArICAgIHN0cnVjdCB2aG9zdF9kZXYg
KmhkZXY7Cj4+PiArCj4+PiArICAgIFFMSVNUX0ZPUkVBQ0goaGRldiwgJnZob3N0X2RldmljZXMs
IGVudHJ5KSB7Cj4+PiArICAgICAgICBpZiAoaGRldi0+dmRldiA9PSB2ZGV2KSB7Cj4+PiArICAg
ICAgICAgICAgcmV0dXJuIGhkZXY7Cj4+PiArICAgICAgICB9Cj4+PiArICAgIH0KPj4+ICsKPj4+
ICsgICAgYXNzZXJ0KGhkZXYpOwo+Pj4gKyAgICByZXR1cm4gTlVMTDsKPj4+ICt9Cj4+Cj4+IEkn
bSBub3Qgc3VyZSB0aGlzIGNhbiB3b3JrIGluIHRoZSBjYXNlIG9mIG11bHRpcXVldWUuIEUuZyB2
aG9zdC1uZXQKPj4gbXVsdGlxdWV1ZSBpcyBhIE46MSBtYXBwaW5nIGJldHdlZW4gdmhvc3QgZGV2
aWNzIGFuZCB2aXJ0aW8gZGV2aWNlcy4KPj4KPj4gVGhhbmtzCj4+Cj4gUmlnaHQuIFdlIGNvdWxk
IGFkZCBhbiAidmRldiB2cSBpbmRleCIgcGFyYW1ldGVyIHRvIHRoZSBmdW5jdGlvbiBpbgo+IHRo
aXMgY2FzZSwgYnV0IEkgZ3Vlc3MgdGhlIG1vc3QgcmVsaWFibGUgd2F5IHRvIGRvIHRoaXMgaXMg
dG8gYWRkIGEKPiB2aG9zdF9vcGFxdWUgdmFsdWUgdG8gVmlydFF1ZXVlLCBhcyBTdGVmYW4gcHJv
cG9zZWQgaW4gcHJldmlvdXMgUkZDLgoKClNvIHRoZSBxdWVzdGlvbiBzdGlsbCwgaXQgbG9va3Mg
bGlrZSBpdCdzIGVhc2llciB0byBoaWRlIHRoZSBzaGFkb3cgCnZpcnRxdWV1ZSBzdHVmZnMgYXQg
dmhvc3QgbGF5ZXIgaW5zdGVhZCBvZiBleHBvc2UgdGhlbSB0byB2aXJ0aW8gbGF5ZXI6CgoxKSB2
aG9zdCBwcm90b2NvbCBpcyBzdGFibGUgQUJJCjIpIG5vIG5lZWQgdG8gZGVhbCB3aXRoIHZpcnRp
byBzdHVmZnMgd2hpY2ggaXMgbW9yZSBjb21wbGV4IHRoYW4gdmhvc3QKCk9yIGFyZSB0aGVyZSBh
bnkgYWR2YW50YWdlcyBpZiB3ZSBkbyBpdCBhdCB2aXJ0aW8gbGF5ZXI/CgpUaGFua3MKCgo+Cj4g
SSBuZWVkIHRvIHRha2UgdGhpcyBpbnRvIGFjY291bnQgaW4gcW1wX3hfdmhvc3RfZW5hYmxlX3No
YWRvd192cSB0b28uCj4KPj4+ICsKPj4+ICAgIHN0YXRpYyB2b2lkIHZob3N0X2Rldl9zeW5jX3Jl
Z2lvbihzdHJ1Y3Qgdmhvc3RfZGV2ICpkZXYsCj4+PiAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgTWVtb3J5UmVnaW9uU2VjdGlvbiAqc2VjdGlvbiwKPj4+ICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICB1aW50NjRfdCBtZmlyc3QsIHVpbnQ2NF90IG1sYXN0
LAoKX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18KVmlydHVh
bGl6YXRpb24gbWFpbGluZyBsaXN0ClZpcnR1YWxpemF0aW9uQGxpc3RzLmxpbnV4LWZvdW5kYXRp
b24ub3JnCmh0dHBzOi8vbGlzdHMubGludXhmb3VuZGF0aW9uLm9yZy9tYWlsbWFuL2xpc3RpbmZv
L3ZpcnR1YWxpemF0aW9u
