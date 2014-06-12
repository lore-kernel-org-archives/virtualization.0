From: Markus Armbruster <armbru@redhat.com>
Subject: Why I advise against using ivshmem (was: [Qemu-devel] Using virtio
	for inter-VM communication)
Date: Thu, 12 Jun 2014 16:40:24 +0200
Message-ID: <87vbs6qjhj.fsf_-___16828.6686334342$1402584042$gmane$org@blackfin.pond.sub.org>
References: <20140610184818.2e490419@nbschild1> <53978375.6090707@6wind.com>
	<87ppie1v4r.fsf@blackfin.pond.sub.org>
	<20140612094413.15e56938@nbschild1>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <20140612094413.15e56938@nbschild1> (Henning Schild's message of
	"Thu, 12 Jun 2014 09:44:13 +0200")
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/virtualization/>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: Henning Schild <henning.schild@siemens.com>
Cc: Vincent JARDIN <vincent.jardin@6wind.com>, qemu-devel@nongnu.org, kvm@vger.kernel.org, virtualization@lists.linux-foundation.org
List-Id: virtualization@lists.linuxfoundation.org

Henning Schild <henning.schild@siemens.com> writes:

> On Thu, 12 Jun 2014 08:48:04 +0200
> Markus Armbruster <armbru@redhat.com> wrote:
>
>> Vincent JARDIN <vincent.jardin@6wind.com> writes:
>> 
>> > On 10/06/2014 18:48, Henning Schild wrote:> Hi,
>> >> In a first prototype i implemented a ivshmem[2] device for the
>> >> hypervisor. That way we can share memory between virtual machines.
>> >> Ivshmem is nice and simple but does not seem to be used anymore.
>> >> And it
>> >> does not define higher level devices, like a console.
>> >
>> > FYI, ivhsmem is used here:
>> >   http://dpdk.org/browse/memnic/tree/
>> >
>> > http://dpdk.org/browse/memnic/tree/pmd/pmd_memnic.c#n449
>> >
>> > There are some few other references too, if needed.
>> 
>> It may be used, but that doesn't mean it's maintained, or robust
>> against abuse.  My advice is to steer clear of it.
>
> Could you elaborate on why you advice against it?

Sure!  The reasons for my dislike range from practical to philosophical.

My practical concerns include:

1. ivshmem code needs work, but has no maintainer

   - Error handling is generally poor.  For instance, "device_add
     ivshmem" kills your guest instantly.

   - More subjectively, I don't trust the code to be robust against
     abuse by our own guest, or the other guests sharing the memory.
     Convincing me would take a code audit.

   - MAINTAINERS doesn't cover ivshmem.c.

   - The last non-trivial commit that isn't obviously part of some
     tree-wide infrastructure or cleanup work is from September 2012
     (commit c08ba66).

2. There is no libvirt support

3. Out-of-tree server program required for full functionality

   Interrupts require a "shared memory server" running in the host (see
   docs/specs/ivshmem_device_spec.txt).  It doesn't tell where to find
   one.  The initial commit 6cbf4c8 points to
   <www.gitorious.org/nahanni>.  That repository's last commit is from
   September 2012.  He's dead, Jim.

   ivshmem_device_spec.txt is silent on what the server is supposed to
   do.

   If this server requires privileges: I don't trust it without an
   audit.

4. Out-of-tree kernel uio driver required

   The device is "intended to be used with the provided UIO driver"
   (ivshmem_device_spec.txt again).  As far as I can tell, the "provided
   UIO driver" is the one in the dead Nahanni repo.

   By now, you should be expecting this: I don't trust that one either.

These concerns are all fixable, but it'll take serious work, and time.
Something like:

* Find a maintainer for the device model

* Review and fix its code

* Get the required kernel module upstream

* Get all the required parts outside QEMU packaged in major distros, or
  absorbed into QEMU

In short, create a viable community around ivshmem, either within the
QEMU community, or separately but cooperating.

On to the more philosophical ones.

5. Out-of-tree interface required

   Paraphrasing an old quip: Some people, when confronted with a
   problem, think "I know, I'll use shared memory."  Now they have two
   problems.

   Shared memory is not an interface.  It's at best something you can
   use to build an interface.

   I'd rather have us offer something with a little bit more structure.
   Very fast guest-to-guest networking perhaps.

6. Device models belong into QEMU

   Say you build an actual interface on top of ivshmem.  Then ivshmem in
   QEMU together with the supporting host code outside QEMU (see 3.) and
   the lower layer of the code using it in guests (kernel + user space)
   provide something that to me very much looks like a device model.

   Device models belong into QEMU.  It's what QEMU does.

   To all currently using ivshmem or contemplating its use: I'd like to
   invite you to work with the QEMU community to get your use case
   served better.  You could start worse than with explaining it to us.

   In case you'd rather not work with the QEMU community: I'm not
   passing judgement on that (heck, I have had days when I'd rather not,
   too).  But if somebody's reasons not to work with us include GPL
   circumvention, then that somebody is a scoundrel.
