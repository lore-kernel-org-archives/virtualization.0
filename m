From: Greg KH <gregkh@linuxfoundation.org>
Subject: Re: [PATCH 1/1] Drivers: scsi: storvsc: Don't pass ATA_16 command to
 the host
Date: Fri, 2 Mar 2012 13:13:54 -0800
Message-ID: <20120302211354.GB6008@kroah.com>
References: <1330721347-26781-1-git-send-email-kys@microsoft.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-scsi-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <1330721347-26781-1-git-send-email-kys@microsoft.com>
Sender: linux-scsi-owner@vger.kernel.org
To: "K. Y. Srinivasan" <kys@microsoft.com>
Cc: linux-kernel@vger.kernel.org, devel@linuxdriverproject.org, virtualization@lists.osdl.org, ohering@suse.com, jbottomley@parallels.com, hch@infradead.org, linux-scsi@vger.kernel.org, Haiyang Zhang <haiyangz@microsoft.com>
List-Id: virtualization@lists.linuxfoundation.org

On Fri, Mar 02, 2012 at 12:49:07PM -0800, K. Y. Srinivasan wrote:
> Windows hosts don't handle the ATA_16 command; don't pass it to the host.
> 
> Signed-off-by: K. Y. Srinivasan <kys@microsoft.com>
> Signed-off-by: Haiyang Zhang <haiyangz@microsoft.com>
> ---
>  drivers/scsi/storvsc_drv.c |    2 ++
>  1 files changed, 2 insertions(+), 0 deletions(-)

Should this go to older kernel versions as well?

greg k-h
