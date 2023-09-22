Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4DF0FCD4847
	for <virtualization@archiver.kernel.org>; Fri, 22 Sep 2023 17:42:10 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id B405082112;
	Fri, 22 Sep 2023 17:42:09 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org B405082112
Authentication-Results: smtp1.osuosl.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20230601 header.b=OyDCk/e8
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
	by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id fT9M5ddER9ZK; Fri, 22 Sep 2023 17:42:08 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp1.osuosl.org (Postfix) with ESMTPS id 91810820A2;
	Fri, 22 Sep 2023 17:42:07 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 91810820A2
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 6C350C0071;
	Fri, 22 Sep 2023 17:42:07 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 3761CC0032
 for <virtualization@lists.linux-foundation.org>;
 Fri, 22 Sep 2023 17:42:06 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id 045F1610E2
 for <virtualization@lists.linux-foundation.org>;
 Fri, 22 Sep 2023 17:42:06 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 045F1610E2
Authentication-Results: smtp3.osuosl.org;
 dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com
 header.a=rsa-sha256 header.s=20230601 header.b=OyDCk/e8
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id QUsYRB8XO-AH
 for <virtualization@lists.linux-foundation.org>;
 Fri, 22 Sep 2023 17:42:03 +0000 (UTC)
Received: from mail-oo1-xc32.google.com (mail-oo1-xc32.google.com
 [IPv6:2607:f8b0:4864:20::c32])
 by smtp3.osuosl.org (Postfix) with ESMTPS id BAD9D61084
 for <virtualization@lists.linux-foundation.org>;
 Fri, 22 Sep 2023 17:42:03 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org BAD9D61084
Received: by mail-oo1-xc32.google.com with SMTP id
 006d021491bc7-573249e73f8so1379721eaf.1
 for <virtualization@lists.linux-foundation.org>;
 Fri, 22 Sep 2023 10:42:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1695404522; x=1696009322;
 darn=lists.linux-foundation.org; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=XekgGSaX3ptkpR/7Vl4AaE79EkIJG3ApSeSAmfaaNYY=;
 b=OyDCk/e8VcSM2F9SaYEiAOWcmXE4ArYLNDQ90v/VDPNmoGO65D8RCwEZx/StdellYP
 941DZ+W5NDXKNQujystiyUpxelGffGBXg0z0aFzqFY3tmWv0gyhAZecWgfQ7aCgz7jlR
 rxMy36ycg3bJLp/xDHRY0OAyn8V4xWfALEWOrzXn2LCQOb6E1vAMI0eNsUpJs81tUH78
 9so/zxeY7BeDNBkqfHbUUyWSuO9vRhr8sB1GmlcNcaq7LhzxLf/fGXw/Ai3zdqXpbsKw
 54NyGJEhBXJZuACgZoiDcRyQdm+hKFPJFsTFM8/w/BskxTgmE8Y2xhVr/1BSl7cuLhgI
 Fj3A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1695404522; x=1696009322;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=XekgGSaX3ptkpR/7Vl4AaE79EkIJG3ApSeSAmfaaNYY=;
 b=eK9/o8iv7fYL7bcHrOZ5+P8B0PlGGrB4cNzTDjmS2SWWURa3bw9kZfJSomazrxBNN+
 eRxnY3j3ROos6XKJ+WAFgF2nLfaCosMMkRBgsUTwMX0lrQN7kyGTzsRoHiWq39sZUptH
 zgIIrOeyGkYOwIuZJBkU5RtQYc7ZcbxUlMiCdBYRDzwBvwRzKydJ8x2N1CTxNt+BNpiH
 qN/mEPYusaFnRXbH6KjFWos7WsBzuHuj5GMN3jmD/fHhKww9X0UmSjNYOoPFXo257v27
 P02xO0xgeXvgCjQvKuJ5/UKFUeSNW4i7/XBQZnY2TPTXsbx0zeI3evU/QBBYUuwx/mxI
 7uEQ==
X-Gm-Message-State: AOJu0YwHcl7sLlzGvyHNy9lD7ChMTdlDlJ5XF1p92KKpWGu2fWnxLKcv
 0CYNh2SNRTYEb70sJPyrLa0nLXCUIE5YkT3xAc0=
X-Google-Smtp-Source: AGHT+IG39K8OoDMaCogRuGeRtHy4kPLjYTbpmj4vuvYl6iT+u3RXeJQ2kVCIXH4X5mx+L+1FvNpYYUZbI2a21sY0YAA=
X-Received: by 2002:a05:6870:f689:b0:1d5:b9e1:d35e with SMTP id
 el9-20020a056870f68900b001d5b9e1d35emr103462oab.41.1695404522615; Fri, 22 Sep
 2023 10:42:02 -0700 (PDT)
MIME-Version: 1.0
References: <20230922173110.work.084-kees@kernel.org>
 <20230922173216.3823169-1-keescook@chromium.org>
In-Reply-To: <20230922173216.3823169-1-keescook@chromium.org>
From: Alex Deucher <alexdeucher@gmail.com>
Date: Fri, 22 Sep 2023 13:41:51 -0400
Message-ID: <CADnq5_P2p3bmczci=pU+pG6f9+hqn=-xp1EynP2345CJZRW08w@mail.gmail.com>
Subject: Re: [PATCH 1/9] drm/amd/pm: Annotate struct
 smu10_voltage_dependency_table with __counted_by
To: Kees Cook <keescook@chromium.org>
Cc: "Pan, Xinhui" <Xinhui.Pan@amd.com>, Karol Herbst <kherbst@redhat.com>,
 Tom Rix <trix@redhat.com>, llvm@lists.linux.dev,
 dri-devel@lists.freedesktop.org, Chris Wilson <chris@chris-wilson.co.uk>,
 Prike Liang <Prike.Liang@amd.com>, Huang Rui <ray.huang@amd.com>,
 Andrzej Hajda <andrzej.hajda@intel.com>,
 Marijn Suijten <marijn.suijten@somainline.org>,
 David Airlie <airlied@gmail.com>, Matthew Brost <matthew.brost@intel.com>,
 Evan Quan <evan.quan@amd.com>, Emma Anholt <emma@anholt.net>,
 amd-gfx@lists.freedesktop.org, Kuogee Hsieh <quic_khsieh@quicinc.com>,
 VMware Graphics Reviewers <linux-graphics-maintainer@vmware.com>,
 Ben Skeggs <bskeggs@redhat.com>, Andi Shyti <andi.shyti@linux.intel.com>,
 nouveau@lists.freedesktop.org, David Airlie <airlied@redhat.com>,
 Alex Deucher <alexander.deucher@amd.com>, Lijo Lazar <lijo.lazar@amd.com>,
 Yifan Zhang <yifan1.zhang@amd.com>, linux-arm-msm@vger.kernel.org,
 intel-gfx@lists.freedesktop.org, Kevin Wang <kevin1.wang@amd.com>,
 Abhinav Kumar <quic_abhinavk@quicinc.com>, Maxime Ripard <mripard@kernel.org>,
 Tvrtko Ursulin <tvrtko.ursulin@linux.intel.com>,
 Nathan Chancellor <nathan@kernel.org>, Le Ma <le.ma@amd.com>,
 Gurchetan Singh <gurchetansingh@chromium.org>,
 Rodrigo Vivi <rodrigo.vivi@intel.com>,
 virtualization@lists.linux-foundation.org, Sean Paul <sean@poorly.run>,
 Neil Armstrong <neil.armstrong@linaro.org>, Xiaojian Du <Xiaojian.Du@amd.com>,
 Lang Yu <Lang.Yu@amd.com>, Bjorn Andersson <andersson@kernel.org>,
 Tejas Upadhyay <tejas.upadhyay@intel.com>,
 Nick Desaulniers <ndesaulniers@google.com>, linux-kernel@vger.kernel.org,
 Hawking Zhang <Hawking.Zhang@amd.com>, Melissa Wen <mwen@igalia.com>,
 Dmitry Baryshkov <dmitry.baryshkov@linaro.org>,
 Nirmoy Das <nirmoy.das@intel.com>, freedreno@lists.freedesktop.org,
 =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>,
 John Harrison <john.c.harrison@intel.com>, linux-hardening@vger.kernel.org
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

T24gRnJpLCBTZXAgMjIsIDIwMjMgYXQgMTozMuKAr1BNIEtlZXMgQ29vayA8a2Vlc2Nvb2tAY2hy
b21pdW0ub3JnPiB3cm90ZToKPgo+IFByZXBhcmUgZm9yIHRoZSBjb21pbmcgaW1wbGVtZW50YXRp
b24gYnkgR0NDIGFuZCBDbGFuZyBvZiB0aGUgX19jb3VudGVkX2J5Cj4gYXR0cmlidXRlLiBGbGV4
aWJsZSBhcnJheSBtZW1iZXJzIGFubm90YXRlZCB3aXRoIF9fY291bnRlZF9ieSBjYW4gaGF2ZQo+
IHRoZWlyIGFjY2Vzc2VzIGJvdW5kcy1jaGVja2VkIGF0IHJ1bi10aW1lIGNoZWNraW5nIHZpYSBD
T05GSUdfVUJTQU5fQk9VTkRTCj4gKGZvciBhcnJheSBpbmRleGluZykgYW5kIENPTkZJR19GT1JU
SUZZX1NPVVJDRSAoZm9yIHN0cmNweS9tZW1jcHktZmFtaWx5Cj4gZnVuY3Rpb25zKS4KPgo+IEFz
IGZvdW5kIHdpdGggQ29jY2luZWxsZVsxXSwgYWRkIF9fY291bnRlZF9ieSBmb3Igc3RydWN0IHNt
dTEwX3ZvbHRhZ2VfZGVwZW5kZW5jeV90YWJsZS4KPgo+IFsxXSBodHRwczovL2dpdGh1Yi5jb20v
a2Vlcy9rZXJuZWwtdG9vbHMvYmxvYi90cnVuay9jb2NjaW5lbGxlL2V4YW1wbGVzL2NvdW50ZWRf
YnkuY29jY2kKPgo+IENjOiBFdmFuIFF1YW4gPGV2YW4ucXVhbkBhbWQuY29tPgo+IENjOiBBbGV4
IERldWNoZXIgPGFsZXhhbmRlci5kZXVjaGVyQGFtZC5jb20+Cj4gQ2M6ICJDaHJpc3RpYW4gS8O2
bmlnIiA8Y2hyaXN0aWFuLmtvZW5pZ0BhbWQuY29tPgo+IENjOiAiUGFuLCBYaW5odWkiIDxYaW5o
dWkuUGFuQGFtZC5jb20+Cj4gQ2M6IERhdmlkIEFpcmxpZSA8YWlybGllZEBnbWFpbC5jb20+Cj4g
Q2M6IERhbmllbCBWZXR0ZXIgPGRhbmllbEBmZndsbC5jaD4KPiBDYzogWGlhb2ppYW4gRHUgPFhp
YW9qaWFuLkR1QGFtZC5jb20+Cj4gQ2M6IEh1YW5nIFJ1aSA8cmF5Lmh1YW5nQGFtZC5jb20+Cj4g
Q2M6IEtldmluIFdhbmcgPGtldmluMS53YW5nQGFtZC5jb20+Cj4gQ2M6IGFtZC1nZnhAbGlzdHMu
ZnJlZWRlc2t0b3Aub3JnCj4gQ2M6IGRyaS1kZXZlbEBsaXN0cy5mcmVlZGVza3RvcC5vcmcKPiBT
aWduZWQtb2ZmLWJ5OiBLZWVzIENvb2sgPGtlZXNjb29rQGNocm9taXVtLm9yZz4KCkFja2VkLWJ5
OiBBbGV4IERldWNoZXIgPGFsZXhhbmRlci5kZXVjaGVyQGFtZC5jb20+Cgo+IC0tLQo+ICBkcml2
ZXJzL2dwdS9kcm0vYW1kL3BtL3Bvd2VycGxheS9od21nci9zbXUxMF9od21nci5oIHwgMiArLQo+
ICAxIGZpbGUgY2hhbmdlZCwgMSBpbnNlcnRpb24oKyksIDEgZGVsZXRpb24oLSkKPgo+IGRpZmYg
LS1naXQgYS9kcml2ZXJzL2dwdS9kcm0vYW1kL3BtL3Bvd2VycGxheS9od21nci9zbXUxMF9od21n
ci5oIGIvZHJpdmVycy9ncHUvZHJtL2FtZC9wbS9wb3dlcnBsYXkvaHdtZ3Ivc211MTBfaHdtZ3Iu
aAo+IGluZGV4IDgwOGUwZWNiZTFmMC4uNDJhZGMyYTNkY2JjIDEwMDY0NAo+IC0tLSBhL2RyaXZl
cnMvZ3B1L2RybS9hbWQvcG0vcG93ZXJwbGF5L2h3bWdyL3NtdTEwX2h3bWdyLmgKPiArKysgYi9k
cml2ZXJzL2dwdS9kcm0vYW1kL3BtL3Bvd2VycGxheS9od21nci9zbXUxMF9od21nci5oCj4gQEAg
LTE5Miw3ICsxOTIsNyBAQCBzdHJ1Y3Qgc211MTBfY2xvY2tfdm9sdGFnZV9kZXBlbmRlbmN5X3Jl
Y29yZCB7Cj4KPiAgc3RydWN0IHNtdTEwX3ZvbHRhZ2VfZGVwZW5kZW5jeV90YWJsZSB7Cj4gICAg
ICAgICB1aW50MzJfdCBjb3VudDsKPiAtICAgICAgIHN0cnVjdCBzbXUxMF9jbG9ja192b2x0YWdl
X2RlcGVuZGVuY3lfcmVjb3JkIGVudHJpZXNbXTsKPiArICAgICAgIHN0cnVjdCBzbXUxMF9jbG9j
a192b2x0YWdlX2RlcGVuZGVuY3lfcmVjb3JkIGVudHJpZXNbXSBfX2NvdW50ZWRfYnkoY291bnQp
Owo+ICB9Owo+Cj4gIHN0cnVjdCBzbXUxMF9jbG9ja192b2x0YWdlX2luZm9ybWF0aW9uIHsKPiAt
LQo+IDIuMzQuMQo+Cl9fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fClZpcnR1YWxpemF0aW9uIG1haWxpbmcgbGlzdApWaXJ0dWFsaXphdGlvbkBsaXN0cy5saW51
eC1mb3VuZGF0aW9uLm9yZwpodHRwczovL2xpc3RzLmxpbnV4Zm91bmRhdGlvbi5vcmcvbWFpbG1h
bi9saXN0aW5mby92aXJ0dWFsaXphdGlvbg==
