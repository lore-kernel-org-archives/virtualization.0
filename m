From: Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>
Subject: Re: [PATCH 3/4] xen kconfig: add dom0 support help text
Date: Mon, 23 Jan 2012 13:42:42 -0500
Message-ID: <20120123184242.GC12542@phenom.dumpdata.com>
References: <1325842991-4404-1-git-send-email-drjones@redhat.com>
	<1325842991-4404-4-git-send-email-drjones@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
Content-Disposition: inline
In-Reply-To: <1325842991-4404-4-git-send-email-drjones@redhat.com>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/virtualization/>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: Andrew Jones <drjones@redhat.com>
Cc: jeremy@goop.org, xen-devel@lists.xensource.com, virtualization@lists.linux-foundation.org
List-Id: virtualization@lists.linuxfoundation.org

On Fri, Jan 06, 2012 at 10:43:10AM +0100, Andrew Jones wrote:
> Describe dom0 support in the config menu and supply help text for it.

So I had this reply in my draft and forgot to send it. Sorry about that.

My understanding from the converstion was that we try to "squash"
the XEN_DOM0 option so that it would not be present. But that did not
work as it lead to a string of X86_LOCAL_APIC, X86_IO_ACPI, ACPI, PCI,
and so on. Then the .h with #define XEN_something based on those
symbols, but that is not the job of a header file. It is the job
of Kconfig.

The other way was to squash this in with the backend support. Since
we are moving away from having one initial domain, to having
multitple "initial domains" (priviliged domains) where each can
server as a backend.  However (quoting Jeremy) "it is more of
disaggregating the privilege to reduce the amount concentrated in any one
part.  Backends don't need any more privilege than to be able to
access the specific device(s) they're being the backend for."

Interestingly, that means DOM0 is kind of .. well, it should be
no different from a normal HVM guest. The old-style PV dom0 remains
would be ..well, almost nothing. The Xen MMU, and Xen SWIOTLB - those
are the ones that pop in mind for Dom0, but they are also used
for PV PCI. In fact, all (I think?) of the CONFIG_XEN_DOM0 functionality
can be _used_ in a PV guest. The 'if (initial_xen_domain()' should
probably be addressed first and to figure which one of those can be
altered as the "backend domain" can run both frontend and backend drivers
(oh joy!). So more relaxing those config options and/or "if (xen..)".

Anyhow, back to the HVM dom0 - that is in the future - and it is going
to take a couple of years to get it. I would rather not shoot my
foot by removing these CONFIG_* option until we get a better grasp of how
we want to deal with the PV hybrid.

What I am saying is that I don't know what the right answer is,
but I don't believe the patch below is it. I wish I had a better
answer in terms of "do this instead", but none of those worked.

Perhaps we can brainstorm some of this at XenSummit by which time
I hope Mukesh's PV hybrid work will be completed and a lot of the
work on the toolstack for backend drivers will be laid out.

> 
> Signed-off-by: Andrew Jones <drjones@redhat.com>
> ---
>  arch/x86/xen/Kconfig |    7 ++++++-
>  1 files changed, 6 insertions(+), 1 deletions(-)
> 
> diff --git a/arch/x86/xen/Kconfig b/arch/x86/xen/Kconfig
> index 26c731a..88862d5 100644
> --- a/arch/x86/xen/Kconfig
> +++ b/arch/x86/xen/Kconfig
> @@ -14,9 +14,14 @@ config XEN
>  	  Xen hypervisor.
>  
>  config XEN_DOM0
> -	def_bool y
> +	bool "Xen Initial Domain (Dom0) support"
> +	default y
>  	depends on XEN && PCI_XEN && SWIOTLB_XEN
>  	depends on X86_LOCAL_APIC && X86_IO_APIC && ACPI && PCI
> +	help
> +	  This allows the kernel to be used for the initial Xen domain,
> +	  Domain0. This is a privileged guest that supplies backends
> +	  and is used to manage the other Xen domains.
>  
>  # Dummy symbol since people have come to rely on the PRIVILEGED_GUEST
>  # name in tools.
> -- 
> 1.7.7.5
