Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4A590C001B0
	for <virtualization@archiver.kernel.org>; Thu, 13 Jul 2023 09:30:38 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp2.osuosl.org (Postfix) with ESMTP id B3DC440184;
	Thu, 13 Jul 2023 09:30:37 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org B3DC440184
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
	by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id 68kuX7hw4wuv; Thu, 13 Jul 2023 09:30:36 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp2.osuosl.org (Postfix) with ESMTPS id 0349A416E0;
	Thu, 13 Jul 2023 09:30:36 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org 0349A416E0
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id CE8DCC0072;
	Thu, 13 Jul 2023 09:30:35 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id B94E3C0032
 for <virtualization@lists.linux-foundation.org>;
 Thu, 13 Jul 2023 09:30:34 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id 86D3983B99
 for <virtualization@lists.linux-foundation.org>;
 Thu, 13 Jul 2023 09:30:34 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 86D3983B99
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id FO60_fS1Jvzd
 for <virtualization@lists.linux-foundation.org>;
 Thu, 13 Jul 2023 09:30:33 +0000 (UTC)
X-Greylist: whitelisted by SQLgrey-1.8.0
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org ADD8883B92
Received: from mail-vk1-f175.google.com (mail-vk1-f175.google.com
 [209.85.221.175])
 by smtp1.osuosl.org (Postfix) with ESMTPS id ADD8883B92
 for <virtualization@lists.linux-foundation.org>;
 Thu, 13 Jul 2023 09:30:33 +0000 (UTC)
Received: by mail-vk1-f175.google.com with SMTP id
 71dfb90a1353d-47e4d002e0bso184913e0c.0
 for <virtualization@lists.linux-foundation.org>;
 Thu, 13 Jul 2023 02:30:33 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1689240632; x=1691832632;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=LHmbzhpkJKMYjCs3rLqCEOJxasGkKa4brFmr33oqUxc=;
 b=SlDba7sYsfDLzWNkQ5L0WFLfKUvLXahL9W566ttL8+G44x8z2GYsAg6ssqoC4ZR1b2
 Q4rhwapEBd64HevREEk9jHNx8xNbm5KqN/7nWfP0/JNYwaF2Vt0q2yYo24oG0iuO3Tg/
 Y2IeabfvdeGA3LssU8IrOtro7VqF8jdZAyyK8N8PUIernOt0iBHxHdZspUPldZqbYEDc
 tSB83iPYEvdI12Uarnx2vN10qm982boVwj3GtAcOlnWjLSOFWdyv1OlJfUHONy/UZqQ5
 YHPieqvsVbecBdDk9n0G9u6R2yJ6nIbgaOz8KKO73hPJ9QGsFR9yu6Ktmp2+I8mImjLm
 VPkg==
X-Gm-Message-State: ABy/qLa0ygSLXaUGqYz/OukRXE48d+gY0AVYFyUOZMQDyKPlK0NEIoWB
 AdILmoYQ7t+fXs6/GKb+ce/qyAmEFeu6hjXk
X-Google-Smtp-Source: APBJJlFQoGEUdPIPmD0pkQTwwx9kTYj9Z2RqW7dgWkOug3SgfgieCrwK6FDvM2Tvn8sDHsGra/JnNQ==
X-Received: by 2002:a1f:4315:0:b0:481:2dec:c27 with SMTP id
 q21-20020a1f4315000000b004812dec0c27mr530262vka.1.1689240632142; 
 Thu, 13 Jul 2023 02:30:32 -0700 (PDT)
Received: from mail-yw1-f173.google.com (mail-yw1-f173.google.com.
 [209.85.128.173]) by smtp.gmail.com with ESMTPSA id
 k16-20020a25fe10000000b00c74e24a68e8sm1283620ybe.55.2023.07.13.02.30.31
 for <virtualization@lists.linux-foundation.org>
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 13 Jul 2023 02:30:31 -0700 (PDT)
Received: by mail-yw1-f173.google.com with SMTP id
 00721157ae682-5700b15c12fso4247537b3.1
 for <virtualization@lists.linux-foundation.org>;
 Thu, 13 Jul 2023 02:30:31 -0700 (PDT)
X-Received: by 2002:a0d:ef46:0:b0:56e:1df1:dc58 with SMTP id
 y67-20020a0def46000000b0056e1df1dc58mr1228415ywe.45.1689240610993; Thu, 13
 Jul 2023 02:30:10 -0700 (PDT)
MIME-Version: 1.0
References: <20230712094702.1770121-1-u.kleine-koenig@pengutronix.de>
 <87fs5tgpvv.fsf@intel.com> <20230712161025.22op3gtzgujrhytb@pengutronix.de>
 <878rbkgp4m.fsf@intel.com>
In-Reply-To: <878rbkgp4m.fsf@intel.com>
From: Geert Uytterhoeven <geert@linux-m68k.org>
Date: Thu, 13 Jul 2023 11:29:54 +0200
X-Gmail-Original-Message-ID: <CAMuHMdV_CvSyF-dFpZwOkQ8PWXWphWxCm2Lwpx8ZXAfWDBafcQ@mail.gmail.com>
Message-ID: <CAMuHMdV_CvSyF-dFpZwOkQ8PWXWphWxCm2Lwpx8ZXAfWDBafcQ@mail.gmail.com>
Subject: Re: [PATCH RFC v1 00/52] drm/crtc: Rename struct drm_crtc::dev to
 drm_dev
To: Jani Nikula <jani.nikula@intel.com>
Cc: Xinliang Liu <xinliang.liu@linaro.org>,
 Rodrigo Vivi <rodrigo.vivi@intel.com>,
 Alexey Kodanev <aleksei.kodanev@bell-sw.com>, dri-devel@lists.freedesktop.org,
 Vandita Kulkarni <vandita.kulkarni@intel.com>,
 Alim Akhtar <alim.akhtar@samsung.com>,
 Anitha Chrisanthus <anitha.chrisanthus@intel.com>,
 Marijn Suijten <marijn.suijten@somainline.org>,
 Jonathan Hunter <jonathanh@nvidia.com>,
 Arun R Murthy <arun.r.murthy@intel.com>, Jerome Brunet <jbrunet@baylibre.com>,
 linux-samsung-soc@vger.kernel.org, Samuel Holland <samuel@sholland.org>,
 Matt Roper <matthew.d.roper@intel.com>, Wenjing Liu <wenjing.liu@amd.com>,
 Javier Martinez Canillas <javierm@redhat.com>,
 Stanislav Lisovskiy <stanislav.lisovskiy@intel.com>,
 Danilo Krummrich <dakr@redhat.com>, NXP Linux Team <linux-imx@nxp.com>,
 =?UTF-8?Q?Uwe_Kleine=2DK=C3=B6nig?= <u.kleine-koenig@pengutronix.de>,
 spice-devel@lists.freedesktop.org,
 Niranjana Vishwanathapura <niranjana.vishwanathapura@intel.com>,
 Dmitry Baryshkov <dmitry.baryshkov@linaro.org>, linux-sunxi@lists.linux.dev,
 Matthias Brugger <matthias.bgg@gmail.com>, Stylon Wang <stylon.wang@amd.com>,
 Tim Huang <Tim.Huang@amd.com>, Suraj Kandpal <suraj.kandpal@intel.com>,
 =?UTF-8?Q?Andr=C3=A9_Almeida?= <andrealmeid@igalia.com>,
 Mika Kahola <mika.kahola@intel.com>,
 Tvrtko Ursulin <tvrtko.ursulin@linux.intel.com>, Leo Li <sunpeng.li@amd.com>,
 Sascha Hauer <s.hauer@pengutronix.de>,
 Lucas De Marchi <lucas.demarchi@intel.com>, Hersen Wu <hersenxs.wu@amd.com>,
 Dave Airlie <airlied@redhat.com>,
 Kamlesh Gurudasani <kamlesh.gurudasani@gmail.com>,
 Bhawanpreet Lakha <Bhawanpreet.Lakha@amd.com>,
 =?UTF-8?Q?=C5=81ukasz_Bartosik?= <lb@semihalf.com>,
 Radhakrishna Sripada <radhakrishna.sripada@intel.com>,
 Andrew Jeffery <andrew@aj.id.au>, Seung-Woo Kim <sw0312.kim@samsung.com>,
 =?UTF-8?Q?Noralf_Tr=C3=B8nnes?= <noralf@tronnes.org>, kernel@pengutronix.de,
 Alex Deucher <alexander.deucher@amd.com>, freedreno@lists.freedesktop.org,
 Claudiu Beznea <claudiu.beznea@microchip.com>,
 Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
 Alexandre Belloni <alexandre.belloni@bootlin.com>,
 linux-aspeed@lists.ozlabs.org, nouveau@lists.freedesktop.org,
 Mitul Golani <mitulkumar.ajitkumar.golani@intel.com>,
 =?UTF-8?Q?Jos=C3=A9_Roberto_de_Souza?= <jose.souza@intel.com>,
 virtualization@lists.linux-foundation.org,
 Thierry Reding <thierry.reding@gmail.com>,
 Yongqin Liu <yongqin.liu@linaro.org>,
 Mario Limonciello <mario.limonciello@amd.com>, Fei Yang <fei.yang@intel.com>,
 Juha-Pekka Heikkila <juhapekka.heikkila@gmail.com>,
 Chunyan Zhang <zhang.lyra@gmail.com>, David Francis <David.Francis@amd.com>,
 Vinod Govindapillai <vinod.govindapillai@intel.com>,
 Aaron Liu <aaron.liu@amd.com>, Vinod Polimera <quic_vpolimer@quicinc.com>,
 linux-rockchip@lists.infradead.org, Fangzhi Zuo <jerry.zuo@amd.com>,
 Aurabindo Pillai <aurabindo.pillai@amd.com>,
 VMware Graphics Reviewers <linux-graphics-maintainer@vmware.com>,
 Ben Skeggs <bskeggs@redhat.com>,
 =?UTF-8?Q?Jouni_H=C3=B6gander?= <jouni.hogander@intel.com>,
 Jessica Zhang <quic_jesszhan@quicinc.com>,
 Martin Blumenstingl <martin.blumenstingl@googlemail.com>,
 linux-arm-msm@vger.kernel.org, Animesh Manna <animesh.manna@intel.com>,
 Nicolas Ferre <nicolas.ferre@microchip.com>,
 Maxime Ripard <mripard@kernel.org>,
 Chaitanya Kumar Borah <chaitanya.kumar.borah@intel.com>,
 Tian Tao <tiantao6@hisilicon.com>, Biju Das <biju.das.jz@bp.renesas.com>,
 linux-amlogic@lists.infradead.org, Evan Quan <evan.quan@amd.com>,
 Michal Simek <michal.simek@amd.com>, linux-arm-kernel@lists.infradead.org,
 Sean Paul <sean@poorly.run>, Neil Armstrong <neil.armstrong@linaro.org>,
 Kai Vehmanen <kai.vehmanen@linux.intel.com>,
 Boris Brezillon <bbrezillon@kernel.org>, Shawn Guo <shawnguo@kernel.org>,
 Qingqing Zhuo <qingqing.zhuo@amd.com>, Sandy Huang <hjc@rock-chips.com>,
 Swati Sharma <swati2.sharma@intel.com>, linux-renesas-soc@vger.kernel.org,
 Kyungmin Park <kyungmin.park@samsung.com>,
 Maxime Coquelin <mcoquelin.stm32@gmail.com>,
 Kevin Hilman <khilman@baylibre.com>, Hawking Zhang <Hawking.Zhang@amd.com>,
 Haneen Mohammed <hamohammed.sa@gmail.com>,
 Paul Cercueil <paul@crapouillou.net>,
 Anusha Srivatsa <anusha.srivatsa@intel.com>, Dan Carpenter <error27@gmail.com>,
 Karol Herbst <kherbst@redhat.com>, linux-hyperv@vger.kernel.org,
 Melissa Wen <melissa.srw@gmail.com>,
 =?UTF-8?B?TWHDrXJhIENhbmFs?= <mairacanal@riseup.net>,
 Luca Coelho <luciano.coelho@intel.com>,
 Andrzej Hajda <andrzej.hajda@intel.com>, Likun Gao <Likun.Gao@amd.com>,
 "Jiri Slaby \(SUSE\)" <jirislaby@kernel.org>, Emma Anholt <emma@anholt.net>,
 Alain Volmat <alain.volmat@foss.st.com>, Chen-Yu Tsai <wens@csie.org>,
 Jernej Skrabec <jernej.skrabec@gmail.com>,
 Deepak Rawat <drawat.floss@gmail.com>,
 Xinwei Kong <kong.kongxinwei@hisilicon.com>, Joel Stanley <joel@jms.id.au>,
 Orson Zhai <orsonzhai@gmail.com>, Ankit Nautiyal <ankit.k.nautiyal@intel.com>,
 Alan Liu <haoping.liu@amd.com>, Philip Yang <Philip.Yang@amd.com>,
 intel-gfx@lists.freedesktop.org, Alison Wang <alison.wang@nxp.com>,
 Wolfram Sang <wsa+renesas@sang-engineering.com>,
 Abhinav Kumar <quic_abhinavk@quicinc.com>,
 Gustavo Sousa <gustavo.sousa@intel.com>,
 Baolin Wang <baolin.wang@linux.alibaba.com>,
 Tomi Valkeinen <tomi.valkeinen+renesas@ideasonboard.com>,
 Mikko Perttunen <mperttunen@nvidia.com>, Yifan Zhang <yifan1.zhang@amd.com>,
 Rodrigo Siqueira <rodrigosiqueiramelo@gmail.com>,
 Tomi Valkeinen <tomba@kernel.org>, Deepak R Varma <drv@mailo.com>, "Pan,
 Xinhui" <Xinhui.Pan@amd.com>, Konrad Dybcio <konrad.dybcio@linaro.org>,
 Kieran Bingham <kieran.bingham+renesas@ideasonboard.com>,
 John Stultz <jstultz@google.com>, Roman Li <roman.li@amd.com>,
 Sumit Semwal <sumit.semwal@linaro.org>,
 =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>,
 Khaled Almahallawy <khaled.almahallawy@intel.com>,
 linux-stm32@st-md-mailman.stormreply.com, Sam Ravnborg <sam@ravnborg.org>,
 Chun-Kuang Hu <chunkuang.hu@kernel.org>, Liviu Dudau <liviu.dudau@arm.com>,
 Alexandre Torgue <alexandre.torgue@foss.st.com>,
 Gurchetan Singh <gurchetansingh@chromium.org>,
 Liu Shixin <liushixin2@huawei.com>, Hamza Mahfooz <hamza.mahfooz@amd.com>,
 Marek Vasut <marex@denx.de>, Paul Kocialkowski <paul.kocialkowski@bootlin.com>,
 xen-devel@lists.xenproject.org, Guchun Chen <guchun.chen@amd.com>,
 Oleksandr Andrushchenko <oleksandr_andrushchenko@epam.com>,
 Raphael Gallais-Pou <raphael.gallais-pou@foss.st.com>,
 Rodrigo Siqueira <Rodrigo.Siqueira@amd.com>,
 Russell King <linux@armlinux.org.uk>, Uma Shankar <uma.shankar@intel.com>,
 Andi Shyti <andi.shyti@linux.intel.com>, Jiasheng Jiang <jiasheng@iscas.ac.cn>,
 Srinivasan Shanmugam <srinivasan.shanmugam@amd.com>,
 David Lechner <david@lechnology.com>,
 Jiapeng Chong <jiapeng.chong@linux.alibaba.com>,
 =?UTF-8?B?TWFyZWsgT2zFocOhaw==?= <marek.olsak@amd.com>,
 =?UTF-8?Q?Joaqu=C3=ADn_Ignacio_Aramend=C3=ADa?= <samsagax@gmail.com>,
 Melissa Wen <mwen@igalia.com>, Hans de Goede <hdegoede@redhat.com>,
 linux-mediatek@lists.infradead.org,
 Laurentiu Palcu <laurentiu.palcu@oss.nxp.com>, linux-tegra@vger.kernel.org,
 David Tadokoro <davidbtadokoro@usp.br>,
 AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>,
 amd-gfx@lists.freedesktop.org, Lang Yu <Lang.Yu@amd.com>,
 Yannick Fertre <yannick.fertre@foss.st.com>, linux-mips@vger.kernel.org,
 Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
 Philippe Cornu <philippe.cornu@foss.st.com>,
 Thomas Zimmermann <tzimmermann@suse.de>, Wayne Lin <Wayne.Lin@amd.com>,
 Drew Davenport <ddavenport@chromium.org>, Nirmoy Das <nirmoy.das@intel.com>,
 Jyri Sarha <jyri.sarha@iki.fi>
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

SGkgSmFuaSwKCk9uIFRodSwgSnVsIDEzLCAyMDIzIGF0IDExOjAz4oCvQU0gSmFuaSBOaWt1bGEg
PGphbmkubmlrdWxhQGludGVsLmNvbT4gd3JvdGU6Cj4gT24gV2VkLCAxMiBKdWwgMjAyMywgVXdl
IEtsZWluZS1Lw7ZuaWcgPHUua2xlaW5lLWtvZW5pZ0BwZW5ndXRyb25peC5kZT4gd3JvdGU6Cj4g
PiBPbiBXZWQsIEp1bCAxMiwgMjAyMyBhdCAwNTozNDoyOFBNICswMzAwLCBKYW5pIE5pa3VsYSB3
cm90ZToKPiA+PiBPbiBXZWQsIDEyIEp1bCAyMDIzLCBVd2UgS2xlaW5lLUvDtm5pZyA8dS5rbGVp
bmUta29lbmlnQHBlbmd1dHJvbml4LmRlPiB3cm90ZToKPiA+PiA+IHdoaWxlIEkgZGVidWdnZWQg
YW4gaXNzdWUgaW4gdGhlIGlteC1sY2RjIGRyaXZlciBJIHdhcyBjb25zdGFudGx5Cj4gPj4gPiBp
cnJpdGF0ZWQgYWJvdXQgc3RydWN0IGRybV9kZXZpY2UgcG9pbnRlciB2YXJpYWJsZXMgYmVpbmcg
bmFtZWQgImRldiIKPiA+PiA+IGJlY2F1c2Ugd2l0aCB0aGF0IG5hbWUgSSB1c3VhbGx5IGV4cGVj
dCBhIHN0cnVjdCBkZXZpY2UgcG9pbnRlci4KPiA+PiA+Cj4gPj4gPiBJIHRoaW5rIHRoZXJlIGlz
IGEgYmlnIGJlbmVmaXQgd2hlbiB0aGVzZSBhcmUgYWxsIHJlbmFtZWQgdG8gImRybV9kZXYiLgo+
ID4+ID4gSSBoYXZlIG5vIHN0cm9uZyBwcmVmZXJlbmNlIGhlcmUgdGhvdWdoLCBzbyAiZHJtZGV2
IiBvciAiZHJtIiBhcmUgZmluZQo+ID4+ID4gZm9yIG1lLCB0b28uIExldCB0aGUgYmlrZXNoZWRp
bmcgYmVnaW4hCj4gPj4gPgo+ID4+ID4gU29tZSBzdGF0aXN0aWNzOgo+ID4+ID4KPiA+PiA+ICQg
Z2l0IGdyZXAgLW9oRSAnc3RydWN0IGRybV9kZXZpY2UgKlwqICpbXiAoKSw7XSonIHY2LjUtcmMx
IHwgc29ydCB8IHVuaXEgLWMgfCBzb3J0IC1uCj4gPj4gPiAgICAgICAxIHN0cnVjdCBkcm1fZGV2
aWNlICphZGV2X3RvX2RybQo+ID4+ID4gICAgICAgMSBzdHJ1Y3QgZHJtX2RldmljZSAqZHJtXwo+
ID4+ID4gICAgICAgMSBzdHJ1Y3QgZHJtX2RldmljZSAgICAgICAgICAqZHJtX2Rldgo+ID4+ID4g
ICAgICAgMSBzdHJ1Y3QgZHJtX2RldmljZSAgICAgICAgKmRybV9kZXYKPiA+PiA+ICAgICAgIDEg
c3RydWN0IGRybV9kZXZpY2UgKnBkZXYKPiA+PiA+ICAgICAgIDEgc3RydWN0IGRybV9kZXZpY2Ug
KnJkZXYKPiA+PiA+ICAgICAgIDEgc3RydWN0IGRybV9kZXZpY2UgKnZkZXYKPiA+PiA+ICAgICAg
IDIgc3RydWN0IGRybV9kZXZpY2UgKmRjc3NfZHJ2X2Rldl90b19kcm0KPiA+PiA+ICAgICAgIDIg
c3RydWN0IGRybV9kZXZpY2UgKipkZGV2Cj4gPj4gPiAgICAgICAyIHN0cnVjdCBkcm1fZGV2aWNl
ICpkcm1fZGV2X2FsbG9jCj4gPj4gPiAgICAgICAyIHN0cnVjdCBkcm1fZGV2aWNlICptb2NrCj4g
Pj4gPiAgICAgICAyIHN0cnVjdCBkcm1fZGV2aWNlICpwX2RkZXYKPiA+PiA+ICAgICAgIDUgc3Ry
dWN0IGRybV9kZXZpY2UgKmRldmljZQo+ID4+ID4gICAgICAgOSBzdHJ1Y3QgZHJtX2RldmljZSAq
IGRldgo+ID4+ID4gICAgICAyNSBzdHJ1Y3QgZHJtX2RldmljZSAqZAo+ID4+ID4gICAgICA5NSBz
dHJ1Y3QgZHJtX2RldmljZSAqCj4gPj4gPiAgICAgMjE2IHN0cnVjdCBkcm1fZGV2aWNlICpkZGV2
Cj4gPj4gPiAgICAgMjM0IHN0cnVjdCBkcm1fZGV2aWNlICpkcm1fZGV2Cj4gPj4gPiAgICAgNjEx
IHN0cnVjdCBkcm1fZGV2aWNlICpkcm0KPiA+PiA+ICAgIDQxOTAgc3RydWN0IGRybV9kZXZpY2Ug
KmRldgo+ID4+ID4KPiA+PiA+IFRoaXMgc2VyaWVzIHN0YXJ0cyB3aXRoIHJlbmFtaW5nIHN0cnVj
dCBkcm1fY3J0Yzo6ZGV2IHRvIGRybV9kZXYuIElmCj4gPj4gPiBpdCdzIG5vdCBvbmx5IG1lIGFu
ZCBvdGhlcnMgbGlrZSB0aGUgcmVzdWx0IG9mIHRoaXMgZWZmb3J0IGl0IHNob3VsZCBiZQo+ID4+
ID4gZm9sbG93ZWQgdXAgYnkgYWRhcHRpbmcgdGhlIG90aGVyIHN0cnVjdHMgYW5kIHRoZSBpbmRp
dmlkdWFsIHVzYWdlcyBpbgo+ID4+ID4gdGhlIGRpZmZlcmVudCBkcml2ZXJzLgo+ID4+Cj4gPj4g
SSB0aGluayB0aGlzIGlzIGFuIHVubmVjZXNzYXJ5IGNoYW5nZS4gSW4gZHJtLCBhIGRldiBpcyB1
c3VhbGx5IGEgZHJtCj4gPj4gZGV2aWNlLCBpLmUuIHN0cnVjdCBkcm1fZGV2aWNlICouCj4gPgo+
ID4gV2VsbCwgdW5sZXNzIGl0J3Mgbm90LiBQcm9taW5lbnRseSB0aGVyZSBpcwo+ID4KPiA+ICAg
ICAgIHN0cnVjdCBkcm1fZGV2aWNlIHsKPiA+ICAgICAgICAgICAgICAgLi4uCj4gPiAgICAgICAg
ICAgICAgIHN0cnVjdCBkZXZpY2UgKmRldjsKPiA+ICAgICAgICAgICAgICAgLi4uCj4gPiAgICAg
ICB9Owo+ID4KPiA+IHdoaWNoIHlpZWxkcyBxdWl0ZSBhIGZldyBjb2RlIGxvY2F0aW9ucyB1c2lu
ZyBkZXYtPmRldiB3aGljaCBpcwo+ID4gSU1ITyB1bm5lY2Vzc2FyeSBpcnJpdGF0aW5nOgo+ID4K
PiA+ICAgICAgICQgZ2l0IGdyZXAgJ1w8ZGV2LT5kZXYnIHY2LjUtcmMxIGRyaXZlcnMvZ3B1L2Ry
bSB8IHdjIC1sCj4gPiAgICAgICAxNjMzCj4gPgo+ID4gQWxzbyB0aGUgZnVuY3Rpb25zIHRoYXQg
ZGVhbCB3aXRoIGJvdGggYSBzdHJ1Y3QgZGV2aWNlIGFuZCBhIHN0cnVjdAo+ID4gZHJtX2Rldmlj
ZSBvZnRlbiB1c2UgImRldiIgZm9yIHRoZSBzdHJ1Y3QgZGV2aWNlIGFuZCB0aGVuICJkZGV2IiBm
b3IKPiA+IHRoZSBkcm1fZGV2aWNlIChzZWUgZm9yIGV4YW1wbGUgYW1kZ3B1X2RldmljZV9nZXRf
cGNpZV9yZXBsYXlfY291bnQoKSkuCj4KPiBXaHkgaXMgc3BlY2lmaWNhbGx5IHN0cnVjdCBkcm1f
ZGV2aWNlICpkZXYgc28gaXJyaXRhdGluZyB0byB5b3U/Cj4KPiBZb3UgbGVhZCB1cyB0byBiZWxp
ZXZlIGl0J3MgYW4gb3V0bGllciBpbiBrZXJuZWwsIHNvbWV0aGluZyB0aGF0IGdvZXMKPiBhZ2Fp
bnN0IGNvbW1vbiBrZXJuZWwgc3R5bGUsIGJ1dCBpdCdzIHJlYWxseSBub3Q6Cj4KPiAkIGdpdCBn
cmVwIC1ob3cgInN0cnVjdCBbQS1aYS16MC05X11cKyBcKmRldiIgfCBzb3J0IHwgdW5pcSAtYyB8
IHNvcnQgLXJuIHwgaGVhZCAtMjAKPiAgIDM4NDk0IHN0cnVjdCBkZXZpY2UgKmRldgo+ICAgMTYz
ODggc3RydWN0IG5ldF9kZXZpY2UgKmRldgo+ICAgIDQxODQgc3RydWN0IGRybV9kZXZpY2UgKmRl
dgo+ICAgIDI3ODAgc3RydWN0IHBjaV9kZXYgKmRldgo+ICAgIDE5MTYgc3RydWN0IGNvbWVkaV9k
ZXZpY2UgKmRldgo+ICAgIDE1MTAgc3RydWN0IG1seDVfY29yZV9kZXYgKmRldgo+ICAgIDEwNTcg
c3RydWN0IG1seDRfZGV2ICpkZXYKPiAgICAgODk0IHN0cnVjdCBiNDNfd2xkZXYgKmRldgo+ICAg
ICA3NjIgc3RydWN0IGlucHV0X2RldiAqZGV2Cj4gICAgIDYyMyBzdHJ1Y3QgdXNibmV0ICpkZXYK
PiAgICAgNTYxIHN0cnVjdCBtbHg1X2liX2RldiAqZGV2Cj4gICAgIDUyNSBzdHJ1Y3QgbXQ3Nl9k
ZXYgKmRldgo+ICAgICA0NjUgc3RydWN0IG10NzZ4MDJfZGV2ICpkZXYKPiAgICAgNDM1IHN0cnVj
dCBwbGF0Zm9ybV9kZXZpY2UgKmRldgo+ICAgICA0MzEgc3RydWN0IHVzYl9kZXZpY2UgKmRldgo+
ICAgICA0MTEgc3RydWN0IG10NzkxNV9kZXYgKmRldgo+ICAgICAzOTggc3RydWN0IGN4MjMxeHgg
KmRldgo+ICAgICAzNzggc3RydWN0IG1laV9kZXZpY2UgKmRldgo+ICAgICAzNjMgc3RydWN0IGtz
el9kZXZpY2UgKmRldgo+ICAgICAzNTkgc3RydWN0IG10aGNhX2RldiAqZGV2Cj4KPiBBIGdvb2Qg
cG9ydGlvbiBvZiB0aGUgYWJvdmUgYWxzbyBoYXZlIGEgZGV2IG1lbWJlci4KCk5vdCBhbGwgb2Yg
dGhlbSBhY2Nlc3MgYm90aCB0aGUgZm9vX2RldmljZSBhbmQgdGhlIGRldmljZSBwb2ludGVycy4K
CkxldCdzIHB1dCB0aGUgbnVtYmVyIG9mIDQzNSBwbGF0Zm9ybV9kZXZpY2UgcG9pbnRlcnMgbmFt
ZWQgImRldiIKaW50byBwZXJzcGVjdGl2ZToKCiAgICAxMDA5NSBzdHJ1Y3QgcGxhdGZvcm1fZGV2
aWNlICpwZGV2CgpHcntvZXRqZSxlZXRpbmd9cywKCiAgICAgICAgICAgICAgICAgICAgICAgIEdl
ZXJ0CgotLSAKR2VlcnQgVXl0dGVyaG9ldmVuIC0tIFRoZXJlJ3MgbG90cyBvZiBMaW51eCBiZXlv
bmQgaWEzMiAtLSBnZWVydEBsaW51eC1tNjhrLm9yZwoKSW4gcGVyc29uYWwgY29udmVyc2F0aW9u
cyB3aXRoIHRlY2huaWNhbCBwZW9wbGUsIEkgY2FsbCBteXNlbGYgYSBoYWNrZXIuIEJ1dAp3aGVu
IEknbSB0YWxraW5nIHRvIGpvdXJuYWxpc3RzIEkganVzdCBzYXkgInByb2dyYW1tZXIiIG9yIHNv
bWV0aGluZyBsaWtlIHRoYXQuCiAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgLS0gTGlu
dXMgVG9ydmFsZHMKX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X18KVmlydHVhbGl6YXRpb24gbWFpbGluZyBsaXN0ClZpcnR1YWxpemF0aW9uQGxpc3RzLmxpbnV4
LWZvdW5kYXRpb24ub3JnCmh0dHBzOi8vbGlzdHMubGludXhmb3VuZGF0aW9uLm9yZy9tYWlsbWFu
L2xpc3RpbmZvL3ZpcnR1YWxpemF0aW9u
