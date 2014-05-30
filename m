From: Jens Axboe <axboe@kernel.dk>
Subject: Re: [PATCH] block: virtio_blk: don't hold spin lock during world
	switch
Date: Thu, 29 May 2014 21:35:50 -0600
Message-ID: <5387FC96.4030508@kernel.dk>
References: <1401418169-3361-1-git-send-email-ming.lei@canonical.com>	<5387F8B2.1070509@kernel.dk>
	<CACVXFVPoG6_fL_MTRF+616W7UdHpSgjtMLBLeBn4OGR63haw3w@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <CACVXFVPoG6_fL_MTRF+616W7UdHpSgjtMLBLeBn4OGR63haw3w@mail.gmail.com>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/virtualization/>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: Ming Lei <ming.lei@canonical.com>
Cc: virtualization@lists.linux-foundation.org, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, "Michael S. Tsirkin" <mst@redhat.com>
List-Id: virtualization@lists.linuxfoundation.org

On 2014-05-29 21:34, Ming Lei wrote:
> On Fri, May 30, 2014 at 11:19 AM, Jens Axboe <axboe@kernel.dk> wrote:
>> On 2014-05-29 20:49, Ming Lei wrote:
>>>
>>> Firstly, it isn't necessary to hold lock of vblk->vq_lock
>>> when notifying hypervisor about queued I/O.
>>>
>>> Secondly, virtqueue_notify() will cause world switch and
>>> it may take long time on some hypervisors(such as, qemu-arm),
>>> so it isn't good to hold the lock and block other vCPUs.
>>>
>>> On arm64 quad core VM(qemu-kvm), the patch can increase I/O
>>> performance a lot with VIRTIO_RING_F_EVENT_IDX enabled:
>>>          - without the patch: 14K IOPS
>>>          - with the patch: 34K IOPS
>>
>>
>> Patch looks good to me. I don't see a hit on my qemu-kvm testing, but it
>> definitely makes sense and I can see it hurting in other places.
>
> It isn't easy to observe the improvement on x86 VM, especially
> with few vCPUs, because qemu-system-x86_64 only takes
> several microseconds to handle the notification, but on arm64, it
> may take hundreds of microseconds, so the improvement is
> obvious on arm VM.
>
> I hope this patch can be merged, at least arm VM can benefit
> from it.

If Rusty agrees, I'd like to add it for 3.16 with a stable marker.

-- 
Jens Axboe
