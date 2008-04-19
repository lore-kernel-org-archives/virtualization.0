From: corbet@lwn.net (Jonathan Corbet)
Subject: Re: [PATCH 2/5] /dev/vring: simple userspace-kernel ringbuffer
	interface.
Date: Sat, 19 Apr 2008 09:02:04 -0600
Message-ID: <8793.1208617324__20860.1698316217$1208626442$gmane$org@vena.lwn.net>
References: <20080418115959.6b8fdfa7.akpm@linux-foundation.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-reply-to: Your message of "Fri, 18 Apr 2008 11:59:59 PDT."
	<20080418115959.6b8fdfa7.akpm@linux-foundation.org>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/virtualization>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: Andrew Morton <akpm@linux-foundation.org>
Cc: netdev@vger.kernel.org, linux-kernel@vger.kernel.org, Max Krasnyansky <maxk@qualcomm.com>, virtualization@lists.linux-foundation.org
List-Id: virtualization@lists.linuxfoundation.org

> So I think it would be good to plonk the proposed interface on the table
> and have a poke at it.  Is it compat-safe?  Is it extensible in a
> backward-compatible fashion?  Are there future-safe changes we should make
> to it?  Can Michael Kerrisk understand, review and document it?  etc.
> 
> You know what I'm saying ;)  What is the proposed interface?

So, I'm not Michael, but I *did* make an attempt to document this
interface - user and kernel sides - so that it could be more easily
understood:

	http://lwn.net/Articles/276856/

That was the previous posting, but a quick look suggests it hasn't
changed *that* much in this round.

jon
