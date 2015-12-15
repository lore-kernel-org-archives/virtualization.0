From: Andrew Cooper <andrew.cooper3@citrix.com>
Subject: Re: [Xen-devel] [PATCH v2 0/3] Fix and cleanup for 32-bit PV sysexit
Date: Tue, 15 Dec 2015 20:40:46 +0000
Message-ID: <56707ACE.9060809__24928.5868522295$1450212066$gmane$org@citrix.com>
References: <1447970147-1733-1-git-send-email-boris.ostrovsky@oracle.com>
	<CALCETrUeGoeB8vNgbRNkFXjH0A570=M+4L1sRsfh-7btym59nA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <CALCETrUeGoeB8vNgbRNkFXjH0A570=M+4L1sRsfh-7btym59nA@mail.gmail.com>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/virtualization/>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: Andy Lutomirski <luto@amacapital.net>, Boris Ostrovsky <boris.ostrovsky@oracle.com>
Cc: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, Linux Virtualization <virtualization@lists.linux-foundation.org>, Ingo Molnar <mingo@redhat.com>, David Vrabel <david.vrabel@citrix.com>, Andrew Lutomirski <luto@kernel.org>, "H. Peter Anvin" <hpa@zytor.com>, "xen-devel@lists.xenproject.org" <xen-devel@lists.xenproject.org>, Thomas Gleixner <tglx@linutronix.de>, Borislav Petkov <bp@suse.de>
List-Id: virtualization@lists.linuxfoundation.org

On 19/11/15 22:07, Andy Lutomirski wrote:
> On Thu, Nov 19, 2015 at 1:55 PM, Boris Ostrovsky
> <boris.ostrovsky@oracle.com> wrote:
>> The first patch fixes Xen PV regression introduced by 32-bit rewrite. Unlike the
>> earlier version it uses ALTERNATIVE instruction and avoids using xen_sysexit
>> (and sysret32 in compat mode) pv ops, as suggested by Andy.
>>
>> As result of this patch irq_enable_sysexit and usergs_sysret32 pv ops are not
>> used anymore by anyone and so can be removed.
> This whole series is:
>
> Acked-by: Andy Lutomirski <luto@kernel.org>
>
> Now I just have to sucker someone into getting rid of
> PARAVIRT_ADJUST_EXCEPTION_FRAME (by using stub entries) and the
> overcomplicated syscall entry stuff.  :)

Looking at this, it should be quite easy now.

ALTERNATIVE "", "pop %rcx; %pop %11", X86_FEATURE_XENPV

(Completely untested)

> And whoever gets rid of
> PARAVIRT_ADJUST_EXCEPTION_FRAME gets to wonder why it doesn't crash
> and burn for NMIs on Xen, since I'm reasonably confident that it can't
> possibly be correct.

The Xen PV ABI only has a single kernel stack pointer which may be
registered.  There is no equivalent of an IST, so if a second fault
occurs, it is delivered normally on the current stack.

By the looks of it, the other NMI handling is ambivalent to the fact
that it isn't really on an IST stack under Xen.

~Andrew
