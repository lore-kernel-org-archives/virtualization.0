From: Xu Quan <quan.xu04@gmail.com>
Subject: Re: [PATCH RFC v3 0/6] x86/idle: add halt poll support
Date: Wed, 15 Nov 2017 21:04:55 +0800
Message-ID: <CACbSEunLCNw2mqcVGYVCEaaMzPAmdqsXcODuiwMPsNimoNH-kg@mail.gmail.com>
References: <1510570901-6373-1-git-send-email-quan.xu0@gmail.com>
	<20171115121314.s7hhcb6f36uasrku@hirez.programming.kicks-ass.net>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============0902361427260581360=="
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <20171115121314.s7hhcb6f36uasrku@hirez.programming.kicks-ass.net>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/virtualization/>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: Peter Zijlstra <peterz@infradead.org>
Cc: Yang Zhang <yang.zhang.wz@gmail.com>, Quan Xu <quan.xu0@gmail.com>, kvm <kvm@vger.kernel.org>, linux-doc@vger.kernel.org, x86@kernel.org, linux-kernel@vger.kernel.org, virtualization@lists.linux-foundation.org, linux-fsdevel@vger.kernel.org, Paolo Bonzini <pbonzini@redhat.com>, Thomas Gleixner <tglx@linutronix.de>
List-Id: virtualization@lists.linuxfoundation.org

--===============0902361427260581360==
Content-Type: multipart/alternative; boundary="94eb2c1402ce63aa93055e05263d"

--94eb2c1402ce63aa93055e05263d
Content-Type: text/plain; charset="UTF-8"

2017-11-15 20:13 GMT+08:00 Peter Zijlstra <peterz@infradead.org>:

> On Mon, Nov 13, 2017 at 07:01:40PM +0800, Quan Xu wrote:
> >  Documentation/sysctl/kernel.txt       |   35 ++++++++++++++++
> >  arch/x86/include/asm/paravirt.h       |    5 ++
> >  arch/x86/include/asm/paravirt_types.h |    6 +++
> >  arch/x86/kernel/kvm.c                 |   73
> +++++++++++++++++++++++++++++++++
> >  arch/x86/kernel/paravirt.c            |   10 +++++
> >  arch/x86/kernel/process.c             |    7 +++
> >  include/linux/kernel.h                |    6 +++
> >  include/linux/tick.h                  |    2 +
> >  kernel/sched/idle.c                   |    2 +
> >  kernel/sysctl.c                       |   34 +++++++++++++++
> >  kernel/time/tick-sched.c              |   11 +++++
> >  kernel/time/tick-sched.h              |    3 +
> >  12 files changed, 194 insertions(+), 0 deletions(-)
>
> You seem to have forgotten to CC me on the actual patches, but no. Not
> going to happen.
>

sorry, I will forward  patch 5 / patch 6 to you .. I have some problems
with Gmail on unbuntu.

Quan

--94eb2c1402ce63aa93055e05263d
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><br><div class=3D"gmail_extra"><br><div class=3D"gmail_quo=
te">2017-11-15 20:13 GMT+08:00 Peter Zijlstra <span dir=3D"ltr">&lt;<a href=
=3D"mailto:peterz@infradead.org" target=3D"_blank">peterz@infradead.org</a>=
&gt;</span>:<br><blockquote class=3D"gmail_quote" style=3D"margin:0 0 0 .8e=
x;border-left:1px #ccc solid;padding-left:1ex"><span class=3D"">On Mon, Nov=
 13, 2017 at 07:01:40PM +0800, Quan Xu wrote:<br>
&gt;=C2=A0 Documentation/sysctl/kernel.<wbr>txt=C2=A0 =C2=A0 =C2=A0 =C2=A0|=
=C2=A0 =C2=A035 ++++++++++++++++<br>
&gt;=C2=A0 arch/x86/include/asm/paravirt.<wbr>h=C2=A0 =C2=A0 =C2=A0 =C2=A0|=
=C2=A0 =C2=A0 5 ++<br>
&gt;=C2=A0 arch/x86/include/asm/paravirt_<wbr>types.h |=C2=A0 =C2=A0 6 +++<=
br>
&gt;=C2=A0 arch/x86/kernel/kvm.c=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0|=C2=A0 =C2=A073 ++++++++++++++++++++++++++++++<wbr>+++=
<br>
&gt;=C2=A0 arch/x86/kernel/paravirt.c=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 |=C2=A0 =C2=A010 +++++<br>
&gt;=C2=A0 arch/x86/kernel/process.c=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0|=C2=A0 =C2=A0 7 +++<br>
&gt;=C2=A0 include/linux/kernel.h=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 |=C2=A0 =C2=A0 6 +++<br>
&gt;=C2=A0 include/linux/tick.h=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 |=C2=A0 =C2=A0 2 +<br>
&gt;=C2=A0 kernel/sched/idle.c=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0|=C2=A0 =C2=A0 2 +<br>
&gt;=C2=A0 kernel/sysctl.c=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0|=C2=A0 =C2=A034 +++++++++++++++<br>
&gt;=C2=A0 kernel/time/tick-sched.c=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 |=C2=A0 =C2=A011 +++++<br>
&gt;=C2=A0 kernel/time/tick-sched.h=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 |=C2=A0 =C2=A0 3 +<br>
&gt;=C2=A0 12 files changed, 194 insertions(+), 0 deletions(-)<br>
<br>
</span>You seem to have forgotten to CC me on the actual patches, but no. N=
ot<br>
going to happen.<br>
</blockquote></div></div><div class=3D"gmail_extra"><br></div><div class=3D=
"gmail_extra">sorry, I will forward=C2=A0 patch 5 / patch 6 to you .. I hav=
e some problems with Gmail on unbuntu.</div><div class=3D"gmail_extra"><br>=
</div><div class=3D"gmail_extra">Quan<br></div><div class=3D"gmail_extra"><=
br></div><div class=3D"gmail_extra"><br></div></div>

--94eb2c1402ce63aa93055e05263d--

--===============0902361427260581360==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
--===============0902361427260581360==--
