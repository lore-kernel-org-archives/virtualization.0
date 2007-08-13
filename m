From: Avi Kivity <avi@qumranet.com>
Subject: Re: [kvm-devel] [PATCH 0/2][KVM] guest time accounting
Date: Mon, 13 Aug 2007 11:38:15 +0300
Message-ID: <46C01877.7060007__11411.7703437389$1186994385$gmane$org@qumranet.com>
References: <46BC8B39.6050202@bull.net> <46C00FC1.1070306@qumranet.com>
	<46C012A8.2040908@bull.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <46C012A8.2040908@bull.net>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/virtualization>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: Laurent Vivier <Laurent.Vivier@bull.net>
Cc: kvm-devel <kvm-devel@lists.sourceforge.net>, Ingo Molnar <mingo@elte.hu>, linux-kernel <linux-kernel@vger.kernel.org>, virtualization <virtualization@lists.linux-foundation.org>
List-Id: virtualization@lists.linuxfoundation.org

Laurent Vivier wrote:
>> - perhaps the new fields should be guarded by a #ifdef CONFIG_HYPERVISOR
>> (selected by CONFIG_KVM)?  that way the (minor) additional overhead is
>> only incurred if it can possibly be used.  I imagine that our canine
>> cousin will want to use this as well.
>>     
>
> There is also a CONFIG_VIRTUALIZATION and a CONFIG_VIRT_CPU_ACCOUNTING (from
> s390 and powerpc) Which one to use ?
>   

Are these options for using the kernel as a guest or host?  I'd guess 
the former.

> I'm wondering if we can have a more accurate accounting:
>
> - For the moment we add all system time since the previous entering to the VCPU
> to the guest time (and I guess there is some real system time in it ???)
>
> - Perhaps we can sum nanoseconds spent in the VCPU and add it to cpustat when
> these ns are greater than 1 ms ? (I'm trying to make something in this way)
>   

I think that it's okay to use the same method as user/system time 
accounting.  But Ingo the the right man to ask.


-- 
error compiling committee.c: too many arguments to function
