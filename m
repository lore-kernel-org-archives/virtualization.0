Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 16DC4C433FE
	for <virtualization@archiver.kernel.org>; Tue, 26 Apr 2022 14:38:46 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id AAACE41834;
	Tue, 26 Apr 2022 14:38:46 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
	by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id n5NmSgbzuK0H; Tue, 26 Apr 2022 14:38:45 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp4.osuosl.org (Postfix) with ESMTPS id 1945241674;
	Tue, 26 Apr 2022 14:38:45 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id D3AB3C0032;
	Tue, 26 Apr 2022 14:38:44 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id A62F1C002D
 for <virtualization@lists.linux-foundation.org>;
 Tue, 26 Apr 2022 14:38:43 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id 9496481467
 for <virtualization@lists.linux-foundation.org>;
 Tue, 26 Apr 2022 14:38:43 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp1.osuosl.org (amavisd-new);
 dkim=pass (1024-bit key) header.d=redhat.com
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id A5CNrCEnpbJc
 for <virtualization@lists.linux-foundation.org>;
 Tue, 26 Apr 2022 14:38:40 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.133.124])
 by smtp1.osuosl.org (Postfix) with ESMTPS id C43028145A
 for <virtualization@lists.linux-foundation.org>;
 Tue, 26 Apr 2022 14:38:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1650983919;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=Oay4ro9gliPGutvjNsoyWEuxgyMzWkRHOAjFiijjFoc=;
 b=fLgE/ywQan5Tie8UHLAm1mq1Zyhwc38a4AyI2LvkJA4Wau2/Tfn80tKxAgCj7dDU5zLEpt
 xPHLaCwLcKTMRhUSxhu9TaSMb9cQusfNq9JN3MMuNlwGBF4DYAuHjC1eZqtFeNinQCmGjD
 M1zbJcKuGlJkkJ7ftLQNNKKSc4rAk0g=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-148-fdPaN-4PO_OAZ38Y-fMp9w-1; Tue, 26 Apr 2022 10:38:38 -0400
X-MC-Unique: fdPaN-4PO_OAZ38Y-fMp9w-1
Received: by mail-wm1-f69.google.com with SMTP id
 i66-20020a1c3b45000000b0038eab4e0feaso8106236wma.9
 for <virtualization@lists.linux-foundation.org>;
 Tue, 26 Apr 2022 07:38:38 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to;
 bh=Oay4ro9gliPGutvjNsoyWEuxgyMzWkRHOAjFiijjFoc=;
 b=enD9ciNRceQUF1jGYMcMh76M0k2oj0Al/3yocmggGmKDSjGnXbJHCNp4BRBphkqU2h
 bWxXLy8uYaMgoKmKUJTZAHx7znR335Xm8sQXElvpKg3dzm2KVTm0DXoTChctCDIV8tZq
 oQjUWC8VtlIirrm2u3fH9lABxwE9Xh5Zah4hL52Q6jGJZG1Fn+09cPjBFBBDlBd0KVyu
 9O9VEFdOtN2rgpkEVrkTf64+oltDN/stBknVf+JYoydTT3WnMqIBV/zOfyyYnilvIdHl
 WEaSWHZlN11IcM1YLmzWpiMxMxGU7LRj/I7/J0DyQ+nxIDuZ99ucP0Q7CwpFbjYqRotg
 /9jQ==
X-Gm-Message-State: AOAM53245D+YP1BAMtasfQxkMaCX+bXFgZ7oZyKrdcRZ5kh+16jdApRr
 WUjnzwCuLrgLXuWtS+/GGaOcWAJ7feHWf8zMCF/Yr/q5DJJFalouhLiwMiiF0CT2xjDhlPz+BEm
 YDV4j5f+rBYslkRZWrlCx7ffP0HFr89XI406zlYRQ6w==
X-Received: by 2002:a5d:6e0d:0:b0:207:a4d9:7950 with SMTP id
 h13-20020a5d6e0d000000b00207a4d97950mr18375702wrz.477.1650983916504; 
 Tue, 26 Apr 2022 07:38:36 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJylYtF6Wp5jg40DA3zQEzDDxbPs4yx70tpkzBV4+NmNwdvK4cDa8N0/lzrq04ZWnbBO/BbNBw==
X-Received: by 2002:a5d:6e0d:0:b0:207:a4d9:7950 with SMTP id
 h13-20020a5d6e0d000000b00207a4d97950mr18375678wrz.477.1650983916291; 
 Tue, 26 Apr 2022 07:38:36 -0700 (PDT)
Received: from redhat.com ([2.53.22.137]) by smtp.gmail.com with ESMTPSA id
 i14-20020a1c540e000000b00393dc91e9c9sm10891399wmb.17.2022.04.26.07.38.33
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 26 Apr 2022 07:38:35 -0700 (PDT)
Date: Tue, 26 Apr 2022 10:38:31 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Yongji Xie <xieyongji@bytedance.com>
Subject: Re: [PATCH v2] vduse: Fix NULL pointer dereference on sysfs access
Message-ID: <20220426103742-mutt-send-email-mst@kernel.org>
References: <YmeoSuMfsdVxuGlf@kroah.com>
 <CACycT3sLgihkgX5cB6GxDehaTsPn9rqhtWF7G_=J=__oTopJZw@mail.gmail.com>
 <YmfIv2YuARnPe97k@kroah.com>
 <CACycT3sq6WM1uCa+ix79AwTJHaEOhkLycwkZOhqPhABZ4xa2AA@mail.gmail.com>
 <YmfpKGZB06Ix5WPu@kroah.com>
 <CACycT3vD9o+_uLaevCZ=W==YRA_WJP8UJ6czHTtsUny8Rwgd0A@mail.gmail.com>
 <Ymf03l+Ag8ZBSGm2@kroah.com>
 <CACycT3vmN0z=in1hcT7XuW4p-vzq9SAgPJNGGkooc+C+qftWjw@mail.gmail.com>
 <20220426101640-mutt-send-email-mst@kernel.org>
 <CACycT3vLdjH820EBzz+4u5+6JH+hjnFTK1mtSJje9Uq1j_KTdQ@mail.gmail.com>
MIME-Version: 1.0
In-Reply-To: <CACycT3vLdjH820EBzz+4u5+6JH+hjnFTK1mtSJje9Uq1j_KTdQ@mail.gmail.com>
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=mst@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Disposition: inline
Cc: Greg KH <gregkh@linuxfoundation.org>, stable@vger.kernel.org,
 virtualization <virtualization@lists.linux-foundation.org>,
 Luis Chamberlain <mcgrof@kernel.org>,
 kernel test robot <oliver.sang@intel.com>,
 Andrew Morton <akpm@linux-foundation.org>
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

On Tue, Apr 26, 2022 at 10:37:17PM +0800, Yongji Xie wrote:
> On Tue, Apr 26, 2022 at 10:18 PM Michael S. Tsirkin <mst@redhat.com> wrote:
> >
> > On Tue, Apr 26, 2022 at 10:02:02PM +0800, Yongji Xie wrote:
> > > > This should not be needed, when your module is unloaded, all devices it
> > > > handled should be properly removed by it.
> > > >
> > >
> > > I see. But it's not easy to achieve that currently. Maybe we need
> > > something like DEVICE_NEEDS_RESET support in virtio core.
> >
> > Not sure what the connection is.
> >
> 
> If we want to force remove all working vduse devices during module
> unload, we might need to send a DEVICE_NEEDS_RESET notification to
> device driver to do some cleanup before, e.g., return error for all
> inflight I/Os.
> 
> Thanks,
> Yongji

IMHO DEVICE_NEEDS_RESET won't help much with that, it's more in
case device is still there but needs a reset to start working.

-- 
MST

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
