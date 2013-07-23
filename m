From: Raghavendra K T <raghavendra.kt@linux.vnet.ibm.com>
Subject: Re: [PATCH RFC V11 0/18] Paravirtualized ticket spinlocks
Date: Tue, 23 Jul 2013 08:20:46 +0530
Message-ID: <51EDEF86.9040405@linux.vnet.ibm.com>
References: <20130722061631.24737.75508.sendpatchset@codeblue>
	<20130722193627.GP30300@phenom.dumpdata.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <20130722193627.GP30300@phenom.dumpdata.com>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/virtualization/>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>
Cc: jeremy@goop.org, gregkh@suse.de, kvm@vger.kernel.org, linux-doc@vger.kernel.org, peterz@infradead.org, drjones@redhat.com, virtualization@lists.linux-foundation.org, andi@firstfloor.org, hpa@zytor.com, xen-devel@lists.xensource.com, x86@kernel.org, mingo@redhat.com, habanero@linux.vnet.ibm.com, riel@redhat.com, stefano.stabellini@eu.citrix.com, ouyang@cs.pitt.edu, avi.kivity@gmail.com, tglx@linutronix.de, chegu_vinod@hp.com, linux-kernel@vger.kernel.org, srivatsa.vaddagiri@gmail.com, attilio.rao@citrix.com, pbonzini@redhat.com, torvalds@linux-foundation.org
List-Id: virtualization@lists.linuxfoundation.org

On 07/23/2013 01:06 AM, Konrad Rzeszutek Wilk wrote:
>>
>> github link: https://github.com/ktraghavendra/linux/tree/pvspinlock_v11
>
> And chance you have a backup git tree? I get:
>
> This repository is temporarily unavailable.

I only have it on local apart from there :(.
Hope it was a temporary github problem. working for me now.

>
>>
>> Please note that we set SPIN_THRESHOLD = 32k with this series,
>> that would eatup little bit of overcommit performance of PLE machines
>> and overall performance of non-PLE machines.
>>
>> The older series[3] was tested by Attilio for Xen implementation.
>>
>> Note that Konrad needs to revert below two patches to enable xen on hvm
>>    70dd4998, f10cd522c
>
> We could add that to the series. But let me first test it out - and that
> gets back to the repo :-)
>

okay.
