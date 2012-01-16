From: Raghavendra K T <raghavendra.kt@linux.vnet.ibm.com>
Subject: Re: [PATCH RFC V4 0/5] kvm : Paravirt-spinlock support for KVM guests
Date: Mon, 16 Jan 2012 19:13:07 +0530
Message-ID: <4F14296B.4070003@linux.vnet.ibm.com>
References: <20120114182501.8604.68416.sendpatchset@oc5400248562.ibm.com>
	<3EC1B881-0724-49E3-B892-F40BEB07D15D@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <3EC1B881-0724-49E3-B892-F40BEB07D15D@suse.de>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/virtualization/>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: Alexander Graf <agraf@suse.de>
Cc: Jeremy Fitzhardinge <jeremy@goop.org>, Greg Kroah-Hartman <gregkh@suse.de>, linux-doc@vger.kernel.org, Peter Zijlstra <peterz@infradead.org>, Jan Kiszka <jan.kiszka@siemens.com>, Virtualization <virtualization@lists.linux-foundation.org>, Paul Mackerras <paulus@samba.org>, "H. Peter Anvin" <hpa@zytor.com>, Stefano Stabellini <stefano.stabellini@eu.citrix.com>, Xen <xen-devel@lists.xensource.com>, Dave Jiang <dave.jiang@intel.com>, KVM <kvm@vger.kernel.org>, Glauber Costa <glommer@redhat.com>, X86 <x86@kernel.org>, Ingo Molnar <mingo@redhat.com>, Avi Kivity <avi@redhat.com>, Rik van Riel <riel@redhat.com>, Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>, Srivatsa Vaddagiri <vatsa@linux.vnet.ibm.com>, Sasha Levin <levinsasha928@gmail.com>, Sedat Dilek <sedat.dilek@gmail.com>, Thomas Gleixner <tglx@linutronix.de>, LKML <linux-kernel@vger.kernel.org>, Dave Hansen <dave@linu>
List-Id: virtualization@lists.linuxfoundation.org

On 01/16/2012 09:27 AM, Alexander Graf wrote:
>
[...]
>> Result for PLE machine:
>> ======================
>> Machine : IBM xSeries with Intel(R) Xeon(R)  X7560 2.27GHz CPU with 32/64 core, with 8
>>          online cores and 4*64GB RAM
>>
>> Kernbench:
>> 		 BASE                    BASE+patch            %improvement
>> 		 mean (sd)               mean (sd)
>> Scenario A:	 			
>> case 1x:	 161.263 (56.518) 	 159.635 (40.5621) 	1.00953
>> case 2x:	 190.748 (61.2745) 	 190.606 (54.4766) 	0.0744438
>> case 3x:	 227.378 (100.215) 	 225.442 (92.0809) 	0.851446
>>
>> Scenario B:
>> 		 446.104 (58.54 )	 433.12733 (54.476)	2.91
>>
>> Dbench:
>> Throughput is in MB/sec
>> NRCLIENTS	 BASE                    BASE+patch            %improvement
>>                	 mean (sd)               mean (sd)
>> 8       	1.101190  (0.875082) 	1.700395  (0.846809) 	54.4143
>> 16      	1.524312  (0.120354) 	1.477553  (0.058166) 	-3.06755
>> 32        	2.143028  (0.157103) 	2.090307  (0.136778) 	-2.46012
>
> So on a very contended system we're actually slower? Is this expected?
>
>

I think, the result is interesting because its PLE machine. I have to 
experiment more with parameters, SPIN_THRESHOLD, and also may be ple_gap 
and ple_window.

> Alex
>
>
