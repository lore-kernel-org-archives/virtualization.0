From: Greg KH <greg@kroah.com>
Subject: Re: [PATCH 0/16 v6] PCI: Linux kernel SR-IOV support
Date: Thu, 6 Nov 2008 08:49:19 -0800
Message-ID: <20081106164919.GA4099__8701.01147233999$1225990929$gmane$org@kroah.com>
References: <20081106154351.GA30459@kroah.com>
	<894107.30288.qm@web45108.mail.sp1.yahoo.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
Content-Disposition: inline
In-Reply-To: <894107.30288.qm@web45108.mail.sp1.yahoo.com>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/virtualization>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: H L <swdevyid@yahoo.com>
Cc: randy.dunlap@oracle.com, grundler@parisc-linux.org, achiang@hp.com, matthew@wil.cx, linux-pci@vger.kernel.org, rdreier@cisco.com, linux-kernel@vger.kernel.org, jbarnes@virtuousgeek.org, virtualization@lists.linux-foundation.org, kvm@vger.kernel.org, mingo@elte.hu
List-Id: virtualization@lists.linuxfoundation.org


A: No.
Q: Should I include quotations after my reply?

On Thu, Nov 06, 2008 at 08:41:53AM -0800, H L wrote:
> I have not modified any existing drivers, but instead I threw together
> a bare-bones module enabling me to make a call to pci_iov_register()
> and then poke at an SR-IOV adapter's /sys entries for which no driver
> was loaded.
> 
> It appears from my perusal thus far that drivers using these new
> SR-IOV patches will require modification; i.e. the driver associated
> with the Physical Function (PF) will be required to make the
> pci_iov_register() call along with the requisite notify() function.
> Essentially this suggests to me a model for the PF driver to perform
> any "global actions" or setup on behalf of VFs before enabling them
> after which VF drivers could be associated.

Where would the VF drivers have to be associated?  On the "pci_dev"
level or on a higher one?

Will all drivers that want to bind to a "VF" device need to be
rewritten?

> I have so far only seen Yu Zhao's "7-patch" set.  I've not yet looked
> at his subsequently tendered "15-patch" set so I don't know what has
> changed.    The hardware/firmware implementation for any given SR-IOV
> compatible device, will determine the extent of differences required
> between a PF driver and a VF driver.

Yeah, that's what I'm worried/curious about.  Without seeing the code
for such a driver, how can we properly evaluate if this infrastructure
is the correct one and the proper way to do all of this?

thanks,

greg k-h
