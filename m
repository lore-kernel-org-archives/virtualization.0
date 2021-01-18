Return-Path: <SRS0=OmMZ=GV=lists.linux-foundation.org=virtualization-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.2 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2FD88C433E0
	for <virtualization@archiver.kernel.org>; Mon, 18 Jan 2021 05:26:02 +0000 (UTC)
Received: from fraxinus.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B24612231F
	for <virtualization@archiver.kernel.org>; Mon, 18 Jan 2021 05:26:01 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B24612231F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=virtualization-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by fraxinus.osuosl.org (Postfix) with ESMTP id 7701A85A82;
	Mon, 18 Jan 2021 05:26:01 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from fraxinus.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id CIcYH9JefjtV; Mon, 18 Jan 2021 05:25:59 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by fraxinus.osuosl.org (Postfix) with ESMTP id B538185604;
	Mon, 18 Jan 2021 05:25:59 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 904B6C088B;
	Mon, 18 Jan 2021 05:25:59 +0000 (UTC)
Received: from silver.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by lists.linuxfoundation.org (Postfix) with ESMTP id D96F1C013A
 for <virtualization@lists.linux-foundation.org>;
 Mon, 18 Jan 2021 05:25:58 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by silver.osuosl.org (Postfix) with ESMTP id BD44320119
 for <virtualization@lists.linux-foundation.org>;
 Mon, 18 Jan 2021 05:25:58 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from silver.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id Gcq633Khr6Xk
 for <virtualization@lists.linux-foundation.org>;
 Mon, 18 Jan 2021 05:25:57 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [216.205.24.124])
 by silver.osuosl.org (Postfix) with ESMTPS id 22A9420115
 for <virtualization@lists.linux-foundation.org>;
 Mon, 18 Jan 2021 05:25:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1610947555;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=hpA/2lzEvO8o3CZnJ/P9NlQ95nOpAYmzv3dugnKebyQ=;
 b=WOMyVuuPlR9loKxEfyoYjxmqSYGR1FbE03K4hp8m6N23upsnd+UwekUSX1u8wp0kayDgDT
 OZ7aXH38Cs1dt8TnRLMHtVi9Yc99lVFTlJXWW70/ZSWeAtifNu+3WV6HlHMoV05T7ett6O
 hafThQon/6ASIxamCs4tDOUtJfV4aXE=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-589-ANpXt0OaPciHHPNmoIbdLw-1; Mon, 18 Jan 2021 00:25:53 -0500
X-MC-Unique: ANpXt0OaPciHHPNmoIbdLw-1
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com
 [10.5.11.15])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id C710A180A098;
 Mon, 18 Jan 2021 05:25:51 +0000 (UTC)
Received: from [10.72.13.12] (ovpn-13-12.pek2.redhat.com [10.72.13.12])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 1B84C5D72E;
 Mon, 18 Jan 2021 05:25:46 +0000 (UTC)
Subject: Re: [PATCH RFC] virtio-blk: support per-device queue depth
To: Joseph Qi <joseph.qi@linux.alibaba.com>,
 "Michael S. Tsirkin" <mst@redhat.com>
References: <1610942338-78252-1-git-send-email-joseph.qi@linux.alibaba.com>
From: Jason Wang <jasowang@redhat.com>
Message-ID: <ab4cbc06-b629-dd35-52ac-1246d500d1c4@redhat.com>
Date: Mon, 18 Jan 2021 13:25:45 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <1610942338-78252-1-git-send-email-joseph.qi@linux.alibaba.com>
Content-Language: en-US
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
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

Ck9uIDIwMjEvMS8xOCDkuIrljYgxMTo1OCwgSm9zZXBoIFFpIHdyb3RlOgo+IG1vZHVsZSBwYXJh
bWV0ZXIgJ3ZpcnRibGtfcXVldWVfZGVwdGgnIHdhcyBmaXJzdGx5IGludHJvZHVjZWQgZm9yCj4g
dGVzdGluZy9iZW5jaG1hcmtpbmcgcHVycG9zZXMgZGVzY3JpYmVkIGluIGNvbW1pdCBmYzQzMjRi
NDU5N2MKPiAoInZpcnRpby1ibGs6IGJhc2UgcXVldWUtZGVwdGggb24gdmlydHF1ZXVlIHJpbmdz
aXplIG9yIG1vZHVsZSBwYXJhbSIpLgo+IFNpbmNlIHdlIGhhdmUgZGlmZmVyZW50IHZpcnRpby1i
bGsgZGV2aWNlcyB3aGljaCBoYXZlIGRpZmZlcmVudAo+IGNhcGFiaWxpdGllcywgaXQgcmVxdWly
ZXMgdGhhdCB3ZSBzdXBwb3J0IHBlci1kZXZpY2UgcXVldWUgZGVwdGggaW5zdGVhZAo+IG9mIHBl
ci1tb2R1bGUuIFNvIGRlZmF1bHRseSB1c2UgdnEgZnJlZSBlbGVtZW50cyBpZiBtb2R1bGUgcGFy
YW1ldGVyCj4gJ3ZpcnRibGtfcXVldWVfZGVwdGgnIGlzIG5vdCBzZXQuCgoKSSB3b25kZXIgaWYg
aXQncyBiZXR0ZXIgdG8gdXNlIHN5c2ZzIGluc3RlYWQgKG9yIHdoZXRoZXIgaXQgaGFzIGFscmVh
ZHkgCmhhZCBzb21ldGhpbmcgbGlrZSB0aGlzIGluIHRoZSBibG9ja2VyIGxheWVyKS4KClRoYW5r
cwoKCj4KPiBTaWduZWQtb2ZmLWJ5OiBKb3NlcGggUWkgPGpvc2VwaC5xaUBsaW51eC5hbGliYWJh
LmNvbT4KPiAtLS0KPiAgIGRyaXZlcnMvYmxvY2svdmlydGlvX2Jsay5jIHwgMTIgKysrKysrKy0t
LS0tCj4gICAxIGZpbGUgY2hhbmdlZCwgNyBpbnNlcnRpb25zKCspLCA1IGRlbGV0aW9ucygtKQo+
Cj4gZGlmZiAtLWdpdCBhL2RyaXZlcnMvYmxvY2svdmlydGlvX2Jsay5jIGIvZHJpdmVycy9ibG9j
ay92aXJ0aW9fYmxrLmMKPiBpbmRleCAxNDU2MDZkLi5mODNhNDE3IDEwMDY0NAo+IC0tLSBhL2Ry
aXZlcnMvYmxvY2svdmlydGlvX2Jsay5jCj4gKysrIGIvZHJpdmVycy9ibG9jay92aXJ0aW9fYmxr
LmMKPiBAQCAtNzA1LDYgKzcwNSw3IEBAIHN0YXRpYyBpbnQgdmlydGJsa19wcm9iZShzdHJ1Y3Qg
dmlydGlvX2RldmljZSAqdmRldikKPiAgIAl1MzIgdiwgYmxrX3NpemUsIG1heF9zaXplLCBzZ19l
bGVtcywgb3B0X2lvX3NpemU7Cj4gICAJdTE2IG1pbl9pb19zaXplOwo+ICAgCXU4IHBoeXNpY2Fs
X2Jsb2NrX2V4cCwgYWxpZ25tZW50X29mZnNldDsKPiArCXVuc2lnbmVkIGludCBxdWV1ZV9kZXB0
aDsKPiAgIAo+ICAgCWlmICghdmRldi0+Y29uZmlnLT5nZXQpIHsKPiAgIAkJZGV2X2VycigmdmRl
di0+ZGV2LCAiJXMgZmFpbHVyZTogY29uZmlnIGFjY2VzcyBkaXNhYmxlZFxuIiwKPiBAQCAtNzU1
LDE3ICs3NTYsMTggQEAgc3RhdGljIGludCB2aXJ0YmxrX3Byb2JlKHN0cnVjdCB2aXJ0aW9fZGV2
aWNlICp2ZGV2KQo+ICAgCQlnb3RvIG91dF9mcmVlX3ZxOwo+ICAgCX0KPiAgIAo+IC0JLyogRGVm
YXVsdCBxdWV1ZSBzaXppbmcgaXMgdG8gZmlsbCB0aGUgcmluZy4gKi8KPiAtCWlmICghdmlydGJs
a19xdWV1ZV9kZXB0aCkgewo+IC0JCXZpcnRibGtfcXVldWVfZGVwdGggPSB2YmxrLT52cXNbMF0u
dnEtPm51bV9mcmVlOwo+ICsJaWYgKGxpa2VseSghdmlydGJsa19xdWV1ZV9kZXB0aCkpIHsKPiAr
CQlxdWV1ZV9kZXB0aCA9IHZibGstPnZxc1swXS52cS0+bnVtX2ZyZWU7Cj4gICAJCS8qIC4uLiBi
dXQgd2l0aG91dCBpbmRpcmVjdCBkZXNjcywgd2UgdXNlIDIgZGVzY3MgcGVyIHJlcSAqLwo+ICAg
CQlpZiAoIXZpcnRpb19oYXNfZmVhdHVyZSh2ZGV2LCBWSVJUSU9fUklOR19GX0lORElSRUNUX0RF
U0MpKQo+IC0JCQl2aXJ0YmxrX3F1ZXVlX2RlcHRoIC89IDI7Cj4gKwkJCXF1ZXVlX2RlcHRoIC89
IDI7Cj4gKwl9IGVsc2Ugewo+ICsJCXF1ZXVlX2RlcHRoID0gdmlydGJsa19xdWV1ZV9kZXB0aDsK
PiAgIAl9Cj4gICAKPiAgIAltZW1zZXQoJnZibGstPnRhZ19zZXQsIDAsIHNpemVvZih2YmxrLT50
YWdfc2V0KSk7Cj4gICAJdmJsay0+dGFnX3NldC5vcHMgPSAmdmlydGlvX21xX29wczsKPiAtCXZi
bGstPnRhZ19zZXQucXVldWVfZGVwdGggPSB2aXJ0YmxrX3F1ZXVlX2RlcHRoOwo+ICsJdmJsay0+
dGFnX3NldC5xdWV1ZV9kZXB0aCA9IHF1ZXVlX2RlcHRoOwo+ICAgCXZibGstPnRhZ19zZXQubnVt
YV9ub2RlID0gTlVNQV9OT19OT0RFOwo+ICAgCXZibGstPnRhZ19zZXQuZmxhZ3MgPSBCTEtfTVFf
Rl9TSE9VTERfTUVSR0U7Cj4gICAJdmJsay0+dGFnX3NldC5jbWRfc2l6ZSA9CgpfX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fXwpWaXJ0dWFsaXphdGlvbiBtYWls
aW5nIGxpc3QKVmlydHVhbGl6YXRpb25AbGlzdHMubGludXgtZm91bmRhdGlvbi5vcmcKaHR0cHM6
Ly9saXN0cy5saW51eGZvdW5kYXRpb24ub3JnL21haWxtYW4vbGlzdGluZm8vdmlydHVhbGl6YXRp
b24=
