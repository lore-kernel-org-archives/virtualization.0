Return-Path: <SRS0=H5WS=OJ=lists.linux-foundation.org=virtualization-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8EF45C433F5
	for <virtualization@archiver.kernel.org>; Sun, 19 Sep 2021 19:45:26 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 24AE661051
	for <virtualization@archiver.kernel.org>; Sun, 19 Sep 2021 19:45:26 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org 24AE661051
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id D40744043C;
	Sun, 19 Sep 2021 19:45:25 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
	by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id 6Z5MnwcQ9TbZ; Sun, 19 Sep 2021 19:45:24 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp4.osuosl.org (Postfix) with ESMTPS id 462EA4041D;
	Sun, 19 Sep 2021 19:45:24 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id E4521C0011;
	Sun, 19 Sep 2021 19:45:23 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id EB39CC000D
 for <virtualization@lists.linux-foundation.org>;
 Sun, 19 Sep 2021 19:45:22 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id D969D83E54
 for <virtualization@lists.linux-foundation.org>;
 Sun, 19 Sep 2021 19:45:22 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp1.osuosl.org (amavisd-new);
 dkim=pass (1024-bit key) header.d=redhat.com
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id mtED1efVbAZh
 for <virtualization@lists.linux-foundation.org>;
 Sun, 19 Sep 2021 19:45:21 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [216.205.24.124])
 by smtp1.osuosl.org (Postfix) with ESMTPS id 9C10683E4F
 for <virtualization@lists.linux-foundation.org>;
 Sun, 19 Sep 2021 19:45:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1632080720;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=4oAWpa0o9G4j995IPJun3Q9gB79UMusoI6QFX2kWtMI=;
 b=deMm3KXb62/OZwQ9u+A9OaCt6L1g95NP4dH2Tj/7De5s3Hv+iMyFbpVKp72NvS5RBlFzzR
 5JU3S1Cgh4l1wOcHitID9qfjpA4c7gQnSvEjjk9pU4H6nfMklkYgt5CdhDlDj/CVD5lRj4
 HmYdzBHIH7801CSE5zZKsp4Qn45ZnH4=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-269-9h9lRDY3M0STrH3llpuhmg-1; Sun, 19 Sep 2021 15:45:16 -0400
X-MC-Unique: 9h9lRDY3M0STrH3llpuhmg-1
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com
 [10.5.11.23])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id C3EF91084681;
 Sun, 19 Sep 2021 19:45:14 +0000 (UTC)
Received: from horse.redhat.com (unknown [10.22.32.42])
 by smtp.corp.redhat.com (Postfix) with ESMTP id A554219724;
 Sun, 19 Sep 2021 19:45:04 +0000 (UTC)
Received: by horse.redhat.com (Postfix, from userid 10451)
 id F16C122827F; Sun, 19 Sep 2021 15:45:03 -0400 (EDT)
Date: Sun, 19 Sep 2021 15:45:03 -0400
From: Vivek Goyal <vgoyal@redhat.com>
To: JeffleXu <jefflexu@linux.alibaba.com>
Subject: Re: [Virtio-fs] [PATCH v4 0/8] fuse,virtiofs: support per-file DAX
Message-ID: <YUeTP1B+JE5gGudq@redhat.com>
References: <20210817022220.17574-1-jefflexu@linux.alibaba.com>
 <CAJfpeguw1hMOaxpDmjmijhf=-JEW95aEjxfVo_=D_LyWx8LDgw@mail.gmail.com>
 <YRuCHvhICtTzMK04@work-vm> <YRuuRo8jEs5dkfw9@redhat.com>
 <299689e9-bdeb-a715-3f31-8c70369cf0ba@linux.alibaba.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <299689e9-bdeb-a715-3f31-8c70369cf0ba@linux.alibaba.com>
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
Cc: Miklos Szeredi <miklos@szeredi.hu>,
 "Dr. David Alan Gilbert" <dgilbert@redhat.com>,
 virtualization@lists.linux-foundation.org,
 virtio-fs-list <virtio-fs@redhat.com>, Joseph Qi <joseph.qi@linux.alibaba.com>,
 Liu Bo <bo.liu@linux.alibaba.com>, linux-fsdevel@vger.kernel.org
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

On Thu, Sep 16, 2021 at 04:21:59PM +0800, JeffleXu wrote:
> Hi, I add some performance statistics below.
> 
> 
> On 8/17/21 8:40 PM, Vivek Goyal wrote:
> > On Tue, Aug 17, 2021 at 10:32:14AM +0100, Dr. David Alan Gilbert wrote:
> >> * Miklos Szeredi (miklos@szeredi.hu) wrote:
> >>> On Tue, 17 Aug 2021 at 04:22, Jeffle Xu <jefflexu@linux.alibaba.com> wrote:
> >>>>
> >>>> This patchset adds support of per-file DAX for virtiofs, which is
> >>>> inspired by Ira Weiny's work on ext4[1] and xfs[2].
> >>>
> >>> Can you please explain the background of this change in detail?
> >>>
> >>> Why would an admin want to enable DAX for a particular virtiofs file
> >>> and not for others?
> >>
> >> Where we're contending on virtiofs dax cache size it makes a lot of
> >> sense; it's quite expensive for us to map something into the cache
> >> (especially if we push something else out), so selectively DAXing files
> >> that are expected to be hot could help reduce cache churn.
> 
> Yes, the performance of dax can be limited when the DAX window is
> limited, where dax window may be contended by multiple files.
> 
> I tested kernel compiling in virtiofs, emulating the scenario where a
> lot of files contending dax window and triggering dax window reclaiming.
> 
> Environment setup:
> - guest vCPU: 16
> - time make vmlinux -j128
> 
> type    | cache  | cache-size | time
> ------- | ------ | ---------- | ----
> non-dax | always |   --       | real 2m48.119s
> dax     | always | 64M        | real 4m49.563s
> dax     | always |   1G       | real 3m14.200s
> dax     | always |   4G       | real 2m41.141s
> 
> 
> It can be seen that there's performance drop, comparing to the normal
> buffered IO, when dax window resource is restricted and dax window
> relcaiming is triggered. The smaller the cache size is, the worse the
> performance is. The performance drop can be alleviated and eliminated as
> cache size increases.
> 
> Though we may not compile kernel in virtiofs, indeed we may access a lot
> of small files in virtiofs and suffer this performance drop.

Hi Jeffle,

If you access lot of big files or a file bigger than dax window, still
you will face performance drop due to reclaim. IOW, if data being
accessed is bigger than dax window, then reclaim will trigger and
performance drop will be observed. So I think its not fair to assciate
performance drop with big for small files as such.

What makes more sense is that memomry usage argument you have used
later in the email. That is, we have a fixed chunk size of 2MB. And
that means we use 512 * 64 = 32K of memory per chunk. So if a file
is smaller than 32K in size, it might be better to just access it
without DAX and incur the cost of page cache in guest instead. Even this
argument also works only if dax window is being utilized fully.

Anyway, I think Miklos already asked you to send patches so that
virtiofs daemon specifies which file to use dax on. So are you
planning to post patches again for that. (And drop patches to
read dax attr from per inode from filesystem in guest).

Thanks
Vivek

> 
> 
> > In that case probaly we should just make DAX window larger. I assume
> 
> Yes, as the DAX window gets larger, it is less likely that we can run
> short of dax window resource.
> 
> However it doesn't come without cost. 'struct page' descriptor for dax
> window will consume guest memory at a ratio of ~1.5% (64/4096 = ~1.5%,
> page descriptor is of 64 bytes size, assuming 4K sized page). That is,
> every 1GB cache size will cost 16MB guest memory. As the cache size
> increases, the memory footprint for page descriptors also increases,
> which may offset the benefit of dax by eliminating guest page cache.
> 
> In summary, per-file dax feature tries to achieve a balance between
> performance and memory overhead, by offering a finer gained control for
> dax to users.
> 
> 
> > that selecting which files to turn DAX on, will itself will not be
> > a trivial. Not sure what heuristics are being deployed to determine
> > that. Will like to know more about it.
> 
> Currently we enable dax for hot and large blob files, while disabling
> dax for other miscellaneous small files.
> 
> 
> 
> -- 
> Thanks,
> Jeffle
> 

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
