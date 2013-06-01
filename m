From: Jeremy Fitzhardinge <jeremy@goop.org>
Subject: Re: [PATCH RFC V9 0/19] Paravirtualized ticket spinlocks
Date: Sat, 01 Jun 2013 13:28:00 -0700
Message-ID: <51AA5950.6050603__37730.2960063846$1370119053$gmane$org@goop.org>
References: <20130601082145.22955.33596.sendpatchset@codeblue>
	<20130601201442.GP6123@two.firstfloor.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <20130601201442.GP6123@two.firstfloor.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/virtualization/>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: Andi Kleen <andi@firstfloor.org>
Cc: x86@kernel.org, kvm@vger.kernel.org, linux-doc@vger.kernel.org, peterz@infradead.org, drjones@redhat.com, virtualization@lists.linux-foundation.org, srivatsa.vaddagiri@gmail.com, hpa@zytor.com, stefano.stabellini@eu.citrix.com, xen-devel@lists.xensource.com, Raghavendra K T <raghavendra.kt@linux.vnet.ibm.com>, mingo@redhat.com, habanero@linux.vnet.ibm.com, riel@redhat.com, konrad.wilk@oracle.com, ouyang@cs.pitt.edu, avi.kivity@gmail.com, tglx@linutronix.de, chegu_vinod@hp.com, gregkh@suse.de, linux-kernel@vger.kernel.org, attilio.rao@citrix.com, pbonzini@redhat.com, torvalds@linux-foundation.org, stephan.diestelhorst@amd.com
List-Id: virtualization@lists.linuxfoundation.org

On 06/01/2013 01:14 PM, Andi Kleen wrote:
> FWIW I use the paravirt spinlock ops for adding lock elision
> to the spinlocks.

Does lock elision still use the ticketlock algorithm/structure, or are
they different?  If they're still basically ticketlocks, then it seems
to me that they're complimentary - hle handles the fastpath, and pv the
slowpath.

> This needs to be done at the top level (so the level you're removing)
>
> However I don't like the pv mechanism very much and would 
> be fine with using an static key hook in the main path
> like I do for all the other lock types.

Right.

    J
