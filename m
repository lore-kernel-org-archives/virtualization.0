Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7E014EB64DA
	for <virtualization@archiver.kernel.org>; Wed, 12 Jul 2023 18:37:47 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id D230B82ECF;
	Wed, 12 Jul 2023 18:37:46 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org D230B82ECF
Authentication-Results: smtp1.osuosl.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=chromium.org header.i=@chromium.org header.a=rsa-sha256 header.s=google header.b=Rj2HaqxJ
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
	by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id 256nQKNIrR73; Wed, 12 Jul 2023 18:37:45 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp1.osuosl.org (Postfix) with ESMTPS id 7498E82244;
	Wed, 12 Jul 2023 18:37:44 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 7498E82244
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 3D06FC0072;
	Wed, 12 Jul 2023 18:37:44 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [IPv6:2605:bc80:3010::137])
 by lists.linuxfoundation.org (Postfix) with ESMTP id EE1D6C0032
 for <virtualization@lists.linux-foundation.org>;
 Wed, 12 Jul 2023 18:37:42 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id B938941B93
 for <virtualization@lists.linux-foundation.org>;
 Wed, 12 Jul 2023 18:37:42 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org B938941B93
Authentication-Results: smtp4.osuosl.org;
 dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org
 header.a=rsa-sha256 header.s=google header.b=Rj2HaqxJ
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id q1JET-6Gu1so
 for <virtualization@lists.linux-foundation.org>;
 Wed, 12 Jul 2023 18:37:40 +0000 (UTC)
X-Greylist: whitelisted by SQLgrey-1.8.0
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org B056841AEF
Received: from mail-pl1-x62f.google.com (mail-pl1-x62f.google.com
 [IPv6:2607:f8b0:4864:20::62f])
 by smtp4.osuosl.org (Postfix) with ESMTPS id B056841AEF
 for <virtualization@lists.linux-foundation.org>;
 Wed, 12 Jul 2023 18:37:40 +0000 (UTC)
Received: by mail-pl1-x62f.google.com with SMTP id
 d9443c01a7336-1b89d47ffb6so38666265ad.2
 for <virtualization@lists.linux-foundation.org>;
 Wed, 12 Jul 2023 11:37:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1689187059; x=1691779059;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=rTThceHWQZD4Ac2XfATsHd8gywiOPtbGgdMtmxYrl6g=;
 b=Rj2HaqxJ017CZ64rMflU5afQzYUPXXlyrf4tpRXh31EOeik3z4p9/H6mlMJ+9MdrzJ
 1rZucRUZlU0oXi/8OUz/dkAnou7YeRfrC4saIIk1fYrykZsOlS6M7eSdLjy78LuVJNoE
 kgPA69tBWVLeVYWVkbeiReYLV/RpamJ9jacl0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1689187059; x=1691779059;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=rTThceHWQZD4Ac2XfATsHd8gywiOPtbGgdMtmxYrl6g=;
 b=lBBm+N1rKyq+VYBYVIE4WpYjHiIhw7PkVUQbbxVWZmpgsyF5bUSwGoEFwNMA7irG5Y
 D9Qrvlo6yc6nB7Sv6iIMMZKADrEKm8eblCyYuV6AM2gceZl16946l3dHZuClFRvDGEOQ
 HFHKKcdYxDUZzT5DVVjBQ9K8Bp00VR2RqepS2z8ofHPXQkoLcZ1NrGzgFKffGZa4Jai8
 T6G5psh7PqkPBXYObo4Vz5scW1ILgj4GjBt0ZVPDbgMad8L7kYp7RgYVJp19urOh34Bv
 Ozn98YFL2azTSkSyzIsVhts7OIE+GEaWuK54CXPTcZLkiB9xd0cGfCTi4LFjzAkpbAEj
 WmhA==
X-Gm-Message-State: ABy/qLaxpuovzBc361h8Vzhcz7UfiVDst1RCiwFjw9CHCxHDyjaLNfgg
 dEc2PSkvSrkDpQXnQTUri1tJEo8JPOB6xJwNw9jzJTf3
X-Google-Smtp-Source: APBJJlGZGyb0S4bOpGzFI36RWhsJ9O4dsNi2hi1CAAbX5V0QO3Y6XYyWkcLf9OEcyXADxIRqAN66kg==
X-Received: by 2002:a17:903:1246:b0:1b8:1b79:a78c with SMTP id
 u6-20020a170903124600b001b81b79a78cmr17128943plh.44.1689187059195; 
 Wed, 12 Jul 2023 11:37:39 -0700 (PDT)
Received: from mail-pj1-f48.google.com (mail-pj1-f48.google.com.
 [209.85.216.48]) by smtp.gmail.com with ESMTPSA id
 c15-20020a170902cb0f00b001ae469ca0c0sm4298955ply.245.2023.07.12.11.37.38
 for <virtualization@lists.linux-foundation.org>
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 12 Jul 2023 11:37:38 -0700 (PDT)
Received: by mail-pj1-f48.google.com with SMTP id
 98e67ed59e1d1-262ea2ff59dso3682601a91.0
 for <virtualization@lists.linux-foundation.org>;
 Wed, 12 Jul 2023 11:37:38 -0700 (PDT)
X-Received: by 2002:a25:50c9:0:b0:c6d:e3e3:5592 with SMTP id
 e192-20020a2550c9000000b00c6de3e35592mr13511834ybb.54.1689186698646; Wed, 12
 Jul 2023 11:31:38 -0700 (PDT)
MIME-Version: 1.0
References: <20230712094702.1770121-1-u.kleine-koenig@pengutronix.de>
 <87fs5tgpvv.fsf@intel.com>
In-Reply-To: <87fs5tgpvv.fsf@intel.com>
From: Sean Paul <seanpaul@chromium.org>
Date: Wed, 12 Jul 2023 14:31:02 -0400
X-Gmail-Original-Message-ID: <CAOw6vbLO_UaXDbTCtAQJgthXOUMPqEV+c2MQhP-1DuK44OhGxw@mail.gmail.com>
Message-ID: <CAOw6vbLO_UaXDbTCtAQJgthXOUMPqEV+c2MQhP-1DuK44OhGxw@mail.gmail.com>
Subject: Re: [Freedreno] [PATCH RFC v1 00/52] drm/crtc: Rename struct
 drm_crtc::dev to drm_dev
To: Jani Nikula <jani.nikula@intel.com>
Cc: =?UTF-8?Q?Heiko_St=C3=BCbner?= <heiko@sntech.de>,
 Geert Uytterhoeven <geert+renesas@glider.be>,
 Marian Cichy <m.cichy@pengutronix.de>, Xinliang Liu <xinliang.liu@linaro.org>,
 Linus Walleij <linus.walleij@linaro.org>,
 Tomi Valkeinen <tomi.valkeinen+renesas@ideasonboard.com>,
 Alexey Kodanev <aleksei.kodanev@bell-sw.com>, dri-devel@lists.freedesktop.org,
 Vandita Kulkarni <vandita.kulkarni@intel.com>,
 Alim Akhtar <alim.akhtar@samsung.com>,
 Anitha Chrisanthus <anitha.chrisanthus@intel.com>,
 Marijn Suijten <marijn.suijten@somainline.org>,
 Jonathan Hunter <jonathanh@nvidia.com>,
 Arun R Murthy <arun.r.murthy@intel.com>, Jerome Brunet <jbrunet@baylibre.com>,
 Liu Shixin <liushixin2@huawei.com>, linux-samsung-soc@vger.kernel.org,
 Samuel Holland <samuel@sholland.org>, Matt Roper <matthew.d.roper@intel.com>,
 Wenjing Liu <wenjing.liu@amd.com>,
 Javier Martinez Canillas <javierm@redhat.com>,
 Stanislav Lisovskiy <stanislav.lisovskiy@intel.com>,
 Danilo Krummrich <dakr@redhat.com>, NXP Linux Team <linux-imx@nxp.com>,
 =?UTF-8?Q?Uwe_Kleine=2DK=C3=B6nig?= <u.kleine-koenig@pengutronix.de>,
 spice-devel@lists.freedesktop.org,
 Niranjana Vishwanathapura <niranjana.vishwanathapura@intel.com>,
 linux-sunxi@lists.linux.dev, Stylon Wang <stylon.wang@amd.com>,
 Tim Huang <Tim.Huang@amd.com>, Suraj Kandpal <suraj.kandpal@intel.com>,
 =?UTF-8?Q?Andr=C3=A9_Almeida?= <andrealmeid@igalia.com>,
 Andi Shyti <andi.shyti@linux.intel.com>, Yifan Zhang <yifan1.zhang@amd.com>,
 Leo Li <sunpeng.li@amd.com>, Sascha Hauer <s.hauer@pengutronix.de>,
 Lucas De Marchi <lucas.demarchi@intel.com>, Inki Dae <inki.dae@samsung.com>,
 Hersen Wu <hersenxs.wu@amd.com>, Jessica Zhang <quic_jesszhan@quicinc.com>,
 Kamlesh Gurudasani <kamlesh.gurudasani@gmail.com>,
 Bhawanpreet Lakha <Bhawanpreet.Lakha@amd.com>,
 =?UTF-8?Q?=C5=81ukasz_Bartosik?= <lb@semihalf.com>,
 Radhakrishna Sripada <radhakrishna.sripada@intel.com>,
 Andrew Jeffery <andrew@aj.id.au>, Seung-Woo Kim <sw0312.kim@samsung.com>,
 Manasi Navare <manasi.d.navare@intel.com>,
 =?UTF-8?Q?Noralf_Tr=C3=B8nnes?= <noralf@tronnes.org>, kernel@pengutronix.de,
 Alex Deucher <alexander.deucher@amd.com>, freedreno@lists.freedesktop.org,
 Claudiu Beznea <claudiu.beznea@microchip.com>, Zack Rusin <zackr@vmware.com>,
 Alexandre Belloni <alexandre.belloni@bootlin.com>,
 linux-aspeed@lists.ozlabs.org, nouveau@lists.freedesktop.org,
 Mitul Golani <mitulkumar.ajitkumar.golani@intel.com>,
 Edmund Dea <edmund.j.dea@intel.com>,
 =?UTF-8?Q?Jos=C3=A9_Roberto_de_Souza?= <jose.souza@intel.com>,
 virtualization@lists.linux-foundation.org,
 Thierry Reding <thierry.reding@gmail.com>,
 Yongqin Liu <yongqin.liu@linaro.org>,
 Mario Limonciello <mario.limonciello@amd.com>, Fei Yang <fei.yang@intel.com>,
 =?UTF-8?B?VmlsbGUgU3lyasOkbMOk?= <ville.syrjala@linux.intel.com>,
 David Lechner <david@lechnology.com>,
 Juha-Pekka Heikkila <juhapekka.heikkila@gmail.com>,
 "Jiri Slaby \(SUSE\)" <jirislaby@kernel.org>,
 David Francis <David.Francis@amd.com>, Aaron Liu <aaron.liu@amd.com>,
 Patrik Jakobsson <patrik.r.jakobsson@gmail.com>,
 Vinod Polimera <quic_vpolimer@quicinc.com>, linux-rockchip@lists.infradead.org,
 Fangzhi Zuo <jerry.zuo@amd.com>, Aurabindo Pillai <aurabindo.pillai@amd.com>,
 VMware Graphics Reviewers <linux-graphics-maintainer@vmware.com>,
 Ben Skeggs <bskeggs@redhat.com>,
 =?UTF-8?Q?Jouni_H=C3=B6gander?= <jouni.hogander@intel.com>,
 Dave Airlie <airlied@redhat.com>, linux-mips@vger.kernel.org,
 Graham Sider <Graham.Sider@amd.com>,
 Gurchetan Singh <gurchetansingh@chromium.org>,
 Martin Blumenstingl <martin.blumenstingl@googlemail.com>,
 linux-arm-msm@vger.kernel.org, Animesh Manna <animesh.manna@intel.com>,
 linux-renesas-soc@vger.kernel.org, Maxime Ripard <mripard@kernel.org>,
 Chaitanya Kumar Borah <chaitanya.kumar.borah@intel.com>,
 Biju Das <biju.das.jz@bp.renesas.com>, linux-amlogic@lists.infradead.org,
 Evan Quan <evan.quan@amd.com>, Michal Simek <michal.simek@amd.com>,
 linux-arm-kernel@lists.infradead.org, Sean Paul <sean@poorly.run>,
 Neil Armstrong <neil.armstrong@linaro.org>,
 Kai Vehmanen <kai.vehmanen@linux.intel.com>,
 Boris Brezillon <bbrezillon@kernel.org>, Chunyan Zhang <zhang.lyra@gmail.com>,
 Qingqing Zhuo <qingqing.zhuo@amd.com>, Sandy Huang <hjc@rock-chips.com>,
 Swati Sharma <swati2.sharma@intel.com>, John Stultz <jstultz@google.com>,
 Paul Kocialkowski <paul.kocialkowski@bootlin.com>,
 Kyungmin Park <kyungmin.park@samsung.com>,
 Drew Davenport <ddavenport@chromium.org>, Kevin Hilman <khilman@baylibre.com>,
 Hawking Zhang <Hawking.Zhang@amd.com>,
 Haneen Mohammed <hamohammed.sa@gmail.com>,
 Anusha Srivatsa <anusha.srivatsa@intel.com>, Dan Carpenter <error27@gmail.com>,
 Karol Herbst <kherbst@redhat.com>,
 Joonas Lahtinen <joonas.lahtinen@linux.intel.com>,
 linux-hyperv@vger.kernel.org, Stefan Agner <stefan@agner.ch>,
 Melissa Wen <melissa.srw@gmail.com>,
 =?UTF-8?B?TWHDrXJhIENhbmFs?= <mairacanal@riseup.net>,
 Luca Coelho <luciano.coelho@intel.com>,
 Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
 Andrzej Hajda <andrzej.hajda@intel.com>, Likun Gao <Likun.Gao@amd.com>,
 Sam Ravnborg <sam@ravnborg.org>, Alain Volmat <alain.volmat@foss.st.com>,
 Xinwei Kong <kong.kongxinwei@hisilicon.com>,
 Jernej Skrabec <jernej.skrabec@gmail.com>,
 Deepak Rawat <drawat.floss@gmail.com>, Chen-Yu Tsai <wens@csie.org>,
 Joel Stanley <joel@jms.id.au>, xurui <xurui@kylinos.cn>,
 Ankit Nautiyal <ankit.k.nautiyal@intel.com>,
 Harry Wentland <harry.wentland@amd.com>,
 Sumit Semwal <sumit.semwal@linaro.org>, Alan Liu <haoping.liu@amd.com>,
 Philip Yang <Philip.Yang@amd.com>, Lyude Paul <lyude@redhat.com>,
 intel-gfx@lists.freedesktop.org, Alison Wang <alison.wang@nxp.com>,
 Wolfram Sang <wsa+renesas@sang-engineering.com>,
 Abhinav Kumar <quic_abhinavk@quicinc.com>,
 Gustavo Sousa <gustavo.sousa@intel.com>,
 Baolin Wang <baolin.wang@linux.alibaba.com>,
 Rodrigo Vivi <rodrigo.vivi@intel.com>, Philipp Zabel <p.zabel@pengutronix.de>,
 Mikko Perttunen <mperttunen@nvidia.com>,
 Tvrtko Ursulin <tvrtko.ursulin@linux.intel.com>,
 Rodrigo Siqueira <rodrigosiqueiramelo@gmail.com>,
 Tomi Valkeinen <tomba@kernel.org>, Deepak R Varma <drv@mailo.com>, "Pan,
 Xinhui" <Xinhui.Pan@amd.com>, Chia-I Wu <olvaffe@gmail.com>,
 Konrad Dybcio <konrad.dybcio@linaro.org>,
 Kieran Bingham <kieran.bingham+renesas@ideasonboard.com>,
 Tian Tao <tiantao6@hisilicon.com>, Shawn Guo <shawnguo@kernel.org>,
 =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>,
 Khaled Almahallawy <khaled.almahallawy@intel.com>,
 linux-stm32@st-md-mailman.stormreply.com, Emma Anholt <emma@anholt.net>,
 Chun-Kuang Hu <chunkuang.hu@kernel.org>, Imre Deak <imre.deak@intel.com>,
 Liviu Dudau <liviu.dudau@arm.com>,
 Alexandre Torgue <alexandre.torgue@foss.st.com>, Roman Li <roman.li@amd.com>,
 Paul Cercueil <paul@crapouillou.net>, Rob Clark <robdclark@gmail.com>,
 Hamza Mahfooz <hamza.mahfooz@amd.com>, David Airlie <airlied@gmail.com>,
 Marek Vasut <marex@denx.de>, Jiapeng Chong <jiapeng.chong@linux.alibaba.com>,
 xen-devel@lists.xenproject.org, Guchun Chen <guchun.chen@amd.com>,
 Oleksandr Andrushchenko <oleksandr_andrushchenko@epam.com>,
 Raphael Gallais-Pou <raphael.gallais-pou@foss.st.com>,
 Rodrigo Siqueira <Rodrigo.Siqueira@amd.com>,
 Russell King <linux@armlinux.org.uk>, Uma Shankar <uma.shankar@intel.com>,
 Mika Kahola <mika.kahola@intel.com>,
 Maxime Coquelin <mcoquelin.stm32@gmail.com>,
 Jiasheng Jiang <jiasheng@iscas.ac.cn>,
 Srinivasan Shanmugam <srinivasan.shanmugam@amd.com>,
 Thomas Zimmermann <tzimmermann@suse.de>,
 Vinod Govindapillai <vinod.govindapillai@intel.com>,
 linux-tegra@vger.kernel.org,
 =?UTF-8?B?TWFyZWsgT2zFocOhaw==?= <marek.olsak@amd.com>,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 =?UTF-8?Q?Joaqu=C3=ADn_Ignacio_Aramend=C3=ADa?= <samsagax@gmail.com>,
 Melissa Wen <mwen@igalia.com>, Hans de Goede <hdegoede@redhat.com>,
 linux-mediatek@lists.infradead.org, Fabio Estevam <festevam@gmail.com>,
 Laurentiu Palcu <laurentiu.palcu@oss.nxp.com>,
 Matthias Brugger <matthias.bgg@gmail.com>,
 David Tadokoro <davidbtadokoro@usp.br>,
 AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>,
 Orson Zhai <orsonzhai@gmail.com>, amd-gfx@lists.freedesktop.org,
 Jyri Sarha <jyri.sarha@iki.fi>, Yannick Fertre <yannick.fertre@foss.st.com>,
 Nicolas Ferre <nicolas.ferre@microchip.com>,
 Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
 Philippe Cornu <philippe.cornu@foss.st.com>, Daniel Vetter <daniel@ffwll.ch>,
 Wayne Lin <Wayne.Lin@amd.com>, Dmitry Baryshkov <dmitry.baryshkov@linaro.org>,
 Nirmoy Das <nirmoy.das@intel.com>, Lang Yu <Lang.Yu@amd.com>,
 Lucas Stach <l.stach@pengutronix.de>
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

T24gV2VkLCBKdWwgMTIsIDIwMjMgYXQgMTA6NTLigK9BTSBKYW5pIE5pa3VsYSA8amFuaS5uaWt1
bGFAaW50ZWwuY29tPiB3cm90ZToKPgo+IE9uIFdlZCwgMTIgSnVsIDIwMjMsIFV3ZSBLbGVpbmUt
S8O2bmlnIDx1LmtsZWluZS1rb2VuaWdAcGVuZ3V0cm9uaXguZGU+IHdyb3RlOgo+ID4gSGVsbG8s
Cj4gPgo+ID4gd2hpbGUgSSBkZWJ1Z2dlZCBhbiBpc3N1ZSBpbiB0aGUgaW14LWxjZGMgZHJpdmVy
IEkgd2FzIGNvbnN0YW50bHkKPiA+IGlycml0YXRlZCBhYm91dCBzdHJ1Y3QgZHJtX2RldmljZSBw
b2ludGVyIHZhcmlhYmxlcyBiZWluZyBuYW1lZCAiZGV2Igo+ID4gYmVjYXVzZSB3aXRoIHRoYXQg
bmFtZSBJIHVzdWFsbHkgZXhwZWN0IGEgc3RydWN0IGRldmljZSBwb2ludGVyLgo+ID4KPiA+IEkg
dGhpbmsgdGhlcmUgaXMgYSBiaWcgYmVuZWZpdCB3aGVuIHRoZXNlIGFyZSBhbGwgcmVuYW1lZCB0
byAiZHJtX2RldiIuCj4gPiBJIGhhdmUgbm8gc3Ryb25nIHByZWZlcmVuY2UgaGVyZSB0aG91Z2gs
IHNvICJkcm1kZXYiIG9yICJkcm0iIGFyZSBmaW5lCj4gPiBmb3IgbWUsIHRvby4gTGV0IHRoZSBi
aWtlc2hlZGluZyBiZWdpbiEKPiA+Cj4gPiBTb21lIHN0YXRpc3RpY3M6Cj4gPgo+ID4gJCBnaXQg
Z3JlcCAtb2hFICdzdHJ1Y3QgZHJtX2RldmljZSAqXCogKlteICgpLDtdKicgdjYuNS1yYzEgfCBz
b3J0IHwgdW5pcSAtYyB8IHNvcnQgLW4KPiA+ICAgICAgIDEgc3RydWN0IGRybV9kZXZpY2UgKmFk
ZXZfdG9fZHJtCj4gPiAgICAgICAxIHN0cnVjdCBkcm1fZGV2aWNlICpkcm1fCj4gPiAgICAgICAx
IHN0cnVjdCBkcm1fZGV2aWNlICAgICAgICAgICpkcm1fZGV2Cj4gPiAgICAgICAxIHN0cnVjdCBk
cm1fZGV2aWNlICAgICAgICAqZHJtX2Rldgo+ID4gICAgICAgMSBzdHJ1Y3QgZHJtX2RldmljZSAq
cGRldgo+ID4gICAgICAgMSBzdHJ1Y3QgZHJtX2RldmljZSAqcmRldgo+ID4gICAgICAgMSBzdHJ1
Y3QgZHJtX2RldmljZSAqdmRldgo+ID4gICAgICAgMiBzdHJ1Y3QgZHJtX2RldmljZSAqZGNzc19k
cnZfZGV2X3RvX2RybQo+ID4gICAgICAgMiBzdHJ1Y3QgZHJtX2RldmljZSAqKmRkZXYKPiA+ICAg
ICAgIDIgc3RydWN0IGRybV9kZXZpY2UgKmRybV9kZXZfYWxsb2MKPiA+ICAgICAgIDIgc3RydWN0
IGRybV9kZXZpY2UgKm1vY2sKPiA+ICAgICAgIDIgc3RydWN0IGRybV9kZXZpY2UgKnBfZGRldgo+
ID4gICAgICAgNSBzdHJ1Y3QgZHJtX2RldmljZSAqZGV2aWNlCj4gPiAgICAgICA5IHN0cnVjdCBk
cm1fZGV2aWNlICogZGV2Cj4gPiAgICAgIDI1IHN0cnVjdCBkcm1fZGV2aWNlICpkCj4gPiAgICAg
IDk1IHN0cnVjdCBkcm1fZGV2aWNlICoKPiA+ICAgICAyMTYgc3RydWN0IGRybV9kZXZpY2UgKmRk
ZXYKPiA+ICAgICAyMzQgc3RydWN0IGRybV9kZXZpY2UgKmRybV9kZXYKPiA+ICAgICA2MTEgc3Ry
dWN0IGRybV9kZXZpY2UgKmRybQo+ID4gICAgNDE5MCBzdHJ1Y3QgZHJtX2RldmljZSAqZGV2Cj4g
Pgo+ID4gVGhpcyBzZXJpZXMgc3RhcnRzIHdpdGggcmVuYW1pbmcgc3RydWN0IGRybV9jcnRjOjpk
ZXYgdG8gZHJtX2Rldi4gSWYKPiA+IGl0J3Mgbm90IG9ubHkgbWUgYW5kIG90aGVycyBsaWtlIHRo
ZSByZXN1bHQgb2YgdGhpcyBlZmZvcnQgaXQgc2hvdWxkIGJlCj4gPiBmb2xsb3dlZCB1cCBieSBh
ZGFwdGluZyB0aGUgb3RoZXIgc3RydWN0cyBhbmQgdGhlIGluZGl2aWR1YWwgdXNhZ2VzIGluCj4g
PiB0aGUgZGlmZmVyZW50IGRyaXZlcnMuCj4KPiBJIHRoaW5rIHRoaXMgaXMgYW4gdW5uZWNlc3Nh
cnkgY2hhbmdlLiBJbiBkcm0sIGEgZGV2IGlzIHVzdWFsbHkgYSBkcm0KPiBkZXZpY2UsIGkuZS4g
c3RydWN0IGRybV9kZXZpY2UgKi4gQXMgc2hvd24gYnkgdGhlIG51bWJlcnMgYWJvdmUuCj4KCkkn
ZCByZWFsbHkgcHJlZmVyIHRoaXMgcGF0Y2ggKHNlcmllcyBvciBzaW5nbGUpIGlzIG5vdCBhY2Nl
cHRlZC4gVGhpcwp3aWxsIGNhdXNlIHByb2JsZW1zIGZvciBldmVyeW9uZSBjaGVycnktcGlja2lu
ZyBwYXRjaGVzIHRvIGEKZG93bnN0cmVhbSBrZXJuZWwgKExUUyBvciBkaXN0cm8gdHJlZSkuIEkg
dXN1YWxseSB3b3VsZG4ndCBleHBlY3QKc3ltcGF0aHkgaGVyZSwgYnV0IHRoZSBxdWVzdGlvbmFi
bGUgYmVuZWZpdCBkb2VzIG5vdCBvdXR3ZWlnaCB0aGUgY29zdApJTVtiaWFzZWRdTy4KClNlYW4K
Cj4gSWYgZm9sa3MgaW5zaXN0IG9uIGZvbGxvd2luZyB0aHJvdWdoIHdpdGggdGhpcyBhbnl3YXks
IEknbSBmaXJtbHkgaW4gdGhlCj4gY2FtcCB0aGUgbmFtZSBzaG91bGQgYmUgImRybSIgYW5kIG5v
dGhpbmcgZWxzZS4KPgo+Cj4gQlIsCj4gSmFuaS4KPgo+Cj4gLS0KPiBKYW5pIE5pa3VsYSwgSW50
ZWwgT3BlbiBTb3VyY2UgR3JhcGhpY3MgQ2VudGVyCl9fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fClZpcnR1YWxpemF0aW9uIG1haWxpbmcgbGlzdApWaXJ0dWFs
aXphdGlvbkBsaXN0cy5saW51eC1mb3VuZGF0aW9uLm9yZwpodHRwczovL2xpc3RzLmxpbnV4Zm91
bmRhdGlvbi5vcmcvbWFpbG1hbi9saXN0aW5mby92aXJ0dWFsaXphdGlvbg==
