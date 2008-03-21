From: Carsten Otte <cotte@de.ibm.com>
Subject: Re: [kvm-devel] [RFC/PATCH 05/15] KVM_MAX_VCPUS
Date: Fri, 21 Mar 2008 12:13:16 +0100
Message-ID: <47E3984C.9090709__14785.5999101468$1206098545$gmane$org@de.ibm.com>
References: <1206028710.6690.21.camel@cotte.boeblingen.de.ibm.com>	<1206030298.6690.56.camel@cotte.boeblingen.de.ibm.com>	<1206031383.6356.13.camel@basalt>
	<47E2954B.7090903@de.ibm.com> <47E390CD.7010401@qumranet.com>
Reply-To: carsteno@de.ibm.com
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <47E390CD.7010401@qumranet.com>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/virtualization>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: Avi Kivity <avi@qumranet.com>
Cc: Christian Ehrhardt <EHRHARDT@de.ibm.com>, Hollis Blanchard <hollisb@us.ibm.com>, arnd@arndb.de, carsteno@de.ibm.com, heicars2@linux.vnet.ibm.com, mschwid2@linux.vnet.ibm.com, jeroney@us.ibm.com, borntrae@linux.vnet.ibm.com, virtualization@lists.linux-foundation.org, kvm-devel@lists.sourceforge.net, rvdheij@gmail.com, Olaf Schnapper <os@de.ibm.com>, jblunck@suse.de, "Zhang,
	Xiantao" <xiantao.zhang@intel.com>
List-Id: virtualization@lists.linuxfoundation.org

Avi Kivity wrote:
> Carsten Otte wrote:
>> Hollis Blanchard wrote:
>>  
>>> On Thu, 2008-03-20 at 17:24 +0100, Carsten Otte wrote:
>>>    
>>>> Index: kvm/include/linux/kvm_host.h
>>>> ===================================================================
>>>> --- kvm.orig/include/linux/kvm_host.h
>>>> +++ kvm/include/linux/kvm_host.h
>>>> @@ -24,7 +24,11 @@
>>>>
>>>>  #include <asm/kvm_host.h>
>>>>
>>>> +#ifdef CONFIG_S390
>>>> +#define KVM_MAX_VCPUS 64
>>>> +#else
>>>>  #define KVM_MAX_VCPUS 16
>>>> +#endif
>>>>  #define KVM_MEMORY_SLOTS 32
>>>>  /* memory slots that does not exposed to userspace */
>>>>  #define KVM_PRIVATE_MEM_SLOTS 4
>>>>
>>>>       
>>> Why don't we just define this in <asm/kvm_host.h> ?
>>>     
>> No problem with that, I just wanted to keep impact on common code very 
>> low and things like this seperated from the actual port. I have a few 
>> things like this that can safely be taken care about later.
>>
>>   
> 
> Since there were a few other comments, I went ahead and moved those 
> #defines to asm-x86.
Great! I will rebase the patch series.
