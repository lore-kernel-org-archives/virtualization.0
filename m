Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id ADB30C25B06
	for <virtualization@archiver.kernel.org>; Sun, 14 Aug 2022 03:52:52 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 222B883F89;
	Sun, 14 Aug 2022 03:52:52 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 222B883F89
Authentication-Results: smtp1.osuosl.org;
	dkim=fail reason="signature verification failed" (2048-bit key, unprotected) header.d=anarazel.de header.i=@anarazel.de header.a=rsa-sha256 header.s=fm1 header.b=VkCNbD74;
	dkim=fail reason="signature verification failed" (2048-bit key, unprotected) header.d=messagingengine.com header.i=@messagingengine.com header.a=rsa-sha256 header.s=fm1 header.b=28wb70dX
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
	by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id 7GmtZcLFAB6k; Sun, 14 Aug 2022 03:52:51 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp1.osuosl.org (Postfix) with ESMTPS id 87AEB83F87;
	Sun, 14 Aug 2022 03:52:50 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 87AEB83F87
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 53F88C0033;
	Sun, 14 Aug 2022 03:52:50 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [IPv6:2605:bc80:3010::133])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 6A0C8C002D
 for <virtualization@lists.linux-foundation.org>;
 Sun, 14 Aug 2022 03:52:48 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id 266BD404B1
 for <virtualization@lists.linux-foundation.org>;
 Sun, 14 Aug 2022 03:52:48 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org 266BD404B1
Authentication-Results: smtp2.osuosl.org;
 dkim=pass (2048-bit key, unprotected) header.d=anarazel.de
 header.i=@anarazel.de header.a=rsa-sha256 header.s=fm1 header.b=VkCNbD74; 
 dkim=pass (2048-bit key,
 unprotected) header.d=messagingengine.com header.i=@messagingengine.com
 header.a=rsa-sha256 header.s=fm1 header.b=28wb70dX
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id zZiUlxwPfpKt
 for <virtualization@lists.linux-foundation.org>;
 Sun, 14 Aug 2022 03:52:47 +0000 (UTC)
X-Greylist: from auto-whitelisted by SQLgrey-1.8.0
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org D8D1F404A8
Received: from out1-smtp.messagingengine.com (out1-smtp.messagingengine.com
 [66.111.4.25])
 by smtp2.osuosl.org (Postfix) with ESMTPS id D8D1F404A8
 for <virtualization@lists.linux-foundation.org>;
 Sun, 14 Aug 2022 03:52:46 +0000 (UTC)
Received: from compute1.internal (compute1.nyi.internal [10.202.2.41])
 by mailout.nyi.internal (Postfix) with ESMTP id A97E25C0084;
 Sat, 13 Aug 2022 23:52:42 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
 by compute1.internal (MEProxy); Sat, 13 Aug 2022 23:52:42 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=anarazel.de; h=
 cc:cc:content-type:date:date:from:from:in-reply-to:in-reply-to
 :message-id:mime-version:references:reply-to:sender:subject
 :subject:to:to; s=fm1; t=1660449162; x=1660535562; bh=arK7yru82m
 NQyxKZ58FhgyMo4fbKApN5PwTcq+J5WBg=; b=VkCNbD74dikSXuAA+bHCGFhlU0
 Dk6jAzPelWLzpCyHqMqNy8iKvsioCz8IwQ9+15uJj2XSPF308XyDr+GDt685irb8
 77tyu1dQtcHXMoT7AjBlec/k7A7bVe2WiPqAJtbLAEOWDaG02JgdZXw6MJhXG2/7
 vAjyTHL7/yaCCRtAPqNx4XhvjCLgj0d/uOrIIzzzNXqpHulqExoOHFU4tfmdIYoh
 mnIQXJK3sydPsiCaj6pupanGkxeHD0gjFeNGrJyMmtjRcsWR1buvdPMqkY/Y/B8h
 fqGnqaaoN0D7VsrCquyAyTdMSsz8szx5ubgTjMwubLYqKquerh5Lv4PhT+dw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
 messagingengine.com; h=cc:cc:content-type:date:date:feedback-id
 :feedback-id:from:from:in-reply-to:in-reply-to:message-id
 :mime-version:references:reply-to:sender:subject:subject:to:to
 :x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
 fm1; t=1660449162; x=1660535562; bh=arK7yru82mNQyxKZ58FhgyMo4fbK
 ApN5PwTcq+J5WBg=; b=28wb70dXB3yL0tuhQqMllb0PazCuy9MkFUANde0zFpmi
 zjDIqAp9iC9TifmtPU6aEDx8qlpnM2FencSb8sroJlhrDBUt8ExESG7+5vtbzw4p
 NQvAnJy7QiPsxyTqRb/GeLQhFv2AIciIAwNIg61ElHqXTEGqacLms27Kw08aGehX
 zTRopaOOV9d+bds3c0+tM4wMIBGrpxaq8elOpaFaouHfhTt01tw1gksBlAR8FCNY
 m+eeggQl0kk5VLICCEBMMdJOFocxVPmiswKB56ubeartbq1c5fjA/LXN5jtmZ7Lh
 dORlVi8YEz8fh7v0t84GmGpDkdw7IIAowUU33exo4A==
X-ME-Sender: <xms:iHH4YhCpP1OPCNYjC7i7ppu6P7YPmME6JTjsVjj1BQdjgR9Gi3NJBQ>
 <xme:iHH4Yvh3tabpmdSvQpc_RrCe5q2kN0festnCyYRj97RHjkX8PnszQmxNv4ur6nePB
 prwK0gmPa7oM1IWhg>
X-ME-Received: <xmr:iHH4Ysk8DaXRneQdLZ7EUjbt4pRqVcZAQJDZGUrcyYHAf0rEUcromfB8CF43zlXBa7wmzXwsVPg8qVPerAIeEFJOuFIxaoqXXXdmwfVl_TO_YQD5pgX7Iu4HWJVc>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvfedrvdegledgjeejucetufdoteggodetrfdotf
 fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
 uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
 cujfgurhepfffhvfevuffkfhggtggujgesthdtredttddtvdenucfhrhhomheptehnughr
 vghsucfhrhgvuhhnugcuoegrnhgurhgvshesrghnrghrrgiivghlrdguvgeqnecuggftrf
 grthhtvghrnhephefftdffheduffehffdtgfejgffhveehueeivdfhfefhfeekheeugfeg
 fefgleffnecuffhomhgrihhnpehgihhthhhusgdrtghomhenucevlhhushhtvghrufhiii
 gvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpegrnhgurhgvshesrghnrghrrgiivghl
 rdguvg
X-ME-Proxy: <xmx:iHH4Yrzjbsc-vjRdMBDkoUVnoEM_o8wDKwrNK7ZeHAGBRnSu0SPcTw>
 <xmx:iHH4YmSjZcAQmZ-lqCm_S-_6t_JZlhlj_DTGG3nMUo5PxPRBEJavbg>
 <xmx:iHH4YuYFKRVDaXd072svU5fx02CHuKDAIbE0IALxsNpF8E_9v7aXnw>
 <xmx:inH4Yt8LAVnlvFMS5H8bp6JYpvNa6f752Q-XWYNpASow8o9MJkyYTA>
Feedback-ID: id4a34324:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Sat,
 13 Aug 2022 23:52:40 -0400 (EDT)
Date: Sat, 13 Aug 2022 20:52:39 -0700
From: Andres Freund <andres@anarazel.de>
To: Xuan Zhuo <xuanzhuo@linux.alibaba.com>
Subject: Re: [GIT PULL] virtio: fatures, fixes
Message-ID: <20220814035239.m7rtepyum5xvtu2c@awork3.anarazel.de>
References: <20220812114250-mutt-send-email-mst@kernel.org>
 <20220814004522.33ecrwkmol3uz7aq@awork3.anarazel.de>
 <1660441835.6907768-1-xuanzhuo@linux.alibaba.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <1660441835.6907768-1-xuanzhuo@linux.alibaba.com>
Cc: peng.fan@nxp.com, kvm@vger.kernel.org, alvaro.karsz@solid-run.com,
 virtualization@lists.linux-foundation.org, quic_mingxue@quicinc.com,
 syoshida@redhat.com, elic@nvidia.com, eperezma@redhat.com,
 "Michael S. Tsirkin" <mst@redhat.com>, jiaming@nfschina.com, hulkci@huawei.com,
 liubo03@inspur.com, dan.carpenter@oracle.com, kangjie.xu@linux.alibaba.com,
 robin.murphy@arm.com, hdegoede@redhat.com, pankaj.gupta@amd.com,
 gautam.dawar@xilinx.com, suwan.kim027@gmail.com, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org, xuqiang36@huawei.com, xieyongji@bytedance.com,
 colin.i.king@gmail.com, lingshan.zhu@intel.com, colin.king@intel.com,
 Linus Torvalds <torvalds@linux-foundation.org>
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

On 2022-08-14 09:50:35 +0800, Xuan Zhuo wrote:
> Sorry, I didn't get any valuable information from the logs, can you tell me how
> to get such an image? Or how your [1] script is executed.

Is there specific information you'd like from the VM? I just recreated the
problem and can extract.


The last image that succeeded getting built is publically available, so you
could create a gcp VM for that, go to /usr/src/linux, git pull, make & install
the new kernel and reproduce the problem that way.  The git pull will take a
bit because it's a shallow clone...

gcloud compute instances create myvm --preemptible --project your-gcp-project --image-project pg-ci-images --image pg-ci-sid-newkernel-2022-08-12t06-52 --zone us-west1-a --custom-cpu=4 --custom-memory=4 --metadata=serial-port-enable=true

If you want to log in via serial console, you'd have set a password before
rebooting.

gcloud compute connect-to-serial-port --zone us-west1-a --project=pg-ci-images-dev myvm


Executing the script requires a gcp key with the right to create instances and
images. Here's how to invoke it:

PACKER_LOG=1 GOOGLE_APPLICATION_CREDENTIALS=~/image-builder@pg-ci-images-dev.iam.gserviceaccount.com.json \
  packer build \
    -var gcp_project=pg-ci-images-dev \
    -var "image_date=$(date --utc +'%Y-%m-%dt%H-%M')" \
    -var "task_name=sid-newkernel" \
    -only 'linux.googlecompute.sid-newkernel' \
    -on-error=ask \
    packer/linux_debian.pkr.hcl

Of course you'd need to change the gcp_project= variable to point to a the
project you have access to and GOOGLE_APPLICATION_CREDENTIALS to point to your
gcp key.

Initially (package upgrades, kernel builds) the VM would be SSH
accessible. After building the kernel it's only accessible via serial console.


I can probably also get you the image in some other form that you prefer,
although I don't know if the problem will reproduce outside gcp. If helpful I
could upload a "broken" gcp image that you could use to


> > [1] https://github.com/anarazel/pg-vm-images/blob/main/packer/linux_debian.pkr.hcl#L225

Greetings,

Andres Freund
_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
