From: Avi Kivity <avi@qumranet.com>
Subject: Re: [kvm-devel] [RFC] KVM Source layout Proposal to
 accommodate	newCPU architecture
Date: Mon, 08 Oct 2007 11:57:05 +0200
Message-ID: <4709FEF1.6010006__24702.8549820699$1191837724$gmane$org@qumranet.com>
References: <42DFA526FC41B1429CE7279EF83C6BDC753A4E@pdsmsx415.ccr.corp.intel.com><46FB7566.9030504@qumranet.com><42DFA526FC41B1429CE7279EF83C6BDC753E73@pdsmsx415.ccr.corp.intel.com><46FD1392.1080905@qumranet.com><42DFA526FC41B1429CE7279EF83C6BDC754031@pdsmsx415.ccr.corp.intel.com><46FD33F2.9090506@qumranet.com><42DFA526FC41B1429CE7279EF83C6BDC754076@pdsmsx415.ccr.corp.intel.com><46FF7FF6.6090103@qumranet.com><42DFA526FC41B1429CE7279EF83C6BDC75421C@pdsmsx415.ccr.corp.intel.com><46FFAB00.4050103@qumranet.com><42DFA526FC41B1429CE7279EF83C6BDC7AE225@pdsmsx415.ccr.corp.intel.com>
	<1191816268.26859.11.camel@basalt>
	<42DFA526FC41B1429CE7279EF83C6BDC7AE2A8@pdsmsx415.ccr.corp.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <42DFA526FC41B1429CE7279EF83C6BDC7AE2A8@pdsmsx415.ccr.corp.intel.com>
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
Cc: kvm-devel@lists.sourceforge.net, Hollis Blanchard <hollisb@us.ibm.com>, virtualization <virtualization@lists.linux-foundation.org>
List-Id: virtualization@lists.linuxfoundation.org

Zhang, Xiantao wrote:
> Hollis Blanchard wrote:
>   
>> On Mon, 2007-10-08 at 10:36 +0800, Zhang, Xiantao wrote:
>>     
>>> Avi Kivity wrote:
>>>       
>>>> Zhang, Xiantao wrote:
>>>>         
>>>>> Avi Kivity wrote:
>>>>>
>>>>>           
>>>>>> Zhang, Xiantao wrote:
>>>>>>
>>>>>>             
>>>>>>> Zhang, Xiantao wrote:
>>>>>>>
>>>>>>>
>>>>>>>               
>>>>>>>>> Hi Avi,
>>>>>>>>> 	So you mean IA64 can adopt the similar method as well?
>>>>>>>>>
>>>>>>>>>
>>>>>>>>>                   
>>>>>>>> What method do you mean exactly?
>>>>>>>>
>>>>>>>>
>>>>>>>>                 
>>>>>>> Put all arch-specific files into arch/ia64/kvm as you described
>>>>>>> in future KVM infrastructure. 
>>>>>>>
>>>>>>>
>>>>>>>               
>>>>>>>> The powerpc people had some patches to make kvm_main arch
>>>>>>>> independent. We should work on that base. To avoid a dependency
>>>>>>>> on the x86 merge, we can start by working withing drivers/kvm/,
>>>>>>>> for example creating drivers/kvm/x86.c and drivers/kvm/ia64.c.
>>>>>>>> Later patches can move these to arch/*/.
>>>>>>>>
>>>>>>>>
>>>>>>>>                 
>>>>>>> It may work on x86 side. But for IA64, we have several source
>>>>>>> files and assembly files to implement a VMM module, which
>>>>>>> contains the virtualization logic of CPU, MMU and other platform
>>>>>>> devices. (In KVM forum, Anthony had presented IA64/KVM
>>>>>>> architecture which is a bit different with x86 side due to
>>>>>>> different approaches for VT.).If we put all such these
>>>>>>> arch-specific files in one directory, it looks very strange!
>>>>>>>
>>>>>>>
>>>>>>>               
>>>>>> ia64/ subdirectory is also fine.
>>>>>>
>>>>>>             
>>>>> But even so , we have to split current code to be arch-independent,
>>>>> and to support IA64 and other architectures.
>>>>> So, why not add an more subdirectory x86 in drivers kvm to hold
>>>>> X86-arch code? 
>>>>>
>>>>>           
>>>> Sure, that's not an issue.
>>>>         
>>> Could you help to open a branch from master tree for this work? We
>>> are very willing to contribute to it:)
>>>       
>> Do you really need a new branch? Why not just submit patches?
>>     
>
> Due to big changes to current source structure, maybe a new branch would
> help to work, and doesn't
> impact existing quality of KVM.  If it is convenient for you to submit
> patches directly, also we are glad to do in that way.
>   

A branch with such large changes quickly becomes out-of-date, so it's 
best to send patches.

-- 
Any sufficiently difficult bug is indistinguishable from a feature.
