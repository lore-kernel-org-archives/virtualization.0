From: Linus Torvalds <torvalds@linux-foundation.org>
Subject: Re: [PATCH] x86 spinlock: Fix memory corruption on completing
	completions
Date: Wed, 11 Feb 2015 15:28:42 -0800
Message-ID: <CA+55aFwnCxUV2JrWkq0pMtymzTfVetYd_NRKn4SB4fXqU5qZ8w@mail.gmail.com>
References: <1423234148-13886-1-git-send-email-raghavendra.kt@linux.vnet.ibm.com>
	<54D7D19B.1000103@goop.org> <54D87F1E.9060307@linux.vnet.ibm.com>
	<20150209120227.GT21418@twins.programming.kicks-ass.net>
	<CA+55aFympdPOotzEgdhQULidN+nxb-VUdfym+qU9LOsHScvpzw@mail.gmail.com>
	<54D9CFC7.5020007@linux.vnet.ibm.com>
	<20150210132634.GA30380@redhat.com> <54DAADEE.6070506@goop.org>
	<20150211172434.GA28689@redhat.com> <54DBE27C.8050105@goop.org>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============6120272734412163431=="
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <54DBE27C.8050105@goop.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/virtualization/>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: Jeremy Fitzhardinge <jeremy@goop.org>
Cc: Raghavendra K T <raghavendra.kt@linux.vnet.ibm.com>, KVM list <kvm@vger.kernel.org>, Peter Zijlstra <peterz@infradead.org>, Oleg Nesterov <oleg@redhat.com>, Paul Gortmaker <paul.gortmaker@windriver.com>, Peter Anvin <hpa@zytor.com>, Andi Kleen <ak@linux.intel.com>, Andrey Ryabinin <a.ryabinin@samsung.com>, the arch/x86 maintainers <x86@kernel.org>, Christian Borntraeger <borntraeger@de.ibm.com>, Ingo Molnar <mingo@redhat.com>, xen-devel@lists.xenproject.org, Paul McKenney <paulmck@linux.vnet.ibm.com>, Rik van Riel <riel@redhat.com>, Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>, Davidlohr Bueso <dave@stgolabs.net>, Sasha Levin <sasha.levin@oracle.com>, Dave Jones <davej@redhat.com>, Thomas Gleixner <tglx@linutronix.de>, virtualization <virtualization@lists.linux-foundation.org>, Waiman Long <waiman.long@hp.com>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
List-Id: virtualization@lists.linuxfoundation.org

--===============6120272734412163431==
Content-Type: multipart/alternative; boundary=001a113fdbea342883050ed85d5b

--001a113fdbea342883050ed85d5b
Content-Type: text/plain; charset=UTF-8

On Feb 11, 2015 3:15 PM, "Jeremy Fitzhardinge" <jeremy@goop.org> wrote:
>
> Right now it needs to be a locked operation to prevent read-reordering.
> x86 memory ordering rules state that all writes are seen in a globally
> consistent order, and are globally ordered wrt reads *on the same
> addresses*, but reads to different addresses can be reordered wrt to
writes.

The modern x86 rules are actually much tighter than that.

Every store is a release, and every load is an acquire. So a non-atomic
store is actually a perfectly fine unlock. All preceding stores will be
seen by other cpu's before the unlock, and while reads can pass stores,
they only pass *earlier* stores.

For *taking* a lock you need an atomic access, because otherwise loads
inside the locked region could bleed out to before the store that takes the
lock.

     Linus

--001a113fdbea342883050ed85d5b
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

<p dir=3D"ltr"><br>
On Feb 11, 2015 3:15 PM, &quot;Jeremy Fitzhardinge&quot; &lt;<a href=3D"mai=
lto:jeremy@goop.org">jeremy@goop.org</a>&gt; wrote:<br>
&gt;<br>
&gt; Right now it needs to be a locked operation to prevent read-reordering=
.<br>
&gt; x86 memory ordering rules state that all writes are seen in a globally=
<br>
&gt; consistent order, and are globally ordered wrt reads *on the same<br>
&gt; addresses*, but reads to different addresses can be reordered wrt to w=
rites.</p>
<p dir=3D"ltr">The modern x86 rules are actually much tighter than that.</p=
>
<p dir=3D"ltr">Every store is a release, and every load is an acquire. So a=
 non-atomic store is actually a perfectly fine unlock. All preceding stores=
 will be seen by other cpu&#39;s before the unlock, and while reads can pas=
s stores, they only pass *earlier* stores.</p>
<p dir=3D"ltr">For *taking* a lock you need an atomic access, because other=
wise loads inside the locked region could bleed out to before the store tha=
t takes the lock.</p>
<p dir=3D"ltr">=C2=A0=C2=A0=C2=A0=C2=A0 Linus</p>

--001a113fdbea342883050ed85d5b--

--===============6120272734412163431==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
--===============6120272734412163431==--
