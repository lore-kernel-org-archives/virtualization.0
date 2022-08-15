Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 52677C00140
	for <virtualization@archiver.kernel.org>; Mon, 15 Aug 2022 17:46:25 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id B5C1760777;
	Mon, 15 Aug 2022 17:46:24 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org B5C1760777
Authentication-Results: smtp3.osuosl.org;
	dkim=fail reason="signature verification failed" (2048-bit key, unprotected) header.d=anarazel.de header.i=@anarazel.de header.a=rsa-sha256 header.s=fm1 header.b=WWh1N78L;
	dkim=fail reason="signature verification failed" (2048-bit key, unprotected) header.d=messagingengine.com header.i=@messagingengine.com header.a=rsa-sha256 header.s=fm1 header.b=tEMDvu+R
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
	by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id tgmSRimpx3GQ; Mon, 15 Aug 2022 17:46:23 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp3.osuosl.org (Postfix) with ESMTPS id 3418C6059C;
	Mon, 15 Aug 2022 17:46:23 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 3418C6059C
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id D8D82C0033;
	Mon, 15 Aug 2022 17:46:22 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [IPv6:2605:bc80:3010::136])
 by lists.linuxfoundation.org (Postfix) with ESMTP id BE9B4C002D
 for <virtualization@lists.linux-foundation.org>;
 Mon, 15 Aug 2022 17:46:21 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id 78E2D605B3
 for <virtualization@lists.linux-foundation.org>;
 Mon, 15 Aug 2022 17:46:21 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 78E2D605B3
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id pslObCm3qogy
 for <virtualization@lists.linux-foundation.org>;
 Mon, 15 Aug 2022 17:46:20 +0000 (UTC)
X-Greylist: from auto-whitelisted by SQLgrey-1.8.0
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 995616059C
Received: from out3-smtp.messagingengine.com (out3-smtp.messagingengine.com
 [66.111.4.27])
 by smtp3.osuosl.org (Postfix) with ESMTPS id 995616059C
 for <virtualization@lists.linux-foundation.org>;
 Mon, 15 Aug 2022 17:46:20 +0000 (UTC)
Received: from compute5.internal (compute5.nyi.internal [10.202.2.45])
 by mailout.nyi.internal (Postfix) with ESMTP id 91FF25C0138;
 Mon, 15 Aug 2022 13:46:19 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
 by compute5.internal (MEProxy); Mon, 15 Aug 2022 13:46:19 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=anarazel.de; h=
 cc:cc:content-type:date:date:from:from:in-reply-to:in-reply-to
 :message-id:mime-version:references:reply-to:sender:subject
 :subject:to:to; s=fm1; t=1660585579; x=1660671979; bh=8OMR3TElBe
 6FtukCUYXb52i6A/aUd+KCr1sfP2Mcrq4=; b=WWh1N78Lr62Hl69WT1r86CNWh+
 roxkNiICEOZ7YJGTtdJZ49uTb0HJG+JMAdmUbCy8eWMufL0xmC7HkDRtwZLXNKPz
 gzSrEDzp63kP/pleU6F076KJt2zCcamtdnuytaIKqPaTo/6+n0rd6mVBYRagD+vB
 etZs+OsABrz5kX+2kzllpigxikUAKxEo68L3HqIEw2DR9P8hH6DuBE7JYqltbhXS
 Lwbvc9EQiPa1jEEUHwStQswg38TH1WaKdEnoO5GGkCPn4bk/NFw95wwCaolItbfs
 BtyCYp4Rl027xTBsqjUExhbcQRYmYGc1eygzn2x8Q5xWgtOyql9mYbWe2GaQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
 messagingengine.com; h=cc:cc:content-type:date:date:feedback-id
 :feedback-id:from:from:in-reply-to:in-reply-to:message-id
 :mime-version:references:reply-to:sender:subject:subject:to:to
 :x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
 fm1; t=1660585579; x=1660671979; bh=8OMR3TElBe6FtukCUYXb52i6A/aU
 d+KCr1sfP2Mcrq4=; b=tEMDvu+R2Aspw36NwuK6kFqZRns/mDPUG4fIwlwUQ/ID
 wCquAEfl8s9ofbcABUZAS88RihgDaBKF+aIiqXSMkXtEdaDfu42fTV2/97XquZ3b
 65Fgk7idAukoCMbQxZkN7SDn+1FdBerVJVOT/SCIgCuENHDpV+aDoiE+d9ex7zAX
 vfcs79dq2yNOBIkfSksvTzrnTuA138zyh66Rd8HmSL+/YWJSvmPMQPG1PQ2WCo+c
 DFPUMQQ9alpFTkT1DvLXQBFeRVcIhFNbFnz4MYn95zSrfwpidNRE5UZUsz9I4mN5
 rcOxRTb3FCsbdJDgafCSUanZSa+nr3K2vqkSeTu4Kg==
X-ME-Sender: <xms:aob6YpskErKBujTdU7Vc4c52RPVJf-cGl8cJZJn9kuID1oJ9SPr49w>
 <xme:aob6Yif0do-Se1xnCVnIIaSvxSacIY-waWnv6SA4iIGu3km_kNfPN-t43GfAUB0GV
 M10u8gWOYTpFLEORQ>
X-ME-Received: <xmr:aob6YsxWVdKGF816krV-BQcBHo34Mr4pIH1QtbygoH7bRbZowpMet14COJ7jN-KOnRtzoeZ8xjEXypZdOu-exrL-ei9OCW855XJVm9MeUYII6e0lQrzYdSSGIKOl>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvfedrvdehvddguddujecutefuodetggdotefrod
 ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfgh
 necuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmd
 enucfjughrpeffhffvvefukfhfgggtuggjsehttdertddttddvnecuhfhrohhmpeetnhgu
 rhgvshcuhfhrvghunhguuceorghnughrvghssegrnhgrrhgriigvlhdruggvqeenucggtf
 frrghtthgvrhhnpedvffefvefhteevffegieetfefhtddvffejvefhueetgeeludehteev
 udeitedtudenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhroh
 hmpegrnhgurhgvshesrghnrghrrgiivghlrdguvg
X-ME-Proxy: <xmx:aob6YgOpRGuCxc1zyn0zJCY9VT87O6ZLHZij6K0tXCXuzSGzP5pNHA>
 <xmx:aob6Yp9sHAGQCb3cobWp_X3g3w75bAFpOrpKZuTEN1VH1jeTpRlzsw>
 <xmx:aob6YgW2K4jSFqDTSemEWEDsZRT8j6LTsNwfDyf0lh-AFC05Dte6cg>
 <xmx:a4b6YodjWSEiH8FOhOICfT5pTGNvV6Wgc7S2VQao-RTHOqsF84jGSg>
Feedback-ID: id4a34324:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 15 Aug 2022 13:46:18 -0400 (EDT)
Date: Mon, 15 Aug 2022 10:46:17 -0700
From: Andres Freund <andres@anarazel.de>
To: "Michael S. Tsirkin" <mst@redhat.com>
Subject: Re: upstream kernel crashes
Message-ID: <20220815174617.z4chnftzcbv6frqr@awork3.anarazel.de>
References: <20220815013651.mrm7qgklk6sgpkbb@awork3.anarazel.de>
 <CAHk-=wikzU4402P-FpJRK_QwfVOS+t-3p1Wx5awGHTvr-s_0Ew@mail.gmail.com>
 <20220815071143.n2t5xsmifnigttq2@awork3.anarazel.de>
 <20220815034532-mutt-send-email-mst@kernel.org>
 <20220815081527.soikyi365azh5qpu@awork3.anarazel.de>
 <20220815042623-mutt-send-email-mst@kernel.org>
 <FCDC5DDE-3CDD-4B8A-916F-CA7D87B547CE@anarazel.de>
 <20220815113729-mutt-send-email-mst@kernel.org>
 <20220815164503.jsoezxcm6q4u2b6j@awork3.anarazel.de>
 <20220815124748-mutt-send-email-mst@kernel.org>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20220815124748-mutt-send-email-mst@kernel.org>
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

On 2022-08-15 12:50:52 -0400, Michael S. Tsirkin wrote:
> On Mon, Aug 15, 2022 at 09:45:03AM -0700, Andres Freund wrote:
> > Hi,
> > 
> > On 2022-08-15 11:40:59 -0400, Michael S. Tsirkin wrote:
> > > OK so this gives us a quick revert as a solution for now.
> > > Next, I would appreciate it if you just try this simple hack.
> > > If it crashes we either have a long standing problem in virtio
> > > code or more likely a gcp bug where it can't handle smaller
> > > rings than what device requestes.
> > > Thanks!
> > 
> > I applied the below and the problem persists.
> > 
> > [...]
>
> Okay!

Just checking - I applied and tested this atop 6.0-rc1, correct? Or did you
want me to test it with the 762faee5a267 reverted? I guess what you're trying
to test if a smaller queue than what's requested you'd want to do so without
the problematic patch applied...


> And just to be 100% sure, can you try the following on top of 5.19:

> diff --git a/drivers/virtio/virtio_pci_modern.c b/drivers/virtio/virtio_pci_modern.c
> index 623906b4996c..6f4e54a618bc 100644
> --- a/drivers/virtio/virtio_pci_modern.c
> +++ b/drivers/virtio/virtio_pci_modern.c
> @@ -208,6 +208,9 @@ static struct virtqueue *setup_vq(struct virtio_pci_device *vp_dev,
>  		return ERR_PTR(-EINVAL);
>  	}
>  
> +	if (num > 1024)
> +		num = 1024;
> +
>  	info->msix_vector = msix_vec;
>  
>  	/* create the vring */
> 
> -- 

Either way, I did this, and there are no issues that I could observe. No
oopses, no broken networking. But:

To make sure it does something I added a debugging printk - which doesn't show
up. I assume this is at a point at least earlyprintk should work (which I see
getting enabled via serial)?

Greetings,

Andres Freund
_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
