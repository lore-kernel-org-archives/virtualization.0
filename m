From: Ingo Molnar <mingo@elte.hu>
Subject: Re: [PATCH] avoid ifdefs in desc.h, getting rid of pack_ldt and
	pack_tss
Date: Fri, 14 Dec 2007 11:43:30 +0100
Message-ID: <20071214104330.GA23964__9317.46694627709$1197629560$gmane$org@elte.hu>
References: <11975739373761-git-send-email-gcosta@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <virtualization-bounces@lists.linux-foundation.org>
Content-Disposition: inline
In-Reply-To: <11975739373761-git-send-email-gcosta@redhat.com>
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


* Glauber de Oliveira Costa <gcosta@redhat.com> wrote:

> By Andi Kleen's suggestion, this patch removes pack_ldt() and 
> pack_tss() wrappers in favour of a general wrapper. It saves us an 
> ifdef and some lines of code, but more importantly, it's more elegant.
> 
> No functional change is made, although the object code is expected to 
> be different.

thanks, applied.

	Ingo
