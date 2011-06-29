From: Greg KH <gregkh@suse.de>
Subject: Re: [PATCH 1/1] Staging: hv: Integrate the time source driver with
	Hyper-V detection code
Date: Wed, 29 Jun 2011 12:06:42 -0700
Message-ID: <20110629190642.GA19698@suse.de>
References: <1309374364-23528-1-git-send-email-kys@microsoft.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <devel-bounces@linuxdriverproject.org>
Content-Disposition: inline
In-Reply-To: <1309374364-23528-1-git-send-email-kys@microsoft.com>
List-Unsubscribe: <http://driverdev.linuxdriverproject.org/mailman/options/devel>,
	<mailto:devel-request@linuxdriverproject.org?subject=unsubscribe>
List-Archive: <http://driverdev.linuxdriverproject.org/pipermail/devel>
List-Post: <mailto:devel@linuxdriverproject.org>
List-Help: <mailto:devel-request@linuxdriverproject.org?subject=help>
List-Subscribe: <http://driverdev.linuxdriverproject.org/mailman/listinfo/devel>,
	<mailto:devel-request@linuxdriverproject.org?subject=subscribe>
Sender: devel-bounces@linuxdriverproject.org
Errors-To: devel-bounces@linuxdriverproject.org
To: "K. Y. Srinivasan" <kys@microsoft.com>
Cc: devel@linuxdriverproject.org, Haiyang Zhang <haiyangz@microsoft.com>, linux-kernel@vger.kernel.org, virtualization@lists.osdl.org
List-Id: virtualization@lists.linuxfoundation.org

On Wed, Jun 29, 2011 at 12:06:04PM -0700, K. Y. Srinivasan wrote:
> The Hyper-V timesource driver is best integrated with Hyper-V detection code
> since: (a) Linux guests running on Hyper-V need this timesource and (b)
> by integrating with Hyper-V detection, we could minimize the code in the 
> timesource driver. Greg, you had  helped me initially in getting the Hyper-V
> detection code into the kernel (mshyperv.c). I am hoping you can take
> this patch. 

Nope, it needs to go through the x86 maintainers, please resend it to
them.  The scripts/get_maintainer.pl file should have told you this,
right?

thanks,

greg k-h
