From: Arnd Bergmann <arnd@arndb.de>
Subject: Re: [PATCH] x86/paravirt: hide unused patch_default label
Date: Fri, 16 Dec 2016 11:07:18 +0100
Message-ID: <5067991.WbNiajpCOj@wuerfel>
References: <20161216091700.2499520-1-arnd@arndb.de>
	<20161216095150.GQ3107@twins.programming.kicks-ass.net>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <20161216095150.GQ3107@twins.programming.kicks-ass.net>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/virtualization/>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: Peter Zijlstra <peterz@infradead.org>
Cc: x86@kernel.org, linux-kernel@vger.kernel.org, virtualization@lists.linux-foundation.org, Ingo Molnar <mingo@redhat.com>, "H. Peter Anvin" <hpa@zytor.com>, Thomas Gleixner <tglx@linutronix.de>
List-Id: virtualization@lists.linuxfoundation.org

On Friday, December 16, 2016 10:51:50 AM CET Peter Zijlstra wrote:
> -patch_default:
> +patch_default: __maybe_unused
>                 ret = paravirt_patch_default(type, clobbers, ibuf, addr, len);
>                 break;
> 

Ah, nice, I didn't know you could do that. Yes, please do this instead.

	Arnd
