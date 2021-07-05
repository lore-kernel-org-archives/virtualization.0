Return-Path: <SRS0=2LZG=L5=lists.linux-foundation.org=virtualization-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1A192C07E9B
	for <virtualization@archiver.kernel.org>; Mon,  5 Jul 2021 12:18:42 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C317C61374
	for <virtualization@archiver.kernel.org>; Mon,  5 Jul 2021 12:18:41 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C317C61374
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=virtualization-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by smtp2.osuosl.org (Postfix) with ESMTP id 85A7B40375;
	Mon,  5 Jul 2021 12:18:41 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
	by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id T8VjhS5GWZMq; Mon,  5 Jul 2021 12:18:40 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp2.osuosl.org (Postfix) with ESMTPS id 12E72401E8;
	Mon,  5 Jul 2021 12:18:40 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id DB476C001A;
	Mon,  5 Jul 2021 12:18:39 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [IPv6:2605:bc80:3010::137])
 by lists.linuxfoundation.org (Postfix) with ESMTP id D764FC000E
 for <virtualization@lists.linux-foundation.org>;
 Mon,  5 Jul 2021 12:18:37 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id C4707402C6
 for <virtualization@lists.linux-foundation.org>;
 Mon,  5 Jul 2021 12:18:37 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp4.osuosl.org (amavisd-new);
 dkim=pass (2048-bit key) header.d=linaro.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id XnlcMGm3hpCy
 for <virtualization@lists.linux-foundation.org>;
 Mon,  5 Jul 2021 12:18:35 +0000 (UTC)
X-Greylist: whitelisted by SQLgrey-1.8.0
Received: from mail-pf1-x431.google.com (mail-pf1-x431.google.com
 [IPv6:2607:f8b0:4864:20::431])
 by smtp4.osuosl.org (Postfix) with ESMTPS id 7A1864024C
 for <virtualization@lists.linux-foundation.org>;
 Mon,  5 Jul 2021 12:18:35 +0000 (UTC)
Received: by mail-pf1-x431.google.com with SMTP id w22so12889546pff.5
 for <virtualization@lists.linux-foundation.org>;
 Mon, 05 Jul 2021 05:18:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=date:from:to:subject:message-id:references:mime-version
 :content-disposition:in-reply-to:user-agent;
 bh=u4GEMXqrVqxTiuERmBBzhK0c9EgdVjMcqN5EyjmdR60=;
 b=IxrUn1LmGvOtzScwNxvADvtlbcqMdlIb2lKdy744YfPAlPzhXlfo2xb9uEYNhFUHc6
 oWOSJUTSoMDUttRI0b9TaZts+dkOP1PuGqJdxM5Bo3BC/5IeLW8QaAG32wLD9HFPIHl5
 i1Rqz/8RbeQom8kwEmlCNkGMTIGSvV1IeYDAnrPMm0AZkWUQGrQF/oovTz+1ltVCAl6q
 Vtn0ta5A0zGr+Tag2SAH33SNdXKRGaTYASlihNvMApKV0tQAtkDTCS3uD47TBj+AFW4d
 S7IF0YH9w+6iSkvaAFUBSmx+W1s/0Vtbk9y2qF/s2AxjZBgy50hKCBsKS3h3tYas+WO2
 bzBQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:subject:message-id:references
 :mime-version:content-disposition:in-reply-to:user-agent;
 bh=u4GEMXqrVqxTiuERmBBzhK0c9EgdVjMcqN5EyjmdR60=;
 b=fqF1w7gWYt1VN9k0WnKsh3SkQnX70g6CcG12JSBGa2ZUwBKCfjfTpEfOP0D4mi4Hho
 hFBhq5vPw28k6rSFo/2tyNojatPoj8XqRGwoGy98dNA/w2noA3J3ZcB6iWGvdf1JIPLy
 b3FsAybb96mWXmucgHVoz6heZVn9IZtl5UkAE4AKdv98Z/k/PdhsCDem4gqckZw1jIWZ
 WmQ2KymVoAdVKp7tnlHSTWRcfb9DUAbZiowXcjDcchLuHQMsvWF8dcbai77R5oiqJzI3
 f/+fLCA+2TuKe09clHuIGGkWLH9yH35lyK4I1hAoHcTvn1J4etlD6P4wFVDbDCclEo4w
 tV9w==
X-Gm-Message-State: AOAM532eBmYgyGQ060ihC6PJTILeuP/kX3Z1KwX1SST3djgiwHAD4uuk
 W5Z1Iw+tMgdsI4SIc06I1BLZjw==
X-Google-Smtp-Source: ABdhPJyTYM9QsZt+DYXU859OWip3irzytNPEbNakK54hTszjXI/wJpcc+0dtyXT55ww9/BS+VBzBVA==
X-Received: by 2002:a63:f556:: with SMTP id e22mr15436308pgk.189.1625487514767; 
 Mon, 05 Jul 2021 05:18:34 -0700 (PDT)
Received: from localhost ([106.201.108.2])
 by smtp.gmail.com with ESMTPSA id f17sm21157918pjj.21.2021.07.05.05.18.33
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 05 Jul 2021 05:18:34 -0700 (PDT)
Date: Mon, 5 Jul 2021 17:48:32 +0530
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
Message-ID: <20210705121832.fmye5xnlbydoc5ir@vireshk-i7>
References: <226a8d5663b7bb6f5d06ede7701eedb18d1bafa1.1616493817.git.jie.deng@intel.com>
 <YNrw4rxihFLuqLtY@ninjato>
 <20210629101627.kwc2rszborc3kvjs@vireshk-i7>
 <YNr0uDx1fv+Gjd7m@ninjato>
 <20210629103014.nlk3mpetydc4mi6l@vireshk-i7>
 <YNr5Jf3WDTH7U5b7@ninjato> <YNr5ZRhT3qn+e9/m@ninjato>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <YNr5ZRhT3qn+e9/m@ninjato>
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

On 29-06-21, 12:43, Wolfram Sang wrote:
> 
> > From the spec:
> > 
> > The case when ``length of \field{write_buf}''=0, and at the same time,
> > ``length of \field{read_buf}''=0 doesn't make any sense.
> > 
> > I mentioned this in my first reply and to my understanding I did not get
> > a reply that this has changed meanwhile.
> > 
> 
> Also, this code as mentioned before:
> 
> > +             if (!msgs[i].len)
> > +                     break;
> 
> I hope this can extended in the future to allow zero-length messages. If
> this is impossible we need to set an adapter quirk instead.

Wolfram,

I stumbled again upon this while working at the backend implementation.

If you look at i2c_smbus_xfer_emulated(), the command is always sent via
msgbuf0[0]. Even in the case of I2C_SMBUS_QUICK, where we set msg[0].len = 0, we
still send the buf. This is really confusing :(

Do I understand correctly that we always need to send msg[0].buf even when
msg[0].len is 0 ?

If so, it would be difficult to implement this with the current i2c virtio
specification, as the msg.len isn't really passed from guest to host, rather it
is inferred using the length of the buffer itself. And so we can't really pass a
buffer if length is 0.

Moreover, the driver uses i2c_get_dma_safe_msg_buf(), which also depends on the
length parameter here to allocate the buffer and copy data to it.

All in all, the latest version of the driver doesn't work with "i2cdetect -q <bus>".

To make it work, I had to add this:

diff --git a/drivers/i2c/busses/i2c-virtio.c b/drivers/i2c/busses/i2c-virtio.c
index 731267d42292..5b8bd98ae38e 100644
--- a/drivers/i2c/busses/i2c-virtio.c
+++ b/drivers/i2c/busses/i2c-virtio.c
@@ -73,6 +73,9 @@ static int virtio_i2c_prepare_reqs(struct virtqueue *vq,
                sg_init_one(&out_hdr, &reqs[i].out_hdr, sizeof(reqs[i].out_hdr));
                sgs[outcnt++] = &out_hdr;

+               if (!msgs[i].len)
+                       msgs[i].len = 1;
+
                if (msgs[i].len) {
                        reqs[i].buf = i2c_get_dma_safe_msg_buf(&msgs[i], 1);
                        if (!reqs[i].buf)

which made it I2C_SMBUS_BYTE instead of I2C_SMBUS_QUICK.

What should we do here Wolfram?


Jie, while wolfram comes back and replies to this, I think you need to switch
back to NOT supporting zero length transfer and set update virtio_i2c_func() to
return:

        I2C_FUNC_I2C | (I2C_FUNC_SMBUS_EMUL & ~I2C_FUNC_SMBUS_QUICK);

Support for zero-length transfers and I2C_FUNC_SMBUS_QUICK can be added
separately.

Thanks.

-- 
viresh
_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
