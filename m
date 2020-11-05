Return-Path: <SRS0=fSpH=EL=lists.linux-foundation.org=virtualization-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.1 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	NICE_REPLY_A,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 92410C2D0A3
	for <virtualization@archiver.kernel.org>; Thu,  5 Nov 2020 03:11:15 +0000 (UTC)
Received: from whitealder.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id F0D7120715
	for <virtualization@archiver.kernel.org>; Thu,  5 Nov 2020 03:11:14 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="VA4pe7o+"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org F0D7120715
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=virtualization-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by whitealder.osuosl.org (Postfix) with ESMTP id 6B7F985045;
	Thu,  5 Nov 2020 03:11:14 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from whitealder.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id HNnP61ITW0et; Thu,  5 Nov 2020 03:10:49 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by whitealder.osuosl.org (Postfix) with ESMTP id 1B00F84FE6;
	Thu,  5 Nov 2020 03:10:49 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id EEA8AC0893;
	Thu,  5 Nov 2020 03:10:48 +0000 (UTC)
Received: from fraxinus.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by lists.linuxfoundation.org (Postfix) with ESMTP id E8334C0889
 for <virtualization@lists.linux-foundation.org>;
 Thu,  5 Nov 2020 03:10:47 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by fraxinus.osuosl.org (Postfix) with ESMTP id 7F58984826
 for <virtualization@lists.linux-foundation.org>;
 Thu,  5 Nov 2020 03:10:47 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from fraxinus.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id NuFsvLmCmla5
 for <virtualization@lists.linux-foundation.org>;
 Thu,  5 Nov 2020 03:10:45 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [216.205.24.124])
 by fraxinus.osuosl.org (Postfix) with ESMTPS id 2C0AA84820
 for <virtualization@lists.linux-foundation.org>;
 Thu,  5 Nov 2020 03:10:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1604545842;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=+u0ac9KHv5wcKAFb5ZDCdLBF5wpiQCLC3Skb+q8JnJI=;
 b=VA4pe7o+5Venfs9l53pM22AMBLOnaZUo3A30nQhTE7a0aAf7iSo6xpU8O/KaoMIuFUgarr
 eYL3Tu45gwKqZBo1/yIicwYC+0oHUygwPVIj2ieAdmEc1cK7zSNSu0nv/xlcz2PYLQiWbG
 69TWU/DyK5PcDO68UCwXsWdWiT7kmiw=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-503-yd3NH94MMTu1ekabTjB6KQ-1; Wed, 04 Nov 2020 22:10:40 -0500
X-MC-Unique: yd3NH94MMTu1ekabTjB6KQ-1
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com
 [10.5.11.11])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 940321007469;
 Thu,  5 Nov 2020 03:10:38 +0000 (UTC)
Received: from [10.72.13.154] (ovpn-13-154.pek2.redhat.com [10.72.13.154])
 by smtp.corp.redhat.com (Postfix) with ESMTP id D783C5B4DC;
 Thu,  5 Nov 2020 03:10:25 +0000 (UTC)
Subject: Re: [PATCH virtio] virtio: virtio_console: fix DMA memory allocation
 for rproc serial
To: Alexander Lobakin <alobakin@pm.me>, Amit Shah <amit@kernel.org>,
 Arnd Bergmann <arnd@arndb.de>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>
References: <AOKowLclCbOCKxyiJ71WeNyuAAj2q8EUtxrXbyky5E@cp7-web-042.plabs.ch>
From: Jason Wang <jasowang@redhat.com>
Message-ID: <004da56d-aad2-3b69-3428-02a14263289b@redhat.com>
Date: Thu, 5 Nov 2020 11:10:24 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <AOKowLclCbOCKxyiJ71WeNyuAAj2q8EUtxrXbyky5E@cp7-web-042.plabs.ch>
Content-Language: en-US
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
Cc: Ohad Ben-Cohen <ohad@wizery.com>,
 Mathieu Poirier <mathieu.poirier@linaro.org>,
 "Michael S. Tsirkin" <mst@redhat.com>, linux-remoteproc@vger.kernel.org,
 Arnaud Pouliquen <arnaud.pouliquen@st.com>, linux-kernel@vger.kernel.org,
 stable@vger.kernel.org, Bjorn Andersson <bjorn.andersson@linaro.org>,
 Suman Anna <s-anna@ti.com>, virtualization@lists.linux-foundation.org
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

Ck9uIDIwMjAvMTEvNCDkuIvljYgxMTozMSwgQWxleGFuZGVyIExvYmFraW4gd3JvdGU6Cj4gU2lu
Y2UgY29tbWl0IDA4NmQwODcyNWQzNCAoInJlbW90ZXByb2M6IGNyZWF0ZSB2ZGV2IHN1YmRldmlj
ZSB3aXRoCj4gc3BlY2lmaWMgZG1hIG1lbW9yeSBwb29sIiksIGV2ZXJ5IHJlbW90ZXByb2MgaGFz
IGEgRE1BIHN1YmRldmljZQo+ICgicmVtb3RlcHJvY1gjdmRldllidWZmZXIiKSBmb3IgZWFjaCB2
aXJ0aW8gZGV2aWNlLCB3aGljaCBpbmhlcml0cwo+IERNQSBjYXBhYmlsaXRpZXMgZnJvbSB0aGUg
Y29ycmVzcG9uZGluZyBwbGF0Zm9ybSBkZXZpY2UuIFRoaXMgYWxsb3dlZAo+IHRvIGFzc29jaWF0
ZSBkaWZmZXJlbnQgRE1BIHBvb2xzIHdpdGggZWFjaCB2ZGV2LCBhbmQgcmVxdWlyZWQgZnJvbQo+
IHZpcnRpbyBkcml2ZXJzIHRvIHBlcmZvcm0gRE1BIG9wZXJhdGlvbnMgd2l0aCB0aGUgcGFyZW50
IGRldmljZQo+ICh2ZGV2LT5kZXYucGFyZW50KSBpbnN0ZWFkIG9mIGdyYW5kcGFyZW50ICh2ZGV2
LT5kZXYucGFyZW50LT5wYXJlbnQpLgo+Cj4gdmlydGlvX3JwbXNnX2J1cyB3YXMgYWxyZWFkeSBj
aGFuZ2VkIGluIHRoZSBzYW1lIG1lcmdlIGN5Y2xlIHdpdGgKPiBjb21taXQgZDk5OWI2MjJmY2Zi
ICgicnBtc2c6IHZpcnRpbzogYWxsb2NhdGUgYnVmZmVyIGZyb20gcGFyZW50IiksCj4gYnV0IHZp
cnRpb19jb25zb2xlIGRpZCBub3QuIEluIGZhY3QsIG9wZXJhdGlvbnMgdXNpbmcgdGhlIGdyYW5k
cGFyZW50Cj4gd29ya2VkIGZpbmUgd2hpbGUgdGhlIGdyYW5kcGFyZW50IHdhcyB0aGUgcGxhdGZv
cm0gZGV2aWNlLCBidXQgc2luY2UKPiBjb21taXQgYzc3NGFkMDEwODczICgicmVtb3RlcHJvYzog
Rml4IGFuZCByZXN0b3JlIHRoZSBwYXJlbnRpbmcKPiBoaWVyYXJjaHkgZm9yIHZkZXYiKSB0aGlz
IHdhcyBjaGFuZ2VkLCBhbmQgbm93IHRoZSBncmFuZHBhcmVudCBkZXZpY2UKPiBpcyB0aGUgcmVt
b3RlcHJvYyBkZXZpY2Ugd2l0aG91dCBhbnkgRE1BIGNhcGFiaWxpdGllcy4KPiBTbywgc3RhcnRp
bmcgdjUuOC1yYzEgdGhlIGZvbGxvd2luZyB3YXJuaW5nIGlzIG9ic2VydmVkOgo+Cj4gWyAgICAy
LjQ4MzkyNV0gLS0tLS0tLS0tLS0tWyBjdXQgaGVyZSBdLS0tLS0tLS0tLS0tCj4gWyAgICAyLjQ4
OTE0OF0gV0FSTklORzogQ1BVOiAzIFBJRDogMTAxIGF0IGtlcm5lbC9kbWEvbWFwcGluZy5jOjQy
NyAweDgwZTdlZWU4Cj4gWyAgICAyLjQ4OTE1Ml0gTW9kdWxlcyBsaW5rZWQgaW46IHZpcnRpb19j
b25zb2xlKCspCj4gWyAgICAyLjUwMzczN10gIHZpcnRpb19ycG1zZ19idXMgcnBtc2dfY29yZQo+
IFsgICAgMi41MDg5MDNdCj4gWyAgICAyLjUyODg5OF0gPE90aGVyIG1vZHVsZXMsIHN0YWNrIGFu
ZCBjYWxsIHRyYWNlIGhlcmU+Cj4gWyAgICAyLjkxMzA0M10KPiBbICAgIDIuOTE0OTA3XSAtLS1b
IGVuZCB0cmFjZSA5M2FjODc0NmJlYWI2MTJjIF0tLS0KPiBbICAgIDIuOTIwMTAyXSB2aXJ0aW8t
cG9ydHMgdnBvcnQxcDA6IEVycm9yIGFsbG9jYXRpbmcgaW5idWZzCj4KPiBrZXJuZWwvZG1hL21h
cHBpbmcuYzo0MjcgaXM6Cj4KPiBXQVJOX09OX09OQ0UoIWRldi0+Y29oZXJlbnRfZG1hX21hc2sp
Owo+Cj4gb2J2aW91c2x5IGJlY2F1c2UgdGhlIGdyYW5kcGFyZW50IG5vdyBpcyByZW1vdGVwcm9j
IGRldiB3aXRob3V0IGFueQo+IERNQSBjYXBzOgo+Cj4gWyAgICAzLjEwNDk0M10gUGFyZW50OiBy
ZW1vdGVwcm9jMCN2ZGV2MWJ1ZmZlciwgZ3JhbmRwYXJlbnQ6IHJlbW90ZXByb2MwCj4KPiBGaXgg
dGhpcyB0aGUgc2FtZSB3YXkgYXMgaXQgd2FzIGZvciB2aXJ0aW9fcnBtc2dfYnVzLCB1c2luZyBq
dXN0IHRoZQo+IHBhcmVudCBkZXZpY2UgKHZkZXYtPmRldi5wYXJlbnQsICJyZW1vdGVwcm9jWCN2
ZGV2WWJ1ZmZlciIpIGZvciBETUEKPiBvcGVyYXRpb25zLgo+IFRoaXMgYWxzbyBhbGxvd3Mgbm93
IHRvIHJlc2VydmUgRE1BIHBvb2xzL2J1ZmZlcnMgZm9yIHJwcm9jIHNlcmlhbAo+IHZpYSBEZXZp
Y2UgVHJlZS4KPgo+IEZpeGVzOiBjNzc0YWQwMTA4NzMgKCJyZW1vdGVwcm9jOiBGaXggYW5kIHJl
c3RvcmUgdGhlIHBhcmVudGluZyBoaWVyYXJjaHkgZm9yIHZkZXYiKQo+IENjOiBzdGFibGVAdmdl
ci5rZXJuZWwub3JnICMgNS4xKwo+IFNpZ25lZC1vZmYtYnk6IEFsZXhhbmRlciBMb2Jha2luIDxh
bG9iYWtpbkBwbS5tZT4KPiAtLS0KPiAgIGRyaXZlcnMvY2hhci92aXJ0aW9fY29uc29sZS5jIHwg
OCArKysrLS0tLQo+ICAgMSBmaWxlIGNoYW5nZWQsIDQgaW5zZXJ0aW9ucygrKSwgNCBkZWxldGlv
bnMoLSkKPgo+IGRpZmYgLS1naXQgYS9kcml2ZXJzL2NoYXIvdmlydGlvX2NvbnNvbGUuYyBiL2Ry
aXZlcnMvY2hhci92aXJ0aW9fY29uc29sZS5jCj4gaW5kZXggYTJkYThmNzY4Yjk0Li4xODM2Y2M1
NmUzNTcgMTAwNjQ0Cj4gLS0tIGEvZHJpdmVycy9jaGFyL3ZpcnRpb19jb25zb2xlLmMKPiArKysg
Yi9kcml2ZXJzL2NoYXIvdmlydGlvX2NvbnNvbGUuYwo+IEBAIC00MzUsMTIgKzQzNSwxMiBAQCBz
dGF0aWMgc3RydWN0IHBvcnRfYnVmZmVyICphbGxvY19idWYoc3RydWN0IHZpcnRpb19kZXZpY2Ug
KnZkZXYsIHNpemVfdCBidWZfc2l6ZQo+ICAgCQkvKgo+ICAgCQkgKiBBbGxvY2F0ZSBETUEgbWVt
b3J5IGZyb20gYW5jZXN0b3IuIFdoZW4gYSB2aXJ0aW8KPiAgIAkJICogZGV2aWNlIGlzIGNyZWF0
ZWQgYnkgcmVtb3RlcHJvYywgdGhlIERNQSBtZW1vcnkgaXMKPiAtCQkgKiBhc3NvY2lhdGVkIHdp
dGggdGhlIGdyYW5kcGFyZW50IGRldmljZToKPiAtCQkgKiB2ZGV2ID0+IHJwcm9jID0+IHBsYXRm
b3JtLWRldi4KPiArCQkgKiBhc3NvY2lhdGVkIHdpdGggdGhlIHBhcmVudCBkZXZpY2U6Cj4gKwkJ
ICogdmlydGlvWSA9PiByZW1vdGVwcm9jWCN2ZGV2WWJ1ZmZlci4KPiAgIAkJICovCj4gLQkJaWYg
KCF2ZGV2LT5kZXYucGFyZW50IHx8ICF2ZGV2LT5kZXYucGFyZW50LT5wYXJlbnQpCj4gKwkJYnVm
LT5kZXYgPSB2ZGV2LT5kZXYucGFyZW50Owo+ICsJCWlmICghYnVmLT5kZXYpCj4gICAJCQlnb3Rv
IGZyZWVfYnVmOwo+IC0JCWJ1Zi0+ZGV2ID0gdmRldi0+ZGV2LnBhcmVudC0+cGFyZW50OwoKCkkg
d29uZGVyIGl0IGNvdWxkIGJlIHRoZSByaWdodCB0aW1lIHRvIGludHJvZHVjZSBkbWFfZGV2IGZv
ciB2aXJ0aW8gCmluc3RlYWQgb2YgZGVwZW5kaW5nIG9uIHNvbWV0aGluZyBtYWdpYyB2aWEgcGFy
ZW50LgoKKEJ0dyBJIGRvbid0IGV2ZW4gbm90aWNlIHRoYXQgdGhlcmUncyB0cmFuc3BvcnQgc3Bl
Y2lmaWMgY29kZSBpbiB2aXJ0aW8gCmNvbnNvbGUsIGl0J3MgYmV0dGVyIHRvIGF2b2lkIGl0KQoK
VGhhbmtzCgoKPiAgIAo+ICAgCQkvKiBJbmNyZWFzZSBkZXZpY2UgcmVmY250IHRvIGF2b2lkIGZy
ZWVpbmcgaXQgKi8KPiAgIAkJZ2V0X2RldmljZShidWYtPmRldik7CgpfX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fXwpWaXJ0dWFsaXphdGlvbiBtYWlsaW5nIGxp
c3QKVmlydHVhbGl6YXRpb25AbGlzdHMubGludXgtZm91bmRhdGlvbi5vcmcKaHR0cHM6Ly9saXN0
cy5saW51eGZvdW5kYXRpb24ub3JnL21haWxtYW4vbGlzdGluZm8vdmlydHVhbGl6YXRpb24=
