Return-Path: <SRS0=FgjU=D3=lists.linux-foundation.org=virtualization-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.0 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A340FC43467
	for <virtualization@archiver.kernel.org>; Tue, 20 Oct 2020 09:13:07 +0000 (UTC)
Received: from whitealder.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 0121E22283
	for <virtualization@archiver.kernel.org>; Tue, 20 Oct 2020 09:13:06 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="SuiPhslO"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0121E22283
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=virtualization-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by whitealder.osuosl.org (Postfix) with ESMTP id 749D786C8E;
	Tue, 20 Oct 2020 09:13:06 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from whitealder.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id LoA4avJou2Yo; Tue, 20 Oct 2020 09:13:05 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by whitealder.osuosl.org (Postfix) with ESMTP id B49E486C89;
	Tue, 20 Oct 2020 09:13:05 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 9AD9DC088B;
	Tue, 20 Oct 2020 09:13:05 +0000 (UTC)
Received: from silver.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by lists.linuxfoundation.org (Postfix) with ESMTP id AF006C0051
 for <virtualization@lists.linux-foundation.org>;
 Tue, 20 Oct 2020 09:13:04 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by silver.osuosl.org (Postfix) with ESMTP id 955E02E198
 for <virtualization@lists.linux-foundation.org>;
 Tue, 20 Oct 2020 09:13:04 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from silver.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id qU3LayRUmH5p
 for <virtualization@lists.linux-foundation.org>;
 Tue, 20 Oct 2020 09:13:03 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [216.205.24.124])
 by silver.osuosl.org (Postfix) with ESMTPS id 9A3CB2E197
 for <virtualization@lists.linux-foundation.org>;
 Tue, 20 Oct 2020 09:13:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1603185182;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=I5VsYREhL4++Osw5yB+estDDNbvwdPAcgT+fSqIRav8=;
 b=SuiPhslOD39GjjwETysbUItln6CGR+Z2MoELfMIrEQ8MOv4RRWyoE1GpNpK0KtxaJ4v45l
 nN8uH6SanqtZGxvhxaRKvb0QsrZHxui2Lztex6kgbv5t68N8hYBEWNyX7twCUM5cR3rU31
 fkr2wb9jsGmT2MxxAJasRyFTFsCIOtI=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-255-d0LveL7sPdWn4b9h4NnYjw-1; Tue, 20 Oct 2020 05:12:58 -0400
X-MC-Unique: d0LveL7sPdWn4b9h4NnYjw-1
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com
 [10.5.11.15])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 8B81810866A1;
 Tue, 20 Oct 2020 09:12:56 +0000 (UTC)
Received: from [10.72.13.171] (ovpn-13-171.pek2.redhat.com [10.72.13.171])
 by smtp.corp.redhat.com (Postfix) with ESMTP id B2F032C31E;
 Tue, 20 Oct 2020 09:12:50 +0000 (UTC)
Subject: Re: [External] Re: [RFC 0/4] Introduce VDUSE - vDPA Device in
 Userspace
To: Yongji Xie <xieyongji@bytedance.com>
References: <20201019145623.671-1-xieyongji@bytedance.com>
 <c1f8c9df-d5e1-437f-91ee-68f00ebfe2a2@redhat.com>
 <CACycT3srzADF63rotgHwfsqn5GJOCbXx+19Dcnw8HLyTGY_7Eg@mail.gmail.com>
 <c83aad4f-8ac5-3279-0429-ae2154622fe5@redhat.com>
 <CACycT3ssE-iMquAmrrHGQyBCv7XkQ2WrinFMMPTTubxuuOQ92g@mail.gmail.com>
From: Jason Wang <jasowang@redhat.com>
Message-ID: <6cff5900-42ee-a0f5-0d5f-9383646c27d9@redhat.com>
Date: Tue, 20 Oct 2020 17:12:46 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <CACycT3ssE-iMquAmrrHGQyBCv7XkQ2WrinFMMPTTubxuuOQ92g@mail.gmail.com>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
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

Ck9uIDIwMjAvMTAvMjAg5LiL5Y2INDozNSwgWW9uZ2ppIFhpZSB3cm90ZToKPgo+Cj4gT24gVHVl
LCBPY3QgMjAsIDIwMjAgYXQgNDowMSBQTSBKYXNvbiBXYW5nIDxqYXNvd2FuZ0ByZWRoYXQuY29t
IAo+IDxtYWlsdG86amFzb3dhbmdAcmVkaGF0LmNvbT4+IHdyb3RlOgo+Cj4KPiAgICAgT24gMjAy
MC8xMC8yMCDkuIvljYgzOjM5LCBZb25namkgWGllIHdyb3RlOgo+ICAgICA+Cj4gICAgID4KPiAg
ICAgPiBPbiBUdWUsIE9jdCAyMCwgMjAyMCBhdCAxMToyMCBBTSBKYXNvbiBXYW5nIDxqYXNvd2Fu
Z0ByZWRoYXQuY29tCj4gICAgIDxtYWlsdG86amFzb3dhbmdAcmVkaGF0LmNvbT4KPiAgICAgPiA8
bWFpbHRvOmphc293YW5nQHJlZGhhdC5jb20gPG1haWx0bzpqYXNvd2FuZ0ByZWRoYXQuY29tPj4+
IHdyb3RlOgo+ICAgICA+Cj4gICAgID4KPiAgICAgPsKgIMKgIMKgT24gMjAyMC8xMC8xOSDkuIvl
jYgxMDo1NiwgWGllIFlvbmdqaSB3cm90ZToKPiAgICAgPsKgIMKgIMKgPiBUaGlzIHNlcmllcyBp
bnRyb2R1Y2VzIGEgZnJhbWV3b3JrLCB3aGljaCBjYW4gYmUgdXNlZCB0bwo+ICAgICBpbXBsZW1l
bnQKPiAgICAgPsKgIMKgIMKgPiB2RFBBIERldmljZXMgaW4gYSB1c2Vyc3BhY2UgcHJvZ3JhbS4g
VG8gaW1wbGVtZW50IGl0LCB0aGUgd29yawo+ICAgICA+wqAgwqAgwqA+IGNvbnNpc3Qgb2YgdHdv
IHBhcnRzOiBjb250cm9sIHBhdGggZW11bGF0aW5nIGFuZCBkYXRhIHBhdGgKPiAgICAgPsKgIMKg
IMKgb2ZmbG9hZGluZy4KPiAgICAgPsKgIMKgIMKgPgo+ICAgICA+wqAgwqAgwqA+IEluIHRoZSBj
b250cm9sIHBhdGgsIHRoZSBWRFVTRSBkcml2ZXIgd2lsbCBtYWtlIHVzZSBvZiBtZXNzYWdlCj4g
ICAgID7CoCDCoCDCoD4gbWVjaG5pc20gdG8gZm9yd2FyZCB0aGUgYWN0aW9ucyAoZ2V0L3NldCBm
ZWF0dXJlcywgZ2V0L3N0Cj4gICAgIHN0YXR1cywKPiAgICAgPsKgIMKgIMKgPiBnZXQvc2V0IGNv
bmZpZyBzcGFjZSBhbmQgc2V0IHZpcnRxdWV1ZSBzdGF0ZXMpIGZyb20KPiAgICAgdmlydGlvLXZk
cGEKPiAgICAgPsKgIMKgIMKgPiBkcml2ZXIgdG8gdXNlcnNwYWNlLiBVc2Vyc3BhY2UgY2FuIHVz
ZSByZWFkKCkvd3JpdGUoKSB0bwo+ICAgICA+wqAgwqAgwqA+IHJlY2VpdmUvcmVwbHkgdG8gdGhv
c2UgY29udHJvbCBtZXNzYWdlcy4KPiAgICAgPsKgIMKgIMKgPgo+ICAgICA+wqAgwqAgwqA+IElu
IHRoZSBkYXRhIHBhdGgsIHRoZSBWRFVTRSBkcml2ZXIgaW1wbGVtZW50cyBhIE1NVS1iYXNlZAo+
ICAgICA+wqAgwqAgwqA+IG9uLWNoaXAgSU9NTVUgZHJpdmVyIHdoaWNoIHN1cHBvcnRzIGJvdGgg
ZGlyZWN0IG1hcHBpbmcgYW5kCj4gICAgID7CoCDCoCDCoD4gaW5kaXJlY3QgbWFwcGluZyB3aXRo
IGJvdW5jZSBidWZmZXIuIFRoZW4gdXNlcnNwYWNlIGNhbiBhY2Nlc3MKPiAgICAgPsKgIMKgIMKg
PiB0aG9zZSBpb3ZhIHNwYWNlIHZpYSBtbWFwKCkuIEJlc2lkZXMsIGV2ZW50ZmQgbWVjaG5pc20g
aXMKPiAgICAgdXNlZCB0bwo+ICAgICA+wqAgwqAgwqA+IHRyaWdnZXIgaW50ZXJydXB0cyBhbmQg
Zm9yd2FyZCB2aXJ0cXVldWUga2lja3MuCj4gICAgID4KPiAgICAgPgo+ICAgICA+wqAgwqAgwqBU
aGlzIGlzIHByZXR0eSBpbnRlcmVzdGluZyEKPiAgICAgPgo+ICAgICA+wqAgwqAgwqBGb3Igdmhv
c3QtdmRwYSwgaXQgc2hvdWxkIHdvcmssIGJ1dCBmb3IgdmlydGlvLXZkcGEsIEkgdGhpbmsgd2UK
PiAgICAgPsKgIMKgIMKgc2hvdWxkCj4gICAgID7CoCDCoCDCoGNhcmVmdWxseSBkZWFsIHdpdGgg
dGhlIElPTU1VL0RNQSBvcHMgc3R1ZmZzLgo+ICAgICA+Cj4gICAgID4KPiAgICAgPsKgIMKgIMKg
SSBub3RpY2UgdGhhdCBuZWl0aGVyIGRtYV9tYXAgbm9yIHNldF9tYXAgaXMgaW1wbGVtZW50ZWQg
aW4KPiAgICAgPsKgIMKgIMKgdmR1c2VfdmRwYV9jb25maWdfb3BzLCB0aGlzIG1lYW5zIHlvdSB3
YW50IHRvIGxldCB2aG9zdC12RFBBCj4gICAgIHRvIGRlYWwKPiAgICAgPsKgIMKgIMKgd2l0aCBJ
T01NVSBkb21haW5zIHN0dWZmcy7CoCBBbnkgcmVhc29uIGZvciBkb2luZyB0aGF0Pwo+ICAgICA+
Cj4gICAgID4gQWN0dWFsbHksIHRoaXMgc2VyaWVzIG9ubHkgZm9jdXMgb24gdmlydGlvLXZkcGEg
Y2FzZSBub3cuIFRvCj4gICAgIHN1cHBvcnQKPiAgICAgPiB2aG9zdC12ZHBhLMKgIGFzIHlvdSBz
YWlkLCB3ZSBuZWVkIHRvIGltcGxlbWVudAo+ICAgICBkbWFfbWFwL2RtYV91bm1hcC4gQnV0Cj4g
ICAgID4gdGhlcmUgaXMgYSBsaW1pdCB0aGF0IHZtJ3MgbWVtb3J5IGNhbid0IGJlIGFub255bW91
cyBwYWdlcyB3aGljaAo+ICAgICBhcmUKPiAgICAgPiBmb3JiaWRkZW4gaW4gdm1faW5zZXJ0X3Bh
Z2UoKS4gTWF5YmUgd2UgbmVlZCB0byBhZGQgc29tZSBsaW1pdHMgb24KPiAgICAgPiB2aG9zdC12
ZHBhPwo+Cj4KPiAgICAgSSdtIG5vdCBzdXJlIEkgZ2V0IHRoaXMsIGFueSByZWFzb24gdGhhdCB5
b3Ugd2FudCB0byB1c2UKPiAgICAgdm1faW5zZXJ0X3BhZ2UoKSB0byBWTSdzIG1lbW9yeS4gT3Ig
ZG8geW91IG1lYW4geW91IHdhbnQgdG8gaW1wbGVtZW50Cj4gICAgIHNvbWUga2luZCBvZiB6ZXJv
LWNvcHk/IAo+Cj4KPgo+IElmIG15IHVuZGVyc3RhbmRpbmcgaXMgcmlnaHQsIHdlIHdpbGwgaGF2
ZSBhIFFFTVUgKFZNKSBwcm9jZXNzIGFuZCBhIAo+IGRldmljZSBlbXVsYXRpb24gcHJvY2VzcyBp
biB0aGUgdmhvc3QtdmRwYSBjYXNlLCByaWdodD8gV2hlbiBJL08gCj4gaGFwcGVucywgdGhlIHZp
cnRpbyBkcml2ZXIgaW4gVk0gd2lsbCBwdXQgdGhlIElPVkEgdG8gdnJpbmcgYW5kIGRldmljZSAK
PiBlbXVsYXRpb24gcHJvY2VzcyB3aWxsIGdldCB0aGUgSU9WQSBmcm9tIHZyaW5nLiBUaGVuIHRo
ZSBkZXZpY2UgCj4gZW11bGF0aW9uIHByb2Nlc3Mgd2lsbMKgdHJhbnNsYXRlIHRoZSBJT1ZBIHRv
IGl0cyBWQSB0byBhY2Nlc3MgdGhlIGRtYSAKPiBidWZmZXIgd2hpY2ggcmVzaWRlcyBpbiBWTSdz
IG1lbW9yeS4gVGhhdCBtZWFucyB0aGUgZGV2aWNlIGVtdWxhdGlvbiAKPiBwcm9jZXNzIG5lZWRz
IHRvIGFjY2VzcyBWTSdzwqBtZW1vcnksIHNvIHdlIHNob3VsZCB1c2Ugdm1faW5zZXJ0X3BhZ2Uo
KSAKPiB0byBidWlsZCB0aGUgcGFnZSB0YWJsZSBvZiB0aGUgZGV2aWNlIGVtdWxhdGlvbiBwcm9j
ZXNzLgoKCk9rLCBJIGdldCB5b3Ugbm93LiBTbyBpdCBsb29rcyB0byBtZSB0aGUgdGhhdCB0aGUg
cmVhbCBpc3N1ZSBpcyBub3QgdGhlIApsaW1pdGF0aW9uIHRvIGFub255bW91cyBwYWdlIGJ1dCBz
ZWUgdGhlIGNvbW1lbnRzIGFib3ZlIHZtX2luc2VydF9wYWdlKCk6CgoiCgogwqAqIFRoZSBwYWdl
IGhhcyB0byBiZSBhIG5pY2UgY2xlYW4gX2luZGl2aWR1YWxfIGtlcm5lbCBhbGxvY2F0aW9uLgoi
CgpTbyBJIHN1c3BlY3QgdGhhdCB1c2luZyB2bV9pbnNlcnRfcGFnZSgpIHRvIHNoYXJlIHBhZ2Vz
IGJldHdlZW4gCnByb2Nlc3NlcyBpcyBsZWdhbC4gV2UgbmVlZCBpbnB1dHMgZnJvbSBNTSBleHBl
cnRzLgoKVGhhbmtzCgoKPgo+ICAgICBJIGd1ZXNzIGZyb20gdGhlIHNvZnR3YXJlIGRldmljZSBp
bXBsZW1lbnRpb24gaW4gdXNlciBzcGFjZSBpdAo+ICAgICBvbmx5IG5lZWQKPiAgICAgdG8gcmVj
ZWl2ZSBJT1ZBIHJhbmdlcyBhbmQgbWFwIHRoZW0gaW4gaXRzIG93biBhZGRyZXNzIHNwYWNlLgo+
Cj4KPiBIb3cgdG8gbWFwIHRoZW0gaW4gaXRzIG93biBhZGRyZXNzIHNwYWNlIGlmIHdlIGRvbid0
IHVzZSB2bV9pbnNlcnRfcGFnZSgpPwoKX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX18KVmlydHVhbGl6YXRpb24gbWFpbGluZyBsaXN0ClZpcnR1YWxpemF0aW9u
QGxpc3RzLmxpbnV4LWZvdW5kYXRpb24ub3JnCmh0dHBzOi8vbGlzdHMubGludXhmb3VuZGF0aW9u
Lm9yZy9tYWlsbWFuL2xpc3RpbmZvL3ZpcnR1YWxpemF0aW9u
