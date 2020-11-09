Return-Path: <SRS0=pd2K=EP=lists.linux-foundation.org=virtualization-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.1 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	NICE_REPLY_A,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A2770C2D0A3
	for <virtualization@archiver.kernel.org>; Mon,  9 Nov 2020 06:04:50 +0000 (UTC)
Received: from whitealder.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 16F5320678
	for <virtualization@archiver.kernel.org>; Mon,  9 Nov 2020 06:04:49 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="IHZE3wIp"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 16F5320678
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=virtualization-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by whitealder.osuosl.org (Postfix) with ESMTP id 778FD869A2;
	Mon,  9 Nov 2020 06:04:49 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from whitealder.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id L1Cb9UXsN64H; Mon,  9 Nov 2020 06:04:48 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by whitealder.osuosl.org (Postfix) with ESMTP id EDED086503;
	Mon,  9 Nov 2020 06:04:47 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id B3074C0889;
	Mon,  9 Nov 2020 06:04:47 +0000 (UTC)
Received: from silver.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 971CEC016F
 for <virtualization@lists.linux-foundation.org>;
 Mon,  9 Nov 2020 06:04:46 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by silver.osuosl.org (Postfix) with ESMTP id 6FC1D20506
 for <virtualization@lists.linux-foundation.org>;
 Mon,  9 Nov 2020 06:04:46 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from silver.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id Quf+mfXvGlP4
 for <virtualization@lists.linux-foundation.org>;
 Mon,  9 Nov 2020 06:04:44 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [216.205.24.124])
 by silver.osuosl.org (Postfix) with ESMTPS id 7719820504
 for <virtualization@lists.linux-foundation.org>;
 Mon,  9 Nov 2020 06:04:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1604901882;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=UBLQUM1X/0MCddQFRLO/RxxvuYfOPaxQX5b2ahy4mRA=;
 b=IHZE3wIphUKo7R+bQIt/DYIkexZJd4I/Xgy6fqq4qMRlh7420lEaoe5+2ReKQuaJWxmtCZ
 dsgnIlvVbC4xBNLo6rZRC0FdpYMhXKT4KGtmdX9nmG5wF3RwxNkMd4fN//9Rr3/5lGCslp
 5hykzW0yfl5SgmvClIZBoS23NXGZVTE=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-253-RLBubNkaMJCIgAKuA2Lw4g-1; Mon, 09 Nov 2020 01:04:38 -0500
X-MC-Unique: RLBubNkaMJCIgAKuA2Lw4g-1
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com
 [10.5.11.16])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id B24B21882FA1;
 Mon,  9 Nov 2020 06:04:35 +0000 (UTC)
Received: from [10.72.12.244] (ovpn-12-244.pek2.redhat.com [10.72.12.244])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 55C325C5AF;
 Mon,  9 Nov 2020 06:04:26 +0000 (UTC)
Subject: Re: [PATCH virtio] virtio: virtio_console: fix DMA memory allocation
 for rproc serial
To: Alexander Lobakin <alobakin@pm.me>
References: <AOKowLclCbOCKxyiJ71WeNyuAAj2q8EUtxrXbyky5E@cp7-web-042.plabs.ch>
 <004da56d-aad2-3b69-3428-02a14263289b@redhat.com>
 <aXBO8lWEART2MNuWacIKln3qh6wttCtF2oUd7vthkNU@cp3-web-012.plabs.ch>
From: Jason Wang <jasowang@redhat.com>
Message-ID: <b4aaeab1-4e9f-2b38-0124-e0b0ca9c287b@redhat.com>
Date: Mon, 9 Nov 2020 14:04:24 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <aXBO8lWEART2MNuWacIKln3qh6wttCtF2oUd7vthkNU@cp3-web-012.plabs.ch>
Content-Language: en-US
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.16
Cc: Ohad Ben-Cohen <ohad@wizery.com>, Arnd Bergmann <arnd@arndb.de>,
 Mathieu Poirier <mathieu.poirier@linaro.org>, Amit Shah <amit@kernel.org>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 "Michael S. Tsirkin" <mst@redhat.com>,
 Arnaud Pouliquen <arnaud.pouliquen@st.com>, linux-kernel@vger.kernel.org,
 stable@vger.kernel.org, Bjorn Andersson <bjorn.andersson@linaro.org>,
 linux-remoteproc@vger.kernel.org, Suman Anna <s-anna@ti.com>,
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

Ck9uIDIwMjAvMTEvNSDkuIvljYg4OjIyLCBBbGV4YW5kZXIgTG9iYWtpbiB3cm90ZToKPiBGcm9t
OiBKYXNvbiBXYW5nIDxqYXNvd2FuZ0ByZWRoYXQuY29tPgo+IERhdGU6IFRodSwgNSBOb3YgMjAy
MCAxMToxMDoyNCArMDgwMAo+Cj4gSGkgSmFzb24sCj4KPj4gT24gMjAyMC8xMS80IOS4i+WNiDEx
OjMxLCBBbGV4YW5kZXIgTG9iYWtpbiB3cm90ZToKPj4+IFNpbmNlIGNvbW1pdCAwODZkMDg3MjVk
MzQgKCJyZW1vdGVwcm9jOiBjcmVhdGUgdmRldiBzdWJkZXZpY2Ugd2l0aAo+Pj4gc3BlY2lmaWMg
ZG1hIG1lbW9yeSBwb29sIiksIGV2ZXJ5IHJlbW90ZXByb2MgaGFzIGEgRE1BIHN1YmRldmljZQo+
Pj4gKCJyZW1vdGVwcm9jWCN2ZGV2WWJ1ZmZlciIpIGZvciBlYWNoIHZpcnRpbyBkZXZpY2UsIHdo
aWNoIGluaGVyaXRzCj4+PiBETUEgY2FwYWJpbGl0aWVzIGZyb20gdGhlIGNvcnJlc3BvbmRpbmcg
cGxhdGZvcm0gZGV2aWNlLiBUaGlzIGFsbG93ZWQKPj4+IHRvIGFzc29jaWF0ZSBkaWZmZXJlbnQg
RE1BIHBvb2xzIHdpdGggZWFjaCB2ZGV2LCBhbmQgcmVxdWlyZWQgZnJvbQo+Pj4gdmlydGlvIGRy
aXZlcnMgdG8gcGVyZm9ybSBETUEgb3BlcmF0aW9ucyB3aXRoIHRoZSBwYXJlbnQgZGV2aWNlCj4+
PiAodmRldi0+ZGV2LnBhcmVudCkgaW5zdGVhZCBvZiBncmFuZHBhcmVudCAodmRldi0+ZGV2LnBh
cmVudC0+cGFyZW50KS4KPj4+Cj4+PiB2aXJ0aW9fcnBtc2dfYnVzIHdhcyBhbHJlYWR5IGNoYW5n
ZWQgaW4gdGhlIHNhbWUgbWVyZ2UgY3ljbGUgd2l0aAo+Pj4gY29tbWl0IGQ5OTliNjIyZmNmYiAo
InJwbXNnOiB2aXJ0aW86IGFsbG9jYXRlIGJ1ZmZlciBmcm9tIHBhcmVudCIpLAo+Pj4gYnV0IHZp
cnRpb19jb25zb2xlIGRpZCBub3QuIEluIGZhY3QsIG9wZXJhdGlvbnMgdXNpbmcgdGhlIGdyYW5k
cGFyZW50Cj4+PiB3b3JrZWQgZmluZSB3aGlsZSB0aGUgZ3JhbmRwYXJlbnQgd2FzIHRoZSBwbGF0
Zm9ybSBkZXZpY2UsIGJ1dCBzaW5jZQo+Pj4gY29tbWl0IGM3NzRhZDAxMDg3MyAoInJlbW90ZXBy
b2M6IEZpeCBhbmQgcmVzdG9yZSB0aGUgcGFyZW50aW5nCj4+PiBoaWVyYXJjaHkgZm9yIHZkZXYi
KSB0aGlzIHdhcyBjaGFuZ2VkLCBhbmQgbm93IHRoZSBncmFuZHBhcmVudCBkZXZpY2UKPj4+IGlz
IHRoZSByZW1vdGVwcm9jIGRldmljZSB3aXRob3V0IGFueSBETUEgY2FwYWJpbGl0aWVzLgo+Pj4g
U28sIHN0YXJ0aW5nIHY1LjgtcmMxIHRoZSBmb2xsb3dpbmcgd2FybmluZyBpcyBvYnNlcnZlZDoK
Pj4+Cj4+PiBbICAgIDIuNDgzOTI1XSAtLS0tLS0tLS0tLS1bIGN1dCBoZXJlIF0tLS0tLS0tLS0t
LS0KPj4+IFsgICAgMi40ODkxNDhdIFdBUk5JTkc6IENQVTogMyBQSUQ6IDEwMSBhdCBrZXJuZWwv
ZG1hL21hcHBpbmcuYzo0MjcgMHg4MGU3ZWVlOAo+Pj4gWyAgICAyLjQ4OTE1Ml0gTW9kdWxlcyBs
aW5rZWQgaW46IHZpcnRpb19jb25zb2xlKCspCj4+PiBbICAgIDIuNTAzNzM3XSAgdmlydGlvX3Jw
bXNnX2J1cyBycG1zZ19jb3JlCj4+PiBbICAgIDIuNTA4OTAzXQo+Pj4gWyAgICAyLjUyODg5OF0g
PE90aGVyIG1vZHVsZXMsIHN0YWNrIGFuZCBjYWxsIHRyYWNlIGhlcmU+Cj4+PiBbICAgIDIuOTEz
MDQzXQo+Pj4gWyAgICAyLjkxNDkwN10gLS0tWyBlbmQgdHJhY2UgOTNhYzg3NDZiZWFiNjEyYyBd
LS0tCj4+PiBbICAgIDIuOTIwMTAyXSB2aXJ0aW8tcG9ydHMgdnBvcnQxcDA6IEVycm9yIGFsbG9j
YXRpbmcgaW5idWZzCj4+Pgo+Pj4ga2VybmVsL2RtYS9tYXBwaW5nLmM6NDI3IGlzOgo+Pj4KPj4+
IFdBUk5fT05fT05DRSghZGV2LT5jb2hlcmVudF9kbWFfbWFzayk7Cj4+Pgo+Pj4gb2J2aW91c2x5
IGJlY2F1c2UgdGhlIGdyYW5kcGFyZW50IG5vdyBpcyByZW1vdGVwcm9jIGRldiB3aXRob3V0IGFu
eQo+Pj4gRE1BIGNhcHM6Cj4+Pgo+Pj4gWyAgICAzLjEwNDk0M10gUGFyZW50OiByZW1vdGVwcm9j
MCN2ZGV2MWJ1ZmZlciwgZ3JhbmRwYXJlbnQ6IHJlbW90ZXByb2MwCj4+Pgo+Pj4gRml4IHRoaXMg
dGhlIHNhbWUgd2F5IGFzIGl0IHdhcyBmb3IgdmlydGlvX3JwbXNnX2J1cywgdXNpbmcganVzdCB0
aGUKPj4+IHBhcmVudCBkZXZpY2UgKHZkZXYtPmRldi5wYXJlbnQsICJyZW1vdGVwcm9jWCN2ZGV2
WWJ1ZmZlciIpIGZvciBETUEKPj4+IG9wZXJhdGlvbnMuCj4+PiBUaGlzIGFsc28gYWxsb3dzIG5v
dyB0byByZXNlcnZlIERNQSBwb29scy9idWZmZXJzIGZvciBycHJvYyBzZXJpYWwKPj4+IHZpYSBE
ZXZpY2UgVHJlZS4KPj4+Cj4+PiBGaXhlczogYzc3NGFkMDEwODczICgicmVtb3RlcHJvYzogRml4
IGFuZCByZXN0b3JlIHRoZSBwYXJlbnRpbmcgaGllcmFyY2h5IGZvciB2ZGV2IikKPj4+IENjOiBz
dGFibGVAdmdlci5rZXJuZWwub3JnICMgNS4xKwo+Pj4gU2lnbmVkLW9mZi1ieTogQWxleGFuZGVy
IExvYmFraW4gPGFsb2Jha2luQHBtLm1lPgo+Pj4gLS0tCj4+PiAgICBkcml2ZXJzL2NoYXIvdmly
dGlvX2NvbnNvbGUuYyB8IDggKysrKy0tLS0KPj4+ICAgIDEgZmlsZSBjaGFuZ2VkLCA0IGluc2Vy
dGlvbnMoKyksIDQgZGVsZXRpb25zKC0pCj4+Pgo+Pj4gZGlmZiAtLWdpdCBhL2RyaXZlcnMvY2hh
ci92aXJ0aW9fY29uc29sZS5jIGIvZHJpdmVycy9jaGFyL3ZpcnRpb19jb25zb2xlLmMKPj4+IGlu
ZGV4IGEyZGE4Zjc2OGI5NC4uMTgzNmNjNTZlMzU3IDEwMDY0NAo+Pj4gLS0tIGEvZHJpdmVycy9j
aGFyL3ZpcnRpb19jb25zb2xlLmMKPj4+ICsrKyBiL2RyaXZlcnMvY2hhci92aXJ0aW9fY29uc29s
ZS5jCj4+PiBAQCAtNDM1LDEyICs0MzUsMTIgQEAgc3RhdGljIHN0cnVjdCBwb3J0X2J1ZmZlciAq
YWxsb2NfYnVmKHN0cnVjdCB2aXJ0aW9fZGV2aWNlICp2ZGV2LCBzaXplX3QgYnVmX3NpemUKPj4+
ICAgIAkJLyoKPj4+ICAgIAkJICogQWxsb2NhdGUgRE1BIG1lbW9yeSBmcm9tIGFuY2VzdG9yLiBX
aGVuIGEgdmlydGlvCj4+PiAgICAJCSAqIGRldmljZSBpcyBjcmVhdGVkIGJ5IHJlbW90ZXByb2Ms
IHRoZSBETUEgbWVtb3J5IGlzCj4+PiAtCQkgKiBhc3NvY2lhdGVkIHdpdGggdGhlIGdyYW5kcGFy
ZW50IGRldmljZToKPj4+IC0JCSAqIHZkZXYgPT4gcnByb2MgPT4gcGxhdGZvcm0tZGV2Lgo+Pj4g
KwkJICogYXNzb2NpYXRlZCB3aXRoIHRoZSBwYXJlbnQgZGV2aWNlOgo+Pj4gKwkJICogdmlydGlv
WSA9PiByZW1vdGVwcm9jWCN2ZGV2WWJ1ZmZlci4KPj4+ICAgIAkJICovCj4+PiAtCQlpZiAoIXZk
ZXYtPmRldi5wYXJlbnQgfHwgIXZkZXYtPmRldi5wYXJlbnQtPnBhcmVudCkKPj4+ICsJCWJ1Zi0+
ZGV2ID0gdmRldi0+ZGV2LnBhcmVudDsKPj4+ICsJCWlmICghYnVmLT5kZXYpCj4+PiAgICAJCQln
b3RvIGZyZWVfYnVmOwo+Pj4gLQkJYnVmLT5kZXYgPSB2ZGV2LT5kZXYucGFyZW50LT5wYXJlbnQ7
Cj4+Cj4+IEkgd29uZGVyIGl0IGNvdWxkIGJlIHRoZSByaWdodCB0aW1lIHRvIGludHJvZHVjZSBk
bWFfZGV2IGZvciB2aXJ0aW8KPj4gaW5zdGVhZCBvZiBkZXBlbmRpbmcgb24gc29tZXRoaW5nIG1h
Z2ljIHZpYSBwYXJlbnQuCj4gVGhpcyBwYXRjaCBhcmUgbWVhbnQgdG8gaGl0IFJDIHdpbmRvdyBh
bmQgc3RhYmxlIHRyZWVzIGFzIGEgZml4IG9mCj4gdGhlIGJ1ZyB0aGF0IGlzIHByZXNlbnQgc2lu
Y2UgdjUuOC1yYzEuIFNvIGFueSBuZXcgZmVhdHVyZXMgYXJlIG91dAo+IG9mIHNjb3BlIG9mIHRo
aXMgcGFydGljdWxhciBmaXguCgoKUmlnaHQuCgoKPgo+IFRoZSBpZGVhIG9mIERNQWluZyB0aHJv
dWdoICJkZXYtPnBhcmVudCIgaXMgdGhhdCAidmlydGlvWCIgaXRzZWxmIGlzIGEKPiBsb2dpY2Fs
IGRldiwgbm90IHRoZSByZWFsIG9uZSwgYnV0IGl0cyBwYXJlbnQgKmlzKi4gVGhpcyBsb2dpYyBp
cyB1c2VkCj4gYWNyb3NzIHRoZSB3aG9sZSB0cmVlIC0tIGV2ZXJ5IHN1YnN5c3RlbSBjcmVhdGVz
IGl0cyBvd24gbG9naWNhbCBkZXZpY2UsCj4gYnV0IGRyaXZlcnMgc2hvdWxkIGFsd2F5cyB1c2Ug
dGhlIGJhY2tpbmcgUENJL3BsYXRmb3JtL2V0Yy4gZGV2aWNlcyBmb3IKPiBETUEgb3BlcmF0aW9u
cywgd2hpY2ggcmVwcmVzZW50IHRoZSByZWFsIGhhcmR3YXJlLgoKClllcywgc28gd2hhdCBJIG1l
YW50IGlzIHRvIHVzZSBkaWZmZXJlbnQgdmFyaWFibGVzIGZvciBETUEgYW5kIApoaWVyYXJjaHku
IFNvIGl0J3MgdGhlIHJlc3BvbnNpYmlsaXR5IG9mIHRoZSBsb3dlciBsYXllciB0byBwYXNzIGEg
CmNvcnJlY3QgImRtYV9kZXYiIHRvIHRoZSB1cHBlciBsYXllciBpbnN0ZWFkIG9mIGRlcGVuZGlu
ZyBwYXJlbnQuCgpBbnl3YXkgZm9yIHRoaXMgcGF0Y2guCgpBY2tlZC1ieTogSmFzb24gV2FuZyA8
amFzb3dhbmdAcmVkaGF0LmNvbT4KClRoYW5rcwoKCj4KPj4gKEJ0dyBJIGRvbid0IGV2ZW4gbm90
aWNlIHRoYXQgdGhlcmUncyB0cmFuc3BvcnQgc3BlY2lmaWMgY29kZSBpbiB2aXJ0aW8KPj4gY29u
c29sZSwgaXQncyBiZXR0ZXIgdG8gYXZvaWQgaXQpCj4+Cj4+IFRoYW5rcwo+IFRoYW5rcywKPiBB
bAo+Cj4+PiAgICAJCS8qIEluY3JlYXNlIGRldmljZSByZWZjbnQgdG8gYXZvaWQgZnJlZWluZyBp
dCAqLwo+Pj4gICAgCQlnZXRfZGV2aWNlKGJ1Zi0+ZGV2KTsKCl9fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fClZpcnR1YWxpemF0aW9uIG1haWxpbmcgbGlzdApW
aXJ0dWFsaXphdGlvbkBsaXN0cy5saW51eC1mb3VuZGF0aW9uLm9yZwpodHRwczovL2xpc3RzLmxp
bnV4Zm91bmRhdGlvbi5vcmcvbWFpbG1hbi9saXN0aW5mby92aXJ0dWFsaXphdGlvbg==
