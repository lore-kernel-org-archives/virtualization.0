Return-Path: <SRS0=p/QF=D6=lists.linux-foundation.org=virtualization-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.2 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 31514C55178
	for <virtualization@archiver.kernel.org>; Fri, 23 Oct 2020 08:45:06 +0000 (UTC)
Received: from whitealder.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 6F8B924182
	for <virtualization@archiver.kernel.org>; Fri, 23 Oct 2020 08:45:05 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="e0PQ1OW8"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6F8B924182
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=virtualization-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by whitealder.osuosl.org (Postfix) with ESMTP id CE7FD86CCF;
	Fri, 23 Oct 2020 08:45:04 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from whitealder.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id rAFTbpNulzPW; Fri, 23 Oct 2020 08:45:04 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by whitealder.osuosl.org (Postfix) with ESMTP id EE06086803;
	Fri, 23 Oct 2020 08:45:03 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id C76E3C088B;
	Fri, 23 Oct 2020 08:45:03 +0000 (UTC)
Received: from whitealder.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 20F47C0051
 for <virtualization@lists.linux-foundation.org>;
 Fri, 23 Oct 2020 08:45:03 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by whitealder.osuosl.org (Postfix) with ESMTP id 0423386C9A
 for <virtualization@lists.linux-foundation.org>;
 Fri, 23 Oct 2020 08:45:03 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from whitealder.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id p1prtWW5bUa3
 for <virtualization@lists.linux-foundation.org>;
 Fri, 23 Oct 2020 08:45:02 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [63.128.21.124])
 by whitealder.osuosl.org (Postfix) with ESMTPS id 2AD6586803
 for <virtualization@lists.linux-foundation.org>;
 Fri, 23 Oct 2020 08:45:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1603442700;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=bDiRYrmNuAeuXyrzGZ2HO+vecWU+41yPfoW9TUEarfQ=;
 b=e0PQ1OW85qWzVkwdAnIdiX0+IgNUnjWoDc1JdNeGxFDQgM2A5cHQSXlVpT44vqOi7vdl+L
 KzumE3hnH9QvTDqcK5xML1QuwsvfbYGUz8Juiq0cHpEk1SJu4O0gABcFuI38GyTzYCeZzd
 gZ5/MEpoHr1Z10vkWeIydIZL+yEULHM=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-182-l0-M5mPbM7mJs9tkh04YAg-1; Fri, 23 Oct 2020 04:44:58 -0400
X-MC-Unique: l0-M5mPbM7mJs9tkh04YAg-1
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com
 [10.5.11.11])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id AF2FF84BA68;
 Fri, 23 Oct 2020 08:44:57 +0000 (UTC)
Received: from [10.72.13.85] (ovpn-13-85.pek2.redhat.com [10.72.13.85])
 by smtp.corp.redhat.com (Postfix) with ESMTP id D885650B44;
 Fri, 23 Oct 2020 08:44:47 +0000 (UTC)
Subject: Re: [External] Re: [RFC 0/4] Introduce VDUSE - vDPA Device in
 Userspace
To: Yongji Xie <xieyongji@bytedance.com>
References: <20201019145623.671-1-xieyongji@bytedance.com>
 <c1f8c9df-d5e1-437f-91ee-68f00ebfe2a2@redhat.com>
 <CACycT3srzADF63rotgHwfsqn5GJOCbXx+19Dcnw8HLyTGY_7Eg@mail.gmail.com>
 <c83aad4f-8ac5-3279-0429-ae2154622fe5@redhat.com>
 <CACycT3ssE-iMquAmrrHGQyBCv7XkQ2WrinFMMPTTubxuuOQ92g@mail.gmail.com>
 <6cff5900-42ee-a0f5-0d5f-9383646c27d9@redhat.com>
 <CACycT3s2GZ3yKP+Xn2V83_-=tXg342J4n91ZAb0c-+UD_+sFnA@mail.gmail.com>
From: Jason Wang <jasowang@redhat.com>
Message-ID: <427448f0-58ba-0730-d199-6c8cd818ea63@redhat.com>
Date: Fri, 23 Oct 2020 16:44:45 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <CACycT3s2GZ3yKP+Xn2V83_-=tXg342J4n91ZAb0c-+UD_+sFnA@mail.gmail.com>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=jasowang@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Language: en-US
Cc: linux-mm@kvack.org, akpm@linux-foundation.org,
 virtualization@lists.linux-foundation.org,
 "Michael S. Tsirkin" <mst@redhat.com>
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

Ck9uIDIwMjAvMTAvMjMg5LiK5Y2IMTA6NTUsIFlvbmdqaSBYaWUgd3JvdGU6Cj4KPgo+IE9uIFR1
ZSwgT2N0IDIwLCAyMDIwIGF0IDU6MTMgUE0gSmFzb24gV2FuZyA8amFzb3dhbmdAcmVkaGF0LmNv
bSAKPiA8bWFpbHRvOmphc293YW5nQHJlZGhhdC5jb20+PiB3cm90ZToKPgo+Cj4gICAgIE9uIDIw
MjAvMTAvMjAg5LiL5Y2INDozNSwgWW9uZ2ppIFhpZSB3cm90ZToKPiAgICAgPgo+ICAgICA+Cj4g
ICAgID4gT24gVHVlLCBPY3QgMjAsIDIwMjAgYXQgNDowMSBQTSBKYXNvbiBXYW5nIDxqYXNvd2Fu
Z0ByZWRoYXQuY29tCj4gICAgIDxtYWlsdG86amFzb3dhbmdAcmVkaGF0LmNvbT4KPiAgICAgPiA8
bWFpbHRvOmphc293YW5nQHJlZGhhdC5jb20gPG1haWx0bzpqYXNvd2FuZ0ByZWRoYXQuY29tPj4+
IHdyb3RlOgo+ICAgICA+Cj4gICAgID4KPiAgICAgPsKgIMKgIMKgT24gMjAyMC8xMC8yMCDkuIvl
jYgzOjM5LCBZb25namkgWGllIHdyb3RlOgo+ICAgICA+wqAgwqAgwqA+Cj4gICAgID7CoCDCoCDC
oD4KPiAgICAgPsKgIMKgIMKgPiBPbiBUdWUsIE9jdCAyMCwgMjAyMCBhdCAxMToyMCBBTSBKYXNv
biBXYW5nCj4gICAgIDxqYXNvd2FuZ0ByZWRoYXQuY29tIDxtYWlsdG86amFzb3dhbmdAcmVkaGF0
LmNvbT4KPiAgICAgPsKgIMKgIMKgPG1haWx0bzpqYXNvd2FuZ0ByZWRoYXQuY29tIDxtYWlsdG86
amFzb3dhbmdAcmVkaGF0LmNvbT4+Cj4gICAgID7CoCDCoCDCoD4gPG1haWx0bzpqYXNvd2FuZ0By
ZWRoYXQuY29tIDxtYWlsdG86amFzb3dhbmdAcmVkaGF0LmNvbT4KPiAgICAgPG1haWx0bzpqYXNv
d2FuZ0ByZWRoYXQuY29tIDxtYWlsdG86amFzb3dhbmdAcmVkaGF0LmNvbT4+Pj4gd3JvdGU6Cj4g
ICAgID7CoCDCoCDCoD4KPiAgICAgPsKgIMKgIMKgPgo+ICAgICA+wqAgwqAgwqA+wqAgwqAgwqBP
biAyMDIwLzEwLzE5IOS4i+WNiDEwOjU2LCBYaWUgWW9uZ2ppIHdyb3RlOgo+ICAgICA+wqAgwqAg
wqA+wqAgwqAgwqA+IFRoaXMgc2VyaWVzIGludHJvZHVjZXMgYSBmcmFtZXdvcmssIHdoaWNoIGNh
biBiZSB1c2VkIHRvCj4gICAgID7CoCDCoCDCoGltcGxlbWVudAo+ICAgICA+wqAgwqAgwqA+wqAg
wqAgwqA+IHZEUEEgRGV2aWNlcyBpbiBhIHVzZXJzcGFjZSBwcm9ncmFtLiBUbyBpbXBsZW1lbnQK
PiAgICAgaXQsIHRoZSB3b3JrCj4gICAgID7CoCDCoCDCoD7CoCDCoCDCoD4gY29uc2lzdCBvZiB0
d28gcGFydHM6IGNvbnRyb2wgcGF0aCBlbXVsYXRpbmcgYW5kCj4gICAgIGRhdGEgcGF0aAo+ICAg
ICA+wqAgwqAgwqA+wqAgwqAgwqBvZmZsb2FkaW5nLgo+ICAgICA+wqAgwqAgwqA+wqAgwqAgwqA+
Cj4gICAgID7CoCDCoCDCoD7CoCDCoCDCoD4gSW4gdGhlIGNvbnRyb2wgcGF0aCwgdGhlIFZEVVNF
IGRyaXZlciB3aWxsIG1ha2UgdXNlCj4gICAgIG9mIG1lc3NhZ2UKPiAgICAgPsKgIMKgIMKgPsKg
IMKgIMKgPiBtZWNobmlzbSB0byBmb3J3YXJkIHRoZSBhY3Rpb25zIChnZXQvc2V0IGZlYXR1cmVz
LAo+ICAgICBnZXQvc3QKPiAgICAgPsKgIMKgIMKgc3RhdHVzLAo+ICAgICA+wqAgwqAgwqA+wqAg
wqAgwqA+IGdldC9zZXQgY29uZmlnIHNwYWNlIGFuZCBzZXQgdmlydHF1ZXVlIHN0YXRlcykgZnJv
bQo+ICAgICA+wqAgwqAgwqB2aXJ0aW8tdmRwYQo+ICAgICA+wqAgwqAgwqA+wqAgwqAgwqA+IGRy
aXZlciB0byB1c2Vyc3BhY2UuIFVzZXJzcGFjZSBjYW4gdXNlIHJlYWQoKS93cml0ZSgpIHRvCj4g
ICAgID7CoCDCoCDCoD7CoCDCoCDCoD4gcmVjZWl2ZS9yZXBseSB0byB0aG9zZSBjb250cm9sIG1l
c3NhZ2VzLgo+ICAgICA+wqAgwqAgwqA+wqAgwqAgwqA+Cj4gICAgID7CoCDCoCDCoD7CoCDCoCDC
oD4gSW4gdGhlIGRhdGEgcGF0aCwgdGhlIFZEVVNFIGRyaXZlciBpbXBsZW1lbnRzIGEKPiAgICAg
TU1VLWJhc2VkCj4gICAgID7CoCDCoCDCoD7CoCDCoCDCoD4gb24tY2hpcCBJT01NVSBkcml2ZXIg
d2hpY2ggc3VwcG9ydHMgYm90aCBkaXJlY3QKPiAgICAgbWFwcGluZyBhbmQKPiAgICAgPsKgIMKg
IMKgPsKgIMKgIMKgPiBpbmRpcmVjdCBtYXBwaW5nIHdpdGggYm91bmNlIGJ1ZmZlci4gVGhlbiB1
c2Vyc3BhY2UKPiAgICAgY2FuIGFjY2Vzcwo+ICAgICA+wqAgwqAgwqA+wqAgwqAgwqA+IHRob3Nl
IGlvdmEgc3BhY2UgdmlhIG1tYXAoKS4gQmVzaWRlcywgZXZlbnRmZAo+ICAgICBtZWNobmlzbSBp
cwo+ICAgICA+wqAgwqAgwqB1c2VkIHRvCj4gICAgID7CoCDCoCDCoD7CoCDCoCDCoD4gdHJpZ2dl
ciBpbnRlcnJ1cHRzIGFuZCBmb3J3YXJkIHZpcnRxdWV1ZSBraWNrcy4KPiAgICAgPsKgIMKgIMKg
Pgo+ICAgICA+wqAgwqAgwqA+Cj4gICAgID7CoCDCoCDCoD7CoCDCoCDCoFRoaXMgaXMgcHJldHR5
IGludGVyZXN0aW5nIQo+ICAgICA+wqAgwqAgwqA+Cj4gICAgID7CoCDCoCDCoD7CoCDCoCDCoEZv
ciB2aG9zdC12ZHBhLCBpdCBzaG91bGQgd29yaywgYnV0IGZvciB2aXJ0aW8tdmRwYSwgSQo+ICAg
ICB0aGluayB3ZQo+ICAgICA+wqAgwqAgwqA+wqAgwqAgwqBzaG91bGQKPiAgICAgPsKgIMKgIMKg
PsKgIMKgIMKgY2FyZWZ1bGx5IGRlYWwgd2l0aCB0aGUgSU9NTVUvRE1BIG9wcyBzdHVmZnMuCj4g
ICAgID7CoCDCoCDCoD4KPiAgICAgPsKgIMKgIMKgPgo+ICAgICA+wqAgwqAgwqA+wqAgwqAgwqBJ
IG5vdGljZSB0aGF0IG5laXRoZXIgZG1hX21hcCBub3Igc2V0X21hcCBpcwo+ICAgICBpbXBsZW1l
bnRlZCBpbgo+ICAgICA+wqAgwqAgwqA+wqAgwqAgwqB2ZHVzZV92ZHBhX2NvbmZpZ19vcHMsIHRo
aXMgbWVhbnMgeW91IHdhbnQgdG8gbGV0Cj4gICAgIHZob3N0LXZEUEEKPiAgICAgPsKgIMKgIMKg
dG8gZGVhbAo+ICAgICA+wqAgwqAgwqA+wqAgwqAgwqB3aXRoIElPTU1VIGRvbWFpbnMgc3R1ZmZz
LsKgIEFueSByZWFzb24gZm9yIGRvaW5nIHRoYXQ/Cj4gICAgID7CoCDCoCDCoD4KPiAgICAgPsKg
IMKgIMKgPiBBY3R1YWxseSwgdGhpcyBzZXJpZXMgb25seSBmb2N1cyBvbiB2aXJ0aW8tdmRwYSBj
YXNlIG5vdy4gVG8KPiAgICAgPsKgIMKgIMKgc3VwcG9ydAo+ICAgICA+wqAgwqAgwqA+IHZob3N0
LXZkcGEswqAgYXMgeW91IHNhaWQsIHdlIG5lZWQgdG8gaW1wbGVtZW50Cj4gICAgID7CoCDCoCDC
oGRtYV9tYXAvZG1hX3VubWFwLiBCdXQKPiAgICAgPsKgIMKgIMKgPiB0aGVyZSBpcyBhIGxpbWl0
IHRoYXQgdm0ncyBtZW1vcnkgY2FuJ3QgYmUgYW5vbnltb3VzIHBhZ2VzCj4gICAgIHdoaWNoCj4g
ICAgID7CoCDCoCDCoGFyZQo+ICAgICA+wqAgwqAgwqA+IGZvcmJpZGRlbiBpbiB2bV9pbnNlcnRf
cGFnZSgpLiBNYXliZSB3ZSBuZWVkIHRvIGFkZCBzb21lCj4gICAgIGxpbWl0cyBvbgo+ICAgICA+
wqAgwqAgwqA+IHZob3N0LXZkcGE/Cj4gICAgID4KPiAgICAgPgo+ICAgICA+wqAgwqAgwqBJJ20g
bm90IHN1cmUgSSBnZXQgdGhpcywgYW55IHJlYXNvbiB0aGF0IHlvdSB3YW50IHRvIHVzZQo+ICAg
ICA+wqAgwqAgwqB2bV9pbnNlcnRfcGFnZSgpIHRvIFZNJ3MgbWVtb3J5LiBPciBkbyB5b3UgbWVh
biB5b3Ugd2FudCB0bwo+ICAgICBpbXBsZW1lbnQKPiAgICAgPsKgIMKgIMKgc29tZSBraW5kIG9m
IHplcm8tY29weT8KPiAgICAgPgo+ICAgICA+Cj4gICAgID4KPiAgICAgPiBJZiBteSB1bmRlcnN0
YW5kaW5nIGlzIHJpZ2h0LCB3ZSB3aWxsIGhhdmUgYSBRRU1VIChWTSkgcHJvY2Vzcwo+ICAgICBh
bmQgYQo+ICAgICA+IGRldmljZSBlbXVsYXRpb24gcHJvY2VzcyBpbiB0aGUgdmhvc3QtdmRwYSBj
YXNlLCByaWdodD8gV2hlbiBJL08KPiAgICAgPiBoYXBwZW5zLCB0aGUgdmlydGlvIGRyaXZlciBp
biBWTSB3aWxsIHB1dCB0aGUgSU9WQSB0byB2cmluZyBhbmQKPiAgICAgZGV2aWNlCj4gICAgID4g
ZW11bGF0aW9uIHByb2Nlc3Mgd2lsbCBnZXQgdGhlIElPVkEgZnJvbSB2cmluZy4gVGhlbiB0aGUg
ZGV2aWNlCj4gICAgID4gZW11bGF0aW9uIHByb2Nlc3Mgd2lsbMKgdHJhbnNsYXRlIHRoZSBJT1ZB
IHRvIGl0cyBWQSB0byBhY2Nlc3MKPiAgICAgdGhlIGRtYQo+ICAgICA+IGJ1ZmZlciB3aGljaCBy
ZXNpZGVzIGluIFZNJ3MgbWVtb3J5LiBUaGF0IG1lYW5zIHRoZSBkZXZpY2UKPiAgICAgZW11bGF0
aW9uCj4gICAgID4gcHJvY2VzcyBuZWVkcyB0byBhY2Nlc3MgVk0nc8KgbWVtb3J5LCBzbyB3ZSBz
aG91bGQgdXNlCj4gICAgIHZtX2luc2VydF9wYWdlKCkKPiAgICAgPiB0byBidWlsZCB0aGUgcGFn
ZSB0YWJsZSBvZiB0aGUgZGV2aWNlIGVtdWxhdGlvbiBwcm9jZXNzLgo+Cj4KPiAgICAgT2ssIEkg
Z2V0IHlvdSBub3cuIFNvIGl0IGxvb2tzIHRvIG1lIHRoZSB0aGF0IHRoZSByZWFsIGlzc3VlIGlz
Cj4gICAgIG5vdCB0aGUKPiAgICAgbGltaXRhdGlvbiB0byBhbm9ueW1vdXMgcGFnZSBidXQgc2Vl
IHRoZSBjb21tZW50cyBhYm92ZQo+ICAgICB2bV9pbnNlcnRfcGFnZSgpOgo+Cj4gICAgICIKPgo+
ICAgICDCoMKgKiBUaGUgcGFnZSBoYXMgdG8gYmUgYSBuaWNlIGNsZWFuIF9pbmRpdmlkdWFsXyBr
ZXJuZWwgYWxsb2NhdGlvbi4KPiAgICAgIgo+Cj4gICAgIFNvIEkgc3VzcGVjdCB0aGF0IHVzaW5n
IHZtX2luc2VydF9wYWdlKCkgdG8gc2hhcmUgcGFnZXMgYmV0d2Vlbgo+ICAgICBwcm9jZXNzZXMg
aXMgbGVnYWwuIFdlIG5lZWQgaW5wdXRzIGZyb20gTU0gZXhwZXJ0cy4KPgo+Cj4gWWVzLMKgIHZt
X2luc2VydF9wYWdlKCkgY2FuJ3QgYmUgdXNlZCBpbiB0aGlzIGNhc2UuIFNvIGNvdWxkIHdlIGFk
ZCB0aGUgCj4gc2htZmQgaW50b8KgdGhlIHZob3N0IGlvdGxiIG1zZyBhbmQgcGFzcyBpdCB0byB0
aGUgZGV2aWNlIGVtdWxhdGlvbiAKPiBwcm9jZXNzIGFzIGEgbmV3IGlvdmFfZG9tYWluLCBqdXN0
IGxpa2Ugdmhvc3QtdXNlciBkb2VzLgo+Cj4gVGhhbmtzLAo+IFlvbmdqaQoKCkkgdGhpbmsgdmhv
c3QtdXNlciBkaWQgdGhhdCB2aWEgU0VUX01FTV9UQUJMRSB3aGljaCBpcyBub3Qgc3VwcG9ydGVk
IGJ5IAp2RFBBLiBOb3RlIHRoYXQgdGhlIGN1cnJlbnQgSU9UTEIgbWVzc2FnZSB3aWxsIGJlIHVz
ZWQgd2hlbiB2SU9NTVUgaXMgCmVuYWJsZWQuCgpUaGlzIG5lZWRzIG1vcmUgdGhvdWdodC4gV2ls
bCBjb21lIGJhY2sgaWYgSSBoYWQgYW55IHRob3VnaHQuCgpUaGFua3MKCgo+Cj4KPgo+Cj4gICAg
ID4KPiAgICAgPsKgIMKgIMKgSSBndWVzcyBmcm9tIHRoZSBzb2Z0d2FyZSBkZXZpY2UgaW1wbGVt
ZW50aW9uIGluIHVzZXIgc3BhY2UgaXQKPiAgICAgPsKgIMKgIMKgb25seSBuZWVkCj4gICAgID7C
oCDCoCDCoHRvIHJlY2VpdmUgSU9WQSByYW5nZXMgYW5kIG1hcCB0aGVtIGluIGl0cyBvd24gYWRk
cmVzcyBzcGFjZS4KPiAgICAgPgo+ICAgICA+Cj4gICAgID4gSG93IHRvIG1hcCB0aGVtIGluIGl0
cyBvd24gYWRkcmVzcyBzcGFjZSBpZiB3ZSBkb24ndCB1c2UKPiAgICAgdm1faW5zZXJ0X3BhZ2Uo
KT8KPgoKX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18KVmly
dHVhbGl6YXRpb24gbWFpbGluZyBsaXN0ClZpcnR1YWxpemF0aW9uQGxpc3RzLmxpbnV4LWZvdW5k
YXRpb24ub3JnCmh0dHBzOi8vbGlzdHMubGludXhmb3VuZGF0aW9uLm9yZy9tYWlsbWFuL2xpc3Rp
bmZvL3ZpcnR1YWxpemF0aW9u
