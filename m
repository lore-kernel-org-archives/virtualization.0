From: Amit Shah <amit.shah@redhat.com>
Subject: Re: [PATCH v3 2/3] hvc_init(): Enforce one-time initialization.
Date: Tue, 29 Nov 2011 19:51:49 +0530
Message-ID: <20111129142149.GE2822@amit-x200.redhat.com>
References: <20111108214452.28884.14840.stgit@miche.sea.corp.google.com>
	<20111108214504.28884.61814.stgit@miche.sea.corp.google.com>
	<874nybqo0o.fsf@rustcorp.com.au>
	<CAB8RdapbaueyWLJuJDE_ZdvLkRNM4sQHTxgmgO=jrnXZ6YPSmA@mail.gmail.com>
	<20111123103852.GG16665@amit-x200.redhat.com>
	<CAB8RdaoDxMCgTjuGP70bGrsrtgh=USYtU3Spo5OPtVMYAM5EzQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
Content-Disposition: inline
In-Reply-To: <CAB8RdaoDxMCgTjuGP70bGrsrtgh=USYtU3Spo5OPtVMYAM5EzQ@mail.gmail.com>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/virtualization/>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: Miche Baker-Harvey <miche@google.com>
Cc: Stephen Rothwell <sfr@canb.auug.org.au>, xen-devel@lists.xensource.com, Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>, Benjamin Herrenschmidt <benh@kernel.crashing.org>, linux-kernel@vger.kernel.org, virtualization@lists.linux-foundation.org, Anton Blanchard <anton@samba.org>, Mike Waychison <mikew@google.com>, ppc-dev <linuxppc-dev@lists.ozlabs.org>, Greg Kroah-Hartman <gregkh@suse.de>, Eric Northrup <digitaleric@google.com>
List-Id: virtualization@lists.linuxfoundation.org

Hi,

On (Mon) 28 Nov 2011 [15:40:41], Miche Baker-Harvey wrote:
> Amit,
> 
> You said that the work would be serialized "due to port additions
> being on work items on the same workqueue".  I'm not seeing that.

You leave a lot of questions unanswered.  What's your environment?
Are you hot-plugging ports?  Are you using qemu?  What's your command
line?

> I've double checked this by using a mutex_trylock in
> hvc_console::hvc_alloc(), and here's the relevant output from dmesg:
> 
> root@myubuntu:~# dmesg | grep MBH
> [3307216.210274] MBH: got hvc_ports_mutex
> [3307216.210690] MBH: trylock of hvc_ports_mutex failed
> [3307216.211143] MBH: got hvc_ports_mutex
> 
> This is in a system with two virtio console ports, each of which is a
> console.  I think if the VIRTIO_CONSOLE_CONSOLE_PORT message handling
> were actually being serialized, the trylock should never fail.

Agreed.

> What's the source of the serialization for the workqueue items?  At
> first reading it looks like the control_work_handler gets called for
> each virtio interrupt?

It all depends on how you add ports.  If you're using qemu, they
happen via the control work handler.

		Amit
