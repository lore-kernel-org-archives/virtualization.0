Return-Path: <SRS0=uZMz=MA=lists.linux-foundation.org=virtualization-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 57563C07E9C
	for <virtualization@archiver.kernel.org>; Thu,  8 Jul 2021 12:41:46 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id ECD2E61432
	for <virtualization@archiver.kernel.org>; Thu,  8 Jul 2021 12:41:45 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org ECD2E61432
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=virtualization-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id A427B415A4;
	Thu,  8 Jul 2021 12:41:45 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
	by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id PZkEVPCgmZBv; Thu,  8 Jul 2021 12:41:44 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp4.osuosl.org (Postfix) with ESMTPS id 77F1A41589;
	Thu,  8 Jul 2021 12:41:43 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 3FEA3C001A;
	Thu,  8 Jul 2021 12:41:43 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id C64DAC000E
 for <virtualization@lists.linux-foundation.org>;
 Thu,  8 Jul 2021 12:41:41 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id BACEC83B4C
 for <virtualization@lists.linux-foundation.org>;
 Thu,  8 Jul 2021 12:41:41 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp1.osuosl.org (amavisd-new);
 dkim=pass (2048-bit key) header.d=linaro.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id XDWCEmPMv7Cd
 for <virtualization@lists.linux-foundation.org>;
 Thu,  8 Jul 2021 12:41:40 +0000 (UTC)
X-Greylist: whitelisted by SQLgrey-1.8.0
Received: from mail-vs1-xe36.google.com (mail-vs1-xe36.google.com
 [IPv6:2607:f8b0:4864:20::e36])
 by smtp1.osuosl.org (Postfix) with ESMTPS id A7EAD82531
 for <virtualization@lists.linux-foundation.org>;
 Thu,  8 Jul 2021 12:41:40 +0000 (UTC)
Received: by mail-vs1-xe36.google.com with SMTP id m12so3487660vst.8
 for <virtualization@lists.linux-foundation.org>;
 Thu, 08 Jul 2021 05:41:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc:content-transfer-encoding;
 bh=hP9H7HVTE7TFrRNTl1vyqWVVeZcuqXBCZg0bGqclL/A=;
 b=VetX2Cfr8bdRNaZiWLEm04u6bqZW3l6DI4CAN74JIY7k4z1gUX2WPAhVDnzm350lf2
 zN9Z12JQmbzlk/BWNUXvjVAbpB66ZXuvK3SPb444QQ5diXQOytBY51L2/oTaoUD9VeXU
 uFurAnxdtCpnicZBLB0yD9ojUwv6W/qtm1PvBS9AFUFJNPr3tKxeC4wQWDvFkNeWRoRf
 7SjXn45LyDiaoeLgbbyRwVPp/zZWqO3qYud0+Xn/514eUefuiFS0gjROioJ7tCP2C/ZN
 ZUSLS7lmtDXFsaxdqMahs7f08oqXmzo9A5DfBGmAWg3PByPV9/9CFdzFbNZ8GtPMsFJE
 z42g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc:content-transfer-encoding;
 bh=hP9H7HVTE7TFrRNTl1vyqWVVeZcuqXBCZg0bGqclL/A=;
 b=RZVcpmOzt4TAFnSEhlcfZgDRYdcWs/MqMW/gezP16HPu4bh53KPaTLjN6Fir1DlL3w
 BqSB2nOoMEv9Ck/128CFKIRPsAESEAhNAuHPvqL3u02LQSp21hU7JhB0lMw/ZNRaEtOl
 3Hyo0w34bu0baU5Jx4w+DXrOh0f54vsyLYMgtZdBuDYA5ZG4ih0yehIAcEkoCBa91p0C
 RApPmX0p4/stKfsCdN/Iz0pRS7C/QKShIquasLAh/H8jK7GIQYNZAImy4Mz16OkdoC6Z
 sgBsuGZZV4AQ/O0nwCa1jKEOqXxek1MOmmx+tcJESLtvLdZRTnFPk8G8MfzcPTQp5+xN
 r3nw==
X-Gm-Message-State: AOAM533D7JizfCENkpkVKoXjrM3TJRtGzACLwEBL34Th2Xr/tyRj5hxs
 e7wh439zqNVaSFIzClob0f9uJ0BuWJhSiOD/fxfcBg==
X-Google-Smtp-Source: ABdhPJywz4fR2V+V+6/E9OWxEVi9/b58VFa4IZ2LlJTPpT0B9SRAdSG9PM7u1rPMHG2ZlSabjmUDzfVjnsqdUEe3bFI=
X-Received: by 2002:a67:8783:: with SMTP id j125mr27888650vsd.42.1625748098931; 
 Thu, 08 Jul 2021 05:41:38 -0700 (PDT)
MIME-Version: 1.0
References: <20210706154803.1631813-1-u.kleine-koenig@pengutronix.de>
 <20210706154803.1631813-5-u.kleine-koenig@pengutronix.de>
In-Reply-To: <20210706154803.1631813-5-u.kleine-koenig@pengutronix.de>
From: Ulf Hansson <ulf.hansson@linaro.org>
Date: Thu, 8 Jul 2021 14:41:02 +0200
Message-ID: <CAPDyKFo0zuooWAkuR=BcsvcJ2pmSrcEoBhuC8+ne18GQphyPHA@mail.gmail.com>
Subject: Re: [PATCH v2 4/4] bus: Make remove callback return void
To: =?UTF-8?Q?Uwe_Kleine=2DK=C3=B6nig?= <u.kleine-koenig@pengutronix.de>
Cc: nvdimm@lists.linux.dev, Benjamin Herrenschmidt <benh@kernel.crashing.org>,
 Samuel Iglesias Gonsalvez <siglesias@igalia.com>,
 Jens Taprogge <jens.taprogge@taprogge.org>, Jaroslav Kysela <perex@perex.cz>,
 linux-fpga@vger.kernel.org, Benjamin Tissoires <benjamin.tissoires@redhat.com>,
 Paul Mackerras <paulus@samba.org>,
 Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>,
 Wei Liu <wei.liu@kernel.org>, Maxim Levitsky <maximlevitsky@gmail.com>,
 Samuel Holland <samuel@sholland.org>, Michael Ellerman <mpe@ellerman.id.au>,
 linux-acpi@vger.kernel.org, linux-pci@vger.kernel.org,
 xen-devel@lists.xenproject.org, Tomas Winkler <tomas.winkler@intel.com>,
 Julien Grall <jgrall@amazon.com>, Ohad Ben-Cohen <ohad@wizery.com>,
 Alex Elder <elder@kernel.org>, linux-parisc@vger.kernel.org,
 Geoff Levand <geoff@infradead.org>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>, linux-usb@vger.kernel.org,
 "Rafael J. Wysocki" <rjw@rjwysocki.net>,
 Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
 linux-spi@vger.kernel.org, Thorsten Scherer <t.scherer@eckelmann.de>,
 Sascha Hauer <kernel@pengutronix.de>, Jon Mason <jdmason@kudzu.us>,
 linux-ntb@googlegroups.com, Wu Hao <hao.wu@intel.com>,
 David Woodhouse <dwmw@amazon.co.uk>,
 =?UTF-8?Q?Krzysztof_Wilczy=C5=84ski?= <kw@linux.com>,
 Alexandre Belloni <alexandre.belloni@bootlin.com>,
 Manohar Vanga <manohar.vanga@gmail.com>, linux-wireless@vger.kernel.org,
 Dominik Brodowski <linux@dominikbrodowski.net>,
 virtualization@lists.linux-foundation.org,
 "James E.J. Bottomley" <James.Bottomley@hansenpartnership.com>,
 target-devel@vger.kernel.org,
 Srinivas Kandagatla <srinivas.kandagatla@linaro.org>,
 linux-i2c@vger.kernel.org, Kai-Heng Feng <kai.heng.feng@canonical.com>,
 Stefano Stabellini <sstabellini@kernel.org>,
 Stephen Hemminger <sthemmin@microsoft.com>, Ira Weiny <ira.weiny@intel.com>,
 Helge Deller <deller@gmx.de>,
 =?UTF-8?B?UmFmYcWCIE1pxYJlY2tp?= <zajec5@gmail.com>,
 industrypack-devel@lists.sourceforge.net, linux-mips@vger.kernel.org,
 Len Brown <lenb@kernel.org>, alsa-devel@alsa-project.org,
 linux-arm-msm@vger.kernel.org, linux-media@vger.kernel.org,
 Maxime Ripard <mripard@kernel.org>, Johan Hovold <johan@kernel.org>,
 greybus-dev@lists.linaro.org, Bjorn Helgaas <bhelgaas@google.com>,
 Dave Jiang <dave.jiang@intel.com>,
 Boris Ostrovsky <boris.ostrovsky@oracle.com>,
 Mika Westerberg <mika.westerberg@linux.intel.com>,
 linux-arm-kernel@lists.infradead.org, Johannes Thumshirn <morbidrsa@gmail.com>,
 Mathieu Poirier <mathieu.poirier@linaro.org>, Stephen Boyd <sboyd@kernel.org>,
 Cornelia Huck <cohuck@redhat.com>, Wolfram Sang <wsa@kernel.org>,
 Joey Pabalan <jpabalanb@gmail.com>, Yehezkel Bernat <YehezkelShB@gmail.com>,
 =?UTF-8?Q?Pali_Roh=C3=A1r?= <pali@kernel.org>,
 Bodo Stroesser <bostroesser@gmail.com>,
 Alison Schofield <alison.schofield@intel.com>,
 Heikki Krogerus <heikki.krogerus@linux.intel.com>,
 Tyrel Datwyler <tyreld@linux.ibm.com>,
 Alexander Shishkin <alexander.shishkin@linux.intel.com>,
 Tom Rix <trix@redhat.com>, SeongJae Park <sjpark@amazon.de>,
 linux-hyperv@vger.kernel.org, platform-driver-x86@vger.kernel.org,
 Frank Li <lznuaa@gmail.com>, netdev@vger.kernel.org,
 Qinglang Miao <miaoqinglang@huawei.com>, Jiri Slaby <jirislaby@kernel.org>,
 Rob Herring <robh@kernel.org>, Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
 Mark Gross <mgross@linux.intel.com>, linux-staging@lists.linux.dev,
 Dexuan Cui <decui@microsoft.com>, Jernej Skrabec <jernej.skrabec@gmail.com>,
 Kishon Vijay Abraham I <kishon@ti.com>, Chen-Yu Tsai <wens@csie.org>,
 linux-input@vger.kernel.org, Matt Porter <mporter@kernel.crashing.org>,
 Allen Hubbe <allenbh@gmail.com>, Alex Dubov <oakad@yahoo.com>,
 Haiyang Zhang <haiyangz@microsoft.com>, Jiri Kosina <jikos@kernel.org>,
 Vladimir Zapolskiy <vz@mleia.com>, Russell King <rmk+kernel@armlinux.org.uk>,
 Ben Widawsky <ben.widawsky@intel.com>, Moritz Fischer <mdf@kernel.org>,
 linux-cxl@vger.kernel.org, Michael Buesch <m@bues.ch>,
 Dan Williams <dan.j.williams@intel.com>,
 Mauro Carvalho Chehab <mchehab@kernel.org>,
 Cristian Marussi <cristian.marussi@arm.com>,
 Thomas Bogendoerfer <tsbogend@alpha.franken.de>,
 "Martin K. Petersen" <martin.petersen@oracle.com>,
 Martyn Welch <martyn@welchs.me.uk>,
 Dmitry Torokhov <dmitry.torokhov@gmail.com>, linux-mmc@vger.kernel.org,
 linux-sunxi@lists.linux.dev, Stefan Richter <stefanr@s5r6.in-berlin.de>,
 Sudeep Holla <sudeep.holla@arm.com>, "David S. Miller" <davem@davemloft.net>,
 Sven Van Asbroeck <TheSven73@gmail.com>, kvm@vger.kernel.org,
 "Michael S. Tsirkin" <mst@redhat.com>, linux-remoteproc@vger.kernel.org,
 Bjorn Andersson <bjorn.andersson@linaro.org>,
 Kirti Wankhede <kwankhede@nvidia.com>,
 Andreas Noever <andreas.noever@gmail.com>, linux-i3c@lists.infradead.org,
 linux1394-devel@lists.sourceforge.net, Lee Jones <lee.jones@linaro.org>,
 Arnd Bergmann <arnd@arndb.de>, linux-scsi@vger.kernel.org,
 Vishal Verma <vishal.l.verma@intel.com>, Russell King <linux@armlinux.org.uk>,
 Andy Gross <agross@kernel.org>, linux-serial@vger.kernel.org,
 Jakub Kicinski <kuba@kernel.org>, Michael Jamet <michael.jamet@intel.com>,
 William Breathitt Gray <vilhelm.gray@gmail.com>,
 Hans de Goede <hdegoede@redhat.com>, Adrian Hunter <adrian.hunter@intel.com>,
 Juergen Gross <jgross@suse.com>, linuxppc-dev@lists.ozlabs.org,
 Takashi Iwai <tiwai@suse.com>, Alexandre Bounine <alex.bou9@gmail.com>,
 Vinod Koul <vkoul@kernel.org>, Mark Brown <broonie@kernel.org>,
 Marc Zyngier <maz@kernel.org>, dmaengine@vger.kernel.org,
 Johannes Berg <johannes@sipsolutions.net>, Johannes Thumshirn <jth@kernel.org>,
 Maximilian Luz <luzmaximilian@gmail.com>
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

T24gVHVlLCA2IEp1bCAyMDIxIGF0IDE3OjUzLCBVd2UgS2xlaW5lLUvDtm5pZwo8dS5rbGVpbmUt
a29lbmlnQHBlbmd1dHJvbml4LmRlPiB3cm90ZToKPgo+IFRoZSBkcml2ZXIgY29yZSBpZ25vcmVz
IHRoZSByZXR1cm4gdmFsdWUgb2YgdGhpcyBjYWxsYmFjayBiZWNhdXNlIHRoZXJlCj4gaXMgb25s
eSBsaXR0bGUgaXQgY2FuIGRvIHdoZW4gYSBkZXZpY2UgZGlzYXBwZWFycy4KPgo+IFRoaXMgaXMg
dGhlIGZpbmFsIGJpdCBvZiBhIGxvbmcgbGFzdGluZyBjbGVhbnVwIHF1ZXN0IHdoZXJlIHNldmVy
YWwKPiBidXNlcyB3ZXJlIGNvbnZlcnRlZCB0byBhbHNvIHJldHVybiB2b2lkIGZyb20gdGhlaXIg
cmVtb3ZlIGNhbGxiYWNrLgo+IEFkZGl0aW9uYWxseSBzb21lIHJlc291cmNlIGxlYWtzIHdlcmUg
Zml4ZWQgdGhhdCB3ZXJlIGNhdXNlZCBieSBkcml2ZXJzCj4gcmV0dXJuaW5nIGFuIGVycm9yIGNv
ZGUgaW4gdGhlIGV4cGVjdGF0aW9uIHRoYXQgdGhlIGRyaXZlciB3b24ndCBnbwo+IGF3YXkuCj4K
PiBXaXRoIHN0cnVjdCBidXNfdHlwZTo6cmVtb3ZlIHJldHVybmluZyB2b2lkIGl0J3MgcHJldmVu
dGVkIHRoYXQgbmV3bHkKPiBpbXBsZW1lbnRlZCBidXNlcyByZXR1cm4gYW4gaWdub3JlZCBlcnJv
ciBjb2RlIGFuZCBzbyBkb24ndCBhbnRpY2lwYXRlCj4gd3JvbmcgZXhwZWN0YXRpb25zIGZvciBk
cml2ZXIgYXV0aG9ycy4KPgo+IEFja2VkLWJ5OiBSdXNzZWxsIEtpbmcgKE9yYWNsZSkgPHJtaytr
ZXJuZWxAYXJtbGludXgub3JnLnVrPiAoRm9yIEFSTSwgQW1iYSBhbmQgcmVsYXRlZCBwYXJ0cykK
PiBBY2tlZC1ieTogTWFyayBCcm93biA8YnJvb25pZUBrZXJuZWwub3JnPgo+IEFja2VkLWJ5OiBD
aGVuLVl1IFRzYWkgPHdlbnNAY3NpZS5vcmc+IChmb3IgZHJpdmVycy9idXMvc3VueGktcnNiLmMp
Cj4gQWNrZWQtYnk6IFBhbGkgUm9ow6FyIDxwYWxpQGtlcm5lbC5vcmc+Cj4gQWNrZWQtYnk6IE1h
dXJvIENhcnZhbGhvIENoZWhhYiA8bWNoZWhhYkBrZXJuZWwub3JnPiAoZm9yIGRyaXZlcnMvbWVk
aWEpCj4gQWNrZWQtYnk6IEhhbnMgZGUgR29lZGUgPGhkZWdvZWRlQHJlZGhhdC5jb20+IChGb3Ig
ZHJpdmVycy9wbGF0Zm9ybSkKPiBBY2tlZC1ieTogQWxleGFuZHJlIEJlbGxvbmkgPGFsZXhhbmRy
ZS5iZWxsb25pQGJvb3RsaW4uY29tPgo+IEFja2VkLUJ5OiBWaW5vZCBLb3VsIDx2a291bEBrZXJu
ZWwub3JnPgo+IEFja2VkLWJ5OiBKdWVyZ2VuIEdyb3NzIDxqZ3Jvc3NAc3VzZS5jb20+IChGb3Ig
WGVuKQo+IEFja2VkLWJ5OiBMZWUgSm9uZXMgPGxlZS5qb25lc0BsaW5hcm8ub3JnPiAoRm9yIGRy
aXZlcnMvbWZkKQo+IEFja2VkLWJ5OiBKb2hhbm5lcyBUaHVtc2hpcm4gPGp0aEBrZXJuZWwub3Jn
PiAoRm9yIGRyaXZlcnMvbWNiKQo+IEFja2VkLWJ5OiBKb2hhbiBIb3ZvbGQgPGpvaGFuQGtlcm5l
bC5vcmc+Cj4gQWNrZWQtYnk6IFNyaW5pdmFzIEthbmRhZ2F0bGEgPHNyaW5pdmFzLmthbmRhZ2F0
bGFAbGluYXJvLm9yZz4gKEZvciBkcml2ZXJzL3NsaW1idXMpCj4gQWNrZWQtYnk6IEtpcnRpIFdh
bmtoZWRlIDxrd2Fua2hlZGVAbnZpZGlhLmNvbT4gKEZvciBkcml2ZXJzL3ZmaW8pCj4gQWNrZWQt
Ynk6IE1heGltaWxpYW4gTHV6IDxsdXptYXhpbWlsaWFuQGdtYWlsLmNvbT4KPiBBY2tlZC1ieTog
SGVpa2tpIEtyb2dlcnVzIDxoZWlra2kua3JvZ2VydXNAbGludXguaW50ZWwuY29tPiAoRm9yIHVs
cGkgYW5kIHR5cGVjKQo+IEFja2VkLWJ5OiBTYW11ZWwgSWdsZXNpYXMgR29uc8OhbHZleiA8c2ln
bGVzaWFzQGlnYWxpYS5jb20+IChGb3IgaXBhY2spCj4gUmV2aWV3ZWQtYnk6IFRvbSBSaXggPHRy
aXhAcmVkaGF0LmNvbT4gKEZvciBmcGdhKQo+IEFja2VkLWJ5OiBHZW9mZiBMZXZhbmQgPGdlb2Zm
QGluZnJhZGVhZC5vcmc+IChGb3IgcHMzKQo+IFNpZ25lZC1vZmYtYnk6IFV3ZSBLbGVpbmUtS8O2
bmlnIDx1LmtsZWluZS1rb2VuaWdAcGVuZ3V0cm9uaXguZGU+CgpBY2tlZC1ieTogVWxmIEhhbnNz
b24gPHVsZi5oYW5zc29uQGxpbmFyby5vcmc+ICMgRm9yIE1NQwoKWy4uLl0KCktpbmQgcmVnYXJk
cwpVZmZlCl9fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fClZp
cnR1YWxpemF0aW9uIG1haWxpbmcgbGlzdApWaXJ0dWFsaXphdGlvbkBsaXN0cy5saW51eC1mb3Vu
ZGF0aW9uLm9yZwpodHRwczovL2xpc3RzLmxpbnV4Zm91bmRhdGlvbi5vcmcvbWFpbG1hbi9saXN0
aW5mby92aXJ0dWFsaXphdGlvbg==
