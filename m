From: Greg KH <greg@kroah.com>
Subject: Re: [PATCH 08/25] Staging: hv: vmbus_driver cannot be unloaded;
	cleanup accordingly
Date: Tue, 26 Apr 2011 15:45:45 -0700
Message-ID: <20110426224545.GC31974@kroah.com>
References: <1303834785-4981-1-git-send-email-kys@microsoft.com>
	<1303834842-5022-1-git-send-email-kys@microsoft.com>
	<1303834842-5022-8-git-send-email-kys@microsoft.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <devel-bounces@linuxdriverproject.org>
Content-Disposition: inline
In-Reply-To: <1303834842-5022-8-git-send-email-kys@microsoft.com>
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
Cc: Abhishek Kane <v-abkane@microsoft.com>, Haiyang Zhang <haiyangz@microsoft.com>, gregkh@suse.de, linux-kernel@vger.kernel.org, virtualization@lists.osdl.org, devel@linuxdriverproject.org
List-Id: virtualization@lists.linuxfoundation.org

On Tue, Apr 26, 2011 at 09:20:25AM -0700, K. Y. Srinivasan wrote:
> The vmbus driver cannot be unloaded; the windows host does not
> permit this. Cleanup accordingly.

Woah, you just prevented this driver from ever being able to be
unloaded.

That's not a "cleanup" that's a major change in how things work.  I'm
sure, if you want to continue down this line, there are more things you
can remove from the code, right?

What is the real issue here?  What happens if you unload the bus?  What
goes wrong?  Can it be fixed?

This is a pretty big commitment...

thanks,

greg k-h
