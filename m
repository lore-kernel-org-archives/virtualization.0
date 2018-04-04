From: David Miller <davem@davemloft.net>
Subject: Re: [RFC PATCH 2/3] netdev: kernel-only IFF_HIDDEN netdevice
Date: Wed, 04 Apr 2018 13:42:41 -0400 (EDT)
Message-ID: <20180404.134241.569157404061843307.davem__23117.6267182038$1522863664$gmane$org@davemloft.net>
References: <3bdfc39f-4935-2433-7982-9ce28c3aa166@gmail.com>
	<CADGSJ22qmdzY8AiOfQdFdmR7T6rehTp-hHHj1U10XGad0bTb8A@mail.gmail.com>
	<b0f5e27b-0be1-311e-f3f3-f79af5cd4521@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <b0f5e27b-0be1-311e-f3f3-f79af5cd4521@gmail.com>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/virtualization/>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: dsahern@gmail.com
Cc: alexander.h.duyck@intel.com, jiri@resnulli.us, mst@redhat.com, kubakici@wp.pl, sridhar.samudrala@intel.com, virtualization@lists.linux-foundation.org, loseweigh@gmail.com, netdev@vger.kernel.org, si-wei.liu@oracle.com
List-Id: virtualization@lists.linuxfoundation.org

From: David Ahern <dsahern@gmail.com>
Date: Wed, 4 Apr 2018 11:37:52 -0600

> Networking vendors have out of tree kernel modules. Those modules use a
> netdev (call it a master netdev, a control netdev, cpu port, whatever)
> to pull packets from the ASIC and deliver to virtual netdevices
> representing physical ports. The master netdev should not be mucked with
> by a user. It should be ignored by certain s/w with lldpd as just an
> *example*.

Two approaches:

1) Add an IFF_CONTROL and make userspace understand this.  It is probably
   long overdue.

2) Design the driver properly.  Have a non-netdev master device like
   mlxsw does, and control it using devlink or similar.  This is exactly
   how this stuff was meant to be architected.

> From there I think you are confusing my intentions: I fundamentally do
> not believe the kernel should be hiding anything from an admin. Not
> showing data by default is completely different than not showing that
> data at all.

It is the same David.

It measn we have no intention of fixing applications to properly know
what to do with and how to handle these devices.

If you hide these objects, we are basically giving up on fixing the
tools and or the drivers themselves to be architected differently
(see #2 above).

That really isn't acceptable in my opinion.

> The intention of my patch with the IFF_HIDDEN attribute is:
> 1. it is a netdev attribute
> 
> 2. that attribute can be used by userpsace to indicate to the kernel I
> want all or I want the default
> 
> 3. that attribute can be controlled by an admin.
> 
> The patches go beyond my specific use case (preventing a user from
> modifying a netdev it should not be touching) but to defining the
> semantics of a generic capability which is what the kernel should have.

"Teach, do not hide!" -Yoda
