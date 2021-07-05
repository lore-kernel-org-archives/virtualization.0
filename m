Return-Path: <SRS0=2LZG=L5=lists.linux-foundation.org=virtualization-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.1 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7080CC07E98
	for <virtualization@archiver.kernel.org>; Mon,  5 Jul 2021 06:30:11 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 12A8D613B0
	for <virtualization@archiver.kernel.org>; Mon,  5 Jul 2021 06:30:11 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 12A8D613B0
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=virtualization-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id C8039607AC;
	Mon,  5 Jul 2021 06:30:10 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
	by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id Bop-oRPqrbwG; Mon,  5 Jul 2021 06:30:10 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp3.osuosl.org (Postfix) with ESMTPS id 605B8607A8;
	Mon,  5 Jul 2021 06:30:09 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 3F303C0010;
	Mon,  5 Jul 2021 06:30:09 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 17CC7C000E
 for <virtualization@lists.linux-foundation.org>;
 Mon,  5 Jul 2021 06:30:08 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id 06CCB83542
 for <virtualization@lists.linux-foundation.org>;
 Mon,  5 Jul 2021 06:30:08 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp1.osuosl.org (amavisd-new);
 dkim=pass (2048-bit key) header.d=linaro.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id HbVx7wy-bjNa
 for <virtualization@lists.linux-foundation.org>;
 Mon,  5 Jul 2021 06:30:07 +0000 (UTC)
X-Greylist: whitelisted by SQLgrey-1.8.0
Received: from mail-pl1-x631.google.com (mail-pl1-x631.google.com
 [IPv6:2607:f8b0:4864:20::631])
 by smtp1.osuosl.org (Postfix) with ESMTPS id F3B13833FB
 for <virtualization@lists.linux-foundation.org>;
 Mon,  5 Jul 2021 06:30:06 +0000 (UTC)
Received: by mail-pl1-x631.google.com with SMTP id c15so9685574pls.13
 for <virtualization@lists.linux-foundation.org>;
 Sun, 04 Jul 2021 23:30:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=date:from:to:cc:subject:message-id:references:mime-version
 :content-disposition:content-transfer-encoding:in-reply-to
 :user-agent; bh=kCy8PdVHeBTIQi07/Sw1LRfb7Q/EXacATKTbYu+2Fck=;
 b=QVj/ekGNd3LBhRATDInKpV5990ELYYESSnDGSuO7s+S/DGN6i/2CHSGVagsK/5dtEB
 OnUSmlD8FN9S25MJ3QAtWFtjXNCNA105DEEPRQYLlOj96d1x7IIV7eJ2zHttF0nDN+7+
 pspEb/iyZSFI+0Z/hM6lSrMpxYx1wm+730lobEUZHlNvd2ZVg+61Ybr0LgSiSyk95mtM
 hroAfuUkvIXQnI73a62/3/wSCn71CKnpD9qzbE29qEAA/4YvVla7c+/hXxk1lTOnkDgp
 3+C9JXZhJGH5MGkoEAN3uJ8Ui0GAGJ272cr80ZlHuQ9wdeM3KAExsYCl6NZg05cpY1vG
 0oCQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:content-transfer-encoding
 :in-reply-to:user-agent;
 bh=kCy8PdVHeBTIQi07/Sw1LRfb7Q/EXacATKTbYu+2Fck=;
 b=uBPh/coup0TDEQuVOKeewhvP5/g56nK0ZwXal1IvnZG+7+ZU4v8NO+OxXMPYGGdhqD
 FeB9fDanvC/TPZZCxEJoiUhMZeIGh5uh+WLC4MWFcSaz3F27d0P5rZBNPLlrAS1woXjo
 JyOMDT8GSC447JxqWPGNrqbsGxCxNaE/iqOo97iJNJEwp2G/raLONFUxMM0Uc9gEHC7Q
 yrN6aGtXCfAgDlOLsBnUIr9oZ1ErEK/bTzUAMQ+P0nKjZsF7xtk0ja3gb46NiSYji1Xa
 +uhgWsbL0WdaqJp8/gDVmhT9l2/iKxq8nmvhijg9HTGm44kgmtoyNxYPUDgkeXpxB4O2
 N6UQ==
X-Gm-Message-State: AOAM5339sY9KdQB2Ncg0dwE02/eHUCQ+TEYq7o8cmR1UnK8AemYchIVe
 KvMf1gap9Z3fdjqWnPV58dzf5A==
X-Google-Smtp-Source: ABdhPJzBIjW9yRmqeZARi3S9SO1AVvqH+PAwMV2PmCiAtk/oYko+ycXfzgAZ06qspQnraYwJUsbgZw==
X-Received: by 2002:a17:90b:4b87:: with SMTP id
 lr7mr13983622pjb.214.1625466606283; 
 Sun, 04 Jul 2021 23:30:06 -0700 (PDT)
Received: from localhost ([106.201.108.2])
 by smtp.gmail.com with ESMTPSA id v21sm19445795pju.47.2021.07.04.23.30.05
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 04 Jul 2021 23:30:05 -0700 (PDT)
Date: Mon, 5 Jul 2021 12:00:03 +0530
From: Viresh Kumar <viresh.kumar@linaro.org>
To: Jie Deng <jie.deng@intel.com>
Subject: Re: [PATCH v12] i2c: virtio: add a virtio i2c frontend driver
Message-ID: <20210705063003.a45ic3wn74nre6xe@vireshk-i7>
References: <f229cd761048bc143f88f33a3437bdbf891c39fd.1625214435.git.jie.deng@intel.com>
 <20210705024056.ndth2bwn2itii5g3@vireshk-i7>
 <332af2be-0fb0-a846-8092-49d496fe8b6b@intel.com>
 <20210705043841.zujwo672nfdndpg2@vireshk-i7>
 <6aabc877-673a-e2bc-da2d-ec6741b4159b@intel.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <6aabc877-673a-e2bc-da2d-ec6741b4159b@intel.com>
User-Agent: NeoMutt/20180716-391-311a52
Cc: yu1.wang@intel.com, arnd@arndb.de, mst@redhat.com,
 linux-kernel@vger.kernel.org, virtualization@lists.linux-foundation.org,
 wsa@kernel.org, wsa+renesas@sang-engineering.com, linux-i2c@vger.kernel.org,
 stefanha@redhat.com, shuo.a.liu@intel.com, andriy.shevchenko@linux.intel.com,
 conghui.chen@intel.com
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
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Errors-To: virtualization-bounces@lists.linux-foundation.org
Sender: "Virtualization" <virtualization-bounces@lists.linux-foundation.org>

On 05-07-21, 14:22, Jie Deng wrote:
> On 2021/7/5 12:38, Viresh Kumar wrote:
> > On 05-07-21, 11:45, Jie Deng wrote:
> > > On 2021/7/5 10:40, Viresh Kumar wrote:
> > > > On 02-07-21, 16:46, Jie Deng wrote:
> > > > The right way of doing this is is making this function return - Err=
or on failure
> > > > and 0 on success. There is no point returning number of successful =
additions
> > > > here.
> > > =

> > > We need the number for virtio_i2c_complete_reqs to do cleanup. We don=
't have
> > > to
> > > =

> > > do cleanup "num" times every time. Just do it as needed.
> > If you do full cleanup here, then you won't required that at the caller=
 site.
> > =

> > > > Moreover, on failures this needs to clean up (free the dmabufs) its=
elf, just
> > > > like you did i2c_put_dma_safe_msg_buf() at the end. The caller shou=
ldn't be
> > > > required to handle the error cases by freeing up resources.
> > > =

> > > This function will return the number of requests being successfully p=
repared
> > > and make sure
> > > =

> > > resources of the failed request being freed. And virtio_i2c_complete_=
reqs
> > > will free the
> > > =

> > > resources of those successful request.
> > It just looks cleaner to give such responsibility to each and every fun=
ction,
> > i.e. if they fail, they should clean stuff up instead of the caller. Th=
at's the
> > normal philosophy you will find across kernel in most of the cases.
> > > > > +		/*
> > > > > +		 * Condition (req && req =3D=3D &reqs[i]) should always meet s=
ince
> > > > > +		 * we have total nr requests in the vq.
> > > > > +		 */
> > > > > +		if (!failed && (WARN_ON(!(req && req =3D=3D &reqs[i])) ||
> > > > > +		    (req->in_hdr.status !=3D VIRTIO_I2C_MSG_OK)))
> > > > What about writing this as:
> > > > =

> > > > 		if (!failed && (WARN_ON(req !=3D &reqs[i]) ||
> > > > 		    (req->in_hdr.status !=3D VIRTIO_I2C_MSG_OK)))
> > > > =

> > > > We don't need to check req here since if req is NULL, we will not d=
o req->in_hdr
> > > > at all.
> > > =

> > > It's right here just because the &reqs[i] will never be NULL in our c=
ase.
> > > But if you see
> > > =

> > > "virtio_i2c_complete_reqs" as an independent function, you need to ch=
eck the
> > > =

> > > req. From the perspective of the callee, you can't ask the caller alw=
ays
> > > give you
> > > =

> > > the non-NULL parameters.
> > We need to keep this driver optimized in its current form. If you see y=
our own
> > argument here, then why don't you test vq or msgs for a valid pointer ?=
 And even
> > reqs.
> > =

> > If we know for certain that this will never happen, then it should be o=
ptimized.
> > But if you see a case where reqs[i] can be NULL here, then it would be =
fine.
> > ot the driver. And we don't need to take care of that.
> =

> =

> This is still not enough to convince me.=A0 So I won't change them for now
> until I see it
> =

> is the consensus of the majority.

Do you see reqs[i] to ever be NULL here ? If not, then if (req) is like if
(true).

Why would you want to have something like that ?

-- =

viresh
_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
