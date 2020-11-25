Return-Path: <SRS0=EQvy=E7=lists.linux-foundation.org=virtualization-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.1 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 21BB4C63777
	for <virtualization@archiver.kernel.org>; Wed, 25 Nov 2020 06:20:37 +0000 (UTC)
Received: from whitealder.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 8786E20DD4
	for <virtualization@archiver.kernel.org>; Wed, 25 Nov 2020 06:20:36 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="YzatGky2"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8786E20DD4
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=virtualization-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by whitealder.osuosl.org (Postfix) with ESMTP id D52E186CF6;
	Wed, 25 Nov 2020 06:20:35 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from whitealder.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id QC3ex+jUdFPo; Wed, 25 Nov 2020 06:20:35 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by whitealder.osuosl.org (Postfix) with ESMTP id 150B786AD7;
	Wed, 25 Nov 2020 06:20:35 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id D8A83C0891;
	Wed, 25 Nov 2020 06:20:34 +0000 (UTC)
Received: from whitealder.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 609E7C0052
 for <virtualization@lists.linux-foundation.org>;
 Wed, 25 Nov 2020 06:20:33 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by whitealder.osuosl.org (Postfix) with ESMTP id 47C5B86CF6
 for <virtualization@lists.linux-foundation.org>;
 Wed, 25 Nov 2020 06:20:33 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from whitealder.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id jwJ6JbapcFRC
 for <virtualization@lists.linux-foundation.org>;
 Wed, 25 Nov 2020 06:20:32 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [63.128.21.124])
 by whitealder.osuosl.org (Postfix) with ESMTPS id 55EFD86AD7
 for <virtualization@lists.linux-foundation.org>;
 Wed, 25 Nov 2020 06:20:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1606285231;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=hzf8L+pJkmJC6kuPctTHWalVfjiH6jJR7fCpq2GAvzk=;
 b=YzatGky2ke/B0rzH2AO2J0oA+G8au5rkCT9xw/h60JFa7fZq6YMDrqVe8i8u0T+tQSbq0w
 OPC7X+u48ls/xF8RlwFKfB9QrkMLSmePyzDGXc1zjBMZ8mdcfFuIhs/5eYSNKJV3waxtq0
 SxVzrf40STxM5l3ZeGwuPSjl5F8EE4g=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-542-s7V2aL5HN0Sj_o7CAHGE0w-1; Wed, 25 Nov 2020 01:20:28 -0500
X-MC-Unique: s7V2aL5HN0Sj_o7CAHGE0w-1
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com
 [10.5.11.14])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id DCB6F8144E5;
 Wed, 25 Nov 2020 06:20:26 +0000 (UTC)
Received: from [10.72.13.165] (ovpn-13-165.pek2.redhat.com [10.72.13.165])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 940005D9C0;
 Wed, 25 Nov 2020 06:20:19 +0000 (UTC)
Subject: Re: netconsole deadlock with virtnet
To: Steven Rostedt <rostedt@goodmis.org>
References: <20201117102341.GR47002@unreal>
 <20201117093325.78f1486d@gandalf.local.home>
 <X7SK9l0oZ+RTivwF@jagdpanzerIV.localdomain>
 <X7SRxB6C+9Bm+r4q@jagdpanzerIV.localdomain>
 <93b42091-66f2-bb92-6822-473167b2698d@redhat.com>
 <20201118091257.2ee6757a@gandalf.local.home> <20201123110855.GD3159@unreal>
 <20201123093128.701cf81b@gandalf.local.home>
 <20201123105252.1c295138@kicinski-fedora-pc1c0hjn.dhcp.thefacebook.com>
 <20201123140934.38748be3@gandalf.local.home>
 <20201123112130.759b9487@kicinski-fedora-pc1c0hjn.dhcp.thefacebook.com>
 <1133f1a4-6772-8aa3-41dd-edbc1ee76cee@redhat.com>
 <20201124093137.48d1e603@gandalf.local.home>
From: Jason Wang <jasowang@redhat.com>
Message-ID: <fb001549-a4d4-b758-03cf-387eaf81e389@redhat.com>
Date: Wed, 25 Nov 2020 14:20:17 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <20201124093137.48d1e603@gandalf.local.home>
Content-Language: en-US
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
Cc: Petr Mladek <pmladek@suse.com>, Leon Romanovsky <leon@kernel.org>,
 John Ogness <john.ogness@linutronix.de>, "Michael S. Tsirkin" <mst@redhat.com>,
 netdev <netdev@vger.kernel.org>, Amit Shah <amit@kernel.org>,
 virtualization@lists.linux-foundation.org,
 Sergey Senozhatsky <sergey.senozhatsky@gmail.com>,
 Ran Rozenstein <ranro@nvidia.com>, Itay Aveksis <itayav@nvidia.com>,
 Jakub Kicinski <kuba@kernel.org>
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

Ck9uIDIwMjAvMTEvMjQg5LiL5Y2IMTA6MzEsIFN0ZXZlbiBSb3N0ZWR0IHdyb3RlOgo+IE9uIFR1
ZSwgMjQgTm92IDIwMjAgMTE6MjI6MDMgKzA4MDAKPiBKYXNvbiBXYW5nIDxqYXNvd2FuZ0ByZWRo
YXQuY29tPiB3cm90ZToKPgo+PiBCdHcsIGhhdmUgYSBxdWljayBzZWFyY2gsIHRoZXJlIGFyZSBz
ZXZlcmFsIG90aGVyIGRyaXZlcnMgdGhhdCB1c2VzIHR4Cj4+IGxvY2sgaW4gdGhlIHR4IE5BUEku
Cj4gdHggTkFQSSBpcyBub3QgdGhlIGlzc3VlLiBUaGUgaXNzdWUgaXMgdGhhdCB3cml0ZV9tc2co
KSAoaW4gbmV0Y29uc29sZS5jKQo+IGNhbGxzIHRoaXMgcG9sbGluZyBsb2dpYyB3aXRoIHRoZSB0
YXJnZXRfbGlzdF9sb2NrIGhlbGQuCgoKQnV0IGluIHRoZSB0eCBOQVBJIHBvbGwgaXQgdHJpZXMg
dG8gbG9jayBUWCBpbnN0ZWFkIG9mIHVzaW5nIHRyeWxvY2suCgoKPgo+IEFyZSB0aG9zZSBvdGhl
ciBkcml2ZXJzIGNhbGxlZCBieSBuZXRjb25zb2xlPyBJZiBub3QsIHRoZW4gdGhpcyBpcyB1bmlx
dWUKPiB0byB2aXJ0aW8tbmV0LgoKCkkgdGhpbmsgdGhlIGFuc3dlciBpcyB5ZXMsIHNpbmNlIG5l
dCBjb25zb2xlIGlzIG5vdCBkaXNhYmxlZCBpbiB0aGUgY29kZXMuCgpUaGFua3MKCgo+Cj4gLS0g
U3RldmUKPgoKX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18K
VmlydHVhbGl6YXRpb24gbWFpbGluZyBsaXN0ClZpcnR1YWxpemF0aW9uQGxpc3RzLmxpbnV4LWZv
dW5kYXRpb24ub3JnCmh0dHBzOi8vbGlzdHMubGludXhmb3VuZGF0aW9uLm9yZy9tYWlsbWFuL2xp
c3RpbmZvL3ZpcnR1YWxpemF0aW9u
