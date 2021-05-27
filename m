Return-Path: <SRS0=l/A6=KW=lists.linux-foundation.org=virtualization-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.1 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8A173C4708B
	for <virtualization@archiver.kernel.org>; Thu, 27 May 2021 04:09:54 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D0E80613D9
	for <virtualization@archiver.kernel.org>; Thu, 27 May 2021 04:09:53 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D0E80613D9
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=virtualization-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by smtp2.osuosl.org (Postfix) with ESMTP id 865B1400C7;
	Thu, 27 May 2021 04:09:53 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
	by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id fyYrQSFejvTn; Thu, 27 May 2021 04:09:52 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp2.osuosl.org (Postfix) with ESMTP id 94D78401DA;
	Thu, 27 May 2021 04:09:51 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 5BF23C000D;
	Thu, 27 May 2021 04:09:51 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 25076C0001
 for <virtualization@lists.linux-foundation.org>;
 Thu, 27 May 2021 04:09:50 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id F26D282F2D
 for <virtualization@lists.linux-foundation.org>;
 Thu, 27 May 2021 04:09:49 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp1.osuosl.org (amavisd-new);
 dkim=pass (1024-bit key) header.d=redhat.com
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id ambYb5_XH8tf
 for <virtualization@lists.linux-foundation.org>;
 Thu, 27 May 2021 04:09:48 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [216.205.24.124])
 by smtp1.osuosl.org (Postfix) with ESMTPS id DADCF82FA5
 for <virtualization@lists.linux-foundation.org>;
 Thu, 27 May 2021 04:09:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1622088586;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=wBe+WAqe1LvMNei/i+ZstF+sRF4xUcPxxYumZ/kXj0k=;
 b=G8aigClXlS6dBWYViDdHqgjZxjAcyL13pGsqsu4NEvVKhKRsfcqyBHmLkl5HI08CJM5BGT
 KMAggd8JVRWzhQv8ocFaF0j9v+xJK0OYLqmp/skG1XCJKrPWsD6QItDNeWdxMzOIuOsmoJ
 wDLJpIhc3KqxYUGLnuwii1jEk79c3C8=
Received: from mail-pj1-f71.google.com (mail-pj1-f71.google.com
 [209.85.216.71]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-447-Wd4Ao1BoPLmIJtvYoxPcRA-1; Thu, 27 May 2021 00:09:43 -0400
X-MC-Unique: Wd4Ao1BoPLmIJtvYoxPcRA-1
Received: by mail-pj1-f71.google.com with SMTP id
 me1-20020a17090b17c1b029015f8192660bso1653969pjb.7
 for <virtualization@lists.linux-foundation.org>;
 Wed, 26 May 2021 21:09:43 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-transfer-encoding
 :content-language;
 bh=wBe+WAqe1LvMNei/i+ZstF+sRF4xUcPxxYumZ/kXj0k=;
 b=O2ZAAtwYlUCKFxDutDB9p+JAUp6cdFSLS5/ciRY1kcQyol0YbfVdlClbDY2wqScsHC
 p45D+NWBWpFZVVky/cYn+0tKWD/Fe48Pt3jI8jxpMeiw76xn61vE2+YoTSSA9N8R8XLw
 A8IJ0k8HqYUiBaiMN+iZK1arOrgH+Cu6uBpI8By9Zfl4anGTa9tgBg8jgcPkQ/wKRcn6
 /7BljU0ENhWhlFdOLo3fNBHJhYqaKqQ1uYZJTcayX5Lq7k+JLnEh2H5Ubk4J+3jUzngG
 rgf1Im8GWqfX84a8S+mVG5kMlPQdKJMzCaQBeEryLb8E14ZrmCPvDNNabjz1aHnd0cGo
 adVQ==
X-Gm-Message-State: AOAM5311fiSg5FbdVWGxceFTB0GaPrFv2/gKesXn+utGR9IhKse7QNMd
 9i404Vc0IAX2m5ttMOT/FfqT2BBx2SFXNFyBsezNR0m470Q5mDgeY/XzpcNEs6sjxvPaK9epK0q
 1T07gbtFYxiUJJiNb4VSFWdxd9nm5lIIEt/AWCESSa/kkHoZNV3HGKviwqStvELz4ShatNA7OHa
 RwMW1SUbejDNzcjfmG8A==
X-Received: by 2002:a63:5c1:: with SMTP id 184mr1861074pgf.75.1622088582109;
 Wed, 26 May 2021 21:09:42 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJzTAHP0gw/F59OqCLLOcCwr9JK2POhGoj1X/tPOGqlOz0+IIpsFpiVxngu3r0GxYENND8bG8Q==
X-Received: by 2002:a63:5c1:: with SMTP id 184mr1861048pgf.75.1622088581778;
 Wed, 26 May 2021 21:09:41 -0700 (PDT)
Received: from wangxiaodeMacBook-Air.local ([209.132.188.80])
 by smtp.gmail.com with ESMTPSA id 21sm583262pfh.103.2021.05.26.21.09.37
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 26 May 2021 21:09:41 -0700 (PDT)
Subject: Re: [PATCH v3 4/4] virtio_net: disable cb aggressively
To: "Michael S. Tsirkin" <mst@redhat.com>, linux-kernel@vger.kernel.org
References: <20210526082423.47837-1-mst@redhat.com>
 <20210526082423.47837-5-mst@redhat.com>
From: Jason Wang <jasowang@redhat.com>
Message-ID: <93ed586a-d805-2fda-60e7-68eca9e8ac97@redhat.com>
Date: Thu, 27 May 2021 12:09:31 +0800
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:78.0)
 Gecko/20100101 Thunderbird/78.10.2
MIME-Version: 1.0
In-Reply-To: <20210526082423.47837-5-mst@redhat.com>
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=jasowang@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Language: en-US
Cc: Willem de Bruijn <willemb@google.com>, netdev@vger.kernel.org,
 virtualization@lists.linux-foundation.org, Jakub Kicinski <kuba@kernel.org>,
 Wei Wang <weiwan@google.com>, David Miller <davem@davemloft.net>
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
Content-Type: text/plain; charset="gbk"; Format="flowed"
Errors-To: virtualization-bounces@lists.linux-foundation.org
Sender: "Virtualization" <virtualization-bounces@lists.linux-foundation.org>

CtTaIDIwMjEvNS8yNiDPws7nNDoyNCwgTWljaGFlbCBTLiBUc2lya2luINC0tcA6Cj4gVGhlcmUg
YXJlIGN1cnJlbnRseSB0d28gY2FzZXMgd2hlcmUgd2UgcG9sbCBUWCB2cSBub3QgaW4gcmVzcG9u
c2UgdG8gYQo+IGNhbGxiYWNrOiBzdGFydCB4bWl0IGFuZCByeCBuYXBpLiAgV2UgY3VycmVudGx5
IGRvIHRoaXMgd2l0aCBjYWxsYmFja3MKPiBlbmFibGVkIHdoaWNoIGNhbiBjYXVzZSBleHRyYSBp
bnRlcnJ1cHRzIGZyb20gdGhlIGNhcmQuICBVc2VkIG5vdCB0byBiZQo+IGEgYmlnIGlzc3VlIGFz
IHdlIHJ1biB3aXRoIGludGVycnVwdHMgZGlzYWJsZWQgYnV0IHRoYXQgaXMgbm8gbG9uZ2VyIHRo
ZQo+IGNhc2UsIGFuZCBpbiBzb21lIGNhc2VzIHRoZSByYXRlIG9mIHNwdXJpb3VzIGludGVycnVw
dHMgaXMgc28gaGlnaAo+IGxpbnV4IGRldGVjdHMgdGhpcyBhbmQgYWN0dWFsbHkga2lsbHMgdGhl
IGludGVycnVwdC4KPgo+IEZpeCB1cCBieSBkaXNhYmxpbmcgdGhlIGNhbGxiYWNrcyBiZWZvcmUg
cG9sbGluZyB0aGUgdHggdnEuCj4KPiBTaWduZWQtb2ZmLWJ5OiBNaWNoYWVsIFMuIFRzaXJraW4g
PG1zdEByZWRoYXQuY29tPgo+IC0tLQo+ICAgZHJpdmVycy9uZXQvdmlydGlvX25ldC5jIHwgMTYg
KysrKysrKysrKysrLS0tLQo+ICAgMSBmaWxlIGNoYW5nZWQsIDEyIGluc2VydGlvbnMoKyksIDQg
ZGVsZXRpb25zKC0pCj4KPiBkaWZmIC0tZ2l0IGEvZHJpdmVycy9uZXQvdmlydGlvX25ldC5jIGIv
ZHJpdmVycy9uZXQvdmlydGlvX25ldC5jCj4gaW5kZXggYzI5ZjQyZDFlMDRmLi5hODNkYzAzOGQ4
YWYgMTAwNjQ0Cj4gLS0tIGEvZHJpdmVycy9uZXQvdmlydGlvX25ldC5jCj4gKysrIGIvZHJpdmVy
cy9uZXQvdmlydGlvX25ldC5jCj4gQEAgLTE0MzMsNyArMTQzMywxMCBAQCBzdGF0aWMgdm9pZCB2
aXJ0bmV0X3BvbGxfY2xlYW50eChzdHJ1Y3QgcmVjZWl2ZV9xdWV1ZSAqcnEpCj4gICAJCXJldHVy
bjsKPiAgIAo+ICAgCWlmIChfX25ldGlmX3R4X3RyeWxvY2sodHhxKSkgewo+IC0JCWZyZWVfb2xk
X3htaXRfc2ticyhzcSwgdHJ1ZSk7Cj4gKwkJZG8gewo+ICsJCQl2aXJ0cXVldWVfZGlzYWJsZV9j
YihzcS0+dnEpOwo+ICsJCQlmcmVlX29sZF94bWl0X3NrYnMoc3EsIHRydWUpOwo+ICsJCX0gd2hp
bGUgKHVubGlrZWx5KCF2aXJ0cXVldWVfZW5hYmxlX2NiX2RlbGF5ZWQoc3EtPnZxKSkpOwo+ICAg
Cj4gICAJCWlmIChzcS0+dnEtPm51bV9mcmVlID49IDIgKyBNQVhfU0tCX0ZSQUdTKQo+ICAgCQkJ
bmV0aWZfdHhfd2FrZV9xdWV1ZSh0eHEpOwo+IEBAIC0xNjA1LDEyICsxNjA4LDE3IEBAIHN0YXRp
YyBuZXRkZXZfdHhfdCBzdGFydF94bWl0KHN0cnVjdCBza19idWZmICpza2IsIHN0cnVjdCBuZXRf
ZGV2aWNlICpkZXYpCj4gICAJc3RydWN0IG5ldGRldl9xdWV1ZSAqdHhxID0gbmV0ZGV2X2dldF90
eF9xdWV1ZShkZXYsIHFudW0pOwo+ICAgCWJvb2wga2ljayA9ICFuZXRkZXZfeG1pdF9tb3JlKCk7
Cj4gICAJYm9vbCB1c2VfbmFwaSA9IHNxLT5uYXBpLndlaWdodDsKPiArCXVuc2lnbmVkIGludCBi
eXRlcyA9IHNrYi0+bGVuOwo+ICAgCj4gICAJLyogRnJlZSB1cCBhbnkgcGVuZGluZyBvbGQgYnVm
ZmVycyBiZWZvcmUgcXVldWVpbmcgbmV3IG9uZXMuICovCj4gLQlmcmVlX29sZF94bWl0X3NrYnMo
c3EsIGZhbHNlKTsKPiArCWRvIHsKPiArCQlpZiAodXNlX25hcGkpCj4gKwkJCXZpcnRxdWV1ZV9k
aXNhYmxlX2NiKHNxLT52cSk7Cj4gICAKPiAtCWlmICh1c2VfbmFwaSAmJiBraWNrKQo+IC0JCXZp
cnRxdWV1ZV9lbmFibGVfY2JfZGVsYXllZChzcS0+dnEpOwo+ICsJCWZyZWVfb2xkX3htaXRfc2ti
cyhzcSwgZmFsc2UpOwo+ICsKPiArCX0gd2hpbGUgKHVzZV9uYXBpICYmIGtpY2sgJiYKPiArCSAg
ICAgICB1bmxpa2VseSghdmlydHF1ZXVlX2VuYWJsZV9jYl9kZWxheWVkKHNxLT52cSkpKTsKPiAg
IAo+ICAgCS8qIHRpbWVzdGFtcCBwYWNrZXQgaW4gc29mdHdhcmUgKi8KPiAgIAlza2JfdHhfdGlt
ZXN0YW1wKHNrYik7CgoKSSB3b25kZXIgd2hlaHRlciB3ZSBjYW4gc2ltcGxlIGRpc2FibGUgY2Ig
ZHVyaW5nIG5kb19zdGFydF94bWl0KCksIG9yIGlzIAp0aGVyZSBhIHdheSB0byBtYWtlIHhtaXQg
YW5kIG5hcGkgd29yayBpbiBwYXJhbGxlbD8KClRoYW5rcwoKCl9fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fClZpcnR1YWxpemF0aW9uIG1haWxpbmcgbGlzdApW
aXJ0dWFsaXphdGlvbkBsaXN0cy5saW51eC1mb3VuZGF0aW9uLm9yZwpodHRwczovL2xpc3RzLmxp
bnV4Zm91bmRhdGlvbi5vcmcvbWFpbG1hbi9saXN0aW5mby92aXJ0dWFsaXphdGlvbg==
