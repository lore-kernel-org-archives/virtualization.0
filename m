From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Subject: Re: [PATCH RESEND v3 3/7] Intel MIC Host Driver, card OS state
	management.
Date: Fri, 6 Sep 2013 12:04:46 -0700
Message-ID: <20130906190446.GA7965@kroah.com>
References: <cover.1378423596.git.sudeep.dutt@intel.com>
	<669a3a3bbfff577c73d05fb568a810cbbc3d5333.1378423596.git.sudeep.dutt@intel.com>
	<20130906050157.GF28806@kroah.com>
	<1378492863.107744.69.camel@localhost>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
Content-Disposition: inline
In-Reply-To: <1378492863.107744.69.camel@localhost>
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

On Fri, Sep 06, 2013 at 11:41:03AM -0700, Sudeep Dutt wrote:
> On Thu, 2013-09-05 at 22:01 -0700, Greg Kroah-Hartman wrote:
> > On Thu, Sep 05, 2013 at 04:41:55PM -0700, Sudeep Dutt wrote:
> > > +What:		/sys/class/mic/mic(x)/firmware
> > > +Date:		August 2013
> > > +KernelVersion:	3.11
> > > +Contact:	Sudeep Dutt <sudeep.dutt@intel.com>
> > > +Description:
> > > +		When read, this sysfs entry provides the path name under
> > > +		/lib/firmware/ where the firmware image to be booted on the
> > > +		card can be found. The entry can be written to change the
> > > +		firmware image location under /lib/firmware/.
> > 
> > I don't understand, is the path under the HOST device, or the Client
> > device's disk?  Why do you need to change the path on the HOST?  What's
> > wrong with the existing firmware path selection we have in the kernel?
> > 
> 
> The path is on the host. The card does not have a physical persistent
> disk device. Our customers like the flexibility of changing the card
> firmware/ramdisk contents and file names for individual MIC cards. This
> flexibility is not possible with a static set of firmware file names in
> the kernel for all cards.
> 
> Once the firmware/ramdisk path under /lib/firmware/ is set up via sysfs,
> card boot is initiated via the "state" sysfs entry. The host driver then
> obtains the contents of the firmware and ramdisk via the standard
> request_firmware(..) interface, copies the contents to card memory and
> interrupts the card BIOS to initiate boot.

So this is really a "filename" that might contain some directories as
well, right?  The fact you used "path" confused me, as that doesn't
usually imply a filename.

And is the "firmware" just the initramfs image for the kernel to boot?

thanks,

greg k-h
