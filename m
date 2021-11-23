Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 75E0AC433F5
	for <virtualization@archiver.kernel.org>; Tue, 23 Nov 2021 03:35:50 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 1550F403C7;
	Tue, 23 Nov 2021 03:35:50 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
	by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id LJVT21fztBER; Tue, 23 Nov 2021 03:35:49 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp4.osuosl.org (Postfix) with ESMTPS id CF58C403B6;
	Tue, 23 Nov 2021 03:35:48 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id A8294C001E;
	Tue, 23 Nov 2021 03:35:48 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 1ECE6C0012
 for <virtualization@lists.linux-foundation.org>;
 Tue, 23 Nov 2021 03:35:48 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id 06A0E403BF
 for <virtualization@lists.linux-foundation.org>;
 Tue, 23 Nov 2021 03:35:48 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id ClUPji4Zi3q2
 for <virtualization@lists.linux-foundation.org>;
 Tue, 23 Nov 2021 03:35:47 +0000 (UTC)
X-Greylist: whitelisted by SQLgrey-1.8.0
Received: from mail-pl1-x62c.google.com (mail-pl1-x62c.google.com
 [IPv6:2607:f8b0:4864:20::62c])
 by smtp4.osuosl.org (Postfix) with ESMTPS id 89B7E403B6
 for <virtualization@lists.linux-foundation.org>;
 Tue, 23 Nov 2021 03:35:47 +0000 (UTC)
Received: by mail-pl1-x62c.google.com with SMTP id o14so15864779plg.5
 for <virtualization@lists.linux-foundation.org>;
 Mon, 22 Nov 2021 19:35:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=intel-com.20210112.gappssmtp.com; s=20210112;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=ciNARavW8blBNA0+Xvi8Iqp5SUe+gHu1UDO5Z2Om1Uw=;
 b=qv3CnJ11m0PYkOHoQ0rgeVwNALQf3M43R9jDn4noWbPwiyV5PFAUAobozTfJVM6jMN
 gGOMgeqNRIErcKP2vDX0zyTVsNeLTY8lzpDrTr9FaVXz7Nyuss7duyWWUC0w+OEpk0Y3
 wvFH7hCTeTDTzwtCf3LKbmurKbK1zzBM5VImDQVIB5KEn/Ze3QrYkkB8uns0eG1gogCu
 IMFX3s7C31lnzF9JxLo5DwiOin4O3xPlpFSzS/8STpqCkYOQubL9wZiMJBM7MgXl2Mw3
 PQRBvA8Ue2rAduBgzFAmSH8HYxXYHYxgpo2RnZmBQjB4Z5gLkF+OPLhfOEwFkjXAcpRy
 xi7w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=ciNARavW8blBNA0+Xvi8Iqp5SUe+gHu1UDO5Z2Om1Uw=;
 b=mBz3GqoDdT/vEw14dR+FbipbuTx08ydrqAskTdD4wJGqjnuiek+mTM/73IyjvM7Z4o
 XmnIphvVKeZ7j0dTrpWw9AESCNpAl1zUThFX2debE8eduKcsRxRdb8EKZuEjymKSREA2
 m/B4ubCNnuNCeZvwoEVQItoeMos7MvlyAWnPNjGN5igFzW3I0IIy6yJWvYDa/vvpwmvM
 +h/5nrZ+D5+kQLjgIsqAYW/ww4kEIuxbFiqmkHIb+xwKP4KTBilII/qlvLRFcxOA1pXX
 VRsT48ds1SvOE7Nejexc50IvRR8cgwJ4xnsPeleI0c9PIlQ+KWNuuf0fu3h/bxbekRoZ
 hrMA==
X-Gm-Message-State: AOAM533Nzkj1QaiQD9zgTphnD2wrVcU+JNH5UBoEiO2rbof7QdSi23AR
 c3Oy642ZGXxZ1GlNOcfXwqcTcqqHhLpcNmsocFLFPA==
X-Google-Smtp-Source: ABdhPJxIzgcp9HElKDkpBTZbaiahamawtMq8srzUwJcfkFqOm9FQKmJevZaNWPkBJ7GMZd7Eb5XWuI6lWDv1nhHZNS4=
X-Received: by 2002:a17:90a:e7ca:: with SMTP id
 kb10mr38062347pjb.8.1637638546993; 
 Mon, 22 Nov 2021 19:35:46 -0800 (PST)
MIME-Version: 1.0
References: <20211109083309.584081-1-hch@lst.de>
 <20211109083309.584081-6-hch@lst.de>
In-Reply-To: <20211109083309.584081-6-hch@lst.de>
From: Dan Williams <dan.j.williams@intel.com>
Date: Mon, 22 Nov 2021 19:35:36 -0800
Message-ID: <CAPcyv4hQ+=_8_6O77Ayv6Y2suxCKM+8bpBoqKTjjYjBLBp=GZg@mail.gmail.com>
Subject: Re: [PATCH 05/29] dax: remove the pgmap sanity checks in
 generic_fsdax_supported
To: Christoph Hellwig <hch@lst.de>
Cc: Linux NVDIMM <nvdimm@lists.linux.dev>, Mike Snitzer <snitzer@redhat.com>,
 linux-s390 <linux-s390@vger.kernel.org>, linux-erofs@lists.ozlabs.org,
 virtualization@lists.linux-foundation.org,
 linux-xfs <linux-xfs@vger.kernel.org>,
 device-mapper development <dm-devel@redhat.com>,
 linux-fsdevel <linux-fsdevel@vger.kernel.org>,
 linux-ext4 <linux-ext4@vger.kernel.org>, Ira Weiny <ira.weiny@intel.com>
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

On Tue, Nov 9, 2021 at 12:33 AM Christoph Hellwig <hch@lst.de> wrote:
>
> Drivers that register a dax_dev should make sure it works, no need
> to double check from the file system.

Reviewed-by: Dan Williams <dan.j.williams@intel.com>

...with a self-reminder to migrate this validation to a unit test to
backstop any future refactoring of the memmap reservation code.
_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
