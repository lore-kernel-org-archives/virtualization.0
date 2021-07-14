Return-Path: <SRS0=HAf6=MG=lists.linux-foundation.org=virtualization-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 224F0C11F66
	for <virtualization@archiver.kernel.org>; Wed, 14 Jul 2021 08:44:24 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B927A613B7
	for <virtualization@archiver.kernel.org>; Wed, 14 Jul 2021 08:44:23 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B927A613B7
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=virtualization-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 733D183BD2;
	Wed, 14 Jul 2021 08:44:23 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
	by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id xkqJOR1J4Tit; Wed, 14 Jul 2021 08:44:22 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp1.osuosl.org (Postfix) with ESMTPS id 24B5C83BB6;
	Wed, 14 Jul 2021 08:44:22 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 07E2AC001A;
	Wed, 14 Jul 2021 08:44:22 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by lists.linuxfoundation.org (Postfix) with ESMTP id BBE44C000E
 for <virtualization@lists.linux-foundation.org>;
 Wed, 14 Jul 2021 08:44:20 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id A525140685
 for <virtualization@lists.linux-foundation.org>;
 Wed, 14 Jul 2021 08:44:20 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id bp-oumazM4-v
 for <virtualization@lists.linux-foundation.org>;
 Wed, 14 Jul 2021 08:44:19 +0000 (UTC)
X-Greylist: whitelisted by SQLgrey-1.8.0
Received: from mail-ua1-f49.google.com (mail-ua1-f49.google.com
 [209.85.222.49])
 by smtp4.osuosl.org (Postfix) with ESMTPS id 509F840600
 for <virtualization@lists.linux-foundation.org>;
 Wed, 14 Jul 2021 08:44:19 +0000 (UTC)
Received: by mail-ua1-f49.google.com with SMTP id e20so341279ual.9
 for <virtualization@lists.linux-foundation.org>;
 Wed, 14 Jul 2021 01:44:19 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc:content-transfer-encoding;
 bh=r5k/nzvm++7I0kjlsxJbLPoLxldn2GkCJzAXrc4Q3tE=;
 b=tM/ZphPlLbaamsCN5p6DUTl5g1zr1kCPR8epZM7sx9lf7792eJNYn4JH0TxuVPF2Kt
 cwE6zXir6dSNe6i1Jd6OtPHIEtyM+q5EICrqLnFXKECOhu69CRC/KKY5sYZ4ViyVnvDc
 EJ9IvUdzP+4CI/f4qYdW6yxgathRjKeSRsmcp5oN6rLoZg4OsYDE+kwkq1ntwO8jx0Ba
 TwKu1NSrzWMYZt56nOODCsxFSw4a/RyDFQgdaFEYG8qX1JmIzf2CDAKQw5doumuy35e8
 /XkZH+EzaRz9GTNZTyk+rWagAGmAatfUGTDYl/C0793BQe9jWgHr3dHTtjVgMLY7B/jA
 jIzg==
X-Gm-Message-State: AOAM532oRMbxo9cfeyKiQzLFu3DLc35VnUkD+SkJuqC4FpfcS88yIZhe
 45h/wTeCKOmEFzHw3hmELK0aBuDXq5X+cT8BJEM=
X-Google-Smtp-Source: ABdhPJw+Y3tnjfY/zI+Y1qOhR0PNRzn2MQD3PHuwf/AzIRJfXjUIjP825Ll9FtnbmVsf04QAqWLG0Tq2dErAW2+m0rM=
X-Received: by 2002:a9f:3f0d:: with SMTP id h13mr12412958uaj.100.1626252258156; 
 Wed, 14 Jul 2021 01:44:18 -0700 (PDT)
MIME-Version: 1.0
References: <20210713193522.1770306-1-u.kleine-koenig@pengutronix.de>
 <20210713193522.1770306-6-u.kleine-koenig@pengutronix.de>
In-Reply-To: <20210713193522.1770306-6-u.kleine-koenig@pengutronix.de>
From: Geert Uytterhoeven <geert@linux-m68k.org>
Date: Wed, 14 Jul 2021 10:44:06 +0200
Message-ID: <CAMuHMdW8r6u4O5zv2ee-3=jPP6qwnOSHdSzf8pPE_y=jY3Bn5A@mail.gmail.com>
Subject: Re: [PATCH v4 5/5] bus: Make remove callback return void
To: =?UTF-8?Q?Uwe_Kleine=2DK=C3=B6nig?= <u.kleine-koenig@pengutronix.de>
Cc: nvdimm@lists.linux.dev, linux-sh@vger.kernel.org,
 Benjamin Herrenschmidt <benh@kernel.crashing.org>,
 Samuel Iglesias Gonsalvez <siglesias@igalia.com>,
 Jens Taprogge <jens.taprogge@taprogge.org>, Jaroslav Kysela <perex@perex.cz>,
 linux-fpga@vger.kernel.org, Benjamin Tissoires <benjamin.tissoires@redhat.com>,
 Paul Mackerras <paulus@samba.org>,
 Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>,
 Wei Liu <wei.liu@kernel.org>, Maxim Levitsky <maximlevitsky@gmail.com>,
 Samuel Holland <samuel@sholland.org>, Michael Ellerman <mpe@ellerman.id.au>,
 "Rafael J . Wysocki" <rafael@kernel.org>, linux-acpi@vger.kernel.org,
 linux-pci@vger.kernel.org, xen-devel@lists.xenproject.org,
 Tomas Winkler <tomas.winkler@intel.com>, Julien Grall <jgrall@amazon.com>,
 Ohad Ben-Cohen <ohad@wizery.com>, Yufen Yu <yuyufen@huawei.com>,
 Alex Elder <elder@kernel.org>, linux-parisc@vger.kernel.org,
 Finn Thain <fthain@linux-m68k.org>, Geoff Levand <geoff@infradead.org>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>, linux-usb@vger.kernel.org,
 "Rafael J. Wysocki" <rjw@rjwysocki.net>, linux-kernel@vger.kernel.org,
 linux-spi@vger.kernel.org, Kai-Heng Feng <kai.heng.feng@canonical.com>,
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
 linux-i2c@vger.kernel.org, linux-s390@vger.kernel.org,
 Stefano Stabellini <sstabellini@kernel.org>,
 Stephen Hemminger <sthemmin@microsoft.com>,
 Yoshinori Sato <ysato@users.sourceforge.jp>, Jiri Slaby <jirislaby@kernel.org>,
 Helge Deller <deller@gmx.de>,
 =?UTF-8?B?UmFmYcWCIE1pxYJlY2tp?= <zajec5@gmail.com>,
 YueHaibing <yuehaibing@huawei.com>, industrypack-devel@lists.sourceforge.net,
 linux-mips@vger.kernel.org, Len Brown <lenb@kernel.org>,
 Vasily Gorbik <gor@linux.ibm.com>, linux-arm-msm@vger.kernel.org,
 linux-media@vger.kernel.org, Maxime Ripard <mripard@kernel.org>,
 William Breathitt Gray <vilhelm.gray@gmail.com>, greybus-dev@lists.linaro.org,
 linux-m68k@lists.linux-m68k.org, Florian Fainelli <f.fainelli@gmail.com>,
 Rikard Falkeborn <rikard.falkeborn@gmail.com>, Frank Li <lznuaa@gmail.com>,
 Mark Gross <mgross@linux.intel.com>,
 Boris Ostrovsky <boris.ostrovsky@oracle.com>,
 Mika Westerberg <mika.westerberg@linux.intel.com>,
 linux-arm-kernel@lists.infradead.org, Johannes Thumshirn <morbidrsa@gmail.com>,
 Mathieu Poirier <mathieu.poirier@linaro.org>, Stephen Boyd <sboyd@kernel.org>,
 Cornelia Huck <cohuck@redhat.com>, Peter Oberparleiter <oberpar@linux.ibm.com>,
 Wolfram Sang <wsa@kernel.org>, Joey Pabalan <jpabalanb@gmail.com>,
 Yehezkel Bernat <YehezkelShB@gmail.com>,
 =?UTF-8?Q?Pali_Roh=C3=A1r?= <pali@kernel.org>,
 Bodo Stroesser <bostroesser@gmail.com>,
 Alison Schofield <alison.schofield@intel.com>,
 Heikki Krogerus <heikki.krogerus@linux.intel.com>,
 Tyrel Datwyler <tyreld@linux.ibm.com>,
 Alexander Shishkin <alexander.shishkin@linux.intel.com>,
 Tom Rix <trix@redhat.com>, SeongJae Park <sjpark@amazon.de>,
 alsa-devel@alsa-project.org, platform-driver-x86@vger.kernel.org,
 Bjorn Helgaas <bhelgaas@google.com>, netdev@vger.kernel.org,
 Vineeth Vijayan <vneethv@linux.ibm.com>, Ira Weiny <ira.weiny@intel.com>,
 Rob Herring <robh@kernel.org>, Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
 Dave Jiang <dave.jiang@intel.com>, linux-staging@lists.linux.dev,
 Dexuan Cui <decui@microsoft.com>, Jernej Skrabec <jernej.skrabec@gmail.com>,
 Kishon Vijay Abraham I <kishon@ti.com>,
 Christian Borntraeger <borntraeger@de.ibm.com>, Chen-Yu Tsai <wens@csie.org>,
 linux-input@vger.kernel.org, Matt Porter <mporter@kernel.crashing.org>,
 Allen Hubbe <allenbh@gmail.com>, Alex Dubov <oakad@yahoo.com>,
 Haiyang Zhang <haiyangz@microsoft.com>, Jiri Kosina <jikos@kernel.org>,
 "Russell King \(Oracle\)" <rmk+kernel@armlinux.org.uk>,
 Ben Widawsky <ben.widawsky@intel.com>,
 Harald Freudenberger <freude@linux.ibm.com>, linux-cxl@vger.kernel.org,
 Michael Buesch <m@bues.ch>, Dan Williams <dan.j.williams@intel.com>,
 Mauro Carvalho Chehab <mchehab@kernel.org>,
 Cristian Marussi <cristian.marussi@arm.com>,
 Thomas Bogendoerfer <tsbogend@alpha.franken.de>,
 "Martin K. Petersen" <martin.petersen@oracle.com>,
 Martyn Welch <martyn@welchs.me.uk>,
 Dmitry Torokhov <dmitry.torokhov@gmail.com>, linux-mmc@vger.kernel.org,
 linux-sunxi@lists.linux.dev, Stefan Richter <stefanr@s5r6.in-berlin.de>,
 Sudeep Holla <sudeep.holla@arm.com>, "David S. Miller" <davem@davemloft.net>,
 Sven Van Asbroeck <TheSven73@gmail.com>, Rich Felker <dalias@libc.org>,
 kvm@vger.kernel.org, "Michael S. Tsirkin" <mst@redhat.com>,
 linux-remoteproc@vger.kernel.org, Bjorn Andersson <bjorn.andersson@linaro.org>,
 sparclinux@vger.kernel.org, Kirti Wankhede <kwankhede@nvidia.com>,
 Andreas Noever <andreas.noever@gmail.com>, linux-i3c@lists.infradead.org,
 linux1394-devel@lists.sourceforge.net, Lee Jones <lee.jones@linaro.org>,
 Arnd Bergmann <arnd@arndb.de>, linux-scsi@vger.kernel.org,
 Marc Zyngier <maz@kernel.org>, Russell King <linux@armlinux.org.uk>,
 Thorsten Scherer <t.scherer@eckelmann.de>, Andy Gross <agross@kernel.org>,
 linux-serial@vger.kernel.org, Jakub Kicinski <kuba@kernel.org>,
 linux-hyperv@vger.kernel.org, Michael Jamet <michael.jamet@intel.com>,
 Heiko Carstens <hca@linux.ibm.com>, Johan Hovold <johan@kernel.org>,
 Hans de Goede <hdegoede@redhat.com>, Juergen Gross <jgross@suse.com>,
 linuxppc-dev@lists.ozlabs.org, Takashi Iwai <tiwai@suse.com>,
 Alexandre Bounine <alex.bou9@gmail.com>, Vinod Koul <vkoul@kernel.org>,
 Mark Brown <broonie@kernel.org>, Vishal Verma <vishal.l.verma@intel.com>,
 dmaengine@vger.kernel.org, Moritz Fischer <mdf@kernel.org>,
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

T24gVHVlLCBKdWwgMTMsIDIwMjEgYXQgOTozNSBQTSBVd2UgS2xlaW5lLUvDtm5pZwo8dS5rbGVp
bmUta29lbmlnQHBlbmd1dHJvbml4LmRlPiB3cm90ZToKPiBUaGUgZHJpdmVyIGNvcmUgaWdub3Jl
cyB0aGUgcmV0dXJuIHZhbHVlIG9mIHRoaXMgY2FsbGJhY2sgYmVjYXVzZSB0aGVyZQo+IGlzIG9u
bHkgbGl0dGxlIGl0IGNhbiBkbyB3aGVuIGEgZGV2aWNlIGRpc2FwcGVhcnMuCj4KPiBUaGlzIGlz
IHRoZSBmaW5hbCBiaXQgb2YgYSBsb25nIGxhc3RpbmcgY2xlYW51cCBxdWVzdCB3aGVyZSBzZXZl
cmFsCj4gYnVzZXMgd2VyZSBjb252ZXJ0ZWQgdG8gYWxzbyByZXR1cm4gdm9pZCBmcm9tIHRoZWly
IHJlbW92ZSBjYWxsYmFjay4KPiBBZGRpdGlvbmFsbHkgc29tZSByZXNvdXJjZSBsZWFrcyB3ZXJl
IGZpeGVkIHRoYXQgd2VyZSBjYXVzZWQgYnkgZHJpdmVycwo+IHJldHVybmluZyBhbiBlcnJvciBj
b2RlIGluIHRoZSBleHBlY3RhdGlvbiB0aGF0IHRoZSBkcml2ZXIgd29uJ3QgZ28KPiBhd2F5Lgo+
Cj4gV2l0aCBzdHJ1Y3QgYnVzX3R5cGU6OnJlbW92ZSByZXR1cm5pbmcgdm9pZCBpdCdzIHByZXZl
bnRlZCB0aGF0IG5ld2x5Cj4gaW1wbGVtZW50ZWQgYnVzZXMgcmV0dXJuIGFuIGlnbm9yZWQgZXJy
b3IgY29kZSBhbmQgc28gZG9uJ3QgYW50aWNpcGF0ZQo+IHdyb25nIGV4cGVjdGF0aW9ucyBmb3Ig
ZHJpdmVyIGF1dGhvcnMuCgo+ICBkcml2ZXJzL3pvcnJvL3pvcnJvLWRyaXZlci5jICAgICAgICAg
ICAgICB8IDMgKy0tCgpBY2tlZC1ieTogR2VlcnQgVXl0dGVyaG9ldmVuIDxnZWVydEBsaW51eC1t
NjhrLm9yZz4KCkdye29ldGplLGVldGluZ31zLAoKICAgICAgICAgICAgICAgICAgICAgICAgR2Vl
cnQKCi0tIApHZWVydCBVeXR0ZXJob2V2ZW4gLS0gVGhlcmUncyBsb3RzIG9mIExpbnV4IGJleW9u
ZCBpYTMyIC0tIGdlZXJ0QGxpbnV4LW02OGsub3JnCgpJbiBwZXJzb25hbCBjb252ZXJzYXRpb25z
IHdpdGggdGVjaG5pY2FsIHBlb3BsZSwgSSBjYWxsIG15c2VsZiBhIGhhY2tlci4gQnV0CndoZW4g
SSdtIHRhbGtpbmcgdG8gam91cm5hbGlzdHMgSSBqdXN0IHNheSAicHJvZ3JhbW1lciIgb3Igc29t
ZXRoaW5nIGxpa2UgdGhhdC4KICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAtLSBMaW51
cyBUb3J2YWxkcwpfX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
XwpWaXJ0dWFsaXphdGlvbiBtYWlsaW5nIGxpc3QKVmlydHVhbGl6YXRpb25AbGlzdHMubGludXgt
Zm91bmRhdGlvbi5vcmcKaHR0cHM6Ly9saXN0cy5saW51eGZvdW5kYXRpb24ub3JnL21haWxtYW4v
bGlzdGluZm8vdmlydHVhbGl6YXRpb24=
