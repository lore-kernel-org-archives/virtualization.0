From: Avi Kivity <avi@redhat.com>
Subject: Re: [PATCH RFC V4 4/5] kvm : pv-ticketlocks support for linux guests
	running on KVM hypervisor
Date: Tue, 24 Jan 2012 16:08:51 +0200
Message-ID: <4F1EBB73.3000705@redhat.com>
References: <20120114182501.8604.68416.sendpatchset@oc5400248562.ibm.com>
	<20120114182645.8604.68884.sendpatchset@oc5400248562.ibm.com>
	<20120117110210.GA17420@amt.cnet>
	<20120117113312.GB30398@linux.vnet.ibm.com>
	<4F1621B2.3020203@goop.org>
	<20120118135445.GB25711@linux.vnet.ibm.com>
	<4F173F0F.5020604@goop.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <4F173F0F.5020604@goop.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/virtualization/>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: Jeremy Fitzhardinge <jeremy@goop.org>
Cc: Raghavendra K T <raghavendra.kt@linux.vnet.ibm.com>, linux-doc@vger.kernel.org, Peter Zijlstra <peterz@infradead.org>, Jan Kiszka <jan.kiszka@siemens.com>, Srivatsa Vaddagiri <vatsa@linux.vnet.ibm.com>, Paul Mackerras <paulus@samba.org>, "H. Peter Anvin" <hpa@zytor.com>, Stefano Stabellini <stefano.stabellini@eu.citrix.com>, Xen <xen-devel@lists.xensource.com>, Dave Jiang <dave.jiang@intel.com>, KVM <kvm@vger.kernel.org>, Glauber Costa <glommer@redhat.com>, X86 <x86@kernel.org>, Ingo Molnar <mingo@redhat.com>, Rik van Riel <riel@redhat.com>, Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>, Greg Kroah-Hartman <gregkh@suse.de>, Sasha Levin <levinsasha928@gmail.com>, Sedat Dilek <sedat.dilek@gmail.com>, Thomas Gleixner <tglx@linutronix.de>, Virtualization <virtualization@lists.linux-foundation.org>, LKML <linux-kernel@vger.kernel.org>, Dave Hansen <dave@linux.vnet.ibm.com>
List-Id: virtualization@lists.linuxfoundation.org

On 01/18/2012 11:52 PM, Jeremy Fitzhardinge wrote:
> On 01/19/2012 12:54 AM, Srivatsa Vaddagiri wrote:
> >
> >> That logic relies on the "kick" being level triggered, so that "kick"
> >> before "block" will cause the block to fall out immediately.  If you're
> >> using "hlt" as the block and it has the usual edge-triggered behaviour,
> >> what stops a "kick-before-hlt" from losing the kick?
> > Hmm ..'hlt' should result in a check for kick request (in hypervisor
> > context) before vcpu is put to sleep. IOW vcpu1 that is attempting to kick vcpu0
> > will set a 'somebody_tried_kicking_vcpu0' flag, which hypervisor should check 
> > before it puts vcpu0 to sleep because of trapped 'hlt' instruction.
> >
> > Won't that trap the 'kick-before-hlt' case? What am I missing here?
>
> Nothing, that sounds fine.  It wasn't clear to me that your kick
> operation left persistent state, and so has a level-triggered effect on hlt.
>

btw, this persistent state needs to be saved/restored for live
migration.  Best to put it into some MSR.

-- 
error compiling committee.c: too many arguments to function
