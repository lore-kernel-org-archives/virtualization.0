From: Arnd Bergmann <arnd@arndb.de>
Subject: Re: [RFC 1/4] New virtio bus driver
Date: Mon, 9 Jul 2007 16:24:57 +0200
Message-ID: <200707091624.57725.arnd@arndb.de>
References: <20070706124200.988637662@arndb.de>
	<200707091338.20288.arnd@arndb.de> <4692257F.4070909@qumranet.com>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <4692257F.4070909@qumranet.com>
Content-Disposition: inline
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/virtualization>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: Avi Kivity <avi@qumranet.com>
Cc: virtualization@lists.linux-foundation.org
List-Id: virtualization@lists.linuxfoundation.org

On Monday 09 July 2007, Avi Kivity wrote:
> Suppose there is one message queued. =A0The host reconfigures and sends=
=20
> the message. A new reconfiguration event now cannot be propagated.
>=20
> If there are two messages queued, the host can post the updates in the=20
> second message. =A0The guest would then post two new messages (since it=
=20
> can't tell whether any reconfiguration events occured after the second=20
> message), the host would fill one, and everyone is happy.

But you can always have one more event than you have space in the queue,
so the host _still_ needs to do its own queuing of these events.

> Rusty, If you agree with this, I think it needs to be added to the core=
=20
> protocol.

Why is it part of the core protocol? If a driver needs a feature like
this, it needs to have an additional virtqueue, but the core does not
need to care that this is about reconfiguration.

I would make a clear distinction between the stuff that is in the
initial config space (read-only) and other things that can be reconfigure=
d.
If a device needs to read a property that can dynamically change,
it probably makes sense for it to start by reading from the configuration
virtqueue instead of the static config space.

> [btw, virtbus could be implemented atop virtqueue as well]

You mean 'one virtbus'? Certainly, that sounds good. You can have
a virtio device with a single read-only virtqueue that emits messages
about other devices coming and going.
I think that is how Carsten's s390 virtual device bus works.

For virtbus in general, I'd think that this model would only be one
of several possible, where the others could be PCI and whatever Xen
prefers for device enumeration (I haven't looked at that in detail).

[interesting side effect: you can have a PCI device that actually
is a virtbus bridge device, as the parent for other hcall based
virtio devices, along with other PCI devices, some of which are
a virtio device by themselves.]

	Arnd <><
