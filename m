From: David Hildenbrand <dahi@linux.vnet.ibm.com>
Subject: Re: blk-mq crash under KVM in multiqueue block code (with
	virtio-blk and ext4)
Date: Wed, 17 Sep 2014 14:00:34 +0200
Message-ID: <20140917140034.10125d00__12583.1339195885$1410963165$gmane$org@thinkpad-w530>
References: <541178D6.6010303@de.ibm.com>
	<CACVXFVO7Oo9GeagPhejngfoeySxOP4EqWz_GN6kYv2956-Wtxg@mail.gmail.com>
	<541352ED.7030800@de.ibm.com> <54193F4F.9060508@de.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <54193F4F.9060508@de.ibm.com>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/virtualization/>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: Christian Borntraeger <borntraeger@de.ibm.com>
Cc: Jens Axboe <axboe@kernel.dk>, KVM list <kvm@vger.kernel.org>, "Michael S. Tsirkin" <mst@redhat.com>, Ming Lei <tom.leiming@gmail.com>, "linux-kernel@vger.kernel.org
	>> Linux Kernel Mailing List" <linux-kernel@vger.kernel.org>, Virtualization List <virtualization@lists.linux-foundation.org>
List-Id: virtualization@lists.linuxfoundation.org

> >>> Does anyone have an idea?
> >>> The request itself is completely filled with cc
> >>
> >> That is very weird, the 'rq' is got from hctx->tags,  and rq should be
> >> valid, and rq->q shouldn't have been changed even though it was
> >> double free or double allocation.
> >>
> >>> I am currently asking myself if blk_mq_map_request should protect against softirq here but I cant say for sure,as I have never looked into that code before.
> >>
> >> No, it needn't the protection.
> >>
> >> Thanks,
> >>
> > 
> > --
> > To unsubscribe from this list: send the line "unsubscribe kvm" in
> > the body of a message to majordomo@vger.kernel.org
> > More majordomo info at  http://vger.kernel.org/majordomo-info.html
> > 
> 

Digging through the code, I think I found a possible cause:

tags->rqs[..] is not initialized with zeroes (via alloc_pages_node in
blk-mq.c:blk_mq_init_rq_map()).

When a request is created:

1. __blk_mq_alloc_request() gets a free tag (thus e.g. removing it from
bitmap_tags)

2. __blk_mq_alloc_request() initializes is via blk_mq_rq_ctx_init(). The struct
is filled with life and rq->q is set.


When blk_mq_hw_ctx_check_timeout() is called:

1. blk_mq_tag_busy_iter() is used to call blk_mq_timeout_check() on all busy
tags.

2. This is done by collecting all free tags using bt_for_each_free() and
handing them to blk_mq_timeout_check(). This uses bitmap_tags.

3. blk_mq_timeout_check() calls  blk_mq_tag_to_rq() to get the rq.


Could we have a race between

- getting the tag (turning it busy) and initializing it and
- detecting a tag to be busy and trying to access it?


I haven't looked at the details yet. If so, we might either do some locking
(if there is existing infrastructure), or somehow mark a request as not being
initialized prior to accessing the data.
