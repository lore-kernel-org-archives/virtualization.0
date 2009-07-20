From: Dave Jones <davej@redhat.com>
Subject: Re: [patch 00/54] [Announce] Microsoft Hyper-V drivers for Linux
Date: Mon, 20 Jul 2009 13:15:23 -0400
Message-ID: <20090720171523.GA16129@redhat.com>
References: <20090720160025.GA20249@kroah.com> <20090720162810.GA22102@kroah.com> <20090720165941.GA15660@redhat.com> <20090720170911.GS12833@kiste.smurf.noris.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner+glk-linux-kernel-3=40m.gmane.org-S1753279AbZGTRR1@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20090720170911.GS12833@kiste.smurf.noris.de>
Sender: linux-kernel-owner@vger.kernel.org
To: Matthias Urlichs <smurf@smurf.noris.de>
Cc: Greg KH <gregkh@suse.de>, linux-kernel@vger.kernel.org, devel@driverdev.osuosl.org, virtualization@lists.osdl.org, Hank Janssen <hjanssen@microsoft.com>, Haiyang Zhang <haiyangz@microsoft.com>, Sam Ramji <sramji@microsoft.com>, shemminger@linux-foundation.org
List-Id: virtualization@lists.linuxfoundation.org

On Mon, Jul 20, 2009 at 07:09:11PM +0200, Matthias Urlichs wrote:
 > Hi,
 > 
 > Dave Jones:
 > > Given the numerous cleanup patches that already exist, is there any reason
 > > to not just post the cleaned up drivers ?  It would certainly be more
 > > reviewable than the current pile.
 > > 
 > Feel free to apply / combinediff these patches before reviewing. :-P
 > 
 > Personally, I don't want to ever see another patch where substantial
 > changes (for some nontrivial value of "substantial") are intermixed
 > with distracting s/\<BOOLEAN\>/bool/g cleanups.

'Substantial changes' doesn't matter when it's an initial submission.
By its nature, it's a substantial change.

	Dave
