From: Sudeep Dutt <sudeep.dutt@intel.com>
Subject: Re: [PATCH 4/5] Intel MIC Card Driver Changes for Virtio Devices.
Date: Thu, 25 Jul 2013 11:00:08 -0700
Message-ID: <1374775208.32254.9.camel__49523.1864545078$1375346082$gmane$org@blbiskey-desk1.amr.corp.intel.com>
References: <cover.1374717252.git.sudeep.dutt@intel.com>
	<ff721c257100467e8f78421ba9055b97e447551e.1374717252.git.sudeep.dutt@intel.com>
	<20130725044106.GB11906@kroah.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <20130725044106.GB11906@kroah.com>
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

On Wed, 2013-07-24 at 21:41 -0700, Greg Kroah-Hartman wrote:
> On Wed, Jul 24, 2013 at 08:31:35PM -0700, Sudeep Dutt wrote:
> > +/*
> > + * Intel MIC Platform Software Stack (MPSS)
> > + *
> > + * Copyright(c) 2013 Intel Corporation.
> > + *
> > + * This program is free software; you can redistribute it and/or modify
> > + * it under the terms of the GNU General Public License, version 2, as
> > + * published by the Free Software Foundation.
> > + *
> > + * This program is distributed in the hope that it will be useful, but
> > + * WITHOUT ANY WARRANTY; without even the implied warranty of
> > + * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE. See the GNU
> > + * General Public License for more details.
> > + *
> > + * You should have received a copy of the GNU General Public License
> > + * along with this program; if not, write to the Free Software
> > + * Foundation, Inc., 51 Franklin St, Fifth Floor, Boston, MA 02110-1301
> > + * USA.
> > + *
> > + * The full GNU General Public License is included in this distribution in
> > + * the file called "COPYING".
> 
> Someone needs to tell Intel to take out the address paragraph of thier
> "standard template" as it's annoying.  Please remove it, unless you
> personally want to keep the file up to date with the address movements
> of the FSF for the next 40+ years.
> 
Sure, will delete the paragraph with the FSF address across all the
files in the next revision.

> > + * Disclaimer: The codes contained in these modules may be specific to
> > + * the Intel Software Development Platform codenamed: Knights Ferry, and
> > + * the Intel product codenamed: Knights Corner, and are not backward
> > + * compatible with other Intel products. Additionally, Intel will NOT
> > + * support the codes or instruction set in future products.
> 
> What does this mean?  That's a new one to me...
> 
Although the card driver does not contain any Knights Corner (x100)
specific instructions in the source code, we have been asked to include
this disclaimer only in the card driver patches 2 and 4; because the
x100 device has a slightly unique instruction set documented @
http://software.intel.com/en-us/mic-developer. The next generation of
MIC devices should not require this disclaimer in the card driver as
they will use standard x86_64 ISA.  The disclaimer is not present in the
host driver patches 1, 3 and 5 since it is not applicable.

> > +static inline struct device *dev(struct mic_vdev *mvdev)
> > +{
> > +	return mvdev->vdev.dev.parent;
> > +}
> 
> Can you pick a worse name?  And you aren't returning the "device", you
> are returning the parent, so the name (as short as it is), is wrong.
> 
Agreed, will rename in the next revision. We will also review the driver
to ensure that we do not have a similar problem in other files before
posting again.

Thanks,
Sudeep Dutt

> 
> ick.
> 
> greg k-h
> 
