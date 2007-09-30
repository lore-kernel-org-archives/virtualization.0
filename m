From: Avi Kivity <avi@qumranet.com>
Subject: Re: [kvm-devel] [RFC] KVM Source layout Proposal to accommodate new
 CPU architecture
Date: Sun, 30 Sep 2007 12:52:38 +0200
Message-ID: <46FF7FF6.6090103__44068.0015869022$1191149723$gmane$org@qumranet.com>
References: <42DFA526FC41B1429CE7279EF83C6BDC753A4E@pdsmsx415.ccr.corp.intel.com>	<46FB7566.9030504@qumranet.com>	<42DFA526FC41B1429CE7279EF83C6BDC753E73@pdsmsx415.ccr.corp.intel.com>	<46FD1392.1080905@qumranet.com>	<42DFA526FC41B1429CE7279EF83C6BDC754031@pdsmsx415.ccr.corp.intel.com>	<46FD33F2.9090506@qumranet.com>
	<42DFA526FC41B1429CE7279EF83C6BDC754076@pdsmsx415.ccr.corp.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <42DFA526FC41B1429CE7279EF83C6BDC754076@pdsmsx415.ccr.corp.intel.com>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/virtualization>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: "Zhang, Xiantao" <xiantao.zhang@intel.com>
Cc: kvm-devel@lists.sourceforge.net, virtualization <virtualization@lists.linux-foundation.org>
List-Id: virtualization@lists.linuxfoundation.org

Zhang, Xiantao wrote:
> Zhang, Xiantao wrote:
>   
>>> Hi Avi,
>>> 	So you mean IA64 can adopt the similar method as well? 
>>>       
>
>   
>> What method do you mean exactly?
>>     
> Put all arch-specific files into arch/ia64/kvm as you described in
> future KVM infrastructure. 
>   
>> The powerpc people had some patches to make kvm_main arch independent.
>> We should work on that base.
>> To avoid a dependency on the x86 merge, we can start by working withing
>> drivers/kvm/, for example creating drivers/kvm/x86.c and
>> drivers/kvm/ia64.c. Later patches can move these to arch/*/.
>>     
> It may work on x86 side. But for IA64, we have several source files and
> assembly files to implement a VMM module, which contains the
> virtualization logic of CPU, MMU and other platform devices. (In KVM
> forum, Anthony had presented IA64/KVM architecture which is a bit
> different with x86 side due to different approaches for VT.).If we put
> all such these arch-specific files in one directory, it looks very
> strange! 
>   

ia64/ subdirectory is also fine.


-- 
error compiling committee.c: too many arguments to function
