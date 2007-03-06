From: Jeremy Fitzhardinge <jeremy@goop.org>
Subject: Re: Xen & VMI?
Date: Tue, 06 Mar 2007 09:33:12 -0800
Message-ID: <45EDA5D8.7080001@goop.org>
References: <20070306081909.GA9331@elte.hu> <45ED2837.3020108@suse.de>
	<20070306085222.GA17002@elte.hu> <45ED3121.8090308@suse.de>
	<20070306093436.GA30239@elte.hu> <45ED3F29.6000705@suse.de>
	<20070306102658.GA7478@elte.hu> <45ED4AD8.6020504@suse.de>
	<20070306115937.GA25313@elte.hu> <45ED9678.5050907@goop.org>
	<20070306171130.GA13403@elte.hu>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <virtualization-bounces@lists.osdl.org>
In-Reply-To: <20070306171130.GA13403@elte.hu>
List-Unsubscribe: <https://lists.osdl.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.osdl.org?subject=unsubscribe>
List-Archive: <http://lists.osdl.org/pipermail/virtualization>
List-Post: <mailto:virtualization@lists.osdl.org>
List-Help: <mailto:virtualization-request@lists.osdl.org?subject=help>
List-Subscribe: <https://lists.osdl.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.osdl.org?subject=subscribe>
Sender: virtualization-bounces@lists.osdl.org
Errors-To: virtualization-bounces@lists.osdl.org
To: Ingo Molnar <mingo@elte.hu>
Cc: virtualization <virtualization@lists.osdl.org>, Jan Beulich <jbeulich@novell.com>, Linus Torvalds <torvalds@linux-foundation.org>, Andrew Morton <akpm@linux-foundation.org>, Roland McGrath <roland@redhat.com>, linux-kernel@vger.kernel.org
List-Id: virtualization@lists.linuxfoundation.org

Ingo Molnar wrote:
> Pretty much the only way to ensure a sane ABI is to do it like we do =

> it with the Linux syscall ABI:
>
> 	_to have only one_
>   =


Right, but there's also only one implementation; if you were to try and
coordinate Linux and *BSD to have the same kernel ABI it would be a much
trickier prospect.  From OO or Evo's perspective, there are other
syscall ABIs on other systems.  But it doesn't matter - because there's
libc in usermode which papers over the differences in kernel interfaces,
both between Linux versions and between systems.

> We do not unify their pointlessly diverging ABIs to within the kernel =

> via say office_ops (while we could) because that's crappy on its face. =

> Hypervisors arent in any way different, they just _think_ they are =

> special because they are relatively new. But hey, i dont expect you to =

> concede this point ;)
>   =



Well, if you want to draw the analogy like this, then pv_ops is libc,
and it doesn't matter what the kernel/hypervisor ABI is from rest of the
app/kernel's perspective, so long as libc/pv_ops holds up its end of the
agreement.

    J
