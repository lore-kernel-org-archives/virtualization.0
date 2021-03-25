Return-Path: <SRS0=IaGE=IX=lists.linux-foundation.org=virtualization-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.2 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_RED,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DE798C433C1
	for <virtualization@archiver.kernel.org>; Thu, 25 Mar 2021 15:00:15 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 63E5361A0F
	for <virtualization@archiver.kernel.org>; Thu, 25 Mar 2021 15:00:15 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 63E5361A0F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=canonical.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=virtualization-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 1F28440F5C;
	Thu, 25 Mar 2021 15:00:15 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
	by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id 53yjwH9o84oE; Thu, 25 Mar 2021 15:00:14 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp4.osuosl.org (Postfix) with ESMTP id 887A040F70;
	Thu, 25 Mar 2021 15:00:13 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 5C192C000E;
	Thu, 25 Mar 2021 15:00:13 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by lists.linuxfoundation.org (Postfix) with ESMTP id AD5D5C000A
 for <virtualization@lists.linux-foundation.org>;
 Thu, 25 Mar 2021 15:00:11 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id 962396076C
 for <virtualization@lists.linux-foundation.org>;
 Thu, 25 Mar 2021 15:00:11 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id bcVvCcpROKsL
 for <virtualization@lists.linux-foundation.org>;
 Thu, 25 Mar 2021 15:00:10 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from youngberry.canonical.com (youngberry.canonical.com
 [91.189.89.112])
 by smtp3.osuosl.org (Postfix) with ESMTPS id A2BAA60B36
 for <virtualization@lists.linux-foundation.org>;
 Thu, 25 Mar 2021 15:00:10 +0000 (UTC)
Received: from 1.general.cking.uk.vpn ([10.172.193.212])
 by youngberry.canonical.com with esmtpsa
 (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128) (Exim 4.86_2)
 (envelope-from <colin.king@canonical.com>)
 id 1lPRSx-0003iZ-Uo; Thu, 25 Mar 2021 15:00:07 +0000
From: Colin Ian King <colin.king@canonical.com>
Subject: re: drm/ttm: switch to per device LRU lock
To: =?UTF-8?Q?Christian_K=c3=b6nig?= <christian.koenig@amd.com>
Message-ID: <22ad0b20-b879-bcad-5c94-80c162a9da74@canonical.com>
Date: Thu, 25 Mar 2021 15:00:07 +0000
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.8.0
MIME-Version: 1.0
Content-Language: en-US
Cc: David Airlie <airlied@linux.ie>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
 "dri-devel@lists.freedesktop.org" <dri-devel@lists.freedesktop.org>,
 virtualization@lists.linux-foundation.org, Huang Rui <ray.huang@amd.com>,
 amd-gfx mailing list <amd-gfx@lists.freedesktop.org>,
 Daniel Vetter <daniel@ffwll.ch>, spice-devel@lists.freedesktop.org
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

SGksCgpTdGF0aWMgYW5hbHlzaXMgd2l0aCBDb3Zlcml0eSBpbiBsaW51eC1uZXh0IGhhcyBkZXRl
Y3RlZCBhbiBpc3N1ZSBpbgpkcml2ZXJzL2dwdS9kcm0vdHRtL3R0bV9iby5jIHdpdGggdGhlIGZv
bGxvdyBjb21taXQ6Cgpjb21taXQgYTFmMDkxZjhlZjJiNjgwYTUxODRkYjA2NTUyNzYxMjI0N2Ni
NGNhZQpBdXRob3I6IENocmlzdGlhbiBLw7ZuaWcgPGNocmlzdGlhbi5rb2VuaWdAYW1kLmNvbT4K
RGF0ZTogICBUdWUgT2N0IDYgMTc6MjY6NDIgMjAyMCArMDIwMAoKICAgIGRybS90dG06IHN3aXRj
aCB0byBwZXIgZGV2aWNlIExSVSBsb2NrCgogICAgSW5zdGVhZCBvZiBoYXZpbmcgYSBnbG9iYWwg
bG9jayBmb3IgcG90ZW50aWFsbHkgbGVzcyBjb250ZW50aW9uLgoKClRoZSBhbmFseXNpcyBpcyBh
cyBmb2xsb3dzOgoKNjE3IGludCB0dG1fbWVtX2V2aWN0X2ZpcnN0KHN0cnVjdCB0dG1fZGV2aWNl
ICpiZGV2LAo2MTggICAgICAgICAgICAgICAgICAgICAgICBzdHJ1Y3QgdHRtX3Jlc291cmNlX21h
bmFnZXIgKm1hbiwKNjE5ICAgICAgICAgICAgICAgICAgICAgICAgY29uc3Qgc3RydWN0IHR0bV9w
bGFjZSAqcGxhY2UsCjYyMCAgICAgICAgICAgICAgICAgICAgICAgIHN0cnVjdCB0dG1fb3BlcmF0
aW9uX2N0eCAqY3R4LAo2MjEgICAgICAgICAgICAgICAgICAgICAgICBzdHJ1Y3Qgd3dfYWNxdWly
ZV9jdHggKnRpY2tldCkKNjIyIHsKICAgMS4gYXNzaWduX3plcm86IEFzc2lnbmluZzogYm8gPSBO
VUxMLgoKNjIzICAgICAgICBzdHJ1Y3QgdHRtX2J1ZmZlcl9vYmplY3QgKmJvID0gTlVMTCwgKmJ1
c3lfYm8gPSBOVUxMOwo2MjQgICAgICAgIGJvb2wgbG9ja2VkID0gZmFsc2U7CjYyNSAgICAgICAg
dW5zaWduZWQgaTsKNjI2ICAgICAgICBpbnQgcmV0Owo2MjcKCiAgIEV4cGxpY2l0IG51bGwgZGVy
ZWZlcmVuY2VkIChGT1JXQVJEX05VTEwpMi4gdmFyX2RlcmVmX29wOgpEZXJlZmVyZW5jaW5nIG51
bGwgcG9pbnRlciBiby4KCjYyOCAgICAgICAgc3Bpbl9sb2NrKCZiby0+YmRldi0+bHJ1X2xvY2sp
Owo2MjkgICAgICAgIGZvciAoaSA9IDA7IGkgPCBUVE1fTUFYX0JPX1BSSU9SSVRZOyArK2kpIHsK
ClRoZSBzcGluX2xvY2sgb24gYm8gaXMgZGVyZWZlcmVuY2luZyBhIG51bGwgYm8gcG9pbnRlci4K
CkNvbGluCl9fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fClZp
cnR1YWxpemF0aW9uIG1haWxpbmcgbGlzdApWaXJ0dWFsaXphdGlvbkBsaXN0cy5saW51eC1mb3Vu
ZGF0aW9uLm9yZwpodHRwczovL2xpc3RzLmxpbnV4Zm91bmRhdGlvbi5vcmcvbWFpbG1hbi9saXN0
aW5mby92aXJ0dWFsaXphdGlvbg==
