Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7BE45E95A82
	for <virtualization@archiver.kernel.org>; Sun,  8 Oct 2023 06:46:57 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp2.osuosl.org (Postfix) with ESMTP id 1868C4053D;
	Sun,  8 Oct 2023 06:46:57 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org 1868C4053D
Authentication-Results: smtp2.osuosl.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.a=rsa-sha256 header.s=korg header.b=tLDlmCgD
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
	by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id q7Q1D1gzQiTu; Sun,  8 Oct 2023 06:46:56 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp2.osuosl.org (Postfix) with ESMTPS id 902FA4010F;
	Sun,  8 Oct 2023 06:46:55 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org 902FA4010F
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 5FA25C0039;
	Sun,  8 Oct 2023 06:46:55 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [IPv6:2605:bc80:3010::137])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 51049C0032
 for <virtualization@lists.linux-foundation.org>;
 Sun,  8 Oct 2023 06:46:54 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id 2458141B40
 for <virtualization@lists.linux-foundation.org>;
 Sun,  8 Oct 2023 06:46:54 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org 2458141B40
Authentication-Results: smtp4.osuosl.org;
 dkim=pass (1024-bit key) header.d=linuxfoundation.org
 header.i=@linuxfoundation.org header.a=rsa-sha256 header.s=korg
 header.b=tLDlmCgD
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id twpM1l8ujVfY
 for <virtualization@lists.linux-foundation.org>;
 Sun,  8 Oct 2023 06:46:51 +0000 (UTC)
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
 by smtp4.osuosl.org (Postfix) with ESMTPS id 326DB4191D
 for <virtualization@lists.linux-foundation.org>;
 Sun,  8 Oct 2023 06:46:51 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org 326DB4191D
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
 by ams.source.kernel.org (Postfix) with ESMTP id 66068B80AC8;
 Sun,  8 Oct 2023 06:46:49 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3D7BCC433C7;
 Sun,  8 Oct 2023 06:46:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
 s=korg; t=1696747608;
 bh=2PSVpIisCW6kYciUK31EhFOKMSdB/e5LOFm6jHd7F00=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=tLDlmCgDeD5aHDaUSV5KmcrCwR3A77ER9chgFuwiXKuTG6DZR9+tOZIqlGVSkc1OZ
 JuevLVdwgug2RDJpifYubQwd6kQNQOJQPvyIWN+9Q1HLClDkfYawC3oxpIbLnDu9f6
 tI3eO4/rxObzAxZ/sDPrxH+M/rROHx9U/g32uucs=
Date: Sun, 8 Oct 2023 08:46:45 +0200
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: "Michael S. Tsirkin" <mst@redhat.com>
Subject: Re: [PATCH] vduse: make vduse_class constant
Message-ID: <2023100835-driver-disrupt-9ea0@gregkh>
References: <2023100643-tricolor-citizen-6c2d@gregkh>
 <20231008022022-mutt-send-email-mst@kernel.org>
 <2023100823-absurd-imitation-092d@gregkh>
 <20231008024039-mutt-send-email-mst@kernel.org>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20231008024039-mutt-send-email-mst@kernel.org>
Cc: Xuan Zhuo <xuanzhuo@linux.alibaba.com>,
 Xie Yongji <xieyongji@bytedance.com>, linux-kernel@vger.kernel.org,
 virtualization@lists.linux-foundation.org
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

On Sun, Oct 08, 2023 at 02:41:22AM -0400, Michael S. Tsirkin wrote:
> On Sun, Oct 08, 2023 at 08:40:05AM +0200, Greg Kroah-Hartman wrote:
> > On Sun, Oct 08, 2023 at 02:20:52AM -0400, Michael S. Tsirkin wrote:
> > > On Fri, Oct 06, 2023 at 04:30:44PM +0200, Greg Kroah-Hartman wrote:
> > > > Now that the driver core allows for struct class to be in read-only
> > > > memory, we should make all 'class' structures declared at build time
> > > > placing them into read-only memory, instead of having to be dynamically
> > > > allocated at runtime.
> > > > 
> > > > Cc: "Michael S. Tsirkin" <mst@redhat.com>
> > > > Cc: Jason Wang <jasowang@redhat.com>
> > > > Cc: Xuan Zhuo <xuanzhuo@linux.alibaba.com>
> > > > Cc: Xie Yongji <xieyongji@bytedance.com>
> > > > Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
> > > 
> > > Acked-by: Michael S. Tsirkin <mst@redhat.com>
> > > 
> > > Greg should I merge it or do you intend to merge all these patches?
> > 
> > "all"?  There's loads of them for all sorts of subsystems, so feel free
> > to take it through your subsystem tree if you want.  I usually scoop up
> > the ones that no one picks after a release and take them through my
> > tree, to pick up the stragglers.
> > 
> > So it's your call, whatever is easier for you is fine for me.
> > 
> > thanks,
> > 
> > greg k-h
> 
> To clarify which commit does this depend on?

The 6.4 kernel release :)
_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
