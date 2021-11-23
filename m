Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A87D4C433EF
	for <virtualization@archiver.kernel.org>; Tue, 23 Nov 2021 03:51:33 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id F0FF140474;
	Tue, 23 Nov 2021 03:51:32 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
	by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id dnGLXUBMUGED; Tue, 23 Nov 2021 03:51:32 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp4.osuosl.org (Postfix) with ESMTPS id CA990402B2;
	Tue, 23 Nov 2021 03:51:31 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 92B6EC001E;
	Tue, 23 Nov 2021 03:51:31 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [IPv6:2605:bc80:3010::138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 7A47DC0012
 for <virtualization@lists.linux-foundation.org>;
 Tue, 23 Nov 2021 03:51:29 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id 555FF80D43
 for <virtualization@lists.linux-foundation.org>;
 Tue, 23 Nov 2021 03:51:29 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp1.osuosl.org (amavisd-new);
 dkim=pass (2048-bit key) header.d=intel-com.20210112.gappssmtp.com
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id rdZuawsmuuif
 for <virtualization@lists.linux-foundation.org>;
 Tue, 23 Nov 2021 03:51:27 +0000 (UTC)
X-Greylist: whitelisted by SQLgrey-1.8.0
Received: from mail-pl1-x633.google.com (mail-pl1-x633.google.com
 [IPv6:2607:f8b0:4864:20::633])
 by smtp1.osuosl.org (Postfix) with ESMTPS id 6706780D40
 for <virtualization@lists.linux-foundation.org>;
 Tue, 23 Nov 2021 03:51:27 +0000 (UTC)
Received: by mail-pl1-x633.google.com with SMTP id u17so15892050plg.9
 for <virtualization@lists.linux-foundation.org>;
 Mon, 22 Nov 2021 19:51:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=intel-com.20210112.gappssmtp.com; s=20210112;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=set6lIbZWt1UwkjEncJQUmHWp82483Zo0VHgKUnBt0w=;
 b=jaUppntJAg9/mAuYY2fdr9gBd/oPSVvQjQU9MV63keKS4G12JP+nEpEbf/XFgQhTnX
 lYhroHBz4A/n/ueNjXRdi4PGz3IaMMWx7LGsyQ+k3PmsLBwgA59MgQmr1YDS9DWkwjiz
 h84Lz9nQApqhFCv5vhWhKtFCwv3whkuknXHpmp6xY5puSg20rPurJJzE+22u3JyTEE6e
 V2urCXYlCDQCwVaaqgneBsM+4H995+ijZVTqf+fHfdEatR6QlNecFf1J/UGHfHqEPUgZ
 uA/eGzna5QhHm2jHR+WAFoVlyr/aaF9uDy12SjgTOzdukRcbvTwMgK4DzpeCeqXvlNDK
 as+w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=set6lIbZWt1UwkjEncJQUmHWp82483Zo0VHgKUnBt0w=;
 b=V/miO1N08Lz/gZ7VCihWyzJ4xTBjn7LCaUXIcYAzjJ6URkS3ZFkvOHTZc2WajFyoE6
 mXKRIkPOGQX1IdlZUKb7+RbGf4Y5EhLfh5TPY/zuh/iH75OpLN6R4UJSCdlfkgs5i5Tn
 1iIspMmaovdd7aSe0pnYQ1DcbqntoE6YzHKUfuPlmeXBDgsyDOLkJ4N4eITEuM57nlqv
 NcREBSNlM0knsbUZ1zTGlyKoLq6gfZOlLvL3CAFGW1YJ6bialuVYXMOixglXbDZwp+pW
 NGHhK2/5jHluh8XvenDiBtKkTSkfk2ABrcH0bJF86owfzfKb1sb6oQzAl4VsuSzhwCAS
 6nlA==
X-Gm-Message-State: AOAM532kYCW51qWUiSSV3WEpnVvOjAz+khClN6t1DPiFyJ98ZVDR41Ox
 /BlyWfFyQEUq1T2Yi9LWCObnkgboofcYhRVvIwQ7LA==
X-Google-Smtp-Source: ABdhPJwgdeM7vJZ2DKKwalEr7KeonINU2K18nZr67CpB7ixzXQKpSb7Eol7dgHhzUPEgLb+CGDYy92xBtwbeaxDZs1M=
X-Received: by 2002:a17:902:6acb:b0:142:76c3:d35f with SMTP id
 i11-20020a1709026acb00b0014276c3d35fmr2967201plt.89.1637639486743; Mon, 22
 Nov 2021 19:51:26 -0800 (PST)
MIME-Version: 1.0
References: <20211109083309.584081-1-hch@lst.de>
 <20211109083309.584081-8-hch@lst.de>
In-Reply-To: <20211109083309.584081-8-hch@lst.de>
From: Dan Williams <dan.j.williams@intel.com>
Date: Mon, 22 Nov 2021 19:51:15 -0800
Message-ID: <CAPcyv4jnLdFaDwLTeRhJcTzyjd-psZRgWqVDqzOAZr3EGLbF2w@mail.gmail.com>
Subject: Re: [PATCH 07/29] xfs: factor out a xfs_setup_dax_always helper
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
> Factor out another DAX setup helper to simplify future changes.  Also
> move the experimental warning after the checks to not clutter the log
> too much if the setup failed.
>
> Signed-off-by: Christoph Hellwig <hch@lst.de>

Reviewed-by: Dan Williams <dan.j.williams@intel.com>
_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
