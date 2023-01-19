Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 885BDC00A5A
	for <virtualization@archiver.kernel.org>; Thu, 19 Jan 2023 15:22:21 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id BD10260AD8;
	Thu, 19 Jan 2023 15:22:16 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org BD10260AD8
Authentication-Results: smtp3.osuosl.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.a=rsa-sha256 header.s=korg header.b=i0Cwq+LO
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
	by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id z7xa3DH92JXk; Thu, 19 Jan 2023 15:22:15 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp3.osuosl.org (Postfix) with ESMTPS id 399C96117D;
	Thu, 19 Jan 2023 15:22:15 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 399C96117D
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 12825C0032;
	Thu, 19 Jan 2023 15:22:15 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [IPv6:2605:bc80:3010::137])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 4A281C002D
 for <virtualization@lists.linux-foundation.org>;
 Thu, 19 Jan 2023 15:22:14 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id 13E0641896
 for <virtualization@lists.linux-foundation.org>;
 Thu, 19 Jan 2023 15:22:14 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org 13E0641896
Authentication-Results: smtp4.osuosl.org;
 dkim=pass (1024-bit key) header.d=linuxfoundation.org
 header.i=@linuxfoundation.org header.a=rsa-sha256 header.s=korg
 header.b=i0Cwq+LO
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id hIoGMYzFk_pM
 for <virtualization@lists.linux-foundation.org>;
 Thu, 19 Jan 2023 15:22:13 +0000 (UTC)
X-Greylist: from auto-whitelisted by SQLgrey-1.8.0
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org 51D4B41872
Received: from dfw.source.kernel.org (dfw.source.kernel.org
 [IPv6:2604:1380:4641:c500::1])
 by smtp4.osuosl.org (Postfix) with ESMTPS id 51D4B41872
 for <virtualization@lists.linux-foundation.org>;
 Thu, 19 Jan 2023 15:22:13 +0000 (UTC)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by dfw.source.kernel.org (Postfix) with ESMTPS id A1BAD61C43;
 Thu, 19 Jan 2023 15:22:12 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B8BA7C433D2;
 Thu, 19 Jan 2023 15:22:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
 s=korg; t=1674141732;
 bh=fuaHiayN9/WGnI4UfXAsrYe5slppaGLjht5c//g5Dao=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=i0Cwq+LOB2ZsI2hwk9upoYclocTwEPiJXd2t4U7E034fADlivKkFPR3aksHSRAI6e
 HR6fo+kAN5RWQOyuXXw6habE8janoQhrKiCphNxJQQG17F0jnHFEWFTeduqOVaiIJu
 WG5pS1WVRiTFES4AG3EiCCT7XiT/+MveLG6dM5Ns=
Date: Thu, 19 Jan 2023 16:22:09 +0100
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: Alexander Shishkin <alexander.shishkin@linux.intel.com>
Subject: Re: [PATCH v1 4/6] virtio console: Harden control message handling
Message-ID: <Y8lgIS+jygB7SGrn@kroah.com>
References: <20230119135721.83345-1-alexander.shishkin@linux.intel.com>
 <20230119135721.83345-5-alexander.shishkin@linux.intel.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20230119135721.83345-5-alexander.shishkin@linux.intel.com>
Cc: Arnd Bergmann <arnd@arndb.de>, mst@redhat.com, Amit Shah <amit@kernel.org>,
 linux-kernel@vger.kernel.org, virtualization@lists.linux-foundation.org,
 elena.reshetova@intel.com, kirill.shutemov@linux.intel.com
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

On Thu, Jan 19, 2023 at 03:57:19PM +0200, Alexander Shishkin wrote:
> In handle_control_message(), we look at the ->event field twice, which
> gives a malicious VMM a window in which to switch it from PORT_ADD to
> PORT_REMOVE, triggering a null dereference further down the line:

How is the other VMM have full control over the full message here?
Shouldn't this all have been copied into our local memory if we are
going to be poking around in it?  Like I mentioned in my other review,
copy it all once and then parse it.  Don't try to mess with individual
fields one at a time otherwise that way lies madness...

thanks,

greg k-h
_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
