From: "Rose, Gregory V" <gregory.v.rose@intel.com>
Subject: RE: [PATCH 0/13 v7] PCI: Linux kernel SR-IOV support
Date: Wed, 17 Dec 2008 11:42:47 -0800
Message-ID: <43F901BD926A4E43B106BF17856F07554B525A62__46809.8771096722$1229543344$gmane$org@orsmsx508.amr.corp.intel.com>
References: <20081121183605.GA7810@yzhao12-linux.sh.intel.com>
	<20081217060608.GA12618@kroah.com>
	<43F901BD926A4E43B106BF17856F07554B525811@orsmsx508.amr.corp.intel.com>
	<200812171051.36645.jbarnes@virtuousgeek.org>
	<43F901BD926A4E43B106BF17856F07554B525A02@orsmsx508.amr.corp.intel.com>
	<49495447.5030904@goop.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <49495447.5030904@goop.org>
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
To: Jeremy Fitzhardinge <jeremy@goop.org>, "Zhao, Yu" <yu.zhao@intel.com>, "Yu, Wilfred" <wilfred.yu@intel.com>
Cc: "randy.dunlap@oracle.com" <randy.dunlap@oracle.com>, "grundler@parisc-linux.org" <grundler@parisc-linux.org>, "achiang@hp.com" <achiang@hp.com>, "matthew@wil.cx" <matthew@wil.cx>, Greg KH <greg@kroah.com>, "rdreier@cisco.com" <rdreier@cisco.com>, Jike Song <albcamus@gmail.com>, Jesse Barnes <jbarnes@virtuousgeek.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "horms@verge.net.au" <horms@verge.net.au>, "kvm@vger.kernel.org" <kvm@vger.kernel.org>, "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>, "mingo@elte.hu" <mingo@elte.hu>, "virtualization@lists.linux-foundation.org" <virtualization@lists.linux-foundation.org>, "yinghai@kernel.org" <yinghai@kernel.org>, "bjorn.helgaas@hp.com" <bjorn.helgaas@hp.com>
List-Id: virtualization@lists.linuxfoundation.org



Jeremy Fitzhardinge wrote:

> Which dom0 kernel are you using?  Is it based on my pvops-based dom0 work?

The kernel I'm currently using is an ad-hoc patchwork of changes to the 2.6.18 Xen Dom0 kernel that was available back in August.  The folks from OTC in Intel (Zhao Yu and his team) would be able to provide you more background on it as they did the work to enable MSI-X, SR-IOV and VT-d in that kernel so that my drivers would function.  I don't see Zhao Yu on the distro list for this email so I'll add him.

- Greg
