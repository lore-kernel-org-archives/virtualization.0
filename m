From: Siwei Liu <loseweigh@gmail.com>
Subject: Re: [virtio-dev] Re: [PATCH] qemu: Introduce VIRTIO_NET_F_STANDBY
	feature bit to virtio_net
Date: Fri, 22 Jun 2018 15:25:19 -0700
Message-ID: <CADGSJ20aseLKPeEoOg20D5MC5m0JshyPCd2Q8ERfuFhpRL8-FA@mail.gmail.com>
References: <20180605152344-mutt-send-email-mst@kernel.org>
	<a45625c9-d2cd-f8f7-ce31-37c558e70b88@redhat.com>
	<20180612144743-mutt-send-email-mst@kernel.org>
	<5718de66-74c9-1362-a87b-2eba02475b48@redhat.com>
	<c29a5ac9-cfb5-0a19-f28c-30d41bd5efcf@intel.com>
	<ce4da2b0-88fd-c79b-0567-fe564bb34922@redhat.com>
	<20180621211359-mutt-send-email-mst@kernel.org>
	<CADGSJ216itm89dUuK_vOfuBsBq5bq4485GqMKjB1JXFD_PLZxA@mail.gmail.com>
	<20180622052717-mutt-send-email-mst@kernel.org>
	<CADGSJ210d358_uyNK9LLw9gpP5uXK6T0h=9mR9ryG7ySkVqvkA@mail.gmail.com>
	<20180623004404-mutt-send-email-mst@kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <20180623004404-mutt-send-email-mst@kernel.org>
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
Cc: Alexander Duyck <alexander.h.duyck@intel.com>, virtio-dev@lists.oasis-open.org, qemu-devel@nongnu.org, "Samudrala, Sridhar" <sridhar.samudrala@intel.com>, virtualization@lists.linux-foundation.org
List-Id: virtualization@lists.linuxfoundation.org

On Fri, Jun 22, 2018 at 2:47 PM, Michael S. Tsirkin <mst@redhat.com> wrote:
> On Fri, Jun 22, 2018 at 12:43:26PM -0700, Siwei Liu wrote:
>> > The semantics are that the primary is always used if present in
>> > preference to standby.
>> OK. If this is the only semantics of what "standby" refers to in
>> general, that is fine.
>>
>> I just don't want to limit the failover/standby semantics to the
>> device model specifics, the "accelerated datapath" thing or whatever.
>> I really don't know where the requirements of the "accelerated
>> datapath" came from,
>
> It's a way to put it that matches what failover actually provides.
>
>> as the originial problem is migrating vfio
>> devices which is in match of QEMU's live migration model.
>
> If you put it this way then it's natural to require that we have a
> config with a working vfio device, and that we somehow add virtio for
> duration of migration.

OK. That's the STANDBY feature sematics as I expect. Not something
like "we have a working virtio, but we need an accelerated datapath
via VFIO when the VM is not migrating". The VFIO is the what needs to
be concerned with, not the virtio. The way I view it, the STANDBY
feature, although present in the virtio device, is served as a
communication channel for the paired VFIO device, and the main purpose
of its feature negotiation process has to be around for migrating the
corresponding VFIO. While it's possible to re-use it as a side way to
achieve "accelerated datapath".

There could be other alternatives for vfio migration though, which do
not need the virtio helper, so don't need to get a STANDBY virtio for
that VFIO device.

>
>> Hyper-V has
>> it's limitation to do 1-netdev should not impact how KVM/QEMU should
>> be doing it.
>
> That's a linux thing and pretty orthogonal to host/guest interface.

I agree. So don't assume any device model specifics in the host/guest interface.

>
>> > Jason said virtio net is sometimes preferable.
>> > If that's the case don't make it a standby.
>> >
>> > More advanced use-cases do exist and e.g. Alexander Duyck
>> > suggested using a switch-dev.
>>
>> The switchdev case would need a new feature bit, right?
>>
>> -Siwei
>
> I think it would need to be a completely new device.

So how it relates to virtio or failover?

Regards,
-Siwei
>
>> > failover isn't it though.
>> >
>> > --
>> > MST
