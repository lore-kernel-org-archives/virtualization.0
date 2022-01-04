Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 73E5DC433F5
	for <virtualization@archiver.kernel.org>; Tue,  4 Jan 2022 15:44:05 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 0946B60D5A;
	Tue,  4 Jan 2022 15:44:05 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
	by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id tgqrh_qF8sTv; Tue,  4 Jan 2022 15:44:04 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp3.osuosl.org (Postfix) with ESMTPS id A6D7A60BC1;
	Tue,  4 Jan 2022 15:44:03 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 7BE6BC002F;
	Tue,  4 Jan 2022 15:44:03 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [IPv6:2605:bc80:3010::133])
 by lists.linuxfoundation.org (Postfix) with ESMTP id D9EF4C001E;
 Tue,  4 Jan 2022 15:44:00 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id AB3CA404E7;
 Tue,  4 Jan 2022 15:44:00 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp2.osuosl.org (amavisd-new);
 dkim=pass (2048-bit key) header.d=intel.com
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id xQSlVr-MtV38; Tue,  4 Jan 2022 15:43:59 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from mga11.intel.com (mga11.intel.com [192.55.52.93])
 by smtp2.osuosl.org (Postfix) with ESMTPS id 5A400400A8;
 Tue,  4 Jan 2022 15:43:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1641311039; x=1672847039;
 h=date:from:to:cc:subject:message-id:references:
 mime-version:in-reply-to;
 bh=22y9EjrBRaMVy/mz9REdCI0A1LxLuq5BPOq8HpG1+gg=;
 b=Lwt1OJwTVHlWoTIDAsW9l7wZH57tSzFsO9SRi2qidRjoB0t0bahmNRa2
 srCzWBSKVJ69dcWGOgkrjNE7e3wSStn9tdrrhKz0dWi8ZGJ/qx1Iq0RLY
 2i8XkAxEN+FXSQTnrYHcRSeG9wt41f6nHVXcYb9HMgYLvfXsjkr1fkvIz
 JtUtPefxH28iKq+iFg0NfI0mOG+6k4zYEGfFY3sto2EZVBUL5F4wiJA79
 ZUk96ff1uy6+hJLeA61TdpRZebavZEYBJaKTJEbqY4p2IzJ3luOAGf6Uc
 TMOxyPqBGBE0uTsofhAxTtzW3876f2I5tPX8l4Nk+SxiOdQ+bBSotootu g==;
X-IronPort-AV: E=McAfee;i="6200,9189,10216"; a="239785294"
X-IronPort-AV: E=Sophos;i="5.88,261,1635231600"; d="scan'208";a="239785294"
Received: from orsmga005.jf.intel.com ([10.7.209.41])
 by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 04 Jan 2022 07:43:58 -0800
X-IronPort-AV: E=Sophos;i="5.88,261,1635231600"; d="scan'208";a="688600650"
Received: from smile.fi.intel.com ([10.237.72.61])
 by orsmga005-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 04 Jan 2022 07:43:52 -0800
Received: from andy by smile.fi.intel.com with local (Exim 4.95)
 (envelope-from <andriy.shevchenko@linux.intel.com>)
 id 1n4lxK-006GMj-Qz; Tue, 04 Jan 2022 17:42:34 +0200
Date: Tue, 4 Jan 2022 17:42:34 +0200
From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To: Jakub Kicinski <kuba@kernel.org>, mingo@kernel.org
Subject: Re: [PATCH bpf-next v2] net: don't include filter.h from net/sock.h
Message-ID: <YdRq6vKceOqscaKK@smile.fi.intel.com>
References: <20211229004913.513372-1-kuba@kernel.org>
 <5a82690c-7dc0-81de-4dd6-06e26e4b9b92@gmail.com>
 <20211229092012.635e9f2b@kicinski-fedora-PC1C0HJN.hsd1.ca.comcast.net>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20211229092012.635e9f2b@kicinski-fedora-PC1C0HJN.hsd1.ca.comcast.net>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
Cc: linux-s390@vger.kernel.org, linux-nfs@vger.kernel.org,
 Florian Fainelli <f.fainelli@gmail.com>, netfilter-devel@vger.kernel.org,
 daniel@iogearbox.net, linux-rdma@vger.kernel.org, netdev@vger.kernel.org,
 bridge@lists.linux-foundation.org, linux-wireless@vger.kernel.org,
 ast@kernel.org, linux-can@vger.kernel.org, linux-bluetooth@vger.kernel.org,
 coreteam@netfilter.org, intel-wired-lan@lists.osuosl.org,
 linux-fsdevel@vger.kernel.org, linux-hams@vger.kernel.org, bpf@vger.kernel.org,
 virtualization@lists.linux-foundation.org, ath11k@lists.infradead.org,
 linux-decnet-user@lists.sourceforge.net
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

On Wed, Dec 29, 2021 at 09:20:12AM -0800, Jakub Kicinski wrote:
> On Tue, 28 Dec 2021 17:33:39 -0800 Florian Fainelli wrote:
> > It would be nice if we used the number of files rebuilt because of a 
> > header file change as another metric that the kernel is evaluated with 
> > from release to release (or even on a commit by commit basis). Food for 
> > thought.
> 
> Maybe Andy has some thoughts, he has been working on dropping
> unnecessary includes of kernel.h, it seems.

With this [1] announcement I believe Ingo is the best to tell you if this is a
right direction.

> It'd be cool to plug something that'd warn us about significant
> increases in dependencies into the patchwork build bot.
> 
> I have one more small series which un-includes uapi/bpf.h from
> netdevice.h at which point I hope we'll be largely in the clear 
> from build bot performance perspective.

[1]: https://lore.kernel.org/lkml/YdIfz+LMewetSaEB@gmail.com/T/#u

-- 
With Best Regards,
Andy Shevchenko


_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
