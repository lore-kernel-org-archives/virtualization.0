From: Jeremy Fitzhardinge <jeremy@goop.org>
Subject: Re: [RFC] CPUID usage for interaction between Hypervisors	and	Linux.
Date: Tue, 07 Oct 2008 16:41:10 -0700
Message-ID: <48EBF396.8000502__23130.2959764891$1223423022$gmane$org@goop.org>
References: <1222881242.9381.17.camel@alok-dev1>	 <48E3B19D.6060905@zytor.com>
	<1222882431.9381.23.camel@alok-dev1>	 <48E3BC21.4080803@goop.org>
	<1222895153.9381.69.camel@alok-dev1> <48E3FDD5.7040106@zytor.com>
	<0B53E02A2965CE4F9ADB38B34501A3A15D927EA4@orsmsx505.amr.corp.intel.com>
	<48E422CA.2010606@zytor.com>
	<0B53E02A2965CE4F9ADB38B34501A3A15DCBA221@orsmsx505.amr.corp.intel.com>
	<48E6AB15.8060405@zytor.com>
	<0B53E02A2965CE4F9ADB38B34501A3A15DCBA325@orsmsx505.amr.corp.intel.com>
	<48E6BA5B.2090804@zytor.com>
	<0B53E02A2965CE4F9ADB38B34501A3A15DE4F934@orsmsx505.amr.corp.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <0B53E02A2965CE4F9ADB38B34501A3A15DE4F934@orsmsx505.amr.corp.intel.com>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/virtualization>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: "Nakajima, Jun" <jun.nakajima@intel.com>
Cc: the arch/x86 maintainers <x86@kernel.org>, "kvm@vger.kernel.org" <kvm@vger.kernel.org>, Daniel Hecht <dhecht@vmware.com>, LKML <linux-kernel@vger.kernel.org>, "virtualization@lists.linux-foundation.org" <virtualization@lists.linux-foundation.org>, "H. Peter Anvin" <hpa@zytor.com>, "akataria@vmware.com" <akataria@vmware.com>, Ingo Molnar <mingo@elte.hu>, "avi@redhat.com" <avi@redhat.com>
List-Id: virtualization@lists.linuxfoundation.org

Nakajima, Jun wrote:
> On 10/3/2008 5:35:39 PM, H. Peter Anvin wrote:
>   
>> Nakajima, Jun wrote:
>>     
>>> What's the significance of supporting multiple interfaces to the
>>> same guest simultaneously, i.e. _runtime_? We don't want the guests
>>> to run on such a literarily Frankenstein machine. And practically,
>>> such testing/debugging would be good only for Halloween :-).
>>>
>>>       
>> By that notion, EVERY CPU currently shipped is a "Frankenstein" CPU,
>> since at very least they export Intel-derived and AMD-derived interfaces.
>>  This is in other words, a ridiculous claim.
>>     
>
> The big difference here is that you could create a VM at runtime (by combining the existing interfaces) that did not exist before (or was not tested before). For example, a hypervisor could show hyper-v, osx-v (if any), linux-v, etc., and a guest could create a VM with hyper-v MMU, osx-v interrupt handling, Linux-v timer, etc. And such combinations/variations can grow exponentially.
>   

That would be crazy.

> Or are you suggesting that multiple interfaces be _available_ to guests at runtime but the guest chooses one of them?
>   

Right, that's what I've been suggesting.    I think hypervisors should 
be able to offer multiple ABIs to guests, but a guest has to commit to 
using one exclusively (ie, once they start to use one then the others 
turn themselves off, kill the domain, etc).

    J
