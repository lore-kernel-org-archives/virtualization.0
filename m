From: Rusty Russell <rusty@rustcorp.com.au>
Subject: Re: [PATCH 2/2] virtio_balloon: free some memory from baloon on OOM
Date: Tue, 14 Oct 2014 10:14:05 +1030
Message-ID: <87oatfcz7e.fsf@rustcorp.com.au>
References: <1412763669-2980-1-git-send-email-den@parallels.com>
	<1412763669-2980-3-git-send-email-den@parallels.com>
	<87iojoedq3.fsf@rustcorp.com.au>
	<20141013072201.GB10178@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <20141013072201.GB10178@redhat.com>
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
Cc: den@openvz.org, "Denis V. Lunev" <den@parallels.com>, Raushaniya Maksudova <rmaksudova@parallels.com>, virtualization@lists.linux-foundation.org
List-Id: virtualization@lists.linuxfoundation.org

"Michael S. Tsirkin" <mst@redhat.com> writes:

> On Mon, Oct 13, 2014 at 04:02:52PM +1030, Rusty Russell wrote:
>> "Denis V. Lunev" <den@parallels.com> writes:
>> > From: Raushaniya Maksudova <rmaksudova@parallels.com>
>> >
>> > Excessive virtio_balloon inflation can cause invocation of OOM-killer,
>> > when Linux is under severe memory pressure. Various mechanisms are
>> > responsible for correct virtio_balloon memory management. Nevertheless
>> > it is often the case that these control tools does not have enough time
>> > to react on fast changing memory load. As a result OS runs out of memory
>> > and invokes OOM-killer. The balancing of memory by use of the virtio
>> > balloon should not cause the termination of processes while there are
>> > pages in the balloon. Now there is no way for virtio balloon driver to
>> > free some memory at the last moment before some process will be get
>> > killed by OOM-killer.
>> 
>> This makes some amount of sense.
>
> This reminds me of the balloon fs that Google once proposed.
> This really needs to be controlled from host though.
> At the moment host does not expect guest to deflate before
> requests.
> So as a minimum, add a feature bit for this.  what if you want a mix of
> mandatory and optional balooning? I guess we can use multiple balloons,
> is that the idea?

Trying to claw back some pages on OOM is almost certainly correct,
even if the host doesn't expect it.  It's roughly equivalent to not
giving up pages in the first place.

Cheers,
Rusty.
PS.  Yes, a real guest-driven balloon is preferable, but that's a much
     larger task.
