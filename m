Return-Path: <SRS0=rmzs=H3=lists.linux-foundation.org=virtualization-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E9777C433DB
	for <virtualization@archiver.kernel.org>; Thu, 25 Feb 2021 19:03:04 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 412B264EFA
	for <virtualization@archiver.kernel.org>; Thu, 25 Feb 2021 19:03:04 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 412B264EFA
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=virtualization-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 393C24EF52;
	Thu, 25 Feb 2021 19:03:03 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
	by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id 05D92G5D8Gv7; Thu, 25 Feb 2021 19:03:02 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp4.osuosl.org (Postfix) with ESMTP id 6492D4EF53;
	Thu, 25 Feb 2021 19:03:01 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 31F45C000E;
	Thu, 25 Feb 2021 19:03:01 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by lists.linuxfoundation.org (Postfix) with ESMTP id DC7B7C000A
 for <virtualization@lists.linux-foundation.org>;
 Thu, 25 Feb 2021 19:02:59 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id C23356F88C
 for <virtualization@lists.linux-foundation.org>;
 Thu, 25 Feb 2021 19:02:59 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp3.osuosl.org (amavisd-new);
 dkim=pass (1024-bit key) header.d=redhat.com
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id oVI4aDoZJz4x
 for <virtualization@lists.linux-foundation.org>;
 Thu, 25 Feb 2021 19:02:59 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [63.128.21.124])
 by smtp3.osuosl.org (Postfix) with ESMTPS id DEFD46F88D
 for <virtualization@lists.linux-foundation.org>;
 Thu, 25 Feb 2021 19:02:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1614279777;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=XFKozbHhnqP0a9+4FvYtN86/9o6SBDgQyBJdWAPtLYc=;
 b=goqO1vdXPPln9jyuLgdMKTqHCgBp1YKjaEGRXCNnG/iDMZj78RPz1esp4nuHTEd4cnuZj9
 dNvpdY/YSuwpQhRbJNdmQj7K/MqdglRJsYjeNoy4OqIQzOidY7mTrl/HsX8GqmLjWLbmO0
 vHPL65Os0TtpuS3Qmn+BJ1RwQ5mEIZw=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-182-XWCnePcsOCCC3gzmAVDx2Q-1; Thu, 25 Feb 2021 14:02:55 -0500
X-MC-Unique: XWCnePcsOCCC3gzmAVDx2Q-1
Received: by mail-wm1-f70.google.com with SMTP id w20so2359280wmc.0
 for <virtualization@lists.linux-foundation.org>;
 Thu, 25 Feb 2021 11:02:55 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to;
 bh=XFKozbHhnqP0a9+4FvYtN86/9o6SBDgQyBJdWAPtLYc=;
 b=ZgyV89fAvPQ4aSdU+YoqXC1xwCUOLgBAUqueRATjiEC0HbEFy1BxhIyFHNsZnRytwz
 pq2PVUvzQfhWCtdtCNkFozG50Y16h+d3biEsg1M13jxJ1lZ5h6VQvkjNw1tZEygyzIYO
 L1e886cLw4yb1QPRLp29JR0WxN9UTt34W1wVclzbtz5t1jmUtPv3LKmty6Ipr8SmwEsb
 YfbQCHFwfdpu06awTXz+79/NB7rBg6dq8ADF+n3hrmQLFzJLItuOqZgjKvsGkBoMAB/t
 qMxd65WT2k+RFfXjoBiZwrhlovgyY47m6qVfp7sXWMc3q7+5nUfs64myhvfWFcnN8Pwi
 D43Q==
X-Gm-Message-State: AOAM530IMkYX0hSgnxAYhiXeuZCRX1FW2gtkWi8LGxlJ7LhSMzHTiwHt
 vZWRyfmIoRgf3CNixfjMfLQFSpFFJDEsWQyxjgMJKDwRhHCYQZZXPWXJNIXeS2vP0s26W/5tRxq
 aA4avKHzIJ2hl0mKWEeYByQGGOgeo44AiUbOsFtemaw==
X-Received: by 2002:adf:f750:: with SMTP id z16mr5053154wrp.108.1614279774388; 
 Thu, 25 Feb 2021 11:02:54 -0800 (PST)
X-Google-Smtp-Source: ABdhPJyofpaHNGnRewH6YHzPuJRqwWTHK/BQLCP4h/Yb+AZpMyiGXAnajZWb3bS8LQE8CSJUwyqDIA==
X-Received: by 2002:adf:f750:: with SMTP id z16mr5053138wrp.108.1614279774228; 
 Thu, 25 Feb 2021 11:02:54 -0800 (PST)
Received: from redhat.com (212.116.168.114.static.012.net.il.
 [212.116.168.114])
 by smtp.gmail.com with ESMTPSA id s11sm8971320wme.22.2021.02.25.11.02.52
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 25 Feb 2021 11:02:53 -0800 (PST)
Date: Thu, 25 Feb 2021 14:02:50 -0500
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Takashi Iwai <tiwai@suse.de>
Subject: Re: [PATCH v5 6/9] ALSA: virtio: PCM substream operators
Message-ID: <20210225135951-mutt-send-email-mst@kernel.org>
References: <20210222153444.348390-1-anton.yakovlev@opensynergy.com>
 <20210222153444.348390-7-anton.yakovlev@opensynergy.com>
 <s5h35xkquvj.wl-tiwai@suse.de>
 <d9b6e8fa-7356-1cbf-029b-6f7c8bad4994@opensynergy.com>
 <s5hlfbcpayj.wl-tiwai@suse.de>
MIME-Version: 1.0
In-Reply-To: <s5hlfbcpayj.wl-tiwai@suse.de>
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=mst@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Disposition: inline
Cc: virtio-dev@lists.oasis-open.org, alsa-devel@alsa-project.org,
 linux-kernel@vger.kernel.org, Takashi Iwai <tiwai@suse.com>,
 Jaroslav Kysela <perex@perex.cz>, virtualization@lists.linux-foundation.org
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

On Thu, Feb 25, 2021 at 01:51:16PM +0100, Takashi Iwai wrote:
> On Thu, 25 Feb 2021 13:14:37 +0100,
> Anton Yakovlev wrote:
> > 
> > On 25.02.2021 11:55, Takashi Iwai wrote:
> > > On Mon, 22 Feb 2021 16:34:41 +0100,
> > > Anton Yakovlev wrote:
> > >> +static int virtsnd_pcm_open(struct snd_pcm_substream *substream)
> > >> +{
> > >> +     struct virtio_pcm *vpcm = snd_pcm_substream_chip(substream);
> > >> +     struct virtio_pcm_substream *vss = NULL;
> > >> +
> > >> +     if (vpcm) {
> > >> +             switch (substream->stream) {
> > >> +             case SNDRV_PCM_STREAM_PLAYBACK:
> > >> +             case SNDRV_PCM_STREAM_CAPTURE: {
> > >
> > > The switch() here looks superfluous.  The substream->stream must be a
> > > good value in the callback.  If any, you can put WARN_ON() there, but
> > > I don't think it worth.
> > 
> > At least it doesn't do any harm.
> 
> It does -- it makes the readability worse, and that's a very important
> point.
> 
> > >> +static int virtsnd_pcm_hw_params(struct snd_pcm_substream *substream,
> > >> +                              struct snd_pcm_hw_params *hw_params)
> > >> +{
> > > ....
> > >> +     return virtsnd_pcm_msg_alloc(vss, periods, period_bytes);
> > >
> > > We have the allocation, but...
> > >
> > >> +static int virtsnd_pcm_hw_free(struct snd_pcm_substream *substream)
> > >> +{
> > >> +     return 0;
> > >
> > > ... no release at hw_free()?
> > > I know that the free is present in the allocator, but it's only for
> > > re-allocation case, I suppose.
> > 
> > When the substream stops, sync_ptr waits until the device has completed
> > all pending messages. This wait can be interrupted either by a signal or
> > due to a timeout. In this case, the device can still access messages
> > even after calling hw_free(). It can also issue an interrupt, and the
> > interrupt handler will also try to access message structures. Therefore,
> > freeing of already allocated messages occurs either in hw_params() or in
> > dev->release(), since there it is 100% safe.
> 
> OK, then it's worth to document it about this object lifecycle.
> The buffer management of this driver is fairly unique, so otherwise it
> confuses readers.
> 
> 
> thanks,
> 
> Takashi

Takashi given I was in my tree for a while and I planned to merge
it this merge window. I can still drop it but there are
unrelated patches behind these in the tree so that's a rebase
which will invalidate my testing, I'm just concerned about
meeting the merge window.

Would it be ok to merge this as is and then address
readability stuff by patches on top?
If yes please send acks!
If you want to merge it yourself instead, also please say so.

-- 
MST

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
