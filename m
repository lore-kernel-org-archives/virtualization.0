From: Jeremy Fitzhardinge <jeremy@goop.org>
Subject: Re: [PATCH 3/4] x86 paravirt_ops: implementation of paravirt_ops
Date: Sun, 06 Aug 2006 22:56:30 -0700
Message-ID: <44D6D60E.5080507@goop.org>
References: <1154925835.21647.29.camel@localhost.localdomain>	<1154925943.21647.32.camel@localhost.localdomain>	<1154926048.21647.35.camel@localhost.localdomain>
	<200608070739.33428.ak@muc.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <virtualization-bounces@lists.osdl.org>
In-Reply-To: <200608070739.33428.ak@muc.de>
List-Unsubscribe: <https://lists.osdl.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.osdl.org?subject=unsubscribe>
List-Archive: <http://lists.osdl.org/pipermail/virtualization>
List-Post: <mailto:virtualization@lists.osdl.org>
List-Help: <mailto:virtualization-request@lists.osdl.org?subject=help>
List-Subscribe: <https://lists.osdl.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.osdl.org?subject=subscribe>
Sender: virtualization-bounces@lists.osdl.org
Errors-To: virtualization-bounces@lists.osdl.org
To: Andi Kleen <ak@muc.de>
Cc: Andrew Morton <akpm@osdl.org>, virtualization@lists.osdl.org, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Chris Wright <chrisw@sous-sol.org>
List-Id: virtualization@lists.linuxfoundation.org

Andi Kleen wrote:
> On Monday 07 August 2006 06:47, Rusty Russell wrote:
>   =

>> This patch does the dumbest possible replacement of paravirtualized
>> instructions: calls through a "paravirt_ops" structure.  Currently
>> these are function implementations of native hardware: hypervisors
>> will override the ops structure with their own variants.
>>     =

>
> You should call it HAL - that would make it clearer what it is.
>   =


I've always found the term "HAL" to be vague to the point of =

meaningless.  What would it mean in this case:  "hypervisor abstraction =

layer"?  It certainly doesn't attempt abstract all hardware.

> I think I would prefer to patch always. Is there a particular
> reason you can't do that?
>   =


Some calls just don't need patching; an indirect call is fast enough, =

and simple.  But I can't think of a good reason to not patch patchable =

calls, other than for debugging perhaps (easier to place one breakpoint =

than one per inline site).

    J
