From: Chris Friesen <chris.friesen@windriver.com>
Subject: Re: help? looking for limits on in-flight write operations for
	virtio-blk
Date: Tue, 26 Aug 2014 08:58:16 -0600
Message-ID: <53FCA088.7050108@windriver.com>
References: <53FB91BD.40403@windriver.com>
	<CAJSP0QU1e5eZoSm3nbBC4=ePHG21ABVh6+Kjo+SAFnvviLCPAg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <CAJSP0QU1e5eZoSm3nbBC4=ePHG21ABVh6+Kjo+SAFnvviLCPAg@mail.gmail.com>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/virtualization/>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: Stefan Hajnoczi <stefanha@gmail.com>
Cc: Josh Durgin <josh.durgin@inktank.com>, Jeff Cody <jcody@redhat.com>, Linux Virtualization <virtualization@lists.linux-foundation.org>, "Michael S. Tsirkin" <mst@redhat.com>
List-Id: virtualization@lists.linuxfoundation.org

On 08/26/2014 04:34 AM, Stefan Hajnoczi wrote:
> On Mon, Aug 25, 2014 at 8:42 PM, Chris Friesen
> <chris.friesen@windriver.com> wrote:

>> I'm trying to figure out if there are any limits on how high the inflight
>> numbers can go, but I'm not having much luck.
>>
>> I was hopeful when I saw qemu calling virtio_add_queue() with a queue size,
>> but the queue size was 128 which didn't match the inflight numbers I was
>> seeing, and after changing the queue size down to 16 I still saw the number
>> of inflight requests go up to 184 and then the guest took a kernel panic in
>> virtqueue_add_buf().
>>
>> Can someone with more knowledge of how virtio block works point me in the
>> right direction?
>
> You can use QEMU's I/O throttling as a workaround:
> qemu -drive ...,iops=64
>
> libvirt has XML syntax for specifying iops limits.  Please see
> <iotune> at http://libvirt.org/formatdomain.html.

IOPS limits are better than nothing, but not an actual solution.  There 
are two problems that come to mind:

1) If you specify a burst value then a single burst can allocate a bunch 
of memory and it rarely drops back down after that (due to the usual 
malloc()/brk() interactions).

2) If the aggregate I/O load is higher than what the server can provide, 
the number of inflight requests can increase without bounds while still 
abiding by the configured IOPS value.

What I'd like to see (and may take a stab at implementing) is a cap on 
either inflight bytes or inflight IOPS.  One complication is that this 
requires hooking into the completion path to update the stats (and 
possibly unblock the I/O code) when an operation is done.

> I have CCed Josh Durgin and Jeff Cody for ideas on reducing
> block/rbd.c memory consumption.  Is it possible to pass a
> scatter-gather list so I/O can be performed directly on guest memory?
> This would also improve performance slightly.

It's not just rbd.  I've seen qemu RSS jump by 110MB when accessing 
qcow2 images on an NFS-mounted filesystem.  When the guest is configured 
with 512MB that's fairly significant.

Chris
