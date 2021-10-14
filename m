Return-Path: <SRS0=Buhk=PC=lists.linux-foundation.org=virtualization-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BE442C4321E
	for <virtualization@archiver.kernel.org>; Thu, 14 Oct 2021 08:36:40 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 590D66115C
	for <virtualization@archiver.kernel.org>; Thu, 14 Oct 2021 08:36:40 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org 590D66115C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 1E26E406BE;
	Thu, 14 Oct 2021 08:36:40 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
	by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id jHDMuW-YG1QF; Thu, 14 Oct 2021 08:36:39 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp4.osuosl.org (Postfix) with ESMTPS id B8ECF405E2;
	Thu, 14 Oct 2021 08:36:38 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 7C590C0011;
	Thu, 14 Oct 2021 08:36:38 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 6A141C000D
 for <virtualization@lists.linux-foundation.org>;
 Thu, 14 Oct 2021 08:36:36 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id 575C38340C
 for <virtualization@lists.linux-foundation.org>;
 Thu, 14 Oct 2021 08:36:36 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp1.osuosl.org (amavisd-new);
 dkim=pass (2048-bit key) header.d=linaro.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id HxJT4fhHShlQ
 for <virtualization@lists.linux-foundation.org>;
 Thu, 14 Oct 2021 08:36:35 +0000 (UTC)
X-Greylist: whitelisted by SQLgrey-1.8.0
Received: from mail-wr1-x431.google.com (mail-wr1-x431.google.com
 [IPv6:2a00:1450:4864:20::431])
 by smtp1.osuosl.org (Postfix) with ESMTPS id EAA1383096
 for <virtualization@lists.linux-foundation.org>;
 Thu, 14 Oct 2021 08:36:34 +0000 (UTC)
Received: by mail-wr1-x431.google.com with SMTP id v17so16874879wrv.9
 for <virtualization@lists.linux-foundation.org>;
 Thu, 14 Oct 2021 01:36:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=date:from:to:cc:subject:message-id:references:mime-version
 :content-disposition:in-reply-to;
 bh=cfakvhen/wxw5fHdRu0DEuLT5DMfJlXe2a/johLjqxo=;
 b=h40uJnzRy4bIKfqfvwm3i/kik60+Kgx2sfXbHxmv0MsZax7HkeDmryc9yctryM7xlU
 37bg2VuoZWdH4kTXGosC95Fa3QYJayYirIbI/UeFVNH/Nzn2/7/VodB6g1hiMuG9zp+p
 egl0Br7pM5vnKxSuUDa7BUq17cmPH9MsIYOosVtDeEDQMUaCZ6h+AWD2esXOH1LRk+zZ
 X2uV1Nn3ulaudun/4f5AT6jS5oilV0myDq9ozSQAqUnytF1YgcEInQmj+cCLjl5OgT5o
 004n5bwSXge4iP3a4skCS8avlQccw5QvPN8BVpAjam8zZmlkvShcDVpQvgmxjplGDMKz
 pkRQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to;
 bh=cfakvhen/wxw5fHdRu0DEuLT5DMfJlXe2a/johLjqxo=;
 b=gkPyKg43OiT4rxVShwZnK2i5SG+ZzUlkig/X/2b7e+EvAeSApx7EE1nvXpElhIakyP
 FqZ1EMj9VoQlDDCMOPgws70tc9psB6VbLX5h6pv1tM70lT3dRzUPBCahrJ1Cds2PxUJc
 D+cSAE2UuD1bZ170fcpbVp8Pv/XJsHD/TFnoN2NNKbmcfPVge7ZKCiPPNXuf7JG7C8bc
 SRdFf/zL8tP5Ws07pOtktA+RYjhEGgLesRbNGv9PhtwDxhqmGYtosqcHagnGNickvwKQ
 gXEgVPPrOk06I7Q86OprVVqQxntH1oG3dAf3JaU5eW+9QLVuyiLlZzkfSrszA3V0dHwn
 VqSQ==
X-Gm-Message-State: AOAM531EMAD0zhMMQ/8olaw6xySG58ke6KTVlgAabTGDvx11RtcxbUm8
 ZVLW8oUqk/z9x09JfsfUHnY/qw==
X-Google-Smtp-Source: ABdhPJzpVg8OIER+zTALG2ilasSHxD7bC/dTlVAeWBUDgRwrRvN9DCthCd2lRX0ZyZDpw2FTk6Hq6g==
X-Received: by 2002:a5d:59a9:: with SMTP id p9mr5151873wrr.386.1634200593067; 
 Thu, 14 Oct 2021 01:36:33 -0700 (PDT)
Received: from myrica (cpc92880-cmbg19-2-0-cust679.5-4.cable.virginm.net.
 [82.27.106.168])
 by smtp.gmail.com with ESMTPSA id r4sm2299114wrz.58.2021.10.14.01.36.30
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 14 Oct 2021 01:36:32 -0700 (PDT)
Date: Thu, 14 Oct 2021 09:36:09 +0100
From: Jean-Philippe Brucker <jean-philippe@linaro.org>
To: "Michael S. Tsirkin" <mst@redhat.com>
Subject: Re: [PATCH RFC] virtio: wrap config->reset calls
Message-ID: <YWfr+Z0wgpQ48yC5@myrica>
References: <20211013105226.20225-1-mst@redhat.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20211013105226.20225-1-mst@redhat.com>
Cc: nvdimm@lists.linux.dev, Stefan Hajnoczi <stefanha@redhat.com>,
 kvm@vger.kernel.org, David Airlie <airlied@linux.ie>,
 Viresh Kumar <vireshk@kernel.org>, linux-remoteproc@vger.kernel.org,
 alsa-devel@alsa-project.org, dri-devel@lists.freedesktop.org,
 Bjorn Andersson <bjorn.andersson@linaro.org>, netdev@vger.kernel.org,
 linux-scsi@vger.kernel.org, Will Deacon <will@kernel.org>,
 v9fs-developer@lists.sourceforge.net,
 Anton Ivanov <anton.ivanov@cambridgegreys.com>,
 Linus Walleij <linus.walleij@linaro.org>, Dave Jiang <dave.jiang@intel.com>,
 Herbert Xu <herbert@gondor.apana.org.au>, linux-arm-kernel@lists.infradead.org,
 Miklos Szeredi <miklos@szeredi.hu>, Richard Weinberger <richard@nod.at>,
 Bartosz Golaszewski <brgl@bgdev.pl>, Takashi Iwai <tiwai@suse.com>,
 Kalle Valo <kvalo@codeaurora.org>,
 "Martin K. Petersen" <martin.petersen@oracle.com>,
 "James E.J. Bottomley" <jejb@linux.ibm.com>, Jakub Kicinski <kuba@kernel.org>,
 Ira Weiny <ira.weiny@intel.com>, virtualization@lists.linux-foundation.org,
 Jeff Dike <jdike@addtoit.com>, Vivek Goyal <vgoyal@redhat.com>,
 Ohad Ben-Cohen <ohad@wizery.com>, Johan Hedberg <johan.hedberg@gmail.com>,
 Arnd Bergmann <arnd@arndb.de>, Amit Shah <amit@kernel.org>,
 Eric Van Hensbergen <ericvh@gmail.com>, Marcel Holtmann <marcel@holtmann.org>,
 linux-um@lists.infradead.org, linux-crypto@vger.kernel.org,
 linux-block@vger.kernel.org, Vishal Verma <vishal.l.verma@intel.com>,
 Luiz Augusto von Dentz <luiz.dentz@gmail.com>, Matt Mackall <mpm@selenic.com>,
 Dan Williams <dan.j.williams@intel.com>, Jaroslav Kysela <perex@perex.cz>,
 Cristian Marussi <cristian.marussi@arm.com>, Jens Axboe <axboe@kernel.dk>,
 Mathieu Poirier <mathieu.poirier@linaro.org>, linux-gpio@vger.kernel.org,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 linux-wireless@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-i2c@vger.kernel.org, linux-bluetooth@vger.kernel.org,
 iommu@lists.linux-foundation.org, Daniel Vetter <daniel@ffwll.ch>,
 Sudeep Holla <sudeep.holla@arm.com>, linux-fsdevel@vger.kernel.org,
 Paolo Bonzini <pbonzini@redhat.com>, Johannes Berg <johannes@sipsolutions.net>,
 "Enrico Weigelt, metux IT consult" <info@metux.net>,
 "David S. Miller" <davem@davemloft.net>, Joerg Roedel <joro@8bytes.org>
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

On Wed, Oct 13, 2021 at 06:55:31AM -0400, Michael S. Tsirkin wrote:
> This will enable cleanups down the road.
> The idea is to disable cbs, then add "flush_queued_cbs" callback
> as a parameter, this way drivers can flush any work
> queued after callbacks have been disabled.
> 
> Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
> ---

>  drivers/iommu/virtio-iommu.c               | 2 +-

Reviewed-by: Jean-Philippe Brucker <jean-philippe@linaro.org>
_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
