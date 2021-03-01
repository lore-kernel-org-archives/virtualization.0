Return-Path: <SRS0=COaL=H7=lists.linux-foundation.org=virtualization-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.1 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 83F14C433DB
	for <virtualization@archiver.kernel.org>; Mon,  1 Mar 2021 03:57:26 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E9B6764EBD
	for <virtualization@archiver.kernel.org>; Mon,  1 Mar 2021 03:57:25 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E9B6764EBD
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=virtualization-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by smtp2.osuosl.org (Postfix) with ESMTP id A4AE4414FF;
	Mon,  1 Mar 2021 03:57:25 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
	by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id PVqHUyBu233k; Mon,  1 Mar 2021 03:57:24 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp2.osuosl.org (Postfix) with ESMTP id 5F1AF414E0;
	Mon,  1 Mar 2021 03:57:24 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 31B4DC000B;
	Mon,  1 Mar 2021 03:57:24 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 43017C0001
 for <virtualization@lists.linux-foundation.org>;
 Mon,  1 Mar 2021 03:57:23 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id 29C0E4ED8A
 for <virtualization@lists.linux-foundation.org>;
 Mon,  1 Mar 2021 03:57:23 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp4.osuosl.org (amavisd-new);
 dkim=pass (1024-bit key) header.d=redhat.com
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id Z23chjbCKbpx
 for <virtualization@lists.linux-foundation.org>;
 Mon,  1 Mar 2021 03:57:22 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [216.205.24.124])
 by smtp4.osuosl.org (Postfix) with ESMTPS id 1EEA24E59F
 for <virtualization@lists.linux-foundation.org>;
 Mon,  1 Mar 2021 03:57:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1614571040;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=78HWJYXLEabIPzI/nSKwCmdBQ1NIC1XcNi9/L1zbQxY=;
 b=dElJldIsOizPviVo8GNoa8Q0Abl5BKvVtY+cs3JfBLBSdImWJ0fTRSvov8fRB+yYCqyRXN
 2UCIGdAQlc6oIMnUrEyIH1LoWhWkN++HGtkydpr16Hk50iBOAD4Rr/CjKCAmniu9asMxvh
 c8CYgFFG+N+cA6E2oTciDhweuk5DBrI=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-271-FJ5A8hxRMvOtSVBRIFU0jw-1; Sun, 28 Feb 2021 22:57:18 -0500
X-MC-Unique: FJ5A8hxRMvOtSVBRIFU0jw-1
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com
 [10.5.11.13])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 559C86D4E0;
 Mon,  1 Mar 2021 03:57:17 +0000 (UTC)
Received: from wangxiaodeMacBook-Air.local (ovpn-12-164.pek2.redhat.com
 [10.72.12.164])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 4B29F6BF6B;
 Mon,  1 Mar 2021 03:56:59 +0000 (UTC)
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
 <52836a63-4e00-ff58-50fb-9f450ce968d7@oracle.com>
 <20210228163031-mutt-send-email-mst@kernel.org>
From: Jason Wang <jasowang@redhat.com>
Message-ID: <2cb51a6d-afa0-7cd1-d6f2-6b153186eaca@redhat.com>
Date: Mon, 1 Mar 2021 11:56:50 +0800
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.16; rv:78.0)
 Gecko/20100101 Thunderbird/78.8.0
MIME-Version: 1.0
In-Reply-To: <20210228163031-mutt-send-email-mst@kernel.org>
Content-Language: en-GB
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
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

Ck9uIDIwMjEvMy8xIDU6MzQg5LiK5Y2ILCBNaWNoYWVsIFMuIFRzaXJraW4gd3JvdGU6Cj4gT24g
V2VkLCBGZWIgMjQsIDIwMjEgYXQgMTA6MjQ6NDFBTSAtMDgwMCwgU2ktV2VpIExpdSB3cm90ZToK
Pj4+IERldGVjdGluZyBpdCBpc24ndCBlbm91Z2ggdGhvdWdoLCB3ZSB3aWxsIG5lZWQgYSBuZXcg
aW9jdGwgdG8gbm90aWZ5Cj4+PiB0aGUga2VybmVsIHRoYXQgaXQncyBhIGxlZ2FjeSBndWVzdC4g
VWdoIDooCj4+IFdlbGwsIGFsdGhvdWdoIEkgdGhpbmsgYWRkaW5nIGFuIGlvY3RsIGlzIGRvYWJs
ZSwgbWF5IEkga25vdyB3aGF0IHRoZSB1c2UKPj4gY2FzZSB0aGVyZSB3aWxsIGJlIGZvciBrZXJu
ZWwgdG8gbGV2ZXJhZ2Ugc3VjaCBpbmZvIGRpcmVjdGx5PyBJcyB0aGVyZSBhCj4+IGNhc2UgUUVN
VSBjYW4ndCBkbyB3aXRoIGRlZGljYXRlIGlvY3RscyBsYXRlciBpZiB0aGVyZSdzIGluZGVlZAo+
PiBkaWZmZXJlbnRpYXRpb24gKGxlZ2FjeSB2LnMuIG1vZGVybikgbmVlZGVkPwo+IEJUVyBhIGdv
b2QgQVBJIGNvdWxkIGJlCj4KPiAjZGVmaW5lIFZIT1NUX1NFVF9FTkRJQU4gX0lPVyhWSE9TVF9W
SVJUSU8sID8sIGludCkKPiAjZGVmaW5lIFZIT1NUX0dFVF9FTkRJQU4gX0lPVyhWSE9TVF9WSVJU
SU8sID8sIGludCkKPgo+IHdlIGRpZCBpdCBwZXIgdnJpbmcgYnV0IG1heWJlIHRoYXQgd2FzIGEg
bWlzdGFrZSAuLi4KCgpBY3R1YWxseSwgSSB3b25kZXIgd2hldGhlciBpdCdzIGdvb2QgdGltZSB0
byBqdXN0IG5vdCBzdXBwb3J0IGxlZ2FjeSAKZHJpdmVyIGZvciB2RFBBLiBDb25zaWRlcjoKCjEp
IEl0J3MgZGVmaW5pdGlvbiBpcyBuby1ub3JtYXRpdmUKMikgQSBsb3Qgb2YgYnVkcmVuIG9mIGNv
ZGVzCgpTbyBxZW11IGNhbiBzdGlsbCBwcmVzZW50IHRoZSBsZWdhY3kgZGV2aWNlIHNpbmNlIHRo
ZSBjb25maWcgc3BhY2Ugb3IgCm90aGVyIHN0dWZmcyB0aGF0IGlzIHByZXNlbnRlZCBieSB2aG9z
dC12RFBBIGlzIG5vdCBleHBlY3RlZCB0byBiZSAKYWNjZXNzZWQgYnkgZ3Vlc3QgZGlyZWN0bHku
IFFlbXUgY2FuIGRvIHRoZSBlbmRpYW4gY29udmVyc2lvbiB3aGVuIApuZWNlc3NhcnkgaW4gdGhp
cyBjYXNlPwoKVGhhbmtzCgoKPgoKX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX18KVmlydHVhbGl6YXRpb24gbWFpbGluZyBsaXN0ClZpcnR1YWxpemF0aW9uQGxp
c3RzLmxpbnV4LWZvdW5kYXRpb24ub3JnCmh0dHBzOi8vbGlzdHMubGludXhmb3VuZGF0aW9uLm9y
Zy9tYWlsbWFuL2xpc3RpbmZvL3ZpcnR1YWxpemF0aW9u
