From: Linus Torvalds <torvalds@linux-foundation.org>
Subject: Re: [PATCH] virtio_balloon: fix towards_target when deflating balloon
Date: Mon, 18 Aug 2008 17:42:55 -0700 (PDT)
Message-ID: <alpine.LFD.1.10.0808181740500.3324__16110.3023485795$1219106716$gmane$org@nehalem.linux-foundation.org>
References: <1219097731-1224-1-git-send-email-aliguori@us.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <1219097731-1224-1-git-send-email-aliguori@us.ibm.com>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/virtualization>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: Anthony Liguori <aliguori@us.ibm.com>
Cc: Chris Wright <chrisw@sous-sol.org>, linux-kernel@vger.kernel.org, virtualization@lists.linux-foundation.org
List-Id: virtualization@lists.linuxfoundation.org



On Mon, 18 Aug 2008, Anthony Liguori wrote: <
> 
> This handles the case where v < vb->num_pages and ensures we get a 
> small, negative, s64 as the result.

That's just horrible code.

Maybe the compiler notices that you're doing something stupid, but 
basically, please don't do this.

> -	return v - vb->num_pages;
> +	if (v < vb->num_pages)
> +		return -(s64)(vb->num_pages - v);
> +	else
> +		return v - vb->num_pages;

What's wrong with just doing

	return (s64)v - vb->num_pages;

instead?

Casting 'v' to s64 guarantees that the subtraction will eb done in 64 
bits, and the compiler can just generate the trivial non-conditional code.

		Linus
