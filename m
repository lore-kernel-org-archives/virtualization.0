Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1C951C00140
	for <virtualization@archiver.kernel.org>; Mon, 15 Aug 2022 21:46:15 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 81E3040442;
	Mon, 15 Aug 2022 21:46:14 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org 81E3040442
Authentication-Results: smtp4.osuosl.org;
	dkim=fail reason="signature verification failed" (2048-bit key, unprotected) header.d=anarazel.de header.i=@anarazel.de header.a=rsa-sha256 header.s=fm1 header.b=wJ/HZdYg;
	dkim=fail reason="signature verification failed" (2048-bit key, unprotected) header.d=messagingengine.com header.i=@messagingengine.com header.a=rsa-sha256 header.s=fm1 header.b=2ZXCvA9c
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
	by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id G5V2H-0aJ9e2; Mon, 15 Aug 2022 21:46:13 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp4.osuosl.org (Postfix) with ESMTPS id 9D58540327;
	Mon, 15 Aug 2022 21:46:12 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org 9D58540327
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 57054C0033;
	Mon, 15 Aug 2022 21:46:12 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by lists.linuxfoundation.org (Postfix) with ESMTP id B88C5C002D
 for <virtualization@lists.linux-foundation.org>;
 Mon, 15 Aug 2022 21:46:10 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id 96DB440359
 for <virtualization@lists.linux-foundation.org>;
 Mon, 15 Aug 2022 21:46:10 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org 96DB440359
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id enP_RCZQeyrW
 for <virtualization@lists.linux-foundation.org>;
 Mon, 15 Aug 2022 21:46:09 +0000 (UTC)
X-Greylist: from auto-whitelisted by SQLgrey-1.8.0
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org 7E79340327
Received: from wout1-smtp.messagingengine.com (wout1-smtp.messagingengine.com
 [64.147.123.24])
 by smtp4.osuosl.org (Postfix) with ESMTPS id 7E79340327
 for <virtualization@lists.linux-foundation.org>;
 Mon, 15 Aug 2022 21:46:09 +0000 (UTC)
Received: from compute4.internal (compute4.nyi.internal [10.202.2.44])
 by mailout.west.internal (Postfix) with ESMTP id 330E732007D7;
 Mon, 15 Aug 2022 17:46:07 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
 by compute4.internal (MEProxy); Mon, 15 Aug 2022 17:46:08 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=anarazel.de; h=
 cc:cc:content-type:date:date:from:from:in-reply-to:in-reply-to
 :message-id:mime-version:references:reply-to:sender:subject
 :subject:to:to; s=fm1; t=1660599966; x=1660686366; bh=5/0EPvXdhP
 ro0zKMiqEkonkJvXb/I1AzuGUyP3JQyBI=; b=wJ/HZdYgs0p31ThNXOV8mrGlLT
 Vk46kz9Qn76RQBJzxbUmYaB3E3ZuFVum/Aqm5qZUlDxu34pekRNIs9XqDYRYsXl5
 FWnt+zCgIAOJIGM8yhRqajjLNRIZs68RJDKBBmavTEHypZ3LrHm/6hynZ9xTMP6L
 TNOl8VuBLUW7QfBjmxLY1bUeD4sj+Otzjiy2j2UtN0gWx7yCaXWRj1Q9ea/suKRr
 i45PrJFOYLwtEO70Hxp0PkBU+n110TSBesNUmW6Q+GcZD0+NGBfPM1Lkwv1lUcrF
 UJTcw4dNWgNDgitrR6KZeHIqLOYqT9dLGK/PFOlm4d5r2luvcVzy/O4gTqmw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
 messagingengine.com; h=cc:cc:content-type:date:date:feedback-id
 :feedback-id:from:from:in-reply-to:in-reply-to:message-id
 :mime-version:references:reply-to:sender:subject:subject:to:to
 :x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
 fm1; t=1660599966; x=1660686366; bh=5/0EPvXdhPro0zKMiqEkonkJvXb/
 I1AzuGUyP3JQyBI=; b=2ZXCvA9cimntn1UjjHMB0r0MlvpOfOOtHRF5pcIaI81T
 mdTJA6vLOYPQM6eL69Kq7ZrFUhQmM8qPZ2ldvDMpyOwzUP+2vCOikQDugdVuRb/K
 pPBPc5U2su3eZoqmIEjJoM2btRPfAeIy864LeQ1D9rhxgWem0JvESurBZN/D3eD+
 IlT1IvcztrdJDrhSkHY8OlPVXV02IwYwk2AiBKpMXflEiwhQ22s1SxW2gB++os7B
 Icohgq8CUp3Ypigl5Omf0Se3QD24c5B4DZ0MvLzvm5zRZbCuY1bRKYZt/kIuNEH/
 sSkIoFePwmLMd0HOnlArTvKFJlHCfNbvyGXSNY2rdA==
X-ME-Sender: <xms:nb76Yv0Ej_z_uM_wN3B_P_R3ltOfeO2C8sGBtIuh29Zc_4lFpEvSDw>
 <xme:nb76YuGJkk7QBkz5kLgrEN5S4OJ8ssQK3Ly2IV2RLuJyqfrclNP7vLJyHnLQmnuSN
 sFj2Dtf4BWj03uncA>
X-ME-Received: <xmr:nb76Yv4yEU20_iu9UQ3pOzsS8VZdfTPLdbpzNJK1NfMSFmLq2SchkjeCfKMsQ0R5QFLwBsENaGicY9hIZPI77-KYqmmsE03A2ds4LP_mNbh27kyAwhUSYlokYwB0>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvfedrvdehfedgtdefucetufdoteggodetrfdotf
 fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
 uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
 cujfgurhepfffhvfevuffkfhggtggujgesthdtredttddtvdenucfhrhhomheptehnughr
 vghsucfhrhgvuhhnugcuoegrnhgurhgvshesrghnrghrrgiivghlrdguvgeqnecuggftrf
 grthhtvghrnhepvdfffeevhfetveffgeeiteefhfdtvdffjeevhfeuteegleduheetvedu
 ieettddunecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomh
 eprghnughrvghssegrnhgrrhgriigvlhdruggv
X-ME-Proxy: <xmx:nb76Yk1WLs_gY1IYxKa9HCfxP1WZQGDwJuW8-uJfX6mcviCw_oXBTQ>
 <xmx:nb76YiGxg2k9yNZr3I-NuiFVrR-7qWSkqLVqj3TFJwEPTe17kdgAnA>
 <xmx:nb76Yl-tiKe5RZYevmY2_0IdTNT3c5Rx2X5TGOj8Tou6sOHIO93XsQ>
 <xmx:nr76YgHpauIZlhEd-lIjWIXnPExykmUPz133PNZHrrtpg7Di_j3q_g>
Feedback-ID: id4a34324:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 15 Aug 2022 17:46:05 -0400 (EDT)
Date: Mon, 15 Aug 2022 14:46:04 -0700
From: Andres Freund <andres@anarazel.de>
To: "Michael S. Tsirkin" <mst@redhat.com>
Subject: Re: [PATCH] virtio_net: Revert "virtio_net: set the default max ring
 size by find_vqs()"
Message-ID: <20220815214604.x7g342h3oadruxx2@awork3.anarazel.de>
References: <20220815090521.127607-1-mst@redhat.com>
 <20220815203426.GA509309@roeck-us.net>
 <20220815164013-mutt-send-email-mst@kernel.org>
 <20220815205053.GD509309@roeck-us.net>
 <20220815165608-mutt-send-email-mst@kernel.org>
 <20220815212839.aop6wwx4fkngihbf@awork3.anarazel.de>
 <20220815173256-mutt-send-email-mst@kernel.org>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20220815173256-mutt-send-email-mst@kernel.org>
Cc: Jens Axboe <axboe@kernel.dk>,
 "Martin K. Petersen" <martin.petersen@oracle.com>, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org, virtualization@lists.linux-foundation.org,
 James Bottomley <James.Bottomley@hansenpartnership.com>,
 Eric Dumazet <edumazet@google.com>, Greg KH <gregkh@linuxfoundation.org>,
 c@redhat.com, Jakub Kicinski <kuba@kernel.org>,
 Paolo Abeni <pabeni@redhat.com>,
 Linus Torvalds <torvalds@linux-foundation.org>,
 "David S. Miller" <davem@davemloft.net>, Guenter Roeck <linux@roeck-us.net>
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

Hi,

On 2022-08-15 17:39:08 -0400, Michael S. Tsirkin wrote:
> On Mon, Aug 15, 2022 at 02:28:39PM -0700, Andres Freund wrote:
> > On 2022-08-15 17:04:10 -0400, Michael S. Tsirkin wrote:
> > > So virtio has a queue_size register. When read, it will give you
> > > originally the maximum queue size. Normally we just read it and
> > > use it as queue size.
> > > 
> > > However, when queue memory allocation fails, and unconditionally with a
> > > network device with the problematic patch, driver is asking the
> > > hypervisor to make the ring smaller by writing a smaller value into this
> > > register.
> > > 
> > > I suspect that what happens is hypervisor still uses the original value
> > > somewhere.
> > 
> > It looks more like the host is never told about the changed size for legacy
> > devices...
> > 
> > Indeed, adding a vp_legacy_set_queue_size() & call to it to setup_vq(), makes
> > 5.19 + restricting queue sizes to 1024 boot again.
> 
> Interesting, the register is RO in the legacy interface.
> And to be frank I can't find where is vp_legacy_set_queue_size
> even implemented. It's midnight here too ...

Yea, I meant that added both vp_legacy_set_queue_size() and a call to it. I
was just quickly experimenting around.


> Yes I figured this out too. And I was able to reproduce on qemu now.

Cool.


> I'm posting a new patchset reverting all the handing of resize
> restrictions, I think we should rethink it for the next release.

Makes sense.

Greetings,

Andres Freund
_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
