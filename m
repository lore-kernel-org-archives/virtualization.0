From: Juergen Gross <jgross@suse.com>
Subject: Re: [PATCH] x86/paravirt: Drop {read,write}_cr8() hooks
Date: Mon, 15 Jul 2019 16:52:11 +0200
Message-ID: <f51ce980-599b-cae3-e3fa-4a67443ea128__10257.1474433475$1563202346$gmane$org@suse.com>
References: <20190715130056.10627-1-andrew.cooper3@citrix.com>
	<a04918d1-975e-5869-1ecd-c9df4ae5b1c1@suse.com>
	<CALCETrX0T=vzyN8gqoBmA72xwzS45d5bDTfcZQJayht9n9ijPA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <CALCETrX0T=vzyN8gqoBmA72xwzS45d5bDTfcZQJayht9n9ijPA@mail.gmail.com>
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
To: Andy Lutomirski <luto@kernel.org>
Cc: FengTang <feng.tang@intel.com>, Peter Zijlstra <peterz@infradead.org>, Andrew Cooper <andrew.cooper3@citrix.com>, X86 ML <x86@kernel.org>, "Rafael J.Wysocki" <rjw@rjwysocki.net>, LKML <linux-kernel@vger.kernel.org>, Stephane Eranian <eranian@google.com>, Linux Virtualization <virtualization@lists.linux-foundation.org>, Borislav Petkov <bp@alien8.de>, Pavel Machek <pavel@ucw.cz>, Nadav Amit <namit@vmware.com>, Boris Ostrovsky <boris.ostrovsky@oracle.com>, Alok Kataria <akataria@vmware.com>
List-Id: virtualization@lists.linuxfoundation.org

On 15.07.19 16:26, Andy Lutomirski wrote:
> On Mon, Jul 15, 2019 at 6:23 AM Juergen Gross <jgross@suse.com> wrote:
>>
>> On 15.07.19 15:00, Andrew Cooper wrote:
>>> There is a lot of infrastructure for functionality which is used
>>> exclusively in __{save,restore}_processor_state() on the suspend/resume
>>> path.
>>>
>>> cr8 is an alias of APIC_TASKPRI, and APIC_TASKPRI is saved/restored
>>> independently by lapic_{suspend,resume}().
>>
>> Aren't those called only with CONFIG_PM set?
>>
> 
> 
> Unless I'm missing something, we only build any of the restore code
> (including the write_cr8() call) if CONFIG_PM_SLEEP is set, and that
> selects CONFIG_PM, so we should be fine, I think.
> 

Okay, in that case I'd suggest to remove "cr8" from struct saved_context
as it won't be used any longer.


Juergen
