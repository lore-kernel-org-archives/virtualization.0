Return-Path: <SRS0=st/B=FW=lists.linux-foundation.org=virtualization-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.0 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 32245C4361B
	for <virtualization@archiver.kernel.org>; Fri, 18 Dec 2020 02:56:56 +0000 (UTC)
Received: from silver.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 9D3D0233F6
	for <virtualization@archiver.kernel.org>; Fri, 18 Dec 2020 02:56:55 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9D3D0233F6
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=virtualization-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by silver.osuosl.org (Postfix) with ESMTP id 23EED228AC;
	Fri, 18 Dec 2020 02:56:55 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from silver.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id rfCqEc-DDUf2; Fri, 18 Dec 2020 02:56:52 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by silver.osuosl.org (Postfix) with ESMTP id C300C2151F;
	Fri, 18 Dec 2020 02:56:52 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id AD5A6C1786;
	Fri, 18 Dec 2020 02:56:52 +0000 (UTC)
Received: from hemlock.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 212F3C0893
 for <virtualization@lists.linux-foundation.org>;
 Fri, 18 Dec 2020 02:56:52 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by hemlock.osuosl.org (Postfix) with ESMTP id 079EE86FA2
 for <virtualization@lists.linux-foundation.org>;
 Fri, 18 Dec 2020 02:56:52 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from hemlock.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id PdeDQTpj0Qmj
 for <virtualization@lists.linux-foundation.org>;
 Fri, 18 Dec 2020 02:56:51 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [216.205.24.124])
 by hemlock.osuosl.org (Postfix) with ESMTPS id 042B186FA0
 for <virtualization@lists.linux-foundation.org>;
 Fri, 18 Dec 2020 02:56:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1608260209;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=2ePTASZu7o5kc6K1mUETLMnjXTOm0ohdFm+SE6FW+4Q=;
 b=h+2SrHDYWCmexBAZmL6qKW6VeZbrkrR0UTnRfYSGDYrTWV5sMlw3bzNDfFxK6cWdjWJceI
 ThogXm6oIN69rMWdLrlaop868R/9XEiQK34IomaB0mSB4aOOih2fOV4yARGKeF50FbPktE
 GkQtRb1wm7XEs0z4zumPEco/KHpaMek=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-565-OLEgDrvnOK2yHbrNBpqEig-1; Thu, 17 Dec 2020 21:56:48 -0500
X-MC-Unique: OLEgDrvnOK2yHbrNBpqEig-1
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com
 [10.5.11.23])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 89BA7107ACF5;
 Fri, 18 Dec 2020 02:56:46 +0000 (UTC)
Received: from [10.72.12.111] (ovpn-12-111.pek2.redhat.com [10.72.12.111])
 by smtp.corp.redhat.com (Postfix) with ESMTP id C19BB1A8A1;
 Fri, 18 Dec 2020 02:56:36 +0000 (UTC)
Subject: Re: [PATCH 00/21] Control VQ support in vDPA
To: "Michael S. Tsirkin" <mst@redhat.com>
References: <20201216064818.48239-1-jasowang@redhat.com>
 <20201216044051-mutt-send-email-mst@kernel.org>
 <aa061fcb-9395-3a1b-5d6e-76b5454dfb6c@redhat.com>
 <20201217025410-mutt-send-email-mst@kernel.org>
 <61b60985-142b-10f2-58b8-1d9f57c0cfca@redhat.com>
 <20201217163513-mutt-send-email-mst@kernel.org>
From: Jason Wang <jasowang@redhat.com>
Message-ID: <c120d0ce-7d42-ab6e-1040-ab85985f7cbe@redhat.com>
Date: Fri, 18 Dec 2020 10:56:34 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <20201217163513-mutt-send-email-mst@kernel.org>
Content-Language: en-US
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
Cc: kvm@vger.kernel.org, lulu@redhat.com, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org, virtualization@lists.linux-foundation.org,
 eperezma@redhat.com, stefanha@redhat.com, eli@mellanox.com,
 lingshan.zhu@intel.com, rob.miller@broadcom.com
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

Ck9uIDIwMjAvMTIvMTgg5LiK5Y2INjoyOCwgTWljaGFlbCBTLiBUc2lya2luIHdyb3RlOgo+IE9u
IFRodSwgRGVjIDE3LCAyMDIwIGF0IDA1OjAyOjQ5UE0gKzA4MDAsIEphc29uIFdhbmcgd3JvdGU6
Cj4+IE9uIDIwMjAvMTIvMTcg5LiL5Y2IMzo1OCwgTWljaGFlbCBTLiBUc2lya2luIHdyb3RlOgo+
Pj4gT24gVGh1LCBEZWMgMTcsIDIwMjAgYXQgMTE6MzA6MThBTSArMDgwMCwgSmFzb24gV2FuZyB3
cm90ZToKPj4+PiBPbiAyMDIwLzEyLzE2IOS4i+WNiDU6NDcsIE1pY2hhZWwgUy4gVHNpcmtpbiB3
cm90ZToKPj4+Pj4gT24gV2VkLCBEZWMgMTYsIDIwMjAgYXQgMDI6NDc6NTdQTSArMDgwMCwgSmFz
b24gV2FuZyB3cm90ZToKPj4+Pj4+IEhpIEFsbDoKPj4+Pj4+Cj4+Pj4+PiBUaGlzIHNlcmllcyB0
cmllcyB0byBhZGQgdGhlIHN1cHBvcnQgZm9yIGNvbnRyb2wgdmlydHF1ZXVlIGluIHZEUEEuCj4+
Pj4+Pgo+Pj4+Pj4gQ29udHJvbCB2aXJ0cXVldWUgaXMgdXNlZCBieSBuZXR3b3JraW5nIGRldmlj
ZSBmb3IgYWNjZXB0aW5nIHZhcmlvdXMKPj4+Pj4+IGNvbW1hbmRzIGZyb20gdGhlIGRyaXZlci4g
SXQncyBhIG11c3QgdG8gc3VwcG9ydCBtdWx0aXF1ZXVlIGFuZCBvdGhlcgo+Pj4+Pj4gY29uZmln
dXJhdGlvbnMuCj4+Pj4+Pgo+Pj4+Pj4gV2hlbiB1c2VkIGJ5IHZob3N0LXZEUEEgYnVzIGRyaXZl
ciBmb3IgVk0sIHRoZSBjb250cm9sIHZpcnRxdWV1ZQo+Pj4+Pj4gc2hvdWxkIGJlIHNoYWRvd2Vk
IHZpYSB1c2Vyc3BhY2UgVk1NIChRZW11KSBpbnN0ZWFkIG9mIGJlaW5nIGFzc2lnbmVkCj4+Pj4+
PiBkaXJlY3RseSB0byBHdWVzdC4gVGhpcyBpcyBiZWNhdXNlIFFlbXUgbmVlZHMgdG8ga25vdyB0
aGUgZGV2aWNlIHN0YXRlCj4+Pj4+PiBpbiBvcmRlciB0byBzdGFydCBhbmQgc3RvcCBkZXZpY2Ug
Y29ycmVjdGx5IChlLmcgZm9yIExpdmUgTWlncmF0aW9uKS4KPj4+Pj4+Cj4+Pj4+PiBUaGlzIHJl
cXVpZXMgdG8gaXNvbGF0ZSB0aGUgbWVtb3J5IG1hcHBpbmcgZm9yIGNvbnRyb2wgdmlydHF1ZXVl
Cj4+Pj4+PiBwcmVzZW50ZWQgYnkgdmhvc3QtdkRQQSB0byBwcmV2ZW50IGd1ZXN0IGZyb20gYWNj
ZXNpbmcgaXQgZGlyZWN0bHkuCj4+Pj4+PiBUbyBhY2hpZXZlIHRoaXMsIHZEUEEgaW50cm9kdWNl
IHR3byBuZXcgYWJzdHJhY3Rpb25zOgo+Pj4+Pj4KPj4+Pj4+IC0gYWRkcmVzcyBzcGFjZTogaWRl
bnRpZmllZCB0aHJvdWdoIGFkZHJlc3Mgc3BhY2UgaWQgKEFTSUQpIGFuZCBhIHNldAo+Pj4+Pj4g
ICAgICAgICAgICAgICAgICAgICBvZiBtZW1vcnkgbWFwcGluZyBpbiBtYWludGFpbmVkCj4+Pj4+
PiAtIHZpcnRxdWV1ZSBncm91cDogdGhlIG1pbmltYWwgc2V0IG9mIHZpcnRxdWV1ZXMgdGhhdCBt
dXN0IHNoYXJlIGFuCj4+Pj4+PiAgICAgICAgICAgICAgICAgICAgIGFkZHJlc3Mgc3BhY2UKPj4+
Pj4gSG93IHdpbGwgdGhpcyBzdXBwb3J0IHRoZSBwcmV0dHkgY29tbW9uIGNhc2Ugd2hlcmUgY29u
dHJvbCB2cQo+Pj4+PiBpcyBwcm9ncmFtbWVkIGJ5IHRoZSBrZXJuZWwgdGhyb3VnaCB0aGUgUEYs
IGFuZCBvdGhlcnMgYnkgdGhlIFZGcz8KPj4+PiBJbiB0aGlzIGNhc2UsIHRoZSBWRiBwYXJlbnQg
bmVlZCB0byBwcm92aWRlIGEgc29mdHdhcmUgY29udHJvbCB2cSBhbmQgZGVjb2RlCj4+Pj4gdGhl
IGNvbW1hbmQgdGhlbiBzZW5kIHRoZW0gdG8gVkYuCj4+PiBCdXQgaG93IGRvZXMgdGhhdCB0aWUg
dG8gdGhlIGFkZHJlc3Mgc3BhY2UgaW5mcmFzdHJ1Y3R1cmU/Cj4+IEluIHRoaXMgY2FzZSwgYWRk
cmVzcyBzcGFjZSBpcyBub3QgYSBtdXN0Lgo+IFRoYXQncyBvaywgcHJvYmxlbSBpcyBJIGRvbid0
IHNlZSBob3cgYWRkcmVzcyBzcGFjZSBpcyBnb2luZwo+IHRvIHdvcmsgaW4gdGhpcyBjYXNlIGF0
IGFsbC4KPgo+IFRoZXJlJ3Mgbm8gYWRkcmVzcyBzcGFjZSB0aGVyZSB0aGF0IHVzZXJzcGFjZS9n
dWVzdCBjYW4gY29udHJvbC4KPgoKVGhlIHZpcnRxdWV1ZSBncm91cCBpcyBtYW5kYXRlZCBieSBw
YXJlbnQgYnV0IHRoZSBhc3NvY2lhdGlvbiBiZXR3ZWVuIAp2aXJ0cXVldWUgZ3JvdXAgYW5kIGFk
ZHJlc3Mgc3BhY2UgaXMgdW5kZXIgdGhlIGNvbnRyb2wgb2YgdXNlcnNwYWNlIChRZW11KS4KCkEg
c2ltcGxlIGJ1dCBjb21tb24gY2FzZSBpcyB0aGF0OgoKMSkgRGV2aWNlIGFkdmVydGlzZSB0d28g
dmlydHF1ZXVlIGdyb3VwczogZ3JvdXAgMCBjb250YWlucyBSWCBhbmQgVFgsIApncm91cCAxIGNv
bnRhaW5zIENWUS4KMikgRGV2aWNlIGFkdmVydGlzZSB0d28gYWRkcmVzcyBzcGFjZXMKClRoZW4s
IGZvciB2aG9zdC12RFBBIHVzaW5nIGJ5IFZNOgoKMSkgYXNzb2NpYXRlIGdyb3VwIDAgd2l0aCBh
cyAwLCBncm91cCAxIHdpdGggYXMgMSAodmlhIHZob3N0LXZEUEEgClZIT1NUX1ZEUEFfU0VUX0dS
T1VQX0FTSUQpCjIpIFB1Ymxpc2ggZ3Vlc3QgbWVtb3J5IG1hcHBpbmcgdmlhIElPVExCIGFzaWQg
MAozKSBQdWJsaXNoIGNvbnRyb2wgdmlydHF1ZXVlIG1hcHBpbmcgdmlhIElPVExCIGFzaWQgMQoK
VGhlbiB0aGUgRE1BIGlzIHRvdGFsbHkgaXNvbGF0ZWQgaW4gdGhpcyBjYXNlLgoKRm9yIHZob3N0
LXZEUEEgdXNpbmcgYnkgRFBESyBvciB2aXJ0aW8tdkRQQQoKMSkgYXNzb2NpYXRlIGdyb3VwIDAg
YW5kIGdyb3VwIDEgd2l0aCBhcyAwCgpzaW5jZSB3ZSBkb24ndCBuZWVkIERNQSBpc29sYXRpb24g
aW4gdGhpcyBjYXNlLgoKSW4gb3JkZXIgdG8gbGV0IGl0IGJlIGNvbnRyb2xsZWQgYnkgR3Vlc3Qs
IHdlIG5lZWQgZXh0ZW5kIHZpcnRpbyBzcGVjIHRvIApzdXBwb3J0IHRob3NlIGNvbmNlcHRzLgoK
VGhhbmtzCgoKX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18K
VmlydHVhbGl6YXRpb24gbWFpbGluZyBsaXN0ClZpcnR1YWxpemF0aW9uQGxpc3RzLmxpbnV4LWZv
dW5kYXRpb24ub3JnCmh0dHBzOi8vbGlzdHMubGludXhmb3VuZGF0aW9uLm9yZy9tYWlsbWFuL2xp
c3RpbmZvL3ZpcnR1YWxpemF0aW9u
