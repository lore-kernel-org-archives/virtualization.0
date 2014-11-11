From: Ming Lei <tom.leiming@gmail.com>
Subject: Re: kernel BUG at drivers/block/virtio_blk.c:172!
Date: Tue, 11 Nov 2014 08:56:27 +0800
Message-ID: <CACVXFVOgRMqCUASOaXQ7ys8yiKZFEH5SA-+mV=H0uvHuGseENQ__27494.9285238565$1415667399$gmane$org@mail.gmail.com>
References: <20141107080416.0837a88c@tlielax.poochiereds.net>
	<87bnofnzop.fsf@rustcorp.com.au> <54614AE7.2080204@kernel.dk>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <54614AE7.2080204@kernel.dk>
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
Cc: "Michael S. Tsirkin" <mst@redhat.com>, Dave Chinner <david@fromorbit.com>, xfs@oss.sgi.com, Jeff Layton <jlayton@poochiereds.net>, Linux Virtualization <virtualization@lists.linux-foundation.org>
List-Id: virtualization@lists.linuxfoundation.org

On Tue, Nov 11, 2014 at 7:31 AM, Jens Axboe <axboe@kernel.dk> wrote:
> On 2014-11-10 02:59, Rusty Russell wrote:
>>
>> Jeff Layton <jlayton@poochiereds.net> writes:
>>
>>> In the latest Fedora rawhide kernel in the repos, I'm seeing the
>>> following oops when mounting xfs. rc2-ish kernels seem to be fine:
>>>
>>> [   64.669633] ------------[ cut here ]------------
>>> [   64.670008] kernel BUG at drivers/block/virtio_blk.c:172!
>>
>>
>> Hmm, that's:
>>
>>         BUG_ON(req->nr_phys_segments + 2 > vblk->sg_elems);
>>
>> But during our probe routine we said:
>>
>>         /* We can handle whatever the host told us to handle. */
>>         blk_queue_max_segments(q, vblk->sg_elems-2);
>>
>> Jens?
>
>
> Known, I'm afraid, Ming is looking into it.

There is one obvious bug which should have been fixed by below
patch(0001-block-blk-merge-fix-blk_recount_segments.patch"):

http://marc.info/?l=linux-virtualization&m=141562191719405&q=p3

And there might be another one, I appreciate someone can post
log which is printed by patch("blk-seg.patch") in below link if the
bug still can be triggered even with above fix:

http://marc.info/?l=linux-virtualization&m=141473040618467&q=p3


Thanks,
-- 
Ming Lei
