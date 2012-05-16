From: Dor Laor <dlaor@redhat.com>
Subject: Re: [vmw_vmci RFC 00/11] VMCI for Linux
Date: Wed, 16 May 2012 11:55:04 +0300
Message-ID: <4FB36B68.5000009@redhat.com>
References: <1337094428-20453-1-git-send-email-astiegmann@vmware.com>
	<20120515235024.GB1758@kroah.com>
Reply-To: dlaor@redhat.com
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <20120515235024.GB1758@kroah.com>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/virtualization/>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: Greg KH <gregkh@linuxfoundation.org>
Cc: acking@vmware.com, kvm-devel <kvm@vger.kernel.org>, dtor@vmware.com, linux-kernel@vger.kernel.org, virtualization@lists.linux-foundation.org, dsouders@vmware.com, Amit Shah <amit.shah@redhat.com>, "Andrew Stiegmann (stieg)" <astiegmann@vmware.com>, akpm@linux-foundation.org, cschamp@vmware.com
List-Id: virtualization@lists.linuxfoundation.org

On 05/16/2012 02:50 AM, Greg KH wrote:
> On Tue, May 15, 2012 at 08:06:57AM -0700, Andrew Stiegmann (stieg) wrote:
>> In an effort to improve the out-of-the-box experience with Linux
>> kernels for VMware users, VMware is working on readying the Virtual
>> Machine Communication Interface (vmw_vmci) and VMCI Sockets (vmw_vsock) kernel
>> modules for inclusion in the Linux kernel. The purpose of this post
>> is to acquire feedback on the vmw_vmci kernel module. The vmw_vsock
>> kernel module will be presented in a later post.
>>
>> VMCI allows virtual machines to communicate with host kernel modules
>> and the VMware hypervisors. User level applications both in a virtual
>> machine and on the host can use vmw_vmci through VMCI Sockets, a socket
>> address family designed to be compatible with UDP and TCP at the
>> interface level. Today, VMCI and VMCI Sockets are used by the VMware
>> shared folders (HGFS) and various VMware Tools components inside the
>> guest for zero-config, network-less access to VMware host services. In
>> addition to this, VMware's users are using VMCI Sockets for various
>> applications, where network access of the virtual machine is
>> restricted or non-existent. Examples of this are VMs communicating
>> with device proxies for proprietary hardware running as host
>> applications and automated testing of applications running within
>> virtual machines.
>>
>> In a virtual machine, VMCI is exposed as a regular PCI device. The
>> primary communication mechanisms supported are a point-to-point
>> bidirectional transport based on a pair of memory-mapped queues, and
>> asynchronous notifications in the form of datagrams and
>> doorbells. These features are available to kernel level components
>> such as HGFS and VMCI Sockets through the VMCI kernel API. In addition
>> to this, the VMCI kernel API provides support for receiving events
>> related to the state of the VMCI communication channels, and the
>> virtual machine itself.
>
> Don't we have something like this already for KVM and maybe Xen?

We have virtio-serial driver for guest-host communication:
http://fedoraproject.org/wiki/Features/VirtioSerial
http://www.linux-kvm.org/page/VMchannel_Requirements

Amit Shah, the writer is CCed as well as kvm-devel.

> virtio?  Can't you use that code instead of a new block of code that is
> only used by vmware users?  It has virtual pci devices which should give
> you what you want/need here, right?
>
> If not, why doesn't that work for you?  Would it be easier to just
> extend it?

KVM uses virtio-serial as a pci device which has 'ports' on top of it. 
The ports acts like channels that can be created dynamically and allows 
guest userspace <-> host userspace communication.
In theory, the kvm mechanism should be a good fit for other hypervisors.

Nevertheless, despite my biased love for KVM, I bet it would be 'tricky' 
for VMW to change their hardware model and shift to virtio hardware 
abstraction. In addition, they'll be required to change existing apps 
that use their socket code.

One can bunker in our rightful requirement of 'upstream first' but this 
may slow/vanish the benefits of getting VMW code upstream for out of the 
box experience for Linux users.

IMHO, let's be practical and include this pci device (pending standard 
review) but _require_ that the VMCI sockets family will be a general 
mechanism that may be used over virtio-serial as well.
Andrew, it would be the best to work w/ Amit and various other KVM 
hackers to get your (changed) code upstream.

Regards,
Dor

>
> thanks,
>
> greg k-h
> --
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/
