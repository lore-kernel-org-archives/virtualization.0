From: Juergen Gross <jgross@suse.com>
Subject: Re: [PATCH 0/2] Remove 32-bit Xen PV guest support
Date: Mon, 15 Jul 2019 14:36:37 +0200
Message-ID: <83fd65e0-9b6f-39a0-4f10-4f535d523ac8__7446.98786163411$1563194209$gmane$org@suse.com>
References: <20190715113739.17694-1-jgross@suse.com>
	<20190715123207.GE3419@hirez.programming.kicks-ass.net>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <20190715123207.GE3419@hirez.programming.kicks-ass.net>
Content-Language: de-DE
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/virtualization/>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: Peter Zijlstra <peterz@infradead.org>
Cc: Stefano Stabellini <sstabellini@kernel.org>, x86@kernel.org, Alok Kataria <akataria@vmware.com>, linux-kernel@vger.kernel.org, virtualization@lists.linux-foundation.org, Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>, Andy Lutomirski <luto@kernel.org>, "H. Peter Anvin" <hpa@zytor.com>, xen-devel@lists.xenproject.org, Thomas Gleixner <tglx@linutronix.de>, Boris Ostrovsky <boris.ostrovsky@oracle.com>
List-Id: virtualization@lists.linuxfoundation.org

On 15.07.19 14:32, Peter Zijlstra wrote:
> On Mon, Jul 15, 2019 at 01:37:37PM +0200, Juergen Gross wrote:
>> The long term plan has been to replace Xen PV guests by PVH. The first
>> victim of that plan are now 32-bit PV guests, as those are used only
>> rather seldom these days. Xen on x86 requires 64-bit support and with
>> Grub2 now supporting PVH officially since version 2.04 there is no
>> need to keep 32-bit PV guest support alive in the Linux kernel.
>> Additionally Meltdown mitigation is not available in the kernel running
>> as 32-bit PV guest, so dropping this mode makes sense from security
>> point of view, too.
>>
>> Juergen Gross (2):
>>    x86/xen: remove 32-bit Xen PV guest support
>>    x86/paravirt: remove 32-bit support from PARAVIRT_XXL
> 
> Hooray!
> 

Always a pleasure to cheer the community up by sending Xen patches. :-D


Juergen
