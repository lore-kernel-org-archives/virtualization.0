From: Sudeep Dutt <sudeep.dutt@intel.com>
Subject: Re: [PATCH RESEND v3 0/7] Enable Drivers for Intel MIC X100
	Coprocessors.
Date: Thu, 26 Sep 2013 14:40:27 -0700
Message-ID: <1380231627.116984.4.camel@blbiskey-desk1.amr.corp.intel.com>
References: <cover.1378423596.git.sudeep.dutt@intel.com>
	<1378431368.19204.3.camel@joe-AO722> <20130926205424.GB19455@kroah.com>
	<1380231195.17366.82.camel@joe-AO722>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <1380231195.17366.82.camel@joe-AO722>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/virtualization/>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: Joe Perches <joe@perches.com>
Cc: Sudeep Dutt <sudeep.dutt@intel.com>, Peter P Waskiewicz Jr <peter.p.waskiewicz.jr@intel.com>, "Yaozu (Eddie) Dong" <eddie.dong@intel.com>, Arnd Bergmann <arnd@arndb.de>, "Michael S. Tsirkin" <mst@redhat.com>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org, virtualization@lists.linux-foundation.org, Ashutosh Dixit <ashutosh.dixit@intel.com>, Rob Landley <rob@landley.net>, Harshavardhan R Kharche <harshavardhan.r.kharche@intel.com>, Caz Yokoyama <Caz.Yokoyama@intel.com>, Dasaratharaman Chandramouli <dasaratharaman.chandramouli@intel.com>
List-Id: virtualization@lists.linuxfoundation.org

On Thu, 2013-09-26 at 14:33 -0700, Joe Perches wrote:
> On Thu, 2013-09-26 at 13:54 -0700, Greg Kroah-Hartman wrote:
> > On Thu, Sep 05, 2013 at 06:36:08PM -0700, Joe Perches wrote:
> > > Whitespace neatening...
> > > 
> > > Multiline statement argument alignment.
> > > Argument wrapping.
> > > Use kmalloc_array instead of kmalloc.
> > > 
> > > ---
> > 
> > -ENOSIGNEDOFFBY :(
> 
> These were just suggestions for Sudeep.
> 
> Sudeep said he'd incorporate and resend the series.
> 
> Sudeep?  Were you ever going to do that?
> 

We were waiting for Greg to apply the base patches to the char misc next
tree which happened today. We will send out the cleanup patch series
which addresses all feedback soon.

Thanks,
Sudeep Dutt
