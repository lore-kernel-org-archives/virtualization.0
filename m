From: Bastian Blank <waldi@debian.org>
Subject: Re: [Xen-devel] [PATCH 1/4] xen kconfig: keep XEN_XENBUS_FRONTEND
	builtin
Date: Thu, 12 Jan 2012 16:42:06 +0100
Message-ID: <20120112154206.GA9722__8421.99393450773$1326383431$gmane$org@wavehammer.waldi.eu.org>
References: <20120111172832.GB4449@phenom.dumpdata.com>
	<e37e8bec-f4ec-4420-81f0-da0ef90a6120@zmail13.collab.prod.int.phx2.redhat.com>
	<20120112143745.GE7685@phenom.dumpdata.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
Content-Disposition: inline
In-Reply-To: <20120112143745.GE7685@phenom.dumpdata.com>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/virtualization/>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>
Cc: Andrew Jones <drjones@redhat.com>, xen-devel@lists.xensource.com, stefano stabellini <stefano.stabellini@eu.citrix.com>, jeremy@goop.org, virtualization@lists.linux-foundation.org, konrad@darnok.org
List-Id: virtualization@lists.linuxfoundation.org

On Thu, Jan 12, 2012 at 09:37:45AM -0500, Konrad Rzeszutek Wilk wrote:
> Or is it possible to make the modules (fb) try to load xenbus frontend
> automatically? Preferrably one would do this:

Which modules?

> modprobe xen_fbfront
> which would then automatically load xenbus_module, xen_kbdfront

I think you are missing something.

| video/xen-fbfront.c:      return xenbus_register_frontend(&xenfb_driver);
| xen/xenbus/xenbus_probe_frontend.c:EXPORT_SYMBOL_GPL(xenbus_register_frontend);

xen-fbfront already pulls in the module, at least in Linus' tree.

> Better yet if udev/kudzu figured out this automtically and loaded
> the modules.

No workarounds for kernel problems if not absolutely necessary.

Bastian

-- 
Military secrets are the most fleeting of all.
		-- Spock, "The Enterprise Incident", stardate 5027.4
