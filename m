From: Dave Jones <davej@redhat.com>
Subject: Re: [patch 00/54] [Announce] Microsoft Hyper-V drivers for Linux
Date: Mon, 20 Jul 2009 12:59:41 -0400
Message-ID: <20090720165941.GA15660@redhat.com>
References: <20090720160025.GA20249@kroah.com> <20090720162810.GA22102@kroah.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner+glk-linux-kernel-3=40m.gmane.org-S1752723AbZGTRA6@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20090720162810.GA22102@kroah.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Greg KH <gregkh@suse.de>
Cc: linux-kernel@vger.kernel.org, devel@driverdev.osuosl.org, virtualization@lists.osdl.org, Hank Janssen <hjanssen@microsoft.com>, Haiyang Zhang <haiyangz@microsoft.com>, Sam Ramji <sramji@microsoft.com>, shemminger@linux-foundation.org
List-Id: virtualization@lists.linuxfoundation.org

On Mon, Jul 20, 2009 at 09:28:10AM -0700, Greg KH wrote:
 > On Mon, Jul 20, 2009 at 09:00:25AM -0700, Greg Kroah-Hartman wrote:
 > > 
 > > Hi all,
 > > 
 > > I'm happy to announce, that after many months of discussions, Microsoft
 > > has released their Hyper-V Linux drivers under the GPLv2.  Following
 > > this message, will be the patches that add the drivers to the
 > > drivers/staging/ tree, and a whole bunch of cleanups.
 > 
 > Hm, for some reason my scripts to send patches out caused them to get
 > eaten by the very good lkml filters.  (note, it was my fault, not
 > lkml's).
 > 
 > So instead of trying to send them again, and spaming everyone who
 > already got them, you can find them in my staging tree at:
 > 	http://www.kernel.org/pub/linux/kernel/people/gregkh/gregkh-2.6/gregkh-05-staging/
 > 
 > If anyone wants me to post any of the individual 54 patches to them,
 > please let me know.

Given the numerous cleanup patches that already exist, is there any reason
to not just post the cleaned up drivers ?  It would certainly be more
reviewable than the current pile.

Come to think of it, is there any value in merging the pre-cleaned up
patches ? Why merge 54 patches to mainline when a half dozen will do ?

	Dave
