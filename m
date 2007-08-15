From: Steven Rostedt <rostedt@goodmis.org>
Subject: Re: [PATCH 18/25][V3] turn priviled operations into macros in
	entry.S
Date: Wed, 15 Aug 2007 10:04:39 -0400 (EDT)
Message-ID: <Pine.LNX.4.58.0708151002001.25252__28783.6926676848$1187186841$gmane$org@gandalf.stny.rr.com>
References: <11871821854176-git-send-email-gcosta@redhat.com>
	<1187182197314-git-send-email-gcosta@redhat.com>
	<11871822062386-git-send-email-gcosta@redhat.com>
	<11871822163867-git-send-email-gcosta@redhat.com>
	<11871822244170-git-send-email-gcosta@redhat.com>
	<11871822342754-git-send-email-gcosta@redhat.com>
	<11871822421713-git-send-email-gcosta@redhat.com>
	<1187182253740-git-send-email-gcosta@redhat.com>
	<1187182268408-git-send-email-gcosta@redhat.com>
	<1187182282913-git-send-email-gcosta@redhat.com>
	<11871822951747-git-send-email-gcosta@redhat.com>
	<11871823042011-git-send-email-gcosta@redhat.com>
	<11871823151789-git-send-email-gcosta@redhat.com>
	<11871823273810-git-send-email-gcosta@redhat.com>
	<11871823373106-git-send-email-gcosta@redhat.com>
	<11871823673236-git-send-email-gcosta@redhat.com>
	<11871823782610-git-send-email-gcosta@redhat.com>
	<11871823892519-git-send-email-gcosta@redhat.com>
	<11871823991803-git-send-email-gcosta@redhat.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <11871823991803-git-send-email-gcosta@redhat.com>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/virtualization>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: Glauber de Oliveira Costa <gcosta@redhat.com>
Cc: lguest@ozlabs.org, linux-kernel@vger.kernel.org, chrisw@sous-sol.org, anthony@codemonkey.ws, akpm@linux-foundation.org, virtualization@lists.linux-foundation.org, mingo@elte.hu
List-Id: virtualization@lists.linuxfoundation.org



--

On Wed, 15 Aug 2007, Glauber de Oliveira Costa wrote:

> @@ -566,10 +596,15 @@ retint_restore_args:
>  restore_args:
>  	RESTORE_ARGS 0,8,0
>  iret_label:
> +#ifdef CONFIG_PARAVIRT
> +	INTERRUPT_RETURN
> +#endif
> +.globl do_iretq;

Is the .globl really required here? I would think that the reference in
the fixup section would be resolved with in the compiling of this object.

-- Steve

> +do_iretq:
>  	iretq
>
>  	.section __ex_table,"a"
> -	.quad iret_label,bad_iret
> +	.quad do_iretq, bad_iret
>  	.previous
>  	.section .fixup,"ax"
>  	/* force a signal here? this matches i386 behaviour */
>
