From: Raghavendra K T <raghavendra.kt@linux.vnet.ibm.com>
Subject: Re: [PATCH  V12 0/14] Paravirtualized ticket spinlocks
Date: Thu, 08 Aug 2013 08:29:27 +0530
Message-ID: <5203098F.908@linux.vnet.ibm.com>
References: <20130806114020.20643.57235.sendpatchset@codeblue.in.ibm.com>
	<52016412.1020608@zytor.com> <5201B6FB.5080807@linux.vnet.ibm.com>
	<5201D180.9080005@zytor.com> <5201ED01.7000803@linux.vnet.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <5201ED01.7000803@linux.vnet.ibm.com>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/virtualization/>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: "H. Peter Anvin" <hpa@zytor.com>
Cc: jeremy@goop.org, gregkh@suse.de, kvm@vger.kernel.org, linux-doc@vger.kernel.org, peterz@infradead.org, drjones@redhat.com, virtualization@lists.linux-foundation.org, andi@firstfloor.org, stefano.stabellini@eu.citrix.com, xen-devel@lists.xensource.com, x86@kernel.org, mingo@redhat.com, habanero@linux.vnet.ibm.com, riel@redhat.com, konrad.wilk@oracle.com, ouyang@cs.pitt.edu, avi.kivity@gmail.com, tglx@linutronix.de, chegu_vinod@hp.com, linux-kernel@vger.kernel.org, srivatsa.vaddagiri@gmail.com, attilio.rao@citrix.com, pbonzini@redhat.com, torvalds@linux-foundation.org
List-Id: virtualization@lists.linuxfoundation.org

On 08/07/2013 12:15 PM, Raghavendra K T wrote:
> On 08/07/2013 10:18 AM, H. Peter Anvin wrote:
>> tip:master is not a stable branch; it is more like linux-next.  We need
>> to figure out which topic branches are dependencies for this set.
>
> Okay. I 'll start looking at the branches that would get affected.
> (Xen, kvm are obvious ones).
> Please do let me know the branches I might have to check for.

On Linus tree,
I am seeing patch getting applied to arch/x86/Kconfig at some offset

Hunk #1 succeeded at 632 (offset -31 lines).
Hunk #2 succeeded at 657 (offset -31 lines).

since patches are based on -rc4, Xen, kvm should not have problem
as pointed by Gleb, Konrad.
I did not see change in tip's jumplabel/core-spinlock tree that would
affect it.

Peter, could you please point me to the conflict, so that I can help
there which saves time and trouble to maintainers.
