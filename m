From: Roland Dreier <rdreier@cisco.com>
Subject: Re: [PATCH 2/4 v2] PCI: support ARI capability
Date: Wed, 10 Sep 2008 11:42:18 -0700
Message-ID: <aday71zn8qd.fsf__35908.9841870174$1221072297$gmane$org@cisco.com>
References: <7A25B56E4BE99C4283EB931CD1A40E110177EB6E@pdsmsx414.ccr.corp.intel.com>
	<20080901152734.GC16796@ldl.fc.hp.com> <ada3akjj268.fsf@cisco.com>
	<7A25B56E4BE99C4283EB931CD1A40E110181CAF7@pdsmsx414.ccr.corp.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <7A25B56E4BE99C4283EB931CD1A40E110181CAF7@pdsmsx414.ccr.corp.intel.com>
	(Yu Zhao's message of "Wed, 10 Sep 2008 15:48:04 +0800")
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
Cc: Randy Dunlap <randy.dunlap@oracle.com>, xen-devel@lists.xensource.com, Grant Grundler <grundler@parisc-linux.org>, Alex Chiang <achiang@hp.com>, Matthew Wilcox <matthew@wil.cx>, linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org, Jesse Barnes <jbarnes@virtuousgeek.org>, virtualization@lists.linux-foundation.org, kvm@vger.kernel.org, Greg KH <greg@kroah.com>
List-Id: virtualization@lists.linuxfoundation.org

 > ARI is an independent PCI Express extended capability. Multi-function
 > devices supporting this capability may use it to track dependency
 > between different functions and assign function group numbers to
 > these functions.

 > Another reason to keep this separated with SR-IOV is that after ARI
 > is enabled, PCI Express Endpoint may have non-zero slot number
 > (device number), which is different from traditional PCI Express
 > Endpoint.

OK, I guess.  Although I still don't see why we need a user-visible
option to control ARI independent of SR-IOV.  When would a user want to
enable CONFIG_PCI_ARI=y but not select CONFIG_PCI_IOV?  (Also, by the
way, why PCI_IOV instead of PCI_SR_IOV -- I assume in the future we may
have PCI_MR_IOV, and matching the PCI terminology is probably easier for
people to understand).

 - R.
