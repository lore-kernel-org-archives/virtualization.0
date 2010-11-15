From: "H. Peter Anvin" <hpa@zytor.com>
Subject: Re: [PATCH 00/20] x86: ticket lock rewrite and paravirtualization
Date: Mon, 15 Nov 2010 12:03:27 -0800
Message-ID: <4CE1920F.5000509__47738.2686840885$1289851507$gmane$org@zytor.com>
References: <cover.1288794124.git.jeremy.fitzhardinge@citrix.com>
	<4CDDBBD3.5050903@zytor.com> <4CDDBCE4.80906@goop.org>
	<4CDDBDB5.8000800@zytor.com> <4CE1915F.60507@goop.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <4CE1915F.60507@goop.org>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/virtualization>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: Jeremy Fitzhardinge <jeremy@goop.org>
Cc: Xen-devel <xen-devel@lists.xensource.com>, Mathieu Desnoyers <mathieu.desnoyers@polymtl.ca>, Peter Zijlstra <peterz@infradead.org>, Srivatsa Vaddagiri <vatsa@linux.vnet.ibm.com>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Jan Beulich <JBeulich@novell.com>, Linux Virtualization <virtualization@lists.linux-foundation.org>, Avi Kivity <avi@redhat.com>
List-Id: virtualization@lists.linuxfoundation.org

On 11/15/2010 12:00 PM, Jeremy Fitzhardinge wrote:
> 
> Another approach I discussed with PeterZ and Mathieu is to steal the LSB
> of the ticket counters (halving the max CPU count) to use as a "there is
> someone in slowpath waiting on this lock".  But I haven't spent the time
> to work out an algorithm to maintain that flag (or flags, since there
> are bits available) in a correct and efficient way.
> 

Definitely worth pondering.

	-hpa
