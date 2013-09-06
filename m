From: Sudeep Dutt <sudeep.dutt@intel.com>
Subject: Re: [PATCH RESEND v3 3/7] Intel MIC Host Driver, card OS state
	management.
Date: Fri, 06 Sep 2013 11:30:04 -0700
Message-ID: <1378492204.107744.57.camel__38440.4656281278$1378492245$gmane$org@localhost>
References: <cover.1378423596.git.sudeep.dutt@intel.com>
	<669a3a3bbfff577c73d05fb568a810cbbc3d5333.1378423596.git.sudeep.dutt@intel.com>
	<20130906050037.GE28806@kroah.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <20130906050037.GE28806@kroah.com>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/virtualization/>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: Sudeep Dutt <sudeep.dutt@intel.com>, Peter P Waskiewicz Jr <peter.p.waskiewicz.jr@intel.com>, "Yaozu (Eddie) Dong" <eddie.dong@intel.com>, Arnd Bergmann <arnd@arndb.de>, "Michael S. Tsirkin" <mst@redhat.com>, Harshavardhan R Kharche <harshavardhan.r.kharche@intel.com>, linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org, virtualization@lists.linux-foundation.org, Ashutosh Dixit <ashutosh.dixit@intel.com>, Rob Landley <rob@landley.net>, Caz Yokoyama <Caz.Yokoyama@intel.com>, Dasaratharaman Chandramouli <dasaratharaman.chandramouli@intel.com>
List-Id: virtualization@lists.linuxfoundation.org

On Thu, 2013-09-05 at 22:00 -0700, Greg Kroah-Hartman wrote:
> On Thu, Sep 05, 2013 at 04:41:55PM -0700, Sudeep Dutt wrote:
> > +What:		/sys/class/mic/mic(x)/cmdline
> > +Date:		August 2013
> > +KernelVersion:	3.11
> > +Contact:	Sudeep Dutt <sudeep.dutt@intel.com>
> > +Description:
> > +		An Intel MIC device runs a Linux OS during its operation. Before
> > +		booting this card OS, it is possible to pass kernel command line
> > +		options to configure various features in it, similar to
> > +		self-bootable machines. When read, this entry provides
> > +		information about the current kernel command line options set to
> > +		boot the card OS. This entry can be written to change the
> > +		existing kernel command line options. Typically, the user would
> > +		want to read the current command line options, append new ones
> > +		or modify existing ones and then write the whole kernel command
> > +		line back to this entry.
> 
> Is a PAGE_SIZE value going to be big enough for your command line?  I
> know some embedded systems have horribly long command lines, hopefully
> this will be enough for you.
> 

Yes, PAGE_SIZE is more than sufficient for our command line.
Thanks,
Sudeep Dutt
