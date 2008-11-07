From: "Dong, Eddie" <eddie.dong@intel.com>
Subject: RE: [PATCH 0/16 v6] PCI: Linux kernel SR-IOV support
Date: Fri, 7 Nov 2008 09:52:28 +0800
Message-ID: <9832F13BD22FB94A829F798DA4A82805018BF38DAB__45567.116890061$1226023005$gmane$org@pdsmsx503.ccr.corp.intel.com>
References: <20081106154351.GA30459@kroah.com>
	<894107.30288.qm@web45108.mail.sp1.yahoo.com>
	<20081106164919.GA4099@kroah.com>
	<0199E0D51A61344794750DC57738F58E5E26F996C4@GVW1118EXC.americas.hpqcorp.net>
	<20081106183630.GD11773@parisc-linux.org>
	<491371F0.7020805@codemonkey.ws>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <491371F0.7020805@codemonkey.ws>
Content-Language: en-US
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/virtualization>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: Anthony Liguori <anthony@codemonkey.ws>, Matthew Wilcox <matthew@wil.cx>
Cc: "randy.dunlap@oracle.com" <randy.dunlap@oracle.com>, "grundler@parisc-linux.org" <grundler@parisc-linux.org>, "Chiang,
	Alexander" <achiang@hp.com>, Greg KH <greg@kroah.com>, "rdreier@cisco.com" <rdreier@cisco.com>, "Dong,
	Eddie" <eddie.dong@intel.com>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "jbarnes@virtuousgeek.org" <jbarnes@virtuousgeek.org>, "virtualization@lists.linux-foundation.org" <virtualization@lists.linux-foundation.org>, "kvm@vger.kernel.org" <kvm@vger.kernel.org>, "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>, "mingo@elte.hu" <mingo@elte.hu>
List-Id: virtualization@lists.linuxfoundation.org


> What we would rather do in KVM, is have the VFs appear in
> the host as standard network devices.  We would then like
> to back our existing PV driver to this VF directly
> bypassing the host networking stack.  A key feature here
> is being able to fill the VF's receive queue with guest
> memory instead of host kernel memory so that you can get
> zero-copy  
> receive traffic.  This will perform just as well as doing
> passthrough (at least) and avoid all that ugliness of
> dealing with SR-IOV in the guest. 
> 

Anthony:
	This is already addressed by VMDq solution(or so called netchannel2), right? Qing He is debugging the KVM side patch and pretty much close to end.

	For this single purpose, we don't need SR-IOV. BTW at least Intel SR-IOV NIC also supports VMDq, so you can achieve this by simply use "native" VMDq enabled driver here, plus the work we are debugging now.

Thx, eddie
