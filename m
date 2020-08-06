Return-Path: <SRS0=OwTx=BQ=lists.linux-foundation.org=virtualization-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.3 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	NICE_REPLY_A,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CD6E7C433DF
	for <virtualization@archiver.kernel.org>; Thu,  6 Aug 2020 03:25:28 +0000 (UTC)
Received: from whitealder.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 9CBE420792
	for <virtualization@archiver.kernel.org>; Thu,  6 Aug 2020 03:25:28 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="IsSb7UXt"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9CBE420792
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=virtualization-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by whitealder.osuosl.org (Postfix) with ESMTP id 79432881A3;
	Thu,  6 Aug 2020 03:25:28 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from whitealder.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id 0s8za4ZuqsCb; Thu,  6 Aug 2020 03:25:27 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by whitealder.osuosl.org (Postfix) with ESMTP id E11E38819C;
	Thu,  6 Aug 2020 03:25:27 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id C676AC0051;
	Thu,  6 Aug 2020 03:25:27 +0000 (UTC)
Received: from fraxinus.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by lists.linuxfoundation.org (Postfix) with ESMTP id EF4D7C004C
 for <virtualization@lists.linux-foundation.org>;
 Thu,  6 Aug 2020 03:25:26 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by fraxinus.osuosl.org (Postfix) with ESMTP id DB60A86E56
 for <virtualization@lists.linux-foundation.org>;
 Thu,  6 Aug 2020 03:25:26 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from fraxinus.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id lWlkteFHjdEm
 for <virtualization@lists.linux-foundation.org>;
 Thu,  6 Aug 2020 03:25:26 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from us-smtp-delivery-1.mimecast.com (us-smtp-1.mimecast.com
 [207.211.31.81])
 by fraxinus.osuosl.org (Postfix) with ESMTPS id 1CA8B86E44
 for <virtualization@lists.linux-foundation.org>;
 Thu,  6 Aug 2020 03:25:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1596684324;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=jWjXO7HLm05C7oJyO5GWR+Ll9CJGwirJV/KI2VEIAUU=;
 b=IsSb7UXt12z6axsyzcJGmr/8N5gx0uzJVta2Ynw5wFHKj5r43VZTPXz58VBOqziOp2mAGx
 Y3WU/UQJE/fH4sZdZdLb1YMBE6M5r3tyN9k6KdQJfhzz9YrbIdLyVCTqXndTjSHK1WMM1i
 c4wIlG8PpM6rG2KghQywHH4vDruY+5M=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-195-dPB3X9flMuegRBT0BUE2jw-1; Wed, 05 Aug 2020 23:25:22 -0400
X-MC-Unique: dPB3X9flMuegRBT0BUE2jw-1
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com
 [10.5.11.23])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id AB0BD106B244;
 Thu,  6 Aug 2020 03:25:20 +0000 (UTC)
Received: from [10.72.13.140] (ovpn-13-140.pek2.redhat.com [10.72.13.140])
 by smtp.corp.redhat.com (Postfix) with ESMTP id A824219C71;
 Thu,  6 Aug 2020 03:25:12 +0000 (UTC)
Subject: Re: [PATCH 1/4] vdpa: introduce config op to get valid iova range
To: "Michael S. Tsirkin" <mst@redhat.com>
References: <20200617032947.6371-1-jasowang@redhat.com>
 <20200617032947.6371-2-jasowang@redhat.com>
 <20200805085035-mutt-send-email-mst@kernel.org>
From: Jason Wang <jasowang@redhat.com>
Message-ID: <777d6e78-4271-10e9-4546-329f53962429@redhat.com>
Date: Thu, 6 Aug 2020 11:25:11 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <20200805085035-mutt-send-email-mst@kernel.org>
Content-Language: en-US
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
Cc: shahafs@mellanox.com, lulu@redhat.com, saugatm@xilinx.com,
 mhabets@solarflare.com, vmireyno@marvell.com, linux-kernel@vger.kernel.org,
 gdawar@xilinx.com, virtualization@lists.linux-foundation.org,
 eperezma@redhat.com, hanand@xilinx.com, zhangweining@ruijie.com.cn,
 eli@mellanox.com, lingshan.zhu@intel.com, rob.miller@broadcom.com
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

Ck9uIDIwMjAvOC81IOS4i+WNiDg6NTEsIE1pY2hhZWwgUy4gVHNpcmtpbiB3cm90ZToKPiBPbiBX
ZWQsIEp1biAxNywgMjAyMCBhdCAxMToyOTo0NEFNICswODAwLCBKYXNvbiBXYW5nIHdyb3RlOgo+
PiBUaGlzIHBhdGNoIGludHJvZHVjZSBhIGNvbmZpZyBvcCB0byBnZXQgdmFsaWQgaW92YSByYW5n
ZSBmcm9tIHRoZSB2RFBBCj4+IGRldmljZS4KPj4KPj4gU2lnbmVkLW9mZi1ieTogSmFzb24gV2Fu
ZzxqYXNvd2FuZ0ByZWRoYXQuY29tPgo+PiAtLS0KPj4gICBpbmNsdWRlL2xpbnV4L3ZkcGEuaCB8
IDE0ICsrKysrKysrKysrKysrCj4+ICAgMSBmaWxlIGNoYW5nZWQsIDE0IGluc2VydGlvbnMoKykK
Pj4KPj4gZGlmZiAtLWdpdCBhL2luY2x1ZGUvbGludXgvdmRwYS5oIGIvaW5jbHVkZS9saW51eC92
ZHBhLmgKPj4gaW5kZXggMjM5ZGI3OTQzNTdjLi5iNzYzM2VkMjUwMGMgMTAwNjQ0Cj4+IC0tLSBh
L2luY2x1ZGUvbGludXgvdmRwYS5oCj4+ICsrKyBiL2luY2x1ZGUvbGludXgvdmRwYS5oCj4+IEBA
IC00MSw2ICs0MSwxNiBAQCBzdHJ1Y3QgdmRwYV9kZXZpY2Ugewo+PiAgIAl1bnNpZ25lZCBpbnQg
aW5kZXg7Cj4+ICAgfTsKPj4gICAKPj4gKy8qKgo+PiArICogdkRQQSBJT1ZBIHJhbmdlIC0gdGhl
IElPVkEgcmFuZ2Ugc3VwcG9ydCBieSB0aGUgZGV2aWNlCj4+ICsgKiBAc3RhcnQ6IHN0YXJ0IG9m
IHRoZSBJT1ZBIHJhbmdlCj4+ICsgKiBAZW5kOiBlbmQgb2YgdGhlIElPVkEgcmFuZ2UKPj4gKyAq
Lwo+PiArc3RydWN0IHZkcGFfaW92YV9yYW5nZSB7Cj4+ICsJdTY0IHN0YXJ0Owo+PiArCXU2NCBl
bmQ7Cj4+ICt9Owo+PiArCj4gVGhpcyBpcyBhbWJpZ3VvdXMuIElzIGVuZCBpbiB0aGUgcmFuZ2Ug
b3IganVzdCBiZWhpbmQgaXQ/CgoKSW4gdGhlIHJhbmdlLgoKCj4gSG93IGFib3V0IGZpcnN0L2xh
c3Q/CgoKU3VyZS4KClRoYW5rcwoKCj4KPgo+CgpfX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fXwpWaXJ0dWFsaXphdGlvbiBtYWlsaW5nIGxpc3QKVmlydHVhbGl6
YXRpb25AbGlzdHMubGludXgtZm91bmRhdGlvbi5vcmcKaHR0cHM6Ly9saXN0cy5saW51eGZvdW5k
YXRpb24ub3JnL21haWxtYW4vbGlzdGluZm8vdmlydHVhbGl6YXRpb24=
