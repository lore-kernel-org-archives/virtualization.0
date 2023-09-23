Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E381ACE7A81
	for <virtualization@archiver.kernel.org>; Fri, 22 Sep 2023 23:01:54 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 692B281D0B;
	Fri, 22 Sep 2023 23:01:54 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 692B281D0B
Authentication-Results: smtp1.osuosl.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=embeddedor.com header.i=@embeddedor.com header.a=rsa-sha256 header.s=default header.b=iNhF5ZGK
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
	by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id MSBSm6v5FF1P; Fri, 22 Sep 2023 23:01:53 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp1.osuosl.org (Postfix) with ESMTPS id 0BA1F81CD0;
	Fri, 22 Sep 2023 23:01:52 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 0BA1F81CD0
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id F18E3C0DD2;
	Fri, 22 Sep 2023 23:01:50 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 0056EC0039
 for <virtualization@lists.linux-foundation.org>;
 Fri, 22 Sep 2023 23:01:49 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id C666E42488
 for <virtualization@lists.linux-foundation.org>;
 Fri, 22 Sep 2023 23:01:48 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org C666E42488
Authentication-Results: smtp4.osuosl.org;
 dkim=pass (2048-bit key) header.d=embeddedor.com header.i=@embeddedor.com
 header.a=rsa-sha256 header.s=default header.b=iNhF5ZGK
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id MWHJREI2vakB
 for <virtualization@lists.linux-foundation.org>;
 Fri, 22 Sep 2023 23:01:47 +0000 (UTC)
Received: from omta040.useast.a.cloudfilter.net
 (omta040.useast.a.cloudfilter.net [44.202.169.39])
 by smtp4.osuosl.org (Postfix) with ESMTPS id A83E24243D
 for <virtualization@lists.linux-foundation.org>;
 Fri, 22 Sep 2023 23:01:47 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org A83E24243D
Received: from eig-obgw-5002a.ext.cloudfilter.net ([10.0.29.215])
 by cmsmtp with ESMTP
 id jjHaq7WW3yYOwjp9eqxwHV; Fri, 22 Sep 2023 23:01:46 +0000
Received: from gator4166.hostgator.com ([108.167.133.22]) by cmsmtp with ESMTPS
 id jp9eqUT3FjI4jjp9eqtYqK; Fri, 22 Sep 2023 23:01:46 +0000
X-Authority-Analysis: v=2.4 cv=Uoxwis8B c=1 sm=1 tr=0 ts=650e1cda
 a=1YbLdUo/zbTtOZ3uB5T3HA==:117 a=P7XfKmiOJ4/qXqHZrN7ymg==:17
 a=OWjo9vPv0XrRhIrVQ50Ab3nP57M=:19 a=dLZJa+xiwSxG16/P+YVxDGlgEgI=:19
 a=IkcTkHD0fZMA:10 a=zNV7Rl7Rt7sA:10 a=wYkD_t78qR0A:10 a=NEAV23lmAAAA:8
 a=zd2uoN0lAAAA:8 a=pGLkceISAAAA:8 a=e5mUnYsNAAAA:8 a=cm27Pg_UAAAA:8
 a=VwQbUJbxAAAA:8 a=2wB7VPZBpCe0CuILneIA:9 a=QEXdDO2ut3YA:10
 a=Vxmtnl_E_bksehYqCbjh:22 a=xmb-EsYY8bH0VWELuYED:22 a=AjGcO6oz07-iQ99wixmX:22
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=embeddedor.com; s=default; h=Content-Transfer-Encoding:Content-Type:
 In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:Message-ID:Sender
 :Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
 Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
 List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=uilWM61trubKM2ejy0VnaxrpRmVV7jUvqNgJorf6Qao=; b=iNhF5ZGKjJCvmxMwvJhJsVex5N
 +kDQxgkwTRsW2hflZt3y1HL+m5qOESNqeZ7r9l0JUKw0+k7tF+DQJ7B4JY+FR1k3JAu1uVBTCJniM
 clR2EmCJnOIxb2shrvyyzwNYFVGhaHJdXEXOAqmy9mgi1M3S+Psg1dAbnP3QwQap5mXn8i7p0hmlA
 470q9M9RNJboyPgGKhTcngTDuhLhIwycFUy1wGOz3GIp5zfeWiGf9TOG/ubAU70XbaYyKO1mQqKMo
 ZAPERXNKSQfiwYWiOdMgVWDzrdJmYEguKAjVL22EKimaO8bjHwiwQUoz0Uf+MjORxXnl+iyAKqQqn
 JLfivoIg==;
Received: from [94.239.20.48] (port=33658 helo=[192.168.1.98])
 by gator4166.hostgator.com with esmtpsa (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256 (Exim 4.96)
 (envelope-from <gustavo@embeddedor.com>) id 1qjkeQ-000MuO-28;
 Fri, 22 Sep 2023 13:13:14 -0500
Message-ID: <4b64e969-633a-c59a-90e4-5f6368ad76b6@embeddedor.com>
Date: Fri, 22 Sep 2023 20:14:06 -0600
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.15.1
Subject: Re: [PATCH 2/9] drm/amdgpu/discovery: Annotate struct ip_hw_instance
 with __counted_by
Content-Language: en-US
To: Kees Cook <keescook@chromium.org>, David Airlie <airlied@gmail.com>
References: <20230922173110.work.084-kees@kernel.org>
 <20230922173216.3823169-2-keescook@chromium.org>
From: "Gustavo A. R. Silva" <gustavo@embeddedor.com>
In-Reply-To: <20230922173216.3823169-2-keescook@chromium.org>
X-AntiAbuse: This header was added to track abuse,
 please include it with any abuse report
X-AntiAbuse: Primary Hostname - gator4166.hostgator.com
X-AntiAbuse: Original Domain - lists.linux-foundation.org
X-AntiAbuse: Originator/Caller UID/GID - [47 12] / [47 12]
X-AntiAbuse: Sender Address Domain - embeddedor.com
X-BWhitelist: no
X-Source-IP: 94.239.20.48
X-Source-L: No
X-Exim-ID: 1qjkeQ-000MuO-28
X-Source: 
X-Source-Args: 
X-Source-Dir: 
X-Source-Sender: ([192.168.1.98]) [94.239.20.48]:33658
X-Source-Auth: gustavo@embeddedor.com
X-Email-Count: 0
X-Org: HG=hgshared;ORG=hostgator;
X-Source-Cap: Z3V6aWRpbmU7Z3V6aWRpbmU7Z2F0b3I0MTY2Lmhvc3RnYXRvci5jb20=
X-Local-Domain: yes
X-CMAE-Envelope: MS4xfHCi+sk1/mLqCOBPVzcsipZGuXxNwoqhcTW/BZey9KQp9y32dWg2zBCQRHF7ZmxiDaVsLrwPu7/hNHk2Ch5PNDCy/Hq+VGTAqa7qLW4wLytMuwbZy8RV
 dfULx/N9M7UptAjp/WnVUUEIu43i4En/6mw+Vo6MXdcI3E4naF66KPjc9PlzmsWIThdoRfSQ1u6uVDKmG7fbPJbtcXEl99V69aeETKwrZ7ClWRbtQugCFRL0
Cc: Tejas Upadhyay <tejas.upadhyay@intel.com>, Emma Anholt <emma@anholt.net>,
 Tom Rix <trix@redhat.com>, Joonas Lahtinen <joonas.lahtinen@linux.intel.com>,
 llvm@lists.linux.dev, dri-devel@lists.freedesktop.org,
 Chris Wilson <chris@chris-wilson.co.uk>, Prike Liang <Prike.Liang@amd.com>,
 Huang Rui <ray.huang@amd.com>, Andrzej Hajda <andrzej.hajda@intel.com>,
 Marijn Suijten <marijn.suijten@somainline.org>,
 Matthew Brost <matthew.brost@intel.com>, Karol Herbst <kherbst@redhat.com>,
 Neil Armstrong <neil.armstrong@linaro.org>, amd-gfx@lists.freedesktop.org,
 Kuogee Hsieh <quic_khsieh@quicinc.com>, Nathan Chancellor <nathan@kernel.org>,
 VMware Graphics Reviewers <linux-graphics-maintainer@vmware.com>,
 Ben Skeggs <bskeggs@redhat.com>, Andi Shyti <andi.shyti@linux.intel.com>,
 nouveau@lists.freedesktop.org, David Airlie <airlied@redhat.com>,
 virtualization@lists.linux-foundation.org, Chia-I Wu <olvaffe@gmail.com>,
 linux-hardening@vger.kernel.org, Lijo Lazar <lijo.lazar@amd.com>,
 Lyude Paul <lyude@redhat.com>, Yifan Zhang <yifan1.zhang@amd.com>,
 linux-arm-msm@vger.kernel.org, intel-gfx@lists.freedesktop.org,
 Kevin Wang <kevin1.wang@amd.com>, Abhinav Kumar <quic_abhinavk@quicinc.com>,
 Jani Nikula <jani.nikula@linux.intel.com>, Melissa Wen <mwen@igalia.com>,
 Dmitry Baryshkov <dmitry.baryshkov@linaro.org>,
 Gurchetan Singh <gurchetansingh@chromium.org>,
 Maxime Ripard <mripard@kernel.org>, Rodrigo Vivi <rodrigo.vivi@intel.com>,
 Evan Quan <evan.quan@amd.com>, Sean Paul <sean@poorly.run>,
 Tvrtko Ursulin <tvrtko.ursulin@linux.intel.com>,
 Xiaojian Du <Xiaojian.Du@amd.com>, Le Ma <le.ma@amd.com>,
 freedreno@lists.freedesktop.org, Bjorn Andersson <andersson@kernel.org>, "Pan,
 Xinhui" <Xinhui.Pan@amd.com>, Nick Desaulniers <ndesaulniers@google.com>,
 linux-kernel@vger.kernel.org, Rob Clark <robdclark@gmail.com>,
 Zack Rusin <zackr@vmware.com>, Daniel Vetter <daniel@ffwll.ch>,
 Alex Deucher <alexander.deucher@amd.com>, Nirmoy Das <nirmoy.das@intel.com>,
 Lang Yu <Lang.Yu@amd.com>,
 =?UTF-8?Q?Christian_K=c3=b6nig?= <christian.koenig@amd.com>,
 John Harrison <john.c.harrison@Intel.com>,
 Hawking Zhang <Hawking.Zhang@amd.com>
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
Content-Transfer-Encoding: base64
Content-Type: text/plain; charset="utf-8"; Format="flowed"
Errors-To: virtualization-bounces@lists.linux-foundation.org
Sender: "Virtualization" <virtualization-bounces@lists.linux-foundation.org>

CgpPbiA5LzIyLzIzIDExOjMyLCBLZWVzIENvb2sgd3JvdGU6Cj4gUHJlcGFyZSBmb3IgdGhlIGNv
bWluZyBpbXBsZW1lbnRhdGlvbiBieSBHQ0MgYW5kIENsYW5nIG9mIHRoZSBfX2NvdW50ZWRfYnkK
PiBhdHRyaWJ1dGUuIEZsZXhpYmxlIGFycmF5IG1lbWJlcnMgYW5ub3RhdGVkIHdpdGggX19jb3Vu
dGVkX2J5IGNhbiBoYXZlCj4gdGhlaXIgYWNjZXNzZXMgYm91bmRzLWNoZWNrZWQgYXQgcnVuLXRp
bWUgY2hlY2tpbmcgdmlhIENPTkZJR19VQlNBTl9CT1VORFMKPiAoZm9yIGFycmF5IGluZGV4aW5n
KSBhbmQgQ09ORklHX0ZPUlRJRllfU09VUkNFIChmb3Igc3RyY3B5L21lbWNweS1mYW1pbHkKPiBm
dW5jdGlvbnMpLgo+IAo+IEFzIGZvdW5kIHdpdGggQ29jY2luZWxsZVsxXSwgYWRkIF9fY291bnRl
ZF9ieSBmb3Igc3RydWN0IGlwX2h3X2luc3RhbmNlLgo+IAo+IFsxXSBodHRwczovL2dpdGh1Yi5j
b20va2Vlcy9rZXJuZWwtdG9vbHMvYmxvYi90cnVuay9jb2NjaW5lbGxlL2V4YW1wbGVzL2NvdW50
ZWRfYnkuY29jY2kKPiAKPiBDYzogQWxleCBEZXVjaGVyIDxhbGV4YW5kZXIuZGV1Y2hlckBhbWQu
Y29tPgo+IENjOiAiQ2hyaXN0aWFuIEvDtm5pZyIgPGNocmlzdGlhbi5rb2VuaWdAYW1kLmNvbT4K
PiBDYzogIlBhbiwgWGluaHVpIiA8WGluaHVpLlBhbkBhbWQuY29tPgo+IENjOiBEYXZpZCBBaXJs
aWUgPGFpcmxpZWRAZ21haWwuY29tPgo+IENjOiBEYW5pZWwgVmV0dGVyIDxkYW5pZWxAZmZ3bGwu
Y2g+Cj4gQ2M6IEhhd2tpbmcgWmhhbmcgPEhhd2tpbmcuWmhhbmdAYW1kLmNvbT4KPiBDYzogYW1k
LWdmeEBsaXN0cy5mcmVlZGVza3RvcC5vcmcKPiBDYzogZHJpLWRldmVsQGxpc3RzLmZyZWVkZXNr
dG9wLm9yZwo+IFNpZ25lZC1vZmYtYnk6IEtlZXMgQ29vayA8a2Vlc2Nvb2tAY2hyb21pdW0ub3Jn
PgoKUmV2aWV3ZWQtYnk6IEd1c3Rhdm8gQS4gUi4gU2lsdmEgPGd1c3Rhdm9hcnNAa2VybmVsLm9y
Zz4KClRoYW5rcwotLSAKR3VzdGF2bwoKPiAtLS0KPiAgIGRyaXZlcnMvZ3B1L2RybS9hbWQvYW1k
Z3B1L2FtZGdwdV9kaXNjb3ZlcnkuYyB8IDIgKy0KPiAgIDEgZmlsZSBjaGFuZ2VkLCAxIGluc2Vy
dGlvbigrKSwgMSBkZWxldGlvbigtKQo+IAo+IGRpZmYgLS1naXQgYS9kcml2ZXJzL2dwdS9kcm0v
YW1kL2FtZGdwdS9hbWRncHVfZGlzY292ZXJ5LmMgYi9kcml2ZXJzL2dwdS9kcm0vYW1kL2FtZGdw
dS9hbWRncHVfZGlzY292ZXJ5LmMKPiBpbmRleCBkMWJjN2IyMTI1MjAuLmJlNGM5N2EzZDdiZiAx
MDA2NDQKPiAtLS0gYS9kcml2ZXJzL2dwdS9kcm0vYW1kL2FtZGdwdS9hbWRncHVfZGlzY292ZXJ5
LmMKPiArKysgYi9kcml2ZXJzL2dwdS9kcm0vYW1kL2FtZGdwdS9hbWRncHVfZGlzY292ZXJ5LmMK
PiBAQCAtNjYyLDcgKzY2Miw3IEBAIHN0cnVjdCBpcF9od19pbnN0YW5jZSB7Cj4gICAJdTggIGhh
cnZlc3Q7Cj4gICAKPiAgIAlpbnQgbnVtX2Jhc2VfYWRkcmVzc2VzOwo+IC0JdTMyIGJhc2VfYWRk
cltdOwo+ICsJdTMyIGJhc2VfYWRkcltdIF9fY291bnRlZF9ieShudW1fYmFzZV9hZGRyZXNzZXMp
Owo+ICAgfTsKPiAgIAo+ICAgc3RydWN0IGlwX2h3X2lkIHsKX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX18KVmlydHVhbGl6YXRpb24gbWFpbGluZyBsaXN0ClZp
cnR1YWxpemF0aW9uQGxpc3RzLmxpbnV4LWZvdW5kYXRpb24ub3JnCmh0dHBzOi8vbGlzdHMubGlu
dXhmb3VuZGF0aW9uLm9yZy9tYWlsbWFuL2xpc3RpbmZvL3ZpcnR1YWxpemF0aW9u
