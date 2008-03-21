From: Carsten Otte <cotte@de.ibm.com>
Subject: Re: [kvm-devel] [RFC/PATCH 06/15] kvm-s390: sie intercept handling
Date: Fri, 21 Mar 2008 12:26:29 +0100
Message-ID: <47E39B65.6010201__37452.3696526468$1206099146$gmane$org@de.ibm.com>
References: <1206028710.6690.21.camel@cotte.boeblingen.de.ibm.com>
	<1206030302.6690.57.camel@cotte.boeblingen.de.ibm.com>
	<47E393A5.2010602@qumranet.com>
Reply-To: carsteno@de.ibm.com
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <47E393A5.2010602@qumranet.com>
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
Cc: Christian Ehrhardt <EHRHARDT@de.ibm.com>, arnd@arndb.de, hollisb@us.ibm.com, kvm-devel@lists.sourceforge.net, mschwid2@linux.vnet.ibm.com, heicars2@linux.vnet.ibm.com, jeroney@us.ibm.com, borntrae@linux.vnet.ibm.com, virtualization@lists.linux-foundation.org, rvdheij@gmail.com, Olaf Schnapper <os@de.ibm.com>, jblunck@suse.de, "Zhang,
	Xiantao" <xiantao.zhang@intel.com>
List-Id: virtualization@lists.linuxfoundation.org

Avi Kivity wrote:
> Carsten Otte wrote:
>>  
>>  /* for KVM_RUN, returned by mmap(vcpu_fd, offset=0) */
>>  struct kvm_run {
>> @@ -138,6 +139,14 @@ struct kvm_run {
>>              __u32 is_write;
>>              __u32 pad;
>>          } tpr_access;
>> +        /* KVM_EXIT_S390_SIEIC */
>> +        struct {
>> +            __u8 icptcode;
>> +            __u64 mask; /* psw upper half */
>> +            __u64 addr; /* psw lower half */
>> +            __u16 ipa;
>> +            __u32 ipb;
>> +        } s390_sieic;
>>          /* Fix the size of the union. */
>>          char padding[256];
>>      };
>>
>>   
> 
> Do you support 32-bit userspace on 64-bit kernel?  If so, this is likely 
> badly aligned.
32bit userspace is not pracitcal, current enterprise distributions 
come with 64bit only on s390. Nevertheless, I don't get your point on 
allignment. What is the problem caused by the struct, and how can I 
solve it?
