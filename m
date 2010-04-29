From: Greg KH <greg@kroah.com>
Subject: Re: [PATCH 1/1] hv: Added new hv_utils driver to hyper-v - CORRECTED
Date: Thu, 29 Apr 2010 12:14:34 -0700
Message-ID: <20100429191434.GH21799@kroah.com>
References: <8AFC7968D54FB448A30D8F38F259C5621AFEC8AD@TK5EX14MBXC114.redmond.corp.microsoft.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
Content-Disposition: inline
In-Reply-To: <8AFC7968D54FB448A30D8F38F259C5621AFEC8AD@TK5EX14MBXC114.redmond.corp.microsoft.com>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/virtualization>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: Hank Janssen <hjanssen@microsoft.com>
Cc: "devel@driverdev.osuosl.org" <devel@driverdev.osuosl.org>, "virtualization@lists.osdl.org" <virtualization@lists.osdl.org>, Haiyang Zhang <haiyangz@microsoft.com>, Greg KH <gregkh@suse.de>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
List-Id: virtualization@lists.linuxfoundation.org

On Thu, Apr 29, 2010 at 12:27:25AM +0000, Hank Janssen wrote:
> 
> From: Hank Janssen <hjanssen@microsoft.com>
> 
> Addition of new driver for Hyper-V called hv_utils.
> This driver is intended to support things like KVP, Timesync, Heartbeat etc.
> 
> This first release has support for graceful shutdown.
> e.g. Select shutdown from the Hyper-V main admin screen and the
> Linux VM will do a graceful shutdown.
> 
> Cc: Greg Kroah-Hartman <gregkh@suse.de>
> Signed-off-by: Hank Janssen <hjanssen@microsoft.com>
> Signed-off-by: Haiyang Zhang <haiyangz@microsoft.com>

This patch fails to apply :(

Can you redo it against the linux-next tree of tomorrow and resend it?

thanks,

greg k-h
