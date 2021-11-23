Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 89640C433EF
	for <virtualization@archiver.kernel.org>; Tue, 23 Nov 2021 04:02:57 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 1B93460600;
	Tue, 23 Nov 2021 04:02:57 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
	by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id sUmQ6GwsYdjA; Tue, 23 Nov 2021 04:02:56 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp3.osuosl.org (Postfix) with ESMTPS id C877160605;
	Tue, 23 Nov 2021 04:02:55 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 9878CC001E;
	Tue, 23 Nov 2021 04:02:55 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by lists.linuxfoundation.org (Postfix) with ESMTP id AF448C0012
 for <virtualization@lists.linux-foundation.org>;
 Tue, 23 Nov 2021 04:02:54 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id 9DE664018E
 for <virtualization@lists.linux-foundation.org>;
 Tue, 23 Nov 2021 04:02:54 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp4.osuosl.org (amavisd-new);
 dkim=pass (2048-bit key) header.d=intel-com.20210112.gappssmtp.com
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id QTpt0SgSBDAh
 for <virtualization@lists.linux-foundation.org>;
 Tue, 23 Nov 2021 04:02:54 +0000 (UTC)
X-Greylist: whitelisted by SQLgrey-1.8.0
Received: from mail-pl1-x635.google.com (mail-pl1-x635.google.com
 [IPv6:2607:f8b0:4864:20::635])
 by smtp4.osuosl.org (Postfix) with ESMTPS id 1366E4017B
 for <virtualization@lists.linux-foundation.org>;
 Tue, 23 Nov 2021 04:02:53 +0000 (UTC)
Received: by mail-pl1-x635.google.com with SMTP id p18so15886975plf.13
 for <virtualization@lists.linux-foundation.org>;
 Mon, 22 Nov 2021 20:02:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=intel-com.20210112.gappssmtp.com; s=20210112;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=g/ky7DkMfynxz93Jg1Thyokk1eZpzUf1Xl2rDhRoyWA=;
 b=sflh6j00R53ITli5bO2IoAwQaIa8VR/tllaujepF7nQ0McJ6iT2CSZUK7BuB1zU6If
 9CwhHY4WZipWFFT6wSgL9NXJHKzpWx4dzREV1QewVHPXAfe3nZ2ge9ayabqAClcoOtMT
 6CWsvm27gk7VLVryyb3GQ4RxleOrmnBmuKNS+T6GLom6VfHHQqPk8G9iMZiGpJfXA6jD
 WtPXA13msMgztdGrXOYIM1Tv6bLvkl2kjxHbaH2u8afmQwOPoz4TylpBWUlzjs7RiwZQ
 Q7dRhRXUS7ma5L6pdFg1NOadjevEswoXcEKlTQmOlLvpZ8ukBNqCZ65Zu45i5yf8msAV
 Rrgg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=g/ky7DkMfynxz93Jg1Thyokk1eZpzUf1Xl2rDhRoyWA=;
 b=uRy/PTVEV4iwjG6RWBttfiVWPHYIECXoyD6mrRQhJY9V3ih+l01xObojeRuh5S4c2w
 kzhlbyE3nnLJ8/22iaNIV+uuc7gO6BPDPuqjUjN42Du2HmHAr4km3KEF0CGICetmI6Kf
 UGqqsRcW0FUHBXtqLfldK80vVIZEk0Ln+2y1YkZHBr6XWoqsIIQraKPfblZwTcJ1Cn/P
 xy/tKWa1jm6VornHJKKeS9+vWhRIHWxh8EgrX90xf85q23EB95pw1ANpixWYGJ+yzfdq
 3Z0yN3Rziif1ypa5YrJeyl2BBSCccPXTiOQYb3IKvXbGtLjds3qkBUrWZwEGO9T8RaXm
 pYqQ==
X-Gm-Message-State: AOAM531DqocLadFEdlCAueo8EJU89kAl9xFff1JgPhss8V43nZO356xD
 AH8Rn85CPIGYlVg/ek0em0ZfGikxFRYV5MF7mxQ/0g==
X-Google-Smtp-Source: ABdhPJxvSLmX3xye88c668D00uWDdnnCeZiY99i/tpK8E6hWm4PH0+Kg/6cCj46QhqqZS8+/hIjz2nKulq2NhEFbIuM=
X-Received: by 2002:a17:90b:1e07:: with SMTP id
 pg7mr2663610pjb.93.1637640173575; 
 Mon, 22 Nov 2021 20:02:53 -0800 (PST)
MIME-Version: 1.0
References: <20211109083309.584081-1-hch@lst.de>
 <20211109083309.584081-11-hch@lst.de>
In-Reply-To: <20211109083309.584081-11-hch@lst.de>
From: Dan Williams <dan.j.williams@intel.com>
Date: Mon, 22 Nov 2021 20:02:42 -0800
Message-ID: <CAPcyv4hUSRSVBP_G6z7fPUwvb=3F2q4mrGhmD9A4nez=DrEdWQ@mail.gmail.com>
Subject: Re: [PATCH 10/29] dm-log-writes: add a log_writes_dax_pgoff helper
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
> Add a helper to perform the entire remapping for DAX accesses.  This
> helper open codes bdev_dax_pgoff given that the alignment checks have
> already been done by the submitting file system and don't need to be
> repeated.
>
> Signed-off-by: Christoph Hellwig <hch@lst.de>
> Acked-by: Mike Snitzer <snitzer@redhat.com>

Reviewed-by: Dan Williams <dan.j.williams@intel.com>
_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
