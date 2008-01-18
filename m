From: Ingo Molnar <mingo@elte.hu>
Subject: Re: [PATCH 0/10] Tree fixes for PARAVIRT
Date: Fri, 18 Jan 2008 21:32:59 +0100
Message-ID: <20080118203259.GA3079__44542.1304008507$1200688520$gmane$org@elte.hu>
References: <12006768251548-git-send-email-gcosta@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <virtualization-bounces@lists.linux-foundation.org>
Content-Disposition: inline
In-Reply-To: <12006768251548-git-send-email-gcosta@redhat.com>
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

> 
> This small series provides some more fixes towards the goal to have 
> the PARAVIRT selectable for x86_64. After that, just some more small 
> steps are needed.

thanks, applied.

> The first fix is not even specific for PARAVIRT, and it's actually 
> preventing the whole tree from booting.

on CONFIG_EFI, indeed :)

	Ingo
