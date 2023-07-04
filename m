Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 11463EB64D9
	for <virtualization@archiver.kernel.org>; Tue,  4 Jul 2023 13:17:38 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 483FD606BF;
	Tue,  4 Jul 2023 13:17:38 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 483FD606BF
Authentication-Results: smtp3.osuosl.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=DjhPbrsj
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
	by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id O7LY0hK4VhbO; Tue,  4 Jul 2023 13:17:37 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp3.osuosl.org (Postfix) with ESMTPS id 319AF60B49;
	Tue,  4 Jul 2023 13:17:36 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 319AF60B49
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id E8C59C0072;
	Tue,  4 Jul 2023 13:17:35 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [IPv6:2605:bc80:3010::136])
 by lists.linuxfoundation.org (Postfix) with ESMTP id B660DC0032
 for <virtualization@lists.linux-foundation.org>;
 Tue,  4 Jul 2023 13:17:33 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id 83C9560B49
 for <virtualization@lists.linux-foundation.org>;
 Tue,  4 Jul 2023 13:17:33 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 83C9560B49
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id ydIGmkhbq0PA
 for <virtualization@lists.linux-foundation.org>;
 Tue,  4 Jul 2023 13:17:32 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 8348C606BF
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.133.124])
 by smtp3.osuosl.org (Postfix) with ESMTPS id 8348C606BF
 for <virtualization@lists.linux-foundation.org>;
 Tue,  4 Jul 2023 13:17:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1688476651;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=kRXNwgWnFU9ZqZTTaRpnSrUAwofFRUsqVGfrl1t654U=;
 b=DjhPbrsjBiel1DFiH+uE1016na+qck9JjoiTRuUKuaJ2xT1hU0olF3r0W7oSdg/YVd23EZ
 6p1oVebOr0cPhij158OQqSEo5BPPHS71URpzHvMXfU1k+jO2x3fqqzWPOu7H7esn9O/STJ
 RxYbtTW9YiYumqftKfM4T6JXCNJCdrw=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-116-7jjORAkmPd25ysBKCGMs1Q-1; Tue, 04 Jul 2023 09:17:27 -0400
X-MC-Unique: 7jjORAkmPd25ysBKCGMs1Q-1
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.rdu2.redhat.com
 [10.11.54.1])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 5FAE41044594;
 Tue,  4 Jul 2023 13:17:27 +0000 (UTC)
Received: from [10.39.208.32] (unknown [10.39.208.32])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 6CC7140C2063;
 Tue,  4 Jul 2023 13:17:25 +0000 (UTC)
Message-ID: <8128857f-e292-2e41-cdb9-9c5d4a2f79c7@redhat.com>
Date: Tue, 4 Jul 2023 15:17:22 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.12.0
Subject: Re: [PATCH v1 0/2] vduse: add support for networking devices
Content-Language: en-US
To: "Michael S. Tsirkin" <mst@redhat.com>
References: <20230627113652.65283-1-maxime.coquelin@redhat.com>
 <20230702093530-mutt-send-email-mst@kernel.org>
 <CACGkMEtoW0nW8w6_Ew8qckjvpNGN_idwpU3jwsmX6JzbDknmQQ@mail.gmail.com>
 <571e2fbc-ea6a-d231-79f0-37529e05eb98@redhat.com>
 <20230703174043-mutt-send-email-mst@kernel.org>
 <0630fc62-a414-6083-eed8-48b36acc7723@redhat.com>
 <20230704055840-mutt-send-email-mst@kernel.org>
From: Maxime Coquelin <maxime.coquelin@redhat.com>
In-Reply-To: <20230704055840-mutt-send-email-mst@kernel.org>
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.1
Cc: xuanzhuo@linux.alibaba.com, lulu@redhat.com, eperezma@redhat.com,
 netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
 virtualization@lists.linux-foundation.org, xieyongji@bytedance.com,
 david.marchand@redhat.com
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

CgpPbiA3LzQvMjMgMTE6NTksIE1pY2hhZWwgUy4gVHNpcmtpbiB3cm90ZToKPiBPbiBUdWUsIEp1
bCAwNCwgMjAyMyBhdCAxMDo0MzowN0FNICswMjAwLCBNYXhpbWUgQ29xdWVsaW4gd3JvdGU6Cj4+
Cj4+Cj4+IE9uIDcvMy8yMyAyMzo0NSwgTWljaGFlbCBTLiBUc2lya2luIHdyb3RlOgo+Pj4gT24g
TW9uLCBKdWwgMDMsIDIwMjMgYXQgMDk6NDM6NDlBTSArMDIwMCwgTWF4aW1lIENvcXVlbGluIHdy
b3RlOgo+Pj4+Cj4+Pj4gT24gNy8zLzIzIDA4OjQ0LCBKYXNvbiBXYW5nIHdyb3RlOgo+Pj4+PiBP
biBTdW4sIEp1bCAyLCAyMDIzIGF0IDk6MzfigK9QTSBNaWNoYWVsIFMuIFRzaXJraW4gPG1zdEBy
ZWRoYXQuY29tPiB3cm90ZToKPj4+Pj4+Cj4+Pj4+PiBPbiBUdWUsIEp1biAyNywgMjAyMyBhdCAw
MTozNjo1MFBNICswMjAwLCBNYXhpbWUgQ29xdWVsaW4gd3JvdGU6Cj4+Pj4+Pj4gVGhpcyBzbWFs
bCBzZXJpZXMgZW5hYmxlcyB2aXJ0aW8tbmV0IGRldmljZSB0eXBlIGluIFZEVVNFLgo+Pj4+Pj4+
IFdpdGggaXQsIGJhc2ljIG9wZXJhdGlvbiBoYXZlIGJlZW4gdGVzdGVkLCBib3RoIHdpdGgKPj4+
Pj4+PiB2aXJ0aW8tdmRwYSBhbmQgdmhvc3QtdmRwYSB1c2luZyBEUERLIFZob3N0IGxpYnJhcnkg
c2VyaWVzCj4+Pj4+Pj4gYWRkaW5nIFZEVVNFIHN1cHBvcnQgdXNpbmcgc3BsaXQgcmluZ3MgbGF5
b3V0IChtZXJnZWQgaW4KPj4+Pj4+PiBEUERLIHYyMy4wNy1yYzEpLgo+Pj4+Pj4+Cj4+Pj4+Pj4g
Q29udHJvbCBxdWV1ZSBzdXBwb3J0IChhbmQgc28gbXVsdGlxdWV1ZSkgaGFzIGFsc28gYmVlbgo+
Pj4+Pj4+IHRlc3RlZCwgYnV0IHJlcXVpcmVzIGEgS2VybmVsIHNlcmllcyBmcm9tIEphc29uIFdh
bmcKPj4+Pj4+PiByZWxheGluZyBjb250cm9sIHF1ZXVlIHBvbGxpbmcgWzFdIHRvIGZ1bmN0aW9u
IHJlbGlhYmx5Lgo+Pj4+Pj4+Cj4+Pj4+Pj4gWzFdOiBodHRwczovL2xvcmUua2VybmVsLm9yZy9s
a21sL0NBQ0drTUV0Z3J4TjNQUHdzRG80b09zbnNTTEpmRW1CRVowV3ZqR1JyM3doVStRYXNVZ0Bt
YWlsLmdtYWlsLmNvbS9ULwo+Pj4+Pj4KPj4+Pj4+IEphc29uIHByb21pc2VkIHRvIHBvc3QgYSBu
ZXcgdmVyc2lvbiBvZiB0aGF0IHBhdGNoLgo+Pj4+Pj4gUmlnaHQgSmFzb24/Cj4+Pj4+Cj4+Pj4+
IFllcy4KPj4+Pj4KPj4+Pj4+IEZvciBub3cgbGV0J3MgbWFrZSBzdXJlIENWUSBmZWF0dXJlIGZs
YWcgaXMgb2ZmPwo+Pj4+Pgo+Pj4+PiBXZSBjYW4gZG8gdGhhdCBhbmQgcmVsYXggb24gdG9wIG9m
IG15IHBhdGNoLgo+Pj4+Cj4+Pj4gSSBhZ3JlZT8gRG8geW91IHByZWZlciBhIGZlYXR1cmVzIG5l
Z290aWF0aW9uLCBvciBmYWlsaW5nIGluaXQgKGxpa2UKPj4+PiBkb25lIGZvciBWRVJTSU9OXzEp
IGlmIHRoZSBWRFVTRSBhcHBsaWNhdGlvbiBhZHZlcnRpc2VzIENWUT8KPj4+Pgo+Pj4+IFRoYW5r
cywKPj4+PiBNYXhpbWUKPj4+Cj4+PiBVbmZvcnR1bmF0ZWx5IGd1ZXN0cyBmYWlsIHByb2JlIGlm
IGZlYXR1cmUgc2V0IGlzIGluY29uc2lzdGVudC4KPj4+IFNvIEkgZG9uJ3QgdGhpbmsgcGFzc2lu
ZyB0aHJvdWdoIGZlYXR1cmVzIGlzIGEgZ29vZCBpZGVhLAo+Pj4geW91IG5lZWQgYSBsaXN0IG9m
IGxlZ2FsIGJpdHMuIEFuZCB3aGVuIGRvaW5nIHRoaXMsCj4+PiBjbGVhciBDVlEgYW5kIGV2ZXJ5
dGhpbmcgdGhhdCBkZXBlbmRzIG9uIGl0Lgo+Pgo+PiBTaW5jZSB0aGlzIGlzIHRlbXBvcmFyeSwg
d2hpbGUgY3ZxIGlzIG1hZGUgbW9yZSByb2J1c3QsIEkgdGhpbmsgaXQgaXMKPj4gYmV0dGVyIHRv
IGZhaWwgVkRVU0UgZGV2aWNlIGNyZWF0aW9uIGlmIENWUSBmZWF0dXJlIGlzIGFkdmVydGlzZWQg
YnkgdGhlCj4+IFZEVVNFIGFwcGxpY2F0aW9uLCBpbnN0ZWFkIG9mIGVuc3VyaW5nIGZlYXR1cmVz
IGRlcGVuZGluZyBvbiBDVlEgYXJlCj4+IGFsc28gY2xlYXJlZC4KPj4KPj4gSmFzb24gc2VlbXMg
dG8gdGhpbmsgbGlrZXdpc2UsIHdvdWxkIHRoYXQgd29yayBmb3IgeW91Pwo+Pgo+PiBUaGFua3Ms
Cj4+IE1heGltZQo+IAo+IE5vdGhpbmcgaXMgbW9yZSBwZXJtYW5lbnQgdGhhbiB0ZW1wb3Jhcnkg
c29sdXRpb25zLgo+IE15IGNvbmNlcm4gd291bGQgYmUgdGhhdCBoYXJkd2FyZSBkZXZpY2VzIHRo
ZW4gc3RhcnQgbWFza2luZyBDVlEKPiBpbnRlbnRpb25hbGx5IGp1c3QgdG8gYXZvaWQgdGhlIHBh
aW4gb2YgYnJva2VuIHNvZnR3YXJlLgoKR290IGl0LCBJJ2xsIGFkZCBhIHBhdGNoIG9uIHRvcCB0
aGF0IGZpbHRlcnMgb3V0IENWUSBmZWF0dXJlIGFuZCBhbGwgdGhlCmZlYXR1cmVzIHRoYXQgZGVw
ZW5kIG9uIGl0LgoKVGhhbmtzLApNYXhpbWUKCj4gCj4+Pgo+Pj4KPj4+Pj4gVGhhbmtzCj4+Pj4+
Cj4+Pj4+Pgo+Pj4+Pj4+IFJGQyAtPiB2MSBjaGFuZ2VzOgo+Pj4+Pj4+ID09PT09PT09PT09PT09
PT09PQo+Pj4+Pj4+IC0gRmFpbCBkZXZpY2UgaW5pdCBpZiBpdCBkb2VzIG5vdCBzdXBwb3J0IFZF
UlNJT05fMSAoSmFzb24pCj4+Pj4+Pj4KPj4+Pj4+PiBNYXhpbWUgQ29xdWVsaW4gKDIpOgo+Pj4+
Pj4+ICAgICAgdmR1c2U6IHZhbGlkYXRlIGJsb2NrIGZlYXR1cmVzIG9ubHkgd2l0aCBibG9jayBk
ZXZpY2VzCj4+Pj4+Pj4gICAgICB2ZHVzZTogZW5hYmxlIFZpcnRpby1uZXQgZGV2aWNlIHR5cGUK
Pj4+Pj4+Pgo+Pj4+Pj4+ICAgICBkcml2ZXJzL3ZkcGEvdmRwYV91c2VyL3ZkdXNlX2Rldi5jIHwg
MTUgKysrKysrKysrKystLS0tCj4+Pj4+Pj4gICAgIDEgZmlsZSBjaGFuZ2VkLCAxMSBpbnNlcnRp
b25zKCspLCA0IGRlbGV0aW9ucygtKQo+Pj4+Pj4+Cj4+Pj4+Pj4gLS0KPj4+Pj4+PiAyLjQxLjAK
Pj4+Pj4+Cj4+Pj4+Cj4+Pgo+IAoKX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX18KVmlydHVhbGl6YXRpb24gbWFpbGluZyBsaXN0ClZpcnR1YWxpemF0aW9uQGxp
c3RzLmxpbnV4LWZvdW5kYXRpb24ub3JnCmh0dHBzOi8vbGlzdHMubGludXhmb3VuZGF0aW9uLm9y
Zy9tYWlsbWFuL2xpc3RpbmZvL3ZpcnR1YWxpemF0aW9u
