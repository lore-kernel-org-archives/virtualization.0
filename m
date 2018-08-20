From: Thomas Gleixner <tglx@linutronix.de>
Subject: Re: [PATCH RESEND] x86-64: use RIP-relative calls for paravirt
	indirect ones
Date: Mon, 20 Aug 2018 16:54:54 +0200 (CEST)
Message-ID: <alpine.DEB.2.21.1808201654230.1551@nanos.tec.linutronix.de>
References: <5B30C3F102000078001CD6F1@prv1-mh.provo.novell.com>
	<5B73DFB602000078001DE35E@prv1-mh.provo.novell.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <5B73DFB602000078001DE35E@prv1-mh.provo.novell.com>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/virtualization/>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: Jan Beulich <JBeulich@suse.com>
Cc: Juergen Gross <jgross@suse.com>, the arch/x86 maintainers <x86@kernel.org>, linux-kernel@vger.kernel.org, Linux Virtualization <virtualization@lists.linux-foundation.org>, hpa@zytor.com, Alok Kataria <akataria@vmware.com>
List-Id: virtualization@lists.linuxfoundation.org

On Wed, 15 Aug 2018, Jan Beulich wrote:

> This saves one insn byte per instance, summing up to a savings of over
> 4k in my (stripped down) configuration. No variant of to be patched in
> replacement code relies on the one byte larger size.
> 
> Signed-off-by: Jan Beulich <jbeulich@suse.com>
> Reviewed-by: Juergen Gross <jgross@suse.com>

Reviewed-by: Thomas Gleixner <tglx@linutronix.de>
