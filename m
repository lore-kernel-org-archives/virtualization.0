Return-Path: <SRS0=cI1G=H2=lists.linux-foundation.org=virtualization-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.1 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C3DC9C433E0
	for <virtualization@archiver.kernel.org>; Wed, 24 Feb 2021 06:02:36 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 168E364E20
	for <virtualization@archiver.kernel.org>; Wed, 24 Feb 2021 06:02:36 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 168E364E20
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=virtualization-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by smtp2.osuosl.org (Postfix) with ESMTP id 9FFF34307A;
	Wed, 24 Feb 2021 06:02:35 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
	by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id y4iOzhwqrDYK; Wed, 24 Feb 2021 06:02:34 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp2.osuosl.org (Postfix) with ESMTP id 2E603414F0;
	Wed, 24 Feb 2021 06:02:34 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id F247FC000B;
	Wed, 24 Feb 2021 06:02:33 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 020D4C000B
 for <virtualization@lists.linux-foundation.org>;
 Wed, 24 Feb 2021 06:02:32 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id CC3174307A
 for <virtualization@lists.linux-foundation.org>;
 Wed, 24 Feb 2021 06:02:32 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id OkJUtzldApQH
 for <virtualization@lists.linux-foundation.org>;
 Wed, 24 Feb 2021 06:02:30 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [63.128.21.124])
 by smtp2.osuosl.org (Postfix) with ESMTPS id 76A38414ED
 for <virtualization@lists.linux-foundation.org>;
 Wed, 24 Feb 2021 06:02:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1614146549;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=pKAEd9NzF+Or8LXDVPURGBie8jn43KIqg+dfY0MsUC4=;
 b=KVMjt8c1mVIdSrFz1qs59mebbqhr9YLN42umBXt9QlSOqqJi+ADyH9WCl65Is6FiJOAEGo
 +6y7sTAxCPXCY1ZvpcsXYsu51et6qZX4qRxx+ZdjOu61L+OkHoHKBkB1dQ8ArwmFwi7SOW
 8z0d1mn419guEN0l6SQUfembLLYbk18=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-342-P5Ah9MdgPFGe83aGepremw-1; Wed, 24 Feb 2021 01:02:23 -0500
X-MC-Unique: P5Ah9MdgPFGe83aGepremw-1
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com
 [10.5.11.13])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 079391005501;
 Wed, 24 Feb 2021 06:02:22 +0000 (UTC)
Received: from wangxiaodeMacBook-Air.local (ovpn-13-96.pek2.redhat.com
 [10.72.13.96])
 by smtp.corp.redhat.com (Postfix) with ESMTP id E1ADF6061F;
 Wed, 24 Feb 2021 06:02:16 +0000 (UTC)
Subject: Re: [PATCH] vdpa/mlx5: set_features should allow reset to zero
To: "Michael S. Tsirkin" <mst@redhat.com>
References: <1613735698-3328-1-git-send-email-si-wei.liu@oracle.com>
 <605e7d2d-4f27-9688-17a8-d57191752ee7@redhat.com>
 <20210222023040-mutt-send-email-mst@kernel.org>
 <22fe5923-635b-59f0-7643-2fd5876937c2@oracle.com>
 <fae0bae7-e4cd-a3aa-57fe-d707df99b634@redhat.com>
 <20210223082536-mutt-send-email-mst@kernel.org>
 <3ff5fd23-1db0-2f95-4cf9-711ef403fb62@oracle.com>
 <7e6291a4-30b1-6b59-a2bf-713e7b56826d@redhat.com>
 <20210224000528-mutt-send-email-mst@kernel.org>
From: Jason Wang <jasowang@redhat.com>
Message-ID: <8fe0e218-3733-9aa3-d2df-cde561613e2b@redhat.com>
Date: Wed, 24 Feb 2021 14:02:15 +0800
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.16; rv:78.0)
 Gecko/20100101 Thunderbird/78.7.1
MIME-Version: 1.0
In-Reply-To: <20210224000528-mutt-send-email-mst@kernel.org>
Content-Language: en-GB
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
Cc: Si-Wei Liu <si-wei.liu@oracle.com>, netdev@vger.kernel.org, elic@nvidia.com,
 linux-kernel@vger.kernel.org, virtualization@lists.linux-foundation.org
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

Ck9uIDIwMjEvMi8yNCAxOjE3IOS4i+WNiCwgTWljaGFlbCBTLiBUc2lya2luIHdyb3RlOgo+IE9u
IFdlZCwgRmViIDI0LCAyMDIxIGF0IDExOjIwOjAxQU0gKzA4MDAsIEphc29uIFdhbmcgd3JvdGU6
Cj4+IE9uIDIwMjEvMi8yNCAzOjM1IOS4iuWNiCwgU2ktV2VpIExpdSB3cm90ZToKPj4+Cj4+PiBP
biAyLzIzLzIwMjEgNToyNiBBTSwgTWljaGFlbCBTLiBUc2lya2luIHdyb3RlOgo+Pj4+IE9uIFR1
ZSwgRmViIDIzLCAyMDIxIGF0IDEwOjAzOjU3QU0gKzA4MDAsIEphc29uIFdhbmcgd3JvdGU6Cj4+
Pj4+IE9uIDIwMjEvMi8yMyA5OjEyIOS4iuWNiCwgU2ktV2VpIExpdSB3cm90ZToKPj4+Pj4+IE9u
IDIvMjEvMjAyMSAxMTozNCBQTSwgTWljaGFlbCBTLiBUc2lya2luIHdyb3RlOgo+Pj4+Pj4+IE9u
IE1vbiwgRmViIDIyLCAyMDIxIGF0IDEyOjE0OjE3UE0gKzA4MDAsIEphc29uIFdhbmcgd3JvdGU6
Cj4+Pj4+Pj4+IE9uIDIwMjEvMi8xOSA3OjU0IOS4i+WNiCwgU2ktV2VpIExpdSB3cm90ZToKPj4+
Pj4+Pj4+IENvbW1pdCA0NTI2MzlhNjRhZDggKCJ2ZHBhOiBtYWtlIHN1cmUgc2V0X2ZlYXR1cmVz
IGlzIGludm9rZWQKPj4+Pj4+Pj4+IGZvciBsZWdhY3kiKSBtYWRlIGFuIGV4Y2VwdGlvbiBmb3Ig
bGVnYWN5IGd1ZXN0cyB0byByZXNldAo+Pj4+Pj4+Pj4gZmVhdHVyZXMgdG8gMCwgd2hlbiBjb25m
aWcgc3BhY2UgaXMgYWNjZXNzZWQgYmVmb3JlIGZlYXR1cmVzCj4+Pj4+Pj4+PiBhcmUgc2V0LiBX
ZSBzaG91bGQgcmVsaWV2ZSB0aGUgdmVyaWZ5X21pbl9mZWF0dXJlcygpIGNoZWNrCj4+Pj4+Pj4+
PiBhbmQgYWxsb3cgZmVhdHVyZXMgcmVzZXQgdG8gMCBmb3IgdGhpcyBjYXNlLgo+Pj4+Pj4+Pj4K
Pj4+Pj4+Pj4+IEl0J3Mgd29ydGggbm90aW5nIHRoYXQgbm90IGp1c3QgbGVnYWN5IGd1ZXN0cyBj
b3VsZCBhY2Nlc3MKPj4+Pj4+Pj4+IGNvbmZpZyBzcGFjZSBiZWZvcmUgZmVhdHVyZXMgYXJlIHNl
dC4gRm9yIGluc3RhbmNlLCB3aGVuCj4+Pj4+Pj4+PiBmZWF0dXJlIFZJUlRJT19ORVRfRl9NVFUg
aXMgYWR2ZXJ0aXNlZCBzb21lIG1vZGVybiBkcml2ZXIKPj4+Pj4+Pj4+IHdpbGwgdHJ5IHRvIGFj
Y2VzcyBhbmQgdmFsaWRhdGUgdGhlIE1UVSBwcmVzZW50IGluIHRoZSBjb25maWcKPj4+Pj4+Pj4+
IHNwYWNlIGJlZm9yZSB2aXJ0aW8gZmVhdHVyZXMgYXJlIHNldC4KPj4+Pj4+Pj4gVGhpcyBsb29r
cyBsaWtlIGEgc3BlYyB2aW9sYXRpb246Cj4+Pj4+Pj4+Cj4+Pj4+Pj4+ICIKPj4+Pj4+Pj4KPj4+
Pj4+Pj4gVGhlIGZvbGxvd2luZyBkcml2ZXItcmVhZC1vbmx5IGZpZWxkLCBtdHUgb25seSBleGlz
dHMgaWYKPj4+Pj4+Pj4gVklSVElPX05FVF9GX01UVSBpcwo+Pj4+Pj4+PiBzZXQuCj4+Pj4+Pj4+
IFRoaXMgZmllbGQgc3BlY2lmaWVzIHRoZSBtYXhpbXVtIE1UVSBmb3IgdGhlIGRyaXZlciB0byB1
c2UuCj4+Pj4+Pj4+ICIKPj4+Pj4+Pj4KPj4+Pj4+Pj4gRG8gd2UgcmVhbGx5IHdhbnQgdG8gd29y
a2Fyb3VuZCB0aGlzPwo+Pj4+Pj4+Pgo+Pj4+Pj4+PiBUaGFua3MKPj4+Pj4+PiBBbmQgYWxzbzoK
Pj4+Pj4+Pgo+Pj4+Pj4+IFRoZSBkcml2ZXIgTVVTVCBmb2xsb3cgdGhpcyBzZXF1ZW5jZSB0byBp
bml0aWFsaXplIGEgZGV2aWNlOgo+Pj4+Pj4+IDEuIFJlc2V0IHRoZSBkZXZpY2UuCj4+Pj4+Pj4g
Mi4gU2V0IHRoZSBBQ0tOT1dMRURHRSBzdGF0dXMgYml0OiB0aGUgZ3Vlc3QgT1MgaGFzCj4+Pj4+
Pj4gbm90aWNlZCB0aGUgZGV2aWNlLgo+Pj4+Pj4+IDMuIFNldCB0aGUgRFJJVkVSIHN0YXR1cyBi
aXQ6IHRoZSBndWVzdCBPUyBrbm93cyBob3cgdG8gZHJpdmUgdGhlCj4+Pj4+Pj4gZGV2aWNlLgo+
Pj4+Pj4+IDQuIFJlYWQgZGV2aWNlIGZlYXR1cmUgYml0cywgYW5kIHdyaXRlIHRoZSBzdWJzZXQg
b2YgZmVhdHVyZSBiaXRzCj4+Pj4+Pj4gdW5kZXJzdG9vZCBieSB0aGUgT1MgYW5kIGRyaXZlciB0
byB0aGUKPj4+Pj4+PiBkZXZpY2UuIER1cmluZyB0aGlzIHN0ZXAgdGhlIGRyaXZlciBNQVkgcmVh
ZCAoYnV0IE1VU1QgTk9UIHdyaXRlKQo+Pj4+Pj4+IHRoZSBkZXZpY2Utc3BlY2lmaWMgY29uZmln
dXJhdGlvbgo+Pj4+Pj4+IGZpZWxkcyB0byBjaGVjayB0aGF0IGl0IGNhbiBzdXBwb3J0IHRoZSBk
ZXZpY2UgYmVmb3JlIGFjY2VwdGluZyBpdC4KPj4+Pj4+PiA1LiBTZXQgdGhlIEZFQVRVUkVTX09L
IHN0YXR1cyBiaXQuIFRoZSBkcml2ZXIgTVVTVCBOT1QgYWNjZXB0IG5ldwo+Pj4+Pj4+IGZlYXR1
cmUgYml0cyBhZnRlciB0aGlzIHN0ZXAuCj4+Pj4+Pj4gNi4gUmUtcmVhZCBkZXZpY2Ugc3RhdHVz
IHRvIGVuc3VyZSB0aGUgRkVBVFVSRVNfT0sgYml0IGlzIHN0aWxsIHNldDoKPj4+Pj4+PiBvdGhl
cndpc2UsIHRoZSBkZXZpY2UgZG9lcyBub3QKPj4+Pj4+PiBzdXBwb3J0IG91ciBzdWJzZXQgb2Yg
ZmVhdHVyZXMgYW5kIHRoZSBkZXZpY2UgaXMgdW51c2FibGUuCj4+Pj4+Pj4gNy4gUGVyZm9ybSBk
ZXZpY2Utc3BlY2lmaWMgc2V0dXAsIGluY2x1ZGluZyBkaXNjb3Zlcnkgb2YgdmlydHF1ZXVlcwo+
Pj4+Pj4+IGZvciB0aGUgZGV2aWNlLCBvcHRpb25hbCBwZXItYnVzIHNldHVwLAo+Pj4+Pj4+IHJl
YWRpbmcgYW5kIHBvc3NpYmx5IHdyaXRpbmcgdGhlIGRldmljZeKAmXMgdmlydGlvIGNvbmZpZ3Vy
YXRpb24KPj4+Pj4+PiBzcGFjZSwgYW5kIHBvcHVsYXRpb24gb2YgdmlydHF1ZXVlcy4KPj4+Pj4+
PiA4LiBTZXQgdGhlIERSSVZFUl9PSyBzdGF0dXMgYml0LiBBdCB0aGlzIHBvaW50IHRoZSBkZXZp
Y2UgaXMg4oCcbGl2ZeKAnS4KPj4+Pj4+Pgo+Pj4+Pj4+Cj4+Pj4+Pj4gc28gYWNjZXNzaW5nIGNv
bmZpZyBzcGFjZSBiZWZvcmUgRkVBVFVSRVNfT0sgaXMgYSBzcGVjCj4+Pj4+Pj4gdmlvbGF0aW9u
LCByaWdodD8KPj4+Pj4+IEl0IGlzLCBidXQgaXQncyBub3QgcmVsZXZhbnQgdG8gd2hhdCB0aGlz
IGNvbW1pdCB0cmllcyB0byBhZGRyZXNzLiBJCj4+Pj4+PiB0aG91Z2h0IHRoZSBsZWdhY3kgZ3Vl
c3Qgc3RpbGwgbmVlZHMgdG8gYmUgc3VwcG9ydGVkLgo+Pj4+Pj4KPj4+Pj4+IEhhdmluZyBzYWlk
LCBhIHNlcGFyYXRlIHBhdGNoIGhhcyB0byBiZSBwb3N0ZWQgdG8gZml4IHRoZSBndWVzdCBkcml2
ZXIKPj4+Pj4+IGlzc3VlIHdoZXJlIHRoaXMgZGlzY3JlcGFuY3kgaXMgaW50cm9kdWNlZCB0bwo+
Pj4+Pj4gdmlydG5ldF92YWxpZGF0ZSgpIChzaW5jZQo+Pj4+Pj4gY29tbWl0IGZlMzZjYmUwNjcp
LiBCdXQgaXQncyBub3QgdGVjaG5pY2FsbHkgcmVsYXRlZCB0byB0aGlzIHBhdGNoLgo+Pj4+Pj4K
Pj4+Pj4+IC1TaXdlaQo+Pj4+PiBJIHRoaW5rIGl0J3MgYSBidWcgdG8gcmVhZCBjb25maWcgc3Bh
Y2UgaW4gdmFsaWRhdGUsIHdlIHNob3VsZAo+Pj4+PiBtb3ZlIGl0IHRvCj4+Pj4+IHZpcnRuZXRf
cHJvYmUoKS4KPj4+Pj4KPj4+Pj4gVGhhbmtzCj4+Pj4gSSB0YWtlIGl0IGJhY2ssIHJlYWRpbmcg
YnV0IG5vdCB3cml0aW5nIHNlZW1zIHRvIGJlIGV4cGxpY2l0bHkKPj4+PiBhbGxvd2VkIGJ5IHNw
ZWMuCj4+Pj4gU28gb3VyIHdheSB0byBkZXRlY3QgYSBsZWdhY3kgZ3Vlc3QgaXMgYm9ndXMsIG5l
ZWQgdG8gdGhpbmsgd2hhdCBpcwo+Pj4+IHRoZSBiZXN0IHdheSB0byBoYW5kbGUgdGhpcy4KPj4+
IFRoZW4gbWF5YmUgcmV2ZXJ0IGNvbW1pdCBmZTM2Y2JlMDY3IGFuZCBmcmllbmRzLCBhbmQgaGF2
ZSBRRU1VIGRldGVjdAo+Pj4gbGVnYWN5IGd1ZXN0PyBTdXBwb3NlZGx5IG9ubHkgY29uZmlnIHNw
YWNlIHdyaXRlIGFjY2VzcyBuZWVkcyB0byBiZQo+Pj4gZ3VhcmRlZCBiZWZvcmUgc2V0dGluZyBG
RUFUVVJFU19PSy4KPj4KPj4gSSBhZ3JlZS4gTXkgdW5kZXJzdGFuZGluZyBpcyB0aGF0IGFsbCB2
RFBBIG11c3QgYmUgbW9kZXJuIGRldmljZSAoc2luY2UKPj4gVklSSVRPX0ZfQUNDRVNTX1BMQVRG
T1JNIGlzIG1hbmRhdGVkKSBpbnN0ZWFkIG9mIHRyYW5zaXRpb25hbCBkZXZpY2UuCj4+Cj4+IFRo
YW5rcwo+IFdlbGwgbWx4NSBoYXMgc29tZSBjb2RlIHRvIGhhbmRsZSBsZWdhY3kgZ3Vlc3RzIC4u
LgoKCk15IHVuZGVyc3RhbmRpbmcgaXMgdGhhdCwgZXZlbiBpZiBtbHg1IGlzIG1vZGVybiBkZXZp
Y2UgaXQgY2FuIHN0aWxsIApzdXBwb3QgbGVnYWN5IGd1ZXN0cyBzaW5jZSB0aGUgZGV2aWNlIHNh
dyBieSBndWVzdCBpcyBlbXVsYXRlZCBieSBRZW11LiAKUWVtdSBjYW4ganVzdCBwcmVzZW50IGEg
dHJhbnNpdGlvbmFsIGRldmljZSB0byBndWVzdCwgYnV0IG5lZ290aWF0ZSAKVklSVElPX0ZfQUND
RVNTX1BMQVRGT1JNLiAoQWN0dWFsbHkgdGhpcyBpcyB3aGF0IGhhcyBiZWVuIGRvbmUgbm93KS4K
ClRoYW5rcwoKCj4gRWxpLCBjb3VsZCB5b3UgY29tbWVudD8gSXMgdGhhdCBzdXBwb3J0IHVudXNl
ZCByaWdodCBub3c/Cj4KPgo+Pj4gLVNpd2llCj4+Pgo+Pj4+Pj4+Pj4gUmVqZWN0aW5nIHJlc2V0
IHRvIDAKPj4+Pj4+Pj4+IHByZW1hdHVyZWx5IGNhdXNlcyBjb3JyZWN0IE1UVSBhbmQgbGluayBz
dGF0dXMgdW5hYmxlIHRvIGxvYWQKPj4+Pj4+Pj4+IGZvciB0aGUgdmVyeSBmaXJzdCBjb25maWcg
c3BhY2UgYWNjZXNzLCByZW5kZXJpbmcgaXNzdWVzIGxpa2UKPj4+Pj4+Pj4+IGd1ZXN0IHNob3dp
bmcgaW5hY2N1cmF0ZSBNVFUgdmFsdWUsIG9yIGZhaWx1cmUgdG8gcmVqZWN0Cj4+Pj4+Pj4+PiBv
dXQtb2YtcmFuZ2UgTVRVLgo+Pj4+Pj4+Pj4KPj4+Pj4+Pj4+IEZpeGVzOiAxYTg2YjM3N2FhMjEg
KCJ2ZHBhL21seDU6IEFkZCBWRFBBIGRyaXZlciBmb3IKPj4+Pj4+Pj4+IHN1cHBvcnRlZCBtbHg1
IGRldmljZXMiKQo+Pj4+Pj4+Pj4gU2lnbmVkLW9mZi1ieTogU2ktV2VpIExpdSA8c2ktd2VpLmxp
dUBvcmFjbGUuY29tPgo+Pj4+Pj4+Pj4gLS0tCj4+Pj4+Pj4+PiAgwqDCoMKgIGRyaXZlcnMvdmRw
YS9tbHg1L25ldC9tbHg1X3ZuZXQuYyB8IDE1ICstLS0tLS0tLS0tLS0tLQo+Pj4+Pj4+Pj4gIMKg
wqDCoCAxIGZpbGUgY2hhbmdlZCwgMSBpbnNlcnRpb24oKyksIDE0IGRlbGV0aW9ucygtKQo+Pj4+
Pj4+Pj4KPj4+Pj4+Pj4+IGRpZmYgLS1naXQgYS9kcml2ZXJzL3ZkcGEvbWx4NS9uZXQvbWx4NV92
bmV0LmMKPj4+Pj4+Pj4+IGIvZHJpdmVycy92ZHBhL21seDUvbmV0L21seDVfdm5ldC5jCj4+Pj4+
Pj4+PiBpbmRleCA3YzFmNzg5Li41NDBkZDY3IDEwMDY0NAo+Pj4+Pj4+Pj4gLS0tIGEvZHJpdmVy
cy92ZHBhL21seDUvbmV0L21seDVfdm5ldC5jCj4+Pj4+Pj4+PiArKysgYi9kcml2ZXJzL3ZkcGEv
bWx4NS9uZXQvbWx4NV92bmV0LmMKPj4+Pj4+Pj4+IEBAIC0xNDkwLDE0ICsxNDkwLDYgQEAgc3Rh
dGljIHU2NAo+Pj4+Pj4+Pj4gbWx4NV92ZHBhX2dldF9mZWF0dXJlcyhzdHJ1Y3QgdmRwYV9kZXZp
Y2UgKnZkZXYpCj4+Pj4+Pj4+PiAgwqDCoMKgwqDCoMKgwqAgcmV0dXJuIG12ZGV2LT5tbHhfZmVh
dHVyZXM7Cj4+Pj4+Pj4+PiAgwqDCoMKgIH0KPj4+Pj4+Pj4+IC1zdGF0aWMgaW50IHZlcmlmeV9t
aW5fZmVhdHVyZXMoc3RydWN0IG1seDVfdmRwYV9kZXYgKm12ZGV2LAo+Pj4+Pj4+Pj4gdTY0IGZl
YXR1cmVzKQo+Pj4+Pj4+Pj4gLXsKPj4+Pj4+Pj4+IC3CoMKgwqAgaWYgKCEoZmVhdHVyZXMgJiBC
SVRfVUxMKFZJUlRJT19GX0FDQ0VTU19QTEFURk9STSkpKQo+Pj4+Pj4+Pj4gLcKgwqDCoMKgwqDC
oMKgIHJldHVybiAtRU9QTk9UU1VQUDsKPj4+Pj4+Pj4+IC0KPj4+Pj4+Pj4+IC3CoMKgwqAgcmV0
dXJuIDA7Cj4+Pj4+Pj4+PiAtfQo+Pj4+Pj4+Pj4gLQo+Pj4+Pj4+Pj4gIMKgwqDCoCBzdGF0aWMg
aW50IHNldHVwX3ZpcnRxdWV1ZXMoc3RydWN0IG1seDVfdmRwYV9uZXQgKm5kZXYpCj4+Pj4+Pj4+
PiAgwqDCoMKgIHsKPj4+Pj4+Pj4+ICDCoMKgwqDCoMKgwqDCoCBpbnQgZXJyOwo+Pj4+Pj4+Pj4g
QEAgLTE1NTgsMTggKzE1NTAsMTMgQEAgc3RhdGljIGludAo+Pj4+Pj4+Pj4gbWx4NV92ZHBhX3Nl
dF9mZWF0dXJlcyhzdHJ1Y3QgdmRwYV9kZXZpY2UgKnZkZXYsIHU2NAo+Pj4+Pj4+Pj4gZmVhdHVy
ZXMpCj4+Pj4+Pj4+PiAgwqDCoMKgIHsKPj4+Pj4+Pj4+ICDCoMKgwqDCoMKgwqDCoCBzdHJ1Y3Qg
bWx4NV92ZHBhX2RldiAqbXZkZXYgPSB0b19tdmRldih2ZGV2KTsKPj4+Pj4+Pj4+ICDCoMKgwqDC
oMKgwqDCoCBzdHJ1Y3QgbWx4NV92ZHBhX25ldCAqbmRldiA9IHRvX21seDVfdmRwYV9uZGV2KG12
ZGV2KTsKPj4+Pj4+Pj4+IC3CoMKgwqAgaW50IGVycjsKPj4+Pj4+Pj4+ICDCoMKgwqDCoMKgwqDC
oCBwcmludF9mZWF0dXJlcyhtdmRldiwgZmVhdHVyZXMsIHRydWUpOwo+Pj4+Pj4+Pj4gLcKgwqDC
oCBlcnIgPSB2ZXJpZnlfbWluX2ZlYXR1cmVzKG12ZGV2LCBmZWF0dXJlcyk7Cj4+Pj4+Pj4+PiAt
wqDCoMKgIGlmIChlcnIpCj4+Pj4+Pj4+PiAtwqDCoMKgwqDCoMKgwqAgcmV0dXJuIGVycjsKPj4+
Pj4+Pj4+IC0KPj4+Pj4+Pj4+ICDCoMKgwqDCoMKgwqDCoCBuZGV2LT5tdmRldi5hY3R1YWxfZmVh
dHVyZXMgPSBmZWF0dXJlcyAmCj4+Pj4+Pj4+PiBuZGV2LT5tdmRldi5tbHhfZmVhdHVyZXM7Cj4+
Pj4+Pj4+PiAgwqDCoMKgwqDCoMKgwqAgbmRldi0+Y29uZmlnLm10dSA9IGNwdV90b19tbHg1dmRw
YTE2KG12ZGV2LCBuZGV2LT5tdHUpOwo+Pj4+Pj4+Pj4gIMKgwqDCoMKgwqDCoMKgIG5kZXYtPmNv
bmZpZy5zdGF0dXMgfD0gY3B1X3RvX21seDV2ZHBhMTYobXZkZXYsCj4+Pj4+Pj4+PiBWSVJUSU9f
TkVUX1NfTElOS19VUCk7Cj4+Pj4+Pj4+PiAtwqDCoMKgIHJldHVybiBlcnI7Cj4+Pj4+Pj4+PiAr
wqDCoMKgIHJldHVybiAwOwo+Pj4+Pj4+Pj4gIMKgwqDCoCB9Cj4+Pj4+Pj4+PiAgwqDCoMKgIHN0
YXRpYyB2b2lkIG1seDVfdmRwYV9zZXRfY29uZmlnX2NiKHN0cnVjdCB2ZHBhX2RldmljZQo+Pj4+
Pj4+Pj4gKnZkZXYsIHN0cnVjdCB2ZHBhX2NhbGxiYWNrICpjYikKCl9fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fClZpcnR1YWxpemF0aW9uIG1haWxpbmcgbGlz
dApWaXJ0dWFsaXphdGlvbkBsaXN0cy5saW51eC1mb3VuZGF0aW9uLm9yZwpodHRwczovL2xpc3Rz
LmxpbnV4Zm91bmRhdGlvbi5vcmcvbWFpbG1hbi9saXN0aW5mby92aXJ0dWFsaXphdGlvbg==
