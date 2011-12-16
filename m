From: Rusty Russell <rusty@rustcorp.com.au>
Subject: Re: [RFC 7/11] virtio_pci: new, capability-aware driver.
Date: Fri, 16 Dec 2011 12:20:08 +1030
Message-ID: <87zketp9nz.fsf@rustcorp.com.au>
References: <87pqfzgy6p.fsf@rustcorp.com.au> <87zkf3fiu2.fsf@rustcorp.com.au>
	<20111211094256.GB11504@redhat.com>
	<87boreohhs.fsf@rustcorp.com.au>
	<20111212182533.GB25916@redhat.com>
	<87liqhtdnj.fsf@rustcorp.com.au> <20111215063004.GA3630@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <20111215063004.GA3630@redhat.com>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/virtualization/>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: "Michael S. Tsirkin" <mst@redhat.com>
Cc: Sasha Levin <levinsasha928@gmail.com>, virtualization <virtualization@lists.linux-foundation.org>
List-Id: virtualization@lists.linuxfoundation.org

On Thu, 15 Dec 2011 10:27:50 +0200, "Michael S. Tsirkin" <mst@redhat.com> wrote:
> On Tue, Dec 13, 2011 at 12:51:20PM +1030, Rusty Russell wrote:
> I mean like this in block:
> 
> 
> 
>         /* Host must always specify the capacity. */
>         vdev->config->get(vdev, offsetof(struct virtio_blk_config,
> capacity),
>                           &capacity, sizeof(capacity));
> 
>         /* If capacity is too big, truncate with warning. */
>         if ((sector_t)capacity != capacity) {
>                 dev_warn(&vdev->dev, "Capacity %llu too large:
> truncating\n",
>                          (unsigned long long)capacity);
>                 capacity = (sector_t)-1;
>         }
> 
> 
> Now let's assume capacity field is changed from 0x8000 to 0x10000
> on host. Is it possible that we read two upper bytes
> before the change so we see 0x0000....
> and 2 lower bytes after the change
> so we see 0x....0000 and resulting capacity appears
> to be 0?
> 
> If no why not?

Same issue in reverse with the guest setting the MAC address in
virtio_net, if the host were reading it.  And virtio_balloon?  We have
ignored it, so far.

Perhaps a new feature VIRTIO_F_UNSTABLE?  Which (unlike other features)
appears and vanishes around config writes by either side?  Kind of a
hack though...

Cheers,
Rusty.
