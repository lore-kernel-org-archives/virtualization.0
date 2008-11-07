From: "Zhao, Yu" <yu.zhao@intel.com>
Subject: Re: [PATCH 16/16 v6] PCI: document the new PCI boot parameters
Date: Fri, 07 Nov 2008 16:35:47 +0800
Message-ID: <4913FDE3.8050804__18283.8168846958$1226047122$gmane$org@intel.com>
References: <20081022083809.GA3757@yzhao12-linux.sh.intel.com>
	<20081022084531.GP3773@yzhao12-linux.sh.intel.com>
	<20081106043235.GA30292@kroah.com> <4913AA03.5060807@intel.com>
	<20081107025032.GA12824@kroah.com> <4913B8A5.5010806@intel.com>
	<20081107061603.GC3860@kroah.com> <4913F34A.8020805@intel.com>
	<20081107080222.GA6284@kroah.com> <4913F97E.7030408@intel.com>
	<20081107082432.GA6601@kroah.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <20081107082432.GA6601@kroah.com>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/virtualization>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: Greg KH <greg@kroah.com>
Cc: "randy.dunlap@oracle.com" <randy.dunlap@oracle.com>, "grundler@parisc-linux.org" <grundler@parisc-linux.org>, "achiang@hp.com" <achiang@hp.com>, "matthew@wil.cx" <matthew@wil.cx>, "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>, "rdreier@cisco.com" <rdreier@cisco.com>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "jbarnes@virtuousgeek.org" <jbarnes@virtuousgeek.org>, "virtualization@lists.linux-foundation.org" <virtualization@lists.linux-foundation.org>, "kvm@vger.kernel.org" <kvm@vger.kernel.org>, "mingo@elte.hu" <mingo@elte.hu>
List-Id: virtualization@lists.linuxfoundation.org

Greg KH wrote:
> On Fri, Nov 07, 2008 at 04:17:02PM +0800, Zhao, Yu wrote:
>>> Well, to do it "correctly" you are going to have to tell the driver to
>>> shut itself down, and reinitialize itself.
>>> Turns out, that doesn't really work for disk and network devices without
>>> dropping the connection (well, network devices should be fine probably).
>>> So you just can't do this, sorry.  That's why the BIOS handles all of
>>> these issues in a PCI hotplug system.
>>> How does the hardware people think we are going to handle this in the
>>> OS?  It's not something that any operating system can do, is it part of
>>> the IOV PCI spec somewhere?
>> No, it's not part of the PCI IOV spec.
>>
>> I just want the IOV (and whole PCI subsystem) have more flexibility on 
>> various BIOSes. So can we reconsider about resource rebalance as boot 
>> option, or should we forget about this idea?
> 
> As you have proposed it, the boot option will not work at all, so I
> think we need to forget about it.  Especially if it is not really
> needed.

I guess at least one thing would work if people don't want to boot 
twice: give the bus number 0 as rebalance starting point, then all 
system resources would be reshuffled :-)

Thanks,
Yu
