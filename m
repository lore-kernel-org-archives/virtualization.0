Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 78BFDC77B61
	for <virtualization@archiver.kernel.org>; Mon,  1 May 2023 14:14:18 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 06BB0607D0;
	Mon,  1 May 2023 14:14:18 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 06BB0607D0
Authentication-Results: smtp3.osuosl.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=AqOFPDU7
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
	by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id YD-0Pcd894WX; Mon,  1 May 2023 14:14:17 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp3.osuosl.org (Postfix) with ESMTPS id 788536073F;
	Mon,  1 May 2023 14:14:16 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 788536073F
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 5B479C0037;
	Mon,  1 May 2023 14:14:16 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 248F1C002A
 for <virtualization@lists.linux-foundation.org>;
 Mon,  1 May 2023 14:14:15 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id F37F7408B1
 for <virtualization@lists.linux-foundation.org>;
 Mon,  1 May 2023 14:14:14 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org F37F7408B1
Authentication-Results: smtp2.osuosl.org;
 dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com
 header.a=rsa-sha256 header.s=mimecast20190719 header.b=AqOFPDU7
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id ary0RR5hz4xY
 for <virtualization@lists.linux-foundation.org>;
 Mon,  1 May 2023 14:14:14 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org 1EEE640491
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.133.124])
 by smtp2.osuosl.org (Postfix) with ESMTPS id 1EEE640491
 for <virtualization@lists.linux-foundation.org>;
 Mon,  1 May 2023 14:14:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1682950452;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=ZbS5IjUaNlPU8hbwLWUCcqwd+h51QQNEXep9a6KbrKM=;
 b=AqOFPDU7oYd7BlMklmL3A0H5x2eeRHdRKhPqm0uI3VJqiQNMINnYhyRQT4CPRdj155StOS
 Gqpt77GpuZpJ28z9P9EUWP/hr+GA8VROwtF9OcCAYxG22/Qki+yqjqojR/juks8KXZaHcv
 xS3OFsPfVRbDeb5D+Ez87e+FR5gQbU8=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-530-iKEEVnSDO5uYXQma702P0Q-1; Mon, 01 May 2023 10:14:05 -0400
X-MC-Unique: iKEEVnSDO5uYXQma702P0Q-1
Received: by mail-wm1-f69.google.com with SMTP id
 5b1f17b1804b1-3f18c2b2110so7383435e9.3
 for <virtualization@lists.linux-foundation.org>;
 Mon, 01 May 2023 07:14:04 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1682950444; x=1685542444;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=ZbS5IjUaNlPU8hbwLWUCcqwd+h51QQNEXep9a6KbrKM=;
 b=WNddsr4/m503o1TeUqI78ViAkbZ5uV0MN86mfkJsQc45g20kC46dHWe+2IUhMhEy/x
 nja1ofVIHtH5xCZlshS7joJw4QDS4MkEkdDp2giY9/gjcXGBiWfh55Ux0yCU7YBoYM1W
 eEGuISRZhtJU1IgKhCTH0Nk1fvxlXLlMlkUvRaL94FS68er6I3RctKqQATt1OqG407qs
 bw89No5uZMSKkM0ZpCfBsR9vflaoVuu7/cKTPBY8Qg4T1pMcFKjqMG9j5syW4vto66xi
 waciOb6nSncnDY13J7nYVMQ0Dt7G66uwsV4+Wj7AsWy2YqCwvUEZz51iy+usVzJhSyPL
 uLCQ==
X-Gm-Message-State: AC+VfDz8ZCAeBcajah6g1g7wBGgLWhMkRws2FDIWldLj3lHs1Obi3lBC
 Wdo9lfbEbbF28LePebZ8sMqEhB7LnYcxmx6kuJfYu16PMQ40NvfrkBns4zbt5qa/5lmRMmKKNAT
 IYqz8A8HjoKSiUqay6/GeEbzXAKZ3yQxsxg2p0EOVDw==
X-Received: by 2002:a1c:4b06:0:b0:3f0:3d47:2cc5 with SMTP id
 y6-20020a1c4b06000000b003f03d472cc5mr10326842wma.10.1682950443988; 
 Mon, 01 May 2023 07:14:03 -0700 (PDT)
X-Google-Smtp-Source: ACHHUZ5uwbn+68k6dEwgamd9RB+Cf3SAOrfWXIAOfHT0cY5NAJ1rKClQM9jVpxSANY9aJ1gTlwwrQA==
X-Received: by 2002:a1c:4b06:0:b0:3f0:3d47:2cc5 with SMTP id
 y6-20020a1c4b06000000b003f03d472cc5mr10326826wma.10.1682950443676; 
 Mon, 01 May 2023 07:14:03 -0700 (PDT)
Received: from redhat.com ([31.210.184.46]) by smtp.gmail.com with ESMTPSA id
 f22-20020a1c6a16000000b003f17e79d74asm33036957wmc.7.2023.05.01.07.14.01
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 01 May 2023 07:14:03 -0700 (PDT)
Date: Mon, 1 May 2023 10:14:00 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Feng Liu <feliu@nvidia.com>
Subject: Re: [PATCH net v1 2/2] virtio_net: Close queue pairs using helper
 function
Message-ID: <20230501101231-mutt-send-email-mst@kernel.org>
References: <20230428224346.68211-1-feliu@nvidia.com>
 <ZE+0RsBYDTgnauOX@corigine.com>
 <9dba94bb-3e40-6809-3f5a-cbb0ae19c5b7@nvidia.com>
MIME-Version: 1.0
In-Reply-To: <9dba94bb-3e40-6809-3f5a-cbb0ae19c5b7@nvidia.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Disposition: inline
Cc: Xuan Zhuo <xuanzhuo@linux.alibaba.com>,
 Simon Horman <simon.horman@corigine.com>, linux-kernel@vger.kernel.org,
 virtualization@lists.linux-foundation.org, netdev@vger.kernel.org,
 William Tu <witu@nvidia.com>, bpf@vger.kernel.org
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

On Mon, May 01, 2023 at 09:58:18AM -0400, Feng Liu wrote:
> 
> 
> On 2023-05-01 a.m.8:44, Simon Horman wrote:
> > External email: Use caution opening links or attachments
> > 
> > 
> > On Fri, Apr 28, 2023 at 06:43:46PM -0400, Feng Liu wrote:
> > > Use newly introduced helper function that exactly does the same of
> > > closing the queue pairs.
> > > 
> > > Signed-off-by: Feng Liu <feliu@nvidia.com>
> > > Reviewed-by: William Tu <witu@nvidia.com>
> > > Reviewed-by: Parav Pandit <parav@nvidia.com>
> > 
> > I guess this was put in a separate patch to 1/2, as it's more
> > net-next material, as opposed to 1/2 which seems to be net material.
> > FWIIW, I'd lean to putting 1/2 in net. And holding this one for net-next.
> > 
> > That aside, this looks good to me.
> > 
> > Reviewed-by: Simon Horman <simon.horman@corigine.com>
> 
> Will do, thanks Simon

Nah, I think you should just squash these two patches together.
It's early in the merge window.

-- 
MST

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
