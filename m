From: Peter Zijlstra <peterz@infradead.org>
Subject: Re: [PATCH v5 6/9] x86: prevent inline distortion by paravirt ops
Date: Wed, 20 Jun 2018 12:10:21 +0200
Message-ID: <20180620101021.GA2530@hirez.programming.kicks-ass.net>
References: <20180619194854.69486-1-namit@vmware.com>
	<20180619194854.69486-7-namit@vmware.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
Content-Disposition: inline
In-Reply-To: <20180619194854.69486-7-namit@vmware.com>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/virtualization/>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: Nadav Amit <namit@vmware.com>
Cc: x86@kernel.org, linux-kernel@vger.kernel.org, virtualization@lists.linux-foundation.org, Ingo Molnar <mingo@redhat.com>, "H. Peter Anvin" <hpa@zytor.com>, Alok Kataria <akataria@vmware.com>, Thomas Gleixner <tglx@linutronix.de>
List-Id: virtualization@lists.linuxfoundation.org

On Tue, Jun 19, 2018 at 12:48:51PM -0700, Nadav Amit wrote:
> +#define paravirt_alt							\
> +	"PARAVIRT_CALL type=\"%c[paravirt_typenum]\""			\
> +	" clobber=\"%c[paravirt_clobber]\""				\
> +	" pv_opptr=\"%c[paravirt_opptr]\""

That wants to be:

+     " pv_opptr=\"%c[paravirt_opptr]\";"

And other than that I would suggest: 's/paravirt_alt/paravirt_call/g'.
