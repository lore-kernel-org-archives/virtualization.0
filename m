Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9AE7CC0015E
	for <virtualization@archiver.kernel.org>; Thu, 13 Jul 2023 15:15:13 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 2C7AC41FB0;
	Thu, 13 Jul 2023 15:15:13 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org 2C7AC41FB0
Authentication-Results: smtp4.osuosl.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=chromium.org header.i=@chromium.org header.a=rsa-sha256 header.s=google header.b=A2+oSg6s
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
	by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id 5ayfRwFPbB-A; Thu, 13 Jul 2023 15:15:12 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp4.osuosl.org (Postfix) with ESMTPS id 77E3B41F3F;
	Thu, 13 Jul 2023 15:15:11 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org 77E3B41F3F
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 3DF33C0072;
	Thu, 13 Jul 2023 15:15:11 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [IPv6:2605:bc80:3010::136])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 726A3C0032
 for <virtualization@lists.linux-foundation.org>;
 Thu, 13 Jul 2023 15:15:09 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id 4C60561333
 for <virtualization@lists.linux-foundation.org>;
 Thu, 13 Jul 2023 15:15:09 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 4C60561333
Authentication-Results: smtp3.osuosl.org;
 dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org
 header.a=rsa-sha256 header.s=google header.b=A2+oSg6s
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id IDVK3eV0p41v
 for <virtualization@lists.linux-foundation.org>;
 Thu, 13 Jul 2023 15:15:08 +0000 (UTC)
X-Greylist: whitelisted by SQLgrey-1.8.0
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org C62F560D89
Received: from mail-oi1-x235.google.com (mail-oi1-x235.google.com
 [IPv6:2607:f8b0:4864:20::235])
 by smtp3.osuosl.org (Postfix) with ESMTPS id C62F560D89
 for <virtualization@lists.linux-foundation.org>;
 Thu, 13 Jul 2023 15:15:07 +0000 (UTC)
Received: by mail-oi1-x235.google.com with SMTP id
 5614622812f47-3a3e1152c23so703911b6e.2
 for <virtualization@lists.linux-foundation.org>;
 Thu, 13 Jul 2023 08:15:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1689261306; x=1691853306;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=vKItIj72hAMISxrHuiptAazhKs3+4zy1JRueUjGy5Ew=;
 b=A2+oSg6sQmWz0ZmU9buZhg7+23vgsGR5qgFL1blu/yKSWbkPSmPF1NSnTwWp3RQg3R
 d9xEWGn8bxhU5vbOtLt35s/LUCI4FEdIdHzF1npFd5rK0KCRap8MGwkt/zasnQ3SXsHO
 WeikQd9SCym9GJgbYOTqOhtPAQNScKsChiq+c=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1689261306; x=1691853306;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=vKItIj72hAMISxrHuiptAazhKs3+4zy1JRueUjGy5Ew=;
 b=c8gt9XrRX+Dua4qN7RdFEPWsqrIy9VSYsB/iZEYSAt5JY0LlG6wWGTBRjvBWYUGgud
 iscporRfYeN1a4ogiaC+/n16LyvcmUGSiNmIcA2ldeaz/yLpuOPORHZfbL4nfQ9aWOk9
 8KtUFAZW50TQmnKbV4gOuXyma5RhuN4jdU0KAkti2KjkT6T8zLHUlsouPTLCbXmtzd9g
 f4+Sgd+g95NVCuO5CCgPBOD4f1JLCFOS0EXEJ3i8D5NRqXXTCq605Rxe1sij0JcOgWRk
 g2xUdNO92URZVJCZkTCWsDnmqeb9yBuQYk+bFvTDf4TzmCpxFNe7oKeGqNPAkHbjNjKm
 kXLA==
X-Gm-Message-State: ABy/qLYA2BohQDbY3f8dQQhaQTrB3QKpu1LkXb4lyw03vSJ5KVmUEYRM
 0jtd3sqkthKn1cZv4ZWC6G8yns4qynHsX0B629uEQLqH
X-Google-Smtp-Source: APBJJlErC+mG2QPGh+2VUlld4a0Q2AEejDjZ+nUw3uE1+ZjhSI3EuLcdN75VJWhXCxzf8t8PtulAZA==
X-Received: by 2002:a05:6808:f11:b0:3a4:31da:34c5 with SMTP id
 m17-20020a0568080f1100b003a431da34c5mr2362782oiw.39.1689261306363; 
 Thu, 13 Jul 2023 08:15:06 -0700 (PDT)
Received: from mail-oa1-f45.google.com (mail-oa1-f45.google.com.
 [209.85.160.45]) by smtp.gmail.com with ESMTPSA id
 26-20020aca121a000000b003a1e38362b7sm2928110ois.25.2023.07.13.08.15.05
 for <virtualization@lists.linux-foundation.org>
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 13 Jul 2023 08:15:06 -0700 (PDT)
Received: by mail-oa1-f45.google.com with SMTP id
 586e51a60fabf-1b060bce5b0so700953fac.3
 for <virtualization@lists.linux-foundation.org>;
 Thu, 13 Jul 2023 08:15:05 -0700 (PDT)
X-Received: by 2002:a05:6902:211:b0:c8b:3:e399 with SMTP id
 j17-20020a056902021100b00c8b0003e399mr1398441ybs.44.1689259342555; Thu, 13
 Jul 2023 07:42:22 -0700 (PDT)
MIME-Version: 1.0
References: <20230712094702.1770121-1-u.kleine-koenig@pengutronix.de>
 <87fs5tgpvv.fsf@intel.com>
 <CAOw6vbLO_UaXDbTCtAQJgthXOUMPqEV+c2MQhP-1DuK44OhGxw@mail.gmail.com>
 <20230713130337.fd2l67r23g2irifx@pengutronix.de>
In-Reply-To: <20230713130337.fd2l67r23g2irifx@pengutronix.de>
From: Sean Paul <seanpaul@chromium.org>
Date: Thu, 13 Jul 2023 10:41:45 -0400
X-Gmail-Original-Message-ID: <CAOw6vbKtjyUm+OqO7LSV1hDOMQATwkEWP4GzBbbXib0i5EviUQ@mail.gmail.com>
Message-ID: <CAOw6vbKtjyUm+OqO7LSV1hDOMQATwkEWP4GzBbbXib0i5EviUQ@mail.gmail.com>
Subject: Re: [Freedreno] [PATCH RFC v1 00/52] drm/crtc: Rename struct
 drm_crtc::dev to drm_dev
To: =?UTF-8?Q?Uwe_Kleine=2DK=C3=B6nig?= <u.kleine-koenig@pengutronix.de>
Cc: =?UTF-8?Q?Heiko_St=C3=BCbner?= <heiko@sntech.de>,
 Geert Uytterhoeven <geert+renesas@glider.be>,
 Xinliang Liu <xinliang.liu@linaro.org>,
 Linus Walleij <linus.walleij@linaro.org>,
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
 spice-devel@lists.freedesktop.org,
 Niranjana Vishwanathapura <niranjana.vishwanathapura@intel.com>,
 Dmitry Baryshkov <dmitry.baryshkov@linaro.org>, linux-sunxi@lists.linux.dev,
 Matthias Brugger <matthias.bgg@gmail.com>, Stylon Wang <stylon.wang@amd.com>,
 Tim Huang <Tim.Huang@amd.com>, Suraj Kandpal <suraj.kandpal@intel.com>,
 =?UTF-8?Q?Andr=C3=A9_Almeida?= <andrealmeid@igalia.com>,
 Mika Kahola <mika.kahola@intel.com>,
 Tvrtko Ursulin <tvrtko.ursulin@linux.intel.com>, Leo Li <sunpeng.li@amd.com>,
 Sascha Hauer <s.hauer@pengutronix.de>,
 Lucas De Marchi <lucas.demarchi@intel.com>, Inki Dae <inki.dae@samsung.com>,
 Hersen Wu <hersenxs.wu@amd.com>, Dave Airlie <airlied@redhat.com>,
 Kamlesh Gurudasani <kamlesh.gurudasani@gmail.com>,
 Bhawanpreet Lakha <Bhawanpreet.Lakha@amd.com>,
 =?UTF-8?Q?=C5=81ukasz_Bartosik?= <lb@semihalf.com>,
 Radhakrishna Sripada <radhakrishna.sripada@intel.com>,
 Andrew Jeffery <andrew@aj.id.au>, Seung-Woo Kim <sw0312.kim@samsung.com>,
 =?UTF-8?Q?Noralf_Tr=C3=B8nnes?= <noralf@tronnes.org>, kernel@pengutronix.de,
 Alex Deucher <alexander.deucher@amd.com>, freedreno@lists.freedesktop.org,
 Claudiu Beznea <claudiu.beznea@microchip.com>, Zack Rusin <zackr@vmware.com>,
 Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
 Alexandre Belloni <alexandre.belloni@bootlin.com>,
 linux-aspeed@lists.ozlabs.org, nouveau@lists.freedesktop.org,
 Mitul Golani <mitulkumar.ajitkumar.golani@intel.com>,
 =?UTF-8?Q?Jos=C3=A9_Roberto_de_Souza?= <jose.souza@intel.com>,
 virtualization@lists.linux-foundation.org,
 Thierry Reding <thierry.reding@gmail.com>,
 Yongqin Liu <yongqin.liu@linaro.org>,
 Mario Limonciello <mario.limonciello@amd.com>, Fei Yang <fei.yang@intel.com>,
 =?UTF-8?B?VmlsbGUgU3lyasOkbMOk?= <ville.syrjala@linux.intel.com>,
 Juha-Pekka Heikkila <juhapekka.heikkila@gmail.com>,
 Chunyan Zhang <zhang.lyra@gmail.com>, David Francis <David.Francis@amd.com>,
 Vinod Govindapillai <vinod.govindapillai@intel.com>,
 Aaron Liu <aaron.liu@amd.com>, Patrik Jakobsson <patrik.r.jakobsson@gmail.com>,
 Vinod Polimera <quic_vpolimer@quicinc.com>, linux-rockchip@lists.infradead.org,
 Fangzhi Zuo <jerry.zuo@amd.com>, Aurabindo Pillai <aurabindo.pillai@amd.com>,
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
 Karol Herbst <kherbst@redhat.com>,
 Joonas Lahtinen <joonas.lahtinen@linux.intel.com>,
 linux-hyperv@vger.kernel.org, Stefan Agner <stefan@agner.ch>,
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
 Harry Wentland <harry.wentland@amd.com>, Chia-I Wu <olvaffe@gmail.com>,
 Alan Liu <haoping.liu@amd.com>, Philip Yang <Philip.Yang@amd.com>,
 Lyude Paul <lyude@redhat.com>, intel-gfx@lists.freedesktop.org,
 Alison Wang <alison.wang@nxp.com>,
 Wolfram Sang <wsa+renesas@sang-engineering.com>,
 Abhinav Kumar <quic_abhinavk@quicinc.com>,
 Gustavo Sousa <gustavo.sousa@intel.com>,
 Baolin Wang <baolin.wang@linux.alibaba.com>,
 Tomi Valkeinen <tomi.valkeinen+renesas@ideasonboard.com>,
 Daniel Vetter <daniel@ffwll.ch>, Mikko Perttunen <mperttunen@nvidia.com>,
 Yifan Zhang <yifan1.zhang@amd.com>,
 Rodrigo Siqueira <rodrigosiqueiramelo@gmail.com>,
 Tomi Valkeinen <tomba@kernel.org>, Deepak R Varma <drv@mailo.com>, "Pan,
 Xinhui" <Xinhui.Pan@amd.com>, Konrad Dybcio <konrad.dybcio@linaro.org>,
 Kieran Bingham <kieran.bingham+renesas@ideasonboard.com>,
 John Stultz <jstultz@google.com>, Roman Li <roman.li@amd.com>,
 Sumit Semwal <sumit.semwal@linaro.org>,
 =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>,
 Khaled Almahallawy <khaled.almahallawy@intel.com>,
 linux-stm32@st-md-mailman.stormreply.com, Sam Ravnborg <sam@ravnborg.org>,
 Chun-Kuang Hu <chunkuang.hu@kernel.org>, Imre Deak <imre.deak@intel.com>,
 Liviu Dudau <liviu.dudau@arm.com>,
 Alexandre Torgue <alexandre.torgue@foss.st.com>,
 Gurchetan Singh <gurchetansingh@chromium.org>,
 Liu Shixin <liushixin2@huawei.com>,
 Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
 Hamza Mahfooz <hamza.mahfooz@amd.com>, David Airlie <airlied@gmail.com>,
 Marek Vasut <marex@denx.de>, Paul Kocialkowski <paul.kocialkowski@bootlin.com>,
 Lang Yu <Lang.Yu@amd.com>, xen-devel@lists.xenproject.org,
 Guchun Chen <guchun.chen@amd.com>,
 Oleksandr Andrushchenko <oleksandr_andrushchenko@epam.com>,
 Raphael Gallais-Pou <raphael.gallais-pou@foss.st.com>,
 Rodrigo Siqueira <Rodrigo.Siqueira@amd.com>,
 Russell King <linux@armlinux.org.uk>, Jani Nikula <jani.nikula@intel.com>,
 Uma Shankar <uma.shankar@intel.com>, Andi Shyti <andi.shyti@linux.intel.com>,
 Jiasheng Jiang <jiasheng@iscas.ac.cn>,
 Srinivasan Shanmugam <srinivasan.shanmugam@amd.com>,
 David Lechner <david@lechnology.com>,
 Jiapeng Chong <jiapeng.chong@linux.alibaba.com>,
 =?UTF-8?B?TWFyZWsgT2zFocOhaw==?= <marek.olsak@amd.com>,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 =?UTF-8?Q?Joaqu=C3=ADn_Ignacio_Aramend=C3=ADa?= <samsagax@gmail.com>,
 Melissa Wen <mwen@igalia.com>, Hans de Goede <hdegoede@redhat.com>,
 linux-mediatek@lists.infradead.org, Fabio Estevam <festevam@gmail.com>,
 Laurentiu Palcu <laurentiu.palcu@oss.nxp.com>, linux-tegra@vger.kernel.org,
 David Tadokoro <davidbtadokoro@usp.br>,
 AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>,
 amd-gfx@lists.freedesktop.org, Thomas Zimmermann <tzimmermann@suse.de>,
 Yannick Fertre <yannick.fertre@foss.st.com>, linux-mips@vger.kernel.org,
 Rob Clark <robdclark@gmail.com>, Philippe Cornu <philippe.cornu@foss.st.com>,
 Philipp Zabel <p.zabel@pengutronix.de>, Wayne Lin <Wayne.Lin@amd.com>,
 Drew Davenport <ddavenport@chromium.org>, Nirmoy Das <nirmoy.das@intel.com>,
 Jyri Sarha <jyri.sarha@iki.fi>, Lucas Stach <l.stach@pengutronix.de>
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

T24gVGh1LCBKdWwgMTMsIDIwMjMgYXQgOTowNOKAr0FNIFV3ZSBLbGVpbmUtS8O2bmlnCjx1Lmts
ZWluZS1rb2VuaWdAcGVuZ3V0cm9uaXguZGU+IHdyb3RlOgo+Cj4gaGVsbG8gU2VhbiwKPgo+IE9u
IFdlZCwgSnVsIDEyLCAyMDIzIGF0IDAyOjMxOjAyUE0gLTA0MDAsIFNlYW4gUGF1bCB3cm90ZToK
PiA+IEknZCByZWFsbHkgcHJlZmVyIHRoaXMgcGF0Y2ggKHNlcmllcyBvciBzaW5nbGUpIGlzIG5v
dCBhY2NlcHRlZC4gVGhpcwo+ID4gd2lsbCBjYXVzZSBwcm9ibGVtcyBmb3IgZXZlcnlvbmUgY2hl
cnJ5LXBpY2tpbmcgcGF0Y2hlcyB0byBhCj4gPiBkb3duc3RyZWFtIGtlcm5lbCAoTFRTIG9yIGRp
c3RybyB0cmVlKS4gSSB1c3VhbGx5IHdvdWxkbid0IGV4cGVjdAo+ID4gc3ltcGF0aHkgaGVyZSwg
YnV0IHRoZSBxdWVzdGlvbmFibGUgYmVuZWZpdCBkb2VzIG5vdCBvdXR3ZWlnaCB0aGUgY29zdAo+
ID4gSU1bYmlhc2VkXU8uCj4KPiBJIGFncmVlIHRoYXQgZm9yIGJhY2twb3J0cyB0aGlzIGlzbid0
IHNvIG5pY2UuIEhvd2V2ZXIgd2l0aCB0aGUgc3BsaXQKPiBhcHByb2FjaCAodGhhdCB3YXMgYXJn
dW1lbnRlZCBhZ2FpbnN0IGhlcmUpIGl0J3Mgbm90IHNvbyBiYWQuIFBhdGNoICMxCj4gKGFuZCBz
aW1pbGFyIGNoYW5nZXMgZm9yIHRoZSBvdGhlciBhZmZlY3RlZCBzdHJ1Y3R1cmVzKSBjb3VsZCBi
ZQo+IHRyaXZpYWxseSBiYWNrcG9ydGVkIGFuZCB3aXRoIHRoYXQgaXQgZG9lc24ndCBtYXR0ZXIg
aWYgeW91IHdyaXRlIGRldiBvcgo+IGRybSAob3Igd2hhdGV2ZXIgbmFtZSBpcyBjaG9zZW4gaW4g
dGhlIGVuZCk7IGJvdGggd29yayBpbiB0aGUgc2FtZSB3YXkuCgpQYXRjaCAjMSBhdm9pZHMgdGhl
IG5lZWQgdG8gYmFja3BvcnQgdGhlIGVudGlyZSBzZXQsIGhvd2V2ZXIgZXZlcnkKY2hhbmdlIG9j
Y3VyaW5nIGFmdGVyIHRoZSByZW5hbWUgcGF0Y2hlcyB3aWxsIGNhdXNlIGNvbmZsaWN0cyBvbgpm
dXR1cmUgY2hlcnJ5LXBpY2tzLiBEb3duc3RyZWFtIGtlcm5lbHMgd2lsbCBoYXZlIHRvIGJhY2tw
b3J0IHRoZQp3aG9sZSBzZXQuIEJhY2twb3J0aW5nIHRoZSBlbnRpcmUgc2V0IHdpbGwgY3JlYXRl
IGFuIGVwb2NoIGluCmRvd25zdHJlYW0ga2VybmVscyB3aGVyZSBjaGVycnktcGlja2luZyBwYXRj
aGVzIHByZWNlZGluZyB0aGlzIHNldAp3aWxsIG5lZWQgdG8gdW5kZXJnbyBjb25mbGljdCByZXNv
bHV0aW9uIGFzIHdlbGwuIEFzIG1lbnRpb25lZCBpbiBteQpwcmV2aW91cyBlbWFpbCwgSSBkb24n
dCBleHBlY3Qgc3ltcGF0aHkgaGVyZSwgaXQncyBwYXJ0IG9mIG1haW50YWluaW5nCmEgZG93bnN0
cmVhbSBrZXJuZWwsIGJ1dCB0aGVyZSBpcyBhIHJlYWwgY29zdCB0byBrZXJuZWwgY29uc3VtZXJz
LgoKPgo+IEJ1dCBldmVuIHdpdGggdGhlIG9uZS1wYXRjaC1wZXItcmVuYW1lIGFwcHJvYWNoIEkn
ZCBjb25zaWRlciB0aGUKPiByZW5hbWluZyBhIG5ldCB3aW4sIGJlY2F1c2UgZWFzZSBvZiB1bmRl
cnN0YW5kaW5nIGNvZGUgaGFzIGEgYmlnIHZhbHVlLgo+IEl0J3MgdmFsdWUgaXMgbm90IHNvIGVh
c3kgbWVhc3VyYWJsZSBhcyAiY29uZmxpY3RzIHdoZW4gYmFja3BvcnRpbmciLAo+IGJ1dCBpdCBh
bHNvIG1hdHRlcnMgaW4gc2F5IHR3byB5ZWFycyBmcm9tIG5vdywgd2hpbGUgYmFja3BvcnRpbmcK
PiBzaG91bGRuJ3QgYmUgYW4gaXNzdWUgdGhlbiBhbnkgbW9yZS4KCllvdSd2ZSByaWdodGx5IGlk
ZW50aWZpZWQgdGhlIGNvbmplY3R1cmUgaW4geW91ciBzdGF0ZW1lbnQuIEkndmUgYmVlbgpvbiBi
b3RoIHNpZGVzIG9mIHRoZSBhcmd1bWVudCwgaGF2aW5nIHdyaXR0ZW4vbWFpbnRhaW5lZCBkcm0g
Y29kZQp1cHN0cmVhbSBhbmQgY2hlcnJ5LXBpY2tlZCBjaGFuZ2VzIHRvIGEgZG93bnN0cmVhbSBr
ZXJuZWwuIFBlcmhhcHMKaXQncyBiZWNhdXNlIGRybSdzIGRlZmluaXRpb24gb2YgZGV2IGlzIGlu
Z3JhaW5lZCBpbiBteSBtdXNjbGUgbWVtb3J5LApvciBtYXliZSBpdCdzIGJlY2F1c2UgSSBkb24n
dCBkbyBhIGxvdCBvZiB1cHN0cmVhbSBkZXZlbG9wbWVudCB0aGVzZQpkYXlzLCBidXQgSSBqdXN0
IGhhdmUgYSBoYXJkIHRpbWUgc2VlaW5nIHRoZSBiZW5lZml0IGhlcmUuCgpJIGFwcHJlY2lhdGUg
eW91ciBlbmdhZ2VtZW50IG9uIHRoZSB0b3BpYywgdGhhbmsgeW91IQoKU2VhbgoKPgo+IFRoYW5r
cyBmb3IgeW91ciBpbnB1dCwgYmVzdCByZWdhcmRzCj4gVXdlCj4KPiAtLQo+IFBlbmd1dHJvbml4
IGUuSy4gICAgICAgICAgICAgICAgICAgICAgICAgICB8IFV3ZSBLbGVpbmUtS8O2bmlnICAgICAg
ICAgICAgfAo+IEluZHVzdHJpYWwgTGludXggU29sdXRpb25zICAgICAgICAgICAgICAgICB8IGh0
dHBzOi8vd3d3LnBlbmd1dHJvbml4LmRlLyB8Cl9fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fClZpcnR1YWxpemF0aW9uIG1haWxpbmcgbGlzdApWaXJ0dWFsaXph
dGlvbkBsaXN0cy5saW51eC1mb3VuZGF0aW9uLm9yZwpodHRwczovL2xpc3RzLmxpbnV4Zm91bmRh
dGlvbi5vcmcvbWFpbG1hbi9saXN0aW5mby92aXJ0dWFsaXphdGlvbg==
