Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9BBE1C433F5
	for <virtualization@archiver.kernel.org>; Wed, 18 May 2022 05:23:14 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 34C436111F;
	Wed, 18 May 2022 05:23:14 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
	by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id 8gVye5EViU2A; Wed, 18 May 2022 05:23:11 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp3.osuosl.org (Postfix) with ESMTPS id 2B72D60C07;
	Wed, 18 May 2022 05:23:11 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id F220DC0032;
	Wed, 18 May 2022 05:23:10 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [IPv6:2605:bc80:3010::137])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 19B96C002D
 for <virtualization@lists.linux-foundation.org>;
 Wed, 18 May 2022 05:23:09 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id 0089041826
 for <virtualization@lists.linux-foundation.org>;
 Wed, 18 May 2022 05:23:09 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp4.osuosl.org (amavisd-new);
 dkim=pass (1024-bit key) header.d=redhat.com
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id nKwz4FDVvsAm
 for <virtualization@lists.linux-foundation.org>;
 Wed, 18 May 2022 05:23:05 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.129.124])
 by smtp4.osuosl.org (Postfix) with ESMTPS id 20A54417EF
 for <virtualization@lists.linux-foundation.org>;
 Wed, 18 May 2022 05:23:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1652851383;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=s5aF1SwBsINrQMkQK6jj8/AJIyTgJ8TbouQ8o7y74Qw=;
 b=F3dOS0iQ0uybyE7AAYDh9dCvBIIdRzZvRn8n6CwzlGeFb2jlggX/+Ypt5k9awCaM2XfOwS
 Jeo6cgdhUSpcd2/d+xqJrHmT3GQrxpxwPSHrKpXPIaUyujgT21hKH0lymBunHooRD91ZLI
 t/QgmPiqYyU8XAedpofJhwkeN9TDd8Y=
Received: from mail-ed1-f72.google.com (mail-ed1-f72.google.com
 [209.85.208.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-517-YRtfm7DaNFe6ZakrKqVmOA-1; Wed, 18 May 2022 01:23:02 -0400
X-MC-Unique: YRtfm7DaNFe6ZakrKqVmOA-1
Received: by mail-ed1-f72.google.com with SMTP id
 ay24-20020a056402203800b0042a96a76ba5so831325edb.20
 for <virtualization@lists.linux-foundation.org>;
 Tue, 17 May 2022 22:23:02 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to;
 bh=s5aF1SwBsINrQMkQK6jj8/AJIyTgJ8TbouQ8o7y74Qw=;
 b=L+K6S8aaX44oTsiSwdbj2vU26xkN1y5FE+ITtxOKiO6cp1RzFyaySj1ysyQuPcYnUy
 ZxEKawFDqybBC+uvEDpxfKNH9n+hpwV10/pOYc0wbI1NlWj0R3pRK1hcwYdhBmks4Gf+
 WHu2BP6QBsTB3Qxg9+TlcXyox1rjOcV0pHAzfPHcB+ZdQiwhnX1HuVa2ueiH9G5dYEIz
 msbIg96M/AThJ6Ce7Krf6kZaPO2hcYo/2nt5ipuw16stHBLpYDEY/MLTl4QnZ/2KsZYi
 Zf1bMjZo5dsPcBwnK3S5JWQkKc3+d5uTgBsKv4tl7FoQTjs+AjFgqst8beFdkYWsKlfj
 IEsQ==
X-Gm-Message-State: AOAM533GvCDkkzmakO9Av/Mcq2JXR6wqw2iGm7Ht+2Zuh5+39wXwav6V
 cTyXZS/7KW61aCRRIOj14CP+GqBrPBO3Iy+OTV/MepHdJ9uY8vt2Jhf+MdS1uSPOWl/Q0Ks8in3
 aC7cwlgfqjohUhiRCt8pXID/Pbytaa4Njq7YiLZmfWA==
X-Received: by 2002:aa7:cd87:0:b0:427:f800:220d with SMTP id
 x7-20020aa7cd87000000b00427f800220dmr23052121edv.112.1652851381423; 
 Tue, 17 May 2022 22:23:01 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJwrTT0RINL0V+teBiwef2JunFlgvMj8o5XGCORUKJ0vEF3/8oynflK7QSDzhoZBgKLTc3+BTA==
X-Received: by 2002:aa7:cd87:0:b0:427:f800:220d with SMTP id
 x7-20020aa7cd87000000b00427f800220dmr23052110edv.112.1652851381223; 
 Tue, 17 May 2022 22:23:01 -0700 (PDT)
Received: from redhat.com ([109.253.208.62]) by smtp.gmail.com with ESMTPSA id
 ay18-20020a056402203200b0042aa08c7799sm712321edb.62.2022.05.17.22.22.57
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 17 May 2022 22:23:00 -0700 (PDT)
Date: Wed, 18 May 2022 01:22:55 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Al Viro <viro@zeniv.linux.org.uk>
Subject: Re: [PATCH] vhost_net: fix double fget()
Message-ID: <20220518012236-mutt-send-email-mst@kernel.org>
References: <20220516084213.26854-1-jasowang@redhat.com>
 <20220516044400-mutt-send-email-mst@kernel.org>
 <YoQa4wzy9jSwDY7E@zeniv-ca.linux.org.uk>
MIME-Version: 1.0
In-Reply-To: <YoQa4wzy9jSwDY7E@zeniv-ca.linux.org.uk>
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=mst@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Disposition: inline
Cc: kvm@vger.kernel.org, netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
 virtualization@lists.linux-foundation.org, ebiggers@kernel.org,
 linux-fsdevel@vger.kernel.org, davem@davemloft.net
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

On Tue, May 17, 2022 at 10:00:03PM +0000, Al Viro wrote:
> On Mon, May 16, 2022 at 04:44:19AM -0400, Michael S. Tsirkin wrote:
> > > Signed-off-by: Al Viro <viro@zeniv.linux.org.uk>
> > > Signed-off-by: Jason Wang <jasowang@redhat.com>
> > 
> > Acked-by: Michael S. Tsirkin <mst@redhat.com>
> > 
> > and this is stable material I guess.
> 
> It is, except that commit message ought to be cleaned up.  Something
> along the lines of
> 
> ----
> Fix double fget() in vhost_net_set_backend()
> 
> Descriptor table is a shared resource; two fget() on the same descriptor
> may return different struct file references.  get_tap_ptr_ring() is
> called after we'd found (and pinned) the socket we'll be using and it
> tries to find the private tun/tap data structures associated with it.
> Redoing the lookup by the same file descriptor we'd used to get the
> socket is racy - we need to same struct file.
> 
> Thanks to Jason for spotting a braino in the original variant of patch -
> I'd missed the use of fd == -1 for disabling backend, and in that case
> we can end up with sock == NULL and sock != oldsock.
> ----
> 
> Does the above sound sane for commit message?  And which tree would you
> prefer it to go through?  I can take it in vfs.git#fixes, or you could
> take it into your tree...

Acked-by: Michael S. Tsirkin <mst@redhat.com>
for the new message and merging through your tree.

-- 
MST

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
