From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Subject: Re: [PATCH v3 0/7] Enable Drivers for Intel MIC X100 Coprocessors.
Date: Wed, 4 Sep 2013 09:32:48 -0700
Message-ID: <20130904163248.GA19631@kroah.com>
References: <cover.1377104309.git.sudeep.dutt@intel.com>
	<1378311520.72268.21.camel@blbiskey-desk1.amr.corp.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
Content-Disposition: inline
In-Reply-To: <1378311520.72268.21.camel@blbiskey-desk1.amr.corp.intel.com>
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

On Wed, Sep 04, 2013 at 09:18:40AM -0700, Sudeep Dutt wrote:
> On Wed, 2013-08-21 at 10:51 -0700, Sudeep Dutt wrote:
> > ChangeLog:
> > =========
> > 
> > v2 => v3:
> > a) Patch 1 data structure cleanups, header file include cleanups,
> >    IDA interface reuse and switching to device_create_with_groups(..)
> >    as per feedback from Greg Kroah-Hartman.
> > b) Patch 7 signal documentation, sleep workaround removal and sysfs
> >    access API cleanups as per feedback from Michael S. Tsirkin.
> > 
> > v1 => v2: @ http://lwn.net/Articles/563131/
> > a) License wording cleanup, sysfs ABI documentation, patch 1 refactoring
> >    into 3 smaller patches and function renames, as per feedback from
> >    Greg Kroah-Hartman.
> > b) Use VRINGH infrastructure for accessing virtio rings from the host
> >    in patch 5, as per feedback from Michael S. Tsirkin.
> > 
> > v1: Initial post @ https://lwn.net/Articles/561314/
> > 
> 
> Hi Greg,
> 
> It has been a couple of weeks since we posted v3 @
> https://lwn.net/Articles/564795 which addresses all feedback received so
> far. Have you had a chance to review this version? Please let us know
> your thoughts.

I don't have this around anymore, I got 7 copies and thought your
patch-send script went crazy so I deleted them :(

Care to send them again?  But note, this is the merge window, so I'll
not be able to do anythign for at least 2 weeks with them.

thanks,

greg k-h
