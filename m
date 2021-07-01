Return-Path: <SRS0=M3O5=LZ=lists.linux-foundation.org=virtualization-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.0 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_NONE,URIBL_RED,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 93FCBC11F67
	for <virtualization@archiver.kernel.org>; Thu,  1 Jul 2021 06:18:54 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 31F3F6148E
	for <virtualization@archiver.kernel.org>; Thu,  1 Jul 2021 06:18:54 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 31F3F6148E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=virtualization-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id E5EC040562;
	Thu,  1 Jul 2021 06:18:53 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
	by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id vfBlS2LJ89kJ; Thu,  1 Jul 2021 06:18:53 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp4.osuosl.org (Postfix) with ESMTPS id 60CBF40550;
	Thu,  1 Jul 2021 06:18:52 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 30895C0010;
	Thu,  1 Jul 2021 06:18:52 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [IPv6:2605:bc80:3010::136])
 by lists.linuxfoundation.org (Postfix) with ESMTP id B635DC000E
 for <virtualization@lists.linux-foundation.org>;
 Thu,  1 Jul 2021 06:18:50 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id A9A1B60A84
 for <virtualization@lists.linux-foundation.org>;
 Thu,  1 Jul 2021 06:18:50 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp3.osuosl.org (amavisd-new);
 dkim=pass (2048-bit key) header.d=linaro.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id We1cVWIPbM0j
 for <virtualization@lists.linux-foundation.org>;
 Thu,  1 Jul 2021 06:18:49 +0000 (UTC)
X-Greylist: whitelisted by SQLgrey-1.8.0
Received: from mail-pj1-x102d.google.com (mail-pj1-x102d.google.com
 [IPv6:2607:f8b0:4864:20::102d])
 by smtp3.osuosl.org (Postfix) with ESMTPS id 557B860A81
 for <virtualization@lists.linux-foundation.org>;
 Thu,  1 Jul 2021 06:18:49 +0000 (UTC)
Received: by mail-pj1-x102d.google.com with SMTP id
 b5-20020a17090a9905b029016fc06f6c5bso3277038pjp.5
 for <virtualization@lists.linux-foundation.org>;
 Wed, 30 Jun 2021 23:18:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=date:from:to:cc:subject:message-id:references:mime-version
 :content-disposition:content-transfer-encoding:in-reply-to
 :user-agent; bh=mu5saGqKxlXNgVr7bcUnXINmJrCKq5xXKKfQAtxefEg=;
 b=h9Kzy0o8doVD9ByVw9IGSjaHbYWwh92htcQYdFNY4Q8T7cuElQf9u0lW9u6YfjQ9CH
 kG98yU3KNF0SRulS+ANueQUmfbVupvm9cEEfBvoJ8WLnwFFsiv0JceFOF0ZSWVS0UYh5
 TyYHbWZFLgXMNwHjn9dRSu/fI5zROQe1n9YBRLsgdvd5dUBtIz1kZKg4YGR3jO4UQP5b
 2UUBh+4FY2pNgxpd1X0/XrKuJIEtoWM3mqegp96PtO2OrjqAprpCkR8kWqnQRv3Rd88u
 hWVKCr8BucPyk8uC/axXXFTzP7FCTToajduKNeCiIUJO+LhldTGAJsSlwcJf9xb5+i3Q
 l10w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:content-transfer-encoding
 :in-reply-to:user-agent;
 bh=mu5saGqKxlXNgVr7bcUnXINmJrCKq5xXKKfQAtxefEg=;
 b=Eald7Kil5rtCMFjOrhvwSo2sfKU1R82z+g2YJYkriUl70GIm3il8KmACcAjwOUr/sW
 xqQoX7anbc9qudbuT60zw1H+bPovlnLAAEZZTbumge2iG3eP3mUPkQXe60hHFdw2MyG7
 YcZr7+MUoy0JN38O1IthOjqBO70+dpdAb68CJ+jYRaNn694rcUuzZFTsEHGGIiG0J7md
 +UYaFdYc15koz9sGBrRRk7gGx+dIxie04W+nLC00//u0nZtFucuFDAeKWNPCSlBIiSgp
 uWITCftHY4bxm+X3sLvd0nZ9y8OhCzrnUduzU9XSFQptrbgtMpOKnysZB7Rek0XbEmCT
 CclQ==
X-Gm-Message-State: AOAM530xHPvnN8s0UGe6VKR7c8xQqZcrvC0r+LuR994RiY2uR2dgzCC7
 ST+Rss+caZnjpO8ouRCRi3l1Ng==
X-Google-Smtp-Source: ABdhPJyhhPvVWbRIgwTFmdT2txqRXlkDS3AIl9G3Al02xTlCINLZXXpcYKBy3Lh+rfUkfZMuflb4Hg==
X-Received: by 2002:a17:90a:ea8b:: with SMTP id
 h11mr8539534pjz.122.1625120328712; 
 Wed, 30 Jun 2021 23:18:48 -0700 (PDT)
Received: from localhost ([106.201.108.2])
 by smtp.gmail.com with ESMTPSA id i10sm18244312pjm.51.2021.06.30.23.18.47
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 30 Jun 2021 23:18:48 -0700 (PDT)
Date: Thu, 1 Jul 2021 11:48:46 +0530
From: Viresh Kumar <viresh.kumar@linaro.org>
To: Jie Deng <jie.deng@intel.com>
Subject: Re: [PATCH v11] i2c: virtio: add a virtio i2c frontend driver
Message-ID: <20210701061846.7u4zorimzpmb66v7@vireshk-i7>
References: <510c876952efa693339ab0d6cc78ba7be9ef6897.1625104206.git.jie.deng@intel.com>
 <20210701040436.p7kega6rzeqz5tlm@vireshk-i7>
 <cb35472d-f79e-f3f8-405f-35c699d897a1@intel.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <cb35472d-f79e-f3f8-405f-35c699d897a1@intel.com>
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

On 01-07-21, 14:10, Jie Deng wrote:
> I think a fixed number of sgs will make things easier to develop backend.

Yeah, but it looks awkward to send a message buffer which isn't used
at all. From protocol's point of view, it just looks wrong/buggy.

The backend can just look at the number of elements received, they
can either be 2 (in case of zero-length) transfer, or 3 (for
read/write) and any other number is invalid.

> If you prefer to parse the number of descriptors instead of using the msg
> length to
> =

> distinguish the zero-length request from other requests, I'm OK to set a
> limit.

My concern is more about the specification here first.

> if (!msgs[i].len) {
> =A0=A0=A0 sg_init_one(&msg_buf, reqs[i].buf, msgs[i].len);
> =

> =A0=A0=A0 if (msgs[i].flags & I2C_M_RD)
> =A0=A0=A0 =A0=A0=A0 sgs[outcnt + incnt++] =3D &msg_buf;
> =A0=A0=A0 else
> =A0=A0=A0 =A0=A0=A0 sgs[outcnt++] =3D &msg_buf;
> }

> > > +#ifdef CONFIG_PM_SLEEP
> > You could avoid this pair of ifdef by creating dummy versions of below
> > routines for !CONFIG_PM_SLEEP case. Up to you.
> =

> =

> Thank you. I'd like to keep the same.

Sure.

-- =

viresh
_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
