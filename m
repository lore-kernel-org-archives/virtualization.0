From: "H. Peter Anvin" <hpa@zytor.com>
Subject: Re: New CPUID/MSR driver; virtualization hooks
Date: Wed, 04 Apr 2007 18:23:50 -0700
Message-ID: <46144FA6.1000802@zytor.com>
References: <461447F2.9010807@zytor.com>
	<20070405011640.GL19575@sequoia.sous-sol.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <20070405011640.GL19575@sequoia.sous-sol.org>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/virtualization>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: Chris Wright <chrisw@sous-sol.org>
Cc: Virtualization Mailing List <virtualization@lists.osdl.org>
List-Id: virtualization@lists.linuxfoundation.org

Chris Wright wrote:
>>
>> http://git.kernel.org/?p=3Dlinux/kernel/git/hpa/linux-2.6-cpuidmsr.git;a=
=3Dsummary
> =

> Bleah, and gitweb is unhappy ATM too.
> =


??? Works for me?

> Without having seen the patch yet, you'll need to make sure
> that the final point which is issuing asm("cpuid") is wrapped
> and split to CONFIG_PARAVIRT and non CONFIG_PARAVIRT modes.

It's not *quite* that easy.  The assembly code around this is pretty =

extensive, because it has to stand on its head in order to present the =

proper register image.

Pretty much as far as I can see it, there are two possible points where =

one can break out CONFIG_PARAVIRT:

a) int do_foo(int cpu, const u64 ireg[16], u64 oreg[16]);

b) int foo_everything(const u64 ireg[16], u64 oreg[16]);

The difference, of course, is that the former is invoked on the =

originating CPU and the latter on the target CPU at interrupt level. =

Those are pretty much the choices.

	-hpa
