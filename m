From: Peter Zijlstra <peterz@infradead.org>
Subject: Re: [PATCH 00/20] x86: ticket lock rewrite and paravirtualization
Date: Mon, 15 Nov 2010 22:08:32 +0100
Message-ID: <1289855312.2109.555.camel@laptop>
References: <cover.1288794124.git.jeremy.fitzhardinge@citrix.com>
	<4CDDBBD3.5050903@zytor.com> <4CDDBCE4.80906@goop.org>
	<4CDDBDB5.8000800@zytor.com> <4CE1915F.60507@goop.org>
	<4CE1920F.5000509@zytor.com> <1289852088.2109.553.camel@laptop>
	<4CE19FD1.2000804@goop.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <4CE19FD1.2000804@goop.org>
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
Cc: Xen-devel <xen-devel@lists.xensource.com>, Mathieu Desnoyers <mathieu.desnoyers@polymtl.ca>, Srivatsa@smtp1.linux-foundation.org, Linux@smtp1.linux-foundation.org, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Jan Beulich <JBeulich@novell.com>, Virtualization <virtualization@lists.linux-foundation.org>, Vaddagiri <vatsa@linux.vnet.ibm.com>, Kivity <avi@redhat.com>, "H. Peter Anvin" <hpa@zytor.com>, Avi@smtp1.linux-foundation.org
List-Id: virtualization@lists.linuxfoundation.org

On Mon, 2010-11-15 at 13:02 -0800, Jeremy Fitzhardinge wrote:
> 
> As a heuristic, it shouldn't be too bad performancewise, since
> (handwaving) if ticketholder N has entered the slowpath, then its likely
> that N+1 will as well. 

Yes, esp. if the whole slow unlock path takes more cycles than you spin
for to begin with.

I think this approach is definitely worth trying.
