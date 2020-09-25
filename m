Return-Path: <SRS0=jbvZ=DC=lists.linux-foundation.org=virtualization-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CEE2DC4363D
	for <virtualization@archiver.kernel.org>; Fri, 25 Sep 2020 11:29:37 +0000 (UTC)
Received: from whitealder.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 770F220717
	for <virtualization@archiver.kernel.org>; Fri, 25 Sep 2020 11:29:37 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="g+403WKb"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 770F220717
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=virtualization-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by whitealder.osuosl.org (Postfix) with ESMTP id 2ED5B86DD5;
	Fri, 25 Sep 2020 11:29:37 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from whitealder.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id Kf5d7Tn+ipJZ; Fri, 25 Sep 2020 11:29:36 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by whitealder.osuosl.org (Postfix) with ESMTP id 6BD0186CE0;
	Fri, 25 Sep 2020 11:29:36 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 34EE1C0859;
	Fri, 25 Sep 2020 11:29:36 +0000 (UTC)
Received: from whitealder.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id A0EF4C0051
 for <virtualization@lists.linux-foundation.org>;
 Fri, 25 Sep 2020 11:29:33 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by whitealder.osuosl.org (Postfix) with ESMTP id 9601D86CE0
 for <virtualization@lists.linux-foundation.org>;
 Fri, 25 Sep 2020 11:29:33 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from whitealder.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id Xd0kEw76lrBY
 for <virtualization@lists.linux-foundation.org>;
 Fri, 25 Sep 2020 11:29:33 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [63.128.21.124])
 by whitealder.osuosl.org (Postfix) with ESMTPS id E722D86DD7
 for <virtualization@lists.linux-foundation.org>;
 Fri, 25 Sep 2020 11:29:32 +0000 (UTC)
Dkim-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1601033371;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=3NXvmRl1RoHr3cxBopNVva2P77kIGOs8tMv65YwxLi0=;
 b=g+403WKb4ceiBqI+k3X6kvRUBB2oMaFHNt37bFQQpD8rZl/jtL1C2FK5cmHijZwPwiAzcA
 nhAS/5g6xdPBLcEPj+rzBFsGa/bafi5OKPLR4yvjcOk/o9pA9+e5QW9A2ZKmfS0xCGlSdP
 u5ENDMBCPqQ7hdzq8bHqRZbZ6Rw99BM=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-192-1ex2OmjHNEeCj0OvC-clLQ-1; Fri, 25 Sep 2020 07:29:29 -0400
X-MC-Unique: 1ex2OmjHNEeCj0OvC-clLQ-1
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com
 [10.5.11.14])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 866C564149;
 Fri, 25 Sep 2020 11:29:28 +0000 (UTC)
Received: from [10.72.12.44] (ovpn-12-44.pek2.redhat.com [10.72.12.44])
 by smtp.corp.redhat.com (Postfix) with ESMTP id BE17A5D9F3;
 Fri, 25 Sep 2020 11:29:25 +0000 (UTC)
Subject: Re: [PATCH v3 -next] vdpa: mlx5: change Kconfig depends to fix build
 errors
To: "Michael S. Tsirkin" <mst@redhat.com>, Leon Romanovsky <leonro@nvidia.com>
References: <73f7e48b-8d16-6b20-07d3-41dee0e3d3bd@infradead.org>
 <20200918082245.GP869610@unreal>
 <20200924052932-mutt-send-email-mst@kernel.org>
 <20200924102413.GD170403@mtl-vdi-166.wap.labs.mlnx>
 <079c831e-214d-22c1-028e-05d84e3b7f04@infradead.org>
 <20200924120217-mutt-send-email-mst@kernel.org>
 <20200925072005.GB2280698@unreal>
 <20200925061847-mutt-send-email-mst@kernel.org>
From: Jason Wang <jasowang@redhat.com>
Message-ID: <821c501c-53ce-3e80-8a73-f0680193df20@redhat.com>
Date: Fri, 25 Sep 2020 19:29:24 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <20200925061847-mutt-send-email-mst@kernel.org>
Content-Language: en-US
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
Cc: "netdev@vger.kernel.org" <netdev@vger.kernel.org>,
 Randy Dunlap <rdunlap@infradead.org>, LKML <linux-kernel@vger.kernel.org>,
 virtualization@lists.linux-foundation.org, Eli Cohen <elic@nvidia.com>,
 Saeed Mahameed <saeedm@nvidia.com>
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

Ck9uIDIwMjAvOS8yNSDkuIvljYg2OjE5LCBNaWNoYWVsIFMuIFRzaXJraW4gd3JvdGU6Cj4gT24g
RnJpLCBTZXAgMjUsIDIwMjAgYXQgMTA6MjA6MDVBTSArMDMwMCwgTGVvbiBSb21hbm92c2t5IHdy
b3RlOgo+PiBPbiBUaHUsIFNlcCAyNCwgMjAyMCBhdCAxMjowMjo0M1BNIC0wNDAwLCBNaWNoYWVs
IFMuIFRzaXJraW4gd3JvdGU6Cj4+PiBPbiBUaHUsIFNlcCAyNCwgMjAyMCBhdCAwODo0NzowNUFN
IC0wNzAwLCBSYW5keSBEdW5sYXAgd3JvdGU6Cj4+Pj4gT24gOS8yNC8yMCAzOjI0IEFNLCBFbGkg
Q29oZW4gd3JvdGU6Cj4+Pj4+IE9uIFRodSwgU2VwIDI0LCAyMDIwIGF0IDA1OjMwOjU1QU0gLTA0
MDAsIE1pY2hhZWwgUy4gVHNpcmtpbiB3cm90ZToKPj4+Pj4+Pj4gLS0tIGxpbnV4LW5leHQtMjAy
MDA5MTcub3JpZy9kcml2ZXJzL3ZkcGEvS2NvbmZpZwo+Pj4+Pj4+PiArKysgbGludXgtbmV4dC0y
MDIwMDkxNy9kcml2ZXJzL3ZkcGEvS2NvbmZpZwo+Pj4+Pj4+PiBAQCAtMzEsNyArMzEsNyBAQCBj
b25maWcgSUZDVkYKPj4+Pj4+Pj4KPj4+Pj4+Pj4gICBjb25maWcgTUxYNV9WRFBBCj4+Pj4+Pj4+
ICAgCWJvb2wgIk1MWDUgVkRQQSBzdXBwb3J0IGxpYnJhcnkgZm9yIENvbm5lY3RYIGRldmljZXMi
Cj4+Pj4+Pj4+IC0JZGVwZW5kcyBvbiBNTFg1X0NPUkUKPj4+Pj4+Pj4gKwlkZXBlbmRzIG9uIFZI
T1NUX0lPVExCICYmIE1MWDVfQ09SRQo+Pj4+Pj4+PiAgIAlkZWZhdWx0IG4KPj4+Pj4+PiBXaGls
ZSB3ZSBhcmUgaGVyZSwgY2FuIGFueW9uZSB3aG8gYXBwbHkgdGhpcyBwYXRjaCBkZWxldGUgdGhl
ICJkZWZhdWx0IG4iIGxpbmU/Cj4+Pj4+Pj4gSXQgaXMgYnkgZGVmYXVsdCAibiIuCj4+Pj4+IEkg
Y2FuIGRvIHRoYXQKPj4+Pj4KPj4+Pj4+PiBUaGFua3MKPj4+Pj4+IEhtbSBvdGhlciBkcml2ZXJz
IHNlbGVjdCBWSE9TVF9JT1RMQiwgd2h5IG5vdCBkbyB0aGUgc2FtZT8KPj4+PiB2MSB1c2VkIHNl
bGVjdCwgYnV0IFNhZWVkIHJlcXVlc3RlZCB1c2Ugb2YgZGVwZW5kcyBpbnN0ZWFkIGJlY2F1c2UK
Pj4+PiBzZWxlY3QgY2FuIGNhdXNlIHByb2JsZW1zLgo+Pj4+Cj4+Pj4+IEkgY2FuJ3Qgc2VlIGFu
b3RoZXIgZHJpdmVyIGRvaW5nIHRoYXQuIFBlcmhhcHMgSSBjYW4gc2V0IGRlcGVuZGVuY3kgb24K
Pj4+Pj4gVkhPU1Qgd2hpY2ggYnkgaXRzZWxmIGRlcGVuZHMgb24gVkhPU1RfSU9UTEI/Cj4+Pj4+
Pgo+Pj4+Pj4+PiAgIAloZWxwCj4+Pj4+Pj4+ICAgCSAgU3VwcG9ydCBsaWJyYXJ5IGZvciBNZWxs
YW5veCBWRFBBIGRyaXZlcnMuIFByb3ZpZGVzIGNvZGUgdGhhdCBpcwo+Pj4+Pj4+Pgo+Pj4gU2Fl
ZWQgd2hhdCBraW5kIG9mIHByb2JsZW1zPyBJdCdzIHVzZWQgd2l0aCBzZWxlY3QgaW4gb3RoZXIg
cGxhY2VzLAo+Pj4gaXNuJ3QgaXQ/Cj4+IElNSE8sICJkZXBlbmRzIiBpcyBtdWNoIG1vcmUgZXhw
bGljaXQgdGhhbiAic2VsZWN0Ii4KPj4KPj4gVGhhbmtzCj4gVGhpcyBpcyBub3cgaG93IFZIT1NU
X0lPVExCIGhhcyBiZWVuIGRlc2lnbmVkIHRob3VnaC4KPiBJZiB5b3Ugd2FudCB0byBjaGFuZ2Ug
VkhPU1RfSU9UTEIgdG8gZGVwZW5kcyBJIHRoaW5rCj4gd2Ugc2hvdWxkIGRvIGl0IGNvbnNpc3Rl
bnRseSBhbGwgb3Zlci4KPgo+Cj4gY29uZmlnIFZIT1NUX0lPVExCCj4gICAgICAgICAgdHJpc3Rh
dGUKPiAgICAgICAgICBoZWxwCj4gICAgICAgICAgICBHZW5lcmljIElPVExCIGltcGxlbWVudGF0
aW9uIGZvciB2aG9zdCBhbmQgdnJpbmdoLgo+ICAgICAgICAgICAgVGhpcyBvcHRpb24gaXMgc2Vs
ZWN0ZWQgYnkgYW55IGRyaXZlciB3aGljaCBuZWVkcyB0byBzdXBwb3J0Cj4gICAgICAgICAgICBh
biBJT01NVSBpbiBzb2Z0d2FyZS4KCgpZZXMsIHNpbmNlIHRoZXJlJ3Mgbm8gcHJvbXB0IGZvciBW
SE9TVF9JT1RMQiB3aGljaCBtZWFucywgaWYgdGhlcmUncyBubyAKb3RoZXIgc3ltYm9sIHRoYXQg
c2VsZWN0IFZIT1NUX0lPVExCLCB5b3UgY2FuJ3QgZW5hYmxlIE1MWDUgYXQgYWxsLgoKU2VlIGtj
b25maWctbGFuZ3VhZ2UucnN0OgoKCiDCoMKgwqAgSW4gZ2VuZXJhbCB1c2Ugc2VsZWN0IG9ubHkg
Zm9yIG5vbi12aXNpYmxlIHN5bWJvbHMKIMKgwqDCoCAobm8gcHJvbXB0cyBhbnl3aGVyZSkgYW5k
IGZvciBzeW1ib2xzIHdpdGggbm8gZGVwZW5kZW5jaWVzLgogwqDCoMKgIFRoYXQgd2lsbCBsaW1p
dCB0aGUgdXNlZnVsbmVzcyBidXQgb24gdGhlIG90aGVyIGhhbmQgYXZvaWQKIMKgwqDCoCB0aGUg
aWxsZWdhbCBjb25maWd1cmF0aW9ucyBhbGwgb3Zlci4KClRoYW5rcwoKCj4KPgo+Pj4+IC0tCj4+
Pj4gflJhbmR5CgpfX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
XwpWaXJ0dWFsaXphdGlvbiBtYWlsaW5nIGxpc3QKVmlydHVhbGl6YXRpb25AbGlzdHMubGludXgt
Zm91bmRhdGlvbi5vcmcKaHR0cHM6Ly9saXN0cy5saW51eGZvdW5kYXRpb24ub3JnL21haWxtYW4v
bGlzdGluZm8vdmlydHVhbGl6YXRpb24=
