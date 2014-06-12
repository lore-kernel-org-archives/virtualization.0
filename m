From: Vincent JARDIN <vincent.jardin@6wind.com>
Subject: Re: Why I advise against using ivshmem
Date: Thu, 12 Jun 2014 18:02:17 +0200
Message-ID: <5399CF09.8030803__11699.5815224529$1402588950$gmane$org@6wind.com>
References: <20140610184818.2e490419@nbschild1> <53978375.6090707@6wind.com>
	<87ppie1v4r.fsf@blackfin.pond.sub.org>
	<20140612094413.15e56938@nbschild1>
	<87vbs6qjhj.fsf_-_@blackfin.pond.sub.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <87vbs6qjhj.fsf_-_@blackfin.pond.sub.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/virtualization/>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: Markus Armbruster <armbru@redhat.com>
Cc: Henning Schild <henning.schild@siemens.com>, David Marchand <david.marchand@6wind.com>, qemu-devel@nongnu.org, kvm@vger.kernel.org, virtualization@lists.linux-foundation.org
List-Id: virtualization@lists.linuxfoundation.org

Markus,

see inline (I am not on all mailing list, please, keep the cc list).

 > Sure!  The reasons for my dislike range from practical to
 > philosophical.
>
> My practical concerns include:
>
> 1. ivshmem code needs work, but has no maintainer
See David's contributions:
   http://patchwork.ozlabs.org/patch/358750/

> 2. There is no libvirt support

One can use qemu without libvivrt.

> 3. Out-of-tree server program required for full functionality

We have the source code, it provides the documentation to write our own 
better server program.

> 4. Out-of-tree kernel uio driver required

No, it is optional.

> These concerns are all fixable, but it'll take serious work, and time.
> Something like:
>
> * Find a maintainer for the device model
I guess, we can find it into the DPDK.org community.

> * Review and fix its code
>
> * Get the required kernel module upstream

which module? uio, it is not required.

> * Get all the required parts outside QEMU packaged in major distros, or
>    absorbed into QEMU

Redhat did disable it. why? it is there in QEMU.

> In short, create a viable community around ivshmem, either within the
> QEMU community, or separately but cooperating.

At least, DPDK.org community is a community using it.

> On to the more philosophical ones.
>
> 5. Out-of-tree interface required
>
>     Paraphrasing an old quip: Some people, when confronted with a
>     problem, think "I know, I'll use shared memory."  Now they have two
>     problems.
>
>     Shared memory is not an interface.  It's at best something you can
>     use to build an interface.
>
>     I'd rather have us offer something with a little bit more structure.
>     Very fast guest-to-guest networking perhaps.

It is not just networking, you have other use cases like HPC, sharing 
in-memory databases.

>
> 6. Device models belong into QEMU
>
>     Say you build an actual interface on top of ivshmem.  Then ivshmem in
>     QEMU together with the supporting host code outside QEMU (see 3.) and
>     the lower layer of the code using it in guests (kernel + user space)
>     provide something that to me very much looks like a device model.
>
>     Device models belong into QEMU.  It's what QEMU does.
See my previous statement, it is not just device model.


Best regards,
   Vincent
