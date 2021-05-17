Return-Path: <SRS0=CgtS=KM=lists.linux-foundation.org=virtualization-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7BD28C433B4
	for <virtualization@archiver.kernel.org>; Mon, 17 May 2021 09:39:45 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 1D1F561206
	for <virtualization@archiver.kernel.org>; Mon, 17 May 2021 09:39:45 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1D1F561206
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=sipsolutions.net
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=virtualization-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id D918B83372;
	Mon, 17 May 2021 09:39:44 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
	by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id aTMTsu6ESN_f; Mon, 17 May 2021 09:39:44 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp1.osuosl.org (Postfix) with ESMTP id 97FCE8329A;
	Mon, 17 May 2021 09:39:43 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 6A973C000E;
	Mon, 17 May 2021 09:39:43 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [IPv6:2605:bc80:3010::138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 4DBB8C0001
 for <virtualization@lists.linux-foundation.org>;
 Mon, 17 May 2021 09:39:41 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id 3814E83366
 for <virtualization@lists.linux-foundation.org>;
 Mon, 17 May 2021 09:39:41 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id GsA6udY5HZn0
 for <virtualization@lists.linux-foundation.org>;
 Mon, 17 May 2021 09:39:40 +0000 (UTC)
X-Greylist: delayed 00:27:24 by SQLgrey-1.8.0
Received: from sipsolutions.net (s3.sipsolutions.net
 [IPv6:2a01:4f8:191:4433::2])
 by smtp1.osuosl.org (Postfix) with ESMTPS id 075958329A
 for <virtualization@lists.linux-foundation.org>;
 Mon, 17 May 2021 09:39:39 +0000 (UTC)
Received: by sipsolutions.net with esmtpsa
 (TLS1.3:ECDHE_SECP256R1__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
 (Exim 4.94.2) (envelope-from <johannes@sipsolutions.net>)
 id 1liZI8-00AGhX-T1; Mon, 17 May 2021 11:12:00 +0200
Message-ID: <1f8289f84cd4dd9f440705d3ebab2c8a3e2e6a2c.camel@sipsolutions.net>
Subject: Re: [RFC PATCH 01/17] virtio_ring: Avoid reading unneeded used length
From: Johannes Berg <johannes@sipsolutions.net>
To: Xie Yongji <xieyongji@bytedance.com>, mst@redhat.com,
 jasowang@redhat.com,  stefanha@redhat.com
Date: Mon, 17 May 2021 11:11:59 +0200
In-Reply-To: <20210517090836.533-2-xieyongji@bytedance.com>
 (sfid-20210517_110907_205181_BA136748)
References: <20210517090836.533-1-xieyongji@bytedance.com>
 <20210517090836.533-2-xieyongji@bytedance.com>
 (sfid-20210517_110907_205181_BA136748)
User-Agent: Evolution 3.38.4 (3.38.4-1.fc33) 
MIME-Version: 1.0
X-malware-bazaar: not-scanned
Cc: ohad@wizery.com, amit@kernel.org, airlied@linux.ie,
 linux-kernel@vger.kernel.org, bjorn.andersson@linaro.org, miklos@szeredi.hu,
 dan.j.williams@intel.com, virtualization@lists.linux-foundation.org,
 vgoyal@redhat.com
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
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: virtualization-bounces@lists.linux-foundation.org
Sender: "Virtualization" <virtualization-bounces@lists.linux-foundation.org>

On Mon, 2021-05-17 at 17:08 +0800, Xie Yongji wrote:
> If device driver doesn't need used length, it can pass a NULL
> len in virtqueue_get_buf()/virtqueue_get_buf_ctx().
> 

Well, actually, it can't right now?

You should probably rephrase this, saying something like

   Allow passing NULL to len in ... if the device driver doesn't need
   the length, and don't read it in that case.

or so?

>  Then
> we can avoid reading and validating the len value in used
> ring entries.

Not sure what that "validating" is about, I only see reading?

johannes

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
