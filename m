From: Jeremy Fitzhardinge <jeremy@goop.org>
Subject: Re: [PATCH 00/20] x86: ticket lock rewrite and paravirtualization
Date: Fri, 12 Nov 2010 14:17:08 -0800
Message-ID: <4CDDBCE4.80906__47120.9766030826$1289600268$gmane$org@goop.org>
References: <cover.1288794124.git.jeremy.fitzhardinge@citrix.com>
	<4CDDBBD3.5050903@zytor.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <4CDDBBD3.5050903@zytor.com>
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
Cc: Nick Piggin <npiggin@suse.de>, Xen-devel <xen-devel@lists.xensource.com>, Peter Zijlstra <peterz@infradead.org>, Srivatsa Vaddagiri <vatsa@linux.vnet.ibm.com>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Jan Beulich <JBeulich@novell.com>, Linux Virtualization <virtualization@lists.linux-foundation.org>, Avi Kivity <avi@redhat.com>
List-Id: virtualization@lists.linuxfoundation.org

On 11/12/2010 02:12 PM, H. Peter Anvin wrote:
> On 11/03/2010 07:59 AM, Jeremy Fitzhardinge wrote:
>>       - with an unmodified struct spinlock, it can check to see if
>>         head == tail after unlock; if not, then there's someone else
>>         trying to lock, and we can do a kick.  Unfortunately this
>>         generates very high level of redundant kicks, because the
>>         waiting CPU might not have blocked yet (which is the common
>>         case)
>>
> How high is "very high" here -- most of the time (so that any mitigation
> on the slow patch is useless)?

I'll need to remeasure, but I think around 90% of the slowpath entries
were spurious without this.  In other words, when spinlocks do contend,
most of the time it isn't very serious and the other cpu doesn't spend
much time spinning.

    J
