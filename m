From: "H. Peter Anvin" <hpa@zytor.com>
Subject: Re: New CPUID/MSR driver; virtualization hooks
Date: Thu, 05 Apr 2007 14:17:55 -0700
Message-ID: <46156783.9030501@zytor.com>
References: <461447F2.9010807@zytor.com>	<20070405011640.GL19575@sequoia.sous-sol.org>
	<46144FA6.1000802@zytor.com> <4614867C.4060506@vmware.com>
	<461539DF.6010502@zytor.com> <46156591.8080802@vmware.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <46156591.8080802@vmware.com>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/virtualization>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: Zachary Amsden <zach@vmware.com>
Cc: Chris Wright <chrisw@sous-sol.org>, Virtualization Mailing List <virtualization@lists.osdl.org>
List-Id: virtualization@lists.linuxfoundation.org

Zachary Amsden wrote:
> H. Peter Anvin wrote:
>>
>> This code is almost entirely identical to the setgpr_wrapper in the =

>> patch (except for the fact that setgpr_wrapper sets and captures *ALL* =

>> the GPRs), and it seems rather pointless to use another wrapper.  It =

>> takes a pointer to an entrypoint (default to "cpuid; ret" in the CPUID =

>> case), so it should do what you need.
> =

> void (*cpuid)(unsigned int *eax, unsigned int *ebx, ...)
> =

> Not quite.  The paravirt_ops CPUID function is a C function which takes =

> pointers to each GPR as arguments, and returns the values through those =

> pointers.  This doesn't allow for an entrypoint compatible with =

> setgpr_wrapper, which expects the same output in both the cpuid; ret =

> case and the paravirt-ops case.
> =

> One could argue that the paravirt-ops CPUID should in fact emulate the =

> native instruction semantics, which would make it a non-C function.  =


There is also another option, which is to create an entrypoint with the =

semantics of the *_everything() functions, i.e. take a register image in =

and out.  The above definition of a cpuid() wrapper is insufficient to =

handle potential weird cases, so if we go down that route it's =

inherently a limited-functionality hack.

It seems to me that perhaps this is the way to do it:

- Add cpuid_everything, rdmsr_everything and wrmsr_everything
   entrypoints;

- Provide compatibility wrappers that simply invoke the cpuid, rdmsr,
   and wrmsr entrypoints with appropriate parameter marshalling;

- On hardware, point them to the functions which invoke setgpr_wrapper.

What do you think?

	-hpa
