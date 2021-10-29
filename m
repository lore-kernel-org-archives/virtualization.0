Return-Path: <SRS0=mz8r=PR=lists.linux-foundation.org=virtualization-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AD8DEC433FE
	for <virtualization@archiver.kernel.org>; Fri, 29 Oct 2021 15:42:45 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 58062611C4
	for <virtualization@archiver.kernel.org>; Fri, 29 Oct 2021 15:42:45 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org 58062611C4
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=intel.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by smtp2.osuosl.org (Postfix) with ESMTP id 1543A4015E;
	Fri, 29 Oct 2021 15:42:45 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
	by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id Oit_Oov8V61w; Fri, 29 Oct 2021 15:42:44 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp2.osuosl.org (Postfix) with ESMTPS id 8899340168;
	Fri, 29 Oct 2021 15:42:43 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 6A4F8C001E;
	Fri, 29 Oct 2021 15:42:43 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 54BD8C0012
 for <virtualization@lists.linux-foundation.org>;
 Fri, 29 Oct 2021 15:42:42 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id 430CE80EE8
 for <virtualization@lists.linux-foundation.org>;
 Fri, 29 Oct 2021 15:42:42 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp1.osuosl.org (amavisd-new);
 dkim=pass (2048-bit key) header.d=intel-com.20210112.gappssmtp.com
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id C_7Rc487Z_gU
 for <virtualization@lists.linux-foundation.org>;
 Fri, 29 Oct 2021 15:42:41 +0000 (UTC)
X-Greylist: whitelisted by SQLgrey-1.8.0
Received: from mail-pf1-x432.google.com (mail-pf1-x432.google.com
 [IPv6:2607:f8b0:4864:20::432])
 by smtp1.osuosl.org (Postfix) with ESMTPS id 8B79880EE7
 for <virtualization@lists.linux-foundation.org>;
 Fri, 29 Oct 2021 15:42:41 +0000 (UTC)
Received: by mail-pf1-x432.google.com with SMTP id t184so9651523pfd.0
 for <virtualization@lists.linux-foundation.org>;
 Fri, 29 Oct 2021 08:42:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=intel-com.20210112.gappssmtp.com; s=20210112;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=kkrK8/+uwUhU1+ibCc9sihgvRMe3oeCDEJlEEAsQMNY=;
 b=6wmVMWLAKN8exE8XR8wv/iFYhudFZm/xaEJpNEZmOxWSzGBAVEn+M6ckTQFipGdRJT
 yb6PYTTcKIVqTXGsV3bkPy2TCiq4+HLgRy2cRXBAvM33znfROc4XjMNFzIfr4UE69rdj
 4eISFf7aFEyAHo2Sf/MANtuSqjdRnwdAyb7h0RnbdOmg2MrJVd+mPCxh87qxZR21UV1T
 Jo7MDmjd0zsp2/1yCw8PZ5/EZTwQNFNoOJVWhez881Nf3OlrTKHfCKrLAxk43DLXDdPH
 n00SPDakiTsjm+voDnH7pSuvR7gHcdocX6KbBQemE5xaUaALVKmTKfT7gJVRpb96WLOa
 Bfgg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=kkrK8/+uwUhU1+ibCc9sihgvRMe3oeCDEJlEEAsQMNY=;
 b=umdSWf2xADOMl+Z/C7JbqUuyVav6leQGZt5a3WCBGHVYkkmQQE1wO/KQE8PV2YnSEl
 +ItqT2xf7zok/o8cQV+M6c//y0Xv9h8Wfxt/wYgZSTkW4iI6+eWrX0p96nXAmlucEX9h
 DKnP2EPxr7RuYWhz0MK1ZBfU0hkL430KjHVFtQJBOOC7Bx/onknG5btHjgo1Pied3MvW
 jUFcED8axVkR1qtuvCriFFNCbKe6l/qWhEk5HK9YdoILHEJDPzatm+QohTzEk5p/nxdf
 VBt6gG0uNyNuhVCdbRdZPttZXD6NdfGzMc2Qx23OG65D8ucnKBtcdTiFaGoercayvZ27
 +FvA==
X-Gm-Message-State: AOAM533G+l7gYLY6aM9eWBP/FZSpPhV6EBHYAnCpB2xgTNIhhuKKGJVA
 d+/IL8/bYsxG12uCE3Ag2qqLmGah/jWuMc89wY82qg==
X-Google-Smtp-Source: ABdhPJwscYMJBcsf4QuT7rFuYsL/BYYBLAhJeu/07ZB2t6F9Qexmb3kIziq0UAiLr3A7UbGhuhxXArjTEfzlR4kAptU=
X-Received: by 2002:a05:6a00:140e:b0:444:b077:51ef with SMTP id
 l14-20020a056a00140e00b00444b07751efmr11616698pfu.61.1635522160977; Fri, 29
 Oct 2021 08:42:40 -0700 (PDT)
MIME-Version: 1.0
References: <20211018044054.1779424-1-hch@lst.de>
 <CAPcyv4iEt78-XSsKjTWcpy71zaduXyyigTro6f3fmRqqFOG98Q@mail.gmail.com>
 <20211029105139.1194bb7f@canb.auug.org.au>
In-Reply-To: <20211029105139.1194bb7f@canb.auug.org.au>
From: Dan Williams <dan.j.williams@intel.com>
Date: Fri, 29 Oct 2021 08:42:29 -0700
Message-ID: <CAPcyv4g8iEyN5UN1w1xBqQDYSb3HCh7_smsmjt-PiHORRK+X9Q@mail.gmail.com>
Subject: Re: futher decouple DAX from block devices
To: Stephen Rothwell <sfr@canb.auug.org.au>, Christoph Hellwig <hch@lst.de>, 
 "Darrick J. Wong" <djwong@kernel.org>,
 Shiyang Ruan <ruansy.fnst@fujitsu.com>
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

On Thu, Oct 28, 2021 at 4:52 PM Stephen Rothwell <sfr@canb.auug.org.au> wrote:
>
> Hi Dan,
>
> On Wed, 27 Oct 2021 13:46:31 -0700 Dan Williams <dan.j.williams@intel.com> wrote:
> >
> > My merge resolution is here [1]. Christoph, please have a look. The
> > rebase and the merge result are both passing my test and I'm now going
> > to review the individual patches. However, while I do that and collect
> > acks from DM and EROFS folks, I want to give Stephen a heads up that
> > this is coming. Primarily I want to see if someone sees a better
> > strategy to merge this, please let me know, but if not I plan to walk
> > Stephen and Linus through the resolution.
>
> It doesn't look to bad to me (however it is a bit late in the cycle :-(
> ).  Once you are happy, just put it in your tree (some of the conflicts
> are against the current -rc3 based version of your tree anyway) and I
> will cope with it on Monday.

Christoph, Darrick, Shiyang,

I'm losing my nerve to try to jam this into v5.16 this late in the
cycle. I do want to get dax+reflink squared away as soon as possible,
but that looks like something that needs to build on top of a
v5.16-rc1 at this point. If Linus does a -rc8 then maybe it would have
enough soak time, but otherwise I want to take the time to collect the
acks and queue up some more follow-on cleanups to prepare for
block-less-dax.
_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
