Return-Path: <SRS0=AmYR=HG=lists.linux-foundation.org=virtualization-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 74A49C433DB
	for <virtualization@archiver.kernel.org>; Thu,  4 Feb 2021 12:16:24 +0000 (UTC)
Received: from whitealder.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D0A5A64F39
	for <virtualization@archiver.kernel.org>; Thu,  4 Feb 2021 12:16:23 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D0A5A64F39
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=virtualization-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by whitealder.osuosl.org (Postfix) with ESMTP id 77BCC86AF0;
	Thu,  4 Feb 2021 12:16:23 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from whitealder.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id 1Y41YH1p5VHL; Thu,  4 Feb 2021 12:16:22 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by whitealder.osuosl.org (Postfix) with ESMTP id 2758286ACD;
	Thu,  4 Feb 2021 12:16:22 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id DB5B1C0174;
	Thu,  4 Feb 2021 12:16:21 +0000 (UTC)
Received: from whitealder.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 3F0B5C013A
 for <virtualization@lists.linux-foundation.org>;
 Thu,  4 Feb 2021 12:16:20 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by whitealder.osuosl.org (Postfix) with ESMTP id 2E23586AF0
 for <virtualization@lists.linux-foundation.org>;
 Thu,  4 Feb 2021 12:16:20 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from whitealder.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id iiSeMGTWwW6h
 for <virtualization@lists.linux-foundation.org>;
 Thu,  4 Feb 2021 12:16:18 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [63.128.21.124])
 by whitealder.osuosl.org (Postfix) with ESMTPS id 16DA186ACD
 for <virtualization@lists.linux-foundation.org>;
 Thu,  4 Feb 2021 12:16:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1612440976;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=ZLjX9hzFEvNLdffyS6lE3UIqKKEcNIyzWScy5mwql9c=;
 b=Ai49GfT2cgmMOLHDrQ8FcGpMla8q+p7e5LAfysxA9A1BW/nwm+UbLBz0C+xZ+kn3g5i+i0
 2547x26L7uPSk/8B2o7P/0ZT0rJjjy8DvNmPJO7YP4DtyuqgOLUf0FY5gisfZe6TMfistQ
 BVJx6foAMXdPmtvyuRzP4Hi+Bz91qpc=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-300-aOzyxub9MPuoDIRSekBQaw-1; Thu, 04 Feb 2021 07:16:13 -0500
X-MC-Unique: aOzyxub9MPuoDIRSekBQaw-1
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com
 [10.5.11.15])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 5A6FF1020C2C;
 Thu,  4 Feb 2021 12:16:11 +0000 (UTC)
Received: from blackfin.pond.sub.org (ovpn-115-51.ams2.redhat.com
 [10.36.115.51])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 68FA65D6D7;
 Thu,  4 Feb 2021 12:16:04 +0000 (UTC)
Received: by blackfin.pond.sub.org (Postfix, from userid 1000)
 id EC6DD113865F; Thu,  4 Feb 2021 13:16:02 +0100 (CET)
From: Markus Armbruster <armbru@redhat.com>
To: Eugenio Perez Martin <eperezma@redhat.com>
Subject: Re: [RFC 08/10] vhost: Add x-vhost-enable-shadow-vq qmp
References: <20210129205415.876290-1-eperezma@redhat.com>
 <20210129205415.876290-9-eperezma@redhat.com>
 <4ab76cf6-401b-97de-6154-2e025cb1ebc6@redhat.com>
 <CAJaqyWc5_nmniTDsjCCpJpERvMq5RsB0xebeNuP8=oVnHQkovg@mail.gmail.com>
Date: Thu, 04 Feb 2021 13:16:02 +0100
In-Reply-To: <CAJaqyWc5_nmniTDsjCCpJpERvMq5RsB0xebeNuP8=oVnHQkovg@mail.gmail.com>
 (Eugenio Perez Martin's message of "Thu, 4 Feb 2021 10:01:09 +0100")
Message-ID: <87v9b8hvul.fsf@dusky.pond.sub.org>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.1 (gnu/linux)
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=armbru@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Cc: Parav Pandit <parav@mellanox.com>, "Michael S. Tsirkin" <mst@redhat.com>,
 qemu-level <qemu-devel@nongnu.org>, virtualization@lists.linux-foundation.org,
 Harpreet Singh Anand <hanand@xilinx.com>, Xiao W Wang <xiao.w.wang@intel.com>,
 Stefan Hajnoczi <stefanha@redhat.com>, Eli Cohen <eli@mellanox.com>,
 Rob Miller <rob.miller@broadcom.com>, Eric Blake <eblake@redhat.com>,
 Michael Lilja <ml@napatech.com>, Jim Harford <jim.harford@broadcom.com>
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

RXVnZW5pbyBQZXJleiBNYXJ0aW4gPGVwZXJlem1hQHJlZGhhdC5jb20+IHdyaXRlczoKCj4gT24g
VHVlLCBGZWIgMiwgMjAyMSBhdCA0OjM4IFBNIEVyaWMgQmxha2UgPGVibGFrZUByZWRoYXQuY29t
PiB3cm90ZToKPj4KPj4gT24gMS8yOS8yMSAyOjU0IFBNLCBFdWdlbmlvIFDDqXJleiB3cm90ZToK
Wy4uLl0KPj4gPiBkaWZmIC0tZ2l0IGEvaHcvdmlydGlvL3Zob3N0LmMgYi9ody92aXJ0aW8vdmhv
c3QuYwo+PiA+IGluZGV4IDA0MGY2OGZmMmUuLjQyODM2ZTQ1ZjMgMTAwNjQ0Cj4+ID4gLS0tIGEv
aHcvdmlydGlvL3Zob3N0LmMKPj4gPiArKysgYi9ody92aXJ0aW8vdmhvc3QuYwo+PiA+IEBAIC0x
NSw2ICsxNSw3IEBACj4+ID4KPj4gPiAgI2luY2x1ZGUgInFlbXUvb3NkZXAuaCIKPj4gPiAgI2lu
Y2x1ZGUgInFhcGkvZXJyb3IuaCIKPj4gPiArI2luY2x1ZGUgInFhcGkvcWFwaS1jb21tYW5kcy1u
ZXQuaCIKPj4gPiAgI2luY2x1ZGUgImh3L3ZpcnRpby92aG9zdC5oIgo+PiA+ICAjaW5jbHVkZSAi
cWVtdS9hdG9taWMuaCIKPj4gPiAgI2luY2x1ZGUgInFlbXUvcmFuZ2UuaCIKPj4gPiBAQCAtMTg0
MSwzICsxODQyLDggQEAgaW50IHZob3N0X25ldF9zZXRfYmFja2VuZChzdHJ1Y3Qgdmhvc3RfZGV2
ICpoZGV2LAo+PiA+Cj4+ID4gICAgICByZXR1cm4gLTE7Cj4+ID4gIH0KPj4gPiArCj4+ID4gK3Zv
aWQgcW1wX3hfdmhvc3RfZW5hYmxlX3NoYWRvd192cShjb25zdCBjaGFyICpuYW1lLCBib29sIGVu
YWJsZSwgRXJyb3IgKiplcnJwKQo+PiA+ICt7Cj4+ID4gKyAgICBlcnJvcl9zZXRnKGVycnAsICJT
aGFkb3cgdmlydHF1ZXVlIHN0aWxsIG5vdCBpbXBsZW1lbnRlZC4iKTsKPj4KPj4gZXJyb3Jfc2V0
ZygpIHNob3VsZCBub3QgYmUgcGFzc2VkIGEgdHJhaWxpbmcgJy4nLgo+Pgo+Cj4gT2gsIHNvcnJ5
IEkgbWlzc2VkIHRoZSBjb21tZW50IGluIHRoZSBlcnJvcl9zZXRnIGRvYy4KPgo+IEkgY29weSZw
YXN0ZWQgZnJvbSB0aGUgY2FsbCB0byBlcnJvcl9zZXRnICJNaWdyYXRpb24gZGlzYWJsZWQ6IHZo
b3N0Cj4gbGFja3MgVkhPU1RfRl9MT0dfQUxMIGZlYXR1cmUuIi4gSSdtIHdvbmRlcmluZyBpZiBp
dCdzIGEgZ29vZCBtb21lbnQKPiB0byBkZWxldGUgdGhlIGRvdCB0aGVyZSB0b28sIHNpbmNlIG90
aGVyIHRvb2xzIGNvdWxkIGRlcGVuZCBvbiBwYXJzaW5nCj4gaXQuCgpJdCdzIHByZXR0eSBtdWNo
IGFsd2F5cyBhIGdvb2QgbW9tZW50IGZvciBwYXRjaGVzIGltcHJvdmluZyBlcnJvcgptZXNzYWdl
cyA6KQoKX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18KVmly
dHVhbGl6YXRpb24gbWFpbGluZyBsaXN0ClZpcnR1YWxpemF0aW9uQGxpc3RzLmxpbnV4LWZvdW5k
YXRpb24ub3JnCmh0dHBzOi8vbGlzdHMubGludXhmb3VuZGF0aW9uLm9yZy9tYWlsbWFuL2xpc3Rp
bmZvL3ZpcnR1YWxpemF0aW9u
