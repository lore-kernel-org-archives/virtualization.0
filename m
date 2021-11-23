Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AA879C433EF
	for <virtualization@archiver.kernel.org>; Tue, 23 Nov 2021 09:54:36 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 48A1C40367;
	Tue, 23 Nov 2021 09:54:36 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
	by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id Sf7yjjKzqlt9; Tue, 23 Nov 2021 09:54:35 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp4.osuosl.org (Postfix) with ESMTPS id E0ACC401F0;
	Tue, 23 Nov 2021 09:54:34 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id B8914C002E;
	Tue, 23 Nov 2021 09:54:34 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 9C8C0C0012
 for <virtualization@lists.linux-foundation.org>;
 Tue, 23 Nov 2021 09:54:33 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id D2CB24018E
 for <virtualization@lists.linux-foundation.org>;
 Tue, 23 Nov 2021 09:54:32 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp2.osuosl.org (amavisd-new);
 dkim=pass (2048-bit key) header.d=linaro.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id ZOzn3fyHDJR1
 for <virtualization@lists.linux-foundation.org>;
 Tue, 23 Nov 2021 09:54:31 +0000 (UTC)
X-Greylist: whitelisted by SQLgrey-1.8.0
Received: from mail-pj1-x102d.google.com (mail-pj1-x102d.google.com
 [IPv6:2607:f8b0:4864:20::102d])
 by smtp2.osuosl.org (Postfix) with ESMTPS id BF0C040019
 for <virtualization@lists.linux-foundation.org>;
 Tue, 23 Nov 2021 09:54:31 +0000 (UTC)
Received: by mail-pj1-x102d.google.com with SMTP id
 gx15-20020a17090b124f00b001a695f3734aso2464033pjb.0
 for <virtualization@lists.linux-foundation.org>;
 Tue, 23 Nov 2021 01:54:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=date:from:to:subject:message-id:references:mime-version
 :content-disposition:in-reply-to:user-agent;
 bh=QSCZCVIM5tro7T7torOdfwmS3vTxofOoggZZ/saqbOU=;
 b=dv4lkXZuDXaNbEHrE2JqIa+zynhkxLOVE+c2MdRNeWLH/gsLT1pUoR6aZMXcChVTbB
 Gi2MEo9otlCa9TI1uVIvKEV8rAv3d5Ge/qKl9s6pXRkchmosDcXHg7ZEjqF+rOGz9AOS
 68gMFp1eXrcx6zTfrZP7V+LFKIAZ0jz6ctV6AgCvrZcrjUtQbDSW0a0MHptEeqNZPyhd
 lAdRajDBuGmdwJCgjwtzVEEjqVMHDWm6+yfUCfcUrYSHtd2vo7VU6HxPPYMtozcSGvFJ
 JWZbJWbGIIeiPDj+SdlxcmCqvFVAKJJDz4csPvZWli5j2UH3qDCqji26dlM1XaBL/5NC
 hYfg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:date:from:to:subject:message-id:references
 :mime-version:content-disposition:in-reply-to:user-agent;
 bh=QSCZCVIM5tro7T7torOdfwmS3vTxofOoggZZ/saqbOU=;
 b=7thGPfmH5+JCciX9miVdFlf8vupRsbN4LZXiYP1vuk1fAuFNGKF7nU2aNeD8gxlkH5
 zTAk3kM7F+8EO7dbK5ya/jcVMkkpwVXwfwdE6pYUvgq3h71WehQXaqbcI6bPvCauFLef
 L9wf7jY1tN8GqxlNB0GoFOX+UaGPywey0k+0cMHRaaDHHbXWjSBy24HJga6dkIqJB7GJ
 /NBnryzokfLMRG01CppZUBAdHvbn5MPuAyaBgnoLdUs50jIECj1SkalLdvYUIVMRY0Hk
 EZOe9S6SqlxZZIif0AC4fo3U6pnsYmgwKTGE0EukSjKjC3GWqUKu4qIy3b9NO+NwfPMD
 jrsA==
X-Gm-Message-State: AOAM533wDOSpj5thMfrdQRKX772Bg/7g2z9QqBikXKkPuxbNJa/jvP90
 X//aTFZVlgiVYgoGPs+uAdFrgg==
X-Google-Smtp-Source: ABdhPJwdbNswCrtvOdTklSGcl6W911admnD+WhCQoNtyWIgfzuZqHJUqyKRHgoe7ig4Trjt4mbT0eg==
X-Received: by 2002:a17:902:a40f:b0:143:d470:d66d with SMTP id
 p15-20020a170902a40f00b00143d470d66dmr5481723plq.52.1637661271149; 
 Tue, 23 Nov 2021 01:54:31 -0800 (PST)
Received: from localhost ([122.181.57.99])
 by smtp.gmail.com with ESMTPSA id h6sm13770515pfh.82.2021.11.23.01.54.30
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 23 Nov 2021 01:54:30 -0800 (PST)
Date: Tue, 23 Nov 2021 15:24:28 +0530
From: Viresh Kumar <viresh.kumar@linaro.org>
To: Wolfram Sang <wsa@kernel.org>,
 Vincent Whitchurch <vincent.whitchurch@axis.com>,
 jie.deng@intel.com, conghui.chen@intel.com, mst@redhat.com,
 virtualization@lists.linux-foundation.org,
 linux-i2c@vger.kernel.org, linux-kernel@vger.kernel.org, kernel@axis.com
Subject: Re: [PATCH v2 1/2] i2c: virtio: disable timeout handling
Message-ID: <20211123095428.ke63esylaldgrfus@vireshk-i7>
References: <20211111160412.11980-1-vincent.whitchurch@axis.com>
 <20211111160412.11980-2-vincent.whitchurch@axis.com>
 <YZy5xVU4XHEaz+EL@kunai>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <YZy5xVU4XHEaz+EL@kunai>
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

On 23-11-21, 10:52, Wolfram Sang wrote:
> On Thu, Nov 11, 2021 at 05:04:11PM +0100, Vincent Whitchurch wrote:
> > If a timeout is hit, it can result is incorrect data on the I2C bus
> > and/or memory corruptions in the guest since the device can still be
> > operating on the buffers it was given while the guest has freed them.
> > 
> > Here is, for example, the start of a slub_debug splat which was
> > triggered on the next transfer after one transfer was forced to timeout
> > by setting a breakpoint in the backend (rust-vmm/vhost-device):
> > 
> >  BUG kmalloc-1k (Not tainted): Poison overwritten
> >  First byte 0x1 instead of 0x6b
> >  Allocated in virtio_i2c_xfer+0x65/0x35c age=350 cpu=0 pid=29
> >  	__kmalloc+0xc2/0x1c9
> >  	virtio_i2c_xfer+0x65/0x35c
> >  	__i2c_transfer+0x429/0x57d
> >  	i2c_transfer+0x115/0x134
> >  	i2cdev_ioctl_rdwr+0x16a/0x1de
> >  	i2cdev_ioctl+0x247/0x2ed
> >  	vfs_ioctl+0x21/0x30
> >  	sys_ioctl+0xb18/0xb41
> >  Freed in virtio_i2c_xfer+0x32e/0x35c age=244 cpu=0 pid=29
> >  	kfree+0x1bd/0x1cc
> >  	virtio_i2c_xfer+0x32e/0x35c
> >  	__i2c_transfer+0x429/0x57d
> >  	i2c_transfer+0x115/0x134
> >  	i2cdev_ioctl_rdwr+0x16a/0x1de
> >  	i2cdev_ioctl+0x247/0x2ed
> >  	vfs_ioctl+0x21/0x30
> >  	sys_ioctl+0xb18/0xb41
> > 
> > There is no simple fix for this (the driver would have to always create
> > bounce buffers and hold on to them until the device eventually returns
> > the buffers), so just disable the timeout support for now.
> > 
> > Fixes: 3cfc88380413d20f ("i2c: virtio: add a virtio i2c frontend driver")
> > Acked-by: Jie Deng <jie.deng@intel.com>
> > Signed-off-by: Vincent Whitchurch <vincent.whitchurch@axis.com>
> 
> Applied to for-current, thanks!
> 

Thanks, I completely forgot replying to the last email from Vincent.

FWIW,

Reviewed-by: Viresh Kumar <viresh.kumar@linaro.org>

-- 
viresh
_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
