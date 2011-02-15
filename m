From: Jesper Juhl <jj@chaosbits.net>
Subject: Re: [PATCH 2/2] staging: hv: Remove dead code from rndis_filter.c
Date: Tue, 15 Feb 2011 01:04:23 +0100 (CET)
Message-ID: <alpine.LNX.2.00.1102150102440.4530@swampdragon.chaosbits.net>
References: <1297723902-18176-1-git-send-email-haiyangz@microsoft.com> <1297723902-18176-2-git-send-email-haiyangz@microsoft.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1297723902-18176-2-git-send-email-haiyangz@microsoft.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Haiyang Zhang <haiyangz@microsoft.com>
Cc: hjanssen@microsoft.com, gregkh@suse.de, linux-kernel@vger.kernel.org, devel@linuxdriverproject.org, virtualization@lists.osdl.org, "K. Y. Srinivasan" <kys@microsoft.com>
List-Id: virtualization@lists.linuxfoundation.org

On Mon, 14 Feb 2011, Haiyang Zhang wrote:

> Signed-off-by: Haiyang Zhang <haiyangz@microsoft.com>
> Signed-off-by: K. Y. Srinivasan <kys@microsoft.com>
> ---
>  drivers/staging/hv/rndis_filter.c |   15 ---------------
>  1 files changed, 0 insertions(+), 15 deletions(-)
> 
...

I would probably have said "remove commented out code from rndis_filter.c" 
rather than "remove dead code ...", but nevermind :-)
Looks good to me.

Reviewed-by: Jesper Juhl <jj@chaosbits.net>


-- 
Jesper Juhl <jj@chaosbits.net>            http://www.chaosbits.net/
Plain text mails only, please.
Don't top-post http://www.catb.org/~esr/jargon/html/T/top-post.html
