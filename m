From: Andy Lutomirski <luto@kernel.org>
Subject: Re: [PATCH] x86/paravirt: Drop {read,write}_cr8() hooks
Date: Mon, 15 Jul 2019 07:26:25 -0700
Message-ID: <CALCETrX0T=vzyN8gqoBmA72xwzS45d5bDTfcZQJayht9n9ijPA@mail.gmail.com>
References: <20190715130056.10627-1-andrew.cooper3@citrix.com>
	<a04918d1-975e-5869-1ecd-c9df4ae5b1c1@suse.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <a04918d1-975e-5869-1ecd-c9df4ae5b1c1@suse.com>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/virtualization/>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: Juergen Gross <jgross@suse.com>
Cc: FengTang <feng.tang@intel.com>, Pavel Machek <pavel@ucw.cz>, Peter Zijlstra <peterz@infradead.org>, Andrew Cooper <andrew.cooper3@citrix.com>, X86 ML <x86@kernel.org>, "Rafael J.Wysocki" <rjw@rjwysocki.net>, LKML <linux-kernel@vger.kernel.org>, Stephane Eranian <eranian@google.com>, Linux Virtualization <virtualization@lists.linux-foundation.org>, Borislav Petkov <bp@alien8.de>, Andy Lutomirski <luto@kernel.org>, Nadav Amit <namit@vmware.com>, Boris Ostrovsky <boris.ostrovsky@oracle.com>, Alok Kataria <akataria@vmware.com>
List-Id: virtualization@lists.linuxfoundation.org

On Mon, Jul 15, 2019 at 6:23 AM Juergen Gross <jgross@suse.com> wrote:
>
> On 15.07.19 15:00, Andrew Cooper wrote:
> > There is a lot of infrastructure for functionality which is used
> > exclusively in __{save,restore}_processor_state() on the suspend/resume
> > path.
> >
> > cr8 is an alias of APIC_TASKPRI, and APIC_TASKPRI is saved/restored
> > independently by lapic_{suspend,resume}().
>
> Aren't those called only with CONFIG_PM set?
>


Unless I'm missing something, we only build any of the restore code
(including the write_cr8() call) if CONFIG_PM_SLEEP is set, and that
selects CONFIG_PM, so we should be fine, I think.
