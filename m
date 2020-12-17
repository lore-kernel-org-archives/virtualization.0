Return-Path: <SRS0=dJY/=FV=lists.linux-foundation.org=virtualization-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DFCA8C4361B
	for <virtualization@archiver.kernel.org>; Thu, 17 Dec 2020 03:30:40 +0000 (UTC)
Received: from silver.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 0EEEB23716
	for <virtualization@archiver.kernel.org>; Thu, 17 Dec 2020 03:30:39 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0EEEB23716
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=virtualization-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by silver.osuosl.org (Postfix) with ESMTP id 339792E159;
	Thu, 17 Dec 2020 03:30:39 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from silver.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id rbxYOSzt2thn; Thu, 17 Dec 2020 03:30:38 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by silver.osuosl.org (Postfix) with ESMTP id 2C473203E6;
	Thu, 17 Dec 2020 03:30:38 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 0B90AC0893;
	Thu, 17 Dec 2020 03:30:38 +0000 (UTC)
Received: from silver.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by lists.linuxfoundation.org (Postfix) with ESMTP id E0B05C013B
 for <virtualization@lists.linux-foundation.org>;
 Thu, 17 Dec 2020 03:30:36 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by silver.osuosl.org (Postfix) with ESMTP id B4D462E159
 for <virtualization@lists.linux-foundation.org>;
 Thu, 17 Dec 2020 03:30:36 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from silver.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id tGpEUlEfka+b
 for <virtualization@lists.linux-foundation.org>;
 Thu, 17 Dec 2020 03:30:35 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [216.205.24.124])
 by silver.osuosl.org (Postfix) with ESMTPS id 0EA09203E6
 for <virtualization@lists.linux-foundation.org>;
 Thu, 17 Dec 2020 03:30:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1608175833;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=HO6KkKBsPBYL8yo5xJcOwAGMsGPxSzjnmDq5FDQ+Bkg=;
 b=hOLLwjVxfFh4wOWnIKO3spOSkNsD979sSlXIm4JCbsftlObLnZtp7fswaH8tzqNcuYpzMC
 pRqsn0HQ9DoxErO7tWKHmx9bQ8sLAlLbkgwUnSZmlVvsrgiN4bbKFB3sz0nIUT8TXkUJY2
 j3oLUkL3FyRNc3ePLWWass8OfUwLI7A=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-19-XOc3xLNlML-NxSqRAwwukw-1; Wed, 16 Dec 2020 22:30:32 -0500
X-MC-Unique: XOc3xLNlML-NxSqRAwwukw-1
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com
 [10.5.11.12])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 3B86910054FF;
 Thu, 17 Dec 2020 03:30:30 +0000 (UTC)
Received: from [10.72.12.223] (ovpn-12-223.pek2.redhat.com [10.72.12.223])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 4301860C15;
 Thu, 17 Dec 2020 03:30:20 +0000 (UTC)
Subject: Re: [PATCH 00/21] Control VQ support in vDPA
To: "Michael S. Tsirkin" <mst@redhat.com>
References: <20201216064818.48239-1-jasowang@redhat.com>
 <20201216044051-mutt-send-email-mst@kernel.org>
From: Jason Wang <jasowang@redhat.com>
Message-ID: <aa061fcb-9395-3a1b-5d6e-76b5454dfb6c@redhat.com>
Date: Thu, 17 Dec 2020 11:30:18 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <20201216044051-mutt-send-email-mst@kernel.org>
Content-Language: en-US
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
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

Ck9uIDIwMjAvMTIvMTYg5LiL5Y2INTo0NywgTWljaGFlbCBTLiBUc2lya2luIHdyb3RlOgo+IE9u
IFdlZCwgRGVjIDE2LCAyMDIwIGF0IDAyOjQ3OjU3UE0gKzA4MDAsIEphc29uIFdhbmcgd3JvdGU6
Cj4+IEhpIEFsbDoKPj4KPj4gVGhpcyBzZXJpZXMgdHJpZXMgdG8gYWRkIHRoZSBzdXBwb3J0IGZv
ciBjb250cm9sIHZpcnRxdWV1ZSBpbiB2RFBBLgo+Pgo+PiBDb250cm9sIHZpcnRxdWV1ZSBpcyB1
c2VkIGJ5IG5ldHdvcmtpbmcgZGV2aWNlIGZvciBhY2NlcHRpbmcgdmFyaW91cwo+PiBjb21tYW5k
cyBmcm9tIHRoZSBkcml2ZXIuIEl0J3MgYSBtdXN0IHRvIHN1cHBvcnQgbXVsdGlxdWV1ZSBhbmQg
b3RoZXIKPj4gY29uZmlndXJhdGlvbnMuCj4+Cj4+IFdoZW4gdXNlZCBieSB2aG9zdC12RFBBIGJ1
cyBkcml2ZXIgZm9yIFZNLCB0aGUgY29udHJvbCB2aXJ0cXVldWUKPj4gc2hvdWxkIGJlIHNoYWRv
d2VkIHZpYSB1c2Vyc3BhY2UgVk1NIChRZW11KSBpbnN0ZWFkIG9mIGJlaW5nIGFzc2lnbmVkCj4+
IGRpcmVjdGx5IHRvIEd1ZXN0LiBUaGlzIGlzIGJlY2F1c2UgUWVtdSBuZWVkcyB0byBrbm93IHRo
ZSBkZXZpY2Ugc3RhdGUKPj4gaW4gb3JkZXIgdG8gc3RhcnQgYW5kIHN0b3AgZGV2aWNlIGNvcnJl
Y3RseSAoZS5nIGZvciBMaXZlIE1pZ3JhdGlvbikuCj4+Cj4+IFRoaXMgcmVxdWllcyB0byBpc29s
YXRlIHRoZSBtZW1vcnkgbWFwcGluZyBmb3IgY29udHJvbCB2aXJ0cXVldWUKPj4gcHJlc2VudGVk
IGJ5IHZob3N0LXZEUEEgdG8gcHJldmVudCBndWVzdCBmcm9tIGFjY2VzaW5nIGl0IGRpcmVjdGx5
Lgo+PiBUbyBhY2hpZXZlIHRoaXMsIHZEUEEgaW50cm9kdWNlIHR3byBuZXcgYWJzdHJhY3Rpb25z
Ogo+Pgo+PiAtIGFkZHJlc3Mgc3BhY2U6IGlkZW50aWZpZWQgdGhyb3VnaCBhZGRyZXNzIHNwYWNl
IGlkIChBU0lEKSBhbmQgYSBzZXQKPj4gICAgICAgICAgICAgICAgICAgb2YgbWVtb3J5IG1hcHBp
bmcgaW4gbWFpbnRhaW5lZAo+PiAtIHZpcnRxdWV1ZSBncm91cDogdGhlIG1pbmltYWwgc2V0IG9m
IHZpcnRxdWV1ZXMgdGhhdCBtdXN0IHNoYXJlIGFuCj4+ICAgICAgICAgICAgICAgICAgIGFkZHJl
c3Mgc3BhY2UKPiBIb3cgd2lsbCB0aGlzIHN1cHBvcnQgdGhlIHByZXR0eSBjb21tb24gY2FzZSB3
aGVyZSBjb250cm9sIHZxCj4gaXMgcHJvZ3JhbW1lZCBieSB0aGUga2VybmVsIHRocm91Z2ggdGhl
IFBGLCBhbmQgb3RoZXJzIGJ5IHRoZSBWRnM/CgoKSW4gdGhpcyBjYXNlLCB0aGUgVkYgcGFyZW50
IG5lZWQgdG8gcHJvdmlkZSBhIHNvZnR3YXJlIGNvbnRyb2wgdnEgYW5kIApkZWNvZGUgdGhlIGNv
bW1hbmQgdGhlbiBzZW5kIHRoZW0gdG8gVkYuCgoKPgo+Cj4gSSBhY3R1YWxseSB0aG91Z2h0IHRo
ZSB3YXkgdG8gc3VwcG9ydCBpdCBpcyBieSBleHBvc2luZwo+IHNvbWV0aGluZyBsaWtlIGFuICJp
bmplY3QgYnVmZmVycyIgQVBJIHdoaWNoIHNlbmRzIGRhdGEgdG8gYSBnaXZlbiBWUS4KPiBNYXli
ZSBhbiBpb2N0bCwgYW5kIG1heWJlIGRvd24gdGhlIHJvYWQgdWlvIHJpbmcgY2FuIHN1cHBvcnQg
YmF0Y2hpbmcKPiB0aGVzZSAuLi4uCgoKU28gdGhlIHZpcnR1cXVldWUgYWxsb3dzIHRoZSByZXF1
ZXN0IHRvIGJlIHByb2Nlc3NlZCBhc3luY2hyb25vdXNseSAoZS5nIApkcml2ZXIgbWF5IGNob29z
ZSB0byB1c2UgaW50ZXJydXB0IGZvciBjb250cm9sIHZxKS4gVGhpcyBtZWFucyB3ZSBuZWVkIAp0
byBzdXBwb3J0IHRoYXQgaW4gdUFQSSBsZXZlbC4gQW5kIGlmIHdlIG1hbmFnZSB0byBkbyB0aGF0
LCBpdCdzIGp1c3QgCmFub3RoZXIgdHlwZSBvZiB2aXJ0cXVldWUuCgpGb3IgdmlydGlvLXZEUEEs
IHRoaXMgYWxzbyBtZWFucyB0aGUgZXh0ZW5zaW9ucyBmb3IgcXVldWUgcHJvY2Vzc2luZyAKd2hp
Y2ggaXMgYSBmdW5jdGlvbmFsIGR1cGxpY2F0aW9uLiBVc2luZyB3aGF0IHByb3Bvc2VkIGluIHRo
aXMgc2VyaWVzLCAKd2UgZG9uJ3QgbmVlZCBhbnkgY2hhbmdlcyBmb3Iga2VybmVsIHZpcnRpbyBk
cml2ZXJzLgoKV2hhdCdzIG1vcmUgaW1wb3J0YW50LCB0aGlzIHNlcmllcyBjb3VsZCBiZSB1c2Vk
IGZvciBmdXR1cmUgZmVhdHVyZXMgCnRoYXQgcmVxdWlyZXMgRE1BIGlzb2xhdGlvbiBiZXR3ZWVu
IHZpcnRxdWV1ZXM6CgotIHJlcG9ydCBkaXJ0eSBwYWdlcyB2aWEgdmlydHF1ZXVlCi0gc3ViIGZ1
bmN0aW9uIGxldmVsIGRldmljZSBzbGljaW5nCgouLi4KClRoYW5rcwoKCj4KPgo+PiBEZXZpY2Ug
bmVlZHMgdG8gYWR2ZXJ0aXNlIHRoZSBmb2xsb3dpbmcgYXR0cmlidXRlcyB0byB2RFBBOgo+Pgo+
PiAtIHRoZSBudW1iZXIgb2YgYWRkcmVzcyBzcGFjZXMgc3VwcG9ydGVkIGluIHRoZSBkZXZpY2UK
Pj4gLSB0aGUgbnVtYmVyIG9mIHZpcnRxdWV1ZSBncm91cHMgc3VwcG9ydGVkIGluIHRoZSBkZXZp
Y2UKPj4gLSB0aGUgbWFwcGluZ3MgZnJvbSBhIHNwZWNpZmljIHZpcnRxdWV1ZSB0byBpdHMgdmly
dHF1ZXVlIGdyb3Vwcwo+Pgo+PiBUaGUgbWFwcGluZ3MgZnJvbSB2aXJ0cXVldWUgdG8gdmlydHF1
ZXVlIGdyb3VwcyBpcyBmaXhlZCBhbmQgZGVmaW5lZAo+PiBieSB2RFBBIGRldmljZSBkcml2ZXIu
IEUuZzoKPj4KPj4gLSBGb3IgdGhlIGRldmljZSB0aGF0IGhhcyBoYXJkd2FyZSBBU0lEIHN1cHBv
cnQsIGl0IGNhbiBzaW1wbHkKPj4gICAgYWR2ZXJ0aXNlIGEgcGVyIHZpcnRxdWV1ZSB2aXJ0cXVl
dWUgZ3JvdXAuCj4+IC0gRm9yIHRoZSBkZXZpY2UgdGhhdCBkb2VzIG5vdCBoYXZlIGhhcmR3YXJl
IEFTSUQgc3VwcG9ydCwgaXQgY2FuCj4+ICAgIHNpbXBseSBhZHZlcnRpc2UgYSBzaW5nbGUgdmly
dHF1ZXVlIGdyb3VwIHRoYXQgY29udGFpbnMgYWxsCj4+ICAgIHZpcnRxdWV1ZXMuIE9yIGlmIGl0
IHdhbnRzIGEgc29mdHdhcmUgZW11bGF0ZWQgY29udHJvbCB2aXJ0cXVldWUsIGl0Cj4+ICAgIGNh
biBhZHZlcnRpc2UgdHdvIHZpcnRxdWV1ZSBncm91cHMsIG9uZSBpcyBmb3IgY3ZxLCBhbm90aGVy
IGlzIGZvcgo+PiAgICB0aGUgcmVzdCB2aXJ0cXVldWVzLgo+Pgo+PiB2RFBBIGFsc28gYWxsb3cg
dG8gY2hhbmdlIHRoZSBhc3NvY2lhdGlvbiBiZXR3ZWVuIHZpcnRxdWV1ZSBncm91cCBhbmQKPj4g
YWRkcmVzcyBzcGFjZS4gU28gaW4gdGhlIGNhc2Ugb2YgY29udHJvbCB2aXJ0cXVldWUsIHVzZXJz
cGFjZQo+PiBWTU0oUWVtdSkgbWF5IHVzZSBhIGRlZGljYXRlZCBhZGRyZXNzIHNwYWNlIGZvciB0
aGUgY29udHJvbCB2aXJ0cXVldWUKPj4gZ3JvdXAgdG8gaXNvbGF0ZSB0aGUgbWVtb3J5IG1hcHBp
bmcuCj4+Cj4+IFRoZSB2aG9zdC92aG9zdC12RFBBIGlzIGFsc28gZXh0ZW5kIGZvciB0aGUgdXNl
cnNwYWNlIHRvOgo+Pgo+PiAtIHF1ZXJ5IHRoZSBudW1iZXIgb2YgdmlydHF1ZXVlIGdyb3VwcyBh
bmQgYWRkcmVzcyBzcGFjZXMgc3VwcG9ydGVkIGJ5Cj4+ICAgIHRoZSBkZXZpY2UKPj4gLSBxdWVy
eSB0aGUgdmlydHF1ZXVlIGdyb3VwIGZvciBhIHNwZWNpZmljIHZpcnRxdWV1ZQo+PiAtIGFzc29j
YWl0ZSBhIHZpcnRxdWV1ZSBncm91cCB3aXRoIGFuIGFkZHJlc3Mgc3BhY2UKPj4gLSBzZW5kIEFT
SUQgYmFzZWQgSU9UTEIgY29tbWFuZHMKPj4KPj4gVGhpcyB3aWxsIGhlbHAgdXNlcnNwYWNlIFZN
TShRZW11KSB0byBkZXRlY3Qgd2hldGhlciB0aGUgY29udHJvbCB2cQo+PiBjb3VsZCBiZSBzdXBw
b3J0ZWQgYW5kIGlzb2xhdGUgbWVtb3J5IG1hcHBpbmdzIG9mIGNvbnRyb2wgdmlydHF1ZXVlCj4+
IGZyb20gdGhlIG90aGVycy4KPj4KPj4gVG8gZGVtb25zdHJhdGUgdGhlIHVzYWdlLCB2RFBBIHNp
bXVsYXRvciBpcyBleHRlbmRlZCB0byBzdXBwb3J0Cj4+IHNldHRpbmcgTUFDIGFkZHJlc3Mgdmlh
IGEgZW11bGF0ZWQgY29udHJvbCB2aXJ0cXVldWUuCj4+Cj4+IFBsZWFzZSByZXZpZXcuCj4+Cj4+
IENoYW5nZXMgc2luY2UgUkZDOgo+Pgo+PiAtIHR3ZWFrIHZob3N0IHVBUEkgZG9jdW1lbnRhdGlv
bgo+PiAtIHN3aXRjaCB0byB1c2UgZGV2aWNlIHNwZWNpZmljIElPVExCIHJlYWxseSBpbiBwYXRj
aCA0Cj4+IC0gdHdlYWsgdGhlIGNvbW1pdCBsb2cKPj4gLSBmaXggdGhhdCBBU0lEIGluIHZob3N0
IGlzIGNsYWltZWQgdG8gYmUgMzIgYWN0dWFsbHkgYnV0IDE2Yml0Cj4+ICAgIGFjdHVhbGx5Cj4+
IC0gZml4IHVzZSBhZnRlciBmcmVlIHdoZW4gdXNpbmcgQVNJRCB3aXRoIElPVExCIGJhdGNoaW5n
IHJlcXVlc3RzCj4+IC0gc3dpdGNoIHRvIHVzZSBTdGVmYW5vJ3MgcGF0Y2ggZm9yIGhhdmluZyBz
ZXBhcmF0ZWQgaW92Cj4+IC0gcmVtb3ZlIHVudXNlZCAidXNlZF9hcyIgdmFyaWFibGUKPj4gLSBm
aXggdGhlIGlvdGxiL2FzaWQgY2hlY2tpbmcgaW4gdmhvc3RfdmRwYV91bm1hcCgpCj4+Cj4+IFRo
YW5rcwo+Pgo+PiBKYXNvbiBXYW5nICgyMCk6Cj4+ICAgIHZob3N0OiBtb3ZlIHRoZSBiYWNrZW5k
IGZlYXR1cmUgYml0cyB0byB2aG9zdF90eXBlcy5oCj4+ICAgIHZpcnRpby12ZHBhOiBkb24ndCBz
ZXQgY2FsbGJhY2sgaWYgdmlydGlvIGRvZXNuJ3QgbmVlZCBpdAo+PiAgICB2aG9zdC12ZHBhOiBw
YXNzaW5nIGlvdGxiIHRvIElPTU1VIG1hcHBpbmcgaGVscGVycwo+PiAgICB2aG9zdC12ZHBhOiBz
d2l0Y2ggdG8gdXNlIHZob3N0LXZkcGEgc3BlY2lmaWMgSU9UTEIKPj4gICAgdmRwYTogYWRkIHRo
ZSBtaXNzaW5nIGNvbW1lbnQgZm9yIG52cXMgaW4gc3RydWN0IHZkcGFfZGV2aWNlCj4+ICAgIHZk
cGE6IGludHJvZHVjZSB2aXJ0cXVldWUgZ3JvdXBzCj4+ICAgIHZkcGE6IG11bHRpcGxlIGFkZHJl
c3Mgc3BhY2VzIHN1cHBvcnQKPj4gICAgdmRwYTogaW50cm9kdWNlIGNvbmZpZyBvcGVyYXRpb25z
IGZvciBhc3NvY2lhdGluZyBBU0lEIHRvIGEgdmlydHF1ZXVlCj4+ICAgICAgZ3JvdXAKPj4gICAg
dmhvc3RfaW90bGI6IHNwbGl0IG91dCBJT1RMQiBpbml0aWFsaXphdGlvbgo+PiAgICB2aG9zdDog
c3VwcG9ydCBBU0lEIGluIElPVExCIEFQSQo+PiAgICB2aG9zdC12ZHBhOiBpbnRyb2R1Y2UgYXNp
ZCBiYXNlZCBJT1RMQgo+PiAgICB2aG9zdC12ZHBhOiBpbnRyb2R1Y2UgdUFQSSB0byBnZXQgdGhl
IG51bWJlciBvZiB2aXJ0cXVldWUgZ3JvdXBzCj4+ICAgIHZob3N0LXZkcGE6IGludHJvZHVjZSB1
QVBJIHRvIGdldCB0aGUgbnVtYmVyIG9mIGFkZHJlc3Mgc3BhY2VzCj4+ICAgIHZob3N0LXZkcGE6
IHVBUEkgdG8gZ2V0IHZpcnRxdWV1ZSBncm91cCBpZAo+PiAgICB2aG9zdC12ZHBhOiBpbnRyb2R1
Y2UgdUFQSSB0byBzZXQgZ3JvdXAgQVNJRAo+PiAgICB2aG9zdC12ZHBhOiBzdXBwb3J0IEFTSUQg
YmFzZWQgSU9UTEIgQVBJCj4+ICAgIHZkcGFfc2ltOiBhZHZlcnRpc2UgVklSVElPX05FVF9GX01U
VQo+PiAgICB2ZHBhX3NpbTogZmFjdG9yIG91dCBidWZmZXIgY29tcGxldGlvbiBsb2dpYwo+PiAg
ICB2ZHBhX3NpbTogZmlsdGVyIGRlc3RpbmF0aW9uIG1hYyBhZGRyZXNzCj4+ICAgIHZkcGFzaW06
IGNvbnRyb2wgdmlydHF1ZXVlIHN1cHBvcnQKPj4KPj4gU3RlZmFubyBHYXJ6YXJlbGxhICgxKToK
Pj4gICAgdmRwYV9zaW06IHNwbGl0IHZkcGFzaW1fdmlydHF1ZXVlJ3MgaW92IGZpZWxkIGluIG91
dF9pb3YgYW5kIGluX2lvdgo+Pgo+PiAgIGRyaXZlcnMvdmRwYS9pZmN2Zi9pZmN2Zl9tYWluLmMg
ICB8ICAgOSArLQo+PiAgIGRyaXZlcnMvdmRwYS9tbHg1L25ldC9tbHg1X3ZuZXQuYyB8ICAxMSAr
LQo+PiAgIGRyaXZlcnMvdmRwYS92ZHBhLmMgICAgICAgICAgICAgICB8ICAgOCArLQo+PiAgIGRy
aXZlcnMvdmRwYS92ZHBhX3NpbS92ZHBhX3NpbS5jICB8IDI5MiArKysrKysrKysrKysrKysrKysr
KysrKystLS0tLS0KPj4gICBkcml2ZXJzL3Zob3N0L2lvdGxiLmMgICAgICAgICAgICAgfCAgMjMg
KystCj4+ICAgZHJpdmVycy92aG9zdC92ZHBhLmMgICAgICAgICAgICAgIHwgMjQ2ICsrKysrKysr
KysrKysrKysrKysrLS0tLS0KPj4gICBkcml2ZXJzL3Zob3N0L3Zob3N0LmMgICAgICAgICAgICAg
fCAgMjMgKystCj4+ICAgZHJpdmVycy92aG9zdC92aG9zdC5oICAgICAgICAgICAgIHwgICA0ICst
Cj4+ICAgZHJpdmVycy92aXJ0aW8vdmlydGlvX3ZkcGEuYyAgICAgIHwgICAyICstCj4+ICAgaW5j
bHVkZS9saW51eC92ZHBhLmggICAgICAgICAgICAgIHwgIDQyICsrKystCj4+ICAgaW5jbHVkZS9s
aW51eC92aG9zdF9pb3RsYi5oICAgICAgIHwgICAyICsKPj4gICBpbmNsdWRlL3VhcGkvbGludXgv
dmhvc3QuaCAgICAgICAgfCAgMjUgKystCj4+ICAgaW5jbHVkZS91YXBpL2xpbnV4L3Zob3N0X3R5
cGVzLmggIHwgIDEwICstCj4+ICAgMTMgZmlsZXMgY2hhbmdlZCwgNTYxIGluc2VydGlvbnMoKyks
IDEzNiBkZWxldGlvbnMoLSkKPj4KPj4gLS0gCj4+IDIuMjUuMQoKX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX18KVmlydHVhbGl6YXRpb24gbWFpbGluZyBsaXN0
ClZpcnR1YWxpemF0aW9uQGxpc3RzLmxpbnV4LWZvdW5kYXRpb24ub3JnCmh0dHBzOi8vbGlzdHMu
bGludXhmb3VuZGF0aW9uLm9yZy9tYWlsbWFuL2xpc3RpbmZvL3ZpcnR1YWxpemF0aW9u
