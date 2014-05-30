From: Rusty Russell <rusty@rustcorp.com.au>
Subject: Re: [PATCH] block: virtio_blk: don't hold spin lock during world
	switch
Date: Fri, 30 May 2014 15:35:41 +0930
Message-ID: <87a99z7qdm.fsf@rustcorp.com.au>
References: <1401418169-3361-1-git-send-email-ming.lei@canonical.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <1401418169-3361-1-git-send-email-ming.lei@canonical.com>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/virtualization/>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: Jens Axboe <axboe@kernel.dk>, linux-kernel@vger.kernel.org
Cc: Ming Lei <ming.lei@canonical.com>, virtualization@lists.linux-foundation.org, "Michael S. Tsirkin" <mst@redhat.com>
List-Id: virtualization@lists.linuxfoundation.org

Ming Lei <ming.lei@canonical.com> writes:
> Firstly, it isn't necessary to hold lock of vblk->vq_lock
> when notifying hypervisor about queued I/O.
>
> Secondly, virtqueue_notify() will cause world switch and
> it may take long time on some hypervisors(such as, qemu-arm),
> so it isn't good to hold the lock and block other vCPUs.
>
> On arm64 quad core VM(qemu-kvm), the patch can increase I/O
> performance a lot with VIRTIO_RING_F_EVENT_IDX enabled:
> 	- without the patch: 14K IOPS
> 	- with the patch: 34K IOPS
>
> fio script:
> 	[global]
> 	direct=1
> 	bsrange=4k-4k
> 	timeout=10
> 	numjobs=4
> 	ioengine=libaio
> 	iodepth=64
>
> 	filename=/dev/vdc
> 	group_reporting=1
>
> 	[f1]
> 	rw=randread
>
> Cc: Rusty Russell <rusty@rustcorp.com.au>
> Cc: "Michael S. Tsirkin" <mst@redhat.com>
> Cc: virtualization@lists.linux-foundation.org
> Signed-off-by: Ming Lei <ming.lei@canonical.com>

Acked-by: Rusty Russell <rusty@rustcorp.com.au>

Thanks!
Rusty.
