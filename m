From: Raghavendra K T <raghavendra.kt@linux.vnet.ibm.com>
Subject: Re: [PATCH V12 3/5] kvm : Fold pv_unhalt flag into GET_MP_STATE ioctl
	to aid migration
Date: Wed, 07 Aug 2013 00:40:36 +0530
Message-ID: <52014A2C.5080705__37657.1178473116$1375815860$gmane$org@linux.vnet.ibm.com>
References: <20130806182150.2386.95104.sendpatchset@codeblue.in.ibm.com>
	<20130806182309.2386.35697.sendpatchset@codeblue.in.ibm.com>
	<CAG7+5M3_4D+hQn3xWefniKRWzkdraLCJKHG2PrLGPZLJQQUZVA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <CAG7+5M3_4D+hQn3xWefniKRWzkdraLCJKHG2PrLGPZLJQQUZVA@mail.gmail.com>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/virtualization/>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: Eric Northup <digitaleric@google.com>
Cc: Jeremy Fitzhardinge <jeremy@goop.org>, KVM <kvm@vger.kernel.org>, linux-doc@vger.kernel.org, Peter Zijlstra <peterz@infradead.org>, drjones@redhat.com, lf-virt <virtualization@lists.linux-foundation.org>, srivatsa.vaddagiri@gmail.com, "H. Peter Anvin" <hpa@zytor.com>, the arch/x86 maintainers <x86@kernel.org>, Ingo Molnar <mingo@redhat.com>, habanero@linux.vnet.ibm.com, Rik van Riel <riel@redhat.com>, Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>, ouyang@cs.pitt.edu, avi.kivity@gmail.com, Thomas Gleixner <tglx@linutronix.de>, chegu_vinod@hp.com, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Andi Kleen <andi@firstfloor.org>, Paolo Bonzini <pbonzini@redhat.com>, Linus Torvalds <torvalds@linux-foundation.org>
List-Id: virtualization@lists.linuxfoundation.org

On 08/07/2013 12:02 AM, Eric Northup wrote:
>
> If this is about migration correctness, could it get folded into the
> previous patch 2/5, so that there's not a broken commit which could
> hurt bisection?

Yes. It could be. Only reason I maintained like that was,
original author in the previous patch is different (Srivatsa) and I did
not want to merge this hunk when the patch series got evolved to mix
the sign-offs.

Gleb, Paolo please let me know.
