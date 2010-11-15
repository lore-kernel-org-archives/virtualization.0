From: Peter Zijlstra <peterz@infradead.org>
Subject: Re: [PATCH 00/20] x86: ticket lock rewrite and paravirtualization
Date: Mon, 15 Nov 2010 21:14:48 +0100
Message-ID: <1289852088.2109.553.camel__974.196630022739$1289852112$gmane$org@laptop>
References: <cover.1288794124.git.jeremy.fitzhardinge@citrix.com>
	<4CDDBBD3.5050903@zytor.com> <4CDDBCE4.80906@goop.org>
	<4CDDBDB5.8000800@zytor.com> <4CE1915F.60507@goop.org>
	<4CE1920F.5000509@zytor.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <4CE1920F.5000509@zytor.com>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/virtualization>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: "H. Peter Anvin" <hpa@zytor.com>
Cc: Xen-devel <xen-devel@lists.xensource.com>, Mathieu Desnoyers <mathieu.desnoyers@polymtl.ca>, Srivatsa@smtp1.linux-foundation.org, Vaddagiri <vatsa@linux.vnet.ibm.com>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Jan Beulich <JBeulich@novell.com>, Virtualization <virtualization@lists.linux-foundation.org>, Kivity <avi@redhat.com>, Linux@smtp1.linux-foundation.org, Avi@smtp1.linux-foundation.org
List-Id: virtualization@lists.linuxfoundation.org

On Mon, 2010-11-15 at 12:03 -0800, H. Peter Anvin wrote:
> On 11/15/2010 12:00 PM, Jeremy Fitzhardinge wrote:
> > 
> > Another approach I discussed with PeterZ and Mathieu is to steal the LSB
> > of the ticket counters (halving the max CPU count) to use as a "there is
> > someone in slowpath waiting on this lock".  But I haven't spent the time
> > to work out an algorithm to maintain that flag (or flags, since there
> > are bits available) in a correct and efficient way.
> > 
> 
> Definitely worth pondering.

Right, so the idea was to make the ticket increment 2, which would leave
the LSB of both the head and tail available. I think that if one were to
set both (using a cmpxchg), the ticket fast-path wouldn't need any
changes since head==tail is still the correct condition for acquisition.

Then the unlock needs an added conditional:
  if (tail & 1) 
	unlock_slowpath()
