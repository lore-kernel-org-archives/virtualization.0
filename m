Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 231A8C636CC
	for <virtualization@archiver.kernel.org>; Tue,  7 Feb 2023 10:07:02 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 9A78160E5F;
	Tue,  7 Feb 2023 10:07:02 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 9A78160E5F
Authentication-Results: smtp3.osuosl.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=igel-co-jp.20210112.gappssmtp.com header.i=@igel-co-jp.20210112.gappssmtp.com header.a=rsa-sha256 header.s=20210112 header.b=1JIij/0h
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
	by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id qZcSff7PnGI4; Tue,  7 Feb 2023 10:07:01 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp3.osuosl.org (Postfix) with ESMTPS id 2EAEC60E48;
	Tue,  7 Feb 2023 10:07:01 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 2EAEC60E48
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 02FECC0032;
	Tue,  7 Feb 2023 10:07:01 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [IPv6:2605:bc80:3010::137])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 5F926C002B
 for <virtualization@lists.linux-foundation.org>;
 Tue,  7 Feb 2023 10:06:59 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id D630B408D1
 for <virtualization@lists.linux-foundation.org>;
 Tue,  7 Feb 2023 10:06:58 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org D630B408D1
Authentication-Results: smtp4.osuosl.org;
 dkim=pass (2048-bit key) header.d=igel-co-jp.20210112.gappssmtp.com
 header.i=@igel-co-jp.20210112.gappssmtp.com header.a=rsa-sha256
 header.s=20210112 header.b=1JIij/0h
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id hARG_by7iFbW
 for <virtualization@lists.linux-foundation.org>;
 Tue,  7 Feb 2023 10:06:58 +0000 (UTC)
X-Greylist: whitelisted by SQLgrey-1.8.0
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org DAD78408C4
Received: from mail-vk1-xa2a.google.com (mail-vk1-xa2a.google.com
 [IPv6:2607:f8b0:4864:20::a2a])
 by smtp4.osuosl.org (Postfix) with ESMTPS id DAD78408C4
 for <virtualization@lists.linux-foundation.org>;
 Tue,  7 Feb 2023 10:06:57 +0000 (UTC)
Received: by mail-vk1-xa2a.google.com with SMTP id g28so7577156vkd.8
 for <virtualization@lists.linux-foundation.org>;
 Tue, 07 Feb 2023 02:06:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=igel-co-jp.20210112.gappssmtp.com; s=20210112;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=4F1f6fg1Ju5/GylO5RYS7YswcL9SMWGJBP511vx2aSQ=;
 b=1JIij/0h7xx2+KunzO91Jtltqcw85/+ghFfvGffsJIa31FEgF6EaIXYINVuoKpgT9f
 riSir9SbmAb8OywsgmFDu+fJpB5ojW9q6HtsarNuAPmFfaOQyQUYqMWJfKLRwpd8M2rF
 oxMCF2J7lENtJTYbihoG344ew0eTLbW3mJ9fPS0Nih2bSPYhBdqcHvg9FxiSHj3hv4SG
 3y1PXPjEo172NXT2+qRdG2HetNHiW1mof185n80sBka+6BIOeP55ShQau9lctxH9HTyK
 q+6NZNZTpCbR6zHEIewLA+ZJj2uWpRnOxtNMLs7Qa+twPN7czaSQ0alUwg0GecPEewJr
 PEOA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=4F1f6fg1Ju5/GylO5RYS7YswcL9SMWGJBP511vx2aSQ=;
 b=zgZZ4AYxDN/EaXgQGBNkSBvN0YhyGp8otAp593JaZPxLBv3TtubtNyAmdUyx62XExk
 xip3j6xjjazr6JMneHWiVmPpPzlAip59nD+xp1tp8cFfbgm08QYHpHZ0HtgNq84Zj26l
 6UmNNVaR8laoI0D4QQ42jI7qG0fwUjimQZHPKrp3+EELV3alxVzemfMDfklxk5t07PHK
 gAe4KATfXQ49GRlsA3ypuoq2o3RlaLqgRLk3GWYaGjtpt1N2zJN3gwF445fiDryM9exg
 pKAdwLCAUBlWADIR0hA0JCzefi5ZjSPGm9x1caUAm72Dg7GfLjeWDhczJeDKwDpE1/84
 7gXQ==
X-Gm-Message-State: AO0yUKXAbmpARYs4KX1ftqycbBtA8VkXPd989+4YN6vCEZiv1NE3h2Bo
 KgNN2F4OWZvsKiBPZX0/tWlzzVHgjesUEyswlmP2Nw==
X-Google-Smtp-Source: AK7set8Bj8gAcLpasR5AdxjuMr8vbshN3umCqfQFPoYPpz3YZBHK9u2zhhRO+VrNsERB1PuheKvCcZvhgQ1sXD8dq5Y=
X-Received: by 2002:a1f:9d02:0:b0:3dd:f6a9:4b73 with SMTP id
 g2-20020a1f9d02000000b003ddf6a94b73mr323152vke.12.1675764416761; Tue, 07 Feb
 2023 02:06:56 -0800 (PST)
MIME-Version: 1.0
References: <20230203100418.2981144-1-mie@igel.co.jp>
 <20230203100418.2981144-2-mie@igel.co.jp>
 <20230203051445-mutt-send-email-mst@kernel.org>
In-Reply-To: <20230203051445-mutt-send-email-mst@kernel.org>
From: Shunsuke Mie <mie@igel.co.jp>
Date: Tue, 7 Feb 2023 19:06:45 +0900
Message-ID: <CANXvt5ppfpQ5jQy8BAHPdeVc881vqXig=RaNmBoePPYrNkMm-w@mail.gmail.com>
Subject: Re: [RFC PATCH 1/4] virtio_pci: add a definition of queue flag in ISR
To: "Michael S. Tsirkin" <mst@redhat.com>
Cc: Kishon Vijay Abraham I <kishon@kernel.org>,
 =?UTF-8?Q?Krzysztof_Wilczy=C5=84ski?= <kw@linux.com>,
 Takanari Hayama <taki@igel.co.jp>, Manivannan Sadhasivam <mani@kernel.org>,
 linux-pci@vger.kernel.org, Lorenzo Pieralisi <lpieralisi@kernel.org>,
 Frank Li <Frank.Li@nxp.com>, linux-kernel@vger.kernel.org,
 virtualization@lists.linux-foundation.org, Ren Zhijie <renzhijie2@huawei.com>,
 Jon Mason <jdmason@kudzu.us>, Bjorn Helgaas <bhelgaas@google.com>
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

MjAyM+W5tDLmnIgz5pelKOmHkSkgMTk6MTYgTWljaGFlbCBTLiBUc2lya2luIDxtc3RAcmVkaGF0
LmNvbT46Cj4KPiBPbiBGcmksIEZlYiAwMywgMjAyMyBhdCAwNzowNDoxNVBNICswOTAwLCBTaHVu
c3VrZSBNaWUgd3JvdGU6Cj4gPiBBbHJlYWR5IGl0IGhhcyBiZWVkIGRlZmluZWQgYSBjb25maWcg
Y2hhbmdlZCBmbGFnIG9mIElTUiwgYnV0IG5vdCB0aGUgcXVldWUKPiA+IGZsYWcuIEFkZCBhIG1h
Y3JvIGZvciBpdC4KPiA+Cj4gPiBTaWduZWQtb2ZmLWJ5OiBTaHVuc3VrZSBNaWUgPG1pZUBpZ2Vs
LmNvLmpwPgo+ID4gU2lnbmVkLW9mZi1ieTogVGFrYW5hcmkgSGF5YW1hIDx0YWtpQGlnZWwuY28u
anA+Cj4gPiAtLS0KPiA+ICBpbmNsdWRlL3VhcGkvbGludXgvdmlydGlvX3BjaS5oIHwgMiArKwo+
ID4gIDEgZmlsZSBjaGFuZ2VkLCAyIGluc2VydGlvbnMoKykKPiA+Cj4gPiBkaWZmIC0tZ2l0IGEv
aW5jbHVkZS91YXBpL2xpbnV4L3ZpcnRpb19wY2kuaCBiL2luY2x1ZGUvdWFwaS9saW51eC92aXJ0
aW9fcGNpLmgKPiA+IGluZGV4IGY3MDNhZmM3YWQzMS4uZmE4MmFmZDYxNzFhIDEwMDY0NAo+ID4g
LS0tIGEvaW5jbHVkZS91YXBpL2xpbnV4L3ZpcnRpb19wY2kuaAo+ID4gKysrIGIvaW5jbHVkZS91
YXBpL2xpbnV4L3ZpcnRpb19wY2kuaAo+ID4gQEAgLTk0LDYgKzk0LDggQEAKPiA+Cj4gPiAgI2Vu
ZGlmIC8qIFZJUlRJT19QQ0lfTk9fTEVHQUNZICovCj4gPgo+ID4gKy8qIFRocyBiaXQgb2YgdGhl
IElTUiB3aGljaCBpbmRpY2F0ZXMgYSBxdWV1ZSBlbnRyeSB1cGRhdGUgKi8KPgo+IHR5cG8KPiBT
b21ldGhpbmcgdG8gYWRkIGhlcmU6Cj4gICAgICAgICBOb3RlOiBvbmx5IHdoZW4gTVNJLVggaXMg
ZGlzYWJsZWQKSSdsbCBmaXggYm90aCB0aGF0IHdheS4KPgo+Cj4gPiArI2RlZmluZSBWSVJUSU9f
UENJX0lTUl9RVUVVRSAgICAgICAgIDB4MQo+ID4gIC8qIFRoZSBiaXQgb2YgdGhlIElTUiB3aGlj
aCBpbmRpY2F0ZXMgYSBkZXZpY2UgY29uZmlndXJhdGlvbiBjaGFuZ2UuICovCj4gPiAgI2RlZmlu
ZSBWSVJUSU9fUENJX0lTUl9DT05GSUcgICAgICAgICAgICAgICAgMHgyCj4gPiAgLyogVmVjdG9y
IHZhbHVlIHVzZWQgdG8gZGlzYWJsZSBNU0kgZm9yIHF1ZXVlICovCj4gPiAtLQo+ID4gMi4yNS4x
Cj4KQmVzdCwKU2h1bnN1a2UKX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX18KVmlydHVhbGl6YXRpb24gbWFpbGluZyBsaXN0ClZpcnR1YWxpemF0aW9uQGxpc3Rz
LmxpbnV4LWZvdW5kYXRpb24ub3JnCmh0dHBzOi8vbGlzdHMubGludXhmb3VuZGF0aW9uLm9yZy9t
YWlsbWFuL2xpc3RpbmZvL3ZpcnR1YWxpemF0aW9u
