From: Avi Kivity <avi@redhat.com>
Subject: Re: [PATCHv5 3/3] vhost_net: a kernel-level virtio server
Date: Wed, 23 Sep 2009 17:37:35 +0300
Message-ID: <4ABA32AF.50602__5808.82849540121$1253716895$gmane$org@redhat.com>
References: <4AAFACB5.9050808@redhat.com> <4AAFF437.7060100@gmail.com>
	<4AB0A070.1050400@redhat.com> <4AB0CFA5.6040104@gmail.com>
	<4AB0E2A2.3080409@redhat.com> <4AB0F1EF.5050102@gmail.com>
	<4AB10B67.2050108@redhat.com> <4AB13B09.5040308@gmail.com>
	<4AB151D7.10402@redhat.com> <4AB1A8FD.2010805@gmail.com>
	<20090921214312.GJ7182@ovro.caltech.edu>
	<4AB89C48.4020903@redhat.com> <4ABA3005.60905@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <4ABA3005.60905@gmail.com>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/virtualization>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: Gregory Haskins <gregory.haskins@gmail.com>
Cc: kvm@vger.kernel.org, "Michael S. Tsirkin" <mst@redhat.com>, netdev@vger.kernel.org, "Ira W. Snyder" <iws@ovro.caltech.edu>, linux-kernel@vger.kernel.org, virtualization@lists.linux-foundation.org, linux-mm@kvack.org, s.hetze@linux-ag.com, hpa@zytor.com, mingo@elte.hu, alacrityvm-devel@lists.sourceforge.net, akpm@linux-foundation.org
List-Id: virtualization@lists.linuxfoundation.org

On 09/23/2009 05:26 PM, Gregory Haskins wrote:
>
>    
>>> Yes, I'm having to create my own bus model, a-la lguest, virtio-pci, and
>>> virtio-s390. It isn't especially easy. I can steal lots of code from the
>>> lguest bus model, but sometimes it is good to generalize, especially
>>> after the fourth implemention or so. I think this is what GHaskins tried
>>> to do.
>>>
>>>        
>> Yes.  vbus is more finely layered so there is less code duplication.
>>      
> To clarify, Ira was correct in stating this generalizing some of these
> components was one of the goals for the vbus project: IOW vbus finely
> layers and defines what's below virtio, not replaces it.
>
> You can think of a virtio-stack like this:
>
> --------------------------
> | virtio-net
> --------------------------
> | virtio-ring
> --------------------------
> | virtio-bus
> --------------------------
> | ? undefined ?
> --------------------------
>
> IOW: The way I see it, virtio is a device interface model only.  The
> rest of it is filled in by the virtio-transport and some kind of back-end.
>
> So today, we can complete the "? undefined ?" block like this for KVM:
>
> --------------------------
> | virtio-pci
> --------------------------
>               |
> --------------------------
> | kvm.ko
> --------------------------
> | qemu
> --------------------------
> | tuntap
> --------------------------
>
> In this case, kvm.ko and tuntap are providing plumbing, and qemu is
> providing a backend device model (pci-based, etc).
>
> You can, of course, plug a different stack in (such as virtio-lguest,
> virtio-ira, etc) but you are more or less on your own to recreate many
> of the various facilities contained in that stack (such as things
> provided by QEMU, like discovery/hotswap/addressing), as Ira is discovering.
>
> Vbus tries to commoditize more components in the stack (like the bus
> model and backend-device model) so they don't need to be redesigned each
> time we solve this "virtio-transport" problem.  IOW: stop the
> proliferation of the need for pci-bus, lguest-bus, foo-bus underneath
> virtio.  Instead, we can then focus on the value add on top, like the
> models themselves or the simple glue between them.
>
> So now you might have something like
>
> --------------------------
> | virtio-vbus
> --------------------------
> | vbus-proxy
> --------------------------
> | kvm-guest-connector
> --------------------------
>               |
> --------------------------
> | kvm.ko
> --------------------------
> | kvm-host-connector.ko
> --------------------------
> | vbus.ko
> --------------------------
> | virtio-net-backend.ko
> --------------------------
>
> so now we don't need to worry about the bus-model or the device-model
> framework.  We only need to implement the connector, etc.  This is handy
> when you find yourself in an environment that doesn't support PCI (such
> as Ira's rig, or userspace containers), or when you want to add features
> that PCI doesn't have (such as fluid event channels for things like IPC
> services, or priortizable interrupts, etc).
>    

Well, vbus does more, for example it tunnels interrupts instead of 
exposing them 1:1 on the native interface if it exists.  It also pulls 
parts of the device model into the host kernel.

>> The virtio layering was more or less dictated by Xen which doesn't have
>> shared memory (it uses grant references instead).  As a matter of fact
>> lguest, kvm/pci, and kvm/s390 all have shared memory, as you do, so that
>> part is duplicated.  It's probably possible to add a virtio-shmem.ko
>> library that people who do have shared memory can reuse.
>>      
> Note that I do not believe the Xen folk use virtio, so while I can
> appreciate the foresight that went into that particular aspect of the
> design of the virtio model, I am not sure if its a realistic constraint.
>    

Since a virtio goal was to reduce virtual device driver proliferation, 
it was necessary to accommodate Xen.

-- 
error compiling committee.c: too many arguments to function
