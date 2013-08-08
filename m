From: "H. Peter Anvin" <hpa@zytor.com>
Subject: Re: [PATCH  V12 0/14] Paravirtualized ticket spinlocks
Date: Thu, 08 Aug 2013 16:04:09 -0700
Message-ID: <520423E9.80507@zytor.com>
References: <20130806114020.20643.57235.sendpatchset@codeblue.in.ibm.com>
	<52016412.1020608@zytor.com> <5201B6FB.5080807@linux.vnet.ibm.com>
	<5201D180.9080005@zytor.com> <5201ED01.7000803@linux.vnet.ibm.com>
	<20130808005012.GI2810@phenom.dumpdata.com>
	<20130808010251.GJ15901@redhat.com> <52040A05.5080107@zytor.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <52040A05.5080107@zytor.com>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/virtualization/>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: Gleb Natapov <gleb@redhat.com>
Cc: jeremy@goop.org, x86@kernel.org, kvm@vger.kernel.org, linux-doc@vger.kernel.org, peterz@infradead.org, drjones@redhat.com, virtualization@lists.linux-foundation.org, andi@firstfloor.org, stefano.stabellini@eu.citrix.com, xen-devel@lists.xensource.com, Raghavendra K T <raghavendra.kt@linux.vnet.ibm.com>, mingo@redhat.com, habanero@linux.vnet.ibm.com, riel@redhat.com, Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>, ouyang@cs.pitt.edu, avi.kivity@gmail.com, tglx@linutronix.de, chegu_vinod@hp.com, gregkh@suse.de, linux-kernel@vger.kernel.org, srivatsa.vaddagiri@gmail.com, attilio.rao@citrix.com, pbonzini@redhat.com, torvalds@linux-foundation.org
List-Id: virtualization@lists.linuxfoundation.org

On 08/08/2013 02:13 PM, H. Peter Anvin wrote:
> On 08/07/2013 06:02 PM, Gleb Natapov wrote:
>> On Wed, Aug 07, 2013 at 08:50:12PM -0400, Konrad Rzeszutek Wilk wrote:
>>> On Wed, Aug 07, 2013 at 12:15:21PM +0530, Raghavendra K T wrote:
>>>> On 08/07/2013 10:18 AM, H. Peter Anvin wrote:
>>>>>> Please let me know, if I should rebase again.
>>>>>>
>>>>>
>>>>> tip:master is not a stable branch; it is more like linux-next.  We need
>>>>> to figure out which topic branches are dependencies for this set.
>>>>
>>>> Okay. I 'll start looking at the branches that would get affected.
>>>> (Xen, kvm are obvious ones).
>>>> Please do let me know the branches I might have to check for.
>>>
>>> >From the Xen standpoint anything past v3.11-rc4 would work.
>>>
>> For KVM as early as past v3.11-rc1 would be OK.
>>
> 
> I'm still completely confused as to the base of this patchset.  The
> first patch has the following hunk for arch/x86/include/asm/paravirt.h:
> 

Okay, I figured it out.

One of several problems with the formatting of this patchset is that it
has one- and two-digit patch numbers in the headers, which meant that my
scripts tried to apply patch 10 first.

	-hpa
