From: Greg KH <greg@kroah.com>
Subject: Re: [PATCH 01/40] Staging: hv: storvsc: Do not aquire an unnecessary
 reference on stor_device
Date: Tue, 5 Jul 2011 09:14:08 -0700
Message-ID: <20110705161408.GA25532@kroah.com>
References: <1309358301-8488-1-git-send-email-kys@microsoft.com>
 <1309358377-8537-1-git-send-email-kys@microsoft.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <1309358377-8537-1-git-send-email-kys@microsoft.com>
Sender: linux-kernel-owner@vger.kernel.org
To: "K. Y. Srinivasan" <kys@microsoft.com>
Cc: gregkh@suse.de, linux-kernel@vger.kernel.org, devel@linuxdriverproject.org, virtualization@lists.osdl.org, Haiyang Zhang <haiyangz@microsoft.com>, Abhishek Kane <v-abkane@microsoft.com>
List-Id: virtualization@lists.linuxfoundation.org

On Wed, Jun 29, 2011 at 07:38:58AM -0700, K. Y. Srinivasan wrote:
> On entry into storvsc_on_io_completion() we have already acquired a reference
> on the stor_device; there is no need to acquire an additional reference here.
> 
> Signed-off-by: K. Y. Srinivasan <kys@microsoft.com>
> Signed-off-by: Haiyang Zhang <haiyangz@microsoft.com>
> Signed-off-by: Abhishek Kane <v-abkane@microsoft.com>
> Signed-off-by: Hank Janssen <hjanssen@microsoft.com>

This series doesn't apply anymore, care to redo it?

thanks,

greg k-h
