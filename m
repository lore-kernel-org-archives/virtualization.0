From: Stefano Stabellini <stefano.stabellini@eu.citrix.com>
Subject: Re: [Xen-devel] [PATCH] xen: remove CONFIG_XEN_DOM0 compile option
Date: Mon, 9 Jan 2012 18:44:15 +0000
Message-ID: <alpine.DEB.2.00.1201091838490.3150@kaball-desktop>
References: <3f35c565-bcaf-49d2-ba46-c61ca95aa51b@zmail13.collab.prod.int.phx2.redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <3f35c565-bcaf-49d2-ba46-c61ca95aa51b@zmail13.collab.prod.int.phx2.redhat.com>
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
Cc: "jeremy@goop.org" <jeremy@goop.org>, "xen-devel@lists.xensource.com" <xen-devel@lists.xensource.com>, "virtualization@lists.linux-foundation.org" <virtualization@lists.linux-foundation.org>, Stefano Stabellini <Stefano.Stabellini@eu.citrix.com>, Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>
List-Id: virtualization@lists.linuxfoundation.org

On Mon, 9 Jan 2012, Andrew Jones wrote:
> I guess if we did the s/XEN_DOM0/LOCAL_APIC && IO_APIC && ACPI/ in
> arch/x86/pci/xen.c it would be pretty easy to review for equivalence.
> Then keep CONFIG_PRIVILIGED, but drop XEN_DOM0 from everywhere else and
> compile in the 3 files. I don't think it makes much sense to do it
> though. XEN_DOM0 keeps things tidier now and might be useful later.

we can keep things clean with the following:

#ifdef CONFIG_LOCAL_APIC && CONFIG_IO_APIC && CONFIG_ACPI && CONFIG_PCI_XEN

#define XEN_DOM0

#endif

in include/xen/xen.h.

So in the source files we can still '#ifdef XEN_DOM0', but at the same
time we can get rid of the build symbol: everybody wins.
