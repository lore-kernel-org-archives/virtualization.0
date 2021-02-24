Return-Path: <SRS0=cI1G=H2=lists.linux-foundation.org=virtualization-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.1 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 86D37C433E0
	for <virtualization@archiver.kernel.org>; Wed, 24 Feb 2021 03:20:22 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C66F964E22
	for <virtualization@archiver.kernel.org>; Wed, 24 Feb 2021 03:20:21 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C66F964E22
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=virtualization-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 7304D83B95;
	Wed, 24 Feb 2021 03:20:21 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
	by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id PmP_y1qsJLZD; Wed, 24 Feb 2021 03:20:20 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp1.osuosl.org (Postfix) with ESMTP id E381983B3E;
	Wed, 24 Feb 2021 03:20:19 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id B797BC000A;
	Wed, 24 Feb 2021 03:20:19 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 3AD82C0001
 for <virtualization@lists.linux-foundation.org>;
 Wed, 24 Feb 2021 03:20:18 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id 2E2AC60661
 for <virtualization@lists.linux-foundation.org>;
 Wed, 24 Feb 2021 03:20:18 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp3.osuosl.org (amavisd-new);
 dkim=pass (1024-bit key) header.d=redhat.com
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id uHNkML4ZSjou
 for <virtualization@lists.linux-foundation.org>;
 Wed, 24 Feb 2021 03:20:17 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [63.128.21.124])
 by smtp3.osuosl.org (Postfix) with ESMTPS id C88EF6065C
 for <virtualization@lists.linux-foundation.org>;
 Wed, 24 Feb 2021 03:20:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1614136815;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=4V74H9AMOS6Y0avL8O8KTb4Lqx+oJbogr4tIH2vbj/8=;
 b=Ji0wVX9b9PsuFsR7jrpceg0vgtgUx6xulyy0TUWokgwWA5VelAOt8wUv95Dd/xxJ5o4OhD
 3ekXaB9xVmS4nYJqOMim7xq/70Ymhs7Iw1JDS10V7aTeeqpJ+0sSI2Pf6mWk0nqTKl50AB
 0LhlTrDoYoSwOyryvSGuLbml18CBIT4=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-206-5A7vzBEWNR6I5ZX__DNsYg-1; Tue, 23 Feb 2021 22:20:11 -0500
X-MC-Unique: 5A7vzBEWNR6I5ZX__DNsYg-1
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com
 [10.5.11.15])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 2919B1966321;
 Wed, 24 Feb 2021 03:20:10 +0000 (UTC)
Received: from wangxiaodeMacBook-Air.local (ovpn-13-193.pek2.redhat.com
 [10.72.13.193])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 460AD62499;
 Wed, 24 Feb 2021 03:20:02 +0000 (UTC)
Subject: Re: [PATCH] vdpa/mlx5: set_features should allow reset to zero
To: Si-Wei Liu <si-wei.liu@oracle.com>, "Michael S. Tsirkin" <mst@redhat.com>
References: <1613735698-3328-1-git-send-email-si-wei.liu@oracle.com>
 <605e7d2d-4f27-9688-17a8-d57191752ee7@redhat.com>
 <20210222023040-mutt-send-email-mst@kernel.org>
 <22fe5923-635b-59f0-7643-2fd5876937c2@oracle.com>
 <fae0bae7-e4cd-a3aa-57fe-d707df99b634@redhat.com>
 <20210223082536-mutt-send-email-mst@kernel.org>
 <3ff5fd23-1db0-2f95-4cf9-711ef403fb62@oracle.com>
From: Jason Wang <jasowang@redhat.com>
Message-ID: <7e6291a4-30b1-6b59-a2bf-713e7b56826d@redhat.com>
Date: Wed, 24 Feb 2021 11:20:01 +0800
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.16; rv:78.0)
 Gecko/20100101 Thunderbird/78.7.1
MIME-Version: 1.0
In-Reply-To: <3ff5fd23-1db0-2f95-4cf9-711ef403fb62@oracle.com>
Content-Language: en-GB
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
Cc: netdev@vger.kernel.org, elic@nvidia.com, linux-kernel@vger.kernel.org,
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

Ck9uIDIwMjEvMi8yNCAzOjM1IOS4iuWNiCwgU2ktV2VpIExpdSB3cm90ZToKPgo+Cj4gT24gMi8y
My8yMDIxIDU6MjYgQU0sIE1pY2hhZWwgUy4gVHNpcmtpbiB3cm90ZToKPj4gT24gVHVlLCBGZWIg
MjMsIDIwMjEgYXQgMTA6MDM6NTdBTSArMDgwMCwgSmFzb24gV2FuZyB3cm90ZToKPj4+IE9uIDIw
MjEvMi8yMyA5OjEyIOS4iuWNiCwgU2ktV2VpIExpdSB3cm90ZToKPj4+Pgo+Pj4+IE9uIDIvMjEv
MjAyMSAxMTozNCBQTSwgTWljaGFlbCBTLiBUc2lya2luIHdyb3RlOgo+Pj4+PiBPbiBNb24sIEZl
YiAyMiwgMjAyMSBhdCAxMjoxNDoxN1BNICswODAwLCBKYXNvbiBXYW5nIHdyb3RlOgo+Pj4+Pj4g
T24gMjAyMS8yLzE5IDc6NTQg5LiL5Y2ILCBTaS1XZWkgTGl1IHdyb3RlOgo+Pj4+Pj4+IENvbW1p
dCA0NTI2MzlhNjRhZDggKCJ2ZHBhOiBtYWtlIHN1cmUgc2V0X2ZlYXR1cmVzIGlzIGludm9rZWQK
Pj4+Pj4+PiBmb3IgbGVnYWN5IikgbWFkZSBhbiBleGNlcHRpb24gZm9yIGxlZ2FjeSBndWVzdHMg
dG8gcmVzZXQKPj4+Pj4+PiBmZWF0dXJlcyB0byAwLCB3aGVuIGNvbmZpZyBzcGFjZSBpcyBhY2Nl
c3NlZCBiZWZvcmUgZmVhdHVyZXMKPj4+Pj4+PiBhcmUgc2V0LiBXZSBzaG91bGQgcmVsaWV2ZSB0
aGUgdmVyaWZ5X21pbl9mZWF0dXJlcygpIGNoZWNrCj4+Pj4+Pj4gYW5kIGFsbG93IGZlYXR1cmVz
IHJlc2V0IHRvIDAgZm9yIHRoaXMgY2FzZS4KPj4+Pj4+Pgo+Pj4+Pj4+IEl0J3Mgd29ydGggbm90
aW5nIHRoYXQgbm90IGp1c3QgbGVnYWN5IGd1ZXN0cyBjb3VsZCBhY2Nlc3MKPj4+Pj4+PiBjb25m
aWcgc3BhY2UgYmVmb3JlIGZlYXR1cmVzIGFyZSBzZXQuIEZvciBpbnN0YW5jZSwgd2hlbgo+Pj4+
Pj4+IGZlYXR1cmUgVklSVElPX05FVF9GX01UVSBpcyBhZHZlcnRpc2VkIHNvbWUgbW9kZXJuIGRy
aXZlcgo+Pj4+Pj4+IHdpbGwgdHJ5IHRvIGFjY2VzcyBhbmQgdmFsaWRhdGUgdGhlIE1UVSBwcmVz
ZW50IGluIHRoZSBjb25maWcKPj4+Pj4+PiBzcGFjZSBiZWZvcmUgdmlydGlvIGZlYXR1cmVzIGFy
ZSBzZXQuCj4+Pj4+PiBUaGlzIGxvb2tzIGxpa2UgYSBzcGVjIHZpb2xhdGlvbjoKPj4+Pj4+Cj4+
Pj4+PiAiCj4+Pj4+Pgo+Pj4+Pj4gVGhlIGZvbGxvd2luZyBkcml2ZXItcmVhZC1vbmx5IGZpZWxk
LCBtdHUgb25seSBleGlzdHMgaWYKPj4+Pj4+IFZJUlRJT19ORVRfRl9NVFUgaXMKPj4+Pj4+IHNl
dC4KPj4+Pj4+IFRoaXMgZmllbGQgc3BlY2lmaWVzIHRoZSBtYXhpbXVtIE1UVSBmb3IgdGhlIGRy
aXZlciB0byB1c2UuCj4+Pj4+PiAiCj4+Pj4+Pgo+Pj4+Pj4gRG8gd2UgcmVhbGx5IHdhbnQgdG8g
d29ya2Fyb3VuZCB0aGlzPwo+Pj4+Pj4KPj4+Pj4+IFRoYW5rcwo+Pj4+PiBBbmQgYWxzbzoKPj4+
Pj4KPj4+Pj4gVGhlIGRyaXZlciBNVVNUIGZvbGxvdyB0aGlzIHNlcXVlbmNlIHRvIGluaXRpYWxp
emUgYSBkZXZpY2U6Cj4+Pj4+IDEuIFJlc2V0IHRoZSBkZXZpY2UuCj4+Pj4+IDIuIFNldCB0aGUg
QUNLTk9XTEVER0Ugc3RhdHVzIGJpdDogdGhlIGd1ZXN0IE9TIGhhcyBub3RpY2VkIHRoZSAKPj4+
Pj4gZGV2aWNlLgo+Pj4+PiAzLiBTZXQgdGhlIERSSVZFUiBzdGF0dXMgYml0OiB0aGUgZ3Vlc3Qg
T1Mga25vd3MgaG93IHRvIGRyaXZlIHRoZQo+Pj4+PiBkZXZpY2UuCj4+Pj4+IDQuIFJlYWQgZGV2
aWNlIGZlYXR1cmUgYml0cywgYW5kIHdyaXRlIHRoZSBzdWJzZXQgb2YgZmVhdHVyZSBiaXRzCj4+
Pj4+IHVuZGVyc3Rvb2QgYnkgdGhlIE9TIGFuZCBkcml2ZXIgdG8gdGhlCj4+Pj4+IGRldmljZS4g
RHVyaW5nIHRoaXMgc3RlcCB0aGUgZHJpdmVyIE1BWSByZWFkIChidXQgTVVTVCBOT1Qgd3JpdGUp
Cj4+Pj4+IHRoZSBkZXZpY2Utc3BlY2lmaWMgY29uZmlndXJhdGlvbgo+Pj4+PiBmaWVsZHMgdG8g
Y2hlY2sgdGhhdCBpdCBjYW4gc3VwcG9ydCB0aGUgZGV2aWNlIGJlZm9yZSBhY2NlcHRpbmcgaXQu
Cj4+Pj4+IDUuIFNldCB0aGUgRkVBVFVSRVNfT0sgc3RhdHVzIGJpdC4gVGhlIGRyaXZlciBNVVNU
IE5PVCBhY2NlcHQgbmV3Cj4+Pj4+IGZlYXR1cmUgYml0cyBhZnRlciB0aGlzIHN0ZXAuCj4+Pj4+
IDYuIFJlLXJlYWQgZGV2aWNlIHN0YXR1cyB0byBlbnN1cmUgdGhlIEZFQVRVUkVTX09LIGJpdCBp
cyBzdGlsbCBzZXQ6Cj4+Pj4+IG90aGVyd2lzZSwgdGhlIGRldmljZSBkb2VzIG5vdAo+Pj4+PiBz
dXBwb3J0IG91ciBzdWJzZXQgb2YgZmVhdHVyZXMgYW5kIHRoZSBkZXZpY2UgaXMgdW51c2FibGUu
Cj4+Pj4+IDcuIFBlcmZvcm0gZGV2aWNlLXNwZWNpZmljIHNldHVwLCBpbmNsdWRpbmcgZGlzY292
ZXJ5IG9mIHZpcnRxdWV1ZXMKPj4+Pj4gZm9yIHRoZSBkZXZpY2UsIG9wdGlvbmFsIHBlci1idXMg
c2V0dXAsCj4+Pj4+IHJlYWRpbmcgYW5kIHBvc3NpYmx5IHdyaXRpbmcgdGhlIGRldmljZeKAmXMg
dmlydGlvIGNvbmZpZ3VyYXRpb24KPj4+Pj4gc3BhY2UsIGFuZCBwb3B1bGF0aW9uIG9mIHZpcnRx
dWV1ZXMuCj4+Pj4+IDguIFNldCB0aGUgRFJJVkVSX09LIHN0YXR1cyBiaXQuIEF0IHRoaXMgcG9p
bnQgdGhlIGRldmljZSBpcyDigJxsaXZl4oCdLgo+Pj4+Pgo+Pj4+Pgo+Pj4+PiBzbyBhY2Nlc3Np
bmcgY29uZmlnIHNwYWNlIGJlZm9yZSBGRUFUVVJFU19PSyBpcyBhIHNwZWMgdmlvbGF0aW9uLCAK
Pj4+Pj4gcmlnaHQ/Cj4+Pj4gSXQgaXMsIGJ1dCBpdCdzIG5vdCByZWxldmFudCB0byB3aGF0IHRo
aXMgY29tbWl0IHRyaWVzIHRvIGFkZHJlc3MuIEkKPj4+PiB0aG91Z2h0IHRoZSBsZWdhY3kgZ3Vl
c3Qgc3RpbGwgbmVlZHMgdG8gYmUgc3VwcG9ydGVkLgo+Pj4+Cj4+Pj4gSGF2aW5nIHNhaWQsIGEg
c2VwYXJhdGUgcGF0Y2ggaGFzIHRvIGJlIHBvc3RlZCB0byBmaXggdGhlIGd1ZXN0IGRyaXZlcgo+
Pj4+IGlzc3VlIHdoZXJlIHRoaXMgZGlzY3JlcGFuY3kgaXMgaW50cm9kdWNlZCB0byB2aXJ0bmV0
X3ZhbGlkYXRlKCkgCj4+Pj4gKHNpbmNlCj4+Pj4gY29tbWl0IGZlMzZjYmUwNjcpLiBCdXQgaXQn
cyBub3QgdGVjaG5pY2FsbHkgcmVsYXRlZCB0byB0aGlzIHBhdGNoLgo+Pj4+Cj4+Pj4gLVNpd2Vp
Cj4+Pgo+Pj4gSSB0aGluayBpdCdzIGEgYnVnIHRvIHJlYWQgY29uZmlnIHNwYWNlIGluIHZhbGlk
YXRlLCB3ZSBzaG91bGQgbW92ZSAKPj4+IGl0IHRvCj4+PiB2aXJ0bmV0X3Byb2JlKCkuCj4+Pgo+
Pj4gVGhhbmtzCj4+IEkgdGFrZSBpdCBiYWNrLCByZWFkaW5nIGJ1dCBub3Qgd3JpdGluZyBzZWVt
cyB0byBiZSBleHBsaWNpdGx5IAo+PiBhbGxvd2VkIGJ5IHNwZWMuCj4+IFNvIG91ciB3YXkgdG8g
ZGV0ZWN0IGEgbGVnYWN5IGd1ZXN0IGlzIGJvZ3VzLCBuZWVkIHRvIHRoaW5rIHdoYXQgaXMKPj4g
dGhlIGJlc3Qgd2F5IHRvIGhhbmRsZSB0aGlzLgo+IFRoZW4gbWF5YmUgcmV2ZXJ0IGNvbW1pdCBm
ZTM2Y2JlMDY3IGFuZCBmcmllbmRzLCBhbmQgaGF2ZSBRRU1VIGRldGVjdCAKPiBsZWdhY3kgZ3Vl
c3Q/IFN1cHBvc2VkbHkgb25seSBjb25maWcgc3BhY2Ugd3JpdGUgYWNjZXNzIG5lZWRzIHRvIGJl
IAo+IGd1YXJkZWQgYmVmb3JlIHNldHRpbmcgRkVBVFVSRVNfT0suCgoKSSBhZ3JlZS4gTXkgdW5k
ZXJzdGFuZGluZyBpcyB0aGF0IGFsbCB2RFBBIG11c3QgYmUgbW9kZXJuIGRldmljZSAoc2luY2Ug
ClZJUklUT19GX0FDQ0VTU19QTEFURk9STSBpcyBtYW5kYXRlZCkgaW5zdGVhZCBvZiB0cmFuc2l0
aW9uYWwgZGV2aWNlLgoKVGhhbmtzCgoKPgo+IC1TaXdpZQo+Cj4+Pj4+Cj4+Pj4+Pj4gUmVqZWN0
aW5nIHJlc2V0IHRvIDAKPj4+Pj4+PiBwcmVtYXR1cmVseSBjYXVzZXMgY29ycmVjdCBNVFUgYW5k
IGxpbmsgc3RhdHVzIHVuYWJsZSB0byBsb2FkCj4+Pj4+Pj4gZm9yIHRoZSB2ZXJ5IGZpcnN0IGNv
bmZpZyBzcGFjZSBhY2Nlc3MsIHJlbmRlcmluZyBpc3N1ZXMgbGlrZQo+Pj4+Pj4+IGd1ZXN0IHNo
b3dpbmcgaW5hY2N1cmF0ZSBNVFUgdmFsdWUsIG9yIGZhaWx1cmUgdG8gcmVqZWN0Cj4+Pj4+Pj4g
b3V0LW9mLXJhbmdlIE1UVS4KPj4+Pj4+Pgo+Pj4+Pj4+IEZpeGVzOiAxYTg2YjM3N2FhMjEgKCJ2
ZHBhL21seDU6IEFkZCBWRFBBIGRyaXZlciBmb3IKPj4+Pj4+PiBzdXBwb3J0ZWQgbWx4NSBkZXZp
Y2VzIikKPj4+Pj4+PiBTaWduZWQtb2ZmLWJ5OiBTaS1XZWkgTGl1IDxzaS13ZWkubGl1QG9yYWNs
ZS5jb20+Cj4+Pj4+Pj4gLS0tCj4+Pj4+Pj4gwqDCoMKgIGRyaXZlcnMvdmRwYS9tbHg1L25ldC9t
bHg1X3ZuZXQuYyB8IDE1ICstLS0tLS0tLS0tLS0tLQo+Pj4+Pj4+IMKgwqDCoCAxIGZpbGUgY2hh
bmdlZCwgMSBpbnNlcnRpb24oKyksIDE0IGRlbGV0aW9ucygtKQo+Pj4+Pj4+Cj4+Pj4+Pj4gZGlm
ZiAtLWdpdCBhL2RyaXZlcnMvdmRwYS9tbHg1L25ldC9tbHg1X3ZuZXQuYwo+Pj4+Pj4+IGIvZHJp
dmVycy92ZHBhL21seDUvbmV0L21seDVfdm5ldC5jCj4+Pj4+Pj4gaW5kZXggN2MxZjc4OS4uNTQw
ZGQ2NyAxMDA2NDQKPj4+Pj4+PiAtLS0gYS9kcml2ZXJzL3ZkcGEvbWx4NS9uZXQvbWx4NV92bmV0
LmMKPj4+Pj4+PiArKysgYi9kcml2ZXJzL3ZkcGEvbWx4NS9uZXQvbWx4NV92bmV0LmMKPj4+Pj4+
PiBAQCAtMTQ5MCwxNCArMTQ5MCw2IEBAIHN0YXRpYyB1NjQKPj4+Pj4+PiBtbHg1X3ZkcGFfZ2V0
X2ZlYXR1cmVzKHN0cnVjdCB2ZHBhX2RldmljZSAqdmRldikKPj4+Pj4+PiDCoMKgwqDCoMKgwqDC
oCByZXR1cm4gbXZkZXYtPm1seF9mZWF0dXJlczsKPj4+Pj4+PiDCoMKgwqAgfQo+Pj4+Pj4+IC1z
dGF0aWMgaW50IHZlcmlmeV9taW5fZmVhdHVyZXMoc3RydWN0IG1seDVfdmRwYV9kZXYgKm12ZGV2
LAo+Pj4+Pj4+IHU2NCBmZWF0dXJlcykKPj4+Pj4+PiAtewo+Pj4+Pj4+IC3CoMKgwqAgaWYgKCEo
ZmVhdHVyZXMgJiBCSVRfVUxMKFZJUlRJT19GX0FDQ0VTU19QTEFURk9STSkpKQo+Pj4+Pj4+IC3C
oMKgwqDCoMKgwqDCoCByZXR1cm4gLUVPUE5PVFNVUFA7Cj4+Pj4+Pj4gLQo+Pj4+Pj4+IC3CoMKg
wqAgcmV0dXJuIDA7Cj4+Pj4+Pj4gLX0KPj4+Pj4+PiAtCj4+Pj4+Pj4gwqDCoMKgIHN0YXRpYyBp
bnQgc2V0dXBfdmlydHF1ZXVlcyhzdHJ1Y3QgbWx4NV92ZHBhX25ldCAqbmRldikKPj4+Pj4+PiDC
oMKgwqAgewo+Pj4+Pj4+IMKgwqDCoMKgwqDCoMKgIGludCBlcnI7Cj4+Pj4+Pj4gQEAgLTE1NTgs
MTggKzE1NTAsMTMgQEAgc3RhdGljIGludAo+Pj4+Pj4+IG1seDVfdmRwYV9zZXRfZmVhdHVyZXMo
c3RydWN0IHZkcGFfZGV2aWNlICp2ZGV2LCB1NjQKPj4+Pj4+PiBmZWF0dXJlcykKPj4+Pj4+PiDC
oMKgwqAgewo+Pj4+Pj4+IMKgwqDCoMKgwqDCoMKgIHN0cnVjdCBtbHg1X3ZkcGFfZGV2ICptdmRl
diA9IHRvX212ZGV2KHZkZXYpOwo+Pj4+Pj4+IMKgwqDCoMKgwqDCoMKgIHN0cnVjdCBtbHg1X3Zk
cGFfbmV0ICpuZGV2ID0gdG9fbWx4NV92ZHBhX25kZXYobXZkZXYpOwo+Pj4+Pj4+IC3CoMKgwqAg
aW50IGVycjsKPj4+Pj4+PiDCoMKgwqDCoMKgwqDCoCBwcmludF9mZWF0dXJlcyhtdmRldiwgZmVh
dHVyZXMsIHRydWUpOwo+Pj4+Pj4+IC3CoMKgwqAgZXJyID0gdmVyaWZ5X21pbl9mZWF0dXJlcyht
dmRldiwgZmVhdHVyZXMpOwo+Pj4+Pj4+IC3CoMKgwqAgaWYgKGVycikKPj4+Pj4+PiAtwqDCoMKg
wqDCoMKgwqAgcmV0dXJuIGVycjsKPj4+Pj4+PiAtCj4+Pj4+Pj4gwqDCoMKgwqDCoMKgwqAgbmRl
di0+bXZkZXYuYWN0dWFsX2ZlYXR1cmVzID0gZmVhdHVyZXMgJgo+Pj4+Pj4+IG5kZXYtPm12ZGV2
Lm1seF9mZWF0dXJlczsKPj4+Pj4+PiDCoMKgwqDCoMKgwqDCoCBuZGV2LT5jb25maWcubXR1ID0g
Y3B1X3RvX21seDV2ZHBhMTYobXZkZXYsIG5kZXYtPm10dSk7Cj4+Pj4+Pj4gwqDCoMKgwqDCoMKg
wqAgbmRldi0+Y29uZmlnLnN0YXR1cyB8PSBjcHVfdG9fbWx4NXZkcGExNihtdmRldiwKPj4+Pj4+
PiBWSVJUSU9fTkVUX1NfTElOS19VUCk7Cj4+Pj4+Pj4gLcKgwqDCoCByZXR1cm4gZXJyOwo+Pj4+
Pj4+ICvCoMKgwqAgcmV0dXJuIDA7Cj4+Pj4+Pj4gwqDCoMKgIH0KPj4+Pj4+PiDCoMKgwqAgc3Rh
dGljIHZvaWQgbWx4NV92ZHBhX3NldF9jb25maWdfY2Ioc3RydWN0IHZkcGFfZGV2aWNlCj4+Pj4+
Pj4gKnZkZXYsIHN0cnVjdCB2ZHBhX2NhbGxiYWNrICpjYikKPgoKX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX18KVmlydHVhbGl6YXRpb24gbWFpbGluZyBsaXN0
ClZpcnR1YWxpemF0aW9uQGxpc3RzLmxpbnV4LWZvdW5kYXRpb24ub3JnCmh0dHBzOi8vbGlzdHMu
bGludXhmb3VuZGF0aW9uLm9yZy9tYWlsbWFuL2xpc3RpbmZvL3ZpcnR1YWxpemF0aW9u
