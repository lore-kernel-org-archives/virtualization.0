From: Jeremy Fitzhardinge <jeremy@xensource.com>
Subject: Re: [PATCH 3/25][V3] irq_flags / halt routines
Date: Wed, 15 Aug 2007 14:40:45 -0700
Message-ID: <46C372DD.6070405@xensource.com>
References: <11871821854176-git-send-email-gcosta@redhat.com>	<1187182197314-git-send-email-gcosta@redhat.com>	<11871822062386-git-send-email-gcosta@redhat.com>	<11871822163867-git-send-email-gcosta@redhat.com>	<20070815135554.GE3406@bingen.suse.de>	<5d6222a80708150718v14f26343q7467385e7919fa76@mail.gmail.com>	<20070815154243.GH3406@bingen.suse.de>	<46C31736.2050001@redhat.com>	<20070815163640.GJ3406@bingen.suse.de>
	<46C3283B.5090804@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <46C3283B.5090804@redhat.com>
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
Cc: lguest@ozlabs.org, linux-kernel@vger.kernel.org, shai@scalemp.com, kiran@scalemp.com, virtualization@lists.linux-foundation.org, chrisw@sous-sol.org, anthony@codemonkey.ws, akpm@linux-foundation.org, mingo@elte.hu
List-Id: virtualization@lists.linuxfoundation.org

Glauber de Oliveira Costa wrote:
> Thanks for the explanation, Andi. I understand it much better now, and
> agree with you.
>
> As alternatives what we have now, we can either keep the paravirt_ops
> as it is now for the native case, just hooking the vsmp functions in
> place of the normal one, (there are just three ops anyway), refill the
> paravirt_ops entirely in somewhere like vsmp.c, or similar (or maybe
> even assigning paravirt_ops.fn = vsmp_fn on the fly, but early enough). 

One thing to note is that current code assumes the IF flag is always in
bit 9, so if you paravirtualize this, you need to either a) make the
vsmp version copy AC into IF to satisfy the interface, or b) add a new
op meaning "tell me if this eflags has interrupts enabled or not".  I
went for option a), and it seems to work OK (using bit 9 for "interrupt
enabled" is pretty arbitrary from a Xen perspective, but not very hard
to implement, and more localized than making all eflags tests a pvop).

    J
