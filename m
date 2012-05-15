From: Greg KH <gregkh@linuxfoundation.org>
Subject: Re: [vmw_vmci RFC 00/11] VMCI for Linux
Date: Tue, 15 May 2012 16:50:24 -0700
Message-ID: <20120515235024.GB1758__49704.3389165357$1337186504$gmane$org@kroah.com>
References: <1337094428-20453-1-git-send-email-astiegmann@vmware.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
Content-Disposition: inline
In-Reply-To: <1337094428-20453-1-git-send-email-astiegmann@vmware.com>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/virtualization/>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: "Andrew Stiegmann (stieg)" <astiegmann@vmware.com>
Cc: acking@vmware.com, dtor@vmware.com, linux-kernel@vger.kernel.org, virtualization@lists.linux-foundation.org, dsouders@vmware.com, akpm@linux-foundation.org, cschamp@vmware.com
List-Id: virtualization@lists.linuxfoundation.org

On Tue, May 15, 2012 at 08:06:57AM -0700, Andrew Stiegmann (stieg) wrote:
> In an effort to improve the out-of-the-box experience with Linux
> kernels for VMware users, VMware is working on readying the Virtual
> Machine Communication Interface (vmw_vmci) and VMCI Sockets (vmw_vsock) kernel
> modules for inclusion in the Linux kernel. The purpose of this post
> is to acquire feedback on the vmw_vmci kernel module. The vmw_vsock
> kernel module will be presented in a later post.
> 
> VMCI allows virtual machines to communicate with host kernel modules
> and the VMware hypervisors. User level applications both in a virtual
> machine and on the host can use vmw_vmci through VMCI Sockets, a socket
> address family designed to be compatible with UDP and TCP at the
> interface level. Today, VMCI and VMCI Sockets are used by the VMware
> shared folders (HGFS) and various VMware Tools components inside the
> guest for zero-config, network-less access to VMware host services. In
> addition to this, VMware's users are using VMCI Sockets for various
> applications, where network access of the virtual machine is
> restricted or non-existent. Examples of this are VMs communicating
> with device proxies for proprietary hardware running as host
> applications and automated testing of applications running within
> virtual machines.
> 
> In a virtual machine, VMCI is exposed as a regular PCI device. The
> primary communication mechanisms supported are a point-to-point
> bidirectional transport based on a pair of memory-mapped queues, and
> asynchronous notifications in the form of datagrams and
> doorbells. These features are available to kernel level components
> such as HGFS and VMCI Sockets through the VMCI kernel API. In addition
> to this, the VMCI kernel API provides support for receiving events
> related to the state of the VMCI communication channels, and the
> virtual machine itself.

Don't we have something like this already for KVM and maybe Xen?
virtio?  Can't you use that code instead of a new block of code that is
only used by vmware users?  It has virtual pci devices which should give
you what you want/need here, right?

If not, why doesn't that work for you?  Would it be easier to just
extend it?

thanks,

greg k-h
