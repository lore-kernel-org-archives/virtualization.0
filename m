From: Ingo Molnar <mingo@kernel.org>
Subject: Re: [PATCH] x86: Remove unnecessary return from void function
Date: Fri, 27 Oct 2017 10:48:54 +0200
Message-ID: <20171027084854.d7lrre623k3ejwzu__8768.31951686672$1509094167$gmane$org@gmail.com>
References: <1498234993-1320-1-git-send-email-vasilyev@ispras.ru>
	<1dca4371-aa22-6615-fede-5e38cc4d79cb@pfupf.net>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
Content-Disposition: inline
In-Reply-To: <1dca4371-aa22-6615-fede-5e38cc4d79cb@pfupf.net>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/virtualization/>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: Juergen Gross <lists@pfupf.net>
Cc: ldv-project@linuxtesting.org, Jeremy Fitzhardinge <jeremy@goop.org>, Rusty Russell <rusty@rustcorp.com.au>, x86@kernel.org, linux-kernel@vger.kernel.org, virtualization@lists.linux-foundation.org, Chris Wright <chrisw@sous-sol.org>, Ingo Molnar <mingo@redhat.com>, Thomas Gleixner <tglx@linutronix.de>, Anton Vasilyev <vasilyev@ispras.ru>, Alok Kataria <akataria@vmware.com>
List-Id: virtualization@lists.linuxfoundation.org


* Juergen Gross <lists@pfupf.net> wrote:

> On 23/06/17 18:23, Anton Vasilyev wrote:
> > The patch removes unnecessary return from void function.
> > 
> > Found by Linux Driver Verification project (linuxtesting.org).
> > 
> > Signed-off-by: Anton Vasilyev <vasilyev@ispras.ru>
> 
> Reviewed-by: Juergen Gross <jgross@suse.com>

Cleanup is already upstream, as of v4.13.

Thanks,

	Ingo
