From: Ingo Molnar <mingo@elte.hu>
Subject: Re: [PATCH] avoid ifdefs in desc.h, getting rid of pack_ldt and
	pack_tss
Date: Thu, 13 Dec 2007 21:28:00 +0100
Message-ID: <20071213202800.GD25130__26966.519005555$1197577943$gmane$org@elte.hu>
References: <11975561713425-git-send-email-gcosta@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <virtualization-bounces@lists.linux-foundation.org>
Content-Disposition: inline
In-Reply-To: <11975561713425-git-send-email-gcosta@redhat.com>
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
> No functional change is made.
> 
> Signed-off-by: Glauber de Oliveira Costa <gcosta@redhat.com>

thanks, applied.

	Ingo
