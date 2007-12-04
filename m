From: Andi Kleen <ak@suse.de>
Subject: Re: [PATCH 3/10] allow sched clock to be overridden by paravirt
Date: Tue, 4 Dec 2007 14:56:50 +0100
Message-ID: <20071204135650.GG11764__31800.713358871$1196804132$gmane$org@bingen.suse.de>
References: <11967666042130-git-send-email-gcosta@redhat.com>
	<11967666111489-git-send-email-gcosta@redhat.com>
	<11967666161585-git-send-email-gcosta@redhat.com>
	<11967666212496-git-send-email-gcosta@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <virtualization-bounces@lists.linux-foundation.org>
Content-Disposition: inline
In-Reply-To: <11967666212496-git-send-email-gcosta@redhat.com>
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
Cc: ehabkost@redhat.com, linux-kernel@vger.kernel.org, virtualization@lists.linux-foundation.org, chrisw@sous-sol.org, tglx@linutronix.de, anthony@codemonkey.ws, hpa@zytor.com, akpm@linux-foundation.org, mingo@elte.hu, ak@suse.de
List-Id: virtualization@lists.linuxfoundation.org

On Tue, Dec 04, 2007 at 09:09:57AM -0200, Glauber de Oliveira Costa wrote:
> This patch turns the sched_clock into native_sched_clock.
> sched clock becomes a weak symbol, which can then give its
> place to a paravirt definition.

I ended up regretting that solution on i386, it would be better
to solve that more clearly with ifdefs.

-Andi
