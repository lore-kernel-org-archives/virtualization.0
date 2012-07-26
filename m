From: Greg KH <gregkh@linuxfoundation.org>
Subject: Re: [vmw_vmci 00/11] VMCI for Linux
Date: Thu, 26 Jul 2012 16:47:49 -0700
Message-ID: <20120726234749.GA3849@kroah.com>
References: <1343345980-32397-1-git-send-email-astiegmann@vmware.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
Content-Disposition: inline
In-Reply-To: <1343345980-32397-1-git-send-email-astiegmann@vmware.com>
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
Cc: pv-drivers@vmware.com, vm-crosstalk@vmware.com, linux-kernel@vger.kernel.org, cschamp@vmware.com, virtualization@lists.linux-foundation.org
List-Id: virtualization@lists.linuxfoundation.org

On Thu, Jul 26, 2012 at 04:39:29PM -0700, Andrew Stiegmann (stieg) wrote:
> In an effort to improve the out-of-the-box experience with Linux
> kernels for VMware users, VMware is working on readying the Virtual
> Machine Communication Interface (vmw_vmci) and VMCI Sockets
> (vmw_vsock) kernel modules for inclusion in the Linux kernel. The
> purpose of this post is to acquire feedback on the vmw_vmci kernel
> module. The vmw_vsock kernel module will be presented in a later post.

Ugh, you do realize this is the middle of the merge window when we are
all busy doing other things than code review of new stuff, right?  It's
going to be a few weeks before I can look at this, sorry.

good luck,

greg k-h
