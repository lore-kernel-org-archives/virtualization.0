From: Jesper Juhl <jj@chaosbits.net>
Subject: Re: [PATCH 1/1] hv: Use only one txf buffer per channel and kmalloc
 on initialize
Date: Mon, 13 Dec 2010 22:22:11 +0100 (CET)
Message-ID: <alpine.LNX.2.00.1012132220220.26491@swampdragon.chaosbits.net>
References: <1292274861-29673-1-git-send-email-hjanssen@microsoft.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1292274861-29673-1-git-send-email-hjanssen@microsoft.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Hank Janssen <hjanssen@microsoft.com>
Cc: gregkh@suse.de, linux-kernel@vger.kernel.org, devel@linuxdriverproject.org, virtualization@lists.osdl.org, Haiyang Zhang <haiyangz@microsoft.com>, Evgeniy Polyakov <zbr@ioremap.net>, Ky Srinivasan <ksrinivasan@novell.com>
List-Id: virtualization@lists.linuxfoundation.org

On Mon, 13 Dec 2010, Hank Janssen wrote:

> Correct issue with not checking kmalloc return value.
> This fix now only uses one receive buffer for all hv_utils 
> channels, and will do only one kmalloc on init and will return
> with a -ENOMEM if kmalloc fails on initialize.
> 
> And properly clean up memory on failure.
> 
> Thanks to Evgeniy Polyakov <zbr@ioremap.net> for pointing this out.
> And thanks to Jesper Juhl <jj@chaosbits.net> and Ky Srinivasan 
> <ksrinivasan@novell.com> for suggesting a better implementation of
> my original patch.
> 
> Signed-off-by: Haiyang Zhang <haiyangz@microsoft.com>
> Signed-off-by: Hank Janssen <hjanssen@microsoft.com>
> Cc: Evgeniy Polyakov <zbr@ioremap.net>
> Cc: Jesper Juhl <jj@chaosbits.net>
> Cc: Ky Srinivasan <ksrinivasan@novell.com>
> 

I can't spot any problems with these changes now, so feel free to add
  Reviewed-by: Jesper Juhl <jj@chaosbits.net>
if you like.


-- 
Jesper Juhl <jj@chaosbits.net>            http://www.chaosbits.net/
Don't top-post http://www.catb.org/~esr/jargon/html/T/top-post.html
Plain text mails only, please.
