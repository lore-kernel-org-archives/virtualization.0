Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 84787C7EE29
	for <virtualization@archiver.kernel.org>; Sat, 10 Jun 2023 06:51:12 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id E98D260B5C;
	Sat, 10 Jun 2023 06:51:11 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org E98D260B5C
Authentication-Results: smtp3.osuosl.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.a=rsa-sha256 header.s=korg header.b=DLyNaTuB
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
	by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id N5Q_F6u3EnvQ; Sat, 10 Jun 2023 06:51:11 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp3.osuosl.org (Postfix) with ESMTPS id 4F9CA60AFE;
	Sat, 10 Jun 2023 06:51:10 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 4F9CA60AFE
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 0DFCDC007A;
	Sat, 10 Jun 2023 06:51:10 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [IPv6:2605:bc80:3010::138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 18601C0029
 for <virtualization@lists.linux-foundation.org>;
 Sat, 10 Jun 2023 06:51:08 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id ED602842E6
 for <virtualization@lists.linux-foundation.org>;
 Sat, 10 Jun 2023 06:51:07 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org ED602842E6
Authentication-Results: smtp1.osuosl.org;
 dkim=pass (1024-bit key) header.d=linuxfoundation.org
 header.i=@linuxfoundation.org header.a=rsa-sha256 header.s=korg
 header.b=DLyNaTuB
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id AfjHaQaGpXLW
 for <virtualization@lists.linux-foundation.org>;
 Sat, 10 Jun 2023 06:51:05 +0000 (UTC)
X-Greylist: from auto-whitelisted by SQLgrey-1.8.0
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org C39A5842E1
Received: from dfw.source.kernel.org (dfw.source.kernel.org
 [IPv6:2604:1380:4641:c500::1])
 by smtp1.osuosl.org (Postfix) with ESMTPS id C39A5842E1
 for <virtualization@lists.linux-foundation.org>;
 Sat, 10 Jun 2023 06:51:05 +0000 (UTC)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by dfw.source.kernel.org (Postfix) with ESMTPS id A3162639B9;
 Sat, 10 Jun 2023 06:51:04 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 92E12C433D2;
 Sat, 10 Jun 2023 06:51:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
 s=korg; t=1686379864;
 bh=9+jSZur8kKMdp4QWKKR2gLKbPRbyGHjjK9ectU9UX8E=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=DLyNaTuBZQE7+MgYKCoxoCdQRA94X8bROaqvfbkU8gx0+NpwaPibZJk0l5oukkECv
 8shxby16yQICGsI/X9KxsIYpcvuMmRmv7jmH1pproqP6uZLaxRNF6gfzkNeplAAhtY
 PNYR16QU+v/DdQh80N9kmwlgVWWVSsxtRb62w5TA=
Date: Sat, 10 Jun 2023 08:51:02 +0200
From: Greg KH <gregkh@linuxfoundation.org>
To: Xianting Tian <xianting.tian@linux.alibaba.com>
Subject: Re: [PATCH 1/3] virtio-crypto: fixup potential cpu stall when free
 unused bufs
Message-ID: <2023061036-lived-earflap-26ee@gregkh>
References: <20230609131817.712867-1-xianting.tian@linux.alibaba.com>
 <20230609131817.712867-2-xianting.tian@linux.alibaba.com>
 <20230609115617-mutt-send-email-mst@kernel.org>
 <a0a07bfd-6e44-5478-395d-be6c1f3bd92a@linux.alibaba.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <a0a07bfd-6e44-5478-395d-be6c1f3bd92a@linux.alibaba.com>
Cc: xuanzhuo@linux.alibaba.com, herbert@gondor.apana.org.au, arnd@arndb.de,
 "Michael S. Tsirkin" <mst@redhat.com>, amit@kernel.org, marcel@holtmann.org,
 linux-kernel@vger.kernel.org, virtualization@lists.linux-foundation.org,
 linux-bluetooth@vger.kernel.org,
 Xianting Tian <tianxianting.txt@alibaba-inc.com>, linux-crypto@vger.kernel.org,
 luiz.dentz@gmail.com, davem@davemloft.net, johan.hedberg@gmail.com
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
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Errors-To: virtualization-bounces@lists.linux-foundation.org
Sender: "Virtualization" <virtualization-bounces@lists.linux-foundation.org>

T24gU2F0LCBKdW4gMTAsIDIwMjMgYXQgMTE6MjA6NDlBTSArMDgwMCwgWGlhbnRpbmcgVGlhbiB3
cm90ZToKPiAKPiDlnKggMjAyMy82Lzkg5LiL5Y2IMTE6NTcsIE1pY2hhZWwgUy4gVHNpcmtpbiDl
hpnpgZM6Cj4gPiBPbiBGcmksIEp1biAwOSwgMjAyMyBhdCAwOToxODoxNVBNICswODAwLCBYaWFu
dGluZyBUaWFuIHdyb3RlOgo+ID4gPiBGcm9tOiBYaWFudGluZyBUaWFuIDx0aWFueGlhbnRpbmcu
dHh0QGFsaWJhYmEtaW5jLmNvbT4KPiA+ID4gCj4gPiA+IENwdSBzdGFsbCBpc3N1ZSBtYXkgaGFw
cGVuIGlmIGRldmljZSBpcyBjb25maWd1cmVkIHdpdGggbXVsdGkgcXVldWVzCj4gPiA+IGFuZCBs
YXJnZSBxdWV1ZSBkZXB0aCwgc28gZml4IGl0Lgo+ID4gV2hhdCBkb2VzICJtYXkgaGFwcGVuIiBp
bXBseSBleGFjdGx5Pwo+ID4gd2FzIHRoaXMgb2JzZXJ2ZWQ/Cj4gSSBkaWRuJ3QgbWV0IHN1Y2gg
aXNzdWUsIHRoaXMgcGF0Y2ggc2V0IGp1c3QgYSB0aGVvcmV0aWNhbCBmaXguCgpUaGVuIEkgd291
bGQgbm90IHJlY29tbWVuZCBhZGRpbmcgaXQgYXQgdGhpcyB0aW1lLCBhcyB5b3UganVzdCBzbG93
ZWQKZG93biB0aGUga2VybmVsIGZvciBzb21ldGhpbmcgdGhhdCBubyBvbmUgaGFzIHJlcG9ydGVk
IDooCgp0aGFua3MsCgpncmVnIGstaApfX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fXwpWaXJ0dWFsaXphdGlvbiBtYWlsaW5nIGxpc3QKVmlydHVhbGl6YXRpb25A
bGlzdHMubGludXgtZm91bmRhdGlvbi5vcmcKaHR0cHM6Ly9saXN0cy5saW51eGZvdW5kYXRpb24u
b3JnL21haWxtYW4vbGlzdGluZm8vdmlydHVhbGl6YXRpb24=
