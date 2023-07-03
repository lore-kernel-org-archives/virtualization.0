Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 341CCEB64DC
	for <virtualization@archiver.kernel.org>; Mon,  3 Jul 2023 07:44:04 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 945CD408DA;
	Mon,  3 Jul 2023 07:44:03 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org 945CD408DA
Authentication-Results: smtp4.osuosl.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=AkZ4ld8/
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
	by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id wCuhqQEkxhIo; Mon,  3 Jul 2023 07:44:02 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp4.osuosl.org (Postfix) with ESMTPS id CDE52408AE;
	Mon,  3 Jul 2023 07:44:01 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org CDE52408AE
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 83DACC0071;
	Mon,  3 Jul 2023 07:44:01 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by lists.linuxfoundation.org (Postfix) with ESMTP id BD628C0032
 for <virtualization@lists.linux-foundation.org>;
 Mon,  3 Jul 2023 07:44:00 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id 91C6060B29
 for <virtualization@lists.linux-foundation.org>;
 Mon,  3 Jul 2023 07:44:00 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 91C6060B29
Authentication-Results: smtp3.osuosl.org;
 dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com
 header.a=rsa-sha256 header.s=mimecast20190719 header.b=AkZ4ld8/
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id 2KeALv90GzlN
 for <virtualization@lists.linux-foundation.org>;
 Mon,  3 Jul 2023 07:43:59 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 868A760760
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.129.124])
 by smtp3.osuosl.org (Postfix) with ESMTPS id 868A760760
 for <virtualization@lists.linux-foundation.org>;
 Mon,  3 Jul 2023 07:43:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1688370238;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=+izZ056qkx9wA4inyIESYge9LDOiXeBR8mNGux+wGrY=;
 b=AkZ4ld8/zTmqvR9dBaOXEydH2gA+jS65M0t04m3J1gNdZ1C6kJZpn4fWbXguHi+qEWBtP1
 rQEAK5LkNRrcEkoriK8YKXcUboh7AJGPPJWHfLHTj7GEZpjqCFB+yswxpx3Wm/i2ZeCcI7
 7pErFELcpwUnRm/SjK5PTJJWKap4TfE=
Received: from mimecast-mx02.redhat.com (mx3-rdu2.redhat.com
 [66.187.233.73]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-523-yUKSl3uqMPq6z5xBHPWbzQ-1; Mon, 03 Jul 2023 03:43:54 -0400
X-MC-Unique: yUKSl3uqMPq6z5xBHPWbzQ-1
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.rdu2.redhat.com
 [10.11.54.2])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 1C8573806707;
 Mon,  3 Jul 2023 07:43:54 +0000 (UTC)
Received: from [10.39.208.21] (unknown [10.39.208.21])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id BA0544087C6A;
 Mon,  3 Jul 2023 07:43:51 +0000 (UTC)
Message-ID: <571e2fbc-ea6a-d231-79f0-37529e05eb98@redhat.com>
Date: Mon, 3 Jul 2023 09:43:49 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.12.0
Subject: Re: [PATCH v1 0/2] vduse: add support for networking devices
To: Jason Wang <jasowang@redhat.com>, "Michael S. Tsirkin" <mst@redhat.com>
References: <20230627113652.65283-1-maxime.coquelin@redhat.com>
 <20230702093530-mutt-send-email-mst@kernel.org>
 <CACGkMEtoW0nW8w6_Ew8qckjvpNGN_idwpU3jwsmX6JzbDknmQQ@mail.gmail.com>
Content-Language: en-US
From: Maxime Coquelin <maxime.coquelin@redhat.com>
In-Reply-To: <CACGkMEtoW0nW8w6_Ew8qckjvpNGN_idwpU3jwsmX6JzbDknmQQ@mail.gmail.com>
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.2
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

Ck9uIDcvMy8yMyAwODo0NCwgSmFzb24gV2FuZyB3cm90ZToKPiBPbiBTdW4sIEp1bCAyLCAyMDIz
IGF0IDk6MzfigK9QTSBNaWNoYWVsIFMuIFRzaXJraW4gPG1zdEByZWRoYXQuY29tPiB3cm90ZToK
Pj4KPj4gT24gVHVlLCBKdW4gMjcsIDIwMjMgYXQgMDE6MzY6NTBQTSArMDIwMCwgTWF4aW1lIENv
cXVlbGluIHdyb3RlOgo+Pj4gVGhpcyBzbWFsbCBzZXJpZXMgZW5hYmxlcyB2aXJ0aW8tbmV0IGRl
dmljZSB0eXBlIGluIFZEVVNFLgo+Pj4gV2l0aCBpdCwgYmFzaWMgb3BlcmF0aW9uIGhhdmUgYmVl
biB0ZXN0ZWQsIGJvdGggd2l0aAo+Pj4gdmlydGlvLXZkcGEgYW5kIHZob3N0LXZkcGEgdXNpbmcg
RFBESyBWaG9zdCBsaWJyYXJ5IHNlcmllcwo+Pj4gYWRkaW5nIFZEVVNFIHN1cHBvcnQgdXNpbmcg
c3BsaXQgcmluZ3MgbGF5b3V0IChtZXJnZWQgaW4KPj4+IERQREsgdjIzLjA3LXJjMSkuCj4+Pgo+
Pj4gQ29udHJvbCBxdWV1ZSBzdXBwb3J0IChhbmQgc28gbXVsdGlxdWV1ZSkgaGFzIGFsc28gYmVl
bgo+Pj4gdGVzdGVkLCBidXQgcmVxdWlyZXMgYSBLZXJuZWwgc2VyaWVzIGZyb20gSmFzb24gV2Fu
Zwo+Pj4gcmVsYXhpbmcgY29udHJvbCBxdWV1ZSBwb2xsaW5nIFsxXSB0byBmdW5jdGlvbiByZWxp
YWJseS4KPj4+Cj4+PiBbMV06IGh0dHBzOi8vbG9yZS5rZXJuZWwub3JnL2xrbWwvQ0FDR2tNRXRn
cnhOM1BQd3NEbzRvT3Nuc1NMSmZFbUJFWjBXdmpHUnIzd2hVK1Fhc1VnQG1haWwuZ21haWwuY29t
L1QvCj4+Cj4+IEphc29uIHByb21pc2VkIHRvIHBvc3QgYSBuZXcgdmVyc2lvbiBvZiB0aGF0IHBh
dGNoLgo+PiBSaWdodCBKYXNvbj8KPiAKPiBZZXMuCj4gCj4+IEZvciBub3cgbGV0J3MgbWFrZSBz
dXJlIENWUSBmZWF0dXJlIGZsYWcgaXMgb2ZmPwo+IAo+IFdlIGNhbiBkbyB0aGF0IGFuZCByZWxh
eCBvbiB0b3Agb2YgbXkgcGF0Y2guCgpJIGFncmVlPyBEbyB5b3UgcHJlZmVyIGEgZmVhdHVyZXMg
bmVnb3RpYXRpb24sIG9yIGZhaWxpbmcgaW5pdCAobGlrZQpkb25lIGZvciBWRVJTSU9OXzEpIGlm
IHRoZSBWRFVTRSBhcHBsaWNhdGlvbiBhZHZlcnRpc2VzIENWUT8KClRoYW5rcywKTWF4aW1lCgo+
IFRoYW5rcwo+IAo+Pgo+Pj4gUkZDIC0+IHYxIGNoYW5nZXM6Cj4+PiA9PT09PT09PT09PT09PT09
PT0KPj4+IC0gRmFpbCBkZXZpY2UgaW5pdCBpZiBpdCBkb2VzIG5vdCBzdXBwb3J0IFZFUlNJT05f
MSAoSmFzb24pCj4+Pgo+Pj4gTWF4aW1lIENvcXVlbGluICgyKToKPj4+ICAgIHZkdXNlOiB2YWxp
ZGF0ZSBibG9jayBmZWF0dXJlcyBvbmx5IHdpdGggYmxvY2sgZGV2aWNlcwo+Pj4gICAgdmR1c2U6
IGVuYWJsZSBWaXJ0aW8tbmV0IGRldmljZSB0eXBlCj4+Pgo+Pj4gICBkcml2ZXJzL3ZkcGEvdmRw
YV91c2VyL3ZkdXNlX2Rldi5jIHwgMTUgKysrKysrKysrKystLS0tCj4+PiAgIDEgZmlsZSBjaGFu
Z2VkLCAxMSBpbnNlcnRpb25zKCspLCA0IGRlbGV0aW9ucygtKQo+Pj4KPj4+IC0tCj4+PiAyLjQx
LjAKPj4KPiAKCl9fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
ClZpcnR1YWxpemF0aW9uIG1haWxpbmcgbGlzdApWaXJ0dWFsaXphdGlvbkBsaXN0cy5saW51eC1m
b3VuZGF0aW9uLm9yZwpodHRwczovL2xpc3RzLmxpbnV4Zm91bmRhdGlvbi5vcmcvbWFpbG1hbi9s
aXN0aW5mby92aXJ0dWFsaXphdGlvbg==
