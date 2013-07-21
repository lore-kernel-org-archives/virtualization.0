From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Subject: Re: [patch] virtio: console: fix error handling for
	debugfs_create_dir()
Date: Sun, 21 Jul 2013 08:49:20 -0700
Message-ID: <20130721154920.GI16598__20413.4464300752$1374421761$gmane$org@kroah.com>
References: <20130719055049.GD9729@elgon.mountain>
	<201307191228.41794.arnd@arndb.de> <20130720215048.GD5636@mwanda>
	<201307211136.25989.arnd@arndb.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
Content-Disposition: inline
In-Reply-To: <201307211136.25989.arnd@arndb.de>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/virtualization/>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: Arnd Bergmann <arnd@arndb.de>
Cc: Amit Shah <amit.shah@redhat.com>, kernel-janitors@vger.kernel.org, Dan Carpenter <dan.carpenter@oracle.com>, virtualization@lists.linux-foundation.org
List-Id: virtualization@lists.linuxfoundation.org

On Sun, Jul 21, 2013 at 11:36:25AM +0200, Arnd Bergmann wrote:
> On Saturday 20 July 2013, Dan Carpenter wrote:
> > On Fri, Jul 19, 2013 at 12:28:41PM +0200, Arnd Bergmann wrote:
> > > On Friday 19 July 2013, Dan Carpenter wrote:
> > > > debugfs_create_dir() returns ERR_PTR(-ENODEV) if debugfs is disabled.
> > > > Also my static checker doesn't like it when we print the error code, but
> > > > it's always just NULL.
> > > > 
> > > > Signed-off-by: Dan Carpenter <dan.carpenter@oracle.com>
> > > 
> > > This looks wrong.  debugfs_create_dir intentionally returns non-NULL so
> > > failing to create the directory does not trigger an error condition if
> > > debugfs is disabled.
> > > 
> > 
> > Yeah.  You're right.  But the original code is still wrong and will
> > oops if debugfs is disabled.  We should set the pointer to NULL if
> > we get a ERR_PTR().
> > 
> > I will send a v2 patch.
> 
> I don't see where that oops would happen. In the code I'm looking at,
> all uses of ->debugfs_dir only ever get passed into other debugfs
> functions that are stubbed out to empty inline functions.
> 
> It's not the most obvious interface design, but this all seems intentional
> and correct to me.

It was the best interface design I could create, making it very easy for
drivers to use and not really worry at all if debugfs was failing or
not, or if it was even present in the system or not.  That was the
design goal I had for it when I wrote it.

thanks,

greg k-h
