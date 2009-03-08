From: Avi Kivity <avi@redhat.com>
Subject: Re: Help - KVM TODO_NOV2008_Sharing Memory between guests
Date: Sun, 08 Mar 2009 16:21:14 +0200
Message-ID: <49B3D45A.8030200@redhat.com>
References: <b20fe0330902210535p1efb68bcv282853c5f4f08f3b@mail.gmail.com>	
	<49A549F1.8000901@redhat.com> <49A566AC.3010208@codemonkey.ws>
	<b20fe0330903040612m784b273ew7bca3c8ad087990a@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <b20fe0330903040612m784b273ew7bca3c8ad087990a@mail.gmail.com>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/virtualization>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: PICT PUNE <kvm.smartshare@gmail.com>
Cc: Anthony Liguori <anthony@codemonkey.ws>, virtualization@lists.linux-foundation.org
List-Id: virtualization@lists.linuxfoundation.org

PICT PUNE wrote:
>
>
> On Wed, Feb 25, 2009 at 9:11 PM, Anthony Liguori 
> <anthony@codemonkey.ws <mailto:anthony@codemonkey.ws>> wrote:
>
>     Avi Kivity wrote:
>
>         PICT PUNE wrote:
>
>             In reference to the November 2008 todo list on Qumranet
>             Website
>
>             we are a group of college students working on this todo:
>
>             *Add a qemu interface for sharing memory between guests.
>             Using a pci device to expose the shared memory is probably
>             a good starting point.
>             *
>             Can anyone suggest us some starting point or a possible
>             approach for the same...
>
>
>         Write a PCI device that exposes a BAR containing RAM.
>          Implement the RAM by mapping a shared memory segment or a
>         file.  Write a guest driver to use this shared RAM.
>
>
>     Or implement a virtio device that can advertise available shared
>     memory segments.  Have guest allocate its own memory to send to
>     host that becomes the shared memory segment.
>
>     Expose shared memory mappings via a virtual file system (similar
>     to hugetlbfs or ramfs).
>
>     Using PCI BARs implies static shared memory mappings.  For a long
>     running VM, you're likely to want to support dynamic shared memory
>     mappings.
>
>     Also exposing a simple signaling mechanism with this too would
>     allow for shared ring queues to be implemented in userspace
>     between guests.
>
>     Regards,
>
>     Anthony Liguori
>
>
> Hello Mr. Avi Kivity  and Mr. Anthony Liguori
>
> Thanks for your early reply. We expecting the same approach.

There were two approaches outlined above.  Which one do you mean?

> We are in process of making clusters of free memory  and reserve these 
> memory as a fake PCI device for the guest  OS. this device will be 
> then passed using PCI passthrough  to the guest from the host.

PCI passthrough does not make much sense in this context, is this what 
you meant?

> Can you please help us in faking the free memory cluster as a PCI 
> device. Thanking in anticipation.
>

I suggest reading the code of framebuffer devices such as vga.c.

-- 
error compiling committee.c: too many arguments to function
