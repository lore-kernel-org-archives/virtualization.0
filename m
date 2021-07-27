Return-Path: <SRS0=8N1b=MT=lists.linux-foundation.org=virtualization-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.0 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A7AB4C432BE
	for <virtualization@archiver.kernel.org>; Tue, 27 Jul 2021 04:23:48 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 3E39360BD3
	for <virtualization@archiver.kernel.org>; Tue, 27 Jul 2021 04:23:48 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org 3E39360BD3
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 08967608AE;
	Tue, 27 Jul 2021 04:23:48 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
	by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id uA8cqty7dIwD; Tue, 27 Jul 2021 04:23:47 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp3.osuosl.org (Postfix) with ESMTPS id 837C4605A1;
	Tue, 27 Jul 2021 04:23:46 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 50842C0010;
	Tue, 27 Jul 2021 04:23:46 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [IPv6:2605:bc80:3010::138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 067D7C000E
 for <virtualization@lists.linux-foundation.org>;
 Tue, 27 Jul 2021 04:23:45 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id E2F9381B99
 for <virtualization@lists.linux-foundation.org>;
 Tue, 27 Jul 2021 04:23:44 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp1.osuosl.org (amavisd-new);
 dkim=pass (2048-bit key) header.d=linaro.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id LG9P9ntWs7bl
 for <virtualization@lists.linux-foundation.org>;
 Tue, 27 Jul 2021 04:23:44 +0000 (UTC)
X-Greylist: whitelisted by SQLgrey-1.8.0
Received: from mail-pl1-x62d.google.com (mail-pl1-x62d.google.com
 [IPv6:2607:f8b0:4864:20::62d])
 by smtp1.osuosl.org (Postfix) with ESMTPS id 4282481A9C
 for <virtualization@lists.linux-foundation.org>;
 Tue, 27 Jul 2021 04:23:44 +0000 (UTC)
Received: by mail-pl1-x62d.google.com with SMTP id e5so12369891pld.6
 for <virtualization@lists.linux-foundation.org>;
 Mon, 26 Jul 2021 21:23:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=date:from:to:cc:subject:message-id:references:mime-version
 :content-disposition:content-transfer-encoding:in-reply-to
 :user-agent; bh=2lFU0EJSr+c97aVBle4VB/B7T7Mb5W4uKZCNWRPuq7Q=;
 b=ZxnWj84Xu1lB0yka22jOJxWl8L8MjqlR5szrFWfFBIRzI5tjDZiWkNuP5s5Q/n+YCn
 d+mPe7dDasojYuuNEwm4JT8rm9fDQfpsvOzpwnjpdbltWtk2MYO5OCgXShCkhjZp5w3Q
 uU+POGsE4WaX/L02jgHmQzlnYmD/iklsLS1rC9vo4gI6Ct2Q0AwlwE6r03qDY+AKh53H
 XLWADZvkvDMHLerwllWgpANE2Cp0UkVyy5S5n58/85aafW53VxUY8pDDej8F//WlJ1TE
 Vyn1Alfar2H2xxCF1L+kNXkwdD8EAFSgk5A4Nzkvw90x4EdIpfOq4OOAZW4YgDNyKMCe
 R5Pg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:content-transfer-encoding
 :in-reply-to:user-agent;
 bh=2lFU0EJSr+c97aVBle4VB/B7T7Mb5W4uKZCNWRPuq7Q=;
 b=Pw9iTVHyeNtuORzk/UrycDgqn82j5sivE4JCGYk6UcKdUtZypTcilOW9B8McybeIKR
 fbhV1rcuPW+0nZ5ik1IZQ65HU1u5o8J6GMZio+5kxcqcMGkEAGXkSTZhklG8Hko6ucpB
 QNarCFqxaR3t0BkEfb3wVuSIzNUjvimxuud6q2+c5lHBhwqpKr8EEcGE9NoZK6MrQuDf
 UXEb+z5IQ1HfktSlwALQOxxKXYF+UZ5M78Gtq2sEhOzuj5ki1eVR+Xu84HEWBC6w/du8
 3L2PQ921fQhTIf6yI3WexQ6NsDB0tapRgEEw245H9ovPLrF48X+64yX7eTYKWwjvR8pa
 vzug==
X-Gm-Message-State: AOAM5309+BZjoGzwdl2R3BYI6nv23kMYPIbBYqYdPUmaGjATojezI3FK
 almC/z9RzMlk8EhoeXD0l1Xdpg==
X-Google-Smtp-Source: ABdhPJxFPX6K1CjkSFimIvFBCnuEo7Olfo38zVA0TCIOJDemhKbb8s/ncbuSD14f++dxEw0RFjmhKQ==
X-Received: by 2002:a17:90a:f198:: with SMTP id
 bv24mr20262309pjb.171.1627359823619; 
 Mon, 26 Jul 2021 21:23:43 -0700 (PDT)
Received: from localhost ([122.172.201.85])
 by smtp.gmail.com with ESMTPSA id h17sm1619223pfh.192.2021.07.26.21.23.42
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 26 Jul 2021 21:23:43 -0700 (PDT)
Date: Tue, 27 Jul 2021 09:53:35 +0530
From: Viresh Kumar <viresh.kumar@linaro.org>
To: Jie Deng <jie.deng@intel.com>
Subject: Re: [PATCH v15] i2c: virtio: add a virtio i2c frontend driver
Message-ID: <20210727042335.lyzhkboh55aaqpy2@vireshk-i7>
References: <bcf2fb9bbe965862213f27e05f87ffc91283c0c5.1627018061.git.jie.deng@intel.com>
 <CAK8P3a1=TpKLGMzvoLafjxtmoBbDL+sBMb8ZiEmTjW91Yr-cYw@mail.gmail.com>
 <a65f32f6-6068-951c-c080-9ae27915b288@intel.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <a65f32f6-6068-951c-c080-9ae27915b288@intel.com>
User-Agent: NeoMutt/20180716-391-311a52
Cc: Vincent Guittot <vincent.guittot@linaro.org>, yu1.wang@intel.com,
 Arnd Bergmann <arnd@arndb.de>, "Michael S. Tsirkin" <mst@redhat.com>,
 gregkh <gregkh@linuxfoundation.org>, jiedeng@alumni.sjtu.edu.cn,
 Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
 "open list:DRM DRIVER FOR QEMU'S CIRRUS DEVICE"
 <virtualization@lists.linux-foundation.org>, Wolfram Sang <wsa@kernel.org>,
 Wolfram Sang <wsa+renesas@sang-engineering.com>,
 Linux I2C <linux-i2c@vger.kernel.org>, Stefan Hajnoczi <stefanha@redhat.com>,
 Andy Shevchenko <andriy.shevchenko@linux.intel.com>, conghui.chen@intel.com
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

T24gMjctMDctMjEsIDEwOjE1LCBKaWUgRGVuZyB3cm90ZToKPiAKPiBPbiAyMDIxLzcvMjMgMTc6
MDMsIEFybmQgQmVyZ21hbm4gd3JvdGU6Cj4gPiBPbiBGcmksIEp1bCAyMywgMjAyMSBhdCA3OjQ0
IEFNIEppZSBEZW5nIDxqaWUuZGVuZ0BpbnRlbC5jb20+IHdyb3RlOgo+ID4gCj4gPiA+ICsKPiA+
ID4gKyAgICAgICByZXQgPSB2aXJ0aW9faTJjX3NldHVwX3Zxcyh2aSk7Cj4gPiA+ICsgICAgICAg
aWYgKHJldCkKPiA+ID4gKyAgICAgICAgICAgICAgIHJldHVybiByZXQ7Cj4gPiA+ICsKPiA+ID4g
KyAgICAgICB2aS0+YWRhcC5vd25lciA9IFRISVNfTU9EVUxFOwo+ID4gPiArICAgICAgIHNucHJp
bnRmKHZpLT5hZGFwLm5hbWUsIHNpemVvZih2aS0+YWRhcC5uYW1lKSwKPiA+ID4gKyAgICAgICAg
ICAgICAgICAiaTJjX3ZpcnRpbyBhdCB2aXJ0aW8gYnVzICVkIiwgdmRldi0+aW5kZXgpOwo+ID4g
PiArICAgICAgIHZpLT5hZGFwLmFsZ28gPSAmdmlydGlvX2FsZ29yaXRobTsKPiA+ID4gKyAgICAg
ICB2aS0+YWRhcC5xdWlya3MgPSAmdmlydGlvX2kyY19xdWlya3M7Cj4gPiA+ICsgICAgICAgdmkt
PmFkYXAuZGV2LnBhcmVudCA9ICZ2ZGV2LT5kZXY7Cj4gPiA+ICsgICAgICAgaTJjX3NldF9hZGFw
ZGF0YSgmdmktPmFkYXAsIHZpKTsKPiA+ID4gKwo+ID4gPiArICAgICAgIC8qCj4gPiA+ICsgICAg
ICAgICogU2V0dXAgQUNQSSBub2RlIGZvciBjb250cm9sbGVkIGRldmljZXMgd2hpY2ggd2lsbCBi
ZSBwcm9iZWQgdGhyb3VnaAo+ID4gPiArICAgICAgICAqIEFDUEkuCj4gPiA+ICsgICAgICAgICov
Cj4gPiA+ICsgICAgICAgQUNQSV9DT01QQU5JT05fU0VUKCZ2aS0+YWRhcC5kZXYsIEFDUElfQ09N
UEFOSU9OKHBkZXYpKTsKPiA+IFNpbmNlIHRoZXJlIGlzIG5vdyBhIGdlbmVyaWMgd2F5IGZvciB2
aXJ0aW8gZHJpdmVycyB0byBsaW5rIHVwIHdpdGggT0YKPiA+IGRldmljZSBub2RlcywgbWF5YmUg
dGhpcyBzaG91bGQgYmUgaGFuZGxlZCB0aGUgc2FtZSB3YXkgaW4gdGhlCj4gPiB2aXJ0aW8gY29y
ZSByYXRoZXIgdGhhbiB0aGUgZHJpdmVyPwo+IAo+IAo+IEknbSBjdXJyZW50bHkgYmFzZWQgb24g
dGhlIEkyQyB0cmVlLiBIYXMgdGhhdCBwYXRjaCBiZWVuIGFscmVhZHkgbWVyZ2VkIO+8nwo+IAo+
IEFueXdheSwgSSB0aGluayB3ZSBjYW4gc2VuZCBhbiBhZGRpdGlvbmFsIHBhdGNoIHRvIHJlbW92
ZSB0aGlzIGxpbmUgb25jZQo+IHRoYXQKPiAKPiAiZ2VuZXJpYyB3YXkiIHBhdGNoIGlzIG1lcmdl
ZC4KCkkgYWdyZWUsIHdlIG5lZWQgdG8gZ2V0IHRoaXMgbWVyZ2VkIGFuZCBkbyBzdHVmZiBvbiB0
b3Agb2YgaXQuIFdlIGFyZQphbHJlYWR5IG9uIHYxNSA6KQoKLS0gCnZpcmVzaApfX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fXwpWaXJ0dWFsaXphdGlvbiBtYWls
aW5nIGxpc3QKVmlydHVhbGl6YXRpb25AbGlzdHMubGludXgtZm91bmRhdGlvbi5vcmcKaHR0cHM6
Ly9saXN0cy5saW51eGZvdW5kYXRpb24ub3JnL21haWxtYW4vbGlzdGluZm8vdmlydHVhbGl6YXRp
b24=
