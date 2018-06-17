From: Greg KH <gregkh@linuxfoundation.org>
Subject: Re: v4.14.21+: ATOMIC_SLEEP splat bisected  to 9428088c90b6
	("drm/qxl: reapply cursor after resetting primary")
Date: Sun, 17 Jun 2018 11:36:07 +0200
Message-ID: <20180617093607.GA27652@kroah.com>
References: <1529163551.16103.16.camel@gmx.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
Content-Disposition: inline
In-Reply-To: <1529163551.16103.16.camel@gmx.de>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/virtualization/>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: Mike Galbraith <efault@gmx.de>
Cc: Ray Strode <rstrode@redhat.com>, LKML <linux-kernel@vger.kernel.org>, stable <stable@vger.kernel.org>, virtualization@lists.linux-foundation.org, Dave Airlie <airlied@redhat.com>
List-Id: virtualization@lists.linuxfoundation.org

On Sat, Jun 16, 2018 at 05:39:11PM +0200, Mike Galbraith wrote:
> Greetings,
> 
> Running a kernel with ATOMIC_SLEEP enabled in one of my VMs, I met the
> splat below.  I tracked it back to 4.14-stable, and bisected it there.

Why does your virtual machine use a drm driver?  Ah, it's a driver for
virtual gpu, nice.

And if you revert that patch, does everything work again?

> # first bad commit: [848dd9bf51544c8e5436960124f3d1f9c51cdb99] drm/qxl: reapply cursor after resetting primary

You should also cc: the other developers on that signed-off-by list,
like I did here...

thanks,

greg k-h
