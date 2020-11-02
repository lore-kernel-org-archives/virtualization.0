Return-Path: <SRS0=4MNw=EI=lists.linux-foundation.org=virtualization-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.1 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CD8F5C388F9
	for <virtualization@archiver.kernel.org>; Mon,  2 Nov 2020 06:36:38 +0000 (UTC)
Received: from whitealder.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 48DAA20874
	for <virtualization@archiver.kernel.org>; Mon,  2 Nov 2020 06:36:38 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="JoL2zlGt"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 48DAA20874
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=virtualization-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by whitealder.osuosl.org (Postfix) with ESMTP id AC0B586A3B;
	Mon,  2 Nov 2020 06:36:37 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from whitealder.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id sHzr6d40Y55R; Mon,  2 Nov 2020 06:36:36 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by whitealder.osuosl.org (Postfix) with ESMTP id 840D2869C7;
	Mon,  2 Nov 2020 06:36:36 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 532F8C088B;
	Mon,  2 Nov 2020 06:36:36 +0000 (UTC)
Received: from hemlock.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by lists.linuxfoundation.org (Postfix) with ESMTP id D5A4BC0051
 for <virtualization@lists.linux-foundation.org>;
 Mon,  2 Nov 2020 06:36:34 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by hemlock.osuosl.org (Postfix) with ESMTP id BC85787034
 for <virtualization@lists.linux-foundation.org>;
 Mon,  2 Nov 2020 06:36:34 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from hemlock.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id 7KB2HJTSt+I0
 for <virtualization@lists.linux-foundation.org>;
 Mon,  2 Nov 2020 06:36:33 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [216.205.24.124])
 by hemlock.osuosl.org (Postfix) with ESMTPS id 9ED438702A
 for <virtualization@lists.linux-foundation.org>;
 Mon,  2 Nov 2020 06:36:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1604298992;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=I9B4wmMBvKVZFK63ow26wucfnWRebEFNTDhzl/lHv1A=;
 b=JoL2zlGtdh0CUe6szdF2cWX5P5jbAKWvd8wnDn0kS5okTZ5jF7moG+GNR8RSTfbJri2vds
 HlFbUEuW0ukKjuOzBLsCQsRmLmiYb3AJPdGp04+2g187w90dYB61K3AZONK/OMtPvtBPze
 4wIlhx+x3mHJPgX4i7Kv47qylhaWSBo=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-505-Z-0m3uwyNymzvH1_s1g-mA-1; Mon, 02 Nov 2020 01:36:30 -0500
X-MC-Unique: Z-0m3uwyNymzvH1_s1g-mA-1
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com
 [10.5.11.15])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id C59161084D62;
 Mon,  2 Nov 2020 06:36:28 +0000 (UTC)
Received: from [10.72.13.42] (ovpn-13-42.pek2.redhat.com [10.72.13.42])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 0C52155764;
 Mon,  2 Nov 2020 06:36:19 +0000 (UTC)
Subject: Re: [PATCH 07/17] vhost scsi: support delayed IO vq creation
To: "Michael S. Tsirkin" <mst@redhat.com>,
 Mike Christie <michael.christie@oracle.com>
References: <1603326903-27052-1-git-send-email-michael.christie@oracle.com>
 <1603326903-27052-8-git-send-email-michael.christie@oracle.com>
 <9e97ea2a-bc57-d4aa-4711-35dba20b3b9e@redhat.com>
 <49c2fc29-348c-06db-4823-392f7476d318@oracle.com>
 <20201030044402-mutt-send-email-mst@kernel.org>
From: Jason Wang <jasowang@redhat.com>
Message-ID: <688e46b6-77f1-1629-0c93-e3a27d582da5@redhat.com>
Date: Mon, 2 Nov 2020 14:36:18 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <20201030044402-mutt-send-email-mst@kernel.org>
Content-Language: en-US
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
Cc: martin.petersen@oracle.com, linux-scsi@vger.kernel.org,
 virtualization@lists.linux-foundation.org, target-devel@vger.kernel.org,
 stefanha@redhat.com, pbonzini@redhat.com
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

Ck9uIDIwMjAvMTAvMzAg5LiL5Y2INDo0NywgTWljaGFlbCBTLiBUc2lya2luIHdyb3RlOgo+IE9u
IFR1ZSwgT2N0IDI3LCAyMDIwIGF0IDEyOjQ3OjM0QU0gLTA1MDAsIE1pa2UgQ2hyaXN0aWUgd3Jv
dGU6Cj4+IE9uIDEwLzI1LzIwIDEwOjUxIFBNLCBKYXNvbiBXYW5nIHdyb3RlOgo+Pj4gT24gMjAy
MC8xMC8yMiDkuIrljYg4OjM0LCBNaWtlIENocmlzdGllIHdyb3RlOgo+Pj4+IEVhY2ggdmhvc3Qt
c2NzaSBkZXZpY2Ugd2lsbCBuZWVkIGEgZXZ0IGFuZCBjdGwgcXVldWUsIGJ1dCB0aGUgbnVtYmVy
Cj4+Pj4gb2YgSU8gcXVldWVzIGRlcGVuZHMgb24gd2hhdGV2ZXIgdGhlIHVzZXIgaGFzIGNvbmZp
Z3VyZWQgaW4gdXNlcnNwYWNlLgo+Pj4+IFRoaXMgcGF0Y2ggaGFzIHZob3N0LXNjc2kgY3JlYXRl
IHRoZSBldnQsIGN0bCBhbmQgb25lIElPIHZxIGF0IGRldmljZQo+Pj4+IG9wZW4gdGltZS4gV2Ug
dGhlbiBjcmVhdGUgdGhlIG90aGVyIElPIHZxcyB3aGVuIHVzZXJzcGFjZSBzdGFydHMgdG8KPj4+
PiBzZXQgdGhlbSB1cC4gV2Ugc3RpbGwgd2FzdGUgc29tZSBtZW0gb24gdGhlIHZxIGFuZCBzY3Np
IHZxIHN0cnVjdHMsCj4+Pj4gYnV0IHdlIGRvbid0IHdhc3RlIG1lbSBvbiBpb3ZlYyByZWxhdGVk
IGFycmF5cyBhbmQgZm9yIGxhdGVyIHBhdGNoZXMKPj4+PiB3ZSBrbm93IHdoaWNoIHF1ZXVlcyBh
cmUgdXNlZCBieSB0aGUgZGV2LT5udnFzIHZhbHVlLgo+Pj4+Cj4+Pj4gU2lnbmVkLW9mZi1ieTog
TWlrZSBDaHJpc3RpZSA8bWljaGFlbC5jaHJpc3RpZUBvcmFjbGUuY29tPgo+Pj4+IC0tLQo+Pj4+
ICDCoCBkcml2ZXJzL3Zob3N0L3Njc2kuYyB8IDE5ICsrKysrKysrKysrKysrKy0tLS0KPj4+PiAg
wqAgMSBmaWxlIGNoYW5nZWQsIDE1IGluc2VydGlvbnMoKyksIDQgZGVsZXRpb25zKC0pCj4+Pgo+
Pj4gTm90IGZhbWlsaWFyIHdpdGggU0NTSS4gQnV0IEkgd29uZGVyIGlmIGl0IGNvdWxkIGJlaGF2
ZSBsaWtlIHZob3N0LW5ldC4KPj4+Cj4+PiBFLmcgdXNlcnNwYWNlIHNob3VsZCBrbm93biB0aGUg
bnVtYmVyIG9mIHZpcnRxdWV1ZXMgc28gaXQgY2FuIGp1c3Qgb3Blbgo+Pj4gYW5kIGNsb3NlIG11
bHRpcGxlIHZob3N0LXNjc2kgZmlsZSBkZXNjcmlwdG9ycy4KPj4+Cj4+IE9uZSBoaWNjdXAgSSdt
IGhpdHRpbmcgaXMgdGhhdCB3ZSBtaWdodCBlbmQgdXAgY3JlYXRpbmcgYWJvdXQgM3ggbW9yZSB2
cXMKPj4gdGhhbiB3ZSBuZWVkLiBUaGUgcHJvYmxlbSBpcyB0aGF0IGZvciBzY3NpIGVhY2ggdmhv
c3QgZGV2aWNlIGhhczoKPj4KPj4gdnE9MDogc3BlY2lhbCBjb250cm9sIHZxCj4+IHZxPTE6IGV2
ZW50IHZxCj4+IHZxPTIgYW5kIGFib3ZlOiBTQ1NJIENNRC9JTyB2cXMuIFdlIHdhbnQgdG8gY3Jl
YXRlIE4gb2YgdGhlc2UuCj4+Cj4+IFRvZGF5IHdlIGRvOgo+Pgo+PiBVZXJzcGFjZSBkb2VzIG9w
ZW4oL2Rldi92aG9zdC1zY3NpKQo+PiAgICAgICAgICB2aG9zdF9kZXZfaW5pdChjcmVhdGUgMTI4
IHZxcyBhbmQgdGhlbiBsYXRlciB3ZSBzZXR1cCBhbmQgdXNlIE4gb2YKPj4gdGhlbSk7Cj4+Cj4+
IFFlbXUgZG9lcyBpb2N0bChWSE9TVF9TRVRfT1dORVIpCj4+ICAgICAgICAgIHZob3N0X2Rldl9z
ZXRfb3duZXIoKQo+Pgo+PiBGb3IgTiB2cXMgdXNlcnNwYWNlIGRvZXM6Cj4+ICAgICAgICAgIC8v
IHZpcnRxdWV1ZSBzZXR1cCByZWxhdGVkIGlvY3Rscwo+Pgo+PiBRZW11IGRvZXMgaW9jdGwoVkhP
U1RfU0NTSV9TRVRfRU5EUE9JTlQpCj4+ICAgICAgICAgIC0gbWF0Y2ggTElPL3RhcmdldCBwb3J0
IHRvIHZob3N0X2Rldgo+Pgo+Pgo+PiBTbyB3ZSBjb3VsZCBjaGFuZ2UgdGhhdCB0bzoKPj4KPj4g
Rm9yIE4gSU8gdnFzIHVzZXJzcGFjZSBkb2VzCj4+ICAgICAgICAgIG9wZW4oL2Rldi92aG9zdC1z
Y3NpKQo+PiAgICAgICAgICAgICAgICAgIHZob3N0X2Rldl9pbml0KGNyZWF0ZSBJTywgZXZ0LCBh
bmQgY3RsKTsKPj4KPj4gZm9yIE4gSU8gdnFzIFFlbXUgZG9lczoKPj4gICAgICAgICAgaW9jdGwo
VkhPU1RfU0VUX09XTkVSKQo+PiAgICAgICAgICAgICAgICAgIHZob3N0X2Rldl9zZXRfb3duZXIo
KQo+Pgo+PiBmb3IgTiBJTyB2cXMgUWVtdSBkb2VzOgo+PiAgICAgICAgICAvLyB2aXJ0cXVldWUg
c2V0dXAgcmVsYXRlZCBpb2N0bHMKPj4KPj4gZm9yIE4gSU8gdnFzIFFlbXUgZG9lczoKPj4gICAg
ICAgICAgaW9jdGwoVkhPU1RfU0NTSV9TRVRfRU5EUE9JTlQpCj4+ICAgICAgICAgICAgICAgICAg
LSBtYXRjaCBMSU8vdGFyZ2V0IHBvcnQgdG8gdmhvc3RfZGV2IGFuZCBhc3NlbWJsZSB0aGUKPj4g
bXVsdGlwbGUgdmhvc3RfZGV2IGRldmljZS4KPj4KPj4gVGhlIHByb2JsZW0gaXMgdGhhdCB3ZSBo
YXZlIHRvIHNldHVwIHNvbWUgb2YgdGhlIGV2dC9jdGwgc3BlY2lmaWMgcGFydHMgYXQKPj4gb3Bl
bigpIHRpbWUgd2hlbiB2aG9zdF9kZXZfaW5pdCBkb2VzIHZob3N0X3BvbGxfaW5pdCBmb3IgZXhh
bXBsZS4KPj4KPj4gLSBBdCBvcGVuIHRpbWUsIHdlIGRvbid0IGtub3cgaWYgdGhpcyB2aG9zdF9k
ZXYgaXMgZ29pbmcgdG8gYmUgcGFydCBvZiBhCj4+IG11bHRpcGxlIHZob3N0X2RldmljZSBkZXZp
Y2Ugb3IgYSBzaW5nbGUgb25lIHNvIHdlIG5lZWQgdG8gY3JlYXRlIGF0IGxlYXN0IDMKPj4gb2Yg
dGhlbQo+PiAtIElmIGl0IGlzIGEgbXVsdGlwbGUgZGV2aWNlIHdlIGRvbid0IGtub3cgaWYgaXRz
IHRoZSBmaXJzdCBkZXZpY2UgYmVpbmcKPj4gY3JlYXRlZCBmb3IgdGhlIGRldmljZSBvciB0aGUg
Tid0aCwgc28gd2UgZG9uJ3Qga25vdyBpZiB0aGUgZGV2J3MgdnFzIHdpbGwKPj4gYmUgdXNlZCBm
b3IgSU8gb3IgY3Rscy9ldnRzLCBzbyB3ZSBoYXZlIHRvIGNyZWF0ZSBhbGwgMy4KPj4KPj4gV2hl
biB3ZSBnZXQgdGhlIGZpcnN0IFZIT1NUX1NDU0lfU0VUX0VORFBPSU5UIGNhbGwgZm9yIGEgbmV3
IHN0eWxlIG11bHRpcGxlCj4+IHZob3N0X2RldiBkZXZpY2UsIHdlIGNhbiB1c2UgdGhhdCBkZXYn
cyBldnQvY3RsIHZxcyBmb3IgZXZlbnRzL2NvbnRyb2xzCj4+IHJlcXVlc3RzLiBXaGVuIHdlIGdl
dCB0aGUgb3RoZXIgVkhPU1RfU0NTSV9TRVRfRU5EUE9JTlQgY2FsbHMgZm9yIHRoZQo+PiBtdWx0
aXBsZSB2aG9zdF9kZXYgZGV2aWNlIHRoZW4gdGhvc2UgZGV2J3MgZXZ0L2N0bCB2cXMgd2lsbCBi
ZSBpZ25vcmVkIGFuZAo+PiB3ZSB3aWxsIG9ubHkgdXNlIHRoZWlyIElPIHZxcy4gU28gd2UgZW5k
IHVwIHdpdGggYSBsb3Qgb2YgZXh0cmEgdnFzLgo+IFRoZSBpc3N1ZSBKYXNvbidzIGhpbnRpbmcg
YXQgaXMgaG93IGNhbiBhZG1pbnMgY29udHJvbCB0aGUgYW1vdW50Cj4gb2YgcmVzb3VyY2VzIGEg
Z2l2ZW4gcWVtdSBpbnN0YW5jZSBjYW4gY29uc3VtZT8KPiBBZnRlciBhbGwgdmhvc3QgdnFzIGFs
bCBsaXZlIGluIGhvc3Qga2VybmVsIG1lbW9yeSAuLi4KPiBMaW1pdGluZyAjIG9mIG9wZW4gZmRz
IHdvdWxkIGJlIG9uZSB3YXkgdG8gZG8gdGhhdCAuLi4KPgo+IFRoZSBuZWVkIHRvIHNoYXJlIGV2
ZW50L2NvbnRyb2wgdnFzIGJldHdlZW4gZGV2aWNlcyBpcyBhIHByb2JsZW0gdGhvdWdoLAo+IGFu
ZCBzZW5kaW5nIGxvdHMgb2YgaW9jdGxzIG9uIHRoaW5ncyBsaWtlIHJlc2V0IGlzIGFsc28gbm90
IHRoYXQgZWxlZ2FudC4KPiBKYXNvbiwgZGlkIHlvdSBoYXZlIGEgZ29vZCBzb2x1dGlvbiBpbiBt
aW5kPwoKCk5vcGUsIEknbSBub3QgZmFtaWxpYXIgd2l0aCBTQ1NJIHNvIEkgZG9uJ3QgZXZlbiBr
bm93IHNoYXJpbmcgZXZ0L2N2cSBpcyAKcG9zc2libGUuIENvbnNpZGVyIFZIT1NUX1NDU0lfTUFY
X1ZRIGlzIGFscmVhZHkgMTI4IHBlciBkZXZpY2UuIE1pa2UncyAKcHJvcG9zYWwgc2VlbXMgdG8g
YmUgYmV0dGVyLgoKVGhhbmtzCgoKPgo+PiBPbmUgb3RoZXIgcXVlc3Rpb24vaXNzdWUgSSBoYXZl
IGlzIHRoYXQgcWVtdSBjYW4gb3BlbiB0aGUgL2Rldi92aG9zdC1zY3NpCj4+IGRldmljZSBvciBp
dCBhbGxvd3MgdG9vbHMgbGlrZSBsaWJ2aXJ0ZCB0byBvcGVuIHRoZSBkZXZpY2UgYW5kIHBhc3Mg
aW4gdGhlCj4+IGZkIHRvIHVzZS4gRm9yIHRoZSBsYXR0ZXIgY2FzZSwgd291bGQgd2UgY29udGlu
dWUgdG8gaGF2ZSB0aG9zZSB0b29scyBwYXNzCj4+IGluIHRoZSBsZWFkaW5nIGZkLCB0aGVuIGhh
dmUgcWVtdSBkbyB0aGUgb3RoZXIgbnVtX3F1ZXVlcyAtIDEKPj4gb3BlbigvZGV2L3Zob3N0LXNj
c2kpIGNhbGxzPyBPciBkbyB0aGVzZSBhcHBzIHRoYXQgcGFzcyBpbiB0aGUgZmQgbmVlZCB0bwo+
PiBrbm93IGFib3V0IGFsbCBvZiB0aGUgZmRzIGZvciBzb21lIG1hbmFnZW1lbnQgcmVhc29uPwo+
IFRoZXkga25vdyBhYm91dCBhbGwgdGhlIGZkcywgZm9yIHJlc291cmNlIGNvbnRyb2wgYW5kIHBy
aXZlbGVkZ2UKPiBzZXBhcmF0aW9uIHJlYXNvbnMuCj4KCl9fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fClZpcnR1YWxpemF0aW9uIG1haWxpbmcgbGlzdApWaXJ0
dWFsaXphdGlvbkBsaXN0cy5saW51eC1mb3VuZGF0aW9uLm9yZwpodHRwczovL2xpc3RzLmxpbnV4
Zm91bmRhdGlvbi5vcmcvbWFpbG1hbi9saXN0aW5mby92aXJ0dWFsaXphdGlvbg==
