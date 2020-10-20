Return-Path: <SRS0=FgjU=D3=lists.linux-foundation.org=virtualization-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.1 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 875FCC433DF
	for <virtualization@archiver.kernel.org>; Tue, 20 Oct 2020 02:21:12 +0000 (UTC)
Received: from whitealder.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 064B1222E9
	for <virtualization@archiver.kernel.org>; Tue, 20 Oct 2020 02:21:11 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="C7rFTj6p"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 064B1222E9
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=virtualization-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by whitealder.osuosl.org (Postfix) with ESMTP id 8040D86D03;
	Tue, 20 Oct 2020 02:21:11 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from whitealder.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id C46y-DyKyky5; Tue, 20 Oct 2020 02:21:10 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by whitealder.osuosl.org (Postfix) with ESMTP id D70C286DDB;
	Tue, 20 Oct 2020 02:21:10 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 9751BC088B;
	Tue, 20 Oct 2020 02:21:10 +0000 (UTC)
Received: from hemlock.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 85788C0051
 for <virtualization@lists.linux-foundation.org>;
 Tue, 20 Oct 2020 02:21:08 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by hemlock.osuosl.org (Postfix) with ESMTP id 6BE7B87530
 for <virtualization@lists.linux-foundation.org>;
 Tue, 20 Oct 2020 02:21:08 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from hemlock.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id ythiOtO82uqZ
 for <virtualization@lists.linux-foundation.org>;
 Tue, 20 Oct 2020 02:21:07 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [63.128.21.124])
 by hemlock.osuosl.org (Postfix) with ESMTPS id AF21D8752D
 for <virtualization@lists.linux-foundation.org>;
 Tue, 20 Oct 2020 02:21:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1603160466;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=9KB/p1IEQq67fi4KyjC3h6q8EKC9yidfMW70SNWcv3M=;
 b=C7rFTj6p4aWaGSL04SVofKZxpFjS3bWYSSqv/VR1MpitaSs6Y+sC9M0hzqwTciz8/hJV5I
 Aqn14MFAvrQnUolVm0RkP+HVa52YTYjvCujUHtpCWTibgAv+UkS5gtRSHjbp/dI5BJcVd4
 rVhymiL7vt78dfsAdO5WXifo7cbo7nQ=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-284-8z4LjDqxPpOrre-cUTHNiw-1; Mon, 19 Oct 2020 22:21:02 -0400
X-MC-Unique: 8z4LjDqxPpOrre-cUTHNiw-1
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com
 [10.5.11.13])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 729D9107B47E;
 Tue, 20 Oct 2020 02:21:01 +0000 (UTC)
Received: from [10.72.13.171] (ovpn-13-171.pek2.redhat.com [10.72.13.171])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 948676EF46;
 Tue, 20 Oct 2020 02:20:56 +0000 (UTC)
Subject: Re: [External] Re: [RFC 0/4] Introduce VDUSE - vDPA Device in
 Userspace
To: =?UTF-8?B?6LCi5rC45ZCJ?= <xieyongji@bytedance.com>,
 "Michael S. Tsirkin" <mst@redhat.com>
References: <20201019145623.671-1-xieyongji@bytedance.com>
 <20201019130815-mutt-send-email-mst@kernel.org>
 <CACycT3vzpm_+v-DbqeVRMg8BRny_GoL2JxpbzYC3JYTMKGn_vg@mail.gmail.com>
From: Jason Wang <jasowang@redhat.com>
Message-ID: <192da6ad-2660-896a-bc94-d30fbd38873d@redhat.com>
Date: Tue, 20 Oct 2020 10:20:54 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <CACycT3vzpm_+v-DbqeVRMg8BRny_GoL2JxpbzYC3JYTMKGn_vg@mail.gmail.com>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=jasowang@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Language: en-US
Cc: linux-mm@kvack.org, akpm@linux-foundation.org,
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

Ck9uIDIwMjAvMTAvMjAg5LiK5Y2IMTA6MTgsIOiwouawuOWQiSB3cm90ZToKPgo+Cj4KPiAgICAg
SG93IGRvZXMgdGhpcyBkcml2ZXIgY29tcGFyZSB3aXRoIHZob3N0LXVzZXItYmxrICh3aGljaCBk
b2Vzbid0Cj4gICAgIG5lZWQga2VybmVsIHN1cHBvcnQpPwo+Cj4KPiBXZSB3YW50IHRvIGltcGxl
bWVudCBhIGJsb2NrIGRldmljZSByYXRoZXIgdGhhbiBhIHZpcnRpby1ibGsgCj4gZGF0YXBsYW5l
LiBBbmQgd2l0aCB0aGlzIGRyaXZlcidzIGhlbHAsIHRoZSB2aG9zdC11c2VyLWJsayBwcm9jZXNz
IAo+IGNvdWxkIHByb3ZpZGUgc3RvcmFnZSBzZXJ2aWNlIHRvIGFsbCBBUFBzIGluIHRoZSBob3N0
Lgo+Cj4gVGhhbmtzLAo+IFlvbmdqaQoKCkkgZ3Vlc3MgdGhlIHBvaW50IGlzIHRoYXQsIHdpdGgg
dGhlIGhlbHAgb2YgVkRVU0UsIGJlc2lkZXMgdmhvc3QtdkRQQSAKZm9yIFZNLCB5b3UgY2FuIGhh
dmUgYSBrZXJuZWwgdmlydGlvIGludGVyZmFjZSB0aHJvdWdoIHZpcnRpby12ZHBhIHdoaWNoIApj
YW4gbm90IGJlIGRvbmUgaW4gdmhvc3QtdXNlci1ibGsuCgpUaGFua3MKCl9fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fClZpcnR1YWxpemF0aW9uIG1haWxpbmcg
bGlzdApWaXJ0dWFsaXphdGlvbkBsaXN0cy5saW51eC1mb3VuZGF0aW9uLm9yZwpodHRwczovL2xp
c3RzLmxpbnV4Zm91bmRhdGlvbi5vcmcvbWFpbG1hbi9saXN0aW5mby92aXJ0dWFsaXphdGlvbg==
