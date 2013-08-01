From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Subject: Re: [PATCH 1/5] Intel MIC Host Driver for X100 family.
Date: Wed, 31 Jul 2013 18:45:12 -0700
Message-ID: <20130801014512.GC6941@kroah.com>
References: <cover.1374717252.git.sudeep.dutt@intel.com>
	<be8c714ed743143c427058fc0b75722f2eeeee1c.1374717252.git.sudeep.dutt@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
Content-Disposition: inline
In-Reply-To: <be8c714ed743143c427058fc0b75722f2eeeee1c.1374717252.git.sudeep.dutt@intel.com>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/virtualization/>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: Sudeep Dutt <sudeep.dutt@intel.com>
Cc: Peter P Waskiewicz Jr <peter.p.waskiewicz.jr@intel.com>, "Yaozu (Eddie) Dong" <eddie.dong@intel.com>, Arnd Bergmann <arnd@arndb.de>, "Michael S. Tsirkin" <mst@redhat.com>, Harshavardhan R Kharche <harshavardhan.r.kharche@intel.com>, linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org, virtualization@lists.linux-foundation.org, Ashutosh Dixit <ashutosh.dixit@intel.com>, Rob Landley <rob@landley.net>, Caz Yokoyama <Caz.Yokoyama@intel.com>, Dasaratharaman Chandramouli <dasaratharaman.chandramouli@intel.com>
List-Id: virtualization@lists.linuxfoundation.org

On Wed, Jul 24, 2013 at 08:31:32PM -0700, Sudeep Dutt wrote:
> This patch enables the following:
> a) Initializes the Intel MIC X100 PCIe devices.
> b) Boots and shuts down the card via sysfs entries.
> c) Allocates and maps a device page for communication with the
> card driver and updates the device page address via scratchpad
> registers.
> d) Provides sysfs entries for family, stepping, state, shutdown
> status, kernel command line, IP address, ramdisk and log buffer
> information.

That's a lot to do in one patch, almost 4 thousand lines.  Can't you
break this up into some more smaller, logical, and reviewable, pieces?

For example, I have no idea what b) is, and how to separate it from the
things you do for a) and c).

thanks,

greg k-h
