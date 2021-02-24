Return-Path: <SRS0=cI1G=H2=lists.linux-foundation.org=virtualization-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.1 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 141C1C433DB
	for <virtualization@archiver.kernel.org>; Wed, 24 Feb 2021 06:04:57 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 91B7364EBB
	for <virtualization@archiver.kernel.org>; Wed, 24 Feb 2021 06:04:56 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 91B7364EBB
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=virtualization-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by smtp2.osuosl.org (Postfix) with ESMTP id 49F4F4307E;
	Wed, 24 Feb 2021 06:04:56 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
	by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id lqzMabQju7WC; Wed, 24 Feb 2021 06:04:55 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp2.osuosl.org (Postfix) with ESMTP id C67F04307C;
	Wed, 24 Feb 2021 06:04:54 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 8B2F2C000A;
	Wed, 24 Feb 2021 06:04:54 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id E90EAC0001
 for <virtualization@lists.linux-foundation.org>;
 Wed, 24 Feb 2021 06:04:52 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id D579C83C63
 for <virtualization@lists.linux-foundation.org>;
 Wed, 24 Feb 2021 06:04:52 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp1.osuosl.org (amavisd-new);
 dkim=pass (1024-bit key) header.d=redhat.com
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id hBG1aWcQLNOd
 for <virtualization@lists.linux-foundation.org>;
 Wed, 24 Feb 2021 06:04:52 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.133.124])
 by smtp1.osuosl.org (Postfix) with ESMTPS id D2E7C83AAC
 for <virtualization@lists.linux-foundation.org>;
 Wed, 24 Feb 2021 06:04:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1614146690;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=eNYC7vN6C0EshP6R28AJQdQwT0Q3lWhFKQkx/3ebEME=;
 b=aGd6trWWT9SHT0YaLHQZWR/ir36FzuxH1v891FwTirXt2Nv2fnjN7nQ6dfIh4xROJFyZMI
 nOj9RrWl5ODdADfeRRUkj4vYEY3jSKuTj9xpf6jaeGLt5mPDuaLVVBxR5hNlJCZoi2JBZA
 x+LiDXCISU/IZdtKL0JCWvfI+nTOdAA=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-62-vgQ0V9W0P026MMgrofv6Cw-1; Wed, 24 Feb 2021 01:04:46 -0500
X-MC-Unique: vgQ0V9W0P026MMgrofv6Cw-1
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com
 [10.5.11.11])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 4D1DE91270;
 Wed, 24 Feb 2021 06:04:45 +0000 (UTC)
Received: from wangxiaodeMacBook-Air.local (ovpn-13-96.pek2.redhat.com
 [10.72.13.96])
 by smtp.corp.redhat.com (Postfix) with ESMTP id D07046064B;
 Wed, 24 Feb 2021 06:04:37 +0000 (UTC)
Subject: Re: [PATCH] vdpa/mlx5: set_features should allow reset to zero
To: "Michael S. Tsirkin" <mst@redhat.com>, Si-Wei Liu <si-wei.liu@oracle.com>
References: <1613735698-3328-1-git-send-email-si-wei.liu@oracle.com>
 <605e7d2d-4f27-9688-17a8-d57191752ee7@redhat.com>
 <20210222023040-mutt-send-email-mst@kernel.org>
 <22fe5923-635b-59f0-7643-2fd5876937c2@oracle.com>
 <fae0bae7-e4cd-a3aa-57fe-d707df99b634@redhat.com>
 <20210223082536-mutt-send-email-mst@kernel.org>
 <3ff5fd23-1db0-2f95-4cf9-711ef403fb62@oracle.com>
 <20210224000057-mutt-send-email-mst@kernel.org>
From: Jason Wang <jasowang@redhat.com>
Message-ID: <0559fd8c-ff44-cb7a-8a74-71976dd2ee33@redhat.com>
Date: Wed, 24 Feb 2021 14:04:36 +0800
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.16; rv:78.0)
 Gecko/20100101 Thunderbird/78.7.1
MIME-Version: 1.0
In-Reply-To: <20210224000057-mutt-send-email-mst@kernel.org>
Content-Language: en-GB
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
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

Ck9uIDIwMjEvMi8yNCAxOjA0IOS4i+WNiCwgTWljaGFlbCBTLiBUc2lya2luIHdyb3RlOgo+IE9u
IFR1ZSwgRmViIDIzLCAyMDIxIGF0IDExOjM1OjU3QU0gLTA4MDAsIFNpLVdlaSBMaXUgd3JvdGU6
Cj4+Cj4+IE9uIDIvMjMvMjAyMSA1OjI2IEFNLCBNaWNoYWVsIFMuIFRzaXJraW4gd3JvdGU6Cj4+
PiBPbiBUdWUsIEZlYiAyMywgMjAyMSBhdCAxMDowMzo1N0FNICswODAwLCBKYXNvbiBXYW5nIHdy
b3RlOgo+Pj4+IE9uIDIwMjEvMi8yMyA5OjEyIOS4iuWNiCwgU2ktV2VpIExpdSB3cm90ZToKPj4+
Pj4gT24gMi8yMS8yMDIxIDExOjM0IFBNLCBNaWNoYWVsIFMuIFRzaXJraW4gd3JvdGU6Cj4+Pj4+
PiBPbiBNb24sIEZlYiAyMiwgMjAyMSBhdCAxMjoxNDoxN1BNICswODAwLCBKYXNvbiBXYW5nIHdy
b3RlOgo+Pj4+Pj4+IE9uIDIwMjEvMi8xOSA3OjU0IOS4i+WNiCwgU2ktV2VpIExpdSB3cm90ZToK
Pj4+Pj4+Pj4gQ29tbWl0IDQ1MjYzOWE2NGFkOCAoInZkcGE6IG1ha2Ugc3VyZSBzZXRfZmVhdHVy
ZXMgaXMgaW52b2tlZAo+Pj4+Pj4+PiBmb3IgbGVnYWN5IikgbWFkZSBhbiBleGNlcHRpb24gZm9y
IGxlZ2FjeSBndWVzdHMgdG8gcmVzZXQKPj4+Pj4+Pj4gZmVhdHVyZXMgdG8gMCwgd2hlbiBjb25m
aWcgc3BhY2UgaXMgYWNjZXNzZWQgYmVmb3JlIGZlYXR1cmVzCj4+Pj4+Pj4+IGFyZSBzZXQuIFdl
IHNob3VsZCByZWxpZXZlIHRoZSB2ZXJpZnlfbWluX2ZlYXR1cmVzKCkgY2hlY2sKPj4+Pj4+Pj4g
YW5kIGFsbG93IGZlYXR1cmVzIHJlc2V0IHRvIDAgZm9yIHRoaXMgY2FzZS4KPj4+Pj4+Pj4KPj4+
Pj4+Pj4gSXQncyB3b3J0aCBub3RpbmcgdGhhdCBub3QganVzdCBsZWdhY3kgZ3Vlc3RzIGNvdWxk
IGFjY2Vzcwo+Pj4+Pj4+PiBjb25maWcgc3BhY2UgYmVmb3JlIGZlYXR1cmVzIGFyZSBzZXQuIEZv
ciBpbnN0YW5jZSwgd2hlbgo+Pj4+Pj4+PiBmZWF0dXJlIFZJUlRJT19ORVRfRl9NVFUgaXMgYWR2
ZXJ0aXNlZCBzb21lIG1vZGVybiBkcml2ZXIKPj4+Pj4+Pj4gd2lsbCB0cnkgdG8gYWNjZXNzIGFu
ZCB2YWxpZGF0ZSB0aGUgTVRVIHByZXNlbnQgaW4gdGhlIGNvbmZpZwo+Pj4+Pj4+PiBzcGFjZSBi
ZWZvcmUgdmlydGlvIGZlYXR1cmVzIGFyZSBzZXQuCj4+Pj4+Pj4gVGhpcyBsb29rcyBsaWtlIGEg
c3BlYyB2aW9sYXRpb246Cj4+Pj4+Pj4KPj4+Pj4+PiAiCj4+Pj4+Pj4KPj4+Pj4+PiBUaGUgZm9s
bG93aW5nIGRyaXZlci1yZWFkLW9ubHkgZmllbGQsIG10dSBvbmx5IGV4aXN0cyBpZgo+Pj4+Pj4+
IFZJUlRJT19ORVRfRl9NVFUgaXMKPj4+Pj4+PiBzZXQuCj4+Pj4+Pj4gVGhpcyBmaWVsZCBzcGVj
aWZpZXMgdGhlIG1heGltdW0gTVRVIGZvciB0aGUgZHJpdmVyIHRvIHVzZS4KPj4+Pj4+PiAiCj4+
Pj4+Pj4KPj4+Pj4+PiBEbyB3ZSByZWFsbHkgd2FudCB0byB3b3JrYXJvdW5kIHRoaXM/Cj4+Pj4+
Pj4KPj4+Pj4+PiBUaGFua3MKPj4+Pj4+IEFuZCBhbHNvOgo+Pj4+Pj4KPj4+Pj4+IFRoZSBkcml2
ZXIgTVVTVCBmb2xsb3cgdGhpcyBzZXF1ZW5jZSB0byBpbml0aWFsaXplIGEgZGV2aWNlOgo+Pj4+
Pj4gMS4gUmVzZXQgdGhlIGRldmljZS4KPj4+Pj4+IDIuIFNldCB0aGUgQUNLTk9XTEVER0Ugc3Rh
dHVzIGJpdDogdGhlIGd1ZXN0IE9TIGhhcyBub3RpY2VkIHRoZSBkZXZpY2UuCj4+Pj4+PiAzLiBT
ZXQgdGhlIERSSVZFUiBzdGF0dXMgYml0OiB0aGUgZ3Vlc3QgT1Mga25vd3MgaG93IHRvIGRyaXZl
IHRoZQo+Pj4+Pj4gZGV2aWNlLgo+Pj4+Pj4gNC4gUmVhZCBkZXZpY2UgZmVhdHVyZSBiaXRzLCBh
bmQgd3JpdGUgdGhlIHN1YnNldCBvZiBmZWF0dXJlIGJpdHMKPj4+Pj4+IHVuZGVyc3Rvb2QgYnkg
dGhlIE9TIGFuZCBkcml2ZXIgdG8gdGhlCj4+Pj4+PiBkZXZpY2UuIER1cmluZyB0aGlzIHN0ZXAg
dGhlIGRyaXZlciBNQVkgcmVhZCAoYnV0IE1VU1QgTk9UIHdyaXRlKQo+Pj4+Pj4gdGhlIGRldmlj
ZS1zcGVjaWZpYyBjb25maWd1cmF0aW9uCj4+Pj4+PiBmaWVsZHMgdG8gY2hlY2sgdGhhdCBpdCBj
YW4gc3VwcG9ydCB0aGUgZGV2aWNlIGJlZm9yZSBhY2NlcHRpbmcgaXQuCj4+Pj4+PiA1LiBTZXQg
dGhlIEZFQVRVUkVTX09LIHN0YXR1cyBiaXQuIFRoZSBkcml2ZXIgTVVTVCBOT1QgYWNjZXB0IG5l
dwo+Pj4+Pj4gZmVhdHVyZSBiaXRzIGFmdGVyIHRoaXMgc3RlcC4KPj4+Pj4+IDYuIFJlLXJlYWQg
ZGV2aWNlIHN0YXR1cyB0byBlbnN1cmUgdGhlIEZFQVRVUkVTX09LIGJpdCBpcyBzdGlsbCBzZXQ6
Cj4+Pj4+PiBvdGhlcndpc2UsIHRoZSBkZXZpY2UgZG9lcyBub3QKPj4+Pj4+IHN1cHBvcnQgb3Vy
IHN1YnNldCBvZiBmZWF0dXJlcyBhbmQgdGhlIGRldmljZSBpcyB1bnVzYWJsZS4KPj4+Pj4+IDcu
IFBlcmZvcm0gZGV2aWNlLXNwZWNpZmljIHNldHVwLCBpbmNsdWRpbmcgZGlzY292ZXJ5IG9mIHZp
cnRxdWV1ZXMKPj4+Pj4+IGZvciB0aGUgZGV2aWNlLCBvcHRpb25hbCBwZXItYnVzIHNldHVwLAo+
Pj4+Pj4gcmVhZGluZyBhbmQgcG9zc2libHkgd3JpdGluZyB0aGUgZGV2aWNl4oCZcyB2aXJ0aW8g
Y29uZmlndXJhdGlvbgo+Pj4+Pj4gc3BhY2UsIGFuZCBwb3B1bGF0aW9uIG9mIHZpcnRxdWV1ZXMu
Cj4+Pj4+PiA4LiBTZXQgdGhlIERSSVZFUl9PSyBzdGF0dXMgYml0LiBBdCB0aGlzIHBvaW50IHRo
ZSBkZXZpY2UgaXMg4oCcbGl2ZeKAnS4KPj4+Pj4+Cj4+Pj4+Pgo+Pj4+Pj4gc28gYWNjZXNzaW5n
IGNvbmZpZyBzcGFjZSBiZWZvcmUgRkVBVFVSRVNfT0sgaXMgYSBzcGVjIHZpb2xhdGlvbiwgcmln
aHQ/Cj4+Pj4+IEl0IGlzLCBidXQgaXQncyBub3QgcmVsZXZhbnQgdG8gd2hhdCB0aGlzIGNvbW1p
dCB0cmllcyB0byBhZGRyZXNzLiBJCj4+Pj4+IHRob3VnaHQgdGhlIGxlZ2FjeSBndWVzdCBzdGls
bCBuZWVkcyB0byBiZSBzdXBwb3J0ZWQuCj4+Pj4+Cj4+Pj4+IEhhdmluZyBzYWlkLCBhIHNlcGFy
YXRlIHBhdGNoIGhhcyB0byBiZSBwb3N0ZWQgdG8gZml4IHRoZSBndWVzdCBkcml2ZXIKPj4+Pj4g
aXNzdWUgd2hlcmUgdGhpcyBkaXNjcmVwYW5jeSBpcyBpbnRyb2R1Y2VkIHRvIHZpcnRuZXRfdmFs
aWRhdGUoKSAoc2luY2UKPj4+Pj4gY29tbWl0IGZlMzZjYmUwNjcpLiBCdXQgaXQncyBub3QgdGVj
aG5pY2FsbHkgcmVsYXRlZCB0byB0aGlzIHBhdGNoLgo+Pj4+Pgo+Pj4+PiAtU2l3ZWkKPj4+PiBJ
IHRoaW5rIGl0J3MgYSBidWcgdG8gcmVhZCBjb25maWcgc3BhY2UgaW4gdmFsaWRhdGUsIHdlIHNo
b3VsZCBtb3ZlIGl0IHRvCj4+Pj4gdmlydG5ldF9wcm9iZSgpLgo+Pj4+Cj4+Pj4gVGhhbmtzCj4+
PiBJIHRha2UgaXQgYmFjaywgcmVhZGluZyBidXQgbm90IHdyaXRpbmcgc2VlbXMgdG8gYmUgZXhw
bGljaXRseSBhbGxvd2VkIGJ5IHNwZWMuCj4+PiBTbyBvdXIgd2F5IHRvIGRldGVjdCBhIGxlZ2Fj
eSBndWVzdCBpcyBib2d1cywgbmVlZCB0byB0aGluayB3aGF0IGlzCj4+PiB0aGUgYmVzdCB3YXkg
dG8gaGFuZGxlIHRoaXMuCj4+IFRoZW4gbWF5YmUgcmV2ZXJ0IGNvbW1pdCBmZTM2Y2JlMDY3IGFu
ZCBmcmllbmRzLCBhbmQgaGF2ZSBRRU1VIGRldGVjdCBsZWdhY3kKPj4gZ3Vlc3Q/IFN1cHBvc2Vk
bHkgb25seSBjb25maWcgc3BhY2Ugd3JpdGUgYWNjZXNzIG5lZWRzIHRvIGJlIGd1YXJkZWQgYmVm
b3JlCj4+IHNldHRpbmcgRkVBVFVSRVNfT0suCj4+Cj4+IC1TaXdpZQo+IERldGVjdGluZyBpdCBp
c24ndCBlbm91Z2ggdGhvdWdoLCB3ZSB3aWxsIG5lZWQgYSBuZXcgaW9jdGwgdG8gbm90aWZ5Cj4g
dGhlIGtlcm5lbCB0aGF0IGl0J3MgYSBsZWdhY3kgZ3Vlc3QuIFVnaCA6KAoKCkknbSBub3Qgc3Vy
ZSBJIGdldCB0aGlzLCBob3cgY2FuIHdlIGtub3cgaWYgdGhlcmUncyBhIGxlZ2FjeSBkcml2ZXIg
CmJlZm9yZSBzZXRfZmVhdHVyZXMoKT8KCkFuZCBJIHdvbmRlciB3aGF0IHdpbGwgaGFwZWVuIGlm
IHdlIGp1c3QgcmV2ZXJ0IHRoZSBzZXRfZmVhdHVyZXMoMCk/CgpUaGFua3MKCgo+Cj4KPj4+Pj4+
Pj4gUmVqZWN0aW5nIHJlc2V0IHRvIDAKPj4+Pj4+Pj4gcHJlbWF0dXJlbHkgY2F1c2VzIGNvcnJl
Y3QgTVRVIGFuZCBsaW5rIHN0YXR1cyB1bmFibGUgdG8gbG9hZAo+Pj4+Pj4+PiBmb3IgdGhlIHZl
cnkgZmlyc3QgY29uZmlnIHNwYWNlIGFjY2VzcywgcmVuZGVyaW5nIGlzc3VlcyBsaWtlCj4+Pj4+
Pj4+IGd1ZXN0IHNob3dpbmcgaW5hY2N1cmF0ZSBNVFUgdmFsdWUsIG9yIGZhaWx1cmUgdG8gcmVq
ZWN0Cj4+Pj4+Pj4+IG91dC1vZi1yYW5nZSBNVFUuCj4+Pj4+Pj4+Cj4+Pj4+Pj4+IEZpeGVzOiAx
YTg2YjM3N2FhMjEgKCJ2ZHBhL21seDU6IEFkZCBWRFBBIGRyaXZlciBmb3IKPj4+Pj4+Pj4gc3Vw
cG9ydGVkIG1seDUgZGV2aWNlcyIpCj4+Pj4+Pj4+IFNpZ25lZC1vZmYtYnk6IFNpLVdlaSBMaXUg
PHNpLXdlaS5saXVAb3JhY2xlLmNvbT4KPj4+Pj4+Pj4gLS0tCj4+Pj4+Pj4+ICAgwqDCoCBkcml2
ZXJzL3ZkcGEvbWx4NS9uZXQvbWx4NV92bmV0LmMgfCAxNSArLS0tLS0tLS0tLS0tLS0KPj4+Pj4+
Pj4gICDCoMKgIDEgZmlsZSBjaGFuZ2VkLCAxIGluc2VydGlvbigrKSwgMTQgZGVsZXRpb25zKC0p
Cj4+Pj4+Pj4+Cj4+Pj4+Pj4+IGRpZmYgLS1naXQgYS9kcml2ZXJzL3ZkcGEvbWx4NS9uZXQvbWx4
NV92bmV0LmMKPj4+Pj4+Pj4gYi9kcml2ZXJzL3ZkcGEvbWx4NS9uZXQvbWx4NV92bmV0LmMKPj4+
Pj4+Pj4gaW5kZXggN2MxZjc4OS4uNTQwZGQ2NyAxMDA2NDQKPj4+Pj4+Pj4gLS0tIGEvZHJpdmVy
cy92ZHBhL21seDUvbmV0L21seDVfdm5ldC5jCj4+Pj4+Pj4+ICsrKyBiL2RyaXZlcnMvdmRwYS9t
bHg1L25ldC9tbHg1X3ZuZXQuYwo+Pj4+Pj4+PiBAQCAtMTQ5MCwxNCArMTQ5MCw2IEBAIHN0YXRp
YyB1NjQKPj4+Pj4+Pj4gbWx4NV92ZHBhX2dldF9mZWF0dXJlcyhzdHJ1Y3QgdmRwYV9kZXZpY2Ug
KnZkZXYpCj4+Pj4+Pj4+ICAgwqDCoMKgwqDCoMKgIHJldHVybiBtdmRldi0+bWx4X2ZlYXR1cmVz
Owo+Pj4+Pj4+PiAgIMKgwqAgfQo+Pj4+Pj4+PiAtc3RhdGljIGludCB2ZXJpZnlfbWluX2ZlYXR1
cmVzKHN0cnVjdCBtbHg1X3ZkcGFfZGV2ICptdmRldiwKPj4+Pj4+Pj4gdTY0IGZlYXR1cmVzKQo+
Pj4+Pj4+PiAtewo+Pj4+Pj4+PiAtwqDCoMKgIGlmICghKGZlYXR1cmVzICYgQklUX1VMTChWSVJU
SU9fRl9BQ0NFU1NfUExBVEZPUk0pKSkKPj4+Pj4+Pj4gLcKgwqDCoMKgwqDCoMKgIHJldHVybiAt
RU9QTk9UU1VQUDsKPj4+Pj4+Pj4gLQo+Pj4+Pj4+PiAtwqDCoMKgIHJldHVybiAwOwo+Pj4+Pj4+
PiAtfQo+Pj4+Pj4+PiAtCj4+Pj4+Pj4+ICAgwqDCoCBzdGF0aWMgaW50IHNldHVwX3ZpcnRxdWV1
ZXMoc3RydWN0IG1seDVfdmRwYV9uZXQgKm5kZXYpCj4+Pj4+Pj4+ICAgwqDCoCB7Cj4+Pj4+Pj4+
ICAgwqDCoMKgwqDCoMKgIGludCBlcnI7Cj4+Pj4+Pj4+IEBAIC0xNTU4LDE4ICsxNTUwLDEzIEBA
IHN0YXRpYyBpbnQKPj4+Pj4+Pj4gbWx4NV92ZHBhX3NldF9mZWF0dXJlcyhzdHJ1Y3QgdmRwYV9k
ZXZpY2UgKnZkZXYsIHU2NAo+Pj4+Pj4+PiBmZWF0dXJlcykKPj4+Pj4+Pj4gICDCoMKgIHsKPj4+
Pj4+Pj4gICDCoMKgwqDCoMKgwqAgc3RydWN0IG1seDVfdmRwYV9kZXYgKm12ZGV2ID0gdG9fbXZk
ZXYodmRldik7Cj4+Pj4+Pj4+ICAgwqDCoMKgwqDCoMKgIHN0cnVjdCBtbHg1X3ZkcGFfbmV0ICpu
ZGV2ID0gdG9fbWx4NV92ZHBhX25kZXYobXZkZXYpOwo+Pj4+Pj4+PiAtwqDCoMKgIGludCBlcnI7
Cj4+Pj4+Pj4+ICAgwqDCoMKgwqDCoMKgIHByaW50X2ZlYXR1cmVzKG12ZGV2LCBmZWF0dXJlcywg
dHJ1ZSk7Cj4+Pj4+Pj4+IC3CoMKgwqAgZXJyID0gdmVyaWZ5X21pbl9mZWF0dXJlcyhtdmRldiwg
ZmVhdHVyZXMpOwo+Pj4+Pj4+PiAtwqDCoMKgIGlmIChlcnIpCj4+Pj4+Pj4+IC3CoMKgwqDCoMKg
wqDCoCByZXR1cm4gZXJyOwo+Pj4+Pj4+PiAtCj4+Pj4+Pj4+ICAgwqDCoMKgwqDCoMKgIG5kZXYt
Pm12ZGV2LmFjdHVhbF9mZWF0dXJlcyA9IGZlYXR1cmVzICYKPj4+Pj4+Pj4gbmRldi0+bXZkZXYu
bWx4X2ZlYXR1cmVzOwo+Pj4+Pj4+PiAgIMKgwqDCoMKgwqDCoCBuZGV2LT5jb25maWcubXR1ID0g
Y3B1X3RvX21seDV2ZHBhMTYobXZkZXYsIG5kZXYtPm10dSk7Cj4+Pj4+Pj4+ICAgwqDCoMKgwqDC
oMKgIG5kZXYtPmNvbmZpZy5zdGF0dXMgfD0gY3B1X3RvX21seDV2ZHBhMTYobXZkZXYsCj4+Pj4+
Pj4+IFZJUlRJT19ORVRfU19MSU5LX1VQKTsKPj4+Pj4+Pj4gLcKgwqDCoCByZXR1cm4gZXJyOwo+
Pj4+Pj4+PiArwqDCoMKgIHJldHVybiAwOwo+Pj4+Pj4+PiAgIMKgwqAgfQo+Pj4+Pj4+PiAgIMKg
wqAgc3RhdGljIHZvaWQgbWx4NV92ZHBhX3NldF9jb25maWdfY2Ioc3RydWN0IHZkcGFfZGV2aWNl
Cj4+Pj4+Pj4+ICp2ZGV2LCBzdHJ1Y3QgdmRwYV9jYWxsYmFjayAqY2IpCgpfX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fXwpWaXJ0dWFsaXphdGlvbiBtYWlsaW5n
IGxpc3QKVmlydHVhbGl6YXRpb25AbGlzdHMubGludXgtZm91bmRhdGlvbi5vcmcKaHR0cHM6Ly9s
aXN0cy5saW51eGZvdW5kYXRpb24ub3JnL21haWxtYW4vbGlzdGluZm8vdmlydHVhbGl6YXRpb24=
