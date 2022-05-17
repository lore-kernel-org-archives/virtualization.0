Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B58A9C433F5
	for <virtualization@archiver.kernel.org>; Tue, 17 May 2022 22:18:29 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 6647E607F2;
	Tue, 17 May 2022 22:18:29 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
	by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id qla9NGUc22xu; Tue, 17 May 2022 22:18:28 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp3.osuosl.org (Postfix) with ESMTPS id 1837260B8E;
	Tue, 17 May 2022 22:18:28 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id C3752C0039;
	Tue, 17 May 2022 22:18:27 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 3E53EC002D
 for <virtualization@lists.linux-foundation.org>;
 Tue, 17 May 2022 22:18:26 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id 16F9460B8E
 for <virtualization@lists.linux-foundation.org>;
 Tue, 17 May 2022 22:18:26 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id 7rcyHWd46K_n
 for <virtualization@lists.linux-foundation.org>;
 Tue, 17 May 2022 22:18:25 +0000 (UTC)
X-Greylist: delayed 00:18:18 by SQLgrey-1.8.0
Received: from zeniv-ca.linux.org.uk (zeniv-ca.linux.org.uk
 [IPv6:2607:5300:60:148a::1])
 by smtp3.osuosl.org (Postfix) with ESMTPS id 62F82607F2
 for <virtualization@lists.linux-foundation.org>;
 Tue, 17 May 2022 22:18:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=linux.org.uk; s=zeniv-20220401; h=Sender:In-Reply-To:Content-Type:
 MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
 Content-Transfer-Encoding:Content-ID:Content-Description;
 bh=ibGwroDx09LXcS70EId5UHxTm6Oqg5cS0xsZINUY8tQ=; b=X4E04QpuQIJtMamOPaVopY9r2w
 JOpVM995u3wjGau8dpV2dU9Swn7Ae0BIwm/GgQSodLAvwswzX5QT3lQt7WJk6xKY5mGpNl7fRC0GF
 D5Ly1Y5zwssdjxTyHtllO9NCGuvmfjH2pqedB2A3RXNX3BULb8n0wDUdawDlfs6K/6YKw5CS0kInQ
 Wf88wo29mqRBL1xCRIAxDCMGru1U3aEp+OK7/qgXcx+1S0ahVX9akTQdQU2O8G6kSKwfxrk35GnO9
 YOOeHtqKfmIdh5+biiP/h0Y7d0/cILsDvNyX6te9TUYUQgor+VcNZ0LwS0+7ddvFfhxZL401jjqUl
 B0tbPnFQ==;
Received: from viro by zeniv-ca.linux.org.uk with local (Exim 4.94.2 #2 (Red
 Hat Linux)) id 1nr5EZ-00FqYE-7Q; Tue, 17 May 2022 22:00:03 +0000
Date: Tue, 17 May 2022 22:00:03 +0000
From: Al Viro <viro@zeniv.linux.org.uk>
To: "Michael S. Tsirkin" <mst@redhat.com>
Subject: Re: [PATCH] vhost_net: fix double fget()
Message-ID: <YoQa4wzy9jSwDY7E@zeniv-ca.linux.org.uk>
References: <20220516084213.26854-1-jasowang@redhat.com>
 <20220516044400-mutt-send-email-mst@kernel.org>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20220516044400-mutt-send-email-mst@kernel.org>
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

On Mon, May 16, 2022 at 04:44:19AM -0400, Michael S. Tsirkin wrote:
> > Signed-off-by: Al Viro <viro@zeniv.linux.org.uk>
> > Signed-off-by: Jason Wang <jasowang@redhat.com>
> 
> Acked-by: Michael S. Tsirkin <mst@redhat.com>
> 
> and this is stable material I guess.

It is, except that commit message ought to be cleaned up.  Something
along the lines of

----
Fix double fget() in vhost_net_set_backend()

Descriptor table is a shared resource; two fget() on the same descriptor
may return different struct file references.  get_tap_ptr_ring() is
called after we'd found (and pinned) the socket we'll be using and it
tries to find the private tun/tap data structures associated with it.
Redoing the lookup by the same file descriptor we'd used to get the
socket is racy - we need to same struct file.

Thanks to Jason for spotting a braino in the original variant of patch -
I'd missed the use of fd == -1 for disabling backend, and in that case
we can end up with sock == NULL and sock != oldsock.
----

Does the above sound sane for commit message?  And which tree would you
prefer it to go through?  I can take it in vfs.git#fixes, or you could
take it into your tree...
_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
