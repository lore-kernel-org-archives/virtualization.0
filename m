From: Greg KH <greg@kroah.com>
Subject: Re: [PATCH 5/5] staging: hv: fix a kernel warning in
 netvsc_linkstatus_callback()
Date: Tue, 5 Jul 2011 09:10:07 -0700
Message-ID: <20110705161007.GA24332@kroah.com>
References: <1308322688-9796-1-git-send-email-haiyangz@microsoft.com>
 <1308322688-9796-5-git-send-email-haiyangz@microsoft.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <1308322688-9796-5-git-send-email-haiyangz@microsoft.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Haiyang Zhang <haiyangz@microsoft.com>
Cc: hjanssen@microsoft.com, kys@microsoft.com, v-abkane@microsoft.com, gregkh@suse.de, linux-kernel@vger.kernel.org, devel@linuxdriverproject.org, virtualization@lists.osdl.org, stable <stable@kernel.org>
List-Id: virtualization@lists.linuxfoundation.org

On Fri, Jun 17, 2011 at 07:58:08AM -0700, Haiyang Zhang wrote:
> netif_notify_peers() is not allowed in netvsc_linkstatus_callback() on some
> distros,

"distros"?  Huh?  You mean kernel versions right?

And this doesn't matter for the current kernel, right?  If not, then it
doesn't need to be applied.  If so, then it should.  Which is it?

> because netvsc_linkstatus_callback() is within IRQ context. So we
> move the first call to netif_notify_peers() into queued work as well, but with
> zero delay.

What happens if you don't have this patch applied?  What breaks?  Is it
just a warning?  Something else?

Please resend this with more information.

greg k-h
