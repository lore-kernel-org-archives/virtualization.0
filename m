Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 70BA0C433FE
	for <virtualization@archiver.kernel.org>; Tue,  8 Mar 2022 10:56:13 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp2.osuosl.org (Postfix) with ESMTP id 04B7E401F2;
	Tue,  8 Mar 2022 10:56:13 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
	by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id gDDaLP4lK2If; Tue,  8 Mar 2022 10:56:12 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp2.osuosl.org (Postfix) with ESMTPS id 4A6AD40144;
	Tue,  8 Mar 2022 10:56:11 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 1ADA2C001D;
	Tue,  8 Mar 2022 10:56:11 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by lists.linuxfoundation.org (Postfix) with ESMTP id EBEB8C000B
 for <virtualization@lists.linux-foundation.org>;
 Tue,  8 Mar 2022 10:56:09 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id C784C41766
 for <virtualization@lists.linux-foundation.org>;
 Tue,  8 Mar 2022 10:56:09 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp4.osuosl.org (amavisd-new);
 dkim=pass (1024-bit key) header.d=redhat.com
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id HPlQRRQiRRQt
 for <virtualization@lists.linux-foundation.org>;
 Tue,  8 Mar 2022 10:56:08 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.133.124])
 by smtp4.osuosl.org (Postfix) with ESMTPS id C569B41755
 for <virtualization@lists.linux-foundation.org>;
 Tue,  8 Mar 2022 10:56:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1646736967;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=THPXJELvuxW6inJpizACi6yZwtZMXDw05fIwiYKfyWA=;
 b=FR/+saUBj26x5O/hf+NmaIHXLzUjC4Rnl4MIc7owFdk5vUycz2QqYFfi8urtvElvvamBI6
 RN1C6I8CwpEf1kb5Dsaer6Bk0sO0PhcaQ/Ll9IpSFOf6HyDJ2qc3sp9i3ycyciTUOgp/au
 1ezB/hR/ApAnKS85fnfihav6Uxfh3XI=
Received: from mail-ej1-f70.google.com (mail-ej1-f70.google.com
 [209.85.218.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-558--oaBTHHeNTWWj0cvTIOH1w-1; Tue, 08 Mar 2022 05:56:04 -0500
X-MC-Unique: -oaBTHHeNTWWj0cvTIOH1w-1
Received: by mail-ej1-f70.google.com with SMTP id
 go11-20020a1709070d8b00b006cf0d933739so8475732ejc.5
 for <virtualization@lists.linux-foundation.org>;
 Tue, 08 Mar 2022 02:56:04 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to;
 bh=THPXJELvuxW6inJpizACi6yZwtZMXDw05fIwiYKfyWA=;
 b=aLdkDPkcDd6xANLQhu7tOAhuc59SKG1dIvOFvTzXtfWokSgTDcJTjqFRuQhnWfZZ59
 M+FH7awq0+562IXdWKTSufaoAsvuhjEkdUzZyallvl+8A2c+fiw6scnYJIeWMcNplbcE
 CWrX37B5uAUHzwB/zoLiRQVtHf//1b4B7+g0h7YPBrAsB3A++OOYNU8e5LZ1nEReWnfa
 McJWMAypQ+X63WZVwf5oTNGilTyXvAtrtYt/j/NqUcwZFLybPReNslePG3w+C/+qK5gC
 NFxpPs8ZPbFzTL4do7YuOnGKLt7DtHY2sDAxU1giG3mE6iBpnypBRGCcgaCIvDT0o8hf
 XEDA==
X-Gm-Message-State: AOAM531kGvwnfTKXLZmvnCtpnox06K7ipMIdlottm+MoVjSXWfZRPbf1
 7fT7NfXjAooPbP7HEqX1GsFpkzmQ9KHYNFHWX0kTJqC8AGlDa+Oji/SR4bQWRhEVu5Cy37bHCZA
 gu8uIYsfqL8Uy07XytWCjtsrI6LiWI7itNJBOG3H0yw==
X-Received: by 2002:a17:907:6096:b0:6da:68d2:327f with SMTP id
 ht22-20020a170907609600b006da68d2327fmr12817785ejc.761.1646736962912; 
 Tue, 08 Mar 2022 02:56:02 -0800 (PST)
X-Google-Smtp-Source: ABdhPJyKGG3Z63udeaeH1lPhQJidMdNIksYDzx/dSa/Eol2gRlzn6bu5TRgyUjAEl+sdkcHMtg9aTg==
X-Received: by 2002:a17:907:6096:b0:6da:68d2:327f with SMTP id
 ht22-20020a170907609600b006da68d2327fmr12817773ejc.761.1646736962624; 
 Tue, 08 Mar 2022 02:56:02 -0800 (PST)
Received: from redhat.com ([2.55.138.228]) by smtp.gmail.com with ESMTPSA id
 u5-20020a170906b10500b006ce6fa4f510sm5668769ejy.165.2022.03.08.02.56.00
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 08 Mar 2022 02:56:02 -0800 (PST)
Date: Tue, 8 Mar 2022 05:55:58 -0500
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Greg KH <gregkh@linuxfoundation.org>
Subject: Re: [PATCH 1/1] vhost: Protect the virtqueue from being cleared
 whilst still in use
Message-ID: <20220308055003-mutt-send-email-mst@kernel.org>
References: <20220307191757.3177139-1-lee.jones@linaro.org>
 <YiZeB7l49KC2Y5Gz@kroah.com> <YicPXnNFHpoJHcUN@google.com>
 <Yicalf1I6oBytbse@kroah.com> <Yicer3yGg5rrdSIs@google.com>
 <YicolvcbY9VT6AKc@kroah.com>
MIME-Version: 1.0
In-Reply-To: <YicolvcbY9VT6AKc@kroah.com>
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

On Tue, Mar 08, 2022 at 10:57:42AM +0100, Greg KH wrote:
> On Tue, Mar 08, 2022 at 09:15:27AM +0000, Lee Jones wrote:
> > On Tue, 08 Mar 2022, Greg KH wrote:
> > 
> > > On Tue, Mar 08, 2022 at 08:10:06AM +0000, Lee Jones wrote:
> > > > On Mon, 07 Mar 2022, Greg KH wrote:
> > > > 
> > > > > On Mon, Mar 07, 2022 at 07:17:57PM +0000, Lee Jones wrote:
> > > > > > vhost_vsock_handle_tx_kick() already holds the mutex during its call
> > > > > > to vhost_get_vq_desc().  All we have to do here is take the same lock
> > > > > > during virtqueue clean-up and we mitigate the reported issues.
> > > > > > 
> > > > > > Also WARN() as a precautionary measure.  The purpose of this is to
> > > > > > capture possible future race conditions which may pop up over time.
> > > > > > 
> > > > > > Link: https://syzkaller.appspot.com/bug?extid=279432d30d825e63ba00
> > > > > > 
> > > > > > Cc: <stable@vger.kernel.org>
> > > > > > Reported-by: syzbot+adc3cb32385586bec859@syzkaller.appspotmail.com
> > > > > > Signed-off-by: Lee Jones <lee.jones@linaro.org>
> > > > > > ---
> > > > > >  drivers/vhost/vhost.c | 10 ++++++++++
> > > > > >  1 file changed, 10 insertions(+)
> > > > > > 
> > > > > > diff --git a/drivers/vhost/vhost.c b/drivers/vhost/vhost.c
> > > > > > index 59edb5a1ffe28..ef7e371e3e649 100644
> > > > > > --- a/drivers/vhost/vhost.c
> > > > > > +++ b/drivers/vhost/vhost.c
> > > > > > @@ -693,6 +693,15 @@ void vhost_dev_cleanup(struct vhost_dev *dev)
> > > > > >  	int i;
> > > > > >  
> > > > > >  	for (i = 0; i < dev->nvqs; ++i) {
> > > > > > +		/* No workers should run here by design. However, races have
> > > > > > +		 * previously occurred where drivers have been unable to flush
> > > > > > +		 * all work properly prior to clean-up.  Without a successful
> > > > > > +		 * flush the guest will malfunction, but avoiding host memory
> > > > > > +		 * corruption in those cases does seem preferable.
> > > > > > +		 */
> > > > > > +		WARN_ON(mutex_is_locked(&dev->vqs[i]->mutex));
> > > > > 
> > > > > So you are trading one syzbot triggered issue for another one in the
> > > > > future?  :)
> > > > > 
> > > > > If this ever can happen, handle it, but don't log it with a WARN_ON() as
> > > > > that will trigger the panic-on-warn boxes, as well as syzbot.  Unless
> > > > > you want that to happen?
> > > > 
> > > > No, Syzbot doesn't report warnings, only BUGs and memory corruption.
> > > 
> > > Has it changed?  Last I looked, it did trigger on WARN_* calls, which
> > > has resulted in a huge number of kernel fixes because of that.
> > 
> > Everything is customisable in syzkaller, so maybe there are specific
> > builds which panic_on_warn enabled, but none that I'm involved with
> > do.
> 
> Many systems run with panic-on-warn (i.e. the cloud), as they want to
> drop a box and restart it if anything goes wrong.
> 
> That's why syzbot reports on WARN_* calls.  They should never be
> reachable by userspace actions.
> 
> > Here follows a topical example.  The report above in the Link: tag
> > comes with a crashlog [0].  In there you can see the WARN() at the
> > bottom of vhost_dev_cleanup() trigger many times due to a populated
> > (non-flushed) worker list, before finally tripping the BUG() which
> > triggers the report:
> > 
> > [0] https://syzkaller.appspot.com/text?tag=CrashLog&x=16a61fce700000
> 
> Ok, so both happens here.  But don't add a warning for something that
> can't happen.  Just handle it and move on.  It looks like you are
> handling it in this code, so please drop the WARN_ON().
> 
> thanks,
> 
> greg k-h

Hmm. Well this will mean if we ever reintroduce the bug then
syzkaller will not catch it for us :( And the bug is there,
it just results in a hard to reproduce error for userspace.

Not sure what to do here. Export panic_on_warn flag to modules
and check it here?


-- 
MST

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
