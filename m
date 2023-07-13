Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A53FDEB64DD
	for <virtualization@archiver.kernel.org>; Thu, 13 Jul 2023 06:52:59 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 13E6C404ED;
	Thu, 13 Jul 2023 06:52:59 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org 13E6C404ED
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
	by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id pxmRs3byG3Kd; Thu, 13 Jul 2023 06:52:57 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp4.osuosl.org (Postfix) with ESMTPS id 0CD63400BD;
	Thu, 13 Jul 2023 06:52:57 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org 0CD63400BD
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id D0C8CC0071;
	Thu, 13 Jul 2023 06:52:56 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [IPv6:2605:bc80:3010::136])
 by lists.linuxfoundation.org (Postfix) with ESMTP id B1BB8C0032
 for <virtualization@lists.linux-foundation.org>;
 Thu, 13 Jul 2023 06:52:54 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id 7716E6129D
 for <virtualization@lists.linux-foundation.org>;
 Thu, 13 Jul 2023 06:52:54 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 7716E6129D
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id cprpMzbQ4UTm
 for <virtualization@lists.linux-foundation.org>;
 Thu, 13 Jul 2023 06:52:53 +0000 (UTC)
X-Greylist: whitelisted by SQLgrey-1.8.0
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 143DE61298
Received: from mail-qt1-f172.google.com (mail-qt1-f172.google.com
 [209.85.160.172])
 by smtp3.osuosl.org (Postfix) with ESMTPS id 143DE61298
 for <virtualization@lists.linux-foundation.org>;
 Thu, 13 Jul 2023 06:52:52 +0000 (UTC)
Received: by mail-qt1-f172.google.com with SMTP id
 d75a77b69052e-403c8c48255so3915061cf.3
 for <virtualization@lists.linux-foundation.org>;
 Wed, 12 Jul 2023 23:52:52 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1689231171; x=1691823171;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=a+0qanWxODhzgXHCXIxDgPeQhxCw3xhLkeN7rWN/J3A=;
 b=RfN7wleWyViOjXwOUIcLZIA87y9IQVoWQqoO3PoB0F2BWLhrkxjH9qGEnFtoFmyVh9
 E8173PQrTFeirn0YAlqyujSuXcrXp55Kf24fKekJsgNCbh4MRhlfH3NUsDTC5vUJfV82
 5gxvjO/ve74CLxzo3JhICfxCSnIsXfgw88GqePgIfZPJE1FGs7wXMzoDn0Bb+qdsj928
 dyJlfzZQscSPg0DDA2Dx3aa6KxcbAJvTlZ29j+4zcRGF242PfUljSbCtcnkhrEeHZz7w
 EaTTnp2DK92lG3j9lKkmd80nC5pqrTqjBMUlu+0l1ziBmF3LnDPvjFRdxp2Y/BBTz1+u
 CD/Q==
X-Gm-Message-State: ABy/qLYTIl7G59P3PGNZbiEoskmvv3V0OcAHoArUylrL72dndJ2/ECdG
 Rh0U99WFXSCGqwosw/cADqZcQXfejIKuAPQ/
X-Google-Smtp-Source: APBJJlF/oz+gUtA1BwGNrQSx1FJlIVFYxFjxSCIoj33SS5EIFtU80ZrfBmn5uwt0H2S8oGdBnF5ing==
X-Received: by 2002:ac8:5703:0:b0:403:cbdf:14b8 with SMTP id
 3-20020ac85703000000b00403cbdf14b8mr1119461qtw.22.1689231171522; 
 Wed, 12 Jul 2023 23:52:51 -0700 (PDT)
Received: from mail-qk1-f171.google.com (mail-qk1-f171.google.com.
 [209.85.222.171]) by smtp.gmail.com with ESMTPSA id
 d28-20020a0caa1c000000b0062119a7a7a3sm2890392qvb.4.2023.07.12.23.52.50
 for <virtualization@lists.linux-foundation.org>
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 12 Jul 2023 23:52:50 -0700 (PDT)
Received: by mail-qk1-f171.google.com with SMTP id
 af79cd13be357-763a2e39b88so41840485a.1
 for <virtualization@lists.linux-foundation.org>;
 Wed, 12 Jul 2023 23:52:50 -0700 (PDT)
X-Received: by 2002:a0d:e208:0:b0:56d:9e2:7d9e with SMTP id
 l8-20020a0de208000000b0056d09e27d9emr931586ywe.21.1689231149403; Wed, 12 Jul
 2023 23:52:29 -0700 (PDT)
MIME-Version: 1.0
References: <20230712094702.1770121-1-u.kleine-koenig@pengutronix.de>
 <87fs5tgpvv.fsf@intel.com> <20230712161025.22op3gtzgujrhytb@pengutronix.de>
In-Reply-To: <20230712161025.22op3gtzgujrhytb@pengutronix.de>
From: Geert Uytterhoeven <geert@linux-m68k.org>
Date: Thu, 13 Jul 2023 08:52:12 +0200
X-Gmail-Original-Message-ID: <CAMuHMdWuvkxcj05OTfEn5f2p-6e71QEHVjSLWwNFRnR_=WEJVQ@mail.gmail.com>
Message-ID: <CAMuHMdWuvkxcj05OTfEn5f2p-6e71QEHVjSLWwNFRnR_=WEJVQ@mail.gmail.com>
Subject: Re: [PATCH RFC v1 00/52] drm/crtc: Rename struct drm_crtc::dev to
 drm_dev
To: =?UTF-8?Q?Uwe_Kleine=2DK=C3=B6nig?= <u.kleine-koenig@pengutronix.de>
Cc: =?UTF-8?Q?Heiko_St=C3=BCbner?= <heiko@sntech.de>,
 Geert Uytterhoeven <geert+renesas@glider.be>,
 Xinliang Liu <xinliang.liu@linaro.org>,
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
 =?UTF-8?Q?Noralf_Tr=C3=B8nnes?= <noralf@tronnes.org>, kernel@pengutronix.de,
 Alex Deucher <alexander.deucher@amd.com>, freedreno@lists.freedesktop.org,
 Claudiu Beznea <claudiu.beznea@microchip.com>, Zack Rusin <zackr@vmware.com>,
 Alexandre Belloni <alexandre.belloni@bootlin.com>,
 linux-aspeed@lists.ozlabs.org, nouveau@lists.freedesktop.org,
 Mitul Golani <mitulkumar.ajitkumar.golani@intel.com>,
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
 Maxime Coquelin <mcoquelin.stm32@gmail.com>,
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
 Joel Stanley <joel@jms.id.au>, Philipp Zabel <p.zabel@pengutronix.de>,
 Ankit Nautiyal <ankit.k.nautiyal@intel.com>,
 Harry Wentland <harry.wentland@amd.com>,
 Sumit Semwal <sumit.semwal@linaro.org>, Alan Liu <haoping.liu@amd.com>,
 Philip Yang <Philip.Yang@amd.com>, Lyude Paul <lyude@redhat.com>,
 intel-gfx@lists.freedesktop.org, Alison Wang <alison.wang@nxp.com>,
 Wolfram Sang <wsa+renesas@sang-engineering.com>,
 Abhinav Kumar <quic_abhinavk@quicinc.com>,
 Gustavo Sousa <gustavo.sousa@intel.com>,
 Baolin Wang <baolin.wang@linux.alibaba.com>,
 Rodrigo Vivi <rodrigo.vivi@intel.com>, Mikko Perttunen <mperttunen@nvidia.com>,
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
 Russell King <linux@armlinux.org.uk>, Jani Nikula <jani.nikula@intel.com>,
 Uma Shankar <uma.shankar@intel.com>, Mika Kahola <mika.kahola@intel.com>,
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

SGkgVXdlLAoKTGV0J3MgYWRkIHNvbWUgZnVlbCB0byBrZWVwIHRoZSB0aHJlYWQgYWxpdmUgOy0p
CgpPbiBXZWQsIEp1bCAxMiwgMjAyMyBhdCA2OjEz4oCvUE0gVXdlIEtsZWluZS1Lw7ZuaWcKPHUu
a2xlaW5lLWtvZW5pZ0BwZW5ndXRyb25peC5kZT4gd3JvdGU6Cj4gT24gV2VkLCBKdWwgMTIsIDIw
MjMgYXQgMDU6MzQ6MjhQTSArMDMwMCwgSmFuaSBOaWt1bGEgd3JvdGU6Cj4gPiBPbiBXZWQsIDEy
IEp1bCAyMDIzLCBVd2UgS2xlaW5lLUvDtm5pZyA8dS5rbGVpbmUta29lbmlnQHBlbmd1dHJvbml4
LmRlPiB3cm90ZToKPiA+ID4gSGVsbG8sCj4gPiA+Cj4gPiA+IHdoaWxlIEkgZGVidWdnZWQgYW4g
aXNzdWUgaW4gdGhlIGlteC1sY2RjIGRyaXZlciBJIHdhcyBjb25zdGFudGx5Cj4gPiA+IGlycml0
YXRlZCBhYm91dCBzdHJ1Y3QgZHJtX2RldmljZSBwb2ludGVyIHZhcmlhYmxlcyBiZWluZyBuYW1l
ZCAiZGV2Igo+ID4gPiBiZWNhdXNlIHdpdGggdGhhdCBuYW1lIEkgdXN1YWxseSBleHBlY3QgYSBz
dHJ1Y3QgZGV2aWNlIHBvaW50ZXIuCj4gPiA+Cj4gPiA+IEkgdGhpbmsgdGhlcmUgaXMgYSBiaWcg
YmVuZWZpdCB3aGVuIHRoZXNlIGFyZSBhbGwgcmVuYW1lZCB0byAiZHJtX2RldiIuCj4gPiA+IEkg
aGF2ZSBubyBzdHJvbmcgcHJlZmVyZW5jZSBoZXJlIHRob3VnaCwgc28gImRybWRldiIgb3IgImRy
bSIgYXJlIGZpbmUKPiA+ID4gZm9yIG1lLCB0b28uIExldCB0aGUgYmlrZXNoZWRpbmcgYmVnaW4h
Cj4gPiA+Cj4gPiA+IFNvbWUgc3RhdGlzdGljczoKPiA+ID4KPiA+ID4gJCBnaXQgZ3JlcCAtb2hF
ICdzdHJ1Y3QgZHJtX2RldmljZSAqXCogKlteICgpLDtdKicgdjYuNS1yYzEgfCBzb3J0IHwgdW5p
cSAtYyB8IHNvcnQgLW4KPiA+ID4gICAgICAgMSBzdHJ1Y3QgZHJtX2RldmljZSAqYWRldl90b19k
cm0KPiA+ID4gICAgICAgMSBzdHJ1Y3QgZHJtX2RldmljZSAqZHJtXwo+ID4gPiAgICAgICAxIHN0
cnVjdCBkcm1fZGV2aWNlICAgICAgICAgICpkcm1fZGV2Cj4gPiA+ICAgICAgIDEgc3RydWN0IGRy
bV9kZXZpY2UgICAgICAgICpkcm1fZGV2Cj4gPiA+ICAgICAgIDEgc3RydWN0IGRybV9kZXZpY2Ug
KnBkZXYKPiA+ID4gICAgICAgMSBzdHJ1Y3QgZHJtX2RldmljZSAqcmRldgo+ID4gPiAgICAgICAx
IHN0cnVjdCBkcm1fZGV2aWNlICp2ZGV2Cj4gPiA+ICAgICAgIDIgc3RydWN0IGRybV9kZXZpY2Ug
KmRjc3NfZHJ2X2Rldl90b19kcm0KPiA+ID4gICAgICAgMiBzdHJ1Y3QgZHJtX2RldmljZSAqKmRk
ZXYKPiA+ID4gICAgICAgMiBzdHJ1Y3QgZHJtX2RldmljZSAqZHJtX2Rldl9hbGxvYwo+ID4gPiAg
ICAgICAyIHN0cnVjdCBkcm1fZGV2aWNlICptb2NrCj4gPiA+ICAgICAgIDIgc3RydWN0IGRybV9k
ZXZpY2UgKnBfZGRldgo+ID4gPiAgICAgICA1IHN0cnVjdCBkcm1fZGV2aWNlICpkZXZpY2UKPiA+
ID4gICAgICAgOSBzdHJ1Y3QgZHJtX2RldmljZSAqIGRldgo+ID4gPiAgICAgIDI1IHN0cnVjdCBk
cm1fZGV2aWNlICpkCj4gPiA+ICAgICAgOTUgc3RydWN0IGRybV9kZXZpY2UgKgo+ID4gPiAgICAg
MjE2IHN0cnVjdCBkcm1fZGV2aWNlICpkZGV2Cj4gPiA+ICAgICAyMzQgc3RydWN0IGRybV9kZXZp
Y2UgKmRybV9kZXYKPiA+ID4gICAgIDYxMSBzdHJ1Y3QgZHJtX2RldmljZSAqZHJtCj4gPiA+ICAg
IDQxOTAgc3RydWN0IGRybV9kZXZpY2UgKmRldgo+ID4gPgo+ID4gPiBUaGlzIHNlcmllcyBzdGFy
dHMgd2l0aCByZW5hbWluZyBzdHJ1Y3QgZHJtX2NydGM6OmRldiB0byBkcm1fZGV2LiBJZgo+ID4g
PiBpdCdzIG5vdCBvbmx5IG1lIGFuZCBvdGhlcnMgbGlrZSB0aGUgcmVzdWx0IG9mIHRoaXMgZWZm
b3J0IGl0IHNob3VsZCBiZQo+ID4gPiBmb2xsb3dlZCB1cCBieSBhZGFwdGluZyB0aGUgb3RoZXIg
c3RydWN0cyBhbmQgdGhlIGluZGl2aWR1YWwgdXNhZ2VzIGluCj4gPiA+IHRoZSBkaWZmZXJlbnQg
ZHJpdmVycy4KPiA+Cj4gPiBJIHRoaW5rIHRoaXMgaXMgYW4gdW5uZWNlc3NhcnkgY2hhbmdlLiBJ
biBkcm0sIGEgZGV2IGlzIHVzdWFsbHkgYSBkcm0KPiA+IGRldmljZSwgaS5lLiBzdHJ1Y3QgZHJt
X2RldmljZSAqLgo+Cj4gV2VsbCwgdW5sZXNzIGl0J3Mgbm90LiBQcm9taW5lbnRseSB0aGVyZSBp
cwo+Cj4gICAgICAgICBzdHJ1Y3QgZHJtX2RldmljZSB7Cj4gICAgICAgICAgICAgICAgIC4uLgo+
ICAgICAgICAgICAgICAgICBzdHJ1Y3QgZGV2aWNlICpkZXY7Cj4gICAgICAgICAgICAgICAgIC4u
Lgo+ICAgICAgICAgfTsKPgo+IHdoaWNoIHlpZWxkcyBxdWl0ZSBhIGZldyBjb2RlIGxvY2F0aW9u
cyB1c2luZyBkZXYtPmRldiB3aGljaCBpcwo+IElNSE8gdW5uZWNlc3NhcnkgaXJyaXRhdGluZzoK
Pgo+ICAgICAgICAgJCBnaXQgZ3JlcCAnXDxkZXYtPmRldicgdjYuNS1yYzEgZHJpdmVycy9ncHUv
ZHJtIHwgd2MgLWwKPiAgICAgICAgIDE2MzMKCkkgZmluZCB0aGF0IGlycml0YXRpbmcgYXMgd2Vs
bC4uLgoKU2FtZSBmb3IgZS5nLiBjcnRjLT5jcnRjLgoKSGVuY2UgdGhhdCdzIHdoeSBJIGhhZCBz
ZW50IHBhdGNoZXMgdG8gcmVuYW1lIHRoZSBiYXNlIG1lbWJlcnMgaW4gdGhlCnNobW9iX2RybS1z
cGVjaWZpYyBzdWJjbGFzc2VzIG9mIGRybV97Y3J0Yyxjb25uZWN0b3IscGxhbmV9IHRvICJiYXNl
Ii4KaHR0cHM6Ly9sb3JlLmtlcm5lbC5vcmcvZHJpLWRldmVsL2IzZGFjYTgwZjgyNjI1YmExNGUz
YWVhZjJmY2E2ZGNlZmEwNTZlNDcuMTY4NzQyMzIwNC5naXQuZ2VlcnQrcmVuZXNhc0BnbGlkZXIu
YmUKCj4gQWxzbyB0aGUgZnVuY3Rpb25zIHRoYXQgZGVhbCB3aXRoIGJvdGggYSBzdHJ1Y3QgZGV2
aWNlIGFuZCBhIHN0cnVjdAo+IGRybV9kZXZpY2Ugb2Z0ZW4gdXNlICJkZXYiIGZvciB0aGUgc3Ry
dWN0IGRldmljZSBhbmQgdGhlbiAiZGRldiIgZm9yCj4gdGhlIGRybV9kZXZpY2UgKHNlZSBmb3Ig
ZXhhbXBsZSBhbWRncHVfZGV2aWNlX2dldF9wY2llX3JlcGxheV9jb3VudCgpKS4KCkkgZ3Vlc3Mg
eW91IGNvbnNpZGVyZWQgImRybV9kZXYiLCBiZWNhdXNlIGl0IGlzIHN0aWxsIGEgc2hvcnQgbmFt
ZT8KQ29kZSBkZWFsaW5nIHdpdGggcGxhdGZvcm0gZGV2aWNlcyB1c3VhbGx5IHVzZXMgInBkZXYi
IGFuZCAiZGV2Ii4KU2FtZSBmb3IgUENJIGRyaXZlcnMgKGRlc3BpdGUgInBjaV9kZXYiIGJlaW5n
IGEgc2hvcnQgbmFtZSkuCgpTbyBteSBwZXJzb25hbCBwcmVmZXJlbmNlIGdvZXMgdG8gImRkZXYi
LgoKRU9GIChFbmQtb2YtRnVlbCA7LSkKCkdye29ldGplLGVldGluZ31zLAoKICAgICAgICAgICAg
ICAgICAgICAgICAgR2VlcnQKCi0tIApHZWVydCBVeXR0ZXJob2V2ZW4gLS0gVGhlcmUncyBsb3Rz
IG9mIExpbnV4IGJleW9uZCBpYTMyIC0tIGdlZXJ0QGxpbnV4LW02OGsub3JnCgpJbiBwZXJzb25h
bCBjb252ZXJzYXRpb25zIHdpdGggdGVjaG5pY2FsIHBlb3BsZSwgSSBjYWxsIG15c2VsZiBhIGhh
Y2tlci4gQnV0CndoZW4gSSdtIHRhbGtpbmcgdG8gam91cm5hbGlzdHMgSSBqdXN0IHNheSAicHJv
Z3JhbW1lciIgb3Igc29tZXRoaW5nIGxpa2UgdGhhdC4KICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAtLSBMaW51cyBUb3J2YWxkcwpfX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fXwpWaXJ0dWFsaXphdGlvbiBtYWlsaW5nIGxpc3QKVmlydHVhbGl6YXRp
b25AbGlzdHMubGludXgtZm91bmRhdGlvbi5vcmcKaHR0cHM6Ly9saXN0cy5saW51eGZvdW5kYXRp
b24ub3JnL21haWxtYW4vbGlzdGluZm8vdmlydHVhbGl6YXRpb24=
