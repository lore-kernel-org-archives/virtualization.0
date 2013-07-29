From: Greg KH <gregkh@linuxfoundation.org>
Subject: Re: [PATCH] kexec/kdump implementation for Xen PV domU
Date: Mon, 29 Jul 2013 10:42:50 -0700
Message-ID: <20130729174250.GB19271@kroah.com>
References: <20130729171543.GA2600@router-fw-old.local.net-space.pl>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
Content-Disposition: inline
In-Reply-To: <20130729171543.GA2600@router-fw-old.local.net-space.pl>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/virtualization/>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: Daniel Kiper <dkiper@net-space.pl>
Cc: xen-devel@lists.xensource.com, konrad.wilk@oracle.com, daniel.kiper@oracle.com, kexec@lists.infradead.org, linux-kernel@vger.kernel.org, abyde@acunu.com, tim@acunu.com, ebiederm@xmission.com, brandon@ifup.org, grzegorz.milos@gmail.com, virtualization@lists.linux-foundation.org
List-Id: virtualization@lists.linuxfoundation.org

On Mon, Jul 29, 2013 at 07:15:43PM +0200, Daniel Kiper wrote:
> Hi all,
> 
> Here I am sending as attachments patches enabling kexec/kdump
> support in Xen PV domU. Only x84_64 architecture is supported.
> There is no support for i386 but some code could be easily reused.
> Here is a description of patches:
>   - kexec-tools-2.0.3_20120522.patch: patch for kexec-tools
>     which cleanly applies to version 2.0.3,
>   - kexec-kernel-only_20120522.patch: main kexec/kdump kernel patch;
>     it was prepared for quite old custom version of Xen Linux Kernel 2.6.18;
>     it should apply to publicly available Xen Linux Kernel 2.6.18 after
>     doing some needed changes,
>   - kexec-kernel-only_20121119.patch: patch fixes initial boot
>     structures overwrites on machines with memory larger than 1 GiB;
>     this is partial solution,
>   - kexec-kernel-only_20121203.patch: this patch fixes timer
>     issue on Amazon EC2 machines.

<snip>

> All code is GPL 2 licensed (http://www.gnu.org/licenses/gpl-2.0.html).
> Feel free to base your development on this patchset but please do not
> remove any copyrights. Addtionally, I am happy to help anybody who is
> interested in work on this stuff.
> 
> Big thank you for Acunu Ltd. (http://www.acunu.com/) for
> sponsoring initial work on Xen PV domU.

Thanks so much for releasing this code, it's much appreciated.  I'll
take this and work to get it merged upstream as much as possible.

greg k-h
