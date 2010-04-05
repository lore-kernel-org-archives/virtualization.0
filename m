From: Greg KH <gregkh@suse.de>
Subject: Re: A clocksource driver for HyperV
Date: Mon, 5 Apr 2010 15:03:52 -0700
Message-ID: <20100405220352.GA2306@suse.de>
References: <4BB9F408020000300008287C@sinclair.provo.novell.com>
	<4BBA57FB.2000406@goop.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
Content-Disposition: inline
In-Reply-To: <4BBA57FB.2000406@goop.org>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/virtualization>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: Jeremy Fitzhardinge <jeremy@goop.org>
Cc: devel@driverdev.osuosl.org, Virtualization@lists.osdl.org, Ky Srinivasan <ksrinivasan@novell.com>, Haiyang Zhang <haiyangz@microsoft.com>
List-Id: virtualization@lists.linuxfoundation.org

On Mon, Apr 05, 2010 at 02:36:59PM -0700, Jeremy Fitzhardinge wrote:
> >+static struct dmi_system_id __initconst
> >+hv_timesource_dmi_table[] __maybe_unused  = {
> >+	{
> >+		.ident = "Hyper-V",
> >+		.matches = {
> >+			DMI_MATCH(DMI_SYS_VENDOR, "Microsoft Corporation"),
> >+			DMI_MATCH(DMI_PRODUCT_NAME, "Virtual Machine"),
> >+			DMI_MATCH(DMI_BOARD_NAME, "Virtual Machine"),
> >+		},
> >+	},
> >+	{ },
> >+};
> >+MODULE_DEVICE_TABLE(dmi, hv_timesource_dmi_table);
> 
> So you use the DMI signatures to determine whether the module is
> needed, but cpuid to work out if the feature is present?

The DMI and PCI stuff is to handle module autoloading.  Ideally we would
just use the DMI matching, but some distro installers can't handle that,
so we also add the PCI stuff.  The hyperv core already has this in it.

> >+
> >+static struct pci_device_id __initconst
> >+hv_timesource_pci_table[] __maybe_unused = {
> >+	{ PCI_DEVICE(0x1414, 0x5353) }, /* VGA compatible controller */
> >+	{ 0 }
> >+};
> >+MODULE_DEVICE_TABLE(pci, hv_timesource_pci_table);
> 
> And/or PCI?
> 
> Seems a bit... ad-hoc?  Is this the official way to determine the
> presence of Hyper-V?

Yeah, it is :(

thanks,

greg k-h
