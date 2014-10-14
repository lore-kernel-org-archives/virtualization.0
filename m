From: "Michael S. Tsirkin" <mst@redhat.com>
Subject: Re: [PATCH 2/2] virtio_balloon: free some memory from baloon on OOM
Date: Tue, 14 Oct 2014 12:10:22 +0300
Message-ID: <20141014091022.GB6016@redhat.com>
References: <1412763669-2980-1-git-send-email-den@parallels.com>
	<1412763669-2980-3-git-send-email-den@parallels.com>
	<87iojoedq3.fsf@rustcorp.com.au>
	<20141013072201.GB10178@redhat.com>
	<87oatfcz7e.fsf@rustcorp.com.au>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
Content-Disposition: inline
In-Reply-To: <87oatfcz7e.fsf@rustcorp.com.au>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/virtualization/>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: Rusty Russell <rusty@rustcorp.com.au>
Cc: den@openvz.org, "Denis V. Lunev" <den@parallels.com>, Raushaniya Maksudova <rmaksudova@parallels.com>, virtualization@lists.linux-foundation.org
List-Id: virtualization@lists.linuxfoundation.org

On Tue, Oct 14, 2014 at 10:14:05AM +1030, Rusty Russell wrote:
> "Michael S. Tsirkin" <mst@redhat.com> writes:
> 
> > On Mon, Oct 13, 2014 at 04:02:52PM +1030, Rusty Russell wrote:
> >> "Denis V. Lunev" <den@parallels.com> writes:
> >> > From: Raushaniya Maksudova <rmaksudova@parallels.com>
> >> >
> >> > Excessive virtio_balloon inflation can cause invocation of OOM-killer,
> >> > when Linux is under severe memory pressure. Various mechanisms are
> >> > responsible for correct virtio_balloon memory management. Nevertheless
> >> > it is often the case that these control tools does not have enough time
> >> > to react on fast changing memory load. As a result OS runs out of memory
> >> > and invokes OOM-killer. The balancing of memory by use of the virtio
> >> > balloon should not cause the termination of processes while there are
> >> > pages in the balloon. Now there is no way for virtio balloon driver to
> >> > free some memory at the last moment before some process will be get
> >> > killed by OOM-killer.
> >> 
> >> This makes some amount of sense.
> >
> > This reminds me of the balloon fs that Google once proposed.
> > This really needs to be controlled from host though.
> > At the moment host does not expect guest to deflate before
> > requests.
> > So as a minimum, add a feature bit for this.  what if you want a mix of
> > mandatory and optional balooning? I guess we can use multiple balloons,
> > is that the idea?
> 
> Trying to claw back some pages on OOM is almost certainly correct,
> even if the host doesn't expect it.  It's roughly equivalent to not
> giving up pages in the first place.

Well the difference is that there are management tools that
poll balloon in host until they see balloon size reaches
the expected value.

They don't expect balloon to shrink below num_pages and will respond in various
unexpected ways like e.g. killing the VM if it does.
Killing a userspace process within the guest might be better
for VM health.

Besides the fact that we always did it like this, these tools seem to have
basis in the spec.
Specifically, this is based on this text from the spec:
	the device asks for a certain amount of memory, and the driver
	supplies it (or withdraws it, if the device has more than it asks for).
	This allows the guest to adapt to changes in allowance of underlying
	physical memory.

and

	The device is driven by the receipt of a configuration change interrupt.



> Cheers,
> Rusty.
> PS.  Yes, a real guest-driven balloon is preferable, but that's a much
>      larger task.


Any objection to making the feature depend on a feature flag?

-- 
MST
