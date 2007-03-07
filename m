From: Zachary Amsden <zach@vmware.com>
Subject: Re: Xen & VMI?
Date: Tue, 06 Mar 2007 18:16:25 -0800
Message-ID: <45EE2079.1060200@vmware.com>
References: <20070306081909.GA9331@elte.hu>
	<45ED2837.3020108@suse.de>	<20070306085222.GA17002@elte.hu>
	<45ED3121.8090308@suse.de>	<20070306093436.GA30239@elte.hu>
	<45ED3F29.6000705@suse.de>	<20070306102658.GA7478@elte.hu>
	<45ED4AD8.6020504@suse.de>	<20070306115937.GA25313@elte.hu>
	<45ED9678.5050907@goop.org> <20070306171130.GA13403@elte.hu>
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
Cc: virtualization <virtualization@lists.osdl.org>, Jan Beulich <jbeulich@novell.com>, Andrew Morton <akpm@linux-foundation.org>, Linus Torvalds <torvalds@linux-foundation.org>, linux-kernel@vger.kernel.org, Roland McGrath <roland@redhat.com>
List-Id: virtualization@lists.linuxfoundation.org

Ingo Molnar wrote:

> We do not let OpenOffice or Evolution have its own separate ABI to Linux =

> so that they 'can evolve at their own pace'... We want them to cooperate =

> and come up with a common ABI (or rather, we try to come up with the =

> right syscalls ourselves), because divering, overlapping ABIs are a huge =

> PITA.
>   =


OpenOffice or Evolution are the completely wrong example.  They disprove =

your point more than they prove it.  Consider any significantly large =

cross-platform software like OpenOffice, Evolution, Firefox.  You don't =

let or restrict what these pieces of software do at all.  They evolve at =

their own pace, and they all build their very complicated and divergent =

cross platform compatibility layers, with huge, overlapping APIs, =

converging in places, diverging in others.

> We do not unify their pointlessly diverging ABIs to within the kernel =

> via say office_ops (while we could) because that's crappy on its face. =

> Hypervisors arent in any way different, they just _think_ they are =

> special because they are relatively new. But hey, i dont expect you to =

> concede this point ;)

No, you don't.  The developers of Office and Evolution and Firefox do =

that for you.  And it's not crappy on its face because it provides real =

value to them - the ability to run heterogeneously in multiple different =

environments and across many different platforms and operating systems.

Where your analogy is wrong is that in this case, Linux is very much =

like one of those large software systems.  It has complicated features =

that require special plugins to work efficiently in different hypervisor =

environments.  And paravirt-ops is providing that functionality to =

Linux, just as the platform layer of any large software system does and =

very much should do.

Zach
