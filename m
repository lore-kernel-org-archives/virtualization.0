Return-Path: <SRS0=HjFt=EO=lists.linux-foundation.org=virtualization-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F3B15C4742C
	for <virtualization@archiver.kernel.org>; Sun,  8 Nov 2020 17:59:55 +0000 (UTC)
Received: from whitealder.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 6C9A3206CB
	for <virtualization@archiver.kernel.org>; Sun,  8 Nov 2020 17:59:55 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6C9A3206CB
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=ravnborg.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=virtualization-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by whitealder.osuosl.org (Postfix) with ESMTP id F155586786;
	Sun,  8 Nov 2020 17:59:54 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from whitealder.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id OtY4AJYkwGvz; Sun,  8 Nov 2020 17:59:54 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by whitealder.osuosl.org (Postfix) with ESMTP id 7798F8677F;
	Sun,  8 Nov 2020 17:59:54 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 58441C088B;
	Sun,  8 Nov 2020 17:59:54 +0000 (UTC)
Received: from whitealder.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 19D77C016F
 for <virtualization@lists.linux-foundation.org>;
 Sun,  8 Nov 2020 17:59:53 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by whitealder.osuosl.org (Postfix) with ESMTP id 0E74186786
 for <virtualization@lists.linux-foundation.org>;
 Sun,  8 Nov 2020 17:59:53 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from whitealder.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id bfYLeWKaIuIA
 for <virtualization@lists.linux-foundation.org>;
 Sun,  8 Nov 2020 17:59:51 +0000 (UTC)
X-Greylist: from auto-whitelisted by SQLgrey-1.7.6
Received: from asavdk4.altibox.net (asavdk4.altibox.net [109.247.116.15])
 by whitealder.osuosl.org (Postfix) with ESMTPS id 9AEC88677F
 for <virtualization@lists.linux-foundation.org>;
 Sun,  8 Nov 2020 17:59:51 +0000 (UTC)
Received: from ravnborg.org (unknown [188.228.123.71])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by asavdk4.altibox.net (Postfix) with ESMTPS id 39F3B80538;
 Sun,  8 Nov 2020 18:59:47 +0100 (CET)
Date: Sun, 8 Nov 2020 18:59:45 +0100
From: Sam Ravnborg <sam@ravnborg.org>
To: trix@redhat.com
Subject: Re: [PATCH] drm: remove unneeded break
Message-ID: <20201108175945.GA1508644@ravnborg.org>
References: <20201019163115.25814-1-trix@redhat.com>
 <20201019170641.GA963808@ravnborg.org>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20201019170641.GA963808@ravnborg.org>
X-CMAE-Score: 0
X-CMAE-Analysis: v=2.3 cv=VafZwmh9 c=1 sm=1 tr=0
 a=S6zTFyMACwkrwXSdXUNehg==:117 a=S6zTFyMACwkrwXSdXUNehg==:17
 a=kj9zAlcOel0A:10 a=20KFwNOVAAAA:8 a=7gkXJVJtAAAA:8
 a=fi46lLvuFyj7XQ7yi5sA:9 a=CjuIK1q_8ugA:10 a=E9Po1WZjFZOl8hwRPBS3:22
Cc: airlied@linux.ie, nouveau@lists.freedesktop.org, gustavoars@kernel.org,
 dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org,
 tzimmermann@suse.de, airlied@redhat.com, spice-devel@lists.freedesktop.org,
 virtualization@lists.linux-foundation.org, bskeggs@redhat.com
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

Hi Tom
On Mon, Oct 19, 2020 at 07:06:41PM +0200, Sam Ravnborg wrote:
> Hi Tom
> On Mon, Oct 19, 2020 at 09:31:15AM -0700, trix@redhat.com wrote:
> > From: Tom Rix <trix@redhat.com>
> > 
> > A break is not needed if it is preceded by a return or break
> > 
> > Signed-off-by: Tom Rix <trix@redhat.com>
> 
> Looks good and builds with no warnings.
> 
> One of the diffs made me - "oh this looks wrong". But after I looked again
> it was right and the resulting code is more readable - so good.
> 
> Acked-by: Sam Ravnborg <sam@ravnborg.org>
> 
> Was tempted to just apply to drm-misc-next but will give others the
> opportunity to chime in.

Thanks.
Now applied to drm-misc-next - will show up in -next in a week or so.

	Sam
_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
