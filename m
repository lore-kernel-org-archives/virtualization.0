From: Linus Torvalds <torvalds@linux-foundation.org>
Subject: Re: [PATCH] x86/paravirt: Do not trace _paravirt_ident_*() functions
Date: Fri, 2 Sep 2016 09:41:40 -0700
Message-ID: <CA+55aFwSPhYp6VwzNs0BfGuGOD=PGCThqC0ABS672cXUykcO4A@mail.gmail.com>
References: <20160525134726.6362a601@gandalf.local.home>
	<20160902104630.4b004e09@gandalf.local.home>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <20160902104630.4b004e09@gandalf.local.home>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/virtualization/>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: Steven Rostedt <rostedt@goodmis.org>
Cc: Jeremy Fitzhardinge <jeremy@goop.org>, =?UTF-8?Q?=C5=81ukasz_Daniluk?= <lukasz.daniluk@intel.com>, Andrew Morton <akpm@linux-foundation.org>, LKML <linux-kernel@vger.kernel.org>, virtualization <virtualization@lists.linux-foundation.org>, Chris Wright <chrisw@sous-sol.org>, Thomas Gleixner <tglx@linutronix.de>, "H. Peter Anvin" <hpa@zytor.com>, Alok Kataria <akataria@vmware.com>, Ingo Molnar <mingo@kernel.org>
List-Id: virtualization@lists.linuxfoundation.org

On Fri, Sep 2, 2016 at 7:46 AM, Steven Rostedt <rostedt@goodmis.org> wrote:
>
> Can someone please pull this in. And mark it for stable, it goes
> probably as far back as 2.6.32.

Applied.

             Linus
