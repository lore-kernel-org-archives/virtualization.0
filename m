From: Ingo Molnar <mingo@elte.hu>
Subject: Re: [PATCH 0/6] paravirt patches - the non-integration part
Date: Wed, 12 Dec 2007 18:07:33 +0100
Message-ID: <20071212170733.GA8345__2852.52136313847$1197479431$gmane$org@elte.hu>
References: <11974642471600-git-send-email-gcosta@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <virtualization-bounces@lists.linux-foundation.org>
Content-Disposition: inline
In-Reply-To: <11974642471600-git-send-email-gcosta@redhat.com>
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

> Hi,
> 
> This series corresponds do older patches in the paravirt series that 
> was neither already applied, nor I will touch again. In general, they 
> do not touch code that can be unified (at least, without being the 
> unification a big problem on its own).
> 
> They passed through this list a lot of times, so I feel them ready for 
> inclusion, unless someone opposes.
> 
> As with the other patches, they apply to the top of linux-2.6-x86:mm

thanks, i've picked them up into x86.git, they look certainly very 
clean.

	Ingo
