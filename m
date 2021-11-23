Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 56129C433EF
	for <virtualization@archiver.kernel.org>; Tue, 23 Nov 2021 08:39:19 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp2.osuosl.org (Postfix) with ESMTP id DDBCB40171;
	Tue, 23 Nov 2021 08:39:18 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
	by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id kHOtvl7rAO6e; Tue, 23 Nov 2021 08:39:17 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp2.osuosl.org (Postfix) with ESMTPS id 264D540182;
	Tue, 23 Nov 2021 08:39:17 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id E9370C001E;
	Tue, 23 Nov 2021 08:39:16 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [IPv6:2605:bc80:3010::136])
 by lists.linuxfoundation.org (Postfix) with ESMTP id A2AB7C0012
 for <virtualization@lists.linux-foundation.org>;
 Tue, 23 Nov 2021 08:39:15 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id CAF8E605F2
 for <virtualization@lists.linux-foundation.org>;
 Tue, 23 Nov 2021 08:39:12 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp3.osuosl.org (amavisd-new);
 dkim=pass (1024-bit key) header.d=redhat.com
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id t-cLopJGjDLD
 for <virtualization@lists.linux-foundation.org>;
 Tue, 23 Nov 2021 08:39:12 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.129.124])
 by smtp3.osuosl.org (Postfix) with ESMTPS id 246C4605E3
 for <virtualization@lists.linux-foundation.org>;
 Tue, 23 Nov 2021 08:39:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1637656751;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=nrOQypnIKY09GqYfyFQddU2jCvj5x3Yj1tJn5UauCfc=;
 b=XrX9rwLxpqRUC+JTiTCLnLB0OXSLpQE0F7NGkQKY6pKBGr+H4obmZK9z1tQh6uvtrYk8Lc
 xtOLE925LmdZJTDecnBclAZI/FSeYwq+nbiy2I3SCtGr5h8T7u0uXy2gNbTNh88mxxO/YT
 80zrAkkiwZkh6Kr4qYWgo7d3clyXsns=
Received: from mail-lf1-f70.google.com (mail-lf1-f70.google.com
 [209.85.167.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-263-uJOAJCEoPBqjuhRRTZo60w-1; Tue, 23 Nov 2021 03:39:08 -0500
X-MC-Unique: uJOAJCEoPBqjuhRRTZo60w-1
Received: by mail-lf1-f70.google.com with SMTP id
 24-20020ac25f58000000b0041799ebf529so482622lfz.1
 for <virtualization@lists.linux-foundation.org>;
 Tue, 23 Nov 2021 00:39:08 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=nrOQypnIKY09GqYfyFQddU2jCvj5x3Yj1tJn5UauCfc=;
 b=lkQnuHwBa8YhGyVdxZXF/G28G6NjHPWun0ZW6FvZhsW6rHFAVa859a7YWoHfBEFL0c
 XnpBkXZvp46KHH+78tSpvSufQFHnVH0uxQlk1z/0NUBM5+B8FcdK2thhKmq04/OZVbBd
 3OPKXrj0WhwTJI+wgwRuhrsK64T9U5uttIrcDfL+FJXQp07zw/4PWhQ2r0uzD6JitXzb
 3vzP/Jkogs4N8VzSkmWZnNBg0leZuTmsnzjXcvztsXmMaDZqOu6N7ku0wh6378Ue6u0G
 us7NDXhBL9XUFfdkRvNGr9Zq1xZX1mSZYFPd7osNisni5TtWPAHxGmXf/aSXZnOhLMCe
 5f2w==
X-Gm-Message-State: AOAM533tU1jC3PXtttx6wD8rYDcxTmNBHdoZQpSGPEooV2a20j9w2DCL
 PnNMJVwrVI6bDPFcfIdlL5o8sE9NcWeNR8j4s08LNvhFzFUP0JPRhUSXNcqNGVxSnFbNX1iIXE6
 1a1LtbOZL+QXPpduTO2/aoOSwvHAOtSHW9n7w6exe7QqAq1siSdN3llf2Bw==
X-Received: by 2002:a05:6512:685:: with SMTP id
 t5mr3135049lfe.84.1637656746690; 
 Tue, 23 Nov 2021 00:39:06 -0800 (PST)
X-Google-Smtp-Source: ABdhPJw4QcuxppltJIqB4QJip789w/g6afDuzKZbKd5YBGbcfWD0Tjd/xC+UwHsGT+8eNvA2XZFz6JuG4bR0EGgt3nw=
X-Received: by 2002:a05:6512:685:: with SMTP id
 t5mr3135032lfe.84.1637656746487; 
 Tue, 23 Nov 2021 00:39:06 -0800 (PST)
MIME-Version: 1.0
References: <PH0PR12MB548187F4DE8C789908839F9DDC9C9@PH0PR12MB5481.namprd12.prod.outlook.com>
 <CACGkMEssVx-quDa+c7wYAyB6a3j88EBAYTW+y8e_FcxW2mA1nQ@mail.gmail.com>
 <20211122075615.GB74340@mtl-vdi-166.wap.labs.mlnx>
 <CACGkMEs0mCKV4iF=O7Psxip38tL5iiu92Kzj_LqLgTqXV-M+NA@mail.gmail.com>
 <20211122090755.GA75489@mtl-vdi-166.wap.labs.mlnx>
 <CACGkMEtMB78O7K5E+dV6M7_K3U1fOV_8Q7pArD05THVWszjZKg@mail.gmail.com>
 <PH0PR12MB548147E2266D0A8D7B1951F1DC9F9@PH0PR12MB5481.namprd12.prod.outlook.com>
 <20211122150704.GA88466@mtl-vdi-166.wap.labs.mlnx>
 <PH0PR12MB548193CA4DE7965673AAC3F7DC9F9@PH0PR12MB5481.namprd12.prod.outlook.com>
 <CACGkMEvZW6MbfXQh-++tDWZukEQmKsqV660=r-S+mgYM2_NppQ@mail.gmail.com>
 <20211123064235.GA118175@mtl-vdi-166.wap.labs.mlnx>
In-Reply-To: <20211123064235.GA118175@mtl-vdi-166.wap.labs.mlnx>
From: Jason Wang <jasowang@redhat.com>
Date: Tue, 23 Nov 2021 16:38:55 +0800
Message-ID: <CACGkMEvkQKBeWhweupKQA+PF3NxqYfCSH1hWysxaDhchq8wrQg@mail.gmail.com>
Subject: Re: [PATCH 1/2] vdpa: Add support for querying statistics
To: Eli Cohen <elic@nvidia.com>
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=jasowang@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Cc: Laurent Vivier <lvivier@redhat.com>, mst <mst@redhat.com>,
 virtualization <virtualization@lists.linux-foundation.org>,
 eperezma <eperezma@redhat.com>
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

On Tue, Nov 23, 2021 at 2:42 PM Eli Cohen <elic@nvidia.com> wrote:
>
> On Tue, Nov 23, 2021 at 10:28:04AM +0800, Jason Wang wrote:
> > On Mon, Nov 22, 2021 at 11:56 PM Parav Pandit <parav@nvidia.com> wrote:
> > >
> > >
> > >
> > > > From: Eli Cohen <elic@nvidia.com>
> > > > Sent: Monday, November 22, 2021 8:37 PM
> > > >
> > > > On Mon, Nov 22, 2021 at 12:15:36PM +0200, Parav Pandit wrote:
> > > > >
> > > > >
> > > > > > From: Jason Wang <jasowang@redhat.com>
> > > > > > Sent: Monday, November 22, 2021 3:02 PM
> > > > > >
> > > > > > > If we go with vendor stats, how can we communicate the information
> > > > > > > to userspace? Currenlty we use netlink attributes defined to pass
> > > > > > > this information.
> > > > > >
> > > > > > It can be done exactly as what have been done in the patch, we can
> > > > > > document it as vendor stats.
> > > > > >
> > > > > Yes, attribute to have VENDOR_ prefix in it.
> > > > > >
> > > > > > Ok, I think I get you. So I wonder if it's more useful to use device
> > > > > > specific counters. For networking, it could be packets send/received etc.
> > > > >
> > > > > Yes, I equally discussed this previously with Eli as its more meaningful for end
> > > > users.
> > > > > We just return the device id of it along with queue number that helps to show
> > > > tx and rx.
> > > > > For ctrl q, it is just ctrl commands and ctrl completions.
> > > >
> > > > I don't think we should mix send/receive packets for descriptors statistics. The
> > > > hardware could process a descriptor and still not transmit any packet.
> > > >
> > > > We can add packets send/recv but descriptor statistics have their own value.
> > > >
> > > Oh right. I read Jason's comment of _packets_ to fast. I meant to say send/receive descriptors.
> > > I guess you already named them as tx and rx. Didn't review the patches in this series yet.
> > >
> > > > To summarize, I can add the VENDOR_ preifx to the attibutes and re-send or is
> > > > there anything else you think should change?
> > > VENDOR_ prefix and command as iproute2 command as "vstats" looks fine to me.
> >
> > Ack, but we need to figure out:
> >
> > 1) use descriptors or buffers.
>
> Descriptors.
> Currently we don't support indirect buffers but when we do, we will
> preserve the semantics.

Just to confirm, if I understand correctly:

1) with indirect descriptors, only 1 descriptor is counted
2) with N descriptors chained together, it will report N descriptors

Thanks

>
> > 2) if we use descriptors, for indirect descriptors and descriptor
> > chains how are they counted?
> >
>
> We count descriptors, not buffers.
>
> > Thanks
> >
> > >
> >
>

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
