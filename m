Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9B9F2C00140
	for <virtualization@archiver.kernel.org>; Mon, 15 Aug 2022 20:51:03 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 38CB68177A;
	Mon, 15 Aug 2022 20:51:03 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 38CB68177A
Authentication-Results: smtp1.osuosl.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20210112 header.b=QQ7hvQ+u
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
	by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id 1fYjOBjIDQf3; Mon, 15 Aug 2022 20:51:01 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp1.osuosl.org (Postfix) with ESMTPS id 30F7181775;
	Mon, 15 Aug 2022 20:51:01 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 30F7181775
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id EE014C0032;
	Mon, 15 Aug 2022 20:51:00 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [IPv6:2605:bc80:3010::133])
 by lists.linuxfoundation.org (Postfix) with ESMTP id DCE3BC002D
 for <virtualization@lists.linux-foundation.org>;
 Mon, 15 Aug 2022 20:50:58 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id A9755402BC
 for <virtualization@lists.linux-foundation.org>;
 Mon, 15 Aug 2022 20:50:58 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org A9755402BC
Authentication-Results: smtp2.osuosl.org;
 dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com
 header.a=rsa-sha256 header.s=20210112 header.b=QQ7hvQ+u
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id CkgI-jNqpfhV
 for <virtualization@lists.linux-foundation.org>;
 Mon, 15 Aug 2022 20:50:56 +0000 (UTC)
X-Greylist: whitelisted by SQLgrey-1.8.0
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org 02ABF4028D
Received: from mail-pf1-x42d.google.com (mail-pf1-x42d.google.com
 [IPv6:2607:f8b0:4864:20::42d])
 by smtp2.osuosl.org (Postfix) with ESMTPS id 02ABF4028D
 for <virtualization@lists.linux-foundation.org>;
 Mon, 15 Aug 2022 20:50:55 +0000 (UTC)
Received: by mail-pf1-x42d.google.com with SMTP id h28so7561226pfq.11
 for <virtualization@lists.linux-foundation.org>;
 Mon, 15 Aug 2022 13:50:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20210112;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:sender:from:to:cc;
 bh=glA+4AWskQ0XcBj8UcnWlDiqOn/xWKEln7bVu+o8za4=;
 b=QQ7hvQ+ubp2iJzuj3UoaM8lWe4xQ/FUV+rXpyAd8B8F0q1DSanPwK8b8YKAu/ito2z
 EEOcMyBXUxdpbxc0dNqHywfGBX/ICtK3jTaetbb5KdVBQw67gS0C/M+TgADZAbbeyH3q
 aD0mXkAs0f4zzMC3gZJnm75uSpJnDu9MAVtISN9/J04MtSNTnO/X21jqiLLOyNMS1eji
 5cIkLVKER5CUqI1FGbTCFj0MYnXlI3gKBJ8S6kgnXvv+7mAdb2e48QKEWDZMAPWiseak
 wO2PBJnL1K5XxrkEb143yZe0LCXyHiz55SYAafuEXRc9M3XoXqVMr/rxlnUbY+ESvShL
 QacQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:sender:x-gm-message-state:from:to:cc;
 bh=glA+4AWskQ0XcBj8UcnWlDiqOn/xWKEln7bVu+o8za4=;
 b=n4afm8K6VD6Xq7t1eCDRWsZVV7VoHjO87KW0ZnNypweCzf8hHPJY/cUNVjMPr5Xrb3
 1sGwGbI/fvAc976UXo4SxCAM2vKq6fUUyCAD/BoHrH7ay0DaFAMdwkIi1MyPwEOEwT3U
 oCI1mXBNrqQvjTW0Nq2MqyCA8UrEzO3jVVyUtSiERfdz4rs48ADoKr+swgOhN9hk6IdJ
 abfLv/xTBx6iV0Ww+NjBmBkIFAiqNw+ynAOpH6UE03EDtj8fw+G3ALeM9sDjbErvUnK1
 D65uu/vicFinE63OC1nfbNrSvoPuWn/h75bobi49SGdNTGIpGIiLosXxXfqC6H9nHPTI
 nKkA==
X-Gm-Message-State: ACgBeo0Aufvs7ksBFsKxoOC08LgaZfYa5J5OtMUep5LQWnA5gPHX8YnV
 0+HRkwVIKiAKcT8WIrriLls=
X-Google-Smtp-Source: AA6agR7sPBhzIixnkq0W8yjYSrUdkzbyY93STp5RF3u/3ixs6au3SDQM9HC93KIyhdO/SDet4xb6jw==
X-Received: by 2002:a05:6a00:a04:b0:534:d8a6:40ce with SMTP id
 p4-20020a056a000a0400b00534d8a640cemr7012939pfh.15.1660596655420; 
 Mon, 15 Aug 2022 13:50:55 -0700 (PDT)
Received: from server.roeck-us.net ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
 by smtp.gmail.com with ESMTPSA id
 l8-20020a17090a4d4800b001f4dd3b7d7fsm4975272pjh.9.2022.08.15.13.50.54
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 15 Aug 2022 13:50:54 -0700 (PDT)
Date: Mon, 15 Aug 2022 13:50:53 -0700
From: Guenter Roeck <linux@roeck-us.net>
To: "Michael S. Tsirkin" <mst@redhat.com>
Subject: Re: [PATCH] virtio_net: Revert "virtio_net: set the default max ring
 size by find_vqs()"
Message-ID: <20220815205053.GD509309@roeck-us.net>
References: <20220815090521.127607-1-mst@redhat.com>
 <20220815203426.GA509309@roeck-us.net>
 <20220815164013-mutt-send-email-mst@kernel.org>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20220815164013-mutt-send-email-mst@kernel.org>
Cc: Jens Axboe <axboe@kernel.dk>,
 "Martin K. Petersen" <martin.petersen@oracle.com>, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org, virtualization@lists.linux-foundation.org,
 James Bottomley <James.Bottomley@hansenpartnership.com>,
 Linus Torvalds <torvalds@linux-foundation.org>,
 Eric Dumazet <edumazet@google.com>, Greg KH <gregkh@linuxfoundation.org>,
 c@redhat.com, Jakub Kicinski <kuba@kernel.org>,
 Paolo Abeni <pabeni@redhat.com>, Andres Freund <andres@anarazel.de>,
 "David S. Miller" <davem@davemloft.net>
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

On Mon, Aug 15, 2022 at 04:42:51PM -0400, Michael S. Tsirkin wrote:
> On Mon, Aug 15, 2022 at 01:34:26PM -0700, Guenter Roeck wrote:
> > On Mon, Aug 15, 2022 at 05:16:50AM -0400, Michael S. Tsirkin wrote:
> > > This reverts commit 762faee5a2678559d3dc09d95f8f2c54cd0466a7.
> > > 
> > > This has been reported to trip up guests on GCP (Google Cloud).  Why is
> > > not yet clear - to be debugged, but the patch itself has several other
> > > issues:
> > > 
> > > - It treats unknown speed as < 10G
> > > - It leaves userspace no way to find out the ring size set by hypervisor
> > > - It tests speed when link is down
> > > - It ignores the virtio spec advice:
> > >         Both \field{speed} and \field{duplex} can change, thus the driver
> > >         is expected to re-read these values after receiving a
> > >         configuration change notification.
> > > - It is not clear the performance impact has been tested properly
> > > 
> > > Revert the patch for now.
> > > 
> > > Link: https://lore.kernel.org/r/20220814212610.GA3690074%40roeck-us.net
> > > Link: https://lore.kernel.org/r/20220815070203.plwjx7b3cyugpdt7%40awork3.anarazel.de
> > > Link: https://lore.kernel.org/r/3df6bb82-1951-455d-a768-e9e1513eb667%40www.fastmail.com
> > > Link: https://lore.kernel.org/r/FCDC5DDE-3CDD-4B8A-916F-CA7D87B547CE%40anarazel.de
> > > Fixes: 762faee5a267 ("virtio_net: set the default max ring size by find_vqs()")
> > > Cc: Xuan Zhuo <xuanzhuo@linux.alibaba.com>
> > > Cc: Jason Wang <jasowang@redhat.com>
> > > Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
> > > Tested-by: Andres Freund <andres@anarazel.de>
> > 
> > I ran this patch through a total of 14 syskaller tests, 2 test runs each on
> > 7 different crashes reported by syzkaller (as reported to the linux-kernel
> > mailing list). No problems were reported. I also ran a single cross-check
> > with one of the syzkaller runs on top of v6.0-rc1, without this patch.
> > That test run failed.
> > 
> > Overall, I think we can call this fixed.
> > 
> > Guenter
> 
> It's more of a work around though since we don't yet have the root
> cause for this. I suspect a GCP hypervisor bug at the moment.
> This is excercising a path we previously only took on GFP_KERNEL
> allocation failures during probe, I don't think that happens a lot.
>

Even a hypervisor bug should not trigger crashes like this one,
though, or at least I think so. Any idea what to look for on the
hypervisor side, and/or what it might be doing wrong ?

Thanks,
Guenter
_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
