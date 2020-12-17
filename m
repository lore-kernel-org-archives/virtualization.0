Return-Path: <SRS0=dJY/=FV=lists.linux-foundation.org=virtualization-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D2DDBC4361B
	for <virtualization@archiver.kernel.org>; Thu, 17 Dec 2020 16:22:50 +0000 (UTC)
Received: from fraxinus.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 489C923426
	for <virtualization@archiver.kernel.org>; Thu, 17 Dec 2020 16:22:49 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 489C923426
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmx.de
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=virtualization-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by fraxinus.osuosl.org (Postfix) with ESMTP id BD2B18740C;
	Thu, 17 Dec 2020 16:22:49 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from fraxinus.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id iVtY-ciVOYCW; Thu, 17 Dec 2020 16:22:49 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by fraxinus.osuosl.org (Postfix) with ESMTP id 185F3873B5;
	Thu, 17 Dec 2020 16:22:49 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id EC813C0893;
	Thu, 17 Dec 2020 16:22:48 +0000 (UTC)
Received: from fraxinus.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by lists.linuxfoundation.org (Postfix) with ESMTP id DD6C3C013B
 for <virtualization@lists.linux-foundation.org>;
 Thu, 17 Dec 2020 16:22:47 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by fraxinus.osuosl.org (Postfix) with ESMTP id C429C873F8
 for <virtualization@lists.linux-foundation.org>;
 Thu, 17 Dec 2020 16:22:47 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from fraxinus.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id YeNsD8nIjkVa
 for <virtualization@lists.linux-foundation.org>;
 Thu, 17 Dec 2020 16:22:46 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from mout.gmx.net (mout.gmx.net [212.227.17.22])
 by fraxinus.osuosl.org (Postfix) with ESMTPS id D8BFF873B5
 for <virtualization@lists.linux-foundation.org>;
 Thu, 17 Dec 2020 16:22:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
 s=badeba3b8450; t=1608222064;
 bh=GiA3SVJQxbWUZvTzL7A9ussr290uZsz9k9rPQnz6TTY=;
 h=X-UI-Sender-Class:Subject:From:To:Cc:Date:In-Reply-To:References;
 b=e7Jkfv4rwu+0P4AwRO0ZOs/0gSIpd3OMDgN+clRWB2tuFWr/PvsKea7EoqhTCJECh
 VAOn+YHOXFfDixHIubZX/TVpN7CE+QCUzH7Wdk/Ldwba72sSqub+nA1fabL4j9dAk3
 i8XztMonolO18RN5HZ2UeH6pVnZGBGA1W3oyMUtE=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from homer.fritz.box ([185.191.217.61]) by mail.gmx.com (mrgmx105
 [212.227.17.168]) with ESMTPSA (Nemesis) id 1MHoRK-1kuvxh3ba2-00Eqyd; Thu, 17
 Dec 2020 17:21:03 +0100
Message-ID: <1f88b926bedcad0d6e35c7f5b63bbb038c8c6c09.camel@gmx.de>
Subject: [bisected] Re: drm, qxl: post 5.11 merge warning+explosion
From: Mike Galbraith <efault@gmx.de>
To: LKML <linux-kernel@vger.kernel.org>
Date: Thu, 17 Dec 2020 17:21:02 +0100
In-Reply-To: <a1b925758cbc5517d4ff6df3cf2a9b6614fd5535.camel@gmx.de>
References: <5979380e28f4ba8023e88f96d3a9291381a8457e.camel@gmx.de>
 <a1b925758cbc5517d4ff6df3cf2a9b6614fd5535.camel@gmx.de>
User-Agent: Evolution 3.34.4 
MIME-Version: 1.0
X-Provags-ID: V03:K1:B4e418HlYaOUc8nmN7chcWcHDKS1A5mJ5S/7F4mCNxFmJZQUjcG
 MYWKQSMRCUXF7tSkVqSD6Ki0nB0TQFL5lfJFG/zeDQC5jdiZCRZOQxnO1V4IkhlP0mnlHqD
 KC6llOrJU5LRgSBYYlfrLaXLkxu9xA9BD+Guy4FlWV3e/pD11CuL/cdv1gu3AcCos12dRl8
 WN6amfq6WtBUTnRVLk00Q==
X-UI-Out-Filterresults: notjunk:1;V03:K0:9aAL17RVKKc=:goWWGf7q4OntYZHTZPfzJ4
 gZ7gGgNoYYogdD/nTqRZ2rfO2LPeGB4y8xSIJCP+kGHSwMNiYftDuzHbDyxG7cUllJphAbPDJ
 1I13ylX0JvaoHMXUZBz6+UtBCCMTUf7+4MoD1hseh/10/L4CLzttWADYlkj89CsbNgVsEA6VC
 H/gJokcy4O4wKE75tFLlo7HZEBAofN6y9I/0LUln93cjmaecNF9CNX/3uyhHfbJLRXTdvBvd7
 St/lBmh9RU6L080WQm1+C6sQy0n8mJfpW/IwdkY1nNgNdjW4Mo6HC3j3+diyHDtjejTfyB4FI
 T0twKBvpuE/7aBfe2HY0aID+P9hj95GhEZaKWmDMUPsRpcUNJH4lGgPpcJ1iVqhCWSq987ea9
 qd9zOervarJviDh02iOJsKiowmOj9D/+26N1DhTLIBwRqaGPxNXin5RUnpd5WgRJcb33pVNiN
 gDRWYUEH6MKybvaNAOQQeyj9ms10s/9gbpmHS1xjVUsSjJh8fVV/Xs2G+urXemsBuM6E5cj5R
 IdIyxYtuROKoBjaYNzqTKgrEufYLiNr90ZCUWTQhs4dpGMlOWBS7yfEkzs5xKbU1MOyCmVBls
 1fM3SKgMbdGB2M4z98T3s8ltNvi1xprsF8jJrtxnFHCVEv4RhpTZu7+5mq9R2JweCCbDrRxtA
 iIC60NsyF+FAl+iYFyhiFDvgge6U3lgG+udjFeGnDl0VXnmKWcFV/yyMLTCSdWrPNJCxxu9Ie
 yvAWJYZOLMr0tPUDlAddW3B/ecIBERZjdVuPCV8BNiVukHtLx0NCLGOBULXubJVFVZOqoUmx9
 rBB5SCTT4QYrj+OJ97tSHJiAdqQ1uMiH2pCsVKv7LBMkA3PeC009Hl5hLWkO2CHXiZtlMkvcc
 ODYhpc5n+lIaqdrUISRQ==
Cc: Dave Airlie <airlied@redhat.com>,
 Christian =?ISO-8859-1?Q?K=F6nig?= <christian.koenig@amd.com>,
 virtualization <virtualization@lists.linux-foundation.org>
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
Content-Type: text/plain; charset="iso-8859-15"
Content-Transfer-Encoding: quoted-printable
Errors-To: virtualization-bounces@lists.linux-foundation.org
Sender: "Virtualization" <virtualization-bounces@lists.linux-foundation.org>

ee5d2a8e549e90325fcc31825269f89647cd6fac is the first bad commit
commit ee5d2a8e549e90325fcc31825269f89647cd6fac
Author: Christian K=F6nig <christian.koenig@amd.com>
Date:   Sat Oct 24 13:10:28 2020 +0200

    drm/ttm: wire up the new pool as default one v2

    Provide the necessary parameters by all drivers and use the new pool al=
loc
    when no driver specific function is provided.

    v2: fix the GEM VRAM helpers

    Signed-off-by: Christian K=F6nig <christian.koenig@amd.com>
    Reviewed-by: Dave Airlie <airlied@redhat.com>
    Reviewed-by: Madhav Chauhan <madhav.chauhan@amd.com>
    Tested-by: Huang Rui <ray.huang@amd.com>
    Link: https://patchwork.freedesktop.org/patch/397081/?series=3D83051&re=
v=3D1

 drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c |  4 ++--
 drivers/gpu/drm/drm_gem_vram_helper.c   |  4 ++--
 drivers/gpu/drm/nouveau/nouveau_ttm.c   | 14 +++++++++-----
 drivers/gpu/drm/qxl/qxl_ttm.c           |  5 ++---
 drivers/gpu/drm/radeon/radeon_ttm.c     |  4 ++--
 drivers/gpu/drm/ttm/ttm_bo.c            |  8 ++++++--
 drivers/gpu/drm/ttm/ttm_memory.c        |  2 +-
 drivers/gpu/drm/ttm/ttm_tt.c            |  5 ++---
 drivers/gpu/drm/vmwgfx/vmwgfx_drv.c     |  5 +++--
 include/drm/ttm/ttm_bo_driver.h         | 11 +++++++----
 10 files changed, 36 insertions(+), 26 deletions(-)

git bisect start 'drivers/gpu/drm/qxl'
# good: [2c85ebc57b3e1817b6ce1a6b703928e113a90442] Linux 5.10
git bisect good 2c85ebc57b3e1817b6ce1a6b703928e113a90442
# bad: [accefff5b547a9a1d959c7e76ad539bf2480e78b] Merge tag 'arm-soc-omap-g=
enpd-5.11' of git://git.kernel.org/pub/scm/linux/kernel/git/soc/soc
git bisect bad accefff5b547a9a1d959c7e76ad539bf2480e78b
# bad: [d635a69dd4981cc51f90293f5f64268620ed1565] Merge tag 'net-next-5.11'=
 of git://git.kernel.org/pub/scm/linux/kernel/git/netdev/net-next
git bisect bad d635a69dd4981cc51f90293f5f64268620ed1565
# bad: [0ca2ce81eb8ee30f3ba8ac7967fef9cfbb44dbdb] Merge tag 'arm64-upstream=
' of git://git.kernel.org/pub/scm/linux/kernel/git/arm64/linux
git bisect bad 0ca2ce81eb8ee30f3ba8ac7967fef9cfbb44dbdb
# bad: [f8aab60422c371425365d386dfd51e0c6c5b1041] drm/amdgpu: Initialise dr=
m_gem_object_funcs for imported BOs
git bisect bad f8aab60422c371425365d386dfd51e0c6c5b1041
# bad: [c0f98d2f8b076bf3e3183aa547395f919c943a14] Merge tag 'drm-misc-next-=
2020-11-05' of git://anongit.freedesktop.org/drm/drm-misc into drm-next
git bisect bad c0f98d2f8b076bf3e3183aa547395f919c943a14
# good: [6a6e5988a2657cd0c91f6f1a3e7d194599248b6d] drm/ttm: replace last mo=
ve_notify with delete_mem_notify
git bisect good 6a6e5988a2657cd0c91f6f1a3e7d194599248b6d
# good: [f566fdcd6cc49a9d5b5d782f56e3e7cb243f01b8] drm/i915: Force VT'd wor=
karounds when running as a guest OS
git bisect good f566fdcd6cc49a9d5b5d782f56e3e7cb243f01b8
# good: [e76ab2cf21c38331155ea613cdf18582f011c30f] drm/i915: Remove per-pla=
tform IIR HPD masking
git bisect good e76ab2cf21c38331155ea613cdf18582f011c30f
# bad: [268af50f38b1f2199a2e85e38073d7a25c20190c] drm/panfrost: Support cac=
he-coherent integrations
git bisect bad 268af50f38b1f2199a2e85e38073d7a25c20190c
# good: [e000650375b65ff77c5ee852b5086f58c741179e] fbdev/atafb: Remove unus=
ed extern variables
git bisect good e000650375b65ff77c5ee852b5086f58c741179e
# bad: [461619f5c3242aaee9ec3f0b7072719bd86ea207] drm/nouveau: switch to ne=
w allocator
git bisect bad 461619f5c3242aaee9ec3f0b7072719bd86ea207
# good: [d099fc8f540add80f725014fdd4f7f49f3c58911] drm/ttm: new TT backend =
allocation pool v3
git bisect good d099fc8f540add80f725014fdd4f7f49f3c58911
# bad: [e93b2da9799e5cb97760969f3e1f02a5bdac29fe] drm/amdgpu: switch to new=
 allocator v2
git bisect bad e93b2da9799e5cb97760969f3e1f02a5bdac29fe
# bad: [ee5d2a8e549e90325fcc31825269f89647cd6fac] drm/ttm: wire up the new =
pool as default one v2
git bisect bad ee5d2a8e549e90325fcc31825269f89647cd6fac
# first bad commit: [ee5d2a8e549e90325fcc31825269f89647cd6fac] drm/ttm: wir=
e up the new pool as default one v2

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
