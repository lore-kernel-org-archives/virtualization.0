From: Chris Wright <chrisw@sous-sol.org>
Subject: Re: [PATCH 3/25][V3] irq_flags / halt routines
Date: Wed, 15 Aug 2007 09:47:29 -0700
Message-ID: <20070815164729.GU3672__275.376815307204$1187196812$gmane$org@sequoia.sous-sol.org>
References: <11871821854176-git-send-email-gcosta@redhat.com>
	<1187182197314-git-send-email-gcosta@redhat.com>
	<11871822062386-git-send-email-gcosta@redhat.com>
	<11871822163867-git-send-email-gcosta@redhat.com>
	<20070815135554.GE3406@bingen.suse.de>
	<5d6222a80708150718v14f26343q7467385e7919fa76@mail.gmail.com>
	<20070815154243.GH3406@bingen.suse.de>
	<46C31736.2050001@redhat.com>
	<20070815163640.GJ3406@bingen.suse.de>
	<46C3283B.5090804@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <virtualization-bounces@lists.linux-foundation.org>
Content-Disposition: inline
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
Cc: lguest@ozlabs.org, shai@scalemp.com, kiran@scalemp.com, linux-kernel@vger.kernel.org, chrisw@sous-sol.org, anthony@codemonkey.ws, akpm@linux-foundation.org, virtualization@lists.linux-foundation.org, mingo@elte.hu
List-Id: virtualization@lists.linuxfoundation.org

* Glauber de Oliveira Costa (gcosta@redhat.com) wrote:
> As alternatives what we have now, we can either keep the paravirt_ops as 
> it is now for the native case, just hooking the vsmp functions in place 
> of the normal one, (there are just three ops anyway), refill the 
> paravirt_ops entirely in somewhere like vsmp.c, or similar (or maybe 
> even assigning paravirt_ops.fn = vsmp_fn on the fly, but early enough).

This is the best (just override pvops.fn for the few needed for VSMP).
The irq_disabled_flags() is the only problem.  For i386 we dropped it
(disabled_flags) as a pvop and forced the backend to provide a flags
(via save_flags) that conforms to IF only.

thanks,
-chris
