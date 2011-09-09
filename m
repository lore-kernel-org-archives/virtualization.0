From: Greg KH <greg@kroah.com>
Subject: Re: [PATCH 1/1] Staging: hv: Integrate the time source driver with
	Hyper-V detection code
Date: Fri, 9 Sep 2011 13:32:28 -0700
Message-ID: <20110909203228.GA19127@kroah.com>
References: <1315434310-4827-1-git-send-email-kys@microsoft.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <devel-bounces@linuxdriverproject.org>
Content-Disposition: inline
In-Reply-To: <1315434310-4827-1-git-send-email-kys@microsoft.com>
List-Unsubscribe: <http://driverdev.linuxdriverproject.org/mailman/options/devel>,
	<mailto:devel-request@linuxdriverproject.org?subject=unsubscribe>
List-Archive: <http://driverdev.linuxdriverproject.org/pipermail/devel>
List-Post: <mailto:devel@linuxdriverproject.org>
List-Help: <mailto:devel-request@linuxdriverproject.org?subject=help>
List-Subscribe: <http://driverdev.linuxdriverproject.org/mailman/listinfo/devel>,
	<mailto:devel-request@linuxdriverproject.org?subject=subscribe>
Errors-To: devel-bounces@linuxdriverproject.org
Sender: devel-bounces@linuxdriverproject.org
To: "K. Y. Srinivasan" <kys@microsoft.com>
Cc: devel@linuxdriverproject.org, Haiyang Zhang <haiyangz@microsoft.com>, gregkh@suse.de, linux-kernel@vger.kernel.org, virtualization@lists.osdl.org
List-Id: virtualization@lists.linuxfoundation.org

On Wed, Sep 07, 2011 at 03:25:10PM -0700, K. Y. Srinivasan wrote:
> The Hyper-V timesource driver is best integrated with Hyper-V detection code
> since: (a) Linux guests running on Hyper-V need this timesource and (b)
> by integrating with Hyper-V detection, we could significantly  minimize the
> code in the timesource driver.
> 
> Signed-off-by: K. Y. Srinivasan <kys@microsoft.com>
> Signed-off-by: Haiyang Zhang <haiyangz@microsoft.com>

Acked-by: Greg Kroah-Hartman <gregkh@suse.de>
