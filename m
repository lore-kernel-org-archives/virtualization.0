From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Subject: Re: [PATCH RESEND v3 3/7] Intel MIC Host Driver, card OS state
	management.
Date: Fri, 6 Sep 2013 11:41:46 -0700
Message-ID: <20130906184146.GA4743@kroah.com>
References: <cover.1378423596.git.sudeep.dutt@intel.com>
	<669a3a3bbfff577c73d05fb568a810cbbc3d5333.1378423596.git.sudeep.dutt@intel.com>
	<20130906045858.GD28806@kroah.com>
	<1378492157.107744.54.camel@localhost>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
Content-Disposition: inline
In-Reply-To: <1378492157.107744.54.camel@localhost>
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

On Fri, Sep 06, 2013 at 11:29:17AM -0700, Sudeep Dutt wrote:
> On Thu, 2013-09-05 at 21:58 -0700, Greg Kroah-Hartman wrote:
> > Again, very minor fixups for later (I can even do them...)
> > 
> > > +static DEVICE_ATTR(state, S_IRUGO|S_IWUSR, mic_show_state, mic_store_state);
> > 
> > DEVICE_ATTR_RW() please.
> > 
> > Same for the other attributes you create in this patch.
> > 
> 
> Sure, we will incorporate these changes along with your other feedback
> in patch 1 and post the next revision of this patch series.

There's no need to repost just yet.  I can take these as-is after the
merge window closes, and you can send follow-on patches for these minor
issues, keeping you from having to do a respin, and me trying to
remember what parts I reviewed and didn't review.

So give me some time (i.e. wait for after 3.12-rc1 is out) and if I have
further problems with the patches, I'll let you know, otherwise you'll
get an automated email from my patch collection system saying the
patches are applied.

thanks,

greg k-h
