Return-Path: <SRS0=VeF6=MF=lists.linux-foundation.org=virtualization-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_RED autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B2726C11F66
	for <virtualization@archiver.kernel.org>; Tue, 13 Jul 2021 15:34:48 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 593EA6101E
	for <virtualization@archiver.kernel.org>; Tue, 13 Jul 2021 15:34:48 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 593EA6101E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=virtualization-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 18EE540291;
	Tue, 13 Jul 2021 15:34:48 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
	by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id EcRu3j04cjt1; Tue, 13 Jul 2021 15:34:46 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp4.osuosl.org (Postfix) with ESMTPS id 35EB74026B;
	Tue, 13 Jul 2021 15:34:46 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id E971FC0010;
	Tue, 13 Jul 2021 15:34:45 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by lists.linuxfoundation.org (Postfix) with ESMTP id C6FC0C000E
 for <virtualization@lists.linux-foundation.org>;
 Tue, 13 Jul 2021 15:34:44 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id A863F402E8
 for <virtualization@lists.linux-foundation.org>;
 Tue, 13 Jul 2021 15:34:44 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp2.osuosl.org (amavisd-new);
 dkim=pass (1024-bit key) header.d=redhat.com
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id naEEbYgFO8y9
 for <virtualization@lists.linux-foundation.org>;
 Tue, 13 Jul 2021 15:34:43 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [216.205.24.124])
 by smtp2.osuosl.org (Postfix) with ESMTPS id 9D7364016A
 for <virtualization@lists.linux-foundation.org>;
 Tue, 13 Jul 2021 15:34:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1626190482;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=kFYNaWd22O3nnowmgoN34X1ibVU9X6CFHq3W7KqdyiU=;
 b=FEJBkjbdaf2aT7T3w70MSUh84ojjFQ4vTyPUF8X5/Vrg/kTlUDNA6hWO5D/aNEgnkNd3Ta
 9BahUsFtVINoVj4hw5oAb5jivF0QZ8F6fK+sKMfZws+59XyhzsHjtmGt+cKILNBXq+5jpx
 AsyD3zQq/zcLP91NBi4DfucQrthr57E=
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-503-V4BfqPhKOq6eNBURqQophw-1; Tue, 13 Jul 2021 11:34:39 -0400
X-MC-Unique: V4BfqPhKOq6eNBURqQophw-1
Received: by mail-wr1-f69.google.com with SMTP id
 p4-20020a5d63840000b0290126f2836a61so8965518wru.6
 for <virtualization@lists.linux-foundation.org>;
 Tue, 13 Jul 2021 08:34:38 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to;
 bh=kFYNaWd22O3nnowmgoN34X1ibVU9X6CFHq3W7KqdyiU=;
 b=CJF/yPnFldZpFFA/fEGmprA08RFmDcD9k4nlvd8Jjlaw4l7miDQq8V1RYpihDbo7gy
 +V/2Xdj5yNTxBY1vrhV1ATq1CB/zWGWpnJPiC+ndiqe5xZ72u6lNSHuEzRlKxHL01KU/
 qwFTDWar70GhJzraZDdZBxrJS+nuUvYeZjtvCI3iQV2hw8UXTk480+YOajgLzPobEsfX
 UX0MdiFhFpAF48PqoVgnH10oXFY4TafaLMM5WFM3EzZKTcqZ6kFP52J3yi7IPK6+L5G5
 Ly3rOTo97uYzpi/2xN7LxwcWA6POPm4HojmVyDyZcc2oZLq8wMkWRVJVGaAjfdQLifmP
 ws5Q==
X-Gm-Message-State: AOAM533gkTm64w4wn0kEsIuTV8pPW6gy7y5z1/Juuu0gbpc2gXlICw5X
 /gMreKtBJbGI6soXo7IWj+V/md7OQ75f6+yZESARu2AcA6dbgceiX/YmlvarO1IGK+ssqAnvcUQ
 X/H6DoYn+DqWGYH0q9yGkbUP8v6+5tb5tu5eccylg3g==
X-Received: by 2002:adf:f70a:: with SMTP id r10mr6491816wrp.401.1626190478035; 
 Tue, 13 Jul 2021 08:34:38 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJwpNgNztgrVD7gZKhL/9YqYdmghKsV+iIed8iTwwM6ybZEIl/XhMX0wzXR0E5UDOq8x56dagA==
X-Received: by 2002:adf:f70a:: with SMTP id r10mr6491786wrp.401.1626190477886; 
 Tue, 13 Jul 2021 08:34:37 -0700 (PDT)
Received: from redhat.com ([2.55.15.23])
 by smtp.gmail.com with ESMTPSA id d8sm6178278wrv.20.2021.07.13.08.34.34
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 13 Jul 2021 08:34:36 -0700 (PDT)
Date: Tue, 13 Jul 2021 11:34:31 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Viresh Kumar <viresh.kumar@linaro.org>
Subject: Re: [PATCH v14] i2c: virtio: add a virtio i2c frontend driver
Message-ID: <20210713113301-mutt-send-email-mst@kernel.org>
References: <984ebecaf697058eb73389ed14ead9dd6d38fb53.1625796246.git.jie.deng@intel.com>
 <20210709034407.xmglkgzubrztnxsg@vireshk-i7>
MIME-Version: 1.0
In-Reply-To: <20210709034407.xmglkgzubrztnxsg@vireshk-i7>
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=mst@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Disposition: inline
Cc: vincent.guittot@linaro.org, arnd@arndb.de, gregkh@linuxfoundation.org,
 linux-kernel@vger.kernel.org, virtualization@lists.linux-foundation.org,
 wsa@kernel.org, wsa+renesas@sang-engineering.com, linux-i2c@vger.kernel.org,
 stefanha@redhat.com, shuo.a.liu@intel.com, andriy.shevchenko@linux.intel.com,
 conghui.chen@intel.com, yu1.wang@intel.com
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

On Fri, Jul 09, 2021 at 09:14:07AM +0530, Viresh Kumar wrote:
> On 09-07-21, 10:25, Jie Deng wrote:
> > Add an I2C bus driver for virtio para-virtualization.
> > 
> > The controller can be emulated by the backend driver in
> > any device model software by following the virtio protocol.
> > 
> > The device specification can be found on
> > https://lists.oasis-open.org/archives/virtio-comment/202101/msg00008.html.
> > 
> > By following the specification, people may implement different
> > backend drivers to emulate different controllers according to
> > their needs.
> > 
> > Co-developed-by: Conghui Chen <conghui.chen@intel.com>
> > Signed-off-by: Conghui Chen <conghui.chen@intel.com>
> > Signed-off-by: Jie Deng <jie.deng@intel.com>
> > ---
> > Changes v13 -> v14
> > 	- Put the headers in virtio_i2c.h in alphabetical order.
> > 	- Dropped I2C_FUNC_SMBUS_QUICK support.
> > 	- Dropped few unnecessary variables and checks.
> > 	- Use "num" everywhere instead of num or nr, to be consistent.
> > 	- Added few comments which make the design more clear. 
> 
> Thanks a lot for following this up so far :)
> 
> > +static int virtio_i2c_prepare_reqs(struct virtqueue *vq,
> > +				   struct virtio_i2c_req *reqs,
> > +				   struct i2c_msg *msgs, int num)
> > +{
> > +	struct scatterlist *sgs[3], out_hdr, msg_buf, in_hdr;
> > +	int i;
> > +
> > +	for (i = 0; i < num; i++) {
> > +		int outcnt = 0, incnt = 0;
> > +
> > +		/*
> > +		 * We don't support 0 length messages and so masked out
> > +		 * I2C_FUNC_SMBUS_QUICK in virtio_i2c_func().
> > +		 */
> > +		if (!msgs[i].len)
> > +			break;
> > +
> > +		/*
> > +		 * Only 7-bit mode supported for this moment. For the address
> > +		 * format, Please check the Virtio I2C Specification.
> > +		 */
> > +		reqs[i].out_hdr.addr = cpu_to_le16(msgs[i].addr << 1);
> > +
> > +		if (i != num - 1)
> > +			reqs[i].out_hdr.flags = cpu_to_le32(VIRTIO_I2C_FLAGS_FAIL_NEXT);
> > +
> > +		sg_init_one(&out_hdr, &reqs[i].out_hdr, sizeof(reqs[i].out_hdr));
> > +		sgs[outcnt++] = &out_hdr;
> > +
> > +		reqs[i].buf = i2c_get_dma_safe_msg_buf(&msgs[i], 1);
> > +		if (!reqs[i].buf)
> > +			break;
> > +
> > +		sg_init_one(&msg_buf, reqs[i].buf, msgs[i].len);
> > +
> > +		if (msgs[i].flags & I2C_M_RD)
> > +			sgs[outcnt + incnt++] = &msg_buf;
> > +		else
> > +			sgs[outcnt++] = &msg_buf;
> > +
> > +		sg_init_one(&in_hdr, &reqs[i].in_hdr, sizeof(reqs[i].in_hdr));
> > +		sgs[outcnt + incnt++] = &in_hdr;
> > +
> > +		if (virtqueue_add_sgs(vq, sgs, outcnt, incnt, &reqs[i], GFP_KERNEL)) {
> > +			i2c_put_dma_safe_msg_buf(reqs[i].buf, &msgs[i], false);
> > +			break;
> > +		}
> > +	}
> > +
> > +	return i;
> > +}
> 
> Wolfram, in case you wonder why we don't error out early as discussed earlier,
> then ...
> 
> > +static int virtio_i2c_xfer(struct i2c_adapter *adap, struct i2c_msg *msgs,
> > +			   int num)
> > +{
> 
> ...
> 
> > +	/*
> > +	 * For the case where count < num, i.e. we weren't able to queue all the
> > +	 * msgs, ideally we should abort right away and return early, but some
> > +	 * of the messages are already sent to the remote I2C controller and the
> > +	 * virtqueue will be left in undefined state in that case. We kick the
> > +	 * remote here to clear the virtqueue, so we can try another set of
> > +	 * messages later on.
> > +	 */
> 
> ... here is the reasoning for that.
> 
> Please see if you can still get it merged into 5.14-rc1/2. Thanks.
> 
> Reviewed-by: Viresh Kumar <viresh.kumar@linaro.org>
> Tested-by: Viresh Kumar <viresh.kumar@linaro.org>

Well a new driver so maybe rc2 is still ok ...

Acked-by: Michael S. Tsirkin <mst@redhat.com>



> -- 
> viresh

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
