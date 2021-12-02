Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 890A7C433F5
	for <virtualization@archiver.kernel.org>; Thu,  2 Dec 2021 15:34:43 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp2.osuosl.org (Postfix) with ESMTP id 2469840A2D;
	Thu,  2 Dec 2021 15:34:43 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
	by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id if1WTq6I5rcH; Thu,  2 Dec 2021 15:34:42 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp2.osuosl.org (Postfix) with ESMTPS id 98A3640A2A;
	Thu,  2 Dec 2021 15:34:41 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 70A4FC001C;
	Thu,  2 Dec 2021 15:34:41 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by lists.linuxfoundation.org (Postfix) with ESMTP id DFB0FC000A
 for <virtualization@lists.linux-foundation.org>;
 Thu,  2 Dec 2021 15:34:40 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id C0A7240A2B
 for <virtualization@lists.linux-foundation.org>;
 Thu,  2 Dec 2021 15:34:40 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id KxE_vJsADUd2
 for <virtualization@lists.linux-foundation.org>;
 Thu,  2 Dec 2021 15:34:40 +0000 (UTC)
X-Greylist: from auto-whitelisted by SQLgrey-1.8.0
Received: from smtp1.axis.com (smtp1.axis.com [195.60.68.17])
 by smtp2.osuosl.org (Postfix) with ESMTPS id A3ED940A2A
 for <virtualization@lists.linux-foundation.org>;
 Thu,  2 Dec 2021 15:34:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=axis.com; q=dns/txt; s=axis-central1; t=1638459280;
 x=1669995280; h=date:from:to:cc:subject:message-id:references:
 mime-version:in-reply-to;
 bh=Yri/mS7tORGYp9z6BnOGZR6MCtrucp5Fel5TYmUSo+s=;
 b=Q8QJVggcObrecVvMHa+qucsRXEIgUt1xYvo8Dz4cKXe6W7KeL/A/OUkD
 Koiu6b3i+YD1+j3XDQBToFvshWp6pyStZY9oNCqR+x7uHho7oNONT0WIx
 FY3VuWmO/NxsrtFxZ3xjoOHcCD+mR1pE8fnui5CkuOJIEH0QdA4ZFMQ4J
 By6/mZiYMgwv+a3Z8cL07gDSFAaUnPd+7Y/76H1yqhel43TriBx2qGvXO
 Xn0rLxAuA8WdklM3pPt5/xN4hF0MpAEz3hyz5lsAVjM36QCvpw+dfmVPy
 Cp8vLE1EFd7g2GS8gDCmKRAwkVmxGqSNBpTTFwvBo1mLJutyBKJYZt/ed Q==;
Date: Thu, 2 Dec 2021 16:34:37 +0100
From: Vincent Whitchurch <vincent.whitchurch@axis.com>
To: "Michael S. Tsirkin" <mst@redhat.com>
Subject: Re: [PATCH v2 2/2] i2c: virtio: fix completion handling
Message-ID: <20211202153436.GA11644@axis.com>
References: <20211111160412.11980-1-vincent.whitchurch@axis.com>
 <20211111160412.11980-3-vincent.whitchurch@axis.com>
 <20211111114630-mutt-send-email-mst@kernel.org>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20211111114630-mutt-send-email-mst@kernel.org>
User-Agent: Mutt/1.10.1 (2018-07-13)
Cc: "viresh.kumar@linaro.org" <viresh.kumar@linaro.org>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
 "virtualization@lists.linux-foundation.org"
 <virtualization@lists.linux-foundation.org>, "wsa@kernel.org" <wsa@kernel.org>,
 kernel <kernel@axis.com>,
 "linux-i2c@vger.kernel.org" <linux-i2c@vger.kernel.org>,
 "conghui.chen@intel.com" <conghui.chen@intel.com>
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

On Thu, Nov 11, 2021 at 05:57:30PM +0100, Michael S. Tsirkin wrote:
> On Thu, Nov 11, 2021 at 05:04:12PM +0100, Vincent Whitchurch wrote:
> > -	wait_for_completion(&vi->completion);
> > +	/*
> > +	 * We only need to wait for the last one since the device is required
> > +	 * to complete requests in order.
> > +	 */
> 
> Hmm the spec only says:
> 
>     A device MUST guarantee the requests in the virtqueue being processed in order
>     if multiple requests are received at a time.
> 
> it does not seem to require using the buffers in order.
> In any case, just waiting for all of them in a loop
> seems cleaner and likely won't take longer ...

Thank you, I've fixed this in v3.
_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
