Return-Path: <SRS0=tWAs=GS=lists.linux-foundation.org=virtualization-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.5 required=3.0 tests=BAYES_00,DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 82487C43381
	for <virtualization@archiver.kernel.org>; Fri, 15 Jan 2021 18:16:14 +0000 (UTC)
Received: from whitealder.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 18C6A23A5A
	for <virtualization@archiver.kernel.org>; Fri, 15 Jan 2021 18:16:13 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 18C6A23A5A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=virtualization-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by whitealder.osuosl.org (Postfix) with ESMTP id A59CF86D2F;
	Fri, 15 Jan 2021 18:16:13 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from whitealder.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id arUzKdaC0Lc2; Fri, 15 Jan 2021 18:16:13 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by whitealder.osuosl.org (Postfix) with ESMTP id 2B1E28690C;
	Fri, 15 Jan 2021 18:16:13 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 0F41DC0893;
	Fri, 15 Jan 2021 18:16:13 +0000 (UTC)
Received: from silver.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by lists.linuxfoundation.org (Postfix) with ESMTP id F2CA1C013A
 for <virtualization@lists.linux-foundation.org>;
 Fri, 15 Jan 2021 18:16:11 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by silver.osuosl.org (Postfix) with ESMTP id EB8692044F
 for <virtualization@lists.linux-foundation.org>;
 Fri, 15 Jan 2021 18:16:11 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from silver.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id plX5hAhIigxV
 for <virtualization@lists.linux-foundation.org>;
 Fri, 15 Jan 2021 18:16:11 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from mail-ua1-f52.google.com (mail-ua1-f52.google.com
 [209.85.222.52])
 by silver.osuosl.org (Postfix) with ESMTPS id 1038420346
 for <virtualization@lists.linux-foundation.org>;
 Fri, 15 Jan 2021 18:16:11 +0000 (UTC)
Received: by mail-ua1-f52.google.com with SMTP id 43so668922uag.12
 for <virtualization@lists.linux-foundation.org>;
 Fri, 15 Jan 2021 10:16:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc:content-transfer-encoding;
 bh=VTlINeSVg0q4ArXqDy2KEmadEKZMV/zMWMhRsiB5z8U=;
 b=aDj1h7aR8vmf5hMcBHemhjEe6KAqV2ftTaIATgd95BLUDf4mmMssHbQYMV1I4w1RK2
 Nf7Rg0ZSZ71P+poNIYZOItUw5vE3L3bDtt6y8zwOA81VsnV/dHGGeu7YBFTnXCKsviPm
 rD0OQU2+QRyRc2JaH0+/HW4hgzQ4zzkZJvzYEJ00cIuRNe1BXoVjsz2Anwn875vz2KFE
 PmOXOaoK68C8ulKfoxw1+2wRndjC+ko3yFv0n9xK81TpsWyLWwdWEBZPVdICor9vIy0H
 TZ6xsN983jhCbGAMzV3EoM2lhMKR4OkalNvMesrxBzu0dmbtxdNdZ1qHR6ZNpW9NIGrZ
 EdVA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc:content-transfer-encoding;
 bh=VTlINeSVg0q4ArXqDy2KEmadEKZMV/zMWMhRsiB5z8U=;
 b=OSVx94VwMZarM7hrqvDaWh2rqg1Sew4q52GbiOtedCc6+joSCPLHHLNxqgaOzlLxib
 oQmylVbg4MtmWiCO8URLeHev2NnKxlGJidgbNBfv9Z4e4tTijU3WvmrhcN0R2k1yTdnR
 015QcOHdM4xnvOP81wlBrfMMuHe5fpPfZUbyfi3zJ8QhU0VGUUUx4QPX5z/fUoNXYR3i
 wqIk1HUJJrBpI+9JN7K5EHR6rgLHqFzHv4zFvEWxLMQ/54CHacXDyURVG+NM/L4lrkCF
 QLIAgQfAImWUOKVfzhqa0rT59BV1LhHZRcgBbwEyfzgp4KrQm4SVGj4ckfzMYVkG+vwl
 BBOA==
X-Gm-Message-State: AOAM532QFpGp5krrX0TKK3IQvvG7StyHFnvONxsUQZ4YGOZj8V9UVhhM
 O7oIvZCn4PGd3DYjAkZuhK7CrkIDhYQ=
X-Google-Smtp-Source: ABdhPJzh4PE87eRXfGaY/55M6+ZH45SEP/SvBsxfFG6pnJuFI+GQCxBu5mP9KPu90ZWXnCPIgO89Kg==
X-Received: by 2002:ab0:43a7:: with SMTP id l36mr10665531ual.106.1610734568370; 
 Fri, 15 Jan 2021 10:16:08 -0800 (PST)
Received: from mail-vk1-f176.google.com (mail-vk1-f176.google.com.
 [209.85.221.176])
 by smtp.gmail.com with ESMTPSA id m18sm1341055vke.4.2021.01.15.10.16.06
 for <virtualization@lists.linux-foundation.org>
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 15 Jan 2021 10:16:06 -0800 (PST)
Received: by mail-vk1-f176.google.com with SMTP id j67so925671vkh.11
 for <virtualization@lists.linux-foundation.org>;
 Fri, 15 Jan 2021 10:16:06 -0800 (PST)
X-Received: by 2002:a1f:2f81:: with SMTP id v123mr11517700vkv.24.1610734565853; 
 Fri, 15 Jan 2021 10:16:05 -0800 (PST)
MIME-Version: 1.0
References: <1610685980-38608-1-git-send-email-wangyunjian@huawei.com>
 <ff01b9da-f2a7-3559-63cc-833f52280ef6@redhat.com>
In-Reply-To: <ff01b9da-f2a7-3559-63cc-833f52280ef6@redhat.com>
From: Willem de Bruijn <willemdebruijn.kernel@gmail.com>
Date: Fri, 15 Jan 2021 13:15:30 -0500
X-Gmail-Original-Message-ID: <CA+FuTSdvhJ9An9F5pZHKzEKx1NWFArY=QE0C1RB2+nOVP6iNyw@mail.gmail.com>
Message-ID: <CA+FuTSdvhJ9An9F5pZHKzEKx1NWFArY=QE0C1RB2+nOVP6iNyw@mail.gmail.com>
Subject: Re: [PATCH net-next v7] vhost_net: avoid tx queue stuck when sendmsg
 fails
To: Jason Wang <jasowang@redhat.com>
Cc: Willem de Bruijn <willemdebruijn.kernel@gmail.com>,
 "Michael S. Tsirkin" <mst@redhat.com>,
 Network Development <netdev@vger.kernel.org>,
 wangyunjian <wangyunjian@huawei.com>,
 "Lilijun \(Jerry\)" <jerry.lilijun@huawei.com>,
 virtualization@lists.linux-foundation.org, xudingke <xudingke@huawei.com>,
 "huangbin \(J\)" <brian.huangbin@huawei.com>,
 chenchanghu <chenchanghu@huawei.com>
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

T24gRnJpLCBKYW4gMTUsIDIwMjEgYXQgMToxMiBBTSBKYXNvbiBXYW5nIDxqYXNvd2FuZ0ByZWRo
YXQuY29tPiB3cm90ZToKPgo+Cj4gT24gMjAyMS8xLzE1IOS4i+WNiDEyOjQ2LCB3YW5neXVuamlh
biB3cm90ZToKPiA+IEZyb206IFl1bmppYW4gV2FuZyA8d2FuZ3l1bmppYW5AaHVhd2VpLmNvbT4K
PiA+Cj4gPiBDdXJyZW50bHkgdGhlIGRyaXZlciBkb2Vzbid0IGRyb3AgYSBwYWNrZXQgd2hpY2gg
Y2FuJ3QgYmUgc2VudCBieSB0dW4KPiA+IChlLmcgYmFkIHBhY2tldCkuIEluIHRoaXMgY2FzZSwg
dGhlIGRyaXZlciB3aWxsIGFsd2F5cyBwcm9jZXNzIHRoZQo+ID4gc2FtZSBwYWNrZXQgbGVhZCB0
byB0aGUgdHggcXVldWUgc3R1Y2suCj4gPgo+ID4gVG8gZml4IHRoaXMgaXNzdWU6Cj4gPiAxLiBp
biB0aGUgY2FzZSBvZiBwZXJzaXN0ZW50IGZhaWx1cmUgKGUuZyBiYWQgcGFja2V0KSwgdGhlIGRy
aXZlcgo+ID4gICAgIGNhbiBza2lwIHRoaXMgZGVzY3JpcHRvciBieSBpZ25vcmluZyB0aGUgZXJy
b3IuCj4gPiAyLiBpbiB0aGUgY2FzZSBvZiB0cmFuc2llbnQgZmFpbHVyZSAoZS5nIC1FTk9CVUZT
LCAtRUFHQUlOIGFuZCAtRU5PTUVNKSwKPiA+ICAgICB0aGUgZHJpdmVyIHNjaGVkdWxlcyB0aGUg
d29ya2VyIHRvIHRyeSBhZ2Fpbi4KPiA+Cj4gPiBTaWduZWQtb2ZmLWJ5OiBZdW5qaWFuIFdhbmcg
PHdhbmd5dW5qaWFuQGh1YXdlaS5jb20+Cj4KPgo+IEFja2VkLWJ5OiBKYXNvbiBXYW5nIDxqYXNv
d2FuZ0ByZWRoYXQuY29tPgoKQWNrZWQtYnk6IFdpbGxlbSBkZSBCcnVpam4gPHdpbGxlbWJAZ29v
Z2xlLmNvbT4KX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18K
VmlydHVhbGl6YXRpb24gbWFpbGluZyBsaXN0ClZpcnR1YWxpemF0aW9uQGxpc3RzLmxpbnV4LWZv
dW5kYXRpb24ub3JnCmh0dHBzOi8vbGlzdHMubGludXhmb3VuZGF0aW9uLm9yZy9tYWlsbWFuL2xp
c3RpbmZvL3ZpcnR1YWxpemF0aW9u
