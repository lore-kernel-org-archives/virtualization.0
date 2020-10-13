Return-Path: <SRS0=ZRN8=DU=lists.linux-foundation.org=virtualization-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.1 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	NICE_REPLY_A,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E83BBC433DF
	for <virtualization@archiver.kernel.org>; Tue, 13 Oct 2020 05:38:00 +0000 (UTC)
Received: from fraxinus.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 13C71208D5
	for <virtualization@archiver.kernel.org>; Tue, 13 Oct 2020 05:37:58 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="JhBfu33X"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 13C71208D5
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=virtualization-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by fraxinus.osuosl.org (Postfix) with ESMTP id 882F487344;
	Tue, 13 Oct 2020 05:37:58 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from fraxinus.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id WO-qib7NamOz; Tue, 13 Oct 2020 05:37:57 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by fraxinus.osuosl.org (Postfix) with ESMTP id EBCE887302;
	Tue, 13 Oct 2020 05:37:57 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id CBA5BC07FF;
	Tue, 13 Oct 2020 05:37:57 +0000 (UTC)
Received: from silver.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 9B929C0051
 for <virtualization@lists.linux-foundation.org>;
 Tue, 13 Oct 2020 05:37:56 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by silver.osuosl.org (Postfix) with ESMTP id 6589D27404
 for <virtualization@lists.linux-foundation.org>;
 Tue, 13 Oct 2020 05:37:56 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from silver.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id UQL7Zl6+0ZkZ
 for <virtualization@lists.linux-foundation.org>;
 Tue, 13 Oct 2020 05:37:54 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [63.128.21.124])
 by silver.osuosl.org (Postfix) with ESMTPS id B8AF327400
 for <virtualization@lists.linux-foundation.org>;
 Tue, 13 Oct 2020 05:37:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1602567473;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=Rw74HsxIwD123mE8HaMFYEH2HF+ZHaHtXtmLpiU4KEM=;
 b=JhBfu33XXm22LoUfHUP2RJzrtlrpSK6AXi1dKdA1yCIacELfyNByrc7mgDCttGM/aR/ZuV
 rzGggOjjWXBwaxs1TiISepbRBbyeaJ006RMNQiAGhu5PSNumDqpQn5n18BVV6dnFu1y4EO
 aayJpEDGRvxg02Ebhaq/A6NoMQZF6xY=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-374-eJ5E8C6iOFOGdP0OrCPmlg-1; Tue, 13 Oct 2020 01:37:51 -0400
X-MC-Unique: eJ5E8C6iOFOGdP0OrCPmlg-1
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com
 [10.5.11.23])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 52329805F0D;
 Tue, 13 Oct 2020 05:37:50 +0000 (UTC)
Received: from [10.72.13.59] (ovpn-13-59.pek2.redhat.com [10.72.13.59])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 4A5C227BDC;
 Tue, 13 Oct 2020 05:37:44 +0000 (UTC)
Subject: Re: [PATCH v2] vdpa/mlx5: Setup driver only if
 VIRTIO_CONFIG_S_DRIVER_OK
To: Eli Cohen <elic@nvidia.com>
References: <20200908123346.GA169007@mtl-vdi-166.wap.labs.mlnx>
 <1004346338.16284947.1599617319808.JavaMail.zimbra@redhat.com>
 <20200909053045.GB200399@mtl-vdi-166.wap.labs.mlnx>
From: Jason Wang <jasowang@redhat.com>
Message-ID: <b3c13c74-b945-93a8-fb36-d24b944bb19b@redhat.com>
Date: Tue, 13 Oct 2020 13:37:43 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <20200909053045.GB200399@mtl-vdi-166.wap.labs.mlnx>
Content-Language: en-US
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
Cc: netdev <netdev@vger.kernel.org>, virtualization@lists.linux-foundation.org,
 Cindy Lu <lulu@redhat.com>, "Michael S. Tsirkin" <mst@redhat.com>
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

Ck9uIDIwMjAvOS85IOS4i+WNiDE6MzAsIEVsaSBDb2hlbiB3cm90ZToKPiBPbiBUdWUsIFNlcCAw
OCwgMjAyMCBhdCAxMDowODozOVBNIC0wNDAwLCBKYXNvbiBXYW5nIHdyb3RlOgo+Pgo+PiAtLS0t
LSBPcmlnaW5hbCBNZXNzYWdlIC0tLS0tCj4+PiBzZXRfbWFwKCkgaXMgdXNlZCBieSBtbHg1IHZk
cGEgdG8gY3JlYXRlIGEgbWVtb3J5IHJlZ2lvbiBiYXNlZCBvbiB0aGUKPj4+IGFkZHJlc3MgbWFw
IHBhc3NlZCBieSB0aGUgaW90bGIgYXJndW1lbnQuIElmIHdlIGdldCBzdWNjZXNzaXZlIGNhbGxz
LCB3ZQo+Pj4gd2lsbCBkZXN0cm95IHRoZSBjdXJyZW50IG1lbW9yeSByZWdpb24gYW5kIGJ1aWxk
IGFub3RoZXIgb25lIGJhc2VkIG9uCj4+PiB0aGUgbmV3IGFkZHJlc3MgbWFwcGluZy4gV2UgYWxz
byBuZWVkIHRvIHNldHVwIHRoZSBoYXJkd2FyZSByZXNvdXJjZXMKPj4+IHNpbmNlIHRoZXkgZGVw
ZW5kIG9uIHRoZSBtZW1vcnkgcmVnaW9uLgo+Pj4KPj4+IElmIHRoZXNlIGNhbGxzIGhhcHBlbiBi
ZWZvcmUgRFJJVkVSX09LLCBJdCBtZWFucyB0aGF0IGRyaXZlciBWUXMgbWF5Cj4+PiBhbHNvIG5v
dCBiZWVuIHNldHVwIGFuZCB3ZSBtYXkgbm90IGNyZWF0ZSB0aGVtIHlldC4gSW4gdGhpcyBjYXNl
IHdlIHdhbnQKPj4+IHRvIGF2b2lkIHNldHRpbmcgdXAgdGhlIG90aGVyIHJlc291cmNlcyBhbmQg
ZGVmZXIgdGhpcyB0aWxsIHdlIGdldAo+Pj4gRFJJVkVSIE9LLgo+Pj4KPj4+IEZpeGVzOiAxYTg2
YjM3N2FhMjEgKCJ2ZHBhL21seDU6IEFkZCBWRFBBIGRyaXZlciBmb3Igc3VwcG9ydGVkIG1seDUg
ZGV2aWNlcyIpCj4+PiBTaWduZWQtb2ZmLWJ5OiBFbGkgQ29oZW4gPGVsaWNAbnZpZGlhLmNvbT4K
Pj4+IC0tLQo+Pj4gVjEtPlYyOiBJbXByb3ZlIGNoYW5nZWxvZyBkZXNjcmlwdGlvbgo+Pj4KPj4+
ICAgZHJpdmVycy92ZHBhL21seDUvbmV0L21seDVfdm5ldC5jIHwgMyArKysKPj4+ICAgMSBmaWxl
IGNoYW5nZWQsIDMgaW5zZXJ0aW9ucygrKQo+Pj4KPj4+IGRpZmYgLS1naXQgYS9kcml2ZXJzL3Zk
cGEvbWx4NS9uZXQvbWx4NV92bmV0LmMKPj4+IGIvZHJpdmVycy92ZHBhL21seDUvbmV0L21seDVf
dm5ldC5jCj4+PiBpbmRleCA5ZGY2OWQ1ZWZlOGMuLmM4OWNkNDhhMGFhYiAxMDA2NDQKPj4+IC0t
LSBhL2RyaXZlcnMvdmRwYS9tbHg1L25ldC9tbHg1X3ZuZXQuYwo+Pj4gKysrIGIvZHJpdmVycy92
ZHBhL21seDUvbmV0L21seDVfdm5ldC5jCj4+PiBAQCAtMTY0NSw2ICsxNjQ1LDkgQEAgc3RhdGlj
IGludCBtbHg1X3ZkcGFfY2hhbmdlX21hcChzdHJ1Y3QgbWx4NV92ZHBhX25ldAo+Pj4gKm5kZXYs
IHN0cnVjdCB2aG9zdF9pb3RsYiAqCj4+PiAgIAlpZiAoZXJyKQo+Pj4gICAJCWdvdG8gZXJyX21y
Owo+Pj4gICAKPj4+ICsJaWYgKCEobmRldi0+bXZkZXYuc3RhdHVzICYgVklSVElPX0NPTkZJR19T
X0RSSVZFUl9PSykpCj4+PiArCQlyZXR1cm4gMDsKPj4+ICsKPj4gSXMgdGhlcmUgYW55IHJlYXNv
biB0aGF0IHdlIHN0aWxsIG5lZWQgdG8gZG8gdnEgc3VzcGVuZGluZyBhbmQgc2F2aW5nIGJlZm9y
ZT8KPj4KPiBUaG91Z2ggc3VzcGVuZF92cXMoKSBhbmQgc2F2ZV9jaGFubmVsc19pbmZvKCkgd2ls
bCBiZSBjYWxsZWQsIHRoZXkgd2lsbAo+IG5vdCBhY3R1YWxseSBkbyBhbnkgd29yayBiZWNhdXNl
IHRoZSBtdnEtPmluaXRpYWxpemVkIGlzIGZhbHNlLgo+Cj4gU2luY2Ugd2UgZG9uJ3QgZXhwZWN0
IHNvIG1hbnkgZmFsc2UgbWFwIHVwZGF0ZXMgSSB0aGluayBpdCBtYWtlcyBzZW5zZQo+IHRvIGF2
b2lkIGxvZ2ljIGFyb3VuZCB0aGUgY2FsbHMgc3VzcGVuZF92cXMoKSBhbmQgc2F2ZV9jaGFubmVs
c19pbmZvKCkuCgoKSSBzZWUuCgpBY2tlZC1ieTogSmFzb24gV2FuZyA8amFzb3dhbmdAcmVkaGF0
LmNvbT4KClRoYW5rcwoKCj4KPj4gVGhhbmtzCj4+Cj4+PiAgIAlyZXN0b3JlX2NoYW5uZWxzX2lu
Zm8obmRldik7Cj4+PiAgIAllcnIgPSBzZXR1cF9kcml2ZXIobmRldik7Cj4+PiAgIAlpZiAoZXJy
KQo+Pj4gLS0KPj4+IDIuMjYuMAo+Pj4KPj4+CgpfX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fXwpWaXJ0dWFsaXphdGlvbiBtYWlsaW5nIGxpc3QKVmlydHVhbGl6
YXRpb25AbGlzdHMubGludXgtZm91bmRhdGlvbi5vcmcKaHR0cHM6Ly9saXN0cy5saW51eGZvdW5k
YXRpb24ub3JnL21haWxtYW4vbGlzdGluZm8vdmlydHVhbGl6YXRpb24=
