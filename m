Return-Path: <SRS0=Fazc=QA=lists.linux-foundation.org=virtualization-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B1A3CC433EF
	for <virtualization@archiver.kernel.org>; Sat, 13 Nov 2021 11:07:09 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 3EB3160F70
	for <virtualization@archiver.kernel.org>; Sat, 13 Nov 2021 11:07:09 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org 3EB3160F70
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by smtp2.osuosl.org (Postfix) with ESMTP id CE8964013B;
	Sat, 13 Nov 2021 11:07:08 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
	by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id 4_RLqTgSMzgU; Sat, 13 Nov 2021 11:07:08 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp2.osuosl.org (Postfix) with ESMTPS id 6607A40157;
	Sat, 13 Nov 2021 11:07:07 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 335F2C001E;
	Sat, 13 Nov 2021 11:07:07 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [IPv6:2605:bc80:3010::138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 346E5C0012
 for <virtualization@lists.linux-foundation.org>;
 Sat, 13 Nov 2021 11:07:06 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id 1672F82451
 for <virtualization@lists.linux-foundation.org>;
 Sat, 13 Nov 2021 11:07:06 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp1.osuosl.org (amavisd-new);
 dkim=pass (2048-bit key) header.d=gmail.com
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id DSH3XuZCdYr6
 for <virtualization@lists.linux-foundation.org>;
 Sat, 13 Nov 2021 11:07:05 +0000 (UTC)
X-Greylist: whitelisted by SQLgrey-1.8.0
Received: from mail-yb1-xb2e.google.com (mail-yb1-xb2e.google.com
 [IPv6:2607:f8b0:4864:20::b2e])
 by smtp1.osuosl.org (Postfix) with ESMTPS id E541282437
 for <virtualization@lists.linux-foundation.org>;
 Sat, 13 Nov 2021 11:07:04 +0000 (UTC)
Received: by mail-yb1-xb2e.google.com with SMTP id v138so30826297ybb.8
 for <virtualization@lists.linux-foundation.org>;
 Sat, 13 Nov 2021 03:07:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20210112;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=VSwBIpAKOvKE9/HfMni6vvyfMrUyqVOn+Ln8uGL1xcQ=;
 b=lmaLjcu6MnsUaKTfJOWQ3NCLah2twVb8rnhqSvRx1VtxjI9xCQ9Ao9/XFIWVKb/HLf
 K5HymG0R5CrZ930OT/c7NdRoI1z9iefbZZ82mVxzfmi5N019vVwam3rY0k9vR9qtuF4j
 II3m0FZW3u9w6RtUpOD5sS9iul4ax2s8WsCF7Bz4t0Hjzsz/AmkDfuEatFMd1z3YbN5/
 Ndw9ECBPcD1XwYRwdl8aubGwWXO47Fxc+XL9OFJKOONAUaqWAvDlGxAJJCXW0X8axC3D
 HEMvlHtxpeOmJNaeP64EcJQs1YgccppntT5w6gjnQRp9P9srtvXxxE9I9wo2HI0yegGH
 q2IQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=VSwBIpAKOvKE9/HfMni6vvyfMrUyqVOn+Ln8uGL1xcQ=;
 b=cPy38oKXfH4OJEf8g/NL2zJjaepvqK+GSrtDpq747zAe6CdKBBaO1ur6faJaf2YkbQ
 uBSw9ap9z8t0Xhpp5Etr++Ht3cI8V9lxzQ//DluF7LSl+d8fWzgc5k2TzxGsOKGGskXV
 j8RP9RI/eNQeAmoohLshCfndg3KNlNIQDnVwwMpidbbjwT9wDYPgwFw3ONTH2SJ//G8Y
 7cVrgnitMVWdA3uIsD7wFf+loIHTOVMIatXRnqzIocsyHBDm8IsmG/NcN6yepvKXBrT+
 jAGW8fPA4KXhiKgrl6obfzHzECOcYyTaaDfPcwsFKqbwHv2zFM6GZAfCj7O1fE5Nt2Ya
 ahYg==
X-Gm-Message-State: AOAM530Ryqm3c30Yx4hQdl+JZn88ydl+fdWOaEDQiFce42WICRaueir7
 iy0g512HuAdsdG6CiAfuyTNeASRbLXU5pY5LNCQ=
X-Google-Smtp-Source: ABdhPJyJSJBgIErAQL04cOmL6TrLYrxEMcCzqyulHgBnnK1s8n2Cg7iTYX25GttsV+7OTFXS7M+xXNQnHUz1qgHPDo8=
X-Received: by 2002:a25:bdc5:: with SMTP id g5mr23978411ybk.403.1636801623864; 
 Sat, 13 Nov 2021 03:07:03 -0800 (PST)
MIME-Version: 1.0
References: <CADVatmOuOk6RoZF=M9sZm2L=9NuDDsSNNCJJbAtkgScG0og1Ww@mail.gmail.com>
 <CADVatmP_Sn+SS5Yu5+7sJJ5SVpcaZcW8Z_Bj5vmYz9g3kJD86g@mail.gmail.com>
In-Reply-To: <CADVatmP_Sn+SS5Yu5+7sJJ5SVpcaZcW8Z_Bj5vmYz9g3kJD86g@mail.gmail.com>
From: Sudip Mukherjee <sudipm.mukherjee@gmail.com>
Date: Sat, 13 Nov 2021 11:06:28 +0000
Message-ID: <CADVatmOOzCxAgLhCu1tTz=44sgRDXds5-oMZ3V0w4f5kLCLKrw@mail.gmail.com>
Subject: Re: regression with mainline kernel
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: linux-kernel <linux-kernel@vger.kernel.org>,
 Nicholas Verne <nverne@chromium.org>,
 dri-devel <dri-devel@lists.freedesktop.org>,
 "open list:VIRTIO GPU DRIVER" <virtualization@lists.linux-foundation.org>,
 Daniel Vetter <daniel@ffwll.ch>, Gurchetan Singh <gurchetansingh@chromium.org>
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

On Thu, Nov 11, 2021 at 8:51 PM Sudip Mukherjee
<sudipm.mukherjee@gmail.com> wrote:
>
> Hi Linus,
>
> On Thu, Nov 11, 2021 at 2:03 PM Sudip Mukherjee
> <sudipm.mukherjee@gmail.com> wrote:
> >
> > Hi Linus,
> >
> > My testing has been failing for the last few days. Last good test was
> > with 6f2b76a4a384 and I started seeing the failure with ce840177930f5
> > where boot timeout.

Last night's test on 66f4beaa6c1d worked fine. So I guess this has now
been fixed.
Thanks.


-- 
Regards
Sudip
_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
