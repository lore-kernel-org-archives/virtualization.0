Return-Path: <SRS0=X8aI=DV=lists.linux-foundation.org=virtualization-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.1 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	NICE_REPLY_A,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DF272C43457
	for <virtualization@archiver.kernel.org>; Wed, 14 Oct 2020 11:41:34 +0000 (UTC)
Received: from hemlock.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 5D30C20BED
	for <virtualization@archiver.kernel.org>; Wed, 14 Oct 2020 11:41:34 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="FLfHS38K"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5D30C20BED
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=virtualization-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by hemlock.osuosl.org (Postfix) with ESMTP id CFBC787904;
	Wed, 14 Oct 2020 11:41:33 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from hemlock.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id 15rqLJeoguPx; Wed, 14 Oct 2020 11:41:33 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by hemlock.osuosl.org (Postfix) with ESMTP id 1B8B9878E4;
	Wed, 14 Oct 2020 11:41:33 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 01D83C07FF;
	Wed, 14 Oct 2020 11:41:33 +0000 (UTC)
Received: from whitealder.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 498A4C0051
 for <virtualization@lists.linux-foundation.org>;
 Wed, 14 Oct 2020 11:41:32 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by whitealder.osuosl.org (Postfix) with ESMTP id 28C5187FCC
 for <virtualization@lists.linux-foundation.org>;
 Wed, 14 Oct 2020 11:41:32 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from whitealder.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id L1KPQ2z5kKha
 for <virtualization@lists.linux-foundation.org>;
 Wed, 14 Oct 2020 11:41:31 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [63.128.21.124])
 by whitealder.osuosl.org (Postfix) with ESMTPS id 3294887F09
 for <virtualization@lists.linux-foundation.org>;
 Wed, 14 Oct 2020 11:41:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1602675689;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=v3IxCdR5UIFXc9Mc6E/qqs0EKX5r/+I61Pl8lD+E/EQ=;
 b=FLfHS38KZvFEJ+m9hbkplD7eecv1dRxwqQwlStPesRMYtcV4XkkAk+tSfCQhYoDiyKuGYo
 37QzNPbP9ZGfie/WZ1cn6Fti8IXWM/Uk72Ghed7V7KB9iJpWWcVZYunVFo2+gCeVvQncj4
 g6WExa7xE5MkZRiAjecr89ut/U2Bqj0=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-500-CRMkafWXMgybo9GQOB-Dgg-1; Wed, 14 Oct 2020 07:41:27 -0400
X-MC-Unique: CRMkafWXMgybo9GQOB-Dgg-1
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com
 [10.5.11.14])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 3F9A510866A9;
 Wed, 14 Oct 2020 11:41:26 +0000 (UTC)
Received: from [10.72.13.215] (ovpn-13-215.pek2.redhat.com [10.72.13.215])
 by smtp.corp.redhat.com (Postfix) with ESMTP id BF01A5D9CD;
 Wed, 14 Oct 2020 11:41:18 +0000 (UTC)
Subject: Re: [PATCH v3 2/2] vhost-vdpa: fix page pinning leakage in error path
To: "Michael S. Tsirkin" <mst@redhat.com>, si-wei liu <si-wei.liu@oracle.com>
References: <1601701330-16837-1-git-send-email-si-wei.liu@oracle.com>
 <1601701330-16837-3-git-send-email-si-wei.liu@oracle.com>
 <574a64e3-8873-0639-fe32-248cb99204bc@redhat.com>
 <5F863B83.6030204@oracle.com> <20201014025025-mutt-send-email-mst@kernel.org>
From: Jason Wang <jasowang@redhat.com>
Message-ID: <06322c3a-24b1-1fc7-6914-57a920271738@redhat.com>
Date: Wed, 14 Oct 2020 19:41:17 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <20201014025025-mutt-send-email-mst@kernel.org>
Content-Language: en-US
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
Cc: netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
 virtualization@lists.linux-foundation.org, boris.ostrovsky@oracle.com,
 lingshan.zhu@intel.com
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

Ck9uIDIwMjAvMTAvMTQg5LiL5Y2IMjo1MiwgTWljaGFlbCBTLiBUc2lya2luIHdyb3RlOgo+IE9u
IFR1ZSwgT2N0IDEzLCAyMDIwIGF0IDA0OjQyOjU5UE0gLTA3MDAsIHNpLXdlaSBsaXUgd3JvdGU6
Cj4+IE9uIDEwLzkvMjAyMCA3OjI3IFBNLCBKYXNvbiBXYW5nIHdyb3RlOgo+Pj4gT24gMjAyMC8x
MC8zIOS4i+WNiDE6MDIsIFNpLVdlaSBMaXUgd3JvdGU6Cj4+Pj4gUGlubmVkIHBhZ2VzIGFyZSBu
b3QgcHJvcGVybHkgYWNjb3VudGVkIHBhcnRpY3VsYXJseSB3aGVuCj4+Pj4gbWFwcGluZyBlcnJv
ciBvY2N1cnMgb24gSU9UTEIgdXBkYXRlLiBDbGVhbiB1cCBkYW5nbGluZwo+Pj4+IHBpbm5lZCBw
YWdlcyBmb3IgdGhlIGVycm9yIHBhdGguIEFzIHRoZSBpbmZsaWdodCBwaW5uZWQKPj4+PiBwYWdl
cywgc3BlY2lmaWNhbGx5IGZvciBtZW1vcnkgcmVnaW9uIHRoYXQgc3RyaWRlcyBhY3Jvc3MKPj4+
PiBtdWx0aXBsZSBjaHVua3MsIHdvdWxkIG5lZWQgbW9yZSB0aGFuIG9uZSBmcmVlIHBhZ2UgZm9y
Cj4+Pj4gYm9vayBrZWVwaW5nIGFuZCBhY2NvdW50aW5nLiBGb3Igc2ltcGxpY2l0eSwgcGluIHBh
Z2VzCj4+Pj4gZm9yIGFsbCBtZW1vcnkgaW4gdGhlIElPVkEgcmFuZ2UgaW4gb25lIGdvIHJhdGhl
ciB0aGFuCj4+Pj4gaGF2ZSBtdWx0aXBsZSBwaW5fdXNlcl9wYWdlcyBjYWxscyB0byBtYWtlIHVw
IHRoZSBlbnRpcmUKPj4+PiByZWdpb24uIFRoaXMgd2F5IGl0J3MgZWFzaWVyIHRvIHRyYWNrIGFu
ZCBhY2NvdW50IHRoZQo+Pj4+IHBhZ2VzIGFscmVhZHkgbWFwcGVkLCBwYXJ0aWN1bGFybHkgZm9y
IGNsZWFuLXVwIGluIHRoZQo+Pj4+IGVycm9yIHBhdGguCj4+Pj4KPj4+PiBGaXhlczogNGM4Y2Yz
MTg4NWY2ICgidmhvc3Q6IGludHJvZHVjZSB2RFBBLWJhc2VkIGJhY2tlbmQiKQo+Pj4+IFNpZ25l
ZC1vZmYtYnk6IFNpLVdlaSBMaXU8c2ktd2VpLmxpdUBvcmFjbGUuY29tPgo+Pj4+IC0tLQo+Pj4+
IENoYW5nZXMgaW4gdjM6Cj4+Pj4gLSBGYWN0b3Igb3V0IHZob3N0X3ZkcGFfbWFwKCkgY2hhbmdl
IHRvIGEgc2VwYXJhdGUgcGF0Y2gKPj4+Pgo+Pj4+IENoYW5nZXMgaW4gdjI6Cj4+Pj4gLSBGaXgg
aW5jb3JyZWN0IHRhcmdldCBTSEExIHJlZmVyZW5jZWQKPj4+Pgo+Pj4+ICAgIGRyaXZlcnMvdmhv
c3QvdmRwYS5jIHwgMTE5Cj4+Pj4gKysrKysrKysrKysrKysrKysrKysrKysrKysrKysrLS0tLS0t
LS0tLS0tLS0tLS0tLS0tCj4+Pj4gICAgMSBmaWxlIGNoYW5nZWQsIDcxIGluc2VydGlvbnMoKyks
IDQ4IGRlbGV0aW9ucygtKQo+Pj4+Cj4+Pj4gZGlmZiAtLWdpdCBhL2RyaXZlcnMvdmhvc3QvdmRw
YS5jIGIvZHJpdmVycy92aG9zdC92ZHBhLmMKPj4+PiBpbmRleCAwZjI3OTE5Li5kYWQ0MWRhZSAx
MDA2NDQKPj4+PiAtLS0gYS9kcml2ZXJzL3Zob3N0L3ZkcGEuYwo+Pj4+ICsrKyBiL2RyaXZlcnMv
dmhvc3QvdmRwYS5jCj4+Pj4gQEAgLTU5NSwyMSArNTk1LDE5IEBAIHN0YXRpYyBpbnQKPj4+PiB2
aG9zdF92ZHBhX3Byb2Nlc3NfaW90bGJfdXBkYXRlKHN0cnVjdCB2aG9zdF92ZHBhICp2LAo+Pj4+
ICAgICAgICBzdHJ1Y3Qgdmhvc3RfZGV2ICpkZXYgPSAmdi0+dmRldjsKPj4+PiAgICAgICAgc3Ry
dWN0IHZob3N0X2lvdGxiICppb3RsYiA9IGRldi0+aW90bGI7Cj4+Pj4gICAgICAgIHN0cnVjdCBw
YWdlICoqcGFnZV9saXN0Owo+Pj4+IC0gICAgdW5zaWduZWQgbG9uZyBsaXN0X3NpemUgPSBQQUdF
X1NJWkUgLyBzaXplb2Yoc3RydWN0IHBhZ2UgKik7Cj4+Pj4gKyAgICBzdHJ1Y3Qgdm1fYXJlYV9z
dHJ1Y3QgKip2bWFzOwo+Pj4+ICAgICAgICB1bnNpZ25lZCBpbnQgZ3VwX2ZsYWdzID0gRk9MTF9M
T05HVEVSTTsKPj4+PiAtICAgIHVuc2lnbmVkIGxvbmcgbnBhZ2VzLCBjdXJfYmFzZSwgbWFwX3Bm
biwgbGFzdF9wZm4gPSAwOwo+Pj4+IC0gICAgdW5zaWduZWQgbG9uZyBsb2NrZWQsIGxvY2tfbGlt
aXQsIHBpbm5lZCwgaTsKPj4+PiArICAgIHVuc2lnbmVkIGxvbmcgbWFwX3BmbiwgbGFzdF9wZm4g
PSAwOwo+Pj4+ICsgICAgdW5zaWduZWQgbG9uZyBucGFnZXMsIGxvY2tfbGltaXQ7Cj4+Pj4gKyAg
ICB1bnNpZ25lZCBsb25nIGksIG5tYXAgPSAwOwo+Pj4+ICAgICAgICB1NjQgaW92YSA9IG1zZy0+
aW92YTsKPj4+PiArICAgIGxvbmcgcGlubmVkOwo+Pj4+ICAgICAgICBpbnQgcmV0ID0gMDsKPj4+
PiAgICAgICAgICBpZiAodmhvc3RfaW90bGJfaXRyZWVfZmlyc3QoaW90bGIsIG1zZy0+aW92YSwK
Pj4+PiAgICAgICAgICAgICAgICAgICAgICAgIG1zZy0+aW92YSArIG1zZy0+c2l6ZSAtIDEpKQo+
Pj4+ICAgICAgICAgICAgcmV0dXJuIC1FRVhJU1Q7Cj4+Pj4gICAgLSAgICBwYWdlX2xpc3QgPSAo
c3RydWN0IHBhZ2UgKiopIF9fZ2V0X2ZyZWVfcGFnZShHRlBfS0VSTkVMKTsKPj4+PiAtICAgIGlm
ICghcGFnZV9saXN0KQo+Pj4+IC0gICAgICAgIHJldHVybiAtRU5PTUVNOwo+Pj4+IC0KPj4+PiAg
ICAgICAgaWYgKG1zZy0+cGVybSAmIFZIT1NUX0FDQ0VTU19XTykKPj4+PiAgICAgICAgICAgIGd1
cF9mbGFncyB8PSBGT0xMX1dSSVRFOwo+Pj4+ICAgIEBAIC02MTcsNjEgKzYxNSw4NiBAQCBzdGF0
aWMgaW50Cj4+Pj4gdmhvc3RfdmRwYV9wcm9jZXNzX2lvdGxiX3VwZGF0ZShzdHJ1Y3Qgdmhvc3Rf
dmRwYSAqdiwKPj4+PiAgICAgICAgaWYgKCFucGFnZXMpCj4+Pj4gICAgICAgICAgICByZXR1cm4g
LUVJTlZBTDsKPj4+PiAgICArICAgIHBhZ2VfbGlzdCA9IGt2bWFsbG9jX2FycmF5KG5wYWdlcywg
c2l6ZW9mKHN0cnVjdCBwYWdlICopLAo+Pj4+IEdGUF9LRVJORUwpOwo+Pj4+ICsgICAgdm1hcyA9
IGt2bWFsbG9jX2FycmF5KG5wYWdlcywgc2l6ZW9mKHN0cnVjdCB2bV9hcmVhX3N0cnVjdCAqKSwK
Pj4+PiArICAgICAgICAgICAgICAgICAgR0ZQX0tFUk5FTCk7Cj4+PiBUaGlzIHdpbGwgcmVzdWx0
IGhpZ2ggb3JkZXIgbWVtb3J5IGFsbG9jYXRpb24gd2hpY2ggd2FzIHdoYXQgdGhlIGNvZGUKPj4+
IHRyaWVkIHRvIGF2b2lkIG9yaWdpbmFsbHkuCj4+Pgo+Pj4gVXNpbmcgYW4gdW5saW1pdGVkIHNp
emUgd2lsbCBjYXVzZSBhIGxvdCBvZiBzaWRlIGVmZmVjdHMgY29uc2lkZXIgVk0gb3IKPj4+IHVz
ZXJzcGFjZSBtYXkgdHJ5IHRvIHBpbiBzZXZlcmFsIFRCIG9mIG1lbW9yeS4KPj4gSG1tbSwgdGhh
dCdzIGEgZ29vZCBwb2ludC4gSW5kZWVkLCBpZiB0aGUgZ3Vlc3QgbWVtb3J5IGRlbWFuZCBpcyBo
dWdlIG9yIHRoZQo+PiBob3N0IHN5c3RlbSBpcyBydW5uaW5nIHNob3J0IG9mIGZyZWUgcGFnZXMs
IGt2bWFsbG9jIHdpbGwgYmUgcHJvYmxlbWF0aWMgYW5kCj4+IGxlc3MgZWZmaWNpZW50IHRoYW4g
dGhlIF9fZ2V0X2ZyZWVfcGFnZSBpbXBsZW1lbnRhdGlvbi4KPiBPSyBzbyAuLi4gSmFzb24sIHdo
YXQncyB0aGUgcGxhbj8KPgo+IEhvdyBhYm91dCB5b3Ugc2VuZCBhIHBhdGNoc2V0IHdpdGgKPiAx
LiByZXZlcnQgdGhpcyBjaGFuZ2UKPiAyLiBmaXggZXJyb3IgaGFuZGxpbmcgbGVhawoKCldvcmsg
Zm9yIG1lLCBidXQgaXQgbG9va3MgbGlrZSBzaXdlaSB3YW50IHRvIGRvIHRoaXMuCgpTbyBpdCdz
IGJldHRlciBmb3IgdG8gc2VuZCB0aGUgcGF0Y2hzZXQuCgpUaGFua3MKCgo+Cj4KCl9fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fClZpcnR1YWxpemF0aW9uIG1h
aWxpbmcgbGlzdApWaXJ0dWFsaXphdGlvbkBsaXN0cy5saW51eC1mb3VuZGF0aW9uLm9yZwpodHRw
czovL2xpc3RzLmxpbnV4Zm91bmRhdGlvbi5vcmcvbWFpbG1hbi9saXN0aW5mby92aXJ0dWFsaXph
dGlvbg==
