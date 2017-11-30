From: "Michael S. Tsirkin" <mst@redhat.com>
Subject: Re: [RFC] virtio-net: help live migrate SR-IOV devices
Date: Thu, 30 Nov 2017 16:11:04 +0200
Message-ID: <20171130155612-mutt-send-email-mst__19645.7597347491$1512051098$gmane$org@kernel.org>
References: <20171128112722.00003716@intel.com>
	<0fb552d4-1bfc-e130-4fc1-87b83873916d@redhat.com>
	<CAEHy93LneRXNWo64uyN2dfyDX6t18WN+YwVF2RXXLRnr0=Jhww@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
Content-Disposition: inline
In-Reply-To: <CAEHy93LneRXNWo64uyN2dfyDX6t18WN+YwVF2RXXLRnr0=Jhww@mail.gmail.com>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/virtualization/>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: achiad shochat <achiad.mellanox@gmail.com>
Cc: Jakub Kicinski <jakub.kicinski@netronome.com>, Hannes Frederic Sowa <hannes@redhat.com>, Sridhar Samudrala <sridhar.samudrala@intel.com>, netdev <netdev@vger.kernel.org>, virtualization@lists.linux-foundation.org, Achiad <achiad@mellanox.com>, Peter Waskiewicz Jr <peter.waskiewicz.jr@intel.com>, "Singhai,
	Anjali" <anjali.singhai@intel.com>, Andy Gospodarek <gospo@broadcom.com>, Or Gerlitz <gerlitz.or@gmail.com>
List-Id: virtualization@lists.linuxfoundation.org

On Thu, Nov 30, 2017 at 10:08:45AM +0200, achiad shochat wrote:
> Re. problem #2:
> Indeed the best way to address it seems to be to enslave the VF driver
> netdev under a persistent anchor netdev.
> And it's indeed desired to allow (but not enforce) PV netdev and VF
> netdev to work in conjunction.
> And it's indeed desired that this enslavement logic work out-of-the box.
> But in case of PV+VF some configurable policies must be in place (and
> they'd better be generic rather than differ per PV technology).
> For example - based on which characteristics should the PV+VF coupling
> be done? netvsc uses MAC address, but that might not always be the
> desire.

It's a policy but not guest userspace policy.

The hypervisor certainly knows.

Are you concerned that someone might want to create two devices with the
same MAC for an unrelated reason?  If so, hypervisor could easily set a
flag in the virtio device to say "this is a backup, use MAC to find
another device".

> Another example - when to use PV and when to use VF? One may want to
> use PV only if VF is gone/down, while others may want to use PV also
> when VF is up, e.g for multicasting.

There are a bunch of configurations where these two devices share
the same physical backend. In that case there is no point
in multicasting through both devices, in fact, PV might
not even work at all when passthrough is active.

IMHO these cases are what's worth handling in the kernel.

When there are two separate backends, we are getting into policy and
it's best to leave this to userspace (and it's unlikely network manager
will automatically do the right thing here, either).


> I think the right way to address it is to have a new dedicated module
> for this purpose.
> Have it automatically enslave PV and VF netdevs according to user
> configured policy. Enslave the VF even if there is no PV device at
> all.
> 
> This way we get:
> 1) Optimal migration performance

This remains to be proved.

> 2) A PV agnostic (VM may be migrated even from one PV technology to
> another)

Yes - in theory kvm could expose both a virtio and a hyperv device. But what
would be the point? Just do the abstraction in the hypervisor.

> and HW device agnostic solution

That's useful but I don't think we need to involve userspace for that.
HW abstraction is kernel's job.

>     A dedicated generic module will also enforce a lower common
> denominator of guest netdev features, preventing migration dependency
> on source/guest machine capabilities.

If all we are discussing is where this code should live, then I
do not really care. Let's implement it in virtio, then if we
find we have a lot of common we can factor it out.

> 3) Out-of-the box solution yet with generic methods for policy setting
> 
> 
> Thanks

There's no real policy that guest can set though. All setting happens
on the hypervisor side.

-- 
MST
