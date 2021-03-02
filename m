Return-Path: <SRS0=LnXi=IA=lists.linux-foundation.org=virtualization-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.0 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D3521C433E0
	for <virtualization@archiver.kernel.org>; Tue,  2 Mar 2021 10:54:06 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 5BF6460231
	for <virtualization@archiver.kernel.org>; Tue,  2 Mar 2021 10:54:06 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5BF6460231
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=virtualization-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 1944F6F5FF;
	Tue,  2 Mar 2021 10:54:06 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
	by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id UcdFuodOEunn; Tue,  2 Mar 2021 10:54:05 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp3.osuosl.org (Postfix) with ESMTP id AB8626F4D4;
	Tue,  2 Mar 2021 10:54:04 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 88F3AC000A;
	Tue,  2 Mar 2021 10:54:04 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 55F68C0001
 for <virtualization@lists.linux-foundation.org>;
 Tue,  2 Mar 2021 10:54:03 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id 3754F6F593
 for <virtualization@lists.linux-foundation.org>;
 Tue,  2 Mar 2021 10:54:03 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id 6wWid29WaNZd
 for <virtualization@lists.linux-foundation.org>;
 Tue,  2 Mar 2021 10:54:02 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [63.128.21.124])
 by smtp3.osuosl.org (Postfix) with ESMTPS id 64EA26F4D4
 for <virtualization@lists.linux-foundation.org>;
 Tue,  2 Mar 2021 10:54:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1614682441;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=iGoIdvlUz0nc9AN8ZEH5WnSE27CeiPYPvS6gyByubs0=;
 b=fq05dabxyPnNkzIYArGK5OfWuoHUWgumx91aDB2lp2QyrKc7ybiKYo+cp3k9kyHamuS5Rr
 KcIumvyy9vembRnwX/F/wSggHYuG3XP3hgTCyLLQJi4MG/U7b7axbHal5sSQklYY4vVvHB
 w+bgKrcSO4FZE++gi6Ddw2Z+srODs8c=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-540-V1K4Oah_PzeYFrWjqcNxZQ-1; Tue, 02 Mar 2021 05:53:59 -0500
X-MC-Unique: V1K4Oah_PzeYFrWjqcNxZQ-1
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com
 [10.5.11.14])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 8A3A6801976;
 Tue,  2 Mar 2021 10:53:58 +0000 (UTC)
Received: from wangxiaodeMacBook-Air.local (ovpn-13-124.pek2.redhat.com
 [10.72.13.124])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 473455D9D3;
 Tue,  2 Mar 2021 10:53:52 +0000 (UTC)
Subject: Re: [PATCH] vdpa/mlx5: set_features should allow reset to zero
To: "Michael S. Tsirkin" <mst@redhat.com>
References: <605e7d2d-4f27-9688-17a8-d57191752ee7@redhat.com>
 <20210222023040-mutt-send-email-mst@kernel.org>
 <22fe5923-635b-59f0-7643-2fd5876937c2@oracle.com>
 <fae0bae7-e4cd-a3aa-57fe-d707df99b634@redhat.com>
 <20210223082536-mutt-send-email-mst@kernel.org>
 <3ff5fd23-1db0-2f95-4cf9-711ef403fb62@oracle.com>
 <20210224000057-mutt-send-email-mst@kernel.org>
 <52836a63-4e00-ff58-50fb-9f450ce968d7@oracle.com>
 <20210228163031-mutt-send-email-mst@kernel.org>
 <2cb51a6d-afa0-7cd1-d6f2-6b153186eaca@redhat.com>
 <20210302043419-mutt-send-email-mst@kernel.org>
From: Jason Wang <jasowang@redhat.com>
Message-ID: <178f8ea7-cebd-0e81-3dc7-10a058d22c07@redhat.com>
Date: Tue, 2 Mar 2021 18:53:50 +0800
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.16; rv:78.0)
 Gecko/20100101 Thunderbird/78.8.0
MIME-Version: 1.0
In-Reply-To: <20210302043419-mutt-send-email-mst@kernel.org>
Content-Language: en-GB
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
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

Ck9uIDIwMjEvMy8yIDU6NDcg5LiL5Y2ILCBNaWNoYWVsIFMuIFRzaXJraW4gd3JvdGU6Cj4gT24g
TW9uLCBNYXIgMDEsIDIwMjEgYXQgMTE6NTY6NTBBTSArMDgwMCwgSmFzb24gV2FuZyB3cm90ZToK
Pj4gT24gMjAyMS8zLzEgNTozNCDkuIrljYgsIE1pY2hhZWwgUy4gVHNpcmtpbiB3cm90ZToKPj4+
IE9uIFdlZCwgRmViIDI0LCAyMDIxIGF0IDEwOjI0OjQxQU0gLTA4MDAsIFNpLVdlaSBMaXUgd3Jv
dGU6Cj4+Pj4+IERldGVjdGluZyBpdCBpc24ndCBlbm91Z2ggdGhvdWdoLCB3ZSB3aWxsIG5lZWQg
YSBuZXcgaW9jdGwgdG8gbm90aWZ5Cj4+Pj4+IHRoZSBrZXJuZWwgdGhhdCBpdCdzIGEgbGVnYWN5
IGd1ZXN0LiBVZ2ggOigKPj4+PiBXZWxsLCBhbHRob3VnaCBJIHRoaW5rIGFkZGluZyBhbiBpb2N0
bCBpcyBkb2FibGUsIG1heSBJIGtub3cgd2hhdCB0aGUgdXNlCj4+Pj4gY2FzZSB0aGVyZSB3aWxs
IGJlIGZvciBrZXJuZWwgdG8gbGV2ZXJhZ2Ugc3VjaCBpbmZvIGRpcmVjdGx5PyBJcyB0aGVyZSBh
Cj4+Pj4gY2FzZSBRRU1VIGNhbid0IGRvIHdpdGggZGVkaWNhdGUgaW9jdGxzIGxhdGVyIGlmIHRo
ZXJlJ3MgaW5kZWVkCj4+Pj4gZGlmZmVyZW50aWF0aW9uIChsZWdhY3kgdi5zLiBtb2Rlcm4pIG5l
ZWRlZD8KPj4+IEJUVyBhIGdvb2QgQVBJIGNvdWxkIGJlCj4+Pgo+Pj4gI2RlZmluZSBWSE9TVF9T
RVRfRU5ESUFOIF9JT1coVkhPU1RfVklSVElPLCA/LCBpbnQpCj4+PiAjZGVmaW5lIFZIT1NUX0dF
VF9FTkRJQU4gX0lPVyhWSE9TVF9WSVJUSU8sID8sIGludCkKPj4+Cj4+PiB3ZSBkaWQgaXQgcGVy
IHZyaW5nIGJ1dCBtYXliZSB0aGF0IHdhcyBhIG1pc3Rha2UgLi4uCj4+Cj4+IEFjdHVhbGx5LCBJ
IHdvbmRlciB3aGV0aGVyIGl0J3MgZ29vZCB0aW1lIHRvIGp1c3Qgbm90IHN1cHBvcnQgbGVnYWN5
IGRyaXZlcgo+PiBmb3IgdkRQQS4gQ29uc2lkZXI6Cj4+Cj4+IDEpIEl0J3MgZGVmaW5pdGlvbiBp
cyBuby1ub3JtYXRpdmUKPj4gMikgQSBsb3Qgb2YgYnVkcmVuIG9mIGNvZGVzCj4+Cj4+IFNvIHFl
bXUgY2FuIHN0aWxsIHByZXNlbnQgdGhlIGxlZ2FjeSBkZXZpY2Ugc2luY2UgdGhlIGNvbmZpZyBz
cGFjZSBvciBvdGhlcgo+PiBzdHVmZnMgdGhhdCBpcyBwcmVzZW50ZWQgYnkgdmhvc3QtdkRQQSBp
cyBub3QgZXhwZWN0ZWQgdG8gYmUgYWNjZXNzZWQgYnkKPj4gZ3Vlc3QgZGlyZWN0bHkuIFFlbXUg
Y2FuIGRvIHRoZSBlbmRpYW4gY29udmVyc2lvbiB3aGVuIG5lY2Vzc2FyeSBpbiB0aGlzCj4+IGNh
c2U/Cj4+Cj4+IFRoYW5rcwo+Pgo+IE92ZXJhbGwgSSB3b3VsZCBiZSBmaW5lIHdpdGggdGhpcyBh
cHByb2FjaCBidXQgd2UgbmVlZCB0byBhdm9pZCBicmVha2luZwo+IHdvcmtpbmcgdXNlcnNwYWNl
LCBxZW11IHJlbGVhc2VzIHdpdGggdmRwYSBzdXBwb3J0IGFyZSBvdXQgdGhlcmUgYW5kCj4gc2Vl
bSB0byB3b3JrIGZvciBwZW9wbGUuIEFueSBjaGFuZ2VzIG5lZWQgdG8gdGFrZSB0aGF0IGludG8g
YWNjb3VudAo+IGFuZCBkb2N1bWVudCBjb21wYXRpYmlsaXR5IGNvbmNlcm5zLgoKCkFncmVlLCBs
ZXQgbWUgY2hlY2suCgoKPiAgIEkgbm90ZSB0aGF0IGFueSBoYXJkd2FyZQo+IGltcGxlbWVudGF0
aW9uIGlzIGFscmVhZHkgYnJva2VuIGZvciBsZWdhY3kgZXhjZXB0IG9uIHBsYXRmb3JtcyB3aXRo
Cj4gc3Ryb25nIG9yZGVyaW5nIHdoaWNoIG1pZ2h0IGJlIGhlbHBmdWwgaW4gcmVkdWNpbmcgdGhl
IHNjb3BlLgoKClllcy4KClRoYW5rcwoKCj4KPgoKX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX18KVmlydHVhbGl6YXRpb24gbWFpbGluZyBsaXN0ClZpcnR1YWxp
emF0aW9uQGxpc3RzLmxpbnV4LWZvdW5kYXRpb24ub3JnCmh0dHBzOi8vbGlzdHMubGludXhmb3Vu
ZGF0aW9uLm9yZy9tYWlsbWFuL2xpc3RpbmZvL3ZpcnR1YWxpemF0aW9u
