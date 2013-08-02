From: Sudeep Dutt <sudeep.dutt@intel.com>
Subject: Re: [PATCH 1/5] Intel MIC Host Driver for X100 family.
Date: Thu, 01 Aug 2013 17:36:34 -0700
Message-ID: <1375403794.61060.70.camel__1810.14001505009$1375404040$gmane$org@blbiskey-desk1.amr.corp.intel.com>
References: <cover.1374717252.git.sudeep.dutt@intel.com>
	<be8c714ed743143c427058fc0b75722f2eeeee1c.1374717252.git.sudeep.dutt@intel.com>
	<20130801015106.GE6941@kroah.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <20130801015106.GE6941@kroah.com>
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

On Wed, 2013-07-31 at 18:51 -0700, Greg Kroah-Hartman wrote: 
> On Wed, Jul 24, 2013 at 08:31:32PM -0700, Sudeep Dutt wrote:
> > --- /dev/null
> > +++ b/drivers/misc/mic/common/mic_device.h
> > @@ -0,0 +1,81 @@
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
> 
> Ok, it's now your task as an Intel employee to get this paragraph
> stricken from the "default template" that GPL code in the kernel,
> written by Intel developers, has.  It's pointless, and unless you want
> to be personally responsible for tracking the address changes of the FSF
> for the next 40+ years, not something I'm going to ever accept.
> 
> I know you aren't responsible for this, but I'm getting really tired of
> pointing this out each-and-every-time I see a file from an Intel
> developer.
> 
> So please work to fix this.
> 

I brought up this issue today, with the team which reviews licenses for
open source projects at Intel. The recommendation from them is to
include the following wording instead of the FSF street address in the
standard template.

<snip>
You should have received a copy of the GNU General Public License along
with this program. If not, see <http://www.gnu.org/licenses/>.
<snip>

Do you think this is an acceptable long term solution?
Thanks,
Sudeep Dutt

> thanks,
> 
> greg k-h
