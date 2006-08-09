From: Jeremy Fitzhardinge <jeremy@goop.org>
Subject: Re: Patch: use .pushsection/.popsection
Date: Tue, 08 Aug 2006 23:33:27 -0700
Message-ID: <44D981B7.6050704@goop.org>
References: <44D97A62.9020106@vmware.com> <44D97C03.9080709@goop.org>
	<200608090826.21157.ak@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <virtualization-bounces@lists.osdl.org>
In-Reply-To: <200608090826.21157.ak@suse.de>
List-Unsubscribe: <https://lists.osdl.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.osdl.org?subject=unsubscribe>
List-Archive: <http://lists.osdl.org/pipermail/virtualization>
List-Post: <mailto:virtualization@lists.osdl.org>
List-Help: <mailto:virtualization-request@lists.osdl.org?subject=help>
List-Subscribe: <https://lists.osdl.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.osdl.org?subject=subscribe>
Sender: virtualization-bounces@lists.osdl.org
Errors-To: virtualization-bounces@lists.osdl.org
To: Andi Kleen <ak@suse.de>
Cc: virtualization@lists.osdl.org
List-Id: virtualization@lists.linuxfoundation.org

Andi Kleen wrote:
> I have already merged it.
>
> But in theory all code should run fine in .fixup, so it shouldn't
> actually unbreak anything.
>   =


No, it makes actual broken code without this:

#define RESTORE_REGS	\
	RESTORE_INT_REGS; \
1:	popl %ds;	\
	CFI_ADJUST_CFA_OFFSET -4;\
	/*CFI_RESTORE ds;*/\
2:	popl %es;	\
	CFI_ADJUST_CFA_OFFSET -4;\
	/*CFI_RESTORE es;*/\
.section .fixup,"ax";	\
3:	movl $0,(%esp);	\
	jmp 1b;		\
4:	movl $0,(%esp);	\
	jmp 2b;		\
.previous;		\
...

Those jmp 1b's look a lot like infinite loops if 1: is in the same =

section as 3:.

    J
