From: Jeremy Fitzhardinge <jeremy@goop.org>
Subject: Re: Xen status
Date: Wed, 13 Sep 2006 23:35:59 -0700
Message-ID: <4508F84F.2060802@goop.org>
References: <45088D19.5070801@goop.org>
	<20060914015915.GP10348@sequoia.sous-sol.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <virtualization-bounces@lists.osdl.org>
In-Reply-To: <20060914015915.GP10348@sequoia.sous-sol.org>
List-Unsubscribe: <https://lists.osdl.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.osdl.org?subject=unsubscribe>
List-Archive: <http://lists.osdl.org/pipermail/virtualization>
List-Post: <mailto:virtualization@lists.osdl.org>
List-Help: <mailto:virtualization-request@lists.osdl.org?subject=help>
List-Subscribe: <https://lists.osdl.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.osdl.org?subject=subscribe>
Sender: virtualization-bounces@lists.osdl.org
Errors-To: virtualization-bounces@lists.osdl.org
To: Chris Wright <chrisw@sous-sol.org>
Cc: Virtualization Mailing List <virtualization@lists.osdl.org>, Ian Campbell <Ian.Campbell@XenSource.com>
List-Id: virtualization@lists.linuxfoundation.org

Chris Wright wrote:
>> With these in place, things are getting fairly far, but not to =

>> usermode.  It often gets as far as trying to mount root, but it fails; I =

>> haven't investigated that yet.  But it also frequently crashes before =

>> then, depending on when it gets an interrupt.  I'm trying to work out =

>> what's happening here, but the symptom is eip =3D=3D 0x00000001 (!).
>>     =

>
> Haven't seen that one.
>   =


Yeah, it looks like something is going amiss in interrupt delivery.  =

Maybe something to do with interrupt stacks...

I never saw anything strange relating to timer events, but perhaps this =

is a manifestation of that problem.

> Essentially all the local hacks I have are for debugging.  There was
> one bit which was just for apic clock setup.

I think I worked around that by masking off the ACPI bit in CPUID.

>   But the symptom w/out that was a hang, not a crash. =

Yes, I'm past that one.

>  They're also on a remote machine that
> has apparently died.  Re-tooling locally ATM.
>   =

That sucks.

    J
