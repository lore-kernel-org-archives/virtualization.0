From: Alex Chiang <achiang@hp.com>
Subject: Re: [PATCH 1/4 v2] PCI: introduce new base functions
Date: Wed, 10 Sep 2008 16:37:11 -0600
Message-ID: <20080910223711.GA16740__43789.5506657243$1221086544$gmane$org@ldl.fc.hp.com>
References: <7A25B56E4BE99C4283EB931CD1A40E110177EB6D@pdsmsx414.ccr.corp.intel.com>
	<20080901161534.GF16796@ldl.fc.hp.com>
	<7A25B56E4BE99C4283EB931CD1A40E110181CB4E@pdsmsx414.ccr.corp.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
Content-Disposition: inline
In-Reply-To: <7A25B56E4BE99C4283EB931CD1A40E110181CB4E@pdsmsx414.ccr.corp.intel.com>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/virtualization>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: "Zhao, Yu" <yu.zhao@intel.com>
Cc: Randy Dunlap <randy.dunlap@oracle.com>, xen-devel@lists.xensource.com, Grant Grundler <grundler@parisc-linux.org>, kvm@vger.kernel.org, Matthew Wilcox <matthew@wil.cx>, linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org, Jesse Barnes <jbarnes@virtuousgeek.org>, virtualization@lists.linux-foundation.org, Greg KH <greg@kroah.com>
List-Id: virtualization@lists.linuxfoundation.org

* Zhao, Yu <yu.zhao@intel.com>:
> 
> It can be PCI_BRIDGE_RESOURCES, because there may be some
> non-standard resources following PCI_ROM_RESOURCE and before
> PCI_BRIDGE_RESOURCES.
> 
> For example, a standard PCI device has following resources:
> 	0 - 5   BARs
> 	6       ROM
> 	7 - 10  Bridge
> 
> After SR-IOV is enabled, it becomes
> 	0 - 5   standard BARs
> 	6       Rom
>      7 - 12  SR-IOV BARs
> 	13 - 16 Bridge

Ok, makes sense now; was that documented somewhere else, and I
just missed it?

> Same as above, the PCI_BRIDGE_RES_END varies when some features
> is enabled or disabled.

Ok, I must have missed this documentation too.

> Thank you very much for carefully reviewing these patches. I'd
> like to invite you to review next version again if it's
> convenient for you.

Sure, you can Cc me next time too.

Thanks.

/ac
