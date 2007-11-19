From: Bastian Blank <bastian@waldi.eu.org>
Subject: Re: [PATCH 7/24] consolidate msr.h
Date: Mon, 19 Nov 2007 23:21:51 +0100
Message-ID: <20071119222151.GA11178__10237.0571381927$1195581608$gmane$org@wavehammer.waldi.eu.org>
References: <11946337851964-git-send-email-gcosta@redhat.com>
	<11946337933104-git-send-email-gcosta@redhat.com>
	<11946337991750-git-send-email-gcosta@redhat.com>
	<11946338053158-git-send-email-gcosta@redhat.com>
	<11946338103068-git-send-email-gcosta@redhat.com>
	<1194633815833-git-send-email-gcosta@redhat.com>
	<11946338212915-git-send-email-gcosta@redhat.com>
	<11946338263902-git-send-email-gcosta@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Return-path: <virtualization-bounces@lists.linux-foundation.org>
Content-Disposition: inline
In-Reply-To: <11946338263902-git-send-email-gcosta@redhat.com>
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
Cc: lguest@ozlabs.org, kvm-devel@lists.sourceforge.net, linux-kernel@vger.kernel.org, ak@suse.de, chrisw@sous-sol.org, tglx@linutronix.de, anthony@codemonkey.ws, akpm@linux-foundation.org, virtualization@lists.linux-foundation.org, mingo@elte.hu
List-Id: virtualization@lists.linuxfoundation.org

On Fri, Nov 09, 2007 at 04:42:48PM -0200, Glauber de Oliveira Costa wrote:
> -	wrmsrl(MSR_CSTAR, ia32_cstar_target);
> +	wrmsrl(MSR_CSTAR, (u64)ia32_cstar_target);

Hmm, why do you add explicit casts? The compiler should convert that
correctly on its own.

> +static inline void wrmsrl(unsigned int msr, unsigned long long val)

Hmm, long long is 64 bit on all x86, but why not use explicit u64 to
show that?

Bastian

-- 
Captain's Log, star date 21:34.5...
