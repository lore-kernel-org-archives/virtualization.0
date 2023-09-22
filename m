Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EEEF8CD484A
	for <virtualization@archiver.kernel.org>; Fri, 22 Sep 2023 17:42:37 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id A966782136;
	Fri, 22 Sep 2023 17:42:37 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org A966782136
Authentication-Results: smtp1.osuosl.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20230601 header.b=HfQEnLHq
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
	by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id jxlmmWQkfNpR; Fri, 22 Sep 2023 17:42:36 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp1.osuosl.org (Postfix) with ESMTPS id 2DB498210A;
	Fri, 22 Sep 2023 17:42:36 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 2DB498210A
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 09A70C0071;
	Fri, 22 Sep 2023 17:42:36 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [IPv6:2605:bc80:3010::133])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 4A024C0032
 for <virtualization@lists.linux-foundation.org>;
 Fri, 22 Sep 2023 17:42:34 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id 17CB04198B
 for <virtualization@lists.linux-foundation.org>;
 Fri, 22 Sep 2023 17:42:34 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org 17CB04198B
Authentication-Results: smtp2.osuosl.org;
 dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com
 header.a=rsa-sha256 header.s=20230601 header.b=HfQEnLHq
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id g5LgOcXu19jT
 for <virtualization@lists.linux-foundation.org>;
 Fri, 22 Sep 2023 17:42:32 +0000 (UTC)
Received: from mail-oo1-xc2c.google.com (mail-oo1-xc2c.google.com
 [IPv6:2607:f8b0:4864:20::c2c])
 by smtp2.osuosl.org (Postfix) with ESMTPS id BB14441985
 for <virtualization@lists.linux-foundation.org>;
 Fri, 22 Sep 2023 17:42:32 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org BB14441985
Received: by mail-oo1-xc2c.google.com with SMTP id
 006d021491bc7-57b6c7d0cabso763155eaf.1
 for <virtualization@lists.linux-foundation.org>;
 Fri, 22 Sep 2023 10:42:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1695404551; x=1696009351;
 darn=lists.linux-foundation.org; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=O1mscbgmaMFCH+sggQx7YqczyCptW8ney4CIT5DP64U=;
 b=HfQEnLHqSTJHN6ZKAc5MomsA/peoWz00fI9xkXXkebx9R3Kp+Zc1zZFVf+LjWdnu7I
 2JgriYzea4wp5ZqLcvuogyiMS/mrenpSat87jjte64RR9JO2cGyHR6uo4/4wVCcj3QvC
 L0lVxERfbWvNaEI8xfckJS5cN2dJsx68m9alIvshko+cIBgRLcs4OPczWqnCvdXTZ1tv
 5fBFtr0OosOdmADQIbf6MWx+0HR6CbTbZB/WErUvQSuYe7bWIC7zRyMn4JcavDswulrC
 vD1vpl+Us7VSxrEze3AifKjAeGuheQSmOjpiJhDH3yIMKYZyhN3Yl83UgLmAGfhRFY5D
 BEhA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1695404551; x=1696009351;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=O1mscbgmaMFCH+sggQx7YqczyCptW8ney4CIT5DP64U=;
 b=KxkOcF54KCS6QKVm0rM4hzZb8j1dmCnwY/RBVDuUyE4kVOsVbBk7luxpuu14Bv1wdb
 vnP9n89Y4YocWCnwcji1a4HTdLGIXU4O7jh3stVf6RATvzfRHdjWbDeZGOdEFljB8LsS
 2Mx40is1hKoZ3ngwdzIYV7OBcse9bkfoCQBS4IIz4lNTNAhqwn0DMLtjZImb+Ed7Jn1/
 Rp/KHvyY0iTehjDVIkRA8wjAnLmM68iDj2GnhniA7aW58QQzinGRhf5bscbtyAGezFsp
 yrWWac0wH1H9wwlfnGd+H5XYDAK3Iwwxx5z9WshZG+ZYFEjxDKnGA7w8U9zb2qEUAc/h
 bemw==
X-Gm-Message-State: AOJu0Yx9ufTPOJnHWbP9ywjG/N4CQsg9tf46rPNzjOcbzei7lduvEdXy
 hWk6dO5tvb3UE+Pkpa4pbbigNp3JXaFcsHgzIk0=
X-Google-Smtp-Source: AGHT+IFPsM3Hdk+pcYqT5bpsUWbwTA0MpnAJeoAQZ6o66BtolUGO//OpOOgoyvfV1ya4MzJTleibWsMBwKq26jjzaO8=
X-Received: by 2002:a05:6870:2383:b0:1dc:33a:40d8 with SMTP id
 e3-20020a056870238300b001dc033a40d8mr162032oap.4.1695404551639; Fri, 22 Sep
 2023 10:42:31 -0700 (PDT)
MIME-Version: 1.0
References: <20230922173110.work.084-kees@kernel.org>
 <20230922173216.3823169-2-keescook@chromium.org>
In-Reply-To: <20230922173216.3823169-2-keescook@chromium.org>
From: Alex Deucher <alexdeucher@gmail.com>
Date: Fri, 22 Sep 2023 13:42:20 -0400
Message-ID: <CADnq5_OV7L4_z5mhAq8x8nV4+yp_wGhyVeg1MrKAVoSbMVV1uw@mail.gmail.com>
Subject: Re: [PATCH 2/9] drm/amdgpu/discovery: Annotate struct ip_hw_instance
 with __counted_by
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

T24gRnJpLCBTZXAgMjIsIDIwMjMgYXQgMTozM+KAr1BNIEtlZXMgQ29vayA8a2Vlc2Nvb2tAY2hy
b21pdW0ub3JnPiB3cm90ZToKPgo+IFByZXBhcmUgZm9yIHRoZSBjb21pbmcgaW1wbGVtZW50YXRp
b24gYnkgR0NDIGFuZCBDbGFuZyBvZiB0aGUgX19jb3VudGVkX2J5Cj4gYXR0cmlidXRlLiBGbGV4
aWJsZSBhcnJheSBtZW1iZXJzIGFubm90YXRlZCB3aXRoIF9fY291bnRlZF9ieSBjYW4gaGF2ZQo+
IHRoZWlyIGFjY2Vzc2VzIGJvdW5kcy1jaGVja2VkIGF0IHJ1bi10aW1lIGNoZWNraW5nIHZpYSBD
T05GSUdfVUJTQU5fQk9VTkRTCj4gKGZvciBhcnJheSBpbmRleGluZykgYW5kIENPTkZJR19GT1JU
SUZZX1NPVVJDRSAoZm9yIHN0cmNweS9tZW1jcHktZmFtaWx5Cj4gZnVuY3Rpb25zKS4KPgo+IEFz
IGZvdW5kIHdpdGggQ29jY2luZWxsZVsxXSwgYWRkIF9fY291bnRlZF9ieSBmb3Igc3RydWN0IGlw
X2h3X2luc3RhbmNlLgo+Cj4gWzFdIGh0dHBzOi8vZ2l0aHViLmNvbS9rZWVzL2tlcm5lbC10b29s
cy9ibG9iL3RydW5rL2NvY2NpbmVsbGUvZXhhbXBsZXMvY291bnRlZF9ieS5jb2NjaQo+Cj4gQ2M6
IEFsZXggRGV1Y2hlciA8YWxleGFuZGVyLmRldWNoZXJAYW1kLmNvbT4KPiBDYzogIkNocmlzdGlh
biBLw7ZuaWciIDxjaHJpc3RpYW4ua29lbmlnQGFtZC5jb20+Cj4gQ2M6ICJQYW4sIFhpbmh1aSIg
PFhpbmh1aS5QYW5AYW1kLmNvbT4KPiBDYzogRGF2aWQgQWlybGllIDxhaXJsaWVkQGdtYWlsLmNv
bT4KPiBDYzogRGFuaWVsIFZldHRlciA8ZGFuaWVsQGZmd2xsLmNoPgo+IENjOiBIYXdraW5nIFpo
YW5nIDxIYXdraW5nLlpoYW5nQGFtZC5jb20+Cj4gQ2M6IGFtZC1nZnhAbGlzdHMuZnJlZWRlc2t0
b3Aub3JnCj4gQ2M6IGRyaS1kZXZlbEBsaXN0cy5mcmVlZGVza3RvcC5vcmcKPiBTaWduZWQtb2Zm
LWJ5OiBLZWVzIENvb2sgPGtlZXNjb29rQGNocm9taXVtLm9yZz4KCkFja2VkLWJ5OiBBbGV4IERl
dWNoZXIgPGFsZXhhbmRlci5kZXVjaGVyQGFtZC5jb20+Cgo+IC0tLQo+ICBkcml2ZXJzL2dwdS9k
cm0vYW1kL2FtZGdwdS9hbWRncHVfZGlzY292ZXJ5LmMgfCAyICstCj4gIDEgZmlsZSBjaGFuZ2Vk
LCAxIGluc2VydGlvbigrKSwgMSBkZWxldGlvbigtKQo+Cj4gZGlmZiAtLWdpdCBhL2RyaXZlcnMv
Z3B1L2RybS9hbWQvYW1kZ3B1L2FtZGdwdV9kaXNjb3ZlcnkuYyBiL2RyaXZlcnMvZ3B1L2RybS9h
bWQvYW1kZ3B1L2FtZGdwdV9kaXNjb3ZlcnkuYwo+IGluZGV4IGQxYmM3YjIxMjUyMC4uYmU0Yzk3
YTNkN2JmIDEwMDY0NAo+IC0tLSBhL2RyaXZlcnMvZ3B1L2RybS9hbWQvYW1kZ3B1L2FtZGdwdV9k
aXNjb3ZlcnkuYwo+ICsrKyBiL2RyaXZlcnMvZ3B1L2RybS9hbWQvYW1kZ3B1L2FtZGdwdV9kaXNj
b3ZlcnkuYwo+IEBAIC02NjIsNyArNjYyLDcgQEAgc3RydWN0IGlwX2h3X2luc3RhbmNlIHsKPiAg
ICAgICAgIHU4ICBoYXJ2ZXN0Owo+Cj4gICAgICAgICBpbnQgbnVtX2Jhc2VfYWRkcmVzc2VzOwo+
IC0gICAgICAgdTMyIGJhc2VfYWRkcltdOwo+ICsgICAgICAgdTMyIGJhc2VfYWRkcltdIF9fY291
bnRlZF9ieShudW1fYmFzZV9hZGRyZXNzZXMpOwo+ICB9Owo+Cj4gIHN0cnVjdCBpcF9od19pZCB7
Cj4gLS0KPiAyLjM0LjEKPgpfX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fXwpWaXJ0dWFsaXphdGlvbiBtYWlsaW5nIGxpc3QKVmlydHVhbGl6YXRpb25AbGlzdHMu
bGludXgtZm91bmRhdGlvbi5vcmcKaHR0cHM6Ly9saXN0cy5saW51eGZvdW5kYXRpb24ub3JnL21h
aWxtYW4vbGlzdGluZm8vdmlydHVhbGl6YXRpb24=
