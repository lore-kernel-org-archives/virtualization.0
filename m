From: "Zhao, Yu" <yu.zhao@intel.com>
Subject: Re: [PATCH 16/16 v6] PCI: document the new PCI boot parameters
Date: Fri, 07 Nov 2008 10:37:55 +0800
Message-ID: <4913AA03.5060807__18967.3804714859$1226025614$gmane$org@intel.com>
References: <20081022083809.GA3757@yzhao12-linux.sh.intel.com>
	<20081022084531.GP3773@yzhao12-linux.sh.intel.com>
	<20081106043235.GA30292@kroah.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <20081106043235.GA30292@kroah.com>
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
> On Wed, Oct 22, 2008 at 04:45:31PM +0800, Yu Zhao wrote:
>>  Documentation/kernel-parameters.txt |   10 ++++++++++
>>  1 files changed, 10 insertions(+), 0 deletions(-)
>>
>> diff --git a/Documentation/kernel-parameters.txt b/Documentation/kernel-parameters.txt
>> index 53ba7c7..5482ae0 100644
>> --- a/Documentation/kernel-parameters.txt
>> +++ b/Documentation/kernel-parameters.txt
>> @@ -1677,6 +1677,16 @@ and is between 256 and 4096 characters. It is defined in the file
>>  		cbmemsize=nn[KMG]	The fixed amount of bus space which is
>>  				reserved for the CardBus bridge's memory
>>  				window. The default value is 64 megabytes.
>> +		assign-mmio=[dddd:]bb	[X86] reassign memory resources of all
>> +				devices under bus [dddd:]bb (dddd is the domain
>> +				number and bb is the bus number).
>> +		assign-pio=[dddd:]bb	[X86] reassign io port resources of all
>> +				devices under bus [dddd:]bb (dddd is the domain
>> +				number and bb is the bus number).
>> +		align-mmio=[dddd:]bb:dd.f  [X86] relocate memory resources of a
>> +				device to minimum PAGE_SIZE alignment (dddd is
>> +				the domain number and bb, dd and f is the bus,
>> +				device and function number).
> 
> This seems like a big problem.  How are we going to know to add these
> command line options for devices we haven't even seen/known about yet?
> 
> How do we know the bus ids aren't going to change between boots (hint,
> they are, pci bus ids change all the time...)
> 
> We need to be able to do this kind of thing dynamically, not fixed at
> boot time, which seems way to early to even know about this, right?
> 
> thanks,
> 
> greg k-h

Yes, I totally agree. Doing things dynamically is better.

The purpose of these parameters is to rebalance and align resources for 
device that has BARs encapsulated in various new capabilities (SR-IOV, 
etc.), because most of existing BIOSes don't take care of those BARs.

If we do resource rebalance after system is up, do you think there is 
any side effect or impact to other subsystem other than PCI (e.g. MTRR)?

I haven't had much thinking on the dynamical resource rebalance. If you 
have any idea about this, can you please suggest?

Regards,
Yu
