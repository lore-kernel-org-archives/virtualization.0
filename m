From: Raghavendra K T <raghavendra.kt@linux.vnet.ibm.com>
Subject: Re: [PATCH RFC V4 0/5] kvm : Paravirt-spinlock support for KVM guests
Date: Tue, 17 Jan 2012 00:18:38 +0530
Message-ID: <4F147106.4040803@linux.vnet.ibm.com>
References: <20120114182501.8604.68416.sendpatchset@oc5400248562.ibm.com>
	<3EC1B881-0724-49E3-B892-F40BEB07D15D@suse.de>
	<4F14296B.4070003@linux.vnet.ibm.com> <4F142AF1.2020801@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <4F142AF1.2020801@redhat.com>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/virtualization/>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: Avi Kivity <avi@redhat.com>, Alexander Graf <agraf@suse.de>
Cc: Jeremy Fitzhardinge <jeremy@goop.org>, Greg Kroah-Hartman <gregkh@suse.de>, linux-doc@vger.kernel.org, Peter Zijlstra <peterz@infradead.org>, Jan Kiszka <jan.kiszka@siemens.com>, Virtualization <virtualization@lists.linux-foundation.org>, Paul Mackerras <paulus@samba.org>, "H. Peter Anvin" <hpa@zytor.com>, Stefano Stabellini <stefano.stabellini@eu.citrix.com>, Xen <xen-devel@lists.xensource.com>, Dave Jiang <dave.jiang@intel.com>, KVM <kvm@vger.kernel.org>, Rob Landley <rlandley@parallels.com>, X86 <x86@kernel.org>, Ingo Molnar <mingo@redhat.com>, Rik van Riel <riel@redhat.com>, Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>, Srivatsa Vaddagiri <vatsa@linux.vnet.ibm.com>, Sasha Levin <levinsasha928@gmail.com>, Sedat Dilek <sedat.dilek@gmail.com>, Thomas Gleixner <tglx@linutronix.de>, LKML <linux-kernel@vger.kernel.org>, Dave Hansen <dave@linux.vnet.ibm.com>, Suzuki
List-Id: virtualization@lists.linuxfoundation.org

On 01/16/2012 07:19 PM, Avi Kivity wrote:
> On 01/16/2012 03:43 PM, Raghavendra K T wrote:
>>>> Dbench:
>>>> Throughput is in MB/sec
>>>> NRCLIENTS     BASE                    BASE+patch
>>>> %improvement
>>>>                      mean (sd)               mean (sd)
>>>> 8           1.101190  (0.875082)     1.700395  (0.846809)     54.4143
>>>> 16          1.524312  (0.120354)     1.477553  (0.058166)     -3.06755
>>>> 32            2.143028  (0.157103)     2.090307  (0.136778)
>>>> -2.46012
>>>
>>> So on a very contended system we're actually slower? Is this expected?
>>>
>>>
>>
>>
>> I think, the result is interesting because its PLE machine. I have to
>> experiment more with parameters, SPIN_THRESHOLD, and also may be
>> ple_gap and ple_window.
>
> Perhaps the PLE stuff fights with the PV stuff?
>

I also think so. The slight advantage in PLE, with current patch would
be  that, we are be able to say " This is the next guy who should
probably get his turn".  But If total number of unnecessary "halt
exits" disadvantage dominates above advantage, then we see degradation.

One clarification in above benchmarking is,  Dbench is run
simultaneously on all (8 vcpu) 3 guests. So we already have 1:3 
overcommit when we run 8 clients of dbench. after that it was just 
increasing number of clients.
