From: Ingo Molnar <mingo@elte.hu>
Subject: Re: [PATCH] avoid ifdefs in desc.h, getting rid of pack_ldt and
	pack_tss
Date: Thu, 13 Dec 2007 22:22:21 +0100
Message-ID: <20071213212221.GA16747__42338.5220965885$1197581234$gmane$org@elte.hu>
References: <11975561713425-git-send-email-gcosta@redhat.com>
	<20071213202800.GD25130@elte.hu> <20071213205838.GA9649@elte.hu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <virtualization-bounces@lists.linux-foundation.org>
Content-Disposition: inline
In-Reply-To: <20071213205838.GA9649@elte.hu>
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
Cc: ehabkost@redhat.com, linux-kernel@vger.kernel.org, virtualization@lists.linux-foundation.org, chrisw@sous-sol.org, anthony@codemonkey.ws, hpa@zytor.com, akpm@linux-foundation.org, tglx@linutronix.de, roland@redhat.com, ak@suse.de
List-Id: virtualization@lists.linuxfoundation.org


* Ingo Molnar <mingo@elte.hu> wrote:

> just got the crash below. config attached. Suspects are:
> 
>  Subject: unify struct desc_ptr
>  Subject: unify paravirt pieces of descriptor handling

i've bisected it down to:

 Subject: avoid ifdefs in desc.h, getting rid of pack_ldt and pack_tss
 From: Glauber de Oliveira Costa <gcosta@redhat.com>

i have removed this patch from x86.git. Btw., note the advantage of 
small deltas, so only your v3->v4 delta patch got reverted instead of 
the whole 19-patch v3 kit ;-)

> could we _please_ use basic tools as vmlinux size comparison and 
> objcompare when unifying, to make sure it's a 100% identity 
> conversion?

case in point, the patch claims:

> > No functional change is made.

but vmlinux before/after size comparison shows:

    text    data     bss     dec     hex filename
 8802894 1224910 3526656 13554460         ced31c vmlinux.before
 8803042 1224910 3526656 13554608         ced3b0 vmlinux.after

	Ingo
