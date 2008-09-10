From: "Zhao, Yu" <yu.zhao@intel.com>
Subject: RE: [PATCH 2/4 v2] PCI: support ARI capability
Date: Wed, 10 Sep 2008 15:48:04 +0800
Message-ID: <7A25B56E4BE99C4283EB931CD1A40E110181CAF7__40880.0274403349$1221033028$gmane$org@pdsmsx414.ccr.corp.intel.com>
References: <7A25B56E4BE99C4283EB931CD1A40E110177EB6E@pdsmsx414.ccr.corp.intel.com><20080901152734.GC16796@ldl.fc.hp.com>
	<ada3akjj268.fsf@cisco.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
Content-class: urn:content-classes:message
In-Reply-To: <ada3akjj268.fsf@cisco.com>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/virtualization>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: Roland Dreier <rdreier@cisco.com>, Alex Chiang <achiang@hp.com>
Cc: Randy Dunlap <randy.dunlap@oracle.com>, xen-devel@lists.xensource.com, Grant Grundler <grundler@parisc-linux.org>, kvm@vger.kernel.org, Matthew Wilcox <matthew@wil.cx>, linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org, Jesse Barnes <jbarnes@virtuousgeek.org>, virtualization@lists.linux-foundation.org, Greg KH <greg@kroah.com>
List-Id: virtualization@lists.linuxfoundation.org

On Monday, September 01, 2008 11:50 PM, Roland Dreier wrote:
>To: Alex Chiang
>Cc: Zhao, Yu; Jesse Barnes; linux-pci@vger.kernel.org; Randy Dunlap; Greg KH;
>Grant Grundler; Matthew Wilcox; linux-kernel@vger.kernel.org;
>kvm@vger.kernel.org; virtualization@lists.linux-foundation.org;
>xen-devel@lists.xensource.com
>Subject: Re: [PATCH 2/4 v2] PCI: support ARI capability
>
> > > +config PCI_ARI
> > > +	bool "PCI ARI support"
> > > +	depends on PCI
> > > +	default n
> > > +	help
> > > +	  This enables PCI Alternative Routing-ID Interpretation.
> >
> > This Kconfig help text is a little weak. Why not include the text
> > you've already written here:
> >
> > 	Support Alternative Routing-ID Interpretation (ARI), which
> > 	increases the number of functions that can be supported by a PCIe
> > 	endpoint. ARI is required by SR-IOV.
>
>I agree with this improvement to the help text.  But a further question
>is whether ARI even merits its own user-visible config option.  Is it
>worth having yet another choice for users?  When would someone want ARI
>but not SR-IOV?

ARI is an independent PCI Express extended capability. Multi-function devices supporting this capability may use it to track dependency between different functions and assign function group numbers to these functions.

Another reason to keep this separated with SR-IOV is that after ARI is enabled, PCI Express Endpoint may have non-zero slot number (device number), which is different from traditional PCI Express Endpoint.

Thanks.

>
> - R.
