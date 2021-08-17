Return-Path: <SRS0=dYih=NI=lists.linux-foundation.org=virtualization-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3F3CDC4338F
	for <virtualization@archiver.kernel.org>; Tue, 17 Aug 2021 14:58:00 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D3E0E60FA0
	for <virtualization@archiver.kernel.org>; Tue, 17 Aug 2021 14:57:59 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org D3E0E60FA0
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 9EE81402FF;
	Tue, 17 Aug 2021 14:57:59 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
	by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id VzmXfh-4ftfa; Tue, 17 Aug 2021 14:57:55 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp4.osuosl.org (Postfix) with ESMTPS id 33F844023F;
	Tue, 17 Aug 2021 14:57:55 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 0A0B9C001A;
	Tue, 17 Aug 2021 14:57:55 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [IPv6:2605:bc80:3010::137])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 419B0C000E
 for <virtualization@lists.linux-foundation.org>;
 Tue, 17 Aug 2021 14:57:54 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id 1D30F402E0
 for <virtualization@lists.linux-foundation.org>;
 Tue, 17 Aug 2021 14:57:54 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id gbXV7sNop-dA
 for <virtualization@lists.linux-foundation.org>;
 Tue, 17 Aug 2021 14:57:52 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.133.124])
 by smtp4.osuosl.org (Postfix) with ESMTPS id 0DA784023F
 for <virtualization@lists.linux-foundation.org>;
 Tue, 17 Aug 2021 14:57:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1629212271;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=Hk86/KYj3ZK8RgsgOcBS3p9RbAsZ92PjYs1lZc6coX8=;
 b=anuMZLddL6CqepgZBgq9uqiruYAMtroj+jzqU5ui+XuZZ21+qrNISVfAee0CDmrhlVK2Jc
 6zzOFTn5YMmwzoqrv9xgs+ks5UJ2hLuvSXZOg1XucFVEJ0BO/Xu0cze2UJisKtlGlGEjI9
 l7o33p7EBvBObuBYVKQXq6DR8mJsl4U=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-300-yLla6GVTPeifjsf4fyH-kg-1; Tue, 17 Aug 2021 10:57:49 -0400
X-MC-Unique: yLla6GVTPeifjsf4fyH-kg-1
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com
 [10.5.11.15])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 83F00EC1A1;
 Tue, 17 Aug 2021 14:57:48 +0000 (UTC)
Received: from horse.redhat.com (unknown [10.22.10.24])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 5949B5D6AB;
 Tue, 17 Aug 2021 14:57:41 +0000 (UTC)
Received: by horse.redhat.com (Postfix, from userid 10451)
 id D5A5A220637; Tue, 17 Aug 2021 10:57:40 -0400 (EDT)
Date: Tue, 17 Aug 2021 10:57:40 -0400
From: Vivek Goyal <vgoyal@redhat.com>
To: JeffleXu <jefflexu@linux.alibaba.com>
Subject: Re: [PATCH v4 0/8] fuse,virtiofs: support per-file DAX
Message-ID: <YRvOZI3CvLsF96JA@redhat.com>
References: <20210817022220.17574-1-jefflexu@linux.alibaba.com>
 <CAJfpeguw1hMOaxpDmjmijhf=-JEW95aEjxfVo_=D_LyWx8LDgw@mail.gmail.com>
 <YRut5sioYfc2M1p7@redhat.com>
 <6043c0b8-0ff1-2e11-0dd0-e23f9ff6b952@linux.alibaba.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <6043c0b8-0ff1-2e11-0dd0-e23f9ff6b952@linux.alibaba.com>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
Cc: Miklos Szeredi <miklos@szeredi.hu>,
 virtualization@lists.linux-foundation.org,
 virtio-fs-list <virtio-fs@redhat.com>, Joseph Qi <joseph.qi@linux.alibaba.com>,
 Liu Bo <bo.liu@linux.alibaba.com>, Stefan Hajnoczi <stefanha@redhat.com>,
 linux-fsdevel@vger.kernel.org
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

On Tue, Aug 17, 2021 at 09:22:53PM +0800, JeffleXu wrote:
> 
> 
> On 8/17/21 8:39 PM, Vivek Goyal wrote:
> > On Tue, Aug 17, 2021 at 10:06:53AM +0200, Miklos Szeredi wrote:
> >> On Tue, 17 Aug 2021 at 04:22, Jeffle Xu <jefflexu@linux.alibaba.com> wrote:
> >>>
> >>> This patchset adds support of per-file DAX for virtiofs, which is
> >>> inspired by Ira Weiny's work on ext4[1] and xfs[2].
> >>
> >> Can you please explain the background of this change in detail?
> >>
> >> Why would an admin want to enable DAX for a particular virtiofs file
> >> and not for others?
> > 
> > Initially I thought that they needed it because they are downloading
> > files on the fly from server. So they don't want to enable dax on the file
> > till file is completely downloaded. 
> 
> Right, it's our initial requirement.
> 
> 
> > But later I realized that they should
> > be able to block in FUSE_SETUPMAPPING call and make sure associated
> > file section has been downloaded before returning and solve the problem.
> > So that can't be the primary reason.
> 
> Saying we want to access 4KB of one file inside guest, if it goes
> through FUSE request routine, then the fuse daemon only need to download
> this 4KB from remote server. But if it goes through DAX, then the fuse
> daemon need to download the whole DAX window (e.g., 2MB) from remote
> server, so called amplification. Maybe we could decrease the DAX window
> size, but it's a trade off.

Downloading 2MB chunk should not be a big issue (IMHO). And if this
turns out to be real concern, we could experiment with a smaller
mapping granularity.

> 
> > 
> > Other reason mentioned I think was that only certain files benefit
> > from DAX. But not much details are there after that. It will be nice
> > to hear a more concrete use case and more details about this usage.
> > 
> 
> Apart from our internal requirement, more fine grained control for DAX
> shall be general and more flexible. Glad to hear more discussion from
> community.

Sure it will be more general and flexible. But there needs to be 1-2
good concrete use cases to justify additional complexity. And I don't
think that so far a good use case has come forward.

Thanks
Vivek

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
