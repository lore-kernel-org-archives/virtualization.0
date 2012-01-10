From: Jeremy Fitzhardinge <jeremy@goop.org>
Subject: Re: [Xen-devel] [PATCH] xen: remove CONFIG_XEN_DOM0 compile option
Date: Tue, 10 Jan 2012 11:57:42 +1100
Message-ID: <4F0B8D06.8050501__45011.4141837277$1326410111$gmane$org@goop.org>
References: <3f35c565-bcaf-49d2-ba46-c61ca95aa51b@zmail13.collab.prod.int.phx2.redhat.com>
	<alpine.DEB.2.00.1201091838490.3150@kaball-desktop>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <alpine.DEB.2.00.1201091838490.3150@kaball-desktop>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/virtualization/>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: Stefano Stabellini <stefano.stabellini@eu.citrix.com>
Cc: Andrew Jones <drjones@redhat.com>, "xen-devel@lists.xensource.com" <xen-devel@lists.xensource.com>, "virtualization@lists.linux-foundation.org" <virtualization@lists.linux-foundation.org>, Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>
List-Id: virtualization@lists.linuxfoundation.org

On 01/10/2012 05:44 AM, Stefano Stabellini wrote:
> On Mon, 9 Jan 2012, Andrew Jones wrote:
>> I guess if we did the s/XEN_DOM0/LOCAL_APIC && IO_APIC && ACPI/ in
>> arch/x86/pci/xen.c it would be pretty easy to review for equivalence.
>> Then keep CONFIG_PRIVILIGED, but drop XEN_DOM0 from everywhere else and
>> compile in the 3 files. I don't think it makes much sense to do it
>> though. XEN_DOM0 keeps things tidier now and might be useful later.
> we can keep things clean with the following:
>
> #ifdef CONFIG_LOCAL_APIC && CONFIG_IO_APIC && CONFIG_ACPI && CONFIG_PCI_XEN
>
> #define XEN_DOM0
>
> #endif
>
> in include/xen/xen.h.
>
> So in the source files we can still '#ifdef XEN_DOM0', but at the same
> time we can get rid of the build symbol: everybody wins.

No, really, I think this is silly.  This kind of dependency information
should be encoded in the Kconfig system, and not reimplemented in an
ad-hoc way.

If there were a clean way to do what Andrew wants then I'd support it,
but this thread has descended into a spiral of madness, which makes me
think its a lost cause.

If the root complaint is that "customers think that anything set in
.config is a supported feature", then the solutions are to support all
the features in .config, re-educate the customers that they're wrong, or
maintain a local patch to do this stuff.

    J
