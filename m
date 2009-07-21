From: Bernd Petrovitsch <bernd@firmix.at>
Subject: Re: [patch 27/54] Staging: hv: remove ULONG and LONG typedefs
Date: Tue, 21 Jul 2009 10:26:11 +0200
Message-ID: <1248164771.16364.7.camel@spike.firmix.at>
References: <20090717180850.873962925@mini.kroah.org>
	 <20090717180920.285605541@mini.kroah.org>
	 <200907210200.16295.arnd@arndb.de>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner+glk-linux-kernel-3=40m.gmane.org-S1753700AbZGUIcO@vger.kernel.org>
In-Reply-To: <200907210200.16295.arnd@arndb.de>
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
To: Arnd Bergmann <arnd@arndb.de>
Cc: virtualization@lists.linux-foundation.org, devel@driverdev.osuosl.org, Haiyang Zhang <haiyangz@microsoft.com>, Greg Kroah-Hartman <gregkh@suse.de>, linux-kernel@vger.kernel.org, virtualization@lists.osdl.org, Sam Ramji <sramji@microsoft.com>, shemminger@linux-foundation.org
List-Id: virtualization@lists.linuxfoundation.org

On Tue, 2009-07-21 at 02:00 +0200, Arnd Bergmann wrote:
> On Friday 17 July 2009, Greg Kroah-Hartman wrote:
> > From: Greg Kroah-Hartman <gregkh@suse.de>
> > 
> > The ULONG and LONG typedefs are now removed from the Hyper-V driver
> > code
> 
> This conversion is not equivalent:
[...]
> - // redefine the world, because we can
[...]
> - #define FALSE (2)
That has been done already by the SNMP folks - see
http://www.faqs.org/rfcs/rfc1903.html under "TruthValue".
S,CNR and for off-topic ...

> ;-)
;-) either ....

	Bernd
-- 
Firmix Software GmbH                   http://www.firmix.at/
mobil: +43 664 4416156                 fax: +43 1 7890849-55
          Embedded Linux Development and Services
