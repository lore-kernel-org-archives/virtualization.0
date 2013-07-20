From: Dan Carpenter <dan.carpenter@oracle.com>
Subject: Re: [patch] virtio: console: fix error handling for
	debugfs_create_dir()
Date: Sun, 21 Jul 2013 00:50:48 +0300
Message-ID: <20130720215048.GD5636@mwanda>
References: <20130719055049.GD9729@elgon.mountain>
	<201307191228.41794.arnd@arndb.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
Content-Disposition: inline
In-Reply-To: <201307191228.41794.arnd@arndb.de>
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
Cc: Amit Shah <amit.shah@redhat.com>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, kernel-janitors@vger.kernel.org, virtualization@lists.linux-foundation.org
List-Id: virtualization@lists.linuxfoundation.org

On Fri, Jul 19, 2013 at 12:28:41PM +0200, Arnd Bergmann wrote:
> On Friday 19 July 2013, Dan Carpenter wrote:
> > debugfs_create_dir() returns ERR_PTR(-ENODEV) if debugfs is disabled.
> > Also my static checker doesn't like it when we print the error code, but
> > it's always just NULL.
> > 
> > Signed-off-by: Dan Carpenter <dan.carpenter@oracle.com>
> 
> This looks wrong.  debugfs_create_dir intentionally returns non-NULL so
> failing to create the directory does not trigger an error condition if
> debugfs is disabled.
> 

Yeah.  You're right.  But the original code is still wrong and will
oops if debugfs is disabled.  We should set the pointer to NULL if
we get a ERR_PTR().

I will send a v2 patch.

regards,
dan carpenter
