From: Chris Wright <chrisw@sous-sol.org>
Subject: Re: [PATCH] xen: remove driver_data direct access of struct device
	from more drivers
Date: Mon, 4 May 2009 13:47:05 -0700
Message-ID: <20090504204705.GS3036@sequoia.sous-sol.org>
References: <20090504202206.GA23289@kroah.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
Content-Disposition: inline
In-Reply-To: <20090504202206.GA23289@kroah.com>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/virtualization>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: Greg Kroah-Hartman <gregkh@suse.de>
Cc: Chris Wright <chrisw@sous-sol.org>, virtualization@lists.osdl.org, xen-devel@lists.xensource.com, Greg KH <greg@kroah.com>
List-Id: virtualization@lists.linuxfoundation.org

* Greg Kroah-Hartman (gregkh@suse.de) wrote:
> From: Greg Kroah-Hartman <gregkh@suse.de>
> 
> In the near future, the driver core is going to not allow direct access
> to the driver_data pointer in struct device.  Instead, the functions
> dev_get_drvdata() and dev_set_drvdata() should be used.  These functions
> have been around since the beginning, so are backwards compatible with
> all older kernel versions.
> 
> Cc: xen-devel@lists.xensource.com
> Cc: virtualization@lists.osdl.org
> Cc: Chris Wright <chrisw@sous-sol.org>
> Cc: Jeremy Fitzhardinge <jeremy@xensource.com>
> Signed-off-by: Greg Kroah-Hartman <gregkh@suse.de>

Acked-by: Chris Wright <chrisw@sous-sol.org>
