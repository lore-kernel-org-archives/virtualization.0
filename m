From: "Rose, Gregory V" <gregory.v.rose@intel.com>
Subject: RE: [PATCH 0/13 v7] PCI: Linux kernel SR-IOV support
Date: Thu, 18 Dec 2008 14:42:38 -0800
Message-ID: <43F901BD926A4E43B106BF17856F07554B582F35__49122.435207437$1229640295$gmane$org@orsmsx508.amr.corp.intel.com>
References: <20081121183605.GA7810@yzhao12-linux.sh.intel.com>
	<200812171051.36645.jbarnes@virtuousgeek.org>
	<43F901BD926A4E43B106BF17856F07554B525A02@orsmsx508.amr.corp.intel.com>
	<200812171142.56170.jbarnes@virtuousgeek.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <200812171142.56170.jbarnes@virtuousgeek.org>
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
To: Jesse Barnes <jbarnes@virtuousgeek.org>
Cc: "randy.dunlap@oracle.com" <randy.dunlap@oracle.com>, "grundler@parisc-linux.org" <grundler@parisc-linux.org>, "achiang@hp.com" <achiang@hp.com>, "matthew@wil.cx" <matthew@wil.cx>, Greg KH <greg@kroah.com>, "rdreier@cisco.com" <rdreier@cisco.com>, Jike Song <albcamus@gmail.com>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "horms@verge.net.au" <horms@verge.net.au>, "kvm@vger.kernel.org" <kvm@vger.kernel.org>, "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>, "mingo@elte.hu" <mingo@elte.hu>, "virtualization@lists.linux-foundation.org" <virtualization@lists.linux-foundation.org>, "yinghai@kernel.org" <yinghai@kernel.org>, "bjorn.helgaas@hp.com" <bjorn.helgaas@hp.com>
List-Id: virtualization@lists.linuxfoundation.org

Jesse Barnes wrote:
> 
> Hm, that's not the answer I was hoping for. :)  (Was looking for,
> "Yeah we just need this bits queued and we'll send an update for
> e1000 right away." :) 
> 
> I really don't want the SR-IOV stuff to sit out another merge cycle
> though... Arg.

We will have drivers that support these API's posted to the 
lists within two or three days.  These drivers are RFC only 
and not to be pushed upstream.  More non-Xen testing needs to 
happen with the 82576 HW.

- Greg
