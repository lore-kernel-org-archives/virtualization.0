From: Roland Dreier <rdreier@cisco.com>
Subject: Re: [PATCH 2/4 v2] PCI: support ARI capability
Date: Mon, 01 Sep 2008 08:50:23 -0700
Message-ID: <ada3akjj268.fsf__35470.5782527619$1220365416$gmane$org@cisco.com>
References: <7A25B56E4BE99C4283EB931CD1A40E110177EB6E@pdsmsx414.ccr.corp.intel.com>
	<20080901152734.GC16796@ldl.fc.hp.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <20080901152734.GC16796@ldl.fc.hp.com> (Alex Chiang's message of
	"Mon, 1 Sep 2008 09:27:34 -0600")
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/virtualization>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: Alex Chiang <achiang@hp.com>
Cc: Randy Dunlap <randy.dunlap@oracle.com>, xen-devel@lists.xensource.com, Grant Grundler <grundler@parisc-linux.org>, kvm@vger.kernel.org, Matthew Wilcox <matthew@wil.cx>, linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org, Jesse Barnes <jbarnes@virtuousgeek.org>, virtualization@lists.linux-foundation.org, Greg KH <greg@kroah.com>
List-Id: virtualization@lists.linuxfoundation.org

 > > +config PCI_ARI
 > > +	bool "PCI ARI support"
 > > +	depends on PCI
 > > +	default n
 > > +	help
 > > +	  This enables PCI Alternative Routing-ID Interpretation.
 > 
 > This Kconfig help text is a little weak. Why not include the text
 > you've already written here:
 > 
 > 	Support Alternative Routing-ID Interpretation (ARI), which
 > 	increases the number of functions that can be supported by a PCIe
 > 	endpoint. ARI is required by SR-IOV.

I agree with this improvement to the help text.  But a further question
is whether ARI even merits its own user-visible config option.  Is it
worth having yet another choice for users?  When would someone want ARI
but not SR-IOV?

 - R.
