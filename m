Return-Path: <SRS0=cI1G=H2=lists.linux-foundation.org=virtualization-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.1 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0B509C433DB
	for <virtualization@archiver.kernel.org>; Wed, 24 Feb 2021 06:55:32 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 7D18264DAF
	for <virtualization@archiver.kernel.org>; Wed, 24 Feb 2021 06:55:31 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7D18264DAF
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=virtualization-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 22AEC4EB9D;
	Wed, 24 Feb 2021 06:55:31 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
	by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id CBUytD16rh4f; Wed, 24 Feb 2021 06:55:30 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp4.osuosl.org (Postfix) with ESMTP id 723AB4EBB9;
	Wed, 24 Feb 2021 06:55:29 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 46C1DC000A;
	Wed, 24 Feb 2021 06:55:29 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 4CF83C0001
 for <virtualization@lists.linux-foundation.org>;
 Wed, 24 Feb 2021 06:55:28 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id 259CF4EBB9
 for <virtualization@lists.linux-foundation.org>;
 Wed, 24 Feb 2021 06:55:28 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id TXjGjEeudjUh
 for <virtualization@lists.linux-foundation.org>;
 Wed, 24 Feb 2021 06:55:27 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [216.205.24.124])
 by smtp4.osuosl.org (Postfix) with ESMTPS id D6FB84EB9D
 for <virtualization@lists.linux-foundation.org>;
 Wed, 24 Feb 2021 06:55:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1614149725;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=//VjBrrX+diVQv6GNcoSTqGXAnitFixElwDMOSM+paQ=;
 b=a2lnLZiyAVuQzPHNa/ATJMhkYspPi49O+4lSECw+JpewFvYefrlojbn9kJxy4AO29uxz19
 Kua67DbxbIoayp3Z1JBh7wIdr7VdI64IBMHgBVjhzq+VIdYUMreQxkHIkEH/RPcczp0H0b
 t+x1vFT7KKbNWYhXT7DPTM0jMfK9jbE=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-365-n7LCUzJENcSl-At0g7dlDQ-1; Wed, 24 Feb 2021 01:55:21 -0500
X-MC-Unique: n7LCUzJENcSl-At0g7dlDQ-1
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com
 [10.5.11.11])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id D73C6801965;
 Wed, 24 Feb 2021 06:55:19 +0000 (UTC)
Received: from wangxiaodeMacBook-Air.local (ovpn-13-96.pek2.redhat.com
 [10.72.13.96])
 by smtp.corp.redhat.com (Postfix) with ESMTP id CB2DE72F84;
 Wed, 24 Feb 2021 06:55:14 +0000 (UTC)
Subject: Re: [PATCH] vdpa/mlx5: set_features should allow reset to zero
To: "Michael S. Tsirkin" <mst@redhat.com>, Eli Cohen <elic@nvidia.com>
References: <1613735698-3328-1-git-send-email-si-wei.liu@oracle.com>
 <605e7d2d-4f27-9688-17a8-d57191752ee7@redhat.com>
 <20210222023040-mutt-send-email-mst@kernel.org>
 <22fe5923-635b-59f0-7643-2fd5876937c2@oracle.com>
 <fae0bae7-e4cd-a3aa-57fe-d707df99b634@redhat.com>
 <20210223082536-mutt-send-email-mst@kernel.org>
 <3ff5fd23-1db0-2f95-4cf9-711ef403fb62@oracle.com>
 <7e6291a4-30b1-6b59-a2bf-713e7b56826d@redhat.com>
 <20210224000528-mutt-send-email-mst@kernel.org>
 <20210224064520.GA204317@mtl-vdi-166.wap.labs.mlnx>
 <20210224014700-mutt-send-email-mst@kernel.org>
From: Jason Wang <jasowang@redhat.com>
Message-ID: <ef775724-b5fb-ca70-ed2f-f23d8fbf4cd8@redhat.com>
Date: Wed, 24 Feb 2021 14:55:13 +0800
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.16; rv:78.0)
 Gecko/20100101 Thunderbird/78.7.1
MIME-Version: 1.0
In-Reply-To: <20210224014700-mutt-send-email-mst@kernel.org>
Content-Language: en-GB
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
Cc: Si-Wei Liu <si-wei.liu@oracle.com>, netdev@vger.kernel.org,
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

Ck9uIDIwMjEvMi8yNCAyOjQ3IOS4i+WNiCwgTWljaGFlbCBTLiBUc2lya2luIHdyb3RlOgo+IE9u
IFdlZCwgRmViIDI0LCAyMDIxIGF0IDA4OjQ1OjIwQU0gKzAyMDAsIEVsaSBDb2hlbiB3cm90ZToK
Pj4gT24gV2VkLCBGZWIgMjQsIDIwMjEgYXQgMTI6MTc6NThBTSAtMDUwMCwgTWljaGFlbCBTLiBU
c2lya2luIHdyb3RlOgo+Pj4gT24gV2VkLCBGZWIgMjQsIDIwMjEgYXQgMTE6MjA6MDFBTSArMDgw
MCwgSmFzb24gV2FuZyB3cm90ZToKPj4+PiBPbiAyMDIxLzIvMjQgMzozNSDkuIrljYgsIFNpLVdl
aSBMaXUgd3JvdGU6Cj4+Pj4+Cj4+Pj4+IE9uIDIvMjMvMjAyMSA1OjI2IEFNLCBNaWNoYWVsIFMu
IFRzaXJraW4gd3JvdGU6Cj4+Pj4+PiBPbiBUdWUsIEZlYiAyMywgMjAyMSBhdCAxMDowMzo1N0FN
ICswODAwLCBKYXNvbiBXYW5nIHdyb3RlOgo+Pj4+Pj4+IE9uIDIwMjEvMi8yMyA5OjEyIOS4iuWN
iCwgU2ktV2VpIExpdSB3cm90ZToKPj4+Pj4+Pj4gT24gMi8yMS8yMDIxIDExOjM0IFBNLCBNaWNo
YWVsIFMuIFRzaXJraW4gd3JvdGU6Cj4+Pj4+Pj4+PiBPbiBNb24sIEZlYiAyMiwgMjAyMSBhdCAx
MjoxNDoxN1BNICswODAwLCBKYXNvbiBXYW5nIHdyb3RlOgo+Pj4+Pj4+Pj4+IE9uIDIwMjEvMi8x
OSA3OjU0IOS4i+WNiCwgU2ktV2VpIExpdSB3cm90ZToKPj4+Pj4+Pj4+Pj4gQ29tbWl0IDQ1MjYz
OWE2NGFkOCAoInZkcGE6IG1ha2Ugc3VyZSBzZXRfZmVhdHVyZXMgaXMgaW52b2tlZAo+Pj4+Pj4+
Pj4+PiBmb3IgbGVnYWN5IikgbWFkZSBhbiBleGNlcHRpb24gZm9yIGxlZ2FjeSBndWVzdHMgdG8g
cmVzZXQKPj4+Pj4+Pj4+Pj4gZmVhdHVyZXMgdG8gMCwgd2hlbiBjb25maWcgc3BhY2UgaXMgYWNj
ZXNzZWQgYmVmb3JlIGZlYXR1cmVzCj4+Pj4+Pj4+Pj4+IGFyZSBzZXQuIFdlIHNob3VsZCByZWxp
ZXZlIHRoZSB2ZXJpZnlfbWluX2ZlYXR1cmVzKCkgY2hlY2sKPj4+Pj4+Pj4+Pj4gYW5kIGFsbG93
IGZlYXR1cmVzIHJlc2V0IHRvIDAgZm9yIHRoaXMgY2FzZS4KPj4+Pj4+Pj4+Pj4KPj4+Pj4+Pj4+
Pj4gSXQncyB3b3J0aCBub3RpbmcgdGhhdCBub3QganVzdCBsZWdhY3kgZ3Vlc3RzIGNvdWxkIGFj
Y2Vzcwo+Pj4+Pj4+Pj4+PiBjb25maWcgc3BhY2UgYmVmb3JlIGZlYXR1cmVzIGFyZSBzZXQuIEZv
ciBpbnN0YW5jZSwgd2hlbgo+Pj4+Pj4+Pj4+PiBmZWF0dXJlIFZJUlRJT19ORVRfRl9NVFUgaXMg
YWR2ZXJ0aXNlZCBzb21lIG1vZGVybiBkcml2ZXIKPj4+Pj4+Pj4+Pj4gd2lsbCB0cnkgdG8gYWNj
ZXNzIGFuZCB2YWxpZGF0ZSB0aGUgTVRVIHByZXNlbnQgaW4gdGhlIGNvbmZpZwo+Pj4+Pj4+Pj4+
PiBzcGFjZSBiZWZvcmUgdmlydGlvIGZlYXR1cmVzIGFyZSBzZXQuCj4+Pj4+Pj4+Pj4gVGhpcyBs
b29rcyBsaWtlIGEgc3BlYyB2aW9sYXRpb246Cj4+Pj4+Pj4+Pj4KPj4+Pj4+Pj4+PiAiCj4+Pj4+
Pj4+Pj4KPj4+Pj4+Pj4+PiBUaGUgZm9sbG93aW5nIGRyaXZlci1yZWFkLW9ubHkgZmllbGQsIG10
dSBvbmx5IGV4aXN0cyBpZgo+Pj4+Pj4+Pj4+IFZJUlRJT19ORVRfRl9NVFUgaXMKPj4+Pj4+Pj4+
PiBzZXQuCj4+Pj4+Pj4+Pj4gVGhpcyBmaWVsZCBzcGVjaWZpZXMgdGhlIG1heGltdW0gTVRVIGZv
ciB0aGUgZHJpdmVyIHRvIHVzZS4KPj4+Pj4+Pj4+PiAiCj4+Pj4+Pj4+Pj4KPj4+Pj4+Pj4+PiBE
byB3ZSByZWFsbHkgd2FudCB0byB3b3JrYXJvdW5kIHRoaXM/Cj4+Pj4+Pj4+Pj4KPj4+Pj4+Pj4+
PiBUaGFua3MKPj4+Pj4+Pj4+IEFuZCBhbHNvOgo+Pj4+Pj4+Pj4KPj4+Pj4+Pj4+IFRoZSBkcml2
ZXIgTVVTVCBmb2xsb3cgdGhpcyBzZXF1ZW5jZSB0byBpbml0aWFsaXplIGEgZGV2aWNlOgo+Pj4+
Pj4+Pj4gMS4gUmVzZXQgdGhlIGRldmljZS4KPj4+Pj4+Pj4+IDIuIFNldCB0aGUgQUNLTk9XTEVE
R0Ugc3RhdHVzIGJpdDogdGhlIGd1ZXN0IE9TIGhhcwo+Pj4+Pj4+Pj4gbm90aWNlZCB0aGUgZGV2
aWNlLgo+Pj4+Pj4+Pj4gMy4gU2V0IHRoZSBEUklWRVIgc3RhdHVzIGJpdDogdGhlIGd1ZXN0IE9T
IGtub3dzIGhvdyB0byBkcml2ZSB0aGUKPj4+Pj4+Pj4+IGRldmljZS4KPj4+Pj4+Pj4+IDQuIFJl
YWQgZGV2aWNlIGZlYXR1cmUgYml0cywgYW5kIHdyaXRlIHRoZSBzdWJzZXQgb2YgZmVhdHVyZSBi
aXRzCj4+Pj4+Pj4+PiB1bmRlcnN0b29kIGJ5IHRoZSBPUyBhbmQgZHJpdmVyIHRvIHRoZQo+Pj4+
Pj4+Pj4gZGV2aWNlLiBEdXJpbmcgdGhpcyBzdGVwIHRoZSBkcml2ZXIgTUFZIHJlYWQgKGJ1dCBN
VVNUIE5PVCB3cml0ZSkKPj4+Pj4+Pj4+IHRoZSBkZXZpY2Utc3BlY2lmaWMgY29uZmlndXJhdGlv
bgo+Pj4+Pj4+Pj4gZmllbGRzIHRvIGNoZWNrIHRoYXQgaXQgY2FuIHN1cHBvcnQgdGhlIGRldmlj
ZSBiZWZvcmUgYWNjZXB0aW5nIGl0Lgo+Pj4+Pj4+Pj4gNS4gU2V0IHRoZSBGRUFUVVJFU19PSyBz
dGF0dXMgYml0LiBUaGUgZHJpdmVyIE1VU1QgTk9UIGFjY2VwdCBuZXcKPj4+Pj4+Pj4+IGZlYXR1
cmUgYml0cyBhZnRlciB0aGlzIHN0ZXAuCj4+Pj4+Pj4+PiA2LiBSZS1yZWFkIGRldmljZSBzdGF0
dXMgdG8gZW5zdXJlIHRoZSBGRUFUVVJFU19PSyBiaXQgaXMgc3RpbGwgc2V0Ogo+Pj4+Pj4+Pj4g
b3RoZXJ3aXNlLCB0aGUgZGV2aWNlIGRvZXMgbm90Cj4+Pj4+Pj4+PiBzdXBwb3J0IG91ciBzdWJz
ZXQgb2YgZmVhdHVyZXMgYW5kIHRoZSBkZXZpY2UgaXMgdW51c2FibGUuCj4+Pj4+Pj4+PiA3LiBQ
ZXJmb3JtIGRldmljZS1zcGVjaWZpYyBzZXR1cCwgaW5jbHVkaW5nIGRpc2NvdmVyeSBvZiB2aXJ0
cXVldWVzCj4+Pj4+Pj4+PiBmb3IgdGhlIGRldmljZSwgb3B0aW9uYWwgcGVyLWJ1cyBzZXR1cCwK
Pj4+Pj4+Pj4+IHJlYWRpbmcgYW5kIHBvc3NpYmx5IHdyaXRpbmcgdGhlIGRldmljZeKAmXMgdmly
dGlvIGNvbmZpZ3VyYXRpb24KPj4+Pj4+Pj4+IHNwYWNlLCBhbmQgcG9wdWxhdGlvbiBvZiB2aXJ0
cXVldWVzLgo+Pj4+Pj4+Pj4gOC4gU2V0IHRoZSBEUklWRVJfT0sgc3RhdHVzIGJpdC4gQXQgdGhp
cyBwb2ludCB0aGUgZGV2aWNlIGlzIOKAnGxpdmXigJ0uCj4+Pj4+Pj4+Pgo+Pj4+Pj4+Pj4KPj4+
Pj4+Pj4+IHNvIGFjY2Vzc2luZyBjb25maWcgc3BhY2UgYmVmb3JlIEZFQVRVUkVTX09LIGlzIGEg
c3BlYwo+Pj4+Pj4+Pj4gdmlvbGF0aW9uLCByaWdodD8KPj4+Pj4+Pj4gSXQgaXMsIGJ1dCBpdCdz
IG5vdCByZWxldmFudCB0byB3aGF0IHRoaXMgY29tbWl0IHRyaWVzIHRvIGFkZHJlc3MuIEkKPj4+
Pj4+Pj4gdGhvdWdodCB0aGUgbGVnYWN5IGd1ZXN0IHN0aWxsIG5lZWRzIHRvIGJlIHN1cHBvcnRl
ZC4KPj4+Pj4+Pj4KPj4+Pj4+Pj4gSGF2aW5nIHNhaWQsIGEgc2VwYXJhdGUgcGF0Y2ggaGFzIHRv
IGJlIHBvc3RlZCB0byBmaXggdGhlIGd1ZXN0IGRyaXZlcgo+Pj4+Pj4+PiBpc3N1ZSB3aGVyZSB0
aGlzIGRpc2NyZXBhbmN5IGlzIGludHJvZHVjZWQgdG8KPj4+Pj4+Pj4gdmlydG5ldF92YWxpZGF0
ZSgpIChzaW5jZQo+Pj4+Pj4+PiBjb21taXQgZmUzNmNiZTA2NykuIEJ1dCBpdCdzIG5vdCB0ZWNo
bmljYWxseSByZWxhdGVkIHRvIHRoaXMgcGF0Y2guCj4+Pj4+Pj4+Cj4+Pj4+Pj4+IC1TaXdlaQo+
Pj4+Pj4+IEkgdGhpbmsgaXQncyBhIGJ1ZyB0byByZWFkIGNvbmZpZyBzcGFjZSBpbiB2YWxpZGF0
ZSwgd2Ugc2hvdWxkCj4+Pj4+Pj4gbW92ZSBpdCB0bwo+Pj4+Pj4+IHZpcnRuZXRfcHJvYmUoKS4K
Pj4+Pj4+Pgo+Pj4+Pj4+IFRoYW5rcwo+Pj4+Pj4gSSB0YWtlIGl0IGJhY2ssIHJlYWRpbmcgYnV0
IG5vdCB3cml0aW5nIHNlZW1zIHRvIGJlIGV4cGxpY2l0bHkKPj4+Pj4+IGFsbG93ZWQgYnkgc3Bl
Yy4KPj4+Pj4+IFNvIG91ciB3YXkgdG8gZGV0ZWN0IGEgbGVnYWN5IGd1ZXN0IGlzIGJvZ3VzLCBu
ZWVkIHRvIHRoaW5rIHdoYXQgaXMKPj4+Pj4+IHRoZSBiZXN0IHdheSB0byBoYW5kbGUgdGhpcy4K
Pj4+Pj4gVGhlbiBtYXliZSByZXZlcnQgY29tbWl0IGZlMzZjYmUwNjcgYW5kIGZyaWVuZHMsIGFu
ZCBoYXZlIFFFTVUgZGV0ZWN0Cj4+Pj4+IGxlZ2FjeSBndWVzdD8gU3VwcG9zZWRseSBvbmx5IGNv
bmZpZyBzcGFjZSB3cml0ZSBhY2Nlc3MgbmVlZHMgdG8gYmUKPj4+Pj4gZ3VhcmRlZCBiZWZvcmUg
c2V0dGluZyBGRUFUVVJFU19PSy4KPj4+Pgo+Pj4+IEkgYWdyZWUuIE15IHVuZGVyc3RhbmRpbmcg
aXMgdGhhdCBhbGwgdkRQQSBtdXN0IGJlIG1vZGVybiBkZXZpY2UgKHNpbmNlCj4+Pj4gVklSSVRP
X0ZfQUNDRVNTX1BMQVRGT1JNIGlzIG1hbmRhdGVkKSBpbnN0ZWFkIG9mIHRyYW5zaXRpb25hbCBk
ZXZpY2UuCj4+Pj4KPj4+PiBUaGFua3MKPj4+IFdlbGwgbWx4NSBoYXMgc29tZSBjb2RlIHRvIGhh
bmRsZSBsZWdhY3kgZ3Vlc3RzIC4uLgo+Pj4gRWxpLCBjb3VsZCB5b3UgY29tbWVudD8gSXMgdGhh
dCBzdXBwb3J0IHVudXNlZCByaWdodCBub3c/Cj4+Pgo+PiBJZiB5b3UgbWVhbiBzdXBwb3J0IGZv
ciB2ZXJzaW9uIDEuMCwgd2VsbCB0aGUga25vYiBpcyB0aGVyZSBidXQgaXQncyBub3QKPj4gc2V0
IGluIHRoZSBmaXJtd2FyZSBJIHVzZS4gTm90ZSBzdXJlIGlmIHdlIHdpbGwgc3VwcG9ydCB0aGlz
Lgo+IEhtbSB5b3UgbWVhbiBpdCdzIGxlZ2FjeSBvbmx5IHJpZ2h0IG5vdz8KPiBXZWxsIGF0IHNv
bWUgcG9pbnQgeW91IHdpbGwgd2FudCBhZHZhbmNlZCBnb29kaWVzIGxpa2UgUlNTCj4gYW5kIGFs
bCB0aGF0IGlzIGdhdGVkIG9uIDEuMCA7KQoKClNvIGlmIG15IHVuZGVyc3RhbmRpbmcgaXMgY29y
cmVjdCB0aGUgZGV2aWNlL2Zpcm13YXJlIGlzIGxlZ2FjeSBidXQgCnJlcXVpcmUgVklSVElPX0Zf
QUNDRVNTX1BMQVRGT1JNIHNlbWFuaWM/IExvb2tzIGxpa2UgYSBzcGVjIHZpb2xhdGlvbj8KClRo
YW5rcwoKCj4KPj4+Pj4gLVNpd2llCj4+Pj4+Cj4+Pj4+Pj4+Pj4+IFJlamVjdGluZyByZXNldCB0
byAwCj4+Pj4+Pj4+Pj4+IHByZW1hdHVyZWx5IGNhdXNlcyBjb3JyZWN0IE1UVSBhbmQgbGluayBz
dGF0dXMgdW5hYmxlIHRvIGxvYWQKPj4+Pj4+Pj4+Pj4gZm9yIHRoZSB2ZXJ5IGZpcnN0IGNvbmZp
ZyBzcGFjZSBhY2Nlc3MsIHJlbmRlcmluZyBpc3N1ZXMgbGlrZQo+Pj4+Pj4+Pj4+PiBndWVzdCBz
aG93aW5nIGluYWNjdXJhdGUgTVRVIHZhbHVlLCBvciBmYWlsdXJlIHRvIHJlamVjdAo+Pj4+Pj4+
Pj4+PiBvdXQtb2YtcmFuZ2UgTVRVLgo+Pj4+Pj4+Pj4+Pgo+Pj4+Pj4+Pj4+PiBGaXhlczogMWE4
NmIzNzdhYTIxICgidmRwYS9tbHg1OiBBZGQgVkRQQSBkcml2ZXIgZm9yCj4+Pj4+Pj4+Pj4+IHN1
cHBvcnRlZCBtbHg1IGRldmljZXMiKQo+Pj4+Pj4+Pj4+PiBTaWduZWQtb2ZmLWJ5OiBTaS1XZWkg
TGl1IDxzaS13ZWkubGl1QG9yYWNsZS5jb20+Cj4+Pj4+Pj4+Pj4+IC0tLQo+Pj4+Pj4+Pj4+PiAg
wqDCoMKgIGRyaXZlcnMvdmRwYS9tbHg1L25ldC9tbHg1X3ZuZXQuYyB8IDE1ICstLS0tLS0tLS0t
LS0tLQo+Pj4+Pj4+Pj4+PiAgwqDCoMKgIDEgZmlsZSBjaGFuZ2VkLCAxIGluc2VydGlvbigrKSwg
MTQgZGVsZXRpb25zKC0pCj4+Pj4+Pj4+Pj4+Cj4+Pj4+Pj4+Pj4+IGRpZmYgLS1naXQgYS9kcml2
ZXJzL3ZkcGEvbWx4NS9uZXQvbWx4NV92bmV0LmMKPj4+Pj4+Pj4+Pj4gYi9kcml2ZXJzL3ZkcGEv
bWx4NS9uZXQvbWx4NV92bmV0LmMKPj4+Pj4+Pj4+Pj4gaW5kZXggN2MxZjc4OS4uNTQwZGQ2NyAx
MDA2NDQKPj4+Pj4+Pj4+Pj4gLS0tIGEvZHJpdmVycy92ZHBhL21seDUvbmV0L21seDVfdm5ldC5j
Cj4+Pj4+Pj4+Pj4+ICsrKyBiL2RyaXZlcnMvdmRwYS9tbHg1L25ldC9tbHg1X3ZuZXQuYwo+Pj4+
Pj4+Pj4+PiBAQCAtMTQ5MCwxNCArMTQ5MCw2IEBAIHN0YXRpYyB1NjQKPj4+Pj4+Pj4+Pj4gbWx4
NV92ZHBhX2dldF9mZWF0dXJlcyhzdHJ1Y3QgdmRwYV9kZXZpY2UgKnZkZXYpCj4+Pj4+Pj4+Pj4+
ICDCoMKgwqDCoMKgwqDCoCByZXR1cm4gbXZkZXYtPm1seF9mZWF0dXJlczsKPj4+Pj4+Pj4+Pj4g
IMKgwqDCoCB9Cj4+Pj4+Pj4+Pj4+IC1zdGF0aWMgaW50IHZlcmlmeV9taW5fZmVhdHVyZXMoc3Ry
dWN0IG1seDVfdmRwYV9kZXYgKm12ZGV2LAo+Pj4+Pj4+Pj4+PiB1NjQgZmVhdHVyZXMpCj4+Pj4+
Pj4+Pj4+IC17Cj4+Pj4+Pj4+Pj4+IC3CoMKgwqAgaWYgKCEoZmVhdHVyZXMgJiBCSVRfVUxMKFZJ
UlRJT19GX0FDQ0VTU19QTEFURk9STSkpKQo+Pj4+Pj4+Pj4+PiAtwqDCoMKgwqDCoMKgwqAgcmV0
dXJuIC1FT1BOT1RTVVBQOwo+Pj4+Pj4+Pj4+PiAtCj4+Pj4+Pj4+Pj4+IC3CoMKgwqAgcmV0dXJu
IDA7Cj4+Pj4+Pj4+Pj4+IC19Cj4+Pj4+Pj4+Pj4+IC0KPj4+Pj4+Pj4+Pj4gIMKgwqDCoCBzdGF0
aWMgaW50IHNldHVwX3ZpcnRxdWV1ZXMoc3RydWN0IG1seDVfdmRwYV9uZXQgKm5kZXYpCj4+Pj4+
Pj4+Pj4+ICDCoMKgwqAgewo+Pj4+Pj4+Pj4+PiAgwqDCoMKgwqDCoMKgwqAgaW50IGVycjsKPj4+
Pj4+Pj4+Pj4gQEAgLTE1NTgsMTggKzE1NTAsMTMgQEAgc3RhdGljIGludAo+Pj4+Pj4+Pj4+PiBt
bHg1X3ZkcGFfc2V0X2ZlYXR1cmVzKHN0cnVjdCB2ZHBhX2RldmljZSAqdmRldiwgdTY0Cj4+Pj4+
Pj4+Pj4+IGZlYXR1cmVzKQo+Pj4+Pj4+Pj4+PiAgwqDCoMKgIHsKPj4+Pj4+Pj4+Pj4gIMKgwqDC
oMKgwqDCoMKgIHN0cnVjdCBtbHg1X3ZkcGFfZGV2ICptdmRldiA9IHRvX212ZGV2KHZkZXYpOwo+
Pj4+Pj4+Pj4+PiAgwqDCoMKgwqDCoMKgwqAgc3RydWN0IG1seDVfdmRwYV9uZXQgKm5kZXYgPSB0
b19tbHg1X3ZkcGFfbmRldihtdmRldik7Cj4+Pj4+Pj4+Pj4+IC3CoMKgwqAgaW50IGVycjsKPj4+
Pj4+Pj4+Pj4gIMKgwqDCoMKgwqDCoMKgIHByaW50X2ZlYXR1cmVzKG12ZGV2LCBmZWF0dXJlcywg
dHJ1ZSk7Cj4+Pj4+Pj4+Pj4+IC3CoMKgwqAgZXJyID0gdmVyaWZ5X21pbl9mZWF0dXJlcyhtdmRl
diwgZmVhdHVyZXMpOwo+Pj4+Pj4+Pj4+PiAtwqDCoMKgIGlmIChlcnIpCj4+Pj4+Pj4+Pj4+IC3C
oMKgwqDCoMKgwqDCoCByZXR1cm4gZXJyOwo+Pj4+Pj4+Pj4+PiAtCj4+Pj4+Pj4+Pj4+ICDCoMKg
wqDCoMKgwqDCoCBuZGV2LT5tdmRldi5hY3R1YWxfZmVhdHVyZXMgPSBmZWF0dXJlcyAmCj4+Pj4+
Pj4+Pj4+IG5kZXYtPm12ZGV2Lm1seF9mZWF0dXJlczsKPj4+Pj4+Pj4+Pj4gIMKgwqDCoMKgwqDC
oMKgIG5kZXYtPmNvbmZpZy5tdHUgPSBjcHVfdG9fbWx4NXZkcGExNihtdmRldiwgbmRldi0+bXR1
KTsKPj4+Pj4+Pj4+Pj4gIMKgwqDCoMKgwqDCoMKgIG5kZXYtPmNvbmZpZy5zdGF0dXMgfD0gY3B1
X3RvX21seDV2ZHBhMTYobXZkZXYsCj4+Pj4+Pj4+Pj4+IFZJUlRJT19ORVRfU19MSU5LX1VQKTsK
Pj4+Pj4+Pj4+Pj4gLcKgwqDCoCByZXR1cm4gZXJyOwo+Pj4+Pj4+Pj4+PiArwqDCoMKgIHJldHVy
biAwOwo+Pj4+Pj4+Pj4+PiAgwqDCoMKgIH0KPj4+Pj4+Pj4+Pj4gIMKgwqDCoCBzdGF0aWMgdm9p
ZCBtbHg1X3ZkcGFfc2V0X2NvbmZpZ19jYihzdHJ1Y3QgdmRwYV9kZXZpY2UKPj4+Pj4+Pj4+Pj4g
KnZkZXYsIHN0cnVjdCB2ZHBhX2NhbGxiYWNrICpjYikKCl9fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fClZpcnR1YWxpemF0aW9uIG1haWxpbmcgbGlzdApWaXJ0
dWFsaXphdGlvbkBsaXN0cy5saW51eC1mb3VuZGF0aW9uLm9yZwpodHRwczovL2xpc3RzLmxpbnV4
Zm91bmRhdGlvbi5vcmcvbWFpbG1hbi9saXN0aW5mby92aXJ0dWFsaXphdGlvbg==
