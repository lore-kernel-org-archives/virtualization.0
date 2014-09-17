From: Ming Lei <tom.leiming@gmail.com>
Subject: Re: blk-mq crash under KVM in multiqueue block code (with virtio-blk
	and ext4)
Date: Wed, 17 Sep 2014 23:24:37 +0800
Message-ID: <CACVXFVPh3SSp3V7hHJaPnp-koyh7n7hqf+Ugv9CMg2gO_8MwXg@mail.gmail.com>
References: <541178D6.6010303@de.ibm.com>
	<CACVXFVO7Oo9GeagPhejngfoeySxOP4EqWz_GN6kYv2956-Wtxg@mail.gmail.com>
	<541352ED.7030800@de.ibm.com> <54193F4F.9060508@de.ibm.com>
	<20140917140034.10125d00@thinkpad-w530>
	<20140917215226.426f6ce7@tom-ThinkPad-T410>
	<54199923.9010201@kernel.dk>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <54199923.9010201@kernel.dk>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/virtualization/>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: Jens Axboe <axboe@kernel.dk>
Cc: KVM list <kvm@vger.kernel.org>, "Michael S. Tsirkin" <mst@redhat.com>, "linux-kernel@vger.kernel.org >> Linux Kernel Mailing List" <linux-kernel@vger.kernel.org>, Virtualization List <virtualization@lists.linux-foundation.org>, David Hildenbrand <dahi@linux.vnet.ibm.com>, Christian Borntraeger <borntraeger@de.ibm.com>
List-Id: virtualization@lists.linuxfoundation.org

On Wed, Sep 17, 2014 at 10:22 PM, Jens Axboe <axboe@kernel.dk> wrote:
>
> Another way would be to ensure that the timeout handler doesn't touch hw_ctx
> or tag_sets that aren't fully initialized yet. But I think this is
> safer/cleaner.

That may not be easy or enough to check if hw_ctx/tag_sets are
fully initialized if you mean all requests have been used one time.

On Wed, Sep 17, 2014 at 10:11 PM, David Hildenbrand
> I was playing with a simple patch that just sets cmd_flags and action_flags to

What is action_flags?

> 0. That should already be sufficient to hinder blk_mq_tag_to_rq and the calling
> method to do the wrong thing.

Yes, clearing rq->cmd_flags should be enough.

And looks better to move rq initialization to __blk_mq_free_request()
too, otherwise timeout still may see old cmd_flags and rq->q before
rq's new initialization.


Thanks,
-- 
Ming Lei
