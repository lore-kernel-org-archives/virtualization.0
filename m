Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 937EBC433FE
	for <virtualization@archiver.kernel.org>; Tue,  8 Mar 2022 12:28:01 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 3A97360F3E;
	Tue,  8 Mar 2022 12:28:01 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
	by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id 4UHahdTCkvL0; Tue,  8 Mar 2022 12:28:00 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp3.osuosl.org (Postfix) with ESMTPS id AB61E60F4A;
	Tue,  8 Mar 2022 12:27:59 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 7D8A9C001D;
	Tue,  8 Mar 2022 12:27:59 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 632B5C000B
 for <virtualization@lists.linux-foundation.org>;
 Tue,  8 Mar 2022 12:27:58 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id 59E84841B9
 for <virtualization@lists.linux-foundation.org>;
 Tue,  8 Mar 2022 12:27:58 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp1.osuosl.org (amavisd-new);
 dkim=pass (1024-bit key) header.d=redhat.com
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id GlWIn8bIkkaj
 for <virtualization@lists.linux-foundation.org>;
 Tue,  8 Mar 2022 12:27:57 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.133.124])
 by smtp1.osuosl.org (Postfix) with ESMTPS id 51C4B841AF
 for <virtualization@lists.linux-foundation.org>;
 Tue,  8 Mar 2022 12:27:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1646742476;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=9pf/IVqL8yE3g13OAwcuAVKQfPo53FP6ApFVilX1pcQ=;
 b=BozQaDvjf0jH73yZ4KpoZFguMBmgZ7LgaRUZvSMcWQHYdswutSug9zBNwydZ8RQpnok3LC
 ECUGMmjjbysmcQdFOc0kGOC4Af+BcDlfwKU8IBZza6bWp+lHDKyjUosxXGQz7Hhp5z6ACa
 +naCG8LGhmQt1zsLigOZrBKtNdruvzA=
Received: from mail-ej1-f70.google.com (mail-ej1-f70.google.com
 [209.85.218.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-362-Wzu3FI-mMl2hAEd-TZ_lCg-1; Tue, 08 Mar 2022 07:27:54 -0500
X-MC-Unique: Wzu3FI-mMl2hAEd-TZ_lCg-1
Received: by mail-ej1-f70.google.com with SMTP id
 lf15-20020a170906ae4f00b006da86a43346so7455675ejb.14
 for <virtualization@lists.linux-foundation.org>;
 Tue, 08 Mar 2022 04:27:54 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to;
 bh=9pf/IVqL8yE3g13OAwcuAVKQfPo53FP6ApFVilX1pcQ=;
 b=2xignskZyViQXgaRYua2McpRHUZwl5oeAOYN/l8cjxsqlAD7KYIePBXS9qFCmr8hdT
 39BOOpXQI/iztyz1Z1gtAIRgxuTg4mVp+bOGBnbdLkZYZ/2EE3mS/EJpvlbohaGhu4ij
 zHtx8YCubJAny6d7sV0VVCaP4xxEUNi145MXgFvQgirPvNrzOaP8mHNcEPBo4vMNZnkB
 voFr8P+4zuhq800cOB6cfySX6giQqtG8lo1ysxShvmPD+Z7kXNiU4I/U98WNIKgSfir9
 1uYpYu9cu4NXyTuOvdaKE61Zdgn38XfgmMNzMu/6TH8v6TU9Y8voORv71uBP5isvmLNp
 MpFA==
X-Gm-Message-State: AOAM531WiuAUAUiqio5ExGE7LooZdrTYkQz2OMulp5dQZdTeO5Kqik8e
 ugpojjvUZpW2b9AQ0Y2YgmAH662Wmi4QAdBJf+icfi6LOfv/rsMNYoyfM0v/Bi8SZYoG5J2B4Rw
 R9uqJxABLQknViOIaM5R6GweOmi9FeLOicGWhYY4+Fg==
X-Received: by 2002:a17:907:7242:b0:6da:b561:d523 with SMTP id
 ds2-20020a170907724200b006dab561d523mr13282177ejc.118.1646742471606; 
 Tue, 08 Mar 2022 04:27:51 -0800 (PST)
X-Google-Smtp-Source: ABdhPJyRLddVnWaTYQ7CEcx+H/uBDYSK5MuBK5kvSFUyJcedIYo1CrA8Y49v9huSdkQH7zA4WWcJdw==
X-Received: by 2002:a17:907:7242:b0:6da:b561:d523 with SMTP id
 ds2-20020a170907724200b006dab561d523mr13282150ejc.118.1646742471316; 
 Tue, 08 Mar 2022 04:27:51 -0800 (PST)
Received: from redhat.com ([2.55.138.228]) by smtp.gmail.com with ESMTPSA id
 p24-20020a1709061b5800b006da6435cedcsm5786231ejg.132.2022.03.08.04.27.49
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 08 Mar 2022 04:27:50 -0800 (PST)
Date: Tue, 8 Mar 2022 07:27:47 -0500
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Greg KH <gregkh@linuxfoundation.org>
Subject: Re: [PATCH 1/1] vhost: Protect the virtqueue from being cleared
 whilst still in use
Message-ID: <20220308071718-mutt-send-email-mst@kernel.org>
References: <20220307191757.3177139-1-lee.jones@linaro.org>
 <YiZeB7l49KC2Y5Gz@kroah.com> <YicPXnNFHpoJHcUN@google.com>
 <Yicalf1I6oBytbse@kroah.com> <Yicer3yGg5rrdSIs@google.com>
 <YicolvcbY9VT6AKc@kroah.com>
 <20220308055003-mutt-send-email-mst@kernel.org>
 <YidBz7SxED2ii1Lh@kroah.com>
MIME-Version: 1.0
In-Reply-To: <YidBz7SxED2ii1Lh@kroah.com>
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=mst@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Disposition: inline
Cc: syzbot+adc3cb32385586bec859@syzkaller.appspotmail.com, kvm@vger.kernel.org,
 netdev@vger.kernel.org, linux-kernel@vger.kernel.org, stable@vger.kernel.org,
 virtualization@lists.linux-foundation.org, Lee Jones <lee.jones@linaro.org>
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

On Tue, Mar 08, 2022 at 12:45:19PM +0100, Greg KH wrote:
> On Tue, Mar 08, 2022 at 05:55:58AM -0500, Michael S. Tsirkin wrote:
> > On Tue, Mar 08, 2022 at 10:57:42AM +0100, Greg KH wrote:
> > > On Tue, Mar 08, 2022 at 09:15:27AM +0000, Lee Jones wrote:
> > > > On Tue, 08 Mar 2022, Greg KH wrote:
> > > > 
> > > > > On Tue, Mar 08, 2022 at 08:10:06AM +0000, Lee Jones wrote:
> > > > > > On Mon, 07 Mar 2022, Greg KH wrote:
> > > > > > 
> > > > > > > On Mon, Mar 07, 2022 at 07:17:57PM +0000, Lee Jones wrote:
> > > > > > > > vhost_vsock_handle_tx_kick() already holds the mutex during its call
> > > > > > > > to vhost_get_vq_desc().  All we have to do here is take the same lock
> > > > > > > > during virtqueue clean-up and we mitigate the reported issues.
> > > > > > > > 
> > > > > > > > Also WARN() as a precautionary measure.  The purpose of this is to
> > > > > > > > capture possible future race conditions which may pop up over time.
> > > > > > > > 
> > > > > > > > Link: https://syzkaller.appspot.com/bug?extid=279432d30d825e63ba00
> > > > > > > > 
> > > > > > > > Cc: <stable@vger.kernel.org>
> > > > > > > > Reported-by: syzbot+adc3cb32385586bec859@syzkaller.appspotmail.com
> > > > > > > > Signed-off-by: Lee Jones <lee.jones@linaro.org>
> > > > > > > > ---
> > > > > > > >  drivers/vhost/vhost.c | 10 ++++++++++
> > > > > > > >  1 file changed, 10 insertions(+)
> > > > > > > > 
> > > > > > > > diff --git a/drivers/vhost/vhost.c b/drivers/vhost/vhost.c
> > > > > > > > index 59edb5a1ffe28..ef7e371e3e649 100644
> > > > > > > > --- a/drivers/vhost/vhost.c
> > > > > > > > +++ b/drivers/vhost/vhost.c
> > > > > > > > @@ -693,6 +693,15 @@ void vhost_dev_cleanup(struct vhost_dev *dev)
> > > > > > > >  	int i;
> > > > > > > >  
> > > > > > > >  	for (i = 0; i < dev->nvqs; ++i) {
> > > > > > > > +		/* No workers should run here by design. However, races have
> > > > > > > > +		 * previously occurred where drivers have been unable to flush
> > > > > > > > +		 * all work properly prior to clean-up.  Without a successful
> > > > > > > > +		 * flush the guest will malfunction, but avoiding host memory
> > > > > > > > +		 * corruption in those cases does seem preferable.
> > > > > > > > +		 */
> > > > > > > > +		WARN_ON(mutex_is_locked(&dev->vqs[i]->mutex));
> > > > > > > 
> > > > > > > So you are trading one syzbot triggered issue for another one in the
> > > > > > > future?  :)
> > > > > > > 
> > > > > > > If this ever can happen, handle it, but don't log it with a WARN_ON() as
> > > > > > > that will trigger the panic-on-warn boxes, as well as syzbot.  Unless
> > > > > > > you want that to happen?
> > > > > > 
> > > > > > No, Syzbot doesn't report warnings, only BUGs and memory corruption.
> > > > > 
> > > > > Has it changed?  Last I looked, it did trigger on WARN_* calls, which
> > > > > has resulted in a huge number of kernel fixes because of that.
> > > > 
> > > > Everything is customisable in syzkaller, so maybe there are specific
> > > > builds which panic_on_warn enabled, but none that I'm involved with
> > > > do.
> > > 
> > > Many systems run with panic-on-warn (i.e. the cloud), as they want to
> > > drop a box and restart it if anything goes wrong.
> > > 
> > > That's why syzbot reports on WARN_* calls.  They should never be
> > > reachable by userspace actions.
> > > 
> > > > Here follows a topical example.  The report above in the Link: tag
> > > > comes with a crashlog [0].  In there you can see the WARN() at the
> > > > bottom of vhost_dev_cleanup() trigger many times due to a populated
> > > > (non-flushed) worker list, before finally tripping the BUG() which
> > > > triggers the report:
> > > > 
> > > > [0] https://syzkaller.appspot.com/text?tag=CrashLog&x=16a61fce700000
> > > 
> > > Ok, so both happens here.  But don't add a warning for something that
> > > can't happen.  Just handle it and move on.  It looks like you are
> > > handling it in this code, so please drop the WARN_ON().
> > > 
> > > thanks,
> > > 
> > > greg k-h
> > 
> > Hmm. Well this will mean if we ever reintroduce the bug then
> > syzkaller will not catch it for us :( And the bug is there,
> > it just results in a hard to reproduce error for userspace.
> 
> Is this an error you can recover from in the kernel?
>  What is userspace
> supposed to know with this information when it sees it?

IIUC we are talking about a use after free here since we somehow
managed to have a pointer to the device in a worker while
device is being destroyed.

That's the point of the warning as use after free is hard to debug. You
ask can we recover from a use after free? 

As regards to the added lock, IIUC it kind of shifts the use after free
window to later and since we zero out some of the memory just before we
free it, it's a bit more likely to recover.  I would still like to see
some more analysis on why the situation is always better than it was
before though.

> > Not sure what to do here. Export panic_on_warn flag to modules
> > and check it here?
> 
> Hah, no, never do that :)
> 
> thanks,
> 
> greg k-h

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
