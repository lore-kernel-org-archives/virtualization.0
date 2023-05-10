Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 342B1C77B7C
	for <virtualization@archiver.kernel.org>; Wed, 10 May 2023 03:19:07 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id AE072415D1;
	Wed, 10 May 2023 03:19:06 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org AE072415D1
Authentication-Results: smtp4.osuosl.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=igel-co-jp.20221208.gappssmtp.com header.i=@igel-co-jp.20221208.gappssmtp.com header.a=rsa-sha256 header.s=20221208 header.b=KvWydDMn
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
	by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id zGTkBIDnqcXB; Wed, 10 May 2023 03:19:05 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp4.osuosl.org (Postfix) with ESMTPS id D4CEE408E7;
	Wed, 10 May 2023 03:19:04 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org D4CEE408E7
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id AE92CC0036;
	Wed, 10 May 2023 03:19:04 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 61F6BC002A
 for <virtualization@lists.linux-foundation.org>;
 Wed, 10 May 2023 03:19:03 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id 3CAA681919
 for <virtualization@lists.linux-foundation.org>;
 Wed, 10 May 2023 03:19:03 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 3CAA681919
Authentication-Results: smtp1.osuosl.org;
 dkim=pass (2048-bit key) header.d=igel-co-jp.20221208.gappssmtp.com
 header.i=@igel-co-jp.20221208.gappssmtp.com header.a=rsa-sha256
 header.s=20221208 header.b=KvWydDMn
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id 4biNfB9WAOra
 for <virtualization@lists.linux-foundation.org>;
 Wed, 10 May 2023 03:19:02 +0000 (UTC)
X-Greylist: whitelisted by SQLgrey-1.8.0
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 88D3881911
Received: from mail-vk1-xa32.google.com (mail-vk1-xa32.google.com
 [IPv6:2607:f8b0:4864:20::a32])
 by smtp1.osuosl.org (Postfix) with ESMTPS id 88D3881911
 for <virtualization@lists.linux-foundation.org>;
 Wed, 10 May 2023 03:19:02 +0000 (UTC)
Received: by mail-vk1-xa32.google.com with SMTP id
 71dfb90a1353d-44ff2f8ec9dso4155896e0c.1
 for <virtualization@lists.linux-foundation.org>;
 Tue, 09 May 2023 20:19:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=igel-co-jp.20221208.gappssmtp.com; s=20221208; t=1683688741; x=1686280741;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=d7gD7+x3M2lMQt2g9rV9OyZXiOG/DE38IBsOisXuZLY=;
 b=KvWydDMnRtJdsKe4qf+mMK78hgIVcJbnCIuEGwuLWD0HDDHLUFJ6ue0n3u1wGl3Sxx
 nniF0EBWidPaRiv0P8NoqkgBX9aV/j42Ph6I/hLd3zRFrkcEqEYpi5Uet4EEO6be2DJ/
 gZlSacl5KDJ8cAVfj/Cg6wJ8sVoh2IPCKYCaM/eb2ER12Zef8HrUr2bEzgA3vCeyS3jz
 JWLIFAX3CVkPt/mA4Kwr02oXSvRpXDBSoHrPW2kjeiNPyea5QiO85jNkQXKV5w4nDjvD
 41J+I/gmQo6bLF2vQz2V6z1dvK8AvDl+AnmmZhzv9c18+ToJuWNS6cduB+zVgBBTWosk
 3iPw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1683688741; x=1686280741;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=d7gD7+x3M2lMQt2g9rV9OyZXiOG/DE38IBsOisXuZLY=;
 b=lX+B2CpFNXimDqdVLID85EHH/eP1yPI84h7GXigmdVA4XV2+EiOIa06KYcjlKtZNoL
 B/3lcdpomd9AAil9pQ/XdaVuNiqrv3T4CjkC4BoP8m5yL2Oo8dF2Yn8PWtUltQxGRxWe
 0dVxV2N/S6SECa0UZsqqHPH1FwQmyxQPlS7G/+uKQyCMMd8E5Sg081F86mxuIPOA8Eki
 ZIroIaSdK/IqWl7qag7JhNsoA1t4fxcStYFwe7RQiTPNXdWfUMrE3HGwh9hbBx4QFkcA
 Ztl3E0Rgq7X+LF3X7ILJeUaQft1v/7ZOOAzbkXuWtiYR8ig3YYIsSnfa7pSgcmLg8VE7
 gilQ==
X-Gm-Message-State: AC+VfDwesbgagiUoItTpnQzUco/GObMAutU1pWLQf8QFYPLbwSp/VA35
 DHYFgV4roeny9GB55vSm8a6ckeFJSG4XK012E+hnxQ==
X-Google-Smtp-Source: ACHHUZ4xa0pjOL/MRK6V5HCQcHf21QDMVpxZto7sJzmA2wwxXLLifwws8q4of4vZWLZHoQcIk1ms5Si1mq4sbgxwlfc=
X-Received: by 2002:a1f:4b83:0:b0:44f:cf0e:dbcf with SMTP id
 y125-20020a1f4b83000000b0044fcf0edbcfmr4739973vka.11.1683688741398; Tue, 09
 May 2023 20:19:01 -0700 (PDT)
MIME-Version: 1.0
References: <20230427104428.862643-1-mie@igel.co.jp>
 <20230427104428.862643-3-mie@igel.co.jp>
 <CACGkMEsOw08UWdNfhVd8q2-SwCt+jwMbeYwYQ+OMN+2RiHBZag@mail.gmail.com>
In-Reply-To: <CACGkMEsOw08UWdNfhVd8q2-SwCt+jwMbeYwYQ+OMN+2RiHBZag@mail.gmail.com>
From: Shunsuke Mie <mie@igel.co.jp>
Date: Wed, 10 May 2023 12:18:50 +0900
Message-ID: <CANXvt5oKCoqzp8PfA7A1aTomEG3ycWNFok0YAMp2xCFgAGBbBw@mail.gmail.com>
Subject: Re: [RFC PATCH v2 2/3] virtio_pci: add a definition of queue flag in
 ISR
To: Jason Wang <jasowang@redhat.com>
Cc: Kishon Vijay Abraham I <kishon@kernel.org>,
 =?UTF-8?Q?Krzysztof_Wilczy=C5=84ski?= <kw@linux.com>,
 Randy Dunlap <rdunlap@infradead.org>, "Michael S. Tsirkin" <mst@redhat.com>,
 linux-pci@vger.kernel.org, Lorenzo Pieralisi <lpieralisi@kernel.org>,
 Manivannan Sadhasivam <mani@kernel.org>, Frank Li <Frank.Li@nxp.com>,
 linux-kernel@vger.kernel.org, virtualization@lists.linux-foundation.org,
 Ren Zhijie <renzhijie2@huawei.com>, Jon Mason <jdmason@kudzu.us>,
 Bjorn Helgaas <bhelgaas@google.com>
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

MjAyM+W5tDXmnIg45pelKOaciCkgMTI6NTkgSmFzb24gV2FuZyA8amFzb3dhbmdAcmVkaGF0LmNv
bT46Cj4KPiBPbiBUaHUsIEFwciAyNywgMjAyMyBhdCA2OjQ04oCvUE0gU2h1bnN1a2UgTWllIDxt
aWVAaWdlbC5jby5qcD4gd3JvdGU6Cj4gPgo+ID4gQWxyZWFkeSBpdCBoYXMgYmVlZCBkZWZpbmVk
IGEgY29uZmlnIGNoYW5nZWQgZmxhZyBvZiBJU1IsIGJ1dCBub3QgdGhlIHF1ZXVlCj4KPiBUeXBv
IHNob3VsZCBiZSAiYmVlbiIuClRoYW5rcyBmb3IgcG9pbnRpbmcgdGhhdCBvdXQuCj4gPiBmbGFn
LiBBZGQgYSBtYWNybyBmb3IgaXQuCj4gPgo+ID4gU2lnbmVkLW9mZi1ieTogU2h1bnN1a2UgTWll
IDxtaWVAaWdlbC5jby5qcD4KPgo+IE90aGVyIHRoYW4gdGhpcywKPgo+IEFja2VkLWJ5OiBKYXNv
biBXYW5nIDxqYXNvd2FuZ0ByZWRoYXQuY29tPgo+Cj4gPiAtLS0KPiA+ICBpbmNsdWRlL3VhcGkv
bGludXgvdmlydGlvX3BjaS5oIHwgMyArKysKPiA+ICAxIGZpbGUgY2hhbmdlZCwgMyBpbnNlcnRp
b25zKCspCj4gPgo+ID4gZGlmZiAtLWdpdCBhL2luY2x1ZGUvdWFwaS9saW51eC92aXJ0aW9fcGNp
LmggYi9pbmNsdWRlL3VhcGkvbGludXgvdmlydGlvX3BjaS5oCj4gPiBpbmRleCBmNzAzYWZjN2Fk
MzEuLmQ0MDViZWEyNzI0MCAxMDA2NDQKPiA+IC0tLSBhL2luY2x1ZGUvdWFwaS9saW51eC92aXJ0
aW9fcGNpLmgKPiA+ICsrKyBiL2luY2x1ZGUvdWFwaS9saW51eC92aXJ0aW9fcGNpLmgKPiA+IEBA
IC05NCw2ICs5NCw5IEBACj4gPgo+ID4gICNlbmRpZiAvKiBWSVJUSU9fUENJX05PX0xFR0FDWSAq
Lwo+ID4KPiA+ICsvKiBCaXRzIGZvciBJU1Igc3RhdHVzIGZpZWxkOm9ubHkgd2hlbiBpZiBNU0kt
WCBpcyBkaXNhYmxlZCAqLwo+ID4gKy8qIFRoZSBiaXQgb2YgdGhlIElTUiB3aGljaCBpbmRpY2F0
ZXMgYSBxdWV1ZSBlbnRyeSB1cGRhdGUuICovCj4gPiArI2RlZmluZSBWSVJUSU9fUENJX0lTUl9R
VUVVRSAgICAgICAgICAgMHgxCj4gPiAgLyogVGhlIGJpdCBvZiB0aGUgSVNSIHdoaWNoIGluZGlj
YXRlcyBhIGRldmljZSBjb25maWd1cmF0aW9uIGNoYW5nZS4gKi8KPiA+ICAjZGVmaW5lIFZJUlRJ
T19QQ0lfSVNSX0NPTkZJRyAgICAgICAgICAweDIKPiA+ICAvKiBWZWN0b3IgdmFsdWUgdXNlZCB0
byBkaXNhYmxlIE1TSSBmb3IgcXVldWUgKi8KPiA+IC0tCj4gPiAyLjI1LjEKPiA+Cj4KX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18KVmlydHVhbGl6YXRpb24g
bWFpbGluZyBsaXN0ClZpcnR1YWxpemF0aW9uQGxpc3RzLmxpbnV4LWZvdW5kYXRpb24ub3JnCmh0
dHBzOi8vbGlzdHMubGludXhmb3VuZGF0aW9uLm9yZy9tYWlsbWFuL2xpc3RpbmZvL3ZpcnR1YWxp
emF0aW9u
