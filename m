From: Andrew Jones <drjones@redhat.com>
Subject: Re: [Xen-devel] [PATCH 1/4] xen kconfig: keep XEN_XENBUS_FRONTEND
	builtin
Date: Thu, 12 Jan 2012 12:46:03 -0500 (EST)
Message-ID: <38f5d265-e690-4a8c-9d73-b43c804087e3@zmail13.collab.prod.int.phx2.redhat.com>
References: <20120112154206.GA9722@wavehammer.waldi.eu.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <20120112154206.GA9722@wavehammer.waldi.eu.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/virtualization/>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: Bastian Blank <waldi@debian.org>
Cc: jeremy@goop.org, xen-devel@lists.xensource.com, Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>, stefano stabellini <stefano.stabellini@eu.citrix.com>, virtualization@lists.linux-foundation.org, konrad@darnok.org
List-Id: virtualization@lists.linuxfoundation.org



----- Original Message -----
> On Thu, Jan 12, 2012 at 09:37:45AM -0500, Konrad Rzeszutek Wilk
> wrote:
> > Or is it possible to make the modules (fb) try to load xenbus
> > frontend
> > automatically? Preferrably one would do this:
> 
> Which modules?
> 
> > modprobe xen_fbfront
> > which would then automatically load xenbus_module, xen_kbdfront
> 
> I think you are missing something.

I'll look into this and see if I can get the xenbus module to
work on boot with the right initrd magic. Or at least come up with
a better story why it won't.

Drew

> 
> | video/xen-fbfront.c:      return
> | xenbus_register_frontend(&xenfb_driver);
> | xen/xenbus/xenbus_probe_frontend.c:EXPORT_SYMBOL_GPL(xenbus_register_frontend);
> 
> xen-fbfront already pulls in the module, at least in Linus' tree.
> 
> > Better yet if udev/kudzu figured out this automtically and loaded
> > the modules.
> 
> No workarounds for kernel problems if not absolutely necessary.
> 
> Bastian
> 
> --
> Military secrets are the most fleeting of all.
> 		-- Spock, "The Enterprise Incident", stardate 5027.4
> 
