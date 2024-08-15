Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 01C042AF12
	for <virtualization@lists.linux.dev>; Thu, 15 Aug 2024 16:22:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.176.79.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723738951; cv=none; b=lLYIjNYN0PnReQOfQZPD0igar+QWgyLoFbHwmVNIRdFZUbSeG33shhgqtdG3ufdsO45aZo3fnP/S7NPWgeGkrnhYMPdyy4tX2iptO5oXuedXffc32pRRLyoh+Lg7Df/TYxlbr2gTF2BzIaSSJgPhKxXIpYpQOaN3lMS2Ob8jrWw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723738951; c=relaxed/simple;
	bh=iXkFgiKrYoN6m5dmtYamL8Huc801R1/3tPfFl71drfI=;
	h=Date:From:To:CC:Subject:Message-ID:MIME-Version:Content-Type; b=nHLf1T6DdYHLRg73BnvUIVQ0SGnt33XcihfBrpCxHO+n2qU8K42mqJRvl/szjYGTdvM8Dzgs1PJxxwF5OsIyChD/gDffIUc+W9AF/Y+pqs7jVSR62bUH3NddnGonLPq7LgzNKBZWph4cZSTg6nQKhUegCAKmgaanfSjWhr/GhUY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=Huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=185.176.79.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=Huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.18.186.31])
	by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4Wl9Lm6jLqz6K9B7;
	Fri, 16 Aug 2024 00:19:44 +0800 (CST)
Received: from lhrpeml500005.china.huawei.com (unknown [7.191.163.240])
	by mail.maildlp.com (Postfix) with ESMTPS id 5D968140A87;
	Fri, 16 Aug 2024 00:22:26 +0800 (CST)
Received: from localhost (10.203.177.66) by lhrpeml500005.china.huawei.com
 (7.191.163.240) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.1.2507.39; Thu, 15 Aug
 2024 17:22:25 +0100
Date: Thu, 15 Aug 2024 17:22:23 +0100
From: Jonathan Cameron <Jonathan.Cameron@Huawei.com>
To: David Hildenbrand <david@redhat.com>, <linux-mm@kvack.org>,
	<linux-cxl@vger.kernel.org>, Davidlohr Bueso <dave@stgolabs.net>, Ira Weiny
	<ira.weiny@intel.com>, John Groves <John@Groves.net>,
	<virtualization@lists.linux.dev>
CC: Oscar Salvador <osalvador@suse.de>, <qemu-devel@nongnu.org>, Dave Jiang
	<dave.jiang@intel.com>, Dan Williams <dan.j.williams@intel.com>,
	<linuxarm@huawei.com>, <wangkefeng.wang@huawei.com>, John Groves
	<jgroves@micron.com>, "Fan   Ni" <fan.ni@samsung.com>, "Navneet   Singh"
	<navneet.singh@intel.com>, "=?UTF-8?Q?=E2=80=9CMichael?= S. =?UTF-8?Q?Tsi?=
 =?UTF-8?Q?rkin=E2=80=9D?=" <mst@redhat.com>, Igor Mammedov
	<imammedo@redhat.com>, Philippe =?UTF-8?Q?Mathieu-Daud=C3=A9?=
	<philmd@linaro.org>
Subject: [RFC] Virtualizing tagged disaggregated memory capacity (app
 specific, multi host shared)
Message-ID: <20240815172223.00001ca7@Huawei.com>
Organization: Huawei Technologies Research and Development (UK) Ltd.
X-Mailer: Claws Mail 4.1.0 (GTK 3.24.33; x86_64-w64-mingw32)
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: lhrpeml500002.china.huawei.com (7.191.160.78) To
 lhrpeml500005.china.huawei.com (7.191.163.240)

Introduction
============

If we think application specific memory (including inter-host shared memory) is
a thing, it will also be a thing people want to use with virtual machines,
potentially nested. So how do we present it at the Host to VM boundary?

This RFC is perhaps premature given we haven't yet merged upstream support for
the bare metal case. However I'd like to get the discussion going given we've
touched briefly on this in a number of CXL sync calls and it is clear no one is
entirely sure what direction make sense.  We may briefly touch on this in the
LPC CXL uconf, but time will be very limited.

Aim here isn't to promote a particular path, but just to describe the problem
and some potential solutions. It may be obvious which one I think is easiest,
but it may be a case of I have that hammer so will hit things with it.
It's also the case that we may not converge on a single solution and end up
with several supported.  That's not a problem as long as there isn't
significant extra maintenance burden etc.  There are subtle differences
between likely deployments that may make certain solutions more attractive
than others.

Whilst I'm very familiar with the bare metal CXL part of this, I'm less
familiar with the Virtual Machine and MM elements.  Hence I'm hoping to
get inputs from David Hildenbrand, particularly around virtio-mem as an
option and many others to help fill in some of the gaps in information.
I'd also like inputs from those like John Groves who are looking at inter-host
sharing.  I've also cc'd the QEMU list given all these solutions are likely
to involve some additional emulation work and QEMU is my preferred choice for
a reference implementation.

I've almost certainly forgotten someone, so please do +CC others.

Background
==========

Skip if you already know all about CXL or similar memory pooling technologies.
I've skipped over many of the details, because they hopefully don't matter for
the core of the questions posed. I'm happy to provide more details though if
this isn't detailed enough.

Memory pool devices
-------------------

CXL and similar technologies bring the option of having an 'appliance' that
provides disaggregated memory to a number of servers with moderately low latency
overhead compared to local memory.  Typically these are multi-head devices
directly connected to Root Ports of a number of different hosts. This design
avoids the latency cost of a switched fabric.

Experimental deployments suggest ratios of around 1 memory pool to 16 CPU
sockets.
[Pond: CXL-Based Memory Pooling Systems for Cloud Platforms, Li et Al.
 ASPLOS '23]

In some deployments, each socket has on it's own connection allowing lowish
latency (perhaps 1.5x typical inter socket), highish bandwidth memory
expansion.  Interleave can further boost the host to appliance bandwidth
at the cost of reducing number of hosts sharing a single appliance.
 __________________   __________________   __________________
| Host A           | | Host B           | | Host C           |
|                  | |                  | |                  |
|   ____    ____   | |   ____    ____   | |   ____    ____   |
|__|_RP_|__|_RP_|__| |__|_RP_|__|_RP_|__| |__|_RP_|__|_RP_|__|
     ||      ||           ||      ||           ||      ||
     ||      ||           ||      ||           ||      ||
 ____||______||___________||______||___________||______||_____
|                                                             |
|                                                             |
|             Memory Appliance.                               |
|                                                             |
|_____________________________________________________________|

CXL memory pooling options
--------------------------

CXL 2.0 provided basic memory pool facilities via hot-plug of entire devices.
This is both expensive to do and inflexible, so not well suited to memory
appliance applications.

CXL 3.0 and onwards introduced Dynamic Capacity in what is known as a Dynamic
Capacity Device (DCD).

We'll need a few key terms:

Host Physical Address (HPA). Region of the host system address map where reads 
and writes will be routed to a particular CXL host bridge. This is considered
a fixed mapping (may be changeable in BIOS) and presented to the host OS via
an ACPI table. These windows are called CXL Fixed Memory Windows (CFMWs)
Yes I'm being lazy here and HPA may not quite be the same as the view a CPU sees
but that's a detail we don't care about here.

Device Physical Address (DPA).  Confusingly this isn't necessarily the
addressing used on a device to access a particular physical address in the DRAM
chips, but rather a presentation of the device memory to a particular host.
There may be another level of translation underneath (this detail will matter
later)

Host Managed Device Memory Decoders (HDM Decoders). Programmable Address
Routers that control the routing of a CXL transaction.

Extents - Contiguous regions of DPA space (offset + size)

Key elements of DCD usage
-------------------------

Device to host address routing is not often changed. Typically it is set up at
boot, either in host firmware, or once the operating system has started. That
is, we'll probably program all the HDM Decoders once per boot. They may be left
in a state where the host can reprogram them, or locked down.

Regions of the DPA space that these decoders are routing the accesses to may
not be backed by anything. A slight simplification is that these unbacked
addresses read zero, and writes are dropped.

Later on, some magic entity - let's call it an orchestrator, will tell the
memory pool to provide memory to a given host. The host gets notified by
the device of an 'offer' of specific memory extents and can accept it, after
which it may start to make use of the provided memory extent.

Those address ranges may be shared across multiple hosts (in which case they
are not for general use), or may be dedicated memory intended for use as
normal RAM.

Whilst the granularity of DCD extents is allowed by the specification to be very
fine (64 Bytes), in reality my expectation is no one will build general purpose
memory pool devices with fine granularity.

Memory hot-plug options (bare metal)
------------------------------------

By default, these extents will surface as either:
1) Normal memory hot-plugged into a NUMA node.
2) DAX - requiring applications to map that memory directly or use
   a filesystem etc.

There are various ways to apply policy to this. One is to base the policy
decision on a 'tag' that is associated with a set of DPA extents. That 'tag'
is metadata that originates at the orchestrator. It's big enough to hold a
UUID, so can convey whatever meaning is agreed by the orchestrator and the
software running on each host.

Memory pools tend to want to guarantee, when the circumstances change
(workload finishes etc), they can have the resources they allocated back.
CXL brings polite ways of asking for the memory back and big hammers for
when the host ignores things (which may well crash a naughty host).
Reliable hot unplug of normal memory continues to be a challenge for memory
that is 'normal' because not all its use / lifetime is tied to a particular
application.

Application specific memory
---------------------------

The DAX path enables association of the memory with a single application
by allowing that application to simply mmap appropriate /dev/daxX.Y
That device optionally has an associated tag.

When the application closes or otherwise releases that memory we can
guarantee to be able to recover the capacity.  Memory provided to an
application this way will be referred to here as Application Specific Memory.
This model also works for HBM or other 'better' memory that is reserved for
specific use cases.

So the flow is something like:
1. Cloud orchestrator decides it's going to run in memory database A 
   on host W.
2. Memory appliance Z is told to 'offer' 1TB or memory to host W with
   UUID / tag wwwwxxxxzzzz
3. Host W accepts that memory (why would it say no?) and creates a
   DAX device for which the tag is discoverable.
4. Orchestrator tells host W to launch the workload and that it
   should use the memory provided with tag wwwwxxxxzzzz.
5. Host launches DB and tells it to use DAX device with tag wwwwxxxxzzzz 
   which the DB then mmap()s and loads it's database data into.
... sometime later....
6. Orchestrator tells host W to close that DB ad release the memory
   allocated from the pool.
7. Host gives the memory back to the memory appliance which can then use
   it to provide another host with the necessary memory.

This approach requires applications or at least memory allocation libraries to
be modified.  The guarantees of getting the memory they asked for + that they
will definitely be able to safely give the memory back when done, may make such
software modifications worthwhile.

There are disadvantages and bloat issues if the 'wrong' amount of memory is
allocated to the application. So these techniques only work when the
orchestrator has the necessary information about the workload.

Note that one specific example of application specific memory is virtual
machines.  Just in this case the virtual machine is the application.
Later on it may be useful to consider the example of the specific
application in a VM being a nested virtual machine.

Shared Memory - closely related!
--------------------------------

CXL enables a number of different types of memory sharing across multiple
hosts:
- Read only shared memory (suitable for apache arrow for example)
- Hardware Coherent shared memory.
- Software managed coherency.

These surface using the same machinery as non shared DCD extents. Note however
that the presentation, in terms of extents, to different host is not the same
(can be different extents, in an unrelated order) but along with tags, shared
extents have sufficient data to 'construct' a virtual address to HPA mapping
that makes them look the same to aware  application or file systems.  Current
proposed approach to this is to surface the extents via DAX and apply a
filesystem approach to managing the data.
https://lpc.events/event/18/contributions/1827/

These two types of memory pooling activity (shared memory, application specific
memory) both require capacity associated with a tag to be presented to specific
users in a fashion that is 'separate' from normal memory hot-plug.

The virtualization question
===========================

Having made the assumption that the models above are going to be used in
practice, and that Linux will support them, the natural next step is to
assume that applications designed against them are going to be used in virtual
machines as well as on bare metal hosts.

The open question this RFC is aiming to start discussion around is how best to
present them to the VM.  I want to get that discussion going early because
some of the options I can see will require specification additions and / or
significant PoC / development work to prove them out.  Before we go there,
let us briefly consider other uses of pooled memory in VMs and how theuy
aren't really relevant here.

Other virtualization uses of memory pool capacity
-------------------------------------------------

1. Part of static capacity of VM provided from a memory pool.
   Can be presented as a NUMA setup, with HMAT etc providing performance data
   relative to other memory the VM is using. Recovery of pooled capacity 
   requires shutting down or migrating the VM.
2. Coarse grained memory increases for 'normal' memory.
   Can use memory hot-plug. Recovery of capacity likely to only be possible on
   VM shutdown.

Both these use cases are well covered by existing solutions so we can ignore
them for the rest of this document.

Application specific or shared dynamic capacity - VM options.
-------------------------------------------------------------

1. Memory hot-plug - but with specific purpose memory flag set in EFI
   memory map.  Current default policy is to bring those up as normal memory.
   That policy can be adjusted via kernel option or Kconfig so they turn up
   as DAX.  We 'could' augment the metadata with such hot-plugged memory
   with the UID / tag from an underlying bare metal DAX device.

2. Virtio-mem - It may be possible to fit this use case within an extended
   virtio-mem.

3. Emulate a CXL type 3 device.

4. Other options?

Memory hotplug
--------------

This is the heavy weight solution but should 'work' if we close a specification
gap.  Granularity limitations are unlikely to be a big problem given anticipated
CXL devices.

Today, the EFI memory map has an attribute EFI_MEMORY_SP, for "Specific Purpose
Memory" intended to notify the operating system that it can use the memory as
normal, but it is there for a specific use case and so might be wanted back at
any point. This memory attribute can be provided in the memory map at boot
time and if associated with EfiReservedMemoryType can be used to indicate a
range of HPA Space where memory that is hot-plugged later should be treated as
'special'.

There isn't an obvious path to associate a particular range of hot plugged
memory with a UID / tag.  I'd expect we'd need to add something to the ACPI
specification to enable this.

Virtio-mem
----------

The design goals of virtio-mem [1] mean that it is not 'directly' applicable
to this case, but could perhaps be adapted with the addition of meta data
and DAX + guaranteed removal of explicit extents.

[1] [virtio-mem: Paravirtualized Memory Hot(Un)Plug, David Hildenbrand and
Martin Schulz, Vee'21]

Emulating a CXL Type 3 Device
-----------------------------

Concerns raised about just emulating a CXL topology:
* A CXL Type 3 device is pretty complex.
* All we need is a tag + make it DAX, so surely this is too much?

Possible advantages
* Kernel is exactly the same as that running on the host. No new drivers or
  changes to existing drivers needed as what we are presenting is a possible
  device topology - which may be much simpler that the host.

Complexity:
***********

We don't emulate everything that can exist in physical topologies.
- One emulated device per host CXL Fixed Memory Window
  (I think we can't quite get away with just one in total due to BW/Latency
   discovery)
- Direct connect each emulated device to an emulate RP + Host Bridge. 
- Single CXL Fixed memory Window.  Never present interleave (that's a host
  only problem).
- Can probably always present a single extent per DAX region (if we don't
  mind burning some GPA space to avoid fragmentation).

In most real deployments, that's 1 CFMW, 1 pass through expander bridge, 1 RP
and 1 EP. We would probably lock down the decoders before presentation to the
kernel. Locking down routing is already supported by Linux as a BIOS may do
this. That lock down simplifies the emulation.

We already have most of what is needed emulated and upstream in QEMU with
the exception of a necessary optimization to avoid interleave decoding
(not relevant here, that is all for testing topology handling). PoC level
code exists for that bit.  The other aspect not yet enabled, is hotplugging
additional memory backends into a single CXL Type 3 emulated device. I don't
anticipate that being a problem, but PoC needed to be sure.

One possible corner is that the Dynamic Capacity Flows in a physical machine
require flushing caches due to changes of the physical address map.  Care may
be needed to silently drop such flushes if they are issued from the guest as it
will not actually be changing the physical address map when capacity is added
or released.

Today, Linux associates a single NUMA node with a CXL Fixed Memory
window. Whilst this is a limitation of the Linux handling, to avoid
major changes to that infrastructure it may make sense to present multiple
CXL Fixed Memory windows, so that the Guest can have separate NUMA nodes
for memory pools with different characteristics.

So I agreed complexity of this solution is a valid point, but mostly for
emulation complexity. As emulated devices go it's not that complex (and
we have most of it in place already and upstream in QEMU with Fan's
DCD emulation support going in recently).

Error handling:
***************
What we mostly care about here is memory corruption.  Protocol errors
may be relevant if we an contain the resulting resets, but that is mostly
a host problem.

Synchronous memory errors should surface the same as normal.
Asynchronous errors can either use FW first error injection into the VMM
or inject emulated device errors (some support already in QEMU, additional
support under review).

Conclusion for Type 3 emulation
*******************************
Seems doable.
Complexity is control paths in the VMM.
No kernel changes needed (I think!)

What I'm looking for from this discussion
=========================================

- Blockers!  What problems do people anticipate with each approach?
- General agreement on what we 'might' support in the kernel / QEMU / other VMMs.
- Are there other use cases with similar requirements that we should incorporate?






Appendix : Known corner cases
=============================

These are here mostly for completeness and to track things we need
to solve, rather that because they should greatly influence the
path taken.

CXL Type 3 Performance discovery
--------------------------------

The discussion above suggests that we would represent interleaved CXL devices
as a single device.  Given NUMA characteristics of CXL attached memory are
calculated based partly on the PCIe Link register values that currently 
indicate we have up to a 16x 64GT/s link, to present several higher performance
devices that are interleaved as a single device may require representation of 
a device faster than hardware specifications allow.  If this turns out to be 
a practical problem, solutions such as a PCIe DVSEC capability could be used
to provided accurate information.  If we can ensure the emulated link is not
acting as a bottleneck, the rest of the performance information from the
topology can be mapped to a combination of emulated host HMAT entries and
emulated CDAT data provided by the emulated type 3 device.

Migration
---------

VM migration will either have to remove all extents, or appropriately
prepopulate them prior to migration.  There are possible ways this
may be done with the same memory pool contents via 'temporal' sharing,
but in general this may bring additional complexity.

Kexec etc etc will be similar to how we handle it on the host - probably
just give all the capacity back.
