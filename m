From: Greg KH <gregkh@linuxfoundation.org>
Subject: Re: [Pv-drivers] [PATCH 12/12] VMCI: Some header and config files.
Date: Fri, 30 Nov 2012 10:57:55 -0800
Message-ID: <20121130185755.GA26841@kroah.com>
References: <20121127002357.GA27683@core.coreip.homeip.net>
	<1682307.3e6BJPfOqr@dtor-d630.eng.vmware.com>
	<20121130183918.GA22577@kroah.com>
	<27667508.9ZL27Yq4ZC@dtor-d630.eng.vmware.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
Content-Disposition: inline
In-Reply-To: <27667508.9ZL27Yq4ZC@dtor-d630.eng.vmware.com>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/virtualization/>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: Dmitry Torokhov <dtor@vmware.com>
Cc: pv-drivers@vmware.com, Andy King <acking@vmware.com>, linux-kernel@vger.kernel.org, virtualization@lists.linux-foundation.org
List-Id: virtualization@lists.linuxfoundation.org

On Fri, Nov 30, 2012 at 10:45:44AM -0800, Dmitry Torokhov wrote:
> However you snipped the rest of my reply: do we really need to renumber 
> ioctls? There is no benefit for the driver as its ioctl handler does
> not parse the numbers into components.

I don't know if you need to renumber, I really don't understand what you
were trying to do with this code, and as it was acting differently from
all other kernel ioctl declarations, I asked for some clarity.

If you can rewrite it to look sane, and keep the same numbers, that's
fine with me.

thanks,

greg k-h
