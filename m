From: Rusty Russell <rusty@rustcorp.com.au>
Subject: Re: [PATCH] virtio_balloon: fix towards_target when deflating balloon
Date: Tue, 19 Aug 2008 11:22:54 +1000
Message-ID: <200808191122.54845.rusty@rustcorp.com.au>
References: <1219097731-1224-1-git-send-email-aliguori@us.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <1219097731-1224-1-git-send-email-aliguori@us.ibm.com>
Content-Disposition: inline
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
Cc: Chris Wright <chrisw@sous-sol.org>, Linus Torvalds <torvalds@linux-foundation.org>, linux-kernel@vger.kernel.org, virtualization@lists.linux-foundation.org
List-Id: virtualization@lists.linuxfoundation.org

On Tuesday 19 August 2008 08:15:31 Anthony Liguori wrote:
> -	return v - vb->num_pages;
> +	if (v < vb->num_pages)
> +		return -(s64)(vb->num_pages - v);
> +	else
> +		return v - vb->num_pages;

With all due respect, WTF?

Did you mean:

	return (s64)v - vb->num_pages;

I'm really amazed this bug got this far though...
Rusty.
