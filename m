From: Sudeep Dutt <sudeep.dutt@intel.com>
Subject: Re: [PATCH 0/5] Enable Drivers for Intel MIC X100 Coprocessors.
Date: Fri, 16 Aug 2013 09:59:29 -0700
Message-ID: <1376672369.93110.13.camel__26781.4625906341$1376672624$gmane$org@blbiskey-desk1.amr.corp.intel.com>
References: <cover.1374717252.git.sudeep.dutt@intel.com>
	<20130813124311.GA18426@amd.pavel.ucw.cz>
	<1376511850.113256.29.camel@blbiskey-desk1.amr.corp.intel.com>
	<20130815101455.GA25528@amd.pavel.ucw.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <20130815101455.GA25528@amd.pavel.ucw.cz>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/virtualization/>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: Pavel Machek <pavel@ucw.cz>
Cc: Sudeep Dutt <sudeep.dutt@intel.com>, Peter P Waskiewicz Jr <peter.p.waskiewicz.jr@intel.com>, "Yaozu (Eddie) Dong" <eddie.dong@intel.com>, Arnd Bergmann <arnd@arndb.de>, "Michael S. Tsirkin" <mst@redhat.com>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org, virtualization@lists.linux-foundation.org, Ashutosh Dixit <ashutosh.dixit@intel.com>, Rob Landley <rob@landley.net>, Harshavardhan R Kharche <harshavardhan.r.kharche@intel.com>, Caz Yokoyama <Caz.Yokoyama@intel.com>, Dasaratharaman Chandramouli <dasaratharaman.chandramouli@intel.com>
List-Id: virtualization@lists.linuxfoundation.org

On Thu, 2013-08-15 at 12:14 +0200, Pavel Machek wrote:
> Hi!
> 

Hi!

> > > > Since it is a PCIe card, it does not have the ability to host hardware
> > > > devices for networking, storage and console. We provide these devices
> > > > on X100 coprocessors thus enabling a self-bootable equivalent environment
> > > > for applications. A key benefit of our solution is that it leverages
> > > > the standard virtio framework for network, disk and console devices,
> > > > though in our case the virtio framework is used across a PCIe bus.
> > > 
> > > Interesting...
> > > 
> > > >  Documentation/mic/mic_overview.txt   |   48 +
> > > >  Documentation/mic/mpssd/.gitignore   |    1 +
> > > >  Documentation/mic/mpssd/Makefile     |   20 +
> > > >  Documentation/mic/mpssd/micctrl      |  157 +++
> > > >  Documentation/mic/mpssd/mpss         |  246 +++++
> > > >  Documentation/mic/mpssd/mpssd.c      | 1732 ++++++++++++++++++++++++++++++++++
> > > >  Documentation/mic/mpssd/mpssd.h      |  105 +++
> > > >  Documentation/mic/mpssd/sysfs.c      |  108 +++
> > > >  drivers/misc/Kconfig                 |    1 +
> > > >  drivers/misc/Makefile                |    1 +
> > > >  drivers/misc/mic/Kconfig             |   56 ++
> > > >  drivers/misc/mic/Makefile            |    6 +
> > > >  drivers/misc/mic/card/Makefile       |   11 +
> > > >  drivers/misc/mic/card/mic_common.h   |   43 +
> > > >  drivers/misc/mic/card/mic_debugfs.c  |  139 +++
> > > >  drivers/misc/mic/card/mic_debugfs.h  |   40 +
> > > >  drivers/misc/mic/card/mic_device.c   |  311 ++++++
> > > >  drivers/misc/mic/card/mic_device.h   |  106 +++
> > > >  drivers/misc/mic/card/mic_virtio.c   |  643 +++++++++++++
> > > >  drivers/misc/mic/card/mic_virtio.h   |   79 ++
> > > >  drivers/misc/mic/card/mic_x100.c     |  253 +++++
> > > >  drivers/misc/mic/card/mic_x100.h     |   53 ++
> > > >  drivers/misc/mic/common/mic_device.h |   85 ++
> > > >  drivers/misc/mic/host/Makefile       |   13 +
> > > >  drivers/misc/mic/host/mic_boot.c     |  181 ++++
> > > 
> > > So... there are basically separate computers running on PCIe card
> > > plugged into host computer, right?
> > > 
> > 
> > They are PCIe form factor Coprocessors plugged into the host.
> > 
> > > Maybe we should have something more promintent than drivers/misc for
> > > this, then? Like drivers/multicomputer?
> > > 
> > 
> > multicomputer" is an interesting name for these kind of devices but has
> > several issues:
> > a) The definition I found for multicomputer online was "A computer made
> > up of several computers. The term generally refers to an architecture in
> > which each processor has its own memory rather than multiple processors
> > with a shared memory. A multicore computer, although it sounds similar,
> > would not be a multicomputer because the multiple cores share a common
> > memory." Intel MIC X100 devices typically have upto 244 CPUs (61 cores)
> > on the card sharing common card memory so multicomputer would not be
> > accurate based on this definition.
> 
> Well... you have your "host" computer, and than (potentially several)
> Intel MIC devices, which are basically separate computers. So X100 is
> not a multicomputer, but machine with several X100 cards certainly is
> multicomputer.
> 
> > b) X100 MIC devices have always been referred to Coprocessors and never
> > as multicomputers in product specifications @
> > http://software.intel.com/en-us/mic-developer
> 
> Coprocessor sounds like i487, but why not.
> 
> > c) multicomputer is a very long path name.
> 
> Agreed it is long. drivers/coproc? 
> 
> [I guess we'll get similar hardware from different vendors in
> future. It would make sense having it at common place.]
> 

drivers/coproc is a good, short suggestion. Intel MIC X100 devices are
likely unique since they can run a general purpose OS in a PCIe form
factor Coprocessor plugged to the host. This might result in MIC
potentially being the only driver under drivers/coproc till another
general purpose Coprocessor comes along. Is it recommended to create a
new driver directory (drivers/coproc) in anticipation of future devices?
Do you think it would be better if we revive this discussion, once
another Coprocessor with similar capabilities comes along?

Thanks,
Sudeep Dutt

> 								Pavel
> 
