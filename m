From: Juergen Gross <lists@pfupf.net>
Subject: Re: [PATCH] x86: Remove unnecessary return from void function
Date: Fri, 27 Oct 2017 07:42:47 +0200
Message-ID: <1dca4371-aa22-6615-fede-5e38cc4d79cb__1002.10847235775$1509084234$gmane$org@pfupf.net>
References: <1498234993-1320-1-git-send-email-vasilyev@ispras.ru>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <1498234993-1320-1-git-send-email-vasilyev@ispras.ru>
Content-Language: de-DE
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/virtualization/>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: Anton Vasilyev <vasilyev@ispras.ru>, Jeremy Fitzhardinge <jeremy@goop.org>
Cc: ldv-project@linuxtesting.org, x86@kernel.org, Rusty Russell <rusty@rustcorp.com.au>, linux-kernel@vger.kernel.org, virtualization@lists.linux-foundation.org, Chris Wright <chrisw@sous-sol.org>, Ingo Molnar <mingo@redhat.com>, Alok Kataria <akataria@vmware.com>, Thomas Gleixner <tglx@linutronix.de>
List-Id: virtualization@lists.linuxfoundation.org

On 23/06/17 18:23, Anton Vasilyev wrote:
> The patch removes unnecessary return from void function.
> 
> Found by Linux Driver Verification project (linuxtesting.org).
> 
> Signed-off-by: Anton Vasilyev <vasilyev@ispras.ru>

Reviewed-by: Juergen Gross <jgross@suse.com>


Juergen
