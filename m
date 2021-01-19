Return-Path: <SRS0=ogTN=GW=lists.linux-foundation.org=virtualization-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.2 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,
	SPF_HELO_NONE,SPF_PASS,URIBL_RED,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 56A2FC433E0
	for <virtualization@archiver.kernel.org>; Tue, 19 Jan 2021 04:04:32 +0000 (UTC)
Received: from silver.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B0778205CB
	for <virtualization@archiver.kernel.org>; Tue, 19 Jan 2021 04:04:31 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B0778205CB
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=virtualization-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by silver.osuosl.org (Postfix) with ESMTP id 110CD23492;
	Tue, 19 Jan 2021 04:04:31 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from silver.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id Mb-POWo09FcM; Tue, 19 Jan 2021 04:04:27 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by silver.osuosl.org (Postfix) with ESMTP id C8EB7232D2;
	Tue, 19 Jan 2021 04:04:27 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id B34C8C088B;
	Tue, 19 Jan 2021 04:04:27 +0000 (UTC)
Received: from whitealder.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id E8F36C013A
 for <virtualization@lists.linux-foundation.org>;
 Tue, 19 Jan 2021 04:04:26 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by whitealder.osuosl.org (Postfix) with ESMTP id D4A0F8614D
 for <virtualization@lists.linux-foundation.org>;
 Tue, 19 Jan 2021 04:04:26 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from whitealder.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id O7-R0qufubm6
 for <virtualization@lists.linux-foundation.org>;
 Tue, 19 Jan 2021 04:04:25 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [63.128.21.124])
 by whitealder.osuosl.org (Postfix) with ESMTPS id 9A6EC860F9
 for <virtualization@lists.linux-foundation.org>;
 Tue, 19 Jan 2021 04:04:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1611029064;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=06PtBYn0LQuzQkFBF6fgOmSrDr0QFcSFZEJebEBQ7c4=;
 b=jA4PUziMhQsEpNskF1qaIZFtO+TqBCNd/YlM68bR+QRB8ceVyMJ23oo59NolM9BmPREKgo
 0cAvepNROjMfKbKQ7NoA6NO5DhSxJKRYuN+xATEgh4Uun1M5Ml7XblpkRb17LiPhd2Qasb
 vvp2++kM+aq+8Z0hTYgutjQmjRUOTzU=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-352-6Quo4kc8PtKdLji77ZRl7w-1; Mon, 18 Jan 2021 23:04:22 -0500
X-MC-Unique: 6Quo4kc8PtKdLji77ZRl7w-1
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com
 [10.5.11.14])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 2D05F10054FF;
 Tue, 19 Jan 2021 04:04:21 +0000 (UTC)
Received: from [10.72.13.139] (ovpn-13-139.pek2.redhat.com [10.72.13.139])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 7DEAC5D9CD;
 Tue, 19 Jan 2021 04:04:16 +0000 (UTC)
Subject: Re: [PATCH RFC] virtio-blk: support per-device queue depth
To: Joseph Qi <joseph.qi@linux.alibaba.com>,
 "Michael S. Tsirkin" <mst@redhat.com>
References: <1610942338-78252-1-git-send-email-joseph.qi@linux.alibaba.com>
 <ab4cbc06-b629-dd35-52ac-1246d500d1c4@redhat.com>
 <9a736867-d420-26eb-3ee2-42869a069640@linux.alibaba.com>
From: Jason Wang <jasowang@redhat.com>
Message-ID: <814df55b-68cf-189c-66e3-29f02f3d6b62@redhat.com>
Date: Tue, 19 Jan 2021 12:04:14 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <9a736867-d420-26eb-3ee2-42869a069640@linux.alibaba.com>
Content-Language: en-US
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
Cc: linux-block@vger.kernel.org, virtualization@lists.linux-foundation.org
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

Ck9uIDIwMjEvMS8xOCDkuIvljYgyOjA2LCBKb3NlcGggUWkgd3JvdGU6Cj4gSGkgSmFzb24sCj4K
PiBPbiAxLzE4LzIxIDE6MjUgUE0sIEphc29uIFdhbmcgd3JvdGU6Cj4+IE9uIDIwMjEvMS8xOCDk
uIrljYgxMTo1OCwgSm9zZXBoIFFpIHdyb3RlOgo+Pj4gbW9kdWxlIHBhcmFtZXRlciAndmlydGJs
a19xdWV1ZV9kZXB0aCcgd2FzIGZpcnN0bHkgaW50cm9kdWNlZCBmb3IKPj4+IHRlc3RpbmcvYmVu
Y2htYXJraW5nIHB1cnBvc2VzIGRlc2NyaWJlZCBpbiBjb21taXQgZmM0MzI0YjQ1OTdjCj4+PiAo
InZpcnRpby1ibGs6IGJhc2UgcXVldWUtZGVwdGggb24gdmlydHF1ZXVlIHJpbmdzaXplIG9yIG1v
ZHVsZSBwYXJhbSIpLgo+Pj4gU2luY2Ugd2UgaGF2ZSBkaWZmZXJlbnQgdmlydGlvLWJsayBkZXZp
Y2VzIHdoaWNoIGhhdmUgZGlmZmVyZW50Cj4+PiBjYXBhYmlsaXRpZXMsIGl0IHJlcXVpcmVzIHRo
YXQgd2Ugc3VwcG9ydCBwZXItZGV2aWNlIHF1ZXVlIGRlcHRoIGluc3RlYWQKPj4+IG9mIHBlci1t
b2R1bGUuIFNvIGRlZmF1bHRseSB1c2UgdnEgZnJlZSBlbGVtZW50cyBpZiBtb2R1bGUgcGFyYW1l
dGVyCj4+PiAndmlydGJsa19xdWV1ZV9kZXB0aCcgaXMgbm90IHNldC4KPj4KPj4gSSB3b25kZXIg
aWYgaXQncyBiZXR0ZXIgdG8gdXNlIHN5c2ZzIGluc3RlYWQgKG9yIHdoZXRoZXIgaXQgaGFzIGFs
cmVhZHkgaGFkIHNvbWV0aGluZyBsaWtlIHRoaXMgaW4gdGhlIGJsb2NrZXIgbGF5ZXIpLgo+Pgo+
IFRoYW5rcyBmb3IgcXVpY2sgcmVzcG9uc2UuCj4gRG8geW91IG1lYW4gYWRqdXN0IC9zeXMvYmxv
Y2svdmRYL3F1ZXVlL25yX3JlcXVlc3RzPwo+IEJ1dCBjdXJyZW50IGxvZ2ljIGluIHZpcnRibGtf
cHJvYmUoKSBpcywgdmlydGJsa19xdWV1ZV9kZXB0aCBpcwo+IHVzZWQgYXMgYSBzYXZlZCB2YWx1
ZSBmb3IgZmlyc3QgcHJvYmVkIHZkZXYsIG5vdCBwdXJlbHkgbW9kdWxlCj4gcGFyYW1ldGVyLgoK
ClJpZ2h0LCBJIHNlZS4gU28gSSB0aGluayB0aGUgcGF0Y2ggaXMgZmluZS4KClRoYW5rcwoKCj4K
PiBUaGFua3MsCj4gSm9zZXBoCj4KCl9fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fClZpcnR1YWxpemF0aW9uIG1haWxpbmcgbGlzdApWaXJ0dWFsaXphdGlvbkBs
aXN0cy5saW51eC1mb3VuZGF0aW9uLm9yZwpodHRwczovL2xpc3RzLmxpbnV4Zm91bmRhdGlvbi5v
cmcvbWFpbG1hbi9saXN0aW5mby92aXJ0dWFsaXphdGlvbg==
