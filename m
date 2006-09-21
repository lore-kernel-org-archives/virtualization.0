From: Zachary Amsden <zach@vmware.com>
Subject: Re: paravirt_ops.safe_halt vs .halt?
Date: Thu, 21 Sep 2006 13:58:31 -0700
Message-ID: <4512FCF7.8040507@vmware.com>
References: <4512E83E.80402@goop.org>	<20060921194415.GA2811@sequoia.sous-sol.org>
	<4512F6D1.60902@goop.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <virtualization-bounces@lists.osdl.org>
In-Reply-To: <4512F6D1.60902@goop.org>
List-Unsubscribe: <https://lists.osdl.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.osdl.org?subject=unsubscribe>
List-Archive: <http://lists.osdl.org/pipermail/virtualization>
List-Post: <mailto:virtualization@lists.osdl.org>
List-Help: <mailto:virtualization-request@lists.osdl.org?subject=help>
List-Subscribe: <https://lists.osdl.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.osdl.org?subject=subscribe>
Sender: virtualization-bounces@lists.osdl.org
Errors-To: virtualization-bounces@lists.osdl.org
To: Jeremy Fitzhardinge <jeremy@goop.org>
Cc: Chris Wright <chrisw@sous-sol.org>, Virtualization Mailing List <virtualization@lists.osdl.org>
List-Id: virtualization@lists.linuxfoundation.org

Jeremy Fitzhardinge wrote:
> Chris Wright wrote:
>   =

>> * Jeremy Fitzhardinge (jeremy@goop.org) wrote:
>>   =

>>     =

>>> What's paravirt_ops.halt for?  Is it the non-safe equivalent to =

>>> safe_halt, or is it intended for shutting down the machine?  It doesn't =

>>> seem to be used anywhere.
>>>     =

>>>       =

>> It's called from halt().  Xen should be using it to down the cpu.
>>     =


It's also called whenever there is a raw hlt instruction.  Which happens =

in some cases when you don't want to shutdown the CPU (at least, testing =

HLT instruction).  So there are really three kinds of halt

1) safe_halt  - safely halt and enable interrupts
2) shutdown_halt - halt and disable interrupts to shut down the CPU =

(some cases of this are bare hlts)
3) bare_hlt - hlt for other reasons than the above, or in regions know =

to already have interrupts enabled, thus avoiding the extra sti.  This =

avoidance is pretty silly, considering the only bare halts I believe are =

in bootup code.

We had this triple abstraction in VMI when it was a subarch, but it was =

unclear it was worth imposing on places that weren't really applicable =

to a virtualization context.

In short, perhaps it is best to separate safe_halt vs shutdown_halt and =

unconditionally use sti; hlt or cli; hlt instead of providing a bare =

halt paravirt op.

Zach
