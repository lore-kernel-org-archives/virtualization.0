Return-Path: <SRS0=ofWe=BV=lists.linux-foundation.org=virtualization-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.3 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	NICE_REPLY_A,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9A5FEC433E0
	for <virtualization@archiver.kernel.org>; Tue, 11 Aug 2020 02:55:19 +0000 (UTC)
Received: from whitealder.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 68B0D206DA
	for <virtualization@archiver.kernel.org>; Tue, 11 Aug 2020 02:55:19 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="gZ0Hy7JZ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 68B0D206DA
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=virtualization-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by whitealder.osuosl.org (Postfix) with ESMTP id 4F9C387695;
	Tue, 11 Aug 2020 02:55:19 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from whitealder.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id h0u8ySvJAo-u; Tue, 11 Aug 2020 02:55:18 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by whitealder.osuosl.org (Postfix) with ESMTP id 9ED3C87652;
	Tue, 11 Aug 2020 02:55:18 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 84D76C013C;
	Tue, 11 Aug 2020 02:55:18 +0000 (UTC)
Received: from whitealder.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id C7E64C004D
 for <virtualization@lists.linux-foundation.org>;
 Tue, 11 Aug 2020 02:55:17 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by whitealder.osuosl.org (Postfix) with ESMTP id C1DD987695
 for <virtualization@lists.linux-foundation.org>;
 Tue, 11 Aug 2020 02:55:17 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from whitealder.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id T2Gn21YVllIJ
 for <virtualization@lists.linux-foundation.org>;
 Tue, 11 Aug 2020 02:55:17 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [216.205.24.124])
 by whitealder.osuosl.org (Postfix) with ESMTPS id D3E0987652
 for <virtualization@lists.linux-foundation.org>;
 Tue, 11 Aug 2020 02:55:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1597114515;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=GKhj1Ydo5cuP4e/A9fInsizZom2NntrocIU8lcoSOLg=;
 b=gZ0Hy7JZTWFkeQFYy7PqcM3c+aAnoty5KP+MQvhviNlTvucLREBkkJE4SdhcgpQfks3ntA
 fGJwDufeNZt+Ea2HkdTyK+tWVXFNwdROqugNR6I2E+RfV+KlE1c5/DMEWvsvfYY0r0vcrp
 NHAccw5nQSMUFxJvZDQGN1TgkngvKLk=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-149-kzFg17BzO9CvIh7vxFZT_g-1; Mon, 10 Aug 2020 22:55:11 -0400
X-MC-Unique: kzFg17BzO9CvIh7vxFZT_g-1
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com
 [10.5.11.11])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 721A18005B0;
 Tue, 11 Aug 2020 02:55:10 +0000 (UTC)
Received: from [10.72.13.186] (ovpn-13-186.pek2.redhat.com [10.72.13.186])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 3F6B26F130;
 Tue, 11 Aug 2020 02:55:04 +0000 (UTC)
Subject: Re: [PATCH] vdpa_sim: init iommu lock
To: "Michael S. Tsirkin" <mst@redhat.com>, linux-kernel@vger.kernel.org
References: <20200810124813.1555677-1-mst@redhat.com>
From: Jason Wang <jasowang@redhat.com>
Message-ID: <e96ec466-0852-ffc8-0e26-118cc4118707@redhat.com>
Date: Tue, 11 Aug 2020 10:55:03 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <20200810124813.1555677-1-mst@redhat.com>
Content-Language: en-US
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
Cc: Max Gurtovoy <maxg@mellanox.com>, lkp@lists.01.org,
 virtualization@lists.linux-foundation.org,
 kernel test robot <rong.a.chen@intel.com>
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

Ck9uIDIwMjAvOC8xMCDkuIvljYg4OjQ4LCBNaWNoYWVsIFMuIFRzaXJraW4gd3JvdGU6Cj4gVGhl
IHBhdGNoIGFkZGluZyB0aGUgaW9tbXUgbG9jayBkaWQgbm90IGluaXRpYWxpemUgaXQuCj4gVGhl
IHN0cnVjdCBpcyB6ZXJvLWluaXRpYWxpemVkIHNvIHRoaXMgaXMgbW9zdGx5IGEgcHJvYmxlbQo+
IHdoZW4gdXNpbmcgbG9ja2RlcC4KPgo+IFJlcG9ydGVkLWJ5OiBrZXJuZWwgdGVzdCByb2JvdCA8
cm9uZy5hLmNoZW5AaW50ZWwuY29tPgo+IENjOiBNYXggR3VydG92b3kgPG1heGdAbWVsbGFub3gu
Y29tPgo+IEZpeGVzOiAwZWE5ZWU0MzBlNzQgKCJ2ZHBhc2ltOiBwcm90ZWN0IGNvbmN1cnJlbnQg
YWNjZXNzIHRvIGlvbW11IGlvdGxiIikKPiBTaWduZWQtb2ZmLWJ5OiBNaWNoYWVsIFMuIFRzaXJr
aW4gPG1zdEByZWRoYXQuY29tPgoKCkFja2VkLWJ5OiBKYXNvbiBXYW5nIDxqYXNvd2FuZ0ByZWRo
YXQuY29tPgoKCj4gLS0tCj4gICBkcml2ZXJzL3ZkcGEvdmRwYV9zaW0vdmRwYV9zaW0uYyB8IDEg
Kwo+ICAgMSBmaWxlIGNoYW5nZWQsIDEgaW5zZXJ0aW9uKCspCj4KPiBkaWZmIC0tZ2l0IGEvZHJp
dmVycy92ZHBhL3ZkcGFfc2ltL3ZkcGFfc2ltLmMgYi9kcml2ZXJzL3ZkcGEvdmRwYV9zaW0vdmRw
YV9zaW0uYwo+IGluZGV4IGRmMzIyNGIxMzhlZS4uNjA0ZDlkMjVjYTQ3IDEwMDY0NAo+IC0tLSBh
L2RyaXZlcnMvdmRwYS92ZHBhX3NpbS92ZHBhX3NpbS5jCj4gKysrIGIvZHJpdmVycy92ZHBhL3Zk
cGFfc2ltL3ZkcGFfc2ltLmMKPiBAQCAtMzU4LDYgKzM1OCw3IEBAIHN0YXRpYyBzdHJ1Y3QgdmRw
YXNpbSAqdmRwYXNpbV9jcmVhdGUodm9pZCkKPiAgIAo+ICAgCUlOSVRfV09SSygmdmRwYXNpbS0+
d29yaywgdmRwYXNpbV93b3JrKTsKPiAgIAlzcGluX2xvY2tfaW5pdCgmdmRwYXNpbS0+bG9jayk7
Cj4gKwlzcGluX2xvY2tfaW5pdCgmdmRwYXNpbS0+aW9tbXVfbG9jayk7Cj4gICAKPiAgIAlkZXYg
PSAmdmRwYXNpbS0+dmRwYS5kZXY7Cj4gICAJZGV2LT5jb2hlcmVudF9kbWFfbWFzayA9IERNQV9C
SVRfTUFTSyg2NCk7CgpfX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fXwpWaXJ0dWFsaXphdGlvbiBtYWlsaW5nIGxpc3QKVmlydHVhbGl6YXRpb25AbGlzdHMubGlu
dXgtZm91bmRhdGlvbi5vcmcKaHR0cHM6Ly9saXN0cy5saW51eGZvdW5kYXRpb24ub3JnL21haWxt
YW4vbGlzdGluZm8vdmlydHVhbGl6YXRpb24=
