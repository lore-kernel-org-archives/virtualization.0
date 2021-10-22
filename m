Return-Path: <SRS0=+kt1=PK=lists.linux-foundation.org=virtualization-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3074CC433EF
	for <virtualization@archiver.kernel.org>; Fri, 22 Oct 2021 06:58:15 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id CEF3361037
	for <virtualization@archiver.kernel.org>; Fri, 22 Oct 2021 06:58:14 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org CEF3361037
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 8623E60711;
	Fri, 22 Oct 2021 06:58:14 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
	by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id 5qcZox99Y4aq; Fri, 22 Oct 2021 06:58:13 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp3.osuosl.org (Postfix) with ESMTPS id 4D19F605D4;
	Fri, 22 Oct 2021 06:58:13 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 0659BC001F;
	Fri, 22 Oct 2021 06:58:13 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 00232C001E
 for <virtualization@lists.linux-foundation.org>;
 Fri, 22 Oct 2021 06:58:11 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id CE1F1401B0
 for <virtualization@lists.linux-foundation.org>;
 Fri, 22 Oct 2021 06:58:11 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp2.osuosl.org (amavisd-new);
 dkim=pass (2048-bit key) header.d=linaro.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id q3CeORlKzC3w
 for <virtualization@lists.linux-foundation.org>;
 Fri, 22 Oct 2021 06:58:10 +0000 (UTC)
X-Greylist: whitelisted by SQLgrey-1.8.0
Received: from mail-pj1-x1032.google.com (mail-pj1-x1032.google.com
 [IPv6:2607:f8b0:4864:20::1032])
 by smtp2.osuosl.org (Postfix) with ESMTPS id DF4EB4019E
 for <virtualization@lists.linux-foundation.org>;
 Fri, 22 Oct 2021 06:58:10 +0000 (UTC)
Received: by mail-pj1-x1032.google.com with SMTP id ls18so2250174pjb.3
 for <virtualization@lists.linux-foundation.org>;
 Thu, 21 Oct 2021 23:58:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=date:from:to:cc:subject:message-id:references:mime-version
 :content-disposition:in-reply-to:user-agent;
 bh=c7Ryh42xjoZrd458X0PuRKzO/jGZ4LiJFN49yEEUKqU=;
 b=qBAzCypTQajk5c9kRrbb3OjnMB83pysGa8f0+yBZdKL3RKQ9HraA7zOzdmRoSKAmve
 CnOAiNK9bzTLXT656DXcuMss006ywRhgEFfULF+cZJzghyce6Ot5MjPSSgouy1gG7Trp
 dcoATQqZj9/ZVmWRLErSAWHIAmmljTluNWtfllA4/Shl08bLf4y0M/w7KbzDSpRWn7OH
 zihPq9LHC0G05PZBso4aRpbkrDr6jf41VDoIb2YOrMiEdCf/4MFLh+2fuduJyU0BQVdb
 745oMHnJMUCETHWzU5q90ajexcmQZ3PeLWiNUhAybl/o9HhV3scHsmdFOjPfRQ1ynbNk
 0GOQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to:user-agent;
 bh=c7Ryh42xjoZrd458X0PuRKzO/jGZ4LiJFN49yEEUKqU=;
 b=BoEzeSh/UbNWferWDh9v4NN8VfG5+Y2M2MKeYu2VrRVSzwcYtHbTAD+1uMAF+4xNUq
 PzQMhwN7D3BkeiUpXkJEyA/9TLILOHTX2kCttdIgVq9aGABPoZj+cMuyjf7WF4AjAv1S
 Jh1Y7F2ASOQaOiDO2HgqOjUgaI0QWBarSvJBQY+fUOc4ClyFRgv4AwfaxOJgpcomvHgz
 b5uxW9xsxz/WE978+24+L7RBADXZRnSz7gtLPWiRUFYlK1GjbT+0B4oIldTOqMgooAGI
 o69ad6VL2z1oXksPBllopm5Z1Kiu5JogQNIoi01eH1nJZRARJG9ED8ey+BJNOV4Pk6+g
 h6bA==
X-Gm-Message-State: AOAM531AZli5lax/EF/bHS6f9cZ5CIVw3Z1vtp1UDC7jSVEzHRFmxMnd
 1gxVSlBAbr/jCjY4SsTswkPq9g==
X-Google-Smtp-Source: ABdhPJwMKxqgWWNy65Dtf8Zi0C/hvEbDozlU/nTWVV0Se0KvR9Raf7/OcIkwhpzIom5qPtofGLcylA==
X-Received: by 2002:a17:90a:f0c9:: with SMTP id
 fa9mr12611364pjb.107.1634885890395; 
 Thu, 21 Oct 2021 23:58:10 -0700 (PDT)
Received: from localhost ([106.201.113.61])
 by smtp.gmail.com with ESMTPSA id u23sm9841299pfg.162.2021.10.21.23.58.09
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 21 Oct 2021 23:58:09 -0700 (PDT)
Date: Fri, 22 Oct 2021 12:28:08 +0530
From: Viresh Kumar <viresh.kumar@linaro.org>
To: Jie Deng <jie.deng@intel.com>
Subject: Re: [PATCH] i2c: virtio: Add support for zero-length requests
Message-ID: <20211022065808.2rvbr6nvollz5mz6@vireshk-i7>
References: <7c58868cd26d2fc4bd82d0d8b0dfb55636380110.1634808714.git.viresh.kumar@linaro.org>
 <0adf1c36-a00b-f16f-e631-439148c4f956@intel.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <0adf1c36-a00b-f16f-e631-439148c4f956@intel.com>
User-Agent: NeoMutt/20180716-391-311a52
Cc: Arnd Bergmann <arnd@kernel.org>,
 Vincent Whitchurch <vincent.whitchurch@axis.com>,
 Vincent Guittot <vincent.guittot@linaro.org>,
 "Michael S. Tsirkin" <mst@redhat.com>, conghui.chen@intel.com,
 cohuck@redhat.com, linux-kernel@vger.kernel.org,
 virtualization@lists.linux-foundation.org, Wolfram Sang <wsa@kernel.org>,
 linux-i2c@vger.kernel.org, stratos-dev@op-lists.linaro.org
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

On 22-10-21, 14:51, Jie Deng wrote:
> > +	if (!virtio_has_feature(vdev, VIRTIO_I2C_F_ZERO_LENGTH_REQUEST)) {
> > +		dev_err(&vdev->dev, "Zero-length request feature is mandatory\n");
> > +		return -EINVAL;
> 
> 
> It might be better to return -EOPNOTSUPP ?

Maybe that or one of these:

#define	EBADE		52	/* Invalid exchange */
#define	EPROTO		71	/* Protocol error */
#define	EPFNOSUPPORT	96	/* Protocol family not supported */
#define	ECONNREFUSED	111	/* Connection refused */

Arnd, any suggestions ? This is about the mandatory feature not being offered by
the device.

-- 
viresh
_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
