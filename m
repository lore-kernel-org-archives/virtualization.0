Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8F332C433EF
	for <virtualization@archiver.kernel.org>; Thu, 25 Nov 2021 06:47:59 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 28981608C3;
	Thu, 25 Nov 2021 06:47:59 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
	by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id R9cRRB36904e; Thu, 25 Nov 2021 06:47:58 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp3.osuosl.org (Postfix) with ESMTPS id D683D600C5;
	Thu, 25 Nov 2021 06:47:57 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 905FCC0038;
	Thu, 25 Nov 2021 06:47:57 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 1504CC000A
 for <virtualization@lists.linux-foundation.org>;
 Thu, 25 Nov 2021 06:47:56 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id E25BD4021F
 for <virtualization@lists.linux-foundation.org>;
 Thu, 25 Nov 2021 06:47:55 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp2.osuosl.org (amavisd-new);
 dkim=pass (2048-bit key) header.d=linaro.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id pztP_uEfE611
 for <virtualization@lists.linux-foundation.org>;
 Thu, 25 Nov 2021 06:47:55 +0000 (UTC)
X-Greylist: whitelisted by SQLgrey-1.8.0
Received: from mail-pj1-x102f.google.com (mail-pj1-x102f.google.com
 [IPv6:2607:f8b0:4864:20::102f])
 by smtp2.osuosl.org (Postfix) with ESMTPS id 01C5C40018
 for <virtualization@lists.linux-foundation.org>;
 Thu, 25 Nov 2021 06:47:54 +0000 (UTC)
Received: by mail-pj1-x102f.google.com with SMTP id np3so4468121pjb.4
 for <virtualization@lists.linux-foundation.org>;
 Wed, 24 Nov 2021 22:47:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=date:from:to:subject:message-id:references:mime-version
 :content-disposition:in-reply-to:user-agent;
 bh=8xu2aIxFiMS+FdoCDZiYWeLv0HFIncR6uH5xTnTYuDE=;
 b=sQ7DeQx2L7wyOPR8AcPj2GANXOImuYpFUsZVVyPXeFkHRdzeY53EDx1g9DibKS+Tkt
 If5lxUsGj4pBaes1VY3Idbzo/bVvsRrPq8+g5S/amBkhwtyZ0rpZQSGqLlqz14rgTBxA
 qdXq298SyjxjqaonhpCTUiHc4d6KDe/Gwz7rGuRqYABI9zZEe8Du5FNiBJAKWUrGimKv
 62fy4f3TGCw/stdY8x983P+ls4Bu06nqdsA3heRa8Y/Tx/4nIJAFKtPT7cq4r5e7h/O3
 6v4bYKvH3eN5ECerCjtGIr5RBrAW07a7YL8aro9cU+JhjOmmAl9Ub/+hQL42DAeEW4gk
 t+BA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:date:from:to:subject:message-id:references
 :mime-version:content-disposition:in-reply-to:user-agent;
 bh=8xu2aIxFiMS+FdoCDZiYWeLv0HFIncR6uH5xTnTYuDE=;
 b=WziJereMmpXcq8EE15o8W/vBGLrzyQiBK5XkK0mM1l1xbmNmIF1Qn/IPmIIYh3Vwh9
 9QPxh+V9Mx1s7hEKJlnei6D+RNS0NTo9T488wjIkdRmW/DQ3++mouZxMUS+p7yrSobg+
 iC033PfhHOCzQ+Y2X42Yyx7dI1TEKNsrjiulBC4yyS1y7t0zWB5VSlzEMjqNmYvlZjYh
 wji1LK26cXL4vbyatFPGrPiUGE2DrL8WwgZ9AsjVsfUAOFwZVE2Z0vxCgte0trylbSpY
 eJODjesQOhuiN1rO8g+YIW/3yh6KJb6Y8rJiZKgwTPt8Q2C581PO1wZVB6+DV8G6lGit
 derg==
X-Gm-Message-State: AOAM532ddiqLOVD5Gdya2lL3WI3dEX0KwriCUkME62M/0WQU524E1WI8
 sf7kO4iQ++LYphG6rRqNEBrktA==
X-Google-Smtp-Source: ABdhPJzRN1Vq8J4tQeRAEWR90H5WICez/RY4tb7lTi4AOQPbpllEtnv65NgkuG6F/L8OFo9V7oaMZQ==
X-Received: by 2002:a17:902:c3cc:b0:141:be17:405e with SMTP id
 j12-20020a170902c3cc00b00141be17405emr27698607plj.76.1637822874397; 
 Wed, 24 Nov 2021 22:47:54 -0800 (PST)
Received: from localhost ([122.181.57.99])
 by smtp.gmail.com with ESMTPSA id z8sm1312770pgc.53.2021.11.24.22.47.52
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 24 Nov 2021 22:47:53 -0800 (PST)
Date: Thu, 25 Nov 2021 12:17:50 +0530
From: Viresh Kumar <viresh.kumar@linaro.org>
To: Wolfram Sang <wsa@kernel.org>, "Michael S. Tsirkin" <mst@redhat.com>,
 Vincent Whitchurch <vincent.whitchurch@axis.com>,
 jie.deng@intel.com, conghui.chen@intel.com,
 virtualization@lists.linux-foundation.org,
 linux-i2c@vger.kernel.org, linux-kernel@vger.kernel.org, kernel@axis.com
Subject: Re: [PATCH v2 0/2] virtio-i2c: Fix buffer handling
Message-ID: <20211125064750.ywq3vd76uy2levoz@vireshk-i7>
References: <20211111160412.11980-1-vincent.whitchurch@axis.com>
 <20211124185546-mutt-send-email-mst@kernel.org>
 <20211125032119.vklsh4yymwnalh5b@vireshk-i7>
 <YZ8rxHDPo68AT4HN@kunai>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <YZ8rxHDPo68AT4HN@kunai>
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

On 25-11-21, 07:24, Wolfram Sang wrote:
> 
> > Wolfram, you can apply that one as well, it looks okay.
> 
> Is it? I read that the code only waits for the last request while
> Michael suggested to wait for all of them? And he did not ack patch 2
> while he acked patch 1. Did I misunderstand?

Okay, I misread it then.

To clarify, we should initialize the completion for each buffer and
wait for all of them to be completed before returning back to the
user.

Lets wait for an update by Vincent for that then.

-- 
viresh
_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
