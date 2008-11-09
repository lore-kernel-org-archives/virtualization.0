From: Alexander Graf <agraf@suse.de>
Subject: Re: [PATCH 16/16 v6] PCI: document the new PCI boot parameters
Date: Sun, 9 Nov 2008 15:34:33 +0100
Message-ID: <C6F54356-3132-4888-8565-5368DECD2206__28624.3882649162$1226241427$gmane$org@suse.de>
References: <20081022083809.GA3757@yzhao12-linux.sh.intel.com>
	<20081022084531.GP3773@yzhao12-linux.sh.intel.com>
	<20081106043235.GA30292@kroah.com> <4913AA03.5060807@intel.com>
	<20081107025032.GA12824@kroah.com> <4913B8A5.5010806@intel.com>
	<20081107061603.GC3860@kroah.com> <20081109141909.GA2458@ucw.cz>
Mime-Version: 1.0 (Apple Message framework v929.2)
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <20081109141909.GA2458@ucw.cz>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/virtualization>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: Pavel Machek <pavel@suse.cz>
Cc: "randy.dunlap@oracle.com" <randy.dunlap@oracle.com>, "grundler@parisc-linux.org" <grundler@parisc-linux.org>, "achiang@hp.com" <achiang@hp.com>, "matthew@wil.cx" <matthew@wil.cx>, Greg KH <greg@kroah.com>, "rdreier@cisco.com" <rdreier@cisco.com>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "jbarnes@virtuousgeek.org" <jbarnes@virtuousgeek.org>, "virtualization@lists.linux-foundation.org" <virtualization@lists.linux-foundation.org>, "kvm@vger.kernel.org" <kvm@vger.kernel.org>, "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>, "mingo@elte.hu" <mingo@elte.hu>
List-Id: virtualization@lists.linuxfoundation.org

>>>>> If we do resource rebalance after system is up, do you think  
>>>>> there is any
>>>>> side effect or impact to other subsystem other than PCI (e.g.  
>>>>> MTRR)?
>>>> I don't think so.
>>>>> I haven't had much thinking on the dynamical resource rebalance.  
>>>>> If you
>>>>> have any idea about this, can you please suggest?
>>>> Yeah, it's going to be hard :)
>>>> We've thought about this in the past, and even Microsoft said it  
>>>> was
>>>> going to happen for Vista, but they realized in the end, like we  
>>>> did a
>>>> few years previously, that it would require full support of all PCI
>>>> drivers as well (if you rebalance stuff that is already bound to a
>>>> driver.)  So they dropped it.
>>>> When would you want to do this kind of rebalancing?  Before any PCI
>>>> driver is bound to any devices?  Or afterwards?
>>>
>>> I guess if we want the rebalance dynamic, then we should have it  
>>> full --
>>> the rebalance would be functional even after the driver is loaded.
>>>
>>> But in most cases, there will be problem when we unload driver  
>>> from a hard
>>> disk controller, etc. We can mount root on a ramdisk and do the  
>>> rebalance
>>> there, but it's complicated for a real user.
>>>
>>> So looks like doing rebalancing before any driver is bound to any  
>>> device is
>>> also a nice idea, if user can get a shell to do rebalance before  
>>> built-in
>>> PCI driver grabs device.
>>
>> That's not going to work, it needs to happen before any PCI device is
>> bound, which is before init runs.
>
> We could run shell from early initrd... And PCI is not required for
> initrd, right?

You can't be sure of that - compile your ATA driver =y and you'll  
definitely end up using PCI.

Alex
