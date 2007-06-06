From: Keir Fraser <keir@xensource.com>
Subject: Re: [Xen-devel] [patch 14/33] xen: xen time implementation
Date: Wed, 06 Jun 2007 12:52:59 +0100
Message-ID: <C28C5EAB.1024D%keir__16745.0647954412$1181131182$gmane$org@xensource.com>
References: <4666AFEF.76E4.0078.0@novell.com>
Mime-Version: 1.0
Content-Type: text/plain;
	charset="US-ASCII"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <4666AFEF.76E4.0078.0@novell.com>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/virtualization>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: Jan Beulich <jbeulich@novell.com>
Cc: Xen-devel <xen-devel@lists.xensource.com>, lkml <linux-kernel@vger.kernel.org>, Chris Wright <chrisw@sous-sol.org>, virtualization@lists.osdl.org, Thomas Gleixner <tglx@linutronix.de>, Andrew Morton <akpm@linux-foundation.org>, Linus Torvalds <torvalds@linux-foundation.org>, Ingo Molnar <mingo@elte.hu>
List-Id: virtualization@lists.linuxfoundation.org




On 6/6/07 12:00, "Jan Beulich" <jbeulich@novell.com> wrote:

>> If the error across CPUS is +/- just a few microseconds at worst then having
>> the clocksource clamp to no less than the last timestamp returned seems a
>> reasonable fix. Time won't 'stop' for longer than the cross-CPU error, and
>> that should always be a tiny value.
> 
> Are you sure this is also true when e.g. a CPU gets throttled due to thermal
> conditions? It is my understanding that both the duty cycle adjustment and
> the frequency reduction would yield a reduced rate TSC, which would be
> accounted for only the next time the local clock gets calibrated. Otherwise,
> immediate calibration (and vcpu update) would need to be forced out of the
> thermal interrupt.

Yes, this could be an issue. Is there any way to get an interrupt or MCE
when thermal throttling occurs?

 -- Keir
