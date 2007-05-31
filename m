From: Avi Kivity <avi@qumranet.com>
Subject: Re: [kvm-devel] [PATCH 3/3] Eliminate read_cr3 on TLB flush
Date: Thu, 31 May 2007 10:50:39 +0300
Message-ID: <465E7E4F.8050208__40704.9714857296$1180597905$gmane$org@qumranet.com>
References: <97D612E30E1F88419025B06CB4CF1BE10259AD95@scsmsx412.amr.corp.intel.com>
	<465DCED8.4080506@us.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <465DCED8.4080506@us.ibm.com>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/virtualization>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: Anthony Liguori <aliguori@us.ibm.com>
Cc: kvm-devel <kvm-devel@lists.sourceforge.net>, virtualization@lists.linux-foundation.org
List-Id: virtualization@lists.linuxfoundation.org

Anthony Liguori wrote:
>>>     
>>>       
>> For KVM, it should be okay as well. But we can replace two CR4 accesses
>> with just one hypercall.
>>   
>>     
>
> I was thinking the same thing :-)
>
> I was actually thinking about adding a hypercall to set/clear a bit in a 
> control register.  The thought here is that it would be useful not just 
> for the global bit but also for CR0.TS although we would need another 
> paravirt_op hook for stts.
>   

Are global tlb flushes frequent enough to warrant optimization?

-- 
error compiling committee.c: too many arguments to function
