From: Greg KH <greg@kroah.com>
Subject: Re: [PATCH 16/16 v6] PCI: document the new PCI boot parameters
Date: Fri, 7 Nov 2008 21:25:19 -0800
Message-ID: <20081108052519.GA11067__44786.3737390891$1226122349$gmane$org@kroah.com>
References: <20081107025032.GA12824@kroah.com> <4913B8A5.5010806@intel.com>
	<20081107061603.GC3860@kroah.com> <4913F34A.8020805@intel.com>
	<20081107080222.GA6284@kroah.com> <4913F97E.7030408@intel.com>
	<20081107082432.GA6601@kroah.com> <4913FDE3.8050804@intel.com>
	<20081107185325.GE2320@kroah.com> <49151CED.8060507@uniscape.net>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
Content-Disposition: inline
In-Reply-To: <49151CED.8060507@uniscape.net>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/virtualization>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: Yu Zhao <yu.zhao@uniscape.net>
Cc: "randy.dunlap@oracle.com" <randy.dunlap@oracle.com>, "grundler@parisc-linux.org" <grundler@parisc-linux.org>, "achiang@hp.com" <achiang@hp.com>, "matthew@wil.cx" <matthew@wil.cx>, "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>, "rdreier@cisco.com" <rdreier@cisco.com>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "jbarnes@virtuousgeek.org" <jbarnes@virtuousgeek.org>, "virtualization@lists.linux-foundation.org" <virtualization@lists.linux-foundation.org>, "kvm@vger.kernel.org" <kvm@vger.kernel.org>, "mingo@elte.hu" <mingo@elte.hu>
List-Id: virtualization@lists.linuxfoundation.org

On Sat, Nov 08, 2008 at 01:00:29PM +0800, Yu Zhao wrote:
> Greg KH wrote:
>> On Fri, Nov 07, 2008 at 04:35:47PM +0800, Zhao, Yu wrote:
>>> Greg KH wrote:
>>>> On Fri, Nov 07, 2008 at 04:17:02PM +0800, Zhao, Yu wrote:
>>>>>> Well, to do it "correctly" you are going to have to tell the driver to
>>>>>> shut itself down, and reinitialize itself.
>>>>>> Turns out, that doesn't really work for disk and network devices 
>>>>>> without
>>>>>> dropping the connection (well, network devices should be fine 
>>>>>> probably).
>>>>>> So you just can't do this, sorry.  That's why the BIOS handles all of
>>>>>> these issues in a PCI hotplug system.
>>>>>> How does the hardware people think we are going to handle this in the
>>>>>> OS?  It's not something that any operating system can do, is it part 
>>>>>> of
>>>>>> the IOV PCI spec somewhere?
>>>>> No, it's not part of the PCI IOV spec.
>>>>>
>>>>> I just want the IOV (and whole PCI subsystem) have more flexibility on 
>>>>> various BIOSes. So can we reconsider about resource rebalance as boot 
>>>>> option, or should we forget about this idea?
>>>> As you have proposed it, the boot option will not work at all, so I
>>>> think we need to forget about it.  Especially if it is not really
>>>> needed.
>>> I guess at least one thing would work if people don't want to boot twice: 
>>> give the bus number 0 as rebalance starting point, then all system 
>>> resources would be reshuffled :-)
>> Hm, but don't we do that today with our basic resource reservation logic
>> at boot time?  What would be different about this kind of proposal?
>
> The generic PCI core can do this but this feature is kind of disabled by 
> low level PCI code in x86. The low level code tries to reserve resource 
> according to configuration from BIOS. If the BIOS is wrong, the allocation 
> would fail and the generic PCI core couldn't repair it because the bridge 
> resources may have been allocated by the PCI low level and the PCI core 
> can't expand them to find enough resource for the subordinates.

Yes, we do this on purpose.

> The proposal is to disable x86 PCI low level to allocation resources 
> according to BIOS so PCI core can fully control the resource allocation. 
> The PCI core takes all resources from BARs it knows into account and 
> configure the resource windows on the bridges according to its own 
> calculation.

Ah, so you mean we should revert back to the way we use to do x86 PCI
resource allocation from about a year and a half ago to about 8 years
ago?

Hint, there was a reason why we switched over to using the BIOS instead
of doing it ourselves.  Turns out we have to trust the BIOS here, as
that is exactly what other operating systems do.  Trying to do it on our
own was too fragile and resulted in too many problems over time.

Go look at the archives for when this all was switched, you'll see the
reasons why.

So no, we will not be going back to the way we used to do things, we
changed for a reason :)

thanks,

greg k-h
