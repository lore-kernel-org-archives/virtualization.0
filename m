Return-Path: <SRS0=sVkE=DB=lists.linux-foundation.org=virtualization-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 35324C4727D
	for <virtualization@archiver.kernel.org>; Thu, 24 Sep 2020 08:28:45 +0000 (UTC)
Received: from hemlock.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id ADF32221EB
	for <virtualization@archiver.kernel.org>; Thu, 24 Sep 2020 08:28:44 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="RivIQyfl"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org ADF32221EB
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=virtualization-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by hemlock.osuosl.org (Postfix) with ESMTP id 4B48E874C2;
	Thu, 24 Sep 2020 08:28:44 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from hemlock.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id hLWCcZYw5cAu; Thu, 24 Sep 2020 08:28:43 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by hemlock.osuosl.org (Postfix) with ESMTP id 9E051874BD;
	Thu, 24 Sep 2020 08:28:43 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 8E9FFC0889;
	Thu, 24 Sep 2020 08:28:43 +0000 (UTC)
Received: from whitealder.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 204A3C0051
 for <virtualization@lists.linux-foundation.org>;
 Thu, 24 Sep 2020 08:28:42 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by whitealder.osuosl.org (Postfix) with ESMTP id 083D185BBA
 for <virtualization@lists.linux-foundation.org>;
 Thu, 24 Sep 2020 08:28:42 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from whitealder.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id yGfnAkEFpSgV
 for <virtualization@lists.linux-foundation.org>;
 Thu, 24 Sep 2020 08:28:40 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [216.205.24.124])
 by whitealder.osuosl.org (Postfix) with ESMTPS id 8DD2585AB3
 for <virtualization@lists.linux-foundation.org>;
 Thu, 24 Sep 2020 08:28:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1600936119;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=JTY1j3OmhHbXJbAzmk77hPlarzC+ZBGY2AfyiVFzjX8=;
 b=RivIQyflKbi3hH1bgSl5S3UoDUuMD7mkTvBjYGTs+zEUFb3k60U+AeE6TJcU1Y19aF3CVu
 0aytNNOeDdxo60coQFoVryyR7zGyeT8yl/SlRba7PybDgCHN6QZC29J/YcVVh9TAbnWcVc
 GOW2s784IdCopmqQLHRNnAqz7XEyBUY=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-263-vMCWz1n0OkGl2bM0e4eECw-1; Thu, 24 Sep 2020 04:28:35 -0400
X-MC-Unique: vMCWz1n0OkGl2bM0e4eECw-1
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com
 [10.5.11.14])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id F3CAE800462;
 Thu, 24 Sep 2020 08:28:33 +0000 (UTC)
Received: from [10.72.13.193] (ovpn-13-193.pek2.redhat.com [10.72.13.193])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 9AC0C5D993;
 Thu, 24 Sep 2020 08:28:19 +0000 (UTC)
Subject: Re: [RFC PATCH 01/24] vhost-vdpa: fix backend feature ioctls
To: "Michael S. Tsirkin" <mst@redhat.com>
References: <20200924032125.18619-1-jasowang@redhat.com>
 <20200924032125.18619-2-jasowang@redhat.com>
 <20200924034940-mutt-send-email-mst@kernel.org>
From: Jason Wang <jasowang@redhat.com>
Message-ID: <bebb65cd-732f-58b5-56f0-55ce61cde61f@redhat.com>
Date: Thu, 24 Sep 2020 16:28:17 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <20200924034940-mutt-send-email-mst@kernel.org>
Content-Language: en-US
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
Cc: lulu@redhat.com, kvm@vger.kernel.org, netdev@vger.kernel.org,
 mhabets@solarflare.com, linux-kernel@vger.kernel.org,
 virtualization@lists.linux-foundation.org, eperezma@redhat.com,
 hanand@xilinx.com, stefanha@redhat.com, eli@mellanox.com,
 maxime.coquelin@redhat.com, lingshan.zhu@intel.com,
 Eli Cohen <elic@nvidia.com>, rob.miller@broadcom.com
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

Ck9uIDIwMjAvOS8yNCDkuIvljYgzOjUwLCBNaWNoYWVsIFMuIFRzaXJraW4gd3JvdGU6Cj4gT24g
VGh1LCBTZXAgMjQsIDIwMjAgYXQgMTE6MjE6MDJBTSArMDgwMCwgSmFzb24gV2FuZyB3cm90ZToK
Pj4gQ29tbWl0IDY1MzA1NWI5YWNkNCAoInZob3N0LXZkcGE6IHN1cHBvcnQgZ2V0L3NldCBiYWNr
ZW5kIGZlYXR1cmVzIikKPj4gaW50cm9kdWNlcyB0d28gbWFsZnVuY3Rpb24gYmFja2VuZCBmZWF0
dXJlcyBpb2N0bHM6Cj4+Cj4+IDEpIHRoZSBpb2N0bHMgd2FzIGJsaW5kbHkgYWRkZWQgdG8gdnJp
bmcgaW9jdGwgaW5zdGVhZCBvZiB2ZHBhIGRldmljZQo+PiAgICAgaW9jdGwKPj4gMikgdmhvc3Rf
c2V0X2JhY2tlbmRfZmVhdHVyZXMoKSB3YXMgY2FsbGVkIHdoZW4gZGV2IG11dGV4IGhhcyBhbHJl
YWR5Cj4+ICAgICBiZWVuIGhlbGQgd2hpY2ggd2lsbCBsZWFkIGEgZGVhZGxvY2sKPj4KPj4gVGhp
cyBwYXRjaCBmaXhlcyB0aGUgYWJvdmUgaXNzdWVzLgo+Pgo+PiBDYzogRWxpIENvaGVuPGVsaWNA
bnZpZGlhLmNvbT4KPj4gUmVwb3J0ZWQtYnk6IFpodSBMaW5nc2hhbjxsaW5nc2hhbi56aHVAaW50
ZWwuY29tPgo+PiBGaXhlczogNjUzMDU1YjlhY2Q0ICgidmhvc3QtdmRwYTogc3VwcG9ydCBnZXQv
c2V0IGJhY2tlbmQgZmVhdHVyZXMiKQo+PiBTaWduZWQtb2ZmLWJ5OiBKYXNvbiBXYW5nPGphc293
YW5nQHJlZGhhdC5jb20+Cj4gRG9uJ3Qgd2Ugd2FudCB0aGUgZml4ZXMgcXVldWVkIHJpZ2h0IG5v
dywgYXMgb3Bwb3NlZCB0byB0aGUgcmVzdCBvZiB0aGUKPiBSRkM/CgoKWWVzLCBhY3R1YWxseSBJ
J3ZlIHBvc3RlZCBpbiBiZWZvcmVbMV0uCgpBZGRpbmcgdGhlIHBhdGNoIGhlcmUgaXMgdG8gc2lt
cGxpZnkgdGhlIHdvcmsgZm9yIHRoZSBndXlzIHRoYXQgd2FudCB0byAKZG8gdGhlIHdvcmsgb24g
dG9wLiBFLmcgZm9yIENpbmR5IHRvIHN0YXJ0IHRoZSBRZW11IHByb3RvdHlwZS4KClRoYW5rcwoK
WzFdIGh0dHBzOi8vd3d3LnNwaW5pY3MubmV0L2xpc3RzL25ldGRldi9tc2c2ODEyNDcuaHRtbAoK
Cl9fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fClZpcnR1YWxp
emF0aW9uIG1haWxpbmcgbGlzdApWaXJ0dWFsaXphdGlvbkBsaXN0cy5saW51eC1mb3VuZGF0aW9u
Lm9yZwpodHRwczovL2xpc3RzLmxpbnV4Zm91bmRhdGlvbi5vcmcvbWFpbG1hbi9saXN0aW5mby92
aXJ0dWFsaXphdGlvbg==
