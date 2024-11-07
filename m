Received: from out30-132.freemail.mail.aliyun.com (out30-132.freemail.mail.aliyun.com [115.124.30.132])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C2132D268;
	Thu,  7 Nov 2024 02:27:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=115.124.30.132
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730946425; cv=none; b=ReRH9fbi6FQ8xulrMWMmuNrDbcb/lnno4U5scuJvT2QlRvGwJfOhsgZWyOjiisBDJNnTbD4Dm5NoZpGIK1vM+2WydEjo/vZkzG7yioaxws+ffwkLe5qyt5zr4lM0ZkKP3eiy5ADiiDr5y9y8ALTK93nzb4W+kja4qg17hP14nQs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730946425; c=relaxed/simple;
	bh=b5NLqH4D6TJxOOfKQVO3eHJieaGxINQW1ZIF+j+Coyc=;
	h=Message-ID:Subject:Date:From:To:Cc:References:In-Reply-To; b=bZXVZ00Nja8Z3sg6Ol2g8acoNK71AgxLfXxtONxRBLn3HgUK82BAyuyPizbYMw2oI1LsGvDafSZXCFG3LGRZAbFzGl+bWqlfS9bi4wICwL78I9ZoUO7JO0q62pLhhPpKXyUqKAF0tapQiU8PnilW47R1O9jTJk9a7ew/kLHSWEw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; spf=pass smtp.mailfrom=linux.alibaba.com; dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b=NjKz4aad; arc=none smtp.client-ip=115.124.30.132
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b="NjKz4aad"
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1730946420; h=Message-ID:Subject:Date:From:To;
	bh=b5NLqH4D6TJxOOfKQVO3eHJieaGxINQW1ZIF+j+Coyc=;
	b=NjKz4aadSM1YDDLvYOHAGj12YSOfiJgbdmnKwVq/GYmkwkiC0C5fgMdjPjos4MvQwn1XY6eth2Gkt2UKJ/49+A+lXFywovz4XCbATUcWaXHsjW6oTLH0y2EsVIA540uHIo44KoIBqzdD9+Nrug1KUxYfPXXUSyjfSxRc9cgrdB0=
Received: from localhost(mailfrom:xuanzhuo@linux.alibaba.com fp:SMTPD_---0WItv5jJ_1730946418 cluster:ay36)
          by smtp.aliyun-inc.com;
          Thu, 07 Nov 2024 10:26:59 +0800
Message-ID: <1730946100.0197623-1-xuanzhuo@linux.alibaba.com>
Subject: Re: 0010:virtnet_rq_alloc+0x8f/0x1b0 [virtio_net] with 6.10.7 and packed virtqueues
Date: Thu, 7 Nov 2024 10:21:40 +0800
From: Xuan Zhuo <xuanzhuo@linux.alibaba.com>
To: "Linux regression tracking (Thorsten Leemhuis)" <regressions@leemhuis.info>
Cc: Linux regressions mailing list <regressions@lists.linux.dev>,
 virtualization@lists.linux.dev,
 Jaroslav Pulchart <jaroslav.pulchart@gooddata.com>,
 "Michael S. Tsirkin" <mst@redhat.com>
References: <CAK8fFZ6qVutPWxquHg7NEvFqYqDP5BwEdO81hqW8iMFxJFuLSQ@mail.gmail.com>
 <CAK8fFZ5N7EbU=uLbfyeSkQ273NSm+GELWUu1O1OBCpaSwjv6FA@mail.gmail.com>
 <422f35b3-7834-4df7-bcea-e3be12707aef@leemhuis.info>
 <1726216954.7439098-1-xuanzhuo@linux.alibaba.com>
 <565a9204-362d-458d-8b8e-11c5aada7b98@leemhuis.info>
 <CAK8fFZ6W2ZfwTa4nYz8ORTgb0mOTysg89LEEz7cHGtdqwpsvmA@mail.gmail.com>
 <20240913103753-mutt-send-email-mst@kernel.org>
 <CAK8fFZ4ONa_LYsyPN1E6QvUz4uUbzm35yfh6_dHUMDSxzySm3A@mail.gmail.com>
 <20241106035955-mutt-send-email-mst@kernel.org>
 <1730883874.818401-4-xuanzhuo@linux.alibaba.com>
 <20241106044241-mutt-send-email-mst@kernel.org>
 <35b03c6d-a083-407e-a0db-85d5dedcd335@leemhuis.info>
In-Reply-To: <35b03c6d-a083-407e-a0db-85d5dedcd335@leemhuis.info>
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>

On Wed, 6 Nov 2024 11:09:17 +0100, "Linux regression tracking (Thorsten Leemhuis)" <regressions@leemhuis.info> wrote:
> On 06.11.24 10:43, Michael S. Tsirkin wrote:
> > On Wed, Nov 06, 2024 at 05:04:34PM +0800, Xuan Zhuo wrote:
> >> On Wed, 6 Nov 2024 04:01:43 -0500, "Michael S. Tsirkin" <mst@redhat.com> wrote:
> >>> On Mon, Sep 16, 2024 at 09:32:38AM +0200, Jaroslav Pulchart wrote:
> >>>>> On Fri, Sep 13, 2024 at 11:21:11AM +0200, Jaroslav Pulchart wrote:
> >>>>>>
> >>>>>> 1/ I was able to "do a reproducer" and hit the "random memory
> >>>>>> corruption" issue with vanila 6.10.10 in our setup in ~28m of uptime
> >>>>>> see attached 6.10.10-1.gdc.el9.x86_64.log.
> >>>>>> 2/ I reverted these commits
> >>>>>> "virtio_net: rx remove premapped failover code":
> >>>>>> defd28aa5acb0fd7c15adc6bc40a8ac277d04dea
> >>>>>> "virtio_net: big mode skip the unmap check":
> >>>>>> a377ae542d8d0a20a3173da3bbba72e045bea7a9
> >>>>>> "virtio_ring: enable premapped mode whatever use_dma_api":
> >>>>>> f9dac92ba9081062a6477ee015bd3b8c5914efc4
> >>>>>> in our next build and so far the environment is stable and not
> >>>>>> crashing under same conditions like the previous crash.
> >>>>>
> >>>>> Automated backport failed:
> >>>>>
> >>>>> http://lore.kernel.org/all/2024091336-family-daffodil-541d@gregkh
> >>>>>
> >>>>> Since you have done the revert, and actually tested it, feel free
> >>>>> to post, I will ack.
> >>>>
> >>>> What I did is:
> >>>> git checkout linux-6.10.y
> >>>> git revert defd28aa5acb0fd7c15adc6bc40a8ac277d04dea
> >>>> git revert a377ae542d8d0a20a3173da3bbba72e045bea7a9
> >>>> git revert f9dac92ba9081062a6477ee015bd3b8c5914efc4
> >>>> (no changes nor fixing conflicts was needed)
> >>>>
> >>>> I'm newbie in posting the changes to upstream, Can you help me with
> >>>> some simple steps on how to do it?
> >>>
> >>> Basically in this case, I think it is enough
> >>> to reply to the revert patches and CC stable.
> >>
> >> Oh, I am ok.
> >>
> >> If need me to do something, please let me know.
> >>
> >> Thanks.
> >
> > yes, pls reply and CC stable ;)
>
> I see that ";)", but it seems I'm missing something here:
>
> Why did this thread resurface? 6.10.y is EOL since a while now, so that
> reverting ship has sailed. And the commit in question is in 6.11 afaics.
>


I did a simple research that the only version was affected is 6.10.y.

6.9 does not include the problem commits.
6.11 is fixed by reverting the problem commits.

6.10.y failed on the backport.

But the 6.10.y is EOL, so the fix commit to 6.10.y is still needed?

If yes, I can post a fix commit.


Thanks.


> Ciao, Thorsten
