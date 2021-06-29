Return-Path: <SRS0=tbjA=LX=lists.linux-foundation.org=virtualization-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.1 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 308C2C11F68
	for <virtualization@archiver.kernel.org>; Tue, 29 Jun 2021 10:16:35 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id BE69D61DB3
	for <virtualization@archiver.kernel.org>; Tue, 29 Jun 2021 10:16:34 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BE69D61DB3
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=virtualization-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 6EA3D40415;
	Tue, 29 Jun 2021 10:16:34 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
	by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id DWJKiEtB0Ld6; Tue, 29 Jun 2021 10:16:33 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp4.osuosl.org (Postfix) with ESMTPS id CECBC4026A;
	Tue, 29 Jun 2021 10:16:32 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 96104C0010;
	Tue, 29 Jun 2021 10:16:32 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [IPv6:2605:bc80:3010::136])
 by lists.linuxfoundation.org (Postfix) with ESMTP id E07CDC000E
 for <virtualization@lists.linux-foundation.org>;
 Tue, 29 Jun 2021 10:16:31 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id C200A60849
 for <virtualization@lists.linux-foundation.org>;
 Tue, 29 Jun 2021 10:16:31 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp3.osuosl.org (amavisd-new);
 dkim=pass (2048-bit key) header.d=linaro.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id mZmgoPn6313L
 for <virtualization@lists.linux-foundation.org>;
 Tue, 29 Jun 2021 10:16:31 +0000 (UTC)
X-Greylist: whitelisted by SQLgrey-1.8.0
Received: from mail-pj1-x1036.google.com (mail-pj1-x1036.google.com
 [IPv6:2607:f8b0:4864:20::1036])
 by smtp3.osuosl.org (Postfix) with ESMTPS id 1141260824
 for <virtualization@lists.linux-foundation.org>;
 Tue, 29 Jun 2021 10:16:30 +0000 (UTC)
Received: by mail-pj1-x1036.google.com with SMTP id
 g24-20020a17090ace98b029017225d0c013so308623pju.1
 for <virtualization@lists.linux-foundation.org>;
 Tue, 29 Jun 2021 03:16:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=date:from:to:subject:message-id:references:mime-version
 :content-disposition:in-reply-to:user-agent;
 bh=fHJGPCNIIZX7zHvjAz1sYFrEy/nZsnBPgV4WCrzHZoY=;
 b=Z98RsBJ2tMkTUKUXLl5Z86dDA+gDkUzfeRB2iqkEAFOn8W9kU5xnIsZ24Mi2XLNOF0
 wLYpHpBObb7m0JF/BoIRzigVvDYWyxdeUcYiFI5SHXNrriLH9LHd4N1F5bR4+j59cYev
 ddhr0+b3wwtxl4cKcgAEjM5c3rT4ljRAE/ptecca3hwkFvqQvztGcA5Fsuar4AaLcURV
 khUnJ7jrXaTAOQWs32074IgP9tVrU19TS63wSh+JRJ6BkxgoZZ0fjOY8w5CPqacleKmM
 Z3OsH/ev2NhpiGg9tRp9OUv6SrhGJEnuZ7OGS6YCrAPDr6gyZ98FImrkj2n1hshYeGtM
 F8Zw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:subject:message-id:references
 :mime-version:content-disposition:in-reply-to:user-agent;
 bh=fHJGPCNIIZX7zHvjAz1sYFrEy/nZsnBPgV4WCrzHZoY=;
 b=Y4yOkbj7MiFbB2o+f+74EtxnTElpPFSvTsTOQCvFHgNVvo6mQaebk7CUn7ExY3YIxH
 iZ6jFQSG0q0hjSfjjuu+3nD7cBRui7KIhA76SOVc4GJ/T+SZ//LdtWVfVfC+LPqhk2z2
 f6F4yBzMv/4q65zBGI4xxpMxg7NvYMWBFtDCJPOgtyELoG40taAzE6r0SHtkEKDlH4zk
 lg4ddLz4Joyxb24tnCAx4CxXOZx3I2qRfoTfGXJmTRIiUajPzGE9hy+xHpUJODFEWCq5
 R+NA3aAYTKH5PUcZcDXZQVXIIgZKrGnHlfcsEUVxq7gOULZvkDd+Dt4J/OoWPkHqVa52
 7W2g==
X-Gm-Message-State: AOAM532SJR/akQgIBVRnhr/UqETAII4Ba0UMOWMYLS7oLcLpRl6LunXT
 80eO7fQQylMkQ8DKpoNPRUWFKw==
X-Google-Smtp-Source: ABdhPJy6ELC1Uskp0Zc2w7psvkk4b23wKkXSPLPrQWne41oU8aWbeHNf1IoQruutBgVH7W34Ck67cQ==
X-Received: by 2002:a17:90a:ea8a:: with SMTP id
 h10mr6312319pjz.61.1624961790404; 
 Tue, 29 Jun 2021 03:16:30 -0700 (PDT)
Received: from localhost ([136.185.134.182])
 by smtp.gmail.com with ESMTPSA id c18sm16989726pfo.143.2021.06.29.03.16.29
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 29 Jun 2021 03:16:29 -0700 (PDT)
Date: Tue, 29 Jun 2021 15:46:27 +0530
From: Viresh Kumar <viresh.kumar@linaro.org>
To: Wolfram Sang <wsa@kernel.org>, Jie Deng <jie.deng@intel.com>,
 linux-i2c@vger.kernel.org, virtualization@lists.linux-foundation.org,
 linux-kernel@vger.kernel.org, mst@redhat.com, jasowang@redhat.com,
 andriy.shevchenko@linux.intel.com, conghui.chen@intel.com,
 arnd@arndb.de, kblaiech@mellanox.com, jarkko.nikula@linux.intel.com,
 Sergey.Semin@baikalelectronics.ru, rppt@kernel.org,
 loic.poulain@linaro.org, tali.perry1@gmail.com,
 u.kleine-koenig@pengutronix.de, bjorn.andersson@linaro.org,
 yu1.wang@intel.com, shuo.a.liu@intel.com, stefanha@redhat.com,
 pbonzini@redhat.com
Subject: Re: [PATCH v10] i2c: virtio: add a virtio i2c frontend driver
Message-ID: <20210629101627.kwc2rszborc3kvjs@vireshk-i7>
References: <226a8d5663b7bb6f5d06ede7701eedb18d1bafa1.1616493817.git.jie.deng@intel.com>
 <YNrw4rxihFLuqLtY@ninjato>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <YNrw4rxihFLuqLtY@ninjato>
User-Agent: NeoMutt/20180716-391-311a52
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

On 29-06-21, 12:07, Wolfram Sang wrote:
> > +static u32 virtio_i2c_func(struct i2c_adapter *adap)
> > +{
> > +	return I2C_FUNC_I2C | I2C_FUNC_SMBUS_EMUL;
> 
> You are not emulating I2C_FUNC_SMBUS_QUICK, so you need to mask it out.

What is it that we need to have to emulate it ? I did use it in my
qemu and rust backends, not sure if this was ever sent by device I
used for testing SMBUS though.

-- 
viresh
_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
