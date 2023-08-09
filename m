Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DA3E5EB64DD
	for <virtualization@archiver.kernel.org>; Wed,  9 Aug 2023 13:11:45 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 69E4782BED;
	Wed,  9 Aug 2023 13:11:45 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 69E4782BED
Authentication-Results: smtp1.osuosl.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20221208 header.b=X39VyQ81
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
	by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id WlMcyAFJhZWd; Wed,  9 Aug 2023 13:11:44 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp1.osuosl.org (Postfix) with ESMTPS id F40DF827D9;
	Wed,  9 Aug 2023 13:11:43 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org F40DF827D9
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id D23E9C0072;
	Wed,  9 Aug 2023 13:11:43 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by lists.linuxfoundation.org (Postfix) with ESMTP id DF5DBC0032
 for <virtualization@lists.linux-foundation.org>;
 Wed,  9 Aug 2023 13:11:42 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id A390D4186F
 for <virtualization@lists.linux-foundation.org>;
 Wed,  9 Aug 2023 13:11:42 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org A390D4186F
Authentication-Results: smtp4.osuosl.org;
 dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com
 header.a=rsa-sha256 header.s=20221208 header.b=X39VyQ81
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id 5yyBBBRSozgE
 for <virtualization@lists.linux-foundation.org>;
 Wed,  9 Aug 2023 13:11:41 +0000 (UTC)
Received: from mail-ot1-x32d.google.com (mail-ot1-x32d.google.com
 [IPv6:2607:f8b0:4864:20::32d])
 by smtp4.osuosl.org (Postfix) with ESMTPS id 4C2BD4186A
 for <virtualization@lists.linux-foundation.org>;
 Wed,  9 Aug 2023 13:11:41 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org 4C2BD4186A
Received: by mail-ot1-x32d.google.com with SMTP id
 46e09a7af769-6bd06470b68so550954a34.1
 for <virtualization@lists.linux-foundation.org>;
 Wed, 09 Aug 2023 06:11:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20221208; t=1691586700; x=1692191500;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=0bsfHSbir+1N3BPwsEF83+v9jo06cZjJVauWxQE2x88=;
 b=X39VyQ81ASYk/nBdQF2k0zkOJr/0vtM4ZpjXBKvnXgqH0R4bVOzYwN862VOzrR+xcj
 x3FpupRMsRy7LDq7LpyqF25wC6tbW75E04I9YjPO14TSPjRX6C5prULvlJsGvEEptNVm
 +KaJ1dgo9yDYvvU9xgG4hPh/jBo2jN+cWTaB9vM2sw0taGzXVXkI09vm9gjv3YdsbQfq
 fVPylz6eN+KR5L6QcKAbs2scRSlOmKkbZMpF9eiAuRUCeeiue3+fNiq6cua13K7CE3MR
 iwhCAiADw5MAtzoz2nRqhIRpteROYyPsV+/Zu+9qMzuIk9n/JNtv02kFrJu5jM+1rnUx
 ohVA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1691586700; x=1692191500;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=0bsfHSbir+1N3BPwsEF83+v9jo06cZjJVauWxQE2x88=;
 b=Y/yopuaKgGkMgOROGLVW8PSqjoPsmbaXiRPnfyJbhya+Ti30cKrdrASECIAgr/K0f6
 t+8G+kOrC8ASmp4aU/YKZN9CljXJ6klQiHcDyODbzmnNmxZZrrsoJIBoGlRZd5Lesct5
 DoO7UqnL9j4jS7sLRrNQbKH2iAhrqpKb9mxbOxa56ABcrMUL0uTwL/Uptqdi3XTdp8m3
 aJWyGLsjUSV3ZnKg55IMpuU71LZsZ/Xat3mApNBx7L/E67DEQGbZ4r2b/2CsPLYVBO4t
 tdgtcM8HzxUxX5us77NXgs9MRhHjXCYS6r9PhG8/l7D6+hs2kGTdhd7e5YJylv+wlcVc
 EBHQ==
X-Gm-Message-State: AOJu0Yxtu1YqOhihrXBrDtm6JX0phFKbLA4wTXCxwq/rSBF996utrLou
 4uumlLKTZeoh1ZcG7q25np7QEn0NNRnCJQi05/g=
X-Google-Smtp-Source: AGHT+IGr/N7x0qp/tLHJD9vnx3F+mQLn8Qo3mYlXKDAIof/DZHtBXv2c6gcV9z6BHmLltXrWKyQrwzMGuJze0KPjlPM=
X-Received: by 2002:aca:bb0b:0:b0:3a7:46c4:e8cd with SMTP id
 l11-20020acabb0b000000b003a746c4e8cdmr8330814oif.12.1691586700314; Wed, 09
 Aug 2023 06:11:40 -0700 (PDT)
MIME-Version: 1.0
References: <20230809034445.434902-1-ruanjinjie@huawei.com>
 <20230809034445.434902-2-ruanjinjie@huawei.com>
 <c2b0d96e-b768-b295-c672-3ae52e14b10b@amd.com>
In-Reply-To: <c2b0d96e-b768-b295-c672-3ae52e14b10b@amd.com>
From: Alex Deucher <alexdeucher@gmail.com>
Date: Wed, 9 Aug 2023 09:11:29 -0400
Message-ID: <CADnq5_MZXYBmxr3dJn4vmW2qAbzUDM0eL48anjCot77LinE8tg@mail.gmail.com>
Subject: Re: [PATCH -next 1/7] drm/amdkfd: Remove unnecessary NULL values
To: =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>
Cc: kherbst@redhat.com, wenjing.liu@amd.com, dri-devel@lists.freedesktop.org,
 gurchetansingh@chromium.org, mairacanal@riseup.net, alim.akhtar@samsung.com,
 marijn.suijten@somainline.org, airlied@gmail.com, arthurgrillo@riseup.net,
 Charlene.Liu@amd.com, linux-samsung-soc@vger.kernel.org,
 Ruan Jinjie <ruanjinjie@huawei.com>, Rodrigo.Siqueira@amd.com,
 krzysztof.kozlowski@linaro.org, amd-gfx@lists.freedesktop.org,
 quic_vpolimer@quicinc.com, tony.tascioglu@amd.com, aurabindo.pillai@amd.com,
 bskeggs@redhat.com, george.shen@amd.com, kyungmin.park@samsung.com,
 harry.wentland@amd.com, olvaffe@gmail.com, haoping.liu@amd.com,
 lyude@redhat.com, daniel@ffwll.ch, javierm@redhat.com, sunpeng.li@amd.com,
 linux-arm-msm@vger.kernel.org, jiasheng@iscas.ac.cn,
 maarten.lankhorst@linux.intel.com, quic_abhinavk@quicinc.com,
 mripard@kernel.org, inki.dae@samsung.com, alexander.deucher@amd.com,
 davidgow@google.com, nouveau@lists.freedesktop.org,
 virtualization@lists.linux-foundation.org, sean@poorly.run,
 linux-arm-kernel@lists.infradead.org, noralf@tronnes.org,
 paulo.miguel.almeida.rodenas@gmail.com, chiahsuan.chung@amd.com, drv@mailo.com,
 tales.aparecida@gmail.com, Felix.Kuehling@amd.com, Xinhui.Pan@amd.com,
 sw0312.kim@samsung.com, robdclark@gmail.com, jaehyun.chung@amd.com,
 tzimmermann@suse.de, dmitry.baryshkov@linaro.org, jose.exposito89@gmail.com,
 freedreno@lists.freedesktop.org, sancchen@amd.com
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

QXBwbGllZC4gIFRoYW5rcyEKCk9uIFdlZCwgQXVnIDksIDIwMjMgYXQgMjoxNeKAr0FNIENocmlz
dGlhbiBLw7ZuaWcgPGNocmlzdGlhbi5rb2VuaWdAYW1kLmNvbT4gd3JvdGU6Cj4KPiBBbSAwOS4w
OC4yMyB1bSAwNTo0NCBzY2hyaWViIFJ1YW4gSmluamllOgo+ID4gVGhlIE5VTEwgaW5pdGlhbGl6
YXRpb24gb2YgdGhlIHBvaW50ZXJzIGFzc2lnbmVkIGJ5IGt6YWxsb2MoKSBmaXJzdCBpcwo+ID4g
bm90IG5lY2Vzc2FyeSwgYmVjYXVzZSBpZiB0aGUga3phbGxvYygpIGZhaWxlZCwgdGhlIHBvaW50
ZXJzIHdpbGwgYmUKPiA+IGFzc2lnbmVkIE5VTEwsIG90aGVyd2lzZSBpdCB3b3JrcyBhcyB1c3Vh
bC4gc28gcmVtb3ZlIGl0Lgo+ID4KPiA+IFNpZ25lZC1vZmYtYnk6IFJ1YW4gSmluamllIDxydWFu
amluamllQGh1YXdlaS5jb20+Cj4KPiBSZXZpZXdlZC1ieTogQ2hyaXN0aWFuIEvDtm5pZyA8Y2hy
aXN0aWFuLmtvZW5pZ0BhbWQuY29tPiBmb3IgdGhpcyBvbmUsCj4gdGhlIGFtZCBkaXNwbGF5IGNv
ZGUgYW5kIHRoZSByYWRlb24gc3R1ZmYuCj4KPiBUaGFua3MsCj4gQ2hyaXN0aWFuLgo+Cj4gPiAt
LS0KPiA+ICAgZHJpdmVycy9ncHUvZHJtL2FtZC9hbWRrZmQva2ZkX21xZF9tYW5hZ2VyLmMgfCA0
ICsrLS0KPiA+ICAgMSBmaWxlIGNoYW5nZWQsIDIgaW5zZXJ0aW9ucygrKSwgMiBkZWxldGlvbnMo
LSkKPiA+Cj4gPiBkaWZmIC0tZ2l0IGEvZHJpdmVycy9ncHUvZHJtL2FtZC9hbWRrZmQva2ZkX21x
ZF9tYW5hZ2VyLmMgYi9kcml2ZXJzL2dwdS9kcm0vYW1kL2FtZGtmZC9rZmRfbXFkX21hbmFnZXIu
Ywo+ID4gaW5kZXggODYzY2YwNjBhZjQ4Li5kMDFiYjU3NzMzYjMgMTAwNjQ0Cj4gPiAtLS0gYS9k
cml2ZXJzL2dwdS9kcm0vYW1kL2FtZGtmZC9rZmRfbXFkX21hbmFnZXIuYwo+ID4gKysrIGIvZHJp
dmVycy9ncHUvZHJtL2FtZC9hbWRrZmQva2ZkX21xZF9tYW5hZ2VyLmMKPiA+IEBAIC00OCw3ICs0
OCw3IEBAIGludCBwaXBlX3ByaW9yaXR5X21hcFtdID0gewo+ID4KPiA+ICAgc3RydWN0IGtmZF9t
ZW1fb2JqICphbGxvY2F0ZV9oaXFfbXFkKHN0cnVjdCBrZmRfbm9kZSAqZGV2LCBzdHJ1Y3QgcXVl
dWVfcHJvcGVydGllcyAqcSkKPiA+ICAgewo+ID4gLSAgICAgc3RydWN0IGtmZF9tZW1fb2JqICpt
cWRfbWVtX29iaiA9IE5VTEw7Cj4gPiArICAgICBzdHJ1Y3Qga2ZkX21lbV9vYmogKm1xZF9tZW1f
b2JqOwo+ID4KPiA+ICAgICAgIG1xZF9tZW1fb2JqID0ga3phbGxvYyhzaXplb2Yoc3RydWN0IGtm
ZF9tZW1fb2JqKSwgR0ZQX0tFUk5FTCk7Cj4gPiAgICAgICBpZiAoIW1xZF9tZW1fb2JqKQo+ID4g
QEAgLTY0LDcgKzY0LDcgQEAgc3RydWN0IGtmZF9tZW1fb2JqICphbGxvY2F0ZV9oaXFfbXFkKHN0
cnVjdCBrZmRfbm9kZSAqZGV2LCBzdHJ1Y3QgcXVldWVfcHJvcGVydGkKPiA+ICAgc3RydWN0IGtm
ZF9tZW1fb2JqICphbGxvY2F0ZV9zZG1hX21xZChzdHJ1Y3Qga2ZkX25vZGUgKmRldiwKPiA+ICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgc3RydWN0IHF1ZXVlX3Byb3BlcnRp
ZXMgKnEpCj4gPiAgIHsKPiA+IC0gICAgIHN0cnVjdCBrZmRfbWVtX29iaiAqbXFkX21lbV9vYmog
PSBOVUxMOwo+ID4gKyAgICAgc3RydWN0IGtmZF9tZW1fb2JqICptcWRfbWVtX29iajsKPiA+ICAg
ICAgIHVpbnQ2NF90IG9mZnNldDsKPiA+Cj4gPiAgICAgICBtcWRfbWVtX29iaiA9IGt6YWxsb2Mo
c2l6ZW9mKHN0cnVjdCBrZmRfbWVtX29iaiksIEdGUF9LRVJORUwpOwo+Cl9fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fClZpcnR1YWxpemF0aW9uIG1haWxpbmcg
bGlzdApWaXJ0dWFsaXphdGlvbkBsaXN0cy5saW51eC1mb3VuZGF0aW9uLm9yZwpodHRwczovL2xp
c3RzLmxpbnV4Zm91bmRhdGlvbi5vcmcvbWFpbG1hbi9saXN0aW5mby92aXJ0dWFsaXphdGlvbg==
