From: Josh Poimboeuf <jpoimboe@redhat.com>
Subject: Re: [Xen-devel] [PATCH 11/13] x86/paravirt: Add paravirt
	alternatives infrastructure
Date: Tue, 17 Oct 2017 15:50:37 -0500
Message-ID: <20171017205037.rnqto2i2hul4q2s4__4434.08559444851$1509080576$gmane$org@treble>
References: <5a49e43a-8d6b-512a-ec5a-641be7bae41d@oracle.com>
	<ed30216f-4b9e-2bc3-b1d2-36135b29d746@citrix.com>
	<a6c3be0b-35f4-8d23-4ea2-ead94a3fc69e@oracle.com>
	<b9fdc3ec-87cd-da0e-47b7-67cdae8ffb97@oracle.com>
	<20171017052413.nzbqniurzw7eim4b@treble>
	<de621b0b-f767-222a-e1de-aabd0e9a0bf9@oracle.com>
	<20171017143613.6i7auk3mqcqayx3o@treble>
	<2e7890fb-3634-0f3b-003f-fc1772504b9a@oracle.com>
	<20171017201743.tnw6wulu4gjvkqli@treble>
	<44a2cbeb-7424-0a2a-7f9c-b669e049bded@oracle.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
Content-Disposition: inline
In-Reply-To: <44a2cbeb-7424-0a2a-7f9c-b669e049bded@oracle.com>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/virtualization/>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: Boris Ostrovsky <boris.ostrovsky@oracle.com>
Cc: Juergen Gross <jgross@suse.com>, Mike Galbraith <efault@gmx.de>, Ingo Molnar <mingo@kernel.org>, Peter Zijlstra <peterz@infradead.org>, Andrew Cooper <andrew.cooper3@citrix.com>, Rusty Russell <rusty@rustcorp.com.au>, virtualization@lists.linux-foundation.org, x86@kernel.org, linux-kernel@vger.kernel.org, Chris Wright <chrisw@sous-sol.org>, live-patching@vger.kernel.org, Linus Torvalds <torvalds@linux-foundation.org>, Borislav Petkov <bp@alien8.de>, Andy Lutomirski <luto@kernel.org>, "H. Peter Anvin" <hpa@zytor.com>, xen-devel@lists.xenproject.org, Thomas Gleixner <tglx@linutronix.de>, Sasha Levin <alexander.levin@verizon.com>, Jiri Slaby <jslaby@suse.cz>, Alok Kataria <akataria@vmware.com>
List-Id: virtualization@lists.linuxfoundation.org

On Tue, Oct 17, 2017 at 04:36:00PM -0400, Boris Ostrovsky wrote:
> On 10/17/2017 04:17 PM, Josh Poimboeuf wrote:
> > On Tue, Oct 17, 2017 at 11:36:57AM -0400, Boris Ostrovsky wrote:
> >> On 10/17/2017 10:36 AM, Josh Poimboeuf wrote:
> >>> Maybe we can add a new field to the alternatives entry struct which
> >>> specifies the offset to the CALL instruction, so apply_alternatives()
> >>> can find it.
> >> We'd also have to assume that the restore part of an alternative entry
> >> is the same size as the save part. Which is true now.
> > Why?
> >
> 
> Don't you need to know the size of the instruction without save and
> restore part?
> 
> + if (a->replacementlen == 6 && *insnbuf == 0xff && *(insnbuf+1) == 0x15)
> 
> Otherwise you'd need another field for the actual instruction length.

If we know where the CALL instruction starts, and can verify that it
starts with "ff 15", then we know the instruction length: 6 bytes.
Right?

-- 
Josh
