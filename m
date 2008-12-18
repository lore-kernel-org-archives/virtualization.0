From: "Zhao, Yu" <yu.zhao@intel.com>
Subject: Re: [PATCH 0/13 v7] PCI: Linux kernel SR-IOV support
Date: Thu, 18 Dec 2008 10:26:40 +0800
Message-ID: <4949B4E0.2010409__40067.8510348827$1229567316$gmane$org@intel.com>
References: <20081121183605.GA7810@yzhao12-linux.sh.intel.com>
	<200812161523.55238.jbarnes@virtuousgeek.org>
	<20081217141542.GB19967@parisc-linux.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <20081217141542.GB19967@parisc-linux.org>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/virtualization>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: Matthew Wilcox <matthew@wil.cx>
Cc: "randy.dunlap@oracle.com" <randy.dunlap@oracle.com>, "grundler@parisc-linux.org" <grundler@parisc-linux.org>, "achiang@hp.com" <achiang@hp.com>, "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>, "rdreier@cisco.com" <rdreier@cisco.com>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, Jesse Barnes <jbarnes@virtuousgeek.org>, "virtualization@lists.linux-foundation.org" <virtualization@lists.linux-foundation.org>, "horms@verge.net.au" <horms@verge.net.au>, "kvm@vger.kernel.org" <kvm@vger.kernel.org>, "greg@kroah.com" <greg@kroah.com>, "mingo@elte.hu" <mingo@elte.hu>, "yinghai@kernel.org" <yinghai@kernel.org>, "bjorn.helgaas@hp.com" <bjorn.helgaas@hp.com>
List-Id: virtualization@lists.linuxfoundation.org

Matthew Wilcox wrote:
> On Tue, Dec 16, 2008 at 03:23:53PM -0800, Jesse Barnes wrote:
>> I applied 1-9 to my linux-next branch; and at least patch #10 needs a respin, 
> 
> I still object to #2.  We should have the flexibility to have 'struct
> resource's that are not in this array in the pci_dev.  I would like to
> see the SR-IOV resources _not_ in this array (and indeed, I'd like to
> see PCI bridges keep their producer resources somewhere other than in
> this array).  I accept that there are still some problems with this, but

I understand your concern, and agree that using the array as resource 
manager is not the best way. But for now it's not possible as you know. 
We need a better resource manager for PCI subsystem to manage the 
various resources (traditional, device specific, bus related), which is 
another independent work from SR-IOV change.

> patch #2 moves us further from being able to achieve this goal, not
> closer.

The array is obvious straightforward and can be easily replaced with a 
more advanced resource manager in the future. So I don't think we going 
  further from or closer to the goal.

Thanks,
Yu
