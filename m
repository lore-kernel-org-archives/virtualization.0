From: Ingo Molnar <mingo@elte.hu>
Subject: Re: [PATCH 0/10] Tree fixes for PARAVIRT
Date: Fri, 18 Jan 2008 22:37:11 +0100
Message-ID: <20080118213711.GA24979__47662.0678128258$1200692456$gmane$org@elte.hu>
References: <12006768251548-git-send-email-gcosta@redhat.com>
	<20080118203259.GA3079@elte.hu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <virtualization-bounces@lists.linux-foundation.org>
Content-Disposition: inline
In-Reply-To: <20080118203259.GA3079@elte.hu>
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

> > The first fix is not even specific for PARAVIRT, and it's actually 
> > preventing the whole tree from booting.
> 
> on CONFIG_EFI, indeed :)

but in exchange you broke all of 32-bit with CONFIG_PARAVIRT=y. Which 
means you did not even build-test it on 32-bit, let alone boot test 
it...

	Ingo
