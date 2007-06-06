From: Keir Fraser <keir@xensource.com>
Subject: Re: [Xen-devel] [patch 14/33] xen: xen time implementation
Date: Wed, 06 Jun 2007 13:54:44 +0100
Message-ID: <C28C6D24.1026E%keir__14383.7295043797$1181134560$gmane$org@xensource.com>
References: <4666C8E3.76E4.0078.0@novell.com>
Mime-Version: 1.0
Content-Type: text/plain;
	charset="US-ASCII"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <4666C8E3.76E4.0078.0@novell.com>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/virtualization>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: Jan Beulich <jbeulich@novell.com>, Andi Kleen <ak@suse.de>
Cc: Xen-devel <xen-devel@lists.xensource.com>, lkml <linux-kernel@vger.kernel.org>, Chris Wright <chrisw@sous-sol.org>, virtualization@lists.osdl.org, Thomas Gleixner <tglx@linutronix.de>, Andrew Morton <akpm@linux-foundation.org>, Linus Torvalds <torvalds@linux-foundation.org>, Ingo Molnar <mingo@elte.hu>
List-Id: virtualization@lists.linuxfoundation.org




On 6/6/07 13:46, "Jan Beulich" <jbeulich@novell.com> wrote:

>> On the other hand some timing issues on throttling are probably
>> the smallest of the users' problems when it really happens.
> 
> Not if this results in your box hanging - I think throttling is exactly
> intended
> to keep the box alive as long as possible (and I've seen throttling in action,
> with the box happily recovering from the situation - after having seen it a
> few times I checked and found the fan covered with dust).

Clamping to last returned timestamp value would be fine here. Time would go
moderately haywire for a while (lurch forwards and then stop for a while),
but wouldn't go backwards and should recover reasonably within the timescale
of the thermal event itself. I don't see an issue with just implementing
this clamping if it is needed.

 -- Keir
