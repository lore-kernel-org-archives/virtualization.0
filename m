From: Greg KH <greg@kroah.com>
Subject: Re: [PATCH 3/3] virtio module alias support
Date: Mon, 24 Sep 2007 09:02:21 -0700
Message-ID: <20070924160221.GB5846__4723.85941907323$1190650924$gmane$org@kroah.com>
References: <1190625194.27805.199.camel@localhost.localdomain>
	<1190625256.27805.201.camel@localhost.localdomain>
	<1190625307.27805.203.camel@localhost.localdomain>
	<1190625394.27805.206.camel@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <virtualization-bounces@lists.linux-foundation.org>
Content-Disposition: inline
In-Reply-To: <1190625394.27805.206.camel@localhost.localdomain>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/virtualization>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: Rusty Russell <rusty@rustcorp.com.au>
Cc: kvm-devel <kvm-devel@lists.sourceforge.net>, virtualization <virtualization@lists.linux-foundation.org>
List-Id: virtualization@lists.linuxfoundation.org

On Mon, Sep 24, 2007 at 07:16:34PM +1000, Rusty Russell wrote:
> This adds the logic to convert the virtio ids into module aliases, and
> includes a modalias entry in sysfs.
> 
> Unfortunately this does not seem sufficient to have the module
> autoprobed at startup on my Ubuntu system.  Greg?  Am I missing some
> udev magic?

You also need to pass the MODINFO environment variable to the hotplug
call so that udev can pick it up.

hope this helps,

greg k-h
