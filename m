From: Matthias Urlichs <smurf@smurf.noris.de>
Subject: Re: [patch 00/54] [Announce] Microsoft Hyper-V drivers for Linux
Date: Mon, 20 Jul 2009 19:09:11 +0200
Message-ID: <20090720170911.GS12833@kiste.smurf.noris.de>
References: <20090720160025.GA20249@kroah.com> <20090720162810.GA22102@kroah.com> <20090720165941.GA15660@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner+glk-linux-kernel-3=40m.gmane.org-S1753184AbZGTRKO@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20090720165941.GA15660@redhat.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Dave Jones <davej@redhat.com>, Greg KH <gregkh@suse.de>, linux-kernel@vger.kernel.org, devel@driverdev.osuosl.org, virtualization@lists.osdl.org, Hank Janssen <hjanssen@microsoft.com>
List-Id: virtualization@lists.linuxfoundation.org

Hi,

Dave Jones:
> Given the numerous cleanup patches that already exist, is there any reason
> to not just post the cleaned up drivers ?  It would certainly be more
> reviewable than the current pile.
> 
Feel free to apply / combinediff these patches before reviewing. :-P

Personally, I don't want to ever see another patch where substantial
changes (for some nontrivial value of "substantial") are intermixed
with distracting s/\<BOOLEAN\>/bool/g cleanups.

-- 
Matthias Urlichs   |   {M:U} IT Design @ m-u-it.de   |  smurf@smurf.noris.de
Disclaimer: The quote was selected randomly. Really. | http://smurf.noris.de
v4sw7$Yhw6+8ln7ma7u7L!wl7DUi2e6t3TMWb8HAGen6g3a4s6Mr1p-3/-6 hackerkey.com
 - -
You can never do merely one thing.
					-- Garrett Hardin
